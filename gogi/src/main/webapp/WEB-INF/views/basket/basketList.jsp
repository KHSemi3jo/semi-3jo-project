<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
 .btn-select{
 	border:none;
 	background-color: white;
 	font-size:16px;
 }
  .btn-select:hover{
  	cursor: pointer;
  }
  .top-select{
   padding-left:26px;
  }
  .custom-checkbox {
    display: inline-block;
    font-size: 18px;
    position: relative; 
    padding-top:5px;
}
.custom-checkbox > [type=checkbox] {
    display: none;
}
.custom-checkbox > span {
    display: inline-block;
    width: 1em;
    height: 1em;

    background-image: url("/images/checkbox/checkbox-empty.png");
    background-size: 100%;
    background-position: center;
    background-repeat: no-repeat;
}
.custom-checkbox > [type=checkbox]:checked + span {
    background-image: url("/images/checkbox/checkbox-check.png");
}

/* 버튼 스타일 */
        .btn-decrease-quantity,
        .btn-increase-quantity {
            font-size: 20px;
            background-color: white;
            color: #012D5C;
            border: none;
            padding: 4px 12px;
            cursor: pointer;
        }

        /* input 스타일 */
        .quantity{
            width: 10px;
            font-size: 16px;
            border: none;
            padding-top:8px;
            }
            
        .pCount{
            border: 1px solid #ddd;
            border-radius: 3px;
         	width: 80px; 
         	height:35px;   
        }
.totalPrice{
	width:300px;
	align-items:center;
    border: 1px solid #F4F6F8;
    border-radius: 3px;
    background-color:#F4F6F8;
}
.w-90.line{
	background:#D0D9E1;
	height:1px;
    border:0;
}
.image{
	vertical-align: middle;
}
</style>

<script src="/js/checkbox.js"></script>
<!-- javascript 작성 공간 --> 

<script>


$(function() {
	
	  reload();
	  
	  // "전체선택" 체크박스 클릭 처리
 	  $(".check-all").click(function() {
 	        
 	      var isChecked = $(this).prop("checked");

 	      $(".check-item").prop("checked", isChecked);

 	      // 체크박스가 선택되거나 선택 해제 될 때 총 결제 금액을 계산
 	      reload();
 	  });
	  
 	 $(".check-item").click(function(){
 		 reload();
 	 });


 	  // 전체선택 체크박스 상태 변수
    var isCheckAllChecked = false;

    // "전체선택" 체크박스 클릭 처리
    $(".check-all").click(function() {
        isCheckAllChecked = $(this).prop("checked");
        $(".check-item").prop("checked", isCheckAllChecked);
        // 체크박스가 선택되거나 선택 해제 될 때 총 결제 금액을 계산
        reload();
        // 전체선택 체크박스 상태에 따라 "선택 삭제" 버튼 활성화/비활성화
        $(".btn-select").prop("disabled", !isCheckAllChecked);
    });

     // 체크박스 상태 변화 감지
     $(".check-item").change(function() {
    	 reload();
         var checkedItems = $(".check-item:checked");
         // 체크된 항목이 하나 이상인 경우 버튼을 활성화, 그렇지 않으면 비활성화
         if (checkedItems.length > 0) {
             $(".btn-select").prop("disabled", false);
         } else {
             $(".btn-select").prop("disabled", true);
         }
     });

      //실시간 변경처리
      function reload(){
         
         var checkboxList = document.querySelectorAll(".check-item:checked");
         var total = 0;
         for (var i = 0; i < checkboxList.length; i++) {

            var count = $(checkboxList[i]).parents('tr').find(".count").text();
            var price = $(checkboxList[i]).parents('tr').find(".pay").text();
            total += count * price;
            $(".totalpay").text(total);
         }
         
         if (total == 0) {
	          $(".totalpay").text("0");
	     } 
	     else {
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

      	     	    
    	
});
        </script>

<form class="delete-form" action="delete" method="post">
	<div class="container w-1000">
		<div class="row left top-select navy">
		<!-- 전체선택 체크박스 -->
				<label class="custom-checkbox">
						<input type="checkbox" class="check-all" checked>
						<span></span> 
				</label>  <span class="pl-10 ">전체선택</span>
						<span class="pl-10 ">|</span>
						<button type="submit" class="btn-select " >선택삭제</button>
		</div>
	<div class="flex-container">
		<div class="row w-700">
		
		<table class="table table-slit">
			<tbody>
			
<%-- 			<c:if test="${sessionScope.name == '${findDto.getMemberId()}'}"></c:if> --%>
			<c:forEach var="basketListDto" items="${basketList}">
				<tr>
				
					<td>
						<label class="custom-checkbox">
								<!-- 개별항목 체크박스 -->
								<input type="checkbox" class="check-item" name="basketNoList"  
								value="${basketListDto.basketNo}" checked> <span></span>
						</label>
					</td>
					<td class="image">
						<c:choose>
							<c:when test="${basketListDto.image}">
                        		<img src="image?productNo=${basketListDto.productNo}" width="50" height="50">
                    		</c:when>
                    		<c:otherwise>
                            	<img src="https://dummyimage.com/50x50/000/fff" width="50" height="50">
                    		</c:otherwise>
						</c:choose>
					</td>
					<td class="left w-60">
						<!-- 제목을 누르면 상세페이지로 이동 -->
						<a class="link" href="/product/detail?productNo=${basketListDto.basketListNo}">
							${basketListDto.productName}
						</a>
					</td>
					<td class="row right w-10">
						<div class="row flex-container pCount">
							<button class="btn-minus btn-decrease-quantity" type="button" name="minus">-</button>
					<!-- <input type="number" min="1" max="10" name="count"> -->
							<div class="count quantity" onchange="calculate(this);">${basketListDto.getBasketCount()}</div>					
							<button class="btn-plus btn-increase-quantity" type="button" name="plus">+</button>
						</div>
					</td>

					<td class="right w-16"><span class="pay">${basketListDto.productPrice}</span><span>원</span></td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		
		</div>
		
			<div class="row w-300 ms-30">

					<div class="container totalPrice">
							<div class="row float-container">
								<div class="row w-50 float-left left pl-20">
									<div>상품금액  </div>
								</div>
								<div class="row w-50 float-right right pr-20">
									<span class="totalpay" name="total"></span><span>원</span>
								</div>
							</div>	
							<div class="row float-container">
								<div class="row w-50 float-left left pl-20">
									<div>배송비  </div>
								</div>
								<div class="row w-50 float-right right pr-20">
									<span  name="deliveryFee"></span>3000<span>원</span>
								</div>
							</div> 
							<div class="row"><hr class="w-90 line"></div>
							<div class="row float-container">
								<div class="row w-50 float-left left pl-20">
									<div>결제예정금액  </div>
								</div>
								<div class="row w-50 float-right right pr-20">
									<span class="totalpay" name="total"></span><span>원</span>
								</div>
							</div>	 
					</div>
					<div class="row"><button class="btn btn-orange w-100">결제하기</button></div>				

			</div>
	</div>
</div>
</form>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>