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
		<button onclick="location.href='/concertHall/yes24live'">YES24LIVEHALL</button>
		<button style="font-weight:bold;">BLUESQUARE마스터카드홀</button>
		
	</div><!-- intro_wrap 끝 -->	
	
	<!-- hall_container 시작 -->
	<div class="hall_container">
		<div class="logo-box">
			<img src="/images/concertHalls/bluesquare_logo.png" alt="Image" class="img-fluid">
		</div>
		<h3><i class="fa-solid fa-landmark"></i> 블루스퀘어 소개</h3>
		<p>
			서울 한남동에 자리한 블루스퀘어는 1,766석의 뮤지컬 전문 공연장인 신한카드홀과 1,400석(스탠딩 2,800석) 규모의 다목적 공연장인 마스터카드홀로 구성된 국내 최대 규모의 공연장입니다.<br>
			2011년 개관 이후 10년간 약 1천만명의 방문객을 기록한 블루스퀘어는 매년 국내 최고의 흥행작을 무대에 올려 연간 공연장 가동률 100%를 달성하고 있습니다.<br>
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
							<img src="/images/concertHalls/blue1.jpeg" alt="Image" class="img-fluid">
						</div>
					</div> <!-- /.item -->
					<div class="item">
						<div class="product-item">
							<img src="/images/concertHalls/blue2.jpeg" alt="Image" class="img-fluid">
						</div>
					</div> <!-- /.item -->
					<div class="item">
						<div class="product-item">
							<img src="/images/concertHalls/blue3.png" alt="Image" class="img-fluid">
						</div>
					</div> <!-- /.item -->
					<div class="item">
						<div class="product-item">
							<img src="/images/concertHalls/blue4.png" alt="Image" class="img-fluid">
						</div>
					</div> <!-- /.item -->
					<div class="item">
						<div class="product-item">
							<img src="/images/concertHalls/blue5.png" alt="Image" class="img-fluid">
						</div>
					</div> <!-- /.item -->
				</div>
			</div> <!-- /.container -->
		</div> <!-- /.untree_co-section -->  


		<div style="padding:15px;">
			<h5 style="margin-top:100px;"><i class="fa-solid fa-table-cells"></i> 좌석 배치도</h5>
			<p>
			1,937석[가변석] (1층 1200석, 2층 337석)
			</p>
			<div style="background:black; margin:auto; width:60%; margin-bottom:100px;">
				<img src="/images/concertHalls/bluesquaremap1.gif" alt="Image" class="img-fluid">
				<img src="/images/concertHalls/bluesquaremap2.gif" alt="Image" class="img-fluid">
			</div>
			
	
			<h5><i class="fa-solid fa-route"></i> 찾아오시는 길</h5>
			<p>
				블루스퀘어 마스터카드홀<br>
				서울특별시 용산구 이태원로 294<br>
				대표전화 1544-1591
			</p>
			<div style="margin:auto; width:60%; margin-bottom:100px;">
				<img src="/images/concertHalls/KakaoMap_20221221_154834.png" alt="Image" class="img-fluid">
			</div>
			
			<h5><i class="fa-solid fa-train-subway"></i> 대중교통 안내</h5>
			<p>
				- 지하철<br>
				6호선 한강진역 2번 출구와 3번 출구 사이 지하철역 연결통로 이용<br><br>
				
				- 버스<br>
				간선버스  110A, 405, 400번 한강진역 하차 (1번 출구 방면)<br>
				순환버스  03번 한강진역 하차 (2번 출구 방면)<br>
				공항버스  6030번 한강진역 하차 (2번 출구 방면)<br>
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