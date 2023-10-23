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
<!-- 내가 만든 CSS 파일-->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/reset.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/Gogi-layout.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/Gogi-commons.css">
<style>

.hidden-select{
	display: none;
}
</style>
<div class="container w-800">
    <div class="row">
        <h2 class="pt-30 pb-30 navy">공지사항</h2>
    </div>
    <div class="row">
        <table class="table table-slit">
                <tr>
                    <th bgcolor="#CCD5DE">제목</th>
                    <td class="left">${noticeDto.noticeTitle}</td>
                </tr>
                <tr>
                    <th bgcolor="#CCD5DE">작성자</th>
                    <td class="left">${noticeDto.noticeWriter}</td>
                </tr>
                <tr>
                    <th bgcolor="#CCD5DE">작성일</th>
                    <td class="left">${noticeDto.noticeDate}</td>
                </tr>
                <tr>
                    <td colspan="2" class="left">${noticeDto.noticeContent}</td>
                </tr>
        </table>
        <div class="row right">
            <a href="${pageContext.request.contextPath}/notice/list"class="btn btn-navy">목록</a>
            <%-- 수정,삭제는 관리자가 로그인한 경우에만 출력 --%>
			<c:if test="${sessionScope.level =='관리자' }">
	            <a class="btn btn-orange" href="${pageContext.request.contextPath}/notice/fix?noticeNo=${noticeDto.noticeNo}">수정</a>
	            <a class="btn btn-orange" href="${pageContext.request.contextPath}/notice/delete?noticeNo=${noticeDto.noticeNo}">삭제</a>										
			</c:if>
        </div>
    </div>
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>