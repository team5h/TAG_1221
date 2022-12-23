<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="ssi.jsp" %>
<%@ include file="../header.jsp" %>
<%@ include file="summernote_ssi.jsp" %>

<style>
.btn.saem_btn {
  background: transparent;
  border-color: #000000;
  color: #000000; 
}
.btn.saem_btn:hover {
  color: #000000;
  background: lightgreen;
}
.btn.btn-outline-bllack {
  background: transparent;
  border-color: #000000;
  color: #000000; 
}
.btn.btn-outline-bllack:hover {
    color: #000000; 
    background: #ffffff; 
}
.li{display: inline;}

p{
	margin: 0;
}

button{
	outline: none;
}

</style>

<script>

/* Go to top */
function scrollFunction() {
	let mybutton = document.getElementById("myBtn");

	// When the user scrolls down 20px from the top of the document, show the button
	window.onscroll = function() {scrollFunction()};

  if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
    mybutton.style.display = "block";
  } else {
    mybutton.style.display = "none";
  }
}
function topFunction() {
	$('html, body').animate({scrollTop:0}, '200');
}
/* Go to top */

</script>
<!-- 본문영역 -->

<button onclick="topFunction()" id="myBtn" title="Go to top" style="font-size: 26px;">Go to top ↑</button>
 
<div class="totalwrap">
	<div class="wrapcont">
	
		<!-- 상단 상품정보 -->
		<div id="productinfo" style="height: 547px; padding: 0 40px 0 40px; margin-top: 50px; ">
			<div style="width:547px; height:547px; overflow: hidden; float: left; margin:0 auto;">
				<img src="/storage/${proDetail.postername}" style="width:100%; height:100%; object-fit:cover;">
				<!-- /storage/johnnystimson9.png -->
			</div><!-- product image -->
		
			<div id="rightside" style=" display: inline-block; text-align: left; padding-left: 70px; width: 600px; height: 100%;">
				<div id="likebtn" style="display: inline-block; float: right;" onclick="like()">
				<c:choose>
					<c:when test="${likechk == null}">
						<img src="/images/heart-192x192_1.svg" id="empty">
						<img src="/images/heart-192x192_2.svg" id="fill" style="display:none;">
					</c:when>
					
					<c:when test="${likechk == 0}">
						<img src="/images/heart-192x192_1.svg" id="empty">
						<img src="/images/heart-192x192_2.svg" id="fill" style="display:none;">
					</c:when>
					
					<c:when test="${likechk == 1}">
						<img src="/images/heart-192x192_1.svg" id="empty" style="display:none;">
						<img src="/images/heart-192x192_2.svg" id="fill" >
					</c:when>		
				</c:choose>
		
				</div>
				
				<p style="font-size:15px; color:lightgreen; margin-bottom: 0px; display: inline-block;">${proDetail.title}</p>
				<p style="font-size:30px; font-weight: bold; width: 100%; height: 100px;">${proDetail.pro_name}</p>
				
				<div id="priceinfo" style="text-align:right;"> 
					<span style="font-size:18px; margin-bottom:0;"> ￦ </span> 
					<p style="display:inline-block; font-size:28px; margin-bottom:0; font-weight: 500;"> 
						<fmt:formatNumber value="${proDetail.price}" pattern="#,###"/>
					</p>
					<p style="font-size:13px; color:gray; font-weight: 400; padding-top: 5px; margin-bottom: 0px;">
					 ＋ <fmt:formatNumber type="number" maxFractionDigits="0"  value="${proDetail.price * 0.01}" />P (1%)</p>
				</div><!-- priceinfo -->
				
				<div id="deliveryinfo" style="padding-top: 25px; font-size: 13px; margin-bottom: 10px;">
					<p style="border-bottom: 1px solid black; margin-bottom: 10px;">Delivery Info</p>
					
					<span> 출고 정보 </span> 
						<label id="delinfo" style="vertical-align: middle; cursor: pointer; margin-bottom: 4px;">
							<svg xmlns="http://www.w3.org/2000/svg" x="0px" y="0px" width="16" height="16" viewBox="0 0 16 16">
							<path d="M 7.5 1 C 3.917969 1 1 3.917969 1 7.5 C 1 11.082031 3.917969 14 7.5 14 C 11.082031 14 14 
									11.082031 14 7.5 C 14 3.917969 11.082031 1 7.5 1 Z M 7.5 2 C 10.542969 2 13 4.457031 13 
									7.5 C 13 10.542969 10.542969 13 7.5 13 C 4.457031 13 2 10.542969 2 7.5 C 2 4.457031 
									4.457031 2 7.5 2 Z M 7 4 L 7 5 L 8 5 L 8 4 Z M 7 6 L 7 11 L 8 11 L 8 6 Z"></path>
							</svg>
						</label><!-- info icon -->
						
					<span style="margin-left: 70px;"> 오늘 주문 시 <strong>내일</strong> 출고 </span>
					
						<div class="info_popup" style="display: none; z-index: 2; position: absolute;">
							판매자가 설정한 정보로, 업체 및 상품상황에 따라 변경될 수 있습니다. 
							<br>주말, 공휴일 및 업체 휴무일 제외한 평일(영업일) 기준 일자 입니다.
						</div><!-- popup message -->
					<br>
					<div style="position: relative; z-index: 1; padding-top: 5px;">
						<span> 배송 방법 </span>
						<span style="margin-left: 90px; font-weight: bold;"> 국내 배송 / 입점사 배송 </span>
					</div>	
				</div><!-- deliveryinfo -->
		
		        <div id="quantity" style="border:1px solid black; border-bottom: none; margin-top: 35px; width:100%; height:135px; padding: 20px 20px 20px 20px;">	
		        	<div id="pro_op" style="display: inline-block; width: 200px; font-weight: 600;" >
		        		<span>${proDetail.color} / <c:if test="${proDetail.size == 'F'}">Free</c:if>
		        								   <c:if test="${proDetail.size == 'S'}">S size</c:if>
		        								   <c:if test="${proDetail.size == 'M'}">M size</c:if>
		        								   <c:if test="${proDetail.size == 'L'}">L size</c:if>
		        		</span>
		        	</div>
		        			
		        	<div id="countchk" style="display: inline-block; padding-left: 90px;"> 		
			            <div class="minus" style="display: inline-block;"><a href="javascript:change_qty2('m')" style="color:black;">
			            	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-dash-lg" viewBox="0 0 16 16"> 
			            	<path fill-rule="evenodd" d="M2 8a.5.5 0 0 1 .5-.5h11a.5.5 0 0 1 0 1h-11A.5.5 0 0 1 2 8Z"/> </svg>
			            </a></div><!-- minus -->
			       
			      	    <input type="text" name="ct_qty" id="ct_qty" value="1" size="3" readonly="readonly" style="width: 50px; text-align: center; display: inline-block;">
				  
				        <div class="plus" style="display: inline-block;"><a href="javascript:change_qty2('p')" style="color:black;">
				        	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus-lg" viewBox="0 0 16 16"> 
			            	<path fill-rule="evenodd" d="M8 2a.5.5 0 0 1 .5.5v5h5a.5.5 0 0 1 0 1h-5v5a.5.5 0 0 1-1 0v-5h-5a.5.5 0 0 1 
			            	0-1h5v-5A.5.5 0 0 1 8 2Z"/> </svg></a>
			            </div><!-- plus -->
			 		 </div>
			 		 
			 		 <div style="display: inline-block; float: right; padding-top: 5px;"> 
			 		 	<span style="font-size: 14px;"> <fmt:formatNumber value="${proDetail.price}" pattern="#,###"/> 원 </span>
			 		 	<c:set var="price" value="${proDetail.price}" />
			 		 </div>
			 		 
			      	<hr>
					<div id="totalprice" style="float: right; font-size: 20px;"> 
						<span style="font-size: 14px;"> 총 금액 </span>  
						<div id="total_amount" style="display: inline-block; font-weight: bold; width: 100px; text-align: right;">
							<fmt:formatNumber value="${proDetail.price}" pattern="#,###"/> 
						</div>
						<span>원</span>
					</div>	  
				</div>	<!-- quantity -->
				
				<div id="paymentbtn" style="width: 100%;">
					<c:set var="pro_no" value="${proDetail.pro_no}" />
					<c:set var="s_m_id" value="${s_m_id}" />
					<button class="btn btn-outline-bllack btn-sm" style="width: 50%; border-right: none;" onclick="addcart()">장바구니</button>
					<button class="btn saem_btn btn-sm" style="width: 50.1%; margin-left: -5px;"  onclick="orderpage()">바로 구매</button>
				</div>
				
			</div><!-- rightside -->
		</div><!-- productinfo -->
		
		<!-- 하단 상품상세정보 및 문의 -->
		<div id="detailinfo" style="padding: 0 40px 0 40px; margin-top: 50px; position: relative; z-index: 1;">
		  <div class="tab">
		    <ul class="tabnav" style="font-size: 12px;">
		      <li class="li"><a href="#prodetail">상품 설명</a></li>
		      <li class="li"><a href="#qna">Q＆A</a></li>
		    </ul>
		    <div class="tabcontent">
		      <div id="prodetail" style="margin: auto; width: 100%;">
		      		<div style="overflow: hidden; float: right; margin-right: 80px;"> 
		      			${proDetail.edit}
		      		</div>
		      </div>
		
		      <div id="qna">
		      	<span style="font-weight: 600; font-size: 20px;"> 문의 (${pro_qnacnt}) </span>
		      	<button id="qnabtn" style="float: right; padding: 7; font-size: 11;" class="btn btn-outline-black btn-sm">Q＆A쓰기</button>
		     	
		     	
		     	<div id="modal" style="display: none; z-index: 2; position: absolute; border:1px solid; width: 700px; margin-left: 15%; background-color:white; height: 645px; padding: 20px;"> 
		     		<div class="close-area" style="float: right;">
		     			<svg xmlns="http://www.w3.org/2000/svg" x="0px" y="0px" width="15" height="15" viewBox="0 0 50 50">
						<path d="M 7.71875 6.28125 L 6.28125 7.71875 L 23.5625 25 L 6.28125 42.28125 L 7.71875 43.71875 
								L 25 26.4375 L 42.28125 43.71875 L 43.71875 42.28125 L 26.4375 25 L 43.71875 7.71875 L 
								42.28125 6.28125 L 25 23.5625 Z"></path>
						</svg>
		     		</div><!-- close btn -->
		     		
		  		    <p style="text-align: center; font-size: 20px; font-weight: 600;">Q & A</p>
			     	<form id="qnainsert">
				     	<input type="hidden" id="pro_no" name="pro_no" value="${proDetail.pro_no}">
				     	<input type="hidden" id="qname" name="qname" value="${s_m_id}">
			     		<div style="float: left; padding-top: 10px; font-size:14px;"> 
				     		<p> 아이디 </p> 
				     		<p style="padding-top: 10px;"> 비밀번호 </p> 
							<p style="padding-top: 10px;"> 문의제목 </p>
							<p style="padding-top: 10px;"> 문의내용 </p>
						</div>
						
						<div style="float: right; padding-top: 10px;"> 
							<p>${s_m_id}</p>
								<c:choose>
									<c:when test="${s_m_id == null and s_p_id == null}">
										<p style="color:red;">로그인이 필요한 서비스입니다.</p> 	
									</c:when>
									<c:when test="${mem_grade == 'S' and s_m_id == null}">
										<p style="color:red;">일반회원만 가능한 서비스입니다.</p> 	
									</c:when>
								</c:choose>
							<input type="number" name="passwd" inputmode="numeric" style="padding-top: 10px; margin-bottom: 18px;" class="input-number-password" placeholder="숫자만 입력 가능합니다"/>
							
							<input type="text" name="subject" style="display: block; margin-bottom: 18px; width: 100%;" />
							<textarea id="summernote" name="edit"></textarea>	
						</div>
						
			     		<p style="font-size:12px; color:#bcbcbc; clear: both; padding: 15px 0 15px 0;">- 문의내용에 대한 답변은 ‘마이페이지 > MY 상품 > 나의 문의내역’ 또는 ‘상품 상세페이지’에서 확인 가능합니다.</p>
			     		
			     		<button type="button" onclick="qnasubmit()" style="width: 100%;" class="btn btn-outline-black btn-sm">등록</button>
			     	</form> <!-- QnA insert -->
		     	</div><!-- modal -->
		    	
		   <!-- qna list -->
		     	<table style="width: 100%; margin-top: 20px; text-align: center;">
		     	
		     	<c:if test="${empty qnalist}"> 
					<tr>
						<td colspan="5" style="padding-top: 20px;">
							등록된 문의글이 없습니다.
						</td>
					</tr>
				</c:if>
		     	
		     	<c:forEach var="row" items="${qnalist}" varStatus="vs">
		     		<tr style="height: 50px;  border-bottom: none; border-top: 0.5px solid;">
		     			<td style="width: 70%; padding-left: 10px; text-align: left;">
		     				<img src="/images/icon/lock-20.svg" style="padding-bottom:7px;">
							<button type="button" onclick="detailshow(this)" value="${row.q_no}" style="border: none; background-color: transparent;" > 
								비밀글입니다. 
							</button>
		     			</td>
		     			
		     			<td style="font-size: 12px;">${row.qname}</td>
		     			
		     			<td style="font-size: 12px; width: 120px;">${row.regdate}</td>
		     			
		     			<td style="font-size: 12px;">
		     				<div style="background-color: lightgreen; border-radius: 50%; width: 20px; height: 20px; margin: auto;">
		     					<span style="font-size: 11px; font-weight: bold; line-height: 20px;"> 
									${row.a_stus}
		     					</span> 
		     				</div>
		     			</td>
		     		</tr>
		     		
		     		<!-- qna passwdchk -->
		     		<tr id="passwdchk${row.q_no}" style="display:none;" class="passch">
						<td style="height: 200px; border: 1px solid;" colspan="4">
								<c:set var="q_no" value="${row.q_no}"></c:set>
								<input type="number" name="passwd" id="passwd" inputmode="numeric" class="input-number-password"/>
								<button type="button" onclick="passwdchkfrm(this)" value="${row.q_no}" class="btn btn-outline-black btn-sm" style="padding: 5px 10px 5px 10px; font-size: 10px;">확인</button>
						</td>
						<td style="display: none;"></td>
						<td style="display: none;"></td>  
						<td style="display: none;"></td>       		
		     		</tr>
		     	
		     		<!-- qna detail -->
		     		<tr id="qnadetail${row.q_no}" class="detail" style="display:none;">
		     			<td style="height: 300px; background-color: #f8f8f8; padding: 10px 20px; font-size: 15px;" colspan="4">
								<div style="float: left; width:100%; text-align: left; padding-left: 10px; padding-bottom: 20px;"> 
									[ <span id="subject${row.q_no}" style="padding: 10px 0 10px 0; font-weight: 600;"></span> ]
												
									<div style="float: right; padding-top: 10px;">
										<button onclick="detailclose(this)" value="${row.q_no}" style="border: none; background-color: transparent;"> 
							     			<svg xmlns="http://www.w3.org/2000/svg" x="0px" y="0px" width="15" height="15" viewBox="0 0 50 50">
											<path d="M 7.71875 6.28125 L 6.28125 7.71875 L 23.5625 25 L 6.28125 42.28125 L 7.71875 43.71875 
													L 25 26.4375 L 42.28125 43.71875 L 43.71875 42.28125 L 26.4375 25 L 43.71875 7.71875 L 
													42.28125 6.28125 L 25 23.5625 Z"></path>
											</svg>
										</button>
						     		</div><!-- close btn -->
								</div>
								<br> 
						
								<div style="height:100px;"> 
									<span style="font-weight: bold; font-size:15px; padding-left: 15px; float:left; color:lightgreen; margin-bottom:0;"> Q.&nbsp;</span> 
									<div id="edit${row.q_no}" style="float: right; width: 95%;  overflow: auto; text-align:left; display: inline-block;">
		
									</div>
								</div>
								
								<hr>
								
								<div style="height:100px;">
									<span style="font-weight: bold; font-size:15px; color:lightgreen; margin-bottom:0;"> A.&nbsp;</span> 
									<div id="content${row.q_no}" style="display:inline-block; float: right; width: 95%; height:100px; overflow: auto; text-align:left; display: inline-block;">
		
									</div>
									
									<span id="regdate${row.q_no}" style="float: right; font-size: 11px; color: gray;"> </span>
								</div>
			
						</td>
						<td style="display: none;"></td>
						<td style="display: none;"></td>  
						<td style="display: none;"></td>   
		     		</tr>
		     	 	</c:forEach>
		     	</table>
		      </div><!-- qna tab -->
		  </div><!-- tab content -->	
		</div><!-- tab -->
		</div><!-- detailinfo -->

	</div><!-- wrap -->
</div><!-- wrapall -->
<!-- 본문영역 -->

<script>
	//출고정보
	$("#delinfo").click(function(){		
		if($(".info_popup").css("display") == "none"){
		    $(".info_popup").show();
		} else {
		    $(".info_popup").hide();
		}
	})// end
	

	// 상품 수량 체크 	
	Number.prototype.format = function(){
	  if(this==0) return 0;

	  var reg = /(^[+-]?\d+)(\d{3})/;
	  var n = (this + '');

	  while (reg.test(n)) n = n.replace(reg, '$1' + ',' + '$2');

	  return n;
	};
	 
	String.prototype.format = function(){
	  var num = parseFloat(this);
	  if( isNaN(num) ) return "0";

	  return num.format();
	};
	    

	var basic_amount = parseInt(${price});  
	
	function change_qty2(t){
	  //var min_qty = '수량버튼'*1;
	  var min_qty = 1;
	  var this_qty = $("#ct_qty").val()*1;
	  var max_qty = '200'; // 현재 재고
	  if(t=="m"){
	    this_qty -= 1;
	    if(this_qty<min_qty){
	      //alert("최소구매수량 이상만 구매할 수 있습니다.");
	      alert("수량은 1개 이상 입력해 주십시오.");
	      return;
	      }
	    }
	    else if(t=="p"){
	      this_qty += 1;
	      if(this_qty>max_qty){
	        alert("죄송합니다. 재고가 부족합니다.");
	        return;
	        }
	    }

	  var show_total_amount = basic_amount * this_qty;
	  //$("#ct_qty_txt").text(this_qty); 
	  $("#ct_qty").val(this_qty);
	  $("#it_pay").val(show_total_amount);
	  $("#total_amount").html(show_total_amount.format());
	}
	// 상품 수량 체크 end
	
	// Tab
	$(function(){
		  $('.tabcontent > div').hide();
		  $('.tabnav a').click(function () {
		    $('.tabcontent > div').hide().filter(this.hash).fadeIn();
		    $('.tabnav a').removeClass('active');
		    $(this).addClass('active');
		    return false;
		  }).filter(':eq(0)').click();
	});//end
	
	//modal
	const modal = document.getElementById("modal")
	const btnModal = document.getElementById("qnabtn")
	btnModal.addEventListener("click", e => {
	    modal.style.display = "block"
	})
	
	const closeBtn = modal.querySelector(".close-area")
	closeBtn.addEventListener("click", e => {
	    modal.style.display = "none"
	})
	
	modal.addEventListener("click", e => {
    const evTarget = e.target
	    if(evTarget.classList.contains("modal-overlay")) {
	        modal.style.display = "none"
	    }
	})
	
	window.addEventListener("keyup", e => {
	    if(modal.style.display === "flex" && e.key === "Escape") {
	        modal.style.display = "none"
	    }
	})
	
	//문의 작성
	function qnasubmit(){
		let insertData = $('#qnainsert').serialize();
		
		$.ajax({
					url   	 : "/product/qnainsert"
					,type 	 : "post"
					,data 	 : insertData
					,success : function(data){
						alert('문의가 등록되었습니다.');
						location.reload();
					}
		})//ajax end
	}//end
	
	// qna detail
	function detailshow(this1){
		var q_no = this1.value;
		var passwdchk = '#passwdchk'+q_no;
		var qnadetail = '#qnadetail'+q_no;
	
		if( $(passwdchk).css("display") == "none" ) {
			$(passwdchk).css("display","table-row");
			$('.passch').not(passwdchk).css('display', 'none');
			$('.detail').not(qnadetail).css('display', 'none');
		}else {
			$(passwdchk).css("display","none");
			$(qnadetail).css("display","none");
		}
	}//end
	
	function passwdchkfrm(this1){
		var q_no = this1.value;
		var passwd = $('#passwd').val();
		
		var passwdchk = '#passwdchk'+q_no;
		var qnadetail = '#qnadetail'+q_no;
		var subject = '#subject'+q_no;
		var edit = '#edit'+q_no;
		var content = '#content'+q_no;
		var regdate = '#regdate'+q_no;
		/*
		alert (q_no);
		alert (passwd);
		alert (passwdchk);
		alert (qnadetail);
		*/
		$.ajax({
					url   	 : "/product/qnadetail"
					,type 	 : "post"
					,data 	 :  {"q_no":q_no, "passwd":passwd}
					,success : function(data){
						//alert('성공');
						//alert(data.regdate);
						$(passwdchk).css('display','none');
						$(qnadetail).css('display','table-row');
						$(subject).html(data.subject);
						$(edit).html(data.edit);
						$(content).html(data.content);
						$(regdate).html(data.regdate);
						if (data.content == null) {
							$(content).html('<p style="font-size:13px; font-weight: 500; color:gray;"> 아직 답변이 등록되지 않았습니다. </p>');
						}
					}//suc end
					,error : function (error) {
						alert ('잘못된 비밀번호입니다.');
						//alert (error);
					}
		})//ajax end
		
	}//end
	
	
	function detailclose(this1) {
		var q_no = this1.value;
		var qnadetail = '#qnadetail'+q_no;
		
		$(qnadetail).css('display','none');
	}//end
	
	function addcart() {
		//alert ( $('#ct_qty').val() );
		const cnt = $('#ct_qty').val()
		const pro_no = parseInt(${pro_no});
		var m_id = '${s_m_id}';
		
		/*
		alert (cnt);
		alert (pro_no);
		alert (m_id);
		*/
		if(m_id == '') {
			alert('로그인이 필요한 서비스입니다.');
		}else {
			$.ajax({
				 url   	 : "/product/addcart"
				,type 	 : "post"
				,data 	 :  {"cnt":cnt, 
					"pro_no":pro_no, "m_id":m_id}
				,success : function(data){
					//alert('장바구니에 담았습니다.');
					if(confirm('장바구니에 담았습니다 \n이동하시겠습니까?')){
						location.replace('/cart');
					}
					
					
				}
			
			});//ajax end	
		}//if end
		
	}//end
	
	var flag = false;
	
	function like() {
		const pro_no = parseInt(${pro_no});
		var m_id = '${s_m_id}';
		
		if(m_id == '') {
			alert('로그인이 필요한 서비스입니다.');
		}else {

			if( !flag ) {
				//alert (flag);
				
				$.ajax({
				
				 		 url   	 : "/product/like"
						,type 	 : "post"
						,data 	 :  {"pro_no":pro_no, "m_id":m_id}
						,success : function(data){
							//alert("like");
							$('#empty').css('display','none');
							$('#fill').css('display','inline');
						}
				}); //ajax end
				
				flag = true;
				
			}else {
				
				$.ajax({
					
			 		 url   	 : "/product/unlike"
					,type 	 : "post"
					,data 	 :  {"pro_no":pro_no, "m_id":m_id}
					,success : function(data){
						//alert("unlike");
						$('#fill').css('display','none');
						$('#empty').css('display','inline-block');
					}
				}); //ajax end
				
				flag = false;
			}//if end
		}//if end
	}// end
	
	function orderpage() {
		let pro_no = $('#pro_no').val();
		let m_id = $('#qname').val();
		let buystock = $('#ct_qty').val();
		
		//let productprice = parseInt(${price});
		//let total_amount = productprice*buystock;
		
		/*
		alert(pro_no);
		alert(m_id);
		alert(buystock);
		alert(productprice);
		alert(total_amount);
		*/
		
		if (m_id == '') { 
			location.href='/loginG.do';
		}else {
			location.href='/product/order?pro_no=' + pro_no +'&m_id=' + m_id + '&buystock=' + buystock;
		}
	}//end

//----------------------------------------------------------------------- SUMMERNOTE 

  	// summernote
    $('#summernote').summernote({
        //placeholder: 'Hello Bootstrap 4',
        tabsize: 2,
        height: 300,
        focus: false,
        toolbar: [
		    // [groupName, [list of button]]
		    ['fontname', ['fontname']],
		    ['fontsize', ['fontsize']],
		    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
		    ['color', ['forecolor','color']],
		    ['insert',['picture']]
		  ],
		fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋움체','바탕체'],
		fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72'],
        lang: "ko-KR",	
      	//여기 부분이 이미지를 첨부하는 부분 
		callbacks: {	
			onImageUpload : function(files) {
				uploadSummernoteImageFile(files[0],this);
			},
			onPaste: function (e) {
				var clipboardData = e.originalEvent.clipboardData;
				if (clipboardData && clipboardData.items && clipboardData.items.length) {
					var item = clipboardData.items[0];
					if (item.kind === 'file' && item.type.indexOf('image/') !== -1) {
						e.preventDefault();
					}
				}
			}
		}//callback end 
	});//end
	
	// 이미지업로드로직
	function uploadSummernoteImageFile(file, editor) {
		var data = new FormData();
		data.append("file", file);
		$.ajax({
			data : data,
			type : "POST",
			url : "/uploadSummernoteImageFile",
			contentType : false,
			processData : false,
			success : function(data) {
            	$('#summernote').summernote('insertImage', data.url);
			 }
			,error:function(request,status,error, data){
            	            alert("Error");
         	        }
		});
	}//end
</script>

<%@ include file="../footer.jsp" %>