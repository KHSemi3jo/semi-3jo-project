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
     
     
         
    </script>

    <div class="container w-600 navy">
        <div class="row pb-20 pt-30">
            <h2 >회원 정보 변경</h2>
        </div>

        <form action="edit" method="post" autocomplete="off"autocomplete="off" >
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
                    <a href="${pageContext.request.contextPath}/admin/member/list"class="btn btn-navy ">목록</a>
                </div>
    	</form>
   </div>



<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include>