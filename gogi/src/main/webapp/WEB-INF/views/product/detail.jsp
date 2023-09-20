<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<div class="container w-500">
	<div class="row">
		<h1>상품 상세 페이지</h1>
	</div>
	<div class="row"></div>
		<img src="image?productNo=${productDto.productNo}" width="200" height="200">
	</div>
	<div class="row">
		<h1>${productDto.productNo}</h1>;
	</div>
	<div class="row">
		<h1>${productDto.productName}</h1>
	</div>
	<div class="row">
	<h1>${productDto.productPrice}원</h1>
	</div>
	<div class="row">
	<h1>${productDto.productWeight}g</h1>
	</div>
	<div class="row">
	<h1>${productDto.productOrigin}</h1>
	</div>
	<div class="row">
	<h1>${productDto.productExpire}까지</h1>
	</div>
	<div class="row">
	<h1>${productDto.productType}</h1>
	</div>
	<div class="row">
	<h1>${productDto.productDate}</h1>
	</div>
</div>








<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>