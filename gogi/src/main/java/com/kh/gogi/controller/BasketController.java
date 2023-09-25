package com.kh.gogi.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.gogi.dao.BasketDao;
import com.kh.gogi.dto.BasketListDto;



@Controller
@RequestMapping("/basket")
public class BasketController {	
	@Autowired
	private BasketDao basketDao;
	
	@RequestMapping("/list")
	public String list(Model model) {
		List<BasketListDto> basketList = basketDao.selectList();
		model.addAttribute("basketList", basketList);
		
		return "/WEB-INF/views/basket/basketList.jsp";
	}
	
	@PostMapping("/delete")
	public String delete(
			@RequestParam List<Integer> basketNoList) {
		for(int basketNo : basketNoList) {
			basketDao.delete(basketNo);
		}
		return "redirect:list";
	}
	
	
}
