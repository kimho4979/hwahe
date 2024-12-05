<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="com.at.domain.SituationVO" %>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, user-scalable=no">
	<meta name="apple-mobile
	-web-app-title" content="화훼유통정보시스템">
	<meta name="robots" content="no-index,follow">
	<meta name="og:title" content="화훼유통정보시스템">
	<meta property="og:type" content="website">
	<meta name="og:description" content="화훼유통정보시스템">
	<meta name="content" content="화훼유통정보시스템 입니다.">
	<meta name="keywords" content="화훼경매시세, 화훼경매가격, Korea aT flower market auction price, 화훼공판장, 화훼거래정보, 꽃시장, 꽃값">
	<meta name="Author" content="화훼유통정보시스템 & www.woorim.co.kr : Kim Juyeon">
	<title>화훼유통정보시스템</title>
	<link type="text/css" rel="stylesheet" href="/css/common.css">
	<link type="text/css" rel="stylesheet" href="/css/sub.css">
	<link type="text/css" rel="stylesheet" href="/css/media.css" media="(max-width:1155px)">
	<script type="text/javascript" src="/js/jquery-1.11.2.min.js"></script>
	<script type="text/javascript" src="/js/display.js"></script>
	
	<link rel="stylesheet" type="text/css" href="<c:url value='/rMateChart/rMateChartH5/Assets/Css/rMateChartH5.css' />"/>   
	
	<script type="text/javascript" src="<c:url value='/js/sub_nav.js' />"></script>
	
	<!-- rMateChartH5 라이센스 시작 -->
	<script type="text/javascript" src="<c:url value='/rMateChart/LicenseKey/rMateChartH5License.js' />"></script>
	<!-- rMateChartH5 라이센스 끝-->  
	<!-- 실제적인 rMateChartH5 라이브러리 시작-->
	<script type="text/javascript" src="<c:url value='/rMateChart/rMateChartH5/JS/rMateBrokenChartH5.js' />"></script>
	<!-- 실제적인 rMateChartH5 라이브러리 끝-->
	<!-- rMateChartH5 테마 js -->
	<script type="text/javascript" src="<c:url value='/rMateChart/rMateChartH5/Assets/Theme/theme.js' />"></script>
	
	
<script type="text/javascript">

$(document).ready(function(){
	var url = document.location.href;
	if(url.indexOf("moveNone") == -1){
		setTimeout(function(){goUrl2();}, 60000);
	}
	
	$("#dateTxt").text('${dateTxt}');
	
});

	function goUrl(){
		var url = "/situation/situation.do";    
		$(location).attr('href',url);
	}
	function goUrl2(){
		var url = "/situation/situation02.do";    
		$(location).attr('href',url);
	}
	function goUrl3(){
		var url = "/situation/situation03.do";    
		$(location).attr('href',url);
	}
	//-----------------------차트 설정 시작-----------------------

	//rMate 차트 생성 준비가 완료된 상태 시 호출할 함수를 지정합니다.
	var chartVars = "rMateOnLoadCallFunction=chartReadyHandler";

	//rMateChart 를 생성합니다.
	//파라메터 (순서대로) 
	//1. 차트의 id ( 임의로 지정하십시오. ) 
	//2. 차트가 위치할 div 의 id (즉, 차트의 부모 div 의 id 입니다.)
	//3. 차트 생성 시 필요한 환경 변수들의 묶음인 chartVars
	//4. 차트의 가로 사이즈 (생략 가능, 생략 시 100%)
	//5. 차트의 세로 사이즈 (생략 가능, 생략 시 100%)
	rMateChartH5.create("chart1", "chartHolder", chartVars, "100%", "100%");

	//차트의 속성인 rMateOnLoadCallFunction 으로 설정된 함수.
	//rMate 차트 준비가 완료된 경우 이 함수가 호출됩니다.
	//이 함수를 통해 차트에 레이아웃과 데이터를 삽입합니다.
	//파라메터 : id - rMateChartH5.create() 사용 시 사용자가 지정한 id 입니다.
	function chartReadyHandler(id) {
		var val = ${list};
		if(typeof val !== "undefined" && val.length > 0){
			document.getElementById(id).setLayout(layoutStr);
			document.getElementById(id).setData(val);
			checkData(val);
		}else{
			chartData = [];
		}
	} 	

	var layoutStr = 
            '<rMateChart backgroundColor="#505050"  borderStyle="none">'
              +'<Options>'
                  +'<Legend defaultMouseOverAction="false" />'
             +'</Options>'
             +'<NumberFormatter id="numfmt" useThousandsSeparator="true"/>'
               +'<Column2DChart showDataTips="true" selectionMode="multiple" columnWidthRatio="0.48">'
                   +'<horizontalAxis>'
                       +'<CategoryAxis id="hAxis" categoryField="month" labelJsFunction="axisLabelFunc" />'
                    +'</horizontalAxis>'
                  /* +'<verticalAxis>'
                     +'<LinearAxis id="vAxis" labelJsFunction="axisLabelYFunc"/>'
                  +'</verticalAxis>' */
                  +'<verticalAxis>'
                  /* BrokenAxis를 설정 하시려면 해당 축이 설정될 곳에 BrokenAxis를 설정하십시오. */
                   +'<BrokenAxis id="vAxis" brokenMinimum="15000" brokenMaximum="100000" minimum="0" interval="5000" brokenRatio="0.8"  labelJsFunction="axisLabelYFunc"/>'
                   /* brokenMinimum - Broken축이 시작될 값 입니다. */
                    /* brokenMaximum - Broken축이 끝날 값 입니다. */
                     /* brokenRatio - Broken축이 그려질 위치 값입니다. 0 ~ 1이 유효값이며 0에 가까울수록 축의 최소값에 가까워지며 */
                    /* 1에 가까워질수록 축의 최대값에 가까워집니다. */
              +'</verticalAxis>'
                 +'<verticalAxisRenderers>'
                     +'<BrokenAxis2DRenderer axis="{vAxis}"/>'
                  /* BrokenAxis를 사용할 경우에 BrokenAxis3DRenderer를 설정 합니다. */
                  /* 이 외의 렌더러를 설정할 경우 올바르게 표현이 되지 않습니다. */
                 +'</verticalAxisRenderers>'
	                  +'<series>'
						+'<Column2DSeries  yField="plan_sum" displayName="금년목표"   formatter="{numfmt}" >'
							+'<showDataEffect>'
								+'<SeriesInterpolate/>'
							+'</showDataEffect>'
							+'<fill>'
								+'<SolidColor color="#f9bb17"/>'
							+'</fill>'
						+'</Column2DSeries>'
						+'<Column2DSeries  yField="pan_sum" displayName="금년실적"   formatter="{numfmt}" >'
							+'<showDataEffect>'
								+'<SeriesInterpolate/>'
							+'</showDataEffect>'
							+'<fill>'
								+'<SolidColor color="#42b1e5"/>'
							+'</fill>'
						+'</Column2DSeries>'
						+'<Column2DSeries  yField="before_year_avg" displayName="전년실적"  formatter="{numfmt}" >'
							+'<showDataEffect>'
								+'<SeriesInterpolate/>'
							+'</showDataEffect>'
							+'<fill>'
								+'<SolidColor color="#e54242" />'
							+'</fill>'
						+'</Column2DSeries>'
						+'<Column2DSeries  yField="five_year_avg" displayName="5개년평균"  formatter="{numfmt}" >'
						+'<showDataEffect>'
							+'<SeriesInterpolate/>'
						+'</showDataEffect>'
						+'<fill>'
							+'<SolidColor color="#4ae542"/>'
						+'</fill>'
					+'</Column2DSeries>'
					+'</series>'
              +'</Column2DChart>'
           +'</rMateChart>';

	function axisLabelFunc(id, value){
	    return "<font color='#aaaaaa'>"+value+"</font>";
	}
	
	function axisLabelYFunc(id, value){
	    return "<font color='#aaaaaa'>"+value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")+"</font>";
	}
           
	//차트 데이터
	var chartData = [];
	
	/**
	* rMateChartH5 3.0이후 버전에서 제공하고 있는 테마기능을 사용하시려면 아래 내용을 설정하여 주십시오.
	* 테마 기능을 사용하지 않으시려면 아래 내용은 삭제 혹은 주석처리 하셔도 됩니다.
	*
	* -- rMateChartH5.themes에 등록되어있는 테마 목록 --
	* - simple
	* - cyber
	* - modern
	* - lovely
	* - pastel
	* -------------------------------------------------
	*
	* rMateChartH5.themes 변수는 theme.js에서 정의하고 있습니다.
	*/
	//rMateChartH5.registerTheme(rMateChartH5.themes);

	/**
	* 샘플 내의 테마 버튼 클릭 시 호출되는 함수입니다.
	* 접근하는 차트 객체의 테마를 변경합니다.
	* 파라메터로 넘어오는 값
	* - simple
	* - cyber
	* - modern
	* - lovely
	* - pastel
	* - default
	*
	* default : 테마를 적용하기 전 기본 형태를 출력합니다.
	*/
	function rMateChartH5ChangeTheme(theme){
		document.getElementById("chart1").setTheme(theme);
	}
	
	function checkData(data){
		if(data.length <= 0){
			// 데이터가 없을 경우 hasNoData함수를 실행하여 메세지창을 출력한다.
			document.getElementById("chart1").hasNoData(true);
			// hasNoData(false); - 데이터가 존재하지 않으므로 차트의 기본 구조도 보이지 않아야 한다면 false로 주어 차트 전체의 visible을 false로 설정합니다.
			// hasNoData(true);  - 데이터가 존재하지 않아도 차트의 기본 구조는 보여야 한다면 true로 주어 visible을 true로 설정합니다.
		}
	}
	
	//-----------------------차트 설정 끝 -----------------------

</script>

</head>
<body>
	<ul class="skip_nav">
		<li><a href="#header">상단바로가기</a></li>
		<li><a href="#content">본문바로가기</a></li>
	</ul><!-- skip end -->
	<div id="wrap2">
		<div id="header">
			<h1 class="blind">화훼유통정보시스템 상황실</h1>
			<ul style="float:left;" class="tabNav">
				<li style="font-size: 1.5vw;font-weight:bold;width: auto;padding-right: 10px;line-height: 33px;color: #fff;">화훼공판장</li>
			</ul>
			<ul class="tabNav">
				<li id="dateTxt"></li>
				<li class="li01 on"><a href="#" onclick="goUrl()">01</a></li>
				<li class="li02"><a href="#" onclick="goUrl2()">02</a></li>
				<li class="li03"><a href="#" onclick="goUrl3()">03</a></li>
			</ul><!-- tabNav end -->
		</div><!-- header end -->
		<article>
			<div class="contentWrap on" id="st_content01">
				<section class="situation sec100"  id="content">
					<h2 class="tit">경매 목표 대 실적</h2>
					<div class="graphWrap2">
						<!-- <img src="../images/sample/img_st_grid01.png" alt="그래프" /> -->
						<div id="chartHolder" style="width:100%; height:100%;"></div>
					</div><!-- graphWrap2 end-->
					<div class="gridWrap2">
						<p class="txt">(단위: 백만원)</p>
						<table class="situationList list1">
							<caption>부류별 경매실적 누계 상세리스트입니다.</caption>
							<thead>
								<tr>
									<th colspan="1" width="8%">&nbsp;</th>
									<c:forEach begin="0" end="11" varStatus="num">
										<th width="7%">${resultList[num.index].month } 월</th>
									</c:forEach>
									<th width="8%">누계</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<th>금년목표</th>
									<c:set var = "sum" value = "0" />
									<c:forEach begin="0" end="11" varStatus="num">
										<td><fmt:formatNumber value="${resultList[num.index].plan_sum }" type="number"/></td>
										<c:set var= "sum" value="${sum + resultList[num.index].plan_sum}"/>
									</c:forEach>
									<td><fmt:formatNumber value="${sum}" type="number"/></td>
								</tr>
								<tr>
									<th>금년실적</th>
									<c:set var = "sum" value = "0" />
									<c:forEach begin="0" end="11" varStatus="num">
										<td><fmt:formatNumber value="${resultList[num.index].pan_sum }" type="number"/></td>
										<c:set var= "sum" value="${sum + resultList[num.index].pan_sum}"/>
									</c:forEach>
									<td><fmt:formatNumber value="${sum}" type="number"/></td>
								</tr>								
								<tr>
									<th>전년실적</th>
									<c:set var = "sum" value = "0" />
									<c:forEach begin="0" end="11" varStatus="num">
										<td><fmt:formatNumber value="${resultList[num.index].before_year_avg }" type="number"/></td>
										<c:set var= "sum" value="${sum + resultList[num.index].before_year_avg}"/>
									</c:forEach>
									<td><fmt:formatNumber value="${sum}" type="number"/></td>
								</tr>
								<tr>
									<th>5개년평균</th>
									<c:set var = "sum" value = "0" />
									<c:forEach begin="0" end="11" varStatus="num">
										<td><fmt:formatNumber value="${resultList[num.index].five_year_avg }" type="number"/></td>
										<c:set var= "sum" value="${sum + resultList[num.index].five_year_avg}"/>
									</c:forEach>
									<td><fmt:formatNumber value="${sum}" type="number"/></td>
								</tr>
							</tbody>
						</table><!-- situationList list1 end-->
					</div><!-- gridWrap2 end -->
				</section><!-- situation100 end-->
			</div><!-- contentWrap #st_content01 end -->			
		</article>
	</div><!-- wrap end -->
</body>
</html>