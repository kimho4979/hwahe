<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%@page import="org.apache.commons.lang3.StringUtils" %>


<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, user-scalable=no">
	<title>화훼유통정보시스템 모니터요원</title>
	<!-- @@@@@@@@@@@@@@@@@@@@@@ css begin @@@@@@@@@@@@@@@@@@@@@@ -->
	<link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/cocker/AXJ.min.css' />" id="axu-theme-axisj" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/hw/ma.css' />" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/hw/common.css' />" />

<!-- @@@@@@@@@@@@@@@@@@@@@@ css end @@@@@@@@@@@@@@@@@@@@@@ -->

<!-- @@@@@@@@@@@@@@@@@@@@@@ javascript START @@@@@@@@@@@@@@@@@@@@@@ --> 
	<script type="text/javascript" src="<c:url value='/axisj/jquery/jquery.min.js' />"></script>
	<script type="text/javascript" src="<c:url value='/axisj/dist/AXJ.min.js' />"></script>
	<script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/ax5-polyfill.js' />"></script>
	<script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/axjApp.js' />"></script>            
 <!-- @@@@@@@@@@@@@@@@@@@@@@ javascript END @@@@@@@@@@@@@@@@@@@@@@ --> 
 <%
	String l_reqUri    = StringUtils.defaultString(request.getParameter("reqUri"),"");
 	System.out.println(l_reqUri);
%>

<script language="javascript">
$(function() {
	fnObj.pageStart();
});

var fnObj = {
        pageStart: function(){      
        	//항상 로그인화면은 Top Window 에서 실행되도록!
        	if ( top.location.href != self.location.href)
        	{
        		top.location.href = self.location.href;
        		return;
        	}
        	
        	$("#pwd").on("keypress", function(e){
        		var ch = e.keyCode ? e.keyCode : e.which;
        		if (ch == 13) { fnObj.smsChk(); return true; }
        	});
        	            
        },
        smsChk: function () {
            if($("#loginId").val() == ''){
                alert("아이디를 입력해 주세요.");
                $("#loginId").focus();
                return false;
            }
            
            if( $("#pwd").val() == ''){
            	 alert("비밀번호를 입력해 주세요.");
                 $("#pwd").focus();
            	return false;
            }
            
            var f = document.login-form;
             
            app.ajax({
                 type: "GET",
                 url: "/login/loginProc.json",
                 data: {loginId:f.usrId.value, pwd:f.pwd.value}
             }, function(res){
           	   if(axf.isEmpty(res)|| res.result||res.result.code){
           		   alert("로그인에 실패하였습니다. <br>다시 시도해 주세요");
           		   return;
           		   
           	   }else{/*             		               		               		              		
           		 
           		   for (var word in mobileKeyWords){
           			   alert("모바일성공");
           	    	   //var form=document['login-form']
           	           if (userAgent.match(mobileKeyWords[word]) != null){
           	        	  
           	        	   if(res.result.code=="OK"){
                   			   if(res.result.passChange == "Y"){            				   
                          			top.location.href = ROOT + "/maa11/maa11.do?passChange=Y";
                          		} else {
                          			top.location.href = ROOT + "/maa11/maa11.do";
                          		}
                   		   }else{
                   			   alert('계정 정보가 일치하지 않습니다.');
                   			   return;
                   		   }
           	        	   
           	        	  // form.action="/maa11/maa11.do";
           	        	  // form.submit();
           	        	   break;
           	           }else{
           	        	   alert("웹성공");
           	        	   if(res.result.code=="OK"){
                   			   if(res.result.passChange == "Y"){            				   
                          			top.location.href = ROOT + "/maa01/maa01.do?passChange=Y";
                          		} else {
                          			top.location.href = ROOT + "/maa01/maa01.do";
                          		}
                   		   }else{
                   			   alert('계정 정보가 일치하지 않습니다.');
                   			   return;
                   		   }
           	        	   //form.action="/maa01/maa01.do";
           	        	   //form.submit();
           	           }
           	       } */
           	   }
           	   return true;
         	});		     
        },
        login: function () {
        	
        }
    };

	function fnLogin() {				 		 
		 
	}				    
</script>

</head>

<body>
<div class="wrap_finding_id">
		<div class="hw_login_section">
			<div class="hw_at_ig" >
			<img src="/images/hw/logo_system.JPG" alt="모니터요원입력화면" style="width:300px; height:68px;" />
				<form name="login-form" method="Post" action="<c:url value='/login/loginProc.do'/>" onsubmit="return fnObj.smsChk();">
				 <input type="hidden" name="reqUri" id="reqUri" value="<%=l_reqUri%>"/>	
					<div class="hw_all_left hw_all_left_otp">
						<label class="blind" for="loginId">아이디</label>
						<input type="text" name="loginId" id="loginId"  value="" class="login_id"  placeholder="ID"/>
						<label class="blind" for="pwd">비밀번호</label>
						<input type="password" name="pwd" id="pwd" value="" class="login_pw"  placeholder="password" autocomplete="off"/>
						<label class="blind" for="otp">아이디</label>
						<input type="input" name="otp" id="otp" value="" class="login_pw" maxlength="6" minlength="6" placeholder="otp"/>
					</div>					
					<div class="hw_all_right hw_all_right_otp">
						<input type="submit"  id="login"  name="login" value="로그인" class="login_btn login_otp_btn" />
					</div>
				</form>	
			<span class="login_title" style="text-align:left;">아이디 또는 비밀번호 분실시 담당자에게 연락바랍니다.</span>
			<span class="login_title2" style="text-align:left;">로그인은 모니터 요원만 가능합니다.</span>
		</div>
	</div>		
</div>

</body>
</html>