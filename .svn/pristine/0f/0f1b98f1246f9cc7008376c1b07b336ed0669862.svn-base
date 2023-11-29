<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>외래무척추동물예측시스템</title>
</head>
<body>
	<c:set var="statusCode" value="${requestScope['javax.servlet.error.status_code']}" />
	<c:set var="requestUri" value="${requestScope['javax.servlet.error.request_uri']}" />
	<c:set var="exceptionType" value="${requestScope['javax.servlet.error.exception_type']}" />
	<c:set var="exception" value="${requestScope['javax.servlet.error.exception']}" />

	<h1>에러 페이지</h1>
	<p>에러코드: ${statusCode}</p>
	<p>요청을 보낸 URI: ${requestUri}</p>
		<c:choose>
			<c:when test="${statusCode eq 403}">
				<p>내용: 이 페이지에 접속 권한이 없습니다.</p>
				<%-- <c:redirect url="/main.do" /> --%>
			</c:when>
			<c:when test="${statusCode eq 404}">
				<p>내용: 잘못된 경로입니다. 올바른 방법으로 접근해주세요.</p>
			</c:when>
			<c:when test="${statusCode eq 500}">
				<p>내용: 서버에 요청이 전송되었으나 서버가 거부하였습니다. 올바른 방법으로 접근해주세요.</p>
				<c:redirect url="/main.do" />
			</c:when>
		</c:choose>
	<c:if test="${not empty exceptionType}">
		<p>Exception Type: ${exceptionType}</p>
	</c:if>
	<c:if test="${not empty exception}">
		<p>Exception Message: ${exception.message}</p>
	</c:if>
	<p>
		<a href="<c:url value='/main.do' />">기본화면으로 돌아가기</a>
	</p>
</body>
</html>