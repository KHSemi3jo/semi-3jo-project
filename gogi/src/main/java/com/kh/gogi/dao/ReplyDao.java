package com.kh.gogi.dao;

import java.util.List;

import com.kh.gogi.dto.ReplyDto;

public interface ReplyDao {

	int sequence();

	public void insert(ReplyDto replyDto);

	List<ReplyDto> selectList(int replyList);

	ReplyDto selectOne(int replyNo);

	boolean delete(int replyNo);

	boolean edit(ReplyDto replyDto);
}
