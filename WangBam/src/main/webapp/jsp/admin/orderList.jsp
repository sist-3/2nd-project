<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@include file="/jsp/common/adminHeader.jsp"%>


<div class="search-group">
	<h2>주문 리스트</h2>
	<form class="search-bar">
		<select name="searchType" id="searchType">
			<option value="all" selected>전체조회</option>
			<option value="or_name"
				<c:if test="${(requestScope.searchType == 'or_name')}">selected</c:if>>받는사람</option>
			<option value="or_payment_code"
				<c:if test="${(requestScope.searchType == 'or_payment_code')}">selected</c:if>>주문번호</option>
			<option value="or_status_code"
				<c:if test="${(requestScope.searchType == 'or_status_code')}">selected</c:if>>주문상태</option>
			<option value="or_tracking_number"
				<c:if test="${(requestScope.searchType == 'or_tracking_number')}">selected</c:if>>운송장번호</option>
		</select> <input type="text" name="searchValue" id="searchValue"
			placeholder="Search..."
			value="<c:if test='${(requestScope.searchValue != null)}'>${param.searchValue }</c:if>" />
		<button type="button" class="search-btn btn search" id="sendBtn"></button>
	</form>
</div>
<table class="table" id="orderList">
	<tr>
		<th><label for="selectSendAll"><input type="checkbox"
				id="selectSendAll" />발송</label></th>
		<th><label for="selectCancelAll"><input type="checkbox"
				id="selectCancelAll" />주문취소</label></th>
		<th>no</th>
		<th>받는사람</th>
		<th>주문번호</th>
		<th>주문상태</th>
		<th>주문금액</th>
		<th>운송장 번호</th>
	</tr>
	<c:forEach var="vo" items="${requestScope.list }" varStatus="vs">
		<tr>
			<td><input type="checkbox" value="${vo.or_idx}" name="or_idx_ar" /></td>
			<td><input type="checkbox" value="${vo.or_idx}" name="or_idx_ar" /></td>
			<td>${vs.index + 1 + (page.pagePerBlock * (page.nowPage - 1))}</td>
			<td><a href="admin?type=orderDetail&or_idx=${vo.or_idx }">${vo.or_name}
			</a></td>
			<td>${vo.or_payment_code}</td>
			<td>${vo.or_status_code}</td>
			<td>${vo.or_total_price}</td>
			<td>${vo.or_tracking_number}</td>
		</tr>
	</c:forEach>

</table>
<div class="admin-pagination" id="pagination">
	<c:set var="page" value="${ requestScope.page}" />
	<c:if test="${page.startPage < page.pagePerBlock }">
		<div class="disable">&lt;</div>
	</c:if>
	<c:if test="${page.startPage >= page.pagePerBlock }">
		<div>
			<a
				href="admin?type=orderList&searchType=${searchType }&searchValue=${searchValue }&cPage=${page.nowPage - page.pagePerBlock }">&lt;</a>
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
					href="admin?type=orderList&cPage=${vs.index}&searchType=${searchType }&searchValue=${searchValue }">${vs.index}</a>
			</div>
		</c:if>
	</c:forEach>

	<c:if test="${page.endPage < page.totalPage }">
		<c:if test="${page.nowPage+page.pagePerBlock > page.totalPage }">
			<div>
				<a
					href="admin?type=orderList&cPage=${page.totalPage}&searchType=${searchType }&searchValue=${searchValue }">&gt;</a>
			</div>
		</c:if>
		<c:if test="${page.nowPage+page.pagePerBlock <= page.totalPage }">
			<div>
				<a
					href="admin?type=orderList&cPage=${page.nowPage + page.pagePerBlock}&searchType=${searchType }&searchValue=${searchValue }">&gt;</a>
			</div>
		</c:if>
	</c:if>


	<c:if test="${page.endPage >= page.totalPage }">
		<div class="disable">&gt;</div>
	</c:if>

</div>

<div class="btn_div">
	<button type="button" class="admin-btn submit" onclick="or_ok()">발송</button>
	<button type="button" class="admin-btn cancel" onclick="or_cancel()">주문취소</button>
</div>


<%@include file="/jsp/common/footer.jsp"%>
<script src="${pageContext.request.contextPath}/js/Payment.js"></script>
<script>

$(function(){
	selectCancelAll();
	selectSendAll();
	
	$("#searchType").on('change', function(){
		$("#searchValue").val("");
	})
	
	$("#sendBtn").on('click', function(){
		const searchType = $("#searchType").val();
		const searchValue = $("#searchValue").val();
		$.ajax({
			url : "admin?type=orderList",
			type : "GET",
			data : {
				"searchType" : searchType,
				"searchValue" : searchValue,
			},
		}).done(function(res) {
			$("#orderList").html($(res).find("#orderList").html());
			$("#pagination").html($(res).find("#pagination").html());
			selectCancelAll();
			selectSendAll();
		});
	});
});

function selectSendAll() {
	$('#selectSendAll').on('change', function(){
        const isChecked = this.checked;
        $('input[name="or_idx_ar"]').each(function() {
            const row = $(this).closest('tr');
            const orderStatus = row.find('td:eq(5)').text().trim();
            const column = row.children().eq(0).find("input");
            if (orderStatus === 'UNKNOWN' && isChecked) {
                $(column).prop('checked', true);
            } else {
                $(column).prop('checked', false);
            }
        });
    });
}

function selectCancelAll() {
	$('#selectCancelAll').on('change', function(){
        const isChecked = this.checked;
        $('input[name="or_idx_ar"]').each(function() {
            const row = $(this).closest('tr');
            const orderStatus = row.find('td:eq(5)').text().trim();
            const column = row.children().eq(1).find("input");
            if (orderStatus.includes('UNKNOWN') && isChecked) {
                $(column).prop('checked', true);
            } else {
                $(column).prop('checked', false);
            }
        });
    });
}

function or_ok() {
	let cPage = ${page.nowPage};
    if (confirm("정말 발송하시겠습니까?")) {
        const checkboxes = document.querySelectorAll('input[name="or_idx_ar"]:checked');
        if (checkboxes.length === 0) {
            alert("발송할 항목을 선택하세요.");
            return;
        }

        const form = document.createElement('form');
        form.method = 'POST';
        form.action = 'admin?type=orderUpdate&or_status_code=DELIVERED&cPage='+cPage;

        let canProceed = true;
        checkboxes.forEach(checkbox => {
            const row = checkbox.closest('tr');
            const cells = row.querySelectorAll('td');
            const orderStatus = cells[5].textContent.trim();
            
            if (orderStatus !== 'UNKNOWN') {
                alert("발송가능한 상태가 아닙니다.");
                canProceed = false;
                return;
            }

            const hiddenInput = document.createElement('input');
            hiddenInput.type = 'hidden';
            hiddenInput.name = 'or_idx_ar';
            hiddenInput.value = checkbox.value;
            form.appendChild(hiddenInput);
        });

        if (canProceed) {
            document.body.appendChild(form);
            form.submit();
        }
    }
}

function or_cancel(){
	let chk = false;
	let cPage = ${page.nowPage};
	if (confirm("정말 취소하시겠습니까?")) {
        const checkboxes = document.querySelectorAll('input[name="or_idx_ar"]:checked');
        if (checkboxes.length === 0) {
            alert("취소할 항목을 선택하세요.");
            return;
        }

        const form = document.createElement('form');
        form.method = 'POST';
        form.action = 'admin?type=orderUpdate&or_status_code=CANCEL&cPage='+cPage;
        
        let canProceed = true;
         const hiddenInput = document.createElement('input');
        checkboxes.forEach(checkbox => {
            const row = checkbox.closest('tr');
            const cells = row.querySelectorAll('td');
            const orderStatus = cells[5].textContent.trim();
            hiddenInput.type = 'hidden';
            hiddenInput.name = 'or_idx_ar';
            hiddenInput.value = checkbox.value;
            form.appendChild(hiddenInput);
            
            if (orderStatus !== 'UNKNOWN_WAIT') {
                alert("취소가능한 상태가 아닙니다.");
                canProceed = false;
                return;
            }
            
            if(check(hiddenInput.value) == 'CANCELLED' ){
            	chk = true;
            }else{
            	chk = false;
            }
        });
        
       	if(chk && canProceed){
              document.body.appendChild(form);
              form.submit();
       	}
	}
}

function check(value){
	let result = getPaymentByOrIdx(value);
	return result.status;
}

</script>
</body>
</html>