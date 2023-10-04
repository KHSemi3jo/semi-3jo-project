package com.kh.gogi.dao;

import java.util.List;

import com.kh.gogi.dto.AttachDto;
import com.kh.gogi.dto.BasketDto;
import com.kh.gogi.dto.BasketListDto;

public interface BasketDao {
	
	int sequence();
	void add(BasketDto basketDto);
	boolean delete(int basketNo);
	List<BasketListDto> selectList(String basketMember);
	boolean isInBasket(String basketMember, int productNo);
	
	AttachDto findImage(int productNo);
	

}