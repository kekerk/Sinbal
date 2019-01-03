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

@Controller //@Component + Controller ��� �ο�.
public class ItemController {
	@Autowired
	private ShopService service;
	@RequestMapping("item/list")
	public ModelAndView list() {
		//itemList : Item ���̺��� ��� ���ڵ带 ������ �ִ� List ��ü
		List<Item> itemList = service.getItemList();
		ModelAndView mav = new ModelAndView(); //view ��� ���� : "item/list"�� �⺻ view
		// /WEB-INF/view/item/list.jsp
		mav.addObject("itemList",itemList);
		return mav;
	}
	@RequestMapping("item/*")//*:��Ī �Ǵ� �̸��� ������ ����
	public ModelAndView detail(String id) { //id : "id"�Ķ���� ���� ������
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
		//@Valid : ��ȿ�� ����. Item Ŭ������ ���ǵ� �������� ������ ��
		//item ��ü : �Ķ���� ������ ���ε�� ���ϳ����� ����
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
