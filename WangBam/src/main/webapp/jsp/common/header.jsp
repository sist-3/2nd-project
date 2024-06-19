<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="icon" href="/img/logo.ico">
  <title>왕밤빵</title>

  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
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
            </div>
          </nav>
          <nav class="local-nav">
            <div class="local-nav-links">
              <h1><a href="" class="product-name">왕밤빵</a></h1>
              <a href="../login.html">로그인</a>
              <a href="#">회원가입</a>
              <a href="#">마이페이지</a>
              <a href="#">장바구니</a>
            </div>
          </nav>
        </div>
      </header>
      <main class="main">
        <section class="view">
          <img src="${pageContext.request.contextPath}/img/03.png" alt="배너">
        </section>
        <section class="content">