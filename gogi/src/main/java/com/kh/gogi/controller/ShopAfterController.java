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

import com.kh.gogi.dao.ShopAfterDao;
import com.kh.gogi.dto.ShopAfterDto;
import com.kh.gogi.mapper.ShopAfterMapper;


@Controller
@RequestMapping("/shopafter")
public class ShopAfterController {
	@Autowired 
	ShopAfterMapper shopAfterMapper;
	@Autowired
	ShopAfterDao shopAfterDao;

	@RequestMapping("/list")
	private String list(Model model) {
		List<ShopAfterDto>list = shopAfterDao.list();
		model.addAttribute("list",list);
		return "/WEB-INF/views/shopafter/list.jsp";
	}
	
	@GetMapping("/add")
	private String add() {
		return "/WEB-INF/views/shopafter/add.jsp";
	}
	@PostMapping("/add")
	private String add(@ModelAttribute ShopAfterDto shopAfterDto,
			HttpSession sesstion) {
		int shopAfterNo = shopAfterDao.sequence();
		shopAfterDto.setShopAfterNo(shopAfterNo);
		shopAfterDao.add(shopAfterDto);
		return "redirect:detail?shopAfterNo="+shopAfterNo;
	}
	
	@RequestMapping("/detail")
	private String detail(@RequestParam int shopAfterNo, Model model) {
		ShopAfterDto shopAfterDto = shopAfterDao.detail(shopAfterNo);
		model.addAttribute("shopAfterDto", shopAfterDto);
		return "/WEB-INF/views/shopafter/detail.jsp";
	}
	
	@GetMapping("/fix")
	private String fix(@RequestParam int shopAfterNo,
			Model model) {
		ShopAfterDto shopAfterDto = shopAfterDao.detail(shopAfterNo);
		model.addAttribute("shopAfterDto",shopAfterDto);
		return "/WEB-INF/views/shopafter/fix.jsp";
	}
	
	@PostMapping("/fix")
	private String fix(@ModelAttribute ShopAfterDto shopAfterDto) {
		boolean result = shopAfterDao.fix(shopAfterDto);
		if(result) {
			return "redirect : detail?shopAfterNo=?"+shopAfterDto.getShopAfterNo();
		}
		else {
			 return "redirect:error";
		}
	}
	@RequestMapping("/delete")
	private String delete(
			@RequestParam int shopAfterNo) {

		shopAfterDao.delete(shopAfterNo);
		return "redirect:list";
	}
}
