package com.kh.gogi.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.gogi.dao.MemberDao;
import com.kh.gogi.dto.MemberDto;
import com.kh.gogi.dto.MemberListDto;
import com.kh.gogi.error.NoTargetException;
import com.kh.gogi.vo.PaginationVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	private MemberDao memberDao; 
	
//	@Autowired
//	private BoardDao boardDao;

	
	@RequestMapping("/home")
	public String home() {
		return "/WEB-INF/views/admin/home.jsp";
	}
	
	@RequestMapping("/member/list")
	public String memberList(@ModelAttribute PaginationVO vo, Model model) {
		int count = memberDao.countList(vo); //상황에 맞는 게시글 수;
				vo.setCount(count);
		model.addAttribute("vo", vo);
		
//		List<MemberDto> list = memberDao.selectListByPage(vo); //상황에 맞는 목록데이터;
		List<MemberListDto> list = memberDao.selectListByPage2(vo);
		model.addAttribute("list",list);
		return "/WEB-INF/views/admin/member/list.jsp";
	}

	@GetMapping("/member/edit")
	public String edit(HttpSession session, Model model) {
		String memberId = (String) session.getAttribute("name");
		MemberDto memberDto = memberDao.selectOne(memberId);
		model.addAttribute("memberDto", memberDto);
        return "/WEB-INF/views/admin/member/edit.jsp";
	}
	@PostMapping("/member/edit")
	public String edit(@ModelAttribute MemberDto memberDto) {
		boolean result = memberDao.updateMemberInfoByAdmin(memberDto);
		if(result) {
			return "redirect:list"; //상대경로
			//return "redirect:/admin/member/list"; //절대경로
		}
		else {
			throw new NoTargetException("존재하지 않는 회원 ID");
		}
	}
	@RequestMapping("/member/detail")
	public String memberDetail(@RequestParam String memberId, Model model) {
		//파라미터로 전달된 아이디의 회원정보를 조회하여 모델에 첨부
		MemberDto memberDto = memberDao.selectOne(memberId);
		model.addAttribute("memberDto", memberDto);
		
//		//이 회원이 작성한 글을 조회하여 모델에 첨부
//		List<BoardListDto> boardList = boardDao.selectListByBoardWriter(memberId);
//		model.addAttribute("boardList", boardList);			
		
		return "/WEB-INF/views/admin/member/detail.jsp";
	}
	@RequestMapping("/member/block")
	public String memberBlock(@RequestParam String memberId) {
		memberDao.insertBlock(memberId);
		return "redirect:list";
	}
	@RequestMapping("/member/cancel")
	public String memberCancel(@RequestParam String memberId) {
		memberDao.deleteBlock(memberId);
		return "redirect:list";
	}
}