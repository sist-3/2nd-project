<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/jsp/common/header.jsp" %>
<c:forEach var="ovo" items="${requestScope.o_list}">
<div class="order-container">
        <div class="order-header">
            <h2>주문번호: ${ovo.or_idx}</h2>
            <a href="#">주문 상세보기 &gt;</a>
        </div>
        <div class="order-status">
            <span class="status-value">${ovo.or_status_code}</span>
        </div>
        <c:forEach var="odvo" items="${ovo.od_list}">
        <div class="order-item">
            <img src="${odvo.pd_img}" alt="Product Image">
            <div class="order-item-details">
                <h3>${odvo.pd_name}</h3>
                <p>${odvo.pd_price}원</p>
            </div>
            <div class="order-item-actions">
                ${odvo.od_cnt}개
            </div>	
        </div>
        </c:forEach>
    </div>
</c:forEach>
<%@include file="/jsp/common/footer.jsp" %>
  </body>
</html>