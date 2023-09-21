<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<form action= "edit" method="post" enctype="multipart/form-data" autocomplete="off">
<div class="container w-500">
<div class="row">
	<input type="hidden" name="productNo" value="${productDto.productNo}">
		<c:if test="${productDto.image}">
			<img src="image?productNo=${productDto.productNo}" width="100" height="100">
		</c:if>
	<input type="file" name="attach">
	</div>
	<div class="row">
	이름  <input type="text" name="productName" value="${productDto.productName}">
	</div>
	<div class="row">
	가격 <input type="number" name="productPrice" value="${productDto.productPrice}">
		</div>
	<div class="row">
	중량<input type="number" name="productWeight" value="${productDto.productWeight}">
	</div>
	<div class="row">
	원산지<input type="text" name="productOrigin" value="${productDto.productOrigin}">
	</div>
	<div class="row">
	타입<input type="text" name="productType" value="${productDto.productType}">
	</div>
	<div class="row">
	<button type="submit" class="btn btn-orange">등록하기</button>
	</div>
	</div>
</form>









<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>