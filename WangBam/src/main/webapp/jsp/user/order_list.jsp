<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/jsp/common/header.jsp" %>
<c:forEach var="ovo" items="${requestScope.o_list}">
<div class="order-container">
        <div class="order-header">
            <h2>주문번호: ${ovo.or_idx}</h2>
            <a href="http://localhost:8080/WangBam/?type=orderdetail&or_idx=${ovo.or_idx}">주문 상세보기 &gt;</a>
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
            	<button style="background-color: #8B4513; color: white; border: none; padding: 10px 20px; border-radius: 5px; cursor: pointer; transition: background-color 0.3s ease;">리뷰작성</button>
        	</div>	
        </div>
        </c:forEach>
        <div class="order-total-price">
            <span>총 결제금액: ${ovo.or_total_price}원</span>
        </div>
    </div>
</c:forEach>
<%@include file="/jsp/common/footer.jsp" %>
  </body>
</html>