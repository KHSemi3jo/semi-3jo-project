package com.kh.gogi.dao;

import java.util.List;

import com.kh.gogi.dto.ShopAfterDto;

public interface ShopAfterDao {

	public int sequence();

	public void add(ShopAfterDto shopAfterDto);

	public boolean delete(int shopAfterNo);

	public List<ShopAfterDto> list();

	public boolean fix(ShopAfterDto shopAfterDto);

	public ShopAfterDto detail(int shopAfterNo);

}
