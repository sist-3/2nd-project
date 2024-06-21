<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="/jsp/common/adminHeader.jsp"%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>상품 관리</title>
  <link rel="stylesheet" href="./css/admin.css">
  <style>

  </style>
</head>

<body>
  <div class="search-group">
    <h2>상품 관리</h2>
    <div class="search-bar">
      <input type="text" placeholder="Search..." />
      <button class="search-btn">&#128269;</button>
    </div>
  </div>
  <table class="table">
    <tr>
      <th>선택</th>
      <th>no</th>
      <th>썸네일</th>
      <th>상품명</th>
      <th>가격</th>
      <th>재고</th>
    </tr>
    <c:forEach var="product" items="${pvo}">
    <tr>
      <td>
        <input type="checkbox" />
      </td>
      <td>${product.pd_idx}</td>
      <td>
        <img src="${product.pd_thumbnail_img }" />
      </td>
      <td><a href="admin?type=productDetail&pd_idx=${product.pd_idx}">${product.pd_name}</a></td>
      <td>${product.pd_price}</td>
      <td>${product.pd_cnt }</td>
    </tr>
    </c:forEach>
  </table>
</body>

<div class="admin-pagination">
  <a href="#">&lt;</a>
  <a href="#">1</a>
  <a href="#">2</a>
  <a href="#">3</a>
  <a href="#">4</a>
  <a href="#">5</a>
  <a href="#">&gt;</a>
</div>

<div class="btn_div">
  <button type="button" class="admin-btn cancel">삭제</button>
</div>

</html>