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

<a href="/shopafter/add">쇼핑후기 등록</a>
<br>
<a href="/shopafter/delete">쇼핑후기 삭제</a>
<table>
	<div class="container w-600">
		<div class="row">
			<h1>쇼핑 후기 목록</h1>
		</div>
	<tr>
		<th>쇼핑후기 번호</th>
		<th>쇼핑후기 제목</th>
		<th>쇼핑후기 내용</th>
	</tr>

	<c:forEach var="shopAfterDto" items="${list}">
		<tr>
			<td>${shopAfterDto.shopAfterNo}</td>
			<td><a href="detail?shopAfterNo=${shopAfterDto.shopAfterNo}">${shopAfterDto.shopAfterName}</a></td>
			<td>${shopAfterDto.shopAfterContent}</td>
		</tr>
	</c:forEach>

	</div>
</table>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>