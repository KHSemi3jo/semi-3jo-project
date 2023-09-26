package com.kh.gogi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.gogi.dto.OneOnOneDto;
import com.kh.gogi.dto.ShopAfterDto;
import com.kh.gogi.mapper.OneOnOneMapper;
import com.kh.gogi.vo.ShopAfterVO;



@Repository
public class OneOnOneDaoImpl implements OneOnOneDao {

	@Autowired
	OneOnOneMapper oneOnOneMapper;
	@Autowired
	JdbcTemplate tem;
	
	@Override
	public int sequence() {
		String sql = "select OneOnOne_seq.nextval from dual ";
		return tem.queryForObject(sql, int.class);
	}

	@Override
	public void add(OneOnOneDto oneOnOneDto) {
		String sql = "insert into OneOnOne(one_no,one_id, one_level, one_category"
				+ ",one_title ,one_content,one_group, one_parent, one_depth) "
				+ "values(?,?,?,?,?,?,?,?,?)";
		Object[] data = {oneOnOneDto.getOneNo(),oneOnOneDto.getOneId(), 
				oneOnOneDto.getOneLevel(),oneOnOneDto.getOneCategory(),
				oneOnOneDto.getOneTitle(),oneOnOneDto.getOneContent(),
				oneOnOneDto.getOneGroup(), oneOnOneDto.getOneParent()
				,oneOnOneDto.getOneDepth()};
	tem.update(sql, data);
	}

	@Override
	public boolean delete(int OneOnOneNo) {
		String sql ="delete from OneOnOne where one_no =?";
		Object[] data = {OneOnOneNo};
		return tem.update(sql, data)>0;
	}

//	@Override
//	public List<OneOnOneDto> list(String memberId) {
//		String sql ="select * from OneOnOne where one_id =?   order by one_no desc";
//		return tem.query(sql, oneOnOneMapper);
//	}
	@Override
	public List<OneOnOneDto> list() {
		String sql = "SELECT * FROM OneOnOne_list connect by Prior one_no = one_parent "
				+ "start WITH one_parent is NULL order siblings by one_group desc, one_no asc";
		return tem.query(sql, oneOnOneMapper);
	}

	@Override
	public boolean fix(OneOnOneDto oneOnOneDto) {
		String sql = "update OneOnOne set one_title = ?, one_content = ?  where one_no = ?";
		Object[] data = {oneOnOneDto.getOneTitle(), 
				oneOnOneDto.getOneContent(), oneOnOneDto.getOneNo()};
		return tem.update(sql, data)>0;
	}

	@Override
	public OneOnOneDto detail(int OneOnOneNo) {
		String sql = "select * from OneOnOne where one_no = ?";
		Object[] data = {OneOnOneNo};
	 List<OneOnOneDto> list = tem.query(sql, oneOnOneMapper, data);
 		return list.isEmpty() ? null : list.get(0);
	}

	@Override
	public int countList() {
		String sql = "select count(*) from OneOnOne";
		return tem.queryForObject(sql, int.class);
	}

	@Override
	public int countList(String type, String keyword) {
		String sql = "select count(*) from OneOnOne where instr(" + type + ", ?) > 0";
		Object[] ob = { keyword };
		return tem.queryForObject(sql, int.class, ob);
	}
	@Override
	public List<OneOnOneDto> selectListByPage(String type, String keyword, int page ,String oneId) {
		int begin = page * 10 - 9;
		int end = page * 10;

//		String sql =	" SELECT * "
//			     +"FROM (SELECT *  FROM OneOnOne"
//			    	     +" where one_id = ? and instr(" + type + ", ?) > 0 "
//			    	          +" ORDER BY one_no DESC)"
//			    	    +" WHERE ROWNUM between ? and ?";	
		
		String sql=  "select * from ("
			+ "select rownum rn, TMP.* from("
			+ "select * from OneOnOne_list "
			+ "where one_id = ? or one_level = '관리자' and instr(" + type + ", ?) > 0  "
			+ "connect by Prior one_no = one_parent start WITH one_parent is NULL "
			+ "order siblings by one_group desc, one_no asc"
			+ ")TMP"
			+ ") where rn between ? and ?";
		
		
		Object[] ob = {oneId,keyword, begin, end };
		return tem.query(sql, oneOnOneMapper, ob);
	}

	@Override
	public List<OneOnOneDto> selectListByPage(int page, String oneId) {
		
		String sql = "select * from (select rownum rn, TMP.* from("
				+ "select * from OneOnOne_list  where one_id = ? or one_level = '관리자' "
				+ "connect by Prior one_no = one_parent "
				+ "start WITH one_parent is NULL "
				+ "order siblings by one_group desc, one_no asc"
				+ ")TMP) where rn between ? and ?";
		Object[] ob = {oneId, page * 10 - 9, page * 10 };
		return tem.query(sql,oneOnOneMapper , ob);

	}

	@Override
	public List<OneOnOneDto> selectListByPage(ShopAfterVO vo, String oneId) {
		if (vo.isSearch()) {
			return selectListByPage(vo.getType(), vo.getKeyword(), vo.getPage(),oneId);

		} else {
			return selectListByPage(vo.getPage(),oneId);
		}
	}
	
	

	@Override
	public int countList(ShopAfterVO vo) {
		if (vo.isSearch()) {
			String sql = "select count(*) from OneOnOne where instr(" + vo.getType() + ", ?) > 0";
			Object[] ob = { vo.getKeyword() };
			return tem.queryForObject(sql, int.class, ob);
		} else {
			String sql = "select count(*) from OneOnOne";
			return tem.queryForObject(sql, int.class);
		}
	}

	@Override
	public Integer selectMax(String memberId) {
		String sql = "select max(one_no) from OneOnOne where one_id = ?";
		Object[] ob = {memberId};
		return tem.queryForObject(sql, Integer.class, ob);
	}
	
	@Override
	public List<OneOnOneDto> selectAdminListByPage(ShopAfterVO vo) {
		if (vo.isSearch()) {
			return selectAdminListByPage(vo.getType(), vo.getKeyword(), vo.getPage());

		} else {
			return selectAdminListByPage(vo.getPage());
		}
	}
	
	@Override
	public List<OneOnOneDto> selectAdminListByPage(int page) {
		
		String sql = "select * from (select rownum rn, TMP.* from("
				+ "select * from OneOnOne_list  "
				+ "connect by Prior one_no = one_parent "
				+ "start WITH one_parent is NULL "
				+ "order siblings by one_group desc, one_no asc"
				+ ")TMP) where rn between ? and ?";
		Object[] ob = { page * 10 - 9, page * 10 };
		return tem.query(sql,oneOnOneMapper , ob);

	}
	
	
	@Override
	public List<OneOnOneDto> selectAdminListByPage(String type, String keyword, int page) {
		int begin = page * 10 - 9;
		int end = page * 10;

		
		String sql=  "select * from ("
			+ "select rownum rn, TMP.* from("
			+ "select * from OneOnOne_list "
			+ "where instr(" + type + ", ?) > 0  "
			+ "connect by Prior one_no = one_parent start WITH one_parent is NULL "
			+ "order siblings by one_group desc, one_no asc"
			+ ")TMP"
			+ ") where rn between ? and ?";
		
		
		Object[] ob = {keyword, begin, end };
		return tem.query(sql, oneOnOneMapper, ob);
	}

}

	

