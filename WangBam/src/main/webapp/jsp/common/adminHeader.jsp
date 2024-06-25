<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" href="${pageContext.request.contextPath}/img/logo.ico">
<title>왕밤빵</title>
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.13.3/themes/base/jquery-ui.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/admin.css">
</head>

<body>
	<c:set var="currentPage" value="${param.type}" />
	<div class="wrap">
		<div class="container">
			<header class="admin-header">
				<nav class="global-nav">
					<div class="global-nav-links">
						<a href="admin?type=index"
							class="${currentPage.contains('index') ? 'global-nav-item on' : 'global-nav-item'}">한눈에
							보기</a> <a href="admin?type=reviewList"
							class="${currentPage.contains('review') ? 'global-nav-item on' : 'global-nav-item'}">리뷰
							답글</a> <a href="admin?type=questionList"
							class="${currentPage.contains('question') ? 'global-nav-item on' : 'global-nav-item'}">문의사항
							답글</a> <a href="admin?type=productList"
							class="${currentPage.contains('product') ? 'global-nav-item on' : 'global-nav-item'}">상품관리</a>
						<a href="admin?type=orderList"
							class="${currentPage.contains('order') ? 'global-nav-item on' : 'global-nav-item'}">주문관리</a>
						<a href="admin?type=memberList"
							class="${currentPage.contains('member') ? 'global-nav-item on' : 'global-nav-item'}">회원관리</a>
					</div>
				</nav>
			</header>
			<main class="admin-main">
				<section class="content">