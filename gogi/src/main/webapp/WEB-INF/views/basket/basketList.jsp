<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
    
</style>

<script src="/js/checkbox.js"></script>
<!-- javascript 작성 공간 --> 

<script>
		$(function(){
           	// "+" 버튼 클릭 시
	        $(".btn-plus").click(function () {
	            var count = $(this).parents('tr').find(".count"); // 수량을 표시하는 요소
	            var plusCount = parseInt(count.text()); // 현재 수량 가져오기
	            plusCount++; // 수량 증가
	            
	            count.text(plusCount); // 업데이트된 수량 표시
	        });
	
	        // "-" 버튼 클릭 시
	        $(".btn-minus").click(function () {
	            var count = $(this).parents('tr').find(".count"); // 수량을 표시하는 요소
	            var minusCount = parseInt(count.text()); // 현재 수량 가져오기
	            if (minusCount > 1) {
	                minusCount--; // 수량 감소
	                
	                count.text(minusCount); // 업데이트된 수량 표시
	            }
	        });
            

	        $(".check-item").click(function () {
	            var totalPay = $(".totalpay"); // 합계 금액을 표시하는 요소
	            var totalPrice = 0; // 총 가격 초기화

	            $(".check-item:checked").each(function () {
	                var price = parseInt($(this).parents('tr').find(".pay").text()); // 선택된 상품의 가격
	                var count = parseInt($(this).parents('tr').find(".count").text()); // 선택된 상품의 수량
	                var total = price * count; // 상품별 합계 금액
	                totalPrice += total; // 총 가격에 합산
	            });
	        
	            totalPay.text(totalPrice); // 합계 금액 업데이트
	        });
		        
            			
		});
            
        </script>

<form class="delete-form" action="delete" method="post">
	<div class="flex-container">
		<div style="width:950px;">
		<table class="table table-slit">
			<thead>
				<tr>
					<th>
						<!-- 전체선택 체크박스 -->
						<input type="checkbox" class="check-all">
						<span>전체선택</span>
						<span>|</span>
						<button type="submit" class="btn" ><span>선택삭제</span></button>
					</th>
					<th width="40%">상품명</th>
					<th>개수</th>
					<th>가격</th>
				</tr>
			</thead>
			<tbody>
<%-- 			<c:if test="${sessionScope.name == '${findDto.getMemberId()}'}"></c:if> --%>
			<c:forEach var="basketListDto" items="${basketList}">
				<tr>
					<td>
						<!-- 개별항목 체크박스 -->
						<input type="checkbox" class="check-item" name="basketNoList" value="${basketListDto.basketNo}">
					</td>
					<td>${basketListDto.basketNo}</td>
					<td align="left">
						<!-- 제목을 누르면 상세페이지로 이동 -->
						<a class="link" href="/product/detail?productNo=${basketListDto.basketListNo}">
							${basketListDto.productName}
						</a>
					</td>

					<td><button class="btn-plus" type="button" name="plus">+</button></td>


					<td class="count">
			<!-- <input type="number" min="1" max="10" name="count"> -->
					${basketListDto.getBasketCount()}
					</td>
					<td><button class="btn-minus" type="button" name="minus">-</button></td>

					<td class="pay">${basketListDto.productPrice}</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		</div>
		<div style="width:300px;">
		<c:forEach var="basketListDto" items="${basketList}" varStatus="i">
			<div>
			상품금액 :
				<span class="price"> 
<%-- 					<fmt:formatNumber pattern="###,###,###" value="${basketListDto.productPrice}"/>원 --%>
				</span>
			</div>

		
<!-- 			<div>할인금액 : </div> -->
<!-- 			<div>합계금액 : </div> -->
		</c:forEach>	
	<div class="flex-container">	합계금액  :  <div class="totalpay" name="total"></div>원</div>

			<div>
				<button class="btn btn-orange w-100">결제하기</button>
			</div>
		</div>
	</div>

</form>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>