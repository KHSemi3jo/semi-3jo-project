<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
table {
	border: 1px solid black;
	margin-left: auto;
	margin-right: auto;
}

th {
	border: 1px solid black;
	text-align: center;
}

td {
	border: 1px solid black;
	text-align: center;
}
</style>

<button  class="btn btn-navy"><a href="/qna/add">Qna 등록</a></button>
<br>

<table class="w-600">
	<div class="container ">
		<div class="row">
			<h1>자주하는 질문 목록</h1>
		</div>
		<div class="row w-100">
		<tr>
			<th>Qna 번호</th>
			<th>Qna 제목</th>
			<th>Qna 내용</th>
			<th>삭제</th>
		</tr>
</div>
		<c:forEach var="qnaDto" items="${list}">
			<tr>
				<td>${qnaDto.qnaNo}</td>
				<td><a href="detail?qnaNo=${qnaDto.qnaNo}">${qnaDto.qnaTitle}</a></td>
				<td>${qnaDto.qnaAnswer}</td>
				<td><a href="delete?qnaNo=${qnaDto.qnaNo}">삭제</a></td>
			</tr>
		</c:forEach>

	</div>
</table>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>