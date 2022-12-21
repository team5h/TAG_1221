<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Jost:wght@100;200;300;400;500;600;700;800;900&family=Mulish:wght@200;300;400;500;600;700;800;900;1000&display=swap" rel="stylesheet">

<style>
	.leftcontent {
		float: left;
		width: 15%;
		margin-right: 5%;
		height: 100%;
	}
	
	.rightcontent {
		float: right;
		width: 80%;
		height: 100%;
		font-family: 'Jost', sans-serif;
  		letter-spacing: 0.25px;	
	}
	
	.leftcontent, .rightcontent, .box { border-top: 1px solid black; }
	
	.leftcontent, .rightcontent { border-bottom: 1px solid black; }
	
	.leftcontent div, .rightcontent { padding: 10px; }
	
	.box { margin-top: 10%; }
	
	/*
	.memberLike {
		display: flex;
		flex-wrap: wrap; // 상위 요소의 너비보다 하위 요소의 너비가 더 클 경우 줄바꿈 //
		justify-content: space-between;
		width: 800px;
		//height: 100%;//
		border: 1px solid blue;
		margin: 0 auto;
	}
	
	.memberLike .likeItem {
		border: 1px solid green; // 테두리를 1px 실선의 #eee 색상으로 //
		height: 350px;
		width: 250px;
		padding: 5px;
		margin-bottom: 10px;	
	}
	
	.likeItem img {
		height: 150px;
		width: 200px;
	}
	
	.likeItem p {
		font-size: 14px;
	}
	*/
	
	.mylike_concert {
		/*border: solid 1px blue;*/
		height: 50%;
	}
	
	.mylike_concert p {
		border-bottom: solid 3px black;
	}
	
	.mylike_product {
		margin-top: 1%;
		/*border: solid 1px blue;*/
		height: 50%;
	}

	.mylike_product p {
		border-bottom: solid 3px black;
	}
	
	.button {
		float: right;
		background-color: #4CAF50; /* Green */
		border: none;
		color: white;
		padding: 10px 15px;
		text-align: center;
		text-decoration: none;
		display: inline-block;
		font-size: 16px;
		margin: auto;
		transition-duration: 0.4s;
		cursor: pointer;
		border-radius: 4px;
	}
	
	.button5 {
	  background-color: #555555;
	  color: white;
	}

	.button5:hover {
	  background-color: white;
	  color: black;
	  border: 2px solid #555555;
	}
	
	table {
		margin-left:auto; 
    	margin-right:auto;
	}
</style>

<!-- 본문 시작 -->

<div class="title">
	<h3 style="text-align: center;">관심 공연 / 관심 상품</h3>
</div>

<div class="leftcontent">
	<div><b>${s_m_id}</b> 님</div>
	<div><a href="/mypage/memberupdateG">회원 정보 수정</a></div>
	<div class="box">
		<div><b>MY티켓</b>
			<div><a href="/mypage/myticket">- 예매 확인 / 취소</a></div>	
		</div>
		<div><b>MY상품</b>
			<div><a href="/mypage/myproduct">- 상품 구매내역</a></div>	
			<div><a href="/mypage/myqna">- 나의 문의내역</a></div>
		</div>
		<div><b>좋아요</b>
			<div><a href="/mypage/mylike">- 관심 공연 / 관심 상품</a></div>
		</div>
		<div><b>MY쿠폰 / MY포인트</b>
			<div><a href="/couponDetail/detail">- 보유 쿠폰</a></div>
			<div><a href="/pointDetail/detail">- 보유 포인트</a></div>
		</div>
	</div>
</div><!-- leftcontent end -->


<div class="rightcontent">
	<div class=mylike_concert>
		<p style="text-align: center;">관심 공연</p>
		<c:if test="${conCnt == 0}">
			관심 공연이 없습니다.<br>
			공연 목록에서 좋아요를 눌러서 관심 공연으로 추가해 보세요!
		</c:if>
		
		<c:if test="${conCnt != 0}">
			<table border="1">
			<tr>
			<c:forEach var="row" items="${like_c}" varStatus="vs">
				<td>
					<c:choose>
						<c:when test="${row.postername != null}">
							<a href="/concert/${row.like_li}"><img src="/storage/${row.postername}" width="100px"></a>
						</c:when>
						<c:otherwise>
							등록된 사진 없음!!<br>
						</c:otherwise>
					</c:choose>
					<div id="concert_name">
						<a href="/concert/${row.like_li}">${row.title}</a>
					</div>
				</td>
				<!-- 테이블 한줄에 3칸씩
				<c:if test="${vs.count mod 3==0 }">
					<tr></tr>
				</c:if> -->
			</c:forEach>
			</tr>
			</table>
			<button class="button button5" onclick="location.href='/mypage/mylike/all_c'">전체보기</button>
		</c:if>
	</div>
	
	<div class=mylike_product>
		<p style="text-align: center;">관심 상품</p>
		<c:if test="${proCnt == 0}">
			관심 상품이 없습니다.<br>
			상품 목록에서 좋아요를 눌러서 관심 상품으로 추가해 보세요!
		</c:if>
		
		<c:if test="${proCnt != 0}">
			<table border="1">
			<tr>
			<c:forEach var="row" items="${like_p}" varStatus="vs">
				<td>
					<c:choose>
						<c:when test="${row.postername != null}">
							<a href="/product/${row.like_li}"><img src="/storage/${row.postername}" width="100px"></a>
						</c:when>
						<c:otherwise>
							등록된 사진 없음!!<br>
						</c:otherwise>
					</c:choose>
					<div id="product_name">
						<a href="/product/${row.like_li}">${row.pro_name}</a>
					</div>
				</td>
				<!-- 테이블 한줄에 3칸씩
				<c:if test="${vs.count mod 3==0 }">
					<tr></tr>
				</c:if> -->
			</c:forEach>
			</tr>
			</table>
			<button class="button button5" onclick="location.href='/mypage/mylike/all_p'">전체보기</button>
		</c:if>
	</div>
</div><!-- rightcontent end -->

<!-- 본문 끝 -->

<%@ include file="../footer.jsp" %>