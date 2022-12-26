<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../header.jsp" %>
<%@ include file="ssi.jsp" %>

<style>
@import url(http://fonts.googleapis.com/earlyaccess/notosanskr.css); 

	* {
		font-family: 'Noto Sans KR', sans-serif; !important;
		box-sizing: border-box;
	}

	.leftcontent {
		float: left;
		width: 10%;
		/*border: 1px solid black;*/
		margin-right: 10%;
	}
	
	.rightcontent {
		float: right;
		width: 80%;
		/*border: 1px solid black;*/
	}
		
	.column {
		/*float: left;*/
		padding: 0 10px;
		display: flex;
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
		/*background-color: #f1f1f1;*/
	}
	
	.card a { color: black; }
	
	.card a:hover { color: lightgreen; }
	
	table {
		margin-left: auto;
		margin-right: auto;
	}
	
	.btnCenter { text-align: center; display: block; margin: 20px 0 0 839px; }
</style>

<!-- 본문 시작 -->

<br>
	<h1 class="saem_title fontJ"><a href="/mypage/mypageG" style="color: black;" class="saem_title fontJ"> My Page </a></h1>
<br>

<div class="container1">
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
		<div class="mylike_concert row1">
			<c:if test="${conCnt == 0}">
				<p style="text-align: center;">관심 공연이 없습니다.</p>
				<p style="text-align: center;">공연 목록에서 좋아요를 눌러서 관심 공연으로 추가해 보세요!</p>
			</c:if>
			
			<c:if test="${conCnt != 0}">
			<p style="text-align: center;">관심 공연</p>
			<br>
			<table>
				<tr class="column">
				<c:forEach var="row" items="${like_c}" varStatus="vs">
					<td class="card">
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
						</div><!-- concert_name end -->
					</td><!-- card end -->
					
				</c:forEach>
				
				</tr><!-- column end -->
			</table>
			<c:if test="${conCnt > 1 }">
				<button type="button" class="btn btn-outline-black btn-sm btnCenter" onclick="location.href='/mypage/mylike/all_c'" style="width: 80px; padding: 2px 2px 2px 2px; font-weight: 400; font-size: 14px; display: block;">전체보기</button>
			</c:if>
			
			</c:if>
		</div><!-- mylike_concert end -->
		
		<br>
		<br>
		<br>
		<div class="mylike_product row1">
			<c:if test="${proCnt == 0}">
				<p style="text-align: center;">관심 상품이 없습니다.</p>
				<p style="text-align: center;">상품 목록에서 좋아요를 눌러서 관심 상품으로 추가해 보세요!</p>
			</c:if>
			
			<c:if test="${proCnt != 0}">
			<p style="text-align: center;">관심 상품</p>
			<br>
			<table>
				<tr class="column">
				<c:forEach var="row" items="${like_p}" varStatus="vs">
					<td class="card">
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
					</td><!-- card end -->
					
				</c:forEach>
				
				</tr><!-- column end -->
			</table>
			<c:if test="${proCnt > 1 }">
				<button type="button" class="btn btn-outline-black btn-sm btnCenter" onclick="location.href='/mypage/mylike/all_p'" style="width: 80px; padding: 2px 2px 2px 2px; font-weight: 400; font-size: 14px; display: block;">전체보기</button>
			</c:if>
			
			</c:if>
		</div><!-- mylike_product end -->
	</div><!-- rightcontent end -->
</div><!-- container1 end -->

<!-- 본문 끝 -->

<%@ include file="../footer.jsp" %>