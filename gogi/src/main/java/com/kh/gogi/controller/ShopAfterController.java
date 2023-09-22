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
import com.kh.gogi.dao.ReplyDao;
import com.kh.gogi.dao.ShopAfterDao;
import com.kh.gogi.dto.MemberDto;
import com.kh.gogi.dto.NoticeDto;
import com.kh.gogi.dto.OneOnOneDto;
import com.kh.gogi.dto.ReplyDto;
import com.kh.gogi.dto.ShopAfterDto;
import com.kh.gogi.mapper.ShopAfterMapper;
import com.kh.gogi.vo.ShopAfterVO;



@Controller
@RequestMapping("/shopafter")
public class ShopAfterController {
	@Autowired
	ShopAfterMapper shopAfterMapper;
	@Autowired
	ShopAfterDao shopAfterDao;
	@Autowired
	MemberDao memberDao;
	@Autowired
	ReplyDao replyDao;



	@GetMapping("/add")
	private String add() {
		return "/WEB-INF/views/shopafter/add.jsp";
	}

	@PostMapping("/add")
	private String add(@ModelAttribute ShopAfterDto shopAfterDto, 
			@ModelAttribute MemberDto memberDto,
			HttpSession session) {
		int shopAfterNo = shopAfterDao.sequence();
		shopAfterDto.setShopAfterNo(shopAfterNo);
		String memberId = (String) session.getAttribute("name");
		shopAfterDto.setShopAfterId(memberId);
		shopAfterDao.add(shopAfterDto);
		return "redirect:detail?shopAfterNo=" + shopAfterNo;
	}

	
//	@RequestMapping("/list")
//	public String list(Model model, HttpSession session,
//	@ModelAttribute(name = "vo") ShopAfterVO vo,
//	ShopAfterDto shopAfterDto,	
//	@RequestParam(required = false) String type,
//	@RequestParam(required = false) String keyword,
//	@RequestParam(required = false, defaultValue = "1") int page) {
//		
//		boolean isSearch = type != null && keyword != null;
//		
//		int begin = (page - 1) / 10 * 10 + 1;
//		int end = begin + 9;
//		int count = isSearch ? shopAfterDao.countList(type, keyword) : shopAfterDao.countList();
//		int pageCount = (count - 1) / 10 + 1;
//		model.addAttribute("page", page);
//		model.addAttribute("begin", begin);
//		model.addAttribute("end", end);
//		model.addAttribute("pageCount", pageCount);
//		
//		if (isSearch) { 
//			 List<ShopAfterDto> list = shopAfterDao.selectList(type, keyword);
//			// List<ShopAfterDto> list = shopAfterDao.selectListByPage(type, keyword,page);
//			model.addAttribute("list", list);
//			model.addAttribute("isSearch", true);
//		} else { 
//
//			//List<ShopAfterDto>list = shopAfterDao.list();
//			 List<ShopAfterDto> list = shopAfterDao.selectListByPage(page);
//			model.addAttribute("list", list);
//			model.addAttribute("isSearch", false);
//		}
//		
//
//		return "/WEB-INF/views/shopafter/list.jsp";
//	}
	
	
	@RequestMapping("/list")
	public String list(@ModelAttribute(name = "vo") ShopAfterVO vo, Model model) {

		int count = shopAfterDao.countList(vo);
		vo.setCount(count);

		List<ShopAfterDto> list = shopAfterDao.selectListByPage(vo);
		model.addAttribute("list", list);
		return "/WEB-INF/views/shopafter/list.jsp";

	}
	
	
	
	
	
//	@RequestMapping("list")
//	public String list(Model model, HttpSession session,
//			@ModelAttribute(name = "vo") ShopAfterVO vo,
//			ShopAfterDto shopAfterDto,	
//			@RequestParam(required = false) String type,
//			@RequestParam(required = false) String keyword,
//			@RequestParam(required = false, defaultValue = "1") int page) {
//		
//				boolean isSearch = type != null && keyword != null;
//		
//				int begin = (page - 1) / 10 * 10 + 1;
//				int end = begin + 9;
//				int count = isSearch ? shopAfterDao.countList(type, keyword) : shopAfterDao.countList();
//				int pageCount = (count - 1) / 10 + 1;
//				model.addAttribute("page", page);
//				model.addAttribute("begin", begin);
//				
//				model.addAttribute("end", Math.min(pageCount, end));
//				model.addAttribute("pageCount", pageCount);
//				if (isSearch) { 
//					 List<ShopAfterDto> list = shopAfterDao.selectListByPage(type, keyword, page);
//					model.addAttribute("list", list);
//					model.addAttribute("isSearch", true);
//				} else { 
//		
//					List<ShopAfterDto> list = shopAfterDao.selectListByPage(page);
//					model.addAttribute("list", shopAfterDao.selectListByPage(page));
//					model.addAttribute("isSearch", false);
//				}
//				return "/WEB-INF/views/shopafter/list.jsp";
//			}

	
	@RequestMapping("/detail")
	private String detail(@RequestParam int shopAfterNo, Model model, HttpSession session,
			@RequestParam(required = false, defaultValue = "1") int page) {
		ShopAfterDto  shopAfterDto = shopAfterDao.detail(shopAfterNo);
		model.addAttribute("shopAfterDto", shopAfterDto);
		int replyOrigin = shopAfterDto.getShopAfterNo();
		
		//댓글 페이징을 위한 코드
	   List <ReplyDto> replyList =replyDao.selectListByPage(replyOrigin, page);
	    model.addAttribute("replyList", replyList);

	    
	    
	    
		
		String shopAfterId = shopAfterDto.getShopAfterId();
		if (shopAfterId != null) {
			MemberDto memberDto = memberDao.selectOne(shopAfterId);
			model.addAttribute("shopAfterDto", memberDto);
		}
		return "/WEB-INF/views/shopafter/detail.jsp";
	}




	@GetMapping("/fix")
	private String fix(@RequestParam int shopAfterNo,
			Model model) {
		ShopAfterDto shopAfterDto = shopAfterDao.detail(shopAfterNo);
		model.addAttribute("shopAfterDto",shopAfterDto);
		return "/WEB-INF/views/shopafter/fix.jsp";
	}

	@PostMapping("/fix")
	private String fix(@ModelAttribute ShopAfterDto shopAfterDto) {
		boolean result = shopAfterDao.fix(shopAfterDto);
		if(result) {
			return "redirect:detail?shopAfterNo="+shopAfterDto.getShopAfterNo();
		}
		else {
			 return "redirect:error";
		}
	}

	@RequestMapping("/delete")
	private String delete(
			@RequestParam int shopAfterNo) {

		shopAfterDao.delete(shopAfterNo);
		return "redirect:list";
	}
}
