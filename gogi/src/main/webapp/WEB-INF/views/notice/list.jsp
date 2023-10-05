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
.noticeTitle{
	text-decoration: none;
}
select.form-input.notice{
	font-size:16px;
	height:2.8em;
    border-radius: 0.1em;
}
</style>

	<div class="container w-800 navy">
			<div class="row pb-30">
				<h2>공지사항</h2>
			</div>
			
			<%-- 작성은 관리자가 로그인한 경우에만 출력 --%>
			<c:if test="${sessionScope.level =='관리자' }">
				<div class="row right">
					 <a href="/notice/add" class="btn btn-orange">작성</a>
				</div>						
			</c:if>
						
			<div class="row">
	            <table class=" table table-slit">
					<thead>
	                    <tr>
	                        <th>번호</th>
	                        <th width="50%">제목</th>
	                        <th>작성자</th>
	                        <th>작성일</th>
	                    </tr>
	                </thead>
	
					<c:forEach var="noticeDto" items="${list}">				
						<tr>
							<td>${noticeDto.noticeNo}</td>
							<td class="left"><a class="noticeTitle navy " href="detail?noticeNo=${noticeDto.noticeNo}">${noticeDto.noticeTitle}</a></td>					
									<td>관리자</td>
		
							<td>${noticeDto.noticeDate}</td>
						</tr>
					</c:forEach>	            
	            </table>	
			</div>
	</div>
	
 		<div class="row page-navigator mv-30">
                <!-- 이전 버튼 -->
                <c:if test="${!vo.first}">
                    <a href="list?${vo.prevQueryString}">
                        <i class="fa-solid fa-angle-left"></i>
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
                    <a href="list?${vo.nextQueryString}">
                        <i class="fa-solid fa-angle-right"></i>
                    </a>
                </c:if>
        </div>

<!-- 검색기능 -->

<div align="center">
	<form action="list" method="get">

		<c:choose>
			<c:when test="${param.type == 'shopAfterId'}">
				<select name="type" 
					required="required"  class="form-input notice">
					<option value="notice_title">제목</option>
					<option value="notice_writer" selected="selected">작성자</option>
				</select>
			</c:when>
			<c:otherwise>
				<select name="type" 
					required="required"  class="form-input notice">
					<option value="notice_title" selected="selected">제목</option>
					<option value="notice_writer">작성자</option>
				</select>
			</c:otherwise>
		</c:choose>

		<input class="form-input notice" type="search" name="keyword" required="required"
			 placeholder="검색어를 입력해주세요"
			>
		<button class="btn btn-navy" type="submit">검색</button>
	</form>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>