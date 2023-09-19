package com.kh.gogi.dao;

import com.kh.gogi.dto.AttachDto;

public interface AttachDao {
	int sequence();
	void insert(AttachDto attachDto);
	boolean delete(int attachNo);
	AttachDto selectOne(int attachNo);

}
