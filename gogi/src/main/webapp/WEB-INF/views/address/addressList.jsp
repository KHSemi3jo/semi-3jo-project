<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:choose>
	<c:when test="${sessionScope.level == '관리자'}">
		<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>
	</c:when>
	<c:otherwise>
		<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>	
	</c:otherwise>
</c:choose>



<style>
.noticeTitle {
	text-decoration: none;
}

select.form-input, .form-input, .btn.btn-navy {
	font-size: 16px;
	height: 2.8em;
	border-radius: 0.1em;
}
</style>

 <!--daum 우편 API cdn-->
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
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
                             reloadList();
                        	 $("[name=addressPost]").empty();
                        	 $("[name=addressNormal]").empty();
                        	 $("[name=addressDetail]").empty();

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
                    var addressName = "${sessionScope.customer}";
                    var addressPhone = "${sessionScope.phone}";

                    $.ajax({
                        url: "/rest/address/list",
                        method: "post",
                        data: {
                            addressId: addressId
                        },
                        success: function (response) {
                            $(".address-list").empty(); 
                            var customer = "${sessionScope.customer}";
                               var phone = "${sessionScope.phone}";
                            for (var i = 0; i < response.length; i++) {
                                var address = response[i];
                                var template = $("#address-template").html();
                                var htmlTemplate = $.parseHTML(template);
                        
                           
                               
                                
                                $(htmlTemplate).find(".addressId").text(
                                    "회원 아이디 : " + address.addressId || "탈퇴한 사용자");
                                
                                $(htmlTemplate).find(".addressName").text(
                                        "받으실 분 : " + address.addressName);
                                $(htmlTemplate).find(".addressPhone").text(
                                        "연락처 : " + address.addressPhone);
                                
                                $(htmlTemplate).find(".addressPost").text(
                                    "우편번호 : " + address.addressPost);
                                $(htmlTemplate).find(".addressNormal").text(
                                    "기본주소 : " + address.addressNormal);
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
											var addressPost = $(this).attr(
											"data-address-post");
											var addressNormal = $(this).attr(
											"data-address-normal");
											var addressDetail = $(this).attr(
											"data-address-detail");
										
								
											
											
				                                
										
								
											
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
																			data : $(
																					e.target).serialize(),
																			success : function(response) {
																				
																				reloadList();
																			}
																		});
															});
											$(this).parents(".view-container")
													.hide().after(editHtmlTemplate);
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
			<div class="w-35">
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
			<div class="w-65 pt-10 left">
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

			<div class="w-35">

		    <div class="flex-container">
                    <div class="w-40 left">
                        <label>받으실 분</label>
                    </div>
                    <div class="w-60">
                      <input type="text" name="addressName" value="${sessionScope.customer}" 
                     class="form-input  address w-100" required autocomplete="off">
                    </div>
             </div>

			 <div class="flex-container">
                     <div class="row w-40 left">
                         <label>연락처</label>
                     </div>
                     <div class="row w-60 left">
                         <input type="tel" name="addressPhone" value="${sessionScope.phone}"
                                class="form-input address w-100"autocomplete="off">
                         <div class="fail-feedback left">휴대폰 번호를 입력해주세요</div>
                     </div>
              </div>
   			  </div>

			<div class="w-65 left">

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
								<input name="addressPhone" class="form-input address  w-55" value="${sessionScope.phone}">
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


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>