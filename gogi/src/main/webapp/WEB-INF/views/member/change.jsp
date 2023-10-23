<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

 <style>
.container.w-600 input{
    border-radius: 3px;
    border-color: #ADBBCA;
}
.btn{
    border-radius: 3px;
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

      <!--jquery CDN-->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="/js/change.js"></script>   
     <!--daum 우편 API cdn-->
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    
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
                    document.querySelector("[name=memberPost]").value = data.zonecode;
                    document.querySelector("[name=memberAddr1]").value = addr;
                    // 커서를 상세주소 필드로 이동한다.
                    document.querySelector("[name=memberAddr2]").focus();
            }
        }).open();
        });
   
    });
         
         $(function(){
        	 
             // 비밀번호 변경 버튼을 클릭했을 때 팝업을 보여주는 함수
             $("#changePasswordButton").click(function(e) {
            	 e.preventDefault();
                 // 팝업을 보이도록 설정
            	 showPasswordChangePopup();
             });

             // 팝업 닫기 버튼을 클릭했을 때 팝업을 닫는 함수
             $("#closePasswordChangePopup").on("click",function() {
            	 closePopup("passwordChangePopup");
             });

          // 비밀번호 변경 확인 팝업 닫기 버튼 클릭 이벤트 처리
             $("#closePasswordChangeConfirmPopup").on("click", function() {
                 closePopup("passwordChangeConfirmPopup");
                 closePopup("passwordChangePopup");
             });
             
             // 비밀번호 변경 폼을 제출할 때의 처리
             $("#passwordChangeForm").submit(function(e) {
                 e.preventDefault(); // 기본 폼 제출 동작을 막음
                 
              // 비밀번호 필드의 값을 가져옵니다.
                 var originPw = $("input[name=originPw]").val();
                 var changePw = $("input[name=changePw]").val();

              // 비밀번호 필드가 비어 있는지 확인합니다.
                 if (originPw === "" || changePw === "") {
                     // 비밀번호 필드가 비어 있을 때 오류 메시지를 표시합니다.
                     $("#passwordChangeErrorMessage").text("");
                 } 
                 else {
                 		// 폼을 서버로 제출하는 코드
		                 $.ajax({
		                     type: "POST",
		                     url: window.contextPath+"/rest/member/changePw", 
		                     data: $(this).serialize(), // 폼 데이터 직렬화
		                     success: function(response) {
			                         // 서버 응답 처리
			                         if (response == "success") {
			                             // 변경 성공 시
			                             showPasswordChangeConfirmPopup();
			                         }
			                         else {
			                        	 
			                             // 변경 실패 시 오류 메시지 표시
			                             $("#passwordChangeErrorMessage").text("비밀번호 변경에 실패했습니다.");
			                         }
		                     },
		                     error: function() {
		                         // AJAX 요청 실패 시 오류 메시지 표시
		                         $("#passwordChangeErrorMessage").text("서버와의 통신이 원할하지 않습니다.");
		                     }
		                 });
                	 
                	 
                 }

             });
             
             // 비밀번호 변경 확인 팝업 열기
             function showPasswordChangeConfirmPopup() {
                 var popup = $("#passwordChangeConfirmPopup");
                 popup.css("display", "block");
             }

             // 팝업 닫기 
             function closePopup(popupId) {
                 var popup = $("#" + popupId);
                 popup.css("display", "none");
             }

             // 비밀번호 변경 팝업 열기 
             function showPasswordChangePopup() {
                 var popup = $("#passwordChangePopup");
                 popup.css("display", "block");
             }
             
         });
         
    </script>
    
    
    <form class="change-form" action="change" method="post"autocomplete="off" >
	    <div class="container w-600" >

            <div class="row left pb-20">
                <h2 >개인 정보 수정</h2>
            </div>
            <hr>

                <div class="row flex-container pt-20">
                    <div class="row w-25 left">
                        <label>아이디</label>
                    </div>
                    <div class="row w-75 pr-30">
                        <input type="text" name="memberId" value="${memberDto.memberId}"
                            class="form-input w-100" readonly>
                    </div>
                </div>
         
                <div class="row flex-container">
                    <div class="row w-25 left">
                        <label>이름</label>
                    </div>
                    <div class="row w-75 pr-30">
                        <input type="text" name="memberName" value="${memberDto.memberName}" 
                         class="form-input w-100" >
                         <div class="fail-feedback left">한글 2~7자 이내의 이름을 입력하세요</div>
                    </div>
                </div>

                <div class="row flex-container">
                    <div class="row w-25 left">
                        <label>이메일</label>
                    </div>
                    <div class="row w-75 pr-30">
                        <input type="email" name="memberEmail"value="${memberDto.memberEmail}"
                                class="form-input w-100">
                        <div class="fail-feedback left">이메일 형식으로 입력해주세요</div>
                        <div class="fail2-feedback left">이미 사용중인 이메일입니다</div>
                    </div>
                </div>
                <div class="row flex-container">
                    <div class="row w-25 left">
                        <label>생년월일</label>
                    </div>
                    <div class="row w-75 pr-30">
                        <input type="date" name="memberBirth" value="${memberDto.memberBirth}"
                        class="form-input w-100">
                        <div class="fail-feedback left">예)1999-01-22( '-'를 포함하여 작성)</div>
                    </div>
                </div>

                <div class="row flex-container">
                    <div class="row w-25 left">
                        <label>휴대폰</label>
                    </div>
                    <div class="row w-75 pr-30">
                        <input type="tel" name="memberContact" value="${memberDto.memberContact}"
                                class="form-input w-100">
                        <div class="fail-feedback left">예)010xxxx0000( '-' 없이 작성)</div>
                    </div>
                </div>
                <div class="row flex-container">
                    <div class="row w-25 left">
                        <label style="display: block;">주소</label>
                    </div>
                    <div class="row w-75 left">
                        <input type="text" name="memberPost" class="form-input post-search"
                                size="6" maxlength="6" value="${memberDto.memberPost}">
                        <button type="button" class="btn post-search">
                            <i class="fa-solid fa-magnifying-glass"></i>
                        </button>
                    </div>
                </div>
                <div class="row flex-container">
                    <div class="w-25"></div>
                    <div class="w-75 pr-30">
                        <input type="text" name="memberAddr1"
                                    class="form-input post-search w-100 " value="${memberDto.memberAddr1}">
                    </div>
                </div>
                <div class="row flex-container">
                    <div class="w-25"></div>
                    <div class="w-75 pr-30">
                        <input type="text" name="memberAddr2"  value="${memberDto.memberAddr2}"
                                    class="form-input w-100" >
                        <div class="fail-feedback left">주소 입력시 모든 주소를 작성해주세요</div>
                    </div>
                </div>
                <div class="row float-container right pr-30" >
	                        <button class="btn btn-orange " type="submit">                         
	                            회원정보수정
	                        </button>
	                        <a class="btn btn-navy" id="changePasswordButton">비밀번호변경</a>
	                        <a class="btn" href="${pageContext.request.contextPath}/member/exit" >탈퇴하기</a>
                </div>
        </div> 
    </form>
    
   <div id="passwordChangePopup" class="popup row container" >
    	<div class="popupContent row w-200">
		    <h2>비밀번호 변경</h2>
		    <form id="passwordChangeForm" action="password" method="post" autocomplete="off">
			    <div class="row left">
	            	<span class="navy">기존 비밀번호</span>
	            </div>
	            <div class="row">
	            	 <input type="password" name="originPw" class="form-input w-100">
	            </div>
	            <div class="row left">
	            	<span class="navy">변경 비밀번호</span>
	            </div>
	            <div class="row">
	            	 <input type="password" name="changePw" class="form-input w-100">
	            </div>
			     <!-- 오류 메시지를 표시할 div -->
			    <div id="passwordChangeErrorMessage" class="row left orange"></div>
		        <div class="row pt-10">
			        <button class="btn btn-orange" type="submit">비밀번호 변경하기</button>
				    <button class="btn btn-navy" id="closePasswordChangePopup">닫기</button>
		        </div>
		    </form>
		</div>
</div>

<div id="passwordChangeConfirmPopup" class="popup">
    <div class="popupContent row container w-200">
    	<div class="row pt-30">
	        <h2 class="orange pt-60" id="passwordChangeMessage">비밀번호가 변경되었습니다!</h2>
    	</div>
    	<div class="row pt-30">
    	    <button class="btn btn-navy" id="closePasswordChangeConfirmPopup">닫기</button>
    	</div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>