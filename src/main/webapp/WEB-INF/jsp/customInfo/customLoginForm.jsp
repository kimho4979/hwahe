<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
	<meta name="og:description" content="화훼유통정보시스템"/>
	<meta name="description" content="가격문자알림서비스">
	<meta name="content" content="화훼유통정보시스템 입니다."/>
	<meta name="keywords" content="화훼경매시세, 화훼경매가격, Korea aT flower market auction price, 화훼공판장, 화훼거래정보, 꽃시장, 꽃값">
	<meta name="Author" content="화훼유통정보시스템 & www.woorim.co.kr"/>
	<title>가격문자알림서비스</title>
	<%@include file="../common/2020/commonJs.jsp" %>
	<%@include file="../common/2020/commonCss.jsp" %>
	
	<script type="text/javascript">
	
		function joinCustionInfo(){
			var url = "/customInfo/customInfoRegForm.do";
			$(location).attr('href',url);
		}
		
		function loginCheck(){
			var userId = $("#userId").val();
			var userPw = $("#passwd").val();
			
			if(userId == null || userId == ""){
				alert("아이디를 입력하여 주십시오.")
			}else if(userPw == null || userPw == ""){
				alert("비밀번호를 입력하여 주십시오");
			}else{
				$.ajax({
					type : 'post',
					url : "/customInfo/loginCustomInfo.json",
					data :  "userId="+userId+"&passwd="+userPw,
					dataType : 'json',
					success : function(res){
						var val = res.user;
						if(val == '' || val == null){
							alert("아이디 또는 비밀번호를 확인하여 주십시오.");
						}else if(val != '' || val != null){
							var url = "/customInfo/loginCustomInfo.do";
							$(location).attr('href',url);
						}
					}
				});
			}
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

				<!-- 로그인 타이틀(S) -->
				<div class="log_title_box">
					<h2 class="log_tit">가격문자알림서비스</h2>
					<p class="log_sant">aT 화훼유통정보시스템에 방문하신 것을 환영합니다. 아이디 및 비밀번호를 입력해 주세요.</p>
				</div>
				<!-- 로그인 타이틀(E) -->

				<!-- 로그인 박스(S) -->
				<div class="log_box">
					<div class="log_input_box">
						<div class="l_input">
							<form id="actionForm" name="actionForm" method="post" class="customWrap" action="/customInfo/loginCustomInfo.do">
							<ul>
								<li>
									<span>아이디</span>
									<label for="userId">
										<input type="text" placeholder="이메일 또는 휴대폰번호" id="userId" name="userId" />
									</label>
								</li>
								<li>
									<span>비밀번호</span>
									<label for="passwd">
										<input type="password" id="passwd" name="passwd" autocomplete="off"/>
									</label>
								</li>
							</ul>
							</form>
						</div>
						<div class="l_btn">
							<button type="button" class="btn_login" id="btn1" onclick="loginCheck();">로그인</button>
						</div>
					</div>
					<div class="log_etc_box">
						<div class="l_sign">
							<p>처음 방문하셨나요?</p>
							<button type="button" class="btn_type_log" onclick="joinCustionInfo();">회원가입</button>
						</div>
						<div class="l_find">
							<p>비밀번호를 잊으셨나요?</p>
							<a href="/password/passwordFind.do"><button type="button" class="btn_type_log">비밀번호 찾기</button></a>
						</div>
					</div>

				</div>
				<!-- 로그인 박스(E) -->
			</div>
		</div>
		<!--콘텐츠_메인(E)-->

		<jsp:include page="../inc/2020/IncFooter.jsp"/>
		
	</div>
	<!--WRAP(E)-->
</body>
</html>