<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/view/jspHandler.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>사용자 수정</title>
</head>
<body>
<%--
	1. AOP 설정
	2. User 객체에 id 파라미터에 해당하는 고객정보 저장.
--%>
<h2>사용자 수정</h2>
<!-- modelAttribute="user" : 현재 페이지가 호출될 때 user 객체가 있어야 한다. -->
<form:form modelAttribute="user" method="post" action="update.shop">
	<spring:hasBindErrors name="user">
		<font color="red">
			<c:forEach items="${errors.globalErrors}" var="error">
				<spring:message code="${error.code}" />
			</c:forEach>
		</font>
	</spring:hasBindErrors>
	<table>
		<tr height="40px"><td>아이디</td><td><form:input path="userId" readonly="true"/>&nbsp;<font color="red"><form:errors path="userId" /></font></td></tr>
		<tr height="40px"><td>비밀번호</td><td><form:password path="password"/>&nbsp;<font color="red"><form:errors path="password" /></font></td></tr>
		<tr height="40px"><td>이름</td><td><form:input path="userName"/>&nbsp;<font color="red"><form:errors path="userName" /></font></td></tr>
		<tr height="40px"><td>전화번호</td><td><form:input path="phoneNo"/>&nbsp;<font color="red"><form:errors path="phoneNo" /></font></td></tr>
		<tr height="40px"><td>우편번호</td><td><form:input path="postcode"/>&nbsp;<font color="red"><form:errors path="postcode" /></font></td></tr>
		<tr height="40px"><td>주소</td><td><form:input path="address"/>&nbsp;<font color="red"><form:errors path="address" /></font></td></tr>
		<tr height="40px"><td>이메일</td><td><form:input path="email"/>&nbsp;<font color="red"><form:errors path="email" /></font></td></tr>
		<tr height="40px"><td>생년월일</td><td><form:input path="birthDay"/>&nbsp;<font color="red"><form:errors path="birthDay" /></font></td></tr>
		<tr height="40px"><td colspan="2" align="center">
			<input type="submit" value="수정">&nbsp;<input type="reset" value="초기화"></td></tr>
	</table>
</form:form>
</body>
</html>