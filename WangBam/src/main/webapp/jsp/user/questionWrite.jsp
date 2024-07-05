<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@include file="/jsp/common/header.jsp" %>


	<div class="user">
        <form action="?type=questionWrite" method="post" class="form-group" enctype="multipart/form-data" name=form>
        	<h1>문의사항 작성</h1>
        	<input type="hidden" name="us_idx" value="${sessionScope.user.us_idx }"> 
        	<input type="hidden" id="pd_idx" name="pd_idx" value=""> 
            <div>
                <label for="text">제목 :</label>
                <input type="text" name="bo_title" placeholder="제목을 입력하세요." />
            </div>
            <div>
                <label for="text">작성자 :</label>
                <input type="text" name="writer" value="${sessionScope.user.us_name }" disabled/>
            </div>
            <select name="searchCategory" id="searchCategory">
            	<c:forEach var="category" items="${requestScope.ct_ar }">
					<option value="${category.ct_idx }" ${requestScope.ct_idx == category.ct_idx ? 'selected' : ''}>${category.ct_name }</option>            	
            	</c:forEach>
            </select>
            <select name="searchProduct" id="searchProduct">
            	<option value="select">::선택::</option>
            		<c:forEach var="product" items="${requestScope.pd_ar }">
							<option class="product_option" data-category="${product.ct_idx}" value="${product.pd_idx }"
							${requestScope.pd_idx == product.pd_idx ? 'selected' : ''}>${product.pd_name }</option>            	
            		</c:forEach>
            </select>
            <div>
                <label for="text">내용 :</label>
                <textarea id="content" name="bo_content" placeholder="내용을 입력하세요."></textarea>
            </div>

            <div class="btn_div">
                <button type="button" class="btn cancel" onclick="javascript:window.location.href='Controller?type=question'">취소</button>
                <button type="button" class="btn submit" onclick="saveBorads()">저장</button>
            </div>
        </form>
    </div>
<%@include file="/jsp/common/footer.jsp"%>
<script>
function saveBorads() {
    var form = document.forms[0];
    var elements = form.elements;
	var val = document.getElementById('searchProduct').value;

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
    if(val == "select"){
    	alert("상품을 선택하세요.");
    	return;
    }
    document.getElementById("pd_idx").value = val;
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
        //document.form.append("upload", file);

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
    
    function ProductOption() {
		var selectedCategory = document.getElementById("searchCategory").value;
        var productOptions = document.getElementsByClassName("product_option");
		/* $('#searchProduct').prop('selectedIndex', 0); */
		
        for (var i = 0; i < productOptions.length; i++) {
            var option = productOptions[i];
            if (option.getAttribute("data-category") == selectedCategory) {
                option.style.display = "block";
            }else {
                option.style.display = "none";
            }
        }
    }
	$('#searchCategory').change(function ProductOption() {
		var selectedCategory = document.getElementById("searchCategory").value;
        var productOptions = document.getElementsByClassName("product_option");
		
		
        for (var i = 0; i < productOptions.length; i++) {
            var option = productOptions[i];
            if (option.getAttribute("data-category") == selectedCategory) {
                option.style.display = "block";
            }else {
                option.style.display = "none";
            }
        }
		$('#searchProduct').val("select");
    });
    // 초기 로드 시 선택된 카테고리에 따라 제품 필터링
    document.addEventListener("DOMContentLoaded", function() {
    	ProductOption();
	});
</script>
</body>
</html>