package com.kh.gogi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.gogi.dto.AddressDto;
import com.kh.gogi.dto.ReplyDto;
import com.kh.gogi.mapper.AddressMapper;

@Repository
public class AddressDaoImpl implements AddressDao{
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private AddressMapper addressMapper;

	@Override
	public void insert(AddressDto addressDto) {
		String sql = "insert into address(address_no,address_id,address_post, "
				+ "address_normal, address_detail, address_name,"
				+ "address_phone ) "
				+ "values(?,?,?,?,?,?,?)";
		
		Object[] data = {addressDto.getAddressNo(),
				addressDto.getAddressId(),addressDto.getAddressPost(), 
				addressDto.getAddressNormal(),addressDto.getAddressDetail(),
				addressDto.getAddressName(),addressDto.getAddressPhone()
		};
		jdbcTemplate.update(sql,data);
	}

	@Override
	public List<AddressDto> selectAddressList(String addressId) {
		String sql = "select * from address where address_id=? "
				+ "order by address_no asc";
		Object[] data = {addressId};
		return jdbcTemplate.query(sql, addressMapper, data);
	}

	@Override
	public int sequence() {
		String sql = "select address_seq.nextval from dual ";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	@Override
	public AddressDto selectOne(String memberId) {
		String sql = "select * from address where address_id =?";
		Object[] data = { memberId };
		List< AddressDto> list = jdbcTemplate.query(sql, addressMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}

	@Override
	public boolean delete(int addressNo) {
		String sql = "delete from address where address_no = ?";
		Object[] data = { addressNo };
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	@Override
	public boolean edit(AddressDto addressDto) {
		String sql = "update address set address_post=?, address_normal=?, "
				+ "address_detail =? where address_no = ?";
		Object[] data = { addressDto.getAddressPost(), addressDto.getAddressNormal(),
				addressDto.getAddressDetail(), addressDto.getAddressNo()};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
}
