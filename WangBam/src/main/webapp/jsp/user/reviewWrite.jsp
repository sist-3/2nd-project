<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@include file="/jsp/common/header.jsp" %>


	<div class="user">
        <h1>리뷰 작성</h1>
        <form action="?type=reviewWrite" method="post" class="form-group" enctype="multipart/form-data" name=form>
        	<input type="hidden" name="us_idx" value="${sessionScope.user.us_idx }"> 
        	 
            <div>
                <label for="text">제목 :</label>
                <input type="text" name="bo_title" placeholder="제목을 입력하세요." />
            </div>
            <div>
                <label for="text">작성자 :</label>
                <input type="text" name="writer" value="${sessionScope.user.us_name }" disabled/>
            </div>
            <div>
            	<label for="text">제품 :</label>
	            <input type="text" name="pd_idx" value="${requestScope.product.pd_name }" disabled/>
            </div>
			<div>
            	<label for="text">평점 :</label>
	            <select name="bo_score">
	            	<c:forEach begin="1" end="10" varStatus="vs">
       					<option value="${vs.count/2}">${vs.count/2}점</option>
    				</c:forEach>
	            </select>
            </div>
            <div>
                <label for="text">내용 :</label>
                <textarea id="content" name="bo_content" placeholder="내용을 입력하세요."></textarea>
            </div>
            <div class="btn_div">
                <button type="button" class="btn cancel" onclick="javascript:window.location.href='Controller?type=review'">취소</button>
                <button type="button" class="btn submit" onclick="saveBorads()">저장</button>
            </div>
        </form>
    </div>
<%@include file="/jsp/common/footer.jsp"%>
<script>
	function saveBorads() {
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
			height: 300,
			maxHeight:400,
			minHeight: 200,
			dialogsInBody: true,
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
            url: "Controller?type=saveImage",
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