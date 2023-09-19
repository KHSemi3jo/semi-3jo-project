package com.kh.gogi.dao;

import java.util.List;

import com.kh.gogi.dto.QnaDto;


public interface QnaDao {
	public int sequence();

	public void add(QnaDto qnaDto);

	public boolean delete(int qnaNo);

	public List<QnaDto> list();

	public boolean fix(QnaDto qnaDto);

	public QnaDto detail(int qnaNo);
}
