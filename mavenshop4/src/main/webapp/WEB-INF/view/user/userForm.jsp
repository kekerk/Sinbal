<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/view/jspHandler.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>사용자 등록</title>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    function Post_find() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>
</head>
<body>
<h2>사용자 등록</h2>
<!-- modelAttribute="user" : 현재 페이지가 호출될 때 user 객체가 있어야 한다. -->
<form:form modelAttribute="user" method="post" action="userEntry.shop">
	<spring:hasBindErrors name="user">
		<font color="red">
			<c:forEach items="${errors.globalErrors}" var="error">
				<spring:message code="${error.code}" />
			</c:forEach>
		</font>
	</spring:hasBindErrors>
	<table>
		<tr height="40px"><td>아이디</td><td><form:input path="userId"/>&nbsp;<font color="red"><form:errors path="userId" /></font></td></tr>
		<tr height="40px"><td>비밀번호</td><td><form:password path="password"/>&nbsp;<font color="red"><form:errors path="password" /></font></td></tr>
		<tr height="40px"><td>이름</td><td><form:input path="userName"/>&nbsp;<font color="red"><form:errors path="userName" /></font></td></tr>
		<tr height="40px"><td>전화번호</td><td><form:input path="phoneNo"/>&nbsp;<font color="red"><form:errors path="phoneNo" /></font></td></tr>
		<tr height="40px"><td>우편번호</td><td>
		<input type="text" id="postcode" name="postcode" placeholder="우편번호">
		<input type="button" onclick="Post_find()" value="우편번호 찾기"><br>
		<input type="text" id="address" name="address" placeholder="주소"><br>
		<input type="text" id="sample6_detailAddress" name="address1"placeholder="상세주소">
		<input type="text" id="sample6_extraAddress" placeholder="참고항목"></td></tr>
		<tr height="40px"><td>이메일</td><td><form:input path="email"/>&nbsp;<font color="red"><form:errors path="email" /></font></td></tr>
		<tr height="40px"><td>생년월일</td><td><form:input path="birthDay"/>&nbsp;<font color="red"><form:errors path="birthDay" /></font></td></tr>
		<tr height="40px"><td colspan="2" align="center">
			<input type="submit" value="등록">&nbsp;<input type="reset" value="초기화"></td></tr>
	</table>
</form:form>
</body>
</html>