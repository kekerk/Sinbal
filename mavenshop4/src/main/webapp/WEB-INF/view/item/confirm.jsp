<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/view/jspHandler.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>��ǰ ���� �� Ȯ��</title>
</head>
<body>
<h2>��ǰ �� ����</h2>
<table>
	<tr><td><img src="../picture/${item.pictureUrl}" width="200" height="250"></td>
		<td align="center"><table>
		<tr><td width="80">��ǰ��</td><td>${item.name}</td></tr>
		<tr><td width="80">����</td><td>${item.price}</td></tr>
		<tr><td width="80">����</td><td>${item.description}</td></tr>
		<tr><td colspan="2"><input type="button" value="����" onclick="location.href='delete.shop?id=${item.id}'">&nbsp;
			<input type="button" value="��ǰ���" onclick="location.href='list.shop'"></td></tr>
</table></td></tr></table>
</body>
</html>