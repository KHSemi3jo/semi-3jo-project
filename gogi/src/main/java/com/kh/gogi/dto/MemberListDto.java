package com.kh.gogi.dto;

import java.sql.Date;

import org.springframework.stereotype.Component;

import lombok.Data;

@Data
@Component
public class MemberListDto {
	private String memberId,memberPw,memberNickname;
	private String memberEmail, memberContact;
	private String memberBirth;
	private String memberPost, memberAddr1, memberAddr2;
	private String memberLevel;
	private int memberPoint;
	private Date memberJoin, memberLogin, memberChange;
	
	private String block;//차단 여부 확인

}
