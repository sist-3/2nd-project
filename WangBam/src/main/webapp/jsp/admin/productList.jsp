<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@include file="/jsp/common/adminHeader.jsp"%>




<div class="search-group">
	<h2>상품 관리</h2>
	<div class="search-bar">

		<input type="text" placeholder="Search..." id="searchProductName" />
		<button class="search-btn" id="searchBtn">&#128269;</button>
	</div>
</div>
<table class="table" id="productList">
	<tr>
		<th>선택</th>
		<th>no</th>
		<th>썸네일</th>
		<th>상품명</th>
		<th>가격</th>
		<th>재고</th>
	</tr>
	<!-- 상품 리스트 출력 -->
	<c:forEach var="product" items="${p_ar}">
		<tr>
			<td><input type="checkbox" class="checkbox" /></td>
			<td>${product.pd_idx}</td>
			<td><img src="${product.pd_thumbnail_img }" /></td>
			<td><a href="admin?type=productDetail&pd_idx=${product.pd_idx}">${product.pd_name}</a>
			</td>
			<td>${product.pd_price}</td>
			<td>${product.pd_cnt }</td>
		</tr>
	</c:forEach>
</table>

<!-- 페이지네이션 -->
<div class="admin-pagination">
		<c:set var="page" value="${paging}" />
		<c:if test="${page.startPage < page.pagePerBlock }">
			<div class="disable">&lt;</div>
		</c:if>
		<c:if test="${page.startPage >= page.pagePerBlock }">
			<div>
				<a
					href="admin?type=productList&cPage=${page.nowPage - page.pagePerBlock }&ct_idx=${requestScope.ct_idx}">&lt;</a>
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
						href="admin?type=productList&cPage=${vs.index}&ct_idx=${requestScope.ct_idx}">${vs.index}</a>
				</div>
			</c:if>
		</c:forEach>

		<c:if test="${page.endPage < page.totalPage }">
			<div>
				<a
					href="admin?type=productList&cPage=${page.nowPage + page.pagePerBlock - 1}&ct_idx=${requestScope.ct_idx}">&gt;</a>
			</div>
		</c:if>
		<c:if test="${page.endPage >= page.totalPage }">
			<div class="disable">&gt;</div>
		</c:if>

	</div>

<!-- 상품 추가 및 삭제 버튼 -->
<div class="btn_div">

	<button type="button" class="admin-btn submit"
		onclick="javascript:location.href='jsp/admin/productAdd.jsp'">추가</button>
	<button type="button" class="admin-btn cancel" id="deleteBtn">삭제</button>
</div>

<%@include file="/jsp/common/footer.jsp"%>
<script>
	//검색 버튼 클릭 시 상품 검색
	$(function() {
		$("#searchBtn").on('click', function() {

			const searchValue = $("#searchProductName").val();

			//const productPerBlock = $("#productPerBlock").val();
			const cPage = $(".on").text();
			const param = {
				"type" : "productList",
				"searchValue" : searchValue,
			// "productPerBlock":productPerBlock,
			}

			$.ajax({
				url : "?", // 올바른 서블릿 경로를 지정하세요.
				type : "GET",
				data : param,
			}).done(function(res) {
				$("#productList").html($(res).find("#productList").html());
				$("#pagination").html($(res).find("#pagination").html());
			});
		});
	});
	//상품 추가 메세지 출력
	let addMsg = "${addmsg}"
	document.addEventListener("DOMContentLoaded", function() {
		if (addMsg.length > 0) {
			alert(addMsg);

		}
	});
	
	$(document).ready(function() {
		$("#deleteBtn").on('click', function() {
			var pd_idx_array = [];

			$(".checkbox:checked").each(function() {
				var $row = $(this).closest('tr');
				var pd_idx = $row.find('td:eq(1)').text().trim();
				pd_idx_array.push(pd_idx);
			});

			if (pd_idx_array.length > 0) {
				$.ajax({
					url : 'admin?type=productlistDelete', // 수정된 서버의 URL
					type : 'POST',
					data : {
						pd_idx_list : pd_idx_array
					},
					traditional : true,
					success : function(response) {
						console.log('삭제 성공');
						alert('상품이 성공적으로 삭제되었습니다.');
						location.reload(); // 성공 후 페이지 새로고침
					},
					error : function() {
						console.log('삭제 실패');
						alert('상품 삭제에 실패했습니다.');
					}
				});
			} else {
				alert('삭제할 상품을 선택하세요.');
			}
		});
	});
</script>


