<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%@include file="/jsp/common/header.jsp" %>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.3/themes/base/jquery-ui.css">
<div>
    <form action="?type=search" method="post" class="search-group" id="searchForm">
    	<h2><a href="?type=review">리뷰목록</a></h2>
	    <div id="searchBox" class="search-bar">
	    	<select name="searchType" id="searchType">
				<option value="title" ${requestScope.searchType == 'title' ? 'selected' : ''}>제목</option>
           		<option value="writer" ${requestScope.searchType == 'writer' ? 'selected' : ''}>닉네임</option>
           		<option value="category" ${requestScope.searchType == 'category' ? 'selected' : ''}>카테고리</option>
           		<option value="score" ${requestScope.searchType == 'score' ? 'selected' : ''}>평점</option>
           	 	<option value="writeDate" ${requestScope.searchType == 'writeDate' ? 'selected' : ''}>날짜</option>
			</select>
			<input type="hidden" name="bo_type" value="2"/>
			<input type="text" name="searchValue" id="searchValue" value="${requestScope.searchValue }"/>
            <input type="text" name="searchValue2" id="searchValue2" value="${requestScope.searchValue2}"/>
            <select name="searchValue3" id="searchValue3">
            	<option value="" ${requestScope.searchValue3 == "" ? 'selected' : ''}>::선택::</option>
            	<c:forEach begin="1" end="10" varStatus="vs">
       				<option value="${vs.count/2}" ${requestScope.searchValue3 == vs.count/2 ? 'selected' : ''}>${vs.count/2}점</option>
    			</c:forEach>
            </select>
            <select name="searchCategory" id="searchCategory">
            	<c:forEach var="category" items="${requestScope.ct_ar }">
					<option value="${category.ct_idx }" ${requestScope.searchCategory == category.ct_idx ? 'selected' : ''}>${category.ct_name }</option>            	
            	</c:forEach>
            </select>
            <select name="searchProduct" id="searchProduct">
            		<option value="allProduct" ${requestScope.searchProduct == "allProduct" ? 'selected' : ''}>전체</option>
            		<c:forEach var="product" items="${requestScope.pd_ar }">
							<option class="product_option" data-category="${product.ct_idx}" value="${product.pd_idx }" ${requestScope.searchProduct == product.pd_idx ? 'selected' : ''}>${product.pd_name }</option>            	
            		</c:forEach>
            </select>
			<button type="submit" class="search-btn btn search"></button>
	    </div>
    </form>
    <table class="table1">
        <thead>
            <tr>
                <th>번호</th>
                <th>상품</th>
                <th>제목</th>
                <th>작성자</th>
                <th>작성날짜</th>
                <th>평점</th>
                <th>조회수</th>
            </tr>
        </thead>

        <tbody>
            <c:if test="${fn:length(ar) > 0 }">
                <c:forEach var="vo" items="${requestScope.ar }" varStatus="vs">
                    <tr class="review">
                        <td>${page.totalRecord-((page.nowPage-1)*page.numPerPage+vs.index) }</td>
                        <td>${vo.pvo.pd_name }</td>
                        <td><a href="?type=boardsDetail&bo_idx=${vo.bo_idx }&cPage=${page.nowPage}&bo_type=2">${vo.bo_title }</a></td>
                        <c:if test="${vo.uvo.us_nickname != null }">
                        	<td>${vo.uvo.us_nickname }</td>
                        </c:if>
                        <c:if test="${vo.uvo.us_nickname == null }">
                        	<td>탈퇴한 회원</td>
                        </c:if>
                        <td>${vo.bo_write_date }</td>
                        <td>${vo.bo_score }</td>
                        <td>${vo.bo_hit }</td>
                    </tr>
                </c:forEach>
            </c:if>

            <c:if test="${fn:length(ar) < 1 }">
                <tr class="no_data">
                    <td colspan="6">
                        <b>등록된 리뷰가 없습니다.</b>
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
				<div><a href="?type=search&searchType=${requestScope.searchType }&searchValue=${requestScope.searchValue }&searchValue2=${requestScope.searchValue2 }&cPage=${page.nowPage-page.pagePerBlock }&bo_type=2">&lt;</a></div>
			</c:if>


			<c:forEach begin="${page.startPage }" end="${page.endPage }" varStatus="vs">
          		<c:if test="${vs.index eq page.nowPage }">
          			<div class="on">${vs.index }</div>
           		</c:if>
				<c:if test="${vs.index ne page.nowPage }">
					<div><a href="?type=search&searchType=${requestScope.searchType }&searchValue=${requestScope.searchValue }&searchValue2=${requestScope.searchValue2 }&cPage=${vs.index }&bo_type=2">${vs.index }</a></div>
				</c:if>
			</c:forEach>
			
			
			<c:if test="${page.endPage < page.totalPage}">
				<c:if test="${page.nowPage+page.pagePerBlock > page.totalPage }">
					<div><a href="?type=search&searchType=${requestScope.searchType }&searchValue=${requestScope.searchValue }&searchValue2=${requestScope.searchValue2 }&cPage=${page.totalPage }&bo_type=2">&gt;</a></div>
				</c:if>
				<c:if test="${page.nowPage+page.pagePerBlock <= page.totalPage }">
					<div><a href="?type=search&searchType=${requestScope.searchType }&searchValue=${requestScope.searchValue }&searchValue2=${requestScope.searchValue2 }&cPage=${page.nowPage+page.pagePerBlock}&bo_type=2">&gt;</a></div>
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
		$('#searchValue2').hide();
		$('#searchValue3').hide();
		$('#searchCategory').hide();
		$('#searchProduct').hide();
		
    	$('#searchType').change(function() {
	        var selectType = $(this).val();

	        if ($('#searchValue').hasClass('hasDatepicker')) {
	            $('#searchValue').datepicker('destroy').removeClass('hasDatepicker');
	        }
	        if ($('#searchValue2').hasClass('hasDatepicker')) {
	            $('#searchValue2').datepicker('destroy').removeClass('hasDatepicker');
	        }
	        if (selectType == 'writeDate') {
	        	$('#searchValue3').hide().val('');
	        	$('#searchCategory').hide();
	    		$('#searchProduct').hide();
	            $('#searchValue').show().datepicker({
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
	        }else if(selectType == 'score'){
	        	$('#searchValue').hide().val('');
	        	$('#searchValue2').hide().val('');
	        	$('#searchCategory').hide();
	    		$('#searchProduct').hide();
	        	$('#searchValue3').show();
	        	//$('#searchValue3').val("5.0").attr("selected", "selected")
	        }else if(selectType == 'category'){
	        	$('#searchValue').hide().val('');
	        	$('#searchValue2').hide().val('');
	        	$('#searchValue3').hide().val('');
	        	$('#searchCategory').show();
	        	$('#searchProduct').show();
	        }else {
	        	$('#searchValue').show().prop('readonly', false).attr('type', 'text');
	        	$('#searchProduct').show().prop('readonly', false).attr('type', 'text');
	            $('#searchValue2').hide().val('');
	            $('#searchValue3').hide().val('');
	            $('#searchCategory').hide();
	    		$('#searchProduct').hide();
	        }
    	}).trigger('change');
	});
	//유효성 검사
	document.getElementById('searchForm').addEventListener('submit', function(sub) {
		var type = document.getElementById('searchType').value;
     	var val = document.getElementById('searchValue').value.trim();
     	var val2 = document.getElementById('searchValue2').value.trim();
     	var val3 = document.getElementById('searchValue3').value.trim();
     	var val4 = document.getElementById('searchCategory').value.trim();
     	var val5 = document.getElementById('searchProduct').value.trim();

        if (type == 'writeDate') {
        	if (val == '' || val == null || val2 == '' || val2 == null){
           		alert('날짜를 입력하세요.');
           		sub.preventDefault();
        	}
        }else if(type == 'score'){
        	if (val3 == '' || val3 == null){
        		alert('평점을 선택하세요.');
	            sub.preventDefault();
        	}
        }else if(type == 'category'){
        	if (val4 == '' || val4 == null || val5 == '' || val5 == null){
        		alert('카테고리 및 상품을 선택하세요.');
	            sub.preventDefault();
        	}
        }else {
	        if (val == '' || val == null) {
	            alert('검색어를 입력하세요.');
	            sub.preventDefault();
	        }
        }
    });
	$('#searchCategory').change(function ProductOption() {
		var selectedCategory = document.getElementById("searchCategory").value;
        var productOptions = document.getElementsByClassName("product_option");
		$('#searchProduct').val("allProduct").attr("selected", "selected");
		
        for (var i = 0; i < productOptions.length; i++) {
            var option = productOptions[i];
            if (option.getAttribute("data-category") == selectedCategory) {
                option.style.display = "block";
            }else {
                option.style.display = "none";
            }
        }
    });
    // 초기 로드 시 선택된 카테고리에 따라 제품 필터링
    document.addEventListener("DOMContentLoaded", function() {
    	ProductOption();
	});

</script>
</body>
</html>