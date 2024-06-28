<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>결제 완료</title>
<link rel="stylesheet" href="/css/style.css">
<style>
body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
}

.success-message {
    background-color: #fff;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    text-align: center;
}

.success-message img {
	width: 120px;
    height: 100px;
}    

.success-message h1 {
    color: #673a11;
    margin: 20px 0;
}

.success-message p {
    color: #333;
    margin: 30px 0;
}

.success-message .btn {
    display: inline-block;
    margin: 10px 5px;
    padding: 10px 20px;
    background-color: #4CAF50;
    color: #fff;
    text-decoration: none;
    border-radius: 5px;
    transition: background-color 0.3s;
}

.success-message .btn:hover {
    background-color: #45a049;
}
</style>
</head>
	<%@include file="/jsp/common/header.jsp"%>
	<div class="container">
        <div class="success-message">
        	<img src="img/logo.png" alt="성공 이미지">
            <h1>주문이 완료되었습니다!</h1>
            <p>주문 번호: <span id="order-number">${idx}</p>
            <p>주문해주셔서 감사합니다. 주문 내역은 이메일로 발송되었습니다.</p>
            <a class="final-btn" href="/WangBam/?type=orderdetail&or_idx=${idx}">주문 내역 보기</a>
            <a class="final-btn" href="/WangBam/">계속 쇼핑하기</a>
        </div>
    </div>
	<%@include file="/jsp/common/footer.jsp"%>
</body>
</html>