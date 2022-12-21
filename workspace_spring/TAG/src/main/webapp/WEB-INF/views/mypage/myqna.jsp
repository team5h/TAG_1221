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
	
	.mylike_concert {
		/*border: solid 1px blue;*/
		height: 50%;
	}
	
	.mylike_concert p {
		border-bottom: solid 3px black;
	}
	
	table {
		margin-left:auto; 
    	margin-right:auto;
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
</style>

<!-- 본문 시작 -->

<div class="title">
	<h3 style="text-align: center;">나의 문의내역</h3>
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
	</div><!-- box end -->
</div><!-- leftcontent end -->


<div class="rightcontent">
	<div id="myqna">
		<p style="text-align: center;">답변 완료</p>
		<c:if test="${empty myqna}">
			<p>답변 완료된 문의내역이 없습니다.</p>
		</c:if>

		<c:forEach var="row" items="${myqna}" varStatus="vs">
			<button type="button" class="mysubject">
				<span>${row.subject}</span>
				<span>${row.qdate}</span>
			</button>
			<div class="content">
				<p>${row.edit}</p>
				<p>
					<a href="/product/${row.pro_no}"><img src="/storage/${row.postername}" width="100px"></a>
					<a href="/product/${row.pro_no}">[해당 상품 보러가기]</a>
				</p>
				<hr>
				<p>${row.adate}</p>
				<p>${row.content}</p>
			</div>
		</c:forEach>
	</div><!-- myqna end -->
		
	<div id="notAyet">
		<p style="text-align: center;">답변 대기</p>
		<c:if test="${empty notAyet}">
			<p>답변 대기중인 문의내역이 없습니다.</p>
		</c:if>

		<c:forEach var="row" items="${notAyet}" varStatus="vs">
			<button type="button" class="mysubject">
				<span>${row.subject}</span>
				<span>${row.regdate}</span>
			</button>
			<div class="content">
				<p>${row.edit}</p>
				<hr>
				<p>아직 답변이 등록되지 않았습니다.</p>
			</div>
		</c:forEach>
	</div><!-- notAyet end -->
	
</div><!-- rightcontent end -->

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