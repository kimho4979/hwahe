<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<script type='text/javascript'>
 	alert('세션이 종료 되었습니다. 다시 로그인 하여 주시기 바랍니다.');
	try{
		opener.location.href="<c:url value='/tran/mem01/mem01Form.do'/>";
		self.close();
	}catch(e){
		location.href="<c:url value='/tran/mem01/mem01Form.do'/>";
	}
</script>