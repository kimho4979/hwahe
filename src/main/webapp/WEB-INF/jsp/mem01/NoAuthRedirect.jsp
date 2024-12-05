<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%  
//  	response.sendRedirect("/login/loginForm.ce");
%>

<script type='text/javascript'>
 	alert('권한이 없는 화면입니다.\n(' + '${pRequestParamMap.noAuthUrl}' + ')');
// 	window.history.back()

</script>	