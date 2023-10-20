package com.kh.gogi.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.gogi.dao.AttachDao;
import com.kh.gogi.dao.ProductDao;
import com.kh.gogi.dto.ProductDto;
import com.kh.gogi.vo.ProductVO;

@Controller
public class HomeController {
	
	@Autowired
	private ProductDao productDao;
	
	@Autowired
	private AttachDao attachDao;
		
//	@RequestMapping("/main")
//	public String home(){
//		return "/WEB-INF/views/home.jsp";
//	}
	
	
	//상품 목록 페이지
			@RequestMapping("/")
			public String listMain(Model model,
									@ModelAttribute(name = "vo") ProductVO vo,
									HttpSession session) {
				int count=productDao.countList(vo);
				vo.setCount(count);
				
				List<ProductDto>list = productDao.selectListBypage(vo);
				model.addAttribute("list",list);
				session.removeAttribute("productNo");
				return"/WEB-INF/views/home.jsp";
			}
	
}
