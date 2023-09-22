package com.kh.gogi.rest;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.gogi.dao.PickDao;
import com.kh.gogi.dao.ProductDao;
import com.kh.gogi.dto.PickDto;
import com.kh.gogi.dto.ProductDto;

@CrossOrigin
@RestController
@RequestMapping("/rest/pick")
public class PickRestController {
	
	@Autowired
	private PickDao pickDao;
	
	@Autowired
	private ProductDao productDao;
	
	@PostMapping("/add")
	public void add(@RequestParam int productNo, HttpSession session) {
		ProductDto productDto = productDao.selectOne(productNo);
		if(productDto == null) return;//없는 상품이면 중지
		
		int pickNo = pickDao.sequence();
		
		PickDto pickDto = new PickDto();
		pickDto.setPickNo(pickNo);
		pickDto.setPickProdNo(productDto.getProductNo());
		String memberId = (String) session.getAttribute("name");
		pickDto.setPickMemberId(memberId);
		pickDao.add(pickDto);
	}
	
}
