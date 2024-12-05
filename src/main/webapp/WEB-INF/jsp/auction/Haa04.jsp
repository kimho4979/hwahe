<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, user-scalable=no">
	<meta name="apple-mobile-web-app-title" content="화훼유통정보시스템">
	<meta name="robots" content="no-index,follow">
	<meta name="og:title" content="화훼유통정보시스템">
	<meta name="og:description" content="화훼유통정보시스템">
	<meta name="description" content="주요거래지표">
	<meta name="content" content="화훼유통정보시스템 입니다.">
	<meta name="keywords" content="화훼경매시세, 화훼경매가격, Korea aT flower market auction price, 화훼공판장, 화훼거래정보, 꽃시장, 꽃값">
	<meta name="Author" content="화훼유통정보시스템 & www.woorim.co.kr">
	<title>주요거래지표</title>	
	<%@include file="../common/2020/commonJs.jsp" %>	
	<%@include file="../common/2020/commonCss.jsp" %>
	
	<script type="text/javascript">
		var CMP_CD = "0000000001";
		var searchFlower='1,3,2,4';
		
		var chartYear = "";
		var chartAgoYear = "";
		//-----------------------차트 설정 시작-----------------------
		
		//rMate 차트 생성 준비가 완료된 상태 시 호출할 함수를 지정합니다.
		var chartVars = "rMateOnLoadCallFunction=chartReadyHandler";
		var chartVars2 = "rMateOnLoadCallFunction=chartReadyHandler2";
		var chartVars3 = "rMateOnLoadCallFunction=chartReadyHandler3";
		var chartVars4 = "rMateOnLoadCallFunction=chartReadyHandler4";
		var chartVars5 = "rMateOnLoadCallFunction=chartReadyHandler5";
		var chartVars6 = "rMateOnLoadCallFunction=chartReadyHandler6";
		var chartVars7 = "rMateOnLoadCallFunction=chartReadyHandler7";
		var chartVars8 = "rMateOnLoadCallFunction=chartReadyHandler8";
		var chartVars9 = "rMateOnLoadCallFunction=chartReadyHandler9";
		var chartVars10 = "rMateOnLoadCallFunction=chartReadyHandler10";
		
		rMateChartH5.create("chart1", "chartHolder", chartVars, "100%", "100%"); 
		rMateChartH5.create("chart2", "chartHolder2", chartVars2, "100%", "100%"); 
		rMateChartH5.create("chart3", "chartHolder3", chartVars3, "100%", "100%"); 
		rMateChartH5.create("chart4", "chartHolder4", chartVars4, "100%", "100%");
		rMateChartH5.create("chart5", "chartHolder5", chartVars5, "100%", "100%");
		rMateChartH5.create("chart6", "chartHolder6", chartVars6, "100%", "100%");
		rMateChartH5.create("chart7", "chartHolder7", chartVars7, "100%", "100%");
		rMateChartH5.create("chart8", "chartHolder8", chartVars8, "100%", "100%");
		rMateChartH5.create("chart9", "chartHolder9", chartVars9, "100%", "100%");
		rMateChartH5.create("chart10", "chartHolder10", chartVars10, "100%", "100%");
		
		function chartReadyHandler(id) {
			if(document.getElementById(id) != null){
				document.getElementById(id).setLayout(mainAmtLayout(chartAgoYear,chartYear));
				document.getElementById(id).setData(chartData);
			}
		}
		
		function chartReadyHandler2(id) {
			if(document.getElementById(id) != null){
				document.getElementById(id).setLayout(mainQtyLayout(chartAgoYear,chartYear));
				document.getElementById(id).setData(chartData2);
			}
		}
		
		function chartReadyHandler3(id) {
			if(document.getElementById(id) != null){
				document.getElementById(id).setLayout(cutAmtLayout(chartAgoYear,chartYear));
				document.getElementById(id).setData(chartData3);
			}
		}
		
		function chartReadyHandler4(id) {
			if(document.getElementById(id) != null){
				document.getElementById(id).setLayout(cutQtyLayout(chartAgoYear,chartYear));
				document.getElementById(id).setData(chartData4);
			}
		}
		
		function chartReadyHandler5(id) {
			if(document.getElementById(id) != null){
				document.getElementById(id).setLayout(nanAmtLayout(chartAgoYear,chartYear));
				document.getElementById(id).setData(chartData5);
			}
		}
		
		function chartReadyHandler6(id) {
			if(document.getElementById(id) != null){
				document.getElementById(id).setLayout(nanQtyLayout(chartAgoYear,chartYear));
				document.getElementById(id).setData(chartData6);
			}
		}
		
		function chartReadyHandler7(id) {
			if(document.getElementById(id) != null){
				document.getElementById(id).setLayout(gwanAmtLayout(chartAgoYear,chartYear));
				document.getElementById(id).setData(chartData7);
			}
		}
		
		function chartReadyHandler8(id) {
			if(document.getElementById(id) != null){
				document.getElementById(id).setLayout(gwanQtyLayout(chartAgoYear,chartYear));
				document.getElementById(id).setData(chartData8);
			}
		}
		
		function chartReadyHandler9(id) {
			if(document.getElementById(id) != null){
				document.getElementById(id).setLayout(chunAmtLayout(chartAgoYear,chartYear));
				document.getElementById(id).setData(chartData9);
			}
		}
		
		function chartReadyHandler10(id) {
			if(document.getElementById(id) != null){
				document.getElementById(id).setLayout(chunQtyLayout(chartAgoYear,chartYear));
				document.getElementById(id).setData(chartData10);
			}
		}
		//스트링 형식으로 레이아웃 정의.
		function mainAmtLayout(chartAgoYear,chartYear){
		var layoutStr = 
			'<rMateChart  backgroundColor="#ffffff" borderStyle="none">'
				+'<Options>'			
					+'<SubCaption text="단위 : 십만" textAlign="left" />'
					+'<Legend defaultMouseOverAction="false" useVisibleCheck="true"/>'
				+'</Options>'
				+'<NumberFormatter id="numFmt2" useThousandsSeparator="true"/>'
				+'<Line2DChart showDataTips="true" dataTipDisplayMode="axis" paddingTop="0">'
					+'<horizontalAxis>'
						+'<CategoryAxis categoryField="SALE_MONTH"/>'
					+'</horizontalAxis>'
					+'<verticalAxis>'
						+'<LinearAxis formatter="{numFmt2}"/>'
					+'</verticalAxis>'
					+'<series>'
						+'<Line2DSeries  labelPosition="up" showMinValueLabel="true" showMaxValueLabel="true"  yField="AGO_TOT_AMT" minimum="0" radius="3" displayName="'+chartAgoYear+'"  itemRenderer="CircleItemRenderer">'
						/* 아이템렌더러(데이터 마커) 테두리 색상 */
							+'<fill>'
			          		+'<SolidColor color="#0040FF" alpha="1"/>'
							+'</fill>'	
							+'<lineStroke>'
								+'<Stroke color="#0040FF" weight="2"/>'
							+'</lineStroke>'
			                +'<stroke>'
			                    +'<Stroke color="#0040FF" weight="2"/>'
			                +'</stroke>'
							+'<showDataEffect>'
								+'<SeriesInterpolate/>'
							+'</showDataEffect>'
						+'</Line2DSeries>'
						+'<Line2DSeries  labelPosition="up" showMinValueLabel="true" showMaxValueLabel="true" yField="TOT_AMT"  minimum="0"  radius="3" displayName="'+chartYear+'"  itemRenderer="CircleItemRenderer">'						
						+'<fill>'
		          		+'<SolidColor color="#FA5858" alpha="1"/>'
						+'</fill>'	
						+'<lineStroke>'
							+'<Stroke color="#FA5858" weight="2"/>'
						+'</lineStroke>'
		                +'<stroke>'
		                    +'<Stroke color="#FA5858" weight="2"/>'
		                +'</stroke>'
						+'<showDataEffect>'
							+'<SeriesInterpolate/>'
						+'</showDataEffect>'
						+'</Line2DSeries>'						
					+'</series>'
				+'</Line2DChart>'
			+'</rMateChart>';
			return layoutStr;
		}
		//차트 데이터
		var chartData = [];
		
		function mainQtyLayout(chartAgoYear,chartYear){
		var layoutStr2 = 
			'<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'
				+'<Options>'	
					+'<SubCaption text="단위 : 속" textAlign="left" />'
					+'<Legend defaultMouseOverAction="false" />'
				+'</Options>'
				+'<NumberFormatter id="numFmt2" useThousandsSeparator="true"/>'
				+'<Column2DChart showDataTips="true" columnWidthRatio="0.75" selectionMode="single">'
					+'<horizontalAxis>'
						+'<CategoryAxis categoryField="SALE_MONTH"/>'
					+'</horizontalAxis>'
					+'<verticalAxis>'
						+'<LinearAxis formatter="{numFmt2}"/>'
					+'</verticalAxis>'
					+'<series>'
						+'<Column2DSeries labelPosition="false" yField="AGO_TOT_QTY" displayName="'+chartAgoYear+'"  outsideLabelYOffset="-2">'
							
						+'<showDataEffect>'
								+'<SeriesInterpolate/>'
							+'</showDataEffect>'
						+'</Column2DSeries>'
						+'<Column2DSeries labelPosition="false" yField="TOT_QTY" displayName="'+chartYear+'"  outsideLabelYOffset="-2">'
						+'<fill>'
			            /* Series안에 색을 채울 때(단일색) fill에 주목 */
			                +'<SolidColor color="#2D415C" alpha="0.9"/>'
			                /* color:색깔 alpha:투명도 */
			            +'</fill>'			
							+'<showDataEffect>'
								+'<SeriesInterpolate/>'
							+'</showDataEffect>'
						+'</Column2DSeries>'			
					+'</series>'
				+'</Column2DChart>'
			+'</rMateChart>';
			return layoutStr2;
		}
		//차트 데이터
		var chartData2 = [];		
		
		function cutAmtLayout(chartAgoYear,chartYear){
		var layoutStr3 = 
			'<rMateChart  backgroundColor="#ffffff" borderStyle="none">'
			+'<Options>'			
				+'<SubCaption text="단위 : 십만" textAlign="left" />'
				+'<Legend defaultMouseOverAction="false" useVisibleCheck="true"/>'
			+'</Options>'
			+'<NumberFormatter id="numFmt" precision="0"/>'
			+'<NumberFormatter id="numFmt2" useThousandsSeparator="true"/>'
			+'<Line2DChart showDataTips="true" dataTipDisplayMode="axis" paddingTop="0">'
				+'<horizontalAxis>'
					+'<CategoryAxis categoryField="SALE_MONTH"/>'
				+'</horizontalAxis>'
				+'<verticalAxis>'
					+'<LinearAxis formatter="{numFmt2}"/>'
				+'</verticalAxis>'
				+'<series>'
					+'<Line2DSeries labelPosition="up" minimum="0" showMaxValueLabel="true" yField="AGO_TOT_AMT" radius="3" displayName="'+chartAgoYear+'"  itemRenderer="CircleItemRenderer">'
					/* 아이템렌더러(데이터 마커) 테두리 색상 */
						+'<fill>'
			          		+'<SolidColor color="#0040FF" alpha="1"/>'
							+'</fill>'	
							+'<lineStroke>'
								+'<Stroke color="#0040FF" weight="2"/>'
							+'</lineStroke>'
			                +'<stroke>'
			                    +'<Stroke color="#0040FF" weight="2"/>'
			                +'</stroke>'
						+'<showDataEffect>'
							+'<SeriesInterpolate/>'
						+'</showDataEffect>'
					+'</Line2DSeries>'
					+'<Line2DSeries labelPosition="up" showMinValueLabel="true" minimum="0" showMaxValueLabel="true" yField="TOT_AMT"  radius="3" displayName="'+chartYear+'"  itemRenderer="CircleItemRenderer">'						
					+'<fill>'
		      		+'<SolidColor color="#FA5858" alpha="1"/>'
					+'</fill>'	
					+'<lineStroke>'
						+'<Stroke color="#FA5858" weight="2"/>'
					+'</lineStroke>'
		            +'<stroke>'
		                +'<Stroke color="#FA5858" weight="2"/>'
		            +'</stroke>'							
						+'<showDataEffect>'
							+'<SeriesInterpolate/>'
						+'</showDataEffect>'
					+'</Line2DSeries>'						
				+'</series>'
			+'</Line2DChart>'
			+'</rMateChart>';
			return layoutStr3;
		}
		//차트 데이터
		var chartData3 = [];
		
		function cutQtyLayout(chartAgoYear,chartYear){
		var layoutStr4 = 
			'<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'
			+'<Options>'	
				+'<SubCaption text="단위 : 속" textAlign="left" />'
				+'<Legend defaultMouseOverAction="false" />'
			+'</Options>'
			+'<NumberFormatter id="numFmt2" useThousandsSeparator="true"/>'
			+'<Column2DChart showDataTips="true" columnWidthRatio="0.75" selectionMode="single">'
				+'<horizontalAxis>'
					+'<CategoryAxis categoryField="SALE_MONTH"/>'
				+'</horizontalAxis>'
				+'<verticalAxis>'
					+'<LinearAxis formatter="{numFmt2}"/>'
				+'</verticalAxis>'
				+'<series>'
					+'<Column2DSeries labelPosition="false" yField="AGO_TOT_QTY" displayName="'+chartAgoYear+'"  outsideLabelYOffset="-2">'
						+'<showDataEffect>'
							+'<SeriesInterpolate/>'
						+'</showDataEffect>'
					+'</Column2DSeries>'
					+'<Column2DSeries labelPosition="false" yField="TOT_QTY" displayName="'+chartYear+'"  outsideLabelYOffset="-2">'
					+'<fill>'
		            /* Series안에 색을 채울 때(단일색) fill에 주목 */
		                +'<SolidColor color="#E3493D" alpha="1"/>'
		                /* color:색깔 alpha:투명도 */
		            +'</fill>'			
						+'<showDataEffect>'
							+'<SeriesInterpolate/>'
						+'</showDataEffect>'
					+'</Column2DSeries>'			
				+'</series>'
			+'</Column2DChart>'
		+'</rMateChart>';
		return layoutStr4;
		}
		//차트 데이터
		var chartData4 = [];		
		
		function nanAmtLayout(chartAgoYear,chartYear){
		var layoutStr5 = 
			'<rMateChart  backgroundColor="#ffffff" borderStyle="none">'
			+'<Options>'			
				+'<SubCaption text="단위 : 십만" textAlign="left" />'
				+'<Legend defaultMouseOverAction="false" useVisibleCheck="true"/>'
			+'</Options>'
			+'<NumberFormatter id="numFmt2" useThousandsSeparator="true"/>'
			+'<NumberFormatter id="numFmt" precision="0"/>'
			+'<Line2DChart showDataTips="true" dataTipDisplayMode="axis" paddingTop="0">'
				+'<horizontalAxis>'
					+'<CategoryAxis categoryField="SALE_MONTH"/>'
				+'</horizontalAxis>'
				+'<verticalAxis>'
					+'<LinearAxis formatter="{numFmt2}"/>'
				+'</verticalAxis>'
				+'<series>'
					+'<Line2DSeries labelPosition="up" showMinValueLabel="true" minimum="0" showMaxValueLabel="true" yField="AGO_TOT_AMT" radius="3" displayName="'+chartAgoYear+'"  itemRenderer="CircleItemRenderer">'
						/* 아이템렌더러(데이터 마커) 테두리 색상 */
						+'<fill>'
			          		+'<SolidColor color="#0040FF" alpha="1"/>'
							+'</fill>'	
							+'<lineStroke>'
								+'<Stroke color="#0040FF" weight="2"/>'
							+'</lineStroke>'
			                +'<stroke>'
			                    +'<Stroke color="#0040FF" weight="2"/>'
			                +'</stroke>'
						+'<showDataEffect>'
							+'<SeriesInterpolate/>'
						+'</showDataEffect>'
					+'</Line2DSeries>'
					+'<Line2DSeries llabelPosition="up" showMinValueLabel="true" minimum="0" showMaxValueLabel="true" yField="TOT_AMT"  radius="3" displayName="'+chartYear+'"  itemRenderer="CircleItemRenderer">'						
					+'<fill>'
		      		+'<SolidColor color="#FA5858" alpha="1"/>'
					+'</fill>'	
					+'<lineStroke>'
						+'<Stroke color="#FA5858" weight="2"/>'
					+'</lineStroke>'
		            +'<stroke>'
		                +'<Stroke color="#FA5858" weight="2"/>'
		            +'</stroke>'							
						+'<showDataEffect>'
							+'<SeriesInterpolate/>'
						+'</showDataEffect>'
					+'</Line2DSeries>'						
				+'</series>'
			+'</Line2DChart>'
		+'</rMateChart>';
		return layoutStr5;
		}
		//차트 데이터
		var chartData5 = [];
		
		function nanQtyLayout(chartAgoYear,chartYear){
		var layoutStr6 = 
			'<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'
			+'<Options>'	
				+'<SubCaption text="단위 : 속" textAlign="left" />'
				+'<Legend defaultMouseOverAction="false" />'
			+'</Options>'
			+'<NumberFormatter id="numFmt2" useThousandsSeparator="true"/>'
			+'<Column2DChart showDataTips="true" columnWidthRatio="0.75" selectionMode="single">'
				+'<horizontalAxis>'
					+'<CategoryAxis categoryField="SALE_MONTH"/>'
				+'</horizontalAxis>'
				+'<verticalAxis>'
					+'<LinearAxis formatter="{numFmt2}"/>'
				+'</verticalAxis>'
				+'<series>'
					+'<Column2DSeries labelPosition="false" yField="AGO_TOT_QTY" displayName="'+chartAgoYear+'"  outsideLabelYOffset="-2">'
						+'<showDataEffect>'
							+'<SeriesInterpolate/>'
						+'</showDataEffect>'
					+'</Column2DSeries>'
					+'<Column2DSeries labelPosition="false" yField="TOT_QTY" displayName="'+chartYear+'"  outsideLabelYOffset="-2">'
					+'<fill>'
		            /* Series안에 색을 채울 때(단일색) fill에 주목 */
		                +'<SolidColor color="#74C93B" alpha="1"/>'
		                /* color:색깔 alpha:투명도 */
		            +'</fill>'			
						+'<showDataEffect>'
							+'<SeriesInterpolate/>'
						+'</showDataEffect>'
					+'</Column2DSeries>'			
				+'</series>'
			+'</Column2DChart>'
		+'</rMateChart>';
		return layoutStr6;
		}
		//차트 데이터
		var chartData6 = [];		
		
		function gwanAmtLayout(chartAgoYear,chartYear){
		var layoutStr7 = 
			'<rMateChart  backgroundColor="#ffffff" borderStyle="none">'
			+'<Options>'			
				+'<SubCaption text="단위 : 십만" textAlign="left" />'
				+'<Legend defaultMouseOverAction="false" useVisibleCheck="true"/>'
			+'</Options>'
			+'<NumberFormatter id="numFmt2" useThousandsSeparator="true"/>'
			+'<NumberFormatter id="numFmt" precision="0"/>'
			+'<Line2DChart showDataTips="true" dataTipDisplayMode="axis" paddingTop="0">'
				+'<horizontalAxis>'
					+'<CategoryAxis categoryField="SALE_MONTH"/>'
				+'</horizontalAxis>'
				+'<verticalAxis>'
					+'<LinearAxis formatter="{numFmt2}"/>'
				+'</verticalAxis>'
				+'<series>'
					+'<Line2DSeries labelPosition="up" showMinValueLabel="true" minimum="0" showMaxValueLabel="true" yField="AGO_TOT_AMT" radius="3" displayName="'+chartAgoYear+'"  itemRenderer="CircleItemRenderer">'
						/* 아이템렌더러(데이터 마커) 테두리 색상 */
						+'<fill>'
			          		+'<SolidColor color="#0040FF" alpha="1"/>'
							+'</fill>'	
							+'<lineStroke>'
								+'<Stroke color="#0040FF" weight="2"/>'
							+'</lineStroke>'
			                +'<stroke>'
			                    +'<Stroke color="#0040FF" weight="2"/>'
			                +'</stroke>'
						+'<showDataEffect>'
							+'<SeriesInterpolate/>'
						+'</showDataEffect>'
					+'</Line2DSeries>'
					+'<Line2DSeries  labelPosition="up" showMinValueLabel="true" minimum="0" showMaxValueLabel="true"  yField="TOT_AMT" radius="3" displayName="'+chartYear+'"  itemRenderer="CircleItemRenderer">'						
					+'<fill>'
		      		+'<SolidColor color="#FA5858" alpha="1"/>'
					+'</fill>'	
					+'<lineStroke>'
						+'<Stroke color="#FA5858" weight="2"/>'
					+'</lineStroke>'
		            +'<stroke>'
		                +'<Stroke color="#FA5858" weight="2"/>'
		            +'</stroke>'							
						+'<showDataEffect>'
							+'<SeriesInterpolate/>'
						+'</showDataEffect>'
					+'</Line2DSeries>'						
				+'</series>'
			+'</Line2DChart>'
		+'</rMateChart>';
		return layoutStr7;
		}
		//차트 데이터
		var chartData7 = [];
		
		function gwanQtyLayout(chartAgoYear,chartYear){
		var layoutStr8 = 
			'<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'
			+'<Options>'	
				+'<SubCaption text="단위 : 속" textAlign="left" />'
				+'<Legend defaultMouseOverAction="false" />'
			+'</Options>'
			+'<NumberFormatter id="numFmt2" useThousandsSeparator="true"/>'
			+'<Column2DChart showDataTips="true" columnWidthRatio="0.75" selectionMode="single">'
				+'<horizontalAxis>'
					+'<CategoryAxis categoryField="SALE_MONTH"/>'
				+'</horizontalAxis>'
				+'<verticalAxis>'
					+'<LinearAxis formatter="{numFmt2}"/>'
				+'</verticalAxis>'
				+'<series>'
					+'<Column2DSeries labelPosition="false" yField="AGO_TOT_QTY" displayName="'+chartAgoYear+'"  outsideLabelYOffset="-2">'
						+'<showDataEffect>'
							+'<SeriesInterpolate/>'
						+'</showDataEffect>'
					+'</Column2DSeries>'
					+'<Column2DSeries labelPosition="false" yField="TOT_QTY" displayName="'+chartYear+'"  outsideLabelYOffset="-2">'
					+'<fill>'
		            /* Series안에 색을 채울 때(단일색) fill에 주목 */
		                +'<SolidColor color="#01B78E" alpha="1"/>'
		                /* color:색깔 alpha:투명도 */
		            +'</fill>'			
						+'<showDataEffect>'
							+'<SeriesInterpolate/>'
						+'</showDataEffect>'
					+'</Column2DSeries>'			
				+'</series>'
			+'</Column2DChart>'
		+'</rMateChart>';
		return layoutStr8;
		}
		//차트 데이터
		var chartData8 = [];		
		
		function chunAmtLayout(chartAgoYear,chartYear){
		var layoutStr9 = 
			'<rMateChart  backgroundColor="#ffffff" borderStyle="none">'
			+'<Options>'			
				+'<SubCaption text="단위 : 십만" textAlign="left" />'
				+'<Legend defaultMouseOverAction="false" useVisibleCheck="true"/>'
			+'</Options>'
			+'<NumberFormatter id="numFmt2" useThousandsSeparator="true"/>'
			+'<NumberFormatter id="numFmt" precision="0"/>'
			+'<Line2DChart showDataTips="true" dataTipDisplayMode="axis" paddingTop="0">'
				+'<horizontalAxis>'
					+'<CategoryAxis categoryField="SALE_MONTH"/>'
				+'</horizontalAxis>'
				+'<verticalAxis>'
					+'<LinearAxis formatter="{numFmt2}"/>'
				+'</verticalAxis>'
				+'<series>'
					+'<Line2DSeries  labelPosition="up" showMinValueLabel="true" minimum="0" showMaxValueLabel="true"   yField="AGO_TOT_AMT" radius="3" displayName="'+chartAgoYear+'"  itemRenderer="CircleItemRenderer">'
						/* 아이템렌더러(데이터 마커) 테두리 색상 */
						+'<fill>'
			          		+'<SolidColor color="#0040FF" alpha="1"/>'
							+'</fill>'	
							+'<lineStroke>'
								+'<Stroke color="#0040FF" weight="2"/>'
							+'</lineStroke>'
			                +'<stroke>'
			                    +'<Stroke color="#0040FF" weight="2"/>'
			                +'</stroke>'
						+'<showDataEffect>'
							+'<SeriesInterpolate/>'
						+'</showDataEffect>'
					+'</Line2DSeries>'
					+'<Line2DSeries  labelPosition="up" showMinValueLabel="true" minimum="0" showMaxValueLabel="true"  yField="TOT_AMT" radius="3" displayName="'+chartYear+'"  itemRenderer="CircleItemRenderer">'						
					+'<fill>'
		      		+'<SolidColor color="#FA5858" alpha="1"/>'
					+'</fill>'	
					+'<lineStroke>'
						+'<Stroke color="#FA5858" weight="2"/>'
					+'</lineStroke>'
		            +'<stroke>'
		                +'<Stroke color="#FA5858" weight="2"/>'
		            +'</stroke>'							
						+'<showDataEffect>'
							+'<SeriesInterpolate/>'
						+'</showDataEffect>'
					+'</Line2DSeries>'						
				+'</series>'
			+'</Line2DChart>'
		+'</rMateChart>';
		return layoutStr9;
		}
		//차트 데이터
		var chartData9 = [];
		
		function chunQtyLayout(chartAgoYear,chartYear){
		var layoutStr10 = 
			'<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'
			+'<Options>'	
				+'<SubCaption text="단위 : 속" textAlign="left" />'
				+'<Legend defaultMouseOverAction="false" />'
			+'</Options>'
			+'<NumberFormatter id="numFmt2" useThousandsSeparator="true"/>'
			+'<Column2DChart showDataTips="true" columnWidthRatio="0.75" selectionMode="single">'
				+'<horizontalAxis>'
					+'<CategoryAxis categoryField="SALE_MONTH"/>'
				+'</horizontalAxis>'
				+'<verticalAxis>'
					+'<LinearAxis formatter="{numFmt2}"/>'
				+'</verticalAxis>'
				+'<series>'
					+'<Column2DSeries labelPosition="false" yField="AGO_TOT_QTY" displayName="'+chartAgoYear+'"  outsideLabelYOffset="-2">'
						+'<showDataEffect>'
							+'<SeriesInterpolate/>'
						+'</showDataEffect>'
					+'</Column2DSeries>'
					+'<Column2DSeries labelPosition="false" yField="TOT_QTY" displayName="'+chartYear+'"  outsideLabelYOffset="-2">'
					+'<fill>'
		            /* Series안에 색을 채울 때(단일색) fill에 주목 */
		                +'<SolidColor color="#005953" alpha="1"/>'
		                /* color:색깔 alpha:투명도 */
		            +'</fill>'			
						+'<showDataEffect>'
							+'<SeriesInterpolate/>'
						+'</showDataEffect>'
					+'</Column2DSeries>'			
				+'</series>'
			+'</Column2DChart>'
		+'</rMateChart>';
		return layoutStr10;
		}
		//차트 데이터
		var chartData10 = [];		
		
		function rMateChartH5ChangeTheme(theme){
			document.getElementById("chart1").setTheme(theme);
		}
		
		//-----------------------차트 설정 끝 -----------------------
		var cmpCd = '0000000001';
		var fnObj = {
			pageStart: function(){    				   	     	    		    		 
			   	$("#searchSaleDate").bindDate({align:"right", valign:"bottom", separator:"-", selectType:"m",  defaultSelectType:"m", value:"" ,
			       	onchange:function(){
			       		var searchFlag=dateChk();
			   
			       		//getSaleMonth(cmpCd);
			       		//graphRestart();
					}
				});
		
		   		
		   		$("#excelBtn1").empty();
			}
		};
		
		function dateChk(){
		    var searchGoFlag=false;
			var selectDate = $("#searchSaleDate").val().replace(/-/gi, "");
			var today = new Date();
			var mm = today.getMonth()+1;
			var yy= today.getFullYear();
			
			today = yy+''+mm;
			
			if(selectDate<=today){
				searchGoFlag=true;
			}else{
				alert("당월까지만 선택이 가능합니다");
			}
			
			return searchGoFlag;
		}
		
		
		
		
		function init(){
			chartData =[];
			rMateChartLoding("chart1", "chartReadyHandler");
			chartData2 =[];
			rMateChartLoding("chart2", "chartReadyHandler2");
			chartData3 =[];
			rMateChartLoding("chart3", "chartReadyHandler3");
			chartData4 =[];
			rMateChartLoding("chart4", "chartReadyHandler4");
			chartData5 =[];
			rMateChartLoding("chart5", "chartReadyHandler5");
			chartData6 =[];
			rMateChartLoding("chart6", "chartReadyHandler6");
			chartData7 =[];
			rMateChartLoding("chart7", "chartReadyHandler7");
			chartData8 =[];
			rMateChartLoding("chart8", "chartReadyHandler8");
			chartData9 =[];
			rMateChartLoding("chart9", "chartReadyHandler9");
			chartData10 =[];
			rMateChartLoding("chart10", "chartReadyHandler10");
			
		}
		
		function getSaledate(cmpCd){
			init();
			
			$.ajax({
				type : "post",
				url : "/search/selectSaleMonth.json",
				data : {
					searchCmpCd : cmpCd
				},
				dataType : '',
				success : function(res){
					var val = res.list;
					if(val.length > 0){
						$('#searchSaleDate').attr("value", val[0].SALE_MONTH);
						search();
					}else{
						$('#searchSaleDate').attr("value", "");
					}
				}
			});
		}
		
		function search(){
			setSearchCmpCd();
			
			main_index('');
			main_index('1');
			main_index('3');
			main_index('2');
			main_index('4');
		}
		
		function setSearchCmpCd(){
			CMP_CD=$("#cmpCdTab .on > input").attr("value");
						
			$.cookie("cookie.cmpCd", CMP_CD, {expires: 7, path: '/' });
						
			$("#cut").show();
			$("#nan").show();
			$("#gwan").show();
			$("#chun").show();
			if(cmpCd == '0000000001'){
				// 아직 미정
				searchFlower='1,3,2,4';
			}else if(cmpCd == '1508500020'){
				$("#chun").hide();
				searchFlower='1,3,2';
			}else if(cmpCd == '6068207466'){
				$("#gwan").hide();
				$("#chun").hide();
				searchFlower='1,3';
			}else if(cmpCd == '4108212335'){
				$("#gwan").hide();
				$("#chun").hide();
				searchFlower='1,3';
			}else if(cmpCd == '3848200087'){
				$("#cut").hide();
				$("#chun").hide();
				searchFlower='3,2';
			}else if(cmpCd == '1288202296'){
				$("#cut").hide();
				$("#chun").hide();
				searchFlower='3,2';
			}
		}
		
		//주요거래지표 
		function main_index(flowerGubun){   	
			var SALE_MONTH = document.getElementById("searchSaleDate").value;
			$.ajax({
				type : 'get',
		        url : "/haa04/selectMainList.json",
		        data : {
		        	SALE_MONTH : SALE_MONTH,
		        	CMP_CD : CMP_CD,
		        	FLOWER_GUBUN : flowerGubun,
		        	searchFlower : searchFlower
				},
		        dataType : '', 
		        beforeSend : function(){
		        	//fnObj.progress3.start();
		        	},      	   
		        success : function(res){
		        	var varName = 'main';
		        	
		        	if(flowerGubun=='1'){
		        		varName = 'cut';   		
		        	}else if(flowerGubun=='3'){
		        		varName = 'nan';     		
		        	}else if(flowerGubun=='2'){
		        		varName = 'gwan';	
		        	}else if(flowerGubun=='4'){
		        		varName = 'chun';    		
		        	}
		        	var gubun='01';
		        	/*
		        	$("#"+varName+" dt").each(function(){
		        		if($(this).attr('class').indexOf("on") != -1 ){
		        			gubun = $(this).attr('class').substring(2,4); // 01 물량, 02 금액
		        		}
		        	});
		        	*/
		        	
		        	$("#"+varName+" .dealings_graph_bt_b > li").each(function(){		        		
		        		if($(this).attr('class').indexOf("on") != -1 ){
		        			gubun = $(this).attr('class').substring(2,4); // 01 물량, 02 금액
		        		}
		        	});
		        	
		        	if(res.list.length == null || res.list.length==0 ){
		        		var divMainAmtYear = document.getElementById(varName+"_amt_year");  
		        		var divChunAmt=document.getElementById(varName+"_amt");
		        		var divChunAmtMonth = document.getElementById(varName+"_amt_month");
		        		var divChunAmtAvgmonth = document.getElementById(varName+"_amt_avgmonth");
		        		var divChunAmtSum = document.getElementById(varName+"_amt_sum");
		        		
		        		chartYear=SALE_MONTH.split('-')[0];
		        		chartAgoYear=parseInt(SALE_MONTH.split('-')[0])-1;
		        		
		        		// 1. 초기화
		        		if(gubun=='01'){
		        			divMainAmtYear.innerHTML = SALE_MONTH.split('-')[0]+"년 "+SALE_MONTH.split('-')[1]+"월";
		        			divChunAmt.innerHTML = "0 원";
		        			divChunAmtMonth.innerHTML = "<span class='txt_side'> 0 % </span>";				
		        			divChunAmtAvgmonth.innerHTML = "<span class='txt_side'> 0 % </span>";		
		        			divChunAmtSum.innerHTML = "0 원";								
		        		}else{
		        			divMainAmtYear.innerHTML = SALE_MONTH.split('-')[0]+"년 "+SALE_MONTH.split('-')[1]+"월";
		        			divChunAmt.innerHTML = "0 속";							
		        			divChunAmtMonth.innerHTML = "<span class='txt_side'> 0 % </span>";							
		        			divChunAmtAvgmonth.innerHTML = "<span class='txt_side'> 0 % </span>";							  
		        			divChunAmtSum.innerHTML = "0 속";		
		        		}
		        		
		        		if(res.list2 !=null && res.list2.length>0){
		        			if(flowerGubun==''){        			
		            			chartData = res.list2;                                                                                           
		                		rMateChartLoding("chart1", "chartReadyHandler");
		                		
		                		chartData2 = res.list2;   
		                		rMateChartLoding("chart2", "chartReadyHandler2");
		                	}else if(flowerGubun=='1'){
		                		chartData3 = res.list2;                                                                                           
		                		rMateChartLoding("chart3", "chartReadyHandler3");
		                		
		                		chartData4 = res.list2;   
		                		rMateChartLoding("chart4", "chartReadyHandler4");
		                		   		
		                	}else if(flowerGubun=='3'){
		                		chartData5 = res.list2;                                                                                           
		                		rMateChartLoding("chart5", "chartReadyHandler5");
		                		
		                		chartData6 = res.list2;   
		                		rMateChartLoding("chart6", "chartReadyHandler6");
		                			
		                	}else if(flowerGubun=='2'){
		                		chartData7 = res.list2;                                                                                           
		                		rMateChartLoding("chart7", "chartReadyHandler7");
		                		
		                		chartData8 = res.list2;   
		                		rMateChartLoding("chart8", "chartReadyHandler8");
		                	}else if(flowerGubun=='4'){
		                		chartData9 = res.list2;                                                                                           
		                		rMateChartLoding("chart9", "chartReadyHandler9");
		                		
		                		chartData10 = res.list2;   
		                		rMateChartLoding("chart10", "chartReadyHandler10");
		                	}
		        		}else{
		        			 if(flowerGubun==''){        			
		     	           		chartData = [];                                                                          
		     	           		rMateChartLoding("chart1", "chartReadyHandler");
		     	         		
		     	         		chartData2 = [];
		     	         		rMateChartLoding("chart2", "chartReadyHandler2");
		     	         	}else if(flowerGubun=='1'){
		     	         		chartData3 =  [];                                                                          
		     	         		rMateChartLoding("chart3", "chartReadyHandler3");
		     	         		
		     	         		chartData4 =  [];
		     	         		rMateChartLoding("chart4", "chartReadyHandler4");
		     	         	}else if(flowerGubun=='3'){
		     	         		chartData5 =  [];                                                            
		     	         		rMateChartLoding("chart5", "chartReadyHandler5");
		     	         		
		     	         		chartData6 =  [];
		     	         		rMateChartLoding("chart6", "chartReadyHandler6");
		     	         	}else if(flowerGubun=='2'){
		     	         		chartData7 =  [];                                                          
		     	         		rMateChartLoding("chart7", "chartReadyHandler7");
		     	         		
		     	         		chartData8 =  [];
		     	         		rMateChartLoding("chart8", "chartReadyHandler8");
		     	         	}else if(flowerGubun=='4'){
		     	         		chartData9 =  [];                                                                     
		     	         		rMateChartLoding("chart9", "chartReadyHandler9");
		     	         		
		     	         		chartData10 =  [];
		     	         		rMateChartLoding("chart10", "chartReadyHandler10");  		
		     	         	}
		        		}
		        		
		           	    return;		
		           	    
		        	}else{
		        		
		        		var result = res.list;
		        		var MON= result[0].MON;
		        		var TOT_AMT= result[0].TOT_AMT;   
		        		var TOT_QTY= result[0].TOT_QTY;
		        		var SALE_YEAR= result[0].SALE_YEAR;
		        		var AGO_SALE_YEAR= result[0].AGO_SALE_YEAR;
		        		var YEAR_AMT= result[0].YEAR_AMT;   
		        		var YEAR_QTY= result[0].YEAR_QTY; 
		        		var TOT_AMT_COMP= result[0].TOT_AMT_COMP; 
		        		var TOT_AMT_COL= result[0].TOT_AMT_COL;
		        		var TOT_QTY_COMP= result[0].TOT_QTY_COMP;
		        		var TOT_QTY_COL= result[0].TOT_QTY_COL;
		        		var M_AMT_COMP= result[0].M_AMT_COMP;
		        		var M_QTY_COMP= result[0].M_QTY_COMP;    
		        		var YEAR_AMT_COMP= result[0].YEAR_AMT_COMP; 
		        		var YEAR_AMT_COL= result[0].YEAR_AMT_COL;
		        		var YEAR_QTY_COMP= result[0].YEAR_QTY_COMP; 
		        		var YEAR_QTY_COL= result[0].YEAR_QTY_COL;	
		        	   
		        		chartYear=SALE_YEAR;
		        		chartAgoYear=AGO_SALE_YEAR;    	       
		        	   
		        		
		        		var divMainAmtYear=document.getElementById(varName+"_amt_year");
		        		var divMainAmt=document.getElementById(varName+"_amt");
		        		var divCompAmt=document.getElementById(varName+"_amt_month");
		        		var divMainAmtAvgmonth=document.getElementById(varName+"_amt_avgmonth");
		        		var divYearAmt=document.getElementById(varName+"_amt_sum");  
		        		var divMonthIndexQ=document.getElementById(varName+"_amt"); 
		        		
		        		divMainAmtYear.innerHTML=SALE_YEAR+"년  "+MON+"월";
		        		
		        		var dan = " 만원";
		        		if(gubun=='01'){
		        			var totam=TOT_AMT/10000;
		        			
		        			if(TOT_AMT > 100000000){     		  
		        				totam=TOT_AMT/100000000;  	
		        				dan = " 억원";
		        			} 
		        			
		        			var totam2=Math.floor(totam);
		        			totam2=numberWithCommas(totam2);
		        			divMainAmt.innerHTML=   totam2+dan;	      
		        			
		        			if(TOT_AMT_COL=="red"){
		        				//divCompAmt.innerHTML="<span class=ft_"+TOT_AMT_COL+">"+TOT_AMT_COMP+"% ▲</span>";	 
		        				divCompAmt.innerHTML="<span class='txt_up'>"+TOT_AMT_COMP+"% ▲</span>";	
		        			}else if(TOT_AMT_COL=="blue"){
		        				//divCompAmt.innerHTML="<span class=ft_"+TOT_AMT_COL+">"+TOT_AMT_COMP+"% ▼</span>";	
		        				divCompAmt.innerHTML="<span class='txt_down'>"+TOT_AMT_COMP+"% ▼</span>";	
		        			}else{
		        				divCompAmt.innerHTML="<span class='txt_side'>"+TOT_AMT_COMP+"%</span>";	
		        			}
		        			
		        			
		        			if(YEAR_AMT_COL=="red"){
		        				//divMainAmtAvgmonth.innerHTML="<span class=ft_"+YEAR_AMT_COL+">"+YEAR_AMT_COMP+"% ▲</span>";	   
		        				divMainAmtAvgmonth.innerHTML="<span class='txt_up'>"+YEAR_AMT_COMP+"% ▲</span>";	  
		        			}else if(YEAR_AMT_COL=="blue"){
		        				//divMainAmtAvgmonth.innerHTML="<span class=ft_"+YEAR_AMT_COL+">"+YEAR_AMT_COMP+"% ▼</span>";
		        				divMainAmtAvgmonth.innerHTML="<span class='txt_down'>"+YEAR_AMT_COMP+"% ▼</span>";	
		        			}else{
		        				divCompAmt.innerHTML="<span class='txt_side'>"+TOT_AMT_COMP+"%</span>";	
		        			}
		        			
		        			if(YEAR_AMT > 100000000 ){
		        				var yearam=YEAR_AMT/100000000;
		        				var yearam2=Math.floor(yearam);
		        				yearam2=numberWithCommas(yearam2);
		        				divYearAmt.innerHTML=yearam2+" 억원";		
		        			 }else {
		        				var yearam=YEAR_AMT/10000;
		        				var yearam2=Math.floor(yearam);
		        				yearam2 = numberWithCommas(yearam2);
		        				divYearAmt.innerHTML=yearam2+" 만원";	
		        			}					
		        			
		        			//divMonthIndexQ
		        			
		        		}else{
		        			
		        			if(TOT_QTY>10000){
		        				var totqt = TOT_QTY/10000;
		        				var totqt2 = Math.floor(totqt);
		        				totqt2 = numberWithCommas(totqt2);
		        				divMainAmt.innerHTML= totqt2+" 만속"; 
		        			}else{
		        				TOT_QTY=numberWithCommas(TOT_QTY);
		        				divMainAmt.innerHTML=   TOT_QTY+" 속"; 
		        			};
		        			
		        			if(TOT_QTY_COL=="red"){
		        				//divCompAmt.innerHTML="<span class=ft_"+TOT_QTY_COL+">"+TOT_QTY_COMP+"% ▲</span>";	   
		        				divCompAmt.innerHTML="<span class='txt_up'>"+TOT_QTY_COMP+"% ▲</span>";	  
		        			}else if(TOT_QTY_COL=="blue"){
		        				//divCompAmt.innerHTML="<span class=ft_"+TOT_QTY_COL+">"+TOT_QTY_COMP+"% ▼</span>";	
		        				divCompAmt.innerHTML="<span class='txt_down'>"+TOT_QTY_COMP+"% ▼</span>";	
		        			}else{
		        				divCompAmt.innerHTML="<span class='txt_side'>"+TOT_QTY_COMP+"%</span>";	
		        			}
		        			
		        			if(YEAR_QTY_COL=="red"){
		        				//divMainAmtAvgmonth.innerHTML="<span class=ft_"+YEAR_QTY_COL+">"+YEAR_QTY_COMP+"% ▲</span>";	  
		        				divMainAmtAvgmonth.innerHTML="<span class='txt_up'>"+YEAR_QTY_COMP+"% ▲</span>";	 
		        			}else if(YEAR_QTY_COL=="blue"){
		        				//divMainAmtAvgmonth.innerHTML="<span class=ft_"+YEAR_QTY_COL+">"+YEAR_QTY_COMP+"% ▼</span>";	
		        				divMainAmtAvgmonth.innerHTML="<span class='txt_down'>"+YEAR_QTY_COMP+"% ▼</span>";	
		        			}else{
		        				divMainAmtAvgmonth.innerHTML="<span class='txt_side'>"+YEAR_QTY_COMP+"%</span>";	
		        			}	
		        			
		        			if(YEAR_QTY > 10000){
		        				var yearqt = YEAR_QTY/10000;
		        				var yearqt2 = Math.floor(yearqt);	
		        				yearqt2 = numberWithCommas(yearqt2);
		        				var divYearQty=document.getElementById(varName+"_amt_sum");  
		        				divYearAmt.innerHTML = yearqt2+" 만속";	 
		        			}else{		
		        				YEAR_QTY=numberWithCommas(YEAR_QTY);
		        				var divYearQty=document.getElementById(varName+"_amt_sum");  
		        				divYearAmt.innerHTML=YEAR_QTY+" 속";	 
		        			}
		        		}				 
		        		
		        		if(flowerGubun==''){        			
		        			chartData = res.list2;                                                                                           
		            		chartReadyHandler("chart1"); 
		            		
		            		chartData2 = res.list2;		            		
		            		chartReadyHandler2("chart2");
		            		
		            	}else if(flowerGubun=='1'){
		            		chartData3 = res.list2;                                                                                           
		            		chartReadyHandler3("chart3"); 
		            		
		            		chartData4 = res.list2;   
		            		chartReadyHandler4("chart4");
		            		   		
		            	}else if(flowerGubun=='3'){
		            		chartData5 = res.list2;                                                                                           
		            		chartReadyHandler5("chart5"); 
		            		
		            		chartData6 = res.list2;   
		            		chartReadyHandler6("chart6");
		            			
		            	}else if(flowerGubun=='2'){
		            		chartData7 = res.list2;                                                                                           
		            		chartReadyHandler7("chart7"); 
		            		
		            		chartData8 = res.list2;   
		            		chartReadyHandler8("chart8");
		            	}else if(flowerGubun=='4'){
		            		chartData9 = res.list2;                                                                                           
		            		chartReadyHandler9("chart9"); 
		            		
		            		chartData10 = res.list2;   
		            		chartReadyHandler10("chart10");    		
		            	}
		        		
		        		
		        	}
		        },
		    });    	    
		};
		
		//숫자 콤마 함수
		function numberWithCommas(x) {
		    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		};
		
		$(document).ready(fnObj.pageStart);
	
	</script>
	
	<style type="text/css">
	.hide {
    	display: none;
	}
	</style>
	
</head>
<body>
	<!--WRAP(S)-->
	<div class="wrap">
			
		<jsp:include page="../inc/2020/IncHeader.jsp"/>
		
		<div class="lnb_box">
			<ul>
				<li><img src="../images/2020/m_lnb_img.png" alt="집"></li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li>경매정보</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li>경매실적 세부정보</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li class="m_right">주요거래지표</li>
			</ul>
		</div>
		<!--공통 HEADER(E)-->
		
		<!--서브 타이틀(S)-->
		<jsp:include page="../inc/2020/IncShare.jsp"/>
		
		<div class="sub_title">
			<div class="title_box">
				<h2>주요거래지표</h2>
				<img src="../images/2020/sub/t_line.png" alt="방울점선">
			</div>
		</div>
		<!--서브 타이틀(E)-->
		
		<jsp:include page="../inc/2020/topCmpCdMenu.jsp"/>
		
		<!--컨텐츠 내용(S)-->
		<div class="sub_guide">
		<!--1tp-->						
			<div class="dealings_b" id="main">
				<div class="dealings_box_b">
					<div class="dealings_list_b">
						<ul class="list_box_b">
							<li><img src="../images/2020/sub/step_05_off.png" alt="합계"></li>
							<li><p class="dealings_txt_b01" id="main_amt_year">2020년 02월</p></li>
							<li class="dealing_date_b">
								<ul class="dl_datel_b">
									<li>
										<p class="tet_wt01">전년동월대비</p>
										<p id="main_amt_month"><span class="wt01_red">10.51% ▲</span></p>
									</li>
									<li>
										<p class="tet_wt01">전월동월대비</p>
										<p id="main_amt_avgmonth"><span class="wt01_blue">28.08% ▼</span></p>
									</li>
								</ul>
								<ul class="dl_dater_b">
									<li>
										<span class="tet_wt01">실적</span>
										<p class="tet_wt02" id="main_amt">82억원</p>
									</li>
									<li>
										<span class="tet_wt01">누계</span>
										<p class="tet_wt02" id="main_amt_sum">182억원</p>
									</li>
								</ul>
							</li>
						</ul>
					</div>
					<div class="dealings_graph_b">
						<ul class="dealings_graph_bt_b">
							<li class="li02 tab_dt "><a href="#!" onclick="main_index('');" >거래량</a></li>
							<li class="li01 tab_dt s_on"><a href="#!" onclick="main_index('');">경매금액</a></li>
						</ul>
						<div class="graph_boxsing_b dd01 tab_dt">
							<div id="chartHolder" style="width:100%; height:100%;"></div>
						</div>
						<div class="graph_boxsing_b dd02 tab_dt hide">
							<div id="chartHolder2" style="width:100%; height:100%;"></div>
						</div>
					</div>
				</div>
			</div>
		<!--2tp-->
			<div class="dealings_b" id="cut">
				<div class="dealings_box_b">
					<div class="dealings_list_b">
						<ul class="list_box_b">
							<li><img src="../images/2020/sub/step_01_off.png" alt="절화"></li>
							<li><p class="dealings_txt_b01" id="cut_amt_year">2020년 02월</p></li>
							<li class="dealing_date_b">
								<ul class="dl_datel_b">
									<li>
										<p class="tet_wt01">전년동월대비</p>
										<p id="cut_amt_month"><span class="wt01_red">10.51% ▲</span></p>
									</li>
									<li>
										<p class="tet_wt01">전월동월대비</p>
										<p id="cut_amt_avgmonth"><span class="wt01_blue">28.08% ▼</span></p>
									</li>
								</ul>
								<ul class="dl_dater_b">
									<li>
										<span class="tet_wt01">실적</span>
										<p class="tet_wt02" id="cut_amt">82억원</p>
									</li>
									<li>
										<span class="tet_wt01">누계</span>
										<p class="tet_wt02" id="cut_amt_sum">182억원</p>
									</li>
								</ul>
							</li>
						</ul>
					</div>
					<div class="dealings_graph_b">
						<ul class="dealings_graph_bt_b">
							<li class="li02 tab_dt "><a href="#" onclick="main_index('1');">거래량</a></li>
							<li class="li01 tab_dt s_on"><a href="#" onclick="main_index('1');">경매금액</a></li>
						</ul>
						<div class="graph_boxsing_b dd01 tab_dt">
							<div id="chartHolder3" style="width:100%; height:100%;"></div>
						</div>
						<div class="graph_boxsing_b dd02 tab_dt hide">
							<div id="chartHolder4" style="width:100%; height:100%;"></div>
						</div>
					</div>
				</div>
			</div>
		<!--3tp-->
			<div class="dealings_b" id="nan">
				<div class="dealings_box_b">
					<div class="dealings_list_b">
						<ul class="list_box_b">
							<li><img src="../images/2020/sub/step_02_off.png" alt="난"></li>
							<li><p class="dealings_txt_b01" id="nan_amt_year">2020년 02월</p></li>
							<li class="dealing_date_b">
								<ul class="dl_datel_b">
									<li>
										<p class="tet_wt01">전년동월대비</p>
										<p id="nan_amt_month"><span class="wt01_red">10.51% ▲</span></p>
									</li>
									<li>
										<p class="tet_wt01">전월동월대비</p>
										<p id="nan_amt_avgmonth"><span class="wt01_blue">28.08% ▼</span></p>
									</li>
								</ul>
								<ul class="dl_dater_b">
									<li>
										<span class="tet_wt01">실적</span>
										<p class="tet_wt02" id="nan_amt">82억원</p>
									</li>
									<li>
										<span class="tet_wt01">누계</span>
										<p class="tet_wt02" id="nan_amt_sum">182억원</p>
									</li>
								</ul>
							</li>
						</ul>
					</div>
					<div class="dealings_graph_b">
						<ul class="dealings_graph_bt_b">
							<li class="li02 tab_dt "><a href="#" onclick="main_index('3');">거래량</a></li>
							<li class="li01 tab_dt s_on"><a href="#" onclick="main_index('3');">경매금액</a></li>
						</ul>
						<div class="graph_boxsing_b dd01 tab_dt">
							<div id="chartHolder5" style="width:100%; height:100%;"></div>
						</div>
						<div class="graph_boxsing_b dd02 tab_dt hide">
							<div id="chartHolder6" style="width:100%; height:100%;"></div>
						</div>
					</div>
				</div>
			</div>
		<!--4tp-->
			<div class="dealings_b" id="gwan">
				<div class="dealings_box_b">
					<div class="dealings_list_b">
						<ul class="list_box_b">
							<li><img src="../images/2020/sub/step_03_off.png" alt="관엽"></li>
							<li><p class="dealings_txt_b01" id="gwan_amt_year">2020년 02월</p></li>
							<li class="dealing_date_b">
								<ul class="dl_datel_b">
									<li>
										<p class="tet_wt01">전년동월대비</p>
										<p id="gwan_amt_month"><span class="wt01_red">10.51% ▲</span></p>
									</li>
									<li>
										<p class="tet_wt01">전월동월대비</p>
										<p id="gwan_amt_avgmonth"><span class="wt01_blue">28.08% ▼</span></p>
									</li>
								</ul>
								<ul class="dl_dater_b">
									<li>
										<span class="tet_wt01">실적</span>
										<p class="tet_wt02" id="gwan_amt">82억원</p>
									</li>
									<li>
										<span class="tet_wt01">누계</span>
										<p class="tet_wt02" id="gwan_amt_sum">182억원</p>
									</li>
								</ul>
							</li>
						</ul>
					</div>
					<div class="dealings_graph_b">
						<ul class="dealings_graph_bt_b">
							<li class="li02 tab_dt "><a href="#" onclick="main_index('2');">거래량</a></li>
							<li class="li01 tab_dt s_on"><a href="#" onclick="main_index('2');">경매금액</a></li>
						</ul>
						<div class="graph_boxsing_b dd01 tab_dt">
							<div id="chartHolder7" style="width:100%; height:100%;"></div>
						</div>
						<div class="graph_boxsing_b dd02 tab_dt hide">
							<div id="chartHolder8" style="width:100%; height:100%;"></div>
						</div>
					</div>
				</div>
			</div>
		<!--5tp-->
			<div class="dealings_b" id="chun">
				<div class="dealings_box_b">
					<div class="dealings_list_b">
						<ul class="list_box_b">
							<li><img src="../images/2020/sub/step_04_off.png" alt="춘란"></li>
							<li><p class="dealings_txt_b01" id="chun_amt_year">2020년 02월</p></li>
							<li class="dealing_date_b">
								<ul class="dl_datel_b">
									<li>
										<p class="tet_wt01">전년동월대비</p>
										<p id="chun_amt_month"><span class="wt01_red">10.51% ▲</span></p>
									</li>
									<li>
										<p class="tet_wt01">전월동월대비</p>
										<p id="chun_amt_avgmonth"><span class="wt01_blue">28.08% ▼</span></p>
									</li>
								</ul>
								<ul class="dl_dater_b">
									<li>
										<span class="tet_wt01">실적</span>
										<p class="tet_wt02" id="chun_amt">82억원</p>
									</li>
									<li>
										<span class="tet_wt01">누계</span>
										<p class="tet_wt02" id="chun_amt_sum">182억원</p>
									</li>
								</ul>
							</li>
						</ul>
					</div>
					<div class="dealings_graph_b">
						<ul class="dealings_graph_bt_b">
							<li class="li02 tab_dt "><a href="#" onclick="main_index('4');">거래량</a></li>
							<li class="li01 tab_dt s_on"><a href="#" onclick="main_index('4');">경매금액</a></li>
						</ul>
						<div class="graph_boxsing_b dd01 tab_dt">
							<div id="chartHolder9" style="width:100%; height:100%;"></div>
						</div>
						<div class="graph_boxsing_b dd02 tab_dt hide">
							<div id="chartHolder10" style="width:100%; height:100%;"></div>
						</div>
					</div>
				</div>
			</div>		
			<div class="guide">
				<h2 class="title_02">이용안내</h2>
				<ul class="guide_box">
					<li>· 화훼공판장의 경매금액 및 거래량 정보를 월별로 볼수있는 화면 </li>
					<li>· 총합계 및 절화, 난, 관엽, 춘란 별로 정보를 확인 할수 있다.</li>
					<li>· 자료출처 : 자료전송을 통한 각 공판장별 경매내역</li>
				</ul>
			</div>
		</div>
		<!--컨텐츠 내용(E)-->
		
		<jsp:include page="../inc/2020/IncFooter.jsp"/>
		
	</div>
	<!--WRAP(E)-->
</body>
</html>