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
import com.kh.gogi.dao.OneOnOneDao;
import com.kh.gogi.dto.MemberDto;
import com.kh.gogi.dto.OneOnOneDto;
import com.kh.gogi.dto.QnaDto;
import com.kh.gogi.mapper.OneOnOneMapper;
import com.kh.gogi.vo.ShopAfterVO;

@Controller
@RequestMapping("/one")
public class OneOnOneController {
	@Autowired
	OneOnOneDao oneOnOneDao;
	@Autowired
	OneOnOneMapper oneOnOneMapper;
	@Autowired
	MemberDao memberDao;
	
	@RequestMapping("/list")
	public String list(@ModelAttribute(name = "vo") ShopAfterVO vo, Model model,
			String memberId,
			@ModelAttribute MemberDto memberDto,
			HttpSession session) {
		
		memberId = (String) session.getAttribute("name");
	//	boolean isLogin =	inputDto.getMemberId()==findDto.getMemberId();
		
		
		int count = oneOnOneDao.countList(vo);
		vo.setCount(count);

		List<OneOnOneDto> list = oneOnOneDao.selectListByPage(vo,memberId);
		model.addAttribute("list", list);
		return "/WEB-INF/views/one/list.jsp";

	}

	@GetMapping("/add")
	private String add() {
		return "/WEB-INF/views/one/add.jsp";
	}

	@PostMapping("/add")
	private String add(@ModelAttribute OneOnOneDto oneOnOneDto,
			@ModelAttribute MemberDto memberDto
			,HttpSession session) {
		int oneNo = oneOnOneDao.sequence();
		oneOnOneDto.setOneNo(oneNo);
		String memberId = (String) session.getAttribute("name");
		oneOnOneDto.setOneId(memberId);
		oneOnOneDao.add(oneOnOneDto);
		return "redirect:detail?oneNo="+oneNo;
	}

	@RequestMapping("/detail")
	private String detail(@RequestParam int oneNo, Model model) {
		OneOnOneDto oneOnOneDto = oneOnOneDao.detail(oneNo);
		model.addAttribute("oneOnOneDto", oneOnOneDto);
		return "/WEB-INF/views/one/detail.jsp";
	}

	@GetMapping("/fix")
	private String fix(@RequestParam int oneNo, Model model) {
		OneOnOneDto oneOnOneDto = oneOnOneDao.detail(oneNo);
		model.addAttribute("oneOnOneDto", oneOnOneDto);
		return "/WEB-INF/views/one/fix.jsp";
	}

	@PostMapping("/fix")
	private String fix(@ModelAttribute OneOnOneDto oneOnOneDto) {
		boolean result = oneOnOneDao.fix(oneOnOneDto);
		if (result) {
			return "redirect:detail?oneNo=" + oneOnOneDto.getOneNo();
		} else {
			return "redirect:error";
		}
	}

	@RequestMapping("/delete")
	private String delete(@RequestParam int oneNo) {
		boolean result = oneOnOneDao.delete(oneNo);
		if (result) {
			return "redirect:list";
		} else {
			return "redirect:error";
		}
	}
}
