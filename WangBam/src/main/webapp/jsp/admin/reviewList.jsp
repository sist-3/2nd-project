<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@include file="/jsp/common/adminHeader.jsp"%>


<h2>리뷰 관리</h2>
<div class="search-bar">
	<select name="ct_idx">
		<c:forEach var="cate" items="${requestScope.cate_ar }">
			<option value="${cate.ct_idx }">${cate.ct_name }</option>
		</c:forEach>
	</select>
	<button type="submit" class="search-btn">&#128269;</button>
</div>
<div id="review_list">
	<table class="table1">
		<thead>
			<tr>
				<th>선택</th>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성날짜</th>
				<th>평점</th>
				<th>조회수</th>
			</tr>
		</thead>

		<tbody>
			<c:if test="${fn:length('ar') > 0}">
				<c:forEach var="vo" items="${requestScope.ar }" varStatus="vs">
					<tr class="review">
						<td><input type="checkbox" /></td>
						<td>vs.index + 1</td>
						<td>vo.bo_title</td>
						<td>vo.bo_us_idx</td>
						<td>vo.bo_write_date</td>
						<td>vo.bo_score</td>
						<td>vo.bo_hit</td>
					</tr>
				</c:forEach>
			</c:if>

			<c:if test="${fn:length('ar') < 1}">
				<tr class="no_review">
					<td colspan="7"><b>리뷰가 없습니다.</b></td>
				</tr>
			</c:if>
		</tbody>
	</table>
	<div class="pagination">
		<a href="#">&lt;</a> <a href="#">1</a> <a href="#">2</a> <a href="#">3</a>
		<a href="#">4</a> <a href="#">5</a> <a href="#">6</a> <a href="#">7</a>
		<a href="#">8</a> <a href="#">9</a> <a href="#">10</a> <a href="#">&gt;</a>
	</div>
	<div class="btn_div">
		<button type="button" class="btn submit">삭제</button>
	</div>
</div>

<%@include file="/jsp/common/footer.jsp"%>
