<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>
<style>

</style>

<div class="container w-600">
        <div class="row">
            <h2 class="pt-30 pb-30 navy">${memberDto.memberId} 님의 회원 정보</h2>
        </div>
        <div class="row">
            <table class="table table-slit table-stripe">
                                        <tr>
                        <th bgcolor="#CCD5DE" class="w-30 navy">이름</th>
                        <td class="left">${memberDto.memberName}</td>
                    </tr>
                    <tr>
                        <th bgcolor="#CCD5DE">아이디</th>
                        <td class="left">${memberDto.memberId}</td>
                    </tr>
                    <tr>
                        <th bgcolor="#CCD5DE">등급</th>
                        <td class="left">${memberDto.memberLevel}</td>
                    </tr>
                    <tr>
                        <th bgcolor="#CCD5DE">생년월일</th>
                        <td class="left">${memberDto.memberBirth}</td>
                    </tr>
                    <tr>
                        <th bgcolor="#CCD5DE">연락처</th>
                        <td class="left">${memberDto.memberContact}</td>
                    </tr>
                    <tr>
                        <th bgcolor="#CCD5DE">이메일</th>
                        <td class="left">${memberDto.memberEmail}</td>
                    </tr>
                    <tr>
                        <th bgcolor="#CCD5DE">주소</th>
                        <td class="left">[${memberDto.memberPost}]
                            ${memberDto.memberAddr1}
                            ${memberDto.memberAddr2}</td>
                    </tr>
                    <tr>
                        <th bgcolor="#CCD5DE">G-money</th>
                        <td class="left">${memberDto.memberGmoney}</td>
                    </tr>
                    <tr>
                        <th bgcolor="#CCD5DE">가입일</th>
                        <td class="left"><fmt:formatDate value="${memberDto.memberJoin}"
                            pattern="y년 M월 d일 E a h시 m분"/></td>
                    </tr>
                    <tr>
                        <th bgcolor="#CCD5DE">마지막로그인</th>
                        <td class="left"><fmt:formatDate value="${memberDto.memberLogin}"
                            pattern="y년 M월 d일 E a h시 m분"/></td>
                    </tr>
                    <tr>
                        <th bgcolor="#CCD5DE">비밀번호 변경일</th>
                        <td class="left"><fmt:formatDate value="${memberDto.memberChange}" pattern="y년 M월 d일 E a h시 m분"/></td>
                    </tr>
            </table>
            <div class="row right">
                <a href="/admin/member/list"class="btn btn-navy">목록</a>
               <a class="btn btn-orange" href="edit?memberId=${memberDto.memberId}">수정</a>
                
            </div>
        </div>
    </div>



<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include>