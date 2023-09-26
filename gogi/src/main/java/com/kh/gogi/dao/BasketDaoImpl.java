package com.kh.gogi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import com.kh.gogi.dto.BasketDto;
import com.kh.gogi.dto.BasketListDto;
import com.kh.gogi.mapper.BasketListMapper;
import com.kh.gogi.mapper.BasketMapper;

@Component
public class BasketDaoImpl implements BasketDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private BasketMapper basketMapper;

	@Autowired
	private BasketListMapper basketListMapper;

	@Override
	public int sequence() {
		String sql = "select basket_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}

	@Override
	public void add(BasketDto basketDto) {
		String sql = "insert into basket(" + "basket_no, basket_member, " + "basket_listno, basket_count"
				+ ") values(?, ?, ?, ?)";
		Object[] data = { basketDto.getBasketNo(), basketDto.getBasketMember(), basketDto.getBasketListNo(),
				basketDto.getBasketCount() };
		jdbcTemplate.update(sql, data);
	}

	@Override
	public boolean delete(int basketNo) {
		String sql = "delete basket where basket_no = ?";
		Object[] data = { basketNo };
		return jdbcTemplate.update(sql, data) > 0;
	}

	@Override
	public BasketListDto selectOne(int basketNo) {
		String sql = "select *from basket where basket_no = ?";
		Object[] data = {basketNo};
		List<BasketListDto> list = jdbcTemplate.query(sql, basketListMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}

	@Override
	public List<BasketListDto> selectList(String basketMember) {
		String sql = "select " 
				+ "basket_member," 
				+ "product_no, product_name, product_price,"
				+ "basket_no, basket_listno, basket_count " 
				+ "from basket " 
				+ "left outer join product "
				+ "on product.product_no = basket.basket_listno "
				+ "where basket.basket_member = ? " 
				+ "order by basket.basket_member asc";
		Object[] data = {basketMember};
		return jdbcTemplate.query(sql, basketListMapper, data);
	}




}
