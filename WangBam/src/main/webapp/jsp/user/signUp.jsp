<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@include file="/jsp/common/header.jsp" %>
<form action="/WangBam/" method="post" class="form-group" id="signUpForm">
<h1>회원 가입</h1>
  <input type="hidden" name="type" value="signup">
  <c:if test="${param.o_id != null}">
    <input type="hidden" name="o_id" value="${param.o_id}">
    <input type="hidden" name="o_type" value="${param.o_type}">
  </c:if>
  <div>
    <label for="username">이름</label>
    <input type="text" id="username" placeholder="이름" name="us_name">
    <span id="username-check" style="display: none;color: red;margin-top: 5px;"></span>
  </div>
  <input type="hidden" id="email-confirm" value="false">
  <div>
    <label for="email">이메일</label>
    <div class="address-group">
      <input type="email" id="email" placeholder="example@example.com" name="us_email">
      <button type="button" class="btn" id="email-check-btn">인증</button>
    </div>
    <div id="email-check-result" style="margin-top: 16px;"></div>
    <span id="email-check" style="display: none; color: red;margin-top: 5px;"></span>
  </div>
  <div>
    <label for="password">비밀번호</label>
    <input type="password" id="password" placeholder="영문 대소문자/숫자/특수문자 하나 이상 포함, 10자~16자" name="us_pwd">
    <span id="password-check" style="display: none; color: red;margin-top: 5px;"></span>
  </div>
  <div>
    <label for="confirm-password">비밀번호 확인</label>
    <input type="password" id="confirm-password" placeholder="비밀번호 확인">
    <span id="confirm-password-check" style="display: none; color: red;margin-top: 5px;"></span>
  </div>
  <div>
    <label for="nickname">닉네임</label>
    <input type="text" id="nickname" placeholder="최대 10자 (이모티콘 제외)" name="us_nickname">
    <span id="nickname-check" style="display: none; color: red;margin-top: 5px;"></span>
  </div>
  <div>
    <label for="address">주소</label>
    <div class="address-group">
      <input type="text" id="postcode" readonly placeholder="우편번호" name="postcode">
      <button type="button" class="btn" id="address-btn">검색</button>
    </div>
    <input type="text" id="address" readonly placeholder="기본주소" name="address">
    <input type="text" id="extra-address" placeholder="나머지주소" name="extraAddress">
  </div>
  <div>
    <label for="username">전화번호</label>
    <div class="phone-group">
      <select id="phone" name="us_tel">
        <option value="010">010</option>
        <option value="011">011</option>
        <option value="017">017</option>
      </select>
      <input type="text" id="phone-middle" placeholder="1588" name="us_tel" maxlength="4">
      <input type="text" id="phone-last" placeholder="2222" name="us_tel" maxlength="4">
    </div>
    <span id="phone-check" style="display: none; color: red;margin-top: 5px;"></span>
  </div>
  <div class="buttons">
    <button type="button" id="signUp" class="btn submit">가입하기</button>
    <button type="button" class="btn cancel">취소</button>
  </div>
</form>
<%@include file="/jsp/common/footer.jsp" %>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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

function passwordCheck(password){
  password_regex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{10,}$/;
  if(password_regex.test(password)){
    return true;
  }else{
    return false;
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
    clearInterval(timer);
    var cnt = 180;
    $.ajax({  
        	url: '/WangBam/',
        	type: 'POST',
        	data: {type:'emailcheck',
        			email:email,
        			sign:'sign',
        	}
        }).done(function(data){
          if(data == 2){
            $('#email-check-result').css('display', 'block');
            $('#email-check-result').html('이메일이 이미 존재합니다');
            $('#email-check-result').css('color', 'red');
            $('#email-check-result').css('margin-top', '5px');
            $('#email-check-result').css('font-size', '12px');
            $('#email-check-result').css('font-weight', 'bold');
            return;
          }
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

  $('#address-btn').on('click', function(){
    //에러메세지 초기화
    $('#address-check').css('display', 'none');
    $('#address').css('border-color', '#e2e2e2');
	  new daum.Postcode({
          oncomplete: function(data) {
              // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

              // 각 주소의 노출 규칙에 따라 주소를 조합한다.
              // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
              var addr = ''; // 주소 변수
              var extraAddr = ''; // 참고항목 변수

              //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
              if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                  addr = data.roadAddress;
              } else { // 사용자가 지번 주소를 선택했을 경우(J)
                  addr = data.jibunAddress;
              }

              // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
              if(data.userSelectedType === 'R'){
                  // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                  // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                  if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                      extraAddr += data.bname;
                  }
                  // 건물명이 있고, 공동주택일 경우 추가한다.
                  if(data.buildingName !== '' && data.apartment === 'Y'){
                      extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                  }
                  // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                  if(extraAddr !== ''){
                      extraAddr = ' (' + extraAddr + ')';
                  } 
              }

              // 우편번호와 주소 정보를 해당 필드에 넣는다.
              document.getElementById('postcode').value = data.zonecode;
              document.getElementById("address").value = addr+extraAddr;
              // 커서를 상세주소 필드로 이동한다.
              document.getElementById("extra-address").focus();
          }
      }).open();
  });

  $('input#phone-middle').on('propertychange change keyup paste input', function(){
    if($(this).val().match(/[^0-9]/)){
      $(this).val($(this).val().replace(/[^0-9]/g, ''));
                return;
            }
        });
        $('#phone-last').on('propertychange change keyup paste input', function(){
            if($(this).val().match(/[^0-9]/)){
                $(this).val($(this).val().replace(/[^0-9]/g, ''));
                return;
            }
        });

  $('#signUp').on('click', function(){
    //form요소들 가져오기
    let username = $('#username').val();
    let password = $('#password').val();
    let confirmPassword = $('#confirm-password').val();
    let nickname = $('#nickname').val();
    let postcode = $('#postcode').val();
    let address = $('#address').val();
    let phone = $('#phone').val();
    let email = $('#email').val();
    let extraAddress = $('#extra-address').val();

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
      $('#username').val('');
      $('#username').focus();
      return;
    }
    if(email.trim().length == 0){
      $('#email-check').css('display', 'block');
      $('#email-check').text('이메일을 입력하세요');
      $('#email').css('border-color', '#FFA500');
      $('#email').val('');
      $('#email').focus();
      return;
    }
    if(!emailCheck(email)){
      $('#email-check').css('display', 'block');
      $('#email-check').text('이메일 형식이 올바르지 않습니다');
      $('#email').css('border-color', '#FFA500');
      $('#email').val('');
      $('#email').focus();
      return;
    }
    if($('#email-confirm').val()=='false'){
      $('#email-check').css('display', 'block');
      $('#email-check').text('인증을 완료해주세요');
      $('#email').css('border-color', '#FFA500');
      $('#email').val('');
      $('#email').focus();
      return;
    }
    if (password.trim().length == 0) {
      $('#password-check').css('display', 'block');
      $('#password-check').text('비밀번호를 입력하세요');
      $('#password').css('border-color', '#FFA500');
      $('#password').val('');
      $('#password').focus();
      return;
    }
    if(!passwordCheck(password)){
      $('#password-check').css('display', 'block');
      $('#password-check').text('비밀번호 형식이 올바르지 않습니다');
      $('#password').css('border-color', '#FFA500');
      $('#password').val('');
      $('#password').focus();
      return;
    }
    
    if (confirmPassword.trim().length == 0) {
      $('#confirm-password-check').css('display', 'block');
      $('#confirm-password-check').text('비밀번호를 확인하세요');
      $('#confirm-password').css('border-color', '#FFA500');
      $('#confirm-password').val('');
      $('#confirm-password').focus();
      return;
    }
    if (password != confirmPassword) {
      $('#confirm-password-check').css('display', 'block');
      $('#confirm-password-check').text('비밀번호가 일치하지 않습니다');
      $('#confirm-password').css('border-color', '#FFA500');
      $('#confirm-password').val('');
      $('#confirm-password').focus();
      return;
    }
    if (nickname.trim().length == 0) {
      $('#nickname-check').css('display', 'block');
      $('#nickname-check').text('닉네임을 입력하세요');
      $('#nickname').css('border-color', '#FFA500');
      $('#nickname').val('');
      $('#nickname').focus();
      return;
    }
    if(nickname.trim().length > 10){
      $('#nickname-check').css('display', 'block');
      $('#nickname-check').text('닉네임은 최대 10자입니다');
      $('#nickname').css('border-color', '#FFA500');
      $('#nickname').val('');
      $('#nickname').focus();
      return;
    }
    if($('#phone-middle').val().length !== 4 || $('#phone-last').val().length !== 4){
      $('#phone-check').css('display', 'block');
      $('#phone-check').text('올바른 전화번호를 입력하세요');
      $('#phone-middle').css('border-color', '#FFA500');
      $('#phone-last').css('border-color', '#FFA500');
      $('#phone-middle').val('');
      $('#phone-last').val('');
      $('#phone-middle').focus();
      return;
    }
    if($('#phone-last').val().length !== 4){
      $('#phone-check').css('display', 'block');
      $('#phone-check').text('올바른 전화번호를 입력하세요');
      $('#phone-last').css('border-color', '#FFA500');
      $('#phone-last').val('');
      $('#phone-last').focus();
      return;
    }

    if(postcode.trim().length == 0){
      $('#postcode-check').css('display', 'block');
      $('#postcode-check').text('우편번호를 입력하세요');
      $('#address').css('border-color', '#FFA500');
      return;
    }
    if(address.trim().length == 0){
      $('#address-check').css('display', 'block');
      $('#address-check').text('주소를 입력하세요');
      $('#address').css('border-color', '#FFA500');
      return;
    }
     $.ajax({
      url: '/WangBam/',
      type: 'POST',
      data: {
        type: 'signup',
        us_name: username,
        us_email: email,
        us_pwd: password,
        us_nickname: nickname,
        us_tel: $('#phone').val() + $('#phone-middle').val() + $('#phone-last').val(),
        postcode: postcode,
        address: address,
        extraAddress: extraAddress,
        <c:if test="${param.o_id != null}">
          o_id: ${param.o_id},
          o_type: ${param.type}
        </c:if>
      }
     }).done(function(data){
      if(data==1){
        location.href = '/WangBam/';
      }else if(data==2){
        alert('이미 가입된 이메일입니다.');
        $('#email-check').css('display', 'block');
        $('#email-check').text('이미 가입된 이메일입니다.');
        $('#email').css('border-color', '#FFA500');
        $('#email').val('');
        $('#email-check-result').text('');
        $('#email').focus();
      }else if(data==3){
        alert('이미 존재하는 닉네임입니다.');
        $('#nickname-check').css('display', 'block');
        $('#nickname-check').text('이미 존재하는 닉네임입니다.');
        $('#nickname').css('border-color', '#FFA500');
        $('#nickname').focus();
      }
     });
  });
});
</script>
</body>
</html>