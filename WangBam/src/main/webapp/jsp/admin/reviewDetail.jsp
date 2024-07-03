<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@include file="/jsp/common/adminHeader.jsp"%>

	<h1>리뷰 상세보기</h1>
	<form action="" method="post" class="form-group">
		<div>
	        <div style="background:#fff; padding: 12px;">
				<div><h2 style="margin-bottom: 12px;">${vo.bo_title }</h2></div>
				<div style="color: gray; border-bottom: 1px solid #ddd; padding-bottom: 12px; margin-bottom: 8px;">
		            <span><c:if test='${vo.uvo.us_nickname != null}'>${vo.uvo.us_nickname}</c:if>
						<c:if test='${vo.uvo.us_nickname == null}'>관리자</c:if></span>&nbsp;|&nbsp;
	    	        <span>상품 : ${vo.pvo.pd_name }</span>&nbsp;&nbsp;|&nbsp;
	    	        <span>평점 : ${vo.bo_score}</span>&nbsp;&nbsp;|&nbsp;
					<span>댓글 : ${vo.c_list.size() }개</span>&nbsp;&nbsp;|&nbsp;
					<span>조회 : ${vo.bo_hit }회</span>&nbsp;&nbsp;|&nbsp;
	    	        <span>${vo.bo_write_date }</span>
				</div>
	            <p>${vo.bo_content}</p>
	        </div>
   		</div>


		<div class="btn_div">
			<button type="button" class="admin-btn cancel"
				onclick="del('${vo.bo_idx}')">삭제</button>
			<button type="button" class="admin-btn submit"
				onclick="javascript:window.location.href='admin?type=reviewList'">목록</button>
		</div>
	</form>
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

