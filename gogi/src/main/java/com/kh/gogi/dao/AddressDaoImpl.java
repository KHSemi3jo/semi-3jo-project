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
		String sql = "insert into address(address_no,address_id,address_post, address_normal, address_detail ) "
				+ "values(?,?,?,?,?)";
		
		Object[] data = {addressDto.getAddressNo(),
				addressDto.getAddressId(),
				addressDto.getAddressPost(), addressDto.getAddressNormal(),
				addressDto.getAddressDetail()
		};
		jdbcTemplate.update(sql,data);
	}

	@Override
	public List<AddressDto> selectAddressList(String addressId) {
		String sql = "select * from address where address_id=?";
		Object[] data = {addressId};
		return jdbcTemplate.query(sql, addressMapper, data);
	}

	@Override
	public int sequence() {
		String sql = "select shopAfter_seq.nextval from dual ";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
}
