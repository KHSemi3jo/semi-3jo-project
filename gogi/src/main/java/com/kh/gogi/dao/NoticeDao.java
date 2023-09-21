package com.kh.gogi.dao;

import java.util.List;

import com.kh.gogi.dto.NoticeDto;
import com.kh.gogi.dto.ShopAfterDto;
import com.kh.gogi.vo.ShopAfterVO;

public interface NoticeDao {

	public int sequence();

	public void add(NoticeDto noticeDto);

	public boolean delete(int noticeNo);

	public List<NoticeDto> list();

	public boolean fix(NoticeDto noticeDto);

	public NoticeDto detail(int noticeNo);
	
	
	

	public int countList();

	public int countList(String type, String keyword);
	



	public List<NoticeDto> selectListByPage(String type, String keyword, int page);

	public List<NoticeDto> selectListByPage(int page);

	public List<NoticeDto> selectListByPage(ShopAfterVO vo);


	public int countList(ShopAfterVO vo);

}
