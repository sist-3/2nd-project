<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/jsp/common/header.jsp" %>
<form class="form-group">
<h1>회원 가입</h1>
  <div>
    <label for="username">이름</label>
    <input type="text" id="username" placeholder="이름">
    <span id="username-check" style="display: none;color: red;margin-top: 5px;"></span>
  </div>
  <div>
    <label for="email">이메일</label>
    <div class="address-group">
      <input type="email" id="email" placeholder="example@example.com">
      <button type="button" class="btn" id="email-check-btn">인증</button>
    </div>
    <div id="email-check-group" class="address-group" style="display: none;">
        <label for="email-check-result">인증 코드</label>
        <input type="text" id="email-check-result">
      </div>
    <span id="email-check" style="display: none; color: red;margin-top: 5px;"></span>
  </div>
  <div>
    <label for="password">비밀번호</label>
    <input type="password" id="password" placeholder="영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 10자~16자">
    <span id="password-check" style="display: none; color: red;margin-top: 5px;"></span>
  </div>
  <div>
    <label for="confirm-password">비밀번호 확인</label>
    <input type="password" id="confirm-password" placeholder="비밀번호 확인">
    <span id="confirm-password-check" style="display: none; color: red;margin-top: 5px;"></span>
  </div>
  <div>
    <label for="nickname">닉네임</label>
    <input type="text" id="nickname" placeholder="최대 10자 (이모티콘 제외)">
    <span id="nickname-check" style="display: none; color: red;margin-top: 5px;"></span>
  </div>
  <div>
    <label for="address">주소</label>
    <div class="address-group">
      <input type="text" id="postcode" placeholder="우편번호">
      <button type="button" class="btn">검색</button>
    </div>
    <input type="text" placeholder="기본주소">
    <input type="text" placeholder="나머지주소">
  </div>
  <div>
    <label for="username">전화번호</label>
    <div class="phone-group">
      <select id="phone">
        <option value="010">010</option>
        <option value="011">011</option>
        <option value="017">017</option>
      </select>
      <input type="text" id="phone-middle" placeholder="1588">
      <input type="text" id="phone-last" placeholder="2222">
    </div>
    <span id="phone-check" style="display: none; color: red;margin-top: 5px;"></span>
  </div>
  <div class="buttons">
    <button type="button" id="signUp" class="btn submit">가입하기</button>
    <button type="button" class="btn cancel">취소</button>
  </div>
</form>
<script>
function emailCheck(email_address){     
	email_regex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/i;
	if(!email_regex.test(email_address)){ 
		return false; 
	}else{
		return true;
	}
}

$(document).ready(function(){
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
    $.ajax({  
        	url: '/WangBam/',
        	type: 'POST',
        	data: {
            type: 'emailCheck',
            email: email
          }
        }).done(function(data){
            
        }).fail(function(){
            
        });
    
  });

  $('#signUp').on('click', function(){
    //form요소들 가져오기
    let username = $('#username').val();
    let password = $('#password').val();
    let confirmPassword = $('#confirm-password').val();
    let nickname = $('#nickname').val();
    let address = $('#address').val();
    let phone = $('#phone').val();
    let email = $('#email').val();

    //에러메세지 초기화
    $('#username-check').css('display', 'none');
    $('#password-check').css('display', 'none');
    $('#confirm-password-check').css('display', 'none');
    $('#nickname-check').css('display', 'none');
    $('#phone-check').css('display', 'none');
    $('#email-check').css('display', 'none');

    $('#username').css('border-color', '#e2e2e2');
    $('#password').css('border-color', '#e2e2e2');
    $('#confirm-password').css('border-color', '#e2e2e2');
    $('#nickname').css('border-color', '#e2e2e2');
    $('#phone').css('border-color', '#e2e2e2');
    $('#email').css('border-color', '#e2e2e2');

    //유효성 검사
    if (username.trim().length == 0) {
      $('#username-check').css('display', 'block');
      $('#username-check').text('이름를 입력하세요');
      $('#username').css('border-color', '#FFA500');
      return;
    }
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
    if (password.trim().length == 0) {
      $('#password-check').css('display', 'block');
      $('#password-check').text('비밀번호를 입력하세요');
      $('#password').css('border-color', '#FFA500');
      return;
    }
    if (confirmPassword.trim().length == 0) {
      $('#confirm-password-check').css('display', 'block');
      $('#confirm-password-check').text('비밀번호를 확인하세요');
      $('#confirm-password').css('border-color', '#FFA500');
      return;
    }
    if (password != confirmPassword) {
      $('#confirm-password-check').css('display', 'block');
      $('#confirm-password-check').text('비밀번호가 일치하지 않습니다');
      $('#confirm-password').css('border-color', '#FFA500');
      return;
    }
    if (nickname.trim().length == 0) {
      $('#nickname-check').css('display', 'block');
      $('#nickname-check').text('닉네임을 입력하세요');
      $('#nickname').css('border-color', '#FFA500');
      return;
    }
  });
});
</script>
<%@include file="/jsp/common/footer.jsp" %>