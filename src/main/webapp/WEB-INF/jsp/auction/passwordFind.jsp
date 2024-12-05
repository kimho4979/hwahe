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
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, user-scalable=no">
	<meta name="apple-mobile-web-app-title" content="화훼유통정보시스템">
	<meta name="robots" content="no-index,follow">
	<meta name="og:title" content="화훼유통정보시스템">
	<meta name="og:description" content="화훼유통정보시스템">
	<meta name="description" content="가격문자알림서비스">
	<meta name="content" content="화훼유통정보시스템 입니다.">
	<meta name="keywords" content="화훼경매시세, 화훼경매가격, Korea aT flower market auction price, 화훼공판장, 화훼거래정보, 꽃시장, 꽃값">
	<meta name="Author" content="화훼유통정보시스템 & www.woorim.co.kr">
	<title>비밀번호찾기</title>
	
	<%@include file="../common/2020/commonJs.jsp" %>
	<%@include file="../common/2020/commonCss.jsp" %>
	
	<script type="text/javascript">
		var radio = null;
	
		$(document).ready(function(){
			$('#codeSection').hide();
			$('#pwd').hide();
			
			
			$('#btn1').click(function(){
				radioChk =  $("input:radio[name='radioGubun']:checked").val()
				if(radioChk=='email'){
				}else if(radioChk=='kakao'){
				}else if(radioChk==undefined){
					alert("카카오톡 또는 이메일을 선택하여 주십시오.");
					return
				}
				
				findEmail(id);
			})
			
			$('#btn2').click(function(){
				$.ajax({
					type : 'post',
					url : "/customInfo/compareAuthCode.json",
					data :  "userId="+$("#id").val()+"&authCode="+$("#code1").val(),
					dataType : 'json',   	           
					success : function(res){
						if(res.result){
							// 중복확인 완료
							alert('인증되었습니다.');
							$('#pwd').show();
						}else{
							if(res.msg == "countOver"){
								alert("인증번호 확인 횟수를 초과하였습니다.")
							}else{
								alert("인증번호가 틀립니다. 다시 확인해주세요.")
								return;	
							}
							
						}
					}
		       });
			});
		});
		
		function alertMethod(gubun){
			if(gubun=='kakao'){
				$("#id").attr('placeholder','예/01012345678');	
				
			}else{
				$("#id").attr('placeholder','예/abc@at.or.kr');
			}
		}
		
		function findEmail(emailId){
			var userId = $("#id").val();
			var radioChk = $("input:radio[name='radioGubun']:checked").val();
			
			if(radioChk=='email'){
				// 인증코드 메일 발송
				$.ajax({
					type : 'post',
					url : "/customInfo/sendAuthCode.json",
					data :  "userId="+$("#id").val(),
					dataType : 'json',   	           
					success : function(res){
					if(res.result == true){
						// 인증코드 메일 발송
						alert('이메일로 인증코드를 발송하였습니다.');
						$('#codeSection').show();
					}}
				});
			}else if(radioChk=='kakao'){
				// 인증코드 메일 발송
				$.ajax({
					type : 'post',
					url : "/customInfo/sendAuthCodeKakao.json",
					data :  "userId="+$("#id").val(),
					dataType : 'json',   	           
					success : function(res){
					if(res.result == true){
						// 인증코드 메일 발송
						alert('카카오톡으로 인증코드를 발송하였습니다.');
						$('#codeSection').show();
					}}
				});
			}
		}
		function chkPassword(password){
			var chkText = "";
			var chkBoolean =true;
			var chkNumber = password.search(/[0-9]/g);
			var chkEnglish = password.search(/[a-z]/ig);
			
			if(password.length == 0){
				chkText = "";
				chkBoolean= false;
			/* }else if(!/^[a-zA-Z0-9]{10,15}$/.test(password)){ */
			}else if(!/^(?=.*[a-zA-Z])((?=.*\d)|(?=.*\W)).{10,15}$/.test(password)){				
				chkText = '숫자와 영문자 조합으로 10~15자리를 사용해야 합니다.';
				chkBoolean= false;
			} else if(chkNumber <0 || chkEnglish <0){
				chkText ="숫자와 영문자를 혼용하여야 합니다."; 
				chkBoolean= false;
			} else if(/(\w)\1\1\1/.test(password)){
				chkText ="444같은 문자를 4번 이상 사용하실 수 없습니다."; 
				chkBoolean= false;
			} else  if(password.search($("#id").val()) > 0){
				chkText ="비밀번호에 아이디가 포함되었습니다."; 
				chkBoolean= false;
			}
			
			if(chkBoolean==true){
				chkText="사용가능한 패스워드입니다.";
			}
			
			$("#chkPass").text(chkText);
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
		}
		
		function captureReturnKey(e) {
		    if(e.keyCode==13 && e.srcElement.type != 'textarea')
		    return false;
		}
		
		/* 사용자 저장 */
		function updateCustomInfo(){
			if($("#chkPass").text()  != "사용가능한 패스워드입니다." ){
				alert("비밀번호가 형식에 맞지않습니다.");
				$("#passwdChk").focus();
				return;
			}
			
			if($("#chkDup").text()  != "비밀번호 일치" ){
				alert("비밀번호가 일치하지 않습니다.");
				$("#passwdChk").focus();
				return;
			} 
			// saveCustomInfo
			$.ajax({
				type : 'get',
				url : "/password/changePasswd.json",
				data :  $("#passwordForm").serialize(),
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
					alert('수정실패하였습니다. 관리자에게 문의하세요.');
					return;
				}
			}); 
			
		}
		
	</script>
</head>
<body>
	<!--WRAP(S)-->
	<div class="wrap">
			
		<jsp:include page="../inc/2020/IncHeader.jsp"/>
		
		<!--서브 타이틀(S)-->
		<div class="sub_sns">
		</div>
		<div class="sub_title">
			<div class="title_box">
				<h2>가격문자알림서비스</h2>
				<p>전국 화훼공판장의 졍매정보를 확인 할 수 있습니다.</p>
				<img src="../images/2020/sub/t_line.png" alt="방울점선">
			</div>
		</div>
		<!--서브 타이틀(E)-->
		<!--서브공통 (S)-->
		<div class="sub_contents">
		
		</div>
		<!--컨텐츠 내용(S)-->
		<div class="sub_guide">
			<div class="id_pasw_box">
				<div class="pasw_txt_b">
					<p>비밀번호를 잊어버리셨나요?</p>
					<p>입력하신 이메일로 임시 비밀번호를 보내드립니다.</p>
				</div>
				<h2 class="title_02">비밀번호 찾기</h2>
				<form id="passwordForm">
				<div class="id_chkbox">
					<!--아이디 입력창 (S)-->
					<ul class="id_text_a">
						<li>
							<input type="radio" name="radioGubun" id="radioGubun1" value="kakao" onclick="alertMethod(this.value)" />
							<label for="radioGubun1" class="title_box_chk space"><span></span>카카오톡</label>
							<input type="radio" name="radioGubun" id="radioGubun2" value="email" onclick="alertMethod(this.value)" />
							<label for="radioGubun2" class="title_box_chk"><span></span>이메일</label>
						</li>
						<li>
							<label class="nm_t" for="id">아이디</label>
							<input type="text" id="id" name="id" placeholder="예/01012345678" value="${userId}" />
						</li>
						<li class="id_btn_01">
							<button type="button" id="btn1">확인</button> 
						</li>
						<li>
							<p>맞춤정보 설정 시 사용하신 아이디를 입력해 주세요.</p>
						</li>
					</ul>
					<!--아이디 입력창 (E)-->
					<!--아이디 입력창 (S)-->
					<ul class="id_text_b" id="codeSection">						
						<li>
							<label class="nm_t" for="code1">인증코드</label>
							<input type="text" id="code1" name="code1" placeholder="예/abc123"/>
						</li>
						<li class="id_btn_01">
							<button type="button" id="btn2">확인</button> 
						</li>
					</ul>
					<ul class="id_text_b" id="pwd">			
						<li>
							<label class="nm_t" for="passwd">비밀번호</label>
							<input type="password" id="passwd" name="passwd" placeholder="예/abc123!@#" onkeyup="chkPassword(this.value)" autocomplete="off"><p id="chkPass"></p>
							<p class="notice_01">비밀번호는 10~15자의 영문, 숫자를 조합하거나 특수문자를 포함하여 조합하셔야 합니다.</p>
						</li>
						<li>
							<label class="nm_t" for="passwdChk">비밀번호 확인</label>
							<input type="password" id="passwdChk" name="passwdChk" placeholder="예/abc123!@#" onkeyup="chkSamePw(this.value)" autocomplete="off"><p id="chkDup"></p>
						</li>
						<li class="id_btn_01">
							<button type="button" id="btn3" onclick="updateCustomInfo();">수정</button> 
						</li>
					</ul>
					<!--아이디 입력창 (E)-->
				</div>
				</form>
			</div>	
		</div>
		<!--컨텐츠 내용(E)-->
		
		<jsp:include page="../inc/2020/IncFooter.jsp"/>
		
	</div>
	<!--WRAP(E)-->
</body>
</html>
