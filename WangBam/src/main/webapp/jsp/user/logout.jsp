<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:redirect url="https://kauth.kakao.com/oauth/logout?client_id=${requestScope.client_id}&logout_redirect_uri=${requestScope.logout_redirect_uri}" />