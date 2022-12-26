<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../header.jsp" %>
<%@ include file="ssi.jsp" %>

<style>
@import url(http://fonts.googleapis.com/earlyaccess/notosanskr.css); 

	* {
		font-family: 'Noto Sans KR', sans-serif; !important;
	}

	table {border-collapse:collapse;}

	.leftcontent {
		float: left;
		width: 10%;
		margin-right: 10%;
	}
	
	.rightcontent {
		float: right;
		width: 80%;
	}
	
	.clickInfo {
		text-align: center;
		margin: 10px;
		color: #000000;
		animation-name: blink;
		animation-duration: 3s;
		animation-iteration-count: infinite;
	}
	
	@keyframes blink {
		50% {opacity: 0;}
	}
	
	
	.myticketDetail ol{
		text-align:right; 
		list-style:none; 
		padding-right:15px; 
		padding-top:15px; 
		padding-bottom:15px; 
		font-size:18px; 
		font-weight:bold;
	}
	
	.btnDIV {
		margin-left:40px;
		margin-right:200px;
		width:550px;
		padding-top:20px;
		padding-bottom:80px;
		text-align:center;
	}
	
	
	
	.bill{
		margin-left:40px;
		margin-right:40px;
		width:550px;
		border: 1px solid black;
		padding: 60px 10px 10px 10px;
	}
	
	.myticketDetail h1{
		display:inline-block;
		float:left;
	}
	
	.product-image {
		display:inline-block;
		width: 550px;
		margin-left: 40px;
		padding-bottom: 40px;
		text-align: right;
	}
	
	.product-image img{
	    width: 180px;
	    float:right;
	}
	
	table{
		width:550px;
	}
	
	.topLine{
		border-top: 1.5px solid black;
	}
	
	.alignRight{
		text-align:right;
	}
	
	.paddingBottom{
		padding-bottom:40px;
	}


	

	.cnlBtn {
	  width: 100px;
	  padding-top: 12px;
	  padding-bottom: 12px;
	  margin: 0 10px 0 10px;
	  border: none;
	  background-color: black;
	  color: white;
	}
	
	.bckBtn {
	  width: 100px;
	  padding-top: 12px;
	  padding-bottom: 12px;
	  margin: 0 10px 0 10px;
	  border: none;
	  background-color: white;
	  color: black;
	  border: 1px solid black;
	}

	
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
				<li class="side_liT" style="color: lightgreen;">My ticket
					<li>&nbsp;<a href="/mypage/myticket" style="color:black; font-size: 12px;">- 예매 확인 / 취소</a></li>
				</li>
				<br>
				<li class="side_liT">My product
					<li>&nbsp;<a href="/mypage/myproduct" style="color:black; font-size: 12px;">- 상품 구매내역</a></li>
					<li>&nbsp;<a href="/mypage/myqna" style="color:black; font-size: 12px;">- 나의 문의내역</a></li>
				</li>
				<br>
				<li class="side_liT">My like
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
	<div class="myticketDetail">
		<div class="product-image">
			<h6 style="width:60px; border-bottom:2px solid black;"></h6>
			<h1 style="width:40px;">${detail.title}</h1>
			<%-- <a href="detail/${row.pro_no}"><img src="/storage/${row.postername}" width="300px" height="400px"></a> --%>
			<a href="/concert/${detail.c_no}"><img src="/storage/${detail.postername}"></a>
		</div>
		<div class="bill">
			<table class="table">
			<tr>
				<th colspan='2' class="alignRight">주문번호 : ${detail.tck_num}</th>
			</tr>
			<tr class="topLine">
				<th colspan='2'>티켓 좌석번호</th>
			</tr>
			<c:forEach items="${list}" var="row" varStatus="vs">
				<tr>
					<td style="width:50%;">${row.cseat}</td>
					<td class="alignRight"><fmt:formatNumber value="${row.price}" type = "currency"/></td>
				</tr>
			</c:forEach><!-- c:forEach end -->	
			<tr class="topLine paddingBottom">
				<th class="paddingBottom">총 수량</th>
				<td class="alignRight">${detail.cnt}매</td>
			</tr>
			<tr><td></td><td></td></tr>
			<tr><td></td><td></td></tr>
			<tr><td></td><td></td></tr>
			<tr class="topLine">
				<th class="paddingBottom">주문 금액</th>
				<td class="alignRight"><fmt:formatNumber value="${detail.order_price}" type = "currency"/></td>
			</tr>	
			<tr>
				<th>할인 금액</th>
				<td class="alignRight">-<fmt:formatNumber value="${detail.dis_price}" type = "currency"/></td>
			</tr>	
			<tr>
				<td class="paddingBottom"></td>
				<td class="alignRight">${detail.dis_descrip}</td>
			</tr>					
			<tr><td></td><td></td></tr>
			<tr><td></td><td></td></tr>
			<tr><td></td><td></td></tr>
			<tr class="topLine">
				<th>배송비</th>
				<c:choose>
					<c:when test="${detail.d_fee == 0}">
						<td class="alignRight">현장수령</td>
					</c:when>
					<c:otherwise>
						<td class="alignRight"><fmt:formatNumber value="${detail.d_fee}" type = "currency"/></td>
					</c:otherwise>
				</c:choose>
			</tr>
			<tr><td></td><td></td></tr>
			<tr><td></td><td></td></tr>
			<tr><td></td><td></td></tr>
			<tr class="topLine">
				<th class="paddingBottom">최종 결제금액</th>
				<td class="alignRight"><fmt:formatNumber value="${detail.total_price}" type = "currency"/></td>
			</tr>	
			<tr><td></td><td></td></tr>
			<tr><td></td><td></td></tr>
			<tr><td></td><td></td></tr>
			<tr>
				<th colspan="2" style="text-align:center;">수령인 정보</th>
			</tr>
			<tr class="topLine">
				<th>받는사람</th>
				<td>${detail.rec_name}</td>
			</tr>	
			<tr>
				<th>핸드폰번호</th>
				<td>${detail.rec_tel}</td>
			</tr>
			<c:choose>
				<c:when test="${detail.d_fee == 0}">
					<!-- 현장수령이면 주소,메세지 표시 안함 -->
				</c:when>
				<c:otherwise>
					<tr>
						<th>우편번호</th>
						<td>${detail.rec_zipcode}</td>
					</tr>
					<tr>
						<th>주소</th>
						<td>${detail.rec_addr1}</td>
					</tr>
					<tr>
						<th>상세주소</th>
						<td>${detail.rec_addr2}</td>
					</tr>
					<tr>
						<th class="paddingBottom">배송메세지</th>
						<td>${detail.msg}</td>
					</tr>
				</c:otherwise>
			</c:choose>
			<tr><td></td><td></td></tr>
			<tr><td></td><td></td></tr>
			<tr><td></td><td></td></tr>
			<tr class="topLine">
				<th class="paddingBottom">결과상태</th>
				<td>${detail.stus}</td>
			</tr>					
			</table>
		</div><!-- bill end -->
		<div class="btnDIV">
				<!--  
				<button type="button" onclick="location.href='/mypage/myticket/delete/${detail.tck_num}'">결제취소</button>
				-->
				<button class="cnlBtn" onclick="location.href='/mypage/myticket/cancelPolicy/${detail.tck_num}'">결제취소</button>
				<button class="bckBtn" onclick="location.href='/mypage/myticket'">목록으로</button>
			
		</div><!-- 결제취소 / 목록으로 -->
	</div><!-- myticketDetail end -->
</div><!-- rightcontent end -->
</div><!-- container1 end -->


<!-- 본문 끝 -->



<script>


</script>






<%@ include file="../footer.jsp" %>