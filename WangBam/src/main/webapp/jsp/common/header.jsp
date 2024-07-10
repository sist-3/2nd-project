<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" href="${pageContext.request.contextPath}/img/logo.ico">
<title>왕밤빵</title>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.3/themes/base/jquery-ui.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css">
</head>

<body>
<c:set var="currentPage" value="${param.type}" />
	<div class="wrap">
		<div class="container">
			<header class="header">
				<div class="header-inner">
					<nav class="global-nav">
						<div class="global-nav-links">
							<a href="/WangBam/?type=notice" class="${currentPage.contains('notice') ? 'global-nav-item on' : 'global-nav-item'}">공지사항</a>
							<a href="/WangBam/?type=productList" class="${currentPage.contains('product') ? 'global-nav-item on' : 'global-nav-item'}">상품보기</a>
							<a href="/WangBam/?type=review" class="${currentPage.contains('review') ? 'global-nav-item on' : 'global-nav-item'}">리뷰보기</a>
							<a href="/WangBam/?type=question" class="${currentPage.contains('question') ? 'global-nav-item on' : 'global-nav-item'}">1:1문의</a>
							<a href="/WangBam/?type=brand" class="${currentPage.contains('brand') ? 'global-nav-item on' : 'global-nav-item'}">브랜드소개</a>
						</div>
					</nav>
					<nav class="local-nav">
						<div class="local-nav-links">
							<h1>
								<a href="/WangBam/?type=index" class="product-name">왕밤빵</a>
								
							</h1>
							<c:choose>
								<c:when test="${sessionScope.user.us_type eq 1}">
									<a href="/WangBam/?type=logout" onclick="confirm('로그아웃 하시겠습니까?')">로그아웃</a>
									<a href="/WangBam/?type=my">마이페이지</a>
									<a href="/WangBam/?type=order">주문현황</a>
									<a href="/WangBam/?type=cartList">장바구니</a>
								</c:when>
								<c:when test="${sessionScope.user.us_type eq 0}">
									<a href="/WangBam/?type=logout" onclick="confirm('로그아웃 하시겠습니까?')">로그아웃</a>
									<a href="/WangBam/admin?type=index">관리자모드</a>
									<a href="/WangBam/?type=my">마이페이지</a>
								</c:when>
								<c:when test="${sessionScope.user eq null}">
									<a href="/WangBam/?type=login">로그인</a>
									<a href="/WangBam/?type=signup">회원가입</a>
								</c:when>
							</c:choose>
							<div id="google_translate_element"></div>
							<!-- 언어 선택 select box -->
							<select id="language-selector">
							    <option>언어선택</option>
							    <option value="ko" translate="no">한국어</option>
							    <option value="en" translate="no">English</option>
							    <option value="ja" translate="no">日本語</option>
							</select>
						</div>
					</nav>
				</div>
			</header>
			<header class="header-m">
				<div class="header-inner">
					<nav class="local-nav">
						<div class="local-nav-links">
							<h1>
								<a href="?type=index" class="product-name">왕밤빵</a>
							</h1>
							<c:choose>
								<c:when test="${sessionScope.user.us_type eq 1}">
									<a class="icon-btn logout" title="로그아웃" href="/WangBam/?type=logout"></a>
									<a class="icon-btn user" title="마이페이지" href="/WangBam/?type=my"></a>
									<a class="icon-btn order" title="주문현황" href="/WangBam/?type=order"></a>
									<a class="icon-btn cart" title="장바구니" href="/WangBam/?type=cart"></a>
								</c:when>
								<c:when test="${sessionScope.user.us_type eq 0}">
									<a class="icon-btn logout" title="로그아웃" href="/WangBam/?type=logout"></a>
									<a class="icon-btn admin" title="관리자" href="/WangBam/admin?type=index"></a>
									<a class="icon-btn user" title="마이페이지" href="/WangBam/?type=my"></a>
								</c:when>
								<c:when test="${sessionScope.user eq null}">
									<a class="icon-btn user" title="로그인" href="/WangBam/?type=login"></a>
								</c:when>
							</c:choose>
							
							<button type="button" class="icon-btn menu" id="menuOpenBtn" title="전체메뉴"></button>
						</div>
					</nav>
				</div>
			</header>
			<div class="total-menu" id="totalMenu">
				<div class="menu-header">
					<h3>전체메뉴</h3>	
					<button type="button" class="icon-btn close" title="메뉴닫기" id="menuCloseBtn"></button>
				</div>
				<nav class="global-nav">
					<div class="global-nav-links">
						<a href="?type=notice" class="${currentPage.contains('notice') ? 'global-nav-item on' : 'global-nav-item'}">공지사항</a>
						<a href="?type=productList" class="${currentPage.contains('product') ? 'global-nav-item on' : 'global-nav-item'}">상품보기</a>
						<a href="?type=review" class="${currentPage.contains('review') ? 'global-nav-item on' : 'global-nav-item'}">리뷰보기</a>
						<a href="?type=question" class="${currentPage.contains('question') ? 'global-nav-item on' : 'global-nav-item'}">1:1문의</a>
						<a href="?type=brand" class="${currentPage.contains('brand') ? 'global-nav-item on' : 'global-nav-item'}">브랜드소개</a>
					</div>
				</nav>
			</div>
			<main class="main">
				<c:if
					test="${fn:endsWith(pageContext.request.requestURI,'main.jsp')}">
					<!-- Slider main container -->
					<div class="swiper">
						<!-- Additional required wrapper -->
						<div class="swiper-wrapper">
							<!-- Slides -->
							<div class="swiper-slide">
								<a href="/WangBam/?type=notice">
									<img src="${pageContext.request.contextPath}/img/01.png"
										alt="배너">
								</a>
							</div>
							<div class="swiper-slide">
								<a href="/WangBam/?type=notice">
									<img src="${pageContext.request.contextPath}/img/02.png"
										alt="배너">
								</a>
							</div>
							<div class="swiper-slide">
								<a href="/WangBam/?type=notice">
									<img src="${pageContext.request.contextPath}/img/03.png"
										alt="배너">
								</a>
							</div>
						</div>
						<!-- If we need navigation buttons -->
						<div class="swiper-button-prev"></div>
						<div class="swiper-button-next"></div>

						<!-- If we need scrollbar -->
						<div class="swiper-scrollbar"></div>
					</div>
				</c:if>
				<section class="content">