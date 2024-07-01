<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:forEach var="cvo" items="${requestScope.c_list }">
	<option value="${cvo.ct_idx}">${cvo.ct_name}</option>
</c:forEach>