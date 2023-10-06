<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
         	width: 100px; 
         	height:35px;   
         	justify-content: space-between;
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


.form-input.address{
 	font-size:14px;
	height:2.4em;
}
 
.image{ 
	vertical-align: middle; 
} 
   


</style>

<script src="/js/checkbox.js"></script>

<!--daum 우편 API cdn-->
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<!--포트원 API cdn-->
	<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<!-- javascript 작성 공간 --> 

<script>
function clickOnlyOne(itself){


	var addressId = "${sessionScope.name}";
	 $.ajax({
		 url: "/rest/address/list",
		 method: "post",
		 data: {
			 addressId: addressId
		 },
	   success: function(response){
	var checkboxes = document.getElementsByName("check-list");
			   checkboxes.forEach((checkbox) =>{
				   checkbox.checked =false;
			   })
			   
				   itself.checked = true;
			  
				
		   }	 
		   }
	 )}
	 
function clickOnlyOne1(itself){


	var addressId = "${sessionScope.name}";
	 $.ajax({
		 url: "/rest/address/list",
		 method: "post",
		 data: {
			 addressId: addressId
		 },
	   success: function(response){
	var checkboxes = document.getElementsByName("pay-list");
			   checkboxes.forEach((checkbox) =>{
				   checkbox.checked =false;
			   })
			   
				   itself.checked = true;
			  
				
		   }	 
		   }
	 )}
	

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
         } 
         else {
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
         
         }   $(".productpay").text( total );
         
         if (total == 0) {
	          $(".totalpay").text("0");
	     } 
	     else {
	          $(".totalpay").text(total+3000);
	      
	     }
     };
      

      $(".btn-plus").click(function() {
         var count = $(this).parents('tr').find(".count"); // 수량을 표시하는 요소
         var plusCount = parseInt(count.text()); // 현재 수량 가져오기
         if(plusCount <10){
         plusCount++; // 수량 증가
         count.text(plusCount); // 업데이트된 수량 표시   
         reload();       
        	 
         }

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


$(function(){
    //검색버튼, 우편번호 입력창, 기본주소 입력창을 클릭하면 검색 실행
    $(".post-search").click(function(){
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } 
                else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.querySelector("[name=addressPost]").value = data.zonecode;
                document.querySelector("[name=addressNormal]").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.querySelector("[name=addressDetail]").focus();
        }
    }).open();
    });
});


            $(function () {
            	  
                $(".address-insert-form").submit(function (e) {
                	 var addressId = "${sessionScope.name}";
                   var addressName = "${sessionScope.customer}";
                   var addressPhone = "${sessionScope.phone}";
                    e.preventDefault();
                    $.ajax({
                        url: "/rest/address/add",
                        method: "post",
                        data: $(e.target).serialize(),
                        success: function (response) {
                        	 console.log("더하기"+response)
                             reloadList();

                        }
                    });
                    
                });
                reloadList();
                function reloadList() {

                    var params = new URLSearchParams(location.search);
                    var addressNo = params.get("addressNo");
                    var addressPost = params.get("addressPost");
                    var addressNormal = params.get("addressNormal");
                    var addressDetail = params.get("addressDetail");
                    var addressId = "${sessionScope.name}";
                    var addressName = params.get("addressName");
                    var addressPhone = params.get("addressPhone");

                    $.ajax({
                        url: "/rest/address/list",
                        method: "post",
                        data: {
                            addressId: addressId
                        },
                        success: function (response) {
                            $(".address-list").empty();
      
              
                            for (var i = 0; i < response.length; i++) {
                                var address = response[i];
                                var template = $("#address-template").html();
                                var htmlTemplate = $.parseHTML(template);             
                                
                                $(htmlTemplate).find(".addressId").text(
                                    "아이디 : " + address.addressId || "탈퇴한 사용자");
                                
                                $(htmlTemplate).find(".addressName").text(
                                        "받으실 분 : " +  address.addressName);
                                $(htmlTemplate).find(".addressPhone").text(
                                        "연락처 : " +  address.addressPhone);
                                
                                $(htmlTemplate).find(".addressPost").text(
                                    "우편번호 : " + address.addressPost);
                                $(htmlTemplate).find(".addressNormal").text(
                                    "기본 주소 : " + address.addressNormal);
                                $(htmlTemplate).find(".addressDetail").text(
                                    "상세 주소 : " + address.addressDetail);  
                                
                                if (addressId.length == 0
                                    || addressId != address.addressId) {

                                    $(htmlTemplate).find(".w-25").empty();
                                }
                                $(htmlTemplate).find(".btn-delete").attr(
                                    "data-address-no", address.addressNo)
                                    .click(
                                        function (e) {
                                            var addressNo = $(this).attr(
                                                "data-address-no");
                                            if (confirm("정말 삭제하시겠습니까?")) {
                                                $.ajax({
                                                    url: "/rest/address/delete",
                                                    method: "post",
                                                    data: {
                                                        addressNo: addressNo
                                                    },
                                                    success: function (response) {
                                                        reloadList();
                                                    },
                                                });
                                            }
                                            else {
                                                alert("취소하였습니다.")
                                            }
                                        });
                     
                                $(htmlTemplate)
								.find(".btn-edit")
								.attr("data-address-name", address.addressName)
								        $(htmlTemplate)
								.find(".btn-edit")
								.attr("data-address-phone", address.addressPhone)
                                $(htmlTemplate)
								.find(".btn-edit")
								.attr("data-address-post", address.addressPost)
								       $(htmlTemplate)
								.find(".btn-edit")
								.attr("data-address-normal", address.addressNormal)
								       $(htmlTemplate)
								.find(".btn-edit")
								.attr("data-address-detail", address.addressDetail)

                                $(htmlTemplate)
								.find(".btn-edit")
								.attr("data-address-no", 	address.addressNo)
								.click(function() {
											var editTemplate = $(
													"#address-edit-template")
													.html();
											var editHtmlTemplate = $
													.parseHTML(editTemplate);	
											var addressNo = $(this).attr(
											"data-address-no");
											var addressName = $(this).attr(
											"data-address-name");
											var addressPhone = $(this).attr(
											"data-address-phone");
											var addressPost = $(this).attr(
											"data-address-post");
											var addressNormal = $(this).attr(
											"data-address-normal");
											var addressDetail = $(this).attr(
											"data-address-detail");
										
								console.log(this);
								
											
											$(editHtmlTemplate).find(".post-search").click(function(){
											    new daum.Postcode({
											        oncomplete: function(data) {
											            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

											            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
											            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
											            var addr = ''; // 주소 변수
											            var extraAddr = ''; // 참고항목 변수

											            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
											            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
											                addr = data.roadAddress;
											            } else { // 사용자가 지번 주소를 선택했을 경우(J)
											                addr = data.jibunAddress;
											            }
											            // 우편번호와 주소 정보를 해당 필드에 넣는다.
											            document.querySelector("[name=addressPost]").value = data.zonecode;
											            document.querySelector("[name=addressNormal]").value = addr;
											            // 커서를 상세주소 필드로 이동한다.
											            document.querySelector("[name=addressDetail]").focus();
											        }
											    }).open();
											})
											
											
											  var addressId = "${sessionScope.name}";
			
											$(editHtmlTemplate).find(
													"[name=addressNo]")
													.val(addressNo);
											$(editHtmlTemplate)
													.find(
															"[name=addressId]")
													.val(address.addressId);
											$(editHtmlTemplate).find(
											"[name=addressName]")
											.val(address.addressName);
											$(editHtmlTemplate).find(
											"[name=addressPhone]")
											.val(address.addressPhone);
											$(editHtmlTemplate).find(
											"[name=addressPost]")
											.val(address.addressPost);
											$(editHtmlTemplate).find(
											"[name=addressNormal]")
											.val(address.addressNormal);
											$(editHtmlTemplate).find(
											"[name=addressDetail]")
											.val(address.addressDetail);
									
								
											$(editHtmlTemplate)
													.find(".btn-cancel")
													.click(
															function() {
																$(this).parents(
																				".edit-container").prev(
																				".view-container").show();
																$(this).parents(
																				".edit-container").remove();});

											$(editHtmlTemplate).submit(function(e) {
															
																e.preventDefault();
																$.ajax({
																			url : "/rest/address/edit",
																			method : "post",
																			data : $(e.target).serialize(),
																			success : function(response) {
																				console.log("재확인"+response)
																				reloadList();
																			}
																		});
															});
											$(this).parents(".view-container")
													.hide().after(editHtmlTemplate);
											 document.querySelector("[name=addressName]").value = addressName;
											 document.querySelector("[name=addressPhone]").value = addressPhone;
											 document.querySelector("[name=addressPost]").value = addressPost;
												document.querySelector("[name=addressNormal]").value =addressNormal;
				                 		   document.querySelector("[name=addressDetail]").value =addressDetail;
											
										});
                                            
                                  $(".address-list").append(htmlTemplate);
                            }
                          
                        },
                    })
                }
                reloadList();

            });


        </script>


 <script id="address-template" type="text/template">
 
<div class=" flex-container view-container left pb-10" >


		<div class="flex-container table table-slit">
			<div class="w-30">
				<div class="row left">
                   <label class="custom-checkbox">
                   <input type="checkbox" class=" check-item" name="check-list"  
                   onclick="clickOnlyOne(this)"><span></span></label>
					<span class="addressId pl-10">아이디</span>
				</div>
				<div class="row left pl-30">
					<pre class="addressName">성함</pre>
				</div>
				<div class="row left pl-30">
					<pre class="addressPhone">전화번호</pre>
				</div>
			</div>
			<div class="w-70 pt-10 left">
				<div class="row left pl-30">
					<pre class="addressPost">우편번호</pre>
				</div>
				<div class="row left pl-30">
					<pre class="addressNormal">기본주소</pre>
				</div>
				<div class="row left pl-30">
					<pre class="addressDetail">상세주소</pre>
				</div>
			<div>
			</div>
			<div class="container">
				<div class="row address-btn right">
					<button class="btn btn-edit btn-navy">
						 수정
					</button>
					<button class="btn btn-orange btn-delete">
						삭제
					</button>
				</div>
			</div>

</div>

</script>


<script id="address-edit-template" type="text/template">


<form class="address-edit-form edit-container left container" >
 	<div class="pb-10"><hr></div>
	<input type="hidden" name="addressNo">
	<input type="hidden" name="addressId" >
		<div class=" flex-container">

			<div class="w-30">

		    <div class="flex-container">
                    <div class="w-40 left">
                        <label>받으실 분</label>
                    </div>
                    <div class="w-60">
                      <input type="text" name="addressName" value="" 
                     class="form-input  address w-100" required autocomplete="off">
                    </div>
             </div>

			 <div class="flex-container">
                     <div class="row w-40 left">
                         <label>연락처</label>
                     </div>
                     <div class="row w-60 left">
                         <input type="tel" name="addressPhone" value=""
                                class="form-input address w-100"autocomplete="off">
                         <div class="fail-feedback left">휴대폰 번호를 입력해주세요</div>
                     </div>
              </div>
   			  </div>

			<div class="w-70 left">

		     <div class="flex-container pl-10">
                     <div class="w-15 left pl-10">
                         <label >주소</label>
                     </div>
                     <div class="w-85 left">
                         <input type="text" name="addressPost" class="form-input address post-search"
                                size="6" maxlength="6"value="" autocomplete="off">
                         <button type="button" class="btn post-search form-input address">
                            <i class="fa-solid fa-magnifying-glass"></i>
                         </button>
						<div class="row">
                           <input type="text" name="addressNormal"autocomplete="off"
                      	    class="form-input address post-search w-100 " value="addressNormal">
						</div>
						<div class="row">
                            <input type="text" name="addressDetail"  value="addressDetail"
                             class="form-input address w-100" autocomplete="off">
                         <div class="fail-feedback left">주소 입력시 모든 주소를 작성해주세요</div>
                    	</div>
                    </div>
             </div>

				</div>
			</div>
			<div class="container">
				<div class="row right">
					<button type="submit" class="btn btn-navy">
						수정
					</button>
					<button type="button" class="btn btn-orange btn-cancel">
						취소
					</button>
				</div>
			</div>

		</form>



</script>
        
    

<script>
	const userCode = "imp14397622";
	IMP.init(userCode);

	 
	
	function requestPay() {
	
		
		
		
			if($("[name=check-list]").is(":checked") == false){
		return	alert("배송지를 체크해주세요.")
		}
		else{
			var addressName=	$("[name=check-list]:checked").parents(".view-container").find(".btn-edit").attr("data-address-name");
			 var addressPost=	$("[name=check-list]:checked").parents(".view-container").find(".btn-edit").attr("data-address-post");
			 var addressNormal=	$("[name=check-list]:checked").parents(".view-container").find(".btn-edit").attr("data-address-normal");
			 var addressDetail=	$("[name=check-list]:checked").parents(".view-container").find(".btn-edit").attr("data-address-detail");
			 var addressPhone=	$("[name=check-list]:checked").parents(".view-container").find(".btn-edit").attr("data-address-phone");
			 var paymethod=	$("[name=pay-list]:checked").attr("data-pay-list");
			

					 IMP.request_pay({
							pg: "html5_inicis",
							pay_method: paymethod,
							merchant_uid: "test_lnbn6gsr",
							name: addressName+"님 테스트 결제",
							amount: $(".totalpay").text(),
							buyer_name: addressName,
							buyer_tel: addressPhone,
							 buyer_addr: addressNormal+addressDetail,
							    buyer_postcode: addressPost,
							m_redirect_url: "{http://localhost:8080/basket/finish}"
						  }, 
						  function (rsp) { // callback
							  if (rsp.success) {
								  location.href = "http://localhost:8080/basket/finish";
							  } else { alert("사용자의 결재가 취소되었습니다.");}
						  });
						}
	}

	</script>

<div class=" container w-1100 top-select  ms-50" >
   <div class="row left"><h3>배송지 목록</h3></div>
   <div class="w-100"><hr></div>
   <div class="row left"><span>배송지에 따라 상품정보가 달라질 수 있습니다.</span></div>
	<div class="row flex-container">
		<div class="row w-60">
		  	<div class="address-list " ></div>
		</div>
		<div class="row w-40">
			<c:if test="${sessionScope.name != null}">
				<div class="container w-400 pl-10">
					<form class="address-insert-form" method="post" autocomplete="off">			
					<input type="hidden" name="addressId" class="form-input address" value=" ${sessionScope.name}">
						
						<div class=" flex-container" >
							<div  class="row w-25 left">
								<span>이름 </span>
							</div>		
							<div class="row w-75 left">
								<input name="addressName" class="form-input address w-55" value=" ${sessionScope.customer}">
							</div>
						</div>
						
						<div class="flex-container" >
							<div class="row w-25 left" >
								<span>연락처 </span>
							</div>
							<div class="row w-75 left">
								<input name="addressPhone" class="form-input address w-55" value="${sessionScope.phone}">
							</div>	
						</div>
						
						<div class="flex-container" >
							<div class="row w-25 left" >
								<span>우편번호 </span> 
							</div>
							<div class="row w-75 left">	
								<input type="text" name="addressPost" maxlength="6" size="6"class="form-input address post-search"readonly>
								<button type="button" class="btn post-search form-input address"><i class="fa-solid fa-magnifying-glass"></i> </button>	                            
				            </div>         
						</div>
						
						<div class="flex-container" >
							<div class="row w-25 left" >
								<span>기본주소 </span> 
							</div>
							<div class="row w-75 left">
								<input type="text" name="addressNormal" class="form-input address w-100"readonly>
							</div>
						</div>
						
						<div class="flex-container" >							
							<div class="row w-25 left" >
								<span>상세주소  </span>
							</div>
							<div class="row w-75 left">
								<input type="text" name="addressDetail" class="form-input address w-100">
							</div>
						</div>	
							
						<div class="row">
							<button class="btn btn-orange ">
								<i class="fa-solid fa-plus"></i> 새 배송지 추가
							</button>
						</div>			
					</form>
				</div>
			</c:if>
		</div>
	</div>

</div>


<form class="delete-form" action="delete" method="post">
	<div class="container w-1100">
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
		<div class="row w-800">
		
		<table class="table table-slit" >
			<tbody>
			<c:choose>
				<c:when test="${empty basketList}">
					<span>장바구니가 비어 있습니다</span>
				</c:when>
				<c:otherwise>
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
													<div class="count quantity" onchange="calculate(this);">${basketListDto.getBasketCount()}</div>					
								<button class="btn-plus btn-increase-quantity" type="button" name="plus">+</button>
							</div>
						</td>
	
						<td class="right w-16"><span class="pay">${basketListDto.productPrice}</span><span>원</span></td>
					</tr>
				</c:forEach>
				</c:otherwise>
			</c:choose>
			</tbody>
		</table>
		      <div class="row left">
	<br>
	
	</div> 
		
	<br>
		
		</div>
		</form>
	
			<div class="row w-300 ms-30">
		
					
					<div class="container totalPrice">
							<div class="row float-container">
								<div class="row w-50 float-left left pl-20">
									<div>상품금액 </div>
								</div>
								<div class="row w-50 float-right right pr-20">
									<span class="productpay" name="total"></span><span>원</span>
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
							<div class="row float-container">
								<div class="row w-50 float-left left pl-20">
									<div>결제종류</div>
								</div>
								<div class="row w-50 float-right right pr-20">
							    <label class="custom-checkbox">	
							<div><input type="checkbox" name="pay-list" data-pay-list="card" onclick="clickOnlyOne1(this)" checked="checked">카드결재<span></span></div></label>
						  <label class="custom-checkbox">		<div><input type="checkbox" name="pay-list"  data-pay-list="trans" onclick="clickOnlyOne1(this)">계좌이체<span></span></div></label>
						  <label class="custom-checkbox">		<div><input type="checkbox" name="pay-list"  data-pay-list="vbank" onclick="clickOnlyOne1(this)">가상계좌이체<span></span></div></label>
								  <label class="custom-checkbox">			<div><input type="checkbox" name="pay-list"  data-pay-list="phone" onclick="clickOnlyOne1(this)">핸드폰결재<span></span></div></label>
						  <label class="custom-checkbox">			<div><input type="checkbox" name="pay-list"  data-pay-list="cultureland" onclick="clickOnlyOne1(this)">핸드폰결재<span></span></div></label>
								</div>
							</div>	 
					</div>
		
					<div class="row  btn-pay btn btn-orange w-100"    onclick="requestPay()">
		결재하기</div>				
			

			</div>
	</div>
</div>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>