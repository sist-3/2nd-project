<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@include file="/jsp/common/header.jsp" %>
	<div class="form-group">
		<h1>리뷰 상세보기</h1>
		
		<div>
	        <div>
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
		
			<div class="comment-list-section" id="commentList">
		        <h3>댓글 목록 [${vo.c_list.size() }]</h3>
		        <div class="comments-list">
					<c:forEach var="cvo" items="${vo.c_list }" varStatus="vs">
					<div id="comment_${cvo.co_idx }" class="comment">
						<div class="split-box">
							<c:choose>
								<c:when test="${cvo.uvo.us_idx == vo.uvo.us_idx && cvo.uvo.us_type == 1}">
									<p style="color: #ff0044"><strong>[작성자]</strong><b>${cvo.uvo.us_nickname }</b></p>
								</c:when>
								<c:when test="${cvo.uvo.us_type == 0 }">
									<p style="color: #4400ff"><strong>[관리자]</strong><b>${cvo.uvo.us_nickname }</b></p>
								</c:when>
								<c:when test="${cvo.uvo.us_nickname != null}">
									<p>${cvo.uvo.us_nickname }</p>
								</c:when>
								<c:when test="${cvo.uvo.us_nickname == null}">
									<p>탈퇴한 회원</p>
								</c:when>
							</c:choose>
							<p>${cvo.co_write_date }</p>
						</div>
						
						<div class="edit_comment">
							<div class="split-box">
								<input id="contentInput_${cvo.co_idx }" type="text" value="${cvo.co_content }" disabled/>
								<c:if test="${cvo.uvo.us_idx == sessionScope.user.us_idx and cvo.uvo.us_idx != null }">
							    	<button class="btn cancel" type="button" onclick="editComment('${cvo.co_idx}')">수정 및 삭제</button>
								</c:if>
								<c:if test="${sessionScope.user.us_type == 0 and cvo.uvo.us_idx != sessionScope.user.us_idx}">
									<button class="btn cancel" type="button" onclick="deleteComment('${cvo.co_idx}')">삭제</button>
								</c:if>
							</div>
							<div class="commentEdit_btn" id="btn_${cvo.co_idx }" style=display:none >
								<button type="button" onclick="cancelEdit('${cvo.co_idx }')">취소</button>
								<button type="button" onclick="saveEditComment('${cvo.co_idx}')">저장</button>
								<button type="button" onclick="deleteComment('${cvo.co_idx}')">삭제</button>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	
		<c:if test="${sessionScope.user != null}">
			<div class="comment-form-section">
		        <h3>댓글 쓰기</h3><h4 style="margin-bottom: 5px;">작성자: ${sessionScope.user.us_nickname }</h4>
		        <form class="comment-form" name="writeCommentForm" action="Controller" method="post" onsubmit="return writeComment()" style="display: flex; align-items: flex-start;">
	                <textarea rows="4" cols="30" name="co_content" id="co_content" style="resize: none; margin-right: 10px"></textarea>
		            <input type="hidden" name="us_idx" value="${sessionScope.user.us_idx }"/>
					<input type="hidden" name="bo_idx" value="${vo.bo_idx}"/>
					<input type="hidden" name="bo_type" value="2"/>
					<input type="hidden" name="cPage" value="${requestScope.cPage}"/>
					<input type="hidden" name="type" value="writeComment"/>
		            <button type="submit" style="height: 80px; width: 70px">댓글등록</button> 
		        </form>
		    </div>
		</c:if>
		
		<c:if test="${sessionScope.user == null}">
			<div class="comment-form-section">
			<h3>댓글 쓰기</h3>
				<form name="loginFrm" action="Controller" method="get"  class="comment-form"  style="display: flex; align-items: flex-start;">
					<textarea name="co_content" id="co_content" disabled style="resize: none; margin-right: 10px">로그인이 필요합니다.</textarea>
					<input type="hidden" name="type" value="login"/>
					<input type="hidden" name="url" value="?type=reviewDetail&bo_idx=${vo.bo_idx}&bo_type=${vo.bo_type}&cPage=${requestScope.cPage}"/>
					<button type="submit" style="height: 50px; width: 70px; padding: 0">로그인</button>
				</form>
			</div>
		</c:if>
		
		<div class="buttons">
			<c:if test="${sessionScope.user.us_idx == vo.uvo.us_idx}">
				<button type="button" class="btn submit"
						onclick="javascript:window.location.href='?type=reviewEdit&bo_idx=${vo.bo_idx }&cPage=${requestScope.cPage }'">수정</button>
				<button type="button" class="btn cancel"
						onclick="javascript:window.location.href='?type=reviewDelete&bo_idx=${vo.bo_idx }&cPage=${requestScope.cPage }'">삭제</button>
			</c:if>
			
			<button type="button" class="btn cancel"
					onclick="javascript:window.location.href='Controller?type=review&cPage=${requestScope.cPage }'">목록</button>
		</div>
		
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

	// 수정 버튼 클릭 시 처리 함수
    function editComment(co_idx) {
        // 모든 댓글의 수정 상태를 초기화
        document.querySelectorAll(".commentEdit_btn").forEach(btn => {
        	btn.style.display = "none";
        });
        document.querySelectorAll(".edit_comment > input").forEach(input => {
        	input.disabled = true;
        });
        
        /* document.querySelectorAll(".comment").forEach(comment => {
            const edit_btn = document.querySelector(".commentEdit_btn");
            const content_input = document.querySelector("input");
            if (edit_btn) {
                edit_btn.style.display = "none";
            }
            if (content_input) {
                content_input.disabled = true;
            }
        }); */
        
        // 해당 댓글에만 버튼을 보이게 하고 입력 필드를 활성화
        const commentElement = document.getElementById("comment_"+co_idx);
        if (commentElement) {
            const edit_btn = document.getElementById("btn_"+co_idx);
            const content_input = document.getElementById("contentInput_"+co_idx);
            if (edit_btn) {
                edit_btn.style.display = "block";
            }
            if (content_input) {
                content_input.disabled = false;
            }
        } 
    }

    // 취소 버튼 클릭 시 처리 함수
    function cancelEdit(co_idx) {
        // 취소 버튼을 클릭하면 해당 댓글의 버튼을 숨기고 입력 필드를 비활성화
        const edit_btn = document.getElementById("btn_"+co_idx);
        const content_input = document.getElementById("contentInput_"+co_idx);
        if (edit_btn) {
            edit_btn.style.display = "none";
        }
        if (content_input) {
            content_input.disabled = true;
        }
    }

    // 저장 버튼 클릭 시 처리 함수 (비동기 방식으로 DB에 Update)
    function saveEditComment(co_idx) {
	    const content_input = document.getElementById("contentInput_"+co_idx);
	    const newContent = content_input.value;
	    const edit_btn = document.getElementById("btn_"+co_idx);
	    $.ajax({
			url: "?type=saveEditComment",
			type: "post",
			data: {co_idx: co_idx,
				newContent: newContent,
				bo_idx: ${vo.bo_idx },
				bo_type: 2 ,
				cPage: ${requestScope.cPage}},
			
		}).done(function(res) {
			edit_btn.style.display = "none";
			content_input.disabled = true;
			$("#commentList").html($(res).find("#commentList").html());
		});
	}

    // 삭제 버튼 클릭 시 처리 함수 (비동기 방식으로 DB에 Update)
    function deleteComment(co_idx) {
    	if(confirm("삭제 하시겠습니까?")){
	    	const content_input = document.getElementById("contentInput_"+co_idx);
		    const newContent = content_input.value;
		    const edit_btn = document.getElementById("btn_"+co_idx);
		    $.ajax({
				url: "?type=deleteComment",
				type: "post",
				data: {co_idx: co_idx,
					newContent: newContent,
					bo_idx: ${vo.bo_idx },
					bo_type: 2 ,
					cPage: ${requestScope.cPage}},
				
			}).done(function(res) {
				edit_btn.style.display = "none";
				content_input.disabled = true;
				$("#commentList").html($(res).find("#commentList").html());
			});
    	}
    }
</script>
<%@include file="/jsp/common/footer.jsp"%>
</body>
</html>