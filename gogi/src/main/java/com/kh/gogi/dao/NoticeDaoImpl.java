package com.kh.gogi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import com.kh.gogi.dto.NoticeDto;
import com.kh.gogi.dto.ShopAfterDto;
import com.kh.gogi.mapper.NoticeMapper;

@Repository
public class NoticeDaoImpl implements NoticeDao {

	@Autowired
	NoticeMapper noticeMapper;
	@Autowired
	JdbcTemplate tem;

	@Override
	public int sequence() {
		String sql = "select notice_seq.nextval from dual ";
		return tem.queryForObject(sql, int.class);
	}

	@Override
	public void add(NoticeDto noticeDto) {
		String sql = "insert into notice(notice_no," + " notice_title ,notice_content) " + "values(?,?,?)";
		Object[] data = { noticeDto.getNoticeNo(), noticeDto.getNoticeTitle(), noticeDto.getNoticeContent() };
		tem.update(sql, data);
	}

	@Override
	public boolean delete(int noticeNo) {
		String sql = "delete from notice where notice_no =?";
		Object[] data = { noticeNo };
		return tem.update(sql, data) > 0;
	}

	@Override
	public List<NoticeDto> list() {
		String sql = "select * from notice order by notice_no desc";
		return tem.query(sql, noticeMapper);
	}

	@Override
	public boolean fix(NoticeDto noticeDto) {
		String sql = "update notice set notice_title = ?, notice_content = ?  where notice_no = ?";
		Object[] data = { noticeDto.getNoticeTitle(), noticeDto.getNoticeContent(), noticeDto.getNoticeNo() };
		return tem.update(sql, data) > 0;
	}

	@Override
	public NoticeDto detail(int noticeNo) {
		String sql = "select * from notice where notice_no = ?";
		Object[] data = { noticeNo };
		List<NoticeDto> list = tem.query(sql, noticeMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
}
