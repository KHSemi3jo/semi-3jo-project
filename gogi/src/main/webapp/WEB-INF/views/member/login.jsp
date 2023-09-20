<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
.container.w-300 input{
    border-color: #ADBBCA;
    border-radius: 3px;
}
.container.w-300 input:focus{
    border-color: #1A426C;
}
</style>


<form action="login" method="post" autocomplete="off">
        <div class="container w-300">
                <div class="row">
                    <h2>로그인</h2>
                </div>
                <div class="row">
                    <input type="text" name="memberId" class="form-input"
                        placeholder="아이디를 입력해주세요">
                </div>
                <div class="row">
                    <input type="password" name="memberPw" class="form-input"
                        placeholder="비밀번호를 입력해주세요" >
                </div>
                <div class="row right">
                    <a href="findPw" class="link">비밀번호 찾기</a>
                </div>
                <div class="row">
                    <button class="btn btn-orange w-100">로그인</button>
                </div>
                <div class="row">
                    <button class="btn w-100">회원가입</button>
                </div>
            </div>
</form>

<%-- -- if(주소에 파라미터 중 error라는 녀석이 있다면 ){
	<h3>아이디 또는 비밀번호가 일치하지 않습니다</h3>
}--%> 


<%--
	EL은 출력을 쉽게하기 위한 언어이므로 여러 데이터를 쉽게 접근할 수 있다 
	파라미터를 읽고 싶을 경우 param이라는 내장객체(기본아이템)를 사용할 수 있다
	param을 이용하여 파라미터를 비교할 수 있다
	 --%>
<c:if test="${param.error != null}">
		<h3 class="orange">아이디 또는 비밀번호가 일치하지 않습니다</h3>
</c:if>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>