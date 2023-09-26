<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
  $(function(){

	 
	  $(".address-insert-form").submit(function(e) {	
			  
			e.preventDefault();
			$.ajax({	
				url : "/rest/address/add",
				method : "post",
				data : $(e.target).serialize(),
				success : function(response) {
					

				}
			});
		});
	  
	  
  });
</script>

                <h2 >배송지 관리</h2>
                <hr>
                
<script  id="address-template" type="text/template">
<h1>배송지 목록페이지가 와야합니다.</h1>
</script>
	
	
<script  id="address-edit-template" type="text/template">
<h1>배송지 수정페이지가 와야합니다.</h1>
</script>





<h3>기본 배송지</h3>
<h3>회원가입시 입력한 회원의 기본 배송지가 나와야합니다.</h3>
<table border= "1"  width= "800" class=" table table-slit">
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
    <c:forEach var= "addressDto" items= "${list}">
<tr>
 <td><input type="checkbox"></td>
	 <td>${addressDto.addressId}</td>
    <td> ${addressDto.addressPost}</td>
  	<td> ${addressDto.addressNormal}</td>
    <td> ${addressDto.addressDetail}</td>

  </tr>
</c:forEach>
</tbody>
</table>




<c:if test="${sessionScope.name != null}">
	<div class="flex-container w-800">
		<form class="address-insert-form" method="post">
		<input type="hidden" name="addressId"
				value=" ${sessionScope.name}">
		<div class="row">
		 우편번호 :	<input type="text" name="addressPost" maxlength="6"
				value=" ${addressDto.addressPost}">
	</div>
			<div class="row">
		기본주소 :	<input type="text" name="addressNomal"
				value=" ${addressDto.addressNomal}">
	</div>
			<div class="row">
		상세주소 :	<input type="text" name="addressDetail"
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