<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<div class="container w-500">
	<div class="row">
		<c:choose>
		
		</c:choose>
	</div>
	<div class="row">
		<h1>${producctDto.productNo}</h1>
	</div>
	<div class="row">
		<h1>${productDto.productName}</h1>
	</div>
	<div class="row">
	<h1>${productDto.productPrice}</h1>
	</div>
	<div class="row">
	<h1>${productDto.productWeight}</h1>
	</div>
	<div class="row">
	<h1>${productDto.productOrigin}</h1>
	</div>
	<div class="row">
	<h1>${productDto.productExpire}</h1>
	</div>
	<div class="row">
	<h1>${productDto.productPrice}</h1>
	</div>
	<div class="row">
	<h1>${productDto.productPrice}</h1>
	</div>
	<div class="row">
	<h1>${productDto.productPrice}</h1>
	</div>
	





</div>








<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>