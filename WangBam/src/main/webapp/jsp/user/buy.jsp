<%@page import="mybatis.dao.OrderDAO"%>
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
	<%
	final int deliveryFee = 4000;
	
	int idx = OrderDAO.findLastIdx() + 1;
	
	// 세션에 저장된 로그인 정보 검사 및 저장
	Object obj = session.getAttribute("user");
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
	obj = session.getAttribute("odvoList");
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
					<td class="comma"><%=Integer.parseInt(odvo.getOd_price()) / Integer.parseInt(odvo.getOd_cnt())%></td>
					<td><%=odvo.getOd_cnt()%></td>
					<td>-</td>
					<td>기본배송</td>
					<td>착불(수령인)</td>
					<td class="comma"><%=odvo.getOd_price()%></td>
				</tr>
				<%
				}
				%>
				<tr>
					<td colspan="8" >상품구매금액 <span class="comma"><%=totalPrice%></span>+ 배송비 4,000원 = 합계 : <span class="comma"><%=totalPrice + deliveryFee%></span>
					</td>
				</tr>
			</tbody>
		</table>
		<div class="delivery-info">
			<h2>배송 정보</h2>
			<br>
			<form class="form-group" action="/WangBam/?type=payment" method="post">
				<input type="hidden" name="type" value="buy">
				<input type="hidden" name="us_idx" value="<%=uvo.getUs_idx()%>"> 
				<input type="hidden" name="total_price" value="<%=totalPrice%>"> 
				<label for="order-name">받는분</label> 
				<input type="text" id="or_name"	name="or_name" value="<%=uvo.getUs_name()%>" placeholder="받는분 성함">
				<label for=postal_code>주소찾기</label>
				<div class="address-group">
					<input type="text" id="postal_code" name="postal_code"
						<c:if test="${avo != null}">value="${avo.getAd_postal_code()}"</c:if>
						placeholder="우편번호">
					<button id="address-btn" name="address-btn" type="button">우편번호</button>
				</div>
				<input type="text" class="address-input" name="addr"
					<c:if test="${avo != null}">value="${avo.getAd_addr()}"</c:if>
				placeholder="기본주소" /> 
					<input type="text" class="address-input2" name="addr_detail"
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
					<p class="total-amount comma"><%=totalPrice + deliveryFee%></p>
				</div>
				<button type="button" class="final-btn" onclick="requestPayment()">결제하기</button>
			</form>
		</div>
	</div>
	<%@include file="/jsp/common/footer.jsp"%>
	<script>
		$(window).on('load', function(){
		    $('.comma').each(function(){
		        var txt = $(this).text();
		        $(this).html(txt.replace(/,/g, ''));
	
		        var len = $(this).text().length;
		        for (i = 0; i < len; i ++){
		            $(this).eq(i).text(commaNum($(this).eq(i).text()));
	        	}
	    	});

		    function commaNum(num){
		        var len, point, str;
		        num = num + '';
		        point = num.length % 3
		        len = num.length;
		        str = num.substring(0, point);
		        while (point < len){
		            if (str != '') str += ',';
		            str += num.substring(point, point + 3);
		            point += 3;
		        }
		        return str+"원";
		    }
		});
	    
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
		
		async function requestPayment(){
			let form = document.forms[0];
			// 폼 유효성 검사
			if (!validateForm(form)) {
				return false; // 유효성 검사 실패 시, 폼 제출 중단
			}
			if(form.payment.value == 2) {
				const data = {
					or_idx : <%=idx%>,
					pd_name : "<%=odvoList.get(0).getPvo().getPd_name()%>",
					price : "<%=totalPrice+deliveryFee%>" 
				}
				const response = await requestCardPayment(data);
				
				if(response != null) {					
					sendOrder(response);
				}
			}
		}

		function sendOrder(response) {
			let form = document.forms[0];
			
			// 폼 데이터에 hidden type으로 paymentId 추가
			let paymentId = document.createElement("input");
			paymentId.type = "hidden";
			paymentId.name = "paymentId";
			paymentId.value = response.paymentId;
			form.appendChild(paymentId);
			
			// 모든 검사를 통과하면 form 제출
			form.submit();
		}
		
		$('#address-btn').on('click', function(){
			let form = document.forms[0];
			
			new daum.Postcode({
			oncomplete: function(data) {
					var addr = ''; // 주소 변수
					var extraAddr = ''; // 참고항목 변수
				
					if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
						addr = data.roadAddress;
					} else { // 사용자가 지번 주소를 선택했을 경우(J)
						addr = data.jibunAddress;
					}
				
					if(data.userSelectedType === 'R'){
						if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
							extraAddr += data.bname;
						}
						if(data.buildingName !== '' && data.apartment === 'Y'){
							extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
						}
						if(extraAddr !== ''){
							extraAddr = ' (' + extraAddr + ')';
						}
					}
					form.postal_code.value = data.zonecode;
					form.addr.value = addr+extraAddr;
					form.addr_detail.value="";
				    form.addr_detail.focus(); 	
			    }
			}).open();
		});
	</script>
</body>

</html>