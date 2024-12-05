<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="com.at.domain.SituationVO" %>

<!doctype html>
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
	<title>화훼유통정보상황판</title>
	<link type="text/css" rel="stylesheet" href="/css/common.css">
	<link type="text/css" rel="stylesheet" href="/css/sub.css">
	<link type="text/css" rel="stylesheet" href="/css/media.css" media="(max-width:1155px)">
	<link rel="stylesheet" type="text/css" href="/rMateChart/rMateChartH5/Assets/Css/rMateChartH5.css"/>
	
	<script type="text/javascript" src="/js/jquery-1.11.2.min.js"></script>
	<script type="text/javascript" src="/js/display.js"></script>
	
   	<!-- rMateChartH5 라이센스 시작 -->
	<script type="text/javascript" src="/rMateChart/LicenseKey/rMateChartH5License.js"></script>
	<!-- rMateChartH5 라이센스 끝-->  
	<!-- 실제적인 rMateChartH5 라이브러리 시작-->
	<script type="text/javascript" src="/rMateChart/rMateChartH5/JS/rMateChartH5.js"></script>
	<!-- 실제적인 rMateChartH5 라이브러리 끝-->
    <!-- rMateChartH5 테마 js -->
	<script type="text/javascript" src="/rMateChart/rMateChartH5/Assets/Theme/theme.js"></script>
	
	
	
	
	<script type="text/javascript">
	
	var firstH = "";
	
	var layoutStr1 = "";
	var layoutStr1_1 = "";
	var layoutStr2 = "";
	var layoutStr3 = "";
	var layoutStr4 = "";
	var layoutStr5 = "";
	
	var chartData1 = [];
	var chartData2 = [];
	var chartData3 = [];
	var chartData4 = [];
	var chartData5 = [];
	
	var chartVars1 = "rMateOnLoadCallFunction=chartReadyHandler1";
	var chartVars1_1 = "rMateOnLoadCallFunction=chartReadyHandler1_1";
	var chartVars2 = "rMateOnLoadCallFunction=chartReadyHandler2";
	var chartVars3 = "rMateOnLoadCallFunction=chartReadyHandler3";
	var chartVars4 = "rMateOnLoadCallFunction=chartReadyHandler4";
	var chartVars5 = "rMateOnLoadCallFunction=chartReadyHandler5";
	
	function chart1(){
		
		// 스트링 형식으로 레이아웃 정의.
		layoutStr1 = 
		 '<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'
		    +'<Options>'                     
                +'<SubCaption text="금액(원)" textAlign="left" />'
                +'<Legend defaultMouseOverAction="false" useVisibleCheck="true"/>'
		    +'</Options>'
		    +'<NumberFormatter id="numFmt" useThousandsSeparator="true"  precision="0"/>'
		    +'<Line2DChart id="chart" showDataTips="true" dataTipDisplayMode="axis" paddingTop="0">'
	        +'<horizontalAxis>'
	            +'<CategoryAxis categoryField="saleMonth"/>'
	        +'</horizontalAxis>'
	        +'<verticalAxis>'
				+'<LinearAxis  formatter="{numFmt}"/>'
			+'</verticalAxis>'
	        +'<series>'
	        	+'<Line2DSeries labelPosition="up"  formatter="{numFmt}"  showMinValueLabel="true" showMaxValueLabel="true" yField="oldTotAvg" radius="4" displayName="전년경매시세" itemRenderer="CircleItemRenderer">'
					  +'<lineStroke>'
							+'<Stroke color="#000000" weight="2"/>'
					  +'</lineStroke>'
					  +'<stroke>'
	                        +'<Stroke color="#000000" weight="2"/>'
	                  +'</stroke>'
		              +'<showDataEffect>'
		                  +'<SeriesInterpolate/>'
		              +'</showDataEffect>'
	            +'</Line2DSeries>'
	            +'<Line2DSeries labelPosition="up"  formatter="{numFmt}"  showMinValueLabel="true" showMaxValueLabel="true" yField="totAvg" radius="4" displayName="금년경매시세" itemRenderer="CircleItemRenderer">'
					  +'<lineStroke>'
						  +'<Stroke color="#9B0EAA" weight="2"/>'
					  +'</lineStroke>'
					  +'<stroke>'
		                  +'<Stroke color="#9B0EAA" weight="2"/>'
		              +'</stroke>'		
			          +'<showDataEffect>'
			              +'<SeriesInterpolate/>'
			          +'</showDataEffect>'
		        +'</Line2DSeries>'
	         +'</series>'
	    +'</Line2DChart>'
			+'<Style>'
			+'.seriesLabel{fontSize:11;color:#ffffff;fontWeight:bold;}'
			+'</Style>'
		+'</rMateChart>';
		
		layoutStr1_1 = 
			'<rMateChart backgroundColor="#FFFFFF" borderStyle="none" >'
			+'<Options>'
				+'<SubCaption text="속" textAlign="left" />'
				+'<Legend defaultMouseOverAction="false" width="80%" hAlign="center" position="bottom"/>'
			+'</Options>'
			+'<NumberFormatter id="numfmt" useThousandsSeparator="true"  precision="0"/>' 
			+'<Column2DChart showDataTips="true" dataTipDisplayMode="axis">'
				+'<horizontalAxis>'
					+'<CategoryAxis categoryField="saleMonth"/>' 
				+'</horizontalAxis>'
				+'<verticalAxis>'
					+'<LinearAxis formatter="{numfmt}" />'
				+'</verticalAxis>'
				+'<series>'
					/* type 속성을 stacked로 변경	*/
					/* type속성으로는*/
					
					/* clustered : 일반적인 다중데이터(차트의 멀티시리즈)방식으로 데이터를 표현합니다.(Default)*/
					/* stacked : 데이터를 위에 쌓아 올린 방식으로 표현 합니다.*/
					/* overlaid : 수치 데이터 값을 겹쳐서 표현 합니다. 주로 목표 위치와 현재 위치를 나타낼 때 많이 쓰입니다.*/
					/* 100% : 차트의 수치 데이터를 퍼센티지로 계산 후 값을 퍼센티지로 나타냅니다. */
					+'<Column2DSet type="stacked" showTotalLabel="true" totalLabelJsFunction="totalFunc" labelYOffset="-5">'	
						+'<series>'
						/*  Column2D Stacked 를 생성시에는 Column2DSeries를 최소 2개 정의합니다 */
							+'<Column2DSeries yField="oldAtQty" displayName="전년aT화훼공판장(양재동)" styleName="seriesLabel"  fill="#A1F16C">'
								+'<showDataEffect>'
									+'<SeriesInterpolate/>' 
								+'</showDataEffect>'
							+'</Column2DSeries>'
							+'<Column2DSeries  yField="oldBsQty" displayName="전년부산화훼공판장(엄궁동)" styleName="seriesLabel"  fill="#9CE1FE">'
								+'<showDataEffect>'
									+'<SeriesInterpolate/>' 
								+'</showDataEffect>'
							+'</Column2DSeries>'
							+'<Column2DSeries yField="oldBkQty" displayName="전년부산경남화훼농협(강동동)" styleName="seriesLabel"  fill="#8590D2">'
								+'<showDataEffect>'
									+'<SeriesInterpolate/>' 
								+'</showDataEffect>'
							+'</Column2DSeries>'
							+'<Column2DSeries yField="oldKjQty" displayName="전년광주원예농협(풍암)" styleName="seriesLabel"  fill="#FFDB71">'
							+'<showDataEffect>'
								+'<SeriesInterpolate/>' 
							+'</showDataEffect>'
							+'</Column2DSeries>'
							+'<Column2DSeries  yField="oldHuQty" displayName="전년한국화훼농협(음성)" styleName="seriesLabel"  fill="#2EC0C5">'
							+'<showDataEffect>'
								+'<SeriesInterpolate/>' 
							+'</showDataEffect>'
							+'</Column2DSeries>'
							+'<Column2DSeries yField="oldHbQty" displayName="전년한국화훼농협(과천)" styleName="seriesLabel"  fill="#FF9259">'
							+'<showDataEffect>'
								+'<SeriesInterpolate/>' 
							+'</showDataEffect>'
							+'</Column2DSeries>'
						+'</series>'
					+'</Column2DSet>'
					+'<Column2DSet type="stacked" showTotalLabel="true" totalLabelJsFunction="totalFunc" labelYOffset="-5">'	
						+'<series>'
							/*  Column2D Stacked 를 생성시에는 Column2DSeries를 최소 2개 정의합니다 */
							+'<Column2DSeries yField="atQty" displayName="금년aT화훼공판장(양재동)" styleName="seriesLabel"  fill="#60C21D">'
								+'<showDataEffect>'
									+'<SeriesInterpolate/>' 
								+'</showDataEffect>'
							+'</Column2DSeries>'
							+'<Column2DSeries yField="bsQty" displayName="금년부산화훼공판장(엄궁동)" styleName="seriesLabel"  fill="#40B2E6">'
								+'<showDataEffect>'
									+'<SeriesInterpolate/>' 
								+'</showDataEffect>'
							+'</Column2DSeries>'
							+'<Column2DSeries yField="bkQty" displayName="금년부산경남화훼농협(강동동)" styleName="seriesLabel"  fill="#5C5381">'
								+'<showDataEffect>'
									+'<SeriesInterpolate/>' 
								+'</showDataEffect>'
							+'</Column2DSeries>'
							+'<Column2DSeries yField="kjQty" displayName="금년광주원예농협(풍암)" styleName="seriesLabel"  fill="#FABC05">'
							+'<showDataEffect>'
								+'<SeriesInterpolate/>' 
							+'</showDataEffect>'
							+'</Column2DSeries>'
							+'<Column2DSeries yField="huQty" displayName="금년한국화훼농협(음성)" styleName="seriesLabel"  fill="#009687">'
							+'<showDataEffect>'
								+'<SeriesInterpolate/>' 
							+'</showDataEffect>'
							+'</Column2DSeries>'
							+'<Column2DSeries yField="hbQty" displayName="금년한국화훼농협(과천)" styleName="seriesLabel"  fill="#FA5C05">'
							+'<showDataEffect>'
								+'<SeriesInterpolate/>' 
							+'</showDataEffect>'
							+'</Column2DSeries>'
						+'</series>'
					+'</Column2DSet>'
				+'</series>'
			+'</Column2DChart>'
			+'<Style>'
				+'.seriesLabel{fontSize:11;color:#ffffff;fontWeight:bold;}'
			+'</Style>'
		+'</rMateChart>';
	
		if(!document.getElementById("chart1")){
			rMateChartH5.create("chart1", "chartHolder1", chartVars1, "100%", "100%"); 
		 } else{
			chartReadyHandler1("chart1");
		} 
		
		if(!document.getElementById("chart1_1")){
			rMateChartH5.create("chartchart1_1", "chartHolder1_1", chartVars1_1, "100%", "100%"); 
		 } else{
			chartReadyHandler1_1("chartchart1_1");
		} 
	}
	
	function rangeFunc(type, x, y){
		  for(var o in rMateChartH5.instances)
		        rMateChartH5.instances[o].updateCrossRange(type, x, y);
	}
	
	function chart2(thisMonth){
			var compareMonth = "";
			if(thisMonth < 10){
				compareMonth = "0" + thisMonth;
			}else{
				compareMonth = thisMonth;
			}
			
			var solidColor = "";
			for(var i = 0; i < chartData2.length; i++){
				if(compareMonth==chartData2[i].saleMonth){
					solidColor = solidColor + '<SolidColor color="#E64040" alpha="1"/>'	
				}else{
					solidColor = solidColor + '<SolidColor color="#5C5381" alpha="1"/>'
				}
				
	    	}
			
			// 스트링 형식으로 레이아웃 정의.
			layoutStr2 = 
				 '<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'
			     +'<Options>'                     
			                     +'<SubCaption text="물량(속/분)" textAlign="left" />'
			                     +'<SubCaption text="금액(원)" textAlign="right" />'
			                     +'<Legend position="bottom" defaultMouseOverAction="false" useVisibleCheck="false" />'
			                 +'</Options>'
			    +'<NumberFormatter id="numFmt" useThousandsSeparator="true"  precision="0"/>'
			    +'<Combination2DChart showDataTips="true" dataTipDisplayMode="axis">'
			        +'<horizontalAxis>'
			           +'<CategoryAxis categoryField="saleMonth" labelJsFunction="axisLabelFunc51"/>'
			        +'</horizontalAxis>'
			        +'<verticalAxis>'
			            +'<LinearAxis id="vAxis1"  formatter="{numFmt}" maximum="1000000"/>'
			            +'<LinearAxis id="vAxis2"  formatter="{numFmt}" maximum="12000"/>'
			        +'</verticalAxis>'
			        +'<series>'
			            +'<Column2DSet type="clustered">'
			                +'<series>'
				                +'<Column2DSeries verticalAxis="{vAxis1}" yField="oldTotQty" displayName="전년물량">'
					                +'<fill>'
					                	+'<SolidColor color="#40B2E6" alpha="1"/>'
									+'</fill>'
			                    	+'<showDataEffect>'
			                            +'<SeriesInterpolate/>'
			                        +'</showDataEffect>'
			                    +'</Column2DSeries>'
			                    +'<Column2DSeries verticalAxis="{vAxis1}" yField="totQty" displayName="금년물량">'
				                    +'<fill>'
					                	+'<SolidColor color="#5C5381" alpha="1"/>'
									+'</fill>'
			                    	+'<fills>'
			                    	+ solidColor
									+'</fills>'
			                        +'<showDataEffect>'
			                            +'<SeriesInterpolate/>'
			                        +'</showDataEffect>'
			                    +'</Column2DSeries>'
			                +'</series>'
			            +'</Column2DSet>'
			            +'<Line2DSeries labelPosition="up"  formatter="{numFmt}" showMinValueLabel="true" showMaxValueLabel="true" verticalAxis="{vAxis2}" yField="oldAvgAmt" radius="4" displayName="전년경매가격" itemRenderer="CircleItemRenderer">'
			            +'<lineStroke>'
							+'<Stroke color="#FFBB00" weight="2"/>'
						+'</lineStroke>'
							/* itemRenderer의 테두리 선 색상 입니다. */
                            +'<stroke>'
                                +'<Stroke color="#FFBB00" weight="2"/>'
                            +'</stroke>'
			                +'<showDataEffect>'
				                +'<SeriesInterpolate/>'
				            +'</showDataEffect>'
		        		+'</Line2DSeries>'
		            	+'<Line2DSeries labelPosition="up"  formatter="{numFmt}"  showMinValueLabel="true" showMaxValueLabel="true" yField="avgAmt" radius="4" displayName="금년경매가격" itemRenderer="CircleItemRenderer">'
			            	+'<lineStroke>'
								+'<Stroke color="#FA5B04" weight="2"/>'
							+'</lineStroke>'
							+'<stroke>'
	                            +'<Stroke color="#FA5B04" weight="2"/>'
	                        +'</stroke>'
			                +'<showDataEffect>'
			                    +'<SeriesInterpolate/>'
			                +'</showDataEffect>'
			            +'</Line2DSeries>'
			        +'</series>'
			        +'<verticalAxisRenderers>'
			            +'<Axis2DRenderer axis="{vAxis1}" placement="left" showLine="false"/>'
			            +'<Axis2DRenderer axis="{vAxis2}" placement="right" showLine="false"/>'
			        +'</verticalAxisRenderers>'
			    +'</Combination2DChart>'
			+'</rMateChart>';
			
			
			rMateChartH5.defaultColors = ["#40B2E6", "#5C5381", "#FFBB00", "#FA5B04"];
			if(!document.getElementById("chart2")){
				rMateChartH5.create("chart2", "chartHolder2", chartVars2, "100%", "100%"); 
			 } else{
				 chartReadyHandler2("chart2");
			} 
			
			
		}
	
	function chart3(thisMonth){
		
		var compareMonth = "";
		if(thisMonth < 10){
			compareMonth = "0" + thisMonth;
		}else{
			compareMonth = thisMonth;
		}
		
		var solidColor = "";
		for(var i = 0; i < chartData3.length; i++){
			if(compareMonth==chartData3[i].mm){
				solidColor = solidColor + '<SolidColor color="#E64040" alpha="1"/>'	
			}else{
				solidColor = solidColor + '<SolidColor color="#5C5381" alpha="1"/>'
			}
			
    	}
		
		// 스트링 형식으로 레이아웃 정의.
		layoutStr3 = 
			 '<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'
		     +'<Options>'                     
		                     +'<SubCaption text="m2" textAlign="left" />'
		                     +'<SubCaption text="물량(속)" textAlign="right" />'
		                     +'<Legend position="bottom" defaultMouseOverAction="false" useVisibleCheck="false" />'
		                 +'</Options>'
		    +'<NumberFormatter id="numFmt" useThousandsSeparator="true"  precision="0"/>'
		    +'<Combination2DChart showDataTips="true" dataTipDisplayMode="axis">'
		        +'<horizontalAxis>'
		           +'<CategoryAxis categoryField="mm" />'
		        +'</horizontalAxis>'
		        +'<verticalAxis>'
		            +'<LinearAxis id="vAxis1"  formatter="{numFmt}" />'
		            +'<LinearAxis id="vAxis2"  formatter="{numFmt}" />'
		        +'</verticalAxis>'
		        +'<series>'
		            +'<Column2DSet type="clustered">'
		                +'<series>'
			                +'<Column2DSeries verticalAxis="{vAxis1}" yField="oldArea" displayName="전년재배면적">'
				                +'<fill>'
				                	+'<SolidColor color="#40B2E6" alpha="1"/>'
								+'</fill>'
		                    	+'<showDataEffect>'
		                            +'<SeriesInterpolate/>'
		                        +'</showDataEffect>'
		                    +'</Column2DSeries>'
		                    +'<Column2DSeries verticalAxis="{vAxis1}" yField="thisArea" displayName="금년재배면적">'
			                    +'<fill>'
				                	+'<SolidColor color="#5C5381" alpha="1"/>'
								+'</fill>'
		                    	+'<fills>'
		                    	+ solidColor
								+'</fills>'
		                        +'<showDataEffect>'
		                            +'<SeriesInterpolate/>'
		                        +'</showDataEffect>'
		                    +'</Column2DSeries>'
		                +'</series>'
		            +'</Column2DSet>'
		            +'<Line2DSeries labelPosition="up"  formatter="{numFmt}"  showMinValueLabel="true" showMaxValueLabel="true" verticalAxis="{vAxis2}" yField="oldTotQty" radius="4" displayName="전년물량" itemRenderer="CircleItemRenderer">'
						+'<lineStroke>'
							+'<Stroke color="#FFBB00" weight="2"/>'
						+'</lineStroke>'
						+'<stroke>'
	                        +'<Stroke color="#FFBB00" weight="2"/>'
	                    +'</stroke>'
		                +'<showDataEffect>'
			                +'<SeriesInterpolate/>'
			            +'</showDataEffect>'
	        		+'</Line2DSeries>'
	            	+'<Line2DSeries labelPosition="up"  formatter="{numFmt}"  showMinValueLabel="true" showMaxValueLabel="true" verticalAxis="{vAxis2}" yField="thisTotQty" radius="4" displayName="금년물량" itemRenderer="CircleItemRenderer">'
		            	+'<lineStroke>'
							+'<Stroke color="#FA5B04" weight="2"/>'
						+'</lineStroke>'
						+'<stroke>'
		                    +'<Stroke color="#FA5B04" weight="2"/>'
		                +'</stroke>'
		                +'<showDataEffect>'
		                    +'<SeriesInterpolate/>'
		                +'</showDataEffect>'
		            +'</Line2DSeries>'
		        +'</series>'
		        +'<verticalAxisRenderers>'
		            +'<Axis2DRenderer axis="{vAxis1}" placement="left" showLine="false"/>'
		            +'<Axis2DRenderer axis="{vAxis2}" placement="right" showLine="false"/>'
		        +'</verticalAxisRenderers>'
		    +'</Combination2DChart>'
		+'</rMateChart>';
		
		if(!document.getElementById("chart3")){
			rMateChartH5.create("chart3", "chartHolder3", chartVars3, "100%", "100%"); 
		 } else{
			 chartReadyHandler3("chart3");
		} 
	}
	
	function chart4(){
		
		
		layoutStr4 = '<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'
					+'<Options>'
					+'<Legend defaultMouseOverAction="false" useVisibleCheck="true"/>'
				+'</Options>'	
				+'<NumberFormatter id="nft" rounding="nearest"/>'
				+'<Column2DChart showDataTips="true" dataTipFormatter="{nft}" columnWidthRatio="0.4" dataTipDisplayMode="axis">'
					+'<horizontalAxis>'
						+'<CategoryAxis categoryField="yymm"/>' 
					+'</horizontalAxis>'
					+'<verticalAxis>'
						+'<LinearAxis labelJsFunction="labelFunc"/>'
					+'</verticalAxis>'
					+'<series>'
						/* 
						type 속성을 stacked로 변경	
						type속성으로는
						clustered : 일반적인 다중데이터(차트의 멀티시리즈)방식으로 데이터를 표현합니다.(Default)
						stacked : 데이터를 위에 쌓아 올린 방식으로 표현 합니다.
						overlaid : 수치 데이터 값을 겹쳐서 표현 합니다. 주로 목표 위치와 현재 위치를 나타낼 때 많이 쓰입니다.
						100% : 차트의 수치 데이터를 퍼센티지로 계산 후 값을 퍼센티지로 나타냅니다. 
						*/
						+'<Column2DSet type="100%" showTotalLabel="true" totalLabelJsFunction="totalFunc">'
							+'<series>'
							/*  Column2D Stacked 를 생성시에는 Column2DSeries를 최소 2개 정의합니다 */
								+'<Column2DSeries labelPosition="inside" yField="val1"  formatter="{nft}" displayName="매우나쁨" color="#ffffff">'
									 +'<fill>'
			                                +'<SolidColor color="#FF5B05" alpha="1"/>'
			                            +'</fill>'
			                            +'<stroke>'
			                               +'<Stroke weight="1" color="#FF5B05"/>'
			                           +'</stroke>'
									+'<showDataEffect>'
									+'</showDataEffect>'
								+'</Column2DSeries>'
								+'<Column2DSeries labelPosition="inside" yField="val2"  formatter="{nft}" displayName="나쁨" color="#ffffff">'
									+'<fill>'
		                                +'<SolidColor color="#FABC05" alpha="1"/>'
		                            +'</fill>'
		                            +'<stroke>'
		                               +'<Stroke weight="1" color="#FABC05"/>'
		                           +'</stroke>'
									+'<showDataEffect>'
										+'<SeriesInterpolate/>' 
									+'</showDataEffect>'
								+'</Column2DSeries>'
								+'<Column2DSeries labelPosition="inside" yField="val3"  formatter="{nft}" displayName="좋음" color="#ffffff">'
								+'<fill>'
		                                +'<SolidColor color="#40B2E6" alpha="1"/>'
		                            +'</fill>'
		                            +'<stroke>'
		                               +'<Stroke weight="1" color="#40B2E6"/>'
		                           +'</stroke>'
									+'<showDataEffect>'
										+'<SeriesInterpolate/>' 
									+'</showDataEffect>'
								+'</Column2DSeries>'
								+'<Column2DSeries labelPosition="inside" yField="va4"  formatter="{nft}" displayName="매우좋음" color="#ffffff">'
								 	+'<fill>'
					                	+'<SolidColor color="#009788" alpha="1"/>'
									+'</fill>'
									+'<stroke>'
		                               +'<Stroke weight="1" color="#009788"/>'
		                           +'</stroke>'
									+'<showDataEffect>'
										+'<SeriesInterpolate/>' 
									+'</showDataEffect>'
							+'</Column2DSeries>'
							+'</series>'
						+'</Column2DSet>'
					+'</series>'
				+'</Column2DChart>'
			+'</rMateChart>';
		
		if(!document.getElementById("chart4")){
			rMateChartH5.create("chart4", "chartHolder4", chartVars4, "100%", "100%"); 
		 } else{
			 chartReadyHandler4("chart4");
		} 
	}
	
	function labelFunc(id,value){
		return value+"%";
	}
	
	function chart5(thisMonth){
		
		var compareMonth = "";
		if(thisMonth < 10){
			compareMonth = "0" + thisMonth;
		}else{
			compareMonth = thisMonth;
		}
		
		var solidColor = "";
		for(var i = 0; i < chartData5.length; i++){
			if(compareMonth==chartData5[i].mm){
				solidColor = solidColor + '<SolidColor color="#E64040" alpha="1"/>'	
			}else{
				solidColor = solidColor + '<SolidColor color="#5C5381" alpha="1"/>'
			}
			
    	}
		
		layoutStr5 = '<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'
							     +'<Options>'                     
					             +'<SubCaption text="물량(속)" textAlign="left" />'
					             +'<SubCaption text="금액(원)" textAlign="right" />'
					             +'<Legend position="bottom" defaultMouseOverAction="false" useVisibleCheck="false" />'
					         +'</Options>'
					+'<NumberFormatter id="numFmt" useThousandsSeparator="true"  precision="0"/>'
					+'<Combination2DChart showDataTips="true" dataTipDisplayMode="axis" >'
					+'<horizontalAxis>'
					   +'<CategoryAxis categoryField="mm" />'
					+'</horizontalAxis>'
					+'<verticalAxis>'
					    +'<LinearAxis id="vAxis1"  formatter="{numFmt}" minimum="0" maximum="25000" />'
					    +'<LinearAxis id="vAxis2"  formatter="{numFmt}" minimum="0"/>'
					+'</verticalAxis>'
					+'<series>'
					    +'<Column2DSet type="clustered">'
					        +'<series>'
					            +'<Column2DSeries verticalAxis="{vAxis1}" yField="oldQty" displayName="전년소매물량">'
					                +'<fill>'
					                	+'<SolidColor color="#40B2E6" alpha="1"/>'
									+'</fill>'
					            	+'<showDataEffect>'
					                    +'<SeriesInterpolate/>'
					                +'</showDataEffect>'
					            +'</Column2DSeries>'
					            +'<Column2DSeries verticalAxis="{vAxis1}" yField="thisQty" displayName="금년소매물량">'
						            +'<fill>'
					                	+'<SolidColor color="#5C5381" alpha="1"/>'
									+'</fill>'	
						            +'<fills>'
					            	+ solidColor
									+'</fills>'
					                +'<showDataEffect>'
					                    +'<SeriesInterpolate/>'
					                +'</showDataEffect>'
					            +'</Column2DSeries>'
					        +'</series>'
					    +'</Column2DSet>'
					    +'<Line2DSeries verticalAxis="{vAxis2}" labelPosition="up"  formatter="{numFmt}"  showMinValueLabel="true" showMaxValueLabel="true" yField="oldAmt" radius="4" displayName="전년소매가격" >'
					   	 +'<lineStroke>'
								+'<Stroke color="#FFBB00" weight="2"/>'
							+'</lineStroke>'
							+'<stroke>'
			                    +'<Stroke color="#FFBB00" weight="2"/>'
			                +'</stroke>'	
					        +'<showDataEffect>'
					            +'<SeriesInterpolate/>'
					        +'</showDataEffect>'
						+'</Line2DSeries>'
						+'<Line2DSeries labelPosition="up"  formatter="{numFmt}"  showMinValueLabel="true" showMaxValueLabel="true" verticalAxis="{vAxis2}" yField="thisAmt" radius="4" displayName="금년소매가격" >'
							+'<lineStroke>'
								+'<Stroke color="#FA5B04" weight="2"/>'
							+'</lineStroke>'
							+'<stroke>'
			                    +'<Stroke color="#FA5B04" weight="2"/>'
			                +'</stroke>'		
					        +'<showDataEffect>'
					            +'<SeriesInterpolate/>'
					        +'</showDataEffect>'
					    +'</Line2DSeries>'
					+'</series>'
					+'<verticalAxisRenderers>'
					    +'<Axis2DRenderer axis="{vAxis1}" placement="left" showLine="false"/>'
					    +'<Axis2DRenderer axis="{vAxis2}" placement="right" showLine="false"/>'
					+'</verticalAxisRenderers>'
					+'</Combination2DChart>'
					+'</rMateChart>';
		
		if(!document.getElementById("chart5")){
			rMateChartH5.create("chart5", "chartHolder5", chartVars5, "100%", "100%"); 
		 } else{
			 chartReadyHandler5("chart5");
		} 
	}
	
    function axisLabelFunc51(id, value){
    	
    	var d = new Date();
    	var thisMonth = (d.getMonth() + 1);
    	var compareMonth = "";
    	if(thisMonth < 10){
			compareMonth = "0" + thisMonth;
		}else{
			compareMonth = thisMonth;
		}
	
    	var returnValue= value;
		if(value == compareMonth){
			returnValue = returnValue + "\n추정치"
		}
    	return  returnValue;
    }
	
	

	
	
	function chartReadyHandler1(id) {
		document.getElementById(id).setLayout(layoutStr1);
	    document.getElementById(id).setData(chartData1);
	    //rMateChartH5.registerTheme(rMateChartH5.themes);
	}
	
	function chartReadyHandler1_1(id) {
		document.getElementById(id).setLayout(layoutStr1_1);
	    document.getElementById(id).setData(chartData1);
	}
	
	function chartReadyHandler2(id) {
		
	    document.getElementById(id).setLayout(layoutStr2);
	    document.getElementById(id).setData(chartData2);
	   
	}
	
	function chartReadyHandler3(id) {
		
	    document.getElementById(id).setLayout(layoutStr3);
	    document.getElementById(id).setData(chartData3);
	   
	}
	
	function chartReadyHandler4(id) {
		
	    document.getElementById(id).setLayout(layoutStr4);
	    document.getElementById(id).setData(chartData4);
	   
	}
	
	function chartReadyHandler5(id) {
		
	    document.getElementById(id).setLayout(layoutStr5);
	    document.getElementById(id).setData(chartData5);
	   
	}
	
	
	function getChartData1(){
		//$("#chartHolder1").html("");
		//$("#chartHolder1_1").html("");
		var d = new Date();
		
		var thisYear = d.getFullYear();
		var thisMonth = (d.getMonth() + 1);
		var thisDay = d.getDate();
		
		var searchYear = thisYear;
		var cmpCd = '0000000001';
   		var flowerCd = '1';
   		var itemCd = '장미';
		$.ajax({
			type : "post",
			url : "/main/situationNewChart1.json",
			data : {
				searchProductGubun : flowerCd,
				searchCmpCd : cmpCd,
				searchYear : searchYear,
				searchItem : itemCd
			},
			dataType : '',
			
			success : function(res){
				
				var val = res.list;
				
				chartData1 = val;
				chart1();
			}
		});
	}
	
	function getChartData2(){
		//$("#chartHolder2").html("");
		var d = new Date();
		
		var thisYear = d.getFullYear();
		var thisMonth = (d.getMonth() + 1);
		var thisDay = d.getDate();
		
		
		var searchYear = thisYear;
		var flowerCd = '1';
   		var itemCd = '장미';
		
		$.ajax({
			type : "post",
			url : "/main/situationNewChart2.json",
			data : {
				searchProductGubun : flowerCd,
				searchItem : itemCd
			},
			dataType : '',
			success : function(res){
				var val = res.list;
				
				var d = new Date();
	   			var compareMonth = (d.getMonth() + 1);
	   			
	   			
	   			if(compareMonth<10){
	   				compareMonth = "0" + compareMonth;
   				}
	   			
				chartData2 = val;
				chart2(thisMonth);
				
				var lastQty = "";
				for(var i = 0; i<res.list.length; i++){
					if(compareMonth == res.list[i].saleMonth){
						lastQty = res.list[i].totQty;
					}
				}
				
				textTable(res.list2, lastQty);
			}
		});
	}
	
	function textTable(val, lastQty){
		
		var tableTag1 = "<th>월</th>";
		var tableTag2 = "<th>전체물량 (천속)</th>";
		var tableTag3 = "<th>출하예정물량 (천속)</th>";
		var tableTag4 = "<th>%</th>";
		
		for(var i=0; i< val.length; i++){
			tableTag1 += "<td>"+val[i].saleMonth+"</td>";
			if(i == (val.length-1) ){
				tableTag2 += "<td>"+(lastQty/1000).toFixed(0)+"</td>";
				if(val[i].chulQty !=null){
					tableTag3 +="<td>"+val[i].chulQty.toFixed(0)+"</td>";
				}else{
					tableTag3 += "<td>0</td>";
				}
				tableTag4 += "<td>"+((lastQty/1000)/val[i].chulQty*100).toFixed(0)+"%</td>";	
			}else{
				tableTag2 += "<td>"+val[i].totQty.toFixed(0)+"</td>";
				if(val[i].chulQty !=null){
					tableTag3 += "<td>"+val[i].chulQty.toFixed(0)+"</td>";	
				}else{
					tableTag3 += "<td>0</td>";
				}
				
				tableTag4 += "<td>"+(val[i].chulPer*100).toFixed(0)+"%</td>";
			}
			
		}
		
		$("#tableTag1").html(tableTag1);
		$("#tableTag2").html(tableTag2);
		$("#tableTag3").html(tableTag3);
		$("#tableTag4").html(tableTag4);
	}
	
	function getChartData3(){
		
		//$("#chartHolder3").html("");
		var flowerCd = '1';
   		var itemCd = '장미';
   		
		var d = new Date();
		
		var thisYear = d.getFullYear();
		var thisMonth = (d.getMonth() + 1);
		var thisDay = d.getDate();
		
		$.ajax({
			type : "post",
			url : "/main/situationNewChart3.json",
			data : {
				searchProductGubun : flowerCd,
				searchItem : itemCd
			},
			dataType : '',
			success : function(res){
				var val = res.list;
				chartData3 = val;
				chart3(thisMonth);
			}
		});
		
	}
	
	function getChartData4(){
		//$("#chartHolder4").html("");
		
		var flowerCd = '1';
   		var itemCd = '장미';
		
		$.ajax({
			type : "post",
			url :"/main/situationNewChart4.json",
			data : {
				searchProductGubun : flowerCd,
				searchItem : itemCd
			},
			dataType : '',
			success : function(res){
				var val = res.list;
				chartData4 = val;
				
				chart4();
			}
		});	
	}
	
	function getChartData5(){
		
		//$("#chartHolder5").html("");
		
		var flowerCd = '1';
   		var itemCd = '장미';
   		
		var d = new Date();
		
		var thisYear = d.getFullYear();
		var thisMonth = (d.getMonth() + 1);
		var thisDay = d.getDate();
		$.ajax({
			type : "post",
			url : "/main/situationNewChart5.json",
			data : {
				searchProductGubun : flowerCd,
				searchItem : itemCd
			},
			dataType : '',
			success : function(res){
				var val = res.list;
				chartData5 = val;
				chart5(thisMonth);
			}
		});	
	}
	
	function prev(){
		var linum = 0 ;
		var divnum = 0 ;
		
		$(".tabNav2 > li").each(function(index){
			var className = $(".tabNav2 > li").eq(index).attr("class");
			var onCheck = className.indexOf("on");
			if(onCheck != -1){
				linum = $(".tabNav2 > li").eq(index).attr("class").substring(3,4) - 1;
				divnum = $(".tabNav2 > li").eq(index).attr("class").substring(3,4);
				$(".tabNav2 > li").eq(linum).removeClass("on");
				$("#st_content0"+divnum).removeClass("on");
			}
		});
		
		if(linum=="0"){
			linum = 5;
			divnum = 6;
		}
		
		divnum--;
		
		$(".tabNav2 > li").eq(linum-1).addClass("on");
		$("#st_content0"+divnum).addClass("on");
		chartReload(divnum);
	}
	
	function next(){
		var linum = 0 ;
		var divnum = 0 ;
		
		$(".tabNav2 > li").each(function(index){
			var className = $(".tabNav2 > li").eq(index).attr("class");
			var onCheck = className.indexOf("on");
			if(onCheck != -1){
				linum = $(".tabNav2 > li").eq(index).attr("class").substring(3,4) - 1;
				divnum = $(".tabNav2 > li").eq(index).attr("class").substring(3,4);
				$(".tabNav2 > li").eq(linum).removeClass("on");
				$("#st_content0"+divnum).removeClass("on");
			}
		});
		
		if(linum=="4"){
			linum = -1;
			divnum = 0;
		}
		
		divnum++;
		$(".tabNav2 > li").eq(linum+1).addClass("on");
		$("#st_content0"+divnum).addClass("on");
		
		chartReload(divnum);
	}
	
	function chartReload(divnum){
		/* if($("#chart"+divnum).html() == undefined ){
			if(divnum == 1){
				getChartData1();
			}else if(divnum == 2){
				getChartData2();
			}else if(divnum == 3){
				getChartData3();
			}else if(divnum == 4){
				getChartData4();
			}else if(divnum == 5){
				getChartData5();
			}
		}else{
			if(divnum == 1){
				getChartData1();
			}
		} */
		
		if(divnum == 1){
			if(firstH == "475"){					
				$("article").height("1200");
			}
			getChartData1();
		}else if(divnum == 2){
			if(firstH == "475"){
				
				$("article").height(firstH);					
			}
			getChartData2();
		}else if(divnum == 3){
			if(firstH == "475"){
				$("article").height(firstH);
			}
			getChartData3();
		}else if(divnum == 4){
			if(firstH == "475"){
				$("article").height(firstH);
			}
			getChartData4();
		}else if(divnum == 5){
			if(firstH == "475"){
				$("article").height(firstH);
			}
			getChartData5();
		}
	
	 	window.dispatchEvent(new Event('resize'));
	}
	
	
	$(document).ready(function(){
		
		firstH = $("article").height();
		if(firstH == "475"){					
			$("article").height("1200")
		}
		getChartData1();
	});
	
	
	</script>
	<style type="text/css">

	</style>
</head>
<body>
	<ul class="skip_nav">
		<li><a href="#header">상단바로가기</a></li>
		<li><a href="#content">본문바로가기</a></li>
	</ul><!-- skip end -->
	<div id="wrap3">
		<div id="header">
			<h1 class="situationTit2">화훼유통정보시스템 상황판</h1>
			<ul class="tabNav2">
				<li class="li01 on"><a href="#" onclick="chartReload(1);">절화 공판장별 거래물량 추이</a></li>
				<li class="li02"><a href="#" onclick="chartReload(2);">절화 공판장 거래규모</a></li>
				<li class="li03"><a href="#" onclick="chartReload(3);">재배현황</a></li>
				<li class="li04"><a href="#" onclick="chartReload(4);">작황동향</a></li>
				<li class="li05"><a href="#" onclick="chartReload(5);">소비동향</a></li>
			</ul><!-- tabNav end -->
			<button class="st_close" onclick="window.close();">닫기</button>
		</div><!-- header end -->
		<article>
			<div class="contentWrap" style="padding-bottom: 0px;">
				<section class="situation2 on" id="st_content01">
					<h2 class="tit">절화 공판장별 거래물량 추이(장미)</h2>
					<div class="graphWrap100">
						<div class="chart1" id="chartHolder1" style="width:100%; height:40%;"></div>
						<div class="chart1" id="chartHolder1_1" style="width:100%; height:50%;"></div>
					</div><!-- graphWrap2 end-->
				</section><!-- situation2 #st_content01 end-->

				<section class="situation2" id="st_content02">
					<h2 class="tit">절화 공판장 거래규모</h2>
					<div class="graphWrap100">
						<div class="chart1" id="chartHolder2" style="width:100%; height:65%;"></div>
						<%-- <div class="gridWrap02">
							<p class="txt mt10">※추정치는 모니터링 요원으로 부터 재배 동향에 가중치 계산식으로 산출된 예정 출하물량</p>
							<p class="txt">※당월추정치 산출식 : 당월출하예정물량 X 평균( 전체물량 / 출하예정물량 X 100 ) X 10% + 전년동월물량 X ( 11~1 개월전 물량 / 23~13 개월전물량 X 100 ) X 90%</p>
							<table class="situation_table">
								<colgroup>
									<col style="width:*;">
									<col style="width:6.7%;">
									<col style="width:6.7%;">
									<col style="width:6.7%;">
									<col style="width:6.7%;">
									<col style="width:6.7%;">
									<col style="width:6.7%;">
									<col style="width:6.7%;">
									<col style="width:6.7%;">
									<col style="width:6.7%;">
									<col style="width:6.7%;">
									<col style="width:6.7%;">
									<col style="width:6.7%;">
									<col style="width:6.7%;">
								</colgroup>
								<caption>추정치에 대한 표 입니다.</caption>
								<tbody>
									<tr id="tableTag1">
									</tr>
									<tr id="tableTag2">
									</tr>
									<tr id="tableTag3">
									</tr>
									<tr id="tableTag4">
									</tr>
								</tbody>
							</table>
						</div><!--  gridWrap02 end  --> --%>
					
					</div><!-- graphWrap2 end-->
					
				</section><!-- situation2 #st_content01 end-->

				<section class="situation2" id="st_content03">
					<h2 class="tit">재배현황</h2>
					<div class="graphWrap100">
						<div class="chart1" id="chartHolder3" style="width:100%; height:80%;"></div>
					</div><!-- graphWrap2 end-->
				</section><!-- situation2 #st_content01 end-->

				<section class="situation2" id="st_content04">
					<h2 class="tit">작황동향</h2>
					<div class="graphWrap100">
						<div class="chart1" id="chartHolder4" style="width:100%; height:80%;"></div>
					</div><!-- graphWrap2 end-->
				</section><!-- situation2 #st_content01 end-->

				<section class="situation2" id="st_content05">
					<h2 class="tit">소비동향</h2>
					<div class="graphWrap100">
						<div class="chart1" id="chartHolder5" style="width:100%; height:80%;"></div>
					</div><!-- graphWrap2 end-->
				</section><!-- situation2 #st_content01 end-->
				<ul class="st_pagingArea">
					<li class="prev"><a href="#" onclick="prev();">prev</a></li>
					<li class="next"><a href="#" onclick="next();">next</a></li>
				</ul><!-- pagingArea end -->
			</div><!-- contentWrap end -->
		</article>
	</div><!-- wrap end -->
</body>
</html>