package com.kh.gogi.rest;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.kh.gogi.dao.AddressDao;
import com.kh.gogi.dto.AddressDto;
import com.kh.gogi.dto.ReplyDto;
import com.kh.gogi.vo.ShopAfterVO;

//@CrossOrigin
@RestController

@RequestMapping("/rest/address")
public class AddressRestController {
	
	@Autowired
	private AddressDao addressDao;
	
	

	@PostMapping("/list")
	 @ResponseBody
	public List<AddressDto> list(@RequestParam String addressId,
			Model model){
		List<AddressDto> list = addressDao.selectAddressList(addressId);
		model.addAttribute("list",list);
		return list;
	}
	
	@PostMapping("/add")
	public void add(@ModelAttribute AddressDto addressDto, HttpSession session) {
		int addressNo = addressDao.sequence();
		addressDto.setAddressNo(addressNo);
		String addressId = (String) session.getAttribute("name");
		addressDto.setAddressId(addressId);
		String addressPhone = (String) session.getAttribute("phone");
		addressDto.setAddressPhone(addressPhone);
		String addressName = (String) session.getAttribute("customer");
		addressDto.setAddressName(addressName);
		
		addressDao.insert(addressDto);

	}
	
	@PostMapping("/delete")
	public  void delete(@RequestParam int addressNo) {

		addressDao.delete(addressNo);
		
	}
	@PostMapping("/edit")
	public void edit(@ModelAttribute AddressDto addressDto) {
		addressDao.edit(addressDto);
	}
	
	

		
}


