<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<a href="/shopafter/list">쇼핑후기 목록</a>
<br>
<a href="/shopafter/fix?shopAfterNo=${shopafterDto.shopAfterNo}">쇼핑후기 수정</a>
<br>
<a href="/shopafter/delete">쇼핑후기 삭제</a>


<div class="container w-600">
	<div class="row">
		<h1>쇼핑후기 상세</h1>
	</div>
	<table border="1" style="border-color: black;">
		<tr>
			<th>쇼핑후기 번호</th>
			<th>쇼핑후기 제목</th>
			<th>쇼핑후기 내용</th>
		</tr>
	</table>
	<td>${shopAfterDto.shopAfterNo}</td>
	<td>${shopAfterDto.shopAfterName}</td>
	<td>${shopAfterDto.shopAfterContent}</td>
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>