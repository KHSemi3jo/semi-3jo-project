package com.kh.gogi.dao;

import java.util.List;

import com.kh.gogi.dto.NoticeDto;
import com.kh.gogi.dto.QnaDto;
import com.kh.gogi.vo.ShopAfterVO;


public interface QnaDao {
	public int sequence();

	public void add(QnaDto qnaDto);

	public boolean delete(int qnaNo);

	public List<QnaDto> list();

	public boolean fix(QnaDto qnaDto);

	public QnaDto detail(int qnaNo);
	
	
	public int countList();

	public int countList(String type, String keyword);
	



	public List<QnaDto> selectListByPage(String type, String keyword, int page);

	public List<QnaDto> selectListByPage(int page);

	public List<QnaDto> selectListByPage(ShopAfterVO vo);


	public int countList(ShopAfterVO vo);
	
}
