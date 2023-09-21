package com.kh.gogi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import com.kh.gogi.dto.BasketDto;
import com.kh.gogi.dto.BasketListDto;
import com.kh.gogi.mapper.BasketListMapper;

@Component
public class BasketDaoImpl implements BasketDao{
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private BasketListMapper basketListMapper;

	@Override
	public int sequence() {
		String sql = "select basket_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	@Override
	public void add(BasketDto basketDto) {
		String sql = "insert into basket("
					+ "basket_no, basket_member, "
					+ "basket_listno, basket_count"
					+ ") values(?, ?, ?, ?)";
		Object[] data = {
					basketDto.getBasketNo(), basketDto.getBasketMember(),
					basketDto.getBasketListNo(), basketDto.getBasketCount()
		};
		jdbcTemplate.update(sql, data);
	}
	
	@Override
	public boolean delete(int basketListNo) {
		String sql = "delete basket where basket_listno = ?";
		Object[] data = {basketListNo};
		return jdbcTemplate.update(sql, data) > 0;
	}

	@Override
	public List<BasketListDto> selectList() {
		String sql = "select "
					+ "basket_member,"
					+ "product_no, product_name, product_price,"
					+ "basket_no, basket_listno, basket_count "
					+ "from basket "
					+ "left outer join product "
					+ "on product.product_no = basket.basket_listno "
					+ "order by basket.basket_member asc";
		return jdbcTemplate.query(sql, basketListMapper);
	}



}

