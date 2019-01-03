package dao.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Update;

import logic.User;

public interface UserMapper {

	@Insert("insert into user_backup (userid,password,username,phoneno,postcode,address,email,birthday) " 
				+"values(#{userId},#{password},#{userName},#{phoneNo},#{postcode},#{address},#{email},#{birthDay})")
	void insert(User user);

	@Update("update user_backup set username=#{userName},phoneno=#{phoneNo}"
			+",postcode=#{postcode},address=#{address},email=#{email},birthday=#{birthDay} where userid=#{userId}")
	void update(User user);

	@Delete("delete from user_backup where userid=#{userId}")
	void delete(Map<String, String> map);

}
