<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/jsp/common/header.jsp" %>
<form action="/WangBam/" method="post" class="form-group" id="findPwdForm">
<h1>비밀번호 찾기</h1>
  <input type="hidden" name="type" value="findPwd">
  <div>
    <label for="username">이름</label>
    <input type="text" id="username" placeholder="이름" name="us_name">
    <span id="username-check" style="display: none;color: red;margin-top: 5px;"></span>
  </div>
  <div>
  	<input type="hidden" id="email-confirm" value="false">
    <label for="email">이메일</label>
    <div class="address-group">
      <input type="email" id="email" placeholder="example@example.com" name="us_email">
      <button type="button" class="btn" id="email-check-btn">인증</button>
    </div>
    <div id="email-check-result" style="margin-top: 16px;"></div>
    <span id="email-check" style="display: none; color: red;margin-top: 5px;"></span>
  </div>
  <div class="buttons">
    <button type="button" id="findPwd" class="findPwd-btn">비밀번호 찾기</button>
    <button type="button" class="cancel-btn" onclick="location.href='/WangBam/?type=login'">취소</button>
  </div>
</form>
<%@include file="/jsp/common/footer.jsp" %>
<script>
var timer;
function emailCheck(email_address){     
	email_regex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/i;
	if(!email_regex.test(email_address)){ 
		return false; 
	}else{
		return true;
	}
}
$('#email-check-btn').on('click', function(){
	
    let email = $('#email').val();
    //에러메세지 초기화
    $('#email-check').css('display', 'none');
    $('#email').css('border-color', '#e2e2e2');

    //유효성검사
    if(email.trim().length == 0){
      $('#email-check').css('display', 'block');
      $('#email-check').text('이메일을 입력하세요');
      $('#email').css('border-color', '#FFA500');
      return;
    }
    if(!emailCheck(email)){
      $('#email-check').css('display', 'block');
      $('#email-check').text('이메일 형식이 올바르지 않습니다');
      $('#email').css('border-color', '#FFA500');
      return;
    }
    clearInterval(timer);
    var cnt = 180;
    $.ajax({  
        	url: '/WangBam/',
        	type: 'POST',
        	data: "type=emailcheck&email="+email,
        }).done(function(data){
        	$('#email-check-result').css('display', 'block');
        	$('#email-check-result').html(data);
                
          timer = setInterval(function(){
            cnt--;
            //분:초 형식으로 변환
            let min = Math.floor(cnt/60);
            let sec = cnt - (60 * min);
            if(sec > 9){
              $('.certificationTime').text(min + ':' + sec + '');
            }else {
              $('.certificationTime').text(min + ':0' + sec + '');
            }
            if(cnt == 0){
              $('.certificationTime').text('00:00');
              $('#email-check-result').text('인증시간이 초과되었습니다.');
              clearInterval(timer);
            }
          }, 1000);
        }).fail(function(){

        });
    
  });
$(document).ready(function(){
  <c:if test="${message != null}">
      alert("${requestScope.message}");
  </c:if>
	$(".findPwd-btn").click(function(){
    //유효성검사
    if($("#username").val() == ""){
      alert("이름을 입력해주세요.");
      $("#username").focus();
      $("#username").val("");
      return;
    }
    if($("#email").val() == ""){
      alert("이메일을 입력해주세요.");
      $("#email").focus();
      $("#email").val("");
      return;
    }
    if($("#email-confirm").val() == "false"){
      alert("인증을 완료해주세요.");
      $("#email-confirm").val("true");
      return;
    }
    $("#findPwdForm").submit()
	});
 
});
</script>
</body>
</html>