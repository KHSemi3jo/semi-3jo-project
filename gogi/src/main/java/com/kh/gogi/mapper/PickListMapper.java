package com.kh.gogi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.gogi.dto.PickListDto;

@Component
public class PickListMapper implements RowMapper<PickListDto>{

	@Override
	public PickListDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		PickListDto pickListDto = new PickListDto();
		pickListDto.setPickNo(rs.getInt("pick_no"));
		pickListDto.setPickProdNo(rs.getInt("pickProd_no"));
		pickListDto.setPickMemberId(rs.getString("pickmember_id"));
		pickListDto.setProductNo(rs.getInt("product_no"));
		pickListDto.setProductName(rs.getString("product_name"));
		pickListDto.setProductPrice(rs.getInt("product_price"));
		return pickListDto;
	}

}
