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

	public boolean updateShopAfterReplyCount(int shopAfterNo);

	public int countList();

	public int countList(String type, String keyword);

	public List<ShopAfterDto> search(String type, String keyword);
	
	public List<ShopAfterDto> selectListByPage(String type, String keyword, int page);
	public List<ShopAfterDto> selectListByPage(int page);
}
