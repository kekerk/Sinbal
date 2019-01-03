package logic;

import java.util.Date;

public class SaleItem {
	private Integer saleId;
	private Integer saleItemId;
	private Integer itemId;
	private Integer quantity;
	private Date updateTime;
	private Item item;
	public SaleItem() {}
	public SaleItem(Integer saleId, Integer saleItemId, ItemSet itemSet, Date currentTime) {
		this.saleId = saleId;
		this.saleItemId = saleItemId;
		this.item = itemSet.getItem();
		this.itemId = item.getId();
		this.quantity = itemSet.getQuantity();
		this.updateTime = currentTime;
	}
	public Integer getSaleId() {
		return saleId;
	}
	public void setSaleId(Integer saleId) {
		this.saleId = saleId;
	}
	public Integer getSaleItemId() {
		return saleItemId;
	}
	public void setSaleItemId(Integer saleItemId) {
		this.saleItemId = saleItemId;
	}
	public Integer getItemId() {
		return itemId;
	}
	public void setItemId(Integer itemId) {
		this.itemId = itemId;
	}
	public Integer getQuantity() {
		return quantity;
	}
	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}
	public Date getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	public Item getItem() {
		return item;
	}
	public void setItem(Item item) {
		this.item = item;
	}
	
}
