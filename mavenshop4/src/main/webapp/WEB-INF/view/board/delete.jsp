<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>게시물 삭제</title>
</head>
<body>
<form action="delete.shop" method="post" name="f">
	<input type="hidden" name="num" value="${param.num}">
	<table border="1" style="border-collapse:collapse; width:100%">
		<tr><td>게시글 비밀번호</td><td><input type="password" name="pass"></td></tr>
		<tr><td colspan="2" align="center"><a href="javascript:document.f.submit()">[삭제]</a></td></tr>
	</table>
</form>
</body>
</html>