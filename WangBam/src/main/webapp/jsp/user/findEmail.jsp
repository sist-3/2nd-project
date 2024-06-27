<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/jsp/common/header.jsp" %>
<form action="/WangBam/" method="post" class="form-group" id="findEmailForm">
<h1>아이디 찾기</h1>
  <input type="hidden" name="type" value="findEmail">
  <div>
    <label for="username">이름</label>
    <input type="text" id="username" placeholder="이름" name="us_name">
    <span id="username-check" style="display: none;color: red;margin-top: 5px;"></span>
  </div>
  <div>
    <label for="username">전화번호</label>
    <div class="phone-group">
      <select id="phone" name="us_tel">
        <option value="010">010</option>
        <option value="011">011</option>
        <option value="017">017</option>
      </select>
      <input type="text" id="phone-middle" placeholder="1588" name="us_tel">
      <input type="text" id="phone-last" placeholder="2222" name="us_tel">
    </div>
    <span id="phone-check" style="display: none; color: red;margin-top: 5px;"></span>
  </div>
  <div class="buttons">
    <button type="button" id="findEmail" class="findEmail-btn">아이디 찾기</button>
    <button type="button" class="cancel-btn" onclick="location.href='/WangBam/?type=login'">취소</button>
  </div>
</form>
<%@include file="/jsp/common/footer.jsp" %>
<script>
$(document).ready(function(){
  <c:if test="${message != null}">
      alert("${requestScope.message}");
  </c:if>
	$(".findEmail-btn").click(function(){
    //유효성검사
    if($("#username").val() == ""){
      alert("이름을 입력해주세요.");
      $("#username").focus();
      $("#username").val("");
      return;
    }
    if($("#phone-middle").val() == ""){
      alert("전화번호를 입력해주세요.");
      $("#phone-middle").focus();
      $("#phone-middle").val("");
      return;
    }
    if($("#phone-last").val() == ""){
      alert("전화번호를 입력해주세요.");
      $("#phone-last").focus();
      $("#phone-last").val("");
      return;
    }
		$("#findEmailForm").submit();
	});
});
</script>
</body>
</html>