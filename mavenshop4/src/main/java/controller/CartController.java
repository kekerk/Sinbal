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
	public ModelAndView add(Integer id, Integer quantity, HttpSession session) { //cart를 세션으로부터 등록
		// selectedItem : 상품ID값에서 Item 객체를 db에서 읽어서 Item 정보 저장
		
		Item selectedItem = service.getItem(id);
		Cart cart = (Cart)session.getAttribute("CART");
		if(cart == null) { //등록된 장바구니 상품이 없다.
			cart = new Cart();
			session.setAttribute("CART", cart); //empty Cart 객체를 session에 저장
		}
		cart.push(new ItemSet(selectedItem,quantity));  
		ModelAndView mav = new ModelAndView("cart/cart");
		mav.addObject("message",selectedItem.getName()+" "+quantity+"개를 장바구니에 추가");
		mav.addObject("cart",cart);
		return mav;
	
	
	}
	@RequestMapping("cart/cancel")
	public ModelAndView cancel(Integer index, HttpSession session) {
		Cart cart = (Cart)session.getAttribute("CART");
		ModelAndView mav = new ModelAndView("cart/cart");
		int idx = index;
		ItemSet delete = null;
		try {
			delete = cart.getItemSetList().remove(idx);
			mav.addObject("message",delete.getItem().getName()+"상품을 장바구니에서 제거함");
		}catch(Exception e) {
			mav.addObject("message","상품을 장바구니에서 제거 실패");
		}
		mav.addObject("cart",cart);
		return mav;
	}
	
	@RequestMapping("cart/cartView")
	public ModelAndView cartView(HttpSession session) throws CartEmptyException {
		Cart cart = (Cart)session.getAttribute("CART");
		if(cart == null || cart.isEmpty()) { //등록된 장바구니 상품이 없다.
			throw new CartEmptyException ("장바구니에 item이 없습니다.","../item/list.shop");
		}
		ModelAndView mav = new ModelAndView("cart/cart");
		mav.addObject("cart",cart);
		mav.addObject("message","장바구니에 접속했습니다.");
		return mav;
	}
	/*
	 * checkout : view단을 checkout으로 보내라.
	 */
	@RequestMapping("cart/checkout")
	public String checkout(HttpSession session) {	//CartAspect AOP 대상이 되는 핵심 메서드
		return "cart/checkout";
		
	}
	//주문 확정
	//1. 주문테이블에 해당 내용 저장
	//2. 장바구니의 상품 제거
	@RequestMapping("cart/end") 
	public ModelAndView checkend(HttpSession session) { //CartAspect AOP 대상이 되는 핵심 메서드
		ModelAndView mav = new ModelAndView();
		Cart cart = (Cart) session.getAttribute("CART");
		User loginUser = (User) session.getAttribute("loginUser");
		// sale : 구매고객정보, 구매상품정보 등을 저장한 객체
		Sale sale = service.checkEnd(loginUser,cart);//주문상품을 db에 저장하기
		List<ItemSet> itemSetList = cart.getItemSetList();
		int tot = cart.getTotalAmount();
		cart.clearAll(session);//장바구니 비우기
		mav.addObject("sale",sale);
		mav.addObject("totalAmount", tot);
		return mav;
	}
}
