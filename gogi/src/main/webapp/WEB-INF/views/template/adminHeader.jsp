<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


 <script >
window.contextPath = "${pageContext.request.contextPath}";
</script>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고기어때</title>

<!-- 아이콘 사용을 위한 Font Awesome 6 CDN -->
<link rel="stylesheet" type="text/css"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<!-- 구글 웹 폰트 사용을 위한 CDN -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap"
	rel="stylesheet">
	
<!-- 내가 만든 CSS 파일-->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/reset.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/Gogi-layout.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/Gogi-commons.css">


<!-- kakao map cdn -->
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3709f5830a9a640bad10f7d345d86cb5"></script>
<!-- jquery cdn -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<!-- swiper cdn -->
   <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />
   <script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
<style>
.btn.btn-search{
	padding: 0.5em 0.7em;
	    line-height: 1.4em;
}
.hidden-select{
	display: none;
}
</style>

</head>

<!-- javascript 작성 공간 -->
<script>


</script>

</head>
<body>
    <main>
        <header>
            <div class="logo">
                <a href="/main"><img src="${pageContext.request.contextPath}/images/logo/GogiLogo-main.png"width=150 height="150"></a>
            </div>
            <div class="title flex-container ">
                <form action="${pageContext.request.contextPath}/product/list" method="get">
	                <div class="row input-search">
		                <c:choose>
							<c:when test="${vo.type == 'productName'}"></c:when>
							<c:otherwise>
							<select class="form-input hidden-select" name="type">
							<option value="product_name" selected>상품이름</option>
							</select>
							</c:otherwise>
						</c:choose>
	                    <input type="search" name="keyword" class="form-input search-navy"
	                                placeholder="검색어를 입력해주세요" autocomplete="off">
	                    <button type="submit" class="btn btn-search"><i class="fa-solid fa-magnifying-glass orange"></i></button>
	                </div>
	             </form>
            </div>
            <div class="etc flex-container">
                <div class="row pr-20 navy">${sessionScope.name} 님</div>
                <div class="row pr-20 etc-menu navy"><a class="orange" href="${pageContext.request.contextPath}/member/logout">로그아웃</a></div>
            </div>
        </header>
        <nav>
            <ul class="menu menu-navy center">
                <li><a href="#"><i class="fa-solid fa-bars "></i> 고객센터</a>
                    <ul>
                        <li><a class="left" href="${pageContext.request.contextPath}/notice/list">공지사항 관리</a></li>
                        <li><a class="left" href="${pageContext.request.contextPath}/qna/list">QnA 관리</a></li>
                        <li><a class="left" href="${pageContext.request.contextPath}/one/list">1:1 문의</a></li>
                    </ul>
                </li>
                <li><a href="#"><i class="fa-solid fa-bars "></i> 회원 관리</a>
                    <ul>
                        <li><a class="left" href="${pageContext.request.contextPath}/admin/member/list?size=20">회원정보관리</a></li>
                       
                    </ul>
                </li>
                <li><a href="#"><i class="fa-solid fa-bars "></i> 상품 관리</a>
                	<ul>
                        <li><a class="left" href="${pageContext.request.contextPath}/product/list">상품 목록</a></li>
                        <li><a class="left" href="${pageContext.request.contextPath}/product/add">상품 등록</a></li>
                    </ul>
                </li>
            </ul>
        </nav>
        <section>