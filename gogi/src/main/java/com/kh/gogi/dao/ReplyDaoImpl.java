package com.kh.gogi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.gogi.dto.ReplyDto;
import com.kh.gogi.mapper.ReplyMapper;

@Repository
public class ReplyDaoImpl implements ReplyDao {

	@Autowired
	JdbcTemplate tem;
	@Autowired
	ReplyMapper replyMapper;

	@Override
	public int sequence() {
		String sql = "select reply_seq.nextval from dual";
		return tem.queryForObject(sql, int.class);
	}

	@Override
	public void insert(ReplyDto replyDto) {
		String sql = "insert into reply(reply_no, reply_writer, reply_content, reply_origin) " + "values(?,?,?,?)";
		Object[] data = { replyDto.getReplyNo(), replyDto.getReplyWriter(), replyDto.getReplyContent(),
				replyDto.getReplyOrigin() };
		tem.update(sql, data);

	}

	@Override
	public List<ReplyDto> selectList(int replyOrigin) {
		String sql = "select * from reply where reply_no = ? order by asc";
		Object[] data = {replyOrigin};
		return tem.query(sql,replyMapper,data);
	}

	@Override
	public ReplyDto selectOne(int replyNo) {
		String sql = "select * from reply where reply_no =?";
		Object[] data = { replyNo };
		List<ReplyDto> list = tem.query(sql, replyMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}

	@Override
	public boolean delete(int replyNo) {
		String sql = "delete * from reply where reply_no = ?";
		Object[] data = { replyNo };
		return tem.update(sql, data) > 0;
	}

	@Override
	public boolean edit(ReplyDto replyDto) {
		String sql = "update reply set reply_content=? where reply_no = ?";
		Object[] data = { replyDto.getReplyContent(), replyDto.getReplyNo() };
		return tem.update(sql, data) > 0;
	}

}
