// 결재창 불러오기
async function requestCardPayment(data) {
	const response = await PortOne.requestPayment({
		storeId : PaymentConfig.storeId,
		channelKey : PaymentConfig.channelKey,
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
    	Authorization: 'PortOne '+ PaymentConfig.secretKey
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
    	Authorization: 'PortOne '+ PaymentConfig.secretKey
	  }
	};

	$.ajax(settings).done(function (response) {
	  result = response;
	});

	return result;
};