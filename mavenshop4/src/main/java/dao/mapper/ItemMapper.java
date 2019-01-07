package dao.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;


import logic.Item;


public interface ItemMapper {
	@Insert("insert into item (id,name,price,description,pictureUrl)"
			+ "values(#{id},#{name},#{price},#{description},#{pictureUrl})")
	void insert(Item item);
	
	@Select("select ifnull(max(id),0) from item")
	int maxid();
	
	@Update("update item set name=:name, price=#{price}, description=#{description}, pictureUrl=#{pictureUr} where id=#{id}")
	void update(Item item);

	@Delete("delete from item where id = #{id}")
	void delete(Map<String,Integer> map);
	
}
