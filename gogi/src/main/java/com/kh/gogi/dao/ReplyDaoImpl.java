package com.kh.gogi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.gogi.dto.ReplyDto;
import com.kh.gogi.dto.ShopAfterDto;
import com.kh.gogi.mapper.ReplyMapper;
import com.kh.gogi.vo.ShopAfterVO;

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
	public void add(ReplyDto replyDto) {
		String sql = "insert into reply(reply_no, reply_writer, reply_content, reply_origin) "
				+ "values(?, ?, ?, ?)";
		Object[] data = { replyDto.getReplyNo(), replyDto.getReplyWriter(), replyDto.getReplyContent(),
				replyDto.getReplyOrigin()};
		tem.update(sql, data);

	}

	@Override
	public List<ReplyDto> selectList(int replyOrigin) {
		String sql = "select * from reply where reply_origin = ? order by reply_no asc";
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
		String sql = "delete  from reply where reply_no = ?";
		Object[] data = { replyNo };
		return tem.update(sql, data) > 0;
	}

	@Override
	public boolean edit(ReplyDto replyDto) {
		String sql = "update reply set reply_content=? where reply_no = ?";
		Object[] data = { replyDto.getReplyContent(), replyDto.getReplyNo() };
		return tem.update(sql, data) > 0;
	}

	@Override
	public List<ReplyDto> selectListByPage(String type, String keyword, int page) {
		int begin = page * 10 - 9;
		int end = page * 10;
		String sql =	" SELECT * "
			     +"FROM (SELECT *  FROM reply"
			    	     +" where instr(" + type + ", ?) > 0 "
			    	          +" ORDER BY reply_no DESC)"
			    	    +" WHERE ROWNUM between ? and ?";
			
		Object[] ob = { keyword, begin, end };
		return tem.query(sql, replyMapper, ob);
	}


	@Override
	public List<ReplyDto> selectListByPage(int page, int replyOrigin) {
		String sql = "select * from ("
				+ "select rownum rn, TMP.* from("
				+ "select * from reply where reply_origin = ? order by reply_no desc"
				+ ")TMP"
				+ ") where rn between ? and ?";
		Object[] ob = {replyOrigin ,page * 10 - 9, page * 10 };
		return tem.query(sql,replyMapper , ob);

	}

	@Override
	public List<ReplyDto> selectListByPage(ShopAfterVO vo,int replyOrigin) {
		if (vo.isSearch()) {
			return selectListByPage(vo.getType(), vo.getKeyword(), vo.getPage());

		} else {
			return selectListByPage(vo.getPage() ,replyOrigin);
		}
	}

	@Override
	public int countList(ShopAfterVO vo) {
		if (vo.isSearch()) {
			String sql = "select count(*) from reply where instr(" + vo.getType() + ", ?) > 0";
			Object[] ob = { vo.getKeyword() };
			return tem.queryForObject(sql, int.class, ob);
		} else {
			String sql = "select count(*) from reply";
			return tem.queryForObject(sql, int.class);
		}
	}

}
