<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@include file="/jsp/common/adminHeader.jsp"%>
	<div class="form-group">
		<h1>문의사항 관리</h1>

		<div>
			<label for="title">제목</label> <input type="text" name="title"
				value="${vo.bo_title }" disabled />
		</div>
		<div>
			<label for="writeDate">작성일</label> <input type="text"
				name="writeDate" value="${vo.bo_write_date }" disabled />
		</div>
		<div>
			<label for="writer">작성자</label> <input type="text" name="writer"
				value="<c:if test='${vo.uvo.us_nickname != null}'>${vo.uvo.us_nickname}</c:if><c:if test='${vo.uvo.us_nickname == null}'>관리자</c:if>"
				disabled />
		</div>
		<div>
			<label for="content">내용</label>
			<div class="detail-txt">${vo.bo_content}</div>
		</div>
		<div>
			<label for="content">답변여부</label>
			<c:choose>
				<c:when test="${vo.bo_answer == 0}">
					<input type="text" name="answer" value="답변완료" disabled />
				</c:when>
				<c:when test="${vo.bo_answer == 1}">
					<input type="text" name="answer" value="답변대기중" disabled />
				</c:when>
			</c:choose>
		</div>


		<label for="comment">댓글 [${vo.c_list.size() }]</label>
		<div class="comment" id="commentList">
			<c:forEach var="cvo" items="${vo.c_list }" varStatus="vs">
				<div id="comment_${cvo.co_idx }" class="comment-item">
					<div class="comment-header">
						<p>
							<c:choose>
								<c:when
									test="${cvo.uvo.us_idx == vo.uvo.us_idx && cvo.uvo.us_type == 1}">
										작성자: <b style="color: #ff0044">${vo.uvo.us_nickname }</b>&nbsp;&nbsp;
									</c:when>
								<c:when test="${cvo.uvo.us_type == 0 }">
										작성자: <b style="color: #4400ff">${cvo.uvo.us_nickname }</b> &nbsp;&nbsp;
									</c:when>
								<c:when test="${cvo.uvo.us_nickname != null}">
										작성자: ${cvo.uvo.us_nickname } &nbsp;&nbsp;
									</c:when>
								<c:when test="${cvo.uvo.us_nickname == null}">
										작성자: 탈퇴한 회원 &nbsp;&nbsp;
									</c:when>
							</c:choose>
						</p>
						<p class="date">작성일: ${cvo.co_write_date } &nbsp;&nbsp;</p>
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
			<label for="comment">댓글작성</label>
			<form name="writeCommentForm" action="admin" method="post" class="writeCommentForm"
				onsubmit="return writeComment()">
				작성자: ${sessionScope.user.us_nickname }<br /> 내용:
				<textarea rows="4" cols="30" name="co_content" id="co_content"></textarea>
				<br /> <input type="hidden" name="us_idx"
					value="${sessionScope.user.us_idx }" /> <input type="hidden"
					name="bo_idx" value="${vo.bo_idx}" /> <input type="hidden"
					name="bo_type" value="1" /> <input type="hidden" name="cPage"
					value="${requestScope.cPage}" /> <input type="hidden"
					name="us_type" value="${sessionScope.user.us_type }" /> <input
					type="hidden" name="type" value="writeComment" /> <input
					type="submit" value="댓글등록" />
			</form>
		</c:if>


		<c:if test="${sessionScope.user == null}">
			<form name="loginFrm" action="Controller" method="get">
				댓글작성:
				<textarea name="co_content" id="co_content" disabled>로그인이 필요합니다.</textarea>
				<br /> <input type="hidden" name="type" value="login" /> <input
					type="submit" value="로그인" />
			</form>
		</c:if>


		<form name="boardDataForm" action="admin" method="post">
			<input type="hidden" name="type" value="questionEdit" /> <input
				type="hidden" name="bo_idx" value="${vo.bo_idx}" /> <input
				type="hidden" name="cPage" value="${requestScope.cPage}" />
		</form>
		<div class="btn-box" style="margin: 0 auto;">
			<button type="button" class="admin-btn submit" onclick="deleteBoards()">삭제</button>
			<button type="button" class="admin-btn cancel"
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
				bo_type: 0 ,
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
					bo_type: 0 ,
					cPage: ${requestScope.cPage},
					us_type: commAnswer,
				}
			}).done(function(res) {
				edit_btn.style.display = "none";
				content_input.disabled = true;
				$("#commentList").html($(res).find("#commentList").html());
				location.href=`admin?type=boardsDetail&bo_idx=${vo.bo_idx }&bo_type=${vo.bo_type}&cPage=${requestScope.cPage}`;
				
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