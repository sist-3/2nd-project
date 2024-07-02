<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@include file="/jsp/common/adminHeader.jsp"%>


<div class="search-group">
	<h2>회원 리스트</h2>
	<form class="search-bar">
		<select name="searchType" id="searchType">
			<option>전체조회</option>
			<option value="name">이름</option>
			<option value="email">이메일</option>
			<option value="nickname">닉네임</option>
		</select> 
		<input type="text" name="searchValue" id="searchValue" placeholder="Search..." style="display:none"/>
		<button type="button" class="btn search" id="userSendBtn"></button>
	</form>
</div>
<table class="table" id="userList">
	<tr>
		<th>no</th>
		<th>이름</th>
		<th>이메일</th>
		<th>닉네임</th>
	</tr>
	<c:forEach var="vo" items="${requestScope.list }" varStatus="vs">
		<tr>
			<td>${vs.index + 1 + (page.pagePerBlock * (page.nowPage - 1))}</td>
			<td><a
				href="admin?type=userDetail&us_idx=${vo.us_idx }">${vo.us_name}
			</a></td>
			<td>${vo.us_email}</td>
			<td>${vo.us_nickname}</td>
		</tr>
	</c:forEach>

</table>
<div class="admin-pagination" id="userPagination">
	<c:set var="page" value="${ requestScope.page}" />
	<c:if test="${page.startPage < page.pagePerBlock }">
		<div class="disable">&lt;</div>
	</c:if>
	<c:if test="${page.startPage >= page.pagePerBlock }">
		<div>
			<a
				href="admin?type=userList&searchType=${searchType}&searchValue=${searchValue }&cPage=${page.nowPage - page.pagePerBlock }">&lt;</a>
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
					href="admin?type=userList&cPage=${vs.index}&searchType=${searchType }&searchValue=${searchValue }">${vs.index}</a>
			</div>
		</c:if>
	</c:forEach>

	<c:if test="${page.endPage < page.totalPage }">
		<div>
			<a
				href="admin?type=userList&cPage=${page.nowPage + page.pagePerBlock - 1}&earchType=${searchType }&searchValue=${searchValue }">&gt;</a>
		</div>
	</c:if>
	<c:if test="${page.endPage >= page.totalPage }">
		<div class="disable">&gt;</div>
	</c:if>

</div>


<%@include file="/jsp/common/footer.jsp"%>

<script>
	$(function(){
		$("#userSendBtn").on("click", function(){
			const searchType = $("#searchType").val();
			const searchValue = $("#searchValue").val();
			const param = {
					"searchType" : searchType,
					"searchValue" : searchValue,
			};
			$.ajax({
				url: "admin?type=userList",
				type: "GET",
				data: param
			}).done(function(res){
				$("#userList").html($(res).find("#userList").html());
				$("#userPagination").html($(res).find("#userPagination").html());
			})
		})
		
		$("#searchType").change(function(){
			if($(this).val() === "전체조회"){
				$("#searchValue").hide();
			}
			else{
				$("#searchValue").show();
			}
			$("#searchValue").val("");
		})
	})
</script>
</body>
</html>