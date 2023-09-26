package com.kh.gogi.rest;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.gogi.dao.AddressDao;
import com.kh.gogi.dto.AddressDto;

//@CrossOrigin
@RestController
@RequestMapping("/rest/address")
public class AddressRestController {
	
	@Autowired
	private AddressDao addressDao;
	
	

	@PostMapping("/list")
	public List<AddressDto> list(@RequestParam String memberId){
		List<AddressDto> list = addressDao.selectAddressList(memberId);
		return list;
	}

}
