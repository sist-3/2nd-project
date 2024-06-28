// 가져가서 사용 전 스크립트 선언 필수
// <script src="https://cdn.portone.io/v2/browser-sdk.js"></script>
// <script src="${pageContext.request.contextPath}/js/Payment.js"></script>

// Key 모음
const storeId = "store-23c8eb3a-0cc2-4cb0-902d-6a7b553a8703";
const channelKey = "channel-key-373bd11f-eb47-4c2d-962a-f630fd0d7a49";
const secretKey = "TzHvWqMNsWKeSnOlJuyoUPemdT1ZlPwh7lUPjRXZ9vQWJxVwl7N1hFxjQCuSMs5V63e8CYWAoinIu9Jt";

// 결재창 불러오기
async function requestCardPayment(data) {
	const response = await PortOne.requestPayment({
		storeId : storeId,
		channelKey : channelKey,
		paymentId : `PAYMENT`+data.or_idx,
		orderName : "[히트상품] "+data.pd_name,
		totalAmount : data.price,
		currency : "CURRENCY_KRW",
		payMethod : "CARD",
	});
	if (response.code != null) {
		return alert(response.message);
	}
	
	if(getPaymentByOrIdx(data.or_idx).status == "PAID") {
		return response;
	}
};

// 단건 조회
 function getPaymentByOrIdx(or_idx) {
	const settings = {
	  async: false,
	  crossDomain: true,
	  url: 'https://api.portone.io/payments/PAYMENT'+or_idx,
	  method: 'get',
	  headers: {
	    'Content-Type': 'application/json',
    	Authorization: 'PortOne '+secretKey
	  }
	};

	$.ajax(settings).done(function (response) {
		result = response;
	});
	
	return result;
};

// 전체 조회
function getAllPayments() {
	const settings = {
	  async: true,
	  crossDomain: true,
	  url: 'https://api.portone.io/payments-by-cursor',
	  method: 'get',
	  headers: {
	    'Content-Type': 'application/json',
    	Authorization: 'PortOne '+secretKey
	  }
	};

	$.ajax(settings).done(function (response) {
	  result = response;
	});

	return result;
};