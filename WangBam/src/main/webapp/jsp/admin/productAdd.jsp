<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="/jsp/common/adminHeader.jsp"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>상품 추가</title>
<link rel="stylesheet" href="./css/admin.css">
</head>

<body>
	<div class="admin">
		<h1>상품 추가</h1>
		<form class="form-group" action="/WangBam/admin?type=productAdd" method="post">
			 
			<div>
				<label for="username">상품명</label> <input type="text" id="item_name"
					 name="pd_name"placeholder="상품명">
			</div>
			<div>
				<label for="category">카테고리</label> <select name="ct_idx">
					<option value="1">일반빵</option>
					<option value="2">특수빵</option>
				</select>
			</div>
			<div>
				<label for="item_discription">상품설명</label> 
			</div>
			<div>
				<label for="cnt">수량</label> <input type="text" id="cnt"
					 name="pd_cnt"placeholder="수량">
			</div>
			<div>
				<label for="sale">할인율</label> <input type="text" id="sale"
					 name="pd_sale"placeholder="할인율">
			</div>
			<div>
				<label for="price">가격</label> <input type="text" id="price" name="pd_price"
					placeholder="가격">
			</div>
			<div>
				<label for="img">상품이미지</label>
				<div>
					<img src="" />
				</div>
			</div>

			<div class="buttons">
				<button type="submit" class="admin-btn submit">추가</button>
				<button type="button" class="admin-btn cancel" onclick="javascript:location.href='/WangBam/admin?type=productList'">취소</button>
			</div>
		</form>
	</div>
	
</body>

</html>