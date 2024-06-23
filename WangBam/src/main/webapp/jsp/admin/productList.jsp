<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="/jsp/common/adminHeader.jsp"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>상품 관리</title>
<link rel="stylesheet" href="./css/admin.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>

<body>
	
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
					<td><input type="checkbox" /></td>
					<td>${product.pd_idx}</td>
					<td><img src="${product.pd_thumbnail_img }" /></td>
					<td><a
						href="admin?type=productDetail&pd_idx=${product.pd_idx}">${product.pd_name}</a></td>
					<td>${product.pd_price}</td>
					<td>${product.pd_cnt }</td>
				</tr>
			</c:forEach>
		</table>
	
	<script>
    //검색 버튼 클릭 시 상품 검색
    $(function() {
	      $("#searchBtn").on('click', function() {
        		 
	          const searchValue = $("#searchProductName").val();
	         
	          //const productPerBlock = $("#productPerBlock").val();
	          const cPage = $(".on").text();
	          const param = {
        		  "type":"productList",
        		  "searchValue": searchValue,
        		 // "productPerBlock":productPerBlock,
	          }
	          
	          $.ajax({
	              url: "?",  // 올바른 서블릿 경로를 지정하세요.
	              type: "GET",
	              data: param,
	          }).done(function(res){
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
	</script>
</body>
<!-- 페이지네이션 -->
<div class="admin-pagination" id="pagination">
	
	<c:choose>
		<c:when test="${paging.nowPage > 1 }">
			<div>
				<a href="?type=productList&cPage=${paging.nowPage-1}">&lt;</a>
			</div>
		</c:when>
		<c:when test="${paging.nowPage <= 1 }">
			<div class="disable">&lt;</div>
		</c:when>
	</c:choose>
	<c:forEach begin="${paging.startPage }" end="${paging.endPage}"
		varStatus="st">
		<c:choose>
			<c:when test="${paging.nowPage != st.index }">
				<div>
					<a href="?type=productList&cPage=${st.index}">${st.index}</a>
				</div>
			</c:when>
			<c:when test="${paging.nowPage == st.index }">
				<div class="on">
					<a href="?type=productList&cPage=${st.index}">${st.index}</a>
				</div>
			</c:when>
		</c:choose>
	</c:forEach>
	<c:choose>
		<c:when test="${paging.nowPage < paging.endPage }">
			<div>
				<a href="?type=productList&cPage=${paging.nowPage+1}">&gt;</a>
			</div>
		</c:when>
		<c:when test="${paging.nowPage >= paging.endPage }">
			<div class="disable">&gt;</div>
		</c:when>
	</c:choose>
</div>
<!-- 상품 추가 및 삭제 버튼 -->
<div class="btn_div">

	<button type="button" class="admin-btn submit"
		onclick="javascript:location.href='jsp/admin/itemAdd.jsp'">추가</button>
	<button type="button" class="admin-btn cancel">삭제</button>
</div>

</html>