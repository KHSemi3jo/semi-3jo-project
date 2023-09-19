package com.kh.gogi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.gogi.dto.AttachDto;
import com.kh.gogi.mapper.AttachMapper;

@Repository
public class AttachDaoImpl implements AttachDao {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private AttachMapper attachMapper;
	
//	시퀀스 번호 생성
	@Override
	public int sequence() {
		String sql="select attach_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
//	등록
	@Override
	public void insert(AttachDto attachDto) {
		String sql = "insert into attach( "
						+ "attach_no, attach_name, "
						+ "attach_size, attach_type) "
						+ "values(?,?,?,?";
		Object[] data = {
				attachDto.getAttachNo(),attachDto.getAttachName(),
				attachDto.getAttachSize(),attachDto.getAttachType()
		};
		jdbcTemplate.update(sql,data);
	}
	
//	삭제
	@Override
	public boolean delete(int attachNo) {
		String sql= "delete attach where attach_no=?";
		Object[] data = {attachNo};
		return jdbcTemplate.update(sql,data)>0;
	}

//	상세
	@Override
	public AttachDto selectOne(int attachNo) {
		String sql= "select * from attach where attach_no =?";
		Object[] data = {attachNo};
		List<AttachDto>list = jdbcTemplate.query(sql, attachMapper,data);
		return list.isEmpty() ? null : list.get(0);
	}
	

}
