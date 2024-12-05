<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8"/>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, user-scalable=no"/>
	<meta name="apple-mobile-web-app-title" content="화훼유통정보시스템"/>
	<meta name="robots" content="no-index,follow"/>
	<meta name="og:title" content="화훼유통정보시스템"/>
	<meta property="og:type" content="website"/>
	<meta name="og:description" content="화훼유통정보시스템"/>
	<meta name="description" content="회원가입-본인인증">
	<meta name="content" content="화훼유통정보시스템 입니다."/>
	<meta name="keywords" content="화훼경매시세, 화훼경매가격, Korea aT flower market auction price, 화훼공판장, 화훼거래정보, 꽃시장, 꽃값">
	<meta name="Author" content="화훼유통정보시스템 & www.woorim.co.kr"/>
	<title>회원가입-아이디생성</title>
	<%@include file="../common/2020/commonCss.jsp" %>
	<%@include file="../common/2020/commonJs.jsp" %>
	
	<script type="text/javascript">
		var index=0;
	
		$(document).ready(function(){
			$("#email_txt").hide();
			
			$("#userId").keypress(function (e) {
		        if (e.which == 13){
		        	chkCustomInfo();
		        }
		    });
		});
		
		function alertMethod(gubun){
			if(gubun=='kakao'){
				$("#userId").attr('placeholder','예/01012345678');	
				$("#buttonCheck").text('중복 체크');
				$("#email_txt").hide();
				$("#kakao_txt").show();
				
			}else{
				$("#userId").attr('placeholder','예/abc@at.or.kr');
				$("#buttonCheck").text('중복 체크');
				$("#email_txt").show();
				$("#kakao_txt").hide();
			}
		}
		
		function sendCode(){
			var userId = $("#userId").val();
			var radioChk = $("input:radio[name='radioGubun']:checked").val();
			
			if(radioChk=='email'){
				if(!chkEmail()){
					return;
				}
			}else if(radioChk=='kakao'){
				if(!chkKakao()){
					return;
				}
			}
			
			if(radioChk=='email'){
				// 인증코드 메일 발송
				$.ajax({
					type : 'post',
					url : "/customInfo/sendAuthCode.json",
					data :  "userId="+$("#userId").val(),
					dataType : 'json',   	           
					success : function(res){
					if(res.result == true){
						// 인증코드 메일 발송
						alert('이메일로 인증코드를 발송하였습니다.');
					}}
				});
			}else if(radioChk=='kakao'){
				// 인증코드 메일 발송
				$.ajax({
					type : 'post',
					url : "/customInfo/sendAuthCodeKakao.json",
					data :  "userId="+$("#userId").val(),
					dataType : 'json',   	           
					success : function(res){
					if(res.result == true){
						// 인증코드 메일 발송
						alert('카카오톡으로 인증코드를 발송하였습니다.');
					}}
				});
			}
			
		}
		
		/* ID 중복확인 */
		function chkCustomInfo(){
			// 인증값
			var param = '<%=request.getParameter("authCode")%>';
			
			// 선택값
			var userId = $("#userId").val();
			var radioChk = $("input:radio[name='radioGubun']:checked").val();
			
			if(userId==''){
				alert('아이디를 입력하세요.');
				return;
			}
			
			if(radioChk=='email'){
				if(!chkEmail()){
					return;
				}
			}else if(radioChk=='kakao'){
				if(!chkKakao()){
					return;
				}
			}
			
			$.ajax({
				type : 'post',
				url : "/customInfo/getCustomInfo.json",
				data :  "userId="+$("#userId").val()+"&authCode="+param,
				dataType : 'json',   	           
				success : function(res){					
					if(res.customInfo == null && res.error == null){
						// 중복확인 완료
 						//console.log('사용가능한 계정입니다.');
						chkIdText = "사용가능한 계정입니다.";
					}else if (res.error != null){
						chkIdText = res.error;
						$("#userId").val('');
						$("#userId").focus();
					} else {
						//console.log('이미 사용중인 계정입니다.');
						chkIdText = "이미 사용중인 계정입니다.";
						$("#userId").val('');
						$("#userId").focus();
					}
					$("#chkIdDup").text(chkIdText);
				}
	       });
		}
		
		/* email 체크 */
		function chkEmail(){
			var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
			var email = $("#userId").val();
			if (email == '' || !re.test(email)) {
				alert("올바른 이메일 주소를 입력하세요");
				return false;
			}
			return true;
		}
		
		/* 휴대폰번호 체크 */
		function chkKakao(){
			var re = /^\d{3}\d{3,4}\d{4}$/;
			var phone = $("#userId").val();
			if (phone == '' || !re.test(phone)) {
				alert("올바른 휴대폰번호를 입력하세요");
				return false;
			}
			return true;
		}
		
		// 인증코드 확인
// 		function fnChkAuthCode(){
// 			$.ajax({
// 				type : 'post',
// 				url : "/customInfo/compareAuthCode.json",
// 				data :  "userId="+$("#userId").val()+"&authCode="+$("#authCode").val(),
// 				dataType : 'json',   	           
// 				success : function(res){
// 					if(res.result){
// 						// 중복확인 완료
// 						alert('인증되었습니다.');
// 					}else{
// 						alert("인증번호가 틀립니다. 다시 확인해주세요.")
// 						return;
// 					}
// 				}
// 	       });
// 		}
		
		function chkPassword(password){
// 			console.log("chkPassword : "+password);
			var chkBoolean =true;
			var chkNumber = password.search(/[0-9]/g);
			var chkEnglish = password.search(/[a-z]/ig);
			var chkSpecial = password.search(/[!@$%^&*]/gi);
			
// 			console.log("chkNumber : "+chkNumber);
// 			console.log("chkEnglish : "+chkEnglish);
// 			console.log("chkSpecial : "+chkSpecial);
			
			if(password.length == 0){
				chkText = "비밀번호를 입력하세요.";
				chkBoolean= false;
			} else if(!/^(?=.*[a-zA-Z])((?=.*\d)(?=.*?[!@$%^&*])|(?=.*\W)).{10,15}$/.test(password)){
				chkText = '숫자, 영문자, 특수문자(!@$%^&* 만 허용) 조합으로 10~15자리를 사용해야 합니다.';
				chkBoolean= false;
			} else if(chkNumber < 0 || chkEnglish < 0 || chkSpecial < 0){
				chkText ="숫자, 영문자, 특수문자(!@$%^&* 만 허용)를 혼용하여야 합니다."; 
				chkBoolean= false;
			} else if(/(\w)\1\1\1/.test(password)){
				chkText ="같은 문자를 4번 이상 사용하실 수 없습니다."; 
				chkBoolean= false;
			} else if(chkContinuePw(password)){
				chkText ="비밀번호에 연속된 숫자를 4자 이상 사용 할 수 없습니다."; 
				chkBoolean= false;
			} else if(password.search($("userId").val()) > 0){
				chkText ="비밀번호에 아이디가 포함되었습니다."; 
				chkBoolean= false;
			}
			
			if(chkBoolean==true){
				chkText="사용가능한 패스워드입니다.";
			}
			
			$("#chkPass").text(chkText);
			return chkText
		}
		
		function chkSamePw(password){
			var chkText = "";
			var chkBoolean =true;
			var passwd = $("#passwd").val();
			
			if(password.length==0){
				chkText = '';
			}else if(passwd == password){
				chkText = '비밀번호 일치';
			}else{
				chkText = '비밀번호 불일치';
			}
			
			$("#chkDup").text(chkText);
			return chkText;
		}
		
		function chkContinuePw(password){
			var o = 0;
			var d = 0;
			var p = 0;
			var n = 0;		
			var limit = 4;
			for(var i = 0; i < password.length; i++) {
				var tempVal = password.charAt(i);
				
				if (i > 0 && (p = o - tempVal) > -2 && p < 2 && (n = p == d ? n + 1 : 0) > limit - 3) {
					return true;
				}
				  
				d = p;
				o = tempVal;
			}
			
			return false;
		}
		
		/* step2 show*/
		function saveUser(){
			$.ajax({
				type : 'get',
				url : "/customInfo/saveUser.json",
				data :  $("#actionForm").serialize(),
				dataType : 'json',   	           
				success : function(res){    
					if(res.result){
						alert('저장되었습니다');
						var url = "/customInfo/customInfoForm.do";
						$(location).attr('href',url);	
					}else{
						alert(res.resultMsg);
						return;
					}
				},
				error : function(res){
					alert('저장실패');
					return;
				}
			}); 
		}
		
		function cancel(){
			var url = "/main/flowerMain.do";
			if(confirm("페이지의 정보가 사라집니다. 페이지를 이동하시겠습니까?") == true){
				$(location).attr('href',url);	
			}
		}
		
		function captureReturnKey(e) {
		    if(e.keyCode==13 && e.srcElement.type != 'textarea')
		    return false;
		}
		
	</script>
</head>
<body>
	<!--WRAP(S)-->
	<div class="wrap">
		 
		<jsp:include page="../inc/2020/IncHeader.jsp"/>	

		<!--콘텐츠_메인(S)-->
		<div class="conts_main">
			<div class="conts_main_in">

				<!-- 서브타이틀(S) -->
				<div class="log_title_box">
					<h2 class="log_tit">회원가입</h2>
					<p class="log_sant">화훼유통정보 홈페이지 회원가입을 환영합니다.</p>
				</div>
				<!-- 서브타이틀(E) -->

				<!-- 회원가입순서(S) -->
				<div class="sign_step">
					<ul>
						<li>
							<p>1 STEP</p>
							<span>약관동의</span>
						</li>
						<li>
							<p>2 STEP</p>
							<span>본인인증</span>
						</li>
						<li class="on">
							<p>3 STEP</p>
							<span>아이디생성</span>
						</li>
						<li>
							<p>4 STEP</p>
							<span>정보입력</span>
						</li>						
						<li>
							<p>5 STEP</p>
							<span>가입완료</span>
						</li>
					</ul>
				</div>
				<!-- 회원가입순서(E) -->

				<!-- 회원가입 내용(S) -->
				<form id="actionForm" name="actionForm"  method="post">
				
				<div class="tit_box_01">
					<div class="fl">
						<h3 class="sub_title_01">아이디생성</h3>
					</div>
				</div>
				<div class="tit_box_02">
					<div class="fl">
						<p class="notice_01">가격문자 알림 서비스 이용을 위해서는 아래 사항을 입력하여 주셔야 합니다.</p>
					</div>
				</div>
				
				<table class="table_type_01">
					<caption>관리계정 만들기</caption>
					<colgroup>
						<col style="width:25%">
						<col style="width:75%">
					</colgroup>
					<tbody>
						<tr>
							<th>아이디방식</th>
							<td>
								<input type="radio" name="radioGubun" id="radioGubun1" value="kakao" onclick="alertMethod(this.value)" checked />
								<label for="radioGubun1" class="title_box_chk space"><span></span>핸드폰</label>
								<input type="radio" name="radioGubun" id="radioGubun2" value="email" onclick="alertMethod(this.value)" />
								<label for="radioGubun2" class="title_box_chk"><span></span>이메일</label>
							</td>
						</tr>
						<tr>
							<th>아이디</th>
							<td>
								<input type="text" class="ip_text id" id="userId" name="userId" placeholder="예/01012345678"/>
								<div class="btn_box_02">
									<button type="button" class="btn_type_03" onclick="chkCustomInfo();" id="buttonCheck1">중복체크</button>
									
									<!-- button type="button" class="btn_type_03" onclick="sendCode();" id="buttonCheck2">인증번호발송</button> -->
								</div>
								<p id="chkIdDup"></p>
								<div id="email_txt">
									<p class="notice_01">사용중인 이메일인 경우 기존에 등록되었던 메일을 체크해 주시기 바랍니다.</p>
								</div>
								<div id="kakao_txt">
									<p class="notice_01">사용중인 휴대폰번호인 경우 기존에 등록되었던  번호를 체크해 주시기 바랍니다.</p>
								</div>								
							</td>
						</tr>
						<!-- 
						<tr>
							<th>인증코드</th>
							<td>
								<input type="text" class="ip_text code" id="authCode" name="authCode">
								<div class="btn_box_02">
									<button type="button" class="btn_type_03" onclick="fnChkAuthCode()">확인</button>
								</div>
							</td>
						</tr>
						 -->
						<tr>
							<th>비밀번호</th>
							<td>
								<input type="password" class="ip_text code" id="passwd" name="passwd" onkeyup="chkPassword(this.value)" autocomplete="off"><p id="chkPass"></p>
								<p class="notice_01">비밀번호는 10~15자의 영문, 숫자를 조합하거나 특수문자를 포함하여 조합하셔야 합니다.</p>
							</td>
						</tr>
						<tr>
							<th>비밀번호 확인</th>
							<td>
								<input type="password" class="ip_text code" id="passwdChk" name="passwdChk"  onkeyup="chkSamePw(this.value)" autocomplete="off"><p id="chkDup"></p>
							</td>
						</tr>
					</tbody>
				</table>
				
				</form>
				<!-- 회원가입 내용(E) -->

				<div class="btn_box tc">
					<p class="notice_btn">서비스 이용 신청에 동의하시면 [확인]버튼을 눌러주세요.</p>
					<a href="javascript:void(0);" class="btn_type_02" onclick="saveUser();">확인</a>
					<a href="javascript:void(0);" class="btn_type_02" onclick="cancel();">취소</a>
				</div>
			</div>
		</div>
		<!--콘텐츠_메인(E)-->

		<jsp:include page="../inc/2020/IncFooter.jsp"/>
		
	</div>
	<!--WRAP(E)-->
</body>
</html>