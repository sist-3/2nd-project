<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@include file="/jsp/common/header.jsp" %>

	<form class="form-group">
	<h1>공지 상세보기</h1>
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
			value="<c:if test='${vo.uvo.us_nickname != null}'>${vo.uvo.us_nickname}</c:if><c:if test='${vo.uvo.us_nickname == null}'>관리자</c:if>" disabled />
		</div>
		<div>
			<label for="content">내용</label>
			<input type="text" name="content" value="${vo.bo_content}" disabled />
		</div>
		
	
		<div>
			<label for="content">댓글 [${vo.c_list.size() }]</label>
			<div class="comment">
				<c:forEach var="cvo" items="${vo.c_list }" varStatus="vs">
						<div>
							<c:choose>
								<c:when test="${cvo.uvo.us_idx == vo.uvo.us_idx }">
									작성자: <b style="color: #ff0044">${vo.uvo.us_nickname }</b>&nbsp;&nbsp;
								</c:when>
								<c:when test="${cvo.uvo.us_nickname != null}">
									작성자: ${cvo.uvo.us_nickname } &nbsp;&nbsp;
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
		</div>
		
		<div class="btn_div">
			<button type="button" class="btn cancel"
				onclick="javascript:window.location.href='?type=notice&cPage=${requestScope.cPage }'">목록</button>
		</div>
	</form>
<%@include file="/jsp/common/footer.jsp"%>
</body>
</html>