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
                <a><img src="./images/logo/GogiLogo-main.png"width=150 height="150"></a>
            </div>
            <div class="title flex-container ">
                <div class="row input-search">
                    <input type="search" name="keyword" class="form-input search-navy" value="" 
                                placeholder="검색어를 입력해주세요" autocomplete="off">
                    <button class="btn btn-search"><i class="fa-solid fa-magnifying-glass navy"></i></button>
                </div>
            </div>
            <div class="etc">
                <div class="row pr-20 orange">${sessionScope.level}</div>
                <div class="row pr-20 etc-menu navy"><a href="/member/logout">로그아웃</a></div>
            </div>
        </header>
        <nav>
            <ul class="menu menu-navy center">
                <li><a href="#"><i class="fa-solid fa-bars "></i> 고객센터</a>
                    <ul>
                        <li><a href="#">공지사항 관리</a></li>
                        <li><a href="#">1:1문의 관리</a></li>
                        <li><a href="#">QnA 관리</a></li>
                    </ul>
                </li>
                <li><a href="#"><i class="fa-solid fa-bars "></i> 회원 관리</a>
                    <ul>
                        <li><a href="/admin/member/list?size=20">회원정보관리</a></li>
                        <li><a href="/admin/member/address?size=20">회원배송지관리</a></li>
                        <li><a href="/admin/product/list?size=20">상품등록관리</a></li>
                        <li><a href="#">회원 통계</a></li>
                    </ul>
                </li>
                <li><a href="#">상품 통계</a></li>
            </ul>
        </nav>
        <section>