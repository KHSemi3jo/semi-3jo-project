package com.kh.gogi.rest;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.gogi.dao.MemberDao;
import com.kh.gogi.dto.MemberDto;

@CrossOrigin
@RestController
@RequestMapping("/rest/member")
public class MemberRestController {

	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private JavaMailSender sender;
	
	@PostMapping("/idCheck")
	public String idCheck(@RequestParam String memberId) {
		MemberDto memberDto = memberDao.selectOne(memberId);
		if(memberDto == null) {//아이디가 없으면
			return "Y";
		}
		else {//아이디가 있으면
			return "N";
		}
	}
	
	@PostMapping("/emailCheck")
	public String emailCheck(@RequestParam String memberEmail) {
		MemberDto memberDto = memberDao.selectOneEmail(memberEmail);
		if(memberDto == null) {
			return "Y";
		}
		else {
			return "N";
		}
	}
	
	@PostMapping("/searchPw")
	public String searchPw(@ModelAttribute MemberDto memberDto) {
		//[1] 아이디로 모든 정보를 불러오고
		MemberDto findDto = memberDao.selectOne(memberDto.getMemberId());
		//[2] 이메일이 일치하는지 확인한다
		boolean isValid = findDto != null  //아이디 존재+이메일 일치;
					&& findDto.getMemberEmail().equals(memberDto.getMemberEmail());
		if(isValid) { //이메일이 같다면
			//이메일 발송 코드
			SimpleMailMessage message = new SimpleMailMessage();
			message.setTo(findDto.getMemberEmail());
			message.setSubject("[고기어때]비밀번호찾기결과");
			message.setText(findDto.getMemberPw());
			sender.send(message);
			
			return "success";
			
		}
		else { //이메일이 다르다면
			return "아이디와 이메일주소를 확인해주세요";
		}
	}
	
	@PostMapping("/changePw")
	public String password(HttpSession session,
						@RequestParam String originPw,
						@RequestParam String changePw) {
		String memberId = (String) session.getAttribute("name"); //object로 꺼내기 위해 다운캐스팅
		MemberDto memberDto = memberDao.selectOne(memberId);
		
		//[1]기존 비밀번호가 일치하는지 판정
		if(memberDto.getMemberPw().equals(originPw)) {//비밀번호가 일치한다면
			//[2]1번이 성공일 때만 비밀번호를 변경하도록 처리(+개인정보 변경시각 수정(마지막 정보 변경일))
			memberDao.updateMemberPw(memberId,changePw); //dto써도 무방(값이 1-2개일 때)
			return "success";
		}
		else {
			return "error"; //비밀번호 입력이 틀렸습니다 - 다시 입력하세요
		}
	}
	
	
}

















