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
}
