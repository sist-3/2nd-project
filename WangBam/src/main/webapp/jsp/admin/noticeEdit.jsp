<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@include file="/jsp/common/adminHeader.jsp"%>

<div class="admin">
        <h1>공지사항 수정</h1>
        <form name="editForm" class="form-group" action="admin?type=noticeEdit" method="post" encType="multipart/form-data">
            <div>
                <label for="text">제목 :</label>
                <input type="text" name="title" placeholder="${vo.bo_title}" />
            </div>
            <div>
                <label for="text">작성자 :</label>
                <input type="text" name="writer" placeholder="${vo.uvo.us_nickname}" />
            </div>
            <div>
                <label for="text">내용 :</label>
                <textarea id="content" name="content" placeholder="${vo.bo_content}"></textarea>
            </div>
			<input type="hidden" name="bo_idx" value="${vo.bo_idx}"/>
			<!-- <input type="hidden" name="type" value="noticeEdit"/> -->
            <div class="btn_div">
                <button type="button" class="admin-btn cancel" 
                onclick="javascript:window.location.href='Controller?type=boardsDetail&bo_idx=${vo.bo_idx }&cPage=${requestScope.cPage}&bo_type=0'">취소</button>
                <button type="button" class="admin-btn submit" onclick="editSave()">저장</button>
            </div>
        </form>
    </div>
<script>
	function editSave() {
		let res = confirm("저장 하시겠습니까?");
		if(res){
			document.editForm.submit();
		}
	}
</script>
</body>
</html>