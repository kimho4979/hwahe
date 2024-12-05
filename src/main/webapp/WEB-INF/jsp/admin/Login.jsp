<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%@page import="org.apache.commons.lang3.StringUtils" %>
<%
String msg= request.getParameter("msg");

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  	<title>화훼유통정보시스템 ::: </title>
  
  	<!-- @@@@@@@@@@@@@@@@@@@@@@ css begin @@@@@@@@@@@@@@@@@@@@@@ -->    
	<%-- <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/cocker/cmn/admin.css' />" /> --%>
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
	String l_reqUri = StringUtils.defaultString(request.getParameter("reqUri"),"");
%>
  
</head>
<body>

<div class="wrap_finding_id">
		<div class="hw_login_section">
			<div class="hw_at_ig" >
			<img src="/admin/images/n_logo.png" alt="모니터요원입력화면" style="width:300px; height:68px;" />
				<form name="login-form" method="Post" action="<c:url value='/login/adminLoginProc.do'/>" onsubmit="return fnObj.smsChk();">
				 <input type="hidden" name="reqUri" id="reqUri" value="<%=l_reqUri%>"/>	
					<div class="hw_all_left"><input type="text" name="loginId" id="loginId"  value="" class="login_id"  placeholder="ID"/>
					<input type="password" name="pwd" id="pwd" value="" class="login_pw"  placeholder="password" autocomplete="off"/>
					</div>					
					<div class="hw_all_right">
						<input type="submit"  id="login"  name="login" value="로그인" class="login_btn" />
					</div>
				</form>	
			<span class="login_title" style="text-align:left;">아이디또는 비밀번호 분실시 담당자에게 연락바랍니다.</span>
			<span class="login_title2" style="text-align:left;">로그인은 관리자만 가능합니다.</span>
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
	/* $("#loginId").on("keydown", function(e) {		
		var ch = e.keyCode ? e.keyCode : e.which;
		if (ch == 229)	return false;		
		return true;
	}); */

	// 실제 영문,숫자 입력체크는 keypress 에서
	/* $("#loginId").on("keypress", function(e) {
		var ch = e.keyCode ? e.keyCode : e.which;
		if (ch >= 48 && ch <= 57)	return true;    // 숫자 (0:48, ... 9:57)
		if (ch >= 65 && ch <= 90)	return true;    // 대문자 (A:65, ... Z:90)
		if (ch >= 97 && ch <= 122)	return true;    // 소문자 (A:97, ... Z:122)
		if (ch == 13) { fnLogin(); return true; }
		return false;
		
	}); */

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

$(function(){
	
	var msg='${vo.msg}';	
	if(msg!=null && msg.length>0){
		alert(msg);
	}
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
            */  
            if($("#pwd").val()!='flower#1'){
            	alert("비밀번호를 바르게 입력해주세요.");
            	$("#userPs").val('');
            	$("#userPs").focus();
            	return false;
            }
           
             var f = document.login-form;
             
             app.ajax({
                 type: "GET",
                 url: "/login/loginProc.json",
                 data: {loginId:f.usrId.value, pwd:f.pwd.value}
             }, function(res){
            	
            	   console.log(res);
            	   if(axf.isEmpty(res)|| res.result||res.result.code){
            		   alert("로그인에 실패하였습니다. <br>다시 시도해 주세요");
            		   return;
            		   
            	   }else{            		               		               		              		
            		 
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
                    			   alert(res.result.msg);
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
                    			   alert(res.result.msg);
                    			   return;
                    		   }
            	        	   
            	        	   //form.action="/maa01/maa01.do";
            	        	   //form.submit();
            	           }
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