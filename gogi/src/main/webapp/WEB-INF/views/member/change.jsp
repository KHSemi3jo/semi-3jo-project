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
                            class="form-input w-100" readonly>
                    </div>
                </div>
                
                <div class="row flex-container">
                    <div class="row w-25 left">
                        <label>현재 비밀번호</label>
                    </div>
                    <div class="row w-75 pr-30">
                        <input type="password" name="originPw" value="${memberDto.memberPw}"
                            class="form-input w-100">
                    </div>
                </div>
                
                <div class="row flex-container">
                    <div class="row w-25 left">
                        <label>새 비밀번호</label>
                    </div>
                    <div class="row w-75 pr-30">
                        <input type="password" name="memberPw"class="form-input w-100">
                    </div>
                </div>
                
                <div class="row flex-container">
                    <div class="row w-25 left">
                        <label>새 비밀번호 확인</label>
                    </div>
                    <div class="row w-75 pr-30">
                        <input type="password" name="memberPw" value="${memberDto.memberPw}"
                            class="form-input w-100" >
                    </div>
                </div>


                <div class="row flex-container">
                    <div class="row w-25 left">
                        <label>이름</label>
                    </div>
                    <div class="row w-75 pr-30">
                        <input type="text" name="memberName"value="${memberDto.memberName}" 
                        placeholder="이름을 입력해주세요" class="form-input w-100" readonly>

                    </div>
                </div>

                <div class="row flex-container">
                    <div class="row w-25">
                        <label>이메일</label>
                    </div>
                    <div class="row w-75 pr-30">
                        <input type="text" name="memberEmail"value="${memberDto.memberEmail}"
                                class="form-input w-100">
                        <div class="fail-feedback left">이메일 형식으로 입력해주세요</div>
                    </div>
                </div>
                <div class="row flex-container">
                    <div class="row w-25">
                        <label>생년월일</label>
                    </div>
                    <div class="row w-75 pr-30">
                        <input type="text" name="memberBirth" value="${memberDto.memberBirth}"
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
                        <a class="btn btn-orange " href="change">                         
                            회원정보수정
                        </a>
                    </div> 
                </div>
        </div> 
    </form>




<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>