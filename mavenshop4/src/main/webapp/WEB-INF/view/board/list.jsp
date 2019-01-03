<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/view/jspHandler.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�Խ��� ���</title>
<script type="text/javascript">
	function list(pageNum){
		var searchType = document.searchform.searchType.value;
		if(searchType == null || searchType.length == 0){
			document.searchform.searchContent.value = "";
			document.searchform.pageNum.value = "1";
			location.href = "list.shop?pageNum="+pageNum;
		} else{
			document.searchform.pageNum.value = pageNum;
			document.searchform.submit();
			return true;
		}
		return false;
	}
</script>
</head>
<body>
<table border="1" style="border-collapse: collapse; width:100%">
	<tr><td colspan="5" align="center">
	<form action="list.shop" method="post" name="searchform" onsubmit="return list(1)">
		<input type="hidden" name="pageNum" value="1">
		<select name="searchType" id="searchType">
			<option value="">�����ϼ���</option>
			<option value="subject">����</option>
			<option value="name">�۾���</option>
			<option value="content">����</option>
		</select>&nbsp;
		<script type="text/javascript">
			if('${param.searchType}' != ''){
				document.getElementById("searchType").value = '${param.searchType}';
			}
		</script>
		<input type="text" name="searchContent" value="${param.searchContent}">
		<input type="submit" value="�˻�">
	</form></td></tr>
	<c:if test="${listcount > 0}">
		<tr align="center" valign="middle">
			<td colspan="4">Spring �Խ���</td><td>�۰���:${listcount}</td></tr>
		<tr align="center" valign="middle" bordercolor="#212121">
			<th width="8%" height="26">��ȣ</th><th width="50%" height="26">����</th>
			<th width="14%" height="26">�۾���</th><th width="17%" height="26">��¥</th>
			<th width="11%" height="26">��ȸ��</th></tr>
		<c:forEach var="board" items="${boardlist}">
			<tr align="center" valign="middle" bordercolor="#333333" onmouseover="this.style.backgroundColor='#5CD1E5'"
				onmouseout="this.style.backgroundColor=''">
				<td height="23">${boardcnt}</td>
				<c:set var="boardcnt" value="${boardcnt -1}" />
				<td align="left">
				<c:if test="${!empty board.fileurl}">
				<a href="../file/${board.fileurl}">@</a>
				</c:if>
				<c:if test="${board.reflevel > 0}">
				<c:forEach var="i" begin="1" end="${board.reflevel}">&nbsp;&nbsp;&nbsp;</c:forEach>
				��</c:if>
				<c:if test="${empty board.fileurl}">&nbsp;&nbsp;&nbsp;</c:if>
				<a href="detail.shop?num=${board.num}">${board.subject}</a></td>
				<td align="left">${board.name}</td>
				<td align="left">${board.regdate}</td>
				<td align="right">${board.readcnt}</td>
			</tr>
		</c:forEach>
		<tr align="center" height="26"><td colspan="5">
			<c:if test="${pageNum > 1}"><a href="javascript:list(${pageNum -1})">[����]</a></c:if>
			<c:if test="${pageNum <= 1}">[����]</c:if>
			<c:forEach var="a" begin="${startpage}" end="${endpage}">
				<c:if test="${a==pageNum}">[${a}]</c:if>
				<c:if test="${a!=pageNum}"><a href="javascript:list(${a})">[${a}]</a></c:if>
			</c:forEach>
			<c:if test="${pageNum < maxpage}">
				<a href="javascript:list(${pageNum+1})">[����]</a>
			</c:if>
			<c:if test="${pageNum >= maxpage}">[����]</c:if>
		</td></tr>
	</c:if>
	<c:if test="${listcount == 0}">
		<tr><td colspan="5">��ϵ� �Խù��� �����ϴ�.</td></tr>
	</c:if>
	<tr><td colspan="5" align="right"><a href="write.shop">[�۾���]</a></td></tr>
</table>
</body>
</html>