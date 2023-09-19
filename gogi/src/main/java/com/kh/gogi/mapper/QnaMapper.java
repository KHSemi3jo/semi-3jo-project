package com.kh.gogi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.gogi.dto.QnaDto;

@Component
public class QnaMapper implements RowMapper<QnaDto>{

	@Override
	public QnaDto mapRow(ResultSet rs, int rowNum) throws SQLException {
	QnaDto qnaDto = new QnaDto();
	qnaDto.setQnaAdmin(rs.getString("qna_admin"));
	qnaDto.setQnaAnswer(rs.getString("qna_answer"));
	qnaDto.setQnaCategory(rs.getString("qna_category"));
	qnaDto.setQnaNo(rs.getInt("qna_no"));
	qnaDto.setQnaTitle(rs.getString("qna_title"));
	
		return qnaDto;
	}

}
