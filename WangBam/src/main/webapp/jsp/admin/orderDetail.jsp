<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@include file="/jsp/common/adminHeader.jsp"%>

<div class="admin">
	<h1>주문 상세조회</h1>
	<form action="" method="post" class="form-group">
		<div>
			<label type="text">주문번호</label> <input type="text"
				name="order-number" placeholder="주문번호" />
		</div>
		<div>
			<label type="text">주문일시</label> <input type="text" name="order-date"
				placeholder="주문일시" />
		</div>
		<div>
			<label type="text">받는사람</label> <input type="text" name="receiver"
				placeholder="받는사람" />
		</div>
		<div>
			<label type="text">배송상태</label> <label type="text"
				name="delivery-status"></label>


		</div>
		<div>
			<label type="text">운송장번호</label> <input type="text" name="receiver"
				placeholder="받는사람" />
		</div>
		<div>
			<label type="text">배송지</label> <input type="text" name="receiver"
				placeholder="받는사람" />
			<div class="address-group">
				<input type="text" id="postcode" placeholder="우편번호">
				<button type="button" class="admin-btn submit">검색</button>
			</div>
			<input type="text" placeholder="기본주소"> <input type="text"
				placeholder="상세주소">
		</div>

		<div class="btn_div">
			<button type="button" class="admin-btn submit" onclick="">저장</button>
			<button type="button" class="admin-btn cancel" onclick="">취소</button>
		</div>
	</form>
</div>

<%@include file="/jsp/common/footer.jsp"%>

<script>
	function del(idx) {
		if (confirm("정말 삭제하시겠습니까?")) {
			window.location = "admin?type=reviewDelete&bo_idx=" + idx;
		}
	}
</script>
</body>

</html>