package controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;


import exception.LoginException;
import logic.Sale;
import logic.SaleItem;
import logic.ShopService;
import logic.User;
import util.CiperUtil;

@Controller
public class UserController {
	@Autowired
	ShopService service;
	
	@RequestMapping("user/userForm") 
	public ModelAndView userForm() {
		ModelAndView mav = new ModelAndView();
		mav.addObject(new User());
		return mav;
	}
	@RequestMapping("user/userEntry") 
	public ModelAndView userEntry(@Valid User user,BindingResult bindResult) {
		ModelAndView mav = new ModelAndView("user/userForm");
		if(bindResult.hasErrors()) {
			mav.getModel().putAll(bindResult.getModel());
			return mav;
		}
		try {
			user.setPassword(service.getHashvlaue(user.getPassword()));
			service.userCreate(user);
			mav.setViewName("user/login");
			mav.addObject("user",user);
		} catch(DataIntegrityViolationException e) {
			bindResult.reject("error.duplicate.user");
		}
		return mav;
	}
	@RequestMapping("user/loginForm") 
	public ModelAndView loginForm() {
		ModelAndView mav = new ModelAndView("user/login");
		mav.addObject(new User());
		return mav;
	}
	@RequestMapping("user/login")
	public ModelAndView loginForm(@Valid User user,BindingResult bindResult, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		if(bindResult.hasErrors()) {
			mav.getModel().putAll(bindResult.getModel());
			return mav;
		}
		//db���� ���̵��� ȸ�� ���� ��ȸ�ϰ� ��й�ȣ �����Ͽ� session�� ���
		//�α��� ������ loginSuccess
		try {
			//u : ���̵� �ش��ϴ� db�� ����� ���� ����
			User u = service.selectUser(user.getUserId());
			if(u == null){
				bindResult.reject("error.login.id");
				mav.getModel().putAll(bindResult.getModel());
				return mav;
			}
			
			if(service.getHashvlaue(user.getPassword()).equals(u.getPassword())) { //���̵�� ��й�ȣ�� ��ġ
				session.setAttribute("loginUser", u); //�α��� ����.
			} else {
				bindResult.reject("error.login.password");
				mav.getModel().putAll(bindResult.getModel());
				return mav;
			}
		} catch(Exception e) { 
			//EmptyResultDataAccessException :�ش� ���̵� ������ db�� ���� ��. ������������ �߻��Ǵ� ����.
			e.printStackTrace();
			bindResult.reject("error.user.login");
			mav.getModel().putAll(bindResult.getModel());
			return mav;
		}
		mav.setViewName("user/loginSuccess"); //�α��� �����ϴ� ��츸 ����
		return mav;
	}
	@RequestMapping("user/logout")
	public ModelAndView logout(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		session.invalidate();
		mav.setViewName("redirect:loginForm.shop"); 
		return mav;
	}
	@RequestMapping("user/mypage")
	public ModelAndView mypage(String id, HttpSession session) {
		User user = service.selectUser(id);
		List<Sale> salelist = service.saleList(id);
		for(Sale s : salelist) {
			s.setItemList(service.saleItemList(s.getSaleId()));
			int total = 0;
			for(SaleItem si : s.getItemList()) {
				total += si.getQuantity() * si.getItem().getPrice();
			}
			s.setTotAmount(total);
		}
		ModelAndView mav = new ModelAndView();
		mav.addObject("user",user);
		mav.addObject("salelist", salelist);
		return mav;
	}
	@RequestMapping("user/updateForm")
	public ModelAndView updateForm(String id, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User user = service.selectUser(id);
		user.setEmail(CiperUtil.decrypt(user.getEmail(), user.getUserId()));
		mav.addObject("user",user);
		return mav;
	}
	/*
	 * 1. �Ķ���� ������ User ��ü�� ����, ��ȿ�� ����
	 * 2. AOP�� �̿��Ͽ� �α��� �ȵ� ���, �ٸ� ����� ���� ���� �ȵǵ��� LoginAspect Ŭ������ AOP�޼��� �߰�
	 * 3. ��й�ȣ�� ��ġ�ϴ� ��츸 ȸ������ ����
	 * 4. ȸ������ ���� ���� : mypage.shop ������ �̵�
	 *          ���� ���� : updateForm.shop ������ �̵�
	 */
	@RequestMapping("user/update")
	public ModelAndView update(HttpSession session, @Valid User user,BindingResult bindResult) {
		ModelAndView mav = new ModelAndView("user/updateForm");
		if(bindResult.hasErrors()) {
			mav.getModel().putAll(bindResult.getModel());
			return mav;
		}
		try {
			User u = service.selectUser(user.getUserId());
			if(service.getHashvlaue(user.getPassword()).equals(u.getPassword())) {
				user.setEmail(CiperUtil.encrypt(user.getEmail(), user.getUserId()));
				service.update(user);
			} else {
				bindResult.reject("error.login.password");
				mav.getModel().putAll(bindResult.getModel());
				return mav;
			}
		} catch(EmptyResultDataAccessException e) { 
			bindResult.reject("error.user.update");
			mav.getModel().putAll(bindResult.getModel());
			return mav;
		}
		mav.setViewName("redirect:/user/mypage.shop?id="+user.getUserId());
		return mav;
	}
	@RequestMapping(value="user/delete",method=RequestMethod.GET)
	public ModelAndView deleteForm(String id, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User user = service.selectUser(id);
		mav.addObject("user",user);
		return mav;
	}		
	/*
	 * -�����ڰ� �ٸ� ȸ���� ���� Ż��
	 * ��й�ȣ�� ������ ��й�ȣ �Է��ϱ�
	 * ������ ��й�ȣ�� �´� ��� ȸ�� ���� ����
	 * ���� Ż�� ���� : admin/list.shop������ �̵�
	 *       ���� : ��ȿ�� �������� delete.jsp ������ ���
	 * -���� ȸ�� Ż��
	 * ��й�ȣ�� ȸ�� ��й�ȣ �Է��ϱ�
	 * ��й�ȣ�� �´� ��� ȸ�� ���� ����
	 * Ż�� ���� : session ���� �� loginForm.shop������ �̵�
	 *    ���� : ��ȿ�� �������� delete.jsp�������� ���
	 */
	@RequestMapping(value="user/delete",method=RequestMethod.POST)
	public ModelAndView delete(String id, HttpSession session, String password) {
		ModelAndView mav = new ModelAndView();
		User u = (User)session.getAttribute("loginUser");
		if(u.getUserId().equals("admin")) {
			if(u.getPassword().equals(service.getHashvlaue(password))) {
				service.delete(id);
				session.invalidate();
				mav.setViewName("redirect:../admin/list.shop");
			} else {
				throw new LoginException("����","../user/delete.shop?id="+id);
			}
		} else {
			if(u.getPassword().equals(service.getHashvlaue(password))) {
				service.delete(id);
				session.invalidate();
				mav.setViewName("redirect:loginForm.shop");
			} else {
				throw new LoginException("����","../user/delete.shop?id="+id);
			}
		}
		return mav;
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat,true));
	}
}
