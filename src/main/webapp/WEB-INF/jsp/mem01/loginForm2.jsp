<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
    <%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1, maximum-scale=1.0, minimum-scale=1" />
<title>화훼유통정보시스템 모니터요원 입력시스템 </title>
  <!-- @@@@@@@@@@@@@@@@@@@@@@ css begin @@@@@@@@@@@@@@@@@@@@@@ -->
  <link rel="stylesheet" type="text/css" href="<c:url value='/rMateChart/rMateChartH5/Assets/Css/rMateChartH5.css' />"/>   
 <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/axicon/axicon.min.css' />" />
 <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/arongi/AXJ.min.css' />" />
 <link rel="stylesheet" type="text/css" href="<c:url value='/css/hw/ma.css' />" />
 <link rel="stylesheet" type="text/css" href="<c:url value='/css/hw/common.css' />" />
  <!-- @@@@@@@@@@@@@@@@@@@@@@ css end   @@@@@@@@@@@@@@@@@@@@@@ --> 
  
  <script type="text/javascript" src="<c:url value='/axisj/jquery/jquery.min.js' />"></script>
  <script type="text/javascript" src="<c:url value='/axisj/dist/AXJ.min.js' />"></script>
  <script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/ax5-polyfill.js' />"></script>
  <script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/axjApp.js' />"></script>
  
  
  
  <!-- rMateChartH5 라이센스 시작 -->
  <script type="text/javascript" src="<c:url value='/rMateChart/LicenseKey/rMateChartH5License.js' />"></script>
  <!-- rMateChartH5 라이센스 끝-->  
  <!-- 실제적인 rMateChartH5 라이브러리 시작-->
   <script type="text/javascript" src="<c:url value='/rMateChart/rMateChartH5/JS/rMateChartH5.js' />"></script>
  <!-- 실제적인 rMateChartH5 라이브러리 끝-->  
  <!-- rMateChartH5 테마 js -->
  <script type="text/javascript" src="<c:url value='/rMateChart/rMateChartH5/Assets/Theme/theme.js' />"></script>
  
  <!-- @@@@@@@@@@@@@@@@@@@@@@ css end   @@@@@@@@@@@@@@@@@@@@@@ --> 
  <script type="text/javascript">
  
function smsChk(){
	   if($("#userCd").val()!='flower' ){
       	alert("아이디를 바르게 입력해주세요.");
       	$("#userCd").val('')
       	$("#userCd").focus();
       	return false;
       }
       
       if($("#userPs").val()!='1234'){
       	alert("패스워드를 바르게 입력해주세요.");
       	$("#userPs").val('');
       	$("#userPs").focus();
       	return false;
       }
       
     var mobileKeyWords = new Array('iphone', 'ipod', 'blackberry', 'android',  'sonyericsson', 'mobile');
       var userAgent = navigator.userAgent.toLowerCase();
       for (var word in mobileKeyWords){
    	   var form=document['login-form']
           if (userAgent.match(mobileKeyWords[word]) != null){
        	   form.action="/maa11/maa11.do";
        	   form.submit();
        	   break;
           }else{
        	   form.action="/maa01/maa01.do";
        	   form.submit();
           }
       }
}
  
  
//$(document).ready(fnObj.pageStart);
</script>
   
</head>
<body>

	<div class="wrap_finding_id">
		<div class="hw_login_section">
			<div class="hw_at_ig" >
			<img src="/images/hw/logo_system.JPG" alt="모니터요원입력화면" style="width:300px; height:68px;" />
				<form name="login-form" class="frm" method="post" action="/maa01/maa01.do" onsubmit="return smsChk();">
					<div class="hw_all_left"><input type="text" name="userCd" id="userCd" class="login_id" />
					<input type="password" name="userPs" id="userPs" class="login_pw" autocomplete="off" />
					</div>					
					<div class="hw_all_right"><input type="submit" value="로그인" class="login_btn" /></div>
				</form>	
			<span class="login_title" style="text-align:left;">아이디또는 비밀번호 분실시 담당자에게 연락바랍니다.</span>
			<span class="login_title2" style="text-align:left;">로그인은 모니터 요원만 가능합니다.</span>
			</div>
	</div>		
</div>
</body>
</html>