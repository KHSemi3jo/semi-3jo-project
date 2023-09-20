package com.kh.gogi.dao;

import java.util.List;

import com.kh.gogi.dto.BasketListDto;

public interface BasketDao {
	boolean delete(int basketListNo);
	List<BasketListDto> selectList();
}
