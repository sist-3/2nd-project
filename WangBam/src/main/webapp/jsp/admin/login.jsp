<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인 페이지</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .login-container {
            background-color: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        .login-container h2 {
            margin-bottom: 1.5rem;
        }
        .login-container form {
            display: flex;
            flex-direction: column;
        }
        .login-container input[type="email"],
        .login-container input[type="password"] {
            padding: 0.5rem;
            margin-bottom: 1rem;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .login-container button {
            padding: 0.5rem;
            border: none;
            border-radius: 5px;
            background-color: #25496f;
            color: white;
            font-size: 1rem;
        }
        .login-container button:hover {
            background-color: #0056b3;
        }
        .login-container .signup-link {
            margin-top: 1rem;
            color: #007BFF;
            text-decoration: none;
        }
        .login-container .signup-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="login-container">
    	<%
    		Object obj = request.getAttribute("msg");
			if(obj != null) {
    	%>
	    		<script>
	    			alert('${msg}');
	    		</script>
				
			<% 
			}
			%>
        <h2>로그인</h2>
        <form action="admin?type=login" method="post">
            <input type="email" name="us_id" placeholder="이메일" required>
            <input type="password" name="us_pw" placeholder="비밀번호" required>
            <button type="button" onclick="login(this.form)">로그인</button>
        </form>
    </div>
    <script>
    	function login(form) {
			let id = form.us_id.value;
			let pw = form.us_pw.value;
			
			console.log(id.length);
			if(pw.length < 1) {
				if(id.length < 1) {
					alert("아이디를 입력해주세요.");
					return ;
				}
				alert("비밀번호를 입력해주세요.");
				return ;
			}
			form.submit();
		}
    </script>
</body>
</html>
