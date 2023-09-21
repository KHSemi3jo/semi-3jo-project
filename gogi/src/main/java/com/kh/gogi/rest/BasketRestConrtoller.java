package com.kh.gogi.rest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.gogi.dao.BasketDao;
import com.kh.gogi.dto.BasketDto;

@CrossOrigin
@RestController
@RequestMapping("/rest/basket")
public class BasketRestConrtoller {
	@Autowired
	private BasketDao basketDao;
	
	@PostMapping("/add")
	public String add(@ModelAttribute BasketDto basketDto) {
		int basketNo = basketDao.sequence();
		basketDto.setBasketNo(basketNo);
		
		basketDao.add(basketDto);
		
		return "redirect:/basket/basketList";
	}

}
