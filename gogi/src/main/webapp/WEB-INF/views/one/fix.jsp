<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<a href="/one/list">1대1 목록</a>
<a href="/one/delete">1대1 삭제</a>


<div class="container w-600">
	<div class="row">
		<h1>1대1 수정</h1>
	</div>
	<form action="add" method="post">
		<div class="row">
			제목 : <input type="text" name="oneTitle" required class="form-input"
				value="${OneOnOneDto.oneTitle}">
		</div>
		<div class="row ">
			내용 :
			<textarea name="oneContent" class="form-input w-100" cols="30" rows="10">${{OneOnOneDto.oneContent}</textarea>
		</div>
		<div class="row">
			<button type="submit" class="btn w-100 btn-navy">등록</button>
	</form>
</div>




<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>