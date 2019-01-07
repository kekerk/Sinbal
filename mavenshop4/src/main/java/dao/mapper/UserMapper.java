package dao.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Update;

import logic.User;

public interface UserMapper {
	
	@Insert("insert into user_backup (userid, username, password, birthday, phoneno, postcode, address, email)"
				+ " values (#{userId}, #{userName}, #{password}, #{birthDay}, #{phoneNo}, #{postcode}, #{address}, #{email})")
	void insert(User user);

	@Update("update user_backup set username=#{userName},birthday=#{birthDay},phoneno=#{phoneNo},postcode=#{postcode},address=#{address},email=#{email} where userid=#{userId}")
	void update(User user);

	@Delete("delete from user_backup where userid=#{userId}")
	void delete(Map<String, Object> map);

		
}
 