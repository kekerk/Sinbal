package logic;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

public class Cart {
	private List<ItemSet> itemSetList = new ArrayList<ItemSet>(); // 상품 목록

	public List<ItemSet> getItemSetList() {
		return itemSetList; //현재 장바구니에 등록된 목록
	}

	public void push(ItemSet itemSet) { //장바구니에 넣을 목록
		for (ItemSet is : itemSetList) {
			if (is.getItem().getId() == itemSet.getItem().getId()) { //추가 개수 증가 등록
				is.setQuantity(is.getQuantity() + itemSet.getQuantity());
				return;
			}
		}
		itemSetList.add(itemSet);
	}

	public void deleteitem(ItemSet itemSet) {
		itemSetList.remove(itemSet);
	}

	public boolean isEmpty() {
		
		return itemSetList == null || itemSetList.size()==0;
	}

	public void setItemSetList(List<ItemSet> itemSetList) {
		this.itemSetList = itemSetList;
	}
	
	
	public int getTotalAmount() {
		int sum = 0;
		for(ItemSet is : itemSetList) {
			sum = sum + (is.getQuantity()*is.getItem().getPrice());
		}
		return sum;
	}

	public void clearAll(HttpSession session) {
		itemSetList = new ArrayList<ItemSet>();
		session.setAttribute("CART", this);
	}
}
