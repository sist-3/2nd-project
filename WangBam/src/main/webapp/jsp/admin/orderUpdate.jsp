<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body onload="exe()">
	<form action="admin" method="post">
		<input type="hidden" name="type" value="orderList"/>
		<c:if test="${cPage != null}">
			<input type="hidden" name="cPage" value="${cPage}"/>
		</c:if>
	</form>
<script>
	function exe(){
		document.forms[0].submit();
	}
</script>		
</body>

</html>