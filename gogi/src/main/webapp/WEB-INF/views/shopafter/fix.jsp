<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<a href="/shopafter/list">쇼핑후기 목록</a>
<a href="/shopafter/delete">쇼핑후기 삭제</a>


<div class="container w-600">
	<div class="row">
		<h1>쇼핑후기 수정</h1>
	</div>
	<form action="add" method="post">
		<div class="row">
			제목 : <input type="text" required class="form-input"
				value="${shopAfterDto.shopAtfer_name}">
		</div>
		<div class="row ">
			내용 :
			<textarea class="form-input w-100" cols="30" rows="10">${shopAfterDto.shopAtfer_content}</textarea>
		</div>
		<div class="row">
			<button type="submit" class="btn w-100 btn-navy">등록</button>
	</form>
</div>




<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>