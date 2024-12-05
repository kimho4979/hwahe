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
     	alert("<%= msg %>");
<%
	}
%>
    var f=document.ceform;
    if(JSP.passChange == 'Y'){
        f.action = "<c:url value='/tran/main.do?' />"  + 'passChange=<%=passChange%>' ;
    } 
    else {
    	if(code == "SUCCESS"){
    		if(uri!=null && uri!=''){	
    			f.action = "<c:url value='"+uri+"' />";
    	 	}else{
    	 		 f.action = "<c:url value='/tran/main.do' />";
    	 	}
    	}else{
    		f.action = "<c:url value='/tran/mem01/mem01Form.do' />";
    	}
    }
    f.target = "_top";
    f.submit();
</script>
  
