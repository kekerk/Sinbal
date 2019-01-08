<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>비밀번호 변경</title>
</head>
<body>
<form method="post" action="passChange.shop">
<input type="hidden" name="authKey" value="${authKey}">
<table>
	<tr><td>변경할 비밀번호</td><td><input type="password" name="pass1"></td></tr>
	<tr><td>비밀번호 확인</td><td><input type="password" name="pass2"></td>
		<td><input type="submit" value="확인"></td></tr>
</table>
</form>
</body>
</html>