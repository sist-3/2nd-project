<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" href="/img/logo.ico">
<title>왕밤빵</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css">
</head>

<body>
	<div class="wrap">
		<div class="container">
			<header class="header">
				<div class="header-inner">
					<nav class="global-nav">
						<div class="global-nav-links">
							<a href="/html/user/notice_list.html" class="global-nav-item">공지사항</a>
							<a href="/html/user/item_list.html" class="global-nav-item">상품보기</a>
							<a href="/html/user/order_list.html" class="global-nav-item">주문현황</a>
							<a href="/html/user/question_list.html" class="global-nav-item">1:1문의</a>
							<a href="?type=brand" class="global-nav-item">브랜드소개</a>
						</div>
					</nav>
					<nav class="local-nav">
						<div class="local-nav-links">
							<h1>
								<a href="?type=index" class="product-name">왕밤빵</a>
							</h1>
							<a href="../login.html">로그인</a> <a href="#">회원가입</a> <a href="#">마이페이지</a>
							<a href="#">장바구니</a>
						</div>
					</nav>
				</div>
			</header>
			<main class="main">
				<c:if test="${fn:endsWith(pageContext.request.requestURI,'main.jsp')}">
					<!-- Slider main container -->
					<div class="swiper">
						<!-- Additional required wrapper -->
						<div class="swiper-wrapper">
							<!-- Slides -->
							<div class="swiper-slide">
								<img src="${pageContext.request.contextPath}/img/03.png"
									alt="배너">
							</div>
							<div class="swiper-slide">
								<img src="${pageContext.request.contextPath}/img/03.png"
									alt="배너">
							</div>
							<div class="swiper-slide">
								<img src="${pageContext.request.contextPath}/img/03.png"
									alt="배너">
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