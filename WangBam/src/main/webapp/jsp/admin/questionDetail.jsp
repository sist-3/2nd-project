<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@include file="/jsp/common/adminHeader.jsp"%>
	<h1>문의사항 관리</h1>
	<div class="form-group">
		
		<div>
	        <div>
				<div><h2 style="margin-bottom: 12px;">${vo.bo_title }</h2></div>
				<div style="color: gray; border-bottom: 1px solid #ddd; padding-bottom: 12px; margin-bottom: 8px;">
		            <span><c:if test='${vo.uvo.us_nickname != null}'>${vo.uvo.us_nickname}</c:if>
						<c:if test='${vo.uvo.us_nickname == null}'>관리자</c:if></span>&nbsp;|&nbsp;
	    	        <span>문의상품 : ${vo.pvo.pd_name }</span>&nbsp;&nbsp;|&nbsp;
	    	        <c:choose>
						<c:when test="${vo.bo_answer == 0}">
							<span style="color: blue">답변완료</span>
						</c:when>
						<c:when test="${vo.bo_answer == 1}">
							<span style="color: red">답변대기중</span>
						</c:when>
					</c:choose>
					<br/>
					<span>댓글 : ${vo.c_list.size() }개</span>&nbsp;&nbsp;|&nbsp;
					<span>조회 : ${vo.bo_hit }회</span>&nbsp;&nbsp;|&nbsp;
	    	        <span>${vo.bo_write_date }</span>
				</div>
	            <p>${vo.bo_content}</p>
	        </div>
   		</div>

		<label for="comment">댓글 [${vo.c_list.size() }]</label>
		<div class="comment" id="commentList">
			<c:forEach var="cvo" items="${vo.c_list }" varStatus="vs">
				<div id="comment_${cvo.co_idx }" class="comment-item">
					<div class="comment-header">
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
						<p class="date">${cvo.co_write_date } &nbsp;&nbsp;</p>
					</div>

					<c:if
						test="${cvo.uvo.us_idx == sessionScope.user.us_idx and cvo.uvo.us_idx != null }">
						<button class="admin-btn submit" type="button"
							onclick="editComment('${cvo.co_idx}')"
							style="float: right; margin-top: 20px;">수정</button>
						<br />
					</c:if>
					<c:if
						test="${sessionScope.user.us_type == 0 and cvo.uvo.us_idx != sessionScope.user.us_idx}">
						<button class="admin-btn submit" type="button"
							onclick="deleteComment('${cvo.co_idx}')"
							style="float: right; margin-top: 20px;">삭제</button>
						<br />
					</c:if>
					<div class="edit_comment">
						<input id="contentInput_${cvo.co_idx }" type="text"
							value="${cvo.co_content }" disabled style="width: 80%" />
						<div class="commentEdit_btn" id="btn_${cvo.co_idx }"
							style="display: none; float: right;">
							<button type="button" onclick="cancelEdit('${cvo.co_idx }')">취소</button>
							<button type="button" onclick="saveEditComment('${cvo.co_idx}')">저장</button>
							<button type="button" onclick="deleteComment('${cvo.co_idx}')">삭제</button>
						</div>
					</div>
				</div>
				<c:if test="${vs.last}">
					<c:set var="commAnswer" value="${cvo.uvo.us_type }" scope="request" />
				</c:if>



				<c:set var="targetIndex" value="${vo.c_list.size() - 2 }" />

				<c:forEach var="comment" items="${vo.c_list}" varStatus="status">
					<c:if test="${status.index == targetIndex}">
						<c:set var="commAnswer2" value="${comment.uvo.us_type}"
							scope="request" />
					</c:if>
				</c:forEach>


			</c:forEach>
		</div>

		<input type="hidden" id="answerInput" name="us_type"
			value="${commAnswer2 }" />

		<c:if test="${sessionScope.user != null}">
			<h3>댓글 쓰기</h3><h4>작성자: ${sessionScope.user.us_nickname }</h4>
			<form name="writeCommentForm" action="admin" method="post" class="writeCommentForm"	onsubmit="return writeComment()"  style="display: flex; align-items: flex-start; flex-direction: row;">
				<textarea rows="4" cols="30" name="co_content" id="co_content"   style="resize: none; margin-right: 10px; display: inline-block; width: calc(100% - 80px);"></textarea>
				<input type="hidden" name="us_idx" value="${sessionScope.user.us_idx }" /> 
				<input type="hidden" name="bo_idx" value="${vo.bo_idx}" />
				<input type="hidden" name="bo_type" value="1" /> 
				<input type="hidden" name="cPage" value="${requestScope.cPage}" /> 
				<input type="hidden" name="us_type" value="${sessionScope.user.us_type }" /> 
				<input type="hidden" name="type" value="writeComment" />
				<button type="submit" class="admin-btn submit" style="height: 98px; width: 70px; float: right;">댓글등록</button>
			</form>
		</c:if>


		<form name="boardDataForm" action="admin" method="post">
			<input type="hidden" name="type" value="questionEdit" /> 
			<input type="hidden" name="bo_idx" value="${vo.bo_idx}" /> 
			<input type="hidden" name="cPage" value="${requestScope.cPage}" />
		</form>
		<div class="btn-box" style="margin: 0 auto;">
			<button type="button" class="admin-btn cancel" onclick="deleteBoards()">삭제</button>
			<button type="button" class="admin-btn submit"
				onclick="javascript:window.location.href='admin?type=questionList&cPage=${requestScope.cPage }'">목록</button>
		</div>
	</div>
	<%@include file="/jsp/common/footer.jsp"%>
	<script>
	//댓글 유효성 검사
	function writeComment() {
		var val = document.getElementById("co_content");
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
			url: "admin?type=saveEditComment",
			type: "post",
			data: {co_idx: co_idx,
				newContent: newContent,
				bo_idx: ${vo.bo_idx },
				bo_type: 1 ,
				cPage: ${requestScope.cPage}},
			
		}).done(function(res) {
			edit_btn.style.display = "none";
			content_input.disabled = true;
			$("#commentList").html($(res).find("#commentList").html());
			window.location.reload(true);
		});
	};

    // 삭제 버튼 클릭 시 처리 함수 (비동기 방식으로 DB에 Update)
    function deleteComment(co_idx) {
    	if(confirm("삭제 하시겠습니까?")){
	    	const content_input = document.getElementById("contentInput_"+co_idx);
		    const newContent = content_input.value;
		    const edit_btn = document.getElementById("btn_"+co_idx);
		    const commAnswer = document.getElementById("answerInput").value;
		    $.ajax({
				url: "admin?type=deleteComment",
				type: "post",
				data: {co_idx: co_idx,
					newContent: newContent,
					bo_idx: ${vo.bo_idx },
					bo_type: 1 ,
					cPage: ${requestScope.cPage},
					us_type: commAnswer,
				}
			}).done(function(res) {
				edit_btn.style.display = "none";
				content_input.disabled = true;
				$("#commentList").html($(res).find("#commentList").html());
				location.href=`admin?type=questionDetail&bo_idx=${vo.bo_idx }&bo_type=${vo.bo_type}&cPage=${requestScope.cPage}`;
				
			});
    	}
    };
    function deleteBoards() {
    	if(confirm("삭제 하시겠습니까?")){
    		location.href=`admin?type=questionDelete&bo_idx=${vo.bo_idx }`;
    	}
	};
</script>
</body>
</html>