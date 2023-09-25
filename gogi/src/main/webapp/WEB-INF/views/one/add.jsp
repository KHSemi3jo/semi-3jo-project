<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
select.form-input,
.opt{
	font-size:16px;
	height:2.8em;
    border-radius: 0.1em;
}
</style>

<div class="container w-800">
	<div class="row">
		<c:choose>
			<c:when test="${isReply}">
				<h2>답글 작성</h2>
			</c:when>
			<c:otherwise>
			<div class="row pb-30">
				<h2>1 : 1 문의</h2>
			</div>
			</c:otherwise>
		</c:choose>
	</div>

	<hr>

	<form action="add" method="post">
	
			<c:if test="${!isReply}" >
				<div class="row flex-container">
					<div class="row w-25 ">
						<label>카테고리</label> 
					</div>
					<div class="row w-75 pr-30 left selectBox">
						<select name="oneCategory"   required="required"
							class="form-input">
							<option class="opt" selected>결재</option>
							<option class="opt">회원</option>
							<option class="opt">기타문의</option>
						</select>
					</div>
				</div>
			</c:if>

		<div class="row">
			<c:if test="${isReply}">
				<input type="hidden" name="oneParent" value="${oneDto.oneNo}">
			</c:if>
			<div class="row flex-container">
				<c:choose>
					<c:when test="${isReply}">
							<div class="row w-25 ">
									<label>제목</label>
							</div>
							<div class="row w-75 pr-30">
									<input type="text" name="oneTitle" class="form-input w-100"
												value="RE: ${oneDto.oneTitle}">
							</div>
					</c:when>
					<c:otherwise>
						<div class="row w-25 ">
								<label>제목</label>
						</div>
						<div class="row w-75 pr-30">
							<input type="text" name="oneTitle" class="form-input w-100">				
						</div>
					</c:otherwise>
				</c:choose>
			</div>
			
			<div class="row flex-container">
				<div class="row w-25">
					<label>내용</label>
				</div>
				<div class="row w-75 pr-30">
					<textarea name="oneContent" class="form-input w-100" cols="30"
						rows="10"></textarea>
				</div>
			</div>
			<div class="row right  pr-30">
				<a class="btn btn-navy" href="/one/list">목록</a>
				<button type="submit" class="btn btn-orange">등록</button>
			</div>
		</div>
	</form>
</div>















<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>