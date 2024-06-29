<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@include file="/jsp/common/header.jsp" %>
<div class="user">
        <h1>문의사항 수정</h1>
        <form name="form" class="form-group" action="?type=questionEdit" method="post" enctype="multipart/form-data">
       		<input type="hidden" name="us_idx" value="${sessionScope.us_idx }"> 
        	<input type="hidden" name="pd_idx" id="pd_idx" value=""/>
			<input type="hidden" name="bo_idx" value="${vo.bo_idx}"/>
			<input type="hidden" name="cPage" value="${requestScope.cPage }"/>
            <div>
                <label for="text">제목 :</label>
                <input type="text" name="bo_title" value="${vo.bo_title}" />
            </div>
            <div>
                <label for="text">작성자 :</label>
                <input type="text" name="writer" value="${vo.uvo.us_nickname}" disabled/>
            </div>
            <select name="searchCategory" id="searchCategory">
            	<c:forEach var="category" items="${requestScope.ct_ar }">
					<option value="${category.ct_idx }">${category.ct_name }</option>            	
            	</c:forEach>
            </select>
            <select name="searchProduct" id="searchProduct">
            	<option value="select">::선택:;</option>
            		<c:forEach var="product" items="${requestScope.pd_ar }">
							<option class="product_option" data-category="${product.ct_idx}" value="${product.pd_idx }">${product.pd_name }</option>            	
            		</c:forEach>
            </select>
            <div>
                <label for="text">내용 :</label>
                <textarea id="content" name="bo_content">${vo.bo_content}</textarea>
            </div>
            <div class="btn_div">
                <button type="button" class="btn cancel" 
                onclick="javascript:window.location.href='?type=boardsDetail&bo_idx=${vo.bo_idx }&cPage=${requestScope.cPage}&bo_type=1'">취소</button>
                <button type="button" class="btn submit" onclick="editSave()">저장</button>
            </div>
        </form>
    </div>
<%@include file="/jsp/common/footer.jsp"%>
<script>
	function editSave() {
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
            url: "?type=saveImage",
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
        
        
        $('#searchCategory').prop('selectedIndex', ${vo.pvo.ct_idx - 1} );
		$('#searchProduct').prop('selectedIndex', ${vo.pvo.pd_idx} );
		
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