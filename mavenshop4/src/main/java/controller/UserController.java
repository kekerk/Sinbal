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
		//db에서 아이디의 회원 정보 조회하고 비밀번호 검증하여 session에 등록
		//로그인 성공시 loginSuccess
		try {
			//u : 아이디에 해당하는 db의 사용자 정보 저장
			User u = service.selectUser(user.getUserId());
			if(u == null){
				bindResult.reject("error.login.id");
				mav.getModel().putAll(bindResult.getModel());
				return mav;
			}
			
			if(service.getHashvlaue(user.getPassword()).equals(u.getPassword())) { //아이디와 비밀번호가 일치
				session.setAttribute("loginUser", u); //로그인 성공.
			} else {
				bindResult.reject("error.login.password");
				mav.getModel().putAll(bindResult.getModel());
				return mav;
			}
		} catch(Exception e) { 
			//EmptyResultDataAccessException :해당 아이디 정보가 db에 없을 때. 스프링에서만 발생되는 예외.
			e.printStackTrace();
			bindResult.reject("error.user.login");
			mav.getModel().putAll(bindResult.getModel());
			return mav;
		}
		mav.setViewName("user/loginSuccess"); //로그인 성공하는 경우만 설정
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
	 * 1. 파라미터 값들을 User 객체에 저장, 유효성 검증
	 * 2. AOP를 이용하여 로그인 안된 경우, 다른 사용자 정보 수정 안되도록 LoginAspect 클래스에 AOP메서드 추가
	 * 3. 비밀번호가 일치하는 경우만 회원정보 수정
	 * 4. 회원정보 수정 성공 : mypage.shop 페이지 이동
	 *          수정 실패 : updateForm.shop 페이지 이동
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
	 * -관리자가 다른 회원을 강제 탈퇴
	 * 비밀번호에 관리자 비밀번호 입력하기
	 * 관리자 비밀번호가 맞는 경우 회원 정보 삭제
	 * 강제 탈퇴 성공 : admin/list.shop페이지 이동
	 *       실패 : 유효성 검증으로 delete.jsp 페이지 출력
	 * -본인 회원 탈퇴
	 * 비밀번호에 회원 비밀번호 입력하기
	 * 비밀번호가 맞는 경우 회원 정보 삭제
	 * 탈퇴 성공 : session 종료 후 loginForm.shop페이지 이동
	 *    실패 : 유효성 검증으로 delete.jsp페이지에 출력
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
				throw new LoginException("오류","../user/delete.shop?id="+id);
			}
		} else {
			if(u.getPassword().equals(service.getHashvlaue(password))) {
				service.delete(id);
				session.invalidate();
				mav.setViewName("redirect:loginForm.shop");
			} else {
				throw new LoginException("오류","../user/delete.shop?id="+id);
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
