<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
    
</style>

<script src="/js/checkbox.js"></script>
<!-- javascript 작성 공간 -->
<script>
	
</script>

<form action="#" method="post">
	<div class="flex-container">
		<div style="width:950px;">
		<table class="table table-slit">
			<thead>
				<tr>
					<th>
						<!-- 전체선택 체크박스 -->
						<input type="checkbox" class="check-all">
						<span>전체선택</span>
						<span>|</span>
						<span>선택삭제</span>
					</th>
					<th width="40%">상품명</th>
					<th>가격</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="pickListDto" items="${pickList}">
				<tr>
					<td>
						<!-- 개별항목 체크박스 -->
						<input type="checkbox" class="check-item" name="pickNoList" value="${pickListDto.pickNo}">
					</td>
					<td>${pickListDto.pickNo}</td>
					<td align="left">
						<!-- 제목을 누르면 상세페이지로 이동 -->
						<a class="link" href="/product/detail?productNo=${pickListDto.pickProdNo}">
							${pickListDto.productName}
						</a>
					</td>
					<td>${pickListDto.productPrice}</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		</div>
		
	</div>

</form>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>