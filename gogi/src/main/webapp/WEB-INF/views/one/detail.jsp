<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>

</style>

<div class="container w-800">
    <div class="row">
        <h2 class="pt-30 pb-30 navy">1대1 게시판</h2>
    </div>
    <div class="row">
        <table class="table table-slit">
                <tr>
                    <th bgcolor="#CCD5DE">제목</th>
                    <td class="left">${oneOnOneDto.oneTitle}</td>
                </tr>
                <tr>
                    <th bgcolor="#CCD5DE">작성자</th>
                    <td class="left">${oneOnOneDto.oneId}</td>
                </tr>
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
            <a class="btn btn-navy" href="/one/add?oneParent=${oneOnOneDto.oneNo}">답글</a>
            <a class="btn btn-navy" href="/one/fix?oneNo=${oneOnOneDto.oneNo}">수정</a>
            <a class="btn btn-navy" href="/one/delete?oneNo=${oneOnOneDto.oneNo}">삭제</a>

        </div>
    </div>
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>