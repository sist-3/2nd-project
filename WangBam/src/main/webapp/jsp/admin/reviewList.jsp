<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@include file="/jsp/common/adminHeader.jsp"%>

<div class="search-group">
	<h2>리뷰 관리</h2>
	<div class="search-bar">

		<form method="post" name="ctIdxForm">
			<select name="ct_idx">
				<option value="all" selected>전체조회</option>
				<c:forEach var="cate" items="${requestScope.cate_ar }">
					<option value="${cate.ct_idx }"
						<c:if test="${(cate.ct_idx == param.ct_idx)}">selected</c:if>>${cate.ct_name }</option>
				</c:forEach>
			</select>
		</form>
		<button type="button" class="search-btn" onclick="send()">&#128269;</button>
	</div>
</div>
<div id="review_list">
	<table class="table">
		<thead>
			<tr>
				<th><input type="checkbox" id="selectAll"
					onclick="toggleSelectAll(this)" /> 선택</th>
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
						<td><input type="checkbox" name="bo_idx_ar"
							value="${vo.bo_idx }" /></td>
						<td>${vs.index + 1 + (page.pagePerBlock * (page.nowPage - 1))}</td>
						<td><a href="admin?type=reviewDetail&bo_idx=${vo.bo_idx}">${vo.bo_title}</a></td>
						<td><c:if test="${null eq vo.uvo.us_name}">
								<b>탈퇴한 회원</b>
							</c:if> <c:if test="${null ne vo.uvo.us_name}">
								${vo.uvo.us_name}
							</c:if></td>
						<td>${vo.bo_write_date}</td>
						<td>${vo.bo_score}</td>
						<td>${vo.bo_hit}</td>
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


	<div class="admin-pagination">
		<c:set var="page" value="${ requestScope.page}" />
		<c:if test="${page.startPage < page.pagePerBlock }">
			<div class="disable">&lt;</div>
		</c:if>
		<c:if test="${page.startPage >= page.pagePerBlock }">
			<div>
				<a
					href="admin?type=reviewList&cPage=${page.nowPage - page.pagePerBlock }&ct_idx=${requestScope.ct_idx}">&lt;</a>
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
					<a
						href="admin?type=reviewList&cPage=${vs.index}&ct_idx=${requestScope.ct_idx}">${vs.index}</a>
				</div>
			</c:if>
		</c:forEach>

		<c:if test="${page.endPage < page.totalPage }">
			<div>
				<a
					href="admin?type=reviewList&cPage=${page.nowPage + page.pagePerBlock - 1}&ct_idx=${requestScope.ct_idx}">&gt;</a>
			</div>
		</c:if>
		<c:if test="${page.endPage >= page.totalPage }">
			<div class="disable">&gt;</div>
		</c:if>

	</div>

	<div class="btn_div">
		<button type="button" class="admin-btn submit" onclick="del()">삭제</button>
	</div>
</div>


<%@include file="/jsp/common/footer.jsp"%>
<script>
	function send() {
		let ct_idx = document.getElementsByName("ct_idx")[0].value;
		$.ajax({
			url : "admin?type=reviewList",
			type : "get",
			data : "ct_idx=" + encodeURIComponent(ct_idx),
		}).done(function(res) {
			$(".content").html($(res).find(".content").html());
		});
	}
	
	function del(){
	    if (confirm("정말 삭제하시겠습니까?")) {
	        const checkboxes = document.querySelectorAll('input[name="bo_idx_ar"]:checked');
	        if (checkboxes.length === 0) {
	            alert("삭제할 항목을 선택하세요.");
	            return;
	        }

	        const form = document.createElement('form');
	        form.method = 'POST';
	        form.action = 'admin?type=reviewDelete';

	        checkboxes.forEach(checkbox => {
	            const hiddenInput = document.createElement('input');
	            hiddenInput.type = 'hidden';
	            hiddenInput.name = 'bo_idx_ar';
	            hiddenInput.value = checkbox.value;
	            form.appendChild(hiddenInput);
	        });

	        document.body.appendChild(form);
	        form.submit();
		}
	}
	
	function toggleSelectAll(selectAllCheckbox) {
        const checkboxes = document.querySelectorAll('input[name="bo_idx_ar"]');
        checkboxes.forEach(checkbox => {
            checkbox.checked = selectAllCheckbox.checked;
        });
    }
</script>
</body>
</html>
