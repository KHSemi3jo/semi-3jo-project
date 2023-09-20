package com.kh.gogi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.gogi.dto.ReplyDto;

@Component
public class ReplyMapper implements RowMapper<ReplyDto> {

	@Override
	public ReplyDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		ReplyDto replyDto = new ReplyDto();
		replyDto.setReplyWriter(rs.getString("reply_writer"));
		replyDto.setReplyTime(rs.getDate("reply_time"));
		replyDto.setReplyContent(rs.getString("reply_content"));
		replyDto.setReplyNo(rs.getInt("reply_no"));
		replyDto.setReplyOrigin(rs.getInt("reply_origin"));
		return replyDto;
	}

}
