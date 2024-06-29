<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>왕밤빵</title>
</head>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-color: #f7f7f7;
        }
        #f_win {
            background: white;
            padding: 20px 30px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        #f_win div {
            font-size: 1.2em;
            font-weight: bold;
            color: #333;
        }
        .btn {
            margin-top: 20px;
        }
        .btn a {
            text-decoration: none;
            color: white;
            background-color: #673a11;
            padding: 10px 20px;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        .btn a:hover {
            background-color: #8b5228;
        }
    </style>
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
		location.href="?type=review";
	}
</script>	
</body>
</html>