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
	var count = $("[name=count]").val();
	$(".btn-plus").on("click", function(){
		$("[name=count]").val(count++);
	});
	$(".btn-minus").on("click", function(){
		if(count > 1){
			$("[name=count]").val(count--);	
		}
	});
</script>


<script>
            $(function () {

                $(".btn-plus").click(function () {
                	
                        var basketCount =  $(this).parents('tr').find("[name=count]").text();

                        $.ajax({
                            url: "/rest/basket/selectPrice",
                            method: "post",
                            data: { basketCount: basketCount },
                            success: function (response) {
                            	var result;
                            	basketCount++;
                            	 console.log( basketCount);
                			
                                $("[name=count]").text(basketCount);
                            }
                        })
                    })
                    
                    $(".btn-minus").click(function () {
                	  	
                        var basketCount =  $(this).parents('tr').find("[name=count]").text();

                        $.ajax({
                            url: "/rest/basket/selectPrice",
                            method: "post",
                            data: { basketCount: basketCount },
                            success: function (response) {
 
                            	var result;
                            	basketCount--;
                            	 console.log( basketCount);
                			
                                $("[name=count]").text(basketCount);
                            }
                        })
                    })



                $(".check-item").click(function () {

                    var param = [];
                    var selectList = [];
                    var productPrice = $(this).parents('tr').find(".pay").text();
                    var basketCount = $(this).parents('tr').find(".count").text();

                  



                    $(".check-item:checked").each(function (i) {
                        selectList = {

                            // basketNo: $(this).parents('tr').find(".no").text(),
                            productPrice: $(this).parents('tr').find(".pay").text(),
                            basketCount: $(this).parents('tr').find(".count").text()
                        };

                        //param 배열에 selectList 오브젝트를 담는다.
                        param.push(selectList);
                    });

                    $.ajax({
                        type: "post",
                        url: "/rest/basket/selectPrice",
                        headers: {
                            "content-type": "application/json"
                        },
                        data: JSON.stringify(param),
                        dateType: "text",

                        success: function (response) {
                            //   $(".totalpay").text("테스트"),
                            console.log(param.length);
                            var result = 0;
                            for (var i = 0; i < param.length; i++) {

                                var result = productPrice * basketCount + result;
                                //	  console.log(result);
                            } console.log(result);
                            //    console.log("금액 :"+productPrice);
                            //  console.log("수량 :"+basketCount);
                            console.log(result);
                            $(".totalpay").text(result);
                        },


                    });

                });
            })
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
					<td><button class="btn-plus" type="button">+</button></td>

					<td class="count"><intput type="number" min="1" max="10" name="count">${basketListDto.getBasketCount()}</td>


					<td><button class="btn-minus" type="button">-</button></td>
					<td class="pay">${basketListDto.productPrice}</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		</div>
		<div style="width:300px;">
		<c:forEach var="basketListDto" items="${basketList}" varStatus="i">
			<div>
				<span>상품금액 : 
					<fmt:formatNumber pattern="###,###,###" value="${basketListDto.productPrice}"/>원
				</span>
			</div>

		
<!-- 			<div>할인금액 : </div> -->
<!-- 			<div>합계금액 : </div> -->
		</c:forEach>	
	<div class="flex-container">	합계금액  :  <div class="totalpay"></div>원</div>

			<div>
				<button class="btn btn-orange w-100">결제하기</button>
			</div>
		</div>
	</div>

</form>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>