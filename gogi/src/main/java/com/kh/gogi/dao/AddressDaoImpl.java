package com.kh.gogi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.gogi.dto.AddressDto;
import com.kh.gogi.mapper.AddressMapper;

@Repository
public class AddressDaoImpl implements AddressDao{
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private AddressMapper addressMapper;

	@Override
	public void insert(AddressDto addressDto) {
		String sql = "insert into address(address_post, address_normal, address_detail ) "
				+ "values(?,?,?)";
		
		Object[] data = {
				addressDto.getAddressPost(), addressDto.getAddressNormal(),
				addressDto.getAddressDetail()
		};
		jdbcTemplate.update(sql,data);
	}

	@Override
	public List<AddressDto> selectAddressList(String memberId) {
		String sql = "select * from address where member_id=?";
		return jdbcTemplate.query(sql, addressMapper);
	}
}
