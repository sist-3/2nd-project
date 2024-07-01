<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@include file="/jsp/common/header.jsp" %>
	<div class="form-group">
		<h1>리뷰 상세보기</h1>
		
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
			<label for="content">상품</label>
			<input type="text" name="scroe" value="${vo.pvo.pd_name}" disabled />
		</div>
		<div>
			<label for="content">평점</label>
			<input type="text" name="scroe" value="${vo.bo_score}" disabled />
		</div>
		<div>
			<label for="contents">내용</label>
			<%-- <input type="text" name="content" value="${vo.bo_content}" disabled /> --%>
			<div class="contents">${vo.bo_content}</div>
		</div>
		<div>
			<label for="content">조회수</label>
			<input type="text" name="scroe" value="${vo.bo_hit}" disabled />
		</div>
			<div class="comment-list-section" id="commentList">
		        <h2>댓글 목록 [${vo.c_list.size() }]</h2>
		        <div class="comments-list">
					<c:forEach var="cvo" items="${vo.c_list }" varStatus="vs">
					<div id="comment_${cvo.co_idx }" class="comment">
						<div class="split-box">
							<c:choose>
								<c:when test="${cvo.uvo.us_idx == vo.uvo.us_idx && cvo.uvo.us_type == 1}">
									<p><strong>작성자</strong>: <b style="color: #ff0044">${vo.uvo.us_nickname }</b></p>
								</c:when>
								<c:when test="${cvo.uvo.us_type == 0 }">
									<p><strong>작성자</strong>: <b style="color: #4400ff">${cvo.uvo.us_nickname }</b></p>
								</c:when>
								<c:when test="${cvo.uvo.us_nickname != null}">
									<p><strong>작성자</strong>: ${cvo.uvo.us_nickname }</p>
								</c:when>
								<c:when test="${cvo.uvo.us_nickname == null}">
									<p><strong>작성자</strong>: 탈퇴한 회원</p>
								</c:when>
							</c:choose>
							<p><strong>작성일</strong>: ${cvo.co_write_date }</p>
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
		        <h2>댓글 쓰기</h2>
		        <form class="comment-form" name="writeCommentForm" action="Controller" method="post" onsubmit="return writeComment()">
		            <div class="form-group">
		                <textarea rows="4" cols="30" name="co_content" id="co_content"></textarea>
		            </div>
		            <input type="hidden" name="us_idx" value="${sessionScope.user.us_idx }"/>
					<input type="hidden" name="bo_idx" value="${vo.bo_idx}"/>
					<input type="hidden" name="bo_type" value="2"/>
					<input type="hidden" name="cPage" value="${requestScope.cPage}"/>
					<input type="hidden" name="type" value="writeComment"/>
		            <button type="submit">댓글등록</button>
		        </form>
		    </div>
		</c:if>
		
		<c:if test="${sessionScope.user == null}">
	        <form class="comment-form" name="writeCommentForm" action="Controller" method="post" onsubmit="return writeComment()">
	            <div class="form-group">
	                댓글작성<textarea name="co_content" id="co_content" disabled>로그인이 필요합니다.</textarea>
	            </div>
	            <input type="hidden" name="type" value="login"/>
	            <button type="submit">로그인</button>
	        </form>
		</c:if>
		
		<c:if test="${sessionScope.user.us_idx == vo.uvo.us_idx}">
			<button type="button" class="btn submit"
					onclick="javascript:window.location.href='?type=reviewEdit&bo_idx=${vo.bo_idx }&cPage=${requestScope.cPage }'">수정</button>
			<button type="button" class="btn cancel"
					onclick="javascript:window.location.href='?type=reviewDelete&bo_idx=${vo.bo_idx }&cPage=${requestScope.cPage }'">삭제</button>
		</c:if>
		
		
		<button type="button" class="btn cancel"
				onclick="javascript:window.location.href='Controller?type=review&cPage=${requestScope.cPage }'">목록</button>
		
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