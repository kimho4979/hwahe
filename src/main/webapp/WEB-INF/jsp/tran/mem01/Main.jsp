<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	  <title>화훼유통정보시스템 전송시스템::: </title>
	  <!-- @@@@@@@@@@@@@@@@@@@@@@ css begin @@@@@@@@@@@@@@@@@@@@@@ -->
	    <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/axicon/axicon.min.css' />" />
	     <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/cocker/cmn/admin.css' />" />
	    <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/cocker/AXJ.min.css' />" id="axu-theme-axisj" />
	   
	   <link rel="stylesheet" type="text/css" href="<c:url value='/css_trans/css/main.css' />" />
	   <link rel="stylesheet" type="text/css" href="<c:url value='/css_trans/css/common.css' />" />
	<!-- @@@@@@@@@@@@@@@@@@@@@@ css end @@@@@@@@@@@@@@@@@@@@@@ -->
	      
	<!-- @@@@@@@@@@@@@@@@@@@@@@ javascript START @@@@@@@@@@@@@@@@@@@@@@ --> 
	 <script type="text/javascript" src="<c:url value='/axisj/jquery/jquery.min.js' />"></script>
	  <script type="text/javascript" src="<c:url value='/axisj/dist/AXJ.min.js' />"></script>
	  <script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/ax5-polyfill.js' />"></script>
	  <script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/axjApp.js' />"></script>
	  
	       
	       
	 <!-- @@@@@@@@@@@@@@@@@@@@@@ javascript END @@@@@@@@@@@@@@@@@@@@@@ --> 
	  
	</head>
	<body>
<header><!--헤더 시작-->
</header>


<article> 
<div class="wrap">

<div class="logo"><img src="<c:url value='/images/logo.png'/>"/></div>

<div class="list">
<ul>
<li class="title">정산자료 전송관리</li>
<li><a href="/calculate/calculateForm.do"><i class="axi axi-upload"></i>&nbsp;&nbsp;정산자료 전송관리</a></li>
<li><a href="/calculate/calculateListForm.do"><i class="axi axi-list"></i>&nbsp;&nbsp;전송현황</a></li>
<li><a href="/calculate/calculateDetailListForm.do"><i class="axi axi-list"></i>&nbsp;&nbsp;정산자료 세부내역</a></li>
</ul>

<ul>
<li class="title">표준코드 조회기능</li>
<li><a href="/code/GoodCodeForm.do"><i class="axi axi-list"></i>&nbsp;&nbsp;품목(종) 코드 조회</a></li>
<li><a href="/code/LocalCodeListForm.do"><i class="axi axi-list"></i>&nbsp;&nbsp;산지코드조회</a></li>
<li><a href="/code/CodelistForm.do"><i class="axi axi-list"></i>&nbsp;&nbsp;단위등급 규격코드 조회</a></li>
<!-- <li><a href="">신규코드 업데이트 현황</a></li> -->
</ul>

<!-- <ul>
<li class="title">실시간 전송관리</li>
<li><a href="">실시간 전송현황관리</a></li>
<li><a href="">실시간 전송현황관리(재전송관리)</a></li>

</ul> -->
</div>


</div>
</article>

<footer>
<div id="footer">
<div class="footer_box">
<div class="logo_g"><a href=""><img src="<c:url value='/images/logo_g.jpg' />" alt="aT화훼유통정보시스템 로고"/></a></div>
<div class="adress">
<p>[58217] 서울특별시 서초구 강남대로 27 화훼공판장    전화 : 02-579-8100    I   팩스 : 02-578-8671<p>
<p>&nbsp;COPYRIGHT @2016 by Korea Agro-Fisheries & Food Trade Corporation ALL RIGHTS RESERVED.</p>
</div>
</div>

</footer>

</body>
</html>