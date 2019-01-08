<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="decorator"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
<title>carbook</title>
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$.ajax({
		type:"POST",
		url:"${path}/page/fuel.me",
		success:function(data){
			$("#result").html(data);
		}
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
<a href="#" class="w3-bar-item w3-button w3-right"><i class="fa fa-search"></i></a>	
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
			<a href="${path}/page/member/main.me" class="w3-bar-item w3-button" style="font-size: 26px;">Main</a>
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
				<!--로그인 창 -->
				<div class="w3-white w3-margin">
					<div class="w3-container">			
					<c:if test="${empty sessionScope.login}">
							<div class="w3-center">			
								<br>
								<form action="${path}/page/member/login.me" method="post" onsubmit="return logincheck(this)" class="w3-container">
								<div><input type="text" id="id" name="id" placeholder="아이디" maxlength="41">
								<br>
								<input type="password" id="pw" name="pass" placeholder="비밀번호" maxlength="16">
								</div>				
								<input type="submit" title="로그인" alt="로그인" value="로그인" >
								</form>
								<hr>
								<div class="lg_links">			
								<span class=""><a href="" class="">아이디</a>·<a href="" class="" >비밀번호 찾기</a></span>
								<a href="${path}/page/member/joinForm.me" class="">회원가입</a>
								</div>
							</div>
						</c:if>
						<c:if test="${!empty sessionScope.login}">
						<table style="width: 100%; border: 0px">
						<tr><td width="50%"><p class="w3-center">
							<img src="${path}/page/member/img/${sessionScope.pic}" class="w3-circle"
								style="height: 90px; width: 90px" alt="Avatar">
							</p></td><td width="50%"><h6 class="w3-center">${sessionScope.nickname}님</h6></td></tr>
						</table>
							<hr>	
								<form action="${path}/page/member/logout.me" method="post" class="w3-container">				
								<input type="submit" title="로그아웃" alt="로그아웃" value="로그아웃" >
								<a href="${path}/page/member/info.me?id=${login}" class="w">정보보기</a>
								</form>		
								<c:if test="${sessionScope.login=='admin'}">
								<h6><a href="${path}/page/member/list.me">회원목록보기</a></h6>
								</c:if>		
						</c:if>
					</div>
				</div>
				<hr>

				<!-- Posts -->
				<div class="w3-white w3-margin">
					<div class="w3-container w3-padding w3-black">
						<h4>유가 정보</h4>
					</div>
					<div id="result"></div>
				</div>
				<hr>

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
