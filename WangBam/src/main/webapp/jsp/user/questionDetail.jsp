<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@include file="/jsp/common/header.jsp" %>

	<div class="form-group">
		<h1>문의 상세보기</h1>
		
		<div>
			<label for="title">제목</label>
			<input type="text" name="title"	value="${vo.bo_title }" disabled />
		</div>
		<div>
			<label for="writeDate">작성일</label>
			<input type="text" name="writeDate"	value="${vo.bo_write_date }" disabled />
		</div>
		<div>
			<label for="writer">작성자</label>
			<input type="text" name="writer" 
			value="<c:if test='${vo.uvo.us_nickname != null}'>${vo.uvo.us_nickname}</c:if><c:if test='${vo.uvo.us_nickname == null}'>탈퇴한회원</c:if>" disabled />
		</div>
		<div>
			<label for="content">내용</label>
			<input type="text" name="content" value="${vo.bo_content}" disabled />
		</div>
		
	
		<label for="content">댓글 [${vo.c_list.size() }]</label>
		<div class="comment">
			<c:forEach var="cvo" items="${vo.c_list }" varStatus="vs">
					<div>
						<c:choose>
							<c:when test="${cvo.uvo.us_idx == vo.uvo.us_idx && cvo.uvo.us_type != 0 }">
								작성자: <b style="color: #ff0044">${vo.uvo.us_nickname }</b>&nbsp;&nbsp;
							</c:when>
							<c:when test="${cvo.uvo.us_nickname != null}">
								<c:if test="${cvo.uvo.us_type == 0 }">
									작성자: <b style="color: #4400ff">${cvo.uvo.us_nickname }</b> &nbsp;&nbsp;
								</c:if>
								<c:if test="${cvo.uvo.us_type != 0 }">
									작성자: ${cvo.uvo.us_nickname } &nbsp;&nbsp;
								</c:if>
							</c:when>
							<c:when test="${cvo.uvo.us_nickname == null}">
								작성자: 탈퇴한 회원 &nbsp;&nbsp;
							</c:when>
						</c:choose>
						작성일: ${cvo.co_write_date }<br/>
						내용: ${cvo.co_content }
						<c:if test="${!vs.last}">
							<hr/>
						</c:if>
					</div>
			</c:forEach>
		</div>
	

		<label for="content">댓글작성</label>
		<form name="writeCommentForm" action="Controller" method="post" onsubmit="return writeComment()">
			작성자: ${vo.uvo.us_nickname }<br/>
			내용:<textarea rows="4" cols="30" name="co_content" id="co_content"></textarea><br/>
			<input type="hidden" name="us_idx" value="1"/><!-- (!)로그인한 유저의 us_idx로 변경 요망-->
			<input type="hidden" name="bo_idx" value="${vo.bo_idx}"/>
			<input type="hidden" name="type" value="writeComment"/>
			<input type="hidden" name="cPage" value="${requestScope.cPage}"/>
			<input type="submit" value="댓글등록"/> 
		</form>
		
		<form name="boardDataForm" action="admin" method="post">
			<input type="hidden" name="type" value="noticeEdit"/>
			<input type="hidden" name="bo_idx" value="${vo.bo_idx}"/>
			<input type="hidden" name="cPage" value="${requestScope.cPage}"/>
		</form>
		
		<button type="button" class="btn cancel"
				onclick="javascript:window.location.href='Controller?type=question&cPage=${requestScope.cPage }'">목록</button>
		
	</div>
<script>
	//댓글 유효성 검사
	function writeComment() {
		var val = document.getElementById('co_content');
		if(val.value.trim() !== "") {
			return true;  // 폼 제출
		} else {
			alert('댓글을 입력하세요.');
			val.focus();
			val.value = "";
			return false;  // 폼 제출 방지
		}
	}
</script>
<%@include file="/jsp/common/footer.jsp"%>
</body>
</html>