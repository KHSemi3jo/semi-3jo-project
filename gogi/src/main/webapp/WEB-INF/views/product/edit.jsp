<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:choose>
	<c:when test="${sessionScope.level == '관리자'}">
		<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>
	</c:when>
	<c:otherwise>
		<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>	
	</c:otherwise>
</c:choose>
   <script>
   $(function(){
	   var initialProductName = $("[name=productName]").val();
       var initialProductPrice = parseFloat($("[name=productPrice]").val()); // 가격을 숫자로 변환
       var initialProductWeight = parseFloat($("[name=productWeight]").val()); // 무게를 숫자로 변환
       var initialProductOrigin = $("[name=productOrigin]").val();
	   
       $(".btn-save").click(function(e){
    	   
    	// 입력 필드의 값을 가져와서 길이 확인
           var productName = $("[name=productName]").val();
           var productPrice = parseFloat($("[name=productPrice]").val()); // 가격을 숫자로 변환
           var productWeight = parseFloat($("[name=productWeight]").val()); // 무게를 숫자로 변환
           var productOrigin = $("[name=productOrigin]").val();


        // 사용자가 이름, 가격, 중량, 원산지 중 하나라도 변경한 경우
           if (productName != initialProductName || productPrice != initialProductPrice || productWeight != initialProductWeight || productOrigin != initialProductOrigin) {
               // 입력 필드가 비어있거나 가격 또는 무게가 0이면 등록 버튼 비활성화하고 메시지 표시
               if (productName.length == 0 || isNaN(productPrice) || isNaN(productWeight) || productOrigin.length == 0 || productPrice <= 0 || productWeight <= 0) {
                   event.preventDefault();
                   alert("가격과 무게는 0보다 큰 값을 가져야 합니다. 빈 칸을 채워주세요.");
               }
           }
        
       });
            
   }); 
    </script>
    <div class="container w-600 navy">
        <div class="row pb-20 pt-30">
            <h2 >상품 정보 수정</h2>
        </div>

        <form action="edit" method="post" enctype="multipart/form-data" autocomplete="off">
        <input type="hidden" name="productNo" value="${productDto.productNo}">
            <hr class="navy">
                <div class="row flex-container pt-20 pl-20">
                    <div class="row w-25 left">
                        <label>상품 이미지</label>
                    </div>
                    <div class="row w-75 pr-20">
                    	<div class="row container">
                    		<div class="row left">
		                        <c:if test="${productDto.image}">
		                            <img src="image?productNo=${productDto.productNo}" width="200" height="200">
		                        </c:if>
                    		</div>
                    		<div class="row left">
		                        <input type="file" name="attach">                    	
                    		</div>
                    	</div>
                    </div>
                </div>
                <div class="row flex-container pl-20">
                    <div class="row w-25 left">
                        <label>상품 타입</label>
                    </div>
                        <c:choose>
                           <c:when test="${productDto.productType =='냉동'}">
                    		<div class="row pr-20 pb-20">
                                <label class="custom-checkbox">
                                    <input type="radio"  name="productType" value="냉동" checked>
                                    <span ></span> 냉동
                                </label>
                            </div>
                            <div class="row pr-20">
                                <label class="custom-checkbox">
                                    <input type="radio"  name="productType" value="냉장">
                                    <span ></span> 냉장
                                </label>
                            </div>
                            </c:when>
                            <c:otherwise>
                            <div class="row pr-20 pb-20">
                                <label class="custom-checkbox">
                                    <input type="radio"  name="productType" value="냉동">
                                    <span ></span> 냉동
                                </label>
                            </div>
                            <div class="row pr-20">
                                <label class="custom-checkbox">
                                    <input type="radio"  name="productType" value="냉장" checked>
                                    <span ></span> 냉장
                                </label>
                            </div>
                            </c:otherwise>
                        </c:choose>
                </div>
                <div class="row flex-container pl-20">
                    <div class="row w-25 left">
                        <label>상품 이름</label>
                    </div>
                    <div class="row w-75 pr-20">
                        <input type="text" name="productName" class="form-input w-100" value="${productDto.productName}">
                    </div>
                </div>
                <div class="row flex-container pl-20">
                    <div class="row w-25 left">
                        <label>상품 가격 (단위: 원)</label>
                    </div>
                    <div class="row w-75 pr-20">
                        <input type="number"  min='0'  step='100' name="productPrice" class="form-input w-100" value="${productDto.productPrice}">
                    </div>
                </div>
                <div class="row flex-container pl-20">
                    <div class="row w-25 left">
                        <label>상품 중량 (단위 : g)</label>
                    </div>
                    <div class="row w-75 pr-20">
                        <input type="number" min='0'  step='50' name="productWeight"class="form-input w-100"value="${productDto.productWeight}">
                    </div>
                </div>
               
                <div class="row flex-container pl-20">
                    <div class="row w-25 left">
                        <label>원산지</label>
                    </div>
                    <div class="row w-75 pr-20">
                        <input type="text" name="productOrigin" class="form-input w-100" value="${productDto.productOrigin}">
                    </div>
                </div>

                <hr class="mt-30">               
                <div class="row pt-10 pr-20">
                    <button type="submit" class="btn btn-orange btn-save w-25">상품 등록</button>
                    <a href="/product/list"class="btn btn-navy ">목록</a>
                </div>

   	 </form>
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>