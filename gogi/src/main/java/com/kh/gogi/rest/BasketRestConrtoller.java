package com.kh.gogi.rest;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
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
	public ResponseEntity<Map<String, Object>> add(@RequestParam int productNo, HttpSession session) {
		Map<String, Object> response = new HashMap<>();
		
		ProductDto productDto = productDao.selectOne(productNo);
        if (productDto == null) {
            response.put("success", false);
            response.put("message", "상품이 존재하지 않습니다.");
            return ResponseEntity.badRequest().body(response);
        }

        String memberId = (String) session.getAttribute("name");
        boolean isInBasket = basketDao.isInBasket(memberId, productDto.getProductNo());

        if (!isInBasket) {
            int basketNo = basketDao.sequence();
            BasketDto basketDto = new BasketDto();
            basketDto.setBasketNo(basketNo);
            basketDto.setBasketListNo(productDto.getProductNo());
            basketDto.setBasketMember(memberId);
            basketDto.setBasketCount(1);
            basketDao.add(basketDto);

            response.put("success", true);
            response.put("message", "상품이 장바구니에 추가되었습니다");
            return ResponseEntity.ok(response);
        } else {
            response.put("success", false);
            response.put("message", "이미 장바구니에 있는 상품입니다");
            return ResponseEntity.badRequest().body(response);
        }
		
//		BasketListDto basketListDto = basketDao.selectOne(basketNo);
//		if (장바구니에 있으면) return;//이미 담겨 있는 상품이면 중지
		
	}

//	@PostMapping("/selectPrice")
//	public void selectPrice() {
//
//
//	}

}
