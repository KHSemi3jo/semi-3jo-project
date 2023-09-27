package com.kh.gogi.dao;

import java.util.List;

import com.kh.gogi.dto.PickDto;
import com.kh.gogi.dto.PickListDto;

public interface PickDao {
	int sequence();
	void add(PickDto pickDto);
	boolean delete(int pickNo);
	List<PickListDto> selectList(String pickMemberId);

}
