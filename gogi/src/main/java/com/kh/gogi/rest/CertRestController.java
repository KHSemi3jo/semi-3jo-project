package com.kh.gogi.rest;

import java.text.DecimalFormat;
import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.gogi.dao.CertDao;
import com.kh.gogi.dto.CertDto;

@CrossOrigin
@RestController
@RequestMapping("/rest/cert")
public class CertRestController {
	
	@Autowired
	private JavaMailSender sender;
	
	@Autowired
	private CertDao certDao;
	
	@PostMapping("/send")
	public void send(@RequestParam String certEmail) {
		//인증번호 생성
		Random r = new Random();
		int number = r.nextInt(1000000);
		DecimalFormat fm = new DecimalFormat("000000");
		String certNumber = fm.format(number);
		
		//이메일 발송
		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(certEmail);
		message.setSubject("[고기어때]인증번호 발송");
		message.setText("인증번호는 [ "+certNumber+" ] 입니다!");
		sender.send(message);
		
		certDao.delete(certEmail);
		CertDto certDto = new CertDto();
		certDto.setCertEmail(certEmail);
		certDto.setCertNumber(certNumber);
		certDao.insert(certDto);
	}
	
	@PostMapping("/check")
	public Map<String, Object> check(@ModelAttribute CertDto certDto){
		//[1]이메일로 인증정보를 조회
		//CertDto findDto = certDao.selectOne(certDto.getCertEmail());//기간제한 없음
		CertDto findDto = certDao.selectOneIn5min(certDto.getCertEmail());//5분제한
		if(findDto !=null ) {
			//[2]인증번호 비교
			boolean isValid = findDto.getCertNumber().equals(certDto.getCertNumber());
			if(isValid) {
				//인증 성공하면 인증번호를 삭제
				certDao.delete(certDto.getCertEmail());
				return Map.of("result",true);
			}
		}
		return Map.of("result", false);
	}

}
