<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<label for="email-code">인증코드</label> <span class="certificationTime" style="margin-left: 10px; color: red;">03:00</span>
<div id="email-confirm-group" class="address-group">
   <input type="text" id="email-code">
   <button type="button" class="btn" id="email-confirm-btn" onclick="confirm()">확인</button>
</div>
<script>
function confirm() {
		let email_code = $('#email-code').val();
	    if(email_code=="${requestScope.code}"){
	      $('#email-confirm').val('true');
	      $('#email-check-result').text('인증성공');
	      $('#email-check-result').css('color', 'green');
	      $('#email-check').css('display', 'none');
		  clearInterval(timer);
	    }else{
	      $('#email-confirm').val('false');
	      $('#email-check').text('인증번호가 틀렸습니다.');
	      $('#email-check').css('display', 'block');
	      $('#email-check').css('color', 'red');
	    }
	}
</script>