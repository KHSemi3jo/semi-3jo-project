package com.kh.gogi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.gogi.dto.BasketListDto;

@Component
public class BasketListMapper implements RowMapper<BasketListDto>{

	@Override
	public BasketListDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		BasketListDto basketListDto = new BasketListDto();
		basketListDto.setBasketNo(rs.getInt("basket_no"));
		basketListDto.setBasketListNo(rs.getInt("basket_listno"));
		basketListDto.setBasketMember(rs.getString("basket_member"));
		basketListDto.setBasketCount(rs.getInt("basket_count"));
		basketListDto.setProductNo(rs.getInt("product_no"));
		basketListDto.setProductName(rs.getString("product_name"));
		basketListDto.setProductPrice(rs.getInt("product_price"));
		return basketListDto;
	}

}
