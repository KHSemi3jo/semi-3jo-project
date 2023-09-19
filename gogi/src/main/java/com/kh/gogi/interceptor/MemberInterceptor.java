package com.kh.gogi.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.gogi.error.AuthorityException;


@Component
public class MemberInterceptor implements HandlerInterceptor{
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		//세션이 주어지지 않으므로, 요청정보에서 세션 객체를 추출하여 사용
		HttpSession session = request.getSession();
		//세션에서 값(name) 추출
		String memberId = (String) session.getAttribute("name");
		boolean isLogin = memberId != null;
		
		if(isLogin) {//회원이면
			return true;
		}
		else { //비회원이면 - 차단+로그인 페이지로 redirect -> 수동으로 할 땐 response를 쓴다
			//return "redirect:/member/login";
			//response.sendRedirect("/member/login");
			
			//[2]권한 없음 오류 발생
			//response.sendError(401);
			//return false;
			
			//[3]내가 만든 예외로 처리
			throw new AuthorityException("로그인 후 이용 가능"); //괄호 안에 메세지 적으면 로그에 나옴
		}
	}
}
