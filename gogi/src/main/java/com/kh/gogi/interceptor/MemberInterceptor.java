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
		else { 
			throw new AuthorityException("로그인 후 이용 가능");
		}
	}
}
