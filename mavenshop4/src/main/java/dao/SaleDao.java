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

import dao.mapper.SaleMapper;
import logic.Sale;
import logic.SaleItem;

@Repository
public class SaleDao {
	@Autowired
	private SqlSessionTemplate sqlSession;
	private final String NS="dao.mapper.SaleMapper.";
	
	public Integer getMaxSaleId() {
		Integer ret = sqlSession.getMapper(SaleMapper.class).maxSaleId();
		return ++ret;
	}

	public void insert(Sale sale) {
		sqlSession.getMapper(SaleMapper.class).insert(sale);
	}
	
	public List<Sale> Salelist(String userid) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("userId", userid);
		return sqlSession.selectList(NS+"list", map);
	}
	

}
