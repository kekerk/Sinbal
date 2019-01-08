package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.stereotype.Repository;

import dao.mapper.UserMapper;
import logic.User;

@Repository
public class UserDao {
	@Autowired
	private SqlSessionTemplate sqlSession;
	private final String NS = "dao.mapper.UserMapper.";
	
	public void insert(User user) {
		sqlSession.getMapper(UserMapper.class).insert(user);
	}
	public User select(String userId) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("userid", userId);
		return sqlSession.selectOne(NS + "select",map);
	}
	public void update(User user) {
		sqlSession.getMapper(UserMapper.class).update(user);
	}
	public void delete(String id) {
		Map<String, String> map = new HashMap<String,String>();
		map.put("userId", id);
		sqlSession.getMapper(UserMapper.class).delete(map);
	}
	public List<User> userList() {
		return sqlSession.selectList(NS + "select");	
	}
	//idchks : test1, test2
	//ids : 'test1','test2'
	//sql : select * from useraccount where userid in ('test1','test2')
	public List<User> list(String[] idchks) {
		Map<String, String[]> map = new HashMap<String,String[]>();
		map.put("ids", idchks);
		return sqlSession.selectList(NS + "select",map);
	}
	
	public void createAuthKey(String userEmail, String AuthKey) throws Exception {
		Map<String, Object> map = new HashMap<String,Object>();
	        map.put("authKey",AuthKey);
	        map.put("userEmail",userEmail);
	        sqlSession.getMapper(UserMapper.class).Keyinsert(map);
    }
	public void userAuth(String email) {
		sqlSession.getMapper(UserMapper.class).userAuth(email);
	}
	public String userEmail(String key) {
		return sqlSession.getMapper(UserMapper.class).userEmail(key);
	}
	public String findId(String email) {
		return sqlSession.getMapper(UserMapper.class).findId(email);
	}
	public void updatePass(String pass, String email) {
		Map<String, String> map = new HashMap<String,String>();
        map.put("pass",pass);
        map.put("email",email);
		sqlSession.getMapper(UserMapper.class).updatePass(map);
	}
	public String findEmail(User user) {
		return sqlSession.getMapper(UserMapper.class).findEmail(user);
	}
	public void delkey(String authKey) {
		sqlSession.getMapper(UserMapper.class).deleteKey(authKey);
	}
}
