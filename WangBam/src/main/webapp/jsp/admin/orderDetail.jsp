<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@include file="/jsp/common/adminHeader.jsp"%>


<h1>주문 상세조회</h1>
<form action="" method="post" class="form-group" id="orderForm">
	<div>
		<label for="or_idx">주문번호</label> <input type="text" name="or_idx"
			value="${vo.or_idx }" id="or_idx" disabled  />
	</div>
	<div>
		<label for="or_date">주문일시</label> <input type="text" name="or_date"
			value="${vo.or_date }" disabled />
	</div>
	<div>
		<label for="or_date">주문완료일시</label> <input type="text" name="or_date"
			value="${vo.or_end_date }" disabled />
	</div>
	<div>
		<label for="or_name">받는사람</label> <input type="text" name="or_name"
			value="${vo.or_name }" disabled />
	</div>
	<div>
		<label for="pd_name">주문상품</label> 
		
			<c:forEach var="list" items="${requestScope.list }">
				<input type="text" name="pd_name" value="${list.getPvo().getPd_name()}: ${list.getOd_cnt()}개" disabled/>
			</c:forEach>
	</div>
	<div>
		<label for="or_status_code">배송상태</label> <input type="text" name="or_status_code" id="or_status_code"
			value="${vo.or_status_code }" disabled />


	</div>
	<div>
		<label for="or_tracking_number">운송장번호</label> <input type="text" name="or_tracking_number"
			value="${vo.or_tracking_number }" disabled />
	</div>
	<div>
		<label for="or_addr">배송지</label> 
		<input type="text" name="or_addr" value="${vo.or_addr }" disabled /> 
		<input type="text" name="or_addr_detail" value="${vo.or_addr_detail }" disabled >
	</div>

	<div class="btn_div">
		<button type="button" class="admin-btn submit" onclick="okOrder()">발송</button>
		<button type="button" class="admin-btn cancel" onclick="cancelOrder()">주문취소</button>
		<button type="button" class="admin-btn edit" onclick="location.href='admin?type=orderList'">뒤로</button>
	</div>
</form>

<%@include file="/jsp/common/footer.jsp"%>
<script>
	
	function okOrder() {
		if (confirm("정말 발송하시겠습니까?")) {
            const form = document.getElementById('orderForm');
            const idx = document.getElementById("or_idx").value;
			const status = document.getElementById("or_status_code").value;
			
	        form.method = 'POST';
	        form.action = 'admin?type=orderUpdate&or_status_code=DELIVERED&or_idx='+idx;
	        
	        if(status != 'UNKNOWN'){
	        	if(status == 'DELIVERED'){
		        	alert("이미 발송되었습니다.");
		        	return;
		        }
	        	
	        	if(status == 'CANCEL'){
		        	alert("취소된 주문입니다.");
		        	return;
		        }
	        	
	        	alert("발송가능한 상태가 아닙니다.");
	        	return;
	        	
	        }
	        
	        form.submit();
		}
	}

	function cancelOrder() {
		let chk = false;
		if (confirm("정말 취소하시겠습니까?")) {
            const form = document.getElementById('orderForm');
            const idx = document.getElementById("or_idx").value;

	        form.method = 'POST';
	        form.action = 'admin?type=orderUpdate&or_status_code=CANCEL&or_idx='+idx;
	       
	        if(check(idx) == 'CANCELLED' ){
            	chk = true;
            }else{
            	chk = false;
            }
	        
	    	if(chk){
	 	       form.submit();
	        }else{
	        	alert("주문 취소가 가능한 상태가 아닙니다.");
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