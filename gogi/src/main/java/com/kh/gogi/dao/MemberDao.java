package com.kh.gogi.dao;

import java.util.List;

import com.kh.gogi.dto.MemberBlockDto;
import com.kh.gogi.dto.MemberDto;
import com.kh.gogi.dto.MemberListDto;
import com.kh.gogi.vo.PaginationVO;

public interface MemberDao {
	void insert(MemberDto memberDto);
	MemberDto selectOne(String memberId);
	boolean updateMemberLogin(String memberId);
	boolean updateMemberPw(String memberId,String changePw);
	boolean updateMemberInfo(MemberDto memberDto);
	boolean updateMemberInfoByAdmin(MemberDto memberDto);
	boolean delete(String memberId);
	
	List<MemberDto> selectListByPage(PaginationVO vo);
	List<MemberListDto> selectListByPage2(PaginationVO vo);
    int countList(PaginationVO vo);
    
    //차단+해제 기능
    void insertBlock(String memberId);
    boolean deleteBlock(String memberId);
	
    List<MemberBlockDto> selectBlockList();
    MemberBlockDto selectBlockOne(String memberId);
    
	
	//포인트 추가
	boolean increaseMemberPoint(String memberId, long point);
	
	//G머니
	boolean memberGmoney(String memberId, long gmoney);
	
	MemberDto selectOneByName(String memberName);

}
