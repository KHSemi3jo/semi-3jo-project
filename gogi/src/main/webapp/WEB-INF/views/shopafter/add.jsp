<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>



<!-- SummerNote cdn -->
<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>

<style>

   p { text-align: left; }
</style>

<script>
	$(function() {
		$('[name=shopAfterContent]')
				.summernote(
						{
							placeholder : '내용을 작성하세요.',
							tabsize : 2, //탭을 누르면
							height : 300,
							maxHeight : 300,
							minHeight : 300,
							toolbar : [
									[
											'style',
											[ 'bold', 'italic', 'underline',
													'style' ] ],
									[ 'font', [ 'bold', 'underline', 'clear' ] ],
									[ 'color', [ 'forecolor', 'backcolor' ] ],
									[ 'para', [ 'ul', 'ol', 'paragraph' ] ],

									[ 'table', [ 'table' ] ],
									[ 'insert', [ 'link' ] ],
									[
											'view',
											[ 'fullscreen', 'codeview', 'help' ] ] ]
						});
	});
</script>


<div class="container w-600">
	<div class="row">
		<h1>상품후기 등록</h1>
	</div>
	<form action="add" method="post">
		<div class="row">
			제목 : <input type="text" required class="form-input w-100" name="shopAfterName">
		</div>
		<div class="row ">
			내용 :
			<textarea name="shopAfterContent" class="form-input w-100" cols="30" rows="10" ></textarea>
		</div>
		<div class="row">
			<button type="submit" class="btn w-100 btn-navy">등록</button>
	</form>
</div>




<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>