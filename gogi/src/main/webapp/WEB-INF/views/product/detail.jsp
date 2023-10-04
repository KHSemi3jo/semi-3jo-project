<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
.line{
    height: 0.1px;
    border: 0 none;
    background-color: #E5EAEE;
}
.count{
    padding: 0.5em;
    box-shadow : 0px 0px 0px 1px #E5EAEE;
    border-radius: 3px;
}
.name,
.price{
    font-size: 22px;
    font-weight: bold;
}
.origin{
    font-size: 20px;
    font-weight: 500;
}
.sTitle{
    font-size: 13px;
}
 /* 버튼 스타일 */
        .btn-decrease-quantity,
        .btn-increase-quantity {
            font-size: 20px;
            background-color: white;
            color: #012D5C;
            border: none;
            padding: 8px 12px;
            cursor: pointer;
        }

        /* input 스타일 */
        .quantity{
            width: 40px;
            text-align: center;
            font-size: 16px;
            border: none;
            }
            .quantity:focus{
            outline: none;
            }
            
        .pCount{
            border: 1px solid #ddd;
            border-radius: 3px;        
        }
        .row.right.w-75.count{
         margin: 1px 0px;
        }
        .total{
        font-size: 30px;
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
        $(".btn-basket").click(function(){
        	var params = new URLSearchParams(location.search);
        	var productNo = params.get("productNo");
        	
            $.ajax({
                url:"http://localhost:8080/rest/basket/add",
                method:"post",
                data:{productNo:productNo},
                success:function(response){
                	if (response.success) {
                		$("#modalMessage").text("상품이 장바구니에 추가되었습니다");
                        openModal(); // 모달 열기
                    } 
//                 	else {
//                         alert("이미 장바구니에 있는 상품입니다");
//                     }
//                 	console.log(response);
                },
                error: function (xhr, status, error) {
                	$("#modalMessage").text("이미 장바구니에 있는 상품입니다");
                    openModal(); // 모달 열기
                }
            });
        });
        $(".btn-pick").click(function(){
        	var params = new URLSearchParams(location.search);
        	var productNo = params.get("productNo");
        	
            $.ajax({
                url:"http://localhost:8080/rest/pick/add",
                method:"post",
                data:{productNo:productNo},
                success:function(){
                	alert("성공");
                }
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
    
    $(function(){//상품 수량 증가시 합계 금액 증가
        // 초기 수량을 1로 설정
        var quantity = 1;

        // 수량 증가 버튼을 클릭할 때
        $(".btn-increase-quantity").click(function(){
        	if (quantity < 10) {
                quantity++;
                updateTotal();
            }
        });

        // 수량 감소 버튼을 클릭할 때
        $(".btn-decrease-quantity").click(function(){
            if (quantity > 1) {
                quantity--;
                updateTotal();
            }
        });

        // 총상품금액 업데이트 함수
        function updateTotal() {
        	 $(".quantity").val(quantity);
            var productPrice = ${productDto.productPrice}; // 상품 가격을 가져옴
            var total = productPrice * quantity; // 총상품금액 계산
            $(".total").text(total); // 총상품금액 업데이트

        }
    });



</script>

    <div class="row container 800">
        <div class="row flex-container">
            <div class="row w-40 pt-10">
                <c:choose>
                    <c:when test="${productDto.image}">
                        <img src="image?productNo=${productDto.productNo}" width="300" height="400">
                    </c:when>
                        <c:otherwise>
                            <img src="https://dummyimage.com/200x200/000/fff" width="300" height="400">
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="row w-500 pl-30">
                <div class="row left name">${productDto.productName}</div>
                <div class="row left price">${productDto.productPrice}원</div>
                <div class="row left origin">원산지: ${productDto.productOrigin}</div>
                <hr class="line">
                <div class="row flex-container">
                    <div class="row left w-25">중량/용량</div>
                    <div class="row left w-75">${productDto.productWeight} g</div>
                </div>                    
                <hr class="line">
                <div class="row flex-container">
                    <div class="row left w-25">유통기한</div>
                    <div class="row left w-75">${productDto.productExpire}</div>
                </div>                  
                <hr class="line">
                <div class="row flex-container">
                    <div class="row left w-25">상품선택</div>
                    <div class="row right w-75 count">
                        <div class="row left sTitle pt-10">${productDto.productName}</div>
                        <div class="row float-container">
                            <div class="row col-3 left">
                            	<div class="row flex-container pCount ">
									<button class="btn-decrease-quantity">-</button>
							        <input type="text" class="quantity" value="1" readonly>
							        <button class="btn-increase-quantity">+</button>
						        </div>
							</div>
							<div class="row col-3 right"></div>
                            <div class="row col-3 right pt-20">${productDto.productPrice} 원</div>
                        </div>
                    </div>
                </div>  
                <hr class="line">
                <div class="row right">총상품금액: <span class="total">0</span>원</div>
                <div class="row flex-container">
                    <div class="row w-25"><a href="/shopafter/list" class="btn btn-orange">후기목록</a></div>
                    <div class="row w-35 pl-20 ">
                        <button class="btn btn-orange btn-basket">장바구니담기</button>
                    </div>
                    <div class="row w-25">
                        <a class="btn btn-navy" href="list?productNo=${productDto.productNo}">목록</a>
                    </div>
                </div>
            </div>
        </div>
        <c:choose>
        	<c:when test="${productDto.productType eq '돼지고기'}">
        <div class= "row">
        	<hr>
        		<img src="/images/product/pig.png" width="1000" height="800">
        	<hr>
        		<img src="/images/product/pd-image2.png" width="1000" height="800">
        </div>
        </c:when>
        <c:otherwise>
         <div class= "row">
        	<hr>
        		<img src="/images/product/cow.png" width="1000" height="800">
        			<hr>
        		<img src="/images/product/pd-image2.png" width="1000" height="800">
        </div>
        </c:otherwise>
        </c:choose>
    </div>


<!-- 모달 대화상자 -->
<div id="myModal" class="modal ">
  <div class="modal-content container">
    <span class="close orange" onclick="closeModal()">&times;</span>
    <p id="modalMessage" class="orange pt-50"></p>
  </div>
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>