package dao.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import logic.User;

public interface UserMapper {

	@Insert("insert into user_backup (userid,password,username,phoneno,postcode,address,email,birthday,userauth) " 
				+"values(#{userId},#{password},#{userName},#{phoneNo},#{postcode},#{address},#{email},#{birthDay},0)")
	void insert(User user);

	@Update("update user_backup set username=#{userName},phoneno=#{phoneNo}"
			+",postcode=#{postcode},address=#{address},email=#{email},birthday=#{birthDay} where userid=#{userId}")
	void update(User user);

	@Delete("delete from user_backup where userid=#{userId}")
	void delete(Map<String, String> map);

	@Insert("insert into userauth (userEmail,authKey) values(#{userEmail},#{authKey})")
	void Keyinsert(Map<String, Object> map);

	@Update("update user_backup set userauth=1 where email=#{email}")
	void userAuth(String email);

	@Select("select userEmail from userauth where authKey=#{key}")
	String userEmail(String key);

	@Select("select userid from user_backup where email=#{email}")
	String findId(String email);

	@Update("update user_backup set password=#{pass} where email=#{email}")
	void updatePass(Map<String, String> map);

	@Select("select email from user_backup where userid=#{userId} and email=#{email}")
	String findEmail(User user);

	@Delete("delete from userauth where authKey=#{authKey}")
	void deleteKey(String authKey);

}
