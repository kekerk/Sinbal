<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/view/jspHandler.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�Խù� �� ����</title>
</head>
<body>
<table border="1" style="border-collapse: collapse; width:100%">
	<tr><td colspan="2">Spring �Խ���${board.num} </td></tr>
	<tr><td width="15%">�۾���</td>
		<td width="85%">${board.name}</td></tr>
	<tr><td>����</td>
		<td>${board.subject}</td></tr>
	<tr><td>����</td><td>
	<table width="100%" height="250">
		<tr><td>${board.content}</td></td>
	</table>
	<tr><td>÷������</td><td>
		<c:if test="${!empty board.fileurl}">
			<a href="../file/${board.fileurl}">${board.fileurl}</a>
		</c:if></td></tr>
	<tr><td colspan="2" align="center">
		<a href="reply.shop?num=${board.num}">[�亯]</a>
		<a href="update.shop?num=${board.num}">[����]</a>
		<a href="delete.shop?num=${board.num}">[����]</a>
		<a href="list.shop">[���]</a>
	</td></tr>
</table>
</body>
</html>