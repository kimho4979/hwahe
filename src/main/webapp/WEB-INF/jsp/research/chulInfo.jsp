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

<title>전국농가현황</title>

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
<script type="text/javascript" src="/rMateChart/rMateChartH5/JS/rMateChartH5.js"></script>



<!-- rMateChartH5 테마 js -->
<script type="text/javascript" src="/rMateChart/rMateChartH5/Assets/Theme/theme.js"></script>
<script type="text/javascript" src="/rMateMapChart/rMateMapChartH5/JS/html2canvas.js"></script>
<script type="text/javascript" src="/rMateMapChart/rMateMapChartH5/JS/promise.min.js"></script>
<script type="text/javascript" src="/rMateMapChart/rMateMapChartH5/JS/canvg.js"></script>
<script type="text/javascript" src="/rMateMapChart/rMateMapChartH5/JS/rgbcolor.js"></script>

<script type="text/javascript">


//-----------------------맵차트 설정 시작-----------------------
//rMate 맵차트 생성 준비가 완료된 상태 시 호출할 함수를 지정합니다.
var mapVars = "rMateOnLoadCallFunction=mapReadyHandler";
var mapApp = null;
var mapRoot = null;
//맵차트의 속성인 rMateOnLoadCallFunction 으로 설정된 함수.
//rMate 맵차트 준비가 완료된 경우 이 함수가 호출됩니다.
//이 함수를 통해 맵차트에 레이아웃과 데이터를 삽입합니다.
//파라메터 : id - rMateMapChartH5.create() 사용 시 사용자가 지정한 id 입니다.
//맵차트 콜백함수 7개 존재합니다.
//1. setLayout - 스트링으로 작성된 레이아웃 XML을 삽입합니다.
//2. setData - 배열로 작성된 데이터를 삽입합니다.
//3. setMapDataBase - 스트링으로 작성된 MapData XML을 삽입합니다.
//4. setLayoutURLEx - 레이아웃 XML 경로를 지시합니다.
//5. setDataURLEx - 데이터 XML 경로를 지시합니다.
//6. setMapDataBaseURLEx - MapData XML 경로를 지시합니다.
//7. setSourceURLEx - Map Source 경로를 지시합니다.
function mapReadyHandler(id) {
 document.getElementById(id).setLayout(layoutStr);
 document.getElementById(id).setData(mapData);
 document.getElementById(id).setMapDataBaseURLEx(mapDataBaseURL);
 document.getElementById(id).setSourceURLEx(sourceURL);
 
}

//Map Data 경로 정의
//setMapDataBase함수로 mapDataBase를 문자열로 넣어줄 경우 주석처리나 삭제하십시오.
var mapDataBaseURL = "/rMateMapChart/xml/MapDataBaseXml/SouthKoreaDrillDownSeoulDong_scale.xml";

//MapChart Source 선택
//MapSource 디렉토리의 지도 이미지중 택일가능하며, 이외에 사용자가 작성한 별도의 Svg이미지를 지정할 수 있습니다.(매뉴얼 참조)
var sourceURL = "/rMateMapChart/Samples/MapSource/SouthKoreaDrillDownSeoulDong.svg";

//rMateMapChart 를 생성합니다.
//파라메터 (순서대로) 
//1. 맵차트의 id ( 임의로 지정하십시오. ) 
//2. 맵차트가 위치할 div 의 id (즉, 차트의 부모 div 의 id 입니다.)
//3. 맵차트 생성 시 필요한 환경 변수들의 묶음인 chartVars
//4. 맵차트의 가로 사이즈 (생략 가능, 생략 시 100%)
//5. 맵차트의 세로 사이즈 (생략 가능, 생략 시 100%)


var codes = {
	"100":true
  , "200":true
  , "300":true
  , "400":true
  , "500":true
  , "600":true
  , "700":true
  , "800":true
  , "90000":true
  , "1000":true
  , "1100":true
  , "1200":true
  , "1300":true
  , "1400":true
  , "1500":true
  , "1600":true
  , "1700":true
}

function rollOverFillFunction(code, label, data) {
if ( codes[code]){
   return "#2e7dca";
} else if ( code > 90000 ) {
  if ( code%100 == 0  )
        return "#2e7dca";
    else
         return "#f6b149";
} else
   return "#a08e78";
}

function colorFunction(code, label, data) {
	
if ( codes[code]){
   return "#62bfea";
} else if ( code > 90000 ) {
  if ( code%100 == 0 )
         return "#62bfea";
    else
         return "#ccbca5";
} else
   return "#62bfea";
}

function strokeFunction(code, label, data) {
if ( codes[code]){
   return "#BBE1EA";
} else if ( code > 90000 ) {
  if ( code%100 == 0 )
         return "#BBE1EA";
    else
         return "#e2d5c5";
} else
   return "#BBE1EA";
}

var mapInitData = [];
var mapAreaData = [];

function clickFunction(code, label, data) {
    
    var sidoArr = "100,1000,1100,1200,1300,1400,1500,1600,1700,200,300,400,500,600,700,800,900,";
    var areaCode = ""+code;
	var stdKind = $("#kind").prop("value");
    
    if(code >= 90000 ){
    	areaCode = areaCode.substring(0,3);
    	
    }
    
    if(sidoArr.indexOf(areaCode+",") !== -1){
    	$("#sidoCode").prop("value",areaCode);
    	mapApp = document.getElementById("map1");
    	mapRoot = mapApp.getRoot();
    	mapRoot.setOpenCode(code);
    	fn_sigunList();
    	
    	if (stdKind == '절화') {
    		fn_mapInit();
    	}
    	if (stdKind == '난') {
    		fn_mapInit2();
    	}
    	
    }else{
    	$("#sigunCode").prop("value",areaCode);
    	fn_search();
    }
    
    
    //
    
}

function backFunction() {
   var stdKind = $("#kind").prop("value");
	
   $("#sidoCode").prop("value","");
   $("#sigunCode").html("<option value=\"\" id=\"sigun0\">전체</option>");
   mapRoot.setOpenCode(null);
   
   if (stdKind == '절화') { 
   		fn_mapInit();
   }
   if (stdKind == '난') { 
  		fn_mapInit2();
   }
   
   fn_search();
};


function labelFunction(seriesId, code, label, data) {
	
    var text = null;
    
    if(data != null){
    	text = {"text":label+"<br>"+data.prdArea+"ha", "color":"#FFFFFF", "fontSize":"11", "fontWeight":"bold", "lineHeight":5};
    }else{
    	text = {"text":label, "color":"#FFFFFF", "fontSize":"11", "fontWeight":"bold", "lineHeight":5};
    }
    
     return text;
}

function divDataTipFunction(seriesId, code, label, data) {
	
	if(data.prdArea != null){
		var html = "<div style=\"padding:3px;\"><div>"+label+"</div>";
			html += "<div>재배농가수 : "+data.chulCnt+"호</div>";
			html += "<div>재배면적 : "+data.prdArea+"ha</div>";
			html += "<div>연간출하량 : "+data.yearQty+"만단</div>";
			html += "<div>연간출하액 : "+data.yearAmt+"억원</div></div>";
		return html;
		/*
		var html = "<table style=\"text-align:left;color:#888888;letter-spacing:-1px;\">";
			html += "<tr><td align=\"center\">"+label+"<td></tr>";
			html += "<tr><td style=\"padding:0 0 0 15px;margin-top:-10px;\"> 재배농가수 : "+data.chulCnt+"</td></tr>";
			html += "</table>";
		return html;*/	
	}else{
		
		return "데이터가 없습니다.";
	}
    
}


var layoutStr = null;


var mapData = null;
//-----------------------맵차트 설정 끝 -----------------------


$(document).ready(function(){	
	$(".main_title").html($("#stdYear").prop("value") + "년 전국 " + $("#kind").prop("value") + " 농가 현황");
	var stdKind = $("#kind").prop("value");

	if (stdKind == '절화') {
//		$("#view1").show();
//		$("#view2").show();
		
		fn_mapInit();
	}
	if (stdKind == '난') {
//		$("#view1").hide();
//		$("#view2").hide();
		
		fn_mapInit2();
	}

	fn_search();
});

function searchBtn(){
	$(".main_title").html($("#stdYear").prop("value") + "년 전국 " + $("#kind").prop("value") + " 농가 현황");
	var stdKind = $("#kind").prop("value");

	if (stdKind == '절화') {
		fn_mapInit();
	}
	if (stdKind == '난') {
		fn_mapInit2();
	}

	fn_search();
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

function fn_stdYearChange(){
	
	$(".main_title").html($("#stdYear").prop("value") + "년 전국 " + $("#kind").prop("value") + " 농가 현황");
	$("#sidoCode").prop("value","");
	$("#sigunCode").html("<option value=\"\" id=\"sigun0\">전체</option>");
	mapApp = document.getElementById("map1");
	mapRoot = mapApp.getRoot();
	mapRoot.setOpenCode(null);
	
	var stdKind = $("#kind").prop("value");
	
	if (stdKind == '절화') {
		fn_mapInit();
	}
	if (stdKind == '난') {
		fn_mapInit2();
	}
	
	fn_search();
}

function fn_stdKindChange(){
	$(".main_title").html($("#stdYear").prop("value") + "년 전국 " + $("#kind").prop("value") + " 농가 현황");
	$("#sidoCode").prop("value","");
	$("#sigunCode").html("<option value=\"\" id=\"sigun0\">전체</option>");
	mapApp = document.getElementById("map1");
	mapRoot = mapApp.getRoot();
	mapRoot.setOpenCode(null);

    var stdKind = $("#kind").prop("value");

	if (stdKind == '절화') {
		$("#view1").show();
		$("#view2").show();
		
		fn_mapInit();
	}
	if (stdKind == '난') {
		$("#view1").hide();
		$("#view2").hide();
		
		fn_mapInit2();
	}
	
	fn_search();
}

function fn_mapInit(){
	var stdYear = $("#stdYear").prop("value");
	var prdArea = $("#prdArea").prop("value");

	$.ajax({
	    type : 'get',
	    url : "/reseach/chulInfoInit.json",
	    data : {
	    	stdYear : stdYear,
	    	prdArea : prdArea
	    },
	    dataType : 'json',   	           
	    success : function(res){        
	    	
	    	var resultList = res.chulInfoMapSidoList;
	    	var max = 0;
	    	var mapInteval = 10;
	    	mapData = resultList;
	    	var lastMapData = mapData.pop();
	    	mapInitData = mapData;
	    	
	    	var sidoAreaCode = $("#sidoCode").prop("value");
	    	if(sidoAreaCode != "" && sidoAreaCode != null ){
	    		var areaData = [];
	    		for(var i =0; i<mapData.length; i++){
	    			if(sidoAreaCode == mapData[i].sidoCode){
	    				areaData.push(mapData[i]);	
	    			}
	    		}
	    		areaData.pop();
	    		mapData = areaData;
	    		//mapRoot.setOpenCode(sidoAreaCode);
	    		for(var i=0; i<mapData.length; i++){
		    		if(max < mapData[i].prdArea){
		    			max = mapData[i].prdArea;
		    		}
		    	}
	    	}else{
	    		mapData = mapInitData;
	    		//mapRoot.setOpenCode("");
	    		for(var i=0; i<mapData.length; i++){
		    		if(mapData[i].gubun == "1" ){
		    			if(max < mapData[i].prdArea){
			    			max = mapData[i].prdArea;
			    		}	
		    		}
		    	}
	    	}

	    	mapInteval = (max/5).toFixed(0);
	    	if(mapInteval < 1){
	    		mapInteval = 1;
	    	}

	 layoutStr = '<rMateMapChart>'
			  +'<MapChart id="mainMap1" showDataTips="true" drillDownEnabled="true" dataTipType="Type3" mapChangeJsFunction="clickFunction" backToMapJsFunction="backFunction" divDataTipJsFunction="divDataTipFunction" followDataTip="true">'
			  +'<series>'
			  +'    <MapSeries id="mapseries" labelJsFunction="labelFunction" interactive="true" selectionMarking="line" color="#000000" labelPosition="inside" displayName="Map" rollOverFillJsFunction="rollOverFillFunction" localFillByRange="[#dcdfe8,#93D6F1,#4a88b7,#596283,#5b5e67]" rangeLegendDataField="prdArea" localFillJsFunction="colorFunction" >'
			  //+'         <showDataEffect>'
			  //+'            <SeriesInterpolate duration="0"/>'
			  //+'        </showDataEffect>'
			  +'           <stroke>'
			  +'            <Stroke color="#8C8C8C" weight="0.8" alpha="1"/>'
			  +'        </stroke>'
			  //+'           <rollOverStroke>'
			  //+'            <Stroke color="#BBE1EA" weight="0" alpha="0.25"/>'
			  //+'           </rollOverStroke>'
			  +'       </MapSeries>'
			  +'</series>'
			  +'</MapChart>'
			  +'<DataRangeLegend width="200" height="35" minimum="0" maximum="'+max+'" dataRangeHeight="20" fontSize="10" arrowOffset="0" interval="'+mapInteval+'" showArrow="true" tickGap="5" stroke="#000000" arrowColor="#ffffff" arrowStroke="#000000" colors="[#dcdfe8,#93D6F1,#4a88b7,#596283,#5b5e67]"/>'
			  +'</rMateMapChart>';
	    	
			  
		 	if(sidoAreaCode != "" && sidoAreaCode != null){
		 		document.getElementById("map1").setLayout(layoutStr);
		 		document.getElementById("map1").setData(mapData);
		 	}else{
		 		rMateMapChartH5.create("map1", "mapHolder", mapVars, "100%", "100%");
		 	} 
	    },
	});
}

function fn_mapInit2(){
	var stdYear = $("#stdYear").prop("value");
	var prdArea = $("#prdArea").prop("value");

	$.ajax({
	    type : 'get',
	    url : "/reseach/chulInfoInit2.json",
	    data : {
	    	stdYear : stdYear,
	    	prdArea : prdArea
	    },
	    dataType : 'json',   	           
	    success : function(res){        
	    	
	    	var resultList = res.chulInfoMapSidoList2;
	    	var max = 0;
	    	var mapInteval = 10;
	    	mapData = resultList;
	    	var lastMapData = mapData.pop();
	    	mapInitData = mapData;
	    	
	    	var sidoAreaCode = $("#sidoCode").prop("value");
	    	if(sidoAreaCode != "" && sidoAreaCode != null ){
	    		var areaData = [];
	    		for(var i =0; i<mapData.length; i++){
	    			if(sidoAreaCode == mapData[i].sidoCode){
	    				areaData.push(mapData[i]);	
	    			}
	    		}
	    		areaData.pop();
	    		mapData = areaData;
	    		//mapRoot.setOpenCode(sidoAreaCode);
	    		for(var i=0; i<mapData.length; i++){
		    		if(max < mapData[i].prdArea){
		    			max = mapData[i].prdArea;
		    		}
		    	}
	    	}else{
	    		mapData = mapInitData;
	    		//mapRoot.setOpenCode("");
	    		for(var i=0; i<mapData.length; i++){
		    		if(mapData[i].gubun == "1" ){
		    			if(max < mapData[i].prdArea){
			    			max = mapData[i].prdArea;
			    		}	
		    		}
		    	}
	    	}

	    	mapInteval = (max/5).toFixed(0);
	    	if(mapInteval < 1){
	    		mapInteval = 1;
	    	}

	 layoutStr = '<rMateMapChart>'
			  +'<MapChart id="mainMap1" showDataTips="true" drillDownEnabled="true" dataTipType="Type3" mapChangeJsFunction="clickFunction" backToMapJsFunction="backFunction" divDataTipJsFunction="divDataTipFunction" followDataTip="true">'
			  +'<series>'
			  +'    <MapSeries id="mapseries" labelJsFunction="labelFunction" interactive="true" selectionMarking="line" color="#000000" labelPosition="inside" displayName="Map" rollOverFillJsFunction="rollOverFillFunction" localFillByRange="[#dcdfe8,#93D6F1,#4a88b7,#596283,#5b5e67]" rangeLegendDataField="prdArea" localFillJsFunction="colorFunction" >'
			  //+'         <showDataEffect>'
			  //+'            <SeriesInterpolate duration="0"/>'
			  //+'        </showDataEffect>'
			  +'           <stroke>'
			  +'            <Stroke color="#8C8C8C" weight="0.8" alpha="1"/>'
			  +'        </stroke>'
			  //+'           <rollOverStroke>'
			  //+'            <Stroke color="#BBE1EA" weight="0" alpha="0.25"/>'
			  //+'           </rollOverStroke>'
			  +'       </MapSeries>'
			  +'</series>'
			  +'</MapChart>'
			  +'<DataRangeLegend width="200" height="35" minimum="0" maximum="'+max+'" dataRangeHeight="20" fontSize="10" arrowOffset="0" interval="'+mapInteval+'" showArrow="true" tickGap="5" stroke="#000000" arrowColor="#ffffff" arrowStroke="#000000" colors="[#dcdfe8,#93D6F1,#4a88b7,#596283,#5b5e67]"/>'
			  +'</rMateMapChart>';
	    	
			  
		 	if(sidoAreaCode != "" && sidoAreaCode != null){
		 		document.getElementById("map1").setLayout(layoutStr);
		 		document.getElementById("map1").setData(mapData);
		 	}else{
		 		rMateMapChartH5.create("map1", "mapHolder", mapVars, "100%", "100%");
		 	} 
	    },
	});
}

function fn_sidoChange(){
	var sidoCode = $("#sidoCode option:selected").attr("data-code");
	var areaCode = $("#sidoCode").prop("value");
	var stdYear = $("#stdYear").prop("value");
	var prdArea = $("#prdArea").prop("value");
    var stdKind = $("#kind").prop("value");
	
	mapApp = document.getElementById("map1");
	mapRoot = mapApp.getRoot();
	
	if(areaCode==""){
		$("#sigunCode").html("<option value=\"\" id=\"sigun0\">전체</option>");
		
		//window.location.href = "/research/chulInfo.do?stdYear="+stdYear+"&prdArea="+prdArea;
		mapRoot.setOpenCode(null);
		
		if (stdKind == '절화') {
			fn_mapInit();
		}
		if (stdKind == '난') {
			fn_mapInit2();
		}
		fn_search();
	}else{
		if (stdKind == '절화') {
			fn_mapInit();
		}
		if (stdKind == '난') {
			fn_mapInit2();
		}
		mapRoot.setOpenCode(areaCode);
		fn_sigunList();
	}
}



function fn_sigunChange(){
	var areaCode = $("#sigunCode").prop("value");
	
	if(areaCode == ""){
		//mapRoot.setSelectedCode("");
		
		
		
	}else{
		mapRoot.setSelectedCode(areaCode);	
	}
	
	fn_search();
	
}

function fn_prdAreaChange(){
	var sidoCode = $("#sidoCode").prop("value");
    var stdKind = $("#kind").prop("value");
	
	if(sidoCode == ""){
		//mapRoot.setOpenCode(null);
	}
	if (stdKind == '절화') {
		fn_mapInit();
	}
	if (stdKind == '난') {
		fn_mapInit2();
	}
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

function fn_search(){
	var stdYear = $("#stdYear").prop("value");
	var sidoCode = $("#sidoCode option:selected").attr("data-code");
	var sigunCode = $("#sigunCode option:selected").attr("data-code");
	var prdArea = $("#prdArea").prop("value");
	var stdKind = $("#kind").prop("value");

	if (stdKind == '절화') {
		fn_chulInfo(stdYear, sidoCode, sigunCode, prdArea);
		fn_chart(stdYear, sidoCode, sigunCode, prdArea);
	} else {
		fn_chulInfo2(stdYear, sidoCode, sigunCode, prdArea);
		fn_chart2(stdYear, sidoCode, sigunCode, prdArea);
	}
}


function fn_chulInfo(stdYear, sidoCode, sigunCode, prdArea){
	if(sidoCode == null && sigunCode == null){
		fh_chulInfoAll(stdYear, prdArea);	
	}else{
		fh_chulInfoEach(stdYear, sidoCode, sigunCode, prdArea);
	}
}

function fn_chulInfo2(stdYear, sidoCode, sigunCode, prdArea){
	if(sidoCode == null && sigunCode == null){
		fh_chulInfoAll2(stdYear, prdArea);	
	}else{
		fh_chulInfoEach2(stdYear, sidoCode, sigunCode, prdArea);
	}
}

function fh_chulInfoAll(stdYear, prdArea){
	
	$.ajax({
	    type : 'get',
	    url : "/reseach/chulInfo.json",
	    data : {
	    	stdYear : stdYear,
	    	prdArea : prdArea
	    },
	    dataType : 'json',   	           
	    success : function(res){        
	    	
	    	var resultList = res.chulInfoList;
	    	var html = "";
		    var html2 = "";
		    
		    var resultList = res.chulInfoList;
	    	var chulCnt = 0;
	    	var prdArea = 0;
	    	var yearQty = 0;
	    	var yearAmt = 0;
	    	
	    	var lastChulCnt = 0;
	    	var lastPrdArea = 0;
	    	var lastYearQty = 0;
	    	var lastYearAmt = 0;
	    	
	    	
	    	if(resultList.length > 0){
	    		for(var i=0; i<resultList.length; i++){
	    			chulCnt = chulCnt+resultList[i].chulCnt;
	    			prdArea = prdArea+resultList[i].prdArea;
	    			yearQty = yearQty+resultList[i].yearQty;
	    			yearAmt = yearAmt+resultList[i].yearAmt;
	    			
	    			if(i==3 || i==4){
	    				// 제주 강원 합산
	    				lastChulCnt = lastChulCnt+resultList[i].chulCnt;
	    				lastPrdArea = lastPrdArea+resultList[i].prdArea;
	    				lastYearQty = lastYearQty+resultList[i].yearQty;
	    				lastYearAmt = lastYearAmt+resultList[i].yearAmt;
	    			}
	    		}
	    		
	    		$("#mainArea").html("전체");
	    		$("#mainChulCnt").html(comma(chulCnt) + "호");
		    	$("#mainPrdArea").html(comma(prdArea) + "ha");
		    	$("#mainYearChulQty").html(comma(yearQty) + "만단");
		    	$("#mainYearChulAmt").html(comma(yearAmt) + "억원");
	    	}
		    
	    	if(resultList.length > 0){
	    		/*메인*/
	    		/*
		    	$("#mainArea").html(resultList[0].sidoName);
		    	$("#mainChulCnt").html(comma(resultList[0].chulCnt) + "호");
		    	$("#mainPrdArea").html(comma(resultList[0].prdArea) + "ha");
		    	$("#mainYearChulQty").html(comma(resultList[0].yearQty) + "만단");
		    	$("#mainYearChulAmt").html(comma(resultList[0].yearAmt) + "억원");
		    	*/
		    	
		    	/*서브*/
		    	
		    	for(var i=0; i<resultList.length; i++){
		    		if(i != 3 && i!= 4){
		    			if(i<3){
			    			html +="<li>                                                  ";
							html +="	<h4 class=\"tit_si\">"+resultList[i].sidoName+"</h4>                     ";
							html +="	<div class=\"state_data\">                        ";
							html +="		<dl>                                          ";
							html +="			<dt><p class=\"sd_tit\">재배농가 수</p></dt>   ";
							html +="			<dd><p class=\"sd_num\"> "+comma(resultList[i].chulCnt)+"호</p></dd>     ";
							html +="		</dl>                                         ";
							html +="		<dl>                                          ";
							html +="			<dt><p class=\"sd_tit\">재배면적</p></dt>     ";
							html +="			<dd><p class=\"sd_num\">"+comma(resultList[i].prdArea)+"ha</p></dd>    ";
							html +="		</dl>                                         ";
							html +="		<dl>                                          ";
							html +="			<dt><p class=\"sd_tit\">연간출하량</p></dt>    ";
							html +="			<dd><p class=\"sd_num\">"+comma(resultList[i].yearQty)+"만단</p></dd>   ";
							html +="		</dl>                                         ";
							html +="		<dl>                                          ";
							html +="			<dt><h4 class=\"sd_tit\">연간출하액</p></dt>   ";
							html +="			<dd><p class=\"sd_num\">"+comma(resultList[i].yearAmt)+"억원</p></dd>    ";
							html +="		</dl>                                         ";
							html +="	</div>                                            ";
							html +="</li>                                                 ";
			    		}else{
			    			html2 +="<li>                                                  ";
							html2 +="	<h4 class=\"tit_si\">"+resultList[i].sidoName+"</h4>                     ";
							html2 +="	<div class=\"state_data\">                        ";
							html2 +="		<dl>                                          ";
							html2 +="			<dt><p class=\"sd_tit\">재배농가 수</p></dt>   ";
							html2 +="			<dd><p class=\"sd_num\"> "+comma(resultList[i].chulCnt)+"호</p></dd>     ";
							html2 +="		</dl>                                         ";
							html2 +="		<dl>                                          ";
							html2 +="			<dt><p class=\"sd_tit\">재배면적</p></dt>     ";
							html2 +="			<dd><p class=\"sd_num\">"+comma(resultList[i].prdArea)+"ha</p></dd>    ";
							html2 +="		</dl>                                         ";
							html2 +="		<dl>                                          ";
							html2 +="			<dt><p class=\"sd_tit\">연간출하량</p></dt>    ";
							html2 +="			<dd><p class=\"sd_num\">"+comma(resultList[i].yearQty)+"만단</p></dd>   ";
							html2 +="		</dl>                                         ";
							html2 +="		<dl>                                          ";
							html2 +="			<dt><h4 class=\"sd_tit\">연간출하액</p></dt>   ";
							html2 +="			<dd><p class=\"sd_num\">"+comma(resultList[i].yearAmt)+"억원</p></dd>    ";
							html2 +="		</dl>                                         ";
							html2 +="	</div>                                            ";
							html2 +="</li>                                                 ";
			    		}
		    		}
		    	}
		    	
		    	html2 +="<li>                                                  ";
				html2 +="	<h4 class=\"tit_si\">강원,제주</h4>                     ";
				html2 +="	<div class=\"state_data\">                        ";
				html2 +="		<dl>                                          ";
				html2 +="			<dt><p class=\"sd_tit\">재배농가 수</p></dt>   ";
				html2 +="			<dd><p class=\"sd_num\"> "+comma(lastChulCnt)+"호</p></dd>     ";
				html2 +="		</dl>                                         ";
				html2 +="		<dl>                                          ";
				html2 +="			<dt><p class=\"sd_tit\">재배면적</p></dt>     ";
				html2 +="			<dd><p class=\"sd_num\">"+comma(lastPrdArea)+"ha</p></dd>    ";
				html2 +="		</dl>                                         ";
				html2 +="		<dl>                                          ";
				html2 +="			<dt><p class=\"sd_tit\">연간출하량</p></dt>    ";
				html2 +="			<dd><p class=\"sd_num\">"+comma(lastYearQty)+"만단</p></dd>   ";
				html2 +="		</dl>                                         ";
				html2 +="		<dl>                                          ";
				html2 +="			<dt><h4 class=\"sd_tit\">연간출하액</p></dt>   ";
				html2 +="			<dd><p class=\"sd_num\">"+comma(lastYearAmt)+"억원</p></dd>    ";
				html2 +="		</dl>                                         ";
				html2 +="	</div>                                            ";
				html2 +="</li>                                                 ";
		    	
		    	
	    	}else{
	    		
	    		$("#mainArea").html("정보없음");
		    	$("#mainChulCnt").html("0호");
		    	$("#mainPrdArea").html("0ha");
		    	$("#mainYearChulQty").html("0만단");
		    	$("#mainYearChulAmt").html("0억원");
	    		
	    	}
	    	
	    	
	    	$("#subDiv").html(html);
	    	$("#subDiv2").html(html2);
	    	
	    },
	});
}

function fh_chulInfoAll2(stdYear, prdArea){
	
	$.ajax({
	    type : 'get',
	    url : "/reseach/chulInfo2.json",
	    data : {
	    	stdYear : stdYear,
	    	prdArea : prdArea
	    },
	    dataType : 'json',   	           
	    success : function(res){        
	    	
	    	var resultList = res.chulInfoList2;
	    	var html = "";
		    var html2 = "";
		    
		    var resultList = res.chulInfoList2;
	    	var chulCnt = 0;
	    	var prdArea = 0;
	    	var yearQty = 0;
	    	var yearAmt = 0;
	    	
	    	var lastChulCnt = 0;
	    	var lastPrdArea = 0;
	    	var lastYearQty = 0;
	    	var lastYearAmt = 0;
	    	
	    	
	    	if(resultList.length > 0){
	    		for(var i=0; i<resultList.length; i++){
	    			chulCnt = chulCnt+resultList[i].chulCnt;
	    			prdArea = prdArea+resultList[i].prdArea;
	    			yearQty = yearQty+resultList[i].yearQty;
	    			yearAmt = yearAmt+resultList[i].yearAmt;
	    			
	    			if(i==3 || i==4){
	    				// 제주 강원 합산
	    				lastChulCnt = lastChulCnt+resultList[i].chulCnt;
	    				lastPrdArea = lastPrdArea+resultList[i].prdArea;
	    				lastYearQty = lastYearQty+resultList[i].yearQty;
	    				lastYearAmt = lastYearAmt+resultList[i].yearAmt;
	    			}
	    		}
	    		
	    		$("#mainArea").html("전체");
	    		$("#mainChulCnt").html(comma(chulCnt) + "호");
		    	$("#mainPrdArea").html(comma(prdArea) + "ha");
		    	$("#mainYearChulQty").html(comma(yearQty) + "만단");
		    	$("#mainYearChulAmt").html(comma(yearAmt) + "억원");
	    	}
		    
	    	if(resultList.length > 0){
	    		/*메인*/
	    		/*
		    	$("#mainArea").html(resultList[0].sidoName);
		    	$("#mainChulCnt").html(comma(resultList[0].chulCnt) + "호");
		    	$("#mainPrdArea").html(comma(resultList[0].prdArea) + "ha");
		    	$("#mainYearChulQty").html(comma(resultList[0].yearQty) + "만단");
		    	$("#mainYearChulAmt").html(comma(resultList[0].yearAmt) + "억원");
		    	*/
		    	
		    	/*서브*/
		    	
		    	for(var i=0; i<resultList.length; i++){
		    		if(i != 3 && i!= 4){
		    			if(i<3){
			    			html +="<li>                                                  ";
							html +="	<h4 class=\"tit_si\">"+resultList[i].sidoName+"</h4>                     ";
							html +="	<div class=\"state_data\">                        ";
							html +="		<dl>                                          ";
							html +="			<dt><p class=\"sd_tit\">재배농가 수</p></dt>   ";
							html +="			<dd><p class=\"sd_num\"> "+comma(resultList[i].chulCnt)+"호</p></dd>     ";
							html +="		</dl>                                         ";
							html +="		<dl>                                          ";
							html +="			<dt><p class=\"sd_tit\">재배면적</p></dt>     ";
							html +="			<dd><p class=\"sd_num\">"+comma(resultList[i].prdArea)+"ha</p></dd>    ";
							html +="		</dl>                                         ";
							html +="		<dl>                                          ";
							html +="			<dt><p class=\"sd_tit\">연간출하량</p></dt>    ";
							html +="			<dd><p class=\"sd_num\">"+comma(resultList[i].yearQty)+"만단</p></dd>   ";
							html +="		</dl>                                         ";
							html +="		<dl>                                          ";
							html +="			<dt><h4 class=\"sd_tit\">연간출하액</p></dt>   ";
							html +="			<dd><p class=\"sd_num\">"+comma(resultList[i].yearAmt)+"억원</p></dd>    ";
							html +="		</dl>                                         ";
							html +="	</div>                                            ";
							html +="</li>                                                 ";
			    		}else{
			    			html2 +="<li>                                                  ";
							html2 +="	<h4 class=\"tit_si\">"+resultList[i].sidoName+"</h4>                     ";
							html2 +="	<div class=\"state_data\">                        ";
							html2 +="		<dl>                                          ";
							html2 +="			<dt><p class=\"sd_tit\">재배농가 수</p></dt>   ";
							html2 +="			<dd><p class=\"sd_num\"> "+comma(resultList[i].chulCnt)+"호</p></dd>     ";
							html2 +="		</dl>                                         ";
							html2 +="		<dl>                                          ";
							html2 +="			<dt><p class=\"sd_tit\">재배면적</p></dt>     ";
							html2 +="			<dd><p class=\"sd_num\">"+comma(resultList[i].prdArea)+"ha</p></dd>    ";
							html2 +="		</dl>                                         ";
							html2 +="		<dl>                                          ";
							html2 +="			<dt><p class=\"sd_tit\">연간출하량</p></dt>    ";
							html2 +="			<dd><p class=\"sd_num\">"+comma(resultList[i].yearQty)+"만단</p></dd>   ";
							html2 +="		</dl>                                         ";
							html2 +="		<dl>                                          ";
							html2 +="			<dt><h4 class=\"sd_tit\">연간출하액</p></dt>   ";
							html2 +="			<dd><p class=\"sd_num\">"+comma(resultList[i].yearAmt)+"억원</p></dd>    ";
							html2 +="		</dl>                                         ";
							html2 +="	</div>                                            ";
							html2 +="</li>                                                 ";
			    		}
		    		}
		    	}
		    	
		    	html2 +="<li>                                                  ";
				html2 +="	<h4 class=\"tit_si\">강원,제주</h4>                     ";
				html2 +="	<div class=\"state_data\">                        ";
				html2 +="		<dl>                                          ";
				html2 +="			<dt><p class=\"sd_tit\">재배농가 수</p></dt>   ";
				html2 +="			<dd><p class=\"sd_num\"> "+comma(lastChulCnt)+"호</p></dd>     ";
				html2 +="		</dl>                                         ";
				html2 +="		<dl>                                          ";
				html2 +="			<dt><p class=\"sd_tit\">재배면적</p></dt>     ";
				html2 +="			<dd><p class=\"sd_num\">"+comma(lastPrdArea)+"ha</p></dd>    ";
				html2 +="		</dl>                                         ";
				html2 +="		<dl>                                          ";
				html2 +="			<dt><p class=\"sd_tit\">연간출하량</p></dt>    ";
				html2 +="			<dd><p class=\"sd_num\">"+comma(lastYearQty)+"만단</p></dd>   ";
				html2 +="		</dl>                                         ";
				html2 +="		<dl>                                          ";
				html2 +="			<dt><h4 class=\"sd_tit\">연간출하액</p></dt>   ";
				html2 +="			<dd><p class=\"sd_num\">"+comma(lastYearAmt)+"억원</p></dd>    ";
				html2 +="		</dl>                                         ";
				html2 +="	</div>                                            ";
				html2 +="</li>                                                 ";
		    	
		    	
	    	}else{
	    		
	    		$("#mainArea").html("정보없음");
		    	$("#mainChulCnt").html("0호");
		    	$("#mainPrdArea").html("0ha");
		    	$("#mainYearChulQty").html("0만단");
		    	$("#mainYearChulAmt").html("0억원");
	    		
	    	}
	    	
	    	
	    	$("#subDiv").html(html);
	    	$("#subDiv2").html(html2);
	    	
	    },
	});
}

function fh_chulInfoEach(stdYear, sidoCode, sigunCode, prdArea){
	
	$.ajax({
	    type : 'get',
	    url : "/reseach/chulInfoEach.json",
	    data : {
	    	stdYear : stdYear,
	    	sidoCode : sidoCode,
	    	agCode : sigunCode,
	    	prdArea : prdArea
	    },
	    dataType : 'json',   	           
	    success : function(res){        
	    	var resultVO = res.chulInfoVO;
	    	var resultList = res.chulInfoList;
	    	
	    	var html = "";
	    	var html2 = "";
	    	
	    	if(resultVO == null){
	    		$("#mainArea").html("정보없음");
		    	$("#mainChulCnt").html("0호");
		    	$("#mainPrdArea").html("0ha");
		    	$("#mainYearChulQty").html("0만단");
		    	$("#mainYearChulAmt").html("0억원");
	    		
	    	}else{
	    		$("#mainArea").html(resultVO.areaName);
		    	$("#mainChulCnt").html(comma(resultVO.chulCnt) + "호");
		    	$("#mainPrdArea").html(comma(resultVO.prdArea) + "ha");
		    	$("#mainYearChulQty").html(comma(resultVO.yearQty) + "만단");
		    	$("#mainYearChulAmt").html(comma(resultVO.yearAmt) + "억원");
		    	
		    	
		    	var listLength = resultList.length;
		    	if(listLength > 6){
		    		listLength = 6;
		    	}
		    	
		    	for(var i=0; i<listLength; i++){
		    		if(i<3){
		    			html +="<li>                                                  ";
						html +="	<h4 class=\"tit_si\">"+resultList[i].areaName+"</h4>                     ";
						html +="	<div class=\"state_data\">                        ";
						html +="		<dl>                                          ";
						html +="			<dt><p class=\"sd_tit\">재배농가 수</p></dt>   ";
						html +="			<dd><p class=\"sd_num\"> "+comma(resultList[i].chulCnt)+"호</p></dd>     ";
						html +="		</dl>                                         ";
						html +="		<dl>                                          ";
						html +="			<dt><p class=\"sd_tit\">재배면적</p></dt>     ";
						html +="			<dd><p class=\"sd_num\">"+comma(resultList[i].prdArea)+"ha</p></dd>    ";
						html +="		</dl>                                         ";
						html +="		<dl>                                          ";
						html +="			<dt><p class=\"sd_tit\">연간출하량</p></dt>    ";
						html +="			<dd><p class=\"sd_num\">"+comma(resultList[i].yearQty)+"만단</p></dd>   ";
						html +="		</dl>                                         ";
						html +="		<dl>                                          ";
						html +="			<dt><h4 class=\"sd_tit\">연간출하액</p></dt>   ";
						html +="			<dd><p class=\"sd_num\">"+comma(resultList[i].yearAmt)+"억원</p></dd>    ";
						html +="		</dl>                                         ";
						html +="	</div>                                            ";
						html +="</li>                                                 ";
		    		}else{
		    			html2 +="<li>                                                  ";
						html2 +="	<h4 class=\"tit_si\">"+resultList[i].areaName+"</h4>                     ";
						html2 +="	<div class=\"state_data\">                        ";
						html2 +="		<dl>                                          ";
						html2 +="			<dt><p class=\"sd_tit\">재배농가 수</p></dt>   ";
						html2 +="			<dd><p class=\"sd_num\"> "+comma(resultList[i].chulCnt)+"호</p></dd>     ";
						html2 +="		</dl>                                         ";
						html2 +="		<dl>                                          ";
						html2 +="			<dt><p class=\"sd_tit\">재배면적</p></dt>     ";
						html2 +="			<dd><p class=\"sd_num\">"+comma(resultList[i].prdArea)+"ha</p></dd>    ";
						html2 +="		</dl>                                         ";
						html2 +="		<dl>                                          ";
						html2 +="			<dt><p class=\"sd_tit\">연간출하량</p></dt>    ";
						html2 +="			<dd><p class=\"sd_num\">"+comma(resultList[i].yearQty)+"만단</p></dd>   ";
						html2 +="		</dl>                                         ";
						html2 +="		<dl>                                          ";
						html2 +="			<dt><h4 class=\"sd_tit\">연간출하액</p></dt>   ";
						html2 +="			<dd><p class=\"sd_num\">"+comma(resultList[i].yearAmt)+"억원</p></dd>    ";
						html2 +="		</dl>                                         ";
						html2 +="	</div>                                            ";
						html2 +="</li>                                                 ";
		    		}
					
		    	}
	    	}
	    	
	    	$("#subDiv").html(html);
	    	$("#subDiv2").html(html2);
	    },
	});
}

function fh_chulInfoEach2(stdYear, sidoCode, sigunCode, prdArea){
	
	$.ajax({
	    type : 'get',
	    url : "/reseach/chulInfoEach2.json",
	    data : {
	    	stdYear : stdYear,
	    	sidoCode : sidoCode,
	    	agCode : sigunCode,
	    	prdArea : prdArea
	    },
	    dataType : 'json',   	           
	    success : function(res){        
	    	var resultVO = res.chulInfoVO;
	    	var resultList = res.chulInfoList;
	    	
	    	var html = "";
	    	var html2 = "";
	    	
	    	if(resultVO == null){
	    		$("#mainArea").html("정보없음");
		    	$("#mainChulCnt").html("0호");
		    	$("#mainPrdArea").html("0ha");
		    	$("#mainYearChulQty").html("0만단");
		    	$("#mainYearChulAmt").html("0억원");
	    		
	    	}else{
	    		$("#mainArea").html(resultVO.areaName);
		    	$("#mainChulCnt").html(comma(resultVO.chulCnt) + "호");
		    	$("#mainPrdArea").html(comma(resultVO.prdArea) + "ha");
		    	$("#mainYearChulQty").html(comma(resultVO.yearQty) + "만단");
		    	$("#mainYearChulAmt").html(comma(resultVO.yearAmt) + "억원");
		    	
		    	
		    	var listLength = resultList.length;
		    	if(listLength > 6){
		    		listLength = 6;
		    	}
		    	
		    	for(var i=0; i<listLength; i++){
		    		if(i<3){
		    			html +="<li>                                                  ";
						html +="	<h4 class=\"tit_si\">"+resultList[i].areaName+"</h4>                     ";
						html +="	<div class=\"state_data\">                        ";
						html +="		<dl>                                          ";
						html +="			<dt><p class=\"sd_tit\">재배농가 수</p></dt>   ";
						html +="			<dd><p class=\"sd_num\"> "+comma(resultList[i].chulCnt)+"호</p></dd>     ";
						html +="		</dl>                                         ";
						html +="		<dl>                                          ";
						html +="			<dt><p class=\"sd_tit\">재배면적</p></dt>     ";
						html +="			<dd><p class=\"sd_num\">"+comma(resultList[i].prdArea)+"ha</p></dd>    ";
						html +="		</dl>                                         ";
						html +="		<dl>                                          ";
						html +="			<dt><p class=\"sd_tit\">연간출하량</p></dt>    ";
						html +="			<dd><p class=\"sd_num\">"+comma(resultList[i].yearQty)+"만단</p></dd>   ";
						html +="		</dl>                                         ";
						html +="		<dl>                                          ";
						html +="			<dt><h4 class=\"sd_tit\">연간출하액</p></dt>   ";
						html +="			<dd><p class=\"sd_num\">"+comma(resultList[i].yearAmt)+"억원</p></dd>    ";
						html +="		</dl>                                         ";
						html +="	</div>                                            ";
						html +="</li>                                                 ";
		    		}else{
		    			html2 +="<li>                                                  ";
						html2 +="	<h4 class=\"tit_si\">"+resultList[i].areaName+"</h4>                     ";
						html2 +="	<div class=\"state_data\">                        ";
						html2 +="		<dl>                                          ";
						html2 +="			<dt><p class=\"sd_tit\">재배농가 수</p></dt>   ";
						html2 +="			<dd><p class=\"sd_num\"> "+comma(resultList[i].chulCnt)+"호</p></dd>     ";
						html2 +="		</dl>                                         ";
						html2 +="		<dl>                                          ";
						html2 +="			<dt><p class=\"sd_tit\">재배면적</p></dt>     ";
						html2 +="			<dd><p class=\"sd_num\">"+comma(resultList[i].prdArea)+"ha</p></dd>    ";
						html2 +="		</dl>                                         ";
						html2 +="		<dl>                                          ";
						html2 +="			<dt><p class=\"sd_tit\">연간출하량</p></dt>    ";
						html2 +="			<dd><p class=\"sd_num\">"+comma(resultList[i].yearQty)+"만단</p></dd>   ";
						html2 +="		</dl>                                         ";
						html2 +="		<dl>                                          ";
						html2 +="			<dt><h4 class=\"sd_tit\">연간출하액</p></dt>   ";
						html2 +="			<dd><p class=\"sd_num\">"+comma(resultList[i].yearAmt)+"억원</p></dd>    ";
						html2 +="		</dl>                                         ";
						html2 +="	</div>                                            ";
						html2 +="</li>                                                 ";
		    		}
					
		    	}
	    	}
	    	
	    	$("#subDiv").html(html);
	    	$("#subDiv2").html(html2);
	    },
	});
}
//-----------------------차트 설정 시작-----------------------
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
	     +'<SubCaption text="%" textAlign="left" />'
	     +'<Legend defaultMouseOverAction="false" useVisibleCheck="true"/>'
	    +'</Options>'
	    +'<NumberFormatter id="numFmt" useThousandsSeparator="true"/>'
	   +'<Column2DChart showDataTips="true" columnWidthRatio="0.7" selectionMode="single" displayCompleteCallFunction="displayCallFunction" dataTipJsFunction="dataTipFuncPer" >'
	       +'<horizontalAxis>'
	       	+'<CategoryAxis  id="hAxis" categoryField="cateName" padding="0.4"/>'
	        +'</horizontalAxis>'
	        +'<verticalAxis>'
	           +'<LinearAxis id="vAxis"  formatter="{numFmt}" maximum="100"/>'
	       +'</verticalAxis>'
	          +'<series>'
	          +'<Column2DSeries yField="b2r2c1" displayName="자가" halfWidthOffset="20" labelPosition="outside">'
	          		+'<fill>'
		            	+'<SolidColor color="#536BC9" alpha="1"/>'
		            +'</fill>'
                    +'<showDataEffect>'
	                  +'<SeriesInterpolate/>'
	                +'</showDataEffect>'
		            +'</Column2DSeries>'
		      +'<Column2DSeries yField="b2r3c1" displayName="임차" halfWidthOffset="20" labelPosition="outside">'
		      		+'<fill>'
		          		+'<SolidColor color="#4DC189" alpha="1"/>'
		          	+'</fill>'
	                +'<showDataEffect>'
	                   +'<SeriesInterpolate/>'
	               +'</showDataEffect>'
	          +'</Column2DSeries>'
	        +'</series>'
	        +'<horizontalAxisRenderers>'
            +'<Axis2DRenderer axis="{hAxis}" minorTickLength="0" tickPlacement="outside" minorTickPlacement="cross" placement="bottom" canDropLabels="true" showLabels="false" showLine="true" labelAlign="center">'
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
	     +'<SubCaption text="%" textAlign="left" />'
	     +'<Legend defaultMouseOverAction="false" useVisibleCheck="true" />'
	    +'</Options>'
	    +'<NumberFormatter id="numFmt" useThousandsSeparator="true"/>'
	   +'<Column2DChart showDataTips="true" columnWidthRatio="0.7" selectionMode="single" displayCompleteCallFunction="displayCallFunction"   dataTipJsFunction="dataTipFuncPer"  >'
	       +'<horizontalAxis>'
	       	+'<CategoryAxis  id="hAxis" categoryField="cateName" padding="0.4"/>'
	        +'</horizontalAxis>'
	        +'<verticalAxis>'
	           +'<LinearAxis id="vAxis"  formatter="{numFmt}" maximum="100"/>'
	       +'</verticalAxis>'
	          +'<series>'
	          +'<Column2DSeries yField="b2r1c3" displayName="시설" halfWidthOffset="20" labelPosition="outside">'
	          		+'<fill>'
		            	+'<SolidColor color="#F1B95F" alpha="1"/>'
		            +'</fill>'
	                +'<showDataEffect>'
	                  +'<SeriesInterpolate/>'
	                +'</showDataEffect>'
		            +'</Column2DSeries>'
		      +'<Column2DSeries yField="b2r1c2" displayName="노지" halfWidthOffset="20" labelPosition="outside">'
		      		+'<fill>'
		          		+'<SolidColor color="#715FB9" alpha="1"/>'
		          	+'</fill>'
	                +'<showDataEffect>'
	                   +'<SeriesInterpolate/>'
	               +'</showDataEffect>'
	          +'</Column2DSeries>'
	        +'</series>'
	        +'<horizontalAxisRenderers>'
	        +'<Axis2DRenderer axis="{hAxis}" minorTickLength="0" tickPlacement="outside" minorTickPlacement="cross" placement="bottom" canDropLabels="true" showLabels="false" showLine="true" labelAlign="center">'
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
	     +'<Legend defaultMouseOverAction="false" useVisibleCheck="true"/>'
	    +'</Options>'
	    +'<NumberFormatter id="numFmt" useThousandsSeparator="true"/>'
	   +'<Column2DChart showDataTips="true" columnWidthRatio="0.7" selectionMode="single" displayCompleteCallFunction="displayCallFunction"  dataTipJsFunction="dataTipFuncPer"  >'
	       +'<horizontalAxis>'
	       	+'<CategoryAxis  id="hAxis" categoryField="cateName" padding="0.4"/>'
	        +'</horizontalAxis>'
	        +'<verticalAxis>'
	           +'<LinearAxis id="vAxis"  formatter="{numFmt}" maximum="100"/>'
	       +'</verticalAxis>'
	          +'<series>'
	          	+'<Column2DSeries yField="b2r1c6" displayName="철파이프" halfWidthOffset="10" labelPosition="outside">'
	          		+'<fill>'
		            	+'<SolidColor color="#536BC9" alpha="1"/>'
		            +'</fill>'
		              +'<showDataEffect>'
		                 +'<SeriesInterpolate/>'
		             +'</showDataEffect>'
			        +'</Column2DSeries>'
			     +'<Column2DSeries yField="b2r1c4" displayName="철골유리" halfWidthOffset="10" labelPosition="outside">'
				     +'<fill>'
		            	+'<SolidColor color="#4DC189" alpha="1"/>'
		            +'</fill>'
			        +'<showDataEffect>'
			           +'<SeriesInterpolate/>'
			       +'</showDataEffect>'
			       +'</Column2DSeries>'
			       +'<Column2DSeries yField="b2r1c5" displayName="철골경질" halfWidthOffset="10" labelPosition="outside">'
			       +'<fill>'
		            	+'<SolidColor color="#F1B95F" alpha="1"/>'
		            +'</fill>'
			       +'<showDataEffect>'
			          +'<SeriesInterpolate/>'
			      +'</showDataEffect>'
			      +'</Column2DSeries>'
			      +'<Column2DSeries yField="b2r1c7" displayName="기타" halfWidthOffset="10" labelPosition="outside">'
				      +'<fill>'
		            	+'<SolidColor color="#715FB9" alpha="1"/>'
		            +'</fill>'
			          +'<showDataEffect>'
			             +'<SeriesInterpolate/>'
			         +'</showDataEffect>'
			      +'</Column2DSeries>'
	        +'</series>'
	        +'<horizontalAxisRenderers>'
	        +'<Axis2DRenderer axis="{hAxis}" minorTickLength="0" tickPlacement="outside" minorTickPlacement="cross" placement="bottom" canDropLabels="true" showLabels="false" showLine="true" labelAlign="center">'
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
				        +'<Caption text=""/>'
				          +'<Legend useVisibleCheck="true"/>'
				     +'</Options>'
				   +'<Pie2DChart id="chart4" innerRadius="0.5" showDataTips="true" selectionMode="single">'
				 /* 
				Doughnut2D 차트 생성시에 필요한 Pie2DChart 정의합니다 
				  showDataTips : 데이터에 마우스를 가져갔을 때 나오는 Tip을 보이기/안보이기 속성입니다.  
				innerRadius : PieChart 가운데에 빈 공간을 만듭니다. 유효값 0.1 ~ 0.9 0은 PieChart 1은 차트 사라짐
				*/
				        +'<series>'
				             +'<Pie2DSeries nameField="cateName" field="val" startAngle="20" renderDirection="clockwise" labelPosition="inside" color="#ffffff">'
				                +'<fills>'
				                    +'<SolidColor color="#20cbc2"/>'
				                    +'<SolidColor color="#074d81"/>'
				                +'</fills>'
				             /* Pie2DChart 정의 후 Pie2DSeries labelPosition="inside"정의합니다 */
				                 +'<showDataEffect>'
				                 /* 차트 생성시에 Effect를 주고 싶을 때 shoDataEffect정의합니다 */
				                      +'<SeriesZoom duration="1000"/>'
				/* 
				SeriesZoom 효과는 시리즈 데이터가 데이터로 표시될 때 특정 지점에서 점점 확대되어지며 나타나는 효과를 적용합니다
				- 공통속성 -                        
				  elementOffset : effect를 지연시키는 시간을 지정합니다 default:20
				minimumElementDuration : 각 엘리먼트의 최소 지속 시간을 설정합니다 default:0
				             이 값보다 짧은 시간에 effect가 실행되지 않습니다
				offset : effect개시의 지연시간을 설정합니다 default:0
				  perElementOffset : 각 엘리먼트의 개시 지연시간을 설정합니다
				 - SeriesZoom속성 -
				  relativeTo : 이펙트의 기준을 어디로 잡을지에 대한 속성입니다. 유효값 : chart, series
				  horizontalFocus : relativeTo를 기준으로 수평선 방향의 기준을 정합니다. 유효값 : left, center, right
				verticalFocus : relativeTo를 기준으로 수직선 방향의 기준을 정합니다. 유효값 : top, middle, bottom
				  */
				                +'</showDataEffect>'
				            +'</Pie2DSeries>'
				       +'</series>'
				        +'<backgroundElements>'
				             +'<CanvasElement>'
				                  +'<Label text="" height="24" horizontalCenter="0" verticalCenter="-10" fontSize="19" color="#333333" backgroundAlpha="0"/>'
				                 +'<Label text="" height="24" horizontalCenter="0" verticalCenter="10" fontSize="14" color="#666666" backgroundAlpha="0"/>'
				             +'</CanvasElement>'
				         +'</backgroundElements>'
				    +'</Pie2DChart>'
				+'</rMateChart>';

   
var layoutStr5 = 
	'<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'
	    +'<Options>'
	     +'<SubCaption text="%" textAlign="left" />'
	     +'<Legend defaultMouseOverAction="false" useVisibleCheck="true" />'
	    +'</Options>'
	    +'<NumberFormatter id="numFmt" useThousandsSeparator="true"/>'
	   +'<Column2DChart showDataTips="true" columnWidthRatio="0.7" selectionMode="single" displayCompleteCallFunction="displayCallFunction"  dataTipJsFunction="dataTipFuncPer"  >'
	       +'<horizontalAxis>'
	       	+'<CategoryAxis  id="hAxis" categoryField="cateName" padding="0.4"/>'
	        +'</horizontalAxis>'
	        +'<verticalAxis>'
	           +'<LinearAxis id="vAxis"  formatter="{numFmt}" maximum="100"/>'
	       +'</verticalAxis>'
	          +'<series>'
	          	+'<Column2DSeries yField="b3c02" displayName="토경재배" halfWidthOffset="15" labelPosition="outside">'
	          		+'<fill>'
		            	+'<SolidColor color="#536BC9" alpha="1"/>'
		            +'</fill>'
		              +'<showDataEffect>'
		                 +'<SeriesInterpolate/>'
		             +'</showDataEffect>'
			        +'</Column2DSeries>'
			     +'<Column2DSeries yField="b3c03" displayName="고형배지" halfWidthOffset="15" labelPosition="outside">'
				     +'<fill>'
		            	+'<SolidColor color="#4DC189" alpha="1"/>'
		            +'</fill>'
			        +'<showDataEffect>'
			           +'<SeriesInterpolate/>'
			       +'</showDataEffect>'
			       +'</Column2DSeries>'
			       +'<Column2DSeries yField="b3c07" displayName="순수수경" halfWidthOffset="15" labelPosition="outside">'
			       +'<fill>'
		            	+'<SolidColor color="#F1B95F" alpha="1"/>'
		            +'</fill>'
			       +'<showDataEffect>'
			          +'<SeriesInterpolate/>'
			      +'</showDataEffect>'
			      +'</Column2DSeries>'
	        +'</series>'
	        +'<horizontalAxisRenderers>'
	        +'<Axis2DRenderer axis="{hAxis}" minorTickLength="0" tickPlacement="outside" minorTickPlacement="cross" placement="bottom" canDropLabels="true" showLabels="false" showLine="true" labelAlign="center">'
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
	
   
var layoutStr6 = 
	'<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'
    +'<Options>'
     +'<SubCaption text="%" textAlign="left" />'
     +'<Legend defaultMouseOverAction="false" useVisibleCheck="true" />'
    +'</Options>'
    +'<NumberFormatter id="numFmt" useThousandsSeparator="true"/>'
   +'<Column2DChart showDataTips="true" columnWidthRatio="0.7" selectionMode="single" displayCompleteCallFunction="displayCallFunction"  dataTipJsFunction="dataTipFuncPer"  >'
       +'<horizontalAxis>'
       	+'<CategoryAxis  id="hAxis" categoryField="cateName" padding="0.4"/>'
        +'</horizontalAxis>'
        +'<verticalAxis>'
           +'<LinearAxis id="vAxis"  formatter="{numFmt}" maximum="100"/>'
       +'</verticalAxis>'
          +'<series>'
          +'<Column2DSeries yField="b4c03" displayName="가온" halfWidthOffset="20" labelPosition="outside">'
          		+'<fill>'
	            	+'<SolidColor color="#536BC9" alpha="1"/>'
	            +'</fill>'
                +'<showDataEffect>'
                  +'<SeriesInterpolate/>'
                +'</showDataEffect>'
	            +'</Column2DSeries>'
	      +'<Column2DSeries yField="b4c02" displayName="무가온" halfWidthOffset="20" labelPosition="outside">'
	      		+'<fill>'
	          		+'<SolidColor color="#4DC189" alpha="1"/>'
	          	+'</fill>'
                +'<showDataEffect>'
                   +'<SeriesInterpolate/>'
               +'</showDataEffect>'
          +'</Column2DSeries>'
        +'</series>'
        +'<horizontalAxisRenderers>'
        +'<Axis2DRenderer axis="{hAxis}" minorTickLength="0" tickPlacement="outside" minorTickPlacement="cross" placement="bottom" canDropLabels="true" showLabels="false" showLine="true" labelAlign="center">'
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
 
   
var layoutStr7 = 
	'<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'
	    +'<Options>'
	     +'<SubCaption text="%" textAlign="left" />'
	     +'<Legend defaultMouseOverAction="false" useVisibleCheck="true" />'
	    +'</Options>'
	    +'<NumberFormatter id="numFmt" useThousandsSeparator="true"/>'
	   +'<Column2DChart showDataTips="true" columnWidthRatio="0.7" selectionMode="single" displayCompleteCallFunction="displayCallFunction"  dataTipJsFunction="dataTipFuncPer"  >'
	       +'<horizontalAxis>'
	       	+'<CategoryAxis  id="hAxis" categoryField="cateName" padding="0.4"/>'
	        +'</horizontalAxis>'
	        +'<verticalAxis>'
	           +'<LinearAxis id="vAxis"  formatter="{numFmt}" maximum="100"/>'
	       +'</verticalAxis>'
	          +'<series>'
	          +'<Column2DSeries yField="b5c03" displayName="보온" halfWidthOffset="20" labelPosition="outside">'
	          		+'<fill>'
		            	+'<SolidColor color="#F1B95F" alpha="1"/>'
		            +'</fill>'
	                +'<showDataEffect>'
	                  +'<SeriesInterpolate/>'
	                +'</showDataEffect>'
		            +'</Column2DSeries>'
		      +'<Column2DSeries yField="b5c02" displayName="무보온" halfWidthOffset="20" labelPosition="outside">'
		      		+'<fill>'
		          		+'<SolidColor color="#715FB9" alpha="1"/>'
		          	+'</fill>'
	                +'<showDataEffect>'
	                   +'<SeriesInterpolate/>'
	               +'</showDataEffect>'
	          +'</Column2DSeries>'
	        +'</series>'
	        +'<horizontalAxisRenderers>'
	        +'<Axis2DRenderer axis="{hAxis}" minorTickLength="0" tickPlacement="outside" minorTickPlacement="cross" placement="bottom" canDropLabels="true" showLabels="false" showLine="true" labelAlign="center">'
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
	 
   
var layoutStr8 = 
	'<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'
	    +'<Options>'
	     +'<SubCaption text="명" textAlign="left" />'
	     +'<Legend defaultMouseOverAction="false" useVisibleCheck="true" />'
	    +'</Options>'
	    +'<NumberFormatter id="numFmt" useThousandsSeparator="true"/>'
	   +'<Column2DChart showDataTips="true" columnWidthRatio="0.7" selectionMode="single" displayCompleteCallFunction="displayCallFunction"  dataTipJsFunction="dataTipFunc"  >'
	       +'<horizontalAxis>'
	       	+'<CategoryAxis  id="hAxis" categoryField="cateName" padding="0.4"/>'
	        +'</horizontalAxis>'
	        +'<verticalAxis>'
	           +'<LinearAxis id="vAxis"  formatter="{numFmt}"/>'
	       +'</verticalAxis>'
	          +'<series>'
	          	+'<Column2DSeries yField="b1r1c3" displayName="자가인력" halfWidthOffset="10" labelPosition="outside">'
	          		+'<fill>'
		            	+'<SolidColor color="#536BC9" alpha="1"/>'
		            +'</fill>'
		              +'<showDataEffect>'
		                 +'<SeriesInterpolate/>'
		             +'</showDataEffect>'
			        +'</Column2DSeries>'
			     +'<Column2DSeries yField="b1r1c2" displayName="상시고용직" halfWidthOffset="10" labelPosition="outside">'
				     +'<fill>'
		            	+'<SolidColor color="#4DC189" alpha="1"/>'
		            +'</fill>'
			        +'<showDataEffect>'
			           +'<SeriesInterpolate/>'
			       +'</showDataEffect>'
			       +'</Column2DSeries>'
			       +'<Column2DSeries yField="b1r1c4" displayName="임시직" halfWidthOffset="10" labelPosition="outside">'
			       +'<fill>'
		            	+'<SolidColor color="#F1B95F" alpha="1"/>'
		            +'</fill>'
			       +'<showDataEffect>'
			          +'<SeriesInterpolate/>'
			      +'</showDataEffect>'
			      +'</Column2DSeries>'
			      +'<Column2DSeries yField="b1r1c5" displayName="성수기 임시직" halfWidthOffset="10" labelPosition="outside">'
				      +'<fill>'
		            	+'<SolidColor color="#715FB9" alpha="1"/>'
		            +'</fill>'
			          +'<showDataEffect>'
			             +'<SeriesInterpolate/>'
			         +'</showDataEffect>'
			      +'</Column2DSeries>'
	        +'</series>'
	        +'<horizontalAxisRenderers>'
	        +'<Axis2DRenderer axis="{hAxis}" minorTickLength="0" tickPlacement="outside" minorTickPlacement="cross" placement="bottom" canDropLabels="true" showLabels="false" showLine="true" labelAlign="center">'
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
	 
   
var layoutStr9 = 
	'<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'
	    +'<Options>'
	        +'<Caption text=""/>'
	          +'<Legend useVisibleCheck="true"/>'
	     +'</Options>'
	   +'<Pie2DChart id="chart4" innerRadius="0.5" showDataTips="true" selectionMode="single">'
	 /* 
	Doughnut2D 차트 생성시에 필요한 Pie2DChart 정의합니다 
	  showDataTips : 데이터에 마우스를 가져갔을 때 나오는 Tip을 보이기/안보이기 속성입니다.  
	innerRadius : PieChart 가운데에 빈 공간을 만듭니다. 유효값 0.1 ~ 0.9 0은 PieChart 1은 차트 사라짐
	*/
	        +'<series>'
	             +'<Pie2DSeries nameField="cateName" field="val" startAngle="20" renderDirection="clockwise" labelPosition="inside" color="#ffffff">'
	                +'<fills>'
	                    +'<SolidColor color="#20cbc2"/>'
	                    +'<SolidColor color="#074d81"/>'
	                    +'<SolidColor color="#40b2e6"/>'
	                +'</fills>'
	             /* Pie2DChart 정의 후 Pie2DSeries labelPosition="inside"정의합니다 */
	                 +'<showDataEffect>'
	                 /* 차트 생성시에 Effect를 주고 싶을 때 shoDataEffect정의합니다 */
	                      +'<SeriesZoom duration="1000"/>'
	/* 
	SeriesZoom 효과는 시리즈 데이터가 데이터로 표시될 때 특정 지점에서 점점 확대되어지며 나타나는 효과를 적용합니다
	- 공통속성 -                        
	  elementOffset : effect를 지연시키는 시간을 지정합니다 default:20
	minimumElementDuration : 각 엘리먼트의 최소 지속 시간을 설정합니다 default:0
	             이 값보다 짧은 시간에 effect가 실행되지 않습니다
	offset : effect개시의 지연시간을 설정합니다 default:0
	  perElementOffset : 각 엘리먼트의 개시 지연시간을 설정합니다
	 - SeriesZoom속성 -
	  relativeTo : 이펙트의 기준을 어디로 잡을지에 대한 속성입니다. 유효값 : chart, series
	  horizontalFocus : relativeTo를 기준으로 수평선 방향의 기준을 정합니다. 유효값 : left, center, right
	verticalFocus : relativeTo를 기준으로 수직선 방향의 기준을 정합니다. 유효값 : top, middle, bottom
	  */
	                +'</showDataEffect>'
	            +'</Pie2DSeries>'
	       +'</series>'
	        +'<backgroundElements>'
	             +'<CanvasElement>'
	                  +'<Label text="" height="24" horizontalCenter="0" verticalCenter="-10" fontSize="19" color="#333333" backgroundAlpha="0"/>'
	                 +'<Label text="" height="24" horizontalCenter="0" verticalCenter="10" fontSize="14" color="#666666" backgroundAlpha="0"/>'
	             +'</CanvasElement>'
	         +'</backgroundElements>'
	    +'</Pie2DChart>'
	+'</rMateChart>';
	
	
   
var layoutStr10 = "";
	

function valueLabelFunc(value){
  return value.toFixed(1) + "%";
}

function labelFunc(value)
{
   return '<font size="30">' + value + "\n%</font>";
}

	
	   
var layoutStr11 = 
	'<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'
	    +'<Options>'
	     +'<SubCaption text="명" textAlign="left" />'
	     +'<Legend defaultMouseOverAction="false" useVisibleCheck="true" />'
	    +'</Options>'
	    +'<NumberFormatter id="numFmt" useThousandsSeparator="true"/>'
	   +'<Column2DChart showDataTips="true" columnWidthRatio="0.7" selectionMode="single" displayCompleteCallFunction="displayCallFunction"  dataTipJsFunction="dataTipFunc"  >'
	       +'<horizontalAxis>'
	       	+'<CategoryAxis  id="hAxis" categoryField="cateName" padding="0.4"/>'
	        +'</horizontalAxis>'
	        +'<verticalAxis>'
	           +'<LinearAxis id="vAxis"  formatter="{numFmt}"/>'
	       +'</verticalAxis>'
	          +'<series>'
	          +'<Column2DSeries yField="b1r1c1" displayName="내국인" halfWidthOffset="20" labelPosition="outside">'
	          		+'<fill>'
		            	+'<SolidColor color="#536BC9" alpha="1"/>'
		            +'</fill>'
	                +'<showDataEffect>'
	                  +'<SeriesInterpolate/>'
	                +'</showDataEffect>'
		            +'</Column2DSeries>'
		      +'<Column2DSeries yField="b1r2c1" displayName="외국인" halfWidthOffset="20" labelPosition="outside">'
		      		+'<fill>'
		          		+'<SolidColor color="#4DC189" alpha="1"/>'
		          	+'</fill>'
	                +'<showDataEffect>'
	                   +'<SeriesInterpolate/>'
	               +'</showDataEffect>'
	          +'</Column2DSeries>'
	        +'</series>'
	        +'<horizontalAxisRenderers>'
	        +'<Axis2DRenderer axis="{hAxis}" minorTickLength="0" tickPlacement="outside" minorTickPlacement="cross" placement="bottom" canDropLabels="true" showLabels="false" showLine="true" labelAlign="center">'
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
	
		   
var layoutStr12 = 
	'<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'
	    +'<Options>'
	     +'<SubCaption text="%" textAlign="left" />'
	     +'<Legend defaultMouseOverAction="false" useVisibleCheck="true" />'
	    +'</Options>'
	    +'<NumberFormatter id="numFmt" useThousandsSeparator="true"/>'
	   +'<Column2DChart showDataTips="true" columnWidthRatio="0.7" selectionMode="single" displayCompleteCallFunction="displayCallFunction"  dataTipJsFunction="dataTipFuncPer"  >'
	       +'<horizontalAxis>'
	       	+'<CategoryAxis  id="hAxis" categoryField="cateName" padding="0.4"/>'
	        +'</horizontalAxis>'
	        +'<verticalAxis>'
	           +'<LinearAxis id="vAxis"  formatter="{numFmt}" maximum="100"/>'
	       +'</verticalAxis>'
	          +'<series>'
	          +'<Column2DSeries yField="b1r1c11" displayName="내국인" halfWidthOffset="20" labelPosition="outside">'
	          		+'<fill>'
		            	+'<SolidColor color="#F1B95F" alpha="1"/>'
		            +'</fill>'
	                +'<showDataEffect>'
	                  +'<SeriesInterpolate/>'
	                +'</showDataEffect>'
		            +'</Column2DSeries>'
		      +'<Column2DSeries yField="b1r2c11" displayName="외국인" halfWidthOffset="20" labelPosition="outside">'
		      		+'<fill>'
		          		+'<SolidColor color="#715FB9" alpha="1"/>'
		          	+'</fill>'
	                +'<showDataEffect>'
	                   +'<SeriesInterpolate/>'
	               +'</showDataEffect>'
	          +'</Column2DSeries>'
	        +'</series>'
	        +'<horizontalAxisRenderers>'
	        +'<Axis2DRenderer axis="{hAxis}" minorTickLength="0" tickPlacement="outside" minorTickPlacement="cross" placement="bottom" canDropLabels="true" showLabels="false" showLine="true" labelAlign="center">'
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

function fn_chart(stdYear, sidoCode, sigunCode, prdArea){
	$.ajax({
	    type : 'get',
	    url : "/reseach/chulInfoChart.json",
	    data : {
	    	stdYear : stdYear,
	    	sidoCode : sidoCode,
	    	agCode : sigunCode,
	    	prdArea : prdArea
	    },
	    dataType : 'json',   	           
	    success : function(res){        
	    	
	    	if(res.chulInfoChartVO.length > 0){
	    		chartData1 = res.chulInfoChartVO;
		    	chartData2 = res.chulInfoChartVO;
		    	chartData3 = res.chulInfoChartVO;
		    	
		    	chartData4 = [{
			            "cateName" : "단동",
			            "val" : res.chulInfoChartVO[0].dandong
			    },{
				    	"cateName" : "연동",
			            "val" : res.chulInfoChartVO[0].yundong
			    }];
		    	
		    	chartData5 = res.chulInfoChartVO;
		    	chartData6 = res.chulInfoChartVO;
		    	chartData7 = res.chulInfoChartVO;
		    	chartData8 = res.chulInfoChartVO;
		    	chartData9 = [{
				            "cateName" : "자가인력",
				            "val" : res.chulInfoChartVO[0].b1r1c31
				    },{
					    	"cateName" : "상시고용직",
				            "val" : res.chulInfoChartVO[0].b1r1c21
				    },{
					    	"cateName" : "임시직",
				            "val" : res.chulInfoChartVO[0].b1r1c41
				    }];
		    	
		    	chartData10 = [{"cateName":res.chulInfoChartVO[0].cateName,"all":res.chulInfoChartVO[0].b1r1c3+res.chulInfoChartVO[0].b1r1c2+res.chulInfoChartVO[0].b1r1c4,"b1r1c51":res.chulInfoChartVO[0].b1r1c5}];
		    	
		    	layoutStr10 = 
		    		'<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'
			    	    +'<Options>'
			    	     +'<Caption text="'+res.chulInfoChartVO[0].b1r1c51+'%" fontFamily="맑은 고딕" fontSize="30" />'
			    	     +'<SubCaption text="명" textAlign="left" />'
			    	     +'<Legend defaultMouseOverAction="false" useVisibleCheck="true" />'
			    	    +'</Options>'
			    	    +'<NumberFormatter id="numFmt" useThousandsSeparator="true"/>'
			    	   +'<Column2DChart showDataTips="true" columnWidthRatio="0.7" selectionMode="single" displayCompleteCallFunction="displayCallFunction"  dataTipJsFunction="dataTipFunc"  >'
			    	       +'<horizontalAxis>'
			    	       	+'<CategoryAxis  id="hAxis" categoryField="cateName" padding="0.4"/>'
			    	        +'</horizontalAxis>'
			    	        +'<verticalAxis>'
			    	           +'<LinearAxis id="vAxis"  formatter="{numFmt}"/>'
			    	       +'</verticalAxis>'
			    	          +'<series>'
			    	          +'<Column2DSeries yField="all" displayName="재배인력" halfWidthOffset="20" labelPosition="outside">'
			    	          		+'<fill>'
			    		            	+'<SolidColor color="#536BC9" alpha="1"/>'
			    		            +'</fill>'
			    	                +'<showDataEffect>'
			    	                  +'<SeriesInterpolate/>'
			    	                +'</showDataEffect>'
			    		            +'</Column2DSeries>'
			    		      +'<Column2DSeries yField="b1r1c51" displayName="성수기 임시직" halfWidthOffset="20" labelPosition="outside">'
			    		      		+'<fill>'
			    		          		+'<SolidColor color="#4DC189" alpha="1"/>'
			    		          	+'</fill>'
			    	                +'<showDataEffect>'
			    	                   +'<SeriesInterpolate/>'
			    	               +'</showDataEffect>'
			    	          +'</Column2DSeries>'
			    	        +'</series>'
			    	        +'<horizontalAxisRenderers>'
			    	        +'<Axis2DRenderer axis="{hAxis}" minorTickLength="0" tickPlacement="outside" minorTickPlacement="cross" placement="bottom" canDropLabels="true" showLabels="false" showLine="true" labelAlign="center">'
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
		    	
		    	chartData11 = res.chulInfoChartVO;
		    	chartData12 = res.chulInfoChartVO;
		    	$("#personTot").html(comma(res.chulInfoChartVO[0].personAll)+"명" );	    	
		    	$("#personAvg").html("평균 "+res.chulInfoChartVO[0].personAvg+"명");
		    	
		    	rMateChartH5.create("chart1", "chartHolder1", chartVars1, "100%", "100%");
		    	rMateChartH5.create("chart2", "chartHolder2", chartVars2, "100%", "100%");
		    	rMateChartH5.create("chart3", "chartHolder3", chartVars3, "100%", "100%");
		    	rMateChartH5.create("chart4", "chartHolder4", chartVars4, "100%", "100%");
		    	rMateChartH5.create("chart5", "chartHolder5", chartVars5, "100%", "100%");
		    	rMateChartH5.create("chart6", "chartHolder6", chartVars6, "100%", "100%");
		    	rMateChartH5.create("chart7", "chartHolder7", chartVars7, "100%", "100%");
		    	rMateChartH5.create("chart8", "chartHolder8", chartVars8, "100%", "100%");
		    	rMateChartH5.create("chart9", "chartHolder9", chartVars9, "100%", "100%");
		    	rMateChartH5.create("chart10", "chartHolder10", chartVars10, "100%", "100%");
		    	rMateChartH5.create("chart11", "chartHolder11", chartVars11, "100%", "100%");
		    	rMateChartH5.create("chart12", "chartHolder12", chartVars12, "100%", "100%");
	    	}else{
	    		chartNullData = [];
	    		$("#personTot").html("0명" );	    	
		    	$("#personAvg").html("평균 0명");
		    	
		    	document.getElementById("chart1").setData(chartNullData);
		    	document.getElementById("chart2").setData(chartNullData);
		    	document.getElementById("chart3").setData(chartNullData);
		    	document.getElementById("chart4").setData(chartNullData);
		    	document.getElementById("chart5").setData(chartNullData);
		    	document.getElementById("chart6").setData(chartNullData);
		    	document.getElementById("chart7").setData(chartNullData);
		    	
		    	document.getElementById("chart8").setData(chartNullData);
		    	document.getElementById("chart9").setData(chartNullData);
		    	document.getElementById("chart10").setData(chartNullData);
		    	document.getElementById("chart11").setData(chartNullData);
		    	document.getElementById("chart12").setData(chartNullData);
		    	
	    	}
	    },
	});
}

function fn_chart2(stdYear, sidoCode, sigunCode, prdArea){
	$.ajax({
	    type : 'get',
	    url : "/reseach/chulInfoChart2.json",
	    data : {
	    	stdYear : stdYear,
	    	sidoCode : sidoCode,
	    	agCode : sigunCode,
	    	prdArea : prdArea
	    },
	    dataType : 'json',   	           
	    success : function(res){        
	    	
	    	if(res.chulInfoChartVO.length > 0){
	    		chartData1 = res.chulInfoChartVO;
		    	chartData2 = res.chulInfoChartVO;
		    	chartData3 = res.chulInfoChartVO;
		    	
		    	chartData4 = [{
			            "cateName" : "단동",
			            "val" : res.chulInfoChartVO[0].dandong
			    },{
				    	"cateName" : "연동",
			            "val" : res.chulInfoChartVO[0].yundong
			    }];
		    	
		    	chartData5 = res.chulInfoChartVO;
		    	chartData6 = res.chulInfoChartVO;
		    	chartData7 = res.chulInfoChartVO;
		    	chartData8 = res.chulInfoChartVO;
		    	chartData9 = [{
				            "cateName" : "자가인력",
				            "val" : res.chulInfoChartVO[0].b1r1c31
				    },{
					    	"cateName" : "상시고용직",
				            "val" : res.chulInfoChartVO[0].b1r1c21
				    },{
					    	"cateName" : "임시직",
				            "val" : res.chulInfoChartVO[0].b1r1c41
				    }];
		    	
		    	chartData10 = [{"cateName":res.chulInfoChartVO[0].cateName,"all":res.chulInfoChartVO[0].b1r1c3+res.chulInfoChartVO[0].b1r1c2+res.chulInfoChartVO[0].b1r1c4,"b1r1c51":res.chulInfoChartVO[0].b1r1c5}];
		    	
		    	layoutStr10 = 
		    		'<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'
			    	    +'<Options>'
			    	     +'<Caption text="'+res.chulInfoChartVO[0].b1r1c51+'%" fontFamily="맑은 고딕" fontSize="30" />'
			    	     +'<SubCaption text="명" textAlign="left" />'
			    	     +'<Legend defaultMouseOverAction="false" useVisibleCheck="true" />'
			    	    +'</Options>'
			    	    +'<NumberFormatter id="numFmt" useThousandsSeparator="true"/>'
			    	   +'<Column2DChart showDataTips="true" columnWidthRatio="0.7" selectionMode="single" displayCompleteCallFunction="displayCallFunction"  dataTipJsFunction="dataTipFunc"  >'
			    	       +'<horizontalAxis>'
			    	       	+'<CategoryAxis  id="hAxis" categoryField="cateName" padding="0.4"/>'
			    	        +'</horizontalAxis>'
			    	        +'<verticalAxis>'
			    	           +'<LinearAxis id="vAxis"  formatter="{numFmt}"/>'
			    	       +'</verticalAxis>'
			    	          +'<series>'
			    	          +'<Column2DSeries yField="all" displayName="재배인력" halfWidthOffset="20" labelPosition="outside">'
			    	          		+'<fill>'
			    		            	+'<SolidColor color="#536BC9" alpha="1"/>'
			    		            +'</fill>'
			    	                +'<showDataEffect>'
			    	                  +'<SeriesInterpolate/>'
			    	                +'</showDataEffect>'
			    		            +'</Column2DSeries>'
			    		      +'<Column2DSeries yField="b1r1c51" displayName="성수기 임시직" halfWidthOffset="20" labelPosition="outside">'
			    		      		+'<fill>'
			    		          		+'<SolidColor color="#4DC189" alpha="1"/>'
			    		          	+'</fill>'
			    	                +'<showDataEffect>'
			    	                   +'<SeriesInterpolate/>'
			    	               +'</showDataEffect>'
			    	          +'</Column2DSeries>'
			    	        +'</series>'
			    	        +'<horizontalAxisRenderers>'
			    	        +'<Axis2DRenderer axis="{hAxis}" minorTickLength="0" tickPlacement="outside" minorTickPlacement="cross" placement="bottom" canDropLabels="true" showLabels="false" showLine="true" labelAlign="center">'
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
		    	
		    	chartData11 = res.chulInfoChartVO;
		    	chartData12 = res.chulInfoChartVO;
		    	$("#personTot").html(comma(res.chulInfoChartVO[0].personAll)+"명" );	    	
		    	$("#personAvg").html("평균 "+res.chulInfoChartVO[0].personAvg+"명");
		    	
		    	rMateChartH5.create("chart1", "chartHolder1", chartVars1, "100%", "100%");
		    	rMateChartH5.create("chart2", "chartHolder2", chartVars2, "100%", "100%");
		    	rMateChartH5.create("chart3", "chartHolder3", chartVars3, "100%", "100%");
		    	rMateChartH5.create("chart4", "chartHolder4", chartVars4, "100%", "100%");
		    	rMateChartH5.create("chart5", "chartHolder5", chartVars5, "100%", "100%");
		    	rMateChartH5.create("chart6", "chartHolder6", chartVars6, "100%", "100%");
		    	rMateChartH5.create("chart7", "chartHolder7", chartVars7, "100%", "100%");
//		    	rMateChartH5.create("chart8", "chartHolder8", chartVars8, "100%", "100%");
//		    	rMateChartH5.create("chart9", "chartHolder9", chartVars9, "100%", "100%");
//		    	rMateChartH5.create("chart10", "chartHolder10", chartVars10, "100%", "100%");
//		    	rMateChartH5.create("chart11", "chartHolder11", chartVars11, "100%", "100%");
//		    	rMateChartH5.create("chart12", "chartHolder12", chartVars12, "100%", "100%");
	    	}else{
	    		chartNullData = [];
	    		$("#personTot").html("0명" );	    	
		    	$("#personAvg").html("평균 0명");
		    	
		    	document.getElementById("chart1").setData(chartNullData);
		    	document.getElementById("chart2").setData(chartNullData);
		    	document.getElementById("chart3").setData(chartNullData);
		    	document.getElementById("chart4").setData(chartNullData);
		    	document.getElementById("chart5").setData(chartNullData);
		    	document.getElementById("chart6").setData(chartNullData);
		    	document.getElementById("chart7").setData(chartNullData);
//		    	document.getElementById("chart8").setData(chartNullData);
//		    	document.getElementById("chart9").setData(chartNullData);
//		    	document.getElementById("chart10").setData(chartNullData);
//		    	document.getElementById("chart11").setData(chartNullData);
//		    	document.getElementById("chart12").setData(chartNullData);
		    	
	    	}
	    },
	});
}

function fn_printDiv(id){
	$(".btn_down_image").css("display","none");
	$(".btn_search").css("display","none");
	var fileName = $(".main_title").text();
	var div = $("#"+id).get(0);
	mapApp = document.getElementById("map1");
	mapRoot = mapApp.getRoot();
	mapRoot.saveImage('printArea', fileName, "png", "http://demo.riamore.net/demo/chart/downloadLocal.jsp");
	$(".btn_down_image").css("display","");
	$(".btn_search").css("display","");
	/*
	html2canvas(div).then(function(canvas){
		var myImage = canvas.toDataURL();
		downloadURI(myImage, "저장이미지이름.png") 
	});*/
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
					<li><a href="/research/chulInfo.do" class="btn_menu on">농가현황</a></li>
					<li><a href="/research/prodInfo.do" class="btn_menu">재배현황</a></li>
					<li><a href="/research/dataUpload.do" class="btn_menu">데이터관리</a></li>
				</ul>
				<a href="/login/logoutProc.do" class="btn_logout">로그아웃</a>
			</div>
		</div>
		
		<!-- header(E) -->

		<!-- sub-conts(S) -->
		<div class="content">
			<div class="content_in" id="printArea">

				<!-- main title(S) -->
				<h2 class="main_title"></h2>
				<!-- main title(E) -->

				<!-- search box pack(S)-->
				<div class="search_pack mt70">
					<!-- search box(S) -->
					<div class="search_box">
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
							<dt><p class="tit_tag">재배면적</p></dt>
							<dd>
								<div class="select_type_01">
									<select name="prdArea" id="prdArea" onchange="fn_prdAreaChange();">
										<option value="">전체</option>
										<option value="1" <c:if test="${paramMap.prdArea eq '1'}">selected="selected"</c:if>>0.3ha 미만</option>
										<option value="2" <c:if test="${paramMap.prdArea eq '2'}">selected="selected"</c:if>>0.3ha ~ 0.5ha 미만</option>
										<option value="3" <c:if test="${paramMap.prdArea eq '3'}">selected="selected"</c:if>>0.3ha ~ 1ha 미만</option>
										<option value="4" <c:if test="${paramMap.prdArea eq '4'}">selected="selected"</c:if>>1ha 이상</option>
									</select>
									<label for="prdArea"></label>
								</div>
							</dd>
						</dl>
						
					</div>
					<!-- search box(E) -->
					
					<a href="javascript:searchBtn();" class="btn_search">조회</a>
					<a href="javascript:fn_printDiv('printArea');" class="btn_down_image">이미지</a>
					
					<!-- image button(S) -->
					
					
					<!-- image button(E) -->

				</div>
				<!-- search box pack(E)-->
				
				<div class="img_capture mt30">				
					<!-- 농가 현황(S) -->
					<div class="title_box">
						<div class="fl">
							<h4 class="tit_02">농가현황</h4>
						</div>
					</div>
					
					<div class="area mt20 a1">
						<div class="map_chart">
							<div id="mapHolder" style="width:100%;height:100%;"></div>
						</div>
						<div class="map_chart_detail">
							<ul class="city_total_data">
								<li>
									<p class="city_name" id="mainArea"></p>
								</li>
								<li>
									<h4 class="tit_cn_data an01">재배농가 수</h4>
									<p class="cn_data_num" id="mainChulCnt"></p>
								</li>
								<li>
									<h4 class="tit_cn_data an02">재배면적</h4>
									<p class="cn_data_num" id="mainPrdArea"></p>
								</li>
								<li>
									<h4 class="tit_cn_data an03">연간출하량</h4>
									<p class="cn_data_num" id="mainYearChulQty"></p>
								</li>
								<li>
									<h4 class="tit_cn_data an04">연간출하액</h4>
									<p class="cn_data_num" id="mainYearChulAmt"></p>
								</li>
							</ul>

							<ul class="state_info" id="subDiv">
								
							</ul>
							<ul class="state_info" id="subDiv2">
								
							</ul>
						</div>
					</div>
					<!-- 농가 현황(E) -->

					<!-- 면적별 재배 농가 수(S) -->
					<div class="title_box mt30">
						<div class="fl">
							<h4 class="tit_02">재배시설 항목별 면적비중</h4>
						</div>
					</div>

					<div class="area mt20 a2">
						<ul class="col_wrap col4">
							<li class="cola">
								<h4 class="tit_graph">자가/임차</h4>
								<div class="graph_box_02">
									<div id="chartHolder1" style="width:100%;height:100%;"></div>
								</div>
							</li>
							<li class="colb">
								<h4 class="tit_graph">시설/노지</h4>
								<div class="graph_box_02">
									<div id="chartHolder2" style="width:100%;height:100%;"></div>
								</div>
							</li>
							<li class="colc">
								<h4 class="tit_graph">시설유형</h4>
								<div class="graph_box_02">
									<div id="chartHolder3" style="width:100%;height:100%;"></div>
								</div>
							</li>
							<li class="cold">
								<h4 class="tit_graph">시설형태</h4>
								<div class="graph_box_02">
									<div id="chartHolder4" style="width:100%;height:100%;"></div>
								</div>
							</li>
						</ul>
						<ul class="col_wrap col2_1_1">
							<li class="cola">
								<h4 class="tit_graph">재배유형</h4>
								<div class="graph_box_02">
									<div id="chartHolder5" style="width:100%;height:100%;"></div>
								</div>
							</li>
							<li class="colb">
								<h4 class="tit_graph">가온</h4>
								<div class="graph_box_02">
									<div id="chartHolder6" style="width:100%;height:100%;"></div>
								</div>
							</li>
							<li class="colc">
								<h4 class="tit_graph">보온</h4>
								<div class="graph_box_02">
									<div id="chartHolder7" style="width:100%;height:100%;"></div>
								</div>
							</li>
						</ul>
					</div>
					<!-- 면적별 재배 농가 수(E) -->
					
					
					
					
					
					<!-- 재배인력(S) -->
					<div class="title_box mt30" id="view1">
						<div class="fl">
							<h4 class="tit_02">재배인력</h4>
						</div>
					</div>

					<div class="area mt20 a3" id="view2">
						<div class="col_wrap col1_2_1">
							<ul>
								<li class="cola bgb">
									<h4 class="tit_graph">재배인력수</h4>
									<div class="graph_data_01">
										<img src="/research/img/icon_face.png">
										<p class="tit_total_num" id="personTot"></p>
										<p class="tit_average" id="personAvg"></p>
									</div>
								</li>
								<li class="colb">
									<h4 class="tit_graph">고용형태</h4>
									<div class="graph_box_02">
										<div id="chartHolder8" style="width:100%;height:100%;"></div>
									</div>
								</li>
								<li class="colc">
									<h4 class="tit_graph">고용형태 비중</h4>
									<div class="graph_box_02">
										<div id="chartHolder9" style="width:100%;height:100%;"></div>
									</div>
								</li>
							</ul>
						</div>
						<div class="col_wrap col2_1_1 mt10">
							<ul>
								<li class="cola">
									<h4 class="tit_graph">재배인력 대비 성수기 임시직 비중</h4>
									<div class="graph_box_02">
										<div id="chartHolder10" style="width:100%;height:100%;"></div>
									</div>
								</li>
								<li class="colb">
									<h4 class="tit_graph">내/외국인</h4>
									<div class="graph_box_02">
										<div id="chartHolder11" style="width:100%;height:100%;"></div>
									</div>
								</li>
								<li class="colc">
									<h4 class="tit_graph">내/외국인 비중</h4>
									<div class="graph_box_02">
										<div id="chartHolder12" style="width:100%;height:100%;"></div>
									</div>
								</li>
							</ul>
						</div>
					</div>
					<!-- 재배인력(E) -->
					
					
					
					
				</div>
				
			</div>
		</div>
		<!-- sub-conts(E) -->
	</div>
	<!-- wrap(E) -->		

</body>
</html>

