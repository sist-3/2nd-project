<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="/jsp/common/adminHeader.jsp"%>
  <div class="admin">
    <h1>상품 상세 정보</h1>
    <form id="productForm" class="form-group" action="admin?type=productUpdate" method="post" enctype="multipart/form-data">
      <div>
        <label for="productImg">상품이미지</label>
        <div>
      		<label for="updateImg" class="file-select">파일 선택 +</label>
      		<input type="file" id="updateImg" name="updateImg" onchange="selectImg(this)">
      		<p>${pvo.pd_thumbnail_img }</p>
      	</div>
      </div>
      <div>
        <label for="productDetailImg">상세이미지</label>
        <div>
      		<label for="productDetailImg" class="file-select">파일 선택 +</label>
      		<input type="file" id="productDetailImg" name="productDetailImg" onchange="selectImg(this)">
      		<p>${pvo.pd_detail_img }</p>
      	</div>
      </div>
      <input type="hidden" name="pd_idx" value="${pvo.pd_idx}">
      <input type="hidden" name="pd_status" value="${pvo.pd_status}">
      <div>
        <label for="itemname">상품명</label>
        <input type="text" id="itemname" placeholder="상품명" name="pd_name" value="${pvo.pd_name }">
      </div>
      <div>
        <label for="카테고리">카테고리</label>
        <select id="카테고리" name="ct_idx">
          <option value="1" >일반빵</option>
          <option value="2" <c:if test="${pvo.ct_idx == 2}">selected</c:if>>특수빵</option>
        </select>
      </div>
      <div>
        <label for="가격">가격</label>
        <input type="text" id="가격" placeholder="가격"  name="pd_price" value="${pvo.pd_price }">
      </div>
      <div class="buttons">
        <button type="submit" class="admin-btn edit" onclick="javascript:location.href='admin?type=productUpdate'">수정</button>
        <button type="button" class="admin-btn submit" onclick="changeAction()">삭제</button>
        <button type="button" class="admin-btn cancel" onclick="javascript:location.href='admin?type=productList'">취소</button>
      </div>
    </form>
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

    let updateMsg = "${updatemsg}";
	let deleteMsg = "${deletemsg}";
	
document.addEventListener("DOMContentLoaded", function() {
   if(updateMsg.length > 0){
        alert(updateMsg);
	   
   } 
   if(deleteMsg.length > 0 ){
	   alert(deleteMsg);
   }
	

});

function changeAction() {
    let form = document.getElementById('productForm');
    form.action = 'admin?type=productDelete';
    form.submit();
}

</script>
</body>

</html>