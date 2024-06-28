<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/jsp/common/header.jsp"%>
<div>
        <h1 style="text-align: center;">회원 정보 수정</h1>
        <form id="updateForm" class="form-group" action="/WangBam/" method="post">
            <input type="hidden" id="type" name="type" value="my">
            <div>
                <label for="username">아이디</label>
                <input type="text" id="us_name" value="${sessionScope.user.us_email}" readonly>
            </div>
            <div>
                <label for="username">아이디</label>
                <input type="text" id="us_name" value="${sessionScope.user.us_email}" readonly>
            </div>
            <div>
                <label for="password">비밀번호</label>
                <input type="password" id="us_pwd" name="us_pwd" placeholder="영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 10자~16자">
            </div>
            <div>
                <label for="confirm-password">비밀번호 확인</label>
                <input type="password" id="confirm-password" placeholder="비밀번호 확인">
            </div>
            <div>
                <label for="nickname">닉네임</label>
                <input type="text" id="us_nickname" name="us_nickname" value="${sessionScope.user.us_nickname}" placeholder="최대 10자 (이모티콘 제외)">
            </div>
            <div>
                <label for="address">주소</label>
                <div class="address-group">
                    <input type="text" id="postcode" readonly placeholder="우편번호" name="postcode" value="${requestScope.addrVo.ad_postal_code}">
                    <button type="button" class="btn" id="address-btn">검색</button>
                </div>
                <input type="text" id="address" readonly placeholder="기본주소" name="address" value="${requestScope.addrVo.ad_addr}">
                <input type="text" id="extra-address" placeholder="나머지주소" name="extraAddress" value="${requestScope.addrVo.ad_addr_detail}">
            </div>
            <div>
                <label for="phone">휴대폰번호</label>
                <div class="phone-group">
                    <select id="phone-prefix">
                        <option value="010">010</option>
                    </select>
                    <input type="text" id="phone-middle" value="${fn:substring(sessionScope.user.us_tel, 3, 7)}" placeholder="1588">
                    <input type="text" id="phone-last" value="${fn:substring(sessionScope.user.us_tel, 7, 11)}" placeholder="2222">
                </div>
                <input type="hidden" id="us_tel" value="${sessionScope.user.us_tel}">
            </div>
            <div class="buttons">
                <button type="button" class="btn-submit">정보변경수정</button>
                <button type="button" class="btn-cancel" onclick="location.href='/WangBam/'">취소</button>
                <div class="out-buttons">
                    <label type="text" id="out-btn" class="out-btn">회원탈퇴</label>
                </div>
            </div>
        </form>
    </div>
	<%@include file="/jsp/common/footer.jsp"%>
    <script>
    function passwordCheck(password){
        password_regex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{10,}$/;
        if(password_regex.test(password)){
            return true;
        }else{
            return false;
        }
    }
    $(function () {
        <c:if test="${requestScope.msg != null}">
            alert('${requestScope.msg}');
        </c:if>
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
            $('.btn-submit').on('click', function(){
                //유효성검사
                if($('#us_nickname').val() === ''){
                    alert('유효하지않은 닉네임입니다.');
                    $('#us_nickname').val(${sessionScope.user.us_nickname});
                    $('#nickname').focus();
                    return;
                }
                if($('#us_nickname').val().length > 10){
                    alert('닉네임은 최대 10자까지 가능합니다.');
                    $('#us_nickname').val(${sessionScope.user.us_nickname});
                    $('#nickname').focus();
                    return;
                }
                if(!passwordCheck($('#us_pwd').val())&&$('#us_pwd').val() !== ''){
                    alert('비밀번호는 영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 10자~16자로 입력해주세요.');
                    return;
                }
                if($('#us_pwd').val() !== $('#confirm-password').val()&&$('#us_pwd').val() !== ''){
                    alert('비밀번호가 일치하지 않습니다.');
                    return;
                } 
                if($('#phone-middle').val().length !== 4){
                    alert('올바른 전화번호를 입력하세요');
                    $('#phone-middle').val(${fn:substring(sessionScope.user.us_tel, 3, 7)});
                    $('#phone-middle').focus();
                    return;
                }
                if($('#phone-last').val().length !== 4){
                    alert('올바른 전화번호를 입력하세요');
                    $('#phone-last').val(${fn:substring(sessionScope.user.us_tel, 7, 11)});
                    $('#phone-last').focus();
                    return;
                }
                
                $('#us_tel').val($('#phone-prefix').val() + $('#phone-middle').val() + $('#phone-last').val());
                $("#updateForm").submit();
            });
            $('#out-btn').on('click', function(){
                alert('회원탈퇴는 아직 구현되지 않았습니다.');
            });
        });
    </script>
</body>
</html>