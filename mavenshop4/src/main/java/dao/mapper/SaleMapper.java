package dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import logic.Sale;

public interface SaleMapper {

	@Select("select ifnull(max(saleId),0) from sale")
	Integer maxId();

	@Insert("insert into sale (saleid, userid, updateTime) values(#{saleId},#{user.userId}, #{updateTime})")
	void insert(Sale sale);

	@Select("select * from sale where userid=#{userid}")
	List<Sale> list(Map<String, Object> map);

}
