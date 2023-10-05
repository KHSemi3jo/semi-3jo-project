package com.kh.gogi.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.gogi.dao.AddressDao;
import com.kh.gogi.dao.MemberDao;
import com.kh.gogi.dto.AddressDto;
import com.kh.gogi.dto.MemberBlockDto;
import com.kh.gogi.dto.MemberDto;
import com.kh.gogi.dto.OneOnOneDto;
import com.kh.gogi.dto.ShopAfterDto;

@Controller
@RequestMapping("/member")
public class MemberController {
	//주석
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private JavaMailSender sender;
	
	@Autowired
	private AddressDao addressDao;
	
	@GetMapping("/join")
	public String join() {
		return "/WEB-INF/views/member/join.jsp";
	}
	
	@PostMapping("/join")
	public String join(@ModelAttribute MemberDto memberDto) {
		memberDao.insert(memberDto);
		return "redirect:joinFinish";
	}
	
	@RequestMapping("/joinFinish")
	public String joinFinish() {
		return "/WEB-INF/views/member/joinFinish.jsp";
	}
	@GetMapping("/login")
	public String login() {
		return "/WEB-INF/views/member/login.jsp";
	}
	
	@PostMapping("/login")
	public String login(@ModelAttribute MemberDto inputDto, 
							HttpSession session) {
		//[1]사용자가 입력한 아이디로 데이터베이스에서 정보를 조회
		MemberDto findDto = memberDao.selectOne(inputDto.getMemberId());
		//[2]1번에서 정보가 있다면 비밀번호를 검사(=없으면 차단하라는 소리)
		if(findDto == null) {
			return "redirect:login?error"; //에러나면 다시 로그인 -redirect는 무조건 GetMapping으로 간다
		}
		//boolean isCorrectPw = 입력한 비밀번호와 DB의 비밀번호가 같느냐
		boolean isCorrectPw = inputDto.getMemberPw().equals(findDto.getMemberPw());
		
		//[3]비밀번호가 일치하면 메인페이지로 이동(로그인 성공)
		if(isCorrectPw) {
			//(주의) 만약 차단된 회원이라면 추가 작업을 중지하고 오류 발생
			MemberBlockDto blockDto = memberDao.selectBlockOne(findDto.getMemberId());
			
			if(blockDto != null) {//차단된 회원이라면
				return "redirect:오류페이지";
				//throw new AuthorityException("차단된 회원");
			}
			//세션에 아이디 + 등급 저장
			session.setAttribute("name", findDto.getMemberId());
			session.setAttribute("level", findDto.getMemberLevel());
			session.setAttribute("customer", findDto.getMemberName());
			session.setAttribute("phone", findDto.getMemberContact());
			session.setAttribute("post", findDto.getMemberPost());
			session.setAttribute("addr1", findDto.getMemberAddr1());
			session.setAttribute("addr2", findDto.getMemberAddr2());
			session.setAttribute("Gmoney", findDto.getMemberGmoney());
			session.setAttribute("email", findDto.getMemberEmail());

			//로그인시간 갱신
			memberDao.updateMemberLogin(inputDto.getMemberId());
			//메인페이지로 이동
//			return "redirect:/"; //절대경로 - 자동으로 초기페이지로 이동
			return "redirect:/main";
		}
		//[4]비밀번호가 일치하지 않으면 로그인페이지로 이동
	else {
		return "redirect:login?error";
	}	
	}
	
	@RequestMapping("/logout") //로그아웃하려면 로그인된 걸 remove 해주어야 함 - 로그아웃 시,세션값(name) 날라감
	public String logout(HttpSession session) {
		session.removeAttribute("name");
		session.removeAttribute("level");
		return "redirect:/main";
	}
	
	//비밀번호 변경
	@GetMapping("/password")
	public String password() {
		return "/WEB-INF/views/member/password.jsp";
	}
	
	@PostMapping("/password")
	public String password(HttpSession session,
						@RequestParam String originPw,
						@RequestParam String changePw) {
		String memberId = (String) session.getAttribute("name"); //object로 꺼내기 위해 다운캐스팅
		MemberDto memberDto = memberDao.selectOne(memberId);
		
		//[1]기존 비밀번호가 일치하는지 판정
		if(memberDto.getMemberPw().equals(originPw)) {//비밀번호가 일치한다면
			//[2]1번이 성공일 때만 비밀번호를 변경하도록 처리(+개인정보 변경시각 수정(마지막 정보 변경일))
			memberDao.updateMemberPw(memberId,changePw); //dto써도 무방(값이 1-2개일 때)
			return "redirect:passwordFinish";
		}
		else {
			return "redirect:password?error"; //비밀번호 입력이 틀렸습니다 - 다시 입력하세요
		}
	}
	
	@RequestMapping("/passwordFinish")
	public String passwordFinish() {
		return "/WEB-INF/views/member/passwordFinish.jsp";
	}
	
	//개인정보 변경
		@GetMapping("/change")
		public String name(HttpSession session, Model model) {
			String memberId = (String) session.getAttribute("name");
			MemberDto memberDto = memberDao.selectOne(memberId);
			model.addAttribute("memberDto", memberDto);
			return "/WEB-INF/views/member/change.jsp";
		}
		
		@PostMapping("/change")
		public String change(@ModelAttribute MemberDto inputDto,
							HttpSession session){
			String memberId = (String) session.getAttribute("name");

			MemberDto findDto = memberDao.selectOne(memberId);
				memberDao.updateMemberInfo(inputDto);//정보 변경 처리
				return "redirect:changeFinish";
			}
		
		@RequestMapping("/changeFinish")
		public String changeFinish(){
			return "/WEB-INF/views/member/changeFinish.jsp";
		}
		
		
		
		//회원탈퇴
		@GetMapping("/exit")
		public String exit() {
			return "/WEB-INF/views/member/exit.jsp";
		}
		
		@PostMapping("/exit")
		public String exit(HttpSession session, @RequestParam String memberPw) {
			String memberId = (String) session.getAttribute("name");
			
			MemberDto memberDto = memberDao.selectOne(memberId);
			
			if(memberDto.getMemberPw().equals(memberPw)) {
				//삭제
				memberDao.delete(memberId);
				//로그아웃
				session.removeAttribute("name");//세션에서 name의 값을 삭제
			return "redirect:exitFinish"; //탈퇴완료 페이지로 이동
		}
		//비밀번호가 일치하지 않으면
	else {
		return "redirect:exit?error"; //다시 탈퇴 페이지로
	}	
	}
		@RequestMapping("/exitFinish")
		public String exitFinish() {
			return "/WEB-INF/views/member/exitFinish.jsp";
		}

		//비밀번호 찾기
		@GetMapping("/searchPw")
		public String searchPw() {
			return "/WEB-INF/views/member/searchPw.jsp";
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
				
				return "redirect:searchPwFinish";
				
			}
			else { //이메일이 다르다면
				return "redirect:searchPw?error";
			}
		}
		@RequestMapping("/searchPwFinish")
		public String searchPwFinish() {
			return "/WEB-INF/views/member/searchPwFinish.jsp";
		}
		
		@RequestMapping("/addressList")
		public String address( String memberId,
				Model model, HttpSession session
				) {
			memberId =(String) session.getAttribute("name");
			
			AddressDto addressDto = addressDao.selectOne(memberId);
			model.addAttribute("addressDto",addressDto);
			
		
			
			List<AddressDto> list = addressDao.selectAddressList(memberId);
			model.addAttribute("list", list);
			return "/WEB-INF/views/address/addressList.jsp";
		}
	}