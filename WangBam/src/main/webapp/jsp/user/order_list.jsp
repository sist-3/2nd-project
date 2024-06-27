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
<div class="pagination">
			<c:set var="page" value="${requestScope.page }"/>
			
			<c:if test="${page.startPage < page.pagePerBlock }">
            	<div class="disable">&lt;</div>
			</c:if>
			<c:if test="${page.startPage >= page.pagePerBlock }">
				<div><a href="?type=orderlist&cPage=${page.nowPage-page.pagePerBlock }">&lt;</a></div>
			</c:if>


			<c:forEach begin="${page.startPage }" end="${page.endPage }" varStatus="vs">
          		<c:if test="${vs.index eq page.nowPage }">
          			<div class="on">${vs.index }</div>
           		</c:if>
				<c:if test="${vs.index ne page.nowPage }">
					<div><a href="?type=orderlist&cPage=${vs.index }">${vs.index }</a></div>
				</c:if>
			</c:forEach>
			
			
			<c:if test="${page.endPage < page.totalPage}">
				<c:if test="${page.nowPage+page.pagePerBlock > page.totalPage }">
					<div><a href="?type=orderlist&cPage=${page.totalPage }">&gt;</a></div>
				</c:if>
				<c:if test="${page.nowPage+page.pagePerBlock <= page.totalPage }">
					<div><a href="?type=orderlist&cPage=${page.nowPage+page.pagePerBlock}">&gt;</a></div>
				</c:if>
			</c:if>
			<c:if test="${page.endPage >= page.totalPage}">
				<div class="disable">&gt;</div>
			</c:if>
  	</div>

<%@include file="/jsp/common/footer.jsp" %>
  </body>
</html>