<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<a href="/one/list">1대1 목록</a>
<br>
<a href="/one/fix?oneNo=${OneOnOneDto.oneNo}">1대1 수정</a>
<br>
<a href="/one/delete?oneNo=${OneOnOneDto.oneNo}"">1대1 삭제</a>


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
	<td>${OneOnOneDto.oneNo}</td>
	<td>${OneOnOneDto.oneTitle}</td>
	<td>${OneOnOneDto.oneContent}</td>
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>