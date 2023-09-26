package com.kh.gogi.dao;

import java.util.List;

import com.kh.gogi.dto.AddressDto;

public interface AddressDao {
	public int sequence();
	void insert(AddressDto addressDto);
	List<AddressDto> selectAddressList(String memberId);
	public AddressDto selectOne(int addressNo);
	public boolean delete(int addressNo);
	public boolean edit(AddressDto addressDto);
	

}
