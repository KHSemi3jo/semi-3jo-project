package com.kh.gogi.rest;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
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
		
//		BasketListDto basketListDto = basketDao.selectOne(basketNo);
//		if (장바구니에 있으면) return;//이미 담겨 있는 상품이면 중지
		if(productDto == null) return;//없는 상품이면 중지

		String memberId = (String) session.getAttribute("name");
		boolean isInBasket = basketDao.isInBasket(memberId, productDto.getProductNo());
		
		if(!isInBasket) {
			int basketNo = basketDao.sequence();
			BasketDto basketDto = new BasketDto();
			basketDto.setBasketNo(basketNo);
			basketDto.setBasketListNo(productDto.getProductNo());
			basketDto.setBasketMember(memberId);
			basketDto.setBasketCount(1);
			basketDao.add(basketDto);
			
		}
		
		
	}

//	@PostMapping("/selectPrice")
//	public void selectPrice() {
//
//
//	}

}
