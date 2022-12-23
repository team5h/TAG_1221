<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="ssi.jsp" %>
<%@ include file="../header.jsp" %>

<style>
.btn.naverbtn {
  background: transparent;
  border-color: #000000;
  color: #000000; 
}

.btn.naverbtn:hover {
  color: white;
  background: #19ce60;
}

input[type="checkbox"] + label:before {
  content: '';
  display: block;
  width: 18px;
  height: 18px;
  border: 1px solid white;
  position: absolute;
  left: 0;
  top: 0;
  opacity: .6;
  -webkit-transition: all .12s, border-color .08s;
  transition: all .12s, border-color .08s;
}

.btn.btn-outline-blackkk{
    background-color: white;
    width: 100%;
    margin-top: 20px;
    font-size: 14px;
    border: 1px solid white;
    font-weight: 400;
}

.btn.btn-outline-blackkk:hover {
  background: lightgreen;
}
</style>

<!-- 본문영역 -->
<div class="totalwrap">
  <div class="wrapcont">
	
	<h2 class="saem_title">ORDER</h2>	
	
	<div style="font-size:13px;">
		<span style="color:#b8b8b8" class="fontG"> 01 LIST CHECK </span> <span style="color:#D7DBDD"> &nbsp; > &nbsp; </span> 
		<span class="fontG" style="font-weight: 500;"> 02 ORDER </span> <span style="color:#D7DBDD"> &nbsp; > &nbsp; </span>  
		<span style="color:#b8b8b8" class="fontG"> 03 ORDER CONFIRM </span> 
	</div>

<form  action="/product/orderProc"  onsubmit="return orderCheck()"> <!-- 하단 스크립트 --> 
	<input type="hidden" value="${order_proinfo.pro_no}" name="pro_no">
	<input type="hidden" value="" id="Fcp_dis" name="cp_dis">
	<input type="hidden" value="" id="Fd_fee" name="d_fee">
	<input type="hidden" value="" id="Ftotal_price" name="total_price">
	<input type="hidden" value="${(order_proinfo.price * buystock)}" name="order_price">
	<input type="hidden" value="<fmt:formatNumber type="number" maxFractionDigits="0"  value="${(order_proinfo.price * buystock)*0.01}"/>" name="pt_plus">
	<input type="hidden" value="${buystock}" name="detail_cnt">
	<!-- <input type="hidden" value="" id="discount" name="discount"> -->
	<input type="hidden" value="" id="Fpt_minus" name="pt_minus">
	
	<div style="padding:0 10px; width: 60%; display: inline-block;"> 
		<div style="margin-top: 50px; margin-bottom: 30px;"> 
			<p style="font-weight: 600; padding-bottom: 5px; margin-bottom: 30px; border-bottom: 2px solid;">배송 정보</p>
			
			<div style="width: 15%; display: inline-block; font-size: 13px; line-height: 2.6;"> 
				<p> 수령인 </p>
				<p> 연락처 </p>
				<p> 배송지 </p>
				<br><br><br>
				<p> 배송메세지 </p>
			</div>
			
			<div style="display: inline-block; font-size: 13px;"> 
				<input type="text" id="rec_name" name="rec_name" value="${order_Minfo.m_name}" style="height: 40px; padding-left: 5px; display: inline-block; margin-bottom: 10px; border:1px solid #f0f0f0;">
				<span id="namealert" style="display:none; font-size:10px; color:red; padding-left: 5px;"> 받는 사람을 입력해주세요. </span>
				
				<br>
				
				<input type="text" id="rec_tel" name="rec_tel" value="${order_Minfo.m_tel}" style="height: 40px; padding-left: 5px; display: inline-block; margin-bottom: 10px; border:1px solid #f0f0f0;">
				<span id="telalert" style="display:none; font-size:10px; color:red; padding-left: 5px;"> 연락처를 입력해주세요. </span>
				
				<br>
		        
		        <input type="text" value="${order_Minfo.m_zipcode}" style="height: 40px; padding-left: 5px; margin-bottom: 10px; border:1px solid #f0f0f0;" size="20" id="rec_zipcode" name="rec_zipcode" placeholder="우편번호" readonly/>
		        <input type="button" style="padding: 5 10px; font-size: 11px; height: 40; line-height: 50%; margin-bottom: 10px; border:1px solid #f0f0f0; background-color:#f0f0f0;" id="com_zipcodeBtn" value="주소찾기" size="20" onclick="DaumPostcode()"/>
		
				<div id="wrap" style="display:none; border:1px solid #d6d6d6; width:500px;height:300px; margin:-10px 0 20px 0; position:relative">
					<img src="//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
				</div>
		
		        <input type="text" size="70" id="rec_addr1" name="rec_addr1"  readonly="readonly" value="${order_Minfo.m_addr1}" style="height: 40px; padding-left: 5px;  border:1px solid #f0f0f0; display: block; margin-bottom: 10px;" placeholder="주소"/>
		        <input type="text" size="70" id="rec_addr2" name="rec_addr2" value="${order_Minfo.m_addr2}" style="height: 40px; padding-left: 5px; display:inline-block; border:1px solid #f0f0f0; margin-bottom: 10px;" placeholder="상세 주소 입력"/>
				<span id="addralert" style="display:none; font-size:10px; color:red; padding-left: 5px;"> 상세 주소를 입력해주세요. </span>
				
				<br>
				
				<input type="text" name="msg" size="70" style="padding-left: 5px; height: 40px; border:1px solid #f0f0f0;" placeholder="15 - 20 글자이내로 작성 가능합니다.">
			</div>
		</div><!-- Shipping info -->

		<div style="width: 100%; margin:50px 0; clear: both;">
			<p style="font-weight: 600; padding-bottom: 5px; margin-bottom: 30px; border-bottom: 2px solid; ">쿠폰/포인트</p>
			
			<table style="font-size:13px; width: 100%;">
				<tr> 
					<td style="padding-bottom:20px;">쿠폰</td>
					<td style="padding-bottom:20px; padding-left: 60px;">
						<select style="padding-left: 5px; width: 220px; height: 40px;" id="couponselect" name="cp_no">		
							<c:if test="${empty mem_coupon}"> <option value = "0"> 사용 가능한 쿠폰이 없습니다.</option> </c:if> 
							<c:if test="${not empty mem_coupon}"> <option value = "0">선택안함</option> </c:if>
							<c:forEach var="row" items="${mem_coupon}" varStatus="vs">
									<c:choose>
										<c:when test="${row.coupon == 'Bc'}"><option value="${row.cp_no}">공연 예매 감사 쿠폰 (10%)</option></c:when>
										<c:when test="${row.coupon == 'EBc'}"><option value="${row.cp_no}">얼리버드 예매 쿠폰(15%)</option></c:when>
										<c:when test="${row.coupon == 'Dc'}"><option value="${row.cp_no}">배송비 할인 쿠폰</option></c:when>
										<c:when test="${row.coupon == 'Bday'}"><option value="${row.cp_no}">생일 축하 쿠폰 (10%)</option> </c:when>
									</c:choose>
							</c:forEach>
							
					
						</select>
						<span style="font-size: 10px; padding-left: 10px; color:gray;">사용 가능한 쿠폰 <strong style="color:black;">${mem_couponCNT}</strong>장 / 보유 쿠폰 ${mem_couponTOTALCNT}장 </span>
					</td>
				</tr>
				
				<tr>
					<td >포인트</td>
					<td style="padding-left: 60px;"> 
						<input type="number" id="pt_minus"  style="padding-left: 5px; height: 40px;" autocapitalize="none" inputmode="numeric"/> 
						<button type="button" onclick="alluse()" style="margin-left:15px; height: 40; line-height: 50%; margin-bottom: 10px; border:1px solid #f0f0f0; background-color:#f0f0f0; padding: 5 10px; width:70px; font-size: 11px;">모두 사용</button>
						<span style="margin-left: 10px; font-size:10px; color:gray;">보유 포인트</span>
						<span style="font-weight: bold;  font-size:10px;" id="holding">${order_Minfo.point} P</span>
							<c:set var="point" value="${order_Minfo.point}"></c:set>
					</td>
				</tr>
			
				<tr>
					<td colspan="2">
						<p style="font-size: 10px; color: gray; font-weight: 500; margin-top: 20px;"> 
				     		- 쿠폰 적용 시 한 주문, 한 상품에 한해서만 적용됩니다. 
				     	<br>- 각 쿠폰은 사용기한이 정해져 있습니다.
				     	<br>- 할인/적립(%) 쿠폰은 적립금할인 등을 제외한 총 상품 금액에 적용됩니다.
				     	</p>
					</td>
				<tr>
			</table>
		</div><!-- coupon/point info -->
		
		<div style="margin:30px 0;"><!-- color:#3f3f3f; -->
			<p style="font-weight: 600; padding-bottom: 5px; margin-bottom: 30px; border-bottom: 2px solid;">결제 방법</p>
			
			<div style="width: 100%;"> 
				<button type="button" class="btn btn-outline-black btn-sm" id="card" style="width: 33.3%; border-right:none;"> 신용·체크카드</button>
				<button type="button" class="btn btn-outline-black btn-sm" id="bank" style="width: 33.3%; margin-left: -5px; border-right:none;"> 무통장 입금</button>
				<button type="button" class="btn naverbtn btn-sm" onclick="window.open('https://nid.naver.com/nidlogin.login');" style="width: 33.3%; margin-left: -5px;"> 네이버 페이</button>			
			</div>	

			<br>
			
			<div id="cardinfo" style="display:none; font-size:13px; margin-bottom: 30px; padding: 0 110px;">
				<select style="width: 100%; padding-left: 5px; height: 40px;">
					<option selected="selected" style="color:gray"> 카드사를 선택해주세요. </option>
					<option> 삼성 카드 </option>
					<option> KB 국민 카드 </option>
					<option> NH 카드 </option>
					<option> KEB 하나 카드 </option>
					<option> 롯데 카드 </option>
					<option> 우리 카드 </option>
					<option> BC 카드 </option>
					<option> 현대 카드 </option>
				</select>
				
				<select style="width: 100%; padding-left: 5px; height: 40px;">
					<option selected="selected"> 일시불 </option>
					<option> 2개월 </option>
					<option> 3개월 </option>
					<option> 4개월 </option>
					<option> 5개월 </option>
					<option> 6개월 </option>
				</select>
			</div><!-- select box -->
			
			<table style="margin-top: 15px;">
				<tr>
					<td style="width: 15%; vertical-align: baseline; font-size: 12px; font-weight: 600; color:gray;">환불안내</td>
					<td style="font-size:12px; color:gray;">
						<p style="color:black; margin-bottom: 8px;"> 결제하신 수단으로 취소됩니다. </p> 
						<p style="margin-bottom: 8px;">&nbsp; · 입점업체 배송은 낮은 확률로 상품이 품절일 가능성이 있습니다. 이에 품절 시 빠르게 환불 처리해드립니다. </p>
						<p style="margin-bottom: 8px;">&nbsp; · 현금 환불의 경우, 예금정보가 일치해야 환불 처리가 가능합니다. <br> &nbsp;&nbsp;&nbsp; (은행명, 계좌번호, 예금주명을 정확히 기재 부탁드립니다.)</p>
						<p style="margin-bottom: 8px;">&nbsp; · 환불 받으신 날짜 기준으로 3~5일(주말 제외) 후 결제대행사에서 직접 고객님의 계좌로 환불 처리됩니다. </p>
					</td>
				</tr>
			</table><!-- refund info -->
		
		</div><!-- payment info -->

	</div><!-- left content -->
	
	<div style="display:inline-block; width: 33%; margin: 0 10px; float: right;">
		<div class="stickyP" style="height: 100%;">
			<div class="stickyC" style="position: sticky; top: 100px; padding-bottom: 100px;">	
				<div style="padding: 15px 20px; height: 555px; background-color: black; "> 
					<p style="font-weight: 500; color: white; margin-bottom: -5px;">상품 정보</p>
					
					<hr style="background-color: white; opacity: 60%;">
					
					<div style="width: 80px; height: 80px; overflow: hidden; float: left; display: inline-block; position: relative;">
						<img src="/storage/${order_proinfo.postername}" style="width:100%; height:100%; object-fit:cover;" >
					</div><!-- product image -->
					
					<div style="width: 280px; float: left; padding: 0 0 0 15px;"> 
						<p style="font-size: 17px; font-weight:600; color:white; margin-bottom: 0; text-align: justify;">
							${order_proinfo.pro_name}
						</p>
						
						<div style="margin-top: 5px; color: white; font-size: 13px;">
							<span >
								 ${order_proinfo.color} / <c:choose>
								 							 <c:when test="${order_proinfo.size == 'F'}">Free</c:when>
								 							 <c:when test="${order_proinfo.size == 'S'}">S Size</c:when>
								 							 <c:when test="${order_proinfo.size == 'M'}">M Size</c:when>
								 							 <c:when test="${order_proinfo.size == 'L'}">L Size</c:when>
								 						  </c:choose> 
							</span>
							<span style="float:right;">
								<strong style="color:lightgreen; line-height: 2;">${buystock}</strong> 개
							</span>
						</div>
					</div><!-- product info -->
					
					<div style="clear: both;"></div>
					
					<hr style="background-color: white; opacity: 60%;">
					
					<div style="color:white; margin-top: 20px;">
						<span style="font-size:13px;"> 총 상품 금액 </span>
						<span style="float: right; font-size: 18px; line-height: 1;"> <fmt:formatNumber value="${order_proinfo.price * buystock}" pattern="#,###"/> 원</span>			
																					  <c:set var="order_price" value=" ${order_proinfo.price * buystock}"/>
					</div>
					<div style="color:white; margin-top: 20px;">
						<span style="font-size:13px;"> 쿠폰 사용 </span>
						<span style="float: right; font-size: 18px; line-height: 1;"> - 
							<span id="cp_dis"> 0 </span> 원</span>			
					</div>
					<div style="color:white; margin-top: 20px;">
						<span style="font-size:13px;"> 마일리지 사용 </span>
						<span style="float: right; font-size: 18px; line-height: 1;"> - 
							<span id="usepoint"> 0 </span>
							 &nbsp;P</span>			
					</div>
					<div style="color:white; margin-top: 20px;">
						<span style="font-size:13px;"> 배송비 </span>
						<span style="float: right; font-size: 18px; line-height: 1;"> + 
							<span id="d_fee">
								<c:choose>
									<c:when test="${order_proinfo.price * buystock >= 50000}">0</c:when>
									<c:otherwise><fmt:formatNumber value="3000" pattern="#,###"/></c:otherwise>
								</c:choose>
							</span>
						 원</span>			
					</div>
					<div style="color:white; margin-top: 20px;">
						<span style="font-size:13px; line-height: 4.4;"> 총 결제 금액 </span>
					
						<span style="float: right; font-size: 28px; font-weight: bold; color: lightgreen;"> 
							<c:set var="total_price" value="${order_proinfo.price * buystock}"></c:set>
							<c:choose>
								<c:when test="${order_proinfo.price * buystock >= 50000}">
									<span id="total_price"> <fmt:formatNumber value="${order_proinfo.price * buystock}" pattern="#,###"/></span> 
									원
									<c:set var="total_price" value="${order_proinfo.price * buystock}"></c:set>
								</c:when>
								<c:otherwise>
									<span id="total_price"> <fmt:formatNumber value="${order_proinfo.price * buystock + 3000}" pattern="#,###"/></span> 
									원
									<c:set var="total_price" value="${order_proinfo.price * buystock + 3000}"></c:set>
								</c:otherwise>
							</c:choose>
								
						</span>	
					</div>
					
					<hr style="background-color: white; opacity: 60%;">
					
					<div style="text-align: center; margin-top: 20px;"> 
						<input type="checkbox" id="chk" style="display:none; ">
						<label for="chk" style="margin-bottom: 0px; color:white; font-size: 12px; font-weight: 500; padding-right: 0;">
							회원 본인은 구매 조건, 주문 내용 확인 및 결제에 동의합니다
						</label>
					</div>
					
					<button type="submit" class="btn btn-outline-blackkk btn-sm" style="font-size: 20px; font-weight: 700;"> CHECK OUT </button>
					
				</div><!-- proinfo sticky bar -->	
			</div><!-- Sticky C -->	
		</div><!-- Sticky P -->
	</div><!-- right content -->
	
</form><!-- order form -->

  </div><!-- wrap -->
</div><!-- wrapall -->
<!-- 본문영역 -->


<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<script>
	
	$('#card').click(function(){
		$('#cardinfo').css('display','block');
	})//end
	
	$('#bank').click(function(){
		$('#cardinfo').css('display','none');
	})//end
	
 	var order_price = parseInt(${order_price});		// 제품 가격*수량 = 할인 안들어간 원가
	var total_price = parseInt(${total_price});		// 현재 총 결제 금 (가변적)		
	var comma = '';
	var dis_price = 0;								// 할인 된 금액 
	
	//total_price += 3000;							// 기본 배송비
	
	// 쿠폰 사용
	$('#couponselect').change(function() {
	    var result = $('#couponselect option:selected').text();
	    //alert(result);
	    
		    if (result == '공연 예매 감사 쿠폰 (10%)' || result == '생일 축하 쿠폰 (10%)') {
				
		    	var discount = order_price*0.1; 	// 현재 총 결제 금액에 10% 할인액
		    	
		    	if( order_price >= 50000 ) {	// 배송비무료 
		    		dis_price = order_price - discount ;  
		    	} else {
		    		dis_price = order_price - discount + 3000;
		    		$('#d_fee').text('3,000');
		    	}//if end
		    	
		    	comma = dis_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		    	
		    	$('#total_price').text(comma);
		    	
		    	discount = discount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		    	$('#cp_dis').text(discount);
		    	
		    	$('#pt_minus').val('');
				$('#usepoint').text('');
				
				flag = false;
				
		    } else if (result == '얼리버드 예매 쿠폰(15%)') {
		    	
		    	var discount = order_price*0.15; 	// 현재 총 결제 금액에 15% 할인
		    	
		    	if( order_price >= 50000 ) {	// 배송비무료 
		    		dis_price = order_price - discount ;  
		    	} else {
		    		dis_price = order_price - discount + 3000;
		    		$('#d_fee').text('3,000');
		    	}//if end
		    			    	
		  		comma = dis_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		    	
		  		$('#total_price').text(comma);
		    	
		    	discount = discount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		    	$('#cp_dis').text(discount);
		    	
		    	$('#pt_minus').val('');
				$('#usepoint').text('');
				
				flag = false;
		    } else if (result == '배송비 할인 쿠폰') {
		    	
		    	var d_fee = document.getElementById("d_fee").innerText
		    	
		    	//alert(d_fee);
		    	
		    	if (d_fee == '0 '){ 
			    	
		    		alert('현재 배송비가 없습니다.');
		    		
		    	} else if( !(d_fee == '0 ') ) {

		    		dis_price = (order_price + 3000) - 3000;	// 3000원 할인
		    		
			  		comma = dis_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");

			    	$('#total_price').text(comma);	 
	
			    	$('#cp_dis').text('3,000');
			    	
			    	$('#pt_minus').val('');
					$('#usepoint').text('');
					$('#d_fee').text('0');
				
					flag = false;
					
		    	}//if end
		    }
	    	if (result == '선택안함') {
	    		
		    	//alert(order_price);
		    	
		    	comma = order_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		    	
		    	$('#total_price').text(comma);
		    	$('#cp_dis').text('0');
		    	
		    	$('#pt_minus').val('');
				$('#usepoint').text('');

				flag = false;
				
		    }//if end
		    
		    
		    total_price = dis_price;
	    	
	  }); //end

		
	var flag = false;
	var point = parseInt(${point}); 	// 보유 포인트    
	
	// 포인트 모두사용
	function alluse(){
		//alert(point);
		
		if (flag == false) {	// 가진 포인트 모두 사용시
			
			$('#pt_minus').val(point);
			$('#usepoint').text(point);
			
			total_price = total_price - point; 
			
			comma = total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");

			$('#total_price').text(comma);
						
			flag = true;
			
		} else {				// 모두 사용 취소
			
			$('#pt_minus').val('');
			$('#usepoint').text('');
			
			total_price = total_price + point; 
				
			comma = total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		
			$('#total_price').text(comma);
						
			flag = false;
		}//if end
	
	}//end

	//마일리지 사용 
  	$('#pt_minus').on('keyup',function(){
	   var cnt = $("#pt_minus").length;     
	   //console.log(cnt);
  	          
  	  for( var i=1; i< cnt; i++){
  	     var sum = parseInt($(this).val() || 0 );
  	     sum++
  	    //console.log(sum);
  	  }
  	  
	  var org_point = parseInt(${point});   	// 보유 포인트
	  var use_point = parseInt($('#pt_minus').val() || 0);
	
      if($('#pt_minus').val() == '') {
     	  //alert("**");
     	  total_price = dis_price;
     	 flag = false;
       } 
	    
	    
  		//console.log("total_price" + total_price);

  		var sum = 0;

  		if (org_point < use_point) {	// 사용 포인트가 보유 포인트보다 많을때 
    	     
  			sum = parseInt(total_price - org_point);
  			
  			$('#usepoint').text(org_point);
  			$('#pt_minus').val(org_point);

  		}else {
  			
  			sum = parseInt(total_price - use_point);
  			
  			$('#usepoint').text(use_point);	
  			
  		}
	            
           //console.log("sum" + sum);
          
           sum = sum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
           $("#total_price").text(sum);
                    
      });// end

  	// 유효성 검사 
  	function orderCheck() {
  		// 배송지정보, 결제 방법 선택, 약관 동의
  		
  		// 약관 동의 체크박스 
  		if ( !($('#chk').is(':checked')) ){
  			alert('결제를 위해 약관에 동의해주세요.');
  			return false;
  		}
  		
  		// 수령인 정보
  		if ( $('#rec_name').val() == '' ) {
  			//alert('받는 사람 이름이 입력되지 않았습니다.');
  			$('#namealert').css('display', 'inline-block');
  			$('#rec_name').focus();
  			return false;
  		}
  		if ( $('#rec_tel').val() == '' ){
  			//alert('받는 사람 연락처가 입력되지 않았습니다.');
  			$('#telalert').css('display', 'inline-block');
  			$('#rec_tel').focus();
  			return false;
  		}
		if ( $('#rec_addr2').val() == '' ){
  			//alert('상세 주소가 입력되지 않았습니다.');
  			$('#addralert').css('display', 'inline-block');
  			$('#rec_addr2').focus();
  			return false;
  		}
  		
		
		var d_fee = document.getElementById("d_fee").innerText
    	var cp_dis = document.getElementById("cp_dis").innerText
    	var total_price = document.getElementById("total_price").innerText
    	var usepoint = document.getElementById("usepoint").innerText
		//var pt_minus = $('#pt_minus').val(); 
    	
    	d_fee = d_fee.replace(',','');
    	d_fee = parseInt(d_fee);
    	//alert("d_fee"+d_fee);
    	
    	cp_dis = cp_dis.replace(',','');
   		cp_dis = parseInt(cp_dis);
    	//alert("cp_dis"+cp_dis);
    	//alert("pt_minus"+pt_minus);
    	
    	total_price = total_price.replace(',','');
    	total_price = parseInt(total_price);
    	//alert("total_price"+total_price);
    	
    	$('#Fd_fee').val(d_fee);
    	$('#Fcp_dis').val(cp_dis);
    	$('#Ftotal_price').val(total_price);
    	
    	
     	//alert("pt_minus"+pt_minus);
     	//alert("usepoint"+usepoint);
     	usepoint = parseInt(usepoint);
     	//alert(usepoint);
    	
     	//alert($('#Fd_fee').val());
     		
    	//$('#discount').val(cp_dis);
    	//alert(usepoint);
    	$('#Fpt_minus').val(usepoint || 0);
    	//alert($('#Fpt_minus').val());
  		return true;
  	}//end
 
    	 
    
		


/*---------------  DAUM API  ---------------*/
    // 우편번호 찾기 화면을 넣을 element
    var element_wrap = document.getElementById('wrap');

    function foldDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_wrap.style.display = 'none';
    }

    function DaumPostcode() {
        // 현재 scroll 위치를 저장해놓는다.
        var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = data.address; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 기본 주소가 도로명 타입일때 조합한다.
                if(data.addressType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('rec_zipcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('rec_addr1').value = fullAddr;

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_wrap.style.display = 'none';

                // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
                document.body.scrollTop = currentScroll;
                
                $('#rec_addr2').focus();
            },
            // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
            onresize : function(size) {
                element_wrap.style.height = size.height+'px';
            },
            width : '100%',
            height : '100%'
        }).embed(element_wrap);

        // iframe을 넣은 element를 보이게 한다.
        element_wrap.style.display = 'block';
    }//END
/*---------------  DAUM API  ---------------*/
</script>

<%@ include file="../footer.jsp" %>