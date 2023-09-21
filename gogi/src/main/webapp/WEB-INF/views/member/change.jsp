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
    </style>
      <!--jquery CDN-->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    
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
    </script>
    
    
    <form action="change" method="post">
	    <div class="container w-600">

            <div class="row left">
                <h2 >개인 정보 수정</h2>
            </div>
            <hr>

                <div class="row flex-container">
                    <div class="row w-25 left">
                        <label>아이디</label>
                    </div>
                    <div class="row w-75 pr-30">
                        <input type="text" name="memberId" value="${memberDto.memberId}"
                            class="form-input w-100" >
                    </div>
                </div>
                
                <div class="row flex-container">
                    <div class="row w-25 left">
                        <label>현재 비밀번호</label>
                    </div>
                    <div class="row w-75 pr-30">
                        <input type="text" name="originPw" value="${memberDto.memberPw}"
                            class="form-input w-100">
                    </div>
                </div>
                
                <div class="row flex-container">
                    <div class="row w-25 left">
                        <label>새 비밀번호</label>
                    </div>
                    <div class="row w-75 pr-30">
                        <input type="text" name="memberPw"class="form-input w-100">
                    </div>
                </div>
                
                <div class="row flex-container">
                    <div class="row w-25 left">
                        <label>새 비밀번호 확인</label>
                    </div>
                    <div class="row w-75 pr-30">
                        <input type="text" name="memberPw" class="form-input w-100" >
                    </div>
                </div>


                <div class="row flex-container">
                    <div class="row w-25 left">
                        <label>이름</label>
                    </div>
                    <div class="row w-75 pr-30">
                        <input type="text" name="memberName" value="${memberDto.memberName}" 
                         class="form-input w-100" required >

                    </div>
                </div>

                <div class="row flex-container">
                    <div class="row w-25">
                        <label>이메일</label>
                    </div>
                    <div class="row w-75 pr-30">
                        <input type="email" name="memberEmail"value="${memberDto.memberEmail}"
                                class="form-input w-100">
                        <div class="fail-feedback left">이메일 형식으로 입력해주세요</div>
                    </div>
                </div>
                <div class="row flex-container">
                    <div class="row w-25">
                        <label>생년월일</label>
                    </div>
                    <div class="row w-75 pr-30">
                        <input type="date" name="memberBirth" value="${memberDto.memberBirth}"
                        class="form-input w-100">
                        <div class="fail-feedback left">잘못된 날짜를 선택하셨습니다</div>
                    </div>
                </div>

                <div class="row flex-container">
                    <div class="row w-25">
                        <label>휴대폰</label>
                    </div>
                    <div class="row w-75 pr-30">
                        <input type="tel" name="memberContact" value="${memberDto.memberContact}"
                                class="form-input w-100">
                        <div class="fail-feedback left">휴대폰 번호를 입력해주세요</div>
                    </div>
                </div>
                <div class="row flex-container">
                    <div class="row w-25">
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
                <div class="row flex-container">
                    <div class="row w-50 right">
                        <a class="btn" href="exit">                           
                            탈퇴하기
                        </a>
                    </div>
                    <div class="row w-50 left pl-20">
                        <button class="btn btn-orange " type="submit">                         
                            회원정보수정
                        </button>
                    </div> 
                </div>
        </div> 
    </form>




<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>