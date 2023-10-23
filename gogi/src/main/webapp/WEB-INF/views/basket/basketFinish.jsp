<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
.btn-select {
	border: none;
	background-color: white;
	font-size: 16px;
}

.btn-select:hover {
	cursor: pointer;
}

.custom-checkbox {
	display: inline-block;
	font-size: 18px;
	position: relative;
	padding-top: 5px;
}

.custom-checkbox>[type=checkbox] {
	display: none;
}

.custom-checkbox>span {
	display: inline-block;
	width: 1em;
	height: 1em;
	background-image: url("/images/checkbox/checkbox-empty.png");
	background-size: 100%;
	background-position: center;
	background-repeat: no-repeat;
}

.custom-checkbox>[type=checkbox]:checked+span {
	background-image: url("/images/checkbox/checkbox-check.png");
}
/* 버튼 스타일 */
.btn-decrease-quantity, .btn-increase-quantity {
	font-size: 20px;
	background-color: white;
	color: #012D5C;
	border: none;
	padding: 4px 12px;
	cursor: pointer;
}

/* input 스타일 */
.quantity {
	width: 10px;
	font-size: 16px;
	border: none;
	padding-top: 8px;
}

.pCount {
	border: 1px solid #ddd;
	border-radius: 3px;
	width: 80px;
	height: 35px;
}

.totalPrice {
	width: 300px;
	align-items: center;
	border: 1px solid #F4F6F8;
	border-radius: 3px;
	background-color: #F4F6F8;
}

.w-90.line {
	background: #D0D9E1;
	height: 1px;
	border: 0;
}

.form-input.address {
	font-size: 14px;
	height: 2.4em;
}

.image {
	vertical-align: middle;
}
</style>

<script src="/js/checkbox.js"></script>

<!--daum 우편 API cdn-->
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<!--포트원 API cdn-->
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<!-- javascript 작성 공간 -->


<div class="container w-1000">
	<div class="row pb-30" >
		<h2>${sessionScope.name} 님 결제가 완료되었습니다</h2>
	</div>
	<div class="row" >
		<hr>
	</div>
	

<div class="container w-800 pt-20">
    <table class="table table-slit" >
			<tbody>
			  <div class="row left  pb-10"><h3>결제 목록</h3></div>
			
			
<%-- 			<c:if test="${sessionScope.name == '${findDto.getMemberId()}'}"></c:if> --%>
			<c:forEach var="basketListDto" items="${basketList}">
				<tr>
				
				
					<td class="image">
						<div class="row">
							<c:choose>
								<c:when test="${basketListDto.image}">
	                        		<img src="image?productNo=${basketListDto.productNo}" width="50" height="50">
	                    		</c:when>
	                    		<c:otherwise>
	                            	<img src="https://dummyimage.com/50x50/000/fff" width="50" height="50">
	                    		</c:otherwise>
							</c:choose>
						</div>
					</td>
					
					<td class="left w-60">
						<div class="row pt-10 left">
							<!-- 제목을 누르면 상세페이지로 이동 -->
							<a class="link" href="${pageContext.request.contextPath}/product/detail?productNo=${basketListDto.basketListNo}">
								<h4>${basketListDto.productName}</h4>
							</a>
						</div>
					</td>
					<td class="row right w-10">
					<!-- <input type="number" min="1" max="10" name="count"> -->
							<div class="row  count quantity" onchange="calculate(this);">${basketListDto.getBasketCount()}</div>					
					</td>

					<td class="right w-16">
						<div class="row right pr-20">
							<span class="pay">${basketListDto.productPrice}</span><span>원</span>
						</div>
					</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
</div>
		<div class="row pt-20" >
			<a href="${pageContext.request.contextPath}/" class="btn btn-navy pt-10">메인 페이지로 이동</a>
		</div>
</div>






<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>