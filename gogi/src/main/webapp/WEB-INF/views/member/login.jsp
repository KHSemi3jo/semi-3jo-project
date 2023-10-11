<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
.container.w-300 input {
    border-color: #ADBBCA;
    border-radius: 3px;
}
.container.w-300 input:focus {
    border-color: #1A426C;
}
.popup-content input{
    border-color: #ADBBCA;
    border-radius: 3px;
}
.popup-content input:focus{
    border-color: #1A426C;
}
.form-input.login {
    width: 100%;
    padding: 10px 10px;
    font-size: 16px;
}
.btn.w-100 {
    font-size: 18px;
}
a.link:hover {
    color: #FA9F5F;
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

.popup-content {
    position: absolute;
    top:50%;
    left: 50%;
    transform: translate(-50%, -50%);
    border-radius:  10px;
    background-color: white;
    width: 400px;
    height: 300px;
    padding: 20px;
    border: 1px solid #FA9F5F;
}
.btn.btn-orange.btn-send{
	width:10em;
}
</style>

 <script>
        $(function() {
        	$(".btn-send").find(".fa-spinner").hide();
            // 비밀번호 찾기 팝업 열기
            $("#passwordRecoveryButton").click(function(e) {
                e.preventDefault();
                showPasswordRecoveryPopup();
            });

            // "닫기" 버튼 클릭 이벤트 처리
            $("#closePopupInternal").on("click", function() {
                closePopup("passwordRecoveryPopup");
            });

            // 이메일 확인 팝업 닫기 버튼 클릭 이벤트 처리
            $("#closeEmailConfirmationPopup").on("click", function() {
                closePopup("emailConfirmationPopup");
                closePopup("passwordRecoveryPopup");
            });

            // 비밀번호 찾기 폼 제출 이벤트 처리
            $("#passwordRecoveryForm").submit(function(event) {
                event.preventDefault(); // 기본 제출 동작 방지
                $(".btn-send").prop("disabled",true);
                $(".btn-send").find(".fa-spinner").show();
           		$(".btn-send").find("span").text("이메일 전송중");

                // 폼을 서버로 제출하는 코드
                $.ajax({
                    type: "POST",
                    url: "${pageContext.request.contextPath}/rest/member/searchPw", 
                    data: $(this).serialize(), // 폼 데이터 직렬화
                    success: function(response) {
                        // 서버 응답에 따른 처리
                    	$(".btn-send").prop("disabled",true);
		                $(".btn-send").find(".fa-spinner").show();
                        if (response == "success") {
                            // 이메일 확인 팝업 표시
                            showEmailConfirmationPopup();
                        }
                        else {
	                        $(".btn-send").prop("disabled",false);
			                $(".btn-send").find(".fa-spinner").hide();
			                $(".btn-send").find("span").text("비밀번호 찾기");
                            // DB에 해당 아이디와 이메일이 없는 경우 에러 메시지 표시
                            $("#errorMessage").html("<h5 class='orange'>" + response + "</h5>");
                        }
                    },
                    error: function(error) {
                        console.error("서버 에러: " + JSON.stringify(error));
                    }
                });
            });

            // 이메일 확인 팝업 열기
            function showEmailConfirmationPopup() {
                var popup = $("#emailConfirmationPopup");
                popup.css("display", "block");
            }

            // 팝업 닫기 함수 수정
            function closePopup(popupId) {
                var popup = $("#" + popupId);
                popup.css("display", "none");
            }

            // 비밀번호 찾기 팝업 열기 함수 수정
            function showPasswordRecoveryPopup() {
                var popup = $("#passwordRecoveryPopup");
                popup.css("display", "block");
            }
        });
    </script>

<form action="login" method="post" autocomplete="off">
    <div class="container w-300">
        <div class="row pt-50">
            <h2>로그인</h2>
        </div>
        <div class="row pt-20">
            <input type="text" name="memberId" class="form-input login" placeholder="아이디를 입력해주세요">
        </div>
        <div class="row">
            <input type="password" name="memberPw" class="form-input login" placeholder="비밀번호를 입력해주세요">
        </div>
        <div class="row left">
            <c:if test="${param.error != null}">
                <h5 class="orange">아이디 또는 비밀번호가 일치하지 않습니다</h5>
            </c:if>
        </div>
        <div class="row right">
            <a id="passwordRecoveryButton" class="link navy">비밀번호 찾기</a>
        </div>
        <div class="row pt-20">
            <button class="btn btn-orange w-100" type="submit">로그인</button>
        </div>
        <div class="row">
            <a class="btn w-100" href="join">회원가입</a>
        </div>
    </div>
</form>

<!-- 비밀번호 찾기 팝업 -->
<div id="passwordRecoveryPopup" class="popup row container">
    <div class="popup-content row w-200">
        <form id="passwordRecoveryForm" method="post" action="searchPw" autocomplete="off">
            <!-- 아이디와 이메일 주소를 입력받는 폼 -->
            <div class="row left">
            	<span class="navy">아이디</span>
            </div>
            <div class="row">
            	 <input type="text" name="memberId" class="form-input w-100">
            </div>
             <div class="row left">
             	<span class="navy">이메일</span>
             </div>
            <div class="row">
            	<input type="email" name="memberEmail" class="form-input w-100">
            </div>
            <div id="errorMessage" class="row left"></div>
            <!-- 비밀번호 찾기 버튼 클릭 시, 서버로 제출 -->
            <div class="row pt-10">
            	<button class="btn btn-orange btn-send" type="submit">
            	<i class="fa-solid fa-spinner fa-spin"></i>
            	<span>비밀번호 찾기</span></button>
		        <!-- 팝업 닫기 버튼 -->
		        <button type="button" class="btn btn-navy" id="closePopupInternal">닫기</button>
            </div>
        </form>
    </div>
</div>

<div id="emailConfirmationPopup" class="popup">
    <div class="popup-content row container w-200">
    	<div class="row">
	        <h2 class="orange pt-60" id="emailConfirmationMessage">이메일을 확인해주세요!</h2>
    	</div>
    	<div class="row pt-30">
    	    <button class="btn btn-navy" id="closeEmailConfirmationPopup">닫기</button>
    	</div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
