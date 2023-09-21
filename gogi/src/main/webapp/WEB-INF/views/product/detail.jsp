<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script>
    $(function(){
        $(".btn-basket").click(function(){
        	var params = new URLSearchParams(location.search);
        	var productNo = params.get("productNo");
        	
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

<div class="container w-500">
	<div class="row">
		<h1>상품 상세 페이지</h1>
	</div>
	<div class="row"></div>
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
		<h1>${productDto.productNo}</h1>;
	</div>
	<div class="row">
		<h1>${productDto.productName}</h1>
	</div>
	<div class="row">
	<h1>${productDto.productPrice}원</h1>
	</div>
	<div class="row">
	<h1>${productDto.productWeight}g</h1>
	</div>
	<div class="row">
	<h1>${productDto.productOrigin}</h1>
	</div>
	<div class="row">
	<h1>${productDto.productExpire}까지</h1>
	</div>
	<div class="row">
	<h1>${productDto.productType}</h1>
	</div>
	<div class="row">
	<h1>${productDto.productDate}</h1>
	</div>

	
	<div>
		<button class="btn-basket">담기</button>
	</div>
	
</div>

	<div class="row">
	<a href="list?productNo=${productDto.productNo}">목록으로</a>
	</div>
	









<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>