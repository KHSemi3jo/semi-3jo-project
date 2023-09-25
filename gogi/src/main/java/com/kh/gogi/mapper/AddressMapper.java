package com.kh.gogi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.gogi.dto.AddressDto;

@Component
public class AddressMapper implements RowMapper<AddressDto>{

	@Override
	public AddressDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		AddressDto addressDto = new AddressDto();
		addressDto.setAddressPost(rs.getString("address_post"));
		addressDto.setAddressNormal(rs.getString("address_normal"));
		addressDto.setAddressDetail(rs.getString("address_detail"));
		return addressDto;
	}

}
