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

</style>

<div class="container w-800">
    <div class="row">
        <h2 class="pt-30 pb-30 navy">1 : 1 게시판</h2>
    </div>
    <div class="row">
        <table class="table table-slit">
                <tr>
                    <th bgcolor="#CCD5DE">제목</th>
                    <td class="left">${oneOnOneDto.oneTitle}</td>
                </tr>
                <c:if test="${sessionScope.level == '관리자'}">
	                <tr>
	                    <th bgcolor="#CCD5DE">작성자</th>
	                    <td class="left">${oneOnOneDto.oneId}</td>
	                </tr>
                </c:if>
                <tr>
                    <th bgcolor="#CCD5DE">작성일</th>
                    <td class="left">${oneOnOneDto.oneDate}</td>
                </tr>
                <tr>
                    <td colspan="2" class="left">${oneOnOneDto.oneContent}</td>
                </tr>
        </table>
        <div class="row right">
            <a href="/one/list"class="btn btn-navy">목록</a>
            <c:if test="${sessionScope.level != '관리자'}">
            	<a href="/one/add" class="btn btn-orange">문의하기</a> 
            </c:if>
            <%-- 답글은 관리자만 작성가능 --%>
			<c:if test="${sessionScope.level =='관리자' }">
	            <a class="btn btn-orange" href="/one/add?oneParent=${oneOnOneDto.oneNo}">답글</a>									
            	<a class="btn btn-orange" href="/one/delete?oneNo=${oneOnOneDto.oneNo}">삭제</a>
            	<a class="btn btn-orange" href="/one/fix?oneNo=${oneOnOneDto.oneNo}">수정</a>
			</c:if>

        </div>
    </div>
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>