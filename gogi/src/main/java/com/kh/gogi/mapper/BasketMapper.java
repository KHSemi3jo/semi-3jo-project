package com.kh.gogi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.gogi.dto.BasketDto;

@Component
public class BasketMapper implements RowMapper<BasketDto>{

	@Override
	public BasketDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		BasketDto basketDto = new BasketDto();
		basketDto.setBasketNo(rs.getInt("basket_no"));
		basketDto.setBasketListNo(rs.getInt("basket_listno"));
		basketDto.setBasketMember(rs.getString("basket_member"));
		basketDto.setBasketCount(rs.getInt("basket_count"));
		return basketDto;
	}

}
