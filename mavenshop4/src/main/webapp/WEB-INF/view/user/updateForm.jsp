<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/view/jspHandler.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>����� ����</title>
</head>
<body>
<%--
	1. AOP ����
	2. User ��ü�� id �Ķ���Ϳ� �ش��ϴ� ������ ����.
--%>
<h2>����� ����</h2>
<!-- modelAttribute="user" : ���� �������� ȣ��� �� user ��ü�� �־�� �Ѵ�. -->
<form:form modelAttribute="user" method="post" action="update.shop">
	<spring:hasBindErrors name="user">
		<font color="red">
			<c:forEach items="${errors.globalErrors}" var="error">
				<spring:message code="${error.code}" />
			</c:forEach>
		</font>
	</spring:hasBindErrors>
	<table>
		<tr height="40px"><td>���̵�</td><td><form:input path="userId" readonly="true"/>&nbsp;<font color="red"><form:errors path="userId" /></font></td></tr>
		<tr height="40px"><td>��й�ȣ</td><td><form:password path="password"/>&nbsp;<font color="red"><form:errors path="password" /></font></td></tr>
		<tr height="40px"><td>�̸�</td><td><form:input path="userName"/>&nbsp;<font color="red"><form:errors path="userName" /></font></td></tr>
		<tr height="40px"><td>��ȭ��ȣ</td><td><form:input path="phoneNo"/>&nbsp;<font color="red"><form:errors path="phoneNo" /></font></td></tr>
		<tr height="40px"><td>�����ȣ</td><td><form:input path="postcode"/>&nbsp;<font color="red"><form:errors path="postcode" /></font></td></tr>
		<tr height="40px"><td>�ּ�</td><td><form:input path="address"/>&nbsp;<font color="red"><form:errors path="address" /></font></td></tr>
		<tr height="40px"><td>�̸���</td><td><form:input path="email"/>&nbsp;<font color="red"><form:errors path="email" /></font></td></tr>
		<tr height="40px"><td>�������</td><td><form:input path="birthDay"/>&nbsp;<font color="red"><form:errors path="birthDay" /></font></td></tr>
		<tr height="40px"><td colspan="2" align="center">
			<input type="submit" value="����">&nbsp;<input type="reset" value="�ʱ�ȭ"></td></tr>
	</table>
</form:form>
</body>
</html>