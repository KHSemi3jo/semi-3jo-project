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

<button  class="btn btn-navy"><a href="/one/add">1대1 등록</a></button>
<br>

<table class="w-600">
	<div class="container w-600">
		<div class="row">
			<h1>1대1 목록</h1>
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

<br><br><br><br>



	



<!-- 검색기능 -->

<br>
<br>
<div align="center">
	<form action="list" method="get">

		<c:choose>
			<c:when test="${param.type == 'shopAfterId'}">
				<select name="type" 
					required="required"  class="form-input">
					<option value="one_title">제목</option>
					<option value="one_id" selected="selected">작성자</option>
				</select>
			</c:when>
			<c:otherwise>
				<select name="type" 
					required="required"  class="form-input">
					<option value="one_title" selected="selected">제목</option>
					<option value="one_id">작성자</option>
				</select>
			</c:otherwise>
		</c:choose>



		<input  class="form-input" type="search" name="keyword" required="required"
			 placeholder="검색하실 이름을 입력해주세요"
			>
		<button class="btn btn-navy" type="submit">검색</button>
	</form>
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>