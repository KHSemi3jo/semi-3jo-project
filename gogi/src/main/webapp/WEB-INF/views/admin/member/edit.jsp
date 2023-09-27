<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>
    <style>
.custom-checkbox {
    display: inline-block;
    font-size: 18px;
    position: relative;
}
.custom-checkbox > [type=radio] {
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
.custom-checkbox > [type=radio]:checked + span {
    background-image: url("/images/checkbox/checkbox-check.png");
}
.w-20{
    display: inline-flex;
    
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

    <div class="container w-600 navy">
        <div class="row pb-20 pt-30">
            <h2 >회원 정보 변경</h2>
        </div>

        <form class="change-form" action="edit" method="post" autocomplete="off">
        <input type="hidden" name="memberId" value="${memberDto.memberId}">
            <hr class="navy">
                <div class="row flex-container pt-20">
                    <div class="row w-25 left">
                        <label>아이디</label>
                    </div>
                    <div class="row w-75 pr-30">
                        <input type="text" name="memberId" class="form-input w-100"
                                     value="${memberDto.memberId}"  readonly >
                    </div>
                </div>
                <div class="row flex-container">
                    <div class="row w-25 left">
                        <label>이름</label>
                    </div>
                    <div class="row w-75 pr-30">
                        <input type="text" name="memberName" class="form-input w-100"
                                     value="${memberDto.memberName}"  readonly >
                    </div>
                </div>
                <div class="row flex-container">
                    <div class="row w-25 left">
                        <label>등급</label>
                    </div>
                        <c:choose>
                                <c:when test="${memberDto.memberLevel == 'VIP'}">
                   					 <div class="row float-container w-75 left">
                                        <div class="row w-20">
                                            <label class="custom-checkbox">
                                                <input type="radio"  name="memberLevel" value="일반">
                                                <span ></span> 일반 
                                            </label>
                                        </div>
                                        <div class="row w-20 pl-10">
                                            <label class="custom-checkbox">
                                                <input type="radio"  name="memberLevel" checked value="Vip">
                                                <span ></span> Vip 
                                            </label>
                                        </div>
                                        <div class="row w-20 pl-10">
                                            <label class="custom-checkbox">
                                                <input type="radio"  name="memberLevel" value="관리자">
                                                <span ></span> 관리자 
                                            </label>
                                        </div>
                                    </div>
                                </c:when>
                                <c:when test="${memberDto.memberLevel == '관리자'}">
                                	<div class="row float-container w-75 left">
                                        <div class="row w-20">
                                            <label class="custom-checkbox">
                                                <input type="radio"  name="memberLevel" value="일반">
                                                <span ></span> 일반
                                            </label>
                                        </div>
                                        <div class="row w-20 pl-10">
                                            <label class="custom-checkbox">
                                                <input type="radio"  name="memberLevel" value="Vip" >
                                                <span ></span> Vip
                                            </label>
                                        </div>
                                        <div class="row w-20 pl-10">
                                            <label class="custom-checkbox">
                                                <input type="radio"  name="memberLevel"checked value="관리자" >
                                                <span ></span> 관리자
                                            </label>
                                        </div>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                	<div class="row float-container w-75 left">
                                        <div class="row w-20">
                                            <label class="custom-checkbox">
                                                <input type="radio"  name="memberLevel" checked value="일반">
                                                <span ></span> 일반
                                            </label>
                                        </div>
                                        <div class="row w-20 pl-10">
                                            <label class="custom-checkbox">
                                                <input type="radio"  name="memberLevel" value="Vip" >
                                                <span ></span> Vip
                                            </label>
                                        </div>
                                        <div class="row w-20 pl-10">
                                            <label class="custom-checkbox">
                                                <input type="radio"  name="memberLevel" value="관리자">
                                                <span ></span> 관리자
                                            </label>
                                        </div>
                                    </div>
                                </c:otherwise>
                           </c:choose>
                </div>            
               
                <div class="row flex-container">
                    <div class="row w-25 left">
                        <label>G-money</label>
                    </div>
                    <div class="row w-75 pr-30">
                        <input type="number"  min='0'  step='10'  name="memberGmoney" class="form-input w-100"
                                value="${memberDto.memberGmoney}">
                    </div>
                </div>

                <hr class="mt-30">               
                <div class="row pt-10">
                    <button type="submit" class="btn btn-orange btn-save">정보변경</button>
                    <a href="/admin/member/list"class="btn btn-navy ">목록</a>
                </div>
    	</form>
   </div>



<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include>