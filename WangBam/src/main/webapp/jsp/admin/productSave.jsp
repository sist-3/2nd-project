<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body onload="exe()">
	<form action="admin" name="frm">
		<input type="hidden" name="type" value="productList" />
	</form>
	<script>
		function exe(){
			document.frm.submit();
		}
	</script>
</body>
</html>