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
	private final String NS="dao.mapper.SaleItemMapper.";
	
	public void insert(SaleItem is) {
		sqlSession.getMapper(SaleItemMapper.class).insert(is);
		
	}
	public List<SaleItem> SaleItemlist(Integer saleId) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("saleId", saleId);
		return sqlSession.selectList(NS+"list", map);
	}

}
