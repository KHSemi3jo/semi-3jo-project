<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<button><a href="/qna/list">Qna 목록</a></button>
<button><a href="/one/delete?ontNo=${qnaDto.qnaNo}">Qna 삭제</a></button>


<div class="container w-600">
	<div class="row">
		<h1>Qna 수정</h1>
	</div>
	<form action="add" method="post">
		<div class="row">
			제목 : <input type="text" name="qnaTitle" required class="form-input"
				value="${qnaDto.qnaTitle}">
		</div>
		<div class="row ">
			내용 :
			<textarea name="qnaAnswer" class="form-input w-100" cols="30" rows="10">${qnaDto.qnaAnswer}</textarea>
		</div>
		<div class="row">
			<button type="submit" class="btn w-100 btn-navy">등록</button>
	</form>
</div>




<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>