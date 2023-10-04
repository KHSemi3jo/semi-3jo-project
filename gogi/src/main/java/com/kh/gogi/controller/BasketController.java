package com.kh.gogi.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.gogi.dao.AddressDao;
import com.kh.gogi.dao.BasketDao;
import com.kh.gogi.dto.AddressDto;
import com.kh.gogi.dto.BasketListDto;



@Controller
@RequestMapping("/basket")
public class BasketController {
	@Autowired
	private BasketDao basketDao;
	@Autowired
	private AddressDao addressDao;
	

	@RequestMapping("/list")
	public String list(Model model		
//						,@RequestParam int basketNo
						,HttpSession session
						) {
		
		String basketMember = (String) session.getAttribute("name");
		
		AddressDto addressDto = addressDao.selectOne(basketMember);
		model.addAttribute("addressDto",addressDto);
		
	
		
		List<AddressDto> list = addressDao.selectAddressList(basketMember);
		model.addAttribute("list", list);
		

	    if (basketMember != null) {
	        List<BasketListDto> basketList = basketDao.selectList(basketMember);
	        model.addAttribute("basketList", basketList);
	        return "/WEB-INF/views/basket/basketList2.jsp";
	    } 
	    else {//비회원이면 로그인 필요 요청
	        return "redirect:/member/login";
	    }
			
	
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
