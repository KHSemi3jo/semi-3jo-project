<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<button><a href="/one/list">1대1 목록</a></button>


<c:choose>
<c:when test="${isReply}">
<h2>답글 작성</h2>
</c:when>
<c:otherwise><h2>1대1 작성</h2>
</c:otherwise></c:choose>



<div class="container w-600">
	<div class="row">
		<h1>1대1 등록</h1>
	</div>
	<form action="add" method="post">
	

	<select name="type" required="required" class="form-input">
					<option value="shopAfter_name">결재</option>
					<option value="shopAfter_id" selected="selected">회원</option>
					<option value="shopAfter_content">기타문의</option>
				</select>
	<br>
	
	
	<c:if test="${isReply}">
	<input type="text" name="oneParent" value="${oneDto.oneNo}">
	</c:if>
	
	   <c:choose>
				<c:when test="${isReply}">
			제목 : 		<input type="text" name="oneTitle" class="form-input w-100"
								value="RE: ${oneDto.oneTitle}" >
				</c:when>
				<c:otherwise>
			제목 : 		<input type="text" name="oneTitle" class="form-input w-100">
				</c:otherwise>
			</c:choose>
	
	
	
		<div class="row ">
			내용 :
			<textarea name="oneContent" class="form-input w-100" cols="30" rows="10" ></textarea>
		</div>
		<div class="row">
			<button type="submit" class="btn w-100 btn-navy">등록</button>
	</form>
</div>




<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>