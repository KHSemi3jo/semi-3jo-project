package com.kh.gogi.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.gogi.dao.BasketDao;
import com.kh.gogi.dao.ProductDao;
import com.kh.gogi.dto.BasketDto;
import com.kh.gogi.dto.ProductDto;

@Controller
@RequestMapping("/basket")
public class BasketController {
	
	@Autowired
	private ProductDao productDao;
	
	@Autowired
	private BasketDao basketDao;
	
	@GetMapping("/insert")
	public String insert(Model model , @RequestParam int productNo) {
		ProductDto itemDto = productDao.selectOne(productNo);
		model.addAttribute("itemDto", itemDto);
		return "/WEB-INF/views/basket/insert.jsp";
	}
	@PostMapping("/insert")
	public String insert(@ModelAttribute BasketDto basketDto) {
		basketDao.insert(basketDto);
		return "redirect:insert";
	}
}
