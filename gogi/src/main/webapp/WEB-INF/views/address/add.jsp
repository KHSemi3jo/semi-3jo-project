<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<c:choose>
	<c:when test="${sessionScope.level == '관리자'}">
		<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>
	</c:when>
	<c:otherwise>
		<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>	
	</c:otherwise>
</c:choose>
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
                    document.querySelector("[name=addressPost]").value = data.zonecode;
                    document.querySelector("[name=addressNormal]").value = addr;
                    // 커서를 상세주소 필드로 이동한다.
                    document.querySelector("[name=addressDetail]").focus();
            }
        }).open();
        });
    });
    </script>
      
    <form action="change" method="post">
	    <div class="container w-600">

            <div class="row left">
                <h2 >배송지 관리</h2>
            </div>
            <hr>
            </div>
  <div class="row flex-container">
                    <div class="row w-25">
                        <label style="display: block;">주소</label>
                    </div>
                    <div class="row w-75 left">
                        <input type="text" name="addressPost" class="form-input post-search"
                                size="6" maxlength="6" value="${addressDto.addressPost}">
                        <button type="button" class="btn post-search">
                            <i class="fa-solid fa-magnifying-glass"></i>
                        </button>
                    </div>
                </div>
                <div class="row flex-container">
                    <div class="w-25"></div>
                    <div class="w-75 pr-30">
                        <input type="text" name="addressNormal"
                                    class="form-input post-search w-100 " value="${addressDto.addressNormal}">
                    </div>
                </div>
                <div class="row flex-container">
                    <div class="w-25"></div>
                    <div class="w-75 pr-30">
                        <input type="text" name="addressDetail"  value="${addressDto.addressDetail}"
                                    class="form-input w-100" >
                        <div class="fail-feedback left">주소 입력시 모든 주소를 작성해주세요</div>
                    </div>
                </div>
</form>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>