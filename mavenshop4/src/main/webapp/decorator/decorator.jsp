<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/view/jspHandler.jsp" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<title>신발팜</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://www.w3schools.com/lib/w3-theme-black.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">

<body id="myPage">

<!-- Sidebar on click -->
<nav class="w3-sidebar w3-bar-block w3-white w3-card w3-animate-left w3-xxlarge" style="display:none;z-index:2" id="mySidebar">
  <a href="javascript:void(0)" onclick="w3_close()" class="w3-bar-item w3-button w3-display-topright w3-text-teal">Close
    <i class="fa fa-remove"></i>
  </a>
  <a href="#" class="w3-bar-item w3-button">Link 1</a>
  <a href="#" class="w3-bar-item w3-button">Link 2</a>
  <a href="#" class="w3-bar-item w3-button">Link 3</a>
  <a href="#" class="w3-bar-item w3-button">Link 4</a>
  <a href="#" class="w3-bar-item w3-button">Link 5</a>
</nav>

<!-- Navbar -->
<div class="w3-top">
 <div class="w3-bar w3-theme-d2 w3-left-align">
  <a class="w3-bar-item w3-button w3-hide-medium w3-hide-large w3-right w3-hover-white w3-theme-d2" href="javascript:void(0);" onclick="openNav()"><i class="fa fa-bars"></i></a>
  <a href="#" class="w3-bar-item w3-button w3-teal"><i class="fa fa-home w3-margin-right"></i>Home</a>
     <div class="w3-dropdown-hover w3-hide-small">
    <button class="w3-button" title="Notifications">운동화<i class="fa fa-caret-down"></i></button>     
    <div class="w3-dropdown-content w3-bar-block w3-animate-zoom">
      <a href="#" class="w3-bar-item w3-button">런닝화</a>
      <a href="#" class="w3-bar-item w3-button">슬립온</a>
      <a href="#" class="w3-bar-item w3-button">스니커즈</a>
    </div>
  </div>    <div class="w3-dropdown-hover w3-hide-small">
    <button class="w3-button" title="Notifications">구두 <i class="fa fa-caret-down"></i></button>     
    <div class="w3-dropdown-content w3-bar-block w3-animate-zoom">
      <a href="#" class="w3-bar-item w3-button">옥스포드</a>
      <a href="#" class="w3-bar-item w3-button">로퍼</a>
      <a href="#" class="w3-bar-item w3-button">힐</a>
    </div>
  </div>    <div class="w3-dropdown-hover w3-hide-small">
    <button class="w3-button" title="Notifications">샌들 <i class="fa fa-caret-down"></i></button>     
    <div class="w3-dropdown-content w3-bar-block w3-animate-zoom">
      <a href="#" class="w3-bar-item w3-button">플립플랍</a>
      <a href="#" class="w3-bar-item w3-button">슬라이드</a>
      <a href="#" class="w3-bar-item w3-button">스트랩</a>
    </div>
  </div>
    <div class="w3-dropdown-hover w3-hide-small">
    <button class="w3-button" title="Notifications">부츠<i class="fa fa-caret-down"></i></button>     
    <div class="w3-dropdown-content w3-bar-block w3-animate-zoom">
      <a href="#" class="w3-bar-item w3-button">워커</a>
      <a href="#" class="w3-bar-item w3-button">앵클</a>
      <a href="#" class="w3-bar-item w3-button">레인</a>
    </div>
  </div>
  <a href="#" class="w3-bar-item w3-button w3-hide-small w3-right w3-hover-teal" title="Search"><i class="fa fa-search"></i></a> 
<button onclick="document.getElementById('id01').style.display='block'" class="w3-bar-item w3-button w3-hide-small w3-right w3-hover-teal"><font style="font-weight:800;">로그인</font></button>
 </div>

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
</div>

<!-- Image Header -->
<div class="w3-display-container w3-animate-opacity">
  <img src="${path}/picture/main.png" alt="boat" style="width:100%;min-height:350px;max-height:600px;">
</div>

<!-- Modal -->
<div id="id01" class="w3-modal">
  <div class="w3-modal-content w3-card-4 w3-animate-top">
    <header class="w3-container w3-teal w3-display-container"> 
      <span onclick="document.getElementById('id01').style.display='none'" class="w3-button w3-teal w3-display-topright"><i class="fa fa-remove"></i></span>
      <h4>로그인</h4>
    </header>
    <div class="w3-container">
      <p>Cool huh? Ok, enough teasing around..</p>
      <p>Go to our <a class="w3-text-teal" href="/w3css/default.asp">W3.CSS Tutorial</a> to learn more!</p>
    </div>
    <footer class="w3-container w3-teal">
      <p>Modal footer</p>
    </footer>
  </div>
</div>

<!-- Team Container -->
<div class="w3-container w3-padding-64 w3-center" id="team">
<h2>신발팜</h2>
<p>신발을 팔아보자</p>

<div class="w3-row"><br>

<div class="w3-quarter">
  <img src="${path}/picture/air.PNG" alt="Boss" style="width:45%" class="w3-circle w3-hover-opacity">
  <h3>에어포스</h3>
  <p>&#8361;140,000</p>
</div>

<div class="w3-quarter">
  <img src="${path}/picture/roafer.jpg" alt="Boss" style="width:45%" class="w3-circle w3-hover-opacity">
  <h3>닥터마틴 옥스포드</h3>
  <p>&#8361;180,000</p>
</div>

<div class="w3-quarter">
  <img src="${path}/picture/walker.jpg" alt="Boss" style="width:45%" class="w3-circle w3-hover-opacity">
  <h3>레드윙 워커</h3>
  <p>&#8361;380,000</p>
</div>

<div class="w3-quarter">
  <img src="${path}/picture/sandle.jpg" alt="Boss" style="width:45%" class="w3-circle w3-hover-opacity">
  <h3>츄바스코 아즈텍</h3>
  <p> &#8361;99,000</p>
</div>

</div>
</div>

<!-- Work Row -->
<div class="w3-row-padding w3-padding-64 w3-theme-l1" id="work">

<div class="w3-quarter">
<h2>Our Work</h2>
<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
</div>

<div class="w3-quarter">
<div class="w3-card w3-white">
  <img src="/w3images/snow.jpg" alt="Snow" style="width:100%">
  <div class="w3-container">
  <h3>Customer 1</h3>
  <h4>Trade</h4>
  <p>Blablabla</p>
  <p>Blablabla</p>
  <p>Blablabla</p>
  <p>Blablabla</p>
  </div>
  </div>
</div>

<div class="w3-quarter">
<div class="w3-card w3-white">
  <img src="/w3images/lights.jpg" alt="Lights" style="width:100%">
  <div class="w3-container">
  <h3>Customer 2</h3>
  <h4>Trade</h4>
  <p>Blablabla</p>
  <p>Blablabla</p>
  <p>Blablabla</p>
  <p>Blablabla</p>
  </div>
  </div>
</div>

<div class="w3-quarter">
<div class="w3-card w3-white">
  <img src="/w3images/mountains.jpg" alt="Mountains" style="width:100%">
  <div class="w3-container">
  <h3>Customer 3</h3>
  <h4>Trade</h4>
  <p>Blablabla</p>
  <p>Blablabla</p>
  <p>Blablabla</p>
  <p>Blablabla</p>
  </div>
  </div>
</div>

</div>

<!-- Container -->
<div class="w3-container" style="position:relative">
  <a onclick="w3_open()" class="w3-button w3-xlarge w3-circle w3-teal"
  style="position:absolute;top:-28px;right:24px">+</a>
</div>
<!-- Contact Container -->
<div class="w3-container w3-padding-64 w3-theme-l5" id="contact">
  <div class="w3-row">
    <div class="w3-col m5">
    <div class="w3-padding-16"><span class="w3-xlarge w3-border-teal w3-bottombar">Contact Us</span></div>
      <h3>Address</h3>
      <p>Swing by for a cup of coffee, or whatever.</p>
      <p><i class="fa fa-map-marker w3-text-teal w3-xlarge"></i>Chicago, US</p>
      <p><i class="fa fa-phone w3-text-teal w3-xlarge"></i>+00 1515151515</p>
      <p><i class="fa fa-envelope-o w3-text-teal w3-xlarge"></i>test@test.com</p>
    </div>
    <div class="w3-col m7">
      <form class="w3-container w3-card-4 w3-padding-16 w3-white" action="/action_page.php" target="_blank">
      <button type="submit" class="w3-button w3-right w3-theme">Send</button>
      </form>
    </div>
  </div>
</div>

<!-- Image of location/map -->
<img src="/w3images/map.jpg" class="w3-image w3-greyscale-min" style="width:100%;">

<!-- Footer -->
<footer class="w3-container w3-padding-32 w3-theme-d1 w3-center">
  <h4>Follow Us</h4>
  <a class="w3-button w3-large w3-teal" href="javascript:void(0)" title="Facebook"><i class="fab fa-facebook"></i></a>
  <a class="w3-button w3-large w3-teal" href="javascript:void(0)" title="Twitter"><i class="fab fa-twitter"></i></a>
  <a class="w3-button w3-large w3-teal" href="javascript:void(0)" title="Google +"><i class="fab fa-google-plus"></i></a>
  <a class="w3-button w3-large w3-teal" href="javascript:void(0)" title="Google +"><i class="fab fa-instagram"></i></a>
  <a class="w3-button w3-large w3-teal w3-hide-small" href="javascript:void(0)" title="Linkedin"><i class="fab fa-linkedin"></i></a>
  <p>Powered by <a href="https://www.w3schools.com/w3css/default.asp" target="_blank">w3.css</a></p>

  <div style="position:relative;bottom:100px;z-index:1;" class="w3-tooltip w3-right">
    <span class="w3-text w3-padding w3-teal w3-hide-small">Go To Top</span>   
    <a class="w3-button w3-theme" href="#myPage"><span class="w3-xlarge">
    <i class="fa fa-chevron-circle-up"></i></span></a>
  </div>
</footer>

<script>
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
</script>

</body>
</html>
