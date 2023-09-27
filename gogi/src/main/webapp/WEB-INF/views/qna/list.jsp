<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:choose>
	<c:when test="${sessionScope.level == '관리자'}">
		<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>
	</c:when>
	<c:otherwise>
		<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>	
	</c:otherwise>
</c:choose>
<style>
.qnaTitle{
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

<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<button onclick="requestPay()"><img src="/images/pay/kakaopay.png"width="100px"height="50px"></button>
<script>
const userCode = "imp14397622";
IMP.init(userCode);

function requestPay() {
  IMP.request_pay({
    pg: "kakaopay",
    pay_method: "card",
    merchant_uid: "test_lmswa6lo",
    name: "테스트 결제",
    amount: 100,
    buyer_tel: "010-0000-0000",
  });
}
</script>




	<div class="container w-800 navy">
        <div class="row pb-30">
            <h2>자주하는 질문</h2>
        </div>
    
    <%-- 작성은 관리자가 로그인한 경우에만 출력 --%>
		<c:if test="${sessionScope.level =='관리자' }">
	        <div class="row right">
	            <a href="/qna/add" class="btn btn-orange">작성</a>
	        </div>
		</c:if>
        
        <%-- 
    검색일 경우 검색어를 추가로 출력 
    (참고) 논리 반환값을 가지는 getter 메소드는 get이 아니라 is로 시작한다
        --%>
        <c:if test="${vo.search}">
        <div class="row left">
            &quot;${vo.keyword}&quot;에 대한 검색 결과
        </div>
        </c:if>
        
        
        <div class="row">
            <table class=" table table-slit">
                <thead>
                    <tr>
                            <th>번호</th>
                            <th>카테고리</th>
                            <th width="50%">제목</th>
                    </tr>
                </thead>

                <c:forEach var="qnaDto" items="${list}">				
                    <tr>
                        <td>${qnaDto.qnaNo}</td>
                        <td>카테고리</td>
                        <td class="left w-70"><a class="qnaTitle navy" href="detail?qnaNo=${qnaDto.qnaNo}">${qnaDto.qnaTitle}</a></td>    
                    </tr>
                </c:forEach>
            
            </table>	
        </div>

</div>

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




<!-- 검색기능 -->

<div align="center">
<form action="list" method="get">

    <c:choose>
        <c:when test="${param.type == 'shopAfterId'}">
            <select name="type" 
                required="required"  class="form-input">
                <option value="qna_title">제목</option>
                <option value="qna_category" selected="selected">카테고리</option>
            </select>
        </c:when>
        <c:otherwise>
            <select name="type" 
                required="required"  class="form-input">
                <option value="qna_title" selected="selected">제목</option>
                <option value="qna_category">카테고리</option>
            </select>
        </c:otherwise>
    </c:choose>



    <input class="form-input" type="search" name="keyword" required="required"
         placeholder="검색어를 입력해주세요"
        >
    <button class="btn btn-navy" type="submit">검색</button>
</form>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>