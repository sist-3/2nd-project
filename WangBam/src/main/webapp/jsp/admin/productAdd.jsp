<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="/jsp/common/adminHeader.jsp"%>
	<div class="admin">
		<h1>상품 추가</h1>
		<form class="form-group" method="POST" action="admin?type=productSave" enctype="multipart/form-data" name="addForm">
			<div>
				<label for="username">상품명</label> <input type="text" id="item_name"
					 name="pd_name" placeholder="상품명" data-label="상품명">
			</div>
			<div>
				<label for="category">카테고리</label>
				<div class="address-group">
					<select id="category" name="ct_idx">
			        	<c:forEach var="cvo" items="${requestScope.c_list}" varStatus="st">
			        		<option value="${cvo.ct_idx}">${cvo.ct_name}</option>
			        	</c:forEach>
			        </select>
					<button type="button" class="admin-btn submit" id="popOpenBtn">수정</button>
				</div>
			</div>
			<div>
				<label for="cnt">수량</label> <input type="text" id="cnt"
					 name="pd_cnt" placeholder="수량" data-label="수량" oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/\d(?=(?:\d{3})+$)/g, '$&,')">
			</div>
			<div>
				<label for="sale">할인율</label> <input type="text" id="sale"
					 name="pd_sale" placeholder="할인율" data-label="할인율" oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/\d(?=(?:\d{3})+$)/g, '$&,')" maxlength="3">
			</div>
			<div>
				<label for="price">가격</label> <input type="text" id="price" name="pd_price" 
					placeholder="가격" data-label="가격" oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/\d(?=(?:\d{3})+$)/g, '$&,')">
			</div>
			<div>
				<label for="img">썸네일이미지</label>
				<div>
					<label class="file-select" for="pdThumbnailImg">파일선택 +</label>
					<input type="file" name="pd_thumbnail_img" id="pdThumbnailImg" data-label="썸네일이미지" onchange="selectImg(this)">
				</div>
			</div>
			<div>
				<label for="img">상세이미지</label>
				<div>
					<label class="file-select" for="pdDetailImg">파일선택 +</label>
					<input type="file" name="pd_detail_img" id="pdDetailImg" data-label="상세이미지" onchange="selectImg(this)">
				</div>
			</div>

			<div class="buttons">
				<button type="button" class="admin-btn submit" onclick="add()">저장</button>
				<button type="button" class="admin-btn cancel" onclick="javascript:location.href='admin?type=productList'">취소</button>
			</div>
		</form>
	</div>
<div id="dialog-confirm" title="알림" class="admin-dialog" style="display:none">
  <p>저장하시겠습니까?</p>
</div>
<div class="popup-container" id="categoryAddPop">
	<table class="table" id="categoryList">
		<colgroup>
			<col>
			<col width="120">
		</colgroup>
		<thead>
			<tr>
				<th>카테고리명</th>
				<th>삭제</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="cvo" items="${requestScope.c_list}" varStatus="st">
				<tr>
					<td class="split-box">
						<input type="text" value="${cvo.ct_name}" name="ct_name${cvo.ct_idx}" id="ct_name${cvo.ct_idx}">
						<button type="button" class="admin-btn cancel" onclick="updateCategory('${cvo.ct_idx}')">수정</button>
					</td>
					<td>
						<button type="button" class="admin-btn cancel" onclick="delCategory('${cvo.ct_idx}')">삭제</button>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<form>
	    <div>
			<label for="ct_name">카테고리명</label>
			<div class="split-box">
				<input type="text" id="ct_name" name="ct_name">
		        <button type="button" class="admin-btn submit" id="addCategoryBtn">추가</button>
			</div>
		</div>
    </form>
	<div class="buttons">
        <button type="button" class="admin-btn cancel" id="popCloseBtn">닫기</button>
    </div>
</div>

<%@include file="/jsp/common/footer.jsp"%>
<script>
	// 이미지 선택시 하단에 파일명 보이게
	function selectImg(input){
		const fileName = $(input).val().slice($(input).val().lastIndexOf('\\')+1);
		const elem = "<p>"+fileName+"</p>"
		if($(input).parent().find('p').length > 0){
			$(input).parent().find('p').text(fileName)
		}else {
			$(input).parent().append(elem);
		}
	}
	// 카테고리 추가
	function add(){
		const addForm = document.addForm;
		const elem = addForm.elements;
		let pass = false;
		for(i=0;i<elem.length-2;i++){
			if (elem[i].id === "sale" || elem[i].id === "category" || elem[i].id === "popOpenBtn") {
	            continue; // pd_sale, category, popOpenBtn 요소를 건너뜁니다.
	        }
			if (elem[i].type === "number"){
				if(elem[i].value < 0){
					alert("0 이상 입력하세요");
					elem[i].value= "";
					elem[i].focus();
					return;
				}
			}
			if(elem[i].id === "item_name"){
				if(elem[i].value.trim().length > 20){
					alert("상품명을 10자 이하로 입력하세요");
					return;
				}
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
					document.addForm.submit();
		        },
		        "취소": function() {
		          $( this ).dialog( "close" );
		        }
		      }
		    });
		}
	}
	// 카테고리 수정
	function updateCategory(ct_idx){
		const ct_name = $("#ct_name"+ct_idx).val();
		const param = {
			"ct_idx" : ct_idx,
			"ct_name" : ct_name
		}
		$.ajax({
			url:"admin?type=categoryUpdate",
			type:"GET",
			data:param,
		}).done(function(res){
			$("#category").html($(res).find("#category").html());
			$("#categoryList").html($(res).find("#categoryList").html());
			alert("수정완료되었습니다.");
		});
	}
	// 카테고리 삭제
	function delCategory(ct_idx){
		const ctList = $("#categoryList").html();
		$.ajax({
			url:"admin?type=categoryDelete",
			type:"GET",
			data:{
				"ct_idx" : ct_idx
			},
		}).done(function(res){
			if(ctList === $(res).find("#categoryList").html())
				alert("하위 상품이 존재해 삭제가 불가능합니다.")
			else{
				$("#category").html($(res).find("#category").html());
				$("#categoryList").html($(res).find("#categoryList").html());
				alert("삭제완료되었습니다.");
			}
		})
	}
	$("#popOpenBtn").on("click", function(){
		$("#categoryAddPop").show();
	})
	$("#popCloseBtn").on("click", function(){
		$("#categoryAddPop").hide();
	})
	$("#addCategoryBtn").on("click", function(){
		if($("#ct_name").val().length < 1){
			alert("카테고리명을 입력하세요");
			$("#ct_name").focus();
			return;
		}else {
			const ct_name = $("#ct_name").val();
			const param = {
				"ct_name" : ct_name
			}
			$.ajax({
				url: "admin?type=categoryAdd",
				type: "POST",
				data:param
			}).done(function(res){
				$("#category").html($(res).find("#category").html());
				$("#categoryList").html($(res).find("#categoryList").html());
				alert("추가 완료되었습니다.");
				$("#ct_name").val("");
			})
		}
	})

	 
</script>
</body>

</html>