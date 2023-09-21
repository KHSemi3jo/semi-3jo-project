<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<link rel="stylesheet" type="text/css" href="/css/reset.css">
<link rel="stylesheet" type="text/css" href="/css/Gogi-layout.css">
<link rel="stylesheet" type="text/css" href="/css/Gogi-commons.css">
<!-- kakao map cdn -->
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3709f5830a9a640bad10f7d345d86cb5"></script>
<!-- swiper cdn -->
   <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />
   <script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
<!-- jquery cdn -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
.btn.btn-search{
	padding: 0.5em 0.7em;
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
                <a href="/main"><img src="/images/logo/GogiLogo-main.png"width=150 height="150"></a>
            </div>
            <div class="title flex-container ">
                <div class="row input-search">
                    <input type="search" name="keyword" class="form-input search-navy" value="${param.keyword}" 
                                placeholder="검색어를 입력해주세요" autocomplete="off">
                    <button type="submit" class="btn btn-search"><i class="fa-solid fa-magnifying-glass orange"></i></button>
                </div>
            </div>
        <div class="etc">
			  		<%-- 세션에 저장된 name이라는 이름의 값으로 회원/비회원 구분  --%>
					<c:choose>
								<%--회원일시 보이는 etc 메뉴 --%>
								<c:when test="${sessionScope.name != null}">
								        	<%-- 회원일시 로그인된 회원이름(로그인자리) --%>
							                <div class="row pr-30"><a><i class="cart fa-solid fa-cart-shopping fa-xl navy"></i></a></div>
							                <div class="row pr-20 member-menu navy"><span>${sessionScope.name} 님<i class="fa-solid fa-angle-down"></i></span>
							                    <div class="member-service">
							                        <a href="#">G-money</a>
							                        <a href="/payment/list">주문내역</a>
							                        <a href="/shopAfter/list">상품후기</a>
							                        <a href="/member/mypage">마이페이지</a>
							                        <a href="/member/logout">로그아웃</a>
							                    </div>
							                </div>								        	
									</c:when>							        	
						        	<c:otherwise>     	
						        	<%--비회원일시 보이는 etc 메뉴 --%>
								            <%--비회원이 장바구니를 눌렀을 땐 로그인 화면으로 이동하거나 로그인 필요 팝업 --%>
								                <div class="row pr-30"><a href="/basket/list"><i class="cart fa-solid fa-cart-shopping fa-xl navy"></i></a></div>
										                <div class="row pr-20"><a href="/member/join" class="orange">회원가입</a></div>
										                <div class="row pr-20 etc-menu navy"><a href="/member/login">로그인</a></div>										                
						        	</c:otherwise>
						</c:choose>
						<div class="row etc-menu custom-menu navy"><span>고객센터 <i class="fa-solid fa-angle-down"></i></span>
		                    <div class="custom-service">
		                        <a href="/notice/list">공지사항</a>
		                        <a href="/qna/list">자주하는 질문</a>
		                        <a href="/one/list">1:1 문의</a>
		                    </div>
                		</div>
			  </div>        	
        </header>
        <nav>
            <ul class="menu menu-navy center">
                <li><a href="#"><i class="fa-solid fa-bars "></i> 카테고리</a>
                    <ul>
                        <li><a href="#">수입산 소고기</a></li>
                        <li><a href="#">국내산 소고기</a></li>
                        <li><a href="#">돼지고기</a></li>
                    </ul>
                </li>
                <li><a href="#">신상품</a></li>
                <li><a href="#">베스트</a></li>
                <li><a href="#">알뜰쇼핑</a></li>
                <%-- 관리자인 경우 추가 메뉴 출력 --%>
	   				<c:if test = "${sessionScope.level == '관리자'}">
	   					<li><a href="/admin/home">관리자메뉴</a></li>
	   				</c:if>
            </ul>
        </nav>
        <section>