<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${sessionScope.user.us_type == '0'}">
	/WangBam/admin
</c:if>
<c:if test="${sessionScope.user.us_type == '1'}">
	/WangBam/
</c:if>