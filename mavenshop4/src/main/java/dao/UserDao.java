package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import dao.mapper.UserMapper;
import logic.User;

@Repository
public class UserDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	private final String NS="dao.mapper.UserMapper.";
	
	public void insertUser(User user) {
		sqlSession.getMapper(UserMapper.class).insert(user);
	}
	
	
	public User selectUser(String userId){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		return sqlSession.selectOne(NS+"list", map);
	}

	public void update(User user) {
		sqlSession.getMapper(UserMapper.class).update(user);
		
	}

	public void deleteUser(String userId) {
		String sql = "delete from useraccount where userid=:userId";
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("userId", userId);
		sqlSession.getMapper(UserMapper.class).delete(map);
		
	}

	public List<User> userList() {
		return sqlSession.selectList(NS+"list");
	}

	
	public List<User> userList(String[] idchks) {
		Map<String,String[]> map = new HashMap<String,String[]>();
		map.put("idchks", idchks);
		return sqlSession.selectList(NS+"list", map);
	}

}
