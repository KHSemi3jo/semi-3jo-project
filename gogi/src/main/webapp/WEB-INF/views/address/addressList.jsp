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
</style>

<script>
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
                           
                                $(htmlTemplate).find(".addressId").text(
                                    "회원 아이디 : " + address.addressId || "탈퇴한 사용자");
                                
                                $(htmlTemplate).find(".addressName").text(
                                        "고객 성함 : " + customer);
                                $(htmlTemplate).find(".addressPhone").text(
                                        "전화 번호 : " + phone);
                                
                                $(htmlTemplate).find(".addressPost").text(
                                    "우편 번호 : " + address.addressPost);
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
                                            if (confirm("정말 삭제하실에요?")) {
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
								.attr("data-address-no", address.addressNo)
								.click(
										function() {
											var editTemplate = $(
													"#address-edit-template")
													.html();
											var editHtmlTemplate = $
													.parseHTML(editTemplate);	
											var addressNo = $(this).attr(
													"data-address-no");
										
									
											$(editHtmlTemplate).find(
													"[name=addressNo]")
													.val(addressNo);
											$(editHtmlTemplate)
													.find(
															"[name=addressId]")
													.val(addressId);
											$(editHtmlTemplate).find(
											"[name=addressPost]")
											.val(addressPost);
											$(editHtmlTemplate).find(
											"[name=addressNormal]")
											.val(addressNormal);
											$(editHtmlTemplate).find(
											"[name=addressDetail]")
											.val(addressDetail);
											
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
										});
                                
                                
                                
                                  $(".address-list").append(htmlTemplate);
                            }
                          
                        },
                    })
                }
                reloadList();

            });
        </script>
<h2>배송지 관리</h2>
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
					<button class="btn btn-edit btn-navy w-100">
						<i class="fa-solid fa-edit"></i>
						주소 수정
					</button>
				</div>
				<div class="row right ">
					<button class="btn btn-orange btn-delete w-100">
						<i class="fa-solid fa-trash"></i>
						 주소 삭제
					</button>
				</div>
			</div>
</div>
<hr>
</script>


<script id="address-edit-template" type="text/template">
		<form class="address-edit-form edit-container">
		<input type="hidden" name="addressNo">
	<input type="hidden" name="addressId" >
		<div class="row flex-container">
			<div class="w-75">
			우편번호 :	<input type="text" name="addressPost" maxlength="5"  >
			기본주소 :	<input type="text" name="addressNormal"  >
			상세주소 :	<input type="text" name="addressDetail" >
			</div>
			<div class="w-25">
				<div class="row right">
					<button type="submit" class="btn btn-positive">
						<i class="fa-solid fa-check"></i>
						수정
					</button>
				</div>
				<div class="row right">
					<button type="button" class="btn btn-negative btn-cancel">
						<i class="fa-solid fa-xmark"></i>
						취소
					</button>
				</div>
			</div>
		</div>
		</form>
</script>




<br>
<h3>기본 배송지</h3>
<h3>회원가입시 입력한 회원의 기본 배송지가 나와야합니다.</h3>
<table border="1" width="800" class=" table table-slit">
	<thead>
		<tr>
			<th>선택</th>
			<th>아이디</th>
			<th>우편주소</th>
			<th>기본주소</th>
			<th>상세주소</th>
		</tr>
	</thead>
	<tbody align="center">
		<c:forEach var="addressDto" items="${list}">
			<tr>
				<td><input type="checkbox"></td>
				<td>${addressDto.addressId}</td>
				<td>${sessionScope.phone}</td>
				<td>${addressDto.addressNormal}</td>

			</tr>
		</c:forEach>
	</tbody>
</table>

<div class="container address-list w-1000"></div>



<c:if test="${sessionScope.name != null}">
	<div class="container w-800">
		<form class="address-insert-form" method="post">
			<input type="hidden" name="addressId" value=" ${sessionScope.name}">
				<input type="hidden" name="addressName" value=" ${sessionScope.customer}">
					<input type="hidden" name="addressPhone" value="${sessionScope.phone}">
			<div class="row " >
				<h2 style="display: inline; vertical-align:middle; align-items: center; ">우편번호 : </h2><input type="text" name="addressPost" maxlength="6" class="form-input"
					value=" ${addressDto.addressPost}">
			</div>
			<div class="row">
		<h2 style="display: inline; vertical-align:middle; align-items: center; ">		기본주소 : </h2><input type="text" name="addressNormal" class="form-input"
					value=" ${addressDto.addressNormal}">
			</div>
			<div class="row">
			<h2 style="display: inline; vertical-align:middle; align-items: center; ">	상세주소 : </h2><input type="text" name="addressDetail" class="form-input"
					value=" ${addressDto.addressDetail}">
			</div>

			<div class="row">
				<button class="btn btn-orange ">
					<i class="fa-solid fa-pen"></i> 주소등록
				</button>
			</div>
		</form>
	</div>
</c:if>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>