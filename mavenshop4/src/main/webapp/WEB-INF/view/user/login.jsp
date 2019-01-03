<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�α��� ȭ��</title>
</head>
<body>
<%--/mavenshop3/user/loginForm.shop ��û�� login.jsp�� ȭ�鿡 ����ϱ�
	/mavenshop3/user/login.shop ��û�� login.jsp�� ��ȿ�� ���� ȭ�� ���		 
--%>
<form:form modelAttribute="user" methos="post" action="login.shop">
	<input type="hidden" name="userName" value="��ȿ�� ������ ȸ���ϱ� ���� �ǹ̾��� �̸�">
	<spring:hasBindErrors name="user">
		<font color="red">
			<c:forEach items="${errors.globalErrors}" var="error">
				<spring:message code="${error.code}" />
			</c:forEach>
		</font>
	</spring:hasBindErrors>
	<h2>�α���</h2>&nbsp;<a href="../item/list.shop">��ǰ����Ʈ</a>
	<table>
		<tr height="40px"><td>���̵�</td><td><form:input path="userId"/>&nbsp;
			<font color="red"><form:errors path="userId" /></font></td></tr>
		<tr height="40px"><td>��й�ȣ</td><td><form:password path="password"/>&nbsp;
			<font color="red"><form:errors path="password" /></font></td></tr>
		<tr height="40px"><td colspan="2" align="center">
			<input type="submit" value="�α���">&nbsp;
			<input type="button" value="ȸ������" onclick="location.href='userEntry.shop'"></td></tr>
	</table>
</form:form>
</body>
</html>