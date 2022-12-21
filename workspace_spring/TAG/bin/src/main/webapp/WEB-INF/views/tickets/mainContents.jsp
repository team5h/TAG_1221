<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn"   uri="http://java.sun.com/jsp/jstl/functions"%>
<script src="https://kit.fontawesome.com/698fcd5feb.js" crossorigin="anonymous"></script>

<style>

.barBtn{
	padding-left:450px;
	height:40px;
}

.barBtn .bar1{
	margin-left:-200px;
	background:#99ff99;
	color: black;
	border-radius: 10px 50px 50px 10px;
	border: 3px solid white;
}

.barBtn .bar2{
	margin-left:-200px;
	background:black;
	color: white;
	border-radius: 10px 50px 50px 10px;
	border: 3px solid white;
}

.barBtn .bar3{
	margin-left:10px;
	background:black;
	color: white;
	border-radius: 10px 50px 50px 10px;
	border: 3px solid white;
}

.stageBar {
	height:60px;
	background: lightgrey;
	text-align:center;
	padding: auto;
	margin-right:50px;
}

.stageBar b{
	font-size:36px;
	color:gray;
}


#ticketSalejsp p{
	font-size:12px;
}

#ticketSalejsp b{
	font-size:12px;
}

/* 테이블 */
.stb {
	width:740px;
	margin-left:40px;
	margin-top:3px;
	font-size:14px;
	align:center;
}

.stb td, .stb th {
	padding:2px;
	text-align:center;
}


.stb select {
    width: 115px;
	border-bottom: 1px solid black;
    font-size: 14px;
}

.stb input {
    width: 115px;
    text-align:center;
    font-size: 14px;
}



.ktb, .jtb {
	border-collapse:collapse;
	width: 600px;
	margin-top:3px;
	margin-bottom:3px;
}

.ktb td, .jtb td {
    border: 1px solid gray;
    line-height:25px;
    padding:2px;
    padding-left:6px;
    font-size:10px;
}




</style>






<div id="map1Fjsp">
	<!-- <h2>좌석선택-가격할인-배송현장수령</h2> -->
	<div class="barBtn">
	    <button type="button" class="btn bar3">수령방법</button>
	    <button type="button" class="btn bar2">할인선택</button>
	    <button type="button" class="btn bar1">좌석선택</button>
	</div>
	<br>
	<h5>스탠딩 1층</h5>
	<p>스탠딩은 실제 좌석과 다르며 예매시 지정하는 번호가 입장 번호 순서입니다. 빠른 번호를 예매 할수록 입장 순서가 빨라집니다.</p>
	
	<div class="stageBar">
		<b>STAGE</b>
	</div>
	
	<div id="standA" style="display: inline-block; margin-right:40px; margin-top:20px;">
		<h6>스탠딩 A구역</h6>
		<table style="border-spacing: 0;">
			<tr>
			<c:forEach var="seatA" begin="1" end="825" step="1">
				<td>
					<input type="button" id=btnA${seatA} name=btnA${seatA} value="${seatA}" onclick="standAdd(this, 'A', ${seatA})">
				</td>
				<c:if test="${seatA mod 33 == 0}">
					<tr></tr>
				</c:if>
			</c:forEach>
			</tr>
		</table>
	</div>
	<div id="standB" style="display: inline-block;">
		<h6>스탠딩 B구역</h6>
		<table style="border-spacing: 0;">
			<tr>
			<c:forEach var="seatB" begin="1" end="825" step="1">
				<td>
					<input type="button" id=btnB${seatB} name=btnB${seatB} value="${seatB}" onclick="standAdd(this, 'B', ${seatB})">
				</td>
				<c:if test="${seatB mod 33 == 0}">
				<!-- 테이블 한줄에 30개씩 -->
					<tr></tr>
				</c:if>
			</c:forEach>
			</tr>
		</table>
	</div>
</div><!-- map1Fjsp end -->

<div id="map2Fjsp">
	<div class="barBtn">
	    <button type="button" class="btn bar3">수령방법</button>
	    <button type="button" class="btn bar2">할인선택</button>
	    <button type="button" class="btn bar1">좌석선택</button>
	</div>
	<br>
	<h5>지정석 2층</h5>
	<p>객석 2층은 지정좌석제입니다.</p>
	
	<div class="stageBar">
		<b>STAGE</b>
	</div>
	
	<div id="rseatX" style="display: inline-block; margin-left:40px;  margin-top:20px;">
		<h6>지정좌석 X구역</h6>
		<table style="border-spacing: 0;">
			<tr>
			<!-- X구역 행마다 들어가는 빈공간 배열 선언 -->
			<c:set var="nullX" value="<%=new int[] {0,1,2,3,3,5,6} %>"/>
			<!-- "seatX" 좌석의 고유번호(flags의 갯수와 일치) -->
			<c:set var="seatX" value="0"/>
			
			<c:forEach var="r" begin="1" end="${fn:length(nullX)}" step="1">
				<c:forEach var="nullXtd" begin="1" end="${nullX[r-1]}" step="1">
					<td></td>
				</c:forEach><!-- nullX end -->
				<c:forEach var="c" begin="1" end="${15-nullX[r-1]+1}" step="1">
					<td>
						<c:if test="${c <= (15-nullX[r-1])}">
							<!-- ${seatX} 1씩 늘어나게하기 -->
							<c:set var="seatX" value="${seatX+1}"/>
							<input type="button" id=btnX${seatX} name=btnX${seatX} value="${c}" onclick="rseatAdd(this, 'X', ${r}, ${seatX})">
						</c:if>
						<c:if test="${c == (15-nullX[r-1]+1)}">
							<button disabled>${r}</button>
							<tr></tr>
						</c:if>
					</td>
				</c:forEach><!-- c end -->
			</c:forEach><!-- r end -->
			</tr>
		</table>
	</div><!-- id="rseatX" end -->
	<div id="rseatY" style="display: inline-block;">
		<h6>지정좌석 Y구역</h6>
		<table style="border-spacing: 0;">
			<tr>
			<!-- Y구역 행마다 들어가는 빈공간 배열 선언 -->
			<c:set var="nullYL"   value="<%=new int[] {4,3,3,2,1,0,1} %>"/><!-- Left -->
			<c:set var="nullYR"   value="<%=new int[] {3,3,2,1,1,0,1} %>"/><!-- Right -->
			<c:set var="nullYAll"   value="<%=new int[] {7,6,5,3,2,0,2} %>"/><!-- L+R -->
			<!-- "seatY" 좌석의 고유번호(flags의 갯수와 일치) -->
			<c:set var="seatY" value="0"/>
			
			<c:forEach var="r" begin="1" end="${fn:length(nullYL)}" step="1">
				<c:forEach var="nullYLtd" begin="1" end="${nullYL[r-1]}" step="1">
					<td></td>
				</c:forEach><!-- nullYL end -->
				<c:forEach var="c" begin="1" end="${28-nullYAll[r-1]}" step="1">
					<c:choose><%-- if else문 --%>
						<c:when test="${r == 7 && c <= 11}"><!-- 7열 11번째 좌석까지 생성 -->
							<td>
								<c:set var="seatY" value="${seatY+1}"/>
								<input type="button" id=btnY${seatY} name=btnY${seatY} value="${c}" onclick="rseatAdd(this, 'Y', ${r}, ${seatY})">
							</td>
						</c:when>
						<c:when test="${r == 7 && c >= 16}"><!-- 7열 16번째 좌석부터 생성 -->
					    	<td>
								<c:set var="seatY" value="${seatY+1}"/>
								<input type="button" id=btnY${seatY} name=btnY${seatY} value="${c-4}" onclick="rseatAdd(this, 'Y', ${r}, ${seatY})">
							</td>
						</c:when>
						<c:when test="${r == 7 && c > 11 && c < 16}"><!-- 7열 빈 좌석 생성 -->
					    	<td></td>
						</c:when>
						<c:otherwise><!-- 그 외 일반 -->
					    	<td>
								<c:set var="seatY" value="${seatY+1}"/>
								<input type="button" id=btnY${seatY} name=btnY${seatY} value="${c}" onclick="rseatAdd(this, 'Y', ${r}, ${seatY})">
							</td>
					  	</c:otherwise>
					</c:choose><!-- choose end -->
				</c:forEach><!-- c end -->
				<c:forEach var="nullYRtd" begin="1" end="${nullYR[r-1]+1}" step="1">
					<td>
						<c:if test="${nullYRtd == nullYR[r-1]+1 }">
							<button disabled>${r}</button>
							<tr></tr>
						</c:if>
					</td>
				</c:forEach><!-- nullYR end -->
			</c:forEach><!-- r end -->
			</tr>
		</table>
	</div><!-- id="rseatY" end -->
	<div id="rseatZ" style="display: inline-block;">
		<h6>지정좌석 Z구역</h6>
		<table style="border-spacing: 0;">
			<tr>
			<!-- Z구역 행마다 들어가는 빈공간 배열 선언 -->
			<c:set var="nullZ" value="<%=new int[] {0,1,2,3,3,5,6} %>"/>
			<!-- "seatX" 좌석의 고유번호(flags의 갯수와 일치) -->
			<c:set var="seatZ" value="0"/>
			
			<c:forEach var="r" begin="1" end="${fn:length(nullZ)}" step="1">
				<c:forEach var="c" begin="1" end="${15-nullZ[r-1]}" step="1">
					<td>
						<!-- ${seatZ} 1씩 늘어나게하기 -->
						<c:set var="seatZ" value="${seatZ+1}"/>
						<input type="button" id=btnZ${seatZ} name=btnZ${seatZ} value="${c}" onclick="rseatAdd(this, 'Z', ${r}, ${seatZ})">
					</td>
				</c:forEach><!-- c end -->
				<c:forEach var="nullZtd" begin="0" end="${nullZ[r-1]}" step="1">
					<td>
						<c:if test="${nullZtd == nullZ[r-1] }">
							<tr></tr>
						</c:if>
					</td>
				</c:forEach><!-- null end -->
			</c:forEach><!-- r end -->
			</tr>
		</table>
	</div><!-- id="rseatZ" end -->
</div><!-- map2Fjsp end -->	

<div id="ticketSalejsp">
	<div class="barBtn">
	    <button type="button" class="btn bar3">수령방법</button>
	    <button type="button" class="btn bar2" style="background:#99ff99; color: black;">할인선택</button>
	    <button type="button" class="btn bar1" style="background:black; color: white;">좌석선택</button>
	</div>
	<br>
	<h5>
		<i class="fa-solid fa-money-check-dollar"></i> 할인 선택
	</h5>
	<p>할인은 자동선택 되지 않으니, 적용 받고자하는 할인이 있는 경우 직접 선택해주시기 바랍니다.</p>
	<table class="stb">
	<tr style="background:black; color:white;">
		<th>등급</th>
		<th>할인명</th>
		<th>할인금액</th>
		<th>매수</th>
		<th>설명</th>
	</tr>
	<tr>
		<td style="background:lightgrey;">R석</td>
		<td>
			<select name="disSelectR">
				<option value="N">-선택없음-</option>
				<option value="J">장애인 할인</option>
				<option value="K">국가유공자 할인</option>
			</select>
		</td>
		<td>
			<input type="text" id="disPriceR" value="0원">
		</td>
		<td>
			<select name="disCntR">
				<option value="0">-선택없음-</option>
			</select>
		</td>
		<td>
			<input type="text" id="disDesR" value="일반 기본가">
		</td>
	</tr>
	<tr>
		<td style="background:lightgrey;">S석</td>
		<td>
			<select name="disSelectS">
				<option value="N">-선택없음-</option>
				<option value="J">장애인 할인</option>
				<option value="K">국가유공자 할인</option>
			</select>
		</td>
		<td>
			<input type="text" id="disPriceS" value="0원">
		</td>
		<td>
			<select name="disCntS">
				<option value="0">-선택없음-</option>
			</select>
		</td>
		<td>
			<input type="text" id="disDesS" value="일반 기본가">
		</td>
	</tr>
	<tr>
		<td style="background:lightgrey;">A석</td>
		<td>
			<select name="disSelectA">
				<option value="N">-선택없음-</option>
				<option value="J">장애인 할인</option>
				<option value="K">국가유공자 할인</option>
			</select>
		</td>
		<td>
			<input type="text" id="disPriceA" value="0원">
		</td>
		<td>
			<select name="disCntA">
				<option value="0">-선택없음-</option>
			</select>
		</td>
		<td>
			<input type="text" id="disDesA" value="일반 기본가">
		</td>
	</tr>
	</table>
	<br>
	<hr>
	<h6>
		<i class="fa-regular fa-handshake"></i> 장애인·국가유공자 이용안내
	</h6>
	<b>장애인</b>
	<table class="jtb" style="margin-bottom:10px;">
	<tr>
		<td>구 분</td>
		<td>장애인 복지카드 소지자 (1급~3급 / 중증)</td>
		<td>장애인 복지카드 소지자 (4급이하 / 경증)</td>
	</tr>
	<tr>
		<td>공연</td>
		<td>본인 및 동반 1인 30%</td>
		<td>본인 30%</td>
	</tr>	
	</table>
	<b>국가유공자</b>
	<table class="ktb">
	<tr>
		<td>구 분</td>
		<td>국가유공자 본인 및 동반 1인</td>
		<td>국가유공자 유족증 소지자 본인</td>
		<td>국가유공자 배우자(국가유공자 동반시)</td>
	</tr>
	<tr>
		<td>공연</td>
		<td>30% 할인</td>
		<td>30% 할인</td>
		<td>30% 할인</td>
	</tr>	
	</table>
	<p>
		법률에서 정한 국가유공자(독립유공자, 5·18민주유공자, 특수임무유공자), 참전유공자 기준으로 할인 제공<br>
		국가유공자 배우자는 가족관계증명서와 신분증을 함께 제시하여야 한다.
	</p>
</div>

<div id="ticketDeliveryjsp">
	<div class="barBtn">
	    <button type="button" class="btn bar3" style="background:#99ff99; color: black;">수령방법</button>
	    <button type="button" class="btn bar2">할인선택</button>
	    <button type="button" class="btn bar1" style="background:black; color: white;">좌석선택</button>
	</div>
	<h3>* 배송선택/주문자확인 *</h3>
	<table>
	<tr>
		<td>수령방법선택</td>
		<td>
			<input type="radio" id="dlvBtn" name="deliverBtn" value="3000" onclick="dlvSelected()"><!-- value 3000원 -->
 				<label for="dlvBtn">배송</label><br>
 				<input type="radio" id="pUpBtn" name="deliverBtn" value="0" onclick="pUpSelected()" checked><!-- value 0원 -->
 				<label for="pUpBtn">현장수령</label><br>
		</td>
	</tr>
	<tr>
		<td colspan='2'>주문자확인</td>
	</tr>
	<tr>
		<td><label for="rec_name">이름</label></td>
		<td><input type="text" id="rec_name" name="rec_name" value="정다슬"></td>
	</tr>
	<tr>
		<td><label for="rec_tel">연락처</label></td>
		<td><input type="text" id="rec_tel" name="rec_tel" value="010-1234-1234"></td>
	</tr>
	<!-- 
	<tr>
		<td><label for="rec_email">이메일</label></td>
		<td><input type="text" id="rec_email" value="mktmf1226@gmail.com"></td>
	</tr>
	 -->
	<tr>
		<td><label for="rec_addr">받는주소</label></td>
		<td><input type="text" id="rec_addr" name="rec_addr" value="서울시 관악구"></td>
	</tr>
	<tr>
		<td><label for="msg">배송메세지</label></td>
		<td><input type="text" id="msg" name="msg" value="배송 전 연락바랍니다."></td>
	</tr>				
	</table>
</div><!-- ticketDeliveryjsp end -->