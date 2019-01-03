package logic;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

public class Cart {
	//itemList : 현재 장바구니에 등록된 상품목록
	private List<ItemSet> itemSetList = new ArrayList<ItemSet>(); //상품목록
	
	public List<ItemSet> getItemSetList() {
		return itemSetList;
	}
	//itemSet : 장바구니에 등록될 상품
	public void push(ItemSet itemSet) {
		for(ItemSet s : itemSetList) {
			if(s.getItem().getId() == itemSet.getItem().getId()) { //추가 상품 등록
				s.setQuantity(s.getQuantity() + itemSet.getQuantity());
				return;
			}
		}
		itemSetList.add(itemSet);
	}
	public boolean isEmpty() {
		return itemSetList == null || itemSetList.size() == 0;
	}
	public int getTotalAmount(){
		int total = 0;
		for(ItemSet s : itemSetList) {
			total += s.getItem().getPrice() * s.getQuantity();
		}
		return total;
	}
	public void clearAll(HttpSession session) {
		itemSetList = new ArrayList<ItemSet>();
		session.setAttribute("CART",this);
	}
}
