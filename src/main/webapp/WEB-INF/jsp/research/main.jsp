<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>


<!doctype html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="Author" content="">
<meta name="Keywords" content="">
<meta name="Description" content="">
<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>생산조사</title>
<!-- CSS(S) -->
<link rel="stylesheet" type="text/css" href="/research/css/reset.css">
<link rel="stylesheet" type="text/css" href="/research/css/common.css">
<link rel="stylesheet" type="text/css" href="/research/css/sub.css">
<!-- CSS(E) -->

<!-- SCRIPT(S) -->

<script type="text/javascript" src="/research/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="/research/js/script.js"></script> 
<!-- SCRIPT(E) -->


<style type="text/css">

.loadingWrap { display:none; }
.loadArea { position:fixed; display:table; left:0; top:0; width:100%; height:100%; background:#000; background-color:rgba(0,0,0,0.5); z-index:100; }
.loadArea .loading { display:table-cell; width:100%; height:100%; text-align:center; vertical-align:middle; }
.lds-dual-ring { display: inline-block; width: 80px; height: 80px; }
.lds-dual-ring:after { content: " "; display: block; width: 64px; height: 64px; margin: 8px; border-radius: 50%; border: 6px solid #fff; border-color: #fff transparent #fff transparent; animation: lds-dual-ring 1.2s linear infinite; }

@keyframes lds-dual-ring {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
}



</style>

<!-- rMateChartH5 라이센스 -->
<script type="text/javascript" src="/rMateMapChart/LicenseKey/rMateMapChartH5License.js"></script>
<!-- rMateMapChartH5 라이브러리 -->
<script type="text/javascript" src="/rMateMapChart/rMateMapChartH5/JS/rMateMapChartH5.js"></script>


<!-- rMateMapChartH5 CSS -->
<link rel="stylesheet" type="text/css" href="/rMateMapChart/rMateMapChartH5/Assets/rMateMapChartH5.css"/>

<link rel="stylesheet" type="text/css" href="<c:url value='/rMateChart/rMateChartH5/Assets/Css/rMateChartH5.css' />"/>   
 <!-- @@@@@@@@@@@@@@@@@@@@@@ css end   @@@@@@@@@@@@@@@@@@@@@@ --> 


<!-- rMateChartH5 에서 사용하는 스타일 -->
<link rel="stylesheet" type="text/css" href="/rMateChart/rMateChartH5/Assets/Css/rMateChartH52.css"/>

<!-- rMateChartH5 라이센스 -->
<script language="javascript" type="text/javascript" src="/rMateChart/LicenseKey/rMateChartH5License.js"></script>

<!-- 실제적인 rMateChartH5 라이브러리-->
<script type="text/javascript" src="/rMateChart/rMateChartH5/JS/rMateIntegrationH5.js"></script> 

<!-- rMateChartH5 테마 js -->
<script type="text/javascript" src="/rMateChart/rMateChartH5/Assets/Theme/theme.js"></script>
<script type="text/javascript" src="/rMateMapChart/rMateMapChartH5/JS/html2canvas.js"></script>
<script type="text/javascript" src="/rMateMapChart/rMateMapChartH5/JS/promise.min.js"></script>
<script type="text/javascript" src="/rMateMapChart/rMateMapChartH5/JS/canvg.js"></script>
<script type="text/javascript" src="/rMateMapChart/rMateMapChartH5/JS/rgbcolor.js"></script>

<script type="text/javascript">


$(document).ready(function(){	
	$(".main_title").html($("#stdYear").prop("value") + "년 " + $("#kind").prop("value") + " 생산조사");
	fn_search();
});


function comma(num){
    var len, point, str; 
       
    num = num + ""; 
    point = num.length % 3 ;
    len = num.length; 
   
    str = num.substring(0, point); 
    while (point < len) { 
        if (str != "") str += ","; 
        str += num.substring(point, point + 3); 
        point += 3; 
    } 
     
    return str;
}



function fn_stdYearChange(){
	
	
	$(".main_title").html($("#stdYear").prop("value") + "년 " + $("#kind").prop("value") + " 생산조사");
	fn_search();
	
}

function fn_stdKindChange(){
	
	
	$(".main_title").html($("#stdYear").prop("value") + "년 " + $("#kind").prop("value") + " 생산조사");
	fn_search();
	
}



function fn_search(type){
	
	var stdYear = $("#stdYear").prop("value");
	var stdKind = $("#kind").prop("value");
	
	//차트 8개
	if (stdKind == '절화') {
		fh_chulInfoAll(stdYear);
		fn_chart(stdYear);
	}
	if (stdKind == '난') {
		fh_chulInfoAll2(stdYear);
		fn_chart2(stdYear);
	}
}

//-----------------------차트 설정 시작-----------------------
	
//rMate 차트 생성 준비가 완료된 상태 시 호출할 함수를 지정합니다.
var chartVars1 = "rMateOnLoadCallFunction=chartReadyHandler1";
var chartVars2 = "rMateOnLoadCallFunction=chartReadyHandler2";
var chartVars3 = "rMateOnLoadCallFunction=chartReadyHandler3";
var chartVars4 = "rMateOnLoadCallFunction=chartReadyHandler4";
var chartVars5 = "rMateOnLoadCallFunction=chartReadyHandler5";
var chartVars6 = "rMateOnLoadCallFunction=chartReadyHandler6";
var chartVars7 = "rMateOnLoadCallFunction=chartReadyHandler7";
var chartVars8 = "rMateOnLoadCallFunction=chartReadyHandler8";


//rMateChart 를 생성합니다.
//파라메터 (순서대로) 
//1. 차트의 id ( 임의로 지정하십시오. ) 
//2. 차트가 위치할 div 의 id (즉, 차트의 부모 div 의 id 입니다.)
//3. 차트 생성 시 필요한 환경 변수들의 묶음인 chartVars
//4. 차트의 가로 사이즈 (생략 가능, 생략 시 100%)
//5. 차트의 세로 사이즈 (생략 가능, 생략 시 100%)
//rMateChartH5.create("chart1", "chartHolder", chartVars, "100%", "55%"); 

//차트의 속성인 rMateOnLoadCallFunction 으로 설정된 함수.
//rMate 차트 준비가 완료된 경우 이 함수가 호출됩니다.
//이 함수를 통해 차트에 레이아웃과 데이터를 삽입합니다.
//파라메터 : id - rMateChartH5.create() 사용 시 사용자가 지정한 id 입니다.
function chartReadyHandler1(id) {
	document.getElementById(id).setLayout(layoutStr1);
	document.getElementById(id).setData(chartData1);
	checkData1(chartData1);
}

function chartReadyHandler2(id) {
	document.getElementById(id).setLayout(layoutStr2);
	document.getElementById(id).setData(chartData2);

	checkData2(chartData2);
}

function chartReadyHandler3(id) {
	document.getElementById(id).setLayout(layoutStr3);
	document.getElementById(id).setData(chartData3);

	checkData3(chartData3);
}

function chartReadyHandler4(id) {
	document.getElementById(id).setLayout(layoutStr4);
	document.getElementById(id).setData(chartData4);

	checkData4(chartData4);
}

function chartReadyHandler5(id) {
	document.getElementById(id).setLayout(layoutStr5);
	document.getElementById(id).setData(chartData5);

	checkData5(chartData5);
}

function chartReadyHandler6(id) {
	document.getElementById(id).setLayout(layoutStr6);
	document.getElementById(id).setData(chartData6);

	checkData6(chartData6);
}

function chartReadyHandler7(id) {
	document.getElementById(id).setLayout(layoutStr7);
	document.getElementById(id).setData(chartData7);

	checkData7(chartData7);
}

function chartReadyHandler8(id) {
	document.getElementById(id).setLayout(layoutStr8);
	document.getElementById(id).setData(chartData8);

	checkData8(chartData8);
}

function chartReadyHandler9(id) {
	document.getElementById(id).setLayout(layoutStr9);
	document.getElementById(id).setData(chartData9);

	checkData9(chartData9);
}

function chartReadyHandler10(id) {
	document.getElementById(id).setLayout(layoutStr10);
	document.getElementById(id).setData(chartData10);

	checkData10(chartData10);
}

function chartReadyHandler11(id) {
	document.getElementById(id).setLayout(layoutStr11);
	document.getElementById(id).setData(chartData11);

	checkData11(chartData11);
}

function chartReadyHandler12(id) {
	document.getElementById(id).setLayout(layoutStr12);
	document.getElementById(id).setData(chartData12);

	checkData12(chartData12);
}


function dataTipFunc(seriesId, seriesName, index, xName, yName, data, values){
	
	var html = "";
		html += values[0] + "<br>";
		html += seriesName + " : " + values[1];
	
	return html;
}

function dataTipFuncPer(seriesId, seriesName, index, xName, yName, data, values){
	
	var html = "";
		html += values[0] + "<br>";
		html += seriesName + " : " + values[1] + "%";
	
	return html;
}


function chartItemClickHandler(seriesId, displayText, index, data, values){
	
    chUrl = "/research/chulInfo.do?prdArea="+data.areaTypeOrder;
    window.location.href = chUrl;
}

function chartItemClickHandler2(seriesId, displayText, index, data, values){
	
    chUrl = "/research/prodInfo.do?flower="+data.flower;
    window.location.href = chUrl;
}

//스트링 형식으로 레이아웃 정의.
var layoutStr1 = 
	'<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'
	    +'<Options>'
	     +'<SubCaption text="호" textAlign="left" />'
	     +'<Legend defaultMouseOverAction="false" useVisibleCheck="true" />'
	    +'</Options>'
	    +'<NumberFormatter id="numFmt" useThousandsSeparator="true"/>'
	   +'<Column2DChart showDataTips="true" columnWidthRatio="0.7" selectionMode="single" displayCompleteCallFunction="displayCallFunction"  dataTipJsFunction="dataTipFunc" itemClickJsFunction="chartItemClickHandler" >'
	       +'<horizontalAxis>'
	       	+'<CategoryAxis  id="hAxis" categoryField="areaType" padding="0.4"/>'
	        +'</horizontalAxis>'
	        +'<verticalAxis>'
	           +'<LinearAxis id="vAxis"  formatter="{numFmt}"/>'
	       +'</verticalAxis>'
	          +'<series>'
	          	+'<Column2DSeries yField="nongCnt" displayName="재배농가수" halfWidthOffset="10" labelPosition="outside">'
	          	+'<fills>'
                   +'<SolidColor color="#536BC9"/>'
	                  +'<SolidColor color="#4DC189"/>'
	                  +'<SolidColor color="#F1B95F"/>'
	                  +'<SolidColor color="#715FB9"/>'
	              +'</fills>'
		              +'<showDataEffect>'
		                 +'<SeriesInterpolate/>'
		             +'</showDataEffect>'
			        +'</Column2DSeries>'
	        +'</series>'
	        +'<horizontalAxisRenderers>'
	        +'<Axis2DRenderer axis="{hAxis}" minorTickLength="0" tickPlacement="outside" minorTickPlacement="cross" placement="bottom" canDropLabels="true" showLabels="true" showLine="true" labelAlign="center">'
	             +'<axisStroke>'
	                  +'<Stroke weight="10" color="#f4f4f4"/>'
	             +'</axisStroke>'
	        +'</Axis2DRenderer>'
	     +'</horizontalAxisRenderers>'
	     	+'<verticalAxisRenderers>'
	    		+'<Axis2DRenderer axis="{vAxis}" left="15px;" showLine="false"/>'
			+'</verticalAxisRenderers>' 
	    +'</Column2DChart>'
	 +'</rMateChart>';
	
var layoutStr2 = 
	'<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'
    +'<Options>'
     +'<SubCaption text="만단" textAlign="left" />'
     +'<Legend defaultMouseOverAction="false" useVisibleCheck="true" />'
    +'</Options>'
    +'<NumberFormatter id="numFmt" useThousandsSeparator="true"/>'
   +'<Column2DChart showDataTips="true" columnWidthRatio="0.7" selectionMode="single" displayCompleteCallFunction="displayCallFunction"  dataTipJsFunction="dataTipFunc"  itemClickJsFunction="chartItemClickHandler" >'
       +'<horizontalAxis>'
       	+'<CategoryAxis  id="hAxis" categoryField="areaType" padding="0.4"/>'
        +'</horizontalAxis>'
        +'<verticalAxis>'
           +'<LinearAxis id="vAxis"  formatter="{numFmt}"/>'
       +'</verticalAxis>'
          +'<series>'
          	+'<Column2DSeries yField="yearQty" displayName="출하량" halfWidthOffset="10" labelPosition="outside">'
          	+'<fills>'
               +'<SolidColor color="#536BC9"/>'
                  +'<SolidColor color="#4DC189"/>'
                  +'<SolidColor color="#F1B95F"/>'
                  +'<SolidColor color="#715FB9"/>'
              +'</fills>'
	              +'<showDataEffect>'
	                 +'<SeriesInterpolate/>'
	             +'</showDataEffect>'
		        +'</Column2DSeries>'
        +'</series>'
        +'<horizontalAxisRenderers>'
        +'<Axis2DRenderer axis="{hAxis}" minorTickLength="0" tickPlacement="outside" minorTickPlacement="cross" placement="bottom" canDropLabels="true" showLabels="true" showLine="true" labelAlign="center">'
             +'<axisStroke>'
                  +'<Stroke weight="10" color="#f4f4f4"/>'
             +'</axisStroke>'
        +'</Axis2DRenderer>'
     +'</horizontalAxisRenderers>'
     	+'<verticalAxisRenderers>'
    		+'<Axis2DRenderer axis="{vAxis}" left="15px;" showLine="false"/>'
		+'</verticalAxisRenderers>' 
    +'</Column2DChart>'
 +'</rMateChart>';
           
var layoutStr3 = 
	'<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'
	    +'<Options>'
	     +'<SubCaption text="%" textAlign="left" />'
	     +'<Legend defaultMouseOverAction="false" useVisibleCheck="true" />'
	    +'</Options>'
	    +'<NumberFormatter id="numFmt" useThousandsSeparator="true"/>'
	   +'<Column2DChart showDataTips="true" columnWidthRatio="0.7" selectionMode="single" displayCompleteCallFunction="displayCallFunction"  dataTipJsFunction="dataTipFunc" itemClickJsFunction="chartItemClickHandler" >'
	       +'<horizontalAxis>'
	       	+'<CategoryAxis  id="hAxis" categoryField="areaType" padding="0.4"/>'
	        +'</horizontalAxis>'
	        +'<verticalAxis>'
	           +'<LinearAxis id="vAxis"  formatter="{numFmt}" maximum="100"/>'
	       +'</verticalAxis>'
	          +'<series>'
	          	+'<Column2DSeries yField="b2r2c1" displayName="자가" halfWidthOffset="10" labelPosition="outside">'
	          	+'<fills>'
	               +'<SolidColor color="#536BC9"/>'
	                  +'<SolidColor color="#4DC189"/>'
	                  +'<SolidColor color="#F1B95F"/>'
	                  +'<SolidColor color="#715FB9"/>'
	              +'</fills>'
		              +'<showDataEffect>'
		                 +'<SeriesInterpolate/>'
		             +'</showDataEffect>'
			        +'</Column2DSeries>'
		        +'<Column2DSeries yField="b2r3c1" displayName="임차" halfWidthOffset="10" labelPosition="outside">'
	          	+'<fills>'
	               +'<SolidColor color="#B2CCFF"/>'
	                  +'<SolidColor color="#B7F0B1"/>'
	                  +'<SolidColor color="#FFE08C"/>'
	                  +'<SolidColor color="#D1B2FF"/>'
	              +'</fills>'
		              +'<showDataEffect>'
		                 +'<SeriesInterpolate/>'
		             +'</showDataEffect>'
			        +'</Column2DSeries>'
	        +'</series>'
	        +'<horizontalAxisRenderers>'
	        +'<Axis2DRenderer axis="{hAxis}" minorTickLength="0" tickPlacement="outside" minorTickPlacement="cross" placement="bottom" canDropLabels="true" showLabels="true" showLine="true" labelAlign="center">'
	             +'<axisStroke>'
	                  +'<Stroke weight="10" color="#f4f4f4"/>'
	             +'</axisStroke>'
	        +'</Axis2DRenderer>'
	     +'</horizontalAxisRenderers>'
	     	+'<verticalAxisRenderers>'
	    		+'<Axis2DRenderer axis="{vAxis}" left="15px;" showLine="false"/>'
			+'</verticalAxisRenderers>' 
	    +'</Column2DChart>'
	 +'</rMateChart>';
 
              
var layoutStr4 = 
	'<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'
	    +'<Options>'
	     +'<SubCaption text="억원" textAlign="left" />'
	     +'<Legend defaultMouseOverAction="false" useVisibleCheck="true" />'
	    +'</Options>'
	    +'<NumberFormatter id="numFmt" useThousandsSeparator="true"/>'
	   +'<Column2DChart showDataTips="true" columnWidthRatio="0.7" selectionMode="single" displayCompleteCallFunction="displayCallFunction"  dataTipJsFunction="dataTipFunc" itemClickJsFunction="chartItemClickHandler" >'
	       +'<horizontalAxis>'
	       	+'<CategoryAxis  id="hAxis" categoryField="areaType" padding="0.4"/>'
	        +'</horizontalAxis>'
	        +'<verticalAxis>'
	           +'<LinearAxis id="vAxis"  formatter="{numFmt}"/>'
	       +'</verticalAxis>'
	          +'<series>'
	          	+'<Column2DSeries yField="yearAmt" displayName="출하액" halfWidthOffset="10" labelPosition="outside">'
	          	+'<fills>'
	               +'<SolidColor color="#536BC9"/>'
	                  +'<SolidColor color="#4DC189"/>'
	                  +'<SolidColor color="#F1B95F"/>'
	                  +'<SolidColor color="#715FB9"/>'
	              +'</fills>'
		              +'<showDataEffect>'
		                 +'<SeriesInterpolate/>'
		             +'</showDataEffect>'
			        +'</Column2DSeries>'
	        +'</series>'
	        +'<horizontalAxisRenderers>'
	        +'<Axis2DRenderer axis="{hAxis}" minorTickLength="0" tickPlacement="outside" minorTickPlacement="cross" placement="bottom" canDropLabels="true" showLabels="true" showLine="true" labelAlign="center">'
	             +'<axisStroke>'
	                  +'<Stroke weight="10" color="#f4f4f4"/>'
	             +'</axisStroke>'
	        +'</Axis2DRenderer>'
	     +'</horizontalAxisRenderers>'
	     	+'<verticalAxisRenderers>'
	    		+'<Axis2DRenderer axis="{vAxis}" left="15px;" showLine="false"/>'
			+'</verticalAxisRenderers>' 
	    +'</Column2DChart>'
	 +'</rMateChart>';

var layoutStr5 = 
	'<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'
	    +'<Options>'
	    +'<SubCaption text="단위 : 호" textAlign="right" />'
	        +'<Caption text="" />'
	   +'</Options>'
	   +'<NumberFormatter id="numFmt" useThousandsSeparator="true"/>'
	   +'<Bar2DChart showDataTips="true" itemClickJsFunction="chartItemClickHandler2">'
	         +'<horizontalAxis>'
	         	+'<LinearAxis id="vAxis"  formatter="{numFmt}"/>'
	          +'</horizontalAxis>'
	        +'<verticalAxis>'
	           +'<CategoryAxis id="hAxis" categoryField="flower"/>'
	       +'</verticalAxis>'
	          +'<series>'
	             +'<Bar2DSeries labelPosition="outside" xField="nongCnt" displayName="재배농가수" color="#000000" insideLabelYOffset="-2">'
	             		+'<fills>'
	             		   +'<SolidColor color="#536BC9"/>'
		               +'</fills>'
	                  +'<showDataEffect>'
	                     +'<SeriesInterpolate/>'
	                +'</showDataEffect>'
	            +'</Bar2DSeries>'
	       +'</series>'
	       +'<verticalAxisRenderers>'
   			+'<Axis2DRenderer axis="{hAxis}" left="15px;" showLine="false" styleName="axisLabel"/>'
			+'</verticalAxisRenderers>' 
	    +'</Bar2DChart>'
	    +'<Style>'
   		+'.axisLabel{fontSize:11px;colorFill:#ff0000;}'
		+'</Style>'
	+'</rMateChart>';

var layoutStr6 = 
		'<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'
		    +'<Options>'
		    +'<SubCaption text="단위 : ha" textAlign="right" />'
		        +'<Caption text="" />'
		   +'</Options>'
		   +'<NumberFormatter id="numFmt" useThousandsSeparator="true"/>'
		   +'<Bar2DChart showDataTips="true" itemClickJsFunction="chartItemClickHandler2">'
		         +'<horizontalAxis>'
		         	+'<LinearAxis id="vAxis"  formatter="{numFmt}"/>'
		          +'</horizontalAxis>'
		        +'<verticalAxis>'
		           +'<CategoryAxis id="hAxis" categoryField="flower"/>'
		       +'</verticalAxis>'
		          +'<series>'
		             +'<Bar2DSeries labelPosition="outside" xField="ffnowaTot" displayName="재배면적" color="#000000" insideLabelYOffset="-2">'
		             		+'<fills>'
		             		   +'<SolidColor color="#4DC189"/>'
			               +'</fills>'
		                  +'<showDataEffect>'
		                     +'<SeriesInterpolate/>'
		                +'</showDataEffect>'
		            +'</Bar2DSeries>'
		       +'</series>'
		       +'<verticalAxisRenderers>'
	   			+'<Axis2DRenderer axis="{hAxis}" left="15px;" showLine="false" styleName="axisLabel"/>'
				+'</verticalAxisRenderers>' 
		    +'</Bar2DChart>'
		    +'<Style>'
	   		+'.axisLabel{fontSize:11px;colorFill:#ff0000;}'
			+'</Style>'
		+'</rMateChart>';

var layoutStr7 = 
	'<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'
	    +'<Options>'
	    +'<SubCaption text="단위 : 만단" textAlign="right" />'
	        +'<Caption text="" />'
	   +'</Options>'
	   +'<NumberFormatter id="numFmt" useThousandsSeparator="true"/>'
	   +'<Bar2DChart showDataTips="true" itemClickJsFunction="chartItemClickHandler2">'
	         +'<horizontalAxis>'
	         	+'<LinearAxis id="vAxis"  formatter="{numFmt}"/>'
	          +'</horizontalAxis>'
	        +'<verticalAxis>'
	           +'<CategoryAxis id="hAxis" categoryField="flower"/>'
	       +'</verticalAxis>'
	          +'<series>'
	             +'<Bar2DSeries labelPosition="outside" xField="d1c4" displayName="출하량" color="#000000" insideLabelYOffset="-2">'
	             		+'<fills>'
	             		   +'<SolidColor color="#F1B95F"/>'
		               +'</fills>'
	                  +'<showDataEffect>'
	                     +'<SeriesInterpolate/>'
	                +'</showDataEffect>'
	            +'</Bar2DSeries>'
	       +'</series>'
	       +'<verticalAxisRenderers>'
   			+'<Axis2DRenderer axis="{hAxis}" left="15px;" showLine="false" styleName="axisLabel"/>'
			+'</verticalAxisRenderers>' 
	    +'</Bar2DChart>'
	    +'<Style>'
   		+'.axisLabel{fontSize:11px;colorFill:#ff0000;}'
		+'</Style>'
	+'</rMateChart>';
	
var layoutStr8 = 
	'<rMateChart backgroundColor="#FFFFFF" borderStyle="none">'
	    +'<Options>'
	    	+'<SubCaption text="단위 : 억원" textAlign="right" />'
	        +'<Caption text="" />'
	   +'</Options>'
	   +'<NumberFormatter id="numFmt" useThousandsSeparator="true"/>'
	   +'<Bar2DChart showDataTips="true" itemClickJsFunction="chartItemClickHandler2">'
	         +'<horizontalAxis>'
	         	+'<LinearAxis id="vAxis"  formatter="{numFmt}"/>'
	          +'</horizontalAxis>'
	        +'<verticalAxis>'
	           +'<CategoryAxis id="hAxis" categoryField="flower"/>'
	       +'</verticalAxis>'
	          +'<series>'
	             +'<Bar2DSeries labelPosition="outside" xField="d1c7" displayName="출하액" color="#000000" insideLabelYOffset="-2">'
	             		+'<fills>'
	             		   +'<SolidColor color="#715FB9"/>'
		               +'</fills>'
	                  +'<showDataEffect>'
	                     +'<SeriesInterpolate/>'
	                +'</showDataEffect>'
	            +'</Bar2DSeries>'
	       +'</series>'
	       +'<verticalAxisRenderers>'
   			+'<Axis2DRenderer axis="{hAxis}" left="15px;" showLine="false" styleName="axisLabel"/>'
			+'</verticalAxisRenderers>' 
	    +'</Bar2DChart>'
	    +'<Style>'
   		+'.axisLabel{fontSize:11px;colorFill:#ff0000;}'
		+'</Style>'
	+'</rMateChart>';
	
   
	
 
//차트 데이터
var chartData1 = [];
var chartData2 = [];
var chartData3 = [];
var chartData4 = [];
var chartData5 = [];
var chartData6 = [];
var chartData7 = [];
var chartData8 = [];


/*
function rMateChartH5ChangeTheme(theme){
	document.getElementById("chart1").setTheme(theme);
}

function rMateChartH5ChangeTheme(theme){
	document.getElementById("chart2").setTheme(theme);
}*/


function checkData1(data){
	if(data.length <= 0){
		// 데이터가 없을 경우 hasNoData함수를 실행하여 메세지창을 출력한다.
		//document.getElementById("chart1").hasNoData(true);
		// hasNoData(false); - 데이터가 존재하지 않으므로 차트의 기본 구조도 보이지 않아야 한다면 false로 주어 차트 전체의 visible을 false로 설정합니다.
		// hasNoData(true);  - 데이터가 존재하지 않아도 차트의 기본 구조는 보여야 한다면 true로 주어 visible을 true로 설정합니다.
	}
}

function checkData2(data){
	if(data.length <= 0){
		// 데이터가 없을 경우 hasNoData함수를 실행하여 메세지창을 출력한다.
		document.getElementById("chart2").hasNoData(true);
	}
}

function checkData3(data){
	if(data.length <= 0){
		// 데이터가 없을 경우 hasNoData함수를 실행하여 메세지창을 출력한다.
		document.getElementById("chart3").hasNoData(true);
	}
}

function checkData4(data){
	if(data.length <= 0){
		// 데이터가 없을 경우 hasNoData함수를 실행하여 메세지창을 출력한다.
		document.getElementById("chart4").hasNoData(true);
	}
}

function checkData5(data){
	if(data.length <= 0){
		// 데이터가 없을 경우 hasNoData함수를 실행하여 메세지창을 출력한다.
		document.getElementById("chart5").hasNoData(true);
	}
}

function checkData6(data){
	if(data.length <= 0){
		// 데이터가 없을 경우 hasNoData함수를 실행하여 메세지창을 출력한다.
		document.getElementById("chart6").hasNoData(true);
	}
}

function checkData7(data){
	if(data.length <= 0){
		// 데이터가 없을 경우 hasNoData함수를 실행하여 메세지창을 출력한다.
		document.getElementById("chart7").hasNoData(true);
	}
}

function checkData8(data){
	if(data.length <= 0){
		// 데이터가 없을 경우 hasNoData함수를 실행하여 메세지창을 출력한다.
		document.getElementById("chart8").hasNoData(true);
	}
}

function checkData9(data){
	if(data.length <= 0){
		// 데이터가 없을 경우 hasNoData함수를 실행하여 메세지창을 출력한다.
		document.getElementById("chart9").hasNoData(true);
	}
}

function checkData10(data){
	if(data.length <= 0){
		// 데이터가 없을 경우 hasNoData함수를 실행하여 메세지창을 출력한다.
		document.getElementById("chart10").hasNoData(true);
	}
}

function checkData11(data){
	if(data.length <= 0){
		// 데이터가 없을 경우 hasNoData함수를 실행하여 메세지창을 출력한다.
		document.getElementById("chart11").hasNoData(true);
	}
}

function checkData12(data){
	if(data.length <= 0){
		// 데이터가 없을 경우 hasNoData함수를 실행하여 메세지창을 출력한다.
		document.getElementById("chart12").hasNoData(true);
	}
}
function displayCallFunction(){
	/* 
	if(chartData2.length==1){
		$('#chartHolder2 .rMateH5__Column2DChart > canvas:eq(1)').css('left','125px');
	}else if(chartData2.length==2){
		$('#chartHolder2 .rMateH5__Column2DChart > canvas:eq(1)').css('left','62.5px');
	}else if(chartData2.length==3){
		$('#chartHolder2 .rMateH5__Column2DChart > canvas:eq(1)').css('left','41px');
	}else if(chartData2.length==4){
		$('#chartHolder2 .rMateH5__Column2DChart > canvas:eq(1)').css('left','31px');
	}else if(chartData2.length==5){
		$('#chartHolder2 .rMateH5__Column2DChart > canvas:eq(1)').css('left','25px');
	} */
}

function axisLabelFunc(id, value)
{
	return value;
}



//-----------------------차트 설정 끝 -----------------------
var allDataList = [];
var tempDataList = [];
var chartData2List = [];

function fn_chart(stdYear){
	$.ajax({
	    type : 'get',
	    url : "/reseach/mainChart.json",
	    data : {
	    	stdYear : stdYear
	    },
	    dataType : 'json',   	           
	    success : function(res){        
	    	console.log(res);
	    	
    		if (res.mainChulInfoChart.length > 0) {
	    		chartData1 = res.mainChulInfoChart;
	    		chartData2 = res.mainChulInfoChart;
	    		chartData3 = res.mainChulInfoChart;
	    		chartData4 = res.mainChulInfoChart;
	    		rMateChartH5.create("chart1", "chartHolder1", chartVars1, "100%", "100%");
	    		rMateChartH5.create("chart2", "chartHolder2", chartVars2, "100%", "100%");
	    		rMateChartH5.create("chart3", "chartHolder3", chartVars3, "100%", "100%");
	    		rMateChartH5.create("chart4", "chartHolder4", chartVars4, "100%", "100%");
	    	} else {
				var chartNullData = [];
		    	document.getElementById("chart1").setData(chartNullData);
		    	document.getElementById("chart2").setData(chartNullData);
		    	document.getElementById("chart3").setData(chartNullData);
		    	document.getElementById("chart4").setData(chartNullData);
	    	}
	    	
	    	if(res.mainPrdInfoChart.length > 0){
	    		tempDataList = res.mainPrdInfoChart;
	    		chartData5 = [];
	    		chartData6 = [];
	    		chartData7 = [];
	    		chartData8 = [];
	    		
	    		for(var i =0; i<14; i++){
	    			chartData5.push(tempDataList[i]);
	    		}
	    		
	    		chartData5.sort(function(a, b) { // 오름차순
	    		    return a["nongCnt"] - b["nongCnt"];
	    		});
	    		
	    		//재배면적
	    		tempDataList.sort(function(a, b) { // 내림차순
	    		    return b["ffnowaTot"] - a["ffnowaTot"];
	    		});
	    		
	    		for(var i =0; i<14; i++){
	    			chartData6.push(tempDataList[i]);
	    		}
	    		
	    		chartData6.sort(function(a, b) { // 오름차순
	    		    return a["ffnowaTot"] - b["ffnowaTot"];
	    		});
	    		
	    		//출하량 순위
	    		
	    		tempDataList.sort(function(a, b) { // 내림차순
	    		    return b["d1c4"] - a["d1c4"];
	    		});
	    		
	    		for(var i =0; i<14; i++){
	    			chartData7.push(tempDataList[i]);
	    		}
	    		
	    		chartData7.sort(function(a, b) { // 오름차순
	    		    return a["d1c4"] - b["d1c4"];
	    		});
	    		
				//출하액 순위
	    		
	    		tempDataList.sort(function(a, b) { // 내림차순
	    		    return b["d1c7"] - a["d1c7"];
	    		});
	    		
	    		for(var i =0; i<14; i++){
	    			chartData8.push(tempDataList[i]);
	    		}
	    		
	    		chartData8.sort(function(a, b) { // 오름차순
	    		    return a["d1c7"] - b["d1c7"];
	    		});
	    		
	    		
	    		rMateChartH5.create("chart5", "chartHolder5", chartVars5, "100%", "100%");
	    		rMateChartH5.create("chart6", "chartHolder6", chartVars6, "100%", "100%");
	    		rMateChartH5.create("chart7", "chartHolder7", chartVars7, "100%", "100%");
	    		rMateChartH5.create("chart8", "chartHolder8", chartVars8, "100%", "100%");
	    	}else{
				var chartNullData = [];
	    		
		    	document.getElementById("chart5").setData(chartNullData);
		    	document.getElementById("chart6").setData(chartNullData);
		    	document.getElementById("chart7").setData(chartNullData);
		    	document.getElementById("chart8").setData(chartNullData);
	    	}
	    	
	    	
	    },
	});
}

function fn_chart2(stdYear){
	$.ajax({
	    type : 'get',
	    url : "/reseach/mainChart2.json",
	    data : {
	    	stdYear : stdYear
	    },
	    dataType : 'json',   	           
	    success : function(res){        
	    	console.log(res);
	    	
    		if (res.mainChulInfoChart2.length > 0) {
	    		chartData1 = res.mainChulInfoChart2;
	    		chartData2 = res.mainChulInfoChart2;
	    		chartData3 = res.mainChulInfoChart2;
	    		chartData4 = res.mainChulInfoChart2;
	    		rMateChartH5.create("chart1", "chartHolder1", chartVars1, "100%", "100%");
	    		rMateChartH5.create("chart2", "chartHolder2", chartVars2, "100%", "100%");
	    		rMateChartH5.create("chart3", "chartHolder3", chartVars3, "100%", "100%");
	    		rMateChartH5.create("chart4", "chartHolder4", chartVars4, "100%", "100%");
	    	} else {
				var chartNullData = [];
		    	document.getElementById("chart1").setData(chartNullData);
		    	document.getElementById("chart2").setData(chartNullData);
		    	document.getElementById("chart3").setData(chartNullData);
		    	document.getElementById("chart4").setData(chartNullData);
	    	}
    		
	    	if(res.mainPrdInfoChart2.length > 0){
	    		tempDataList = res.mainPrdInfoChart2;
	    		chartData5 = [];
	    		chartData6 = [];
	    		chartData7 = [];
	    		chartData8 = [];
	    		
	    		for(var i =0; i<14; i++){
	    			chartData5.push(tempDataList[i]);
	    		}
	    		
	    		chartData5.sort(function(a, b) { // 오름차순
	    		    return a["nongCnt"] - b["nongCnt"];
	    		});
	    		
	    		//재배면적
	    		tempDataList.sort(function(a, b) { // 내림차순
	    		    return b["ffnowaTot"] - a["ffnowaTot"];
	    		});
	    		
	    		for(var i =0; i<14; i++){
	    			chartData6.push(tempDataList[i]);
	    		}
	    		
	    		chartData6.sort(function(a, b) { // 오름차순
	    		    return a["ffnowaTot"] - b["ffnowaTot"];
	    		});
	    		
	    		//출하량 순위
	    		
	    		tempDataList.sort(function(a, b) { // 내림차순
	    		    return b["d1c4"] - a["d1c4"];
	    		});
	    		
	    		for(var i =0; i<14; i++){
	    			chartData7.push(tempDataList[i]);
	    		}
	    		
	    		chartData7.sort(function(a, b) { // 오름차순
	    		    return a["d1c4"] - b["d1c4"];
	    		});
	    		
				//출하액 순위
	    		
	    		tempDataList.sort(function(a, b) { // 내림차순
	    		    return b["d1c7"] - a["d1c7"];
	    		});
	    		
	    		for(var i =0; i<14; i++){
	    			chartData8.push(tempDataList[i]);
	    		}
	    		
	    		chartData8.sort(function(a, b) { // 오름차순
	    		    return a["d1c7"] - b["d1c7"];
	    		});
	    		
	    		
	    		rMateChartH5.create("chart5", "chartHolder5", chartVars5, "100%", "100%");
	    		rMateChartH5.create("chart6", "chartHolder6", chartVars6, "100%", "100%");
	    		rMateChartH5.create("chart7", "chartHolder7", chartVars7, "100%", "100%");
	    		rMateChartH5.create("chart8", "chartHolder8", chartVars8, "100%", "100%");
	    	}else{
				var chartNullData = [];
	    		
		    	document.getElementById("chart5").setData(chartNullData);
		    	document.getElementById("chart6").setData(chartNullData);
		    	document.getElementById("chart7").setData(chartNullData);
		    	document.getElementById("chart8").setData(chartNullData);
	    	}
	    	    		
	    },
	});
}

function fh_chulInfoAll(stdYear){
	
	$.ajax({
	    type : 'get',
	    url : "/reseach/chulInfo.json",
	    data : {
	    	stdYear : stdYear
	    },
	    dataType : 'json',   	           
	    success : function(res){        
	    	
	    	var resultList = res.chulInfoList;
	    	var chulCnt = 0;
	    	var prdArea = 0;
	    	var yearQty = 0;
	    	var yearAmt = 0;
	    	
	    	if(resultList.length > 0){
	    		for(var i=0; i<resultList.length; i++){
	    			chulCnt = chulCnt+resultList[i].chulCnt;
	    			prdArea = prdArea+resultList[i].prdArea;
	    			yearQty = yearQty+resultList[i].yearQty;
	    			yearAmt = yearAmt+resultList[i].yearAmt;
	    		}
	    	}
	    	
	    	$("#mainChulCnt").html(comma(chulCnt) + "호");
	    	$("#mainPrdArea").html(comma(prdArea) + "ha");
	    	$("#mainYearChulQty").html(comma(yearQty) + "만단");
	    	$("#mainYearChulAmt").html(comma(yearAmt) + "억원");
	    	
	    	
	    },
	});
}


function fh_chulInfoAll2(stdYear){
	
	$.ajax({
	    type : 'get',
	    url : "/reseach/chulInfo2.json",
	    data : {
	    	stdYear : stdYear
	    },
	    dataType : 'json',   	           
	    success : function(res){        
	    	
	    	var resultList = res.chulInfoList2;
	    	var chulCnt = 0;
	    	var prdArea = 0;
	    	var yearQty = 0;
	    	var yearAmt = 0;
	    	
	    	if(resultList.length > 0){
	    		for(var i=0; i<resultList.length; i++){
	    			chulCnt = chulCnt+resultList[i].chulCnt;
	    			prdArea = prdArea+resultList[i].prdArea;
	    			yearQty = yearQty+resultList[i].yearQty;
	    			yearAmt = yearAmt+resultList[i].yearAmt;
	    		}
	    	}
	    	
	    	$("#mainChulCnt").html(comma(chulCnt) + "호");
	    	$("#mainPrdArea").html(comma(prdArea) + "ha");
	    	$("#mainYearChulQty").html(comma(yearQty) + "만단");
	    	$("#mainYearChulAmt").html(comma(yearAmt) + "억원");
	    	
	    	
	    },
	});
}

function fn_printDiv(id){
	$(".btn_down_image").css("display","none");
	var fileName = $(".main_title").text();
	var div = $("#"+id).get(0);
	
	html2canvas(div).then(function(canvas){
		var myImage = canvas.toDataURL();
		$(".btn_down_image").css("display","");
		downloadURI(myImage, fileName+".png");	
	});
}

function downloadURI(uri, name){
	var link = document.createElement("a")
	link.download = name;
	link.href = uri;
	document.body.appendChild(link);
	link.click();
}


</script>	

</head>

<body> 
	<!-- warp(S) -->
	<div class="wrap">
		<!-- header(S) -->
		<div class="header">
			<div class="header_in">
				<a href="/research/main.do" class="btn_home">HOME</a>
				<ul class="menu">
					<li><a href="/research/chulInfo.do" class="btn_menu">농가현황</a></li>
					<li><a href="/research/prodInfo.do" class="btn_menu">재배현황</a></li>
					<li><a href="/research/dataUpload.do" class="btn_menu">데이터관리</a></li>
				</ul>
				<a href="/login/logoutProc.do" class="btn_logout">로그아웃</a>
			</div>
		</div>
		<!-- header(E) -->

		<!-- sub-conts(S) -->
		<div class="content">
			<div class="content_in" id="printDiv">

				<!-- main title(S) -->
				<h2 class="main_title">생산조사 현황</h2>
				<!-- main title(E) -->
				
				<!-- title(S) -->
				<div class="search_pack mt70">
					<!-- search box(S) -->
					<div class="search_box col5">
						<dl>
							<dt><p class="tit_tag">종류</p></dt>
							<dd>
								<div class="select_type_01">
									<select name="kind" id="kind" onchange="fn_stdKindChange();">
										<option value="절화" id="kind">절화</option>
										<option value="난" id="kind">난</option>
									</select>
									<label for="stdMonth"></label>
								</div>
							</dd>
						</dl>
						<dl>
							<dt><p class="tit_tag">년도</p></dt>
							<dd>
								<div class="select_type_01">
									<select name="stdYear" id="stdYear" onchange="fn_stdYearChange();">
										<c:forEach begin="2019" end="2030" var="year">
											<option value="${year}" <c:if test="${paramMap.stdYear eq year}">selected="selected"</c:if>>${year}</option>
										</c:forEach>
									</select>
									<label for="stdYear"></label>
								</div>
							</dd>
						</dl>
						<!-- image button(S) -->
						<a href="javascript:fn_printDiv('printDiv');" class="btn_down_image">이미지</a>
						<!-- image button(E) -->
					</div>
				</div>
				
				
				<div class="title_box mt20 tit_sel">
				
				
		
				<!-- title(E) -->
				
				

				<!-- total data(S) -->
				<div class="img_capture mt30">
					<div class="total_data col4">
						<ul>
							<li>
							 	<h4 class="td_tit td01">재배 농가수</h4>
								<p class="data_num" id="mainChulCnt">0호</p>
							</li>
							<li>
								<h4 class="td_tit td02">재배 면적</h4>
								<p class="data_num" id="mainPrdArea">0 ha</p>
							</li>
							<li>
								<h4 class="td_tit td03">연간 출하량</h4>
								<p class="data_num" id="mainYearChulQty">0 만단</p>
							</li>
							<li>
								<h4 class="td_tit td04">연간 출하액</h4>
								<p class="data_num" id="mainYearChulAmt">0억원</p>
							</li>
						</ul>
					</div>
					<!-- total data(E) -->
					
					<!-- graph(S) -->
					<div class="graph_box">
						<div class="col_wrap col2">
							<div class="cola">
								<h4 class="tit_01">재배면적별 재배농가수</h4>
								<div class="g_area">
									<div id="chartHolder1" style="width:100%;height:100%;"></div>
								</div>
							</div>
							<div class="colb">
								<h4 class="tit_01">재배면적별 연간 출하량</h4>
								<div class="g_area">
									<div id="chartHolder2" style="width:100%;height:100%;"></div>
								</div>
							</div>
						</div>
						<div class="col_wrap col2">
							<div class="cola">
								<h4 class="tit_01">재배면적별 자가 임차 비율</h4>
								<div class="g_area">
									<div id="chartHolder3" style="width:100%;height:100%;"></div>
								</div>
							</div>
							<div class="colb">
								<h4 class="tit_01">재배면적별 연간 출하액</h4>
								<div class="g_area">
									<div id="chartHolder4" style="width:100%;height:100%;"></div>
								</div>
							</div>
						</div>
						<div class="col_wrap col2">
							<div class="cola">
								<h4 class="tit_01">주요 품목별 재배농가수 <span style="font-size: 12px;">(상위 14개 품목 기준)</span></h4>
								<div class="g_area" style="height:500px;">
									<div id="chartHolder5" style="width:100%;height:100%;"></div>
								</div>
							</div>
							<div class="colb">
								<h4 class="tit_01">주요 품목별 재배면적 <span style="font-size: 12px;">(상위 14개 품목 기준)</span></h4>
								<div class="g_area" style="height:500px;">
									<div id="chartHolder6" style="width:100%;height:100%;"></div>
								</div>
							</div>
						</div>
						<div class="col_wrap col2">
							<div class="cola">
								<h4 class="tit_01">주요 품목별 출하량 <span style="font-size: 12px;">(상위 14개 품목 기준)</span></h4>
								<div class="g_area" style="height:500px;">
									<div id="chartHolder7" style="width:100%;height:100%;"></div>
								</div>
							</div>
							<div class="colb">
								<h4 class="tit_01">주요 품목별 출하액 <span style="font-size: 12px;">(상위 14개 품목 기준)</span></h4>
								<div class="g_area" style="height:500px;">
									<div id="chartHolder8" style="width:100%;height:100%;"></div>
								</div>
							</div>
						</div>
					</div>
					<!-- graph(E) -->
				</div>
				
			</div>
		</div>
		<!-- sub-conts(E) -->
	</div>
	<!-- wrap(E) -->		


</body>
</html>


