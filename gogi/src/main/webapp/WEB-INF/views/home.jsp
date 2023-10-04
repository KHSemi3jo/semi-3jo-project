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
<!-- swiper cdn -->
   <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />
   <script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
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
select.form-input,
.form-input,
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
    width: 300px;
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
                url: "http://localhost:8080/rest/basket/add",
                method: "post",
                data: { productNo: productNo },
                success: function(response) {
                    if (response.success) {
                		$("#modalMessage").text("상품이 장바구니에 추가되었습니다");
                        openModal(); // 모달 열기
                    } 
//                     else {
//                         alert(response.message);
//                     }
                },
                error: function (xhr, status, error) {
                	$("#modalMessage").text("이미 장바구니에 있는 상품입니다");
                    openModal(); // 모달 열기
                },
                
            });
        });
        
        var swiper = new Swiper('.swiper', {//아래의 객체에 옵션이 적용
            //direction: 'vertical',//슬라이드 방향
            loop: true,//슬라이드의 순환설정(끝에서 다시 첨으로)

            //자동재생
             autoplay:{
                delay: 3000,//재생간격(ms)
                pauseOnMouseEnter:true,//마우스 진입 시 멈춤 여부
               },

            //이펙트(전환효과) 설정
            effect:"slide",//(slide,fade,cube,coverflow,flip,creative)
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

<c:if test="${sessionScope.level == '관리자'}">
	<div class="row">
		<form action="list" method="get">
			<c:choose>
				<c:when test="${vo.type == 'productName'}"></c:when>
				<c:otherwise>
				<select class="form-input hidden-select" name="type">
				<option value="product_name" selected>상품이름</option>
				</select>
				</c:otherwise>
			</c:choose>
			<input  class="form-input" type="search" name="keyword" placeholder="검색어를 입력해주세요"
			 autocomplete="off">
			<button type="submit" class="btn btn-navy">
			<i class="fa-solid fa-magnifying-glass"></i>
			검색</button>
		</form>
	</div>
</c:if>
    <div class="container w-1100">
        <div class="row">
            <!-- Slider main container -->
            <div class="swiper">
                <!-- Additional required wrapper -->
                <div class="swiper-wrapper">
                    <!-- Slides -->
                    <div class="swiper-slide">
                        <img src="/images/main/main-1.jpg" width="100%" height="250px">
                    </div>
                    <div class="swiper-slide">
                        <img src="/images/main/main-2.png" width="100%" height="250px">
                    </div>
                    <div class="swiper-slide">
                        <img src="/images/main/main3.png" width="100%" height="250px">
                    </div>
                </div>

            
                <!-- If we need scrollbar -->
                <!-- <div class="swiper-scrollbar"></div> -->
            </div>
        </div>
    </div>



<div class="listContainer w-1000" >
    <div class="flex-container w-250 auto-width">
        <c:forEach var="productDto" items="${list}" varStatus="loopStatus">
		            <div class="row col-md-4 pr-40">
		                <div class="row">
		                    <c:choose>
		                        <c:when test="${productDto.image}">
		                        	<a class="link" href="product/detail?productNo=${productDto.productNo}">
			                            <img src="product/image?productNo=${productDto.productNo}"
			                             class="img-fluid" alt="Product Image" width="250" height="300"></a>
		                        </c:when>
		                        <c:otherwise>
		                        	<a class="link" href="product/detail?productNo=${productDto.productNo}">
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
			                    <a class="btn btn-navy " href="edit?productNo=${productDto.productNo}">수정</a>
			                    <a class="btn btn-orange " href="delete?productNo=${productDto.productNo}">삭제</a>
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
	<a href= "list?${vo.prevQueryString}">&lt;</a>
	</c:if>
	
	<!-- 숫자 버튼 -->
	<c:forEach var="i" begin="${vo.begin}" end="${vo.end}" step="1">
	<a href="list?${vo.getQueryString(i)}">${i}</a>
</c:forEach>
		
		<!-- 다음 버튼 -->
	<c:if test="${!vo.last}">
	<a href= "list?${vo.nextQueryString}">
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