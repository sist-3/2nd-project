<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/jsp/common/header.jsp" %>
<div class="order-recipient-info">
    <h3>이메일 찾기</h3>
    <c:forEach items="${u_list}" var="uvo">
      <p>${uvo.us_pwd}</p>
    </c:forEach>
</div>
<%@include file="/jsp/common/footer.jsp" %>
</body>
</html>