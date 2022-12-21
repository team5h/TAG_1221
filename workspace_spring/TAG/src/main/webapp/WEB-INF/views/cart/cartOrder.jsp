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
	
	<div style="padding:0 10px; width: 60%; display: inline-block;"> 
		<div style="margin-top: 50px; margin-bottom: 30px;"> 
			<p style="font-weight: 600; color: lightgreen;">배송 정보</p>
			
			<div style="width: 15%; display: inline-block; font-size: 13px;"> 
				<p> 수령인 </p>
				<p> 배송지 </p>
				<br><br><br>
				<p> 배송메세지 </p>
			</div>
			
			<div style="width: 60%; display: inline-block; font-size: 13px;"> 
				<input type="text" style="padding-left: 5px; display: block; margin-bottom: 10px; border:1px solid #d6d6d6;">
				
		        <input type="text" style="padding-left: 5px; margin-bottom: 10px; border:1px solid #d6d6d6;" size="20" id="com_zipcode" name="com_zipcode" placeholder="우편번호" readonly/>
		        <input type="button" style="padding: 5 10px; font-size: 11px; height: 25; line-height: 50%; margin-bottom: 10px; border:1px solid #d6d6d6;" id="com_zipcodeBtn" value="주소찾기" size="20" onclick="DaumPostcode()"/>
		
				<div id="wrap" style="display:none; border:1px solid #d6d6d6; width:500px;height:300px; margin:-10px 0 20px 0; position:relative">
					<img src="//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
				</div>
		
		        <input type="text" size="70" id="com_addr1" name="com_addr1" style="padding-left: 5px;  border:1px solid #d6d6d6; display: block; margin-bottom: 10px;" placeholder="주소"/>
		        <input type="text" size="70" id="com_addr2" name="com_addr2" style="padding-left: 5px;  border:1px solid #d6d6d6; margin-bottom: 10px;" placeholder="상세 주소"/>
		
				<br>
				
				<input type="text" size="70" style="padding-left: 5px;  border:1px solid #d6d6d6;">
			</div>
		</div><!-- Shipping info -->
<hr>
		<div style="width: 100%; margin:30px 0; clear: both;">
			<p style="font-weight: 600; color: lightgreen;">쿠폰/마일리지</p>
			
			<table style="font-size:13px; width: 100%;">
				<tr> 
					<td style="padding-bottom:20px;">쿠폰</td>
					<td style="padding-bottom:20px; padding-left: 60px;">
						<select style="padding-left: 5px;">
							<option selected="selected"> 사용 가능한 쿠폰 1장 / 보유 쿠폰 2장 </option>
							<option>선택안함</option>
						</select>
					</td>
				</tr>
				
				<tr>
					<td >마일리지</td>
					<td style="padding-left: 60px;"> 
						<input type="number" style="padding-left: 5px;" /> 
						<button style="margin-left:15px; height: 25; line-height: 50%; margin-bottom: 10px; border:1px solid #d6d6d6; padding: 5 10px; font-size: 11px;">모두 사용</button>
						<span style="margin-left: 10px;">보유 마일리지</span>
						<span style="font-weight: bold;">120 P</span>
					</td>
				</tr>
			
			</table>
		</div><!-- coupon/point info -->
<hr>		
		<div style="margin:30px 0;"><!-- color:#3f3f3f; -->
			<p style="font-weight: 600; color: lightgreen">결제 방법</p>
			
			<div style="width: 100%;"> 
				<button class="btn btn-outline-black btn-sm" id="card" style="width: 33.3%; border-right:none;"> 신용·체크카드</button>
				<button class="btn btn-outline-black btn-sm" id="bank" style="width: 33.3%; margin-left: -4px; border-right:none;"> 무통장 입금</button>
				<button class="btn naverbtn btn-sm" onclick="window.open('https://nid.naver.com/nidlogin.login');" style="width: 33.3%; margin-left: -4px;"> 네이버 페이</button>
			</div>	

			<br>
			
			<div id="cardinfo" style="display:none; font-size:13px; margin-bottom: 30px; padding: 0 110px;">
				<select style="width: 100%;">
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
				
				<select style="width: 100%;">
					<option selected="selected"> 일시불 </option>
					<option> 2개월 </option>
					<option> 3개월 </option>
					<option> 4개월 </option>
					<option> 5개월 </option>
					<option> 6개월 </option>
				</select>
			</div><!-- select box -->
			
			<table>
				<tr>
					<td style="width: 15%; vertical-align: baseline; font-size: 12px; font-weight: 500;">환불안내</td>
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
				<div style="padding: 15px 20px; height: 570px; background-color: black; "> 
					<p style="font-weight: 500; color: white; margin-bottom: -5px;">상품 정보</p>
					
					<hr style="background-color: white; opacity: 60%;">
					
					
					
					
				<div style="overflow: auto; height: 90px;">
					<c:forEach var="row" items="${mycart}" varStatus="vs">
							<div style="width: 80px; height: 80px; overflow: hidden; float: left; display: inline-block; position: relative;">
								<img src="/storage/${row.postername}" style="width:100%; height:100%; object-fit:cover;" >
							</div><!-- product image -->
							
							<div style="width: 280px; float: left; padding: 0 0 50px 15px;"> 
								<p style="font-size: 17px; font-weight:600; color:white; margin-bottom: 0; text-align: justify;">
									${row.title}
								</p>
								
								<div style="margin-top: 5px; color: white; font-size: 13px;">
									<span >
										 ${row.color} / ${row.size} 
									</span>
									<span style="float:right;">
										<strong style="color:lightgreen;">3</strong> 개
									</span>
								</div>
							</div><!-- product info -->
					</c:forEach>
				</div>	
					
					
					
					
					<div style="clear: both;"></div>
					
					<hr style="background-color: white; opacity: 60%;">
					
					<div style="color:white; margin-top: 20px;">
						<span style="font-size:13px;"> 총 상품 금액 </span>
						<span style="float: right; font-size: 18px; line-height: 1;"> 144,000 원</span>			
					</div>
					<div style="color:white; margin-top: 20px;">
						<span style="font-size:13px;"> 쿠폰 사용 </span>
						<span style="float: right; font-size: 18px; line-height: 1;"> - 0 원</span>			
					</div>
					<div style="color:white; margin-top: 20px;">
						<span style="font-size:13px;"> 마일리지 사용 </span>
						<span style="float: right; font-size: 18px; line-height: 1;"> - 0 &nbsp;P</span>			
					</div>
					<div style="color:white; margin-top: 20px;">
						<span style="font-size:13px;"> 배송비 </span>
						<span style="float: right; font-size: 18px; line-height: 1;"> + 0 원</span>			
					</div>
			
					<div style="color:white; margin-top: 20px;">
						<span style="font-size:13px; line-height: 4.4;"> 총 결제 금액 </span>
						<span style="float: right; font-size: 28px; font-weight: bold; color: lightgreen;"> 144,000 원</span>			
					</div>
					
					
					
					
					
					
					<hr style="background-color: white; opacity: 60%;">
					
					<div style="text-align: center; margin-top: 20px;"> 
						<input type="checkbox" id="chk" style="display:none; ">
						<label for="chk" style="margin-bottom: 0px; color:white; font-size: 12px; font-weight: 500; padding-right: 0;">
							회원 본인은 구매 조건, 주문 내용 확인 및 결제에 동의합니다
						</label>
					</div>
					
					<button class="btn btn-outline-blackkk btn-sm"> 결제 </button>
					
				</div><!-- proinfo sticky bar -->	
			</div><!-- Sticky C -->	
		</div><!-- Sticky P -->
	</div><!-- right content -->

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



/*  DAUM API  */
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
                document.getElementById('com_zipcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('com_addr1').value = fullAddr;

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_wrap.style.display = 'none';

                // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
                document.body.scrollTop = currentScroll;
                
                $('#com_addr2').focus();
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
/*  DAUM API  */
</script>

<%@ include file="../footer.jsp" %>