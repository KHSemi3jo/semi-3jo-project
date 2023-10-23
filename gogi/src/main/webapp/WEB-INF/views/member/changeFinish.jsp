<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<div class="container w-500">
	<div class="row pt-50">
		<h2 class="navy">회원 정보 변경이 완료되었습니다!</h2>
	</div>
	<div class="row pt-20">
		<h3 class="navy"><i class="fa-regular fa-face-laugh-beam fa-5x"></i></h3>
	</div>
	<div class="row pt-20">
		<a class="btn btn-navy " href="${pageContext.request.contextPath}/">메인</a>
		<a class="btn btn-navy " href="${pageContext.request.contextPath}/member/change">뒤로가기</a>
	</div>
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>