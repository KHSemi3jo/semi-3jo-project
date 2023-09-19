package com.kh.gogi.dao;

import java.util.List;

import com.kh.gogi.dto.OneOnOneDto;
import com.kh.gogi.dto.ShopAfterDto;

public interface OneOnOneDao {
	public int sequence();

	public void add(OneOnOneDto oneOnOneDto);

	public boolean delete(int OneOnOneNo);

	public List<OneOnOneDto> list();

	public boolean fix(OneOnOneDto oneOnOneDto);

	public OneOnOneDto detail(int OneOnOneNo);
}
