<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@include file="/jsp/common/adminHeader.jsp"%>


<h1>회원 상세조회</h1>
<form class="form-group">
	<div>
		<label for="or_idx">유저코드</label> <input type="text" name="or_idx"
			value="${vo.us_idx}" id="or_idx" disabled  />
	</div>
	<div>
		<label for="or_date">이름</label> <input type="text" name="or_date"
			value="${vo.us_name}" disabled />
	</div>
	<div>
		<label for="or_date">이메일</label> <input type="text" name="or_date"
			value="${vo.us_email}" disabled />
	</div>
	<div>
		<label for="or_name">전화번호</label> <input type="text" name="or_name"
			value="${vo.us_tel}" disabled />
	</div>
	<div>
		<label for="pd_name">닉네임</label> <input type="text" name="pd_name"
			value="${vo.us_nickname}" disabled />
	</div>
	<div>
		<label for="or_status_code">가입날짜</label> <input type="text" name="or_status_code"
			value="${vo.us_insert_date}" disabled />
	</div>

	<div class="btn_div">
		<button type="button" class="admin-btn submit" onclick="location.href='admin?type=userDelete&us_idx=${vo.us_idx}'">삭제</button>
		<button type="button" class="admin-btn cancel" onclick="location.href='admin?type=userList'">목록</button>
	</div>
</form>

<%@include file="/jsp/common/footer.jsp"%>

</body>

</html>