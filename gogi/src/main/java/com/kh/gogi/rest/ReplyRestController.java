package com.kh.gogi.rest;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.gogi.dao.ReplyDao;
import com.kh.gogi.dao.ShopAfterDao;
import com.kh.gogi.dto.ReplyDto;

@RestController
@CrossOrigin
@RequestMapping("/rest/reply")
public class ReplyRestController {

	@Autowired
	private	ReplyDao replyDao;
	@Autowired
	private	ShopAfterDao shopAfterDao;
//댓글
	@PostMapping("/add")
	public void add(@ModelAttribute ReplyDto replyDto, HttpSession session) {
		int replyNo = replyDao.sequence();
		replyDto.setReplyNo(replyNo);

		String memberId = (String) session.getAttribute("name");
		replyDto.setReplyWriter(memberId);
		replyDao.add(replyDto);
		

		shopAfterDao.updateShopAfterReplyCount(replyDto.getReplyOrigin());
	}

	@PostMapping("/list")
	public List<ReplyDto> list(@RequestParam int replyOrigin) {
		List<ReplyDto> list = replyDao.selectList(replyOrigin);
		return list;
	}
	
	@PostMapping("/delete")
	public  void delete(@RequestParam int replyNo) {
		ReplyDto replyDto = replyDao.selectOne(replyNo);
		replyDao.delete(replyNo);
		
		shopAfterDao.updateShopAfterReplyCount(replyDto.getReplyOrigin());
	}
	
	@PostMapping("/edit")
	public void edit(@ModelAttribute ReplyDto replyDto) {
		replyDao.edit(replyDto);
	}
	
}
