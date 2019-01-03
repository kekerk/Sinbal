<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>로그인 성공</title>
</head>
<body>
<h2>환영합니다. ${sessionScope.loginUser.userName}님이 로그인 하셨습니다.</h2>
<table border="1" cellspacing="0" cellpadding="0">
	<tr><td>아이디</td><td>${loginUser.userId}</td></tr>
	<tr><td>이름</td><td>${loginUser.userName}</td></tr>
	<tr><td>우편번호</td><td>${loginUser.postcode}</td></tr>
	<tr><td>주소</td><td>${loginUser.address}</td></tr>
	<tr><td>전화번호</td><td>${loginUser.phoneNo}</td></tr>
	<tr><td>이메일</td><td>${loginUser.email}</td></tr>
	<tr><td>생년월일</td>
	<td><fmt:formatDate value="${loginUser.birthDay}" pattern="yyyy년 MM월 dd일" /></td></tr>
</table>
<a href="mypage.shop?id=${loginUser.userId}">mypage</a>
<%--1. 세션 객체 제거
	2. login.shop 페이지 이동 
--%>
<a href="../item/list.shop">상품목록</a>
</body>
</html>