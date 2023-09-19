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
<a href="/notice/list">공지사항 목록</a>
<br>
<a href="/notice/fix?noticeNo=${noticeDto.noticeNo}">공지사항 수정</a>
<br>
<a href="/notice/delete?noticeNo=${noticeDto.noticeNo}">공지사항 삭제</a>


<div class="container w-600">
	<div class="row">
		<h1>공지사항 상세</h1>
	</div>
	<table border="1" style="border-color: black;">
		<tr>
			<th>공지사항 번호</th>
			<th>공지사항 제목</th>
			<th>공지사항 내용</th>
		</tr>
	</table>
	<td>${noticeDto.noticeNo}</td>
	<td>${noticeDto.noticeTitle}</td>
	<td>${noticeDto.noticeContent}</td>
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>