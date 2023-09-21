package com.kh.gogi.dao;

import java.util.List;

import com.kh.gogi.dto.MemberBlockDto;
import com.kh.gogi.dto.MemberDto;
import com.kh.gogi.dto.MemberListDto;
import com.kh.gogi.vo.ShopAfterVO;




public interface AdminDao {
	public List<MemberDto> adminList();
	public MemberDto detail(String memberId);
	public List<MemberDto> selectList(String type,String keyword);
	int countList(ShopAfterVO vo);
	List<MemberDto>selectListByPage(ShopAfterVO vo);
	List<MemberListDto>selectListByPage2(ShopAfterVO vo);
	
	// 차단+해제 기능
		void insertBlock(String memberId);
		boolean deleteBlock(String memberId);
		List<MemberBlockDto>selectBlockList();
		MemberBlockDto selectBlockOne(String memberId);
}
