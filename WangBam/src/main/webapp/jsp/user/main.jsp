<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/header.jsp"%>
<!-- 여기에 작업 -->
<div class="quick-menu">
	<div class="quick-item">
		<a href=""> <img
			src="${pageContext.request.contextPath}/img/quick_01.png" alt="빠른메뉴1">
		</a>
	</div>
	<div class="quick-item">
		<a href=""> <img
			src="${pageContext.request.contextPath}/img/quick_02.png" alt="빠른메뉴2">
		</a>
	</div>
	<div class="quick-item">
		<a href=""> <img
			src="${pageContext.request.contextPath}/img/quick_03.png" alt="빠른메뉴3">
		</a>
	</div>
	<div class="quick-item notice">
		<div class="notice-header">
			<p>공지사항</p>
			<button title="더보기" class="btn-icon plus" type="button"></button>
		</div>
		<ul class="notice-list">
			<li class="new"><a href=""> <span>오픈을 축하합니다.</span> <span
					class="sub-date">2019-11-05</span>
			</a></li>
		</ul>
	</div>
</div>
<div class="hot-items">
	<div class="hot-left">
		<div class="hot-header">
			<p>
				<strong>WEEKLY</strong> HOT ITEMS
			</p>
			<p>
				<span>금주의 핫 아이템</span> <br> <span><a href="">MORE</a></span>
			</p>
		</div>
		<div>
			<img src="${pageContext.request.contextPath}/img/hot_02.png" alt="핫1">
		</div>
		<div>
			<img src="${pageContext.request.contextPath}/img/hot_01.png" alt="핫2">
		</div>
	</div>
	<div class="hot-right">
		<img src="${pageContext.request.contextPath}/img/hot_03.png" alt="핫3">
	</div>
</div>
<div class="product-list">
	<h2>ITEM LIST 1</h2>
	<div class="item-list">
		<div class="item">
			<img src="${pageContext.request.contextPath}/img/rollcake1.png"
				alt="General Roll Cake">
			<p>[은뜰베이커리] 일반 롤케익</p>
			<p>6,300원</p>
		</div>
		<div class="item">
			<img src="${pageContext.request.contextPath}/img/rollcake2.png"
				alt="Green Tea Roll Cake">
			<p>[은뜰베이커리] 녹차 롤케익</p>
			<p>6,500원</p>
		</div>
		<div class="item">
			<img src="${pageContext.request.contextPath}/img/rollcake3.png"
				alt="Mocha Roll Cake">
			<p>[은뜰베이커리] 모카 롤케익</p>
			<p>6,500원</p>
		</div>
		<div class="item">
			<img src="${pageContext.request.contextPath}/img/rollcake4.png"
				alt="Strawberry Roll Cake">
			<p>[은뜰베이커리] 딸기 롤케익</p>
			<p>6,500원</p>
		</div>
		<div class="item">
			<img src="${pageContext.request.contextPath}/img/rollcake5.png"
				alt="Chocolate Roll Cake">
			<p>[은뜰베이커리] 초코 롤케익</p>
			<p>9,000원</p>
		</div>
		<div class="item">
			<img src="${pageContext.request.contextPath}/img/rollcake6.png"
				alt="Cream Roll Cake">
			<p>[은뜰베이커리] 크림 롤케익</p>
			<p>7,500원</p>
		</div>
	</div>
</div>
<%@include file="/jsp/common/footer.jsp"%>