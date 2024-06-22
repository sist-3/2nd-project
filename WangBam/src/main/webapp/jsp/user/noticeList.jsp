<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%@include file="/jsp/common/header.jsp" %>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.3/themes/base/jquery-ui.css">
<div>
    <form action="?type=search" method="post" class="search-group" id="searchForm">
    	<h2><a href="?type=notice">공지사항</a></h2>
	    <div id="searchBox" class="search-bar">
	    	<select name="searchType" id="searchType">
				<option value="title" ${requestScope.searchType == 'title' ? 'selected' : ''}>제목</option>
           		<option value="writer" ${requestScope.searchType == 'writer' ? 'selected' : ''}>닉네임</option>
           	 	<option value="writeDate" ${requestScope.searchType == 'writeDate' ? 'selected' : ''}>날짜</option>
			</select>
			<input type="hidden" name="bo_type" value="0"/>
			<input type="text" name="searchValue" id="searchValue" value="${requestScope.searchValue }"/>
            <input type="text" name="searchValue2" id="searchValue2" value="${requestScope.searchValue2}"/>
			<button type="submit" class="search-btn btn search"></button>
	    </div>
    </form>
    <table class="table1">
        <thead>
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>작성자</th>
                <th>작성날짜</th>
                <th>조회수</th>
            </tr>
        </thead>

        <tbody>
            <c:if test="${fn:length(ar) > 0 }">
                <c:forEach var="vo" items="${requestScope.ar }" varStatus="vs">
                    <tr class="notice">
                        <td>${page.totalRecord-((page.nowPage-1)*page.numPerPage+vs.index) }</td>
                        <td><a href="?type=boardsDetail&bidx=${vo.bo_idx }&cPage=${page.nowPage}">${vo.bo_title }</a></td>
                        <c:if test="${vo.uvo.us_nickname != null }">
                        	<td>${vo.uvo.us_nickname }</td>
                        </c:if>
                        <c:if test="${vo.uvo.us_nickname == null }">
                        	<td>관리자</td>
                        </c:if>
                        <td>${vo.bo_write_date }</td>
                        <td>${vo.bo_hit }</td>
                    </tr>
                </c:forEach>
            </c:if>

            <c:if test="${fn:length(ar) < 1 }">
                <tr class="no_notice">
                    <td colspan="5">
                        <b>공지사항이 없습니다.</b>
                    </td>
                </tr>
            </c:if>
        </tbody>
    </table>

    <div class="pagination">
			<c:set var="page" value="${requestScope.page }"/>
			
			<c:if test="${page.startPage < page.pagePerBlock }">
            	<div class="disable">&lt;</div>
			</c:if>
			<c:if test="${page.startPage >= page.pagePerBlock }">
				<div><a href="?type=search&searchType=${requestScope.searchType }&searchValue=${requestScope.searchValue }&searchValue2=${requestScope.searchValue2 }&cPage=${page.nowPage-page.pagePerBlock }&bo_type=0">&lt;</a></div>
			</c:if>


			<c:forEach begin="${page.startPage }" end="${page.endPage }" varStatus="vs">
          		<c:if test="${vs.index eq page.nowPage }">
          			<div class="on">${vs.index }</div>
           		</c:if>
				<c:if test="${vs.index ne page.nowPage }">
					<div><a href="?type=search&searchType=${requestScope.searchType }&searchValue=${requestScope.searchValue }&searchValue2=${requestScope.searchValue2 }&cPage=${vs.index }&bo_type=0">${vs.index }</a></div>
				</c:if>
			</c:forEach>
			
			
			<c:if test="${page.endPage < page.totalPage}">
				<c:if test="${page.nowPage+page.pagePerBlock > page.totalPage }">
					<div><a href="?type=search&searchType=${requestScope.searchType }&searchValue=${requestScope.searchValue }&searchValue2=${requestScope.searchValue2 }&cPage=${page.totalPage }&bo_type=0">&gt;</a></div>
				</c:if>
				<c:if test="${page.nowPage+page.pagePerBlock <= page.totalPage }">
					<div><a href="?type=search&searchType=${requestScope.searchType }&searchValue=${requestScope.searchValue }&searchValue2=${requestScope.searchValue2 }&cPage=${page.nowPage+page.pagePerBlock}&bo_type=0">&gt;</a></div>
				</c:if>
			</c:if>
			<c:if test="${page.endPage >= page.totalPage}">
				<div class="disable">&gt;</div>
			</c:if>
  	</div>
</div>
<%@include file="/jsp/common/footer.jsp" %>
<script src="https://code.jquery.com/ui/1.13.3/jquery-ui.js"></script>
<script>
	$(document).ready(function() {
    	$('#searchType').change(function() {
	        var selectType = $(this).val();
	        if (selectType == 'writeDate') {
	            $('#searchValue').datepicker({
	                changeYear: true,
	                changeMonth: true,
	                dateFormat: 'yy-mm-dd',
	                beforeShow: function(input, inst) {
	                    $(input).prop('readonly', true);
	                }
	              });
	            $('#searchValue2').show().datepicker({
	                changeYear: true,
	                changeMonth: true,
	                dateFormat: 'yy-mm-dd',
	                beforeShow: function(input, inst) {
	                    $(input).prop('readonly', true);
	                }
	              });
	        } else {
	        	$('#searchValue').prop('readonly', false).datepicker('destroy').val('').attr('type', 'text');
	            $('#searchValue2').hide().val('');
	        }
    	}).trigger('change');
	});
	 document.getElementById('searchForm').addEventListener('submit', function(sub) {
		var type = document.getElementById('searchType').value;
     	var val = document.getElementById('searchValue').value.trim();
     	var val2 = document.getElementById('searchValue2').value.trim();

        if (type != 'writeDate') {
	        if (val == '' || val == null) {
	            alert('검색어를 입력하세요.');
	            sub.preventDefault();
	        }
        }else if (type == 'writeDate') {
        	if (val == '' || val == null || val2 == '' || val2 == null){
           		alert('날짜를 입력하세요.');
           		sub.preventDefault();
        	}
        }
    });
</script>
</body>
</html>
