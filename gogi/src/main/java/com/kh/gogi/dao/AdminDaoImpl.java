package com.kh.gogi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.gogi.dto.MemberBlockDto;
import com.kh.gogi.dto.MemberDto;
import com.kh.gogi.dto.MemberListDto;
import com.kh.gogi.mapper.AdminListMapper;
import com.kh.gogi.mapper.MemberBlockMapper;
import com.kh.gogi.mapper.MemberListMapper;
import com.kh.gogi.vo.ShopAfterVO;




@Repository
public class AdminDaoImpl implements  AdminDao {
	
@Autowired
JdbcTemplate tem;
@Autowired
AdminListMapper adminListMapper;
@Autowired
MemberListMapper memberListMapper;
@Autowired
MemberBlockMapper memberBlockMapper;
@Override
public List<MemberDto> adminList() {
	String sql = "select * from member order by member_id asc";

	return tem.query(sql, adminListMapper);
}

@Override
public MemberDto detail(String memberId) {
	String sql = "select * from member where member_id =?";
	Object[] ob = {memberId};
   List<MemberDto>list = tem.query(sql,adminListMapper,ob);
 return list.isEmpty() ? null: list.get(0);
}

@Override 
public List<MemberDto> selectList(String type,String keyword) {
	String sql= "select * from member where instr("+type+", ?) > 0" 
			+ " order by member_id asc";

	Object[] ob = { keyword };
	List<MemberDto> list = tem.query(sql, adminListMapper, ob);
	return list;
}

@Override
public int countList(ShopAfterVO vo) {
	if(vo.isSearch()) {
		String sql = "select count(*) from member "
						+ "where instr("+vo.getType()+", ?) > 0";
		Object[] ob = {vo.getKeyword()};
		return tem.queryForObject(sql, int.class, ob);
	}
	else {
		String sql = "select count(*) from member";
		return tem.queryForObject(sql, int.class);
	}
}

public List<MemberDto> selectListByPage(ShopAfterVO vo) {
	if(vo.isSearch()) {
		String sql = "select * from ("
							+ "select rownum rn, TMP.* from ("
								+ "select * from member "
								+ "where instr("+vo.getType()+", ?) > 0 "
//								+ "where member_level !='관리자' "
//								+ "order by member_id asc";
								+ "order by "+vo.getType()+" asc"
							+ ")TMP"
						+ ") where rn between ? and ?";
		Object[] data = {vo.getKeyword(), vo.getStartRow(), vo.getFinishRow()};
		return tem.query(sql, adminListMapper, data);
	}
	else {
		String sql = "select * from ("
							+ "select rownum rn, TMP.* from ("
								+ "select * from member "
//								+ "where member_level !='관리자' "
								+ "order by member_id asc"
							+ ")TMP"
						+ ") where rn between ? and ?";
		Object[] data = {vo.getStartRow(), vo.getFinishRow()};
		return tem.query(sql, adminListMapper, data);
	}
}

@Override
public List<MemberListDto> selectListByPage2(ShopAfterVO vo) {
	if(vo.isSearch()) {
		String sql = "select * from ("
							+ "select rownum rn, TMP.* from ("
								+ "select * from member_list "
								+ "where instr("+vo.getType()+", ?) > 0 "

								+ "order by "+vo.getType()+" asc"
							+ ")TMP"
						+ ") where rn between ? and ?";
		Object[] data = {vo.getKeyword(), vo.getStartRow(), vo.getFinishRow()};
		return tem.query(sql, memberListMapper, data);
	}
	else {
		String sql = "select * from ("
							+ "select rownum rn, TMP.* from ("
								+ "select * from member_list "
								+ "order by member_id asc"
							+ ")TMP"
						+ ") where rn between ? and ?";
		Object[] data = {vo.getStartRow(), vo.getFinishRow()};
		return tem.query(sql, memberListMapper, data);
	}
}
@Override
public void insertBlock(String memberId) {
	String sql = "insert into member_block(member_id) values(?)";
	Object[] ob = {memberId};
	tem.update(sql,ob);
}

@Override
public boolean deleteBlock(String memberId) {
String sql = "delete member_block where member_id =?";
Object[] ob = {memberId};
	return tem.update(sql,ob) >0 ;
}

@Override
public List<MemberBlockDto> selectBlockList() {
	String sql = "select * from member_block order by block_time asc";
	return tem.query(sql,memberBlockMapper);
}

@Override
public MemberBlockDto selectBlockOne(String memberId) {
	String sql = "select * from member_block where member_id =?";
	Object[] ob = {memberId};
	List<MemberBlockDto> list = tem.query(sql,memberBlockMapper,ob);
	return list.isEmpty() ? null : list.get(0);
}
}