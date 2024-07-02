<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@include file="/jsp/common/header.jsp" %>
<div class="login-container">
    <h1>LOGIN</h1>
    <p>WELCOME BACK</p>
    <form class="login-form" action="/WangBam/" method="post">
    	<input type="hidden" name="type" value="login">
        <input type="text" name="id" placeholder="아이디" required>
        <input type="password" name="pw" placeholder="비밀번호" required>

        <button type="button" onclick="login(this.form)" >로그인</button>
    </form>
    <div class="login-links">
        <a href="/WangBam/?type=findEmail">아이디찾기</a> 
        <a href="/WangBam/?type=findPwd">비밀번호찾기</a> 
        <a href="/WangBam/?type=signup">회원가입</a>
    </div>
</div>
<%@include file="/jsp/common/footer.jsp" %>
<script>
    function login(frm){
        let us_id = $(frm).find("input[name='id']").val();
        let us_pw = $(frm).find("input[name='pw']").val();
        if(us_id.trim().length == 0){
            alert("아이디를 입력하세요");
            $("#id").focus();
            $("#id").val("");
            return;
        }
        if(us_pw.trim().length == 0){
            alert("비밀번호를 입력하세요");
            $("#pw").focus();
            $("#pw").val("");
            return;
        }
        $.ajax({  
        	url: '/WangBam/',
        	type: 'POST',
        	data: "type=login&us_id="+us_id+"&us_pw="+us_pw
        }).done(function(data){
            if(data==0){
            	alert("아이디 또는 비밀번호가 일치하지 않습니다.");
            }else{
                if(${requestScope.oldUrl!= null && requestScope.oldUrl!='http://localhost:8080/WangBam/?type=login'}){
                    location.href='${requestScope.oldUrl}';	
                }else{
                    location.href='/WangBam/';
                }
            }
        }).fail(function(){
            
        });

    }
</script>
</body>
</html>