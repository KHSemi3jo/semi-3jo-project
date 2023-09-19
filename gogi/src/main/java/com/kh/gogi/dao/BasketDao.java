package com.kh.gogi.dao;

import java.util.List;

import com.kh.gogi.dto.BasketDto;

public interface BasketDao {
	void insert(BasketDto basketDto);
	boolean delete(int basketListNo);
	List<BasketDto> selectList();
}
