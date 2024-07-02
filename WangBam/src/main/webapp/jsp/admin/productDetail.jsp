<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="/jsp/common/adminHeader.jsp"%>
<div class="admin">
	<h1>상품 상세 정보</h1>
	<form id="updateForm" class="form-group" action="admin?type=productUpdate" method="post"
		enctype="multipart/form-data" name="updateForm">
		<input type="hidden" name="pd_idx" value="${pvo.pd_idx}">
		<div>
			<label for="pd_name">상품명</label> <input type="text" id="pd_name"
				placeholder="상품명" name="pd_name" value="${pvo.pd_name}" data-label="상품명">
		</div>
		<div>
			<label for="ct_idx">카테고리</label> <select id="ct_idx"  name="ct_idx" data-label="카테고리">
				<option value="1">일반빵</option>
				<option value="2" <c:if test="${pvo.ct_idx == 2}">selected</c:if>>특수빵</option>
			</select>
		</div>
		<div>
			<label for="pd_cnt">수량</label> <input type="text" id="pd_cnt" name="pd_cnt"
				placeholder="수량" data-label="수량" value="${pvo.pd_cnt}">
		</div>
		<div>
			<label for="pd_sale">할인율</label> <input type="text" id="pd_sale"
				name="pd_sale" placeholder="할인율" data-label="할인율"
				value="${pvo.pd_sale}">
		</div>
		<div>
			<label for="price">가격</label> <input type="text" id="pd_price"
				placeholder="가격" name="pd_price"  data-label="가격" value="${pvo.pd_price}">
		</div>
		<div>
			<label for="productImg">썸네일이미지</label>
			<div>
				<label for="updateImg" class="file-select">파일 선택 +</label> <input
					type="file" id="updateImg" name="updateImg"
					onchange="selectImg(this)">
				<p>${pvo.pd_thumbnail_img }</p>
			</div>
		</div>
		<div>
			<label for="productDetailImg">상세이미지</label>
			<div>
				<label for="updateDetailImg" class="file-select">파일 선택 +</label> <input
					type="file" id="updateDetailImg" name="updateDetailImg"
					onchange="selectImg(this)">
				<p>${pvo.pd_detail_img }</p>
			</div>
		</div>
		<input type="hidden" name="pd_idx" value="${pvo.pd_idx}"> <input
			type="hidden" name="pd_status" value="${pvo.pd_status}">
		<div class="buttons">
			<button type="button" class="admin-btn edit" id="updateBtn" onclick="update()">수정</button>
			<button type="button" class="admin-btn submit" id="deleteBtn">삭제</button>
			<button type="button" class="admin-btn cancel"
				onclick="javascript:location.href='admin?type=productList'">취소</button>
		</div>
	</form>
</div>
<div id="dialog-confirm" title="수정" class="dialog" style="display:none">
	<p>변경하시겠습니까?</p>
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
//상품 삭제

	$("#deleteBtn").on('click', function() {
		if (confirm("정말 삭제하시겠습니까?")) {
			$.ajax({
				url: "?type=productDelete",
				type: "GET",
				data: {
					pd_idx: "${pvo.pd_idx}",
					pd_status: "${pvo.pd_status}"
				},
				success: function () {
					alert("삭제 완료!")
					// 장바구니 추가가 성공하면 장바구니 목록 페이지로 이동합니다.
					location.href = "admin?type=productList";
					
				},
				error: function () {
					alert("삭제 실패...");
				}
			});
		}
	});
//상품 수정
function update(){
		const updateForm = document.updateForm;
		const elem = updateForm.elements;
		let pass = false;
		for(i=1;i<elem.length-7;i++){
			if(elem[i].id === "pd_sale") {
				continue; // pd_sale 요소를 건너뜁니다.
			}
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
					document.updateForm.submit();
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