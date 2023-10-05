package com.kh.gogi.dao;

import java.util.List;

import com.kh.gogi.dto.ShopAfterDto;
import com.kh.gogi.vo.ShopAfterVO;


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
	
	public List<ShopAfterDto> selectList(String type,String keyword);


	public List<ShopAfterDto> selectListByPage(String type, String keyword, int page);

	public List<ShopAfterDto> selectListByPage(int page);

	public List<ShopAfterDto> selectListByPage(ShopAfterVO vo);


	public int countList(ShopAfterVO vo);
	
	
	public List<ShopAfterDto> selectProductListByPage(String type, 
			String keyword, int page , int productNo);

	public List<ShopAfterDto> selectProductListByPage(int page, int productNo);

	public List<ShopAfterDto> selectProductListByPage(ShopAfterVO vo, int productNo);
	public int countProductList(ShopAfterVO vo,int productNo);
	
	
	public int countMemberList(ShopAfterVO vo,String memberId);
	
	public List<ShopAfterDto> selectMemberListByPage(int page, String memberId);

	public List<ShopAfterDto> selectMemberListByPage(ShopAfterVO vo, String memberId);
	public List<ShopAfterDto> selectMemberListByPage(String type, 
			String keyword, int page , String memberId);

}
