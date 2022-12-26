<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%@ include file="../header.jsp" %>
<%@ include file="summernote_ssi.jsp" %>

<style>
@import url(http://fonts.googleapis.com/earlyaccess/notosanskr.css); 

* {
	font-family: 'Noto Sans KR', sans-serif; !important;
}
</style>

<!-- 본문영역 -->

<br>
	<h1 class="saem_title fontJ"> <a href="/mypageS" style="color:black" class="saem_title fontJ"> My Page </a> </h1>
<br> 

<div class="float" style="width: 100%; height: 100%; flex: 1;">
						
<div class="leftcontent" style="float:left; width:15%; margin-right:5%;">
	<div class="stickyP" style="height: 100%;">
			<p class="fontJ" style="font-size: 20px; font-weight: 500;">
				${s_p_id}&nbsp;님 <!-- 세션아이디 -->
			</p>
	<br>	
		<div class="stickyC" style="position: sticky; top: 100px; padding-bottom: 100px;">	
			<ul style="font-size:13px; list-style-type: none; padding-left:0px;">
				<li class="side_liT" style="color:lightgreen;"> PRODUCT </li>
					<li>&nbsp;<a href="/mypageS/create" style="color:black; font-size: 13px;">  - 상품등록 &nbsp;</a></li>
					<li>&nbsp;<a href="/mypageS/productM" style="color:black; font-size: 13px;" >  - 상품관리 &nbsp;</a></li>
		<br>	
				<li class="side_liT"> ORDER </li>
					<li>&nbsp;<a href="/mypageS/orderM" style="color:black; font-size: 13px;" > - 주문관리 &nbsp;</a></li>	
		<br>	
				<li class="side_liT"> QnA </li>
					<li>&nbsp;<a href="/mypageS/qna" style="color:black; font-size: 13px;" > - 답변대기 &nbsp;</a></li>
					<li>&nbsp;<a href="/mypageS/answer" style="color:black; font-size: 13px;" > - 답변완료 &nbsp;</a></li>
		<br>			
				<li style="font-size: 13px; font-weight: 400;"> <a href="/mypageS/update" style="color: #bcbcbc;"> 회원정보수정 </a> </li>
			</ul>
		</div><!-- stickyC -->
	 </div><!-- stickyP -->
</div><!-- "leftcontent" -->



<div class="rightcontent" style="float:right; width:80%;"> 
	<form method="post" action="/mypageS/productupdate" name="productForm" onsubmit="return productCheck()" enctype="multipart/form-data">
		<input type="hidden" name="pro_no" value="${productdetail.pro_no}"/>
		<input type="hidden" name="p_id" value="${s_p_id}"/><!-- 세션아이디 -->
		
		<select name="c_no" id="c_no" style="width:100%;" disabled="disabled">
			<option selected value="-">${productdetail.title}</option>
		</select>
		
		<p style="margin-top:20px; font-size:13px;">상품명</p>
			<input type="text" name="pro_name" id="pro_name" style="width:100%;" value="${productdetail.pro_name}"/>
			<span class="productck" id="pronameck" style="margin-top:5px;">&nbsp;상품명을 작성해주세요&nbsp;</span>
	
	<br>
		<div style="display:inline-block; width:35%; padding-top:20px;">
			<table class="cktable">
				<tr>
					<td> 
					    <input type="checkbox" name="category" id="checker1" value="C" onclick="NoMultiChkcategory(this)"
					    	<c:if test="${productdetail.category == 'C'}">checked</c:if>
					    ><label for="checker1">의류</label>
					</td>
					<td>    
					    <input type="checkbox" name="category" id="checker2" value="P" onclick="NoMultiChkcategory(this)"
					    	<c:if test="${productdetail.category == 'P'}">checked</c:if>
					    ><label for="checker2">포스터</label>
					</td>
					<td>   
					    <input type="checkbox" name="category" id="checker3" value="M" onclick="NoMultiChkcategory(this)"
					    	<c:if test="${productdetail.category == 'M'}">checked</c:if>
					    ><label for="checker3">음반</label>
					</td>
					<td>   
					    <input type="checkbox" name="category" id="checker4" value="A" onclick="NoMultiChkcategory(this)"
					    	<c:if test="${productdetail.category == 'A'}">checked</c:if>
					    ><label for="checker4">잡화</label>
					</td>
				</tr>
				<tr>
					<td>
					    <input type="checkbox" name="size" id="checker5" value="S" onclick="NoMultiChksize(this)"
					    	<c:if test="${productdetail.size == 'S'}">checked</c:if>
					    ><label for="checker5">S</label>
					</td>
					<td>    
					    <input type="checkbox" name="size" id="checker6" value="M" onclick="NoMultiChksize(this)"
					    	<c:if test="${productdetail.size == 'M'}">checked</c:if>
					    ><label for="checker6">M</label>
					</td>
					<td>    
					    <input type="checkbox" name="size" id="checker7" value="L" onclick="NoMultiChksize(this)"
					    	<c:if test="${productdetail.size == 'L'}">checked</c:if>
					    ><label for="checker7">L</label>
					</td>
					<td>    
					    <input type="checkbox" name="size" id="checker8" value="F" onclick="NoMultiChksize(this)"
					    	<c:if test="${productdetail.size == 'F'}">checked</c:if>
					    ><label for="checker8">Free</label>
					</td>
				</tr>
			</table>
				<span class="productck" id="categoryck" style="margin-left: 50px;">&nbsp;상품의 <span style="color:lightgreen;">카테고리</span>를 선택해주세요&nbsp;</span>
				<span class="productck" id="sizeck" style="margin-left: 50px;">&nbsp;상품의 <span style="color:lightgreen;">사이즈</span>를 선택해주세요&nbsp;</span>
		</div> <!-- 체크박스 -->
		
		
		
		<div style="display:inline-block; width:64%; padding:10px 0 20px 0;">
			<table class="inptable" style="font-size:13px; width:100%;">  
				<tr>
					<td style="padding: 0 10px 0 0;">
						<p style="margin-top:15px;">색상</p>
						<input type="text" name="color" id="color" size="15" value="${productdetail.color}"/>
					</td>	
					<td style="padding: 0 10px 0 0;">
						<p style="margin-top:15px;">가격</p>
						<input type="number" name="price" id="price" style="text-align:right; width: 150px;" value="${productdetail.price}"/>
					</td>		
					<td style="padding: 0 10px 0 0;">
						<p style="margin-top:15px;">재고</p>
						<input type="number" name="stock" id="stock" style="text-align:right; width: 150px;" value="${productdetail.stock}"/>
					</td>	
					<td style="vertical-align:bottom; padding: 0 20px 0 20px;">
						<input type="file" name="fileimg" id="fileimg" value="${productdetail.postername}" style="display:none;"/>
						<label for="fileimg">
							<img src="/images/icon/imageupload.png" style="width: 30px; height: 30px; margin-bottom:-10px;"/>
						</label>
					</td>
				</tr>
				<tr>
					<td colspan="4" style="padding-top:10px; text-align: center;">
						<span class="productck" id="colorck">&nbsp;상품의 <span style="color:lightgreen;">색상</span>을 작성해주세요&nbsp;</span>
						<span class="productck" id="priceck">&nbsp;상품의 <span style="color:lightgreen;">가격</span>을 작성해주세요&nbsp;</span>
						<span class="productck" id="stockck">&nbsp;상품의 <span style="color:lightgreen;">재고 총 수량</span>을 작성해주세요&nbsp;</span>
						<span class="productck" id="fileck">&nbsp;상품의  <span style="color:lightgreen;">대표 이미지</span>를 등록해주세요&nbsp;</span>
					</td>
				</tr>
			</table>	
					
		 </div>	<!-- 정렬용 -->
	
	<br><br>
		
		    <textarea id="summernote" name="edit">${productdetail.edit}</textarea>		   
<br>	
			<button type="submit" style="float:right" class="btn btn-outline-black btn-sm">저장</button>
		
	</form>
</div><!-- rightcontent -->

</div><!-- float -->

<!-- 본문영역 -->

     
<script>
	$(document).ready(function(){
		$("#c_no").focus();
	});
	
	//유효성
	function productCheck() {

		if ($("#pro_name").val().length == 0) {
			$("#pro_name").focus();
			$("#pronameck").css("display","inline-block");
			return false;
		}else {
			$("#pronameck").css("display","none");
		}
		
		if (!$("input:checked[Name='category']").is(":checked")){ 
			$("#c_no").focus();
			$("#categoryck").css("display","inline-block");
			return false;
		}else {
			$("#categoryck").css("display","none");
		}
		
		if (!$("input:checked[Name='size']").is(":checked")){ 
			$("#c_no").focus();
			$("#sizeck").css("display","inline-block");
			return false;
		}else {
			$("#sizeck").css("display","none");
		}
		
		if ($("#color").val().length == 0) {
			$("#color").focus();
			$("#colorck").css("display","inline-block");
			return false;
		}else {
			$("#colorck").css("display","none");
		}
		
		if ($("#price").val().length == 0) {
			$("#price").focus();
			$("#priceck").css("display","inline-block");
			return false;
		}else {
			$("#priceck").css("display","none");
		}
		
		if ($("#stock").val().length == 0) {
			$("#stock").focus();
			$("#stockck").css("display","inline-block");
			return false;
		}else {
			$("#stockck").css("display","none");
		}

		
		return true;
	}//productCheck() end
	
	// 체크박스 중복불가 
	function NoMultiChkcategory(chk){
		  var obj = document.getElementsByName("category");
		   for(var i=0; i<obj.length; i++){
		     if(obj[i] != chk){
		       obj[i].checked = false;
		     }
		   }//카테고리
	}//NoMultiChk() END

	function NoMultiChksize(chk){
		  var obj = document.getElementsByName("size");
		   for(var i=0; i<obj.length; i++){
		     if(obj[i] != chk){
		       obj[i].checked = false;
		     }
		   }//사이즈
	}//NoMultiChksize() END	
	
	
//----------------------------------------------------------------------- SUMMERNOTE 

	  // summernote
      $('#summernote').summernote({
        //placeholder: 'Hello Bootstrap 4',
        tabsize: 2,
        height: 700,
        focus: false,
        toolbar: [
		    // [groupName, [list of button]]
		    ['fontname', ['fontname']],
		    ['fontsize', ['fontsize']],
		    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
		    ['color', ['forecolor','color']],
		    ['table', ['table']],
		    ['para', ['ul', 'ol', 'paragraph']],
		    ['height', ['height']],
		    ['insert',['picture','link','video']],
		    ['view',['codeview']]
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