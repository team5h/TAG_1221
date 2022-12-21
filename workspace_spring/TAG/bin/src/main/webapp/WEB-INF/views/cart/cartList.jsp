<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="./ssi.jsp" %>
<%@ include file="../header.jsp" %>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Jost:wght@100;200;300;400;500;600;700;800;900&family=Mulish:wght@200;300;400;500;600;700;800;900;1000&display=swap" rel="stylesheet">

<style>



/* 전체 가로 너비 */
.container {max-width: 1350px; !important;} 

/* 상품 테이블 전체박스 */
#product_box {
  width: 355px;
  padding: 0 25px 0 25px;
  --padding-right: 50px;
  padding-bottom: 70px;
}


/* 좋아요, 카트 hover 되면 보이게 */
#cart{display: none;}


/* 상품마다 밑에 라인넣기 */
#list_line{
  padding-top: 28px;
  border-bottom: 1px solid black;
}

/* 상품 이름 밑에 여백주기 */
#product_price{margin-top: 3px;}


/* 바디 전체 폰트 설정 */
body {
  font-family: 'Jost', sans-serif;
  letter-spacing: 0.25px;
}

/* 링크 컬러 */
a{color: black; !important;}

/* 상품명 위에 공연명 */
#concert_name {
  font-size: 13px;
  margin-bottom: 3px;
  font-weight: 300;
}

/* 상품명 */
#product_name{font-size: 18px;}

/* 제목 (Merchandise) */
h2{
  font-size: 60px; !important;
  font-family: 'Jost', sans-serif; !important;
  font-weight: 600;
  padding: 50px 0 70px 0;
}

/* 검색기능 오른쪽으로 */
#product_search {float: right;}

/* 최신순 카테고리 오른쪽으로 */
#catergory {float: right;}

/* aside 네비바 큰 카테고리 (All, Concert) */
h3{
  font-family: 'Jost', sans-serif; !important;
  font-weight: 600;
}

/* 선택박스(최신순, 인기순, 좋아요순) 디자인 */
select {
  width: 80px;
  border: none; 
  border-bottom: 2px solid black;
  font-size: 14px;
}

/* aside 네비바 텍스트 디자인 */
#pro_name {
  border: none; 
  border-bottom: 2px solid black;
}

/* aisde 네비바 큰 카테고리 밑에 여백 */
.h3_title{padding-bottom: 10px;}

/* 검색기능까지 영역 아래 여백 */
#intro_wrap{padding-bottom: 70px;}

/* ul 점 제거 */
ul{
  list-style:none;
  margin:0px; padding:0px;
  font-size: 20px;
}

   
/* 상품 이미지 꽉차게 */
img{object-fit: contain;}


/* 네비바 + 상품 전체 영역 */
.list_container {
  width: 100%;
  margin: 0 auto;
  --background-color: lightgrey;
}

.list_container:after {  /* after를 이용하여 float해제하기 */
  display: block;
  clear: both;
  content: '';
}


/* 상품의 네비바 영역 */
.list_aside {
  background-color: #F2F3F4;
  position: sticky;
  top: 60px;
  width: 30%;
  --padding-top: 20px;
  --margin-bottom: 20px;
  float: right;
}

/* 상품 영역 */
.list_content {
  --background-color: lightgreen;
  width: 68%;
  margin-right: 25px;
  margin-bottom: 20px;
  float: left;
}
 
/* 푸터 */
.footer {
    clear: both;
}

/* Go to top */
#myBtn {
  position: fixed;
  bottom: 10px;
  right: 10px;
  z-index: 99;
  font-size: 18px;
  border: none;
  outline: none;
  color: black;
  cursor: pointer;
  padding: 15px;
  border-radius: 4px;
  background: transparent;
}
#myBtn:hover {color: #B3B6B7;}


/* 상품마다 화살표 아이콘 띄우기 */
#arrow-icon {display: none;}
#product_box:hover #arrow-icon {display: block;}

/* 상품안에 아이콘 */
.product-imageandicon {
  width: 100%;
  position: relative;
}
.product-image img{
  width: 100%;
  vertical-align: middle;
}
.heart-icon{
  display: none;
  position: absolute;
  top: 10px;
  left: 0px;
}

.cart-icon{
  display: none;
  position: absolute;
  top: 11px;
  right: 0px;
}

#product_box:hover .heart-icon {display: block;}
#product_box:hover .cart-icon {display: block;}





.order-arrow {color: #D7DBDD;}
.order-check{font-weight: 400;}



  .listCheckTable {
    width: 100%;
    --border-top: 1px solid #444444;
    border-collapse: collapse;
  }
  
   th, td {
    --border-bottom: 1px solid #444444;
    --border-left: 1px solid #444444;
    padding: 10px;
  } 
  
  
  
  th:first-child, td:first-child {
    border-left: none;
  }
  
  .cartorder, .orderconfirm{
  color: #D7DBDD;
  }
  
  #inform-table td{
  padding: 0 0 0 20px;
  }
  
  
  
/* 체크박스 css 시작 --------------------------------------------- */
input[type="checkbox"] { display: none; }
 
input[type="checkbox"] + label {
  display: block;
  position: relative;
  --padding-left: 35px;
  font: 14px/20px 'Open Sans', Arial, sans-serif;
  color: black;
  cursor: pointer;
  -webkit-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
}

input[type="checkbox"] + label:last-child { margin-bottom: 0; }

input[type="checkbox"] + label:before {
  content: '';
  display: block;
  width: 18px;
  height: 18px;
  border: 1px solid black;
  --position: absolute;
  left: 0;
  top: 0;
  opacity: .6;
  -webkit-transition: all .12s, border-color .08s;
  transition: all .12s, border-color .08s;
}

input[type="checkbox"]:checked + label:before {
  width: 10px;
  top: -5px;
  left: 5px;
  border-radius: 0;
  opacity: 1;
  border-top-color: transparent;
  border-left-color: transparent;
  -webkit-transform: rotate(45deg);
  transform: rotate(45deg);
}
/* 체크박스 css 종료  ---------------------------------------------  */
	
	.cartTableBox td {
	--border-bottom: 1px solid grey;
	}
	
	.cart-delete-btn {
	 background:none;
 	 border:none;
	}
	
	.li_title{
	padding: 35px;
	font-size: 17px;
	}
	
	.summary{
	display: inline-block;
	padding-bottom: 10px;
	}
	
	.summaryList{
	padding-bottom: 15px;
	color: #A6ACAF;
	font-weight: thin;
	}
	
	.summaryDataList{
	padding-bottom: 15px;
	}
	
	.totalCheck{
	font-size: 24px;
	display: block;
	padding-bottom: 40px;
	}
	
	.checkoutBtn{
	background-color: black;
 	border:none;
 	color: white;
	position: relative;
	float: bottom;
	width: 100%;
	height: 50px;
	margin: 0 auto;
	font-size: 20px;
	}
	
	.selectDeleteBtn{
	 width: 80px;
	 height: 40px;
	 background-color: white;
 	 border: 1px solid #F2F3F4 ;
 	 font-size: 15px;
 	 --padding-left: 0;
	}


/* 수량버튼 */
.count-wrap {position: relative;padding: 0 20px;overflow: hidden;}
.count-wrap > button {border: 0;background-color: white;color: #000;width: 30px;height: 30px;position: absolute;top: 0;font-size: 12px;}
.count-wrap > button.minus {left: 2;}
.count-wrap > button.plus {right: 7;}
.count-wrap .inp {border: 0;width: 20px;height: 30px;text-align: center;display: block;width: 100%;}

.concert-name{padding-bottom: 6px; font-size: 15px;}
.product-name{padding-bottom: 12px; font-size: 18px;}
.product-option{font-size: 14px;}

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

// When the user clicks on the button, scroll to the top of the document
function topFunction() {
	$('html, body').animate({scrollTop:0}, '200');
}//scrollFunction() end



</script>



<!-- 본문영역 -->
<h2>Shopping Cart</h2>
<div class="order-check">
<span class="listcheck"> 01 LIST CHECK </span> <span class="order-arrow"> &nbsp; > &nbsp; </span> 
<span class="cartorder"> 02 ORDER </span> <span class="order-arrow"> &nbsp; > &nbsp; </span>  
<span class="orderconfirm"> 03 ORDER CONFIRM </span> 
</div>

<button onclick="topFunction()" id="myBtn" title="Go to top" style="font-size: 26px;">Go to top ↑</button>

<div class="wrapAll">
	
		<!-- intro_wrap 시작 -->
		<div id="intro_wrap">
		    
			 
		</div><!-- intro_wrap 끝 -->	
		
		
		
		<!-- list_container 시작 -->
		<div class="list_container">
		
			<!-- list_aside 시작 -->
			<div class="list_aside">
			
				<div class="li_title">
					<div style="font-size: 24px; font-weight: bold; padding-bottom: 30px;">주문 요약</div>
					
					<div class="summary catefory" style="float: left;">
						<div class="summaryList">총 주문금액</div>
						<div class="summaryList">총 배송비</div>
						<div class="summaryList">할인금액</div>
						<div class="summaryList" style="padding-top: 120px;">총 결제금액</div>
					</div>    
					<div class="summary data" style="float: right; text-align: right;">
						<div class="summaryDataList">총 주문금액</div>
						<div class="summaryDataList">총 배송비</div>
						<div class="summaryDataList">할인금액</div>
						<div class="summaryDataList"  style="padding-top: 120px;">총 결제금액</div>
					</div>   
				
					<div>
						<button class="checkoutBtn">Checkout</button>
					</div>
				
				</div><!-- li_title 끝 -->
				
			</div><!-- list_aside 끝 -->
			
			
			<!-- list_content 시작 -->
			<div class="list_content">
				
				<!-- checkbox_group 시작 -->
				<div class="checkbox_group">			
				
				<table class="cartTableBox">
					<thead>
					  <tr>
					  	<th style="width: 40px; padding-left: 0;"><!-- 선택박스 -->
							<div class="agreeAll">
							<input type="checkbox" id="check_all" >
							<label for="check_all"></label>
							</div>
					  	</th>
					    <th>상품정보</th>
					    <th>가격</th>
					    <th>수량</th>
					    <th>배송비</th>
					    <th></th>
					  </tr>
					</thead>
					
 					<c:forEach var="row" items="${mycart}" varStatus="vs">
 					<tbody>
				      <tr>
				       	
				       	<td style="width: 30px; padding-left: 0;">
				       	
							<input type="checkbox" id="check${row.cart_no}" name="check" class="normal" >
							<label for="check${row.cart_no}"></label>
				       		
						</td>
				   
				      	<!-- 상품정보 -->
				        <td style="width: 450px; padding-bottom: 30px;">
					        <table id="inform-table"> 
							    <tr>
								    <td style="padding:0;">
								    	<div class="product-imageandicon">
											<a href="">
											<img src="/storage/${row.postername}" width="140">
											</a>
										</div>
								    </td>
								    <td>
								    	<div class="concert-name">${row.title}</div>
								    	<div class="product-name">${row.pro_name}</div>
								    	<div class="product-option">
								    	색상:${row.color}
								    	사이즈: ${row.size}
								    	</div>
								    </td>
							    </tr>
						    </table> 
			 
						    
				        </td>

				        <!-- 가격 -->
				        <td style="width: 130px;">
				        <input type="hidden" id="product_price${row.cart_no}" name="product_price" value="${row.price}">
				        ￦ <fmt:formatNumber id="" value="" pattern="#,###" />
				        </td>
				        <td style="width: 130px; padding-left: 0px;">
				        <div class="count-wrap _count">
						    <button id="count-minus${row.cart_no}" type="button" class="minus" value="${row.cart_no}"><img src="/images/minus.svg"></button>
						    <input id="count-plus${row.cart_no}" type="text" class="inp" value="${row.cnt}" />
						    <button id="count-plus${row.cart_no}" type="button" class="plus" value="${row.cart_no}"><img src="/images/plus.svg"></button>
						</div>
				        </td>
				        
				        <!-- 배송비 -->
						    <c:choose>
					         <c:when test = "${row.price <= 50000}">
						        <td style="width: 125px;">
					        		<fmt:formatNumber value="3000" pattern="#,###" />
					        	</td>
					         </c:when>
					
					         <c:when test = "${row.price >= 50000}">
					           	<td style="width: 125px;">
					        		<div style="font-size: 14px;">50,000원 이상 무료배송</div>
					        	</td>
					         </c:when>
					      </c:choose>
					      	 <input type="hidden" class="inp" value="${total[vs.index]}" />
							<td>${total[vs.index]} ${row.countpid}</td>
							<td>${row.countpid}</td>



				        
				        <td style="width: 78px;">
				        	<button onclick="cartdelete(this)" value="${row.cart_no}" type="button" id="cartdeleteBtn${row.cart_no}" class="cart-delete-btn"><img src="/images/xbutton.svg"></button>
				        </td>
				      </tr>
				    </tbody>
					</c:forEach>
				</table>   
				</div><!-- checkbox_group end -->
				
				<div class="tablepadding" style="padding-bottom: 40px;"></div>
				
				<button class="selectDeleteBtn">선택삭제</button>
					
			</div><!-- list_content -->
		</div><!-- list_container -->
		

</div><!-- wrapAll end -->


<script>
// 체크박스 전체 선택
$(".checkbox_group").on("click", "#check_all", function () {
    $(this).parents(".checkbox_group").find('input').prop("checked", $(this).is(":checked"));
});

// 체크박스 개별 선택
$(".checkbox_group").on("click", ".normal", function() {
    var is_checked = true;

    $(".checkbox_group .normal").each(function(){
        is_checked = is_checked && $(this).is(":checked");
    });

    $("#check_all").prop("checked", is_checked);
});


/* <input type="hidden" id="product_price${row.price}" name="product_price" value="${row.price}"> */


//수량 옵션
$('._count :button').on({
    'click' : function(e){
        e.preventDefault();
        var $count = $(this).parent('._count').find('.inp');
        var now = parseInt($count.val());
        var min = 1;
        var max = 999;
        var num = now;
		var price = $("#product_price${row.cart_no}").val();
		alert(price);
		
        
        if($(this).hasClass('minus')){
            var type = 'm';
        }else{
            var type = 'p';
        }
        if(type=='m'){
            if(now>min){
                num = now - 1;
                //가격가져오고
                //가격*num
            }
        }else{
            if(now<max){
                num = now + 1;
                //가격가져오고
                //가격*num
            }
        }
        if(num != now){
            $count.val(num);
        }
    }
});





// 장바구니 삭제
var m_id = "${s_m_id}";
//alert(m_id);

function cartdelete(this1, m_id){
	var cart_no = this1.value;
    //alert(cart_no);
    
	$.ajax({
			url: '/cart/deleteMycart'
			,type:'post'
			,data : {'cart_no':cart_no, 'm_id':m_id}
			,success : function(data) {
				alert("성공!");
			}//success end
		
	});//$.ajax({}) end

	
	
} //cartdelete(this) end
	
	





</script>



<!-- 본문영역 -->

<%@ include file="../footer.jsp" %>