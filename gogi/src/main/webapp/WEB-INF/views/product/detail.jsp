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
.name{
    font-size: 26px;
    font-weight: bold;
}
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
        $(".btn-basket").click(function(){
        	var params = new URLSearchParams(location.search);
        	var productNo = params.get("productNo");
        	
        	$.ajax({
                url: "/rest/basket/add",
                method: "post",
                data: { productNo: productNo},
                success: function(response) {
                		$("#modalMessage").text(response.message);
                        openModal(); // 모달 열기
                },
                error: function (xhr, status, error) {
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
                <div class="row left name pb-10">${productDto.productName}</div>
                <div class="row left price pb-10">${productDto.productPrice}원</div>
                <div class="row left origin pb-10">원산지: ${productDto.productOrigin}</div>
                <hr class="line">
                <div class="row flex-container origin">
                    <div class="row left w-25">중량/용량</div>
                    <div class="row left w-75">${productDto.productWeight} g</div>
                </div>                    
                <hr class="line">
                <div class="row flex-container origin">
                    <div class="row left w-25">유통기한</div>
                    <div class="row left w-75">${productDto.productExpire}</div>
                </div>                  
                <hr class="line">

                <div class="row flex-container pt-10">
                    <div class="row w-20 pt-10 pl-10">
                    	<a href="/shopafter/list" ><i class="fa-regular fa-comment-dots fa-flip-horizontal fa-2xl orange"></i></a>
                    </div>
                    <div class="row w-30">
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