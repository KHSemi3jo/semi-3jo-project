<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>

</style>

    <div class="container w-800">
        <div class="row">
            <h2 class="pt-30 pb-30 navy">자주하는 질문</h2>
        </div>
        <div class="row">
            <table class="table table-slit">
                    <tr>
                        <th bgcolor="#CCD5DE">제목</th>
                        <td class="left">${qnaDto.qnaTitle}</td>
                    </tr>
                    <tr>
                        <th bgcolor="#CCD5DE">번호</th>
                        <td class="left">${qnaDto.qnaNo}</td>
                    </tr>
                    <tr>
                        <td colspan="2" class="left">${qnaDto.qnaAnswer}</td>
                    </tr>
            </table>
            <div class="row right">
                <a href="/qna/list"class="btn btn-navy">목록</a>
                <a class="btn btn-navy" href="/qna/fix?qnaNo=${qnaDto.qnaNo}">수정</a>
                <a class="btn btn-navy" href="/qna/delete?qnaNo=${qnaDto.qnaNo}">삭제</a>
            </div>
        </div>
    </div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>