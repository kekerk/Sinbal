package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.ItemMapper;
import logic.Item;

/*
 * @Repository: @Component + model의 기능 부여.
 */
@Repository
public class ItemDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	private final String NS="dao.mapper.ItemMapper.";
	
	public List<Item> list(){
	return sqlSession.selectList(NS+"list"); 
	}
	
	public Item getItemById(Integer id) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("id", id);
		return sqlSession.selectOne(NS+"list", map);
	}
	
	public void insert(Item item) {
		// i : item 테이블의 id 값의 최대값 저장
		int i = sqlSession.getMapper(ItemMapper.class).maxid();
		item.setId(++i);
		sqlSession.getMapper(ItemMapper.class).insert(item);
	}

	public void update(Item item) {
		sqlSession.getMapper(ItemMapper.class).update(item);
	}

	public void delete(Integer id) {
		Map<String,Integer> map = new HashMap<String,Integer>();
		map.put("id", id);		
		sqlSession.getMapper(ItemMapper.class).delete(map);
	}
}
