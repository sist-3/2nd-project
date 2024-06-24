<%@page import="org.apache.ibatis.executor.loader.WriteReplaceInterface"%>
<%@page import="mybatis.vo.UserVO"%>
<%@page import="mybatis.vo.AddressVO"%>
<%@page import="mybatis.vo.OrderDetailVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/header.jsp"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>결제페이지</title>
<link rel="stylesheet" href="/css/style.css">
</head>

<body>
	<%-- 
        받아야할 정보
        1. 구매할 상세 주문 리스트 => List<order_detail> 
           -> 내부데이터 productVO, 수량, 상품 계산 후 가격
     --%>
	<%
	// 세션에 저장된 로그인 정보 검사 및 저장
	Object obj = session.getAttribute("uvo");
	UserVO uvo = null;
	if (obj == null) {
	%>
	<script>
		alert("결제를 위해 로그인이 필요합니다. \n 로그인 페이지로 이동합니다.");
	</script>
	<%
	response.sendRedirect("?type=login");
	return;
	} else {
	uvo = (UserVO) obj;
	}

	// 요청에 저장된 orderVO 리스트 검사 및 저장
	obj = request.getAttribute("odvoList");
	List<OrderDetailVO> odvoList = null;
	if (obj == null) {
	%>
	<script>
		alert("잘못된 접근입니다. \n 메인페이지로 이동합니다.");
	</script>
	<%
	response.sendRedirect("/");
	return;
	} else {
	odvoList = (List<OrderDetailVO>) obj;
	request.setAttribute("odvoList", odvoList);
	}
	%>
	<div class="buy-con">
		<h1>결제페이지</h1>
		<table class="order-table">
			<thead>
				<tr>
					<th>이미지</th>
					<th>상품정보</th>
					<th>판매가</th>
					<th>수량</th>
					<th>적립금</th>
					<th>배송구분</th>
					<th>배송비</th>
					<th>합계</th>
				</tr>
			</thead>
			<tbody>
				<%
				int totalPrice = 0;
				for (OrderDetailVO odvo : odvoList) {
					int price = 0;
					totalPrice += Integer.parseInt(odvo.getOd_price());
				%>
				<tr>
					<td><img src="<%=odvo.getPvo().getPd_thumbnail_img()%>"></td>
					<td><%=odvo.getPvo().getPd_name()%></td>
					<td><%=Integer.parseInt(odvo.getOd_price()) / Integer.parseInt(odvo.getOd_cnt())%></td>
					<td><%=odvo.getOd_cnt()%></td>
					<td>-</td>
					<td>기본배송</td>
					<td>착불(수령인)</td>
					<td><%=odvo.getOd_price()%></td>
				</tr>
				<%
				}
				%>
				<tr>
					<td colspan="8">상품구매금액 <%=totalPrice%>+ 배송비 4000 = 합계 : <%=totalPrice + 4000%>원
					</td>
				</tr>
			</tbody>
		</table>
		<div class="delivery-info">
			<h2>배송 정보</h2>
			<br>
			<form class="form-group" action="/WangBam" method="post">
				<input type="hidden" name="type" value="buy"> 
				<input type="hidden" name="us_idx" value="<%=uvo.getUs_idx()%>"> 
				<input type="hidden" name="total_price" value="<%=totalPrice%>"> 
				<label for="order-name">받는분</label> 
				<input type="text" id="or_name"	name="or_name" value="로그인 session에서 가져온 이름" placeholder="받는분 성함">
				<label for=postal_code>주소찾기</label>
				<div class="address-group">
					<input type="text" id="postal_code" name="postal_code"
						<c:if test="${avo != null}">value="${avo.getAd_postal_code()}"</c:if>
						placeholder="우편번호">
					<button type="button">우편번호</button>
				</div>
				<input type="text" class="address-input" name="addr"
					<c:if test="${avo != null}">value="${avo.getAd_addr()}"</c:if>
					placeholder="기본주소" /> <input type="text" class="address-input2"
					name="addr_detail"
					<c:if test="${avo != null}">value="${avo.getAd_addr_detail()}"</c:if>
					placeholder="상세주소" /> <label for="phone">휴대폰</label>
				<div class="phone-input">
					<select name="tel1">
						<option value="010">010</option>
						<!-- Add more options as needed -->
					</select> <span>-</span> <input type="text" name="tel2"
						<c:if test="${avo != null}">value="${avo.getAd_tel().substring(2,6)}"</c:if>>
					<span>-</span> <input type="text" name="tel3"
						<c:if test="${avo != null}">value="${avo.getAd_tel().substring(6)}"</c:if>>
				</div>
				<label for="request">배송시요구사항</label> <select id="request"
					name="request">
					<option value="">배송메모를 선택해주세요</option>
					<option>문 앞에 놓아주세요</option>
					<option>부재 시 연락 부탁드려요</option>
					<option>배송 전 미리 연락해 주세요</option>
				</select>

				<div class="payment">
					<h2>결제수단</h2>
					<label> <input type="radio" name="payment" value="1">무통장 입금</label> 
					<label> <input type="radio" name="payment" value="2"> 카드 결제</label>

				</div>
				<div class="total">
					<p>총 결제금액</p>
					<p class="total-amount"><%=totalPrice + 4000%>
						원
					</p>
				</div>
				<button type="button" class="final-btn" onclick="requestPayment()">결제하기</button>
			</form>
		</div>
	</div>
	<script src="https://cdn.portone.io/v2/browser-sdk.js"></script>
	<script>
		function validateForm(form) {
			const requiredFields = [ // 필수 입력 필드 목록
			{
				field : 'or_name',
				message : '받는 분 성함을 입력해주세요.'
			}, {
				field : 'postal_code',
				message : '우편번호를 입력해주세요.'
			}, {
				field : 'addr',
				message : '기본 주소를 입력해주세요.'
			}, {
				field : 'addr_detail',
				message : '상세 주소를 입력해주세요.'
			}, {
				field : 'tel2',
				message : '전화번호를 올바르게 입력해주세요.'
			}, {
				field : 'tel3',
				message : '전화번호를 올바르게 입력해주세요.'
			}, ];

			// 각 필드를 순회하면서 검사
			for (let i = 0; i < requiredFields.length; i++) {
				const input = form[requiredFields[i].field];
				if (input.value.trim() === "") {
					alert(requiredFields[i].message);
					input.focus();
					return false;
				}
			}
			return true;
		}
		
		function requestPayment(){
			let form = document.forms[0];
			if(form.payment.value == 2) {
				requestCardPayment();
			}
		}
		
		async function requestCardPayment() {
			const response = await PortOne.requestPayment({
				storeId : "store-23c8eb3a-0cc2-4cb0-902d-6a7b553a8703",
				channelKey : "channel-key-a915738a-5c22-4212-a657-76175abe0bf4",
				paymentId : `PAY123`,
				orderName : "<%=odvoList.get(0).getPvo().getPd_name()%>",
				totalAmount : <%=totalPrice + 4000%>,
				currency : "CURRENCY_KRW",
				payMethod : "CARD",
			});
			sendOrder(response);
		};

		function sendOrder(response) {
			let form = document.forms[0];
			// 폼 유효성 검사
			if (!validateForm(form)) {
				return false; // 유효성 검사 실패 시, 폼 제출 중단
			}
			// 모든 검사를 통과하면 form 제출
			form.submit();
		}
	</script>
</body>

</html>