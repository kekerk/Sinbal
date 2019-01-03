package logic;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Sale {
	private Integer saleId;
	private User user;
	private Date updateTime;
	private Integer totAmount;
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
		return totAmount;
	}
	public void setTotAmount(Integer totAmount) {
		this.totAmount = totAmount;
	}
	public List<SaleItem> getItemList() {
		return itemList;
	}
	public void setItemList(List<SaleItem> itemList) {
		this.itemList = itemList;
	}
	
}
