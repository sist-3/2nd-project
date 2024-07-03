<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@include file="/jsp/common/adminHeader.jsp"%>

<div class="search-group">
	<h2>상품 관리</h2>
	<form class="search-bar">
		<select name="productPerBlock" id="productPerBlock">
			<option value="6">6개씩 보기</option>
			<option value="12">12개씩 보기</option>
			<option value="18">18개씩 보기</option>
		</select> 
		<select name="ct_idx" id="ct_idx">
			<option>전체</option>
			<c:forEach var="cvo" items="${requestScope.c_list}" varStatus="st">
				<option value="${cvo.ct_idx}">${cvo.ct_name}</option>
			</c:forEach>
		</select> <input type="text" id="searchProductName" name="searchValue"
			placeholder="Search..." />
		<button type="button" class="search-btn btn search" id="searchBtn"></button>
	</form>
</div>
<table class="table" id="productList">
	<tr>
		<th><input type="checkbox" class="allCheckbox"
			onclick="allCheck()" />선택</th>
		<th>상품번호</th>
		<th>썸네일</th>
		<th>상품명</th>
		<th>가격</th>
		<th>할인가</th>
		<th>할인율</th>
		<th>재고</th>
		<th>상세 이미지</th>
		<th>상품 등록일</th>
		<th>최신 작성일</th>

	</tr>
	<!-- 상품 리스트 출력 -->
	<c:forEach var="product" items="${p_ar}">
		<tr>
			<td><input type="checkbox" class="checkbox" /></td>
			<td>${product.pd_idx}</td>
			<c:if test="${product.pd_thumbnail_img eq ''}">
				<td><img
					src="https://png.pngtree.com/png-vector/20190820/ourmid/pngtree-no-image-vector-illustration-isolated-png-image_1694547.jpg"
					width="100" /></td>
			</c:if>
			<c:if test="${product.pd_thumbnail_img ne ''}">
				<td><img
					src="${pageContext.request.contextPath}/img/${product.pd_thumbnail_img}"
					width="100" /></td>
			</c:if>
			<td><a href="admin?type=productDetail&pd_idx=${product.pd_idx}">${product.pd_name}</a></td>
			<td>${product.pd_price}</td>
			<td>${product.pd_sale_price}</td>
			<td>${product.pd_sale }</td>
			<td>${product.pd_cnt }</td>
			<c:if test="${product.pd_detail_img eq ''}">
				<td><img
					src="https://png.pngtree.com/png-vector/20190820/ourmid/pngtree-no-image-vector-illustration-isolated-png-image_1694547.jpg"
					width="100" /></td>
			</c:if>
			<c:if test="${product.pd_detail_img ne ''}">
				<td><img
					src="${pageContext.request.contextPath}/img/${product.pd_detail_img}"
					width="100" /></td>
			</c:if>
			<td>${product.pd_date}</td>
			<td>${product.pd_last_update}</td>

		</tr>
	</c:forEach>
</table>

<div class="admin-pagination" id="pagination">
    <c:set var="paging" value="${requestScope.paging}" />
    <c:choose>
        <c:when test="${paging.startPage >= paging.pagePerBlock }">
            <div>
                <a href="javascript:void(0);" onclick="changePage(${paging.nowPage - paging.pagePerBlock})">&lt;</a>
            </div>
        </c:when>
        <c:when test="${paging.startPage < paging.pagePerBlock }">
            <div class="disable">&lt;</div>
        </c:when>
    </c:choose>
    <c:forEach begin="${paging.startPage }" end="${paging.endPage}"
        varStatus="st">
        <c:choose>
            <c:when test="${paging.nowPage != st.index }">
                <div>
                    <a href="javascript:void(0);" onclick="changePage(${st.index})">${st.index}</a>
                </div>
            </c:when>
            <c:when test="${paging.nowPage == st.index }">
                
                    <a class="on" href="javascript:void(0);" onclick="changePage(${st.index})">${st.index}</a>
                
            </c:when>
        </c:choose>
    </c:forEach>
    <c:if test="${paging.endPage < paging.totalPage}">
        <c:if test="${paging.nowPage + paging.pagePerBlock > paging.totalPage }">
            <div>
                <a href="javascript:void(0);" onclick="changePage(${paging.totalPage})">&gt;</a>
            </div>
        </c:if>
        <c:if test="${paging.nowPage + paging.pagePerBlock <= paging.totalPage }">
            <div>
                <a href="javascript:void(0);" onclick="changePage(${paging.nowPage + paging.pagePerBlock})">&gt;</a>
            </div>
        </c:if>
    </c:if>
    <c:if test="${paging.endPage >= paging.totalPage }">
        <div class="disable">&gt;</div>
    </c:if>
</div>

<!-- 상품 추가 및 삭제 버튼 -->
<div class="btn_div">

	<button type="button" class="admin-btn submit"
		onclick="javascript:location.href='admin?type=productAdd'">추가</button>
	<button type="button" class="admin-btn cancel" id="deleteBtn">삭제</button>
</div>

<%@include file="/jsp/common/footer.jsp"%>
<script>
	//검색 버튼 클릭 시 상품 검색
	$(function() {
		$("#searchBtn").on('click', function() {
			loadProductList(1);
		});
	});
	function loadProductList(page) {
		const searchValue = $("#searchProductName").val();
		const productPerBlock = $("#productPerBlock").val();
		const ct_idx = $("#ct_idx").val();
		const param = {
			"type" : "productList",
			"searchValue" : searchValue,
			"productPerBlock" : productPerBlock,
			"ct_idx" : ct_idx,
			"cPage" : page
		}

		$.ajax({
			url : "?", // 올바른 서블릿 경로를 지정하세요.
			type : "GET",
			data : param,
			dataType: "html"
		}).done(function(res) {
			const newProductList = $(res).find("#productList").html();
            const newPagination = $(res).find("#pagination").html();
			$("#productList").html($(res).find("#productList").html());
			$("#pagination").html($(res).find("#pagination").html());
		});
	}

	function changePage(page) {
		loadProductList(page);
	}
	//상품 추가 메세지 출력
	let addMsg = "${addmsg}"
	document.addEventListener("DOMContentLoaded", function() {
		if (addMsg.length > 0) {
			alert(addMsg);

		}
	});

	$(document).ready(function() {
		$("#deleteBtn").on('click', function() {
			if (confirm("정말 삭제하시겠습니까?")) {

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
							alert('상품이 성공적으로 삭제되었습니다.');
							location.reload(); // 성공 후 페이지 새로고침
						},
						error : function() {
							alert('상품 삭제에 실패했습니다.');
						}
					});
				} else {
					alert('삭제할 상품을 선택하세요.');
				}
			}
		});
	});

	$(".checkbox").on('click', function() {
			let check = false;
			let checkAll = $(".checkbox").prop('checked');
			if(!checkAll){
				check = false;
			}else{
				for(let i=0;i<$(".checkbox").length;i++){
					if($(".checkbox")[i].checked == false){
						check = false;
						break;
					}else{
						check = true;
					}
				}
			}
			$(".allCheckbox").prop('checked', check);
		});

	function allCheck() {
		if ($('.allCheckbox').is(':checked')) { // 선택자와 메서드 사용 수정
			$('.checkbox').prop('checked', true); // 모든 개별 체크박스를 체크 상태로 설정
		} else {
			$('.checkbox').prop('checked', false); // 모든 개별 체크박스를 체크 해제 상태로 설정
		}
	}
</script>


