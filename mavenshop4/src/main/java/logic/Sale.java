package logic;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Sale {
	private Integer saleId; //주문번호
	private User user;      //주문한 아이디. 고객
	private Date updateTime;//주문일자
//	private Integer totAmount; //아이템 목록 전체의 합?
	private List<SaleItem> itemList = new ArrayList<SaleItem>();
	public Integer getSaleId() {
		return saleId;
	}
	public void setSaleId(Integer saleId) {
		this.saleId = saleId;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public Date getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	
	public Integer getTotAmount() {
		int sum = 0;
		for(SaleItem is : itemList) {
			sum = sum + (is.getQuantity()*is.getItem().getPrice());
		}
		return sum;
	}
	
/*	public void setTotAmount(Integer totAmount) {
		this.totAmount = totAmount;
	}*/
	public List<SaleItem> getItemList() {
		return itemList;
	}
	public void setItemList(List<SaleItem> itemList) {
		this.itemList = itemList;
	}
	
	
	
}
