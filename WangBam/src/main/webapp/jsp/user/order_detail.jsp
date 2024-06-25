<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/jsp/common/header.jsp" %>
<div class="order-container">
    <div class="order-header">
        <h2>주문번호: ${ovo.or_idx}</h2>
    </div>
    <div class="order-status">
        <span class="status-value">${ovo.or_status_code}</span>
    </div>
    <c:forEach var="odvo" items="${ovo.od_list}">
    <div class="order-item">
        <img src="https://via.placeholder.com/50" alt="Product Image">
        <div class="order-item-details">
            <h3>${odvo.pvo.pd_name}</h3>
            <p>${odvo.pvo.pd_sale_price}원  &nbsp; &nbsp;  ${odvo.od_cnt}개</p>
        </div>
        <div class="order-item-actions">
            
        </div>
    </div>
    </c:forEach>
    <div class="order-actions">
    <button onclick="location.href='orderlist'">주문목록 돌아가기</button>
    
	</div>
</div>
<div class="order-recipient-info">
    <h3>받는사람 정보</h3>
    <p>받는사람: ${ovo.or_name}</p>
    <p>연락처: ${ovo.or_tel}</p>
    <p>받는주소: ${ovo.or_addr} ${ovo.or_addr_detail}</p>
    <p>배송요청사항: ${ovo.or_request}</p>
    <br/>
    <h3>결제 정보</h3>
    <p>결제수단: ${ovo.or_payment_code}</p>
    <p>총 결제금액: ${ovo.or_total_price}원</p>
    <br/>
    <h3>결제영수증 정보</h3>
    <p>해당 주문에 대해 구매 현금영수증 확인이 가능합니다.</p>
    <p>해당 쿠폰에 대해 계정영수증서 확인이 가능합니다.</p>
</div>

<div class="order-actions">
    <button onclick="location.href='orderlist'">주문목록 돌아가기</button>
    <button onclick="location.href='orderdetail?or_idx=${ovo.or_idx}'">주문내역</button>
</div>

  <%@include file="/jsp/common/footer.jsp" %>
  </body>
</html>