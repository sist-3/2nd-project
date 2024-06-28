<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div id="f_win">
		<form name="frm">
			<div>
				저장 완료!
			</div>
			<br/>
			<p class="btn">
				<a href="javascript:closeWin()">
					닫 기
				</a>
			</p>
		</form>
	</div>
<script>
	function closeWin(){
		location.href="admin?type=noticeList";
	}
</script>	
</body>
</html>