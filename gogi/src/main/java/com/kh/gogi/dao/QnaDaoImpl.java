package com.kh.gogi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.gogi.dto.NoticeDto;
import com.kh.gogi.dto.QnaDto;
import com.kh.gogi.mapper.QnaMapper;
import com.kh.gogi.vo.ShopAfterVO;


@Repository
public class QnaDaoImpl implements QnaDao{
	@Autowired
	QnaMapper qnaMapper;
	@Autowired
	JdbcTemplate tem;

	@Override
	public int sequence() {
		String sql = "select qna_seq.nextval from dual ";
		return tem.queryForObject(sql, int.class);
	}

	@Override
	public void add(QnaDto qnaDto) {
		String sql = "insert into qna(qna_no,"
				+ " qna_title ,qna_answer, qna_category) "
				+ "values(?,?,?,?)";
		Object[] data = {qnaDto.getQnaNo(),
				qnaDto.getQnaTitle(),qnaDto.getQnaAnswer(), qnaDto.getQnaCategory()};
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
		String sql = "update qna set qna_title = ?, qna_answer = ?, qna_category=?  where qna_no = ?";
		Object[] data = {qnaDto.getQnaTitle(), 
				qnaDto.getQnaAnswer(),qnaDto.getQnaCategory(),  qnaDto.getQnaNo()};
		return tem.update(sql, data)>0;
	}

	@Override
	public QnaDto detail(int qnaNo) {
		String sql = "select * from qna where qna_no = ?";
		Object[] data = {qnaNo};
	 List<QnaDto> list = tem.query(sql, qnaMapper, data);
 		return list.isEmpty() ? null : list.get(0);
	}

	@Override
	public int countList() {
		String sql = "select count(*) from qna";
		return tem.queryForObject(sql, int.class);
	}

	@Override
	public int countList(String type, String keyword) {
		String sql = "select count(*) from qna where instr(" + type + ", ?) > 0";
		Object[] ob = { keyword };
		return tem.queryForObject(sql, int.class, ob);
	}

	@Override
	public List<QnaDto> selectListByPage(String type, String keyword, int page) {
		int begin = page * 10 - 9;
		int end = page * 10;

		String sql =	" SELECT * "
			     +"FROM (SELECT *  FROM qna"
			    	     +" where instr(" + type + ", ?) > 0 "
			    	          +" ORDER BY qna_no DESC)"
			    	    +" WHERE ROWNUM between ? and ?";	
		
		Object[] ob = { keyword, begin, end };
		return tem.query(sql, qnaMapper, ob);
	}

	@Override
	public List<QnaDto> selectListByPage(int page) {
		String sql = "select * from ("
				+ "select rownum rn, TMP.* from("
				+ "select * from qna order by qna_no desc"
				+ ")TMP"
				+ ") where rn between ? and ?";
		Object[] ob = { page * 10 - 9, page * 10 };
		return tem.query(sql,qnaMapper , ob);

	}

	@Override
	public List<QnaDto> selectListByPage(ShopAfterVO vo) {
		if (vo.isSearch()) {
			return selectListByPage(vo.getType(), vo.getKeyword(), vo.getPage());

		} else {
			return selectListByPage(vo.getPage());
		}
	}

	@Override
	public int countList(ShopAfterVO vo) {
		if (vo.isSearch()) {
			String sql = "select count(*) from qna where instr(" + vo.getType() + ", ?) > 0";
			Object[] ob = { vo.getKeyword() };
			return tem.queryForObject(sql, int.class, ob);
		} else {
			String sql = "select count(*) from qna";
			return tem.queryForObject(sql, int.class);
		}
	} 

}
