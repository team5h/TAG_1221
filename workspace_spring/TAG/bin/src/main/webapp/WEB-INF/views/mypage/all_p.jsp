<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../header.jsp" %>
<%@ include file="ssi.jsp" %>

<style>
@import url(http://fonts.googleapis.com/earlyaccess/notosanskr.css); 

	* {
		font-family: 'Noto Sans KR', sans-serif; !important;
		/*box-sizing: border-box;*/
	}

	.leftcontent {
		float: left;
		width: 10%;
		/*border: 1px solid black;*/
		margin-right: 5%;
	}
	
	.rightcontent {
		float: right;
		width: 85%;
		/*border: 1px solid black;*/
	}
	
	/*
	.mylike_concert {
		//border: solid 1px blue;//
		height: 50%;
	}
	
	.mylike_concert p {
		border-bottom: solid 3px black;
	}
	*/
	
	.column {
		/*float: left;*/
		padding: 0 10px;
		display: inline;
	}
	
	.row1 { margin: 0 -5px; }
	
	.row1::after {
	  content: "";
	  display: table;
	  clear: both;
	}
	
	@media screen and (max-width: 600px) {
	  .column {
	    width: 100%;
	    display: block;
	    margin-bottom: 20px;
	  }
	}
	
	.card {
		width: 33%;
		box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
		padding: 16px;
		margin: 10px;
		text-align: center;
		/*flex: 1;
		flex-direction: column;
		flex-wrap: nowrap;
		align-content: normal;
		justify-content: space-evenly;*/
		align-items: center;
		display: inline-flex;
		/*background-color: #f1f1f1;*/
	}
	
	.card a { color: black; }
	
	.card a:hover { color: lightgreen; }
</style>

<!-- 본문 시작 -->

<br>
	<h1 class="saem_title fontJ"><a href="/mypage/mypageG" style="color: black;" class="saem_title fontJ"> My Page </a></h1>
<br>

<div class="container" style="width: 100%; flex: 1 1 1px;">
	<div class="leftcontent">
		<div class="stickyP" style="height: 5%">
			<p class="fontJ" style="font-size: 20px; font-weight: 500;">
				${s_m_id}&nbsp;님 <!-- 세션 아이디 -->
			</p>
		<br>
		<div class="stickyC" style="position: sticky; top: 100px; padding-bottom: 100px;">
			<ul style="font-size:13px; list-style-type: none; padding-left:0px;">
				<li class="side_liT">My ticket
					<li>&nbsp;<a href="/mypage/myticket" style="color:black; font-size: 12px;">- 예매 확인 / 취소</a></li>
				</li>
				<br>
				<li class="side_liT">My product
					<li>&nbsp;<a href="/mypage/myproduct" style="color:black; font-size: 12px;">- 상품 구매내역</a></li>
					<li>&nbsp;<a href="/mypage/myqna" style="color:black; font-size: 12px;">- 나의 문의내역</a></li>
				</li>
				<br>
				<li class="side_liT" style="color: lightgreen;">My like
					<li>&nbsp;<a href="/mypage/mylike" style="color:black; font-size: 12px;">- 관심 공연 / 관심 상품</a></li>
				</li>
				<br>
				<li class="side_liT">My coupon
					<li>&nbsp;<a href="/couponDetail/detail" style="color:black; font-size: 12px;">- 보유 쿠폰</a></li>
				</li>
				<br>
				<li class="side_liT">My point
					<li>&nbsp;<a href="/pointDetail/detail" style="color:black; font-size: 12px;">- 보유 포인트</a></li>
				</li>
				<br>
				<li style="font-size: 12px; font-weight: 400;"><a href="/mypage/memberupdateG" style="color: #bcbcbc;">회원 정보 수정</a></li>
			</ul>
		</div><!-- stickyC end -->
		</div><!-- stickyP end -->
	</div><!-- leftcontent end -->
	
	
	<div class="rightcontent">
		<div class=mylike_product row1>
			<p style="text-align: center; font-weight: bold;">관심 상품</p>
			<div class="column">
			<c:forEach var="row" items="${list_p}" varStatus="vs">
				<div class="card">
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
					</div><!-- product_name end -->
				</div><!-- card end -->
				<!-- 테이블 한줄에 3칸씩
				<c:if test="${vs.count mod 3==0 }">
					<div></div>
				</c:if> -->
			</c:forEach>
			</div><!-- column end -->
			
			<!-- 페이징 -->
			<div style="width: 100%; display: block; text-align: center;">	
				<c:if test="${requestScope.count > 0}">
					<c:set var="pageCount" value="${requestScope.totalPage}" />
					<c:set var="startPage" value="${requestScope.startPage}" />
					<c:set var="endPage" value="${requestScope.endPage}" />
			
			
						<!-- endPage는 10단위이기에 총 페이지가 end 페이지보다 작으면 그 수를 대입한다 -->
						<!-- 즉, 만약 최종 페이지 수가 22라면 30까지 표시할 필요가 없으니 엔드 페이지 수를 22로 맞춘다 -->
						<c:if test="${endPage > pageCount}">
							<c:set var="endPage" value="${pageCount}" />
						</c:if>
			
						<!-- startPage는 1, 11, 21 .. 이기에 1보다 크다면 이전 페이지 이동 가능-->
						<c:if test="${startPage > 1}">
							<a href="/mypage/mylike/all_p?pageNum=${startPage-1}">[이전]</a>
						</c:if>
			
						<!-- 현재 페이지 볼드체, 현재 페이지 외의 보이는 페이지 전부 이동 링크 걸기 -->
						<c:forEach var="i" begin="${startPage}" end="${endPage}">
							<c:choose>
								<c:when test="${pageNum == i}">
									<span style="font-weight: bold">${i}</span>
								</c:when>
								<c:when test="${pageNum != i}">
									<a href="/mypage/mylike/all_p?pageNum=${i}">${i}</a>
								</c:when>
							</c:choose>
						</c:forEach>
			
						<!-- endPage보다 총 페이지 수가 크다면 다음 pages로 이동 가능하다 -->
						<c:if test="${endPage < pageCount}">
							<a href="/mypage/mylike/all_p?pageNum=${startPage+5}">[다음]</a>
						</c:if>
				</c:if>
			</div><!-- 페이징 끝 -->
			
		</div><!-- mylike_product end -->
	</div><!-- rightcontent end -->
</div><!-- container end -->

<!-- 본문 끝 -->

<%@ include file="../footer.jsp" %>