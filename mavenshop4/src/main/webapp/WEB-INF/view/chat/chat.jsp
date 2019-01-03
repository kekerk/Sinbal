<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/view/jspHandler.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>WebSocket Client</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.js"></script>
<c:set var="port" value="${pageContext.request.localPort}" />
<c:set var="server" value="${pageContext.request.serverName}" />
<c:set var="path" value="${pageContext.request.contextPath}" />

<script type="text/javascript">
	$(function(){
		//new WebSocket() : �ڹٽ�ũ��Ʈ ��ü.
		//ws://localhost:8080/mavenshop3/chatting.shop : ä�� ���� url
		var ws = new WebSocket("ws://${server}:${port}${path}/chatting.shop");
		ws.onopen = function(){
			$("#chatStatus").text("info: connection opened.");
			$("input[name=chatInput]").on("keydown",function(evt){
				if(evt.keyCode == 13) { //Enter Ű
					var msg = $("input[name=chatInput]").val();
					ws.send(msg); //������ ���ڸ� ����
					$("input[name=chatInput]").val("");
				}
			})
		}
		//�������� �޼��� ���ŵ� ���
		ws.onmessage = function(event){
			//event.data : �������� ���۵� �޼���. ���ŵ� �޼���
			//prepend : ���ʿ� ����ϱ�
			//append : ���ʿ� ����ϱ�
			$("textarea").eq(0).prepend(event.data + "\n");
		}
		//������ ������ ������ ���
		ws.onclose = function(event){
			$("#chatStatus").text("info:connection closed.");
		}
	})
</script>
</head>
<body><p>
<div id="chatStatus"></div>
<textarea name="chatMsg" rows="15" cols="40"></textarea>
<br>
�޽��� �Է� : <input type="text" name="chatInput">

</body>
</html>