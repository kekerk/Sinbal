<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/view/jspHandler.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>장바구니</title>
</head>
<body>
<h2>장바구니</h2>
<table>
	<tr><td colspan="4"><font color="green">장바구니 상품 목록</font></td></tr>
	<tr><td>상품명</td><td>가격</td><td>수량</td><td>합계</td></tr>
	<c:forEach items="${cart.itemSetList}" var="itemSet" varStatus="stat">
		<tr><td>${itemSet.item.name}</td><td>${itemSet.item.price}</td>
			<td>${itemSet.quantity}</td><td>${itemSet.item.price * itemSet.quantity}&nbsp;
			<a href="cartDelete.shop?index=${stat.index}">ⓧ</a></td></tr>
		<c:set var="tot" value="${tot + (itemSet.item.price * itemSet.quantity)}" />
	</c:forEach>
	<tr><td colspan="4"><font color="green">총 구입금액:${tot}원</font></td></tr>
</table>
<br>${message}<br><a href="../item/list.shop">상품목록</a>
<a href="checkout.shop">주문하기</a>
</body>
</html>