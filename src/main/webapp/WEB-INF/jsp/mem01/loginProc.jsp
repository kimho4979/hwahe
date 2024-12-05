<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%@page import="org.apache.commons.lang3.StringUtils" %>
<%

response.setHeader("Pragma","No-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0);
response.setHeader ("Cache-Control", "no-cache");
/*
 ******************************************************************************************
 * PROGRAM ID   :   
 * Description  :   
 * Input Parm   :
 * Output Parm  :
 * Include FILE :
 * Using Table  :
 * Return Value :
 * Sub Function :
 * SE Name        Description                                             Date
 * ------------   -----------------------------------------------------   -----------
 * nicos
 ****************************************************************************************
 */

/******************************************************************************************
 * INCLUDE
 ******************************************************************************************/


String msg = StringUtils.defaultString((String)request.getAttribute("msg"),"");
String uri = StringUtils.defaultString((String)request.getAttribute("uri"),"");
String code = StringUtils.defaultString((String)request.getAttribute("code"),"");
String passChange = StringUtils.defaultString((String)request.getAttribute("passChange"),"");
String sessionMonitor = StringUtils.defaultString((String)session.getAttribute("SESSION_MONITOR_TYPE"),"");

System.out.println(">>>>>>>>>>>>>>>msg:" + msg );
System.out.println(">>>>>>>>>>>>>>>uri:" + uri );
System.out.println(">>>>>>>>>>>>>>>code:" + code );
%>
<form name="ceform" id="ceform"  method="post"></form>
<script >
    var JSP = {        
        passChange : "<%=passChange%>"
    };
    var code ="<%=code%>"
    var uri = "<%=uri%>"
<%
		
	if ( !"".equals(msg)){
%>
		if(code=='LIMIT_LOGIN'){
			alert('비밀번호 오류횟수 초과로 10분간 로그인이 제한됩니다.');	
		}else{
			alert('계정 정보가 일치하지 않습니다.');	
		}
<%
	}
%>
    var f=document.ceform;
    if(JSP.passChange == 'Y'){
        f.action = "<c:url value='/maa01/maa01.do?' />"  + 'passChange=<%=passChange%>' ;
    } 
    else {
    	if(code == "SUCCESS"){
    		if(uri!=null && uri!=''){	
    			f.action = "<c:url value='"+uri+"' />";
    	 	}else{
    	 		var mobileKeyWords = new Array('iphone', 'ipod', 'blackberry', 'android',  'sonyericsson', 'mobile');
    	        var userAgent = navigator.userAgent.toLowerCase();
    	        for (var word in mobileKeyWords){
    	           
    	        	if (userAgent.match(mobileKeyWords[word]) != null){
    	        		if('<%= sessionMonitor %>'=='C'){
    	        			f.action = "<c:url value='/mba11/mba11.do' />";
    	        		}else{
    	        			f.action = "<c:url value='/maa11/maa11.do' />";		
    	        		}
    	            }else{
    	            	if('<%= sessionMonitor %>'=='C'){
    	        			f.action = "<c:url value='/mba01/mba01.do' />";
    	        		}else{
    	        			f.action = "<c:url value='/maa01/maa01.do' />";
    	        		}
    	           	 
    	            }
    	        }
    	 	}
    	}else{
    		f.action = "<c:url value='/mnt/mem01/mem01Form.do' />";
    	}
    }
    f.target = "_top";
    f.submit();
</script>
  
