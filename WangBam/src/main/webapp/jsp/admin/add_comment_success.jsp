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
		switch(${requestScope.bo_type}){
		case 0:
			location.href = "admin?type=noticeDetail&bo_idx=" +
	        "${requestScope.bo_idx}" + "&cPage=" + "${requestScope.cPage}" + "&bo_type=0"
			break;
		case 1:
			location.href = "admin?type=questionDetail&bo_idx=" +
	        "${requestScope.bo_idx}" + "&cPage=" + "${requestScope.cPage}" + "&bo_type=1"
			break;
		case 2:
			location.href = "admin?type=reviewDetail&bo_idx=" +
	        "${requestScope.bo_idx}" + "&cPage=" + "${requestScope.cPage}" + "&bo_type=2"
			break;
		}
	   /*  location.href = "admin?type=boardsDetail&bo_idx=" +
	        "${requestScope.bo_idx}" + "&cPage=" + "${requestScope.cPage}" + "&bo_type=" + "${requestScope.bo_type}"; */
	});
	
</script>	
</body>
</html>