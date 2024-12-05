<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, user-scalable=no">
<title>모니터요원 정산내역 상세 </title>
<!-- @@@@@@@@@@@@@@@@@@@@@@ css begin @@@@@@@@@@@@@@@@@@@@@@ -->
<link rel="stylesheet" type="text/css" href="<c:url value='/rMateChart/rMateChartH5/Assets/Css/rMateChartH5.css' />"/>   
<link rel="stylesheet" type="text/css" href="<c:url value='/axisj/axicon/axicon.min.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/arongi/AXJ.min.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/hw/ma.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/hw/common.css' />" />
<!-- @@@@@@@@@@@@@@@@@@@@@@ css end   @@@@@@@@@@@@@@@@@@@@@@ --> 

<script type="text/javascript" src="<c:url value='/axisj/jquery/jquery.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/axisj/dist/AXJ.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/axisj/lib/AXUpload5.js' />"></script>
<script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/ax5-polyfill.js' />"></script>
<script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/axjApp.js' />"></script>

<!-- rMateChartH5 라이센스 시작 -->
<script type="text/javascript" src="<c:url value='/rMateChart/LicenseKey/rMateChartH5License.js' />"></script>
<!-- rMateChartH5 라이센스 끝-->  
<!-- 실제적인 rMateChartH5 라이브러리 시작-->
 <script type="text/javascript" src="<c:url value='/rMateChart/rMateChartH5/JS/rMateChartH5.js' />"></script>
<!-- 실제적인 rMateChartH5 라이브러리 끝-->
<!-- rMateChartH5 테마 js -->
<script type="text/javascript" src="<c:url value='/rMateChart/rMateChartH5/Assets/Theme/theme.js' />"></script>
  
  
<script type="text/javascript">


</script>
</head>
<body>

<article>
<div>
	<div class="ma_content"><!--컨텐츠 내용들어가는곳 시작-->
		<div>
			<h4 class="hw_h3_ma_01" >발송이력관리 상세</h4> 
		</div>
		<div class="hw_infouse_01" style="margin-bottom: 30px;">
			<ul class="hw_list">
				<li>
					<span class="hw_item_search_title2">발송아이디</span>
					<span>${detail.SEQ }</span>
				</li>
				<li>
					<span class="hw_item_search_title2">수신자</span>
					<span>${detail.DEST }</span>
				</li>
				<li>
					<span class="hw_item_search_title2">제목</span>
					<span>${detail.SUBJECT }</span>
				</li>
				<li style="border-bottom: 1px solid;border-top: 1px solid;">
					<span>${detail.MSG_BODY }</span>
				</li>
				<li>
					<span class="hw_item_search_title2">발송시간</span>
					<span>${detail.SEND_TIME }</span>
				</li>
				<li>
					<span class="hw_item_search_title2">발송상태</span>
					<span>${detail.STATUS }</span>
				</li>
				<li>
					<span class="hw_item_search_title2">구분</span>
					<span>
						<c:if test="${detail.TYPE eq '1'}">메일</c:if>
						<c:if test="${detail.TYPE eq '2'}">카카오톡</c:if>
					</span>
				</li>
			</ul>
		</div>
	</div>
</div>
</article>

</body>
</html>
