<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, user-scalable=no">
	<meta name="apple-mobile-web-app-title" content="화훼유통정보시스템">
	<meta name="robots" content="no-index,follow">
	<meta name="og:title" content="화훼유통정보시스템">
	<meta name="og:description" content="화훼유통정보시스템">
	<meta name="description" content="데이터 개방 정보">
	<meta name="content" content="화훼유통정보시스템 입니다.">
	<meta name="keywords" content="화훼경매시세, 화훼경매가격, Korea aT flower market auction price, 화훼공판장, 화훼거래정보, 꽃시장, 꽃값">
	<meta name="Author" content="화훼유통정보시스템 & www.woorim.co.kr">
	<title>데이터 개방 정보</title>
	<%@include file="../common/2020/commonJs.jsp" %>
	<%@include file="../common/2020/commonCss.jsp" %>
	
	<script type="text/javascript">
	
		$(function(){	
			$("#getUrl").empty();
			var serviceKey = "${param.serviceKey}";
			var reqDataCd="${param.kind}";
			
			var dt_v= new Date();
			var yyyy= dt_v.getFullYear();
			var m=dt_v.getMonth()+1;
			var d=dt_v.getDate();
		
			if(m =="0")
			{
				m="12"; yyyy=yyyy-1;
			}
			if(m<10)
			{
				m='0'+m;
			}
			if(d<10)
			{
				d='0'+d;
			}
			begindate=yyyy+'-'+m+'-'+d;
			
			if(reqDataCd == 'f001'){
				$("#getUrl").text('https://flower.at.or.kr/api/returnData.api?kind=f001&serviceKey='+serviceKey+'&baseDate='+begindate+'&flowerGubn=1&dataType=json&countPerPage=10');
			
			}else if(reqDataCd == 'f002'){
				$("#getUrl").text('https://flower.at.or.kr/api/returnData.api?kind=f001&serviceKey='+serviceKey+'&baseDate='+begindate+'&flowerGubn=1&dataType=json&countPerPage=10');
			}
			
		});
		
		function getOpenApi(dataType){
			
			var dt_v= new Date();
			var yyyy= dt_v.getFullYear();
			var m=dt_v.getMonth()+1;
			var d=dt_v.getDate();
		
			if(m =="0")
			{
				m="12"; yyyy=yyyy-1;
			}
			if(m<10)
			{
				m='0'+m;
			}
			if(d<10)
			{
				d='0'+d;
			}
			begindate=yyyy+'-'+m+'-'+d;
		
			var serviceKey = "${param.serviceKey}";
			var baseDate = begindate;
			var kind = "${param.kind}";
			var countPerPage = "${param.countPerPage}";
			var flowerGubn = "${param.flowerGubn}";
			var pumName = "${param.pumName}";
			var goodName = "${param.goodName}";
			var param = "${pParam}";
			
			window.open('/api/returnData.api?kind='+kind+'&serviceKey='+serviceKey+'&baseDate='+baseDate+'&countPerPage=10&flowerGubn='+flowerGubn+'&dataType='+dataType, '_blank');
		}
		
		function exsisPage(){
			location.href = "/api/apiOpenApplyExsist.do";
		}
	</script>
</head>
<body>
	<!--WRAP(S)-->
	<div class="wrap">
		
		<jsp:include page="../inc/2020/IncHeader.jsp"/>
		
		<div class="lnb_box">
			<ul>
				<li><img src="../images/2020/m_lnb_img.png" alt="집"></li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li>공공데이터</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li>공공데이터</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li class="m_right">데이터 개방 정보</li>
			</ul>
		</div>
		<!--공통 HEADER(E)-->
		
		<!--서브 타이틀(S)-->
		<div class="sub_sns">
		</div>
		
		<div class="sub_title">
			<div class="title_box">
				<h2>공공데이터 개방 정보 샘플</h2>
				<img src="../images/2020/sub/t_line.png" alt="방울점선">
			</div>
		</div>
		<!--서브 타이틀(E)-->
		<!--서브공통 (S)-->
		<div class="sub_contents">
		
		</div>
		<!--컨텐츠 내용(S)-->
		<div class="sub_guide">
			<!--샘플URL-->
			<div class="opendata04_b">
				<h2 class="title_02"> 샘플URL</h2>
				<div class="url_b">
					<p id="getUrl"></p>
				</div>
			</div>
		</div>
		
		<div class="opendata01_b">			
			<div class="sevi_box03_b">
				<button type="button" onclick="getOpenApi('json')" >JSON</button>
				<button type="button" onclick="getOpenApi('xml')">XML</button>
				<button type="button" onclick="exsisPage();">목록</button>
			</div>
		</div>
			
		<!--컨텐츠 내용(E)-->
		
		<jsp:include page="../inc/2020/IncFooter.jsp"/>
		
	</div>
	<!--WRAP(E)-->
</body>
</html>