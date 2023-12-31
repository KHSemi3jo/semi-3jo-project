<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container w-600">
	<div class="row pt-20">
		<h2 class="navy">회원 가입 완료</h2>
	</div>
	<div class="row pt-20">
		<h3 class="orange"><i class="fa-regular fa-face-laugh-beam fa-5x"></i></h3>
	</div>
	<div class="row pt-10">
		<h3 class="orange">진심으로 환영합니다!</h3>
	</div>
	<div class="row pt-30">
		<a href="${pageContext.request.contextPath}/member/login" class="btn btn-orange">로그인</a>
		<a href="${pageContext.request.contextPath}/" class="btn btn-navy">메인</a>
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>