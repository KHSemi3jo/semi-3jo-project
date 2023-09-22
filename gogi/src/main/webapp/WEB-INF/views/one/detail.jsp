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
<button><a href="/one/list">1대1 목록</a></button>
<br>
<button><a href="/one/fix?oneNo=${oneOnOneDto.oneNo}">1대1 수정</a></button>
<br>
<button><a href="/one/delete?oneNo=${oneOnOneDto.oneNo}"">1대1 삭제</a></button>
		<button>	<a href="/one/add?oneParent=${oneOnOneDto.oneNo}">답글 쓰기</a></button>

<div class="container w-600">
	<div class="row">
		<h1>1대1 상세</h1>
	</div>
	<table border="1" style="border-color: black;">
		<tr>
			<th>1대1 번호</th>
			<th>1대1 제목</th>
			<th>1대1 내용</th>
		</tr>
	</table>
	<td>${oneOnOneDto.oneNo}</td>
	<td>${oneOnOneDto.oneTitle}</td>
	<td>${oneOnOneDto.oneContent}</td>
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>