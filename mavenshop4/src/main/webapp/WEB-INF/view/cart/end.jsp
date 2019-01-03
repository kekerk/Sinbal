<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/view/jspHandler.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�ֹ� Ȯ�� ��ǰ</title>
<style type="text/css">
	table{width:90%; border-collapse:collapse}
	th,td{border:3px solid #bcbcbc; text-align:center; padding:8px}
	th{background-color:#4CAF50; color:white; text-align:center}
	td.title{background-color:#e2e2e2; color:purple}
</style>
</head>
<body>
<h2>${loginUser.userName}���� �ֹ��Ͻ� ���� �Դϴ�.</h2>
<h2>����� ����</h2>
<table>
	<tr><td width="30%" class="title">������ ID</td>
	<td width="70%">${loginUser.userId}</td></tr>
	<tr><td width="30%" class="title">�̸�</td>
	<td width="70%">${loginUser.userName}</td></tr>
	<tr><td width="30%" class="title">�����ȣ</td>
	<td width="70%">${loginUser.postcode}</td></tr>
	<tr><td width="30%" class="title">�ּ�</td>
	<td width="70%">${loginUser.address}</td></tr>
	<tr><td width="30%" class="title">��ȭ��ȣ</td>
	<td width="70%">${loginUser.phoneNo}</td></tr>
	<tr><td width="30%" class="title">�̸���</td>
	<td width="70%">${loginUser.email}</td></tr>
</table><br><br>
<h2>�ֹ� �Ϸ� ��ǰ ���</h2>
<table>
	<tr><td>��ǰ��</td><td>��ǰ����</td><td>����</td><td>�ѱݾ�</td></tr>
	<c:forEach items="${sale.itemList}" var="saleItem">
		<tr><td>${saleItem.item.name}</td><td><fmt:formatNumber value="${saleItem.item.price}" pattern="#,###" />��</td>
		<td>${saleItem.quantity}</td><td><fmt:formatNumber value="${saleItem.item.price * saleItem.quantity}" pattern="#,###" />��
		</td></tr>
	</c:forEach>
	<tr><td colspan="4" style="text-align:right">�ѱݾ�:<fmt:formatNumber value="${totalAmount}" pattern="#,###" />��</td></tr>
	<tr><td colspan="4"><a href="../item/list.shop">��ǰ���</a></td></tr>
</table>
</body>
</html>