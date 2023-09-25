<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

                <h2 >배송지 관리</h2>
                <hr>
                

<table border= "1"  width= "800">
<thead>
<tr>
	<th>이름</th>
	<th>연락처</th>
	<th>주소</th>
	<th>수정</th>
</tr>
</thead>
 <tbody align="center">
    <c:forEach var= "memberDto" items= "${list}">
<tr>
	 <td><a href="detail?memberId=${memberDto.memberId}">${memberDto.memberId}</a></td>
    <td> ${memberDto.memberName}</td>
    <td> ${memberDto.memberContact}</td>
    <td> ${memberDto.memberAddr1}</td>
  <td>
 	<a href="addressDetail">수정</a></td>
</c:forEach>
</tbody>
</table>
	
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>