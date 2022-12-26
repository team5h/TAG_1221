<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%@ include file="../header.jsp" %>
<%@ include file="ssi.jsp" %>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Jost:wght@100;200;300;400;500;600;700;800;900&family=Mulish:wght@200;300;400;500;600;700;800;900;1000&display=swap" rel="stylesheet">

<style>
@import url(http://fonts.googleapis.com/earlyaccess/notosanskr.css); 

	* {
		font-family: 'Noto Sans KR', sans-serif; !important;
	}

	.leftcontent {
		float: left;
		width: 10%;
		/*margin-left:0px;
		border: 1px solid black;
		margin-right: 10%;*/
	}
	
	.rightcontent {
		float: right;
		width: 70%;
	}
	
	.mysubject {
	  background-color: #777;
	  color: white;
	  cursor: pointer;
	  padding: 18px;
	  width: 100%;
	  border: none;
	  text-align: left;
	  outline: none;
	  font-size: 15px;
	}
	
	.activ, .mysubject:hover {
	  background-color: #555;
	}
	
	.mysubject:after {
	  content: '\002B';
	  color: white;
	  font-weight: bold;
	  float: right;
	  margin-left: 5px;
	}
	
	.activ:after {
	  content: "\2212";
	}
	
	.content {
	  padding: 0 18px;
	  max-height: 0;
	  overflow: hidden;
	  transition: max-height 0.2s ease-out;
	  background-color: #f1f1f1;
	}
	
	.rightcontent a { color: black; }
	
	.rightcontent a:hover { color: lightgreen; }
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
				<li class="side_liT" style="color: lightgreen;">My product
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
		<div id="myqna">
			<p style="text-align: center;">답변 완료</p>
			<br>
			<c:if test="${empty myqna}">
				<p>답변 완료된 문의내역이 없습니다.</p>
			</c:if>
	
			<c:forEach var="row" items="${myqna}" varStatus="vs">
				<button type="button" class="mysubject">
					<span>${row.subject}</span>
					&nbsp;&nbsp;&nbsp;
					<span>${row.qdate}</span>
				</button>
				<div class="content">
					<b style="color: lightgreen">Q.</b>
					<p>${row.edit}</p>
					<p>
						<a href="/product/${row.pro_no}"><img src="/storage/${row.postername}" width="100px"></a>
						<br>
						<a href="/product/${row.pro_no}">[해당 상품 보러가기]</a>
					</p>
					<hr>
					<b style="color: lightgreen">A.</b>
					<p>${row.content}</p>
					<p style="text-align: right;">${row.adate}</p>
				</div>
			</c:forEach>
		</div><!-- myqna end -->
		<br>
		<br>
			
		<div id="notAyet">
			<p style="text-align: center;">답변 대기</p>
			<br>
			<c:if test="${empty notAyet}">
				<p>답변 대기중인 문의내역이 없습니다.</p>
			</c:if>
	
			<c:forEach var="row" items="${notAyet}" varStatus="vs">
				<button type="button" class="mysubject">
					<span>${row.subject}</span>
					&nbsp;&nbsp;&nbsp;
					<span>${row.regdate}</span>
				</button>
				<div class="content">
					<b style="color: lightgreen">Q.</b>
					<p>${row.edit}</p>
					<p>
						<a href="/product/${row.pro_no}"><img src="/storage/${row.postername}" width="100px"></a>
						<br>
						<a href="/product/${row.pro_no}">[해당 상품 보러가기]</a>
					</p>
					<hr>
					<b style="color: lightgreen">A.</b>
					<p>아직 답변이 등록되지 않았습니다.</p>
				</div>
			</c:forEach>
		</div><!-- notAyet end -->
		
	</div><!-- rightcontent end -->
</div><!-- container1 end -->

<script type="text/javascript">
	var coll = document.getElementsByClassName("mysubject");
	var i;
	
	for (i = 0; i < coll.length; i++) {
	  coll[i].addEventListener("click", function() {
	    this.classList.toggle("activ");
	    var content = this.nextElementSibling;
	    if (content.style.maxHeight){
	      content.style.maxHeight = null;
	    } else {
	      content.style.maxHeight = content.scrollHeight + "px";
	    } 
	  });
	}
</script>

<!-- 본문 끝 -->

<%@ include file="../footer.jsp" %>