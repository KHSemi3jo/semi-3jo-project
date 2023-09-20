package com.kh.gogi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.gogi.dto.MemberDto;

@Component
public class MemberMapper implements RowMapper<MemberDto> {

	@Override
	public MemberDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		MemberDto memberDto = new MemberDto();
		memberDto.setMemberId(rs.getString("member_id"));
		memberDto.setMemberPw(rs.getString("member_pw"));
		memberDto.setMemberName(rs.getString("member_name"));
		memberDto.setMemberEmail(rs.getString("member_email"));
		memberDto.setMemberContact(rs.getString("member_contact"));
		memberDto.setMemberBirth(rs.getString("member_birth"));
		memberDto.setMemberPost(rs.getString("member_post"));
		memberDto.setMemberAddr1(rs.getString("member_addr1"));
		memberDto.setMemberAddr2(rs.getString("member_addr2"));
		memberDto.setMemberLevel(rs.getString("member_level"));

		memberDto.setMemberPoint(rs.getLong("member_point"));
		memberDto.setMemberGmoney(rs.getLong("member_gmoney"));
		memberDto.setMemberJoin(rs.getDate("member_join"));
		memberDto.setMemberLogin(rs.getDate("member_login"));

		memberDto.setMemberChange(rs.getDate("member_change"));
		return memberDto;
	}

}
