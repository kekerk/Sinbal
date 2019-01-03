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

import dao.mapper.ItemMapper;
import logic.Item;

@Repository //@Component + Model ���
public class ItemDao {
	@Autowired
	private SqlSessionTemplate sqlSession;
	private final String NS = "dao.mapper.ItemMapper.";
	
	public List<Item> list() {
		return sqlSession.selectList(NS + "list");
	}
	public Item getItemById(String id) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		return sqlSession.selectOne(NS + "list",map);
	}
	public void insert(Item item) {
		//i : item ���̺��� id ���� �ִ밪 ����
		int i = sqlSession.getMapper(ItemMapper.class).maxid();
		item.setId(++i); //���� ����� ���ڵ��� id�� ����
		sqlSession.getMapper(ItemMapper.class).insert(item);
	}
	public void update(Item item) {
		sqlSession.getMapper(ItemMapper.class).update(item);
	}
	public void delete(String id) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		sqlSession.getMapper(ItemMapper.class).delete(map);
	}
	public Item getItemById(Integer id) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("id", id);
		return sqlSession.selectOne(NS + "list",map);
	}
}
