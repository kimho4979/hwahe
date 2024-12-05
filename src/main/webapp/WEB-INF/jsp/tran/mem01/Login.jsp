<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%@page import="org.apache.commons.lang3.StringUtils" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>화훼유통정보시스템 ::: </title>
  <!-- @@@@@@@@@@@@@@@@@@@@@@ css begin @@@@@@@@@@@@@@@@@@@@@@ -->
    <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/axicon/axicon.min.css' />" />
     <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/cocker/cmn/admin.css' />" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/cocker/AXJ.min.css' />" id="axu-theme-axisj" />

<!-- @@@@@@@@@@@@@@@@@@@@@@ css end @@@@@@@@@@@@@@@@@@@@@@ -->
      
<!-- @@@@@@@@@@@@@@@@@@@@@@ javascript START @@@@@@@@@@@@@@@@@@@@@@ --> 
 <script type="text/javascript" src="<c:url value='/axisj/jquery/jquery.min.js' />"></script>
  <script type="text/javascript" src="<c:url value='/axisj/dist/AXJ.min.js' />"></script>
  <script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/ax5-polyfill.js' />"></script>
  <script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/axjApp.js' />"></script>
  
       
       
 <!-- @@@@@@@@@@@@@@@@@@@@@@ javascript END @@@@@@@@@@@@@@@@@@@@@@ --> 
 <%
	String l_reqUri    = StringUtils.defaultString(request.getParameter("reqUri"),"");
%>
  
</head>
<body>
<div id="AXPage" class="login">
	<div class="ax-body">
		<div class="ax-wrap">

			<div class="ax-layer ax-title">
				<div class="ax-col-12">
					<h1></h1>
					<p class="desc"></p>
				</div>
                <div class="ax-clear"></div>
			</div>

			<div class="ax-layer">
				<div class="ax-col-12">
					<div class="ax-unit">

						<div class="ax-box">
							<h1>로그인</h1>
							<p></p>
							<div class="H20"></div>
                            <form name="login-form" method="Post" action="<c:url value='/tran/login/loginProc.do'/>" onsubmit="return fnObj.smsChk();">
                              <input type="hidden" name="reqUri" id="reqUri" value="<%=l_reqUri%>"/>	
                                <div class="ax-input">
                                    <span class="name">ID</span>
                                    <input type="text" name="loginId" id="loginId"  value=""    style="ime-mode:disabled;"  class="AXInput" placeholder="ID">
                                </div>
                                <div class="ax-input">
                                    <span class="name">Password</span>
                                    <input type="password" name="pwd" id="pwd" value="" class="AXInput" placeholder="password">
                                </div>

                                <div class="ax-clear"></div>
                                <div class="H20"></div>

                                <div class="ax-funcs">
                                   
                                    <button type="submit"  id="login"  name="login"  class="AXButtonLarge Blue">&nbsp;&nbsp;로그인&nbsp;&nbsp;</button>
                                </div>
                            </form>

							<div class="ax-clear"></div>
							<div class="H20"></div>

							<div class="ax-opts">
							
							</div>

                            <p>
                                IE8+, Chrome, Firefox, safari
                            </p>
                            <div class="H20"></div>

						</div>

					</div>
				</div>
                <div class="ax-clear"></div>
			</div>

			
		</div>
	</div>
</div>
<script language="javascript">
$(function() {
	//항상 로그인화면은 Top Window 에서 실행되도록!
	if ( top.location.href != self.location.href)
	{
		top.location.href = self.location.href;
		return;
	}
	
	// 한글입력방지를 위해서는 keypress 가 아니라 keydown 에서 막아야!!
	// 크롬등에서 229 (IE 는 ime-mode:disabled; 로 막음) (완벽하지 않고 보조수단으로 활용)
	$("#loginId").on("keydown", function(e) {		
		var ch = e.keyCode ? e.keyCode : e.which;
		if (ch == 229)	return false;		
		return true;
	});

	// 실제 영문,숫자 입력체크는 keypress 에서
	$("#loginId").on("keypress", function(e) {
		var ch = e.keyCode ? e.keyCode : e.which;
		if (ch >= 48 && ch <= 57)	return true;    // 숫자 (0:48, ... 9:57)
		if (ch >= 65 && ch <= 90)	return true;    // 대문자 (A:65, ... Z:90)
		if (ch >= 97 && ch <= 122)	return true;    // 소문자 (A:97, ... Z:122)
		if (ch == 13) { fnLogin(); return true; }
		return false;
		
	});

	$("#pwd").on("keypress", function(e){
		var ch = e.keyCode ? e.keyCode : e.which;
		if (ch == 13) { fnObj.smsChk(); return true; }
	});
	
    //------------------------------------------------------
    // 로그인 처리
    //------------------------------------------------------
    $("#pwd").on("click", function() {
    	fnLogin();
    	return false; 	// #none 안나오도록 
    });
	
	

});

var fnObj = {
        pageStart: function(){
        	 
            
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
            
           /*  console.log($("#userPs").val());
            if($("#userCd").val()!='admin' ){
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
             */
             var f = document.login-form;
             
             app.ajax({
                 type: "GET",
                 url: "/tran/login/loginProc.json",
                 data: {loginId:f.usrId.value, pwd:f.pwd.value}
             }, function(res){
            	 
            	   console.log(res);
            	   if(axf.isEmpty(res)|| res.result||res.result.code){
            		   alert("로그인에 실패하였습니다. <br>다시 시도해 주세요");
            		   return;
            		   
            	   }else{
            		   if(res.result.code=="OK"){
            			   if(res.result.passChange == "Y"){
                   			top.location.href = ROOT + "/tran/main.do?passChange=Y";
                   		} else {
                   			top.location.href = ROOT + "/tran/main.do";
                   		}
            		   }else{
            			   alert(res.result.msg);
            			   return;
            		   }
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
</body>
</html>