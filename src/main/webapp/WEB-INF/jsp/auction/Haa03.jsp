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
	<meta name="description" content="품종경락가격">
	<meta name="content" content="화훼유통정보시스템 입니다.">
	<meta name="keywords" content="화훼경매시세, 화훼경매가격, Korea aT flower market auction price, 화훼공판장, 화훼거래정보, 꽃시장, 꽃값">
	<meta name="Author" content="화훼유통정보시스템 & www.woorim.co.kr">
	<title>품종경락가격</title>	
	<%@include file="../common/2020/commonCss.jsp" %>
	<%@include file="../common/2020/commonJs.jsp" %>
	
	<script type="text/javascript">
	//-----------------------차트 설정 시작-----------------------	
	//rMate 차트 생성 준비가 완료된 상태 시 호출할 함수를 지정합니다.
	var chartVars = "rMateOnLoadCallFunction=chartReadyHandler";
	var chartVars2 = "rMateOnLoadCallFunction=chartReadyHandler2";
	var chartVars3 = "rMateOnLoadCallFunction=chartReadyHandler3";
	var chartVars4 = "rMateOnLoadCallFunction=chartReadyHandler4";
	var chartVars5 = "rMateOnLoadCallFunction=chartReadyHandler5";
	var chartVars6 = "rMateOnLoadCallFunction=chartReadyHandler6";
	
	rMateChartH5.create("chart1", "chartHolder", chartVars, "100%", "100%"); 
	rMateChartH5.create("chart2", "chartHolder2", chartVars2, "100%", "100%"); 
	rMateChartH5.create("chart3", "chartHolder3", chartVars3, "100%", "100%");
	rMateChartH5.create("chart4", "chartHolder4", chartVars4, "100%", "100%");
	rMateChartH5.create("chart5", "chartHolder5", chartVars5, "100%", "100%");
	rMateChartH5.create("chart6", "chartHolder6", chartVars6, "100%", "100%");
	
	function chartReadyHandler(id) {
		document.getElementById(id).setLayout(layoutStr);
		document.getElementById(id).setData(chartData);
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
	
	function chartReadyHandler6(id) {
		document.getElementById(id).setLayout(layoutStr6);
		document.getElementById(id).setData(chartData6);
	}
	//스트링 형식으로 레이아웃 정의.
	var layoutStr = 
					'<rMateChart  backgroundColor="#ffffff" borderStyle="none">'
					+'<Options>'
					+'<SubCaption text="단위 : 원" textAlign="left" />'
						+'<Legend defaultMouseOverAction="false" useVisibleCheck="true"/>'
					+'</Options>'
					+'<NumberFormatter id="numFmt" precision="0"/>'
					+'<NumberFormatter id="numFmt2" useThousandsSeparator="true"/>'
					+'<Line2DChart showDataTips="true" dataTipDisplayMode="axis" paddingTop="0">'
						+'<horizontalAxis>'
							+'<CategoryAxis categoryField="SALE_DATE"/>'
						+'</horizontalAxis>'
						+'<verticalAxis>'
							+'<LinearAxis formatter="{numFmt2}" minimum="0"/>'
						+'</verticalAxis>'
						+'<series>'
							+'<Line2DSeries  yField="AVG_AMT_ONE" fill="#ffffff" radius="5" displayName="1순위" itemRenderer="DiamondItemRenderer">'
								/* 아이템렌더러(데이터 마커) 테두리 색상 */
								+'<stroke><Stroke color="#fe6500" weight="1"/></stroke>'
								+'<showDataEffect>'
									+'<SeriesInterpolate/>'
								+'</showDataEffect>'
							+'</Line2DSeries>'
							+'<Line2DSeries  yField="AVG_AMT_TWO" fill="#ffffff" radius="5" displayName="2순위"  itemRenderer="CircleItemRenderer">'
							/* itemRenderer는 Circle입니다 */
								+'<stroke><Stroke color="#ffb801" weight="1"/></stroke>'
								+'<showDataEffect>'
									+'<SeriesInterpolate/>'
								+'</showDataEffect>'
							+'</Line2DSeries>'
							+'<Line2DSeries  yField="AVG_AMT_THR" fill="#ffffff" radius="5" displayName="3순위" itemRenderer="TriangleItemRenderer">'
							/* itemRenderer는 Triangle입니다 */
								+'<stroke><Stroke color="#5fc502" weight="1"/></stroke>'
								+'<showDataEffect>'
									+'<SeriesInterpolate/>'
								+'</showDataEffect>'
							+'</Line2DSeries>'
							+'<Line2DSeries  yField="AVG_AMT_FOU" fill="#ffffff" radius="5" displayName="4순위" itemRenderer="CrossItemRenderer">'
							/* itemRenderer는 Triangle입니다 */
								+'<stroke><Stroke color="#666666" weight="1"/></stroke>'
								+'<showDataEffect>'
									+'<SeriesInterpolate/>'
								+'</showDataEffect>'
							+'</Line2DSeries>'
							+'<Line2DSeries  yField="AVG_AMT_FIV" fill="#ffffff" radius="5" displayName="5순위" itemRenderer="XShapeItemRenderer">'
							/* itemRenderer는 Triangle입니다 */
								+'<stroke><Stroke color="#5ECFCF" weight="1"/></stroke>'
								+'<showDataEffect>'
									+'<SeriesInterpolate/>'
								+'</showDataEffect>'
							+'</Line2DSeries>'
							+'<Line2DSeries  yField="AVG_AMT_SIX" fill="#ffffff" radius="5" displayName="6순위"  itemRenderer="IShapeItemRenderer">'
							/* itemRenderer는 Triangle입니다 */
								+'<stroke><Stroke color="#3284C3" weight="1"/></stroke>'
								+'<showDataEffect>'
									+'<SeriesInterpolate/>'
								+'</showDataEffect>'
							+'</Line2DSeries>'
						+'</series>'
					+'</Line2DChart>'
				+'</rMateChart>';
	
	var layoutStr2 = 
		'<rMateChart  backgroundColor="#ffffff" borderStyle="none">'
		+'<Options>'
		+'<SubCaption text="단위 : 원" textAlign="left" />'
			+'<Legend defaultMouseOverAction="false" useVisibleCheck="true"/>'
		+'</Options>'
		+'<NumberFormatter id="numFmt" precision="0"/>'
		+'<NumberFormatter id="numFmt2" useThousandsSeparator="true"/>'
		+'<Line2DChart showDataTips="true" dataTipDisplayMode="axis" paddingTop="0">'
			+'<horizontalAxis>'
				+'<CategoryAxis categoryField="SALE_DATE"/>'
			+'</horizontalAxis>'
			+'<verticalAxis>'
				+'<LinearAxis formatter="{numFmt2}" minimum="0"/>'
			+'</verticalAxis>'
			+'<series>'
				+'<Line2DSeries  yField="AVG_AMT_ONE" fill="#ffffff" radius="5" displayName="1순위"  itemRenderer="DiamondItemRenderer">'
					/* 아이템렌더러(데이터 마커) 테두리 색상 */
					+'<stroke><Stroke color="#fe6500" weight="1"/></stroke>'
					+'<showDataEffect>'
						+'<SeriesInterpolate/>'
					+'</showDataEffect>'
				+'</Line2DSeries>'
				+'<Line2DSeries  yField="AVG_AMT_TWO" fill="#ffffff" radius="5" displayName="2순위"  itemRenderer="CircleItemRenderer">'
				/* itemRenderer는 Circle입니다 */
					+'<stroke><Stroke color="#ffb801" weight="1"/></stroke>'
					+'<showDataEffect>'
						+'<SeriesInterpolate/>'
					+'</showDataEffect>'
				+'</Line2DSeries>'
				+'<Line2DSeries  yField="AVG_AMT_THR" fill="#ffffff" radius="5" displayName="3순위" itemRenderer="TriangleItemRenderer">'
				/* itemRenderer는 Triangle입니다 */
					+'<stroke><Stroke color="#5fc502" weight="1"/></stroke>'
					+'<showDataEffect>'
						+'<SeriesInterpolate/>'
					+'</showDataEffect>'
				+'</Line2DSeries>'
				+'<Line2DSeries  yField="AVG_AMT_FOU" fill="#ffffff" radius="5" displayName="4순위" itemRenderer="CrossItemRenderer">'
				/* itemRenderer는 Triangle입니다 */
					+'<stroke><Stroke color="#666666" weight="1"/></stroke>'
					+'<showDataEffect>'
						+'<SeriesInterpolate/>'
					+'</showDataEffect>'
				+'</Line2DSeries>'
				+'<Line2DSeries  yField="AVG_AMT_FIV" fill="#ffffff" radius="5" displayName="5순위" itemRenderer="XShapeItemRenderer">'
				/* itemRenderer는 Triangle입니다 */
					+'<stroke><Stroke color="#5ECFCF" weight="1"/></stroke>'
					+'<showDataEffect>'
						+'<SeriesInterpolate/>'
					+'</showDataEffect>'
				+'</Line2DSeries>'
				+'<Line2DSeries  yField="AVG_AMT_SIX" fill="#ffffff" radius="5" displayName="6순위" itemRenderer="IShapeItemRenderer">'
				/* itemRenderer는 Triangle입니다 */
					+'<stroke><Stroke color="#3284C3" weight="1"/></stroke>'
					+'<showDataEffect>'
						+'<SeriesInterpolate/>'
					+'</showDataEffect>'
				+'</Line2DSeries>'
			+'</series>'
		+'</Line2DChart>'
	+'</rMateChart>';			
				
				
	var layoutStr3 = 
		'<rMateChart  backgroundColor="#ffffff" borderStyle="none">'
		+'<Options>'
		+'<SubCaption text="단위 : 원" textAlign="left" />'
			+'<Legend defaultMouseOverAction="false" useVisibleCheck="true"/>'
		+'</Options>'
		+'<NumberFormatter id="numFmt" precision="0"/>'
		+'<NumberFormatter id="numFmt2" useThousandsSeparator="true"/>'
		+'<Line2DChart showDataTips="true" dataTipDisplayMode="axis" paddingTop="0">'
			+'<horizontalAxis>'
				+'<CategoryAxis categoryField="SALE_DATE"/>'
			+'</horizontalAxis>'
			+'<verticalAxis>'
				+'<LinearAxis formatter="{numFmt2}" minimum="0"/>'
			+'</verticalAxis>'
			+'<series>'
				+'<Line2DSeries  yField="AVG_AMT_ONE" fill="#ffffff" radius="5" displayName="1순위"  itemRenderer="DiamondItemRenderer">'
					/* 아이템렌더러(데이터 마커) 테두리 색상 */
					+'<stroke><Stroke color="#fe6500" weight="1"/></stroke>'
					+'<showDataEffect>'
						+'<SeriesInterpolate/>'
					+'</showDataEffect>'
				+'</Line2DSeries>'
				+'<Line2DSeries  yField="AVG_AMT_TWO" fill="#ffffff" radius="5" displayName="2순위"  itemRenderer="CircleItemRenderer">'
				/* itemRenderer는 Circle입니다 */
					+'<stroke><Stroke color="#ffb801" weight="1"/></stroke>'
					+'<showDataEffect>'
						+'<SeriesInterpolate/>'
					+'</showDataEffect>'
				+'</Line2DSeries>'
				+'<Line2DSeries  yField="AVG_AMT_THR" fill="#ffffff" radius="5" displayName="3순위" itemRenderer="TriangleItemRenderer">'
				/* itemRenderer는 Triangle입니다 */
					+'<stroke><Stroke color="#5fc502" weight="1"/></stroke>'
					+'<showDataEffect>'
						+'<SeriesInterpolate/>'
					+'</showDataEffect>'
				+'</Line2DSeries>'
				+'<Line2DSeries  yField="AVG_AMT_FOU" fill="#ffffff" radius="5" displayName="4순위" itemRenderer="CrossItemRenderer">'
				/* itemRenderer는 Triangle입니다 */
					+'<stroke><Stroke color="#666666" weight="1"/></stroke>'
					+'<showDataEffect>'
						+'<SeriesInterpolate/>'
					+'</showDataEffect>'
				+'</Line2DSeries>'
				+'<Line2DSeries  yField="AVG_AMT_FIV" fill="#ffffff" radius="5" displayName="5순위" itemRenderer="XShapeItemRenderer">'
				/* itemRenderer는 Triangle입니다 */
					+'<stroke><Stroke color="#5ECFCF" weight="1"/></stroke>'
					+'<showDataEffect>'
						+'<SeriesInterpolate/>'
					+'</showDataEffect>'
				+'</Line2DSeries>'
				+'<Line2DSeries  yField="AVG_AMT_SIX" fill="#ffffff" radius="5" displayName="6순위" itemRenderer="IShapeItemRenderer">'
				/* itemRenderer는 Triangle입니다 */
					+'<stroke><Stroke color="#3284C3" weight="1"/></stroke>'
					+'<showDataEffect>'
						+'<SeriesInterpolate/>'
					+'</showDataEffect>'
				+'</Line2DSeries>'
			+'</series>'
		+'</Line2DChart>'
	+'</rMateChart>';
	
	var layoutStr4 = 
		'<rMateChart  backgroundColor="#ffffff" borderStyle="none">'
		+'<Options>'
		+'<SubCaption text="단위 : 원" textAlign="left" />'
			+'<Legend defaultMouseOverAction="false" useVisibleCheck="true"/>'
		+'</Options>'
		+'<NumberFormatter id="numFmt" precision="0"/>'
		+'<NumberFormatter id="numFmt2" useThousandsSeparator="true"/>'
		+'<Line2DChart showDataTips="true" dataTipDisplayMode="axis" paddingTop="0">'
			+'<horizontalAxis>'
				+'<CategoryAxis categoryField="SALE_DATE"/>'
			+'</horizontalAxis>'
			+'<verticalAxis>'
				+'<LinearAxis formatter="{numFmt2}" minimum="0"/>'
			+'</verticalAxis>'
			+'<series>'
				+'<Line2DSeries  yField="AVG_AMT_ONE" fill="#ffffff" radius="5" displayName="1순위"  itemRenderer="DiamondItemRenderer">'
					/* 아이템렌더러(데이터 마커) 테두리 색상 */
					+'<stroke><Stroke color="#fe6500" weight="1"/></stroke>'
					+'<showDataEffect>'
						+'<SeriesInterpolate/>'
					+'</showDataEffect>'
				+'</Line2DSeries>'
				+'<Line2DSeries  yField="AVG_AMT_TWO" fill="#ffffff" radius="5" displayName="2순위"  itemRenderer="CircleItemRenderer">'
				/* itemRenderer는 Circle입니다 */
					+'<stroke><Stroke color="#ffb801" weight="1"/></stroke>'
					+'<showDataEffect>'
						+'<SeriesInterpolate/>'
					+'</showDataEffect>'
				+'</Line2DSeries>'
				+'<Line2DSeries  yField="AVG_AMT_THR" fill="#ffffff" radius="5" displayName="3순위" itemRenderer="TriangleItemRenderer">'
				/* itemRenderer는 Triangle입니다 */
					+'<stroke><Stroke color="#5fc502" weight="1"/></stroke>'
					+'<showDataEffect>'
						+'<SeriesInterpolate/>'
					+'</showDataEffect>'
				+'</Line2DSeries>'
				+'<Line2DSeries  yField="AVG_AMT_FOU" fill="#ffffff" radius="5" displayName="4순위" itemRenderer="CrossItemRenderer">'
				/* itemRenderer는 Triangle입니다 */
					+'<stroke><Stroke color="#666666" weight="1"/></stroke>'
					+'<showDataEffect>'
						+'<SeriesInterpolate/>'
					+'</showDataEffect>'
				+'</Line2DSeries>'
				+'<Line2DSeries  yField="AVG_AMT_FIV" fill="#ffffff" radius="5" displayName="5순위" itemRenderer="XShapeItemRenderer">'
				/* itemRenderer는 Triangle입니다 */
					+'<stroke><Stroke color="#5ECFCF" weight="1"/></stroke>'
					+'<showDataEffect>'
						+'<SeriesInterpolate/>'
					+'</showDataEffect>'
				+'</Line2DSeries>'
				+'<Line2DSeries  yField="AVG_AMT_SIX" fill="#ffffff" radius="5" displayName="6순위" itemRenderer="IShapeItemRenderer">'
				/* itemRenderer는 Triangle입니다 */
					+'<stroke><Stroke color="#3284C3" weight="1"/></stroke>'
					+'<showDataEffect>'
						+'<SeriesInterpolate/>'
					+'</showDataEffect>'
				+'</Line2DSeries>'
			+'</series>'
		+'</Line2DChart>'
	+'</rMateChart>';
	
	var layoutStr5 = 
		'<rMateChart  backgroundColor="#ffffff" borderStyle="none">'
		+'<Options>'
		+'<SubCaption text="단위 : 원" textAlign="left" />'
			+'<Legend defaultMouseOverAction="false" useVisibleCheck="true"/>'
		+'</Options>'
		+'<NumberFormatter id="numFmt" precision="0"/>'
		+'<NumberFormatter id="numFmt2" useThousandsSeparator="true"/>'
		+'<Line2DChart showDataTips="true" dataTipDisplayMode="axis" paddingTop="0">'
			+'<horizontalAxis>'
				+'<CategoryAxis categoryField="SALE_DATE"/>'
			+'</horizontalAxis>'
			+'<verticalAxis>'
				+'<LinearAxis formatter="{numFmt2}" minimum="0"/>'
			+'</verticalAxis>'
			+'<series>'
				+'<Line2DSeries  yField="AVG_AMT_ONE" fill="#ffffff" radius="5" displayName="1순위"  itemRenderer="DiamondItemRenderer">'
					/* 아이템렌더러(데이터 마커) 테두리 색상 */
					+'<stroke><Stroke color="#fe6500" weight="1"/></stroke>'
					+'<showDataEffect>'
						+'<SeriesInterpolate/>'
					+'</showDataEffect>'
				+'</Line2DSeries>'
				+'<Line2DSeries  yField="AVG_AMT_TWO" fill="#ffffff" radius="5" displayName="2순위"  itemRenderer="CircleItemRenderer">'
				/* itemRenderer는 Circle입니다 */
					+'<stroke><Stroke color="#ffb801" weight="1"/></stroke>'
					+'<showDataEffect>'
						+'<SeriesInterpolate/>'
					+'</showDataEffect>'
				+'</Line2DSeries>'
				+'<Line2DSeries  yField="AVG_AMT_THR" fill="#ffffff" radius="5" displayName="3순위" itemRenderer="TriangleItemRenderer">'
				/* itemRenderer는 Triangle입니다 */
					+'<stroke><Stroke color="#5fc502" weight="1"/></stroke>'
					+'<showDataEffect>'
						+'<SeriesInterpolate/>'
					+'</showDataEffect>'
				+'</Line2DSeries>'
				+'<Line2DSeries  yField="AVG_AMT_FOU" fill="#ffffff" radius="5" displayName="4순위" itemRenderer="CrossItemRenderer">'
				/* itemRenderer는 Triangle입니다 */
					+'<stroke><Stroke color="#666666" weight="1"/></stroke>'
					+'<showDataEffect>'
						+'<SeriesInterpolate/>'
					+'</showDataEffect>'
				+'</Line2DSeries>'
				+'<Line2DSeries  yField="AVG_AMT_FIV" fill="#ffffff" radius="5" displayName="5순위" itemRenderer="XShapeItemRenderer">'
				/* itemRenderer는 Triangle입니다 */
					+'<stroke><Stroke color="#5ECFCF" weight="1"/></stroke>'
					+'<showDataEffect>'
						+'<SeriesInterpolate/>'
					+'</showDataEffect>'
				+'</Line2DSeries>'
				+'<Line2DSeries  yField="AVG_AMT_SIX" fill="#ffffff" radius="5" displayName="6순위" itemRenderer="IShapeItemRenderer">'
				/* itemRenderer는 Triangle입니다 */
					+'<stroke><Stroke color="#3284C3" weight="1"/></stroke>'
					+'<showDataEffect>'
						+'<SeriesInterpolate/>'
					+'</showDataEffect>'
				+'</Line2DSeries>'
			+'</series>'
		+'</Line2DChart>'
	+'</rMateChart>';
	
	var layoutStr6 = 
		'<rMateChart  backgroundColor="#ffffff" borderStyle="none">'
		+'<Options>'
		+'<SubCaption text="단위 : 원" textAlign="left" />'
			+'<Legend defaultMouseOverAction="false" useVisibleCheck="true"/>'
		+'</Options>'
		+'<NumberFormatter id="numFmt" precision="0"/>'
		+'<NumberFormatter id="numFmt2" useThousandsSeparator="true"/>'
		+'<Line2DChart showDataTips="true" dataTipDisplayMode="axis" paddingTop="0">'
			+'<horizontalAxis>'
				+'<CategoryAxis categoryField="SALE_DATE"/>'
			+'</horizontalAxis>'
			+'<verticalAxis>'
				+'<LinearAxis formatter="{numFmt2}" minimum="0"/>'
			+'</verticalAxis>'
			+'<series>'
				+'<Line2DSeries  yField="AVG_AMT_ONE" fill="#ffffff" radius="5" displayName="1순위"  itemRenderer="DiamondItemRenderer">'
					/* 아이템렌더러(데이터 마커) 테두리 색상 */
					+'<stroke><Stroke color="#fe6500" weight="1"/></stroke>'
					+'<showDataEffect>'
						+'<SeriesInterpolate/>'
					+'</showDataEffect>'
				+'</Line2DSeries>'
				+'<Line2DSeries  yField="AVG_AMT_TWO" fill="#ffffff" radius="5" displayName="2순위"  itemRenderer="CircleItemRenderer">'
				/* itemRenderer는 Circle입니다 */
					+'<stroke><Stroke color="#ffb801" weight="1"/></stroke>'
					+'<showDataEffect>'
						+'<SeriesInterpolate/>'
					+'</showDataEffect>'
				+'</Line2DSeries>'
				+'<Line2DSeries  yField="AVG_AMT_THR" fill="#ffffff" radius="5" displayName="3순위" itemRenderer="TriangleItemRenderer">'
				/* itemRenderer는 Triangle입니다 */
					+'<stroke><Stroke color="#5fc502" weight="1"/></stroke>'
					+'<showDataEffect>'
						+'<SeriesInterpolate/>'
					+'</showDataEffect>'
				+'</Line2DSeries>'
				+'<Line2DSeries  yField="AVG_AMT_FOU" fill="#ffffff" radius="5" displayName="4순위" itemRenderer="CrossItemRenderer">'
				/* itemRenderer는 Triangle입니다 */
					+'<stroke><Stroke color="#666666" weight="1"/></stroke>'
					+'<showDataEffect>'
						+'<SeriesInterpolate/>'
					+'</showDataEffect>'
				+'</Line2DSeries>'
				+'<Line2DSeries  yField="AVG_AMT_FIV" fill="#ffffff" radius="5" displayName="5순위" itemRenderer="XShapeItemRenderer">'
				/* itemRenderer는 Triangle입니다 */
					+'<stroke><Stroke color="#5ECFCF" weight="1"/></stroke>'
					+'<showDataEffect>'
						+'<SeriesInterpolate/>'
					+'</showDataEffect>'
				+'</Line2DSeries>'
				+'<Line2DSeries  yField="AVG_AMT_SIX" fill="#ffffff" radius="5" displayName="6순위" itemRenderer="IShapeItemRenderer">'
				/* itemRenderer는 Triangle입니다 */
					+'<stroke><Stroke color="#3284C3" weight="1"/></stroke>'
					+'<showDataEffect>'
						+'<SeriesInterpolate/>'
					+'</showDataEffect>'
				+'</Line2DSeries>'
			+'</series>'
		+'</Line2DChart>'
	+'</rMateChart>';
	
	//차트 데이터
	var chartData =[];
	var chartData2 =[];
	var chartData3 =[];
	var chartData4 =[];
	var chartData5 =[];
	var chartData6 =[];
	
	function rMateChartH5ChangeTheme(theme){
		document.getElementById("chart1").setTheme(theme);
	}
	
	$(function(){
		$("#excelBtn1").empty();
		$("#excelBtn1").append('<a href="javascript:void(0);" id="exportBtn1" name="exportTable1" onclick="excelExport();"><img src="../images/2020/exel.png" alt="엑셀이미지">엑셀저장</a>');
	});
	
	function excelExport(){
		var excelNm = "품종경락가격";
		var flowerCd = $("#flowerTab .on > input").attr("value");
		var dateGubn = $("#dateGubn").val();
		var param = "?excelNm="+excelNm+"&flowerCd="+flowerCd+"&dateGubn="+dateGubn;
		location.href = "/excel/excelDownLoad.do"+param;
	}
		
	function getSaledate(){
		main_index();
	}
	
	function main_index(){
		// 절화구분
		var flowerCd = $("#flowerTab .on > input").attr("value");
		
		$.cookie("cookie.flowerCd", flowerCd, { expires: 7, path: '/' });
		
		if(flowerCd=='1'){
			$("#txtNm").text('속수량');
			$("#txtNm2").text('속수량');
			$("#txtNm3").text('속수량');
			$("#txtNm4").text('속수량');
			$("#txtNm5").text('속수량');
			$("#txtNm6").text('속수량');
			
		}else{
			$("#txtNm").text('분수량');
			$("#txtNm2").text('분수량');
			$("#txtNm3").text('분수량');
			$("#txtNm4").text('분수량');
			$("#txtNm5").text('분수량');
			$("#txtNm6").text('분수량');
		}
		// 개월
		var dateGubn = $("#dateGubn").val();
		
	   $.ajax({
	     type : 'get',
	     url : "/haa03/selectData.json",
	     data : '&FLOWER_CD='+flowerCd+'&DATE_GUBN='+dateGubn,
	     dataType : '', 
	     success : function(res){
	    	 
	    	 var data1 = res.selectListaTFlower;
				
	    	var htmlTxt='';
 			if(data1 != null && data1.length>0){
 				for(var i=0; i<data1.length; i++){
 						htmlTxt+='<tr>';
 						htmlTxt+='<td>'+data1[i].rnum+'</td>';
 						htmlTxt+='<td>'+data1[i].saleDate+'</td>';
 						htmlTxt+='<td>'+data1[i].pumName+'</td>';
 						htmlTxt+='<td>'+data1[i].goodName+'</td>';
 						htmlTxt+='<td>'+addThousandSeparatorCommas(data1[i].totQty)+'</td>';
 						htmlTxt+='<td>'+addThousandSeparatorCommas(data1[i].minAmt)+'</td>';
 						htmlTxt+='<td>'+addThousandSeparatorCommas(data1[i].maxAmt)+'</td>';
 						htmlTxt+='<td>'+addThousandSeparatorCommas(data1[i].avgAmt)+'</td>';
 						htmlTxt+='</tr>';
 				}
 			}else{
 				htmlTxt='<tr><td colspan="8">데이터가 없습니다.</td></tr>';
 			}
 			$("#aTFlowerTxt").html(htmlTxt);
	    	 
	    	chartData = res.list;                                                                                           
        	rMateChartLoding("chart1", "chartReadyHandler");
        	
        	// busan
			data1 = res.selectListBuSanFlower;
        	
			htmlTxt='';
			if(data1 != null && data1.length>0){
				for(var i=0; i<data1.length; i++){
						htmlTxt+='<tr>';
						htmlTxt+='<td>'+data1[i].rnum+'</td>';
						htmlTxt+='<td>'+data1[i].saleDate+'</td>';
						htmlTxt+='<td>'+data1[i].pumName+'</td>';
						htmlTxt+='<td>'+data1[i].goodName+'</td>';
						htmlTxt+='<td>'+addThousandSeparatorCommas(data1[i].totQty)+'</td>';
						htmlTxt+='<td>'+addThousandSeparatorCommas(data1[i].minAmt)+'</td>';
						htmlTxt+='<td>'+addThousandSeparatorCommas(data1[i].maxAmt)+'</td>';
						htmlTxt+='<td>'+addThousandSeparatorCommas(data1[i].avgAmt)+'</td>';
						htmlTxt+='</tr>';
				}
			}else{
				htmlTxt='<tr><td colspan="8">데이터가 없습니다.</td></tr>';
			}
			$("#busanFlowerTxt").html(htmlTxt);
			
	        chartData2 = res.list2;                                                                                           
	        rMateChartLoding("chart2", "chartReadyHandler2");
	        
	     // bukyoung
	        data1 = res.selectListBukyoungFlower;
	     	
			htmlTxt='';
			if(data1 != null && data1.length>0){
				for(var i=0; i<data1.length; i++){
						htmlTxt+='<tr>';
						htmlTxt+='<td>'+data1[i].rnum+'</td>';
						htmlTxt+='<td>'+data1[i].saleDate+'</td>';
						htmlTxt+='<td>'+data1[i].pumName+'</td>';
						htmlTxt+='<td>'+data1[i].goodName+'</td>';
						htmlTxt+='<td>'+addThousandSeparatorCommas(data1[i].totQty)+'</td>';
						htmlTxt+='<td>'+addThousandSeparatorCommas(data1[i].minAmt)+'</td>';
						htmlTxt+='<td>'+addThousandSeparatorCommas(data1[i].maxAmt)+'</td>';
						htmlTxt+='<td>'+addThousandSeparatorCommas(data1[i].avgAmt)+'</td>';
						htmlTxt+='</tr>';
				}
			}else{
				htmlTxt='<tr><td colspan="8">데이터가 없습니다.</td></tr>';
			}
			$("#bukyoungFlowerTxt").html(htmlTxt);
			
	        chartData3 = res.list3;                                                                                           
	        rMateChartLoding("chart3", "chartReadyHandler3");
	        
	        // KwangJu
	        data1 = res.selectListKwangJuFlower;

			htmlTxt='';
			if(data1 != null && data1.length>0){
				for(var i=0; i<data1.length; i++){
						htmlTxt+='<tr>';
						htmlTxt+='<td>'+data1[i].rnum+'</td>';
						htmlTxt+='<td>'+data1[i].saleDate+'</td>';
						htmlTxt+='<td>'+data1[i].pumName+'</td>';
						htmlTxt+='<td>'+data1[i].goodName+'</td>';
						htmlTxt+='<td>'+addThousandSeparatorCommas(data1[i].totQty)+'</td>';
						htmlTxt+='<td>'+addThousandSeparatorCommas(data1[i].minAmt)+'</td>';
						htmlTxt+='<td>'+addThousandSeparatorCommas(data1[i].maxAmt)+'</td>';
						htmlTxt+='<td>'+addThousandSeparatorCommas(data1[i].avgAmt)+'</td>';
						htmlTxt+='</tr>';
				}
			}else{
				htmlTxt='<tr><td colspan="8">데이터가 없습니다.</td></tr>';
			}
			$("#kwangJuFlowerTxt").html(htmlTxt);
			
	        chartData4 = res.list4;                                                                                           
	        rMateChartLoding("chart4", "chartReadyHandler4");
	        
	     // HanKookUm
	        data1 = res.selectListHanKookUmFlower;

			htmlTxt='';
			if(data1 != null && data1.length>0){
				for(var i=0; i<data1.length; i++){
						htmlTxt+='<tr>';
						htmlTxt+='<td>'+data1[i].rnum+'</td>';
						htmlTxt+='<td>'+data1[i].saleDate+'</td>';
						htmlTxt+='<td>'+data1[i].pumName+'</td>';
						htmlTxt+='<td>'+data1[i].goodName+'</td>';
						htmlTxt+='<td>'+addThousandSeparatorCommas(data1[i].totQty)+'</td>';
						htmlTxt+='<td>'+addThousandSeparatorCommas(data1[i].minAmt)+'</td>';
						htmlTxt+='<td>'+addThousandSeparatorCommas(data1[i].maxAmt)+'</td>';
						htmlTxt+='<td>'+addThousandSeparatorCommas(data1[i].avgAmt)+'</td>';
						htmlTxt+='</tr>';
				}
			}else{
				htmlTxt='<tr><td colspan="8">데이터가 없습니다.</td></tr>';
			}
			$("#hanKookUmFlowerTxt").html(htmlTxt);
			
	        chartData5 = res.list5;                                                 
	        rMateChartLoding("chart5", "chartReadyHandler5");
	        
	     // hankookbonFlowerTxt
	        data1 = res.selectListHanKookBonFlower;
	     	
			htmlTxt='';
			if(data1 != null && data1.length>0){
				for(var i=0; i<data1.length; i++){
						htmlTxt+='<tr>';
						htmlTxt+='<td>'+data1[i].rnum+'</td>';
						htmlTxt+='<td>'+data1[i].saleDate+'</td>';
						htmlTxt+='<td>'+data1[i].pumName+'</td>';
						htmlTxt+='<td>'+data1[i].goodName+'</td>';
						htmlTxt+='<td>'+addThousandSeparatorCommas(data1[i].totQty)+'</td>';
						htmlTxt+='<td>'+addThousandSeparatorCommas(data1[i].minAmt)+'</td>';
						htmlTxt+='<td>'+addThousandSeparatorCommas(data1[i].maxAmt)+'</td>';
						htmlTxt+='<td>'+addThousandSeparatorCommas(data1[i].avgAmt)+'</td>';
						htmlTxt+='</tr>';
				} 
			}else{
				htmlTxt='<tr><td colspan="8">데이터가 없습니다.</td></tr>';
			}
			$("#hankookbonFlowerTxt").html(htmlTxt);
			
	        chartData6 = res.list6;                                                                                           
	        rMateChartLoding("chart6", "chartReadyHandler6");
	     }
	 });    	    
	};
	
	function searchDateGubun(gubn){
		$("#dateGubn").val(gubn);
		main_index();			 
	}
	
	</script>  
</head>


<body>
	<!--WRAP(S)-->
	<div class="wrap">
		<form  id="myForm" name="myForm" method="post">
    		<input type="hidden" id="searchProductGubun" name="searchProductGubun" value="1"/>
    		<input type="hidden" id="dateGubn"  name="dateGubn" value="1"/>    	
		</form>
		
		<jsp:include page="../inc/2020/IncHeader.jsp"/>
		
		<div class="lnb_box">
			<ul>
				<li><img src="../images/2020/m_lnb_img.png" alt="집"></li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li>경매정보</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li>경매실적 세부정보</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li class="m_right">품종경락가격</li>
			</ul>
		</div>
		<!--공통 HEADER(E)-->
		
		<!--서브 타이틀(S)-->
		<jsp:include page="../inc/2020/IncShare.jsp"/>
		
		<div class="sub_title">
			<div class="title_box">
				<h2>품종경락가격</h2>
				<img src="../images/2020/sub/t_line.png" alt="방울점선">
			</div>
		</div>
		<!--서브 타이틀(E)-->
		<jsp:include page="../inc/2020/topFlowerCdMenu.jsp"/>
		
		<div class="search_box_wh">
			<div class="search_box">
				<div class="time_list_b">
					<button class="list_bt time_on" onclick="searchDateGubun('1');">최근1개월</button>
					<button class="list_bt " onclick="searchDateGubun('6');">최근6개월</button>
					<button class="list_bt " onclick="searchDateGubun('12');">최근1년</button>
				</div>
			</div>
		</div>
		<!--컨텐츠 내용(S)-->
		<div class="sub_guide">
		<!--1tp-->
			<div class="auction_b">
				<div class="auction_box_b">
					<h2 class="title_02">aT화훼공판장(양재동)</h2>
					<div class="auction_list_b">
						<table>
							<caption>경매기록부</caption>	
							<colgroup>
								<col style="width:6%">
								<col style="width:15%">
								<col style="width:16%">
								<col style="width:19%">
								<col style="width:10%">
								<col style="width:11%">
								<col style="width:11%">
								<col style="width:11%">
							</colgroup>
							<thead>
								<tr>
									<th>순위</th>
									<th>날짜</th>
									<th>품목명</th>
									<th>품종명</th>
									<th id="txtNm">속수량</th>
									<th>최저단가</th>
									<th>최고단가</th>
									<th>평균단가</th>
								</tr>
							</thead>
							<tbody id="aTFlowerTxt">
							</tbody>
						</table>
					</div>
					<div class="auction_graph_b" id="chartHolder" style="height:324px;">					
					</div>
				</div>
			</div>
		<!--2tp-->
			<div class="auction_b">
				<div class="auction_box_b">
					<h2 class="title_02">부산화훼공판장(엄궁동)</h2>
					<div class="auction_list_b">
						<table>
							<caption>경매기록부</caption>	
							<colgroup>
								<col style="width:6%">
								<col style="width:15%">
								<col style="width:16%">
								<col style="width:19%">
								<col style="width:10%">
								<col style="width:11%">
								<col style="width:11%">
								<col style="width:11%">
							</colgroup>
							<thead>
								<tr>
									<th>순위</th>
									<th>날짜</th>
									<th>품목명</th>
									<th>품종명</th>
									<th id="txtNm2">속수량</th>
									<th>최저단가</th>
									<th>최고단가</th>
									<th>평균단가</th>
								</tr>
							</thead>
							<tbody id="busanFlowerTxt">
							</tbody>
						</table>
					</div>
					<div class="auction_graph_b" id="chartHolder2" style="height:324px;">
					</div>
				</div>
			</div>
		<!--3tp-->
			<div class="auction_b">
				<div class="auction_box_b">
					<h2 class="title_02">부산경남화훼농협(강동동)</h2>
					<div class="auction_list_b">
						<table>
							<caption>경매기록부</caption>	
							<colgroup>
								<col style="width:6%">
								<col style="width:15%">
								<col style="width:16%">
								<col style="width:19%">
								<col style="width:10%">
								<col style="width:11%">
								<col style="width:11%">
								<col style="width:11%">
							</colgroup>
							<thead>
								<tr>
									<th>순위</th>
									<th>날짜</th>
									<th>품목명</th>
									<th>품종명</th>
									<th id="txtNm3">속수량</th>
									<th>최저단가</th>
									<th>최고단가</th>
									<th>평균단가</th>
								</tr>
							</thead>
							<tbody id="bukyoungFlowerTxt">
							</tbody>
						</table>
					</div>
					<div class="auction_graph_b" id="chartHolder3" style="height:324px;">
					</div>
				</div>
			</div>
		<!--4tp-->
			<div class="auction_b">
				<div class="auction_box_b">
					<h2 class="title_02">광주원예농협(풍암)</h2>
					<div class="auction_list_b">
						<table>
							<caption>경매기록부</caption>	
							<colgroup>
								<col style="width:6%">
								<col style="width:15%">
								<col style="width:16%">
								<col style="width:19%">
								<col style="width:10%">
								<col style="width:11%">
								<col style="width:11%">
								<col style="width:11%">
							</colgroup>
							<thead>
								<tr>
									<th>순위</th>
									<th>날짜</th>
									<th>품목명</th>
									<th>품종명</th>
									<th id="txtNm4">속수량</th>
									<th>최저단가</th>
									<th>최고단가</th>
									<th>평균단가</th>
								</tr>
							</thead>
							<tbody id="kwangJuFlowerTxt">
							</tbody>
						</table>
					</div>
					<div class="auction_graph_b" id="chartHolder4" style="height:324px;">
					</div>
				</div>
			</div>
		<!--5tp-->
			<div class="auction_b">
				<div class="auction_box_b">
					<h2 class="title_02">한국화훼농협(음성)</h2>
					<div class="auction_list_b">
						<table>
							<caption>경매기록부</caption>	
							<colgroup>
								<col style="width:6%">
								<col style="width:15%">
								<col style="width:16%">
								<col style="width:19%">
								<col style="width:10%">
								<col style="width:11%">
								<col style="width:11%">
								<col style="width:11%">
							</colgroup>
							<thead>
								<tr>
									<th>순위</th>
									<th>날짜</th>
									<th>품목명</th>
									<th>품종명</th>
									<th id="txtNm5">속수량</th>
									<th>최저단가</th>
									<th>최고단가</th>
									<th>평균단가</th>
								</tr>
							</thead>
							<tbody id="hanKookUmFlowerTxt">
							</tbody>
						</table>
					</div>
					<div class="auction_graph_b" id="chartHolder5" style="height:324px;">
					</div>
				</div>
			</div>
		<!--6tp-->
			<div class="auction_b">
				<div class="auction_box_b">
					<h2 class="title_02">한국화훼농협(과천)</h2>
					<div class="auction_list_b">
						<table>
							<caption>경매기록부</caption>	
							<colgroup>
								<col style="width:6%">
								<col style="width:15%">
								<col style="width:16%">
								<col style="width:19%">
								<col style="width:10%">
								<col style="width:11%">
								<col style="width:11%">
								<col style="width:11%">
							</colgroup>
							<thead>
								<tr>
									<th>순위</th>
									<th>날짜</th>
									<th>품목명</th>
									<th>품종명</th>
									<th id="txtNm6">속수량</th>
									<th>최저단가</th>
									<th>최고단가</th>
									<th>평균단가</th>
								</tr>
							</thead>
							<tbody id="hankookbonFlowerTxt">
							</tbody>
						</table>
					</div>
					<div class="auction_graph_b" id="chartHolder6" style="height:324px;">
					</div>
				</div>
			</div>
			
			<!-- 버튼박스(S) -->
			<div class="dwn_bt_b" id="excelBtn1">
				<a href="#!">엑셀저장</a>
			</div>
			<!-- 버튼박스(E) -->
	
			<div class="guide">
				<h2 class="title_02">이용안내</h2>
				<ul class="guide_box">
					<li>· 경매 속수량이 많은 상위 6개 품종에 대한 경락가격을 공판장별로 비교분석 할수 있는 화면 </li>
					<li>· 최근1개월, 최근6개월, 최근1년 버튼 선택 시, 선택한 날짜의 데이터가 그래프에 표출</li>
					<li>· 조회목록의 1순위의 품목명이 그래프의 1순위의 품종명입니다. (품종명 : 1순위=1순위, 2순위=2순위 ....)</li>
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