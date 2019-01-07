package dao.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import logic.Sale;

public interface SaleMapper {

	@Select( "select ifnull(max(saleid),0) from sale")
	Integer maxSaleId();

	@Insert("insert into sale (saleid,userid,updatetime) values (#{saleId}, #{user.userId}, #{updateTime})")
	void insert(Sale sale);


}
