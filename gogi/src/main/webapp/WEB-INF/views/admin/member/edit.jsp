<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h2>회원정보변경</h2>
<form action="edit" method="post">
	
	이름<input type="text" name="memberName" 
		value="${memberDto.memberName}" required><br><br>
	이메일<input type="email" name="memberEmail" 
		value="${memberDto.memberEmail}"><br><br>
	전화번호<input type="tel" name="memberContact" 
		value="${memberDto.memberContact}"><br><br>
	생년월일<input type="date" name="memberBirth" 
		value="${memberDto.memberBirth}"><br><br>
	주소<input type="text" name="memberPost" size="6" maxlength="6" 
		placeholder="우편번호" value="${memberDto.memberPost}"><br>
		<input type="text" name="memberAddr1" size="50"
		placeholder="기본주소" value="${memberDto.memberAddr1}"><br>
		<input type="text" name="memberAddr2" size="50"
		placeholder="상세주소" value="${memberDto.memberAddr2}"><br>
	
	<%-- radio button은 select box와 같은 역할을 한다 --%>
	등급
	<c:choose>
	<c:when test="${memberDto.memberLevel == 'VIP'}">
	<input type="radio" name="memberLevel" value="일반">일반
	<input type="radio" name="memberLevel" value="VIP" checked>VIP
	<input type="radio" name="memberLevel" value="관리자">관리자
	
	</c:when>
	<c:when test="${memberDto.memberLevel == '관리자'}">
	<input type="radio" name="memberLevel" value="일반">일반
	<input type="radio" name="memberLevel" value="VIP">VIP
	<input type="radio" name="memberLevel" value="관리자" checked>관리자
	</c:when>
	<c:otherwise>
	<input type="radio" name="memberLevel" value="일반" checked>일반
	<input type="radio" name="memberLevel" value="VIP">VIP
	<input type="radio" name="memberLevel" value="관리자">관리자
	</c:otherwise>
	</c:choose>
	
	<br><br>
	포인트<input type="number" name="memberPoint" value="${memberDto.memberPoint}">
	<br><br>
	
	<button>정보변경</button>
</form>




<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>