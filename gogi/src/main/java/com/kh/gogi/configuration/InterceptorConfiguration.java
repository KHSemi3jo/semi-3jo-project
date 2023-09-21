package com.kh.gogi.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.kh.gogi.interceptor.AdminOwnerInterceptor;
import com.kh.gogi.interceptor.MemberInterceptor;

@Configuration
public class InterceptorConfiguration implements WebMvcConfigurer {

	@Autowired
	MemberInterceptor memberInterceptor;

	@Autowired
	AdminOwnerInterceptor adminOwnerInterceptor;

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		
	//	registry.addInterceptor(memberInterceptor)
//				.addPathPatterns("/member/**", "/shopafter/**")
//				.excludePathPatterns("/member/join*", "/member/login", 
//						"/member/exitFinish", "/shopafter/list",
//						"/shopafter/detail");
			
		
	//	registry.addInterceptor(adminOwnerInterceptor)
		//		.addPathPatterns("/admin/**") 


	}
	}
