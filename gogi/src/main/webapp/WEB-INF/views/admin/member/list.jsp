<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<h2>전체회원관리</h2>

<form action="list" method="get">

<c:choose>
		<c:when test="${vo.type == 'member_name'}">
			<select name="type">
				<option value="member_id">아이디</option>
				<option value="member_name" selected>이름</option>
				<option value="member_contact">전화번호</option>
				<option value="member_email">이메일</option>
				<option value="member_birth">생년월일</option>
			</select>
		</c:when>
		<c:when test="${vo.type == 'member_contact'}">
			<select name="type">
				<option value="member_id">아이디</option>
				<option value="member_name">이름</option>
				<option value="member_contact" selected>전화번호</option>
				<option value="member_email">이메일</option>
				<option value="member_birth">생년월일</option>
			</select>
		</c:when>
		<c:when test="${vo.type == 'member_email'}">
			<select name="type">
				<option value="member_id">아이디</option>
				<option value="member_name">이름</option>
				<option value="member_contact">전화번호</option>
				<option value="member_email" selected>이메일</option>
				<option value="member_birth">생년월일</option>
			</select>
		</c:when>
		<c:when test="${vo.type == 'member_birth'}">
			<select name="type">
				<option value="member_id">아이디</option>
				<option value="member_name">이름</option>
				<option value="member_contact">전화번호</option>
				<option value="member_email">이메일</option>
				<option value="member_birth" selected>생년월일</option>
			</select>
		</c:when>
		<c:otherwise>
			<select name="type">
				<option value="member_id">아이디</option>
				<option value="member_name">이름</option>
				<option value="member_contact">전화번호</option>
				<option value="member_email">이메일</option>
				<option value="member_birth">생년월일</option>
			</select>
		</c:otherwise>
		</c:choose>

<%-- 	<input type="search" name="keyword" placeholder="검색어" 
	vale="${vo.keyword}" required>
	<button>검색</button> --%>
	
</form>
	
<br>

<table border= "1"  width= "800">
<thead>
<tr>
	<th>아이디</th>
	<th>이름</th>
	<th>전화번호</th>
	<th>이메일</th>
	<th>생년월일</th>
	<th>등급</th>
	<th>메뉴</th>
	<th>차단</th>
</tr>
</thead>

 <tbody align="center">
    <c:forEach var= "memberListDto" items= "${list}">
<tr>
	 <td><a href="detail?memberId=${memberListDto.memberId}">${memberListDto.memberId}</a></td>
    <td> ${memberListDto.memberName}</td>
    <td> ${memberListDto.memberContact}</td>
    <td> ${memberListDto.memberEmail}</td>
    <td> ${memberListDto.memberBirth}</td>
    <td> ${memberListDto.memberLevel}</td>
    <td>${memberListDto.block}</td>
  <td>
 	<a href="detail?memberId=${memberListDto.memberId}">상세</a>
	<a href="edit?memberId=${memberListDto.memberId}">수정</a>
	
<c:choose>
	<c:when test="${memberListDto.block == 'Y'}">
	<a href="cancel?memberId=${memberListDto.memberId}">해제</a>
</c:when>
<c:otherwise>
	<a href="block?memberId=${memberListDto.memberId}">차단</a>
</c:otherwise>
</c:choose>


 </td>

</tr>

</c:forEach>
</tbody>
</table>
<h3>
<%-- <c:if test="${!vo.first}">
	<a href="list?${vo.prevQueryString}">&lt;</a>
</c:if>

<c:forEach var="i" begin="${vo.begin}" end="${vo.end}" step="1">
	<a href="list?${vo.getQueryString(i)}">${i}</a>
</c:forEach>


<c:if test="${!vo.last}">
<a href="list?${vo.nextQueryString}">&gt;</a>

</c:if> --%>

</h3>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>