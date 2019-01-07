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
// 하나의 Controller 안에서 @RequestMapping을 통해 개별 Controller 기능 사용
/*
 * @Controller = @Component(나를 객체화) + Controller 기능 부여.
 */
@Controller
public class ItemController {
	@Autowired
	private ShopService service;

	
	@RequestMapping("item/list")
	public ModelAndView list() {
		// itemList  : Item 테이블의 모든 레코드를 저장하고 있는 List 객체
		List<Item> itemList = service.getItemList(); 
		//객체를 view단으로 전달
		ModelAndView mav = new ModelAndView(); //view 등록 안함 : "item/list"가 기본 view 
		// /WEB-INF/view/item/list.jsp
		mav.addObject("itemList",itemList);
		return mav;
	}

	// @RequestMapping("item/*") 
	@RequestMapping("item/*") //itemController를 검색하여 detail 부분 메서드를 찾음.
	public ModelAndView detail(Integer id) { //id 파라미터 값을 저장함.(파라미터 이름과 매개변수 이름이 같아야 함)
		/*
		 * 매개변수를 HttpServletRequest request로 선언하면 
		 * String id = request.getParameter("id");로 request객체를 id라는 변수로 선언 및 초기화를 해야한다.
		 */
		Item item = service.getItem(id);
		ModelAndView mav = new ModelAndView(); //view 등록 안함 : "item/detail"가 기본 view 
		// /WEB-INF/view/item/detail.jsp
		mav.addObject("item",item);//setAttribute 기능
		return mav;
	}
	
	@RequestMapping("item/create")
	public ModelAndView create() {
		ModelAndView mav = new ModelAndView("item/add"); //Mapping명과 method명이 다르므로  new ModelAndView("item/add") 로 한다.
		mav.addObject(new Item());
		return mav;
	}
	
	@RequestMapping("item/register")
	public ModelAndView register(@Valid Item item, BindingResult bindResult, HttpServletRequest request) {
		// item 객체 : 파라미터 정보와 업로드된 파일 내용을 저장
		// @Valid : 유효성 검증. Item 클래스에 정의된 내용으로 검증을 함. @Valid 어노테이션을 적용하지 않으면 유효성 검증을 하지 않음.
		ModelAndView mav = new ModelAndView("item/add"); 
		if(bindResult.hasErrors()) {
			mav.getModel().putAll(bindResult.getModel());
			return mav;
		}
		service.itemCreate(item,request); //upload 위치때문에 request 가져옴
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
		service.itemEdit(item,request); 
		mav.setViewName("redirect:/item/list.shop");
		return mav;
	}
	
	@RequestMapping("item/delete")
	public ModelAndView delete(Integer id) {
		ModelAndView mav = new ModelAndView(); 
		service.itemDelete(id); 
		mav.setViewName("redirect:/item/list.shop");
		return mav;
	}
	
}
