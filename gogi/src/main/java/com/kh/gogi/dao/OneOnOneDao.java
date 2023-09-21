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

	public List<OneOnOneDto> list(String memberId);

	public boolean fix(OneOnOneDto oneOnOneDto);

	public OneOnOneDto detail(int OneOnOneNo);
	
	
	public int countList();

	public int countList(String type, String keyword);
	



	public List<OneOnOneDto> selectListByPage(String type, String keyword, int page,  String memberId);

	public List<OneOnOneDto> selectListByPage(int page,  String memberId);

	public List<OneOnOneDto> selectListByPage(ShopAfterVO vo, String memberId);


	public int countList(ShopAfterVO vo );
	
	
}
