<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/jsp/common/header.jsp" %>
<div id="dialog" title="">
  <h1>이미 계정이 있으신가요?</h1>
  <p>${param.type} 로그인에 계정을 연결하려면<br>왕밤빵 계정으로 로그인하세요.</p>
  <button id="login" class="login-button">
    로그인
  </button>
  <div class="login-footer"><button id="signup">왕밤빵 계정을 보유하고 있지 않습니다.</button></div>
</div>
<form id="form" action="/WangBam/login" method="post">
  <input id="type" type="hidden" name="type" value="signup">
  <input id="o_id" type="hidden" name="o_id" value="${requestScope.o_id}">
  <input id="o_type" type="hidden" name="o_type" value="${requestScope.o_type}">
</form>
<%@include file="/jsp/common/footer.jsp" %>
</body>
  <script>
    $(function() {
      $("#dialog").dialog({
        autoOpen: true,
        modal: true,
        width: 400,
        resizable: false,
        draggable: false,
        buttons: []
      });
      
      $("#login").click(function() {
        $("#type").val("login");
        $("#form").submit();
      });
      $("#signup").click(function() {
        $("#type").val("signup");
        $("#form").submit();
      });
    });
  </script>
</html>