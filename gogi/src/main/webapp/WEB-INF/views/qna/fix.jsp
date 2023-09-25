<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

    <div class="container w-800">
        <div class="row">
            <h2 class="pt-30 pb-30">자주하는 질문 수정</h2>
        </div>
        <hr>
        <form action="fix" method="post">
            <input type="hidden" name="qnaNo" value="${qnaDto.qnaNo}">
                <div class="row">
                    <div class="row flex-container">
                        <div class="row w-25 ">
                            <label>제목</label>
                        </div>
                        <div class="row w-75 pr-30">
                            <input type="text" required class="form-input w-100" name="qnaTitle"
                            value="${qnaDto.qnaTitle}">
                        </div>
                    </div>
                    <div class="row flex-container">
                        <div class="row w-25">
                            <label>내용</label>
                        </div>
                        <div class="row w-75 pr-30">
                            <textarea name="qnaAnswer" class="form-input w-100" cols="30" rows="10">${qnaDto.qnaAnswer}</textarea>
                        </div>
                    </div>
                    <div class="row right  pr-30">
                        <a class="btn btn-navy" href="/qna/list">목록</a>
                        <button href="/one/delete?ontNo=${qnaDto.qnaNo}"class="btn btn-orange">삭제</button>
                        <button type="submit"class="btn btn-orange">등록</button>
                    </div>
                </div>
              </form>
    </div>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>