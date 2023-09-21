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

<br><br><br><br>

<!-- 페이지 네이게이터 -->

<h3 align="center">

	<c:if test="${vo.first ==false}">


		<a href="list?${vo.prevQueryString}">&lt;&laquo;</a>

	</c:if>

	<c:forEach var="i" begin="${vo.begin}" end="${vo.end}" step="1">
		<c:choose>
			<c:when test="${vo.page == i}">
			${i}	
		</c:when>
			<c:otherwise>
				<a href="list?${vo.getQueryString(i)}">${i}</a>

			</c:otherwise>
		</c:choose>
	</c:forEach>


	<c:if test="${!vo.last}">

		<a href="list?${vo.nextQueryString}">&gt;&raquo;</a>



	</c:if>


</h3>



<!-- 검색기능 -->

<br>
<br>
<div align="center">
	<form action="list" method="get">

		<c:choose>
			<c:when test="${param.type == 'shopAfterId'}">
				<select name="type" 
					required="required"  class="form-input">
					<option value="qna_title">제목</option>
					<option value="qna_category" selected="selected">카테고리</option>
				</select>
			</c:when>
			<c:otherwise>
				<select name="type" 
					required="required"  class="form-input">
					<option value="qna_title" selected="selected">제목</option>
					<option value="qna_category">카테고리</option>
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