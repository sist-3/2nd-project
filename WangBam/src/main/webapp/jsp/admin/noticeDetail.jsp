<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@include file="/jsp/common/adminHeader.jsp"%>
	<h1>공지 상세보기</h1>
	<div class="form-group">
		
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
			<%-- <input type="text" name="content" value="${vo.bo_content}" disabled /> --%>
			<div style="border: 1px solid #ddd; border-radius:8px; background:#fff; padding: 12px;">${vo.bo_content}</div>
		</div>
		
	
		<label for="comment">댓글 [${vo.c_list.size() }]</label>
		<div class="comment" id="commentList">
			<c:forEach var="cvo" items="${vo.c_list }" varStatus="vs">
					<div id="comment_${cvo.co_idx }" class="comment-item">
						<div class="comment-header">
							<p>
								<c:choose>
									<c:when test="${cvo.uvo.us_idx == vo.uvo.us_idx && cvo.uvo.us_type == 1}">
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
							<p class="date">
								작성일: ${cvo.co_write_date } &nbsp;&nbsp;
							</p>
						</div>
						
						<c:if test="${cvo.uvo.us_idx == sessionScope.user.us_idx and cvo.uvo.us_idx != null }">
					    	<button class="admin-btn submit" type="button" onclick="editComment('${cvo.co_idx}')" style="float: right; margin-top: 20px;">수정</button><br/>
						</c:if>
						<c:if test="${sessionScope.user.us_type == 0 and cvo.uvo.us_idx != sessionScope.user.us_idx}">
							<button class="admin-btn submit" type="button" onclick="deleteComment('${cvo.co_idx}')" style="float: right; margin-top: 20px;">삭제</button><br/>
						</c:if>
						<div class="edit_comment">
							<input id="contentInput_${cvo.co_idx }" type="text" value="${cvo.co_content }" style="width: 80%" disabled/>
							<div class="commentEdit_btn" id="btn_${cvo.co_idx }" style="display:none; float: right;">
								<button type="button" onclick="cancelEdit('${cvo.co_idx }')">취소</button>
								<button type="button" onclick="saveEditComment('${cvo.co_idx}')">저장</button>
								<button type="button" onclick="deleteComment('${cvo.co_idx}')">삭제</button>
							</div>
						</div>
					</div>
			</c:forEach>
		</div>
	
	<br/>

		<c:if test="${sessionScope.user != null}">
			<h2>댓글 쓰기</h2><h4>작성자: ${sessionScope.user.us_nickname }</h4>
				<form class="comment-form" name="writeCommentForm" action="admin" method="post" onsubmit="return writeComment()" style="display: flex; align-items: flex-start; flex-direction: row;">
					<textarea rows="4" cols="30" name="co_content" id="co_content"  style="resize: none; margin-right: 10px; display: inline-block; width: calc(100% - 80px);"></textarea>
					<input type="hidden" name="us_idx" value="${sessionScope.user.us_idx }"/>
					<input type="hidden" name="bo_idx" value="${vo.bo_idx}"/>
					<input type="hidden" name="bo_type" value="0"/>
					<input type="hidden" name="us_type" value="0"/>
					<input type="hidden" name="cPage" value="${requestScope.cPage}"/>
					<input type="hidden" name="type" value="writeComment"/>
					<button type="submit" class="admin-btn submit" style="height: 98px; width: 70px; float: right;">댓글등록</button>
				</form>
		</c:if>
		
		<form name="boardDataForm" action="admin" method="post">
			<input type="hidden" name="type" value="noticeEdit"/>
			<input type="hidden" name="bo_idx" value="${vo.bo_idx}"/>
			<input type="hidden" name="cPage" value="${requestScope.cPage}"/>
		</form>
		
		<div class="buttons">
			<button type="button" class="admin-btn cancel"
					onclick="javascript:window.location.href='admin?type=noticeEdit&bo_idx=${vo.bo_idx }'">수정</button>
			<button type="button" class="admin-btn cancel"
					onclick="deleteBoards()">삭제</button>
			<button type="button" class="admin-btn submit"
					onclick="javascript:window.location.href='admin?type=noticeList&cPage=${requestScope.cPage }'">목록</button>
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
				us_type: 0,
				cPage: ${requestScope.cPage}},
			
		}).done(function(res) {
			edit_btn.style.display = "none";
			content_input.disabled = true;
			$("#commentList").html($(res).find("#commentList").html());
		});
	};

    // 삭제 버튼 클릭 시 처리 함수 (비동기 방식으로 DB에 Update)
    function deleteComment(co_idx) {
    	if(confirm("삭제 하시겠습니까?")){
	    	const content_input = document.getElementById("contentInput_"+co_idx);
		    const newContent = content_input.value;
		    const edit_btn = document.getElementById("btn_"+co_idx);
		    $.ajax({
				url: "admin?type=deleteComment",
				type: "post",
				data: {co_idx: co_idx,
					newContent: newContent,
					bo_idx: ${vo.bo_idx },
					bo_type: 0 ,
					us_type: 0 ,
					cPage: ${requestScope.cPage}},
				
			}).done(function(res) {
				edit_btn.style.display = "none";
				content_input.disabled = true;
				$("#commentList").html($(res).find("#commentList").html());
			});
    	}
    };
    function deleteBoards() {
    	if(confirm("삭제 하시겠습니까?")){
    		location.href=`admin?type=noticeDelete&bo_idx=${vo.bo_idx }`;
    	}
	};
</script>
</body>
</html>