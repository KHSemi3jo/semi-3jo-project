package com.kh.gogi.dao;

import java.util.List;

import com.kh.gogi.dto.NoticeDto;
import com.kh.gogi.dto.ShopAfterDto;

public interface NoticeDao {

	public int sequence();

	public void add(NoticeDto noticeDto);

	public boolean delete(int noticeNo);

	public List<NoticeDto> list();

	public boolean fix(NoticeDto noticeDto);

	public NoticeDto detail(int noticeNo);
}
