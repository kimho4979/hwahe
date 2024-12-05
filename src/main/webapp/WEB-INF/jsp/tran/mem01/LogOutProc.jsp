<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j"%>
<%@page import="org.apache.commons.lang.StringUtils" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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

System.out.println(">>>>>>>>>>>>>>>msg:" + msg );

 
%>
<form name="ceform" id="ceform"  method="post"></form>
<script >
   
<%
		
	if ( !"".equals(msg)){
%>
     	alert("<%= msg %>");
<%
	}
%>
    var f=document.ceform;
    
    f.action = "<c:url value='/' />";
    
      f.submit();
</script>