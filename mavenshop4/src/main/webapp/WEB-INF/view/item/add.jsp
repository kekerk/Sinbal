<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/view/jspHandler.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>��ǰ ��� ȭ��</title>
</head>
<body>
<form:form modelAttribute="item" action="register.shop" enctype="multipart/form-data">
<h2>��ǰ ��� ȭ��</h2>
<table>
	<tr><td>��ǰ��</td>
		<td><form:input path="name" maxlenght="20"/></td>
		<td><font color="red"><form:errors path="name" /></font></td>
	</tr>
	<tr><td>����</td>
		<td><form:input path="price" maxlenght="6"/></td>
		<td><font color="red"><form:errors path="price" /></font></td>
	</tr>
	<tr><td>��ǰ�̹���</td>
		<td colspan="2"><input type="file" name="picture"></td>
	</tr>
	<tr><td>��ǰ����</td>
		<td><form:textarea path="description" cols="21" rows="5" /></td>
		<td><font color="red"><form:errors path="description" /></font></td>
	</tr>
	<tr><td colspan="3"><input type="submit" value="���">&nbsp;
		<input type="button" value="��ǰ���" onclick="location.href='list.shop'"></td></tr>
</table>
</form:form>
</body>
</html>