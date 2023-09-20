<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

	<c:forEach var="productDto" items="${list}">
		<div class="row">
			<a class="link" href="detail?productNo= ${productDto.productNo}">${productDto.productNo}</a> /
			 ${productDto.productName}/
			  ${productDto.productPrice}원
			
		<a href="add?productNo=${productDto.productNo}">등록</a>
		<a href="edit?productNo=${productDto.productNo}">수정</a>
		<a href="delete?productNo=${productDto.productNo}">삭제</a>
		<hr>
		</div>
	
	</c:forEach>


















<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>