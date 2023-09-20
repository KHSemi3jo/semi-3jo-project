package com.kh.gogi.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {
		
	@RequestMapping("/main")
	public String home(){
		return "/WEB-INF/views/home.jsp";
	}
	
}
