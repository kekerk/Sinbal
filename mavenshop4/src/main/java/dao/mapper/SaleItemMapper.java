package dao.mapper;

import org.apache.ibatis.annotations.Insert;

import logic.SaleItem;

public interface SaleItemMapper {

	@Insert("insert into saleitem (saleid,saleitemid,itemid,quantity,updatetime)"
					 + " values (#{saleId},#{saleItemId},#{item.id},#{quantity},#{updateTime})")
	void insert(SaleItem is);

}
