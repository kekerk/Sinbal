package controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	
	@RequestMapping("user/main") 
	public ModelAndView main() {
		ModelAndView mav = new ModelAndView();
		mav.addObject(new User());
		return mav;
	}
	@RequestMapping("user/userForm") 
	public ModelAndView userForm() {
		ModelAndView mav = new ModelAndView("user/login");
		mav.addObject(new User());
		return mav;
	}
	@RequestMapping("user/userEntry") 
	public ModelAndView userEntry(@Valid User user,BindingResult bindResult) throws Exception {
		ModelAndView mav = new ModelAndView("user/userForm");
		if(bindResult.hasErrors()) {
			mav.getModel().putAll(bindResult.getModel());
			return mav;
		}
		try {
			if(user.getAddress1() != "") {
				user.setAddress(user.getAddress()+" "+user.getAddress1());
			}
			user.setEmail(user.getEmail() +"@" +user.getEmail2());
			user.setPassword(service.getHashvlaue(user.getPassword()));
			service.userCreate(user);
			mav.addObject("user",user);
		} catch(DataIntegrityViolationException e) {
			bindResult.reject("error.duplicate.user");
		}
		mav.setViewName("user/main");
		return mav;
	}
	@RequestMapping("user/emailConfirm")
	public ModelAndView emailConfirm(User user,HttpServletRequest request) { // 이메일인증
		ModelAndView mav = new ModelAndView("user/main");
		String key =request.getParameter("authKey");
		String email=service.Email(key);
		service.updateAuth(email);
		mav.addObject("user",user);
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
		mav.addObject(new User());
		//db에서 아이디의 회원 정보 조회하고 비밀번호 검증하여 session에 등록
		//로그인 성공시 loginSuccess
		try {
			//u : 아이디에 해당하는 db의 사용자 정보 저장
			User u = service.selectUser(user.getUserId());
			if(u == null){
				throw new LoginException("입력 정보가 잘못되었습니다.","../user/main.shop");
			}
			if(!u.getUserauth().equals(1)) {
				bindResult.reject("error.login.email");
				mav.getModel().putAll(bindResult.getModel());
				return mav;
			}
			if(service.getHashvlaue(user.getPassword()).equals(u.getPassword())) { //아이디와 비밀번호가 일치
				session.setAttribute("loginUser", u); //로그인 성공.
				mav.setViewName("user/loginSuccess");
			} else {
				throw new LoginException("입력 정보가 잘못되었습니다.","../user/main.shop");
			}
		} catch(Exception e) { 
			throw new LoginException("입력 정보가 잘못되었습니다.","../user/main.shop");
		}
		mav.setViewName("user/loginSuccess"); //로그인 성공하는 경우만 설정
		return mav;
	}
	@RequestMapping("user/logout")
	public ModelAndView logout(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		session.invalidate();
		mav.setViewName("redirect:main.shop"); 
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
				if(user.getAddress1() != "") {
					user.setAddress(user.getAddress()+" "+user.getAddress1());
				}
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
				mav.setViewName("redirect:main.shop");
			} else {
				throw new LoginException("오류","../user/delete.shop?id="+id);
			}
		}
		return mav;
	}
	@RequestMapping(value="user/idfind",method=RequestMethod.POST)
	public ModelAndView idfind(User user, HttpServletRequest request) {
		String email = request.getParameter("email");
		ModelAndView mav = new ModelAndView();
		mav.addObject("user",new User());
		String id = service.findId(email);
		mav.addObject("id",id);
		if(id==null) {
			throw new LoginException("입력 정보가 잘못되었습니다.","../user/main.shop");
		} else {
			throw new LoginException("아이디는 "+id+"입니다.","../user/main.shop");
		}
	}
	@RequestMapping(value="user/passfind",method=RequestMethod.POST)
	public ModelAndView passfind(User user, HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView();
		String email = service.findEmail(user);
		if(email != null) {
			service.passEmail(email);
			throw new LoginException("메일","../user/main.shop");
		} else {
			throw new LoginException("입력 정보가 잘못되었습니다.","../user/loginForm.shop");
		}		
	}
	@RequestMapping(value="user/passChange",method=RequestMethod.GET)
	public ModelAndView passChange(String id, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		String key = request.getParameter("authKey");
		mav.addObject("authKey",key);
		return mav;
	}	
	@RequestMapping(value="user/passChange",method=RequestMethod.POST)
	public ModelAndView passChange(String authKey,String pass1,String pass2,HttpServletRequest request) { // 이메일인증
		ModelAndView mav = new ModelAndView();	
//		String key =request.getParameter("authKey");
//		String pass1 = request.getParameter("pass1");
//		String password = request.getParameter("pass2");
		String email=service.Email(authKey);
		if(pass1.equals(pass2)) {
			try {
				String pass = service.getHashvlaue(pass1);
				service.passChange(pass,email);
				service.delkey(authKey);
				mav.setViewName("user/main");
				return mav;
			} catch (Exception e) {
				e.printStackTrace();
				throw new LoginException("비밀번호 수정중 오류발생.","../user/passChange.shop?authKey="+authKey);
			}		
		} else {
			throw new LoginException("비밀번호 확인이 일치하지 않습니다.","../user/passChange.shop?authKey="+authKey);
		}
    }
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat,true));
	}
}
