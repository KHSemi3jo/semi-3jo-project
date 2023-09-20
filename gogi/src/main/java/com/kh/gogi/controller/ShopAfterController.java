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
import com.kh.gogi.dao.ShopAfterDao;
import com.kh.gogi.dto.MemberDto;
import com.kh.gogi.dto.OneOnOneDto;
import com.kh.gogi.dto.ShopAfterDto;
import com.kh.gogi.mapper.ShopAfterMapper;

@Controller
@RequestMapping("/shopafter")
public class ShopAfterController {
	@Autowired
	ShopAfterMapper shopAfterMapper;
	@Autowired
	ShopAfterDao shopAfterDao;
	@Autowired
	MemberDao memberDao;



	@GetMapping("/add")
	private String add() {
		return "/WEB-INF/views/shopafter/add.jsp";
	}

	@PostMapping("/add")
	private String add(@ModelAttribute ShopAfterDto shopAfterDto, HttpSession sesstion) {
		int shopAfterNo = shopAfterDao.sequence();
		shopAfterDto.setShopAfterNo(shopAfterNo);
		shopAfterDao.add(shopAfterDto);
		return "redirect:detail?shopAfterNo=" + shopAfterNo;
	}

	@RequestMapping("list")
	public String detail(@RequestParam int shopAfterNo, Model model, HttpSession session,
			ShopAfterDto shopAfterDto,	@RequestParam(required = false) String type,
			@RequestParam(required = false) String keyword,
			@RequestParam(required = false, defaultValue = "1") int page) {
		
				boolean isSearch = type != null && keyword != null;
		
				int begin = (page - 1) / 10 * 10 + 1;
				int end = begin + 9;
				int count = isSearch ? shopAfterDao.countList(type, keyword) : shopAfterDao.countList();
				int pageCount = (count - 1) / 10 + 1;
				model.addAttribute("page", page);
				model.addAttribute("begin", begin);
				
		
				model.addAttribute("end", Math.min(pageCount, end));
				model.addAttribute("pageCount", pageCount);
				if (isSearch) { // 검색일 경우
					 List<ShopAfterDto> list = shopAfterDao.search(type, keyword);
					// List<ShopAfterDto> list = shopAfterDao.selectListByPage(type, keyword, page);
					model.addAttribute("list", list);
					model.addAttribute("isSearch", true);
				} else { // 목록일 경우
							
					List<ShopAfterDto> list = shopAfterDao.selectListByPage(page);
					// model.addAttribute("list", list);//둘다 같다
					model.addAttribute("list", shopAfterDao.selectListByPage(page));// 검색기능 대비 변수줄이자!
					model.addAttribute("isSearch", false);
				}
				return "/WEB-INF/views/shopafter/list.jsp";
			}

	@RequestMapping("/detail")
	private String detail(@RequestParam int shopAfterNo, Model model) {
		ShopAfterDto  shopAfterDto = shopAfterDao.detail(shopAfterNo);
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
			return "redirect:detail?shopAfterNo="+shopAfterDto.getShopAfterNo();
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
