<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@include file="/jsp/common/adminHeader.jsp"%>
<c:if test="${sessionScope.us_type == 0 }">


	<div class="admin">
        <h1>공지사항 작성</h1>
        <form action="admin?type=noticeWrite" method="post" class="form-group" enctype="multipart/form-data" name=form>
        	<input type="hidden" name="us_idx" value="${sessionScope.us_idx }"> 
        	<input type="hidden" name="pd_idx" value="1"> 
            <div>
                <label for="text">제목 :</label>
                <input type="text" name="bo_title" placeholder="제목을 입력하세요." />
            </div>
            <div>
                <label for="text">작성자 :</label>
                <input type="text" name="writer" value="${sessionScope.us_name }" disabled/>
            </div>
            <div>
                <label for="text">내용 :</label>
                <textarea id="content" name="bo_content" placeholder="내용을 입력하세요."></textarea>
            </div>

            <div class="btn_div">
                <button type="button" class="admin-btn cancel" onclick="javascript:window.location.href='admin?type=noticeList">취소</button>
                <button type="button" class="admin-btn submit" onclick="saveBorads()">저장</button>
            </div>
        </form>
    </div>
<%@include file="/jsp/common/footer.jsp"%>
<script>
function saveBorads() {
    var form = document.forms[0];
    var elements = form.elements;
    console.log(elements);

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
   // var htmlContent = $('#content').summernote('code');
   // var plainText = $('<div>').html(htmlContent).text();

    //elements['bo_content'].value = plainText;
    
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
</c:if>
<c:if test="${sessionScope.us_type != 0 }">
	<script type="text/javascript">
        window.location.href = 'Controller?type=index';
    </script>
</c:if>
</body>
</html>