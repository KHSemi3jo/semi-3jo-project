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

import com.kh.gogi.dao.NoticeDao;
import com.kh.gogi.dto.NoticeDto;
import com.kh.gogi.mapper.NoticeMapper;


@Controller
@RequestMapping("/notice")
public class NoticeController {
	@Autowired 
	NoticeMapper noticeMapper;
	@Autowired
	NoticeDao noticeDao;

	@RequestMapping("/list")
	private String list(Model model) {
		List<NoticeDto>list = noticeDao.list();
		model.addAttribute("list",list);
		return "/WEB-INF/views/notice/list.jsp";
	}
	
	@GetMapping("/add")
	private String add() {
		return "/WEB-INF/views/notice/add.jsp";
	}
	@PostMapping("/add")
	private String add(@ModelAttribute NoticeDto noticeDto,
			HttpSession sesstion) {
		int noticeNo = noticeDao.sequence();
		noticeDto.setNoticeNo(noticeNo);
		noticeDao.add(noticeDto);
		return "redirect:detail?noticeNo="+noticeNo;
	}
	
	@RequestMapping("/detail")
	private String detail(@RequestParam int noticeNo, Model model) {
		NoticeDto noticeDto = noticeDao.detail(noticeNo);
		model.addAttribute("noticeDto", noticeDto);
		return "/WEB-INF/views/notice/detail.jsp";
	}
	
	@GetMapping("/fix")
	private String fix(@RequestParam int noticeNo,
			Model model) {
		NoticeDto noticeDto = noticeDao.detail(noticeNo);
		model.addAttribute("noticeDto",noticeDto);
		return "/WEB-INF/views/notice/fix.jsp";
	}
	
	@PostMapping("/fix")
	private String fix(@ModelAttribute NoticeDto noticeDto) {
		boolean result = noticeDao.fix(noticeDto);
		if(result) {
			return "redirect : detail?noticeNo=?"+noticeDto.getNoticeNo();
		}
		else {
			 return "redirect:error";
		}
	}
	@RequestMapping("/delete")
	private String delete(
			@RequestParam int noticeNo) {

		noticeDao.delete(noticeNo);
		return "redirect:list";
	}
}
