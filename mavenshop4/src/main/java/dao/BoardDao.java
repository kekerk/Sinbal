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

import dao.mapper.BoardMapper;
import logic.Board;

@Repository
public class BoardDao {


	@Autowired
	private SqlSessionTemplate sqlSession;
	private final String NS="dao.mapper.BoardMapper.";
	
	public Board selectBoard(Integer num) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("num", num);
		return sqlSession.selectOne(NS+"list",map);
	}

	public int count(String searchType, String searchContent) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("searchType", searchType);
		map.put("searchContent", searchContent);
		Integer ret = sqlSession.selectOne(NS+"count", map);
		return ret;
	}
	
	public List<Board> list(String searchType, String searchContent, Integer pageNum, int limit) {
		Map<String,Object> map = new HashMap<String,Object>();
		int startrow = (pageNum-1)*limit;
		map.put("searchType", searchType);
		map.put("searchContent", searchContent);
		map.put("startrow", startrow);
		map.put("limit", limit);
		return sqlSession.selectList(NS+"list", map);
	}

	public void write(Board board) {
		sqlSession.getMapper(BoardMapper.class).insert(board);
	}

	public int maxNum() {
		int ret = sqlSession.getMapper(BoardMapper.class).maxNum();
		return ret;
	}

	public void readcnt(int num) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("num",num);
	    sqlSession.getMapper(BoardMapper.class).readcnt(map);
	}

	public void updateAboutRef(int ref, int refstep) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("ref",ref);
		map.put("refstep",refstep);
		sqlSession.getMapper(BoardMapper.class).updateAboutRef(map);
		
	}

	public void updateboard(Board board) {
		sqlSession.getMapper(BoardMapper.class).update(board);
	}

	public void deleteBoard(int num) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("num",num);
		sqlSession.getMapper(BoardMapper.class).delete(map);
		
	}


	
}
