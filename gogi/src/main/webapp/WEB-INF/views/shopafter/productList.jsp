<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
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
	<div class="row">
		<h2>전체 상품후기</h2>
	</div>
	<!-- 폼시작(체크박스) -->
	<form class="delete-form" action="deleteByAdmin" method="post">
		<%-- 글쓰기는 로그인 상태인 경우에만 출력 --%>
		<c:if test="${sessionScope.name != null}">
			<div class="row right ">

				<a href="${pageContext.request.contextPath}/add" class="btn upBtn"> <i class="fa-solid fa-pen"></i>
					글쓰기
				</a>
			</div>
		</c:if>


		<c:if test="${vo.search}">
			<div class="row left">&quot;${vo.keyword}&quot;에 대한 검색 결과</div>
		</c:if>

		<div class="row">
			<table class=" table table-slit">
				<thead>
					<tr>


						<th>번호</th>
						<th width="50%">제목</th>
						<th>아이디</th>
						<th>작성일</th>
					</tr>
				</thead>



				<c:forEach var="shopAfterDto" items="${list}">
					<tr>
						<td>${shopAfterDto.shopAfterNo}</td>
									
						
						<td><a class="noticeTitle navy left"
							href="${pageContext.request.contextPath}/shopafter/detail?shopAfterNo=${shopAfterDto.shopAfterNo}">${shopAfterDto.shopAfterName}
							<c:if test="${shopAfterDto.shopReplycount > 0}">
							[${shopAfterDto.shopReplycount}]
							</c:if></a>
							</td>
						<td>${shopAfterDto.shopAfterId}</td>
	
						<td>${shopAfterDto.shopAfterDate}</td>


					</tr>
				</c:forEach>
			</table>
		</div>
		<!-- 폼 종료(체크박스) -->
	</form>
</div>
<div class="row page-navigator mv-30">
	<!-- 이전 버튼 -->
	<c:if test="${!vo.first}">
		<a href="${pageContext.request.contextPath}/shopafter/list?${vo.prevQueryString}"> <i
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
				<a href="${pageContext.request.contextPath}/shopafter/list?${vo.getQueryString(i)}">${i}</a>
			</c:otherwise>
		</c:choose>
	</c:forEach>

	<!-- 다음 버튼 -->
	<c:if test="${!vo.last}">
		<a href="${pageContext.request.contextPath}/shopafter/list?${vo.nextQueryString}"> <i
			class="fa-solid fa-angle-right"></i>
		</a>
	</c:if>
</div>


<!-- 검색기능 -->

<div align="center">
	<form action="list" method="get">

		<c:choose>
			<c:when test="${param.type == 'shopAfterId'}">
				<select name="type" required="required" class="form-input">
					<option value="shopAfter_name">제목</option>
					<option value="shopAfter_id" selected="selected">아이디</option>
					<option value="shopAfter_content">내용</option>
				</select>
			</c:when>
			<c:otherwise>
				<select name="type" required="required" class="form-input">
					<option value="shopAfter_name" selected="selected">제목</option>
					<option value="shopAfter_id">작성자</option>
					<option value="shopAfter_content">내용</option>
				</select>
			</c:otherwise>
		</c:choose>



		<input class="form-input" type="search" name="keyword"
			required="required" placeholder="검색어를 입력해주세요">
		<button class="btn btn-navy" type="submit">검색</button>
	</form>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>