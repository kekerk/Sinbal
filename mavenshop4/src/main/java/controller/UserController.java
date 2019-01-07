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
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import exception.LoginException;
import logic.Item;
import logic.Sale;
import logic.SaleItem;
import logic.ShopService;
import logic.User;
import util.CiperUtil;
/*
 * 1. 회원 가입/수정 시 이메일을 암호화하여 db에 저장하기
 * 2. 조회 시 복호화 하여 화면에 출력
 * 	  회원 조회, admin의 회원 목록 조회
 */
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
	
	@RequestMapping("user/main")
	public ModelAndView mainForm() {
		ModelAndView mav = new ModelAndView();
		mav.addObject(new User());
		return mav;
	}
	
	@RequestMapping("user/loginForm")
	public ModelAndView loginForm() {
		ModelAndView mav = new ModelAndView("user/login");
		mav.addObject(new User());
		return mav;
	}

	@RequestMapping("user/login")
	public ModelAndView login(@Valid User user, BindingResult bindResult, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		if (bindResult.hasErrors()) {
			mav.getModel().putAll(bindResult.getModel());
			return mav;
		}
		try {
			User selectedUser = service.selectUser(user.getUserId());
			if(selectedUser == null) {
				bindResult.reject("error.login.id");
				mav.getModel().putAll(bindResult.getModel());
				return mav;
			}
			if (service.getHashValue(user.getPassword()).equals(selectedUser.getPassword())) {
				session.setAttribute("loginUser", selectedUser);
				mav.setViewName("/user/loginSuccess");
			} else {
				bindResult.reject("error.login.password");
				mav.getModel().putAll(bindResult.getModel());
				return mav;
			}
		} catch (Exception e) {
			e.printStackTrace();
			bindResult.reject("error.login.id");
			mav.getModel().putAll(bindResult.getModel());
			return mav;
		}
		return mav;
	}

	@RequestMapping("user/userEntry")
	public ModelAndView userEntry(@Valid User user, BindingResult bindResult) {
		ModelAndView mav = new ModelAndView("user/userForm");
		if (bindResult.hasErrors()) {
			mav.getModel().putAll(bindResult.getModel());
			return mav;
		}
		try {
			service.userCreate(user);
			mav.setViewName("user/login");
			mav.addObject("user", user);
		} catch (DataIntegrityViolationException e) {
			bindResult.reject("error.duplicate.user");
		}
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
		ModelAndView mav = new ModelAndView();
		User user = service.selectUser(id);
		// sale 테이블에서 해당 사용자가 주문한 정보 목록 조회
		List<Sale> salelist = service.SaleList(id);
		for (Sale s : salelist) {
			// 주문 번호를 통해 해당 주문에 포함된 물품목록 list 객체로 생성
			List<SaleItem> saleItemlist = service.SaleItemlist(s.getSaleId());
			for (SaleItem si : saleItemlist) {
				Item item = service.getItem(si.getItemId());
				si.setItem(item);
			}
			s.setItemList(saleItemlist);
		}
		mav.addObject("user", user);
		mav.addObject("salelist", salelist);
		return mav;
	}

	@RequestMapping("user/updateForm")
	public ModelAndView updateForm(String id, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User user = service.selectUser(id);
		mav.addObject("user", user);
		return mav;
	}

	/*
	 * 파라미터 값들을 user 객체에 저장 비밀번호가 일치하는 경우만 회원정보 수정 수정 성공 :mypage.shop 수정 실패
	 * :updateForm.shop
	 */
	@RequestMapping("user/update")
	public ModelAndView update(@Valid User user, BindingResult bindResult, HttpSession session) {
		ModelAndView mav = new ModelAndView("user/updateForm");
		if (bindResult.hasErrors()) {
			mav.getModel().putAll(bindResult.getModel());
			return mav;
		}
		User dbuser = service.selectUser(user.getUserId());
		if (service.getHashValue(user.getPassword()).equals(dbuser.getPassword())) {
			try {
				service.update(user);
				mav.setViewName("redirect:../user/mypage.shop?id=" + user.getUserId());
			} catch (Exception e) {
				e.printStackTrace();
				bindResult.reject("error.user.update");
				mav.getModel().putAll(bindResult.getModel());
			}
		} else {
			bindResult.reject("error.login.password");
			mav.getModel().putAll(bindResult.getModel());
		}
		return mav;
	}

/*	 회원 탈퇴(GET)
	 admin인 경우 탈퇴되지 않도록 처리
	 1.관리자가 다른 회원을 강제 탈퇴
	 1)비밀번호에 관리자 비밀번호를 입력하기.
	 2)관리자비밀번호가 맞는 경우 회원 정보 삭제.
	 3)강제탈퇴 성공 : redirect:admin/list.shop 이동
	 4)강제탈퇴 실패 : 예외 발생 후 delete.shop 페이지에 출력
	 2.본인 회원 탈퇴
	 1)비밀번호에 회원 비밀번호 입력하기
	 2)비밀번호가 맞는 경우 회원 정보 삭제
	 탈퇴 성공 : session 종료 후 loginForm.shop 페이지 이동
	 탈퇴 실패 : 예외발생 후 delete.jsp 페이지에 출력*/
	@RequestMapping(value = "user/delete", method = RequestMethod.GET)
	public ModelAndView delete(String id, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User user = service.selectUser(id);
		mav.addObject("user", user);
		return mav;
	}

	// 회원탈퇴(POST)
	@RequestMapping(value = "user/delete", method = RequestMethod.POST)
	public ModelAndView delete(String id, HttpSession session, String password) {
		ModelAndView mav = new ModelAndView();
		User loginUser = (User) session.getAttribute("loginUser"); // 현재 로그인된 유저
		if (loginUser.getPassword().equals(service.getHashValue(password))) { // 패스워드 일치
			try {
				service.deleteUser(id);
				if (!loginUser.getUserId().equals("admin")) { // 관리자가 아닌 경우
					session.invalidate();
					mav.setViewName("redirect:loginForm.shop");
				} else { // 관리자일 경우
					mav.setViewName("redirect:../admin/list.shop");
				}
			} catch (Exception e) {
				e.printStackTrace();
				throw new LoginException("탈퇴 실패", "../user/delete.shop?id=" + id);
			}
		} else {// 패스워드 불일치
			throw new LoginException("비밀번호 오류", "../user/delete.shop?id=" + id);
		}
		return mav;
	}

	@InitBinder // 날짜형식 초기 지정
	public void initBinder(WebDataBinder binder) {
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	}
}
