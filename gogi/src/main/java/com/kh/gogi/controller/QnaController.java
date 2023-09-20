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

import com.kh.gogi.dao.QnaDao;
import com.kh.gogi.dto.QnaDto;
import com.kh.gogi.mapper.QnaMapper;


@Controller
@RequestMapping("/qna")
public class QnaController {
	@Autowired 
	QnaMapper qnaMapper;
	@Autowired
	QnaDao qnaDao;

	@RequestMapping("/list")
	private String list(Model model) {
		List<QnaDto>list = qnaDao.list();
		model.addAttribute("list",list);
		return "/WEB-INF/views/qna/list.jsp";
	}
	
	@GetMapping("/add")
	private String add() {
		return "/WEB-INF/views/qna/add.jsp";
	}
	@PostMapping("/add")
	private String add(@ModelAttribute QnaDto qnaDto,
			HttpSession sesstion) {
		int qnaNo = qnaDao.sequence();
		qnaDto.setQnaNo(qnaNo);
		qnaDao.add(qnaDto);
		return "redirect:detail?qnaNo="+qnaNo;
	}
	
	@RequestMapping("/detail")
	private String detail(@RequestParam int qnaNo, Model model) {
		QnaDto qnaDto = qnaDao.detail(qnaNo);
		model.addAttribute("qnaDto", qnaDto);
		return "/WEB-INF/views/qna/detail.jsp";
	}
	
	@GetMapping("/fix")
	private String fix(@RequestParam int qnaNo,
			Model model) {
		QnaDto qnaDto = qnaDao.detail(qnaNo);
		model.addAttribute("qnaDto",qnaDto);
		return "/WEB-INF/views/qna/fix.jsp";
	}
	
	@PostMapping("/fix")
	private String fix(@ModelAttribute QnaDto qnaDto) {
		boolean result = qnaDao.fix(qnaDto);
		if(result) {
			return "redirect:detail?qnaNo="+qnaDto.getQnaNo();
		}
		else {
			 return "redirect:error";
		}
	}
	@RequestMapping("/delete")
	private String delete(
			@RequestParam int qnaNo) {

		qnaDao.delete(qnaNo);
		return "redirect:list";
	}
}


