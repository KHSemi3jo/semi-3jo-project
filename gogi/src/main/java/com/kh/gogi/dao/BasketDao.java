package com.kh.gogi.dao;

import java.util.List;

import com.kh.gogi.dto.BasketDto;
import com.kh.gogi.dto.BasketListDto;

public interface BasketDao {
	int sequence();
	void add(BasketDto basketDto);
	boolean delete(int basketListNo);
	List<BasketListDto> selectList();
}