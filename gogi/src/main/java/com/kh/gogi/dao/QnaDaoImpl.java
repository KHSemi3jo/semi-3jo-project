package com.kh.gogi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.gogi.dto.QnaDto;
import com.kh.gogi.mapper.QnaMapper;


@Repository
public class QnaDaoImpl implements QnaDao{
	@Autowired
	QnaMapper qnaMapper;
	@Autowired
	JdbcTemplate tem;

	@Override
	public int sequence() {
		String sql = "select shopAfter_seq.nextval from dual ";
		return tem.queryForObject(sql, int.class);
	}

	@Override
	public void add(QnaDto qnaDto) {
		String sql = "insert into qna(qna_no,"
				+ " qna_title ,qna_answer) "
				+ "values(?,?,?)";
		Object[] data = {qnaDto.getQnaNo(),
				qnaDto.getQnaTitle(),qnaDto.getQnaAnswer()};
	tem.update(sql, data);
	}

	@Override
	public boolean delete(int qnaNo) {
		String sql ="delete from qna where qna_no =?";
		Object[] data = {qnaNo};
		return tem.update(sql, data)>0;
	}

	@Override
	public List<QnaDto> list() {
		String sql ="select * from qna order by qna_no desc";
		return tem.query(sql, qnaMapper);
	}

	@Override
	public boolean fix(QnaDto qnaDto) {
		String sql = "update qna set qna_title = ?, qna_answer = ?  where qna_no = ?";
		Object[] data = {qnaDto.getQnaTitle(), 
				qnaDto.getQnaAnswer(), qnaDto.getQnaNo()};
		return tem.update(sql, data)>0;
	}

	@Override
	public QnaDto detail(int qnaNo) {
		String sql = "select * from qna where qna_no = ?";
		Object[] data = {qnaNo};
	 List<QnaDto> list = tem.query(sql, qnaMapper, data);
 		return list.isEmpty() ? null : list.get(0);
	}

}
