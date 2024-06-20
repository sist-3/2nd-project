<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%@include file="/jsp/common/header.jsp" %>
<div>
    <form action="?type=search" method="post" class="search-group">
    	<h2>공지사항</h2>
	    <div id="searchBox" class="search-bar">
	    	<select name="searchType" id="searchType">
				<option value="title" ${requestScope.searchType == 'title' ? 'selected' : ''}>제목</option>
           		<option value="writer" ${requestScope.searchType == 'writer' ? 'selected' : ''}>닉네임</option>
           	 	<option value="writeDate" ${requestScope.searchType == 'writeDate' ? 'selected' : ''}>날짜</option>
			</select>
			<input type="hidden" name="bo_type" value="0"/>
			<input type="text" name="searchValue" id="searchValue" value="${requestScope.searchValue }"/>
			
            	<input type="hidden" name="searchValue2" id="searchValue2" value="${requestScope.searchValue2}"/>
        	
			<button type="submit" class="search-btn">검색</button>
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
                        <td><a href="">${vo.bo_title }</a></td>
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
                        ${fn:length(ar)}
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
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<!-- <script>
	document.getElementById('searchType').addEventListener('change', function() {
	    var type = this.value;
	    var searchBox = document.getElementById('searchBox');
	    var removeInput = document.getElementById('searchValue2');
	    var submitButton = searchBox.querySelector('button[type="submit"]');
	    
	    if (removeInput) {
	    	searchBox.removeChild(removeInput);
	    }
	    if (type == 'writeDate') {
	        var newInput = document.createElement('input');
	        newInput.type = 'text';
	        newInput.id = 'searchValue2';
	        newInput.name = 'searchValue2';
	        
	        searchBox.insertBefore(newInput, submitButton);
	    }
   });
</script> -->
<script>
	document.addEventListener('DOMContentLoaded', function() {
	    var type = document.getElementById('searchType');
	    var value2 = document.getElementById('searchValue2');
	
	    // 페이지 로드 시, hidden input의 타입을 변경
	    if (type.value === 'writeDate') {
	    	value2.type = 'text';
	    }
	
	    type.addEventListener('change', function() {
	        var selectType = this.value;
	        if (selectType == 'writeDate') {
	        	value2.type = 'text';
	        } else {
	        	value2.type = 'hidden';
	        }
	    });
	});
</script>

<%@include file="/jsp/common/footer.jsp" %>