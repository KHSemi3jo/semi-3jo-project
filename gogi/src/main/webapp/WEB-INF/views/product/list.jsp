<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<c:choose>
	<c:when test="${sessionScope.level == '관리자'}">
		<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>
	</c:when>
	<c:otherwise>
		<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>	
	</c:otherwise>
</c:choose>
<style>
.btn-basket{
	background-color:white;
	border: 1px solid #FA9F5F;
	border-radius:3px;
	height:40px;
	font-size:18px;
}
.productName{
    font-size: 22px;
}
.productPrice{
    font-size: 20px;
    font-weight: bold;
}
.img-fluid{
 	border-radius:3px;
}
.listContainer.w-1000{
	    margin-left: 40px;
}
select.form-input.product,
.btn.btn-navy{
	font-size:16px;
	height:2.8em;
    border-radius: 0.1em;
}
.hidden-select{
	display: none;
}

   /* 모달 스타일 */
.modal {
    display: none; /* 초기에는 모달을 숨김 */
    position: fixed;
    z-index: 1;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    overflow: auto;
    background-color: rgba(0,0,0,0.4);
}
.modal-content {
    background-color: #fefefe;
    margin: 15% auto;
    padding: 20px;
    border: 1px solid #FA9F5F;
    width: 350px;
    height: 180px;
    box-shadow: 0px 0px 1px 0px #000;
    border-radius: 5px;
    text-align: center;
    font-size: 18px;
}
.close {
    color: #FA9F5F;
    float: right;
    font-size: 24px;
    font-weight: bold;
    margin-top: -10px;
}
.close:hover,
.close:focus {
    color: #012D5C;
    text-decoration: none;
    cursor: pointer;
}
</style>

<script>
    $(function(){
        $(".btn-basket").click(function(e){
        	e.preventDefault();
            
            // 상품 번호 가져오기
            var productNo = $(this).data("product-no");
            
            $.ajax({
                url: window.contextPath+"/rest/basket/add",
                method: "post",
                data: { productNo: productNo },
                success: function(response) {
                        $("#modalMessage").text(response.message);
                        openModal(); // 모달 열기

                },
                error: function (xhr) {
                    // 에러 처리
                    console.log(arguments);
                    $("#modalMessage").text(xhr.responseJSON.message);
                    openModal(); // 모달 열기
                },
                
            });
        });
     });
    // 모달 열기------------------------------
    function openModal() {
        var modal = document.getElementById("myModal");
        modal.style.display = "block";
    }

    // 모달 닫기
    function closeModal() {
        var modal = document.getElementById("myModal");
        modal.style.display = "none";
    }

    // 모달 닫기 버튼 클릭 시 닫기
    var closeBtn = document.getElementsByClassName("close")[0];
    closeBtn.onclick = function() {
        closeModal();
    }

    // 모달 외부 클릭 시 닫기
    window.onclick = function(event) {
        var modal = document.getElementById("myModal");
        if (event.target == modal) {
            closeModal();
        }
    }
    //----------------------------

</script>


<div class="listContainer w-1000" >
    <div class="flex-container w-250 auto-width">
        <c:forEach var="productDto" items="${list}" varStatus="loopStatus">
		            <div class="row col-md-4 pr-40">
		                <div class="row">
		                    <c:choose>
		                        <c:when test="${productDto.image}">
		                        	<a class="link" href="${pageContext.request.contextPath}/product/detail?productNo=${productDto.productNo}">
			                            <img src="${pageContext.request.contextPath}/product/image?productNo=${productDto.productNo}"
			                             class="img-fluid" alt="Product Image" width="250" height="300"></a>
		                        </c:when>
		                        <c:otherwise>
		                        	<a class="link" href="${pageContext.request.contextPath}/product/detail?productNo=${productDto.productNo}">
		                            	<img src="https://dummyimage.com/250x300/000/fff" class="img-fluid" alt="Default Image"></a>
		                        </c:otherwise>
		                    </c:choose>
		                </div>
		                <div class="row">
		                    <button class="btn-basket w-100" data-product-no="${productDto.productNo}">
		                    	<i class="ti ti-shopping-cart fa-lg orange"></i><span class="orange pl-5">담기</span></button>
		                </div>
		                <div class="row">
		                	<div class="row left productName" >
		                	<c:if test="${sessionScope.level == '관리자'}">
		                    	<span>No.${productDto.productNo}</span>
		                	</c:if>
		                    	${productDto.productName}
		                	</div>
		                	<div class="row left productPrice">
		                    	${productDto.productPrice}원
		                	</div>
		                	<c:if test="${sessionScope.level == '관리자'}">			         
			                    <a class="btn btn-navy " href="${pageContext.request.contextPath}/product/edit?productNo=${productDto.productNo}">수정</a>
			                    <a class="btn btn-orange " href="${pageContext.request.contextPath}/product/delete?productNo=${productDto.productNo}">삭제</a>
		                	</c:if>
		                </div>
		            </div>
	            <!-- Start a new row after every 3rd product -->
	            <c:if test="${loopStatus.index % 4 == 3 or loopStatus.last}">
	                </div><div class="row flex-container  w-250 auto-width">
	            </c:if>
        </c:forEach>
    </div>
</div>
	

	<div class="row page-navigator mv-30">
	<!-- 이전 버튼 -->
	<c:if test="${!vo.first}">
	<a href= "${pageContext.request.contextPath}/product/list?${vo.prevQueryString}">&lt;</a>
	</c:if>
	
	<!-- 숫자 버튼 -->
	<c:forEach var="i" begin="${vo.begin}" end="${vo.end}" step="1">
	<a href="${pageContext.request.contextPath}/product/list?${vo.getQueryString(i)}">${i}</a>
</c:forEach>
		
		<!-- 다음 버튼 -->
	<c:if test="${!vo.last}">
	<a href= "${pageContext.request.contextPath}/product/list?${vo.nextQueryString}">
	&gt;</a>
	</c:if>
	</div>


<!-- 모달 대화상자 -->
<div id="myModal" class="modal ">
  <div class="modal-content container">
    <span class="close orange" onclick="closeModal()">&times;</span>
    <p id="modalMessage" class="orange pt-50"></p>
  </div>
</div>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>