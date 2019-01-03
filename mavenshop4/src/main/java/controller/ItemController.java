package controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import logic.Item;
import logic.ShopService;

@Controller //@Component + Controller 기능 부여.
public class ItemController {
	@Autowired
	private ShopService service;
	@RequestMapping("item/list")
	public ModelAndView list() {
		//itemList : Item 테이블의 모든 레코드를 가지고 있는 List 객체
		List<Item> itemList = service.getItemList();
		ModelAndView mav = new ModelAndView(); //view 등록 안함 : "item/list"가 기본 view
		// /WEB-INF/view/item/list.jsp
		mav.addObject("itemList",itemList);
		return mav;
	}
	@RequestMapping("item/*")//*:매칭 되는 이름이 없으면 실행
	public ModelAndView detail(String id) { //id : "id"파라미터 값을 저장함
		Item item = service.getItemById(id);
		ModelAndView mav = new ModelAndView();
		mav.addObject("item",item);
		return mav;
	}
	@RequestMapping("item/create")
	public ModelAndView create() {
		ModelAndView mav = new ModelAndView("item/add");
		mav.addObject(new Item());
		return mav;
	}
	@RequestMapping("item/register")
	public ModelAndView register(@Valid Item item, BindingResult bindResult, HttpServletRequest request) {
		//@Valid : 유효성 검증. Item 클래스에 정의된 내용으로 검증을 함
		//item 객체 : 파라미터 정보와 업로드된 파일내용을 저장
		ModelAndView mav = new ModelAndView("item/add");
		if(bindResult.hasErrors()) {
			mav.getModel().putAll(bindResult.getModel());
			return mav;
		}
		service.itemCreate(item,request);
		mav.setViewName("redirect:/item/list.shop");
		return mav;
	}
	@RequestMapping("item/update")
	public ModelAndView update(@Valid Item item, BindingResult bindResult, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("item/edit");
		if(bindResult.hasErrors()) {
			mav.getModel().putAll(bindResult.getModel());
			return mav;
		}
		service.itemUpdate(item,request);
		mav.setViewName("redirect:/item/list.shop");
		return mav;
	}
	@RequestMapping("item/delete")
	public ModelAndView delete(String id) {
		ModelAndView mav = new ModelAndView("item/confirm");
		service.itemDelete(id);
		mav.setViewName("redirect:/item/list.shop");
		return mav;
	}
	
}
