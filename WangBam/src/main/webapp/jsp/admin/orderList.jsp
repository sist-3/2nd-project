<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@include file="/jsp/common/adminHeader.jsp"%>


<div class="search-group">
	<h2>주문 리스트</h2>
	<div class="search-bar">
		<select name="searchType">
			<option value="or_name">받는사람</option>
			<option value="or_date">배송일</option>
			<option value="or_status_code">주문상태</option>
		</select> <input type="text" placeholder="Search..." name="searchValue" />
		<button type="submit" class="search-btn">&#128269;</button>
	</div>
</div>
<table class="table">
	<tr>
		<th>체크박스</th>
		<th>no</th>
		<th>받는사람</th>
		<th>전화번호</th>
		<th>주문상태</th>
		<th>운송장 번호</th>
	</tr>
	<c:forEach var="vo" items="${requestScope.list }" varStatus="vs">

		<tr>
			<td><input type="checkbox" value="${vo.or_idx}" name="orChk"
				id="orChk${vo.or_idx}" /></td>
			<td>${page.totalRecord - ((page.nowPage-1)*page.numPerPage + vs.index) }</td>
			<td style="text-align: left"><a
				href="admin?type=orderDetail&or_idx=${vo.or_idx }&cPage=${page.nowPage}">
					${vo.or_name} </a></td>
			<td>${vo.or_tel}</td>
			<td>${vo.or_status_code}</td>
			<td>${vo.or_tracking_number}</td>
		</tr>
	</c:forEach>

</table>
<div class="admin-pagination">
	<c:set var="page" value="${ requestScope.page}" />
	<c:if test="${page.startPage < page.pagePerBlock }">
		<div class="disable">&lt;</div>
	</c:if>
	<c:if test="${page.startPage >= page.pagePerBlock }">
		<div>
			<a
				href="admin?type=order_list&searchType=${searchType }&searchValue=${searchValue }&cPage=${page.nowPage - page.pagePerBlock }">&lt;</a>
		</div>
	</c:if>

	<c:forEach begin="${page.startPage }" end="${page.endPage }"
		varStatus="vs">
		<c:if test="${page.nowPage eq vs.index}">
			<div>
				<a class="on">${vs.index}</a>
			</div>
		</c:if>
		<c:if test="${page.nowPage ne vs.index}">
			<div>
				<a href="admin?type=orderList&cPage=${vs.index}">${vs.index}</a>
			</div>
		</c:if>
	</c:forEach>

	<c:if test="${page.endPage < page.totalPage }">
		<div>
			<a
				href="admin?type=orderList&cPage=${page.nowPage + page.pagePerBlock - 1}">&gt;</a>
		</div>
	</c:if>
	<c:if test="${page.endPage >= page.totalPage }">
		<div class="disable">&gt;</div>
	</c:if>

</div>

<div class="btn_div">
	<button type="button" class="admin-btn submit">발송</button>
	<button type="button" class="admin-btn cancel">주문취소</button>
</div>
<%@include file="/jsp/common/footer.jsp"%>
</body>
</html>