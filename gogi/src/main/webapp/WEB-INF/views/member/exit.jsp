<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<h2>회원탈퇴</h2>
<h3>정말 탈퇴하시겠습니까? 탈퇴 후 정보는 자동으로 사라집니다.</h3>
<form action="exit" method="post">
	비밀번호<input type="text" name="memberPw" required><br><br>
	<button class="btn btn-orange" type="submit">탈퇴하기</button>
	
	<c:if test="${param.error != null}">
	<h3 style="color:red">비밀번호가 일치하지 않습니다</h3>
	</c:if>

</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>