<%@ page language="java" contentType="text/html; charset=EUC-KR"
   pageEncoding="EUC-KR"%>
<%@ taglib prefix="decorator"
   uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ include file="/WEB-INF/view/jspHandler.jsp" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
<title>carbook</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
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

</script>
<script type="text/javascript">
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

   <!-- Navigation bar with social media icons -->
   <div class="w3-bar w3-black w3-hide-small">
   <a href="" class="w3-bar-item w3-button w3-right"><i class="fa fa-search"></i></a>
<a href="#" id="poplogin" class="w3-bar-item w3-button w3-right"><i  class="fa fa-sign-in" style="font-size: 25px"></i></a>
   </div>
	<div class="modal fade" id="login">
  <div class="modal-dialog">
    <div class="modal-content">
<form method="post" action="login.shop">	
	<h2>로그인</h2>&nbsp;
	<table>
		<tr height="40px"><td>아이디</td><td><input type="text" name="userId"/>&nbsp;
			</td></tr>
		<tr height="40px"><td>비밀번호</td><td><input type="password" name="password"/>&nbsp;
			</td></tr>
		<tr><td><input type="button" id="idbutton" value="아이디찾기"></td>
			<td><input type="button" id="passbutton" value="비밀번호찾기"></td>
		</tr>
		<tr height="40px"><td colspan="2" align="center">
			<input type="submit" value="로그인">&nbsp;
			<input type="button" value="회원가입" onclick="location.href='userEntry.shop'"></td></tr>
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
		<table>
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
		<table>
		<tr height="40px"><td>아이디</td><td><input type="text" name="userId"/></td></tr>
		<tr height="40px"><td>이메일</td><td><input type="text" name="email"/></td></tr>
		<tr height="40px"><td colspan="2" align="center">
			<input type="submit" value="찾기">&nbsp;<input type="reset" value="초기화"></td></tr>
		</table>
	</form>
    </div>
  </div>
</div>
   <!-- w3-content defines a container for fixed size centered content, 
and is wrapped around the whole page content, except for the footer in this example -->
   <div class="w3-content" style="max-width: 1600px">

      <!-- Header -->
      <header class="w3-container w3-center w3-padding-48 w3-white">
         <h1 class="w3-xxxlarge">
            <b>Car Book</b>
         </h1>
         <h6>
            Welcome <span class="w3-tag">carbook이</span>
         </h6>
      </header>
      <div class="w3-container w3-black w3-center">
         <a href="${path}/user/main.shop" class="w3-bar-item w3-button" style="font-size: 26px;">Main</a>
         <div class="w3-dropdown-hover w3-hide-small">
            <a href="${path}/page/board/carbook.bo" class="w3-bar-item w3-button" style="font-size: 26px;">carbook</a>
         </div>
         <div class="w3-dropdown-hover w3-hide-small">
            <a href="#" class="w3-bar-item w3-button" style="font-size: 26px;">Board</a>
            <div class="w3-dropdown-content w3-card-4 w3-bar-block"
               style="width: 300px">
               <a href="${path}/page/board/list.bo?type=1" class="w3-bar-item w3-button">공지사항</a> 
               <a href="${path}/page/board/list.bo?type=2" class="w3-bar-item w3-button">정보공유게시판</a> 
               <a href="${path}/page/board/list.bo?type=3" class="w3-bar-item w3-button">자유게시판</a>
               <a href="${path}/page/board/list.bo?type=4" class="w3-bar-item w3-button">질문게시판</a>
            </div>
         </div>
         <a href="#" class="w3-bar-item w3-button" style="font-size: 26px;"></a>
      </div>



      <!-- Grid -->
      <div class="w3-row w3-padding w3-border">

         <!-- Blog entries -->
         <div class="w3-col l8 s12">
            <!-- Blog entry -->
            <div class="w3-container w3-white w3-margin w3-padding-large w3-center">
                           <decorator:body/>
            </div>
            <hr>
         </div>

         <!-- About/Information menu -->
         <div class="w3-col l4">
            
            <!-- Advertising -->
            <div class="w3-white w3-margin">
               <div class="w3-container w3-padding w3-black">
                  <h4></h4>
               </div>
               <div class="w3-container w3-white">
                  <div
                     class="w3-container w3-display-container w3-light-grey w3-section"
                     style="height: 200px">

                  </div>
               </div>
            </div>
            <hr>

            <!-- Tags -->
            <div class="w3-white w3-margin">
               <div class="w3-container w3-padding w3-black">
                  <h4></h4>
               </div>
               <div class="w3-container w3-white">
                  <p>

                  </p>
               </div>
            </div>
            <hr>

         </div>
      </div>
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