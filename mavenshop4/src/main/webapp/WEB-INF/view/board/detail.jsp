<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/view/jspHandler.jsp"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>게시물 상세 보기</title>
<link rel="stylesheet" href="${path}/lightslider/css/lightslider.css" />
<link rel="stylesheet" href="${path}/lightslider/css/abcmart.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://www.w3schools.com/lib/w3-theme-black.css">
<style>
ul {
	list-style: none outside none;
	padding-left: 0;
	margin: auto;
}

.demo .item {
	margin-bottom: 60px;
}

.content-slider li {
	text-align: center;
	color: #FFF;
}

.content-slider h3 {
	margin: 30px;
	padding: 70px 0;
}

.demo {
	width: 500px;
}

.demo img {
	width: 400px;
}
</style>
<script src="${path}/lightslider/js/lightslider.js"></script>
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
<script>

	function mobRfShop() {

		var sh = new EN();
		// [상품상세정보]

		sh.setData("sc", "47a9cb87e5a2d6c57d2bd21ba98efc5a");
		sh.setData("userid", "abcmart1");
		sh.setData("pcode", "0068359");
		sh.setData("price", "79000");
		sh.setData("pnm",
				encodeURIComponent(encodeURIComponent("나이키 코트 로얄 에이씨")));
		sh
				.setData(
						"img",
						encodeURIComponent("http://image.abcmart.co.kr/nexti/images/title/1217/0068359_title.jpg"));
		sh.setData("dcPrice", "79000"); // 옵션
		if (true) {
			sh.setSSL(true);
		} else {
			sh.setSSL(false);
		}
		sh.sendRfShop();

		// 장바구니 버튼 클릭 시 호출 메소드(사용하지 않는 경우 삭제)
		document.getElementsById("cartBtn")[0].onmouseup = sendCart;
		document.getElementsById("cartBtn")[1].onmouseup = sendCart;
		document.getElementsById("cartBtn")[2].onmouseup = sendCart;

		function sendCart() {
			sh.sendCart();
		}

		// 찜,Wish 버튼 클릭 시 호출 메소드(사용하지 않는 경우 삭제)
		document.getElementById("wishBtn").onmouseup = sendWish;
		function sendWish() {
			sh.sendWish();
		}
	}
</script>
</head>
<body>
	<div class="container_area">
		<div class="container_layout">
			<div class="product_detail_box1 ">
				<div class="detail_box1_left">
				<div class="demo w3-container w3-padding w3-center">
        <div class="item">            
            <div class="clearfix" style="max-width:100%;">
                <ul id="image-gallery" class="gallery list-unstyled cS-hidden">
                <li data-thumb="${path}/picture/air.PNG"> 
                    <img class="w3-circle w3-hover-opacity" src="${path}/picture/air.PNG" />
                    <h3>에어포스</h3>
                    <p>&#8361;140,000</p>
                </li>
                 <li data-thumb="${path}/picture/roafer.jpg"> 
                    <img class="w3-circle w3-hover-opacity" src="${path}/picture/roafer.jpg" />
                    <h3>닥터마틴 옥스포드</h3>
                    <p>&#8361;180,000</p>
                </li>
                <li data-thumb="${path}/picture/sandle.jpg"> 
                    <img class="w3-circle w3-hover-opacity" src="${path}/picture/sandle.jpg" />
                     <h3>츄바스코 아즈텍</h3>
                     <p>&#8361;99,000</p>
                </li>
                <li data-thumb="${path}/picture/walker.jpg"> 
                   <img class="w3-circle w3-hover-opacity" src="${path}/picture/walker.jpg" />
                   <h3>레드윙 워커</h3>
                   <p>&#8361;380,000</p>
                </li>
            </ul>
           </div>
        </div>
  </div>

					<section class="detail_add_box" style="margin-left:15%;">

						<div class="detail_add_box1">

							<div class="rating_box">
								<p class="tit_type1 fs14">상품 만족도</p>
								<p class="tit_type2">
									0<span class="won fs20">%</span>
								</p>
								<p class="tit_type3 mt5">
									<span class="star star0">평점</span><em class="ml10">0.0 / 5</em>
								</p>
							</div>

							<div class="appraisal_box">
								<ul class="mt5">

									<li><strong class="tit_type3">사이즈</strong> <span>정
											사이즈예요</span></li>

									<li><strong class="tit_type3">색상</strong> <span>화면과
											같아요</span></li>

								</ul>
								<a href="#info_box2" class="btn_sType1">상품후기 바로가기</a>
							</div>
						</div>

					</section>

				</div>

				<div class="detail_box1_right" style="width:65%;">
					<div class="detail_info_area ">
						<header class="product_tit clearfix">

							<div class="fl-l mr15">
								<img
									src="http://image.abcmart.co.kr/nexti/images/abcmart/client/1542/20160908091420710.gif"
									alt="나이키" width="128" height="68" onerror="imageError(this)">
								<p class="align-center mt10">
									<a href="/abc/product/brandShop?brandId=000050"><img
										src="http://image.abcmart.co.kr/nexti/images/abcmart_new/btn_brand.gif"
										alt=""></a>
								</p>
							</div>

							<div class="fl-l mt5 tit_group">

								<h2 class="tit_type1">나이키 코트 로얄 에이씨</h2>
								<h3 class="tit_type1 fs16">NIKE COURT ROYALE AC</h3>
								<ul class="tit_type3">
									<li>스타일코드 : BQ4222</li>
									<li>상품코드 : 0068359</li>
								</ul>
							</div>
						</header>


						<section class="detail_section detail_info1">
							<dl>
								<dt>판매가</dt>
								<dd class="detail_price">
									<div>
										<span class="price"> 79,000<em class="won">원</em>

										</span>
									</div>

									<ul class="detail_price_add">
										<li>상품 구매 시 <strong>2,370</strong>P
										</li>
										<li>발도장 <strong>70</strong>개
										</li>
									</ul>

								</dd>
							</dl>

							<div class="btn_group">

								<a data-rel="layer" href="#target1" class="btn_sType1">스마트계산기</a>
							</div>
						</section>
						<section class="detail_section">

							<dl>
								<dt>배송비</dt>
								<dd class="mt3">무료배송 (20,000원 이상 구매시 무료배송)</dd>
							</dl>
						</section>
						<section class="detail_section">

							<dl>
								<dt>색상코드</dt>
								<dd class="mt3">100</dd>
							</dl>

							<dl>
								<dt>컬러</dt>
								<dd>
									<ul class="detail_color">

										<li class=""><a
											href="/abc/product/detail?prdtCode=0068357&amp;color"><img
												src="http://image.abcmart.co.kr/nexti/images/title/1639/0068357_title.jpg"
												alt="NIKE COURT ROYALE AC" width="50" height="50"
												onerror="imageError(this)"></a></li>

										<li class=""><a
											href="/abc/product/detail?prdtCode=0068358&amp;color"><img
												src="http://image.abcmart.co.kr/nexti/images/title/1720/0068358_title.jpg"
												alt="NIKE COURT ROYALE AC" width="50" height="50"
												onerror="imageError(this)"></a></li>

									</ul>
								</dd>
							</dl>

							<dl>
								<dt>사이즈</dt>
								<dd>
									<ul class="detail_size">

										<li class="onlinePrdtSize"><a href="javascript://"
											onclick="optionClick(this,'0068359','250','250','나이키 코트 로얄 에이씨','79000','false')">
												250 </a></li>

										<li class="onlinePrdtSize"><a href="javascript://"
											onclick="optionClick(this,'0068359','255','255','나이키 코트 로얄 에이씨','79000','false')">
												255 </a></li>

										<li class="onlinePrdtSize"><a href="javascript://"
											onclick="optionClick(this,'0068359','260','260','나이키 코트 로얄 에이씨','79000','false')">
												260 </a></li>

										<li class="onlinePrdtSize"><a href="javascript://"
											onclick="optionClick(this,'0068359','265','265','나이키 코트 로얄 에이씨','79000','false')">
												265 </a></li>

										<li class="onlinePrdtSize"><a href="javascript://"
											onclick="optionClick(this,'0068359','270','270','나이키 코트 로얄 에이씨','79000','false')">
												270 </a></li>

										<li class="onlinePrdtSize"><a href="javascript://"
											onclick="optionClick(this,'0068359','275','275','나이키 코트 로얄 에이씨','79000','false')">
												275 </a></li>

										<li class="onlinePrdtSize"><a href="javascript://"
											onclick="optionClick(this,'0068359','280','280','나이키 코트 로얄 에이씨','79000','false')">
												280 </a></li>

										<li class="onlinePrdtSize"><a href="javascript://"
											onclick="optionClick(this,'0068359','285','285','나이키 코트 로얄 에이씨','79000','false')">
												285 </a></li>

										<li class="onlinePrdtSize"><a href="javascript://"
											onclick="optionClick(this,'0068359','290','290','나이키 코트 로얄 에이씨','79000','false')">
												290 </a></li>

									</ul>
								</dd>
							</dl>
						</section>


						<section class="detail_section ">
							<section class="check_list_box borderTopDisplay"
								style="display: none">
								<form method="POST" action="#" class="incrementer">
									<ul class="prdtList" id="prdtList">
									</ul>
								</form>
							</section>
						</section>

					</div>


					<div class="total_price_box">
						<span class="tit_type1">총 결제금액</span> <span
							class="tit_type2 totalAmt">0</span><span class="tit_type1">원</span>
					</div>


					<section class="btn_group_section new">
						<ul>
							<li><a href="javascript:void(0);" class="btn_lType2"
								onclick="saveWishProduct('0068359');sh.sendWish();" id="wishBtn">찜하기</a></li>

							<li><a href="javascript:void(0);" class="btn_lType2"
								onclick="cartList.addCart();" name="cartBtn">장바구니</a></li>

							<li><a href="javascript:void(0);" class="btn_lType2"
								onclick="cartList.quickOrder('02');">매장픽업</a>
								<p class="pickup-guide-txt">
									매장픽업 서비스란<a href="/abc/storePickup/storePickup"
										class="question-ico" target="_blank"></a>
								</p></li>

							<li><a href="javascript:void(0);" class="btn_lType1"
								onclick="cartList.quickOrder('01');">바로구매</a></li>

						</ul>
					</section>

				</div>
			</div>



			<div class="product_detail_box2">

				<div class="grid-box">
					<section class="grid-2 control_slider_box">
						<h2 class="tit_type1 fs16">
							<span class="bg_fff">고객님들이 많이 구매한 상품</span>
						</h2>
						<div class="bx-wrapper" style="max-width: 510px;">
							<div class="bx-viewport"
								style="width: 100%; position: relative; height: 150px;">
								<ul class="popular_slider"
									style="width: 1115%; position: relative; transition-duration: 0s; transform: translate3d(-540px, 0px, 0px);">
									<li
										style="float: left; list-style: none; position: relative; width: 150px; margin-right: 30px;"
										class="bx-clone">


										<div class="model_img_box" mode="">

											<a href="/abc/product/detail?prdtCode=0068127&amp;best"><img
												src="http://image.abcmart.co.kr/nexti/images/list/1548/0068127_list.jpg"
												alt="WMNS NIKE ZOOM 2K" onerror="imageError(this)"></a>
										</div> <a href="/abc/product/detail?prdtCode=0068127&amp;best"
										class="model_box "> <span class="brand"></span> <span
											class="name">WMNS NIKE ZOOM 2K</span> <span class="price">
												99,000 </span>

									</a>


									</li>
									<li
										style="float: left; list-style: none; position: relative; width: 150px; margin-right: 30px;"
										class="bx-clone">


										<div class="model_img_box" mode="">

											<a href="/abc/product/detail?prdtCode=0068110&amp;best"><img
												src="http://image.abcmart.co.kr/nexti/images/list/1146/0068110_list.jpg"
												alt="NIKE AIR MAX AXIS" onerror="imageError(this)"></a>
										</div> <a href="/abc/product/detail?prdtCode=0068110&amp;best"
										class="model_box "> <span class="brand"></span> <span
											class="name">NIKE AIR MAX AXIS</span> <span class="price">
												109,000 </span>

									</a>


									</li>
									<li
										style="float: left; list-style: none; position: relative; width: 150px; margin-right: 30px;"
										class="bx-clone">


										<div class="model_img_box" mode="">

											<a href="/abc/product/detail?prdtCode=0058729&amp;best"><img
												src="http://image.abcmart.co.kr/nexti/images/list/1819/0058729_list.jpg"
												alt="WMNS CLASSIC CORTEZ LEATHER" onerror="imageError(this)"></a>
										</div> <a href="/abc/product/detail?prdtCode=0058729&amp;best"
										class="model_box "> <span class="brand"></span> <span
											class="name">WMNS CLASSIC CORTEZ LEATHER</span> <span
											class="price"> 79,200 <em class="formal"> 99,000
											</em>

										</span>

									</a>


									</li>

									<li
										style="float: left; list-style: none; position: relative; width: 150px; margin-right: 30px;">


										<div class="model_img_box" mode="">

											<a href="/abc/product/detail?prdtCode=0063287&amp;best"><img
												src="http://image.abcmart.co.kr/nexti/images/list/1740/0063287_list.jpg"
												alt="NIKE DOWNSHIFTER 8" onerror="imageError(this)"></a>
										</div> <a href="/abc/product/detail?prdtCode=0063287&amp;best"
										class="model_box "> <span class="brand"></span> <span
											class="name">NIKE DOWNSHIFTER 8</span> <span class="price">
												71,100 <em class="formal"> 79,000 </em>

										</span>

									</a>


									</li>

									<li
										style="float: left; list-style: none; position: relative; width: 150px; margin-right: 30px;">


										<div class="model_img_box" mode="">

											<a href="/abc/product/detail?prdtCode=0059960&amp;best"><img
												src="http://image.abcmart.co.kr/nexti/images/list/1313/0059960_list.jpg"
												alt="WMNS AIR MAX GUILE" onerror="imageError(this)"></a>
										</div> <a href="/abc/product/detail?prdtCode=0059960&amp;best"
										class="model_box "> <span class="brand"></span> <span
											class="name">WMNS AIR MAX GUILE</span> <span class="price">
												83,300 <em class="formal"> 119,000 </em>

										</span>

									</a>


									</li>

									<li
										style="float: left; list-style: none; position: relative; width: 150px; margin-right: 30px;">


										<div class="model_img_box" mode="">

											<a href="/abc/product/detail?prdtCode=0061579&amp;best"><img
												src="http://image.abcmart.co.kr/nexti/images/list/1036/0061579_list.jpg"
												alt="CORTEZ BASIC SL BPV" onerror="imageError(this)"></a>
										</div> <a href="/abc/product/detail?prdtCode=0061579&amp;best"
										class="model_box "> <span class="brand"></span> <span
											class="name">CORTEZ BASIC SL BPV</span> <span class="price">
												58,500 <em class="formal"> 65,000 </em>

										</span>

									</a>


									</li>

									<li
										style="float: left; list-style: none; position: relative; width: 150px; margin-right: 30px;">


										<div class="model_img_box" mode="">

											<a href="/abc/product/detail?prdtCode=0066334&amp;best"><img
												src="http://image.abcmart.co.kr/nexti/images/list/1156/0066334_list.jpg"
												alt="WMNS NIKE AIR MAX NOSTALGIC" onerror="imageError(this)"></a>
										</div> <a href="/abc/product/detail?prdtCode=0066334&amp;best"
										class="model_box "> <span class="brand"></span> <span
											class="name">WMNS NIKE AIR MAX NOSTALGIC</span> <span
											class="price"> 62,300 <em class="formal"> 89,000
											</em>

										</span>

									</a>


									</li>

									<li
										style="float: left; list-style: none; position: relative; width: 150px; margin-right: 30px;">


										<div class="model_img_box" mode="">

											<a href="/abc/product/detail?prdtCode=0050929&amp;best"><img
												src="http://image.abcmart.co.kr/nexti/images/list/1675/0050929_list.jpg"
												alt="WMNS CLASSIC CORTEZ LEATHER" onerror="imageError(this)"></a>
										</div> <a href="/abc/product/detail?prdtCode=0050929&amp;best"
										class="model_box "> <span class="brand"></span> <span
											class="name">WMNS CLASSIC CORTEZ LEATHER</span> <span
											class="price"> 79,200 <em class="formal"> 99,000
											</em>

										</span>

									</a>


									</li>

									<li
										style="float: left; list-style: none; position: relative; width: 150px; margin-right: 30px;">


										<div class="model_img_box" mode="">

											<a href="/abc/product/detail?prdtCode=0068005&amp;best"><img
												src="http://image.abcmart.co.kr/nexti/images/list/1261/0068005_list.jpg"
												alt="NIKE ZOOM 2K" onerror="imageError(this)"></a>
										</div> <a href="/abc/product/detail?prdtCode=0068005&amp;best"
										class="model_box "> <span class="brand"></span> <span
											class="name">NIKE ZOOM 2K</span> <span class="price">
												99,000 </span>

									</a>


									</li>

									<li
										style="float: left; list-style: none; position: relative; width: 150px; margin-right: 30px;">


										<div class="model_img_box" mode="">

											<a href="/abc/product/detail?prdtCode=0068127&amp;best"><img
												src="http://image.abcmart.co.kr/nexti/images/list/1548/0068127_list.jpg"
												alt="WMNS NIKE ZOOM 2K" onerror="imageError(this)"></a>
										</div> <a href="/abc/product/detail?prdtCode=0068127&amp;best"
										class="model_box "> <span class="brand"></span> <span
											class="name">WMNS NIKE ZOOM 2K</span> <span class="price">
												99,000 </span>

									</a>


									</li>

									<li
										style="float: left; list-style: none; position: relative; width: 150px; margin-right: 30px;">


										<div class="model_img_box" mode="">

											<a href="/abc/product/detail?prdtCode=0068110&amp;best"><img
												src="http://image.abcmart.co.kr/nexti/images/list/1146/0068110_list.jpg"
												alt="NIKE AIR MAX AXIS" onerror="imageError(this)"></a>
										</div> <a href="/abc/product/detail?prdtCode=0068110&amp;best"
										class="model_box "> <span class="brand"></span> <span
											class="name">NIKE AIR MAX AXIS</span> <span class="price">
												109,000 </span>

									</a>


									</li>

									<li
										style="float: left; list-style: none; position: relative; width: 150px; margin-right: 30px;">


										<div class="model_img_box" mode="">

											<a href="/abc/product/detail?prdtCode=0058729&amp;best"><img
												src="http://image.abcmart.co.kr/nexti/images/list/1819/0058729_list.jpg"
												alt="WMNS CLASSIC CORTEZ LEATHER" onerror="imageError(this)"></a>
										</div> <a href="/abc/product/detail?prdtCode=0058729&amp;best"
										class="model_box "> <span class="brand"></span> <span
											class="name">WMNS CLASSIC CORTEZ LEATHER</span> <span
											class="price"> 79,200 <em class="formal"> 99,000
											</em>

										</span>

									</a>


									</li>

									<li
										style="float: left; list-style: none; position: relative; width: 150px; margin-right: 30px;"
										class="bx-clone">


										<div class="model_img_box" mode="">

											<a href="/abc/product/detail?prdtCode=0063287&amp;best"><img
												src="http://image.abcmart.co.kr/nexti/images/list/1740/0063287_list.jpg"
												alt="NIKE DOWNSHIFTER 8" onerror="imageError(this)"></a>
										</div> <a href="/abc/product/detail?prdtCode=0063287&amp;best"
										class="model_box "> <span class="brand"></span> <span
											class="name">NIKE DOWNSHIFTER 8</span> <span class="price">
												71,100 <em class="formal"> 79,000 </em>

										</span>

									</a>


									</li>
									<li
										style="float: left; list-style: none; position: relative; width: 150px; margin-right: 30px;"
										class="bx-clone">


										<div class="model_img_box" mode="">

											<a href="/abc/product/detail?prdtCode=0059960&amp;best"><img
												src="http://image.abcmart.co.kr/nexti/images/list/1313/0059960_list.jpg"
												alt="WMNS AIR MAX GUILE" onerror="imageError(this)"></a>
										</div> <a href="/abc/product/detail?prdtCode=0059960&amp;best"
										class="model_box "> <span class="brand"></span> <span
											class="name">WMNS AIR MAX GUILE</span> <span class="price">
												83,300 <em class="formal"> 119,000 </em>

										</span>

									</a>


									</li>
									<li
										style="float: left; list-style: none; position: relative; width: 150px; margin-right: 30px;"
										class="bx-clone">


										<div class="model_img_box" mode="">

											<a href="/abc/product/detail?prdtCode=0061579&amp;best"><img
												src="http://image.abcmart.co.kr/nexti/images/list/1036/0061579_list.jpg"
												alt="CORTEZ BASIC SL BPV" onerror="imageError(this)"></a>
										</div> <a href="/abc/product/detail?prdtCode=0061579&amp;best"
										class="model_box "> <span class="brand"></span> <span
											class="name">CORTEZ BASIC SL BPV</span> <span class="price">
												58,500 <em class="formal"> 65,000 </em>

										</span>

									</a>


									</li>
								</ul>
							</div>
							<div class="bx-controls bx-has-pager">
								<div class="bx-pager bx-default-pager">
									<div class="bx-pager-item">
										<a href="" data-slide-index="0" class="bx-pager-link active">1</a>
									</div>
									<div class="bx-pager-item">
										<a href="" data-slide-index="1" class="bx-pager-link">2</a>
									</div>
									<div class="bx-pager-item">
										<a href="" data-slide-index="2" class="bx-pager-link">3</a>
									</div>
								</div>
							</div>
						</div>
					</section>
					<section class="grid-2 fl-r control_slider_box">
						<h2 class="tit_type1 fs16">
							<span class="bg_fff">HOT 신상</span>
						</h2>
						<div class="bx-wrapper" style="max-width: 510px;">
							<div class="bx-viewport"
								style="width: 100%; position: relative; height: 150px;">
								<ul class="popular_slider"
									style="width: 1115%; position: relative; transition-duration: 0s; transform: translate3d(-540px, 0px, 0px);">
									<li
										style="float: left; list-style: none; position: relative; width: 150px; margin-right: 30px;"
										class="bx-clone">


										<div class="model_img_box" mode="">

											<a href="/abc/product/detail?prdtCode=0064557&amp;hot"><img
												src="http://image.abcmart.co.kr/nexti/images/list/1671/0064557_list.jpg"
												alt="NIKE EBERNON LOW" onerror="imageError(this)"></a>
										</div> <a href="/abc/product/detail?prdtCode=0064557&amp;hot"
										class="model_box "> <span class="brand"></span> <span
											class="name">NIKE EBERNON LOW</span> <span class="price">
												79,000 </span>

									</a>


									</li>
									<li
										style="float: left; list-style: none; position: relative; width: 150px; margin-right: 30px;"
										class="bx-clone">


										<div class="model_img_box" mode="">

											<a href="/abc/product/detail?prdtCode=0064543&amp;hot"><img
												src="http://image.abcmart.co.kr/nexti/images/list/1754/0064543_list.jpg"
												alt="WMNS NIKE COURT ROYALE AC" onerror="imageError(this)"></a>
										</div> <a href="/abc/product/detail?prdtCode=0064543&amp;hot"
										class="model_box "> <span class="brand"></span> <span
											class="name">WMNS NIKE COURT ROYALE AC</span> <span
											class="price"> 79,000 </span>

									</a>


									</li>
									<li
										style="float: left; list-style: none; position: relative; width: 150px; margin-right: 30px;"
										class="bx-clone">


										<div class="model_img_box" mode="">

											<a href="/abc/product/detail?prdtCode=0061516&amp;hot"><img
												src="http://image.abcmart.co.kr/nexti/images/list/1041/0061516_list.jpg"
												alt="AIR MONARCH IV" onerror="imageError(this)"></a>
										</div> <a href="/abc/product/detail?prdtCode=0061516&amp;hot"
										class="model_box "> <span class="brand"></span> <span
											class="name">AIR MONARCH IV</span> <span class="price">
												79,000 </span>

									</a>


									</li>

									<li
										style="float: left; list-style: none; position: relative; width: 150px; margin-right: 30px;">


										<div class="model_img_box" mode="">

											<a href="/abc/product/detail?prdtCode=0068311&amp;hot"><img
												src="http://image.abcmart.co.kr/nexti/images/list/1079/0068311_list.jpg"
												alt="NIKE LIL SWOOSH GT" onerror="imageError(this)"></a>
										</div> <a href="/abc/product/detail?prdtCode=0068311&amp;hot"
										class="model_box "> <span class="brand"></span> <span
											class="name">NIKE LIL SWOOSH GT</span> <span class="price">
												39,000 </span>

									</a>


									</li>

									<li
										style="float: left; list-style: none; position: relative; width: 150px; margin-right: 30px;">


										<div class="model_img_box" mode="">

											<a href="/abc/product/detail?prdtCode=0068309&amp;hot"><img
												src="http://image.abcmart.co.kr/nexti/images/list/1398/0068309_list.jpg"
												alt="NIKE LIL SWOOSH BT" onerror="imageError(this)"></a>
										</div> <a href="/abc/product/detail?prdtCode=0068309&amp;hot"
										class="model_box "> <span class="brand"></span> <span
											class="name">NIKE LIL SWOOSH BT</span> <span class="price">
												39,000 </span>

									</a>


									</li>

									<li
										style="float: left; list-style: none; position: relative; width: 150px; margin-right: 30px;">


										<div class="model_img_box" mode="">

											<a href="/abc/product/detail?prdtCode=0068290&amp;hot"><img
												src="http://image.abcmart.co.kr/nexti/images/list/1119/0068290_list.jpg"
												alt="NIKE AIR VERSITILE III" onerror="imageError(this)"></a>
										</div> <a href="/abc/product/detail?prdtCode=0068290&amp;hot"
										class="model_box "> <span class="brand"></span> <span
											class="name">NIKE AIR VERSITILE III</span> <span
											class="price"> 89,000 </span>

									</a>


									</li>

									<li
										style="float: left; list-style: none; position: relative; width: 150px; margin-right: 30px;">


										<div class="model_img_box" mode="">

											<a href="/abc/product/detail?prdtCode=0068126&amp;hot"><img
												src="http://image.abcmart.co.kr/nexti/images/list/1053/0068126_list.jpg"
												alt="WMNS NIKE ZOOM 2K" onerror="imageError(this)"></a>
										</div> <a href="/abc/product/detail?prdtCode=0068126&amp;hot"
										class="model_box "> <span class="brand"></span> <span
											class="name">WMNS NIKE ZOOM 2K</span> <span class="price">
												99,000 </span>

									</a>


									</li>

									<li
										style="float: left; list-style: none; position: relative; width: 150px; margin-right: 30px;">


										<div class="model_img_box" mode="">

											<a href="/abc/product/detail?prdtCode=0068103&amp;hot"><img
												src="http://image.abcmart.co.kr/nexti/images/list/1990/0068103_list.jpg"
												alt="WMNS NIKE AIR MAX MOTION 2" onerror="imageError(this)"></a>
										</div> <a href="/abc/product/detail?prdtCode=0068103&amp;hot"
										class="model_box "> <span class="brand"></span> <span
											class="name">WMNS NIKE AIR MAX MOTION 2</span> <span
											class="price"> 109,000 </span>

									</a>


									</li>

									<li
										style="float: left; list-style: none; position: relative; width: 150px; margin-right: 30px;">


										<div class="model_img_box" mode="">

											<a href="/abc/product/detail?prdtCode=0068135&amp;hot"><img
												src="http://image.abcmart.co.kr/nexti/images/list/1199/0068135_list.jpg"
												alt="NIKE AIR MAX MOTION 2" onerror="imageError(this)"></a>
										</div> <a href="/abc/product/detail?prdtCode=0068135&amp;hot"
										class="model_box "> <span class="brand"></span> <span
											class="name">NIKE AIR MAX MOTION 2</span> <span class="price">
												109,000 </span>

									</a>


									</li>

									<li
										style="float: left; list-style: none; position: relative; width: 150px; margin-right: 30px;">


										<div class="model_img_box" mode="">

											<a href="/abc/product/detail?prdtCode=0064557&amp;hot"><img
												src="http://image.abcmart.co.kr/nexti/images/list/1671/0064557_list.jpg"
												alt="NIKE EBERNON LOW" onerror="imageError(this)"></a>
										</div> <a href="/abc/product/detail?prdtCode=0064557&amp;hot"
										class="model_box "> <span class="brand"></span> <span
											class="name">NIKE EBERNON LOW</span> <span class="price">
												79,000 </span>

									</a>


									</li>

									<li
										style="float: left; list-style: none; position: relative; width: 150px; margin-right: 30px;">


										<div class="model_img_box" mode="">

											<a href="/abc/product/detail?prdtCode=0064543&amp;hot"><img
												src="http://image.abcmart.co.kr/nexti/images/list/1754/0064543_list.jpg"
												alt="WMNS NIKE COURT ROYALE AC" onerror="imageError(this)"></a>
										</div> <a href="/abc/product/detail?prdtCode=0064543&amp;hot"
										class="model_box "> <span class="brand"></span> <span
											class="name">WMNS NIKE COURT ROYALE AC</span> <span
											class="price"> 79,000 </span>

									</a>


									</li>

									<li
										style="float: left; list-style: none; position: relative; width: 150px; margin-right: 30px;">


										<div class="model_img_box" mode="">

											<a href="/abc/product/detail?prdtCode=0061516&amp;hot"><img
												src="http://image.abcmart.co.kr/nexti/images/list/1041/0061516_list.jpg"
												alt="AIR MONARCH IV" onerror="imageError(this)"></a>
										</div> <a href="/abc/product/detail?prdtCode=0061516&amp;hot"
										class="model_box "> <span class="brand"></span> <span
											class="name">AIR MONARCH IV</span> <span class="price">
												79,000 </span>

									</a>


									</li>

									<li
										style="float: left; list-style: none; position: relative; width: 150px; margin-right: 30px;"
										class="bx-clone">


										<div class="model_img_box" mode="">

											<a href="/abc/product/detail?prdtCode=0068311&amp;hot"><img
												src="http://image.abcmart.co.kr/nexti/images/list/1079/0068311_list.jpg"
												alt="NIKE LIL SWOOSH GT" onerror="imageError(this)"></a>
										</div> <a href="/abc/product/detail?prdtCode=0068311&amp;hot"
										class="model_box "> <span class="brand"></span> <span
											class="name">NIKE LIL SWOOSH GT</span> <span class="price">
												39,000 </span>

									</a>


									</li>
									<li
										style="float: left; list-style: none; position: relative; width: 150px; margin-right: 30px;"
										class="bx-clone">


										<div class="model_img_box" mode="">

											<a href="/abc/product/detail?prdtCode=0068309&amp;hot"><img
												src="http://image.abcmart.co.kr/nexti/images/list/1398/0068309_list.jpg"
												alt="NIKE LIL SWOOSH BT" onerror="imageError(this)"></a>
										</div> <a href="/abc/product/detail?prdtCode=0068309&amp;hot"
										class="model_box "> <span class="brand"></span> <span
											class="name">NIKE LIL SWOOSH BT</span> <span class="price">
												39,000 </span>

									</a>


									</li>
									<li
										style="float: left; list-style: none; position: relative; width: 150px; margin-right: 30px;"
										class="bx-clone">


										<div class="model_img_box" mode="">

											<a href="/abc/product/detail?prdtCode=0068290&amp;hot"><img
												src="http://image.abcmart.co.kr/nexti/images/list/1119/0068290_list.jpg"
												alt="NIKE AIR VERSITILE III" onerror="imageError(this)"></a>
										</div> <a href="/abc/product/detail?prdtCode=0068290&amp;hot"
										class="model_box "> <span class="brand"></span> <span
											class="name">NIKE AIR VERSITILE III</span> <span
											class="price"> 89,000 </span>

									</a>


									</li>
								</ul>
							</div>
							<div class="bx-controls bx-has-pager">
								<div class="bx-pager bx-default-pager">
									<div class="bx-pager-item">
										<a href="" data-slide-index="0" class="bx-pager-link active">1</a>
									</div>
									<div class="bx-pager-item">
										<a href="" data-slide-index="1" class="bx-pager-link">2</a>
									</div>
									<div class="bx-pager-item">
										<a href="" data-slide-index="2" class="bx-pager-link">3</a>
									</div>
								</div>
							</div>
						</div>
					</section>
				</div>
			</div>


			<div class="product_detail_box3 ">
				<div class="info_box1" id="info_box1">



					<ul class="clearfix detail_tab" style="width:65%;">
						<li class="current"><a href="#info_box1">상품 정보</a></li>
						<li><a href="#info_box2">상품 후기 (<span class="reviewCount">0</span>)
						</a></li>
						<li><a href="#info_box3">상품 Q&amp;A (<span
								class="qnaCount">0</span>)
						</a></li>
						<li><a href="#info_box4">배송 / 교환 / 반품 / AS안내</a></li>
					</ul>

					<section class="align-center">
						<p>
							<img alt=""
								src="http://image.abcmart.co.kr/nexti/images/abcmart/sangpum/1442/132868198020190108135801398.jpg"
								style="height: 1822px; width: 980px"><img alt=""
								src="http://image.abcmart.co.kr/nexti/images/abcmart/sangpum/1307/45069128020190108135806854.jpg"
								style="height: 1882px; width: 980px"><img alt=""
								src="http://image.abcmart.co.kr/nexti/images/abcmart/sangpum/1546/134270838420190108135813180.jpg"
								style="height: 1440px; width: 980px"><img alt=""
								src="http://image.abcmart.co.kr/nexti/images/abcmart/sangpum/1601/63206730320190108135819260.jpg"
								style="height: 220px; width: 980px">
						</p>
					</section>


					<section class="table_basic">
						<table>
							<colgroup>
								<col width="200px">
								<col width="*">
								<col width="200px">
								<col width="*">
							</colgroup>
							<tbody>
								<tr>
									<th>성별</th>
									<td>남성</td>

									<th>소재</th>
									<td>상세페이지 참조</td>
								</tr>
								<tr>
									<th>색상</th>
									<td>WHITE</td>

									<th>치수</th>
									<td>250 / 255 / 260 / 265 / 270 / 275 / 280 / 285 / 290</td>
								</tr>
								<tr>
									<th>굽높이</th>
									<td>상세페이지 참조</td>

									<th>제조자</th>
									<td>상세페이지 참조</td>
								</tr>
								<tr>
									<th>제조국</th>
									<td>인도네시아</td>

									<th>수입자</th>
									<td></td>
								</tr>
								<tr>
									<th>A/S 책임자와 전화번호</th>
									<td>ABC마트 A/S 담당자 : 080-701-7770</td>

									<th>제조년월</th>
									<td>상세페이지 참조</td>
								</tr>
								<tr>
									<th>특이사항</th>
									<td></td>

									<th>품질보증기준</th>
									<td>본 제품은 정부 고시 소비자분쟁해결 기준에 의거하여 보상해드립니다. (품질보증기간 : 구입일로부터
										6개월 이내)</td>
								</tr>
								<tr>
									<th>사이즈TIP</th>
									<td></td>

									<th>소재별 관리방법</th>
									<td>가벼운 오염물이 묻었을 때에는 부드러운 솔로 털어내주시기 바랍니다. 물세탁이 되지 않는
										소재입니다. 물에 젖지 않게 해주시기 바라며, 만약 물에 젖었을 때에는 마른 걸레로 닦아주시기 바랍니다. 세탁이
										되지 않는 제품입니다.</td>
								</tr>
							</tbody>
						</table>

					</section>

					<p class="ico_notice">전자상거래 등에서의 상품정보제공 고시에 따라 작성되었습니다.</p>


				</div>

				<div class="info_box2 mt60" id="info_box2">

					<ul class="clearfix detail_tab" style="width:65%;">
						<li><a href="#info_box1">상품 정보</a></li>
						<li class="current"><a href="#info_box2">상품 후기 (<span
								class="reviewCount">0</span>)
						</a></li>
						<li><a href="#info_box3">상품 Q&amp;A (<span
								class="qnaCount">0</span>)
						</a></li>
						<li><a href="#info_box4">배송 / 교환 / 반품 / AS안내</a></li>
					</ul>







					<script>
$(function() {
    // 탭 스위칭
    $('section.evaluate_list ul.tabs li a').on('click', function() {
        var type = $(this).data('type');
        if(isEmpty(type)) {
            return false;
        }
        turnReviewPageAjax(type, 1);

        $('section.evaluate_list ul.tabs li.current').removeClass('current');
        $(this).parent('li').addClass('current');
    });
});

function turnAllReviewPageAjax(page) {
    turnReviewPageAjax('all', page);
}

function turnNormalReviewPageAjax(page) {
    turnReviewPageAjax('normal', page);
}

function turnPhotoReviewPageAjax(page) {
    turnReviewPageAjax('photo', page);
}

function turnReviewPageAjax(type, page) {
    if(type == null || type == undefined || type == '' || (type != 'all' && type != 'normal' && type != 'photo')) {
        return false;
    }

    if(!page) {
        page = 1;
    }

    $.ajax({
        type: 'get',
        url: '/abc/product/ajaxListProductReviews',
        data: {
            type: type,
            prdtCode: '0068359',
            prdtGbnCode: '01000000',
            page: page
        },
        success: function(data) {
            if(location.hash == '#evaluate_area') {
                location.hash = null;
                location.hash = '#evaluate_area';
            } else {
                location.hash = '#evaluate_area';
            }
            var $parent = $('div.linear_list');
            $parent.html(data);
        }
    });
}

function turnAdminReviewPageAjax(page) {
    if(!page) {
        page = 1;
    }

    $.ajax({
        type: 'get',
        url: '/abc/product/ajaxListAdminProductReviews',
        data: {
            prdtCode: '0068359',
            page: page
        },
        success: function(data) {
            if(location.hash == '#evaluate_area') {
                location.hash = null;
                location.hash = '#evaluate_area';
            } else {
                location.hash = '#evaluate_area';
            }
            var $parent = $('div.grid_list');
            $parent.html(data);
        }
    });
}

function isEmpty(value) {
    return (value == null || value == undefined || value == '');
}
</script>
					<p>
						<img
							src="http://image.abcmart.co.kr/nexti/images/abcmart_new/bn_line03.jpg"
							alt="">
					</p>
					<section class="list_area">
						<ul class="list_type1">
							<li>상품 후기를 작성해주시면 <span class="fc_type2">발도장 10개</span>를
								드립니다.
							</li>
							<li>상품 후기를 작성해주시면 <span class="fc_type2">최대 2,000 포인트</span>를
								적립해드립니다.
							</li>
							<li>후기 포인트는 등록일 이후 최대 3일 이내에 적립해드립니다. (주말 및 공휴일 제외)</li>
							<li>용품 및 액세서리에 대한 후기는 포인트 지급이 제외됩니다.</li>
							<li>구매 확정일로부터 <span class="fc_type2">30일이 지난 후 등록된
									후기는 포인트 지급이 제외</span>됩니다.
							</li>
							<li>직접 촬영한 사진이 아닐 경우 포토 후기에 대한 포인트 지급이 제외됩니다.</li>
						</ul>
					</section>

					<div class="evaluate_area" id="evaluate_area">
						<h2>
							이 아이템을 구매한 분들의 <strong class="fc_type1">상품 만족도 및 상품평가</strong>
						</h2>
						<section class="evaluate_box">


							<div class="rating_box" style="margin-left:23%;">
								<p class="tit_type1 fs20">상품 만족도</p>
								<p class="tit_type2">
									0<span class="won">%</span>
								</p>
								<p class="tit_type3 mt5">
									<span class="star_total star_total0"> 평점</span><em
										class="ml10 fs12">0.0 / 5</em>
								</p>
							</div>

							<div class="appraisal_box">



								<section class="appraisal_section">
									<h3 class="tit_type1">
										<img
											src="http://image.abcmart.co.kr/nexti/images/abcmart/client/1308/20160908060134393.png"
											alt="">사이즈
									</h3>



									<dl class="clearfix">
										<dt class="fl-l">정 사이즈예요</dt>
										<dd class="fl-l">
											<p class="bg_graph">
												<span class="cr_per cr0"></span>
											</p>
										</dd>
										<dd class="fl-r">0%</dd>
									</dl>



									<dl class="clearfix">
										<dt class="fl-l">5mm정도 작은 것 같아요</dt>
										<dd class="fl-l">
											<p class="bg_graph">
												<span class="cr_per cr0"></span>
											</p>
										</dd>
										<dd class="fl-r">0%</dd>
									</dl>



									<dl class="clearfix">
										<dt class="fl-l">5mm정도 큰 것 같아요</dt>
										<dd class="fl-l">
											<p class="bg_graph">
												<span class="cr_per cr0"></span>
											</p>
										</dd>
										<dd class="fl-r">0%</dd>
									</dl>



									<dl class="clearfix">
										<dt class="fl-l">10mm정도 작은 것 같아요</dt>
										<dd class="fl-l">
											<p class="bg_graph">
												<span class="cr_per cr0"></span>
											</p>
										</dd>
										<dd class="fl-r">0%</dd>
									</dl>



									<dl class="clearfix">
										<dt class="fl-l">10mm정도 큰 것 같아요</dt>
										<dd class="fl-l">
											<p class="bg_graph">
												<span class="cr_per cr0"></span>
											</p>
										</dd>
										<dd class="fl-r">0%</dd>
									</dl>

								</section>

								<section class="appraisal_section">
									<h3 class="tit_type1">
										<img
											src="http://image.abcmart.co.kr/nexti/images/abcmart/client/1915/20160908060141167.png"
											alt="">색상
									</h3>



									<dl class="clearfix">
										<dt class="fl-l">화면과 같아요</dt>
										<dd class="fl-l">
											<p class="bg_graph">
												<span class="cr_per cr0"></span>
											</p>
										</dd>
										<dd class="fl-r">0%</dd>
									</dl>



									<dl class="clearfix">
										<dt class="fl-l">화면보다 약간 밝아요</dt>
										<dd class="fl-l">
											<p class="bg_graph">
												<span class="cr_per cr0"></span>
											</p>
										</dd>
										<dd class="fl-r">0%</dd>
									</dl>



									<dl class="clearfix">
										<dt class="fl-l">화면보다 약간 어두워요</dt>
										<dd class="fl-l">
											<p class="bg_graph">
												<span class="cr_per cr0"></span>
											</p>
										</dd>
										<dd class="fl-r">0%</dd>
									</dl>



									<dl class="clearfix">
										<dt class="fl-l">화면보다 많이 밝아요</dt>
										<dd class="fl-l">
											<p class="bg_graph">
												<span class="cr_per cr0"></span>
											</p>
										</dd>
										<dd class="fl-r">0%</dd>
									</dl>



									<dl class="clearfix">
										<dt class="fl-l">화면보다 많이 어두워요</dt>
										<dd class="fl-l">
											<p class="bg_graph">
												<span class="cr_per cr0"></span>
											</p>
										</dd>
										<dd class="fl-r">0%</dd>
									</dl>

								</section>

							</div>

						</section>

						<section class="evaluate_list">
							<ul class="tabs">
								<li class="current"><a style="cursor: pointer;"
									data-type="all">전체(0)</a></li>
								<li><a style="cursor: pointer;" data-type="normal">일반(0)</a></li>
								<li><a style="cursor: pointer;" data-type="photo">포토(0)</a></li>
							</ul>

							<div class="linear_list">











								<script>
$(function() {
    $('.toggle_btn').off('click', 'a');
    $('.toggle_btn').on('click', 'a', function(e){ 
        e.preventDefault(); 
        $(this).toggleClass('current');
        $(this).closest('tr').next('.more_viewBox').toggleClass('on');
    });

    $('#btnWriteReview').on('click', function() {
        if(confirm('상품후기는 마이페이지에서 작성 가능합니다. 마이페이지로 이동하시겠습니까?')) {
            return true;
        }
        return false;
    });

    // 특정 후기글 수정
    $(".btnReviewUpdate").click(function() {
        var prdtRvwSeq = $(this).data('prdt-rvw-seq');
        var prdtCode = '0068359';
        var url = 'http://www.abcmart.co.kr/abc/mypage/updateMyReviewForm?prdtRvwSeq=' + prdtRvwSeq + '&prdtCode=' + prdtCode;
        var options = 'width=718,height=1110,scrollbars=yes';
        window.open(url, 'about:blank', options);
    });

    $('.btnReviewDelete').on('click', function() {
        var prdtRvwSeq = $(this).data('prdt-rvw-seq');
        if(confirm('삭제하시겠습니까?')) {
            location.href = 'http://www.abcmart.co.kr/abc/mypage/deleteMyReview?prdtRvwSeq=' + prdtRvwSeq;
        }
    });
});
</script>
								<div class="table_basic mt10">
									<table>
										<colgroup>
											<col width="550">
											<col width="120">
											<col width="140">
											<col width="150">
											<col width="*">
										</colgroup>
										<thead>
											<tr>
												<th>제목</th>
												<th>구매처</th>
												<th>상품만족도</th>
												<th>작성자</th>
												<th>작성일</th>
											</tr>
										</thead>


										<tbody>

											<tr class="group-center">
												<td colspan="5">작성된 후기가 없습니다.</td>
											</tr>


										</tbody>





									</table>
								</div>

								<div class="positR">




									<p class="paginate"></p>

									<a href="http://www.abcmart.co.kr/abc/mypage/listOnlineOrder"
										class="btn_mType1" id="btnWriteReview">상품후기 작성</a>
								</div>
							</div>

							<!--         <div class="grid_list"> -->



							<!--         </div> -->
						</section>
					</div>
				</div>

				<div class="info_box3" id="info_box3">



					<ul class="clearfix detail_tab" style="width:65%;">
						<li><a href="#info_box1">상품 정보</a></li>
						<li><a href="#info_box2">상품 후기 (<span class="reviewCount">0</span>)
						</a></li>
						<li class="current"><a href="#info_box3">상품 Q&amp;A (<span
								class="qnaCount">0</span>)
						</a></li>
						<li><a href="#info_box4">배송 / 교환 / 반품 / AS안내</a></li>
					</ul>

					<div class="qna_area">







						<script>
'use strict';

$(function() {
    if(location.href.indexOf('#info_box3') != -1) {
        $('html, body').animate({
            scrollTop: parseInt($('#info_box3').offset().top)
        }, 500);
    }
    

    $('.qna_btn').off('click', 'a');
    $('.qna_btn').on('click', 'a', function(e) {
        e.preventDefault(); 
        $(this).closest('tr').next('.qna_answer_box').toggleClass('on');
    });
    
    
    $("a.btnUpdate").click(function() {
        if (confirm('수정하시겠습니까?')) {
            var cnslSeq = $(this).parent().attr("cnslSeq");
            var gubun = $(this).parent().attr("gubun");
            var cnslClassId = $(this).parent().attr("cnslClassId");
            $.ajax({
                url: "/abc/customer/layerQnAForm"
                , data: {
                    "cnslSeq" : cnslSeq
                }
                , dataType: "html"
                , success: function(data) {
                    var $layer = $('div#target3');
                    $layer.html('');
                    $layer.html(data);
                    wrapWindowByMask();
                    layerPosition($layer);
                    $layer.attr('tabindex', 0).show().focus();
                    $layer.find('.pop_x , .btn_mType3').click(function() {
                        $layer.hide();
                        $('div.bg_mask').hide();
                        $layer.html('');
                    });
                }
            });
        } else {
            return false;
        }
    });
    
    $("a.btnDelete").click(function() {
        if (confirm('삭제하시겠습니까?')) {
            var cnslSeq = $(this).parent().attr("cnslSeq");
            var gubun = $(this).parent().attr("gubun");
            var cnslClassId = $(this).parent().attr("cnslClassId");
            var tabs = '';
            $.ajax({
                type: "post"
                , url: 'http://www.abcmart.co.kr/abc/customer/deleteOnlineCounsel'
                , data: {
                    "cnslSeq" : cnslSeq
                }
                , dataType: "json"
                , success: function(data) {
                    if (data.save) {
                        alert("삭제되었습니다.");
                        var reloadUrl = location.href;
                        if(reloadUrl.indexOf('#') != -1) {
                            reloadUrl = reloadUrl.substring(0, reloadUrl.indexOf('#')) + '#info_box3';
                        }
                        location.href = reloadUrl;
                        location.reload(true);
                    } else {
                        alert(data.errorMessages[0]);
                    }
                }
                , error: function(xhr, status, error) {
                    alert("시스템 오류가 발생 했습니다. 관리자에게 문의하세요.");
                }
            });
        } else {
            return false;
        }
    });
});

function wrapWindowByMask() {
    var maskWidth = $(window).width();
    var maskHeight = $(window).height();
    $('.bg_mask').css({'width': maskWidth, 'height': maskHeight, 'opacity': '0.6', 'z-index': '500'});
    $('.bg_mask').show();
}

function layerPosition(obj) {
    obj.css("margin-left", '-' + obj.width() / 2 + 'px');
    if(obj.height() > $(window).height() - 100) {
        obj.css("overflow-y", "scroll").css("height", $(window).height() - 100 + 'px').css("margin-top", '-' + obj.height() / 2 + 'px');
    } else {
        obj.css("margin-top" , '-' + obj.height()/2 + 'px');
    }
}

function turnQnAPageAjax(page) {
    var newPage = isEmpty(page) ? "1" : page;
    var $parent = $('div.qna_area').parent();
    $('div.qna_area').remove();
    $.ajax({
        type: 'get',
        url: '/abc/product/ajaxListQnAs',
        data: {prdtCode: '0068359', page: newPage},
        success: function(data) {
            $parent.append(data);
            $('.qna_btn').off('click', 'a');
            $('.qna_btn').on('click', 'a', function(e) {
                e.preventDefault(); 
                $(this).closest('tr').next('.qna_answer_box').toggleClass('on');
            });
        }
    });
}




function showQnAFormLayer() {
    alert('로그인이 필요한 기능입니다.');

    var redirectUrl = location.href;
    location.href = '/abc/login/form?redirectUrl=' + redirectUrl;
}

</script>
						<div class="qna_area">
							<section class="list_area">
								<ul class="list_type1">
									<li>단순 상품비방, 상업적인 내용, 미풍양속 위반, 게시판의 성격에 맞지 않는 글은 통보 없이 삭제될
										수 있습니다.</li>
									<li>오프라인 매장 재고현황 문의는 <span class="fc_type2">‘전국오프라인매장’</span>
										정보를 참고하시어 해당 매장으로 문의하시면 좀 더 정확한 확인이 가능합니다.
									</li>
									<li>주문/배송/반품 및 AS 등 기타 문의는 <span class="fc_type2">1:1
											상담문의(마이페이지&gt;쇼핑수첩&gt;나의상담)</span>에 남겨주시기 바랍니다.<br> (상품 자체에 대한
										문의가 아닌 주문/배송/반품 및 AS 등의 기타문의를 작성하실 경우 나의상담 메뉴로 글이 이동될 수 있습니다.)
									</li>
								</ul>
							</section>

							<section class="qna_list">
								<div class="table_basic mt10">
									<table>
										<colgroup>
											<col width="130">
											<col width="130">
											<col width="590">
											<col width="130">
											<col width="*">
										</colgroup>
										<thead>
											<tr>
												<th>답변상태</th>
												<th>문의유형</th>
												<th>제목</th>
												<th>작성자</th>
												<th>작성일</th>
											</tr>
										</thead>
										<tbody>

											<tr class="group-center">
												<td colspan="5">작성된 상품 Q&amp;A가 없습니다.</td>
											</tr>


										</tbody>
									</table>
								</div>

								<div class="positR">
									<p class="paginate"></p>

									<ul class="btn_group">
										<li><a
											href="http://www.abcmart.co.kr/abc/customer/faqList?parentDepth=0000"
											class="btn_mType3">자주하는 질문보기</a></li>
										<li><a href="#target3" class="btn_mType1"
											onclick="showQnAFormLayer();"> <span
												class="tooltip_type1">Q&amp;A 작성</span>
										</a></li>
									</ul>
								</div>
							</section>
						</div>
					</div>
				</div>


				<div class="info_box4" id="info_box4">



					<ul class="clearfix detail_tab" style="width:65%;">
						<li><a href="#info_box1">상품 정보</a></li>
						<li><a href="#info_box2">상품 후기 (<span class="reviewCount">0</span>)
						</a></li>
						<li><a href="#info_box3">상품 Q&amp;A (<span
								class="qnaCount">0</span>)
						</a></li>
						<li class="current"><a href="#info_box4">배송 / 교환 / 반품 /
								AS안내</a></li>
					</ul>



					<div class="as_info_area grid-box">
						<div class="grid-row">
							<section class="as_info_section grid-2 no_line_left">
								<h2 class="tit_type1 ico_trans">
									<strong class="fc_type1">배송</strong>안내
								</h2>
								<div>
									<h3>배송비</h3>
									<ul class="list_type1">
										<li>2만원 미만 구매 시 <span class="fc_type2">2500원</span></li>
										<li>2만원 이상 구매 시 <span class="fc_type2">전액무료</span> (제주도 및
											기타 도선료 추가지역 포함)
										</li>
									</ul>
								</div>
								<div>
									<h3>평균 배송일</h3>
									<ul class="list_type1">
										<li>평일 4시 이전 주문 당일 출고됩니다. (<span class="fc_type2">온라인
												발송</span>에 한함)
										</li>
										<li>결제 완료 후 평균 2일 소요됩니다. (주말 및 공휴일 제외)</li>
										<li>택배사의 사정에 따라 다소 지연될 수 있습니다. (대한통운 1588-1255)</li>
										<li>오프라인 매장 발송은 <span class="fc_type2">2~3일 더 소요</span>될
											수 있습니다.
										</li>
									</ul>
								</div>
							</section>


							<section class="as_info_section grid-2 positR">
								<h2 class="tit_type1 ico_change">
									온.오프라인 교환 / 반품(환불) / AS <strong class="fc_type1">통합서비스</strong>
								</h2>
								<div>
									<h3>ABC-MART는 온라인ㆍ오프라인 매장 구분 없이 교환/반품/AS 접수가 가능합니다.</h3>
									<ul class="list_type1">
										<li>교환은 사이즈 교환만 가능합니다.</li>
										<li>매장에 방문하여 접수하시면 택배비 무료입니다.</li>
										<li>매장에 방문하여 접수하실 경우 구매내역서를 지참하여 주시기 바랍니다.</li>
										<li>매장에서 반품 접수 하신 경우 환불은 온라인 담당자 확인 후 처리됩니다.<br>(확인
											기간 2-3일 소요 / 결제하신 결제수단으로 환불)
										</li>
									</ul>
								</div>
								<a href="/abc/customer/sortAreaList"
									class="btn_sType1 mt20 ml10">오프라인매장 확인하기<i
									class="ico_arrow_left"></i></a>
							</section>
						</div>
						<div class="grid-row">
							<section class="as_info_section grid-2 no_line_left pt40">
								<h2 class="tit_type1 ico_memo">
									교환ㆍ반품(환불) 접수 시 <strong class="fc_type1">주의사항</strong>
								</h2>
								<div class="mt15">
									<ul class="basic_list_type">
										<li>- 제품을 받으신 날부터 7일 이내(상품불량인 경우 30일)에 접수해주시기 바랍니다.</li>
										<li>- 접수 시 왕복 택배비가 부과됩니다. <br>&nbsp;&nbsp;(단, 상품 불량,
											오배송의 경우 택배비를 환불해드립니다.)
										</li>
										<li>- 접수 후 14일 이내에 상품이 반품지로 도착하지 않을 경우 접수가 취소됩니다.<br>&nbsp;&nbsp;(배송
											지연 제외)
										</li>
									</ul>
								</div>
								<div>
									<h3>
										교환/반품(환불)이 <span class="fc_type2">불가능한</span> 경우
									</h3>
									<ul class="list_type1">
										<li>신발/의류를 외부에서 착용한 경우</li>
										<li>상품이 훼손된 경우</li>
										<li>제품에 붙어있는 택(Tag)을 분실/훼손한 경우</li>
										<li>브랜드 박스 분실/훼손된 경우</li>
									</ul>
								</div>
								<div>
									<h3>교환/반품(환불) 시 박스 포장 예</h3>
									<p class="list_type1">브랜드 박스의 훼손이 없도록 택배 박스 및 타 박스로 포장하여
										발송해주시기 바랍니다.</p>
									<div class="clearfix mt20">
										<figure class="fl-l packing_info1">
											<img
												src="http://image.abcmart.co.kr/nexti/images/abcmart_new/img_box01.jpg"
												alt="">
											<figcaption>
												<strong>올바른 박스포장 예</strong>
												<!-- <p>정품브랜드 박스의 훼손이 없도록 택배 박스 및 타 박스로 포장합니다.</p> -->
											</figcaption>
										</figure>
										<figure class="fl-l packing_info2">
											<img
												src="http://image.abcmart.co.kr/nexti/images/abcmart_new/img_box02.jpg"
												alt="">
											<figcaption>
												<strong>교환/환불이 <span class="fc_type2">불가한 경우</span></strong>
												<!-- <p>정품브랜드 박스의 훼손이 없도록 택배 박스 및 타 박스로 포장합니다.</p>
                            <p>브랜드 박스에 직접적인 송장부착 및 낙서로 인한 박스 훼손시 교환/환불이 불가능 합니다.</p>
                            <p>정품 브랜드 박스 훼손 및 분실 후 제품만 발송되어진 경우 교환/환불이 불가능 합니다.</p> -->
											</figcaption>
										</figure>
									</div>
								</div>
							</section>

							<section class="as_info_section grid-2 pt40 positR">
								<h2 class="tit_type1 ico_chat">
									<strong class="fc_type1">교환ㆍ반품</strong>(환불) 요령
								</h2>
								<div>
									<h3>교환/반품(환불) 처리 순서</h3>
									<ul class="step_box">
										<li>
											<dl>
												<dt>
													<span class="tit_type2 fc_type2">01.</span> 반품/교환 접수
												</dt>
												<dd>온라인 쇼핑몰에 로그인 후 마이 페이지 &gt; 쇼핑내역 &gt; 반품/교환/AS &gt;
													반품/교환 신청</dd>
											</dl>
										</li>
										<li>
											<dl>
												<dt>
													<span class="tit_type2 fc_type2">02.</span> 접수완료
												</dt>
												<dd>마이페이지 &gt; 쇼핑내역 &gt; 반품/교환/AS &gt; 반품현황 또는 교환 현황
													&gt; 접수확인 상태 확인</dd>
											</dl>
										</li>
										<li>
											<dl>
												<dt>
													<span class="tit_type2 fc_type2">03.</span> ABC-MART로 상품 발송
												</dt>
												<dd>주소 : 경기도 이천시 모가면 사실로579번길 39 2층 ABC-MART 온라인 물류센터</dd>
											</dl>
										</li>
										<li>
											<dl>
												<dt>
													<span class="tit_type2 fc_type2">04.</span> ABC-MART에 상품도착
												</dt>
												<dd>교환 : 교환발송 / 반품 : 환불처리 → 환불완료</dd>
												<dd>결제사(카드, 은행) 영업일 기준 3~4일 후 환불확인 가능</dd>
											</dl>
										</li>
									</ul>
								</div>
								<div class="pt10">
									<h3>교환/반품(환불) 배송비 안내</h3>
									<ul class="list_type1">
										<li>왕복 택배비 : 최초 배송비 (2500원) + 반품 배송비(2500원) = 총 5,000원 이
											부과됩니다. <br>(선결제 또는 환불금액에서 차감 선택)
										</li>
										<li>단, 보내주신 상품이 <span class="fc_type1">불량 또는 오배송</span>으로
											확인 될 경우 택배비를 환불해드립니다. <br>(선택하신 결제수단으로 택배비 환불)
										</li>
										<li>지정택배(대한통운) 외 타택배 이용 시 추가로 발생되는 금액은 고객님께서 부담해주셔야 합니다.</li>
									</ul>
									<p class="add_info mt15 fs12">
										※ 대한통운 자동 회수접수 방법 : 교환/반품 접수 시 접수처를 온라인으로 선택 후 <span>회수여부
											‘예’</span>
									</p>
								</div>
								<a href="/abc/mypage/returnServiceRequest" class="btn_sType2"
									target="_blank">교환/반품(환불) 신청</a>
							</section>
						</div>



						<div class="grid-row">
							<section class="as_info_section2">
								<h2 class="tit_type1 ico_alim mb15">
									<strong class="fc_type1">AS불가</strong>안내
								</h2>
								<div class="grid-box">
									<div>&nbsp;- 개인의 착화 습관으로 발생된 힐컵 변형은 A/S 심의 불가합니다.</div>

									<div>
										<br> &nbsp;- 신발 세탁으로 생긴 이염은 심의 및 수선이 불가합니다.
									</div>

									<div>
										<br> &nbsp;- 양말소재로 생긴 힐컵주변 보풀현상은 심의가 불가합니다.
									</div>

								</div>
							</section>
						</div>


						<div>
							<section class="as_info_section2 positR">
								<h2 class="tit_type1 ico_as">
									<strong class="fc_type1">AS(수선/심의)</strong> 요령
								</h2>
								<ul class="basic_list_type mt15">
									<li>- 오프라인 매장에서도 접수 가능합니다. (매장 방문 접수 시 택배비 무료)</li>
									<li>- 외부 착화 후 발견된 상품 이상에 대한 심의/수선 요청은 온라인 쇼핑몰 마이
										페이지&gt;반품/교환/AS 또는 고객센터를 통해 접수해주시기 바랍니다.</li>
									<li>- 접수 없이 상품을 ABC-MART로 보내실 경우 확인이 어려워 반송되거나 처리가 늦어질 수
										있습니다.</li>
									<li>- 접수 완료 후 15일 이내 상품 도착하지 않을 경우 접수가 취소 됩니다.</li>
									<li>- 매장에서 구매하신 상품의 처리절차를 마이페이지&gt;반품/교환/AS 에서 확인 할 수
										있습니다.(멤버십 회원에 한함)</li>
								</ul>
								<a href="/abc/mypage/reqOnlnAsList" class="btn_sType2">AS 신청</a>

								<div class="clearfix" style="margin-left:20%;">
									<section class="as_box1 positR fl-l">
										<h3>수선 AS</h3>
										<ul class="list_type1">
											<li>수선을 원하는 내용을 자세하게(사진 첨부 가능) 기재해주면 처리 시 도움이 될 수 있습니다.</li>
											<li>수선 접수 시 왕복 택배비(5000원)가 부과됩니다.</li>
											<li>지정택배(대한통운) 외 타택배 이용 시 추가로 발생되는 금액은 고객님께서 부담해주셔야 합니다.</li>
										</ul>

										<a
											href="/abc/customer/faqList?parentDepth=0004&amp;depth=000403"
											class="btn_sType1 mt15 ml10">수선예상비용 자세히 보기<i
											class="ico_arrow_left"></i></a>

										<ul class="step_box">
											<li>
												<dl>
													<dt>
														<span class="tit_type2 fc_type2">01.</span> AS 접수
													</dt>
													<dd>
														온라인 쇼핑몰에 로그인 마이 페이지 &gt; 쇼핑내역 &gt; 반품/교환/AS 또는<br>고객센터를
														통해 접수 &gt; AS신청 (1588-9667 / 080-701-7770)
													</dd>
												</dl>
											</li>
											<li>
												<dl>
													<dt>
														<span class="tit_type2 fc_type2">02.</span> 접수완료
													</dt>
													<dd>마이페이지 &gt; 쇼핑내역 &gt; 반품/교환/AS &gt; AS신청 &gt; 접수확인
														상태 확인</dd>
												</dl>
											</li>
											<li>
												<dl>
													<dt>
														<span class="tit_type2 fc_type2">03.</span> ABC-MART로 상품
														발송
													</dt>
													<dd>
														주소 : 서울특별시 중구 을지로 100, B동 21층(을지로 2가, 파인에비뉴) ABCMART<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;온라인
														AS담당자 앞
													</dd>
												</dl>
											</li>
											<li>
												<dl>
													<dt>
														<span class="tit_type2 fc_type2">04.</span> ABC-MART에 상품도착
														브랜드사 또는 수선업체 접수
													</dt>
													<dd>수선 기간은 총 2주 정도 소요 / 수선 완료 시 개별 유선 통보</dd>
													<dd>(수선 내용에 따라 수선 비용이 청구될 수 있습니다.)</dd>
												</dl>
											</li>
										</ul>
									</section>

									<section class="as_box2 fl-l">
										<h3>심의 AS</h3>
										<ul class="list_type1">
											<li>불량으로 확인되는 내용을 자세하게(사진 첨부 가능) 기재해주시면 처리 시 도움이 될 수
												있습니다.</li>
											<li>상품 불량으로 인한 심의 접수 시 왕복 택배비는 ABC-MART에서 부담합니다. <br>
												(대한통운 택배 이용 권장)
											</li>
										</ul>

										<ul class="step_box">
											<li>
												<dl>
													<dt>
														<span class="tit_type2 fc_type2">01.</span> AS 접수
													</dt>
													<dd>
														온라인 쇼핑몰에 로그인 마이 페이지 &gt; 쇼핑내역 &gt; 반품/교환/AS 또는<br>고객센터를
														통해 접수 &gt; AS신청 (1588-9667 / 080-701-7770)
													</dd>
												</dl>
											</li>
											<li>
												<dl>
													<dt>
														<span class="tit_type2 fc_type2">02.</span> 접수완료
													</dt>
													<dd>마이페이지 &gt; 쇼핑내역 &gt; 반품/교환/AS &gt; AS신청 &gt; 접수확인
														상태 확인</dd>
												</dl>
											</li>
											<li>
												<dl>
													<dt>
														<span class="tit_type2 fc_type2">03.</span> ABC-MART로 상품
														발송
													</dt>
													<dd>
														주소 : 서울특별시 중구 을지로 100, B동 21층(을지로 2가, 파인에비뉴) ABCMART<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;온라인
														AS담당자 앞
													</dd>
												</dl>
											</li>
											<li>
												<dl>
													<dt>
														<span class="tit_type2 fc_type2">04.</span> ABC-MART에 상품도착
														브랜드사 또는 수선업체 접수
													</dt>
													<dd>심의 기간은 총 2주 정도 소요 / 결과 확인 후 개별 유선 통보</dd>
													<dd>불량 판정 시 무상 교환 또는 환불 처리 / 불량이 아닐 경우 유선 안내 후 상품 반송</dd>
													<dd>(2차 심의 접수 가능)</dd>
												</dl>
											</li>
										</ul>
									</section>
								</div>
							</section>
						</div>
					</div>


				</div>
			</div>
		</div>
	</div>
</body>
</html>
