<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title><decorator:title /></title>
<decorator:head />
</head>
<body>
<table width="95%" border="1" style="border-collapse:collapse;">
	<tr><td colspan="3" align="right">
	<c:if test="${empty sessionScope.loginUser}">
		<a href="${path}/user/loginForm.shop">로그인</a>
	</c:if>
	<c:if test="${!empty sessionScope.loginUser}">
	${sessionScope.loginUser.userName}님
		<a href="${path}/user/logout.shop">로그아웃</a>
	</c:if></td></tr>
	<tr><td align="center" width="15%" valign="top">
		<a href="${path}/user/mypage.shop?id=${loginUser.userId}">마이페이지</a><br>
		<a href="${path}/item/list.shop">상품관리</a><br>
		<a href="${path}/board/list.shop">게시판</a><br>
		<a href="${path}/chat/chat.shop">채팅</a><br></td>
		<td colspan="2" align="left" valign="top"><decorator:body /></td>
	</tr>
	<tr><td colspan="3" align="center">㈜구디아카데미 Since 2016</td></tr>
</table>
</body>
</html>