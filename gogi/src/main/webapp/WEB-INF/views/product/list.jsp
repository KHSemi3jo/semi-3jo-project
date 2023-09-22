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

<form action="list" method="get">
<c:choose>
	<c:when test="${vo.type == 'product_name'}"></c:when>
	<c:otherwise>
	<select name="type">
	<option value="product_name" selected>상품이름</option>
	</select>
	</c:otherwise>
</c:choose>
	<input type="search" name="keyword" placeholder="검색어"
	value="${vo.keyword}" required>
	<button>검색</button>
	</form>


	<c:forEach var="productDto" items="${list}">
		<div class="container w-500">
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
		</div>
	</c:forEach>
	<c:if test="${!vo.first}">
	<a href= "list?${vo.prevQueryString}">&lt;</a>
	</c:if>
	<c:forEach var="i" begin="${vo.begin}" end="${vo.end}" step="1">
	<a href="list?${vo.getQueryString(i)}">${i}</a>
	</c:forEach>
	<c:if test="${!vo.last}">
	<a href= "list?${vo.prevQueryString}">&gt;</a>
	</c:if>


















<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>