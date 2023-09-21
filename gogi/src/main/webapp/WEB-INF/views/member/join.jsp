<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
.btn.btn-orange{
    border-radius: 3px;
    width: 200px;
}
.container.w-600 input{
    border-radius: 3px;
}
.custom-checkbox {
    display: inline-block;
    font-size: 18px;
    position: relative;
}
.custom-checkbox > [type=checkbox] {
    display: none;
}
.custom-checkbox > span {
    display: inline-block;
    width: 1em;
    height: 1em;

    background-image: url("/images/checkbox/checkbox-empty.png");
    background-size: 100%;
    background-position: center;
    background-repeat: no-repeat;
}
.custom-checkbox > [type=checkbox]:checked + span {
    background-image: url("/images/checkbox/checkbox-check.png");
}
    </style>
    <!--jquery CDN-->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="/js/checkbox.js"></script>
     <script src="/js/join.js"></script>
    <!--daum 우편 API cdn-->
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <!--javascript 작성 공간-->
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

    <form class="join-form" action="join" method="post" autocomplete="off">

        <div class="container w-600 navy">
            <div class="row">
                <h2 >회원가입</h2>
            </div>
            <div class="row right">
                <span><span class="red">*</span>필수입력사항</span>
            </div>
            <hr class="navy">

                <div class="row flex-container">
                    <div class="row w-25">
                        <label>아이디<span class="red">*</span></label>
                    </div>
                    <div class="row w-75 pr-30">
                        <input type="text" name="memberId" placeholder="아이디를 입력해주세요"
                            class="form-input w-100">
                        <div class="success-feedback"></div>
                        <div class="fail-feedback left">영문 소문자,숫자 5~20자</div>
                        <div class="fail2-feedback left">이미 사용중인 아이디입니다</div>
                    </div>
                </div>
                <div class="row flex-container">
                    <div class="row w-25">
                        <label>비밀번호<span class="red">*</span></label>
                    </div>
                    <div class="row w-75 pr-30">
                        <input type="password" name="memberPw" 
                             placeholder="비밀번호를 입력해주세요"
                            class="form-input w-100">
                        <div class="success-feedback left"></div>
                        <div class="fail-feedback left">영문,숫자,특수문자(!@#$) 반드시 1개 이상 포함 8~16자</div>
                    </div>
                </div>
                <div class="row flex-container">
                    <div class="row w-25">
                        <label>비밀번호 확인<span class="red">*</span></label>
                    </div>
                    <div class="row w-75 pr-30">
                        <input type="password" id="password-check" placeholder="비밀번호 한 번 더 입력해주세요"
                                    class="form-input w-100">
                        <div class="success-feedback"></div>
                        <div class="fail-feedback left">동일한 비밀번호를 입력하세요</div>
                        <div class="fail2-feedback left">비밀번호를 먼저 작성하세요</div>
                    </div>
                </div>
               
                <div class="row flex-container">
                    <div class="row w-25">
                        <label>이름<span class="red">*</span></label>
                    </div>
                    <div class="row w-75 pr-30">
                        <input type="text" name="memberName" 
                        placeholder="이름을 입력해주세요" class="form-input w-100">
                        <div class="success-feedback"></div>
                        <div class="fail-feedback left">한글 7자이내의 이름을 입력하세요</div>
                    </div>
                </div>

                <div class="row flex-container">
                    <div class="row w-25">
                        <label>이메일<span class="red">*</span></label>
                    </div>
                    <div class="row w-75 pr-30">
                        <input type="text" name="memberEmail" placeholder="예: test@kh.com"
                                class="form-input w-100">
                        <div class="fail-feedback left">이메일 형식으로 입력해주세요</div>
                    </div>
                </div>
                <div class="row flex-container">
                    <div class="row w-25">
                        <label>생년월일</label>
                    </div>
                    <div class="row w-75 pr-30">
                        <input type="date" name="memberBirth" 
                        class="form-input w-100">
                        <div class="fail-feedback left">잘못된 날짜를 선택하셨습니다</div>
                    </div>
                </div>

                <div class="row flex-container">
                    <div class="row w-25">
                        <label>휴대폰<span class="red">*</span></label>
                    </div>
                    <div class="row w-75 pr-30">
                        <input type="tel" name="memberContact" placeholder="01012341234(-없이)"
                                class="form-input w-100">
                        <div class="fail-feedback left">휴대폰 번호를 입력해주세요</div>
                    </div>
                </div>
                <div class="row flex-container">
                    <div class="row w-25">
                        <label style="display: block;">주소<span class="red">*</span></label>
                    </div>
                    <div class="row w-75 left">
                        <input type="text" name="memberPost" placeholder="우편번호" class="form-input post-search"
                                size="6" maxlength="6" readonly>
                        <button type="button" class="btn post-search">
                            <i class="fa-solid fa-magnifying-glass"></i>
                        </button>
                    </div>
                </div>
                <div class="row flex-container">
                    <div class="w-25"></div>
                    <div class="w-75 pr-30">
                        <input type="text" name="memberAddr1" placeholder="기본주소"
                                    class="form-input post-search w-100 " readonly>
                    </div>
                </div>
                <div class="row flex-container">
                    <div class="w-25"></div>
                    <div class="w-75 pr-30">
                        <input type="text" name="memberAddr2" placeholder="상세주소"
                                    class="form-input w-100" >
                        <div class="fail-feedback left">주소 입력시 모든 주소를 작성해주세요</div>
                    </div>
                </div>
                <hr class="mt-30">
                <div class="row flex-container">
                    <div class="w-25 mt-10">약관동의<span class="red">*</span></div>
                    <div class="w-75"> 
                        <div class="row left">
                            <label class="custom-checkbox">
                                <input  type="checkbox" class="check-all"><span></span> 전체 동의합니다
                            </label>
                        </div>
                        <div class="row left"> 
                            <label class="custom-checkbox">
                                <input  type="checkbox" class="check-item"><span></span> 이용약관동의(필수)
                            </label>
                        </div> 
                        <div class="row left"> 
                            <label class="custom-checkbox">
                                <input  type="checkbox" class="check-item"><span></span> 개인정보수집동의(필수)
                            </label>
                        </div> 
                        <div class="row left"> 
                            <label class="custom-checkbox">
                                <input  type="checkbox" class="check-item"><span></span> 본인은 만 14세 이상입니다(필수)
                            </label>
                        </div> 
                    </div>
                </div>
                <div class="row pt-10">
                    <button type="submit" class="btn btn-orange">가입하기</button>
                </div>


        </div>
    </form>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>