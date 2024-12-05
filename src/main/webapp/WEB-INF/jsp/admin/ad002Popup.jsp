<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%
  request.setAttribute("callBack", request.getParameter("callBack"));
  request.setAttribute("itemIndex", request.getParameter("itemIndex"));
  request.setAttribute("seq", request.getParameter("seq"));

  if (request.getParameter("seq")==null){
    request.setAttribute("pageTitle", "FAQ 등록");
    request.setAttribute("pageopen", "");
    request.setAttribute("pageopen2", "display:none");       
  }
  else{
    request.setAttribute("pageTitle", "FAQ 수정");
    request.setAttribute("pageopen", "display:none");
    request.setAttribute("pageopen2", "");
  }
%>
<html>
<head>

<title>${pageTitle}</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=9">
	<meta http-equiv="X-UA-Compatible" content="IE=8">
<link rel="stylesheet" type="text/css" href="<c:url value='/admin/css/layout.css' />"/> 
 <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/axicon/axicon.min.css' />" />    
 <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/cocker/AXJ.css' />" id="axu-theme-axisj" />
 <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/cocker/AXInput.css' />" />
 <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/cocker/AXSelect.css' />" />
 <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/cocker/AXSearch.css' />" />
 <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/cocker/AXGrid.css' />" />
  <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/cocker/AXButton.css' />" />
  <link rel="stylesheet" type="text/css"  href="<c:url value='/css/hw/ma.css' />" />
<link rel="stylesheet" type="text/css"  href="<c:url value='/css/hw/common.css' />" />
  <script type="text/javascript" src="<c:url value='/axisj/jquery/jquery.min.js' />"></script>
  <script type="text/javascript" src="<c:url value='/axisj/dist/AXJ.min.js' />"></script>
  <script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/ax5-polyfill.js' />"></script>
  <script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/axjApp.js' />"></script>

</head>
<body>
  	
<article>
<div class="wrap">

<div class="ma_content"><!--컨텐츠 내용들어가는곳 시작-->
	
<div>
<h4 class="hw_h3_ma_01" >${pageTitle}</h4> 

</div>

<form name="send-form" onsubmit="return false;">
<div class="hw_clear"></div>
<input type=hidden name="seq" value="${seq}"/>

<h4 class="ma_title">제목</h4> <p class="hw_green">제목을 입력하세요 </p>
<div class="hw_clear"></div>	
<div class="hw_infouse_01" id="pagesearch" ><input type="text" name="title" id="title" class="AXInput W200" value="${title}" />
</div>
<div class="hw_clear"></div>

<div class="hw_clear"></div>	
<h4 class="ma_title">내용</h4> <p class="hw_green">내용을 적어주세요</p>
<div class="hw_clear"></div>	
 <textarea name="content" id="content" class="AXTextarea" style="box-shadow:inset 0px 0px 3px #ccc;width:100%;height:60px; margin-top:10px; ime-mode:active;box-sizing: border-box;" title="내용">${content}</textarea>
<div class="hw_clear"></div>	
     
<div><input style="${pageopen}"id="add" name="add" class="ma_add_01"  type="button" value="등록하기" onclick="fnObj.form.submit();" /></div>
<div><input style="${pageopen2}" id="modify" name="modify" class="ma_add_01"  type="button" value="수정하기" onclick="fnObj.form.submit2();" /></div>  
  

<!-- <button class="AXButton" type="button" onclick="fnObj.form.submit();">저장하기</button> -->

</form>
</div>
</div><!--wrap 끝-->
</article>
</body>
</html>