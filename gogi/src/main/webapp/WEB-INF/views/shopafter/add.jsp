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
							placeholder : '1000자 이내로 작성해주세요.',
							tabsize : 2, //탭을 누르면
							height : 300,
							maxHeight : 300,
							minHeight : 300,
					        toolbar : [
								['style',	[ 'bold', 'italic', 'underline' ] ],
								[ 'para', [ 'ul', 'ol', 'paragraph' ] ],
							]
						});
	});
</script>


<div class="container w-800">
    <div class="row">
        <h2 class="pt-30 pb-30 navy">상품후기 등록</h2>
    </div>
    <hr>
    <form action="add" method="post"autocomplete="off">
      
            <div class="row">
                <div class="row flex-container">
                    <div class="row w-25 ">
                        <label>제목</label>
                    </div>
                    <div class="row w-75 pr-30">
                        <input type="text" required class="form-input w-100" name="shopAfterName">
                    </div>
                </div>
                <div class="row flex-container">
                    <div class="row w-25">
                        <label>내용</label>
                    </div>
                    <div class="row w-75 pr-30">
                        <textarea name="shopAfterContent" class="form-input w-100" cols="30" rows="10"></textarea>
                    </div>
                </div>
                <div class="row right  pr-30">
                    <a class="btn btn-navy" href="${pageContext.request.contextPath}/shopafter/memberList">목록</a>
                    <button type="submit"class="btn btn-orange">등록</button>
                </div>
            </div>
    </form>
</div>




<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>