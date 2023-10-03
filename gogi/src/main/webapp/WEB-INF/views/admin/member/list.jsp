<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>
<style>
.listTitle,
.menu{
	text-decoration: none;
}
select.form-input,
.form-input,
.btn.btn-navy{
	font-size:16px;
	height:2.8em;
    border-radius: 0.1em;
}

</style>

<div class="container w-600 navy">
			<div class="row pb-20">
				<h2>회원 정보 관리</h2>
			</div>

<table class=" table table-slit table-stripe" >
<thead>
<tr>
	<th width="15%">등급</th>
	<th width="40%" >아이디</th>
	<th>이름</th>
	<th>메뉴</th>
</tr>
</thead>

 <tbody align="center">
    <c:forEach var= "memberListDto" items= "${list}">
		<tr>
		    <td> ${memberListDto.memberLevel}</td>
			<td class="left"><a class="listTitle navy" href="detail?memberId=${memberListDto.memberId}">${memberListDto.memberId}</a></td>
		    <td class="left"> ${memberListDto.memberName}</td>
		    <td>
				<a class="menu navy" href="edit?memberId=${memberListDto.memberId}">수정</a>	
				<c:choose>
					<c:when test="${memberListDto.block == 'Y'}">
						<a class="menu orange" href="cancel?memberId=${memberListDto.memberId}">차단</a>
					</c:when>
					<c:otherwise>
						<a class="menu navy" href="block?memberId=${memberListDto.memberId}">해제</a>
					</c:otherwise>
				</c:choose>
		 	</td>
		</tr>
	</c:forEach>
</tbody>

</table>

		<!-- 페이지네비게이션 -->
		<div class="row page-navigator mv-30">
                <!-- 이전 버튼 -->
                <c:if test="${!vo.first}">
                    <a href="list?${vo.prevQueryString}">
                        <i class="fa-solid fa-angle-left"></i>
                    </a>
                </c:if>
            
                <!-- 숫자 버튼 -->
                <c:forEach var="i" begin="${vo.begin}" end="${vo.end}" step="1">
                    <c:choose>
                        <c:when test="${vo.page == i}">
                            <a class="on">${i}</a>
                        </c:when>
                        <c:otherwise>
                            <a href="list?${vo.getQueryString(i)}">${i}</a> 
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            
                <!-- 다음 버튼 -->
                <c:if test="${!vo.last}">
                    <a href="list?${vo.nextQueryString}">
                        <i class="fa-solid fa-angle-right"></i>
                    </a>
                </c:if>
        </div>
        
		<%--키워드 별 검색창  --%>
	<div align="center">	
		<form action="list" method="get">
		<c:choose>
				<c:when test="${vo.type == 'member_name'}">
					<select name="type"  class="form-input">
						<option value="member_id">아이디</option>
						<option value="member_name" selected>이름</option>
						<option value="member_contact">전화번호</option>
						<option value="member_email">이메일</option>
						<option value="member_birth">생년월일</option>
					</select>
				</c:when>
				<c:when test="${vo.type == 'member_contact'}">
					<select name="type"  class="form-input">
						<option value="member_id">아이디</option>
						<option value="member_name">이름</option>
						<option value="member_contact" selected>전화번호</option>
						<option value="member_email">이메일</option>
						<option value="member_birth">생년월일</option>
					</select>
				</c:when>
				<c:when test="${vo.type == 'member_email'}">
					<select name="type"  class="form-input">
						<option value="member_id">아이디</option>
						<option value="member_name">이름</option>
						<option value="member_contact">전화번호</option>
						<option value="member_email" selected>이메일</option>
						<option value="member_birth">생년월일</option>
					</select>
				</c:when>
				<c:when test="${vo.type == 'member_birth'}">
					<select name="type"  class="form-input">
						<option value="member_id">아이디</option>
						<option value="member_name">이름</option>
						<option value="member_contact">전화번호</option>
						<option value="member_email">이메일</option>
						<option value="member_birth" selected>생년월일</option>
					</select>
				</c:when>
				<c:otherwise>
					<select name="type"  class="form-input">
						<option value="member_id">아이디</option>
						<option value="member_name">이름</option>
						<option value="member_contact">전화번호</option>
						<option value="member_email">이메일</option>
						<option value="member_birth">생년월일</option>
					</select>
				</c:otherwise>
				</c:choose>
		
			<input class="form-input" type="search" name="keyword"value="${vo.keyword}" required>
			<button class="btn btn-navy" type="submit">검색</button>
		</form>
		<%--키워드별 검색창 끝 --%>	
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include>