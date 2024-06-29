<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="f_name" value="${requestScope.f_name}" />

<c:if test="${not empty f_name}">
{
    "img_url": "${pageContext.request.contextPath}/img/${f_name}"
}
</c:if>
