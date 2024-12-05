<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"	  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%
	response.setStatus( HttpServletResponse.SC_OK ); 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="apple-touch-icon" href="/images/content/favicon.png" />
<link rel="apple-touch-icon-precomposed" href="/images/content/favicon.png" />
<link rel="shortcut icon" href="/images/content/favicon.png" />
<link rel="shortcut icon" href="/images/content/favicon.png" type="image/x-icon" />
<title>Error Page</title>
</head>

<body>
	<div id="er">
		<h1>
			<code>Error</code>
		</h1>
		<div class="er_wrap">
			<h2>${errorTitle}</h2>
			<p class="warning">${errorDescription}</p>
			<p class="back"><a href="javascript:history.back();">뒤로가기</a></p>

			<c:if test="${pageContext.request.serverName eq 'localhost' || pageContext.request.serverName eq 'www.foodtest.or.kr'}">
				<p class="warning">
					<c:choose>
						<c:when test='${"500" eq httpStatus}'>
							500 OCCURED<br /><br />
							${pageContext.exception}<br /><br />ERROR-TRACE :
							<c:forEach var="trace" items="${pageContext.exception.stackTrace}">
								${trace}<BR>
							</c:forEach>
						</c:when>
						<c:otherwise>
							404 OCCURRED
						</c:otherwise>
					</c:choose>
				</p>
			</c:if>
		</div>
	</div>
	<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td width="100%" height="100%" align="center" valign="middle" style="padding-top: 150px;"><table border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="<spring:message code='image.errorBg' />">
							<span style="font-family: Tahoma; font-weight: bold; color: #000000; line-height: 150%; width: 440px; height: 70px;"></span>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</body>
</html>