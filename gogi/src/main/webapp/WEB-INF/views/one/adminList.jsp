<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:choose>
	<c:when test="${sessionScope.level == '관리자'}">
		<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>
	</c:when>
	<c:otherwise>
		<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>	
	</c:otherwise>
</c:choose>
<style>
.noticeTitle {
	text-decoration: none;
}

select.form-input, .form-input, .btn.btn-navy {
	font-size: 16px;
	height: 2.8em;
	border-radius: 0.1em;
}
</style>

<div class="container w-800 navy">
	<div class="row pb-30">
		<h2>1 : 1 문의</h2>
	</div>


		<div class="row">
			<table class=" table table-slit">
				<thead>
					<tr>
						<th>카테고리</th>
						<th width="50%">제목</th>
						<th>작성자</th>
						<th>작성일</th>
					</tr>
				</thead>

				<c:forEach var="OneOnOneDto" items="${list}">
					<tr>
						<td>${OneOnOneDto.oneCategory}</td>
						<td class="left">
							<c:if test="${OneOnOneDto.oneDepth >0}">
								<img src="/images/shopAfter/bottonArrow.png" width="15" height="15"
								style="background-color: ;">						
							</c:if>
							<a class="noticeTitle navy "href="detail?oneNo=${OneOnOneDto.oneNo}">${OneOnOneDto.oneTitle}</a>
						</td>				
						<td>${OneOnOneDto.oneId}</td>
						<td>${OneOnOneDto.oneDate}</td>
					</tr>
				</c:forEach>
			</table>

		</div>
</div>



<div class="row page-navigator mv-30">
	<!-- 이전 버튼 -->
	<c:if test="${!vo.first}">
		<a href="list?${vo.prevQueryString}"> <i
			class="fa-solid fa-angle-left"></i>
		</a>
	</c:if>

	<!-- 숫자 버튼 -->
	<c:forEach var="i" begin="${vo.begin}" end="${vo.end}" step="1">
		<c:choose>
			<c:when test="${vo.page == i}">
				<a class="on">${i}</a>
			</c:when>
			<c:otherwise>
				<a href="list?${vo.getQueryString(i)}">${i}</a>
			</c:otherwise>
		</c:choose>
	</c:forEach>

	<!-- 다음 버튼 -->
	<c:if test="${!vo.last}">
		<a href="list?${vo.nextQueryString}"> <i
			class="fa-solid fa-angle-right"></i>
		</a>
	</c:if>
</div>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>