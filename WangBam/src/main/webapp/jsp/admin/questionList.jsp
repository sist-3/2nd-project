<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%@include file="/jsp/common/adminHeader.jsp"%>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.3/themes/base/jquery-ui.css">

<div class="search-group">
   	<h2><a href="admin?type=questionList">문의사항 관리</a></h2>
    <div id="searchBox" class="search-bar">
    	<form action="admin?type=search" method="post" id="searchForm">
	    	<select name="searchType" id="searchType">
				<option value="title" ${requestScope.searchType == 'title' ? 'selected' : ''}>제목</option>
           		<option value="writer" ${requestScope.searchType == 'writer' ? 'selected' : ''}>닉네임</option>
           	 	<option value="writeDate" ${requestScope.searchType == 'writeDate' ? 'selected' : ''}>날짜</option>
           	 	<option value="answer" ${requestScope.searchType == 'answer' ? 'selected' : ''}>답변여부</option>
			</select>
			<input type="hidden" name="bo_type" value="1"/>
			<input type="text" name="searchValue" id="searchValue" value="${requestScope.searchValue }"/>
            <input type="text" name="searchValue2" id="searchValue2" value="${requestScope.searchValue2}"/>
            <select name="searchValue3" id="searchValue3">
            	<option value="1" ${requestScope.searchValue3 == "1" ? 'selected' : ''}>답변대기</option>
            	<option value="0" ${requestScope.searchValue3 == "0" ? 'selected' : ''}>답변완료</option>
            </select>
			<button type="submit" class="search-btn btn search"></button>
   		</form>
    </div>
</div>

    <table class="table">
        <thead>
            <tr>
            	<th><input type="checkbox" id="allCheck" name="allCheck"/></th>
                <th>번호</th>
                <th style="width:40%">제목</th>
                <th>작성자</th>
                <th>작성날짜</th>
                <th>조회수</th>
                <th>답변상태</th>
            </tr>
        </thead>

        <tbody>
            <c:if test="${fn:length(ar) > 0 }">
                <c:forEach var="vo" items="${requestScope.ar }" varStatus="vs">
                    <tr class="question">
                    	<td><input type="checkbox" name="rowCheck" value="${vo.bo_idx }"/></td>
                        <td>${page.totalRecord-((page.nowPage-1)*page.numPerPage+vs.index) }</td>
                        <td><a href="admin?type=boardsDetail&bo_idx=${vo.bo_idx }&cPage=${page.nowPage}&bo_type=1">${vo.bo_title }</a></td>
                        <c:if test="${vo.uvo.us_nickname != null }">
                        	<td>${vo.uvo.us_nickname }</td>
                        </c:if>
                        <c:if test="${vo.uvo.us_nickname == null }">
                        	<td>탈퇴한 회원</td>
                        </c:if>
                        <td>${vo.bo_write_date }</td>
                        <td>${vo.bo_hit }</td>
                        <td>
	                        <c:choose>
	                        	<c:when test="${vo.bo_answer == 0}">
	                        		답변완료
	                        	</c:when>
	                        	<c:when test="${vo.bo_answer == 1}">
	                        		답변대기중
	                        	</c:when>
	                        </c:choose>
                        </td>
                    </tr>
                </c:forEach>
            </c:if>

            <c:if test="${fn:length(ar) < 1 }">
                <tr class="no_data">
                    <td colspan="6">
                        <b>문의사항이 없습니다.</b>
                    </td>
                </tr>
            </c:if>
        </tbody>
    </table>

    <div class="admin-pagination">
			<c:set var="page" value="${requestScope.page }"/>
			
			<c:if test="${page.startPage < page.pagePerBlock }">
            	<div class="disable">&lt;</div>
			</c:if>
			<c:if test="${page.startPage >= page.pagePerBlock }">
				<div><a href="admin?type=search&searchType=${requestScope.searchType }&searchValue=${requestScope.searchValue }&searchValue2=${requestScope.searchValue2 }&cPage=${page.nowPage-page.pagePerBlock }&bo_type=1">&lt;</a></div>
			</c:if>


			<c:forEach begin="${page.startPage }" end="${page.endPage }" varStatus="vs">
          		<c:if test="${vs.index eq page.nowPage }">
          			<div><a class="on">${vs.index }</a> </div>
           		</c:if>
				<c:if test="${vs.index ne page.nowPage }">
					<div><a href="admin?type=search&searchType=${requestScope.searchType }&searchValue=${requestScope.searchValue }&searchValue2=${requestScope.searchValue2 }&cPage=${vs.index }&bo_type=1">${vs.index }</a></div>
				</c:if>
			</c:forEach>
			
			
			<c:if test="${page.endPage < page.totalPage}">
				<c:if test="${page.nowPage+page.pagePerBlock > page.totalPage }">
					<div><a href="admin?type=search&searchType=${requestScope.searchType }&searchValue=${requestScope.searchValue }&searchValue2=${requestScope.searchValue2 }&cPage=${page.totalPage }&bo_type=1">&gt;</a></div>
				</c:if>
				<c:if test="${page.nowPage+page.pagePerBlock <= page.totalPage }">
					<div><a href="admin?type=search&searchType=${requestScope.searchType }&searchValue=${requestScope.searchValue }&searchValue2=${requestScope.searchValue2 }&cPage=${page.nowPage+page.pagePerBlock}&bo_type=1">&gt;</a></div>
				</c:if>
			</c:if>
			<c:if test="${page.endPage >= page.totalPage}">
				<div class="disable">&gt;</div>
			</c:if>
  	</div>
 	<div class="btn_div">
  		<button type="button" class="admin-btn cancel" onclick="del()">삭제</button>
  	</div>

<%@include file="/jsp/common/footer.jsp"%>
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
        }else if(selectType == 'answer'){
        	$('#searchValue').hide().val('');
        	$('#searchValue2').hide().val('');
        	$('#searchValue3').show();
        	
        }else {
        	$('#searchValue').show().prop('readonly', false).attr('type', 'text').val('');
            $('#searchValue2').hide().val('');
            $('#searchValue3').hide().val('');
        }
	}).trigger('change');
});
	 document.getElementById('searchForm').addEventListener('submit', function(sub) {
		var type = document.getElementById('searchType').value;
     	var val = document.getElementById('searchValue').value.trim();
     	var val2 = document.getElementById('searchValue2').value.trim();
     	var val3 = document.getElementById('searchValue3').value.trim();
		
     	if(type == 'answer'){
     		if (val3 == '' || val3 == null) {
	            alert('답변여부를 선택하세요.');
	            sub.preventDefault();
	        }
     	}else if (type == 'writeDate') {
        	if (val == '' || val == null || val2 == '' || val2 == null){
           		alert('날짜를 입력하세요.');
           		sub.preventDefault();
        	}
     	}else if (type != 'writeDate') {
	        if (val == '' || val == null) {
	            alert('검색어를 입력하세요.');
	            sub.preventDefault();
	        }
        }
    });
	 
	 $(function(){
         $("#allCheck").click(function(){
             let ar = $(".table>tbody").find(":checkbox");

             ar.prop("checked", this.checked);
         });
     });
     $(function(){
         $(".table>tbody").find(":checkbox").click(function(){
             
             let ch_ar = $(".table>tbody").find(":checkbox");
             let chk = true;

             for(let i=0; i<ch_ar.length; i++){
                 if(!ch_ar[i].checked){
                     chk = false;
                     break;
                 }
             };
             if(chk){
                 $("#allCheck").prop("checked",true);
             }else{
                 $("#allCheck").prop("checked",false);
             }
         });
     });
     
     function del() {
    	 if (confirm("정말 삭제하시겠습니까?")) {
 	        const checkboxes = document.querySelectorAll('input[name="rowCheck"]:checked');
 	        if (checkboxes.length === 0) {
 	            alert("삭제할 항목을 선택하세요.");
 	            return;
 	        }

 	        const form = document.createElement('form');
 	        form.method = 'POST';
 	        form.action = 'admin?type=questionDelete';

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
	};
</script>
</body>
</html>