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
	<meta name="apple-mobile-web-app-title" content="화훼유통정보시스템">
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
	
	<!-- rMateChartH5 라이센스 시작 -->
	<script type="text/javascript" src="<c:url value='/rMateChart/LicenseKey/rMateChartH5License.js' />"></script>
	<!-- rMateChartH5 라이센스 끝-->  
	<!-- 실제적인 rMateChartH5 라이브러리 시작-->
	<script type="text/javascript" src="<c:url value='/rMateChart/rMateChartH5/JS/rMateChartH5.js' />"></script>
	<!-- 실제적인 rMateChartH5 라이브러리 끝-->
	<!-- rMateChartH5 테마 js -->
	<script type="text/javascript" src="<c:url value='/rMateChart/rMateChartH5/Assets/Theme/theme.js' />"></script>
	
	
<script type="text/javascript">

$(document).ready(function(){
	var url = document.location.href;
	if(url.indexOf("moveNone") == -1){
		setTimeout(function(){goUrl3();}, 60000);	
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
	var chartVars1 = "rMateOnLoadCallFunction=chartReadyHandler1";
	var chartVars2 = "rMateOnLoadCallFunction=chartReadyHandler2";
	var chartVars3 = "rMateOnLoadCallFunction=chartReadyHandler3";

	//rMateChart 를 생성합니다.
	//파라메터 (순서대로) 
	//1. 차트의 id ( 임의로 지정하십시오. ) 
	//2. 차트가 위치할 div 의 id (즉, 차트의 부모 div 의 id 입니다.)
	//3. 차트 생성 시 필요한 환경 변수들의 묶음인 chartVars
	//4. 차트의 가로 사이즈 (생략 가능, 생략 시 100%)
	//5. 차트의 세로 사이즈 (생략 가능, 생략 시 100%)
	rMateChartH5.create("chart1", "chartHolder1", chartVars1, "100%", "100%");
	rMateChartH5.create("chart2", "chartHolder2", chartVars2, "100%", "100%"); 
	rMateChartH5.create("chart3", "chartHolder3", chartVars3, "100%", "100%");
	
	//차트의 속성인 rMateOnLoadCallFunction 으로 설정된 함수.
	//rMate 차트 준비가 완료된 경우 이 함수가 호출됩니다.
	//이 함수를 통해 차트에 레이아웃과 데이터를 삽입합니다.
	//파라메터 : id - rMateChartH5.create() 사용 시 사용자가 지정한 id 입니다.
	
	function chartReadyHandler1(id) {
		var val = ${list1};
		if(typeof val !== "undefined" && val.length > 0){
			document.getElementById(id).setLayout(layoutStr1);
			document.getElementById(id).setData(val);
			checkData1(val);
		}else{
			chartData1 = [];
		}
	}
	function chartReadyHandler2(id) {
		var val = ${list2};
		if(typeof val !== "undefined" && val.length > 0){
			document.getElementById(id).setLayout(layoutStr2);
			document.getElementById(id).setData(val);
			checkData2(val);
		}else{
			chartData2 = [];
		}
	}
	function chartReadyHandler3(id) {
		var val = ${list3};
		if(typeof val !== "undefined" && val.length > 0){
			document.getElementById(id).setLayout(layoutStr3);
			document.getElementById(id).setData(val);
			checkData3(val);
		}else{
			chartData3 = [];
		}
	}
	
	var layoutStr1 = 
            '<rMateChart  backgroundColor="#505050"  borderStyle="none">'
         	 +'<Options>'                     
             +'<SubCaption text="금액(천원)" textAlign="left" />'
             +'<SubCaption text="물량(속)" textAlign="right" />'
             +'<Legend position="bottom" defaultMouseOverAction="false" useVisibleCheck="false" />'
         +'</Options>'
             +'<NumberFormatter id="numfmt" useThousandsSeparator="true"/>'
               +'<Combination2DChart showDataTips="true">'
               /* 
                 Combination2D 차트 생성시에 필요한 Combination2DChart 정의합니다 
                 showDataTips : 데이터에 마우스를 가져갔을 때 나오는 Tip을 보이기/안보이기 속성입니다  
               */
                  +'<horizontalAxis>'
                       +'<CategoryAxis categoryField="pan_day" padding="1" labelJsFunction="axisLabelFunc"/>'
                 +'</horizontalAxis>'
                  +'<verticalAxis>'
                     +'<LinearAxis id="vAxis2" formatter="{numfmt}" interval="10000"  labelJsFunction="axisLabelYFunc" minimum="0"/>'
                 +'</verticalAxis>'
                    +'<series>'
                       +'<Column2DSeries  labelJsFunction="axisLabelFunc" yField="tot_sok" displayName="물량"  columnWidthRatio="0.54">'
                            +'<fill>'
                             +'<SolidColor color="#41b2e6"/>'
                          +'</fill>'
                            +'<showDataEffect>'
                               +'<SeriesInterpolate/>'
                          +'</showDataEffect>'
                      +'</Column2DSeries>'
                      +'<Line2DSeries radius="6" yField="tot_price" displayName="금액" itemRenderer="CircleItemRenderer">'
                           +'<verticalAxis>'
                             +'<LinearAxis id="vAxis1" interval="50000" labelJsFunction="axisLabelYFunc" minimum="0"/>'
                          +'</verticalAxis>'
                            +'<showDataEffect>'
                               +'<SeriesInterpolate/>'
                          +'</showDataEffect>'
                          +'<lineStroke>'
                               +'<Stroke color="#f9bd03" weight="4"/>'
                           +'</lineStroke>'
                          +'<stroke>'
                               +'<Stroke color="#f9bd03" weight="3"/>'
                           +'</stroke>'
                      +'</Line2DSeries>'
                    +'</series>'
                  +'<verticalAxisRenderers>'
                        +'<Axis2DRenderer axis="{vAxis1}" showLine="false"/>'
                     +'<Axis2DRenderer axis="{vAxis2}" showLine="false"/>'
                 +'</verticalAxisRenderers>'
               +'</Combination2DChart>'
          +'</rMateChart>';
	
	
    var layoutStr2 = 
    	'<rMateChart  backgroundColor="#505050"  borderStyle="none">'
       	+'<Options>'                     
	       	+'<SubCaption text="금액(천원)" textAlign="left" />'
	        +'<SubCaption text="물량(분)" textAlign="right" />'
             +'<Legend position="bottom" defaultMouseOverAction="false" useVisibleCheck="false" />'
         +'</Options>'
         +'<NumberFormatter id="numfmt" useThousandsSeparator="true"/>'
           +'<Combination2DChart showDataTips="true">'
           /* 
             Combination2D 차트 생성시에 필요한 Combination2DChart 정의합니다 
             showDataTips : 데이터에 마우스를 가져갔을 때 나오는 Tip을 보이기/안보이기 속성입니다  
           */
              +'<horizontalAxis>'
                   +'<CategoryAxis categoryField="pan_day" padding="1" labelJsFunction="axisLabelFunc"/>'
             +'</horizontalAxis>'
              +'<verticalAxis>'
                 +'<LinearAxis id="vAxis2" formatter="{numfmt}" interval="10000"  labelJsFunction="axisLabelYFunc" minimum="0"/>'
             +'</verticalAxis>'
                +'<series>'
                   +'<Column2DSeries  labelJsFunction="axisLabelFunc" yField="tot_sok" displayName="물량"  columnWidthRatio="0.54">'
                        +'<fill>'
                         +'<SolidColor color="#41b2e6"/>'
                      +'</fill>'
                        +'<showDataEffect>'
                           +'<SeriesInterpolate/>'
                      +'</showDataEffect>'
                  +'</Column2DSeries>'
                  +'<Line2DSeries radius="6" yField="tot_price" displayName="금액" itemRenderer="CircleItemRenderer">'
                       +'<verticalAxis>'
                         +'<LinearAxis id="vAxis1" interval="50000" labelJsFunction="axisLabelYFunc" minimum="0"/>'
                      +'</verticalAxis>'
                        +'<showDataEffect>'
                           +'<SeriesInterpolate/>'
                      +'</showDataEffect>'
                      +'<lineStroke>'
                           +'<Stroke color="#f9bd03" weight="4"/>'
                       +'</lineStroke>'
                      +'<stroke>'
                           +'<Stroke color="#f9bd03" weight="3"/>'
                       +'</stroke>'
                  +'</Line2DSeries>'
                +'</series>'
              +'<verticalAxisRenderers>'
                    +'<Axis2DRenderer axis="{vAxis1}" showLine="false" minimum="0"/>'
                 +'<Axis2DRenderer axis="{vAxis2}" showLine="false" minimum="0"/>'
             +'</verticalAxisRenderers>'
           +'</Combination2DChart>'
      +'</rMateChart>';
       
       var layoutStr3 = 
    	   '<rMateChart  backgroundColor="#505050"  borderStyle="none">'
          	+'<Options>'                     
          	+'<SubCaption text="금액(천원)" textAlign="left" />'
            +'<SubCaption text="물량(분)" textAlign="right" />'
             +'<Legend position="bottom" defaultMouseOverAction="false" useVisibleCheck="false" />'
         +'</Options>'
            +'<NumberFormatter id="numfmt" useThousandsSeparator="true"/>'
              +'<Combination2DChart showDataTips="true">'
              /* 
                Combination2D 차트 생성시에 필요한 Combination2DChart 정의합니다 
                showDataTips : 데이터에 마우스를 가져갔을 때 나오는 Tip을 보이기/안보이기 속성입니다  
              */
                 +'<horizontalAxis>'
                      +'<CategoryAxis categoryField="pan_day" padding="1" labelJsFunction="axisLabelFunc"/>'
                +'</horizontalAxis>'
                 +'<verticalAxis>'
                    +'<LinearAxis id="vAxis2" formatter="{numfmt}" interval="10000"  labelJsFunction="axisLabelYFunc" minimum="0"/>'
                +'</verticalAxis>'
                   +'<series>'
                      +'<Column2DSeries  labelJsFunction="axisLabelFunc" yField="tot_sok" displayName="물량"  columnWidthRatio="0.54">'
                           +'<fill>'
                            +'<SolidColor color="#41b2e6"/>'
                         +'</fill>'
                           +'<showDataEffect>'
                              +'<SeriesInterpolate/>'
                         +'</showDataEffect>'
                     +'</Column2DSeries>'
                     +'<Line2DSeries radius="6" yField="tot_price" displayName="금액" itemRenderer="CircleItemRenderer">'
                          +'<verticalAxis>'
                            +'<LinearAxis id="vAxis1" interval="50000" labelJsFunction="axisLabelYFunc" minimum="0"/>'
                         +'</verticalAxis>'
                           +'<showDataEffect>'
                              +'<SeriesInterpolate/>'
                         +'</showDataEffect>'
                         +'<lineStroke>'
                              +'<Stroke color="#f9bd03" weight="4"/>'
                          +'</lineStroke>'
                         +'<stroke>'
                              +'<Stroke color="#f9bd03" weight="3"/>'
                          +'</stroke>'
                     +'</Line2DSeries>'
                   +'</series>'
                 +'<verticalAxisRenderers>'
                       +'<Axis2DRenderer axis="{vAxis1}" showLine="false"/>'
                    +'<Axis2DRenderer axis="{vAxis2}" showLine="false"/>'
                +'</verticalAxisRenderers>'
              +'</Combination2DChart>'
         +'</rMateChart>';
           
	function axisLabelFunc(id, value){
	    return "<font color='#aaaaaa'>"+value+"</font>";
	}
	
	function axisLabelYFunc(id, value){
	    return "<font color='#aaaaaa'>"+value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")+"</font>";
	}
           
	//차트 데이터
	var chartData1 = [];
	var chartData2 = [];
	var chartData3 = [];

	
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
	function rMateChartH5ChangeTheme1(theme){
		document.getElementById("chart1").setTheme(theme);
	}

	function checkData1(data){
		if(data.length <= 0){
			// 데이터가 없을 경우 hasNoData함수를 실행하여 메세지창을 출력한다.
			document.getElementById("chart1").hasNoData(true);
			// hasNoData(false); - 데이터가 존재하지 않으므로 차트의 기본 구조도 보이지 않아야 한다면 false로 주어 차트 전체의 visible을 false로 설정합니다.
			// hasNoData(true);  - 데이터가 존재하지 않아도 차트의 기본 구조는 보여야 한다면 true로 주어 visible을 true로 설정합니다.
		}
	}
	
	function rMateChartH5ChangeTheme2(theme){
		document.getElementById("chart2").setTheme(theme);
	}

	function checkData2(data){
		if(data.length <= 0){
			// 데이터가 없을 경우 hasNoData함수를 실행하여 메세지창을 출력한다.
			document.getElementById("chart2").hasNoData(true);
			// hasNoData(false); - 데이터가 존재하지 않으므로 차트의 기본 구조도 보이지 않아야 한다면 false로 주어 차트 전체의 visible을 false로 설정합니다.
			// hasNoData(true);  - 데이터가 존재하지 않아도 차트의 기본 구조는 보여야 한다면 true로 주어 visible을 true로 설정합니다.
		}
	}

	function rMateChartH5ChangeTheme3(theme){
		document.getElementById("chart3").setTheme(theme);
	}

	function checkData3(data){
		if(data.length <= 0){
			// 데이터가 없을 경우 hasNoData함수를 실행하여 메세지창을 출력한다.
			document.getElementById("chart3").hasNoData(true);
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
				<li class="li01"><a href="#" onclick="goUrl()">01</a></li>
				<li class="li02 on"><a href="#" onclick="goUrl2()">02</a></li>
				<li class="li03"><a href="#" onclick="goUrl3()">03</a></li>
			</ul><!-- tabNav end -->
		</div><!-- header end -->
		<article>
			<div class="contentWrap on" id="st_content02">
				<section class="situation sec1">
					<h2 class="tit">금일경매실적(절화)</h2>
					<div class="graphWrap2">
						<div id="chartHolder1" style="width:100%; height:100%;"></div>
					</div><!-- graphWrap2 end-->
					<div class="gridWrap2">
						<p class="txt">(단위: 천원, 속)</p>
						<table class="situationList list1">
							<colgroup>
								<col style="width:25%;">
								<col style="width:25%;">
								<col style="width:25%;">
								<col style="width:25%;">
							</colgroup>
							<caption>부류별 경매실적 누계 상세리스트입니다.</caption>
							<thead>
								<tr>
									<c:if test="${resultList1.bef_day ==null }">
										<th colspan="2">전년동기</th>
									</c:if>
									<c:if test="${resultList1.bef_day !=null}">
										<th colspan="2">전년동기<br/>${resultList1.bef_day }(${resultList1.bef_day_yoil })</th>
									</c:if>
									<c:if test="${resultList1.pan_day ==null }">
										<th colspan="2">금일<br/><br/></th>
									</c:if>
									<c:if test="${resultList1.pan_day !=null}">
										<th colspan="2">금일<br/>${resultList1.pan_day }(${resultList1.day_yoil })</th>
									</c:if>
								</tr>
								<tr class="tr2">
									<th>금액</th>
									<th>물량</th>
									<th>금액</th>
									<th>물량</th>
								</tr>
							</thead>
							<tbody>
								<%-- <c:forEach var="result1" items="${resultList1}" varStatus="status"> --%>  
								<tr>
									<c:if test="${resultList1.bef_day ==null }">
										<td colspan="2">경매 없음</td>
									</c:if>
									<c:if test="${resultList1.bef_day !=null}">
										<td><fmt:formatNumber value="${resultList1.bef_tot_price }" type="number"/></td>
										<td><fmt:formatNumber value="${resultList1.bef_tot_sok }" type="number"/></td>
									</c:if>
									<c:if test="${resultList1.pan_day ==null }">
										<td colspan="2">경매 없음</td>
									</c:if>
									<c:if test="${resultList1.pan_day !=null}">
									<td><fmt:formatNumber value="${resultList1.tot_price }" type="number"/></td>	
									<td><fmt:formatNumber value="${resultList1.tot_sok }" type="number"/></td>
									</c:if>
								</tr>
								<%-- </c:forEach> --%>
							</tbody>
						</table><!-- situationList list1 end-->
					</div><!-- gridWrap2 end -->
				</section><!-- situation sec1 end-->

				<section class="situation sec2">
					<h2 class="tit">금일경매실적(난/춘란)</h2>
					<div class="graphWrap2">
						<div id="chartHolder2" style="width:100%; height:100%;"></div>
					</div><!-- graphWrap2 end-->
					<div class="gridWrap2">
						<p class="txt">(단위: 천원, 분)</p>
						<table class="situationList list2">
							<colgroup>
								<col style="width:25%;">
								<col style="width:25%;">
								<col style="width:25%;">
								<col style="width:25%;">
							</colgroup>
							<caption>부류별 경매실적 누계 상세리스트입니다.</caption>
							<thead>
								<tr>
									<c:if test="${resultList2.bef_day ==null }">
										<th colspan="2">전년동기</th>
									</c:if>
									<c:if test="${resultList2.bef_day !=null}">
										<th colspan="2">전년동기<br/>${resultList2.bef_day }(${resultList2.bef_day_yoil })</th>
									</c:if>
									<c:if test="${resultList2.pan_day ==null }">
										<th colspan="2">금일<br/><br/></th>
									</c:if>
									<c:if test="${resultList2.pan_day !=null}">
										<th colspan="2">금일<br/>${resultList2.pan_day }(${resultList2.day_yoil })</th>
									</c:if>									
								</tr>
								<tr class="tr2">
									<th>금액</th>
									<th>물량</th>
									<th>금액</th>
									<th>물량</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<c:if test="${resultList2.bef_day ==null }">
										<td colspan="2">경매 없음</td>
									</c:if>
									<c:if test="${resultList2.bef_day !=null}">
									<td><fmt:formatNumber value="${resultList2.bef_tot_price }" type="number"/></td>
									<td><fmt:formatNumber value="${resultList2.bef_tot_sok }" type="number"/></td>
									</c:if>
									<c:if test="${resultList2.pan_day ==null }">
										<td colspan="2">경매 없음</td>
									</c:if>
									<c:if test="${resultList2.pan_day !=null}">
										<td><fmt:formatNumber value="${resultList2.tot_price }" type="number"/></td>	
									<td><fmt:formatNumber value="${resultList2.tot_sok }" type="number"/></td>
									</c:if>
								</tr>
							</tbody>
						</table><!-- situationList list2 end-->
					</div><!-- gridWrap2 end -->
				</section><!-- situation sec2 end-->

				<section class="situation sec3">
					<h2 class="tit">금일경매실적(관엽)</h2>
					<div class="graphWrap2">
						<div id="chartHolder3" style="width:100%; height:100%;"></div>
					</div><!-- graphWrap2 end-->
					<div class="gridWrap2">
						<p class="txt">(단위: 천원, 분)</p>
						<table class="situationList list3">
							<colgroup>
								<col style="width:25%;">
								<col style="width:25%;">
								<col style="width:25%;">
								<col style="width:25%;">
							</colgroup>
							<caption>부류별 경매실적 누계 상세리스트입니다.</caption>
							<thead>
								<tr>
									<c:if test="${resultList3.bef_day !=null}">
										<th colspan="2">전년동기<br/>${resultList3.bef_day }(${resultList3.bef_day_yoil })</th>
									</c:if>
									<c:if test="${resultList3.bef_day ==null }">
										<th colspan="2">전년동기</th>
									</c:if>
									<c:if test="${resultList3.pan_day !=null}">
										<th colspan="2">금일<br/>${resultList3.pan_day }(${resultList3.day_yoil })</th>
									</c:if>
									<c:if test="${resultList3.pan_day ==null }">
										<th colspan="2">금일<br/><br/></th>
									</c:if>
									
								</tr>
								<tr class="tr2">
									<th>금액</th>
									<th>물량</th>
									<th>금액</th>
									<th>물량</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<c:if test="${resultList3.bef_day ==null }">
										<td colspan="2">경매 없음</td>
									</c:if>
									<c:if test="${resultList3.bef_day !=null}">
									<td><fmt:formatNumber value="${resultList3.bef_tot_price }" type="number"/></td>
									<td><fmt:formatNumber value="${resultList3.bef_tot_sok }" type="number"/></td>
									</c:if>
									<c:if test="${resultList3.pan_day ==null }">
										<td colspan="2">경매 없음</td>
									</c:if>
									<c:if test="${resultList3.pan_day !=null}">
									<td><fmt:formatNumber value="${resultList3.tot_price }" type="number"/></td>	
									<td><fmt:formatNumber value="${resultList3.tot_sok }" type="number"/></td>
									</c:if>
								</tr>
							</tbody>
					</div><!-- gridWrap2 end -->
				</section><!-- situation sec3 end-->
			</div><!-- contentWrap #st_content02 end -->

		</article>
	</div><!-- wrap end -->
</body>
</html>