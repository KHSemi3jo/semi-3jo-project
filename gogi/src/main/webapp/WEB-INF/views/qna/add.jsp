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


<!-- SummerNote cdn -->
<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>

<script>
	$(function() {
		$('[name=qnaAnswer]')
				.summernote(
						
						{
							placeholder : '최대 1000자까지 작성 가능합니다',
							tabsize : 2, //탭을 누르면
							height : 300,
							maxHeight : 300,
							minHeight : 300,
							toolbar : [
									[
											'style',
											[ 'bold', 'italic', 'underline',
													'style' ] ],
									[ 'para', [ 'ul', 'ol', 'paragraph' ] ],

									]
						});
	
	});
</script>




<div class="container w-800">
	<div class="row">
		<h2 class="pt-30 pb-30">자주하는 질문</h2>
	</div>
	<hr>
	<form action="add" method="post" autocomplete="off">

		<div class="row">

			<div class="row flex-container">
				<div class="row w-25  left pl-80">
					<label>카테고리</label>
				</div>
				<div class="row w-75 pr-30 left">
					<select name="qnaCategory" class="form-input">
						<option class="form-input">주문/결재/취소</option>
						<option class="form-input">교환/반품/AS</option>
						<option class="form-input">배송</option>
						<option class="form-input">쿠폰/마일리지</option>
						<option class="form-input">회원정보</option>
						<option class="form-input">기타</option>
					</select>

				</div>
			</div>
			<div class="row flex-container">
				<div class="row w-25  left pl-80">
					<label>제목</label>
				</div>
				<div class="row w-75 pr-30">
					<input type="text" required class="form-input w-100"
						name="qnaTitle" autocomplete="off" >
				</div>
			</div>
			<div class="row flex-container">
				<div class="row w-25 left pl-80">
					<label>내용</label>
				</div>
				<div class="row w-75 pr-30">
			
					<textarea name="qnaAnswer" id="summernote" class="form-input w-100"cols="30" rows="10" required ></textarea>

				</div>
			</div>
			<div class="row right  pr-30">
				<button type="submit" class="btn btn-orange">등록</button>
				<a class="btn btn-navy" href="/qna/list">목록</a>
			</div>
		</div>
	</form>
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>