<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script>
    $(function(){
        $(".btn-basket").click(function(){
        	
            $.ajax({
                url:"http://localhost:8080/rest/basket/add",
                method:"post",
                data:{productNo:productNo},
                success:function(){
                    
                }
            });
        });
    });
</script>

<div class="row">
<form action="list" method="get">
<c:choose>
	<c:when test="${vo.type == 'productName'}"></c:when>
	<c:otherwise>
	<select name="type">
	<option value="product_name" selected>상품이름</option>
	</select>
	</c:otherwise>
</c:choose>
	<input  class="form-inptut" type="search" name="keyword" placeholder="검색어를 입력해주세요"
	required>
	<button type="submit" class="btn btn-navy">
	<i class="fa-solid fa-magnifying-glass"></i>
	검색</button>
	</form>
	</div>

		<div class="container w-500">
	<c:forEach var="productDto" items="${list}">
		<div class="row">
		<c:choose>
		<c:when test="${productDto.image}">
			<img src="image?productNo=${productDto.productNo}" width="200" height="200">
		</c:when>
		<c:otherwise>
			<img src="https://dummyimage.com/200x200/000/fff" width="200" height="200">
		</c:otherwise>
	</c:choose>
	</div>
		<div class="row">

			

			<a class="link" href="detail?productNo=${productDto.productNo}">${productDto.productNo}</a> /
			

			 ${productDto.productName}/
			  ${productDto.productPrice}원
			
		<a href="add?productNo=${productDto.productNo}">등록</a>
		<a href="edit?productNo=${productDto.productNo}">수정</a>
		<a href="delete?productNo=${productDto.productNo}">삭제</a>
		<div>
		<button class="btn-basket">담기</button>
		</div>
		<hr>
		</div>
	</c:forEach>
		</div>
	<div class="row page-navigator mv-30">
	<!-- 이전 버튼 -->
	<c:if test="${!vo.first}">
	<a href= "list?${vo.prevQueryString}">&lt;</a>
	</c:if>
	
	<!-- 숫자 버튼 -->
	<c:forEach var="i" begin="${vo.begin}" end="${vo.end}" step="1">
	<a href="list?${vo.getQueryString(i)}">${i}</a>
</c:forEach>
		
		<!-- 다음 버튼 -->
	<c:if test="${!vo.last}">
	<a href= "list?${vo.nextQueryString}">
	&gt;</a>
	</c:if>
	</div>


















<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>