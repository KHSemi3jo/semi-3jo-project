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

<button><a href="/one/add">1대1 등록</a></button>
<br>

<table class="w-600">
	<div class="container w-600">
		<div class="row">
			<h1>1대1 목록1</h1>
		</div>
		<tr>
			<th>1대1 번호</th>
			<th>1대1 제목</th>
			<th>1대1 내용</th>
			<th>삭제</th>
		</tr>

		<c:forEach var="OneOnOneDto" items="${list}">
			<tr>
				<td>${OneOnOneDto.oneNo}</td>
				<td><a href="detail?oneNo=${OneOnOneDto.oneNo}">${OneOnOneDto.oneTitle}</a></td>
				<td>${OneOnOneDto.oneContent}</td>
				<td><a href="delete?oneNo=${OneOnOneDto.oneNo}">삭제</a></td>
			</tr>
		</c:forEach>

	</div>
</table>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>