package controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import exception.CartEmptyException;
import logic.Cart;
import logic.Item;
import logic.ItemSet;
import logic.Sale;
import logic.ShopService;
import logic.User;

@Controller
public class CartController {
	@Autowired
	ShopService service;
	@RequestMapping("cart/cartAdd")
	public ModelAndView add(String id, Integer quantity, HttpSession session) {
		//selectedItem : id값에서 Item 객체를 db에서 읽어서 Item 정보 저장
		Item selectedItem = service.getItemById(id);
		Cart cart = (Cart)session.getAttribute("CART");
		if(cart == null) { //등록된 장바구니 상품이 없다.
			cart = new Cart();
			session.setAttribute("CART", cart); //empty Cart객체를 session저장
		}
		cart.push(new ItemSet(selectedItem,quantity));
		ModelAndView mav = new ModelAndView("cart/cart");
		mav.addObject("message", selectedItem.getName() + "을/를" + quantity + "개를 장바구니에 추가");
		mav.addObject("cart",cart);
		return mav;
	}
	@RequestMapping("cart/cartDelete")
	public ModelAndView add(Integer index, HttpSession session) {
		Cart cart = (Cart)session.getAttribute("CART");
		ModelAndView mav = new ModelAndView("cart/cart");
		int idx = index;
		ItemSet delete = null;
		try {
			delete = cart.getItemSetList().remove(idx);
			mav.addObject("message",delete.getItem().getName() + "상품을 장바구니에서 제거함");
		} catch(Exception e) {
			mav.addObject("message", "상품을 장바구니에서 제거 실패");
		}
		mav.addObject("cart",cart);
		return mav;		
	}
	@RequestMapping("cart/cartView")
	public ModelAndView add1(HttpSession session) {
		Cart cart = (Cart)session.getAttribute("CART");
		if(cart == null || cart.isEmpty()) { //등록된 장바구니 상품이 없다.
			throw new CartEmptyException("장바구니에 상품이 없습니다.","../item/list.shop");
		}
		ModelAndView mav = new ModelAndView("cart/cart");
		mav.addObject("cart",cart);
		return mav;
	}
	@RequestMapping("cart/checkout")
	public String checkout(HttpSession session) { //CartAspect Aop 대상이 되는 핵심메서드
		return "cart/checkout";
	}
	//주문 확정
	//1. 주문테이블에 저장
	//2. 장바구니에 상품을 제거하기
	@RequestMapping("cart/end")
	public ModelAndView checkend(HttpSession session) { //CartAspect Aop 대상이 되는 핵심메서드
		ModelAndView mav = new ModelAndView();
		Cart cart = (Cart)session.getAttribute("CART");
		User loginUser = (User)session.getAttribute("loginUser");
		//sale : 구매 고객정보, 구매상품 정보 등을 저장한 객체
		Sale sale = service.checkEnd(loginUser, cart); //주문 상품을 db에 저장하기
		List<ItemSet> itemSetList = cart.getItemSetList();
		int tot = cart.getTotalAmount();
		cart.clearAll(session); //장바구니 상품 제거
		mav.addObject("sale", sale);
		mav.addObject("totalAmount", tot);
		return mav;
	}
}
