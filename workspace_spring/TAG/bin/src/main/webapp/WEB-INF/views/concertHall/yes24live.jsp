<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../header.jsp" %>
<script src="https://kit.fontawesome.com/698fcd5feb.js" crossorigin="anonymous"></script>



<style>

/* Go to top */
#myBtn {
  position: fixed;
  bottom: 10px;
  right: 10px;
  z-index: 99;
  font-size: 18px;
  border: none;
  outline: none;
  color: black;
  cursor: pointer;
  padding: 15px;
  border-radius: 4px;
  background: transparent;
}
#myBtn:hover {color: #B3B6B7;}

/* 전체 가로 너비 */
.container {max-width: 1350px; !important;} 

/* 링크 컬러 */
a{color: black; !important;}

/* 제목 (Merchandise) */
h2{
  font-size: 60px; !important;
  font-family: 'Jost', sans-serif; !important;
  font-weight: 600;
  padding: 50px 0 70px 0;
}

#intro_wrap{
	height:100px;
}

#intro_wrap button {
  font-size: 16px;
  border: none;
  --border: 1px solid black;
  --border-bottom: 2px solid black;
  outline: none;
  color: black;
  cursor: pointer;
  padding: 3px;
  padding-right: 5px;
  padding-left: 5px;
  margin-right: 5px;
  --border-radius: 4px;
  background: transparent;
}

.logo-box{
	margin:auto;
	width:600px;
	height:300px;
	overflow:hidden;
	margin-bottom:100px;
}

.logo-box img{
	width:100%;
	height:100%;
    object-fit:cover;
}

.hall_container {
	width:80%;
	margin-left:120px;
}




</style>




<!-- 본문영역 -->

<h2>Concert Hall</h2>
<button onclick="topFunction()" id="myBtn" title="Go to top" style="font-size: 26px;">Go to top ↑</button>

<div class="wrapAll">
		
	<!-- intro_wrap 시작 -->
	<div id="intro_wrap">
		<button style="font-weight:bold;">YES24LIVEHALL</button>
		<button onclick="location.href='/concertHall/bluesquare'">BLUESQUARE마스터카드홀</button>
		
	</div><!-- intro_wrap 끝 -->	
	
	<!-- hall_container 시작 -->
	<div class="hall_container">
		<div class="logo-box">
			<img src="/images/concertHalls/livehall_logo.jpeg" alt="Image" class="img-fluid">
		</div>
		<h3><i class="fa-solid fa-landmark"></i> 예스24라이브홀 소개</h3>
		<p>
		대한민국 최초의 전문 콘서트 공연장, 예스24 라이브홀은 2006년 개관하여 지금까지 다양한 공연을 대중들에게 선보이고 있는 전문 콘서트 공연장입니다.<br>
		일본 대중공연장의 전설 '시부야 악스'가 직접 설계한 예스24 라이브홀은 1,500여평의 규모를 자랑하며, 다양하고 전문적인 공연장비와 함께 스탠딩 공연뿐 아니라 좌석 공연도 가능하고, 항상 공연 기획자의 입장에서 고민하는 국내 유일한 전문 콘서트 공연장 입니다.
		</p>


		<div class="untree_co-section" style="margin:0;">
			<div class="container">
				<div class="row mb-5 align-items-center">
					<div class="col-md-6">
						<h2 class="h3"><i class="fa-regular fa-image"></i> 공연장 이미지</h2>        
					</div>
					<div class="col-sm-6 carousel-nav text-sm-right">
						<a href="#" class="prev js-custom-prev-v2">
							<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-arrow-left-circle" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
								<path fill-rule="evenodd" d="M8 15A7 7 0 1 0 8 1a7 7 0 0 0 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
								<path fill-rule="evenodd" d="M8.354 11.354a.5.5 0 0 0 0-.708L5.707 8l2.647-2.646a.5.5 0 1 0-.708-.708l-3 3a.5.5 0 0 0 0 .708l3 3a.5.5 0 0 0 .708 0z"/>
								<path fill-rule="evenodd" d="M11.5 8a.5.5 0 0 0-.5-.5H6a.5.5 0 0 0 0 1h5a.5.5 0 0 0 .5-.5z"/>
							</svg>
						</a>
						<a href="#" class="next js-custom-next-v2">
							<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-arrow-right-circle" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
								<path fill-rule="evenodd" d="M8 15A7 7 0 1 0 8 1a7 7 0 0 0 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
								<path fill-rule="evenodd" d="M7.646 11.354a.5.5 0 0 1 0-.708L10.293 8 7.646 5.354a.5.5 0 1 1 .708-.708l3 3a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708 0z"/>
								<path fill-rule="evenodd" d="M4.5 8a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1H5a.5.5 0 0 1-.5-.5z"/>
							</svg>
						</a>
					</div>
				</div> <!-- /.heading -->
				<div class="owl-3-slider owl-carousel">
					<div class="item">
						<div class="product-item">
							<img src="/images/concertHalls/yes24livehall_img_01_slide.jpeg" alt="Image" class="img-fluid">
						</div>
					</div> <!-- /.item -->
					<div class="item">
						<div class="product-item">
							<img src="/images/concertHalls/yes24livehall_img_02_slide.jpeg" alt="Image" class="img-fluid">
						</div>
					</div> <!-- /.item -->
					<div class="item">
						<div class="product-item">
							<img src="/images/concertHalls/yes24livehall_img_03_slide.jpeg" alt="Image" class="img-fluid">
						</div>
					</div> <!-- /.item -->
					<div class="item">
						<div class="product-item">
							<img src="/images/concertHalls/yes24livehall_img_04_slide.jpeg" alt="Image" class="img-fluid">
						</div>
					</div> <!-- /.item -->
					<div class="item">
						<div class="product-item">
							<img src="/images/concertHalls/yes24livehall_img_05_slide.jpeg" alt="Image" class="img-fluid">
						</div>
					</div> <!-- /.item -->
					<div class="item">
						<div class="product-item">
							<img src="/images/concertHalls/yes24livehall_img_06_slide.jpeg" alt="Image" class="img-fluid">
						</div>
					</div> <!-- /.item -->
					<div class="item">
						<div class="product-item">
							<img src="/images/concertHalls/yes24livehall_img_07_slide.jpeg" alt="Image" class="img-fluid">
						</div>
					</div> <!-- /.item -->
					<div class="item">
						<div class="product-item">
							<img src="/images/concertHalls/yes24livehall_img_08_slide.jpeg" alt="Image" class="img-fluid">
						</div>
					</div> <!-- /.item -->
				</div>
			</div> <!-- /.container -->
		</div> <!-- /.untree_co-section -->  


		<div style="padding:15px;">
			<h5 style="margin-top:100px;"><i class="fa-solid fa-table-cells"></i> 좌석 배치도</h5>
			<p>
			1,382석[가변석] (1층 992석, 2층 390석)
			</p>
			<div style="background:black; margin:auto; width:60%; margin-bottom:100px;">
				<img src="/images/concertHalls/seatingplan_floor_stand.png" alt="Image" class="img-fluid">
			</div>
			
	
			<h5><i class="fa-solid fa-route"></i> 찾아오시는 길</h5>
			<p>
				예스24 라이브홀<br>
				서울특별시 광진구 구천면로 20 (광장동) 예스이십사라이브홀㈜<br>
				대표전화 070-5001-4532
			</p>
			<div style="margin:auto; width:60%; margin-bottom:100px;">
				<img src="/images/concertHalls/KakaoMap_20221221_145252.png" alt="Image" class="img-fluid">
			</div>
			
			<h5><i class="fa-solid fa-train-subway"></i> 대중교통 안내</h5>
			<p>
				- 지하철<br>
				5호선 광나루역 2번 출구에서 도보 5분(400m)<br><br>
				
				- 버스<br>
				간선버스  130,370,N30번 광나루역 하차 후 횡단<br>
				직행버스  1113,1113-1,1113-2,1113-11번 광진청소년수련관 하차<br>
				일반버스 초록색 13,13-2,96-1번 광진청소년수련관 하차<br>
				마을버스 초록색 광진01번 청소년수련관 하차<br><br><br>
			</p>
		</div>


	</div><!-- hall_container -->

</div><!-- wrapAll end -->





<script>
/* Go to top */
function scrollFunction() {
	let mybutton = document.getElementById("myBtn");

	// When the user scrolls down 20px from the top of the document, show the button
	window.onscroll = function() {scrollFunction()};

  if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
    mybutton.style.display = "block";
  } else {
    mybutton.style.display = "none";
  }
}

// When the user clicks on the button, scroll to the top of the document
function topFunction() {
	$('html, body').animate({scrollTop:0}, '200');
}//scrollFunction() end




</script>











<!-- 본문영역 -->

<%@ include file="../footer.jsp" %>