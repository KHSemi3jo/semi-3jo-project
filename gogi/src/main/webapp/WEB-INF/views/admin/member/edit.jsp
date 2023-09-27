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

    <div class="container w-600 navy">
        <div class="row pb-20 pt-30">
            <h2 >회원 정보 변경</h2>
        </div>

        <form action="edit" method="post" autocomplete="off">
        <input type="hidden" name="memberId" value="${memberDto.memberId}">
            <hr class="navy">
                <div class="row flex-container pt-20">
                    <div class="row w-25 left">
                        <label>이름</label>
                    </div>
                    <div class="row w-75 pr-30">
                        <input type="text" name="memberName" class="form-input w-100"
                                     value="${memberDto.memberName}"   required>
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
                        <label>이메일</label>
                    </div>
                    <div class="row w-75 pr-30">
                        <input type="email" name="memberEmail" class="form-input w-100"
                                 value="${memberDto.memberEmail}">
                    </div>
                </div>

                <div class="row flex-container">
                    <div class="row w-25 left">
                        <label>전화번호</label>
                    </div>
                    <div class="row w-75 pr-30">
                        <input type="tel" name="memberContact" class="form-input w-100"
                                value="${memberDto.memberContact}">
                    </div>
                </div>

                <div class="row flex-container">
                    <div class="row w-25 left">
                        <label>생년월일</label>
                    </div>
                    <div class="row w-75 pr-30">
                        <input type="text" name="memberBirth" class="form-input w-100"
                                value="${memberDto.memberBirth}">
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
                    </div>
                </div>
               
                <div class="row flex-container">
                    <div class="row w-25 left">
                        <label>G-money</label>
                    </div>
                    <div class="row w-75 pr-30">
                        <input type="number" name="memberGmoney" class="form-input w-100"
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