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
		addressDto.setAddressNo(rs.getInt("address_no"));
		addressDto.setAddressId(rs.getString("address_id"));
		addressDto.setAddressPost(rs.getString("address_post"));
		addressDto.setAddressNormal(rs.getString("address_normal"));
		addressDto.setAddressDetail(rs.getString("address_detail"));
		addressDto.setAddressName(rs.getString("address_name"));
		addressDto.setAddressPhone(rs.getString("address_phone"));
		return addressDto;
	}

}
