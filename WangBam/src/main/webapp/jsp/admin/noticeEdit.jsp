<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@include file="/jsp/common/adminHeader.jsp"%>
<div class="admin">
        <h1>공지사항 수정</h1>
        <form name="form" class="form-group" action="admin?type=noticeEdit" method="post" enctype="multipart/form-data">
       		<input type="hidden" name="us_idx" value="${sessionScope.us_idx }"> 
        	<input type="hidden" name="pd_idx" value="1">
			<input type="hidden" name="bo_idx" value="${vo.bo_idx}"/>
            <div>
                <label for="text">제목 :</label>
                <input type="text" name="bo_title" value="${vo.bo_title}" />
            </div>
            <div>
                <label for="text">작성자 :</label>
                <input type="text" name="writer" value="${vo.uvo.us_nickname}" disabled/>
            </div>
            <div>
                <label for="text">내용 :</label>
                <textarea id="content" name="bo_content">${vo.bo_content}</textarea>
            </div>
            <div class="btn_div">
                <button type="button" class="admin-btn cancel" 
                onclick="javascript:window.location.href='admin?type=boardsDetail&bo_idx=${vo.bo_idx }&cPage=${requestScope.cPage}&bo_type=0'">취소</button>
                <button type="button" class="admin-btn submit" onclick="editSave()">저장</button>
            </div>
        </form>
    </div>
<%@include file="/jsp/common/footer.jsp"%>
<script>
	function editSave() {
		 var form = document.forms[0];
		    var elements = form.elements;

		    if (elements['bo_title'].value.trim() == "") {
		        alert("제목을 입력하세요.");
		        elements['bo_title'].focus();
		        return;
		    }

		    if (elements['bo_content'].value.trim() == "") {
		        alert("내용을 입력하세요.");
		        elements['bo_content'].focus();
		        return;
		    }
		    form.submit();
	}
	$(function() {
		$("#content").summernote({
			lang: "ko-KR",
			//width: 500,
			height: 300,
			maxHeight:400,
			minHeight: 200,
			dialogsInBody: true,
			//enterHtml: '<p><br></p>',
			callbacks:{
				onImageUpload:function(files){
					for(let i=0; i<files.length; i++)
						sendImage(files[i]);
				}
			}
		});
		$("#content").summernote("lineHeight", 1.5);
	});
	function sendImage(file) {
        let frm = new FormData();
        frm.append("upload", file);
        document.form.append("upload", file);

        $.ajax({
            url: "admin?type=saveImage",
            type: "post",
            data: frm,
            contentType: false,
            processData: false,
            dataType: "json",
            
        }).done(function(data) {
            $("#content").summernote("insertImage", data.img_url);
        });
        
    };
</script>
</body>
</html>