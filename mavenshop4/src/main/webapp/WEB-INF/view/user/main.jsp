<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<%@ include file = "/WEB-INF/view/jspHandler.jsp"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<html>
<head>
<meta charset="EUC-KR">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="description" content="">
<link rel="stylesheet"  href="/SRC2/lightslider/css/lightslider.css"/>

<style>
    	ul{
			list-style: none outside none;
		    padding-left: 0;
            margin: 0;
		}
        .demo .item{
            margin-bottom: 60px;
        }
		.content-slider li{
		    background-color: #ed3020;
		    text-align: center;
		    color: #FFF;
		}
		.content-slider h3 {
		    margin: 0;
		    padding: 70px 0;
		}
		.demo{
			width: 800px;
		}
</style>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script src="/SRC2/lightslider/js/lightslider.js"></script> 
<script>
      
    	 $(document).ready(function() {
			$("#content-slider").lightSlider({
                loop:true,
              	auto:true,
                keyPress:true
            });
            $('#image-gallery').lightSlider({
                gallery:true,
                item:1,
                thumbItem:9,
                slideMargin: 0,
                speed:500,
                auto:true,
                loop:true,
                onSliderLoad: function() {
                    $('#image-gallery').removeClass('cS-hidden');
                }  
            });
		});
</script>
<title>신발팜</title>
</head>
<body class="body">
<!-- Team Container -->
<div class="w3-container w3-padding-64 w3-center">
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
</body>
</html>