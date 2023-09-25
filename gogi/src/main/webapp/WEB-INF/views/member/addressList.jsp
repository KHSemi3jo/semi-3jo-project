<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

                <h2 >배송지 관리</h2>
<table border= "1"  width= "800">
<thead>
<tr>
	<th>아이디</th>
	<th>이름</th>
	<th>주소</th>
	<th>연락처</th>
	<th>수정</th>
</tr>
</thead>

 <tbody align="center">
    <c:forEach var= "addressDto" items= "${list}">
<tr>
	 <td><a href="detail?memberId=${addressDto.memberId}">${addressDto.memberId}</a></td>
    <td> ${memberListDto.memberName}</td>
    <td> ${addressDto.addressNormal}</td>
    <td> ${memberListDto.memberContact}</td>

  <td>
 	<a href="edit?memberId=">수정</a>
</c:forEach>
</tbody>
</table>
	
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>