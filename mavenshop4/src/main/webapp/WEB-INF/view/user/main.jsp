<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="EUC-KR">
<title>회원 관리 프로그램</title>
</head>
<body class="body">
<%-- logout.me : session를 종료. loginForm.jsp로 페이지 이동--%>
<h3>${sessionScope.login} 적셔~</h3>
<h3><a href = "logout.me">로그아웃</a></h3>
<h3><a href="info.me?id=${sessionScope.login}">회원정보보기</a></h3>
<c:if test="${sessionScope.login == 'admin'}">
 <h3><a href="list.me">회원 목록 보기</a></h3>
</c:if>
</body>
</html>