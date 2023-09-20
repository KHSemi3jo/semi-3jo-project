<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
    
</style>

<!-- javascript 작성 공간 -->
<script>
	
</script>

<form action="#" method="post">
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
						<span>선택삭제</span>
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
						<a class="link" href="detail?productNo=${productDto.productNo}">
							${basketListDto.productName}
						</a>
					</td>
					<td>${basketListDto.getBasketCount()}</td>
					<td>${basketListDto.productPrice}</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		</div style="width:300px;">
		<div>
			<div>
				<span>상품금액 : </span>
				<span>20000원</span>
			</div>
			<div>할인금액 : </div>
			<div>합계금액 : </div>
			<div>
				<button class="btn btn-orange w-100">결제하기</button>
			</div>
		</div>
	</div>

</form>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>