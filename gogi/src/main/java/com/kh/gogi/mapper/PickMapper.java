package com.kh.gogi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.gogi.dto.PickDto;

@Component
public class PickMapper implements RowMapper<PickDto>{

	@Override
	public PickDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		PickDto pickDto = new PickDto();
		pickDto.setPickNo(rs.getInt("pick_no"));
		pickDto.setPickProdNo(rs.getInt("pickProd_no"));
		pickDto.setPickMemberId(rs.getString("pickmember_id"));
		return pickDto;
	}

}
