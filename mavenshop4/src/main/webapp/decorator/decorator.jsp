<%@ page language="java" contentType="text/html; charset=EUC-KR"  pageEncoding="EUC-KR"%>

<%@ taglib prefix="decorator"
   uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ include file="/WEB-INF/view/jspHandler.jsp" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
<title>신발팜</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://www.w3schools.com/lib/w3-theme-black.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />
<script type="text/javascript">
$(function(){
	$("#poplogin").click(function(){
        $('div#login').modal("show");
    })
    $("#idbutton").click(function(){
    	$('div#id').modal("show");
    })
    $("#passbutton").click(function(){
        $('div#pass').modal("show");
    })
})
// Script for side navigation
function w3_open() {
  var x = document.getElementById("mySidebar");
  x.style.width = "300px";
  x.style.paddingTop = "10%";
  x.style.display = "block";
}

// Close side navigation
function w3_close() {
  document.getElementById("mySidebar").style.display = "none";
}

// Used to toggle the menu on smaller screens when clicking on the menu button
function openNav() {
  var x = document.getElementById("navDemo");
  if (x.className.indexOf("w3-show") == -1) {
    x.className += " w3-show";
  } else { 
    x.className = x.className.replace(" w3-show", "");
  }
}

function logincheck(f) {
   if(f.id.value==''){   
      f.id.focus();
      alert('아이디를 입력해주세요');
      return false;
   }
   if(f.pass.value==''){   
      f.pass.focus();
      alert('비밀번호를 입력해주세요');
      return false;
   }
}
</script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet"
   href="https://fonts.googleapis.com/css?family=Oswald">
<link rel="stylesheet"
   href="https://fonts.googleapis.com/css?family=Open Sans">
<link rel="stylesheet"
   href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
h1, h2, h3, h4, h5, h6 {
   font-family: "Oswald"
}

body {
   font-family: "Open Sans"
}
</style>
<decorator:head/>
</head>
<body class="w3-light-grey">

       <!-- Navbar on small screens -->
  <div id="navDemo" class="w3-bar-block w3-theme-d2 w3-hide w3-hide-large w3-hide-medium">
<div class="w3-dropdown-hover">
    <button class="w3-button">운동화 <i class="fa fa-caret-down"></i></button>
    <div class="w3-dropdown-content w3-bar-block w3-animate-zoom">
      <a href="#" class="w3-bar-item w3-button">스니커즈</a>
      <a href="#" class="w3-bar-item w3-button">런닝화</a>
      <a href="#" class="w3-bar-item w3-button">슬립온</a>
    </div>
  </div>
  <div class="w3-dropdown-hover">
    <button class="w3-button">구두 <i class="fa fa-caret-down"></i></button>
    <div class="w3-dropdown-content w3-bar-block w3-animate-zoom">
      <a href="#" class="w3-bar-item w3-button">옥스포드</a>
      <a href="#" class="w3-bar-item w3-button">로퍼</a>
      <a href="#" class="w3-bar-item w3-button">힐</a>
    </div>
  </div>
  <div class="w3-dropdown-hover">
    <button class="w3-button">샌들 <i class="fa fa-caret-down"></i></button>
    <div class="w3-dropdown-content w3-bar-block w3-animate-zoom">
      <a href="#" class="w3-bar-item w3-button">플립플랍</a>
      <a href="#" class="w3-bar-item w3-button">슬라이드</a>
      <a href="#" class="w3-bar-item w3-button">스트랩</a>
    </div>
  </div>
    <div class="w3-dropdown-hover">
    <button class="w3-button">부츠 <i class="fa fa-caret-down"></i></button>
    <div class="w3-dropdown-content w3-bar-block w3-animate-zoom">
      <a href="#" class="w3-bar-item w3-button">워커</a>
      <a href="#" class="w3-bar-item w3-button">앵클</a>
      <a href="#" class="w3-bar-item w3-button">레인</a>
    </div>
  </div>
  <a href="#" class="w3-bar-item w3-button">Search</a>
  </div>  
   <!-- Navigation bar with social media icons -->
   <div class="w3-bar w3-black w3-hide-small">
   <a href="" class="w3-bar-item w3-button w3-right"><i class="fa fa-search"></i></a>
   <c:if test="${empty sessionScope.loginUser}">
		<a href="#" id="poplogin" class="w3-bar-item w3-button w3-right"><font style="font-weight:bold; font-size:20px;">로그인</font></a>
		    </c:if>
		     <c:if test="${!empty sessionScope.loginUser}">
		    <a href="${path}/user/logout.shop" id="poplogin" class="w3-bar-item w3-button w3-right"><font style="font-weight:bold; font-size:20px;">로그아웃</font></a>
		     </c:if>
   </div>
	<div class="modal fade" id="login">
  <div class="modal-dialog">
    <div class="modal-content">
<form method="post" action="login.shop">	
	<h2 style="margin-left:50%;">로그인</h2>&nbsp;
	<table class="w3-table-all w3-hoverable">
		<tr height="40px"><td>아이디</td><td><input type="text" name="userId"/>&nbsp;
			</td></tr>
		<tr height="40px"><td>비밀번호</td><td><input type="password" name="password"/>&nbsp;
			</td></tr>
		<tr height="40px"><td colspan="2" align="center">
		    <input type="button" class="w3-button w3-right w3-theme" id="passbutton" value="비밀번호찾기">&nbsp;
		    <input type="button" class="w3-button w3-right w3-theme" id="idbutton" value="아이디찾기"></td></tr>
		<tr height="40px"><td colspan="2" align="center">
			<input type="submit" class="w3-button w3-right w3-theme" value="로그인">&nbsp;
			<input type="button" class="w3-button w3-right w3-theme" value="회원가입" onclick="location.href='userEntry.shop'"></td></tr>
	</table>
</form>
    </div>
  </div>
</div>
<div class="modal fade" id="id">
  <div class="modal-dialog">
    <div class="modal-content">
    	<h2>아이디 찾기</h2>
   	 <form  method="post" action="idfind.shop">
		<table class="w3-table-all">
		<tr height="40px"><td>이름</td><td><input type="text" name="userName"/></td></tr>
		<tr height="40px"><td>이메일</td><td><input type="text" name="email"/></td></tr>
		<tr height="40px"><td colspan="2" align="center">
			<input type="submit" value="찾기">&nbsp;<input type="reset" value="초기화"></td></tr>
		</table>
	</form>
    </div>
  </div>
</div>

<div class="modal fade" id="pass">
  <div class="modal-dialog">
    <div class="modal-content">
        <h2>비밀번호찾기</h2>
	<form method="post" action="passfind.shop">
		<table class="w3-table-all">
		<tr height="40px"><td>아이디</td><td><input type="text" name="userId"/></td></tr>
		<tr height="40px"><td>이메일</td><td><input type="text" name="email"/></td></tr>
		<tr height="40px"><td colspan="2" align="center">
			<input type="submit" value="찾기">&nbsp;<input type="reset" value="초기화"></td></tr>
		</table>
	</form>
    </div>
  </div>
</div>
   <div class="w3-content" style="max-width: 1600px">
      <!-- Header -->
      <header class="w3-container w3-center w3-padding-48 w3-white">
         <h1 class="w3-xxxlarge">
            <a href="${path}/"><b>신발팜</b></a>
         </h1>
         <h6>
            Welcome <span class="w3-tag">신발팜</span>
         </h6>
         </header>
  <div class="w3-container w3-black w3-center">
  <div class="w3-dropdown-hover">
    <button class="w3-button"><font style="color:white;font-size:26px;">운동화</font><i class="fa fa-caret-down"></i></button>
    <div class="w3-dropdown-content w3-bar-block w3-animate-zoom">
      <a href="#" class="w3-bar-item w3-button">스니커즈</a>
      <a href="#" class="w3-bar-item w3-button">런닝화</a>
      <a href="#" class="w3-bar-item w3-button">슬립온</a>
    </div>
  </div>       
  <div class="w3-dropdown-hover">
    <button class="w3-button"><font style="color:white;font-size:26px;">구두</font> <i class="fa fa-caret-down"></i></button>
    <div class="w3-dropdown-content w3-bar-block w3-animate-zoom">
      <a href="#" class="w3-bar-item w3-button">옥스포드</a>
      <a href="#" class="w3-bar-item w3-button">로퍼</a>
      <a href="#" class="w3-bar-item w3-button">힐</a>
    </div>
  </div>
  <div class="w3-dropdown-hover">
    <button class="w3-button"><font style="color:white;font-size:26px;">샌들</font> <i class="fa fa-caret-down"></i></button>
    <div class="w3-dropdown-content w3-bar-block w3-animate-zoom">
      <a href="#" class="w3-bar-item w3-button">플립플랍</a>
      <a href="#" class="w3-bar-item w3-button">슬라이드</a>
      <a href="#" class="w3-bar-item w3-button">스트랩</a>
    </div>
  </div>

    <div class="w3-dropdown-hover">
    <button class="w3-button"><font style="color:white;font-size:26px;">부츠</font><i class="fa fa-caret-down"></i></button>
    <div class="w3-dropdown-content w3-bar-block w3-animate-zoom">
      <a href="#" class="w3-bar-item w3-button">워커</a>
      <a href="#" class="w3-bar-item w3-button">앵클</a>
      <a href="#" class="w3-bar-item w3-button">레인</a>
    </div>
  </div>
      </div>
 </div> 
      <div class="w3-padding w3-center">
            <decorator:body/>
   </div>

   <!-- Footer -->
   <footer class="w3-container w3-dark-grey" style="padding: 32px">
      <a href="#" class="w3-button w3-black w3-padding-large w3-margin-bottom"><i class="fa fa-arrow-up w3-margin-right"></i>To the top</a>
      <p>
         Powered by
      </p>
   </footer>
</body>
</html>
