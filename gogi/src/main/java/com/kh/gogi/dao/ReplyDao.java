package com.kh.gogi.dao;

import java.util.List;

import com.kh.gogi.dto.ReplyDto;
import com.kh.gogi.dto.ShopAfterDto;
import com.kh.gogi.vo.ShopAfterVO;

public interface ReplyDao {

	int sequence();

	public void add(ReplyDto replyDto);

	public List<ReplyDto> selectList(int replyOrigin);

	ReplyDto selectOne(int replyNo);

	boolean delete(int replyNo);

	boolean edit(ReplyDto replyDto);
	
	
	public List<ReplyDto> selectListByPage(String type, String keyword, int page);

	public List<ReplyDto> selectListByPage(int page, int replyOrigin);

	public List<ReplyDto> selectListByPage(ShopAfterVO vo,int replyOrigin);
	
	public int countList(ShopAfterVO vo);
}
