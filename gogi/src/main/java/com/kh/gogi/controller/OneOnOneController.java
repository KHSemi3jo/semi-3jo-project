package com.kh.gogi.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.gogi.dao.OneOnOneDao;
import com.kh.gogi.dto.OneOnOneDto;
import com.kh.gogi.mapper.OneOnOneMapper;

@Controller
@RequestMapping("/one")
public class OneOnOneController {
	@Autowired
	OneOnOneDao oneOnOneDao;
	@Autowired
	OneOnOneMapper oneOnOneMapper;

	@RequestMapping("/list")
	private String list(Model model) {
		List<OneOnOneDto> list = oneOnOneDao.list();
		model.addAttribute("list", list);
		return "/WEB-INF/views/one/list.jsp";
	}

	@GetMapping("/add")
	private String add() {
		return "/WEB-INF/views/one/add.jsp";
	}

	@PostMapping("/add")
	private String add(@ModelAttribute OneOnOneDto oneOnOneDto) {
		int oneNo = oneOnOneDao.sequence();
		oneOnOneDto.setOneNo(oneNo);
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
			return "rediect : detail?oneNo=" + oneOnOneDto.getOneNo();
		} else {
			return "rediect : error";
		}
	}

	@RequestMapping("/delete")
	private String delete(@RequestParam int oneNo) {
		boolean result = oneOnOneDao.delete(oneNo);
		if (result) {
			return "redirect : list";
		} else {
			return "redirect:error";
		}
	}
}
