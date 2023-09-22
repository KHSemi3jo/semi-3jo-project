package com.kh.gogi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.gogi.dto.OneOnOneDto;



@Component
public class OneOnOneMapper implements RowMapper<OneOnOneDto> {

	@Override
	public OneOnOneDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		OneOnOneDto oneOnOneDto = new OneOnOneDto();
		oneOnOneDto.setOneCategory(rs.getString("one_category"));
		oneOnOneDto.setOneContent(rs.getString("one_content"));
		oneOnOneDto.setOneDate(rs.getDate("one_date"));
		oneOnOneDto.setOneId(rs.getString("one_id"));
		oneOnOneDto.setOneNo(rs.getInt("one_no"));
		oneOnOneDto.setOneStatus(rs.getInt("one_status"));
		oneOnOneDto.setOneTitle(rs.getString("one_title"));
		oneOnOneDto.setOneDepth(rs.getInt("one_depth"));
		oneOnOneDto.setOneGroup(rs.getInt("one_group"));
		oneOnOneDto.setOneParent(rs.getObject("one_parent",Integer.class));
		return oneOnOneDto;
	}

}
