<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/view/jspHandler.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>��ǰ �� ����</title>
</head>
<body>
<h2>��ǰ �� ����</h2>
<table>
	<tr><td><img src="../picture/${item.pictureUrl}" width="200" height="250"></td>
		<td align="center"><table>
		<tr><td width="80">��ǰ��</td><td>${item.name}</td></tr>
		<tr><td width="80">����</td><td>${item.price}</td></tr>
		<tr><td width="80">����</td><td>${item.description}</td></tr>
		<tr><td colspan="2" align="center">
		<%--���� URL : /mavenshop3/item/detail.shop
			../cart/cartAdd.shop : /mavenshop3/cart/cartAdd.shop
		--%>
		<form action="../cart/cartAdd.shop">
			<input type="hidden" name="id" value="${item.id}">
			<table>
				<tr><td><select name="quantity">
				<c:forEach begin="1" end="10" var="i"><option>${i}</option></c:forEach></select></td>
					<td><input type="submit" value="��ٱ���">
						<input type="button" value="��ǰ���" onclick="location.href='list.shop'"></td></tr>
			</table>
		</form>
		</td></tr>
		</table></td>
	</tr>
</table>
</body>
</html>