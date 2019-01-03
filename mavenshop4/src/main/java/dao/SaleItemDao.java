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

import dao.mapper.SaleItemMapper;
import logic.SaleItem;

@Repository
public class SaleItemDao {
	@Autowired
	private SqlSessionTemplate sqlSession;
	private final String NS = "dao.mapper.SaleItemMapper.";
	
	public void insert(SaleItem s) {
		sqlSession.getMapper(SaleItemMapper.class).insert(s);
	}
	public List<SaleItem> list(Integer saleId) {
		Map<String,Integer> map = new HashMap<String,Integer>();
		map.put("saleid", saleId);
		return sqlSession.selectList(NS + "list",map);
	}

}
