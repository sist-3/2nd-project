<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="/jsp/common/adminHeader.jsp"%>
	<div class="admin">
		<h1>상품 추가</h1>
		<form class="form-group" method="POST" action="admin?type=productSave" enctype="multipart/form-data" name="addForm">
			<div>
				<label for="username">상품명</label> <input type="text" id="item_name"
					 name="pd_name"placeholder="상품명" data-label="상품명">
			</div>
			<div>
				<label for="category">카테고리</label> <select name="ct_idx" data-label="카테고리">
					<option value="1">일반빵</option>
					<option value="2">특수빵</option>
				</select>
			</div>
			<div>
				<label for="cnt">수량</label> <input type="text" id="cnt"
					 name="pd_cnt" placeholder="수량" data-label="수량">
			</div>
			<div>
				<label for="sale">할인율</label> <input type="text" id="sale"
					 name="pd_sale" placeholder="할인율" data-label="할인율">
			</div>
			<div>
				<label for="price">가격</label> <input type="text" id="price" name="pd_price" 
					placeholder="가격" data-label="가격">
			</div>
			<div>
				<label for="img">썸네일이미지</label>
				<div>
					<label class="file-select" for="pdThumbnailImg">파일선택 +</label>
					<input type="file" name="pd_thumbnail_img" id="pdThumbnailImg" onchange="selectImg(this)">
				</div>
			</div>
			<div>
				<label for="img">상세이미지</label>
				<div>
					<label class="file-select" for="pdDetailImg">파일선택 +</label>
					<input type="file" name="pd_detail_img" id="pdDetailImg" onchange="selectImg(this)">
				</div>
			</div>

			<div class="buttons">
				<button type="button" class="admin-btn submit" onclick="add()">추가</button>
				<button type="button" class="admin-btn cancel" onclick="javascript:location.href='admin?type=productList'">취소</button>
			</div>
		</form>
	</div>
<div id="dialog-confirm" title="알림" class="dialog" style="display:none">
  <p>저장하시겠습니까?</p>
</div>
<%@include file="/jsp/common/footer.jsp"%>
<script>
	function selectImg(input){
		const fileName = $(input).val().slice($(input).val().lastIndexOf('\\')+1);
		const elem = "<p>"+fileName+"</p>"
		if($(input).parent().find('p').length > 0){
			$(input).parent().find('p').text(fileName)
		}else {
			$(input).parent().append(elem);
		}
	}

	function add(){
		const addForm = document.addForm;
		const elem = addForm.elements;
		let pass = false;
		for(i=0;i<elem.length-4;i++){
			if(elem[i].value.trim().length < 1) {
				alert(elem[i].dataset.label+"을 입력하세요");
				elem[i].value= "";
				elem[i].focus();
				pass= false;
				break;
			}else {
				pass = true;
			}
			
		}
		if(pass){
			$( "#dialog-confirm" ).dialog({
		      resizable: false,
		      draggable: false,
		      height: "auto",
		      width: 400,
		      modal: true,
		      buttons: {
		        "확인": function() {
		          $( this ).dialog( "close" );
					document.addForm.submit();
		        },
		        "취소": function() {
		          $( this ).dialog( "close" );
		        }
		      }
		    });
		}
	}
	 
</script>
</body>

</html>