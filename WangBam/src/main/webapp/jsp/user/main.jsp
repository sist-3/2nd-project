<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="/jsp/common/header.jsp"%>
<!-- 여기에 작업 -->
<div class="quick-menu">
	<div class="quick-item">
		<a href="?type=productDetail&pd_idx=10"> <img
			src="${pageContext.request.contextPath}/img/quick_01.png" alt="소보루">
		</a>
	</div>
	<div class="quick-item">
		<a href="?type=productDetail&pd_idx=1"> <img
			src="${pageContext.request.contextPath}/img/quick_02.png" alt="왕밤빵">
		</a>
	</div>
	<div class="quick-item">
		<a href="?type=productDetail&pd_idx=<fmt:formatNumber value='${Math.ceil(Math.random() * requestScope.cnt + 1) - 1}'/>"> <img
			src="${pageContext.request.contextPath}/img/quick_03.png" alt="빠른메뉴3">
		</a>
	</div>
	<div class="quick-item notice">
		<div class="notice-header">
			<p>공지사항</p>
			<button title="더보기" class="btn-icon plus" type="button"></button>
		</div>
		<%-- 공지사항 오늘날짜로 부터 30일 기준으로만 new클래스 적용 --%>
		<ul class="notice-list">
			<%--현재 날짜 준비--%>
			<c:set var="now" value="<%=new java.util.Date()%>" />
			<fmt:formatDate var="nowD" value="${now}" pattern="yyyy-MM-dd hh:mm:ss" />
			<%--현재 날짜를 기준이 되는 날짜와 같은 포멧으로 변경--%>
			<fmt:parseDate value="${nowD }" var="nowPlanDate" pattern="yyyy-MM-dd"/>
			<%--현재 날짜를 일수로 변경--%>
			<fmt:parseNumber value="${nowPlanDate.time / (1000*60*60*24)}" integerOnly="true" var="nowDate"></fmt:parseNumber>
			<c:choose>
				<c:when test="${fn:length(requestScope.b_ar) > 0}">
					<c:forEach var="notice" items="${requestScope.b_ar}" varStatus="idx">
					<%--기준이 되는 날짜 준비--%>
						<fmt:parseDate value="${notice.bo_write_date }" var="bWriteDate" pattern="yyyy-MM-dd"/>
						<%--기준이 되는 날짜를 일수로 변경--%>
						<fmt:parseNumber value="${bWriteDate.time / (1000*60*60*24)}" integerOnly="true" var="writeDate"></fmt:parseNumber>
						<c:choose>
							<c:when test="${nowDate < writeDate + 30}">
								<li class="new">
									<a href="?type=noticeDetail&bo_type=0&bo_idx=${notice.bo_idx }">
										<span><c:out value="${notice.bo_title}" /></span> 
										<span class="sub-date"><c:out value="${notice.bo_write_date}" /></span>
									</a>
								</li>
							</c:when>
							<c:when test="${nowDate > writeDate + 30}">
								<li>
									<a href="?type=noticeDetail&bo_type=0&bo_idx=${notice.bo_idx }">
										<span><c:out value="${notice.bo_title}" /></span> 
										<span class="sub-date"><c:out value="${notice.bo_write_date}" /></span>
									</a>
								</li>
							</c:when>
						</c:choose>
					</c:forEach>
				</c:when>
				<c:when test="${fn:length(requestScope.b_ar) < 1}">
					<li>
						<span>공지사항이 없습니다.</span> 
					</li>
				</c:when>
			</c:choose>
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
				<span>금주의 핫 아이템</span> <br> <span><a href="?type=productList">MORE</a></span>
			</p>
		</div>
		<div>
			<a href="?type=productList">
				<img src="${pageContext.request.contextPath}/img/hot_02.png" alt="핫1">
			</a>
		</div>
		<div>
			<a href="?type=productList">
				<img src="${pageContext.request.contextPath}/img/hot_01.png" alt="핫2">
			</a>
		</div>
	</div>
	<div class="hot-right">
		<a href="?type=productList&searchValue=롤케익">
			<img src="${pageContext.request.contextPath}/img/hot_03.png" alt="핫3">
		</a>
	</div>
</div>
<div class="product-list" id="productList">
	<h2>추천 상품</h2>
	<div class="item-list">
		<c:forEach var="product" items="${requestScope.p_ar}" varStatus="i">
			<div class="item">
				<div class="img-box">
				<a href="?type=productDetail&pd_idx=${product.pd_idx}">
					<img src="${pageContext.request.contextPath}/img/${product.pd_thumbnail_img}"
						alt="${product.pd_name }">
				</a>
				</div>
				<p>[왕밤빵 베이커리]${product.pd_name}</p>
			</div>
		</c:forEach>
	</div>
</div>
<%@include file="/jsp/common/footer.jsp"%>
<script>
// 메인 슬라이더
const swiper = new Swiper('.swiper', {
  // Navigation arrows
  autoplay: true,
  navigation: {
    nextEl: '.swiper-button-next',
    prevEl: '.swiper-button-prev',
  },

  // And if we need scrollbar
  scrollbar: {
    el: '.swiper-scrollbar',
  },
});
</script>
</body>
</html>