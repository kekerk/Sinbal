<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/view/jspHandler.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>게시물 상세 보기</title>
</head>
<body>
<table border="1" style="border-collapse: collapse; width:100%">
	<tr><td colspan="2">Spring 게시판${board.num} </td></tr>
	<tr><td width="15%">글쓴이</td>
		<td width="85%">${board.name}</td></tr>
	<tr><td>제목</td>
		<td>${board.subject}</td></tr>
	<tr><td>내용</td><td>
	<table width="100%" height="250">
		<tr><td>${board.content}</td></td>
	</table>
	<tr><td>첨부파일</td><td>
		<c:if test="${!empty board.fileurl}">
			<a href="../file/${board.fileurl}">${board.fileurl}</a>
		</c:if></td></tr>
	<tr><td colspan="2" align="center">
		<a href="reply.shop?num=${board.num}">[답변]</a>
		<a href="update.shop?num=${board.num}">[수정]</a>
		<a href="delete.shop?num=${board.num}">[삭제]</a>
		<a href="list.shop">[목록]</a>
	</td></tr>
</table>
</body>
</html>