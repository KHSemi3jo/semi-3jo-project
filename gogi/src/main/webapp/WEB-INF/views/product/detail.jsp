<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
.line{
    height: 0.1px;
    border: 0 none;
    background-color: #E5EAEE;
}
.count{
    padding: 0.5em;
    box-shadow : 0px 0px 0px 1px #E5EAEE;
    border-radius: 3px;
}
.name,
.price{
    font-size: 22px;
    font-weight: bold;
}
.origin{
    font-size: 20px;
    font-weight: 500;
}
.sTitle{
    font-size: 13px;
}
</style>
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
        $(".btn-pick").click(function(){
        	var params = new URLSearchParams(location.search);
        	var productNo = params.get("productNo");
        	
            $.ajax({
                url:"http://localhost:8080/rest/pick/add",
                method:"post",
                data:{productNo:productNo},
                success:function(){
                    
                }
            });
        });
    });
</script>

    <div class="row container 800">
        <div class="row flex-container">
            <div class="row w-40 pt-10">
                <c:choose>
                    <c:when test="${productDto.image}">
                        <img src="image?productNo=${productDto.productNo}" width="300" height="400">
                    </c:when>
                        <c:otherwise>
                            <img src="https://dummyimage.com/200x200/000/fff" width="300" height="400">
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="row w-500 pl-30">
                <div class="row left name">${productDto.productName}</div>
                <div class="row left price">${productDto.productPrice}원</div>
                <div class="row left origin">원산지: ${productDto.productOrigin}</div>
                <hr class="line">
                <div class="row flex-container">
                    <div class="row left w-25">중량/용량</div>
                    <div class="row left w-75">${productDto.productWeight}g</div>
                </div>                    
                <hr class="line">
                <div class="row flex-container">
                    <div class="row left w-25">유통기한</div>
                    <div class="row left w-75">${productDto.productExpire}</div>
                </div>                  
                <hr class="line">
                <div class="row flex-container">
                    <div class="row left w-25">상품선택</div>
                    <div class="row right w-75 count">
                        <div class="row left sTitle">${productDto.productName}</div>
                        <div class="row float-container">
                            <div class="row col-2 left">수량증가</div>
                            <div class="row col-2 right">${productDto.productPrice}</div>
                        </div>
                    </div>
                </div>  
                <hr class="line">
                <div class="row right">총상품금액:<span class="total">0</span>원</div>
                <div class="row flex-container">
                    <div class="row w-25">후기(36)</div>
                    <div class="row w-50 ">
                        <button class="btn btn-orange btn-basket w-100">장바구니담기</button>
                    </div>
                    <div class="row w-25">
                        <a class="btn btn-navy" href="list?productNo=${productDto.productNo}">목록</a>
                    </div>
                </div>
            </div>
        </div>
    </div>




<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>