package com.kh.gogi.dao;

import java.util.List;

import com.kh.gogi.dto.OneOnOneDto;
import com.kh.gogi.dto.QnaDto;
import com.kh.gogi.dto.ShopAfterDto;
import com.kh.gogi.vo.ShopAfterVO;

public interface OneOnOneDao {
	public int sequence();

	public void add(OneOnOneDto oneOnOneDto);

	public boolean delete(int OneOnOneNo);

	public List<OneOnOneDto> list();

	public boolean fix(OneOnOneDto oneOnOneDto);

	public OneOnOneDto detail(int OneOnOneNo);
	
	
	public int countList();

	public int countList(String type, String keyword);
	
	public Integer selectMax(String memberId);
	



	public List<OneOnOneDto> selectListByPage(String type, String keyword, int page , String oneId);

	public List<OneOnOneDto> selectListByPage(int page, String oneId);

	public List<OneOnOneDto> selectListByPage(ShopAfterVO vo , String oneId);


	public int countList(ShopAfterVO vo );
	
	
	
	public List<OneOnOneDto> selectAdminListByPage(ShopAfterVO vo);
	public List<OneOnOneDto> selectAdminListByPage(int page);
	public List<OneOnOneDto> selectAdminListByPage(String type, String keyword, int page);
	
	
}
