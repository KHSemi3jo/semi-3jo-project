package com.kh.gogi.rest;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.gogi.dao.BasketDao;
import com.kh.gogi.dao.ProductDao;
import com.kh.gogi.dto.BasketDto;
import com.kh.gogi.dto.ProductDto;

@CrossOrigin
@RestController
@RequestMapping("/rest/basket")
public class BasketRestConrtoller {
	@Autowired
	private BasketDao basketDao;
	
	@Autowired
	private ProductDao productDao;
	
	@PostMapping("/add")
	public void add(@RequestParam int productNo, HttpSession session) {
		ProductDto productDto = productDao.selectOne(productNo);
		if(productDto == null) return;//없는 상품이면 중지
		
		int basketNo = basketDao.sequence();
		
		BasketDto basketDto = new BasketDto();
		basketDto.setBasketNo(basketNo);
		basketDto.setBasketListNo(productDto.getProductNo());
		String memberId = (String) session.getAttribute("name");
		basketDto.setBasketMember(memberId);
		basketDao.add(basketDto);
	}

}
