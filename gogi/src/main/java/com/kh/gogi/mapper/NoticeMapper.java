package com.kh.gogi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.gogi.dto.NoticeDto;

@Component
public class NoticeMapper implements RowMapper<NoticeDto>{

	@Override
	public NoticeDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		NoticeDto noticeDto = new NoticeDto();
		noticeDto.setNoticeAdmin(rs.getString("notice_admin"));
		noticeDto.setNoticeContent(rs.getString("notice_content"));
		noticeDto.setNoticeDate(rs.getDate("notice_date"));
		noticeDto.setNoticeNo(rs.getInt("notice_no"));
		noticeDto.setNoticeTitle(rs.getString("notice_title"));
		noticeDto.setNoticeWriter(rs.getString("notice_writer"));
		return noticeDto;
	}

}
