<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script src="https://kit.fontawesome.com/698fcd5feb.js" crossorigin="anonymous"></script>


<style>

#seatAddFormjsp table, #ticketAddFormjsp table{
	font-size:12px;
}

#seatAddFormjsp ul {
	list-style:none; 
	padding-left:0px;
	font-size:14px;
}

#panel input{
 	width: 225px;
	font-size:16px;
}

#addedSeat input {
	 width: 180px;
}


#reSelect, #goSaddForm, #goSale {
	  width: 140px;
	  height: 60px;
	  border: 1px solid black;
	  background-color: white;
	  color: black;
	  font-size:16px;
}

#goTaddForm, #goDlv {
	  width: 180px;
	  height: 60px;
	  border: none;
	  background-color: black;
	  color: white;
	  font-size:18px;
}

#goFinish {
	  width: 180px;
	  height: 60px;
	  border: none;
	  background-color: #33FF33;
	  color: black;
	  font-weight: bold;
	  font-size:18px;
}
	

</style>


<div id="seatAddFormjsp">
	<table style="border:1px solid black; height:570px; width: 347px;">
	<tr>
		<td>
			공연장소 : <c:choose>
		     			<c:when test="${concert.j_id == 'yes24'}"> yes24 라이브홀 </c:when>
		     			<c:when test="${concert.j_id == 'bluesquare'}"> 블루스퀘어 마스터홀 </c:when>
		     		 </c:choose><br>
			-> 구역이동은 미니맵을 이용해주세요
		</td>
	</tr>
	<tr>
		<td>
			미니맵 이미지
			<button type="button" id="map1F" name="map1F">1층 맵</button>
			<button type="button" id="map2F" name="map2F">2층 맵</button>
		</td>
	</tr>
	<tr>
		<td>좌석등급 / 가격</td>
	</tr>
	<tr>
		<td>
			<ul>
				<li value="${concert.price}">
					<button type="button" style="background:palegreen; border:none; height:12px; width:12px; padding:0;"></button>
					스탠딩 R <fmt:formatNumber value="${concert.price}" pattern="#,###"/>원
				</li>
				<li id="R" value="${concert.price}">
					<button type="button" style="background:mediumslateblue; border:none; height:12px; width:12px; padding:0;"></button>
					지정석 R <fmt:formatNumber value="${concert.price}" pattern="#,###"/>원
				</li>
				<li id="S" value="${concert.price-11000}">
					<button type="button" style="background:dodgerblue; border:none; height:12px; width:12px; padding:0;"></button>
					지정석 S <fmt:formatNumber value="${concert.price-11000}" pattern="#,###"/>원
				</li>
				<li id="A" value="${concert.price-22000}">
					<button type="button" style="background:darkcyan; border:none; height:12px; width:12px; padding:0;"></button>
					지정석 A <fmt:formatNumber value="${concert.price-22000}" pattern="#,###"/>원
				</li>
			</ul>
		</td>
	</tr>
	<tr>
		<td>선택한 좌석 | <input style="display:inline-block; width:210px; text-align:right; color:red;" type="text" id="seatCnt" value="총 0석 선택하였습니다"></td>
	</tr>
	<tr>
		<td>
			<div id="panel" style="height:100px; overflow-y:scroll; margin:0; padding:auto;">
			<!-- 
			
			 -->
			</div>
		</td>
	</tr>
	<tr>
		<td style="text-algin:center;">
			<button type="button" id="reSelect" name="reSelect" onclick="reSelectFN()">
				다시 선택 <i class="fa-solid fa-arrow-rotate-left"></i>
			</button>
			
			<button type="button" id="goTaddForm" name="goTaddForm">
				좌석 선택 완료 <i class="fa-solid fa-arrow-right" style="color:white;"></i>
			</button>
		</td>
	</tr>
	</table>
</div>

<div id="ticketAddFormjsp">
	<input type="hidden" name="tck_num" value="00000000-00000000"><!-- 예매번호 -->
	<input type="hidden" name="cnt" id="cnt" value="0"><!-- 수량 -->
	<input type="hidden" name="order_price" id="order_price" value="0"><!-- 주문금액 -->
	<input type="hidden" name="dis_price" id="dis_price" value="0"><!-- 할인금액 -->
	<input type="hidden" name="d_fee" id="d_fee" value="0"><!-- 배송비 -->
	<input type="hidden" name="total_price" id="total_price" value="0"><!-- 최종결제금액 -->
	<input type="hidden" name="dis_descrip" id="dis_descrip" value="할인내용"><!-- 할인내용 -->
	<input type="hidden" name="stus" value="결제완료"><!-- 결과상태 -->
	<table style="border:1px solid black; height:570px; width: 347px;">
	<tr style="width:346px; height:137px;">
		<td style="width:28%; background:lightgrey; padding:0;">
			<img style="width:100%;" src="/storage/${concert.postername}">
		</td>
		<td style="--width:70%;">
			<b style="font-size:14px;">${concert.title}</b><br>
			<hr>
			관람연령 : ${concert.watch_age}<br>
			공연사 : 
			<c:choose>
     			<c:when test="${concert.com_name == '라이브네이션코리아'}"> LIVENATION </c:when>
     			<c:when test="${concert.com_name == '긱가이드'}"> gigguide </c:when>
     			<c:when test="${concert.com_name == '프라이빗커브'}"> PRIVATE CURVE </c:when>
	     	</c:choose>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<strong>My 예매정보</strong>
		</td>
	</tr>
	<tr>
		<td style="background:lightgrey;">날짜</td>
		<td><fmt:parseDate var="regDate" value="${concert.date}" pattern="yyyy-MM-dd"/>
			<fmt:formatDate value="${regDate}" pattern="yyyy. MM. dd (E)"/></td>
	</tr>
	<tr>
		<td style="background:lightgrey;">시간</td>
		<td><fmt:formatDate value="${concert.start_time}" type="time" pattern="a hh:mm" /> - 
			<fmt:formatDate value="${concert.end_time}" type="time" pattern="hh:mm" /></td>
	</tr>
	<tr>
		<td style="background:lightgrey;">매수</td>
		<td><input type="text" id="ticketCount"></td><!-- 수량 -->
	</tr>
	<tr>
		<td style="background:lightgrey;">선택한 좌석</td>
		<td>
			<div id="addedSeat" style="height:80px; overflow-y:scroll;">
			<!-- 
				S석 2층 Z구역 2열 5번<br>
				S석 2층 Z구역 2열 5번<br>
				S석 2층 Z구역 2열 5번<br>
				S석 2층 Z구역 2열 5번<br>
			 -->
			</div>
		</td>
	</tr>
	<tr>
		<td style="background:lightgrey;">티켓금액</td>
		<td><input type="text" id="originPrice"></td><!-- 주문금액 -->
	</tr>
	<tr>
		<td style="background:lightgrey;">배송료</td>
		<td>
			<input style="display:inline-block; width:80px;" type="text" id="dlvPrice" value="0원"><!-- 배송비 -->
			 | 
			<input style="display:inline-block; width:50px;" type="text" id="dlvText" value="현장수령">
		</td>
	</tr>
	<tr>
		<td style="background:lightgrey;">할인금액</td>
		<td><input type="text" id="discountPrice"></td><!-- 할인금액 -->
	</tr>
	<tr>
		<td style="background:lightgrey;">총 결제금액</td>
		<td><input type="text" id="totalPrice"></td><!-- 최종결제금액 -->
	</tr>
	<tr>
		<td colspan="2">
			<button type="button" id="goSaddForm" name="goSaddForm"><i class="fa-solid fa-chevron-left"></i> 이전단계</button><!-- 1.좌석선택으로 -->
			<button type="button" id="goSale" name="goSale"><i class="fa-solid fa-chevron-left"></i> 이전단계</button><!-- 2.가격할인으로 -->
			<button type="button" id="goDlv" name="goDlv">다음단계 <i class="fa-solid fa-chevron-right"></i></button><!-- 3.배송현장수령으로 -->
			<button type="submit" id="goFinish" name="goFinish">결제완료 <i class="fa-solid fa-check"></i></button><!-- 결제완료 -->
		</td>
	</tr>
	</table>
</div>