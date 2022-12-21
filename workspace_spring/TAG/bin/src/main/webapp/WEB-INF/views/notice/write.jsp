<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../header.jsp" %>
<%@ include file="ssi.jsp" %>

<style>
   .dropdown-toggle:after {
       display: none;
       margin-left: 0.255em;
       vertical-align: 0.255em;
       content: "";
       border-top: 0.3em solid;
       border-right: 0.3em solid transparent;
       border-bottom: 0;
       border-left: 0.3em solid transparent;
   }
</style>

<!-- 본문 시작 -->

<h3 style="text-align: center;">글쓰기</h3>
<br>

<div class="container">
	<p>
		<button type="button" onclick="location.href='/notice/list'">목록</button>
	</p>
	<form name="form1" method="post" action="/notice/insert" >
	<table class="table">
		<tr>
			<td>제목</td>
			<td><input type="text" name="subject" align="center"></td>
		</tr>
		<tr>
			<td>작성자</td>
			<td>관리자</td>
		</tr>
		<tr>
			<td>내용</td>
			<td>
		    	<textarea id="summernote" name="edit"></textarea> 
		   	</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="submit" value="공지사항 등록">
			</td>
		</tr>
	</table>
	</form>
</div>

<!-- 본문 끝 -->

<script>
     // summernote
      $('#summernote').summernote({
        //placeholder: 'Hello Bootstrap 4',
        tabsize: 2,
        height: 500,
        focus: true,
        toolbar: [
          // [groupName, [list of button]]
          ['fontname', ['fontname']],
          ['fontsize', ['fontsize']],
          ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
          ['color', ['forecolor','color']],
          ['table', ['table']],
          ['para', ['ul', 'ol', 'paragraph']],
          ['height', ['height']],
          ['view',['codeview']]
        ],
      fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋움체','바탕체'],
      fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72'],
      lang: "ko-KR",
   	  disableDragAndDrop:true
   });//end
   
</script>

<%@ include file="../footer.jsp" %>