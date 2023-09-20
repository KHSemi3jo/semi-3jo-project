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

<button  class="btn btn-navy"><a href="/notice/add">공지사항 등록</a></button>
<br>

<table class="w-600">
	<div class="container ">
		<div class="row">
			<h1>공지 사항 목록</h1>
		</div>
		<tr>
			<th>공지사항 번호</th>
			<th>공지사항 제목</th>
			<th>공지사항 내용</th>
			<th>삭제</th>
		</tr>

		<c:forEach var="noticeDto" items="${list}">
			<tr>
				<td>${noticeDto.noticeNo}</td>
				<td><a href="detail?noticeNo=${noticeDto.noticeNo}">${noticeDto.noticeTitle}</a></td>
				<td>${noticeDto.noticeContent}</td>
				<td><a href="delete?noticeNo=${noticeDto.noticeNo}">삭제</a></td>
			</tr>
		</c:forEach>

	</div>
</table>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>