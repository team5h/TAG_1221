<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="./ssi.jsp" %>
<%@ include file="../header.jsp" %>

<title>일반회원 로그인</title>


<style>

*{margin: 0;padding: 0;box-sizing: border-box}
body{background-color: #f7f7f7;}
ul>li{list-style: none}
a{text-decoration: none;}
.clearfix::after{content: "";display: block;clear: both;}


.jform {
	/* form전체를 div로 감싸서 width기준 가운데 정렬 */
	/* background-color: red; */
	width: 350px;
	margin: 0 auto;
}

h1{
	padding-top: 40px;
	padding-bottom: 70px;
	text-align: center;
	font-weight: bold;
}

tr {
	padding-bottom: 20px;
}


#body{
  height: auto;
  min-height: 100%;
  /* padding-bottom: 20px; */
}


html, body {
  height: 100%;
}


.footer {
  position: absolute;
  bottom: 0;
}

.textbox input {
 	background-color: #f7f7f7;
	width: 350px;
	height: 45px;
	border: none;
	border-bottom: 1px solid black;
} 

input:focus {
        border: 1px solid #58D68D;
        outline: none;
}


form > .textbox {
padding-bottom: 30px;
}

#loginGbtn{
	font-size : 18px;
	height: 50px;
	background-color: black;
	color: white;
	border: none;
	margin-bottom: 20px;
	/* border-radius: 20px;  */
}

#joinBtn {
	width: 350px;
	font-size : 18px;
	height: 50px;
	background-color: transparent;
	color: black;
	border: 1px solid black;
	margin-bottom: 40px;
	/* border-radius: 20px;  */
}



</style>

<script>

	//아이디 비밀번호 입력해야 전송되는 javascript
	function logincheck() {
		
		// 1. 사용자가 입력한 아이디 값을 폼에서 가져온다.
		let m_id = $("#m_id").val().trim();
		
		// 1-1. 아이디 작성하지 않았을 때
	    if (m_id == "") {
	        //alert("아이디를 입력해 주십시오.");
	        $("#msg").empty();
	        $("#msg").append("아이디를 입력해 주세요");
	        $("#msg").css("color", "red");
	        $("#m_id").focus();
	        return false;
	    }//if end
	    
		// 1-2. 아이디 5~15글자 이내 체크
		if(m_id.length<5 || m_id.length>15) {
			$("#msg").empty();
			$("#msg").append("아이디는 5~15글자 이내 입력해 주세요");
			$("#msg").css("color", "red");
			$("#m_id").focus();
			return false;
		}//if end
		
		
		// 2. 비밀번호 체크
		let m_pw = $("#m_pw").val().trim();
		
		// 2-1. 비밀번호 작성하지 않았을 때
	    if (m_pw == "") {
	        $("#msg").empty();
	        $("#msg").append("비밀번호를 입력해 주세요");
	        $("#msg").css("color", "red");
	        $("#m_pw").focus();
	        return false;
	    }//if end
	    
		// 2-2. 비밀번호 5~15글자 이내 체크
		if(!/^[a-zA-Z0-9]{8,20}$/.test(m_pw)) {
			$("#msg").empty();
			$("#msg").append("비밀번호는 숫자와 영문자 조합으로 8~20자리로 입력해야 합니다.");
			$("#msg").css("color", "red");
			$("#m_pw").focus();
			return false;
		}//if end
		
		return true;
	}//logincheck() end
</script>






<div class="jform">
<h1> 일반회원 로그인 </h1>
		<!-- <form method="post" action="login.do" onsubmit="return logincheck()"> -->
		<form method="post" action="<c:url value='/loginG.do'/>" onsubmit="return logincheck()">
					
					
				  <div class="textbox">
				  <input type="text" id="m_id" name="m_id" size="20" value="${cookie.id.value}" placeholder="아이디">
				  </div>
				  
				  <div class="textbox">
				  <input type="password" id="m_pw" name="m_pw" size="20" placeholder="비밀번호"> 
				  </div>

				
					
						<!-- js 로그인 유효성 검사  -->
						<p id="msg"></p>
						
						<!-- 로그인 실패했을 때 -->
						<c:if test="${result == 0}">
							<div class = "login_warn" style="color: red;">사용자 ID 또는 비밀번호를 잘못 입력하셨습니다.</div>
						</c:if>
	
				<div>
				    <input id="loginGbtn" type="submit" value="로그인" id="btn_logincheck" style="width: 350px;">
				</div>
				
				<div>
				<button id="joinBtn">
				<a onclick="location.href='/agreementG.do'">회원가입</a>
				</button>
				</div>

				<div style="text-align: center;">
					      <%-- <label><input type="checkbox" name="g_id" value="SAVE">아이디 저장</label>	 --%>
					      <input id="checkbox" type="checkbox" ${empty cookie.id.value ? "":"checked" } name="saveId" value="SAVE"style="white-space:nowrap;">
					      <label style="width: 100px;">아이디 저장 </label>
					      
				    	  &nbsp;&nbsp;&nbsp;	  
						  <a href="#" onclick="location.href=''">아이디 찾기</a>
						  &nbsp;&nbsp;&nbsp;
						  <a href="#" onclick="location.href=''">비밀번호 찾기</a>
				</div>
	</form>
</div>

<!-- </body> -->
<!-- </html> -->
<%@ include file="../footer.jsp" %>