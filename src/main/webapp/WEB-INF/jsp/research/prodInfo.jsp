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

<title>재배현황</title>
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
	$(".main_title").html($("#stdYear").prop("value") + "년 재배현황");
	fn_flowerList();
});

function searchBtn(){
	var stdKind = $("#kind").prop("value");
	
	$(".main_title").html($("#stdYear").prop("value") + "년 재배현황");
	
	if (stdKind == '절화') {
		fn_flowerList();
	} else {
		fn_flowerList2();
	}	
}


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


function fn_flowerList(){
	
	var stdYear = $("#stdYear").prop("value");
	
	$.ajax({
	    type : 'get',
	    url : "/reseach/pumMokList.json",
	    data : {
	    	stdYear : stdYear
	    },
	    dataType : 'json',   	           
	    success : function(res){        
	    	$("#flower").html("<option value=\"\" id=\"sigun0\">전체</option>");
	    	var html = "";
	    	var resultList = res.resultList;
	    	for(var i=0; i<resultList.length; i++){
	    		html += "<option value=\""+resultList[i].flower+"\" id=\"flower"+resultList[i].flower+"\">"+resultList[i].flower+"</option>";
	    	}
	    	$("#flower").append(html);
	    	var flowerParam = $("#flowerParam").val();
	    	if(flowerParam != null && flowerParam != ""){
	    		$("#flower").prop("value",flowerParam);
	    	}
	    	
	    	fn_search();
	    },
	});
}

function fn_flowerList2(){
	
	var stdYear = $("#stdYear").prop("value");
	
	$.ajax({
	    type : 'get',
	    url : "/reseach/pumMokList2.json",
	    data : {
	    	stdYear : stdYear
	    },
	    dataType : 'json',   	           
	    success : function(res){        
	    	$("#flower").html("<option value=\"\" id=\"sigun0\">전체</option>");
	    	var html = "";
	    	var resultList = res.resultList;
	    	for(var i=0; i<resultList.length; i++){
	    		html += "<option value=\""+resultList[i].flower+"\" id=\"flower"+resultList[i].flower+"\">"+resultList[i].flower+"</option>";
	    	}
	    	$("#flower").append(html);
	    	var flowerParam = $("#flowerParam").val();
	    	if(flowerParam != null && flowerParam != ""){
	    		$("#flower").prop("value",flowerParam);
	    	}
	    	
	    	fn_search();
	    },
	});
}

function fn_flowerChange(){
	fn_search();
}

function fn_stdYearChange(){
	
	$(".main_title").html($("#stdYear").prop("value") + "년 재배현황");
	$("#sidoCode").prop("value","");
	$("#sigunCode").html("<option value=\"\" id=\"sigun0\">전체</option>");
	fn_flowerList();
	
}


function fn_sidoChange(){
	var sidoCode = $("#sidoCode option:selected").attr("data-code");
	var areaCode = $("#sidoCode").prop("value");
	var stdYear = $("#stdYear").prop("value");
	var stdMonth = $("#stdMonth").prop("value");
	
	if(areaCode==""){
		$("#sigunCode").html("<option value=\"\" id=\"sigun0\">전체</option>");
		fn_search();
	}else{
		fn_sigunList();
	}
}



function fn_sigunChange(){
	var areaCode = $("#sigunCode").prop("value");
	
	if(areaCode == ""){
		//mapRoot.setSelectedCode("");
		
		
		
	}else{
		//mapRoot.setSelectedCode(areaCode);	
	}
	
	fn_search();
	
}

function fn_stdMonthChange(){
	
	fn_search();
	
}

function fn_sigunList(){
	
	var areaCode = $("#sidoCode").prop("value");
	
	$.ajax({
	    type : 'get',
	    url : "/reseach/sigunCode.json",
	    data : {
	    	areaCode : areaCode
	    },
	    dataType : 'json',   	           
	    success : function(res){        
	    	$("#sigunCode").html("<option value=\"\" id=\"sigun0\">전체</option>");
	    	var html = "";
	    	var sigunList = res.sigunList;
	    	for(var i=0; i<sigunList.length; i++){
	    		html += "<option value=\""+sigunList[i].areaCode+"\" id=\"sigun"+sigunList[i].areaCode+"\" data-code=\""+sigunList[i].agCode+"\">"+sigunList[i].searchKorName+"</option>";
	    	}
	    	$("#sigunCode").append(html);
	    	
	    	fn_search();
	    },
	});
}

function fn_search(type){
	var stdYear = $("#stdYear").prop("value");
	var sidoCode = $("#sidoCode option:selected").attr("data-code");
	var sigunCode = $("#sigunCode option:selected").attr("data-code");
	var stdMonth = $("#stdMonth").prop("value");
	var flower = $("#flower").prop("value");
	var stdKind = $("#kind").prop("value");
	
	if (stdKind == '절화') {
		fn_chart(stdYear, flower, sidoCode, sigunCode, stdMonth, type);
	} else {
		fn_chart2(stdYear, flower, sidoCode, sigunCode, stdMonth, type);
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
var chartVars9 = "rMateOnLoadCallFunction=chartReadyHandler9";
var chartVars10 = "rMateOnLoadCallFunction=chartReadyHandler10";
var chartVars11 = "rMateOnLoadCallFunction=chartReadyHandler11";
var chartVars12 = "rMateOnLoadCallFunction=chartReadyHandler12";


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

//스트링 형식으로 레이아웃 정의.
var layoutStr1 = 
	'<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'
	    +'<Options>'
	     +'<SubCaption text="ha" textAlign="left" />'
	     +'<Legend defaultMouseOverAction="false" useVisibleCheck="true"/>'
	    +'</Options>'
	    +'<NumberFormatter id="numFmt" useThousandsSeparator="true"/>'
	   +'<Column2DChart showDataTips="true" columnWidthRatio="0.5" selectionMode="single" displayCompleteCallFunction="displayCallFunction" dataTipJsFunction="dataTipFunc" >'
	       +'<horizontalAxis>'
	       	+'<CategoryAxis  id="hAxis" categoryField="cateName" padding="0.4"/>'
	        +'</horizontalAxis>'
	        +'<verticalAxis>'
	           +'<LinearAxis id="vAxis"  formatter="{numFmt}"/>'
	       +'</verticalAxis>'
	          +'<series>'
	          +'<Column2DSeries yField="ffnowaTot" displayName="재배면적" halfWidthOffset="0" labelPosition="outside">'
	          		+'<fill>'
		            	+'<SolidColor color="#536BC9" alpha="1"/>'
		            +'</fill>'
                    +'<showDataEffect>'
	                  +'<SeriesInterpolate/>'
	                +'</showDataEffect>'
		            +'</Column2DSeries>'
		            +'<Column2DSeries yField="d1c4" displayName="지역별 출하량" halfWidthOffset="0" labelPosition="outside">'
	          		+'<fill>'
		            	+'<SolidColor color="#4DC189" alpha="1"/>'
		            +'</fill>'
	                +'<showDataEffect>'
	                  +'<SeriesInterpolate/>'
	                +'</showDataEffect>'
		            +'</Column2DSeries>'
	        +'</series>'
	        +'<horizontalAxisRenderers>'
            +'<Axis2DRenderer axis="{hAxis}" minorTickLength="0" tickPlacement="outside" minorTickPlacement="cross" placement="bottom" canDropLabels="true" showLabels="true" showLine="true" labelAlign="center" styleName="axisLabel" labelRotation="0">'
                 +'<axisStroke>'
                      +'<Stroke weight="10" color="#f4f4f4"/>'
                 +'</axisStroke>'
            +'</Axis2DRenderer>'
         +'</horizontalAxisRenderers>'
	     	+'<verticalAxisRenderers>'
        		+'<Axis2DRenderer axis="{vAxis}" left="15px;" showLine="false"/>'
    		+'</verticalAxisRenderers>' 
	    +'</Column2DChart>'
	    +'<Style>'
		   	+'.axisLabel{fontSize:11px;colorFill:#ff0000;}'
		+'</Style>'
	 +'</rMateChart>';
	
var layoutStr2 = 
	'<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'
	    +'<Options>'
	     +'<SubCaption text="만단" textAlign="left" />'
	     +'<Legend defaultMouseOverAction="false" useVisibleCheck="true"/>'
	    +'</Options>'
	    +'<NumberFormatter id="numFmt" useThousandsSeparator="true"/>'
	   +'<Column2DChart showDataTips="true" columnWidthRatio="0.5" selectionMode="single" displayCompleteCallFunction="displayCallFunction" dataTipJsFunction="dataTipFunc" >'
	       +'<horizontalAxis>'
	       	+'<CategoryAxis  id="hAxis" categoryField="cateName" padding="0.4"/>'
	        +'</horizontalAxis>'
	        +'<verticalAxis>'
	           +'<LinearAxis id="vAxis"  formatter="{numFmt}"/>'
	       +'</verticalAxis>'
	          +'<series>'
	          +'<Column2DSeries yField="d1c4" displayName="지역별 출하량" halfWidthOffset="0" labelPosition="outside">'
	          		+'<fill>'
		            	+'<SolidColor color="#4DC189" alpha="1"/>'
		            +'</fill>'
	                +'<showDataEffect>'
	                  +'<SeriesInterpolate/>'
	                +'</showDataEffect>'
		            +'</Column2DSeries>'
	        +'</series>'
	        +'<horizontalAxisRenderers>'
	        +'<Axis2DRenderer axis="{hAxis}" minorTickLength="0" tickPlacement="outside" minorTickPlacement="cross" placement="bottom" canDropLabels="true" showLabels="true" showLine="true" labelAlign="center" styleName="axisLabel" labelRotation="0">'
	             +'<axisStroke>'
	                  +'<Stroke weight="10" color="#f4f4f4"/>'
	             +'</axisStroke>'
	        +'</Axis2DRenderer>'
	     +'</horizontalAxisRenderers>'
	     	+'<verticalAxisRenderers>'
	    		+'<Axis2DRenderer axis="{vAxis}" left="15px;" showLine="false"/>'
			+'</verticalAxisRenderers>' 
	    +'</Column2DChart>'
	    +'<Style>'
		   	+'.axisLabel{fontSize:11px;colorFill:#ff0000;}'
		+'</Style>'
	 +'</rMateChart>';
           
var layoutStr3 = 
	'<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'
	    +'<Options>'
	     +'<SubCaption text="%" textAlign="left" />'
	     +'<Legend defaultMouseOverAction="false" useVisibleCheck="true"/>'
	    +'</Options>'
	    +'<NumberFormatter id="numFmt" useThousandsSeparator="true"/>'
	   +'<Column2DChart showDataTips="true" columnWidthRatio="0.5" selectionMode="single" displayCompleteCallFunction="displayCallFunction" dataTipJsFunction="dataTipFunc" >'
	       +'<horizontalAxis>'
	       	+'<CategoryAxis  id="hAxis" categoryField="cateName" padding="0.4"/>'
	        +'</horizontalAxis>'
	        +'<verticalAxis>'
	           +'<LinearAxis id="vAxis"  formatter="{numFmt}"/>'
	       +'</verticalAxis>'
	          +'<series>'
	          +'<Column2DSeries yField="val" displayName="월별 출하량 비중" halfWidthOffset="0" labelPosition="outside">'
	          		+'<fill>'
		            	+'<SolidColor color="#F1B95F" alpha="1"/>'
		            +'</fill>'
	                +'<showDataEffect>'
	                  +'<SeriesInterpolate/>'
	                +'</showDataEffect>'
		            +'</Column2DSeries>'
	        +'</series>'
	        +'<horizontalAxisRenderers>'
	        +'<Axis2DRenderer axis="{hAxis}" minorTickLength="0" tickPlacement="outside" minorTickPlacement="cross" placement="bottom" canDropLabels="true" showLabels="true" showLine="true" labelAlign="center" styleName="axisLabel" labelRotation="0">'
	             +'<axisStroke>'
	                  +'<Stroke weight="10" color="#f4f4f4"/>'
	             +'</axisStroke>'
	        +'</Axis2DRenderer>'
	     +'</horizontalAxisRenderers>'
	     	+'<verticalAxisRenderers>'
	    		+'<Axis2DRenderer axis="{vAxis}" left="15px;" showLine="false"/>'
			+'</verticalAxisRenderers>' 
	    +'</Column2DChart>'
	    +'<Style>'
		   	+'.axisLabel{fontSize:11px;colorFill:#ff0000;}'
		+'</Style>'
	 +'</rMateChart>';
 
              
var layoutStr4 = 
	'<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'
    +'<Options>'
     +'<SubCaption text="%" textAlign="left" />'
     +'<Legend defaultMouseOverAction="false" useVisibleCheck="true"/>'
    +'</Options>'
    +'<NumberFormatter id="numFmt" useThousandsSeparator="true"/>'
   +'<Column2DChart showDataTips="true" columnWidthRatio="0.5" selectionMode="single" displayCompleteCallFunction="displayCallFunction" dataTipJsFunction="dataTipFunc" >'
       +'<horizontalAxis>'
       	+'<CategoryAxis  id="hAxis" categoryField="cateName" padding="0.4"/>'
        +'</horizontalAxis>'
        +'<verticalAxis>'
           +'<LinearAxis id="vAxis"  formatter="{numFmt}"/>'
       +'</verticalAxis>'
          +'<series>'
          +'<Column2DSeries yField="val" displayName="출하처별 출하량 비중" halfWidthOffset="0" labelPosition="outside">'
          		+'<fill>'
	            	+'<SolidColor color="#715FB9" alpha="1"/>'
	            +'</fill>'
                +'<showDataEffect>'
                  +'<SeriesInterpolate/>'
                +'</showDataEffect>'
	            +'</Column2DSeries>'
        +'</series>'
        +'<horizontalAxisRenderers>'
        +'<Axis2DRenderer axis="{hAxis}" minorTickLength="0" tickPlacement="outside" minorTickPlacement="cross" placement="bottom" canDropLabels="true" showLabels="true" showLine="true" labelAlign="center" styleName="axisLabel" labelRotation="0">'
             +'<axisStroke>'
                  +'<Stroke weight="10" color="#f4f4f4"/>'
             +'</axisStroke>'
        +'</Axis2DRenderer>'
     +'</horizontalAxisRenderers>'
     	+'<verticalAxisRenderers>'
    		+'<Axis2DRenderer axis="{vAxis}" left="15px;" showLine="false"/>'
		+'</verticalAxisRenderers>' 
    +'</Column2DChart>'
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
var chartData9 = [];
var chartData10 = [];
var chartData11 = [];
var chartData12 = [];


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
var sidoDataList = [];
var chartData2List = [];

function fn_chart(stdYear, flower, sidoCode, sigunCode, stdMonth, type){
	
	
	$.ajax({
	    type : 'get',
	    url : "/reseach/prodInfoChart.json",
	    data : {
	    	stdYear : stdYear,
	    	flower : flower,
	    	sidoCode : sidoCode,
	    	agCode : sigunCode,
	    	stdMonth : stdMonth
	    },
	    dataType : 'json',   	           
	    success : function(res){        
	    	console.log(res);
	    	
	    	if(res.prodAreaList.length > 0){
	    		// 1번차트 조건
	    		if(sigunCode == "" || sigunCode == null){
	    			
	    			$("#tit01").html("지역별 재배면적 / 출하량");
	    			chartData1 = res.prodAreaList;
			    	
			    	chartData2 = [{
			            "cateName" : "1월",
			            "val" : res.prodList[0].e1s01
				    },{
				    	"cateName" : "2월",
				    	"val" : res.prodList[0].e1s02
				    },{
				    	"cateName" : "3월",
				    	"val" : res.prodList[0].e1s03
			    	},{
				    	"cateName" : "4월",
				    	"val" : res.prodList[0].e1s04
			    	},{
				    	"cateName" : "5월",
				    	"val" : res.prodList[0].e1s05
			    	},{
				    	"cateName" : "6월",
				    	"val" : res.prodList[0].e1s06
			    	},{
				    	"cateName" : "7월",
				    	"val" : res.prodList[0].e1s07
			    	},{
				    	"cateName" : "8월",
				    	"val" : res.prodList[0].e1s08
			    	},{
				    	"cateName" : "9월",
				    	"val" : res.prodList[0].e1s09
			    	},{
				    	"cateName" : "10월",
				    	"val" : res.prodList[0].e1s10
			    	},{
				    	"cateName" : "11월",
				    	"val" : res.prodList[0].e1s11
			    	},{
				    	"cateName" : "12월",
				    	"val" : res.prodList[0].e1s12
			    	}];
			    	
			    	layoutStr1 =
				    	'<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'
					    +'<Options>'
					     +'<SubCaption text="ha/만단" textAlign="left" />'
					     +'<Legend defaultMouseOverAction="false" useVisibleCheck="true"/>'
					    +'</Options>'
					    +'<NumberFormatter id="numFmt" useThousandsSeparator="true"/>'
					   +'<Column2DChart showDataTips="true" columnWidthRatio="0.5" selectionMode="single" displayCompleteCallFunction="displayCallFunction" dataTipJsFunction="dataTipFunc" >'
					       +'<horizontalAxis>'
					       	+'<CategoryAxis  id="hAxis" categoryField="cateName" padding="0.4"/>'
					        +'</horizontalAxis>'
					        +'<verticalAxis>'
					           +'<LinearAxis id="vAxis"  formatter="{numFmt}"/>'
					       +'</verticalAxis>'
					          +'<series>'
					          +'<Column2DSeries yField="ffnowaTot" displayName="재배면적" halfWidthOffset="3" labelPosition="outside">'
					          		+'<fill>'
						            	+'<SolidColor color="#536BC9" alpha="1"/>'
						            +'</fill>'
				                    +'<showDataEffect>'
					                  +'<SeriesInterpolate/>'
					                +'</showDataEffect>'
						            +'</Column2DSeries>'
					            +'<Column2DSeries yField="d1c4" displayName="출하량" halfWidthOffset="3" labelPosition="outside">'
				          		+'<fill>'
					            	+'<SolidColor color="#4DC189" alpha="1"/>'
					            +'</fill>'
				                +'<showDataEffect>'
				                  +'<SeriesInterpolate/>'
				                +'</showDataEffect>'
					            +'</Column2DSeries>'
					        +'</series>'
					        +'<horizontalAxisRenderers>'
				            +'<Axis2DRenderer axis="{hAxis}" minorTickLength="0" tickPlacement="outside" minorTickPlacement="cross" placement="bottom" canDropLabels="true" showLabels="true" showLine="true" labelAlign="center" styleName="axisLabel" labelRotation="0">'
				                 +'<axisStroke>'
				                      +'<Stroke weight="10" color="#f4f4f4"/>'
				                 +'</axisStroke>'
				            +'</Axis2DRenderer>'
				         +'</horizontalAxisRenderers>'
					     	+'<verticalAxisRenderers>'
				        		+'<Axis2DRenderer axis="{vAxis}" left="15px;" showLine="false"/>'
				    		+'</verticalAxisRenderers>' 
					    +'</Column2DChart>'
					    +'<Style>'
						   	+'.axisLabel{fontSize:11px;colorFill:#ff0000;}'
						+'</Style>'
					 +'</rMateChart>';
					
	    		}else{
	    			
	    			$("#tit01").html("월별 실질 재배면적");
	    			
	    			chartData1 = [{
			            "cateName" : "1월",
			            "val" : res.prodAreaList[0].ffnowa01
				    },{
				    	"cateName" : "2월",
				    	"val" : res.prodAreaList[0].ffnowa02
				    },{
				    	"cateName" : "3월",
				    	"val" : res.prodAreaList[0].ffnowa03
			    	},{
				    	"cateName" : "4월",
				    	"val" : res.prodAreaList[0].ffnowa04
			    	},{
				    	"cateName" : "5월",
				    	"val" : res.prodAreaList[0].ffnowa05
			    	},{
				    	"cateName" : "6월",
				    	"val" : res.prodAreaList[0].ffnowa06
			    	},{
				    	"cateName" : "7월",
				    	"val" : res.prodAreaList[0].ffnowa07
			    	},{
				    	"cateName" : "8월",
				    	"val" : res.prodAreaList[0].ffnowa08
			    	},{
				    	"cateName" : "9월",
				    	"val" : res.prodAreaList[0].ffnowa09
			    	},{
				    	"cateName" : "10월",
				    	"val" : res.prodAreaList[0].ffnowa10
			    	},{
				    	"cateName" : "11월",
				    	"val" : res.prodAreaList[0].ffnowa11
			    	},{
				    	"cateName" : "12월",
				    	"val" : res.prodAreaList[0].ffnowa12
			    	}];
	    			
	    			
	    			layoutStr1 = 
	    				'<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'
	    				    +'<Options>'
	    				     +'<SubCaption text="ha" textAlign="left" />'
	    				     +'<Legend defaultMouseOverAction="false" useVisibleCheck="true"/>'
	    				    +'</Options>'
	    				    +'<NumberFormatter id="numFmt" useThousandsSeparator="true"/>'
	    				   +'<Column2DChart showDataTips="true" columnWidthRatio="0.5" selectionMode="single" displayCompleteCallFunction="displayCallFunction" dataTipJsFunction="dataTipFunc" >'
	    				       +'<horizontalAxis>'
	    				       	+'<CategoryAxis  id="hAxis" categoryField="cateName" padding="0.4"/>'
	    				        +'</horizontalAxis>'
	    				        +'<verticalAxis>'
	    				           +'<LinearAxis id="vAxis"  formatter="{numFmt}"/>'
	    				       +'</verticalAxis>'
	    				          +'<series>'
	    				          +'<Column2DSeries yField="val" displayName="월별 재배면적" halfWidthOffset="0" labelPosition="outside">'
	    				          		+'<fill>'
	    					            	+'<SolidColor color="#536BC9" alpha="1"/>'
	    					            +'</fill>'
	    				                +'<showDataEffect>'
	    				                  +'<SeriesInterpolate/>'
	    				                +'</showDataEffect>'
	    					            +'</Column2DSeries>'
	    				        +'</series>'
	    				        +'<horizontalAxisRenderers>'
	    				        +'<Axis2DRenderer axis="{hAxis}" minorTickLength="0" tickPlacement="outside" minorTickPlacement="cross" placement="bottom" canDropLabels="true" showLabels="true" showLine="true" labelAlign="center" styleName="axisLabel" labelRotation="0">'
	    				             +'<axisStroke>'
	    				                  +'<Stroke weight="10" color="#f4f4f4"/>'
	    				             +'</axisStroke>'
	    				        +'</Axis2DRenderer>'
	    				     +'</horizontalAxisRenderers>'
	    				     	+'<verticalAxisRenderers>'
	    				    		+'<Axis2DRenderer axis="{vAxis}" left="15px;" showLine="false"/>'
	    						+'</verticalAxisRenderers>' 
	    				    +'</Column2DChart>'
	    				    +'<Style>'
	    					   	+'.axisLabel{fontSize:11px;colorFill:#ff0000;}'
	    					+'</Style>'
	    				 +'</rMateChart>';	    				 
	    			
	    		}
	    		
	    		// 2번차트 조건
	    		var sidoName = $("#sidoCode option:selected").text();
	    		var sigunName = $("#sigunCode option:selected").text();
	    		
	    		//flower, sidoCode, sigunCode, stdMonth
	    		if((sidoCode == "" || sidoCode ==null) && (sigunCode =="" || sigunCode ==null)){
	    			allDataList = res.prodList[0];
	    			chartData2List = allDataList;
	    			layoutStr2 = 
	    				'<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'
	    				    +'<Options>'
	    				     +'<SubCaption text="만단" textAlign="left" />'
	    				     +'<Legend defaultMouseOverAction="false" useVisibleCheck="true"/>'
	    				    +'</Options>'
	    				    +'<NumberFormatter id="numFmt" useThousandsSeparator="true"/>'
	    				   +'<Column2DChart showDataTips="true" columnWidthRatio="0.5" selectionMode="single" displayCompleteCallFunction="displayCallFunction" dataTipJsFunction="dataTipFunc" >'
	    				       +'<horizontalAxis>'
	    				       	+'<CategoryAxis  id="hAxis" categoryField="cateName" padding="0.4"/>'
	    				        +'</horizontalAxis>'
	    				        +'<verticalAxis>'
	    				           +'<LinearAxis id="vAxis"  formatter="{numFmt}"/>'
	    				       +'</verticalAxis>'
	    				          +'<series>'
	    				          +'<Column2DSeries yField="val" displayName="'+sidoName+' 월별 출하량" halfWidthOffset="5" labelPosition="outside">'
	   				          		+'<fill>'
	   					            	+'<SolidColor color="#F1B95F" alpha="1"/>'
	   					            +'</fill>'
	   				                +'<showDataEffect>'
	   				                  +'<SeriesInterpolate/>'
	   				                +'</showDataEffect>'
	   					            +'</Column2DSeries>'
	    				        +'</series>'
	    				        +'<horizontalAxisRenderers>'
	    				        +'<Axis2DRenderer axis="{hAxis}" minorTickLength="0" tickPlacement="outside" minorTickPlacement="cross" placement="bottom" canDropLabels="true" showLabels="true" showLine="true" labelAlign="center" styleName="axisLabel" labelRotation="0">'
	    				             +'<axisStroke>'
	    				                  +'<Stroke weight="10" color="#f4f4f4"/>'
	    				             +'</axisStroke>'
	    				        +'</Axis2DRenderer>'
	    				     +'</horizontalAxisRenderers>'
	    				     	+'<verticalAxisRenderers>'
	    				    		+'<Axis2DRenderer axis="{vAxis}" left="15px;" showLine="false"/>'
	    						+'</verticalAxisRenderers>' 
	    				    +'</Column2DChart>'
	    				    +'<Style>'
	    					   	+'.axisLabel{fontSize:11px;colorFill:#ff0000;}'
	    					+'</Style>'
	    				 +'</rMateChart>'; 
	    		}else{
	    			if(sigunCode =="" || sigunCode ==null){
			    		sidoDataList = res.prodList[0];
			    		chartData2List = allDataList; 
	    				layoutStr2 = 
		    				'<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'
		    				    +'<Options>'
		    				     +'<SubCaption text="만단" textAlign="left" />'
		    				     +'<Legend defaultMouseOverAction="false" useVisibleCheck="true"/>'
		    				    +'</Options>'
		    				    +'<NumberFormatter id="numFmt" useThousandsSeparator="true"/>'
		    				   +'<Column2DChart showDataTips="true" columnWidthRatio="0.5" selectionMode="single" displayCompleteCallFunction="displayCallFunction" dataTipJsFunction="dataTipFunc" >'
		    				       +'<horizontalAxis>'
		    				       	+'<CategoryAxis  id="hAxis" categoryField="cateName" padding="0.4"/>'
		    				        +'</horizontalAxis>'
		    				        +'<verticalAxis>'
		    				           +'<LinearAxis id="vAxis"  formatter="{numFmt}"/>'
		    				       +'</verticalAxis>'
		    				          +'<series>'
		    				          +'<Column2DSeries yField="val" displayName="전체 월별 출하량" halfWidthOffset="5" labelPosition="outside">'
		   				          		+'<fill>'
		   					            	+'<SolidColor color="#4DC189" alpha="1"/>'
		   					            +'</fill>'
		   				                +'<showDataEffect>'
		   				                  +'<SeriesInterpolate/>'
		   				                +'</showDataEffect>'
		   					            +'</Column2DSeries>'
		   					            +'<Column2DSeries yField="val2" displayName="'+sidoName+' 월별 출하량" halfWidthOffset="5" labelPosition="outside">'
		   				          		+'<fill>'
		   					            	+'<SolidColor color="#F1B95F" alpha="1"/>'
		   					            +'</fill>'
		   				                +'<showDataEffect>'
		   				                  +'<SeriesInterpolate/>'
		   				                +'</showDataEffect>'
		   					            +'</Column2DSeries>'
		    				        +'</series>'
		    				        +'<horizontalAxisRenderers>'
		    				        +'<Axis2DRenderer axis="{hAxis}" minorTickLength="0" tickPlacement="outside" minorTickPlacement="cross" placement="bottom" canDropLabels="true" showLabels="true" showLine="true" labelAlign="center" styleName="axisLabel" labelRotation="0">'
		    				             +'<axisStroke>'
		    				                  +'<Stroke weight="10" color="#f4f4f4"/>'
		    				             +'</axisStroke>'
		    				        +'</Axis2DRenderer>'
		    				     +'</horizontalAxisRenderers>'
		    				     	+'<verticalAxisRenderers>'
		    				    		+'<Axis2DRenderer axis="{vAxis}" left="15px;" showLine="false"/>'
		    						+'</verticalAxisRenderers>' 
		    				    +'</Column2DChart>'
		    				    +'<Style>'
		    					   	+'.axisLabel{fontSize:11px;colorFill:#ff0000;}'
		    					+'</Style>'
		    				 +'</rMateChart>'; 
	    			}else{
	    				chartData2List = sidoDataList;
	    				layoutStr2 = 
		    				'<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'
		    				    +'<Options>'
		    				     +'<SubCaption text="만단" textAlign="left" />'
		    				     +'<Legend defaultMouseOverAction="false" useVisibleCheck="true"/>'
		    				    +'</Options>'
		    				    +'<NumberFormatter id="numFmt" useThousandsSeparator="true"/>'
		    				   +'<Column2DChart showDataTips="true" columnWidthRatio="0.5" selectionMode="single" displayCompleteCallFunction="displayCallFunction" dataTipJsFunction="dataTipFunc" >'
		    				       +'<horizontalAxis>'
		    				       	+'<CategoryAxis  id="hAxis" categoryField="cateName" padding="0.4"/>'
		    				        +'</horizontalAxis>'
		    				        +'<verticalAxis>'
		    				           +'<LinearAxis id="vAxis"  formatter="{numFmt}"/>'
		    				       +'</verticalAxis>'
		    				          +'<series>'
		    				          +'<Column2DSeries yField="val" displayName="'+sidoName+' 월별 출하량" halfWidthOffset="5" labelPosition="outside">'
		   				          		+'<fill>'
		   					            	+'<SolidColor color="#4DC189" alpha="1"/>'
		   					            +'</fill>'
		   				                +'<showDataEffect>'
		   				                  +'<SeriesInterpolate/>'
		   				                +'</showDataEffect>'
		   					            +'</Column2DSeries>'
		   					            +'<Column2DSeries yField="val2" displayName="'+sigunName+' 월별 출하량" halfWidthOffset="5" labelPosition="outside">'
		   				          		+'<fill>'
		   					            	+'<SolidColor color="#F1B95F" alpha="1"/>'
		   					            +'</fill>'
		   				                +'<showDataEffect>'
		   				                  +'<SeriesInterpolate/>'
		   				                +'</showDataEffect>'
		   					            +'</Column2DSeries>'
		    				        +'</series>'
		    				        +'<horizontalAxisRenderers>'
		    				        +'<Axis2DRenderer axis="{hAxis}" minorTickLength="0" tickPlacement="outside" minorTickPlacement="cross" placement="bottom" canDropLabels="true" showLabels="true" showLine="true" labelAlign="center" styleName="axisLabel" labelRotation="0">'
		    				             +'<axisStroke>'
		    				                  +'<Stroke weight="10" color="#f4f4f4"/>'
		    				             +'</axisStroke>'
		    				        +'</Axis2DRenderer>'
		    				     +'</horizontalAxisRenderers>'
		    				     	+'<verticalAxisRenderers>'
		    				    		+'<Axis2DRenderer axis="{vAxis}" left="15px;" showLine="false"/>'
		    						+'</verticalAxisRenderers>' 
		    				    +'</Column2DChart>'
		    				    +'<Style>'
		    					   	+'.axisLabel{fontSize:11px;colorFill:#ff0000;}'
		    					+'</Style>'
		    				 +'</rMateChart>'; 
	    				
	    			}
	    			
	    		}
	    		
	    		
	    		chartData2 = [{
		            "cateName" : "1월",
		            "val" : chartData2List.e1s01,
		            "val2" : res.prodList[0].e1s01
			    },{
			    	"cateName" : "2월",
			    	"val" : chartData2List.e1s02,
			    	"val2" : res.prodList[0].e1s02
			    },{
			    	"cateName" : "3월",
			    	"val" : chartData2List.e1s03,
			    	"val2" : res.prodList[0].e1s03
		    	},{
			    	"cateName" : "4월",
			    	"val" : chartData2List.e1s04,
			    	"val2" : res.prodList[0].e1s04
		    	},{
			    	"cateName" : "5월",
			    	"val" : chartData2List.e1s05,
			    	"val2" : res.prodList[0].e1s05
		    	},{
			    	"cateName" : "6월",
			    	"val" : chartData2List.e1s06,
			    	"val2" : res.prodList[0].e1s06
		    	},{
			    	"cateName" : "7월",
			    	"val" : chartData2List.e1s07,
			    	"val2" : res.prodList[0].e1s07
		    	},{
			    	"cateName" : "8월",
			    	"val" : chartData2List.e1s08,
			    	"val2" : res.prodList[0].e1s08
		    	},{
			    	"cateName" : "9월",
			    	"val" : chartData2List.e1s09,
			    	"val2" : res.prodList[0].e1s09
		    	},{
			    	"cateName" : "10월",
			    	"val" : chartData2List.e1s10,
			    	"val2" : res.prodList[0].e1s10
		    	},{
			    	"cateName" : "11월",
			    	"val" : chartData2List.e1s11,
			    	"val2" : res.prodList[0].e1s11
		    	},{
			    	"cateName" : "12월",
			    	"val" : chartData2List.e1s12,
			    	"val2" : res.prodList[0].e1s12
		    	}];
	    		
	    		
	    		
	    		
	    		
		    	chartData4 = [{
		            "cateName" : "양재",
		            "val" : res.prodList[0].e2s01
			    },{
			    	"cateName" : "엄궁",
			    	"val" : res.prodList[0].e2s02
			    },{
			    	"cateName" : "영남",
			    	"val" : res.prodList[0].e2s03
		    	},{
			    	"cateName" : "부경",
			    	"val" : res.prodList[0].e2s04
		    	},{
			    	"cateName" : "광주",
			    	"val" : res.prodList[0].e2s05
		    	},{
			    	"cateName" : "터미널",
			    	"val" : res.prodList[0].e2s06
		    	},{
			    	"cateName" : "코벤트",
			    	"val" : res.prodList[0].e2s07
		    	},{
			    	"cateName" : "남대문",
			    	"val" : res.prodList[0].e2s08
		    	},{
			    	"cateName" : "기타",
			    	"val" : res.prodList[0].e2s09
		    	},{
			    	"cateName" : "온라인",
			    	"val" : res.prodList[0].e2s10
		    	},{
			    	"cateName" : "오프라인",
			    	"val" : res.prodList[0].e2s11
		    	}];
	    		
		    	
		    	
		    	rMateChartH5.create("chart1", "chartHolder1", chartVars1, "100%", "100%");
		    	rMateChartH5.create("chart2", "chartHolder2", chartVars2, "100%", "100%");
		    	
		    	rMateChartH5.create("chart4", "chartHolder4", chartVars4, "100%", "100%");
		    	
		    	

		    	var flowerName = $("#flower option:selected").text();
		    	var sidoName = $("#sidoCode option:selected").text();
		    	var sigunName = $("#sigunCode option:selected").text();
		    	var stdMonthName = $("#stdMonth option:selected").text();
		    	
		    	var subTit = "<span style=\"font-size: 12px;margin-left:10px;\">품목  :  " + flowerName + "  / 시도  :  " + sidoName + "  / 시군구  :  " + sigunName + "  / 월  :  " + stdMonthName + "월</span>";
		    	
		    	$("#tit01").html($("#tit01").html()+subTit);
		    	$("#tit02").html($("#tit02").html()+subTit);
		    	$("#tit04").html($("#tit04").html()+subTit);
		    	
	    	}else{
	    		chartNullData = [];
	    		
		    	document.getElementById("chart1").setData(chartNullData);
		    	document.getElementById("chart2").setData(chartNullData);
		    	document.getElementById("chart4").setData(chartNullData);
		    	
		    	
	    	}
	    	
	    	
	    	
	    },
	});
}

function fn_chart2(stdYear, flower, sidoCode, sigunCode, stdMonth, type){
	
	
	$.ajax({
	    type : 'get',
	    url : "/reseach/prodInfoChart2.json",
	    data : {
	    	stdYear : stdYear,
	    	flower : flower,
	    	sidoCode : sidoCode,
	    	agCode : sigunCode,
	    	stdMonth : stdMonth
	    },
	    dataType : 'json',   	           
	    success : function(res){        
	    	console.log(res);
	    	
	    	if(res.prodAreaList.length > 0){
	    		// 1번차트 조건
	    		if(sigunCode == "" || sigunCode == null){
	    			
	    			$("#tit01").html("지역별 재배면적 / 출하량");
	    			chartData1 = res.prodAreaList;
			    	
			    	chartData2 = [{
			            "cateName" : "1월",
			            "val" : res.prodList[0].e1s01
				    },{
				    	"cateName" : "2월",
				    	"val" : res.prodList[0].e1s02
				    },{
				    	"cateName" : "3월",
				    	"val" : res.prodList[0].e1s03
			    	},{
				    	"cateName" : "4월",
				    	"val" : res.prodList[0].e1s04
			    	},{
				    	"cateName" : "5월",
				    	"val" : res.prodList[0].e1s05
			    	},{
				    	"cateName" : "6월",
				    	"val" : res.prodList[0].e1s06
			    	},{
				    	"cateName" : "7월",
				    	"val" : res.prodList[0].e1s07
			    	},{
				    	"cateName" : "8월",
				    	"val" : res.prodList[0].e1s08
			    	},{
				    	"cateName" : "9월",
				    	"val" : res.prodList[0].e1s09
			    	},{
				    	"cateName" : "10월",
				    	"val" : res.prodList[0].e1s10
			    	},{
				    	"cateName" : "11월",
				    	"val" : res.prodList[0].e1s11
			    	},{
				    	"cateName" : "12월",
				    	"val" : res.prodList[0].e1s12
			    	}];
			    	
			    	layoutStr1 =
				    	'<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'
					    +'<Options>'
					     +'<SubCaption text="ha/만단" textAlign="left" />'
					     +'<Legend defaultMouseOverAction="false" useVisibleCheck="true"/>'
					    +'</Options>'
					    +'<NumberFormatter id="numFmt" useThousandsSeparator="true"/>'
					   +'<Column2DChart showDataTips="true" columnWidthRatio="0.5" selectionMode="single" displayCompleteCallFunction="displayCallFunction" dataTipJsFunction="dataTipFunc" >'
					       +'<horizontalAxis>'
					       	+'<CategoryAxis  id="hAxis" categoryField="cateName" padding="0.4"/>'
					        +'</horizontalAxis>'
					        +'<verticalAxis>'
					           +'<LinearAxis id="vAxis"  formatter="{numFmt}"/>'
					       +'</verticalAxis>'
					          +'<series>'
					          +'<Column2DSeries yField="ffnowaTot" displayName="재배면적" halfWidthOffset="3" labelPosition="outside">'
					          		+'<fill>'
						            	+'<SolidColor color="#536BC9" alpha="1"/>'
						            +'</fill>'
				                    +'<showDataEffect>'
					                  +'<SeriesInterpolate/>'
					                +'</showDataEffect>'
						            +'</Column2DSeries>'
					            +'<Column2DSeries yField="d1c4" displayName="출하량" halfWidthOffset="3" labelPosition="outside">'
				          		+'<fill>'
					            	+'<SolidColor color="#4DC189" alpha="1"/>'
					            +'</fill>'
				                +'<showDataEffect>'
				                  +'<SeriesInterpolate/>'
				                +'</showDataEffect>'
					            +'</Column2DSeries>'
					        +'</series>'
					        +'<horizontalAxisRenderers>'
				            +'<Axis2DRenderer axis="{hAxis}" minorTickLength="0" tickPlacement="outside" minorTickPlacement="cross" placement="bottom" canDropLabels="true" showLabels="true" showLine="true" labelAlign="center" styleName="axisLabel" labelRotation="0">'
				                 +'<axisStroke>'
				                      +'<Stroke weight="10" color="#f4f4f4"/>'
				                 +'</axisStroke>'
				            +'</Axis2DRenderer>'
				         +'</horizontalAxisRenderers>'
					     	+'<verticalAxisRenderers>'
				        		+'<Axis2DRenderer axis="{vAxis}" left="15px;" showLine="false"/>'
				    		+'</verticalAxisRenderers>' 
					    +'</Column2DChart>'
					    +'<Style>'
						   	+'.axisLabel{fontSize:11px;colorFill:#ff0000;}'
						+'</Style>'
					 +'</rMateChart>';
					
	    		}else{
	    			
	    			$("#tit01").html("월별 실질 재배면적");
	    			
	    			chartData1 = [{
			            "cateName" : "1월",
			            "val" : res.prodAreaList[0].ffnowa01
				    },{
				    	"cateName" : "2월",
				    	"val" : res.prodAreaList[0].ffnowa02
				    },{
				    	"cateName" : "3월",
				    	"val" : res.prodAreaList[0].ffnowa03
			    	},{
				    	"cateName" : "4월",
				    	"val" : res.prodAreaList[0].ffnowa04
			    	},{
				    	"cateName" : "5월",
				    	"val" : res.prodAreaList[0].ffnowa05
			    	},{
				    	"cateName" : "6월",
				    	"val" : res.prodAreaList[0].ffnowa06
			    	},{
				    	"cateName" : "7월",
				    	"val" : res.prodAreaList[0].ffnowa07
			    	},{
				    	"cateName" : "8월",
				    	"val" : res.prodAreaList[0].ffnowa08
			    	},{
				    	"cateName" : "9월",
				    	"val" : res.prodAreaList[0].ffnowa09
			    	},{
				    	"cateName" : "10월",
				    	"val" : res.prodAreaList[0].ffnowa10
			    	},{
				    	"cateName" : "11월",
				    	"val" : res.prodAreaList[0].ffnowa11
			    	},{
				    	"cateName" : "12월",
				    	"val" : res.prodAreaList[0].ffnowa12
			    	}];
	    			
	    			
	    			layoutStr1 = 
	    				'<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'
	    				    +'<Options>'
	    				     +'<SubCaption text="ha" textAlign="left" />'
	    				     +'<Legend defaultMouseOverAction="false" useVisibleCheck="true"/>'
	    				    +'</Options>'
	    				    +'<NumberFormatter id="numFmt" useThousandsSeparator="true"/>'
	    				   +'<Column2DChart showDataTips="true" columnWidthRatio="0.5" selectionMode="single" displayCompleteCallFunction="displayCallFunction" dataTipJsFunction="dataTipFunc" >'
	    				       +'<horizontalAxis>'
	    				       	+'<CategoryAxis  id="hAxis" categoryField="cateName" padding="0.4"/>'
	    				        +'</horizontalAxis>'
	    				        +'<verticalAxis>'
	    				           +'<LinearAxis id="vAxis"  formatter="{numFmt}"/>'
	    				       +'</verticalAxis>'
	    				          +'<series>'
	    				          +'<Column2DSeries yField="val" displayName="월별 재배면적" halfWidthOffset="0" labelPosition="outside">'
	    				          		+'<fill>'
	    					            	+'<SolidColor color="#536BC9" alpha="1"/>'
	    					            +'</fill>'
	    				                +'<showDataEffect>'
	    				                  +'<SeriesInterpolate/>'
	    				                +'</showDataEffect>'
	    					            +'</Column2DSeries>'
	    				        +'</series>'
	    				        +'<horizontalAxisRenderers>'
	    				        +'<Axis2DRenderer axis="{hAxis}" minorTickLength="0" tickPlacement="outside" minorTickPlacement="cross" placement="bottom" canDropLabels="true" showLabels="true" showLine="true" labelAlign="center" styleName="axisLabel" labelRotation="0">'
	    				             +'<axisStroke>'
	    				                  +'<Stroke weight="10" color="#f4f4f4"/>'
	    				             +'</axisStroke>'
	    				        +'</Axis2DRenderer>'
	    				     +'</horizontalAxisRenderers>'
	    				     	+'<verticalAxisRenderers>'
	    				    		+'<Axis2DRenderer axis="{vAxis}" left="15px;" showLine="false"/>'
	    						+'</verticalAxisRenderers>' 
	    				    +'</Column2DChart>'
	    				    +'<Style>'
	    					   	+'.axisLabel{fontSize:11px;colorFill:#ff0000;}'
	    					+'</Style>'
	    				 +'</rMateChart>';	    				 
	    			
	    		}
	    		
	    		// 2번차트 조건
	    		var sidoName = $("#sidoCode option:selected").text();
	    		var sigunName = $("#sigunCode option:selected").text();
	    		
	    		//flower, sidoCode, sigunCode, stdMonth
	    		if((sidoCode == "" || sidoCode ==null) && (sigunCode =="" || sigunCode ==null)){
	    			allDataList = res.prodList[0];
	    			chartData2List = allDataList;
	    			layoutStr2 = 
	    				'<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'
	    				    +'<Options>'
	    				     +'<SubCaption text="만단" textAlign="left" />'
	    				     +'<Legend defaultMouseOverAction="false" useVisibleCheck="true"/>'
	    				    +'</Options>'
	    				    +'<NumberFormatter id="numFmt" useThousandsSeparator="true"/>'
	    				   +'<Column2DChart showDataTips="true" columnWidthRatio="0.5" selectionMode="single" displayCompleteCallFunction="displayCallFunction" dataTipJsFunction="dataTipFunc" >'
	    				       +'<horizontalAxis>'
	    				       	+'<CategoryAxis  id="hAxis" categoryField="cateName" padding="0.4"/>'
	    				        +'</horizontalAxis>'
	    				        +'<verticalAxis>'
	    				           +'<LinearAxis id="vAxis"  formatter="{numFmt}"/>'
	    				       +'</verticalAxis>'
	    				          +'<series>'
	    				          +'<Column2DSeries yField="val" displayName="'+sidoName+' 월별 출하량" halfWidthOffset="5" labelPosition="outside">'
	   				          		+'<fill>'
	   					            	+'<SolidColor color="#F1B95F" alpha="1"/>'
	   					            +'</fill>'
	   				                +'<showDataEffect>'
	   				                  +'<SeriesInterpolate/>'
	   				                +'</showDataEffect>'
	   					            +'</Column2DSeries>'
	    				        +'</series>'
	    				        +'<horizontalAxisRenderers>'
	    				        +'<Axis2DRenderer axis="{hAxis}" minorTickLength="0" tickPlacement="outside" minorTickPlacement="cross" placement="bottom" canDropLabels="true" showLabels="true" showLine="true" labelAlign="center" styleName="axisLabel" labelRotation="0">'
	    				             +'<axisStroke>'
	    				                  +'<Stroke weight="10" color="#f4f4f4"/>'
	    				             +'</axisStroke>'
	    				        +'</Axis2DRenderer>'
	    				     +'</horizontalAxisRenderers>'
	    				     	+'<verticalAxisRenderers>'
	    				    		+'<Axis2DRenderer axis="{vAxis}" left="15px;" showLine="false"/>'
	    						+'</verticalAxisRenderers>' 
	    				    +'</Column2DChart>'
	    				    +'<Style>'
	    					   	+'.axisLabel{fontSize:11px;colorFill:#ff0000;}'
	    					+'</Style>'
	    				 +'</rMateChart>'; 
	    		}else{
	    			if(sigunCode =="" || sigunCode ==null){
			    		sidoDataList = res.prodList[0];
			    		chartData2List = allDataList; 
	    				layoutStr2 = 
		    				'<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'
		    				    +'<Options>'
		    				     +'<SubCaption text="만단" textAlign="left" />'
		    				     +'<Legend defaultMouseOverAction="false" useVisibleCheck="true"/>'
		    				    +'</Options>'
		    				    +'<NumberFormatter id="numFmt" useThousandsSeparator="true"/>'
		    				   +'<Column2DChart showDataTips="true" columnWidthRatio="0.5" selectionMode="single" displayCompleteCallFunction="displayCallFunction" dataTipJsFunction="dataTipFunc" >'
		    				       +'<horizontalAxis>'
		    				       	+'<CategoryAxis  id="hAxis" categoryField="cateName" padding="0.4"/>'
		    				        +'</horizontalAxis>'
		    				        +'<verticalAxis>'
		    				           +'<LinearAxis id="vAxis"  formatter="{numFmt}"/>'
		    				       +'</verticalAxis>'
		    				          +'<series>'
		    				          +'<Column2DSeries yField="val" displayName="전체 월별 출하량" halfWidthOffset="5" labelPosition="outside">'
		   				          		+'<fill>'
		   					            	+'<SolidColor color="#4DC189" alpha="1"/>'
		   					            +'</fill>'
		   				                +'<showDataEffect>'
		   				                  +'<SeriesInterpolate/>'
		   				                +'</showDataEffect>'
		   					            +'</Column2DSeries>'
		   					            +'<Column2DSeries yField="val2" displayName="'+sidoName+' 월별 출하량" halfWidthOffset="5" labelPosition="outside">'
		   				          		+'<fill>'
		   					            	+'<SolidColor color="#F1B95F" alpha="1"/>'
		   					            +'</fill>'
		   				                +'<showDataEffect>'
		   				                  +'<SeriesInterpolate/>'
		   				                +'</showDataEffect>'
		   					            +'</Column2DSeries>'
		    				        +'</series>'
		    				        +'<horizontalAxisRenderers>'
		    				        +'<Axis2DRenderer axis="{hAxis}" minorTickLength="0" tickPlacement="outside" minorTickPlacement="cross" placement="bottom" canDropLabels="true" showLabels="true" showLine="true" labelAlign="center" styleName="axisLabel" labelRotation="0">'
		    				             +'<axisStroke>'
		    				                  +'<Stroke weight="10" color="#f4f4f4"/>'
		    				             +'</axisStroke>'
		    				        +'</Axis2DRenderer>'
		    				     +'</horizontalAxisRenderers>'
		    				     	+'<verticalAxisRenderers>'
		    				    		+'<Axis2DRenderer axis="{vAxis}" left="15px;" showLine="false"/>'
		    						+'</verticalAxisRenderers>' 
		    				    +'</Column2DChart>'
		    				    +'<Style>'
		    					   	+'.axisLabel{fontSize:11px;colorFill:#ff0000;}'
		    					+'</Style>'
		    				 +'</rMateChart>'; 
	    			}else{
	    				chartData2List = sidoDataList;
	    				layoutStr2 = 
		    				'<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'
		    				    +'<Options>'
		    				     +'<SubCaption text="만단" textAlign="left" />'
		    				     +'<Legend defaultMouseOverAction="false" useVisibleCheck="true"/>'
		    				    +'</Options>'
		    				    +'<NumberFormatter id="numFmt" useThousandsSeparator="true"/>'
		    				   +'<Column2DChart showDataTips="true" columnWidthRatio="0.5" selectionMode="single" displayCompleteCallFunction="displayCallFunction" dataTipJsFunction="dataTipFunc" >'
		    				       +'<horizontalAxis>'
		    				       	+'<CategoryAxis  id="hAxis" categoryField="cateName" padding="0.4"/>'
		    				        +'</horizontalAxis>'
		    				        +'<verticalAxis>'
		    				           +'<LinearAxis id="vAxis"  formatter="{numFmt}"/>'
		    				       +'</verticalAxis>'
		    				          +'<series>'
		    				          +'<Column2DSeries yField="val" displayName="'+sidoName+' 월별 출하량" halfWidthOffset="5" labelPosition="outside">'
		   				          		+'<fill>'
		   					            	+'<SolidColor color="#4DC189" alpha="1"/>'
		   					            +'</fill>'
		   				                +'<showDataEffect>'
		   				                  +'<SeriesInterpolate/>'
		   				                +'</showDataEffect>'
		   					            +'</Column2DSeries>'
		   					            +'<Column2DSeries yField="val2" displayName="'+sigunName+' 월별 출하량" halfWidthOffset="5" labelPosition="outside">'
		   				          		+'<fill>'
		   					            	+'<SolidColor color="#F1B95F" alpha="1"/>'
		   					            +'</fill>'
		   				                +'<showDataEffect>'
		   				                  +'<SeriesInterpolate/>'
		   				                +'</showDataEffect>'
		   					            +'</Column2DSeries>'
		    				        +'</series>'
		    				        +'<horizontalAxisRenderers>'
		    				        +'<Axis2DRenderer axis="{hAxis}" minorTickLength="0" tickPlacement="outside" minorTickPlacement="cross" placement="bottom" canDropLabels="true" showLabels="true" showLine="true" labelAlign="center" styleName="axisLabel" labelRotation="0">'
		    				             +'<axisStroke>'
		    				                  +'<Stroke weight="10" color="#f4f4f4"/>'
		    				             +'</axisStroke>'
		    				        +'</Axis2DRenderer>'
		    				     +'</horizontalAxisRenderers>'
		    				     	+'<verticalAxisRenderers>'
		    				    		+'<Axis2DRenderer axis="{vAxis}" left="15px;" showLine="false"/>'
		    						+'</verticalAxisRenderers>' 
		    				    +'</Column2DChart>'
		    				    +'<Style>'
		    					   	+'.axisLabel{fontSize:11px;colorFill:#ff0000;}'
		    					+'</Style>'
		    				 +'</rMateChart>'; 
	    			}
	    		}
	    		chartData2 = [{
		            "cateName" : "1월",
		            "val" : chartData2List.e1s01,
		            "val2" : res.prodList[0].e1s01
			    },{
			    	"cateName" : "2월",
			    	"val" : chartData2List.e1s02,
			    	"val2" : res.prodList[0].e1s02
			    },{
			    	"cateName" : "3월",
			    	"val" : chartData2List.e1s03,
			    	"val2" : res.prodList[0].e1s03
		    	},{
			    	"cateName" : "4월",
			    	"val" : chartData2List.e1s04,
			    	"val2" : res.prodList[0].e1s04
		    	},{
			    	"cateName" : "5월",
			    	"val" : chartData2List.e1s05,
			    	"val2" : res.prodList[0].e1s05
		    	},{
			    	"cateName" : "6월",
			    	"val" : chartData2List.e1s06,
			    	"val2" : res.prodList[0].e1s06
		    	},{
			    	"cateName" : "7월",
			    	"val" : chartData2List.e1s07,
			    	"val2" : res.prodList[0].e1s07
		    	},{
			    	"cateName" : "8월",
			    	"val" : chartData2List.e1s08,
			    	"val2" : res.prodList[0].e1s08
		    	},{
			    	"cateName" : "9월",
			    	"val" : chartData2List.e1s09,
			    	"val2" : res.prodList[0].e1s09
		    	},{
			    	"cateName" : "10월",
			    	"val" : chartData2List.e1s10,
			    	"val2" : res.prodList[0].e1s10
		    	},{
			    	"cateName" : "11월",
			    	"val" : chartData2List.e1s11,
			    	"val2" : res.prodList[0].e1s11
		    	},{
			    	"cateName" : "12월",
			    	"val" : chartData2List.e1s12,
			    	"val2" : res.prodList[0].e1s12
		    	}];
	    		
	    		
	    		
	    		
	    		
		    	chartData4 = [{
		            "cateName" : "양재",
		            "val" : res.prodList[0].e2s01
			    },{
			    	"cateName" : "엄궁",
			    	"val" : res.prodList[0].e2s02
			    },{
			    	"cateName" : "영남",
			    	"val" : res.prodList[0].e2s03
		    	},{
			    	"cateName" : "부경",
			    	"val" : res.prodList[0].e2s04
		    	},{
			    	"cateName" : "광주",
			    	"val" : res.prodList[0].e2s05
		    	},{
			    	"cateName" : "터미널",
			    	"val" : res.prodList[0].e2s06
		    	},{
			    	"cateName" : "코벤트",
			    	"val" : res.prodList[0].e2s07
		    	},{
			    	"cateName" : "남대문",
			    	"val" : res.prodList[0].e2s08
		    	},{
			    	"cateName" : "기타",
			    	"val" : res.prodList[0].e2s09
		    	},{
			    	"cateName" : "온라인",
			    	"val" : res.prodList[0].e2s10
		    	},{
			    	"cateName" : "오프라인",
			    	"val" : res.prodList[0].e2s11
		    	}];
	    		
		    	
		    	
		    	rMateChartH5.create("chart1", "chartHolder1", chartVars1, "100%", "100%");
		    	rMateChartH5.create("chart2", "chartHolder2", chartVars2, "100%", "100%");
		    	
		    	rMateChartH5.create("chart4", "chartHolder4", chartVars4, "100%", "100%");
		    	
		    	

		    	var flowerName = $("#flower option:selected").text();
		    	var sidoName = $("#sidoCode option:selected").text();
		    	var sigunName = $("#sigunCode option:selected").text();
		    	var stdMonthName = $("#stdMonth option:selected").text();
		    	
		    	var subTit = "<span style=\"font-size: 12px;margin-left:10px;\">품목  :  " + flowerName + "  / 시도  :  " + sidoName + "  / 시군구  :  " + sigunName + "  / 월  :  " + stdMonthName + "월</span>";
		    	
		    	$("#tit01").html($("#tit01").html()+subTit);
		    	$("#tit02").html($("#tit02").html()+subTit);
		    	$("#tit04").html($("#tit04").html()+subTit);
		    	
	    	}else{
	    		chartNullData = [];
	    		
		    	document.getElementById("chart1").setData(chartNullData);
		    	document.getElementById("chart2").setData(chartNullData);
		    	document.getElementById("chart4").setData(chartNullData);
	    	}
	    },
	});
}

function fn_printDiv(id){
	$(".btn_down_image").css("display","none");
	$(".btn_search").css("display","none");
	var fileName = $(".main_title").text();
	var div = $("#"+id).get(0);
	
	html2canvas(div).then(function(canvas){
		var myImage = canvas.toDataURL();
		$(".btn_down_image").css("display","");
		$(".btn_search").css("display","");
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
					<li><a href="/research/chulInfo.do" class="btn_menu">전국절화 농가현황</a></li>
					<li><a href="/research/prodInfo.do" class="btn_menu on">재배현황</a></li>
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
				<h2 class="main_title">2019년 재배현황</h2>
				<!-- main title(E) -->

				<!-- search box pack(S)-->
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
						<dl>
							<dt><p class="tit_tag">품목</p></dt>
							<dd>
								<div class="select_type_01">
									<input type="hidden" id="flowerParam" value="<c:out value="${paramMap.flower}"/>">
									<select id="flower" onchange="fn_flowerChange();">
										<option value="" id="flower">전체</option>
									</select>
									<label for="flower"></label>
								</div>
							</dd>
						</dl>
						<dl>
							<dt><p class="tit_tag">시도</p></dt>
							<dd>
								<div class="select_type_01">
									<select name="sidoCode" id="sidoCode" onchange="fn_sidoChange();">
										<option value="" id="sido0">전체</option>
										<c:forEach items="${sidoList}" var="sido">
										<option value="${sido.areaCode}" id="sido${sido.areaCode}" data-code="${sido.sidoCode}">${sido.searchKorName}</option>
										</c:forEach>
									</select>
									<label for="sidoCode"></label>
								</div>
							</dd>
						</dl>
						<dl>
							<dt><p class="tit_tag">시군구</p></dt>
							<dd>
								<div class="select_type_01">
									<select name="sigunCode" id="sigunCode" onchange="fn_sigunChange();">
										<option value="" id="sigun0">전체</option>
									</select>
									<label for="sigunCode"></label>
								</div>
							</dd>
						</dl>
						<dl>
							<dt><p class="tit_tag">월</p></dt>
							<dd>
								<div class="select_type_01">
									<select name="stdMonth" id="stdMonth" onchange="fn_stdMonthChange();">
										<option value="" id="month0">전체</option>
										<c:forEach begin="1" end="12" var="month">
											<option value="${month}" <c:if test="${paramMap.stdMonth eq month}">selected="selected"</c:if>>${month}월</option>
										</c:forEach>
									</select>
									<label for="stdMonth"></label>
								</div>
							</dd>
						</dl>
					</div>
					<!-- search box(E) -->

					<!-- image button(S) -->
					<a href="javascript:searchBtn();" class="btn_search">조회</a>
					<a href="javascript:fn_printDiv('printDiv');" class="btn_down_image">이미지</a>
					<!-- image button(E) -->

				</div>
				<!-- search box pack(E)-->
				
				<div class="img_capture mt30">				
					<!-- graph(S) -->
				<div class="graph_box">
					<div class="col_wrap col2">
						<div class="col">
							<h4 class="tit_01" id="tit01">지역별 재배면적 / 출하량</h4>
							<div class="g_area">
								<div id="chartHolder1" style="width:100%;height:100%;"></div>
							</div>
						</div>
					</div>
					<div class="col_wrap col2">
						<div class="col">
							<h4 class="tit_01" id="tit02">월별 출하량</h4>
							<div class="g_area">
								<div id="chartHolder2" style="width:100%;height:100%;"></div>
							</div>
						</div>
					</div>
					<div class="col_wrap col2">
						<div class="col">
							<h4 class="tit_01" id="tit04">출하처별 출하량 비중 <span style="font-size: 12px;">(월별 데이터 미제공)</span></h4>
							<div class="g_area">
								<div id="chartHolder4" style="width:100%;height:100%;"></div>
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


