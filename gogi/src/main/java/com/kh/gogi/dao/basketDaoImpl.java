package com.kh.gogi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import com.kh.gogi.dto.BasketDto;
import com.kh.gogi.mapper.BasketMapper;

@Component
public class basketDaoImpl implements BasketDao{
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private BasketMapper basketMapper;

	@Override
	public void insert(BasketDto basketDto) {
		String sql = "insert into basket("
				+ "basket_listno, basket_member, bascket_count) "
				+ "values(?,?,?)";
		Object[] data = {basketDto.getBasketListNo(),
						 basketDto.getBasketMember(),
						 basketDto.getBasketCount()};
		jdbcTemplate.update(sql, data);
	}

	@Override
	public boolean delete(int basketListNo) {
		String sql = "delete basket where basket_listno = ?";
		Object[] data = {basketListNo};
		return jdbcTemplate.update(sql, data) > 0;
	}

	@Override
	public List<BasketDto> selectList() {
		String sql = "select * from basket";
		return jdbcTemplate.query(sql, basketMapper);
	}

}
