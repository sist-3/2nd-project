<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>왕밤빵</title>
</head>

<body>

<script>
	
	document.addEventListener("DOMContentLoaded", function () {
	    location.href = "admin?type=boardsDetail&bo_idx=" +
	        "${requestScope.bo_idx}" + "&cPage=" + "${requestScope.cPage}" + "&bo_type=" + "${requestScope.bo_type}";
	});
	
</script>	
</body>
</html>