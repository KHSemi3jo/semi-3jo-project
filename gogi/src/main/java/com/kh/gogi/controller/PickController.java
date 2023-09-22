package com.kh.gogi.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.gogi.dao.PickDao;
import com.kh.gogi.dto.PickListDto;

@Controller
@RequestMapping("/pick")
public class PickController {
	
	@Autowired
	private PickDao pickDao;
	
	@RequestMapping("/list")
	public String list(Model model) {
		List<PickListDto> pickList = pickDao.selectList();
		model.addAttribute("pickList", pickList);
		return "/WEB-INF/views/pick/pickList.jsp";
	}
	
	@RequestMapping("/delete")
	public String delete(@RequestParam int pickNo) {
		boolean result = pickDao.delete(pickNo);
		if(result) {
			return "redirect:list";
		}
		else {
			return "redirect:에러페이지";
		}
	}
}
