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
// 		$(function(){
// 			function total(){
// 		        $(".check-item").click(function () {
// 		            var totalPrice = 0; // 총 가격 초기화
// 		            var totalPay = $(".totalpay"); // 합계 금액을 표시하는 요소
	
// 		            $(".check-item:checked").each(function () {
// 		                var price = parseInt($(this).parents('tr').find(".pay").text()); // 선택된 상품의 가격
// 		                var count = parseInt($(this).parents('tr').find(".count").text()); // 선택된 상품의 수량
// 		                var total = price * count; // 상품별 합계 금액
// 		                totalPrice += total; // 총 가격에 합산
	           	
// 		            });
		        
// 		            totalPay.text(totalPrice); // 합계 금액 업데이트
// 		        });
				
// 			}
//          		// "+" 버튼 클릭 시
// 		        $(".btn-plus").click(function () {
// 		            var count = $(this).parents('tr').find(".count"); // 수량을 표시하는 요소
// 		            var plusCount = parseInt(count.text()); // 현재 수량 가져오기
// 		            plusCount++; // 수량 증가
		            
// 		            count.text(plusCount); // 업데이트된 수량 표시
// 		            total();
// // 		            calculate(this); // 총 가격 업데이트 함수 호출
// 		        });
		
// 		        // "-" 버튼 클릭 시
// 		        $(".btn-minus").click(function () {
// 		            var count = $(this).parents('tr').find(".count"); // 수량을 표시하는 요소
// 		            var minusCount = parseInt(count.text()); // 현재 수량 가져오기
// 		            if (minusCount > 1) {
// 		                minusCount--; // 수량 감소
		                
// 		                count.text(minusCount); // 업데이트된 수량 표시
// 		                total();
// // 		                calculate(this); // 총 가격 업데이트 함수 호출
// 		            }
// 		        });
            
// 			// 체크박스에 대한 이벤트 핸들러
// 		    $(".check-item").click(function () {
// 		        total(); // 체크박스가 클릭될 때 총 가격 업데이트
// 		    });
			
// 		 	// 페이지 로드 시 총 가격 초기화    
// 		    total();			
// // 		function calculate(tag) {
// //             //console.log(tag.value);//value를 읽는 방법
// //             //console.log(tag.dataset.price);//data-* 를 읽는 방법

// //             //체크되어 있는 모든 체크박스를 불러와서 data-price를 합쳐서 출력
// //             var checkboxList = document.querySelectorAll(".check-item:checked");
// //             var total = 0;
// //             for(var i=0; i < checkboxList.length; i++) {
// //                 //체크박스 위 -> 뒤 태그 불러오기
// // //                 var input = checkboxList[i].parentNode.nextElementSibling;
// //                 var count = parseInt($(this).parents('tr').find(".count").text());
// //                 var price = parseInt($(this).parents('tr').find(".pay").text());
// //                 total += count * price;
// //             }

// //             var div = document.querySelector(".totalpay");
// //             if (!isNaN(total)) {
// //                 div.textContent = total.toFixed(2); // 총 가격 업데이트
// //             } else {
// //                 div.textContent = "0.00"; // NaN인 경우 0.00으로 설정
// //             }
		
// //         }
// 		});

$(function() {
      
      function reload(){
         
         var checkboxList = document.querySelectorAll(".check-item:checked");
         var total = 0;
         for (var i = 0; i < checkboxList.length; i++) {

            var count = $(checkboxList[i]).parents('tr').find(".count").text();
            var price = $(checkboxList[i]).parents('tr').find(".pay").text();
            total = count * price+total;
            $(".totalpay").text(total);
         }
         };
      
      
      
      $(".btn-plus").click(function() {
         var count = $(this).parents('tr').find(".count"); // 수량을 표시하는 요소
         var plusCount = parseInt(count.text()); // 현재 수량 가져오기
         plusCount++; // 수량 증가
         count.text(plusCount); // 업데이트된 수량 표시   
         reload();
         

      });

      // "-" 버튼 클릭 시
      $(".btn-minus").click(function() {
         var count = $(this).parents('tr').find(".count"); // 수량을 표시하는 요소
         var minusCount = parseInt(count.text()); // 현재 수량 가져오기
         if (minusCount > 1) {
            minusCount--; // 수량 감소
            count.text(minusCount); // 업데이트된 수량 표시
            reload();
         }
      });
      
         
      
      
      
      $(".check-item").click(function(){
   
         var checkboxList = document.querySelectorAll(".check-item:checked");
         var total = 0;
         for (var i = 0; i < checkboxList.length; i++) {
            var count = $(checkboxList[i]).parents('tr').find(".count").text();
            var price = $(checkboxList[i]).parents('tr').find(".pay").text();
            total = count * price;

            console.log(count);
            console.log(total);
            
            $(".totalpay").text(total);
         }

		
            
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
						<input type="checkbox" class="check-item" name="basketNoList"  
						value="${basketListDto.basketNo}">
					</td>
					<td>${basketListDto.basketNo}</td>
					<td align="left">
						<!-- 제목을 누르면 상세페이지로 이동 -->
						<a class="link" href="/product/detail?productNo=${basketListDto.basketListNo}">
							${basketListDto.productName}
						</a>
					</td>

					<td><button class="btn-plus" type="button" name="plus">+</button></td>


					<td class="count" onchange="calculate(this);">
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

		

		</c:forEach>	
	<div class="flex-container">	합계금액  :  <div class="totalpay" name="total"></div>원</div>

			<div>
				<button class="btn btn-orange w-100">결제하기</button>
			</div>
		</div>
	</div>

</form>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>