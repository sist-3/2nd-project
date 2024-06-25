<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@include file="/jsp/common/adminHeader.jsp"%>


<h1>주문 상세조회</h1>
<form action="" method="post" class="form-group">
	<div>
		<label for="or_idx">주문번호</label> <input type="text" name="or_idx"
			value="${vo.or_idx }" disabled  />
	</div>
	<div>
		<label for="or_date">주문일시</label> <input type="text" name="or_date"
			value="${vo.ovo.or_date }" disabled />
	</div>
	<div>
		<label for="or_date">주문완료일시</label> <input type="text" name="or_date"
			value="${vo.ovo.or_end_date }" disabled />
	</div>
	<div>
		<label for="or_name">받는사람</label> <input type="text" name="or_name"
			value="${vo.ovo.or_name }" disabled />
	</div>
	<div>
		<label for="pd_name">주문상품</label> <input type="text" name="pd_name"
			value="${vo.pvo.pd_name }" disabled />
	</div>
	<div>
		<label for="or_status_code">배송상태</label> <input type="text" name="or_status_code"
			value="${vo.ovo.or_status_code }" disabled />
	</div>
	<div>
		<label for="or_tracking_number">운송장번호</label> <input type="text" name="or_tracking_number"
			value="${vo.ovo.or_tracking_number }" disabled />
	</div>
	<div>
		<label for="or_addr">배송지</label> 
		<input type="text" name="or_addr" value="${vo.ovo.or_addr }" disabled /> 
		<input type="text" name="or_addr_detail" value="${vo.ovo.or_addr_detail }" disabled >
	</div>

	<div class="btn_div">
		<button type="button" class="admin-btn submit" onclick="">저장</button>
		<button type="button" class="admin-btn cancel" onclick="cancelOrder()">취소</button>
	</div>
</form>

<%@include file="/jsp/common/footer.jsp"%>

<script>
	function cancelOrder(idx) {
		if (confirm("주문을 취소하시겠습니까?")) {
			window.location = "admin?type=orderUpdate&or_idx=" + idx;
		}
	}
</script>
</body>

</html>