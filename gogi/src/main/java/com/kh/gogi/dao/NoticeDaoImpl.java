package com.kh.gogi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import com.kh.gogi.dto.NoticeDto;
import com.kh.gogi.dto.ShopAfterDto;
import com.kh.gogi.mapper.NoticeMapper;
import com.kh.gogi.vo.ShopAfterVO;

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
	
	
	
	


	@Override
	public int countList() {
		String sql = "select count(*) from notice";
		return tem.queryForObject(sql, int.class);
	}

	@Override
	public int countList(String type, String keyword) {
		String sql = "select count(*) from notice where instr(" + type + ", ?) > 0";
		Object[] ob = { keyword };
		return tem.queryForObject(sql, int.class, ob);
	}


	@Override
	public List<NoticeDto> selectListByPage(String type, String keyword, int page) {
		int begin = page * 10 - 9;
		int end = page * 10;

		String sql =	" SELECT * "
			     +"FROM (SELECT *  FROM notice"
			    	     +" where instr(" + type + ", ?) > 0 "
			    	          +" ORDER BY notice_no DESC)"
			    	    +" WHERE ROWNUM between ? and ?";	
		
		Object[] ob = { keyword, begin, end };
		return tem.query(sql, noticeMapper, ob);
	}

	@Override
	public List<NoticeDto> selectListByPage(int page) {
	
		String sql = "select * from ("
				+ "select rownum rn, TMP.* from("
				+ "select * from notice order by notice_no desc"
				+ ")TMP"
				+ ") where rn between ? and ?";
		Object[] ob = { page * 10 - 9, page * 10 };
		return tem.query(sql,noticeMapper , ob);

	}

	@Override
	public List<NoticeDto> selectListByPage(ShopAfterVO vo) {
		if (vo.isSearch()) {
			return selectListByPage(vo.getType(), vo.getKeyword(), vo.getPage());

		} else {
			return selectListByPage(vo.getPage());
		}
	}

	@Override
	public int countList(ShopAfterVO vo) {
		if (vo.isSearch()) {
			String sql = "select count(*) from notice where instr(" + vo.getType() + ", ?) > 0";
			Object[] ob = { vo.getKeyword() };
			return tem.queryForObject(sql, int.class, ob);
		} else {
			String sql = "select count(*) from notice";
			return tem.queryForObject(sql, int.class);
		}
	}
}
