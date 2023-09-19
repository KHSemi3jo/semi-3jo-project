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
<button><a href="/qna/list">Qna 목록</a></button>
<br>
<button><a href="/qna/fix?qnaNo=${qnaDto.qnaNo}">Qna 수정</a></button>
<br>
<button><a href="/qna/delete?qnaNo=${qnaDto.qnaNo}"">Qna 삭제</a></button>


<div class="container w-600">
	<div class="row">
		<h1>Qna 상세</h1>
	</div>
	<table border="1" style="border-color: black;">
		<tr>
			<th>Qna 번호</th>
			<th>Qna 제목</th>
			<th>Qna 내용</th>
		</tr>
	</table>
	<td>${qnaDto.qnaNo}</td>
	<td>${qnaDto.qnaTitle}</td>
	<td>${qnaDto.qnaAnswer}</td>
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>