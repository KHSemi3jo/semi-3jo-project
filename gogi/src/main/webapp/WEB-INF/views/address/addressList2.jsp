<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>



<style>
.noticeTitle {
	text-decoration: none;
}

select.form-input, .form-input, .btn.btn-navy {
	font-size: 16px;
	height: 2.8em;
	border-radius: 0.1em;
}

.popup-content input{
    border-color: #ADBBCA;
    border-radius: 3px;
}
.popup-content input:focus{
    border-color: #1A426C;
}
.popupContent {
    position: absolute;
    top:50%;
    left: 50%;
    transform: translate(-50%, -50%);
    border-radius:  10px;
    background-color: white;
    width: 400px;
    height: 350px;
    padding: 20px;
    border: 1px solid #FA9F5F;
}
.popup {
    top:0;
    left: 0;
    right: 0;
    bottom: 0;
    z-index: 100;
    background-color: rgba(0,0,0,0.6);
    display: none;
    position: fixed;
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
                            console.log(response)    
                            var customer = "${sessionScope.customer}";
                               var phone = "${sessionScope.phone}";
                            for (var i = 0; i < response.length; i++) {
                                var address = response[i];
                                var template = $("#address-template").html();
                                var htmlTemplate = $.parseHTML(template);
                        
                                console.log(  document.querySelector("[name=addressPost]").value = address.addressPost);    
                               
                                
                                $(htmlTemplate).find(".addressId").text(
                                    "회원 아이디 : " + address.addressId || "탈퇴한 사용자");
                                
                                $(htmlTemplate).find(".addressName").text(
                                        "받으실 분 : " + customer);
                                $(htmlTemplate).find(".addressPhone").text(
                                        "연락처 : " + phone);
                                
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
            
            $(function(){
           	 
                // 배송지 수정 버튼을 클릭했을 때 팝업을 보여주는 함수
                $("#editAddressButton").click(function(e) {
               	 e.preventDefault();
                    // 팝업을 보이도록 설정
               	 showAddressEditPopup();
                });

                // 팝업 닫기 버튼을 클릭했을 때 팝업을 닫는 함수
                $("#closeAddressEditPopup").on("click",function() {
               	 closePopup("addressEditPopup");
                });

             // 팝업 닫기 버튼 클릭 이벤트 처리
                $("#closeAddressEditConfirmPopup").on("click", function() {
                    closePopup("addressEditConfirmPopup");
                    closePopup("addressEditPopup");
                });
                
                // 배송지 수정 폼을 제출할 때의 처리
                $("#addressEditForm").submit(function(e) {
                    e.preventDefault(); // 기본 폼 제출 동작을 막음

                    // 폼을 서버로 제출하는 코드
                    $.ajax({
                        type: "POST",
                        url: "http://localhost:8080/rest/address/edit", 
                        data: $(this).serialize(), // 폼 데이터 직렬화
                        success: function(response) {
                            // 서버 응답 처리
                            if (response == "success") {
                                // 수정 성공 시
                                showAddressEditConfirmPopup();
                            } else {
                                // 수정 실패 시 오류 메시지 표시
                                $("#addressEditErrorMessage").text("주소가 올바르지 않습니다.");
                            }
                        },
                        error: function() {
                            // AJAX 요청 실패 시 오류 메시지 표시
                            $("#addressEditErrorMessage").text("서버와의 통신이 원할하지 않습니다.");
                        }
                    });
                });
                
            
            // 배송지 수정 팝업
            function showAddressEditConfirmPopup() {
                var popup = $("#addressEditConfirmPopup");
                popup.css("display", "block");
            }

            // 팝업 닫기
            function closePopup(popupId) {
                var popup = $("#" + popupId);
                popup.css("display", "none");
            }

            function showAddressEditPopup() {
                var popup = $("#addressEditPopup");
                popup.css("display", "block");
            }
            
        });
        
    
        </script>
        
<h1>배송지 관리</h1>
<hr>

<script id="address-template" type="text/template">
<div class=" flex-container view-container  container w-1000">

<div class="row">
<input type="checkbox">
</div>

		<div class="w-75 container">
				<div class="row left">
					<h2 class="addressId">아이디</h2>
				</div>
				<div class="row left">
					<h3 class="addressName">성함</h3>
				</div>
				<div class="row left">
					<h3 class="addressPhone">전화번호</h3>
				</div>
				<div class="row left">
					<pre class="addressPost">우편번호</pre>
				</div>
				<div class="row left">
					<pre class="addressNormal">기본주소</pre>
				</div>
				<div class="row left">
					<pre class="addressDetail">상세주소</pre>
				</div>
	
			</div>
			<div class="w-25" flex-container>
				<div class="row right">
					<a class="btn btn-navy" id="editAddressButton">
						배송지 수정
					</a>
				</div>
				<div class="row right ">
					<button class="btn btn-orange btn-delete w-100">
						<i class="fa-solid fa-trash"></i>
						 배송지 삭제
					</button>
				</div>
			</div>
</div>
<hr>
</script>







<br>
<h3>배송지 목록</h3>
<br>
<h4>배송지에 따라 상품정보가 달라질 수 있습니다.</h4>

<table border="1" width="800" class=" table table-slit">
	<thead>
		<tr>
			<th>선택</th>
			<th>받으실 분</th>
			<th>연락처</th>
			<th>기본주소</th>
			<th>수정</th>
		</tr>
	</thead>
	<tbody align="center">
		<c:forEach var="addressDto" items="${list}">
			<tr>
				<td><input type="checkbox"></td>
				<td>${addressDto.addressName}</td>
				<td>${sessionScope.phone}</td>
				<td>${addressDto.addressNormal}</td>
				<td><a href="edit" id="editAddressButton"> 
				<i class="fa-solid fa-pen"></i></a></td>

			</tr>
		</c:forEach>
	</tbody>

</table>


<div class="container address-list w-100"></div>

   
   <div id="addressEditPopup" class="popup row container" >
    	<div class="popupContent row w-400">
		    <h2>배송지 수정</h2>
		   <form id="addressEditForm" action="edit" method="post" autocomplete="off">
		<input type="hidden" name="addressNo">
	<input type="hidden" name="addressId" >
		<div class="container w-400">
		 <div class="row flex-container">
                    <div class="row w-25 left">
                        <label>받으실 분</label>
                    </div>
                    <div class="row w-75 pr-30">
                      <input type="text" name="addressName" value="${addressDto.addressName}" 
                     class="form-input w-100" required autocomplete="off">
                    </div>
                </div>
			<div class="row flex-container">
                    <div class="row w-25 left">
                        <label>연락처</label>
                    </div>
                    <div class="row w-75 pr-30">
                        <input type="tel" name="addressPhone" value="${sessionScope.phone}"
                                class="form-input w-100"autocomplete="off">
                        <div class="fail-feedback left">휴대폰 번호를 입력해주세요</div>
                    </div>
                </div>
		<div class="row flex-container">

                    <div class="row w-25 left">
                        <label style="display: block;">주소</label>
                    </div>
                    <div class="row w-75 left">
                        <input type="text" name="addressPost" class="form-input post-search"
                                size="6" maxlength="6" 
			value="" autocomplete="off">
                        <button type="button" class="btn post-search">
                            <i class="fa-solid fa-magnifying-glass"></i>
                        </button>
                    </div>
                </div>
                <div class="row flex-container">
                    <div class="w-25"></div>
                    <div class="w-75 pr-30">
                        <input type="text" name="addressNormal" autocomplete="off"
                      class="form-input post-search w-100 " value="addressNormal">
                    </div>
                </div>
                <div class="row flex-container">
                    <div class="w-25"></div>
                    <div class="w-75 pr-30">
                        <input type="text" name="addressDetail"  value="addressDetail"
                        class="form-input w-100" autocomplete="off">
                        <div class="fail-feedback left">주소 입력시 모든 주소를 작성해주세요</div>
                    </div>
                </div>
		</div>
		 <div class="row pt-10">
			        <button class="btn btn-orange" type="submit">배송지 수정</button>
				    <button class="btn btn-navy" id="closeAddressEditPopup">닫기</button>
		        </div>
		</form>
		</div>
</div>

<div id="addressEditConfirmPopup" class="popup">
    <div class="popupContent row container w-200">
    	<div class="row pt-30">
	        <h2 class="orange pt-60" id="addressEditMessage">배송지가 수정되었습니다!</h2>
    	</div>
    	<div class="row pt-30">
    	    <button class="btn btn-navy" id="closeAddressEditConfirmPopup">닫기</button>
    	</div>
   
    </div>
</div>

<c:if test="${sessionScope.name != null}">
	<div class="row container w-800">
		<form class="address-insert-form" method="post">

			<input type="hidden" name="addressId" class="form-input" value=" ${sessionScope.name}">
			<div class="row">
			이름 : <input name="addressName" class="form-input" value=" ${sessionScope.customer}">
			</div>
			<div class="row">
			연락처 : <input name="addressPhone" class="form-input" value="${sessionScope.phone}">
			</div>
			<div class="row ">
			우편번호 : <input type="text" name="addressPost" maxlength="6" class="form-input"
		>
					<button type="button" class="btn post-search">
                            <i class="fa-solid fa-magnifying-glass"></i>
                        </button>
			</div>
			<div class="row"> 
			기본주소 : <input type="text" name="addressNormal" class="form-input"
					>
			</div>
			<div class="row">
			상세주소 : <input type="text" name="addressDetail" class="form-input"
					>
			</div>
		

			<div class="row">
				<button class="btn btn-orange ">
					<i class="fa-solid fa-plus"></i> 새 배송지 추가
				</button>
			</div>
			
		</form>
	</div>
</c:if>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>