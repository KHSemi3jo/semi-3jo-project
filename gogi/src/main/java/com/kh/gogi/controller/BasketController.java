package com.kh.gogi.controller;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.gogi.dao.AddressDao;
import com.kh.gogi.dao.BasketDao;
import com.kh.gogi.dao.ProductDao;
import com.kh.gogi.dto.AddressDto;
import com.kh.gogi.dto.AttachDto;
import com.kh.gogi.dto.BasketListDto;



@Controller
@RequestMapping("/basket")
public class BasketController {
	@Autowired
	private BasketDao basketDao;

	
	@Autowired
	private ProductDao productDao;
	
	@ResponseBody
	@RequestMapping("/image")
	public ResponseEntity<ByteArrayResource> image(@RequestParam int productNo) throws IOException{
		
		AttachDto attachDto = productDao.findImage(productNo);//상품번호로 파일번호 찾기
//		if(attachDto == null) {
//			return ResponseEntity.notFound().build();//파일번호가 없으면 404 반환
//		}
		String home=System.getProperty("D:/upload");
		File dir = new File(home, "kh12c");
		File target = new File(dir, String.valueOf(attachDto.getAttachNo()));
		
		
		byte[] data = FileUtils.readFileToByteArray(target);//실제 파일 불러오기
		ByteArrayResource resource = new ByteArrayResource(data);
		
		return ResponseEntity.ok()
				.header(HttpHeaders.CONTENT_ENCODING,StandardCharsets.UTF_8.name())
				.contentLength(attachDto.getAttachSize())
				.header(HttpHeaders.CONTENT_TYPE, attachDto.getAttachType())
				.header(HttpHeaders.CONTENT_DISPOSITION,
						ContentDisposition.attachment().filename(attachDto.getAttachName(),StandardCharsets.UTF_8).build().toString()
						)
				.body(resource);
	}

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
	        return "/WEB-INF/views/basket/basketList.jsp";
	    } 
	    else {//비회원이면 로그인 필요 요청
	        return "redirect:/member/login";
	    }
			
	
	}
	
	@RequestMapping("/delete")
	public String delete(
			@RequestParam List<Integer> basketNoList) {
		for(int basketNo : basketNoList) {
			basketDao.delete(basketNo);
		}
		return "redirect:list";
	}
	
	@RequestMapping("/finish")
	public String finish(
			Model model,HttpSession session
			) {
		
String basketMember = (String) session.getAttribute("name");
		
		AddressDto addressDto = addressDao.selectOne(basketMember);
		model.addAttribute("addressDto",addressDto);
		
		List<AddressDto> list = addressDao.selectAddressList(basketMember);
		model.addAttribute("list", list);
		
	    if (basketMember != null) {
	        List<BasketListDto> basketList = basketDao.selectList(basketMember);
	        model.addAttribute("basketList", basketList);
	        return "/WEB-INF/views/basket/basketFinish.jsp";
	    } 
	    else {//비회원이면 로그인 필요 요청
	        return "redirect:/member/login";
	    }
		
		
		
	}
	
	
	
	
}
