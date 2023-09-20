<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="/js/join.js"></script>
<script src="/js/multipage.js"></script>

<!-- daum 우편 API cdn -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<!-- 주석 -->
<!-- javascript 작성 공간 -->
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
                    //document.querySelector("[name=memberPost]").value = data.zonecode;
                    $("[name=memberPost]").val(data.zonecode);
                    //document.querySelector("[name=memberAddr1]").value = addr;
                    $("[name=memberAddr1]").val(addr);
                    // 커서를 상세주소 필드로 이동한다.
                    //document.querySelector("[name=memberAddr2]").focus();
                    $("[name=memberAddr2]").focus();
                    $(".post-clear").show();
                }
            }).open();
        });
        
        //x버튼 누르면 주소 지우기
        $(".post-clear").click(function(){
        	$("[name=memberPost],[name=memberAddr1],[name=memberAddr2]").val("").removeClass("success fail");
        });
        $("[name=memberAddr2]").on("input blur", function(){
			var post = $("[name=memberPost]").val();
			var addr1 = $("[name=memberAddr1]").val();
			var addr2 = $("[name=memberAddr2]").val();
			if(post.length == 0 && addr1.length == 0 && addr2.length == 0) {
				$(".post-clear").hide();				
			}
			else {
				$(".post-clear").show();        	
			}
        });
        $(".post-clear").hide();
    });
</script>

<form class="join-form" action="" method="post" autocomplete="off">

<div class="container w-600">
    <div class="row">
        <h1>회원가입</h1>
    </div>

    <!-- 1단계 : 아이디+비밀번호+확인 -->
        <div class="row left">
            <label>아이디 <i class="fa-solid fa-asterisk red"></i></label>
            <input type="text" name="memberId" placeholder="영문 소문자, 숫자 5~20자"
                    class="form-input w-100">
            <div class="success-feedback">멋진 아이디입니다!</div>
            <div class="fail-feedback">아이디를 형식에 맞게 입력하세요</div>
            <div class="fail2-feedback">이미 사용중인 아이디입니다</div>
        </div>
        <div class="row left">
            <label>비밀번호 <i class="fa-solid fa-asterisk red"></i></label>
            <input type="password" name="memberPw" 
                    placeholder="영문,숫자,특수문자 반드시 1개 이상 포함"
                    class="form-input w-100">
            <div class="success-feedback">올바른 비밀번호 형식입니다</div>
            <div class="fail-feedback">잘못된 비밀번호 형식입니다</div>
        </div>
        <div class="row left">
            <label>비밀번호 확인 <i class="fa-solid fa-asterisk red"></i></label>
            <input type="password" id="password-check" 
                    placeholder="비밀번호 한 번 더 입력" class="form-input w-100">
            <div class="success-feedback">비밀번호가 일치합니다</div>
            <div class="fail-feedback">비밀번호가 일치하지 않습니다</div>
            <div class="fail2-feedback">비밀번호를 먼저 작성하세요</div>
        </div>
        
       <!-- 이름 -->
       <div class="row left">
       <label>이름 <i class="fa-solid fa-asterisk red"></i></label>
       <input type="text" name="memberName" class="form-input w-100">
       </div>

    <!-- 3단계 : 이메일+연락처 -->
        <div class="row left">
            <label>이메일</label>
            <input type="text" name="memberEmail" 
                    placeholder="test@kh.com" class="form-input w-100">
            <div class="fail-feedback">이메일 형식이 잘못되었습니다</div>
        </div>
        <div class="row left">
            <label>연락처</label>
            <input type="tel" name="memberContact" placeholder="010XXXXXXXX (- 없이)"
                    class="form-input w-100">
            <div class="fail-feedback">전화번호 형식이 올바르지 않습니다</div>
        </div>

    
    <!-- 4단계 : 생년월일-->
        <div class="row left">
            <label>생년월일</label>
            <input type="date" name="memberBirth" class="form-input w-100">
            <div class="fail-feedback">잘못된 날짜를 선택하셨습니다</div>
        </div>

    <!-- 5단계 : 주소 -->
        <div class="row left">
            <label style="display: block;">주소</label>
                <input type="text" name="memberPost" placeholder="우편번호"
                            class="form-input post-search" size="6" maxlength="6"
                                readonly>
                <button type="button" class="btn post-search">
                    <i class="fa-solid fa-magnifying-glass"></i>
                </button>
                <button type="button" class="btn btn-negative post-clear">
                	<i class="fa-solid fa-x"></i>
                </button>
    
                <input type="text" name="memberAddr1" placeholder="기본주소"
                            class="form-input w-100 mt-10 post-search"
                            readonly>
                <input type="text" name="memberAddr2" placeholder="상세주소"
                            class="form-input w-100 mt-10">
                <div class="fail-feedback">모든 주소를 작성해주세요</div>
            </div>
                <button type="submit" class="btn btn-positive w-100">가입하기</button>            
</div>
	</form>
	<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>

