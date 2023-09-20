package com.kh.gogi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.gogi.dto.MemberListDto;

@Component
public class MemberListMapper implements RowMapper<MemberListDto>{

	@Override
	public MemberListDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		MemberListDto memberListDto = new MemberListDto();
		memberListDto.setMemberId(rs.getString("member_id"));
		memberListDto.setMemberPw(rs.getString("member_pw"));
		memberListDto.setMemberName(rs.getString("member_name"));
		memberListDto.setMemberEmail(rs.getString("member_email"));
		memberListDto.setMemberContact(rs.getString("member_contact"));
		memberListDto.setMemberBirth(rs.getString("member_birth"));
		memberListDto.setMemberPost(rs.getString("member_post"));
		memberListDto.setMemberAddr1(rs.getString("member_addr1"));
		memberListDto.setMemberAddr2(rs.getString("member_addr2"));
		memberListDto.setMemberLevel(rs.getString("member_level"));
		memberListDto.setMemberPoint(rs.getLong("member_point"));
		memberListDto.setMemberGmoney(rs.getLong("member_gmoney"));
		memberListDto.setMemberJoin(rs.getDate("member_join"));
		memberListDto.setMemberLogin(rs.getDate("member_login"));
		memberListDto.setMemberChange(rs.getDate("member_change"));
		memberListDto.setBlock(rs.getString("block"));
		return memberListDto;

	}

}
