<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

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
                    <div class="row pr-20 pb-20">
                        <c:choose>
                            <c:when test="${productDto.productType =='냉동'}">
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

        </div>
    </form>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>