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
	<meta charset="utf-8"/>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1"/>
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, user-scalable=no"/>
	<meta name="apple-mobile-web-app-title" content="화훼유통정보시스템"/>
	<meta name="robots" content="no-index,follow"/>
	<meta name="og:title" content="화훼유통정보시스템"/>
	<meta name="og:description" content="화훼유통정보시스템"/>
	<meta name="description" content="경매기록부">
	<meta name="content" content="화훼유통정보시스템 입니다."/>
	<meta name="keywords" content="화훼경매시세, 화훼경매가격, Korea aT flower market auction price, 화훼공판장, 화훼거래정보, 꽃시장, 꽃값">
	<meta name="Author" content="화훼유통정보시스템 & www.woorim.co.kr"/>
	<title>경매기록부</title>	
	<%@include file="../common/2020/commonCss.jsp" %>
	<%@include file="../common/2020/commonJs.jsp" %>
	
	<script type="text/javascript">
	var goodName1 = null;

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

	rMateChartH5.create("chart1", "chartHolder", chartVars, "100%", "100%"); 
	rMateChartH5.create("chart2", "chartHolder2", chartVars2, "100%", "100%"); 
	rMateChartH5.create("chart3", "chartHolder3", chartVars3, "100%", "100%"); 
	rMateChartH5.create("chart4", "chartHolder4", chartVars4, "100%", "100%"); 
	rMateChartH5.create("chart5", "chartHolder5", chartVars5, "100%", "100%"); 
	rMateChartH5.create("chart6", "chartHolder6", chartVars6, "100%", "100%");
	rMateChartH5.create("chart7", "chartHolder7", chartVars7, "100%", "100%"); 
	rMateChartH5.create("chart8", "chartHolder8", chartVars8, "100%", "100%");

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
		/* var searchCmpCd=$("#cmpCdTab .on > input").attr("value");
		if(searchCmpCd=="1288202296"){
			document.getElementById(id).setLayout(layoutStr6_1);	
		}else{
			document.getElementById(id).setLayout(layoutStr6);
		} */
		document.getElementById(id).setLayout(layoutStr6);
		document.getElementById(id).setData(chartData6);
	}
	
	function chartReadyHandler7(id) {
		document.getElementById(id).setLayout(layoutStr7);
		document.getElementById(id).setData(chartData7);
	}
	
	function chartReadyHandler8(id) {
		document.getElementById(id).setLayout(layoutStr8);
		document.getElementById(id).setData(chartData8);
	}

	//스트링 형식으로 레이아웃 정의.
	var layoutStr = 
					'<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'					
						+'<Pie2DChart showDataTips="true" innerRadius="0" depth="50" paddingLeft="1" paddingTop="1" paddingRight="1" paddingBottom="1">'
							+'<series>'
								+'<Pie2DSeries nameField="GOOD_NAME" field="TOT_QTY" labelPosition="inside" color="#ffffff">'
								/* Pie2DChart 정의 후 Pie2DSeries labelPosition="inside"정의합니다 */
									+'<showDataEffect>'
									/* 차트 생성시에 Effect를 주고 싶을 때 shoDataEffect정의합니다 */
										+'<SeriesSlide direction="right" duration="1000"/>'
									+'</showDataEffect>'
								+'</Pie2DSeries>'
							+'</series>'
						+'</Pie2DChart>'
					+'</rMateChart>';

	//차트 데이터
	var chartData = [];
	
	//차트 데이터
	var chartData2 = [];
	
	var layoutStr2 = '<rMateChart  backgroundColor="#ffffff" borderStyle="none">'	
								 +'<Options>'
								 +'<Legend position="bottom" width="100%" height="45" verticalScrollPolicy="on" defaultMouseOverAction="false" useVisibleCheck="true" fontSize="10"/>'
								 +'</Options>'
								+'<NumberFormatter id="numFmt" precision="0"/>'
								+'<Line2DChart showDataTips="true" dataTipDisplayMode="axis" paddingTop="0">'
									+'<horizontalAxis>'
										+'<CategoryAxis categoryField="SALE_MONTH"/>'
									+'</horizontalAxis>'
									+'<verticalAxis>'
										+'<LinearAxis />'
									+'</verticalAxis>'
									+'<series>'
										+'<Line2DSeries  yField="avg1" radius="5"  itemRenderer="DiamondItemRenderer" fill="#ffffff">'
											/* 아이템렌더러(데이터 마커) 테두리 색상 */
											+'<stroke><Stroke color="#fe6500" weight="1"/></stroke>'
											+'<showDataEffect>'
												+'<SeriesInterpolate/>'
											+'</showDataEffect>'
										+'</Line2DSeries>'
									+'</series>'
								+'</Line2DChart>'
							+'</rMateChart>';
	
	function setLayoutStr(goodName1, goodName2, goodName3, goodName4, goodName5, goodName6, layoutStr){
		var rtnLayoutStr ='<rMateChart  backgroundColor="#ffffff" borderStyle="none">'	
			 +'<Options>'
			 +'<Legend position="bottom" width="100%" height="45" verticalScrollPolicy="on" defaultMouseOverAction="false" useVisibleCheck="true" fontSize="10"/>'
			 +'</Options>'
			+'<NumberFormatter id="numFmt"  useThousandsSeparator="true"/>'
			+'<Line2DChart showDataTips="true" dataTipDisplayMode="axis" paddingTop="0">'
				+'<horizontalAxis>'
					+'<CategoryAxis categoryField="SALE_MONTH"/>'
				+'</horizontalAxis>'
				+'<verticalAxis>'
					+'<LinearAxis formatter="{numFmt}"/>'
				+'</verticalAxis>'
				+'<series>';
				if(goodName1!=''){
					rtnLayoutStr +='<Line2DSeries  yField="AVG1" radius="5" displayName="'+goodName1+'" itemRenderer="DiamondItemRenderer" fill="#ffffff">'
					/* 아이템렌더러(데이터 마커) 테두리 색상 */
					+'<stroke><Stroke color="#fe6500" weight="1"/></stroke>'
					+'<showDataEffect>'
						+'<SeriesInterpolate/>'
					+'</showDataEffect>'
				+'</Line2DSeries>';
				}
				if(goodName2!=''){
					rtnLayoutStr +='<Line2DSeries  yField="AVG2" radius="3" displayName="'+goodName2+'" itemRenderer="CircleItemRenderer"  fill="#ffffff" >'
					/* itemRenderer는 Circle입니다 */
						+'<stroke><Stroke color="#ffb801" weight="1"/></stroke>'
						+'<showDataEffect>'
							+'<SeriesInterpolate/>'
						+'</showDataEffect>'
					+'</Line2DSeries>';
				}
				if(goodName3!=''){
					rtnLayoutStr +='<Line2DSeries  yField="AVG3" radius="3" displayName="'+goodName3+'" itemRenderer="CircleItemRenderer" fill="#ffffff" >'
					/* itemRenderer는 Circle입니다 */
						+'<stroke><Stroke color="#ffb801" weight="1"/></stroke>'
						+'<showDataEffect>'
							+'<SeriesInterpolate/>'
						+'</showDataEffect>'
					+'</Line2DSeries>';
				}
				if(goodName4!=''){
					rtnLayoutStr +='<Line2DSeries  yField="AVG4" fill="#ffffff" radius="3" displayName="'+goodName4+'" itemRenderer="CrossItemRenderer">'
					/* itemRenderer는 Triangle입니다 */
						+'<stroke><Stroke color="#666666" weight="1"/></stroke>'
						+'<showDataEffect>'
							+'<SeriesInterpolate/>'
						+'</showDataEffect>'
					+'</Line2DSeries>';
				}
				if(goodName5!=''){
					rtnLayoutStr +='<Line2DSeries  yField="AVG5" fill="#ffffff" radius="3" displayName="'+goodName5+'"  itemRenderer="XShapeItemRenderer">'
					/* itemRenderer는 Triangle입니다 */
						+'<stroke><Stroke color="#50C7F5" weight="1"/></stroke>'
						+'<showDataEffect>'
							+'<SeriesInterpolate/>'
						+'</showDataEffect>'
					+'</Line2DSeries>';
				}
				if(goodName6!=''){
					rtnLayoutStr +='<Line2DSeries  yField="AVG6" fill="#ffffff" radius="3" displayName="'+goodName6+'"  itemRenderer="IShapeItemRenderer">'
					/* itemRenderer는 Triangle입니다 */
						+'<stroke><Stroke color="#3284C3" weight="1"/></stroke>'
						+'<showDataEffect>'
							+'<SeriesInterpolate/>'
						+'</showDataEffect>'
					+'</Line2DSeries>';
				}
				rtnLayoutStr +='</series>'
			+'</Line2DChart>'
		+'</rMateChart>';
		
		if(layoutStr=='layoutStr2'){
			layoutStr2=rtnLayoutStr;
		}else if(layoutStr=='layoutStr4'){
			layoutStr4=rtnLayoutStr;
		}else if(layoutStr=='layoutStr6'){
			layoutStr6=rtnLayoutStr;
		}else if(layoutStr=='layoutStr8'){
			layoutStr8=rtnLayoutStr;
		}
	}
		

	var chartData3 = [];
	var layoutStr3 = 
		'<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'					
		+'<Pie2DChart showDataTips="true" innerRadius="0" depth="50" paddingLeft="1" paddingTop="1" paddingRight="1" paddingBottom="1">'
			+'<series>'
				+'<Pie2DSeries nameField="GOOD_NAME" field="TOT_QTY" labelPosition="inside" color="#ffffff">'
				/* Pie2DChart 정의 후 Pie2DSeries labelPosition="inside"정의합니다 */
					+'<showDataEffect>'
					/* 차트 생성시에 Effect를 주고 싶을 때 shoDataEffect정의합니다 */
						+'<SeriesSlide direction="right" duration="1000"/>'
					+'</showDataEffect>'
				+'</Pie2DSeries>'
			+'</series>'
		+'</Pie2DChart>'
	+'</rMateChart>';
	
	//차트 데이터
	var chartData4 = []
	var layoutStr4 ='<rMateChart  backgroundColor="#ffffff" borderStyle="none">'	
		 +'<Options>'
		 +'<Legend position="bottom" width="100%" height="45" verticalScrollPolicy="on" defaultMouseOverAction="false" useVisibleCheck="true" fontSize="10"/>'
		 +'</Options>'
		+'<NumberFormatter id="numFmt" precision="0"/>'
		+'<Line2DChart showDataTips="true" dataTipDisplayMode="axis" paddingTop="0">'
			+'<horizontalAxis>'
				+'<CategoryAxis categoryField="SALE_MONTH"/>'
			+'</horizontalAxis>'
			+'<verticalAxis>'
				+'<LinearAxis />'
			+'</verticalAxis>'
			+'<series>'
				+'<Line2DSeries  yField="avg1" radius="5" itemRenderer="DiamondItemRenderer"  fill="#ffffff">'
					/* 아이템렌더러(데이터 마커) 테두리 색상 */
					+'<stroke><Stroke color="#fe6500" weight="1"/></stroke>'
					+'<showDataEffect>'
						+'<SeriesInterpolate/>'
					+'</showDataEffect>'
				+'</Line2DSeries>'
			+'</series>'
		+'</Line2DChart>'
	+'</rMateChart>';
	
	
	var layoutStr5 = 
		'<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'					
		+'<Pie2DChart showDataTips="true" innerRadius="0" depth="50" paddingLeft="1" paddingTop="1" paddingRight="1" paddingBottom="1">'
			+'<series>'
				+'<Pie2DSeries nameField="GOOD_NAME" field="TOT_QTY" labelPosition="inside" color="#ffffff">'
				/* Pie2DChart 정의 후 Pie2DSeries labelPosition="inside"정의합니다 */
					+'<showDataEffect>'
					/* 차트 생성시에 Effect를 주고 싶을 때 shoDataEffect정의합니다 */
						+'<SeriesSlide direction="right" duration="1000"/>'
					+'</showDataEffect>'
				+'</Pie2DSeries>'
			+'</series>'
		+'</Pie2DChart>'
	+'</rMateChart>';

	//차트 데이터
	
	var chartData5 =[];
	
	//차트 데이터
	var chartData6 =[];
	
	var layoutStr6 = '<rMateChart  backgroundColor="#ffffff" borderStyle="none">'	
		 +'<Options>'
		 +'<Legend position="bottom" width="100%" height="45" verticalScrollPolicy="on" defaultMouseOverAction="false" useVisibleCheck="true" fontSize="10"/>'
		 +'</Options>'
		+'<NumberFormatter id="numFmt" precision="0"/>'
		+'<Line2DChart showDataTips="true" dataTipDisplayMode="axis" paddingTop="0">'
			+'<horizontalAxis>'
				+'<CategoryAxis categoryField="SALE_MONTH"/>'
			+'</horizontalAxis>'
			+'<verticalAxis>'
				+'<LinearAxis />'
			+'</verticalAxis>'
			+'<series>'
				+'<Line2DSeries  yField="avg1" radius="5" itemRenderer="DiamondItemRenderer" fill="#ffffff">'
					/* 아이템렌더러(데이터 마커) 테두리 색상 */
					+'<stroke><Stroke color="#fe6500" weight="1"/></stroke>'
					+'<showDataEffect>'
						+'<SeriesInterpolate/>'
					+'</showDataEffect>'
				+'</Line2DSeries>'
			+'</series>'
		+'</Line2DChart>'
	+'</rMateChart>';
	
	//차트 데이터
	var chartData7 = [];
	//스트링 형식으로 레이아웃 정의.
	var layoutStr7 = 
		'<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'					
		+'<Pie2DChart showDataTips="true" innerRadius="0" depth="50" paddingLeft="1" paddingTop="1" paddingRight="1" paddingBottom="1">'
			+'<series>'
				+'<Pie2DSeries nameField="GOOD_NAME" field="TOT_QTY"  abelPosition="inside" color="#ffffff">'
				/* Pie2DChart 정의 후 Pie2DSeries labelPosition="inside"정의합니다 */
					+'<showDataEffect>'
					/* 차트 생성시에 Effect를 주고 싶을 때 shoDataEffect정의합니다 */
						+'<SeriesSlide direction="right" duration="1000"/>'
					+'</showDataEffect>'
				+'</Pie2DSeries>'
			+'</series>'
		+'</Pie2DChart>'
	+'</rMateChart>';
	
	//차트 데이터
	var chartData8 =[];
	
	var layoutStr8 = '<rMateChart  backgroundColor="#ffffff" borderStyle="none">'	
		 +'<Options>'
		 +'<Legend position="bottom" width="100%" height="45" verticalScrollPolicy="on" defaultMouseOverAction="false" useVisibleCheck="true" fontSize="10"/>'
		 +'</Options>'
		+'<NumberFormatter id="numFmt" precision="0"/>'
		+'<Line2DChart showDataTips="true" dataTipDisplayMode="axis" paddingTop="0">'
			+'<horizontalAxis>'
				+'<CategoryAxis categoryField="SALE_MONTH"/>'
			+'</horizontalAxis>'
			+'<verticalAxis>'
				+'<LinearAxis />'
			+'</verticalAxis>'
			+'<series>'
				+'<Line2DSeries  yField="avg1" radius="5"  itemRenderer="DiamondItemRenderer" fill="#ffffff">'
					/* 아이템렌더러(데이터 마커) 테두리 색상 */
					+'<stroke><Stroke color="#fe6500" weight="1"/></stroke>'
					+'<showDataEffect>'
						+'<SeriesInterpolate/>'
					+'</showDataEffect>'
				+'</Line2DSeries>'
			+'</series>'
		+'</Line2DChart>'
	+'</rMateChart>';
	
	function rMateChartH5ChangeTheme(theme){
		document.getElementById("chart1").setTheme(theme);
	}

	//-----------------------차트 설정 끝 -----------------------
	function cutChart(value){
		if(value ==1){
			$('#chartHolder').show();
			$('#chartHolder2').hide();
			chartReadyHandler("chart1");
		}else{	
			$('#chartHolder').hide();
			$('#chartHolder2').show();
			chartReadyHandler2("chart2");
		}
	}

	function cutChart2(value){
		if(value ==1){
			$('#chartHolder3').show();
			$('#chartHolder4').hide();
			chartReadyHandler3("chart3");
		}else{	
			$('#chartHolder3').hide();
			$('#chartHolder4').show();
			chartReadyHandler4("chart4");
		}
	}

	function cutChart3(value){
		if(value ==1){
			$('#chartHolder5').show();
			$('#chartHolder6').hide();
			chartReadyHandler5("chart5");
		}else{	
			$('#chartHolder5').hide();
			$('#chartHolder6').show();
			chartReadyHandler6("chart6");
		}
	}
	
	function cutChart4(value){
		if(value ==1){
			$('#chartHolder7').show();
			$('#chartHolder8').hide();
			chartReadyHandler7("chart7");
		}else{	
			$('#chartHolder7').hide();
			$('#chartHolder8').show();
			chartReadyHandler8("chart8");
		}
	}
	
	// 엑셀 다운로드
	function excelExport(){
		var excelNm = "경매기록부";
		cmpCd = $("#cmpCdTab .on > input").attr("value");
		flowerCd = $("#flowerTab .on > input").attr("value");
		var param = "?excelNm="+excelNm+"&searchCmpCd="+cmpCd;
		location.href = "/excel/excelDownLoad.do"+param;
	}

	var fnObj = {
		pageStart: function(){
			
			$("#excelBtn1").empty();
			$("#excelBtn1").append('<a href="javascript:void(0);" id="exportBtn1" name="exportTable1" onclick="excelExport();"><img src="../images/2020/exel.png" alt="엑셀이미지">엑셀저장</a>');
			
			
			$('#chartHolder2').hide();
			$('#chartHolder4').hide();
			$('#chartHolder6').hide();
			$('#chartHolder8').hide();
			
			$("#myTab01").bindTab({
				theme : "AXTabs",
				value:"",
				overflow:"scroll", /* "visible" */
				options:[
					{optionValue:"M", optionText:"거래량차트", closable:true}, 
					{optionValue:"F", optionText:"평균가그래프", closable:true}						
				],
				onchange: function(selectedObject, value){
					toast.push("onchange: "+Object.toJSON(value));
				},
				onclose: function(selectedObject, value){
					toast.push("onclose: "+Object.toJSON(value));
				}
			});
			$("#subSearchMenu").hide();	
		}//pageStartEnd                   
		                        
	};
	
	function getSaledate(cmpCd){
		setSearchCmpCd(cmpCd);
	}
	
	function setSearchCmpCd(cmpCd){
		
		$.cookie("cookie.cmpCd", cmpCd, {expires: 7, path: '/' });
		
		$.ajax({
    		type : "post",
    		url : "/haa01/getData.json",
    		data : {
    			searchCmpCd : cmpCd
    		},
    		dataType : '',
    		success : function(res){
    			chartData = res.cutFlowertList;
    			
    			var htmlTxt='';
    			var emptyChk=true;
    			if(chartData != null && chartData.length>0){
    				for(var i=0; i<chartData.length; i++){
    					if(chartData[i].PUM_NAME!=null){
    						emptyChk=false;
    						htmlTxt+='<tr>';
    						htmlTxt+='<td>'+chartData[i].PUM_NAME+'</td>';
    						htmlTxt+='<td>'+chartData[i].GOOD_NAME+'</td>';
    						htmlTxt+='<td>'+addThousandSeparatorCommas(chartData[i].TOT_QTY)+'</td>';
    						htmlTxt+='<td>'+addThousandSeparatorCommas(chartData[i].AVG_AMT)+'</td>';
    						htmlTxt+='<td>'+addThousandSeparatorCommas(chartData[i].MIN_AMT)+'</td>';
    						htmlTxt+='<td>'+addThousandSeparatorCommas(chartData[i].MAX_AMT)+'</td>';
    						htmlTxt+='</tr>';	
    					}
    				}
    			}
    			
    			if(emptyChk){
    				htmlTxt='<tr><td colspan="6">데이터가 없습니다.</td></tr>';
    			}
    			$("#cutFlowerTxt").html(htmlTxt);
    			
    			var goodName1 = "";
   				var goodName2 = "";
   				var goodName3 = "";
   				var goodName4 = "";
   				var goodName5 = "";
   				var goodName6 = "";
    				
   				if(chartData!=null&& chartData.length>0){
    				for(var i=0; i<chartData.length; i++){
    					if(chartData[i].GOOD_NAME!=null){
    						if(i==0){
    							goodName1=chartData[i].GOOD_NAME;	
    						}else if(i==1){
    							goodName2=chartData[i].GOOD_NAME;	
    						}else if(i==2){
    							goodName3=chartData[i].GOOD_NAME;	
    						}else if(i==3){
    							goodName4=chartData[i].GOOD_NAME;	
    						}else if(i==4){
    							goodName5=chartData[i].GOOD_NAME;	
    						}else if(i==5){
    							goodName6=chartData[i].GOOD_NAME;	
    						}
    					}
    				}
   				}
   				
    			setLayoutStr(goodName1, goodName2, goodName3, goodName4, goodName5, goodName6, 'layoutStr2');
    			chartData2 = res.listGraph;
    			
    			chartData3 = res.orchidFlowerList;
    			
    			htmlTxt='';
    			emptyChk=true;
    			if(chartData3 != null && chartData3.length>0){
    				for(var i=0; i<chartData3.length; i++){
    					if(chartData3[i].PUM_NAME!=null){
    						emptyChk=false;
    						htmlTxt+='<tr>';
    						htmlTxt+='<td>'+chartData3[i].PUM_NAME+'</td>';
    						htmlTxt+='<td>'+chartData3[i].GOOD_NAME+'</td>';
    						htmlTxt+='<td>'+addThousandSeparatorCommas(chartData3[i].TOT_QTY)+'</td>';
    						htmlTxt+='<td>'+addThousandSeparatorCommas(chartData3[i].AVG_AMT)+'</td>';
    						htmlTxt+='<td>'+addThousandSeparatorCommas(chartData3[i].MIN_AMT)+'</td>';
    						htmlTxt+='<td>'+addThousandSeparatorCommas(chartData3[i].MAX_AMT)+'</td>';
    						htmlTxt+='</tr>';	
    					}
    				}
    			}
    			
    			if(emptyChk){
    				htmlTxt='<tr><td colspan="6">데이터가 없습니다.</td></tr>';
    			}
    			$("#orchFlowerTxt").html(htmlTxt);
    			
    			
    			var goodName1 = "";
   				var goodName2 = "";
   				var goodName3 = "";
   				var goodName4 = "";
   				var goodName5 = "";
   				var goodName6 = "";
   				
   				if(chartData3!=null&& chartData3.length>0){
    				for(var i=0; i<chartData3.length; i++){
    					if(chartData3[i].GOOD_NAME!=null){
    						if(i==0){
    							goodName1=chartData3[i].GOOD_NAME;	
    						}else if(i==1){
    							goodName2=chartData3[i].GOOD_NAME;	
    						}else if(i==2){
    							goodName3=chartData3[i].GOOD_NAME;	
    						}else if(i==3){
    							goodName4=chartData3[i].GOOD_NAME;	
    						}else if(i==4){
    							goodName5=chartData3[i].GOOD_NAME;	
    						}else if(i==5){
    							goodName6=chartData3[i].GOOD_NAME;	
    						}
    					}
    				}
   				}
   				
   				setLayoutStr(goodName1, goodName2, goodName3, goodName4, goodName5, goodName6, 'layoutStr4');
    			chartData4 = res.listGraph2;    			
    			
    			chartData5 =res.foliagePlantList;
    			
    			htmlTxt='';
    			emptyChk=true;
    			if(chartData5 != null && chartData5.length>0){
    				for(var i=0; i<chartData5.length; i++){
    					if(chartData5[i].PUM_NAME!=null){
    						emptyChk=false;
    						htmlTxt+='<tr>';
    						htmlTxt+='<td>'+chartData5[i].PUM_NAME+'</td>';
    						htmlTxt+='<td>'+chartData5[i].GOOD_NAME+'</td>';
    						htmlTxt+='<td>'+addThousandSeparatorCommas(chartData5[i].TOT_QTY)+'</td>';
    						htmlTxt+='<td>'+addThousandSeparatorCommas(chartData5[i].AVG_AMT)+'</td>';
    						htmlTxt+='<td>'+addThousandSeparatorCommas(chartData5[i].MIN_AMT)+'</td>';
    						htmlTxt+='<td>'+addThousandSeparatorCommas(chartData5[i].MAX_AMT)+'</td>';
    						htmlTxt+='</tr>';	
    					}
    				}
    			}
    			
    			if(emptyChk){
    				htmlTxt='<tr><td colspan="6">데이터가 없습니다.</td></tr>';
    			}
    			$("#foliFlowerTxt").html(htmlTxt);
    				
   				var goodName1 = "";
   				var goodName2 = "";
   				var goodName3 = "";
   				var goodName4 = "";
   				var goodName5 = "";
   				var goodName6 = "";
   				
    			if(chartData5!=null&& chartData5.length>0){
    				for(var i=0; i<chartData5.length; i++){
    					if(chartData5[i].GOOD_NAME!=null){
    						if(i==0){
    							goodName1=chartData5[i].GOOD_NAME;	
    						}else if(i==1){
    							goodName2=chartData5[i].GOOD_NAME;	
    						}else if(i==2){
    							goodName3=chartData5[i].GOOD_NAME;	
    						}else if(i==3){
    							goodName4=chartData5[i].GOOD_NAME;	
    						}else if(i==4){
    							goodName5=chartData5[i].GOOD_NAME;	
    						}else if(i==5){
    							goodName6=chartData5[i].GOOD_NAME;	
    						}
    					}
    				}
   				}
    			
    			setLayoutStr(goodName1, goodName2, goodName3, goodName4, goodName5, goodName6, 'layoutStr6');
    			chartData6 =res.listGraph3;
    			
    			chartData7 =res.chunranPlantList;
    			htmlTxt='';
    			emptyChk=true;
    			if(chartData5 != null && chartData7.length>0){
    				for(var i=0; i<chartData7.length; i++){
    					if(chartData7[i].PUM_NAME!=null){
    						emptyChk=false;
    						htmlTxt+='<tr>';
    						htmlTxt+='<td>'+chartData7[i].PUM_NAME+'</td>';
    						htmlTxt+='<td>'+chartData7[i].GOOD_NAME+'</td>';
    						htmlTxt+='<td>'+addThousandSeparatorCommas(chartData7[i].TOT_QTY)+'</td>';
    						htmlTxt+='<td>'+addThousandSeparatorCommas(chartData7[i].AVG_AMT)+'</td>';
    						htmlTxt+='<td>'+addThousandSeparatorCommas(chartData7[i].MIN_AMT)+'</td>';
    						htmlTxt+='<td>'+addThousandSeparatorCommas(chartData7[i].MAX_AMT)+'</td>';
    						htmlTxt+='</tr>';	
    					}
    				}
    			}
    			
    			if(emptyChk){
    				htmlTxt='<tr><td colspan="6">데이터가 없습니다.</td></tr>';
    			}
    			$("#chunFlowerTxt").html(htmlTxt);
				
   				var goodName1 = "";
   				var goodName2 = "";
   				var goodName3 = "";
   				var goodName4 = "";
   				var goodName5 = "";
   				var goodName6 = "";
   				
    			if(chartData7!=null&& chartData7.length>0){
    				for(var i=0; i<chartData7.length; i++){
    					if(chartData7[i].GOOD_NAME!=null){
    						if(i==0){
    							goodName1=chartData7[i].GOOD_NAME;	
    						}else if(i==1){
    							goodName2=chartData7[i].GOOD_NAME;	
    						}else if(i==2){
    							goodName3=chartData7[i].GOOD_NAME;	
    						}else if(i==3){
    							goodName4=chartData7[i].GOOD_NAME;	
    						}else if(i==4){
    							goodName5=chartData7[i].GOOD_NAME;	
    						}else if(i==5){
    							goodName6=chartData7[i].GOOD_NAME;	
    						}
    					}
    				}
   				}
    			
    			setLayoutStr(goodName1, goodName2, goodName3, goodName4, goodName5, goodName6, 'layoutStr8');
    			chartData8 =res.listGraph4;
    			
    			rMateChartLoding("chart1", "chartReadyHandler");
    			rMateChartLoding("chart2", "chartReadyHandler2");
    			rMateChartLoding("chart3", "chartReadyHandler3");
    			rMateChartLoding("chart4", "chartReadyHandler4");
    			rMateChartLoding("chart5", "chartReadyHandler5");
    			rMateChartLoding("chart6", "chartReadyHandler6");
    			rMateChartLoding("chart7", "chartReadyHandler7");
    			rMateChartLoding("chart8", "chartReadyHandler8");
    		}
    	});
	};
		   
	$(document).ready(fnObj.pageStart); 
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
				<li>경매정보</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li>경매실적 세부정보</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li class="m_right">경매기록부</li>
			</ul>
		</div>
		<!--공통 HEADER(E)-->
		
		<!--서브 타이틀(S)-->
		<jsp:include page="../inc/2020/IncShare.jsp"/>
		
		<div class="sub_title">
			<div class="title_box">
				<h2>경매기록부</h2>
				<img src="../images/2020/sub/t_line.png" alt="방울점선">
			</div>
		</div>
		<!--서브 타이틀(E)-->
		
		<jsp:include page="../inc/2020/topCmpCdMenu.jsp"/>
		
		<!--컨텐츠 내용(S)-->
		<div class="record_b">
			<!--1pt-->
			<div class="record_box_b">
				<div class="record_pic_b">
					<img src="../images/2020/sub/step_21_off.png" alt="절화">
				</div>
				<div class="record_graph_b">
					<div class="btn_tab_graph">
						<div class="dt01 tab_dt on"><a href="#!" class="btn_graph" id="cutChart1" onclick="cutChart(1);">거래량</a></div>
						<div class="dt02 tab_dt"><a href="#!" class="btn_graph" id="cutChart2" onclick="cutChart(2);">평균가</a></div>
					</div>
					<ul class="ag_box">
						<li class="auction_graph" >
							<div id="chartHolder" style="width:100%; height:228px;"></div>
							<div id="chartHolder2" style="width:100%; height:228px;"></div>
						</li>
					</ul>
				</div>
				<div class="record_list_b">
					<table>
						<caption>경매기록부</caption>
						<colgroup>
							<col style="width:20%">
							<col style="width:20%">
							<col style="width:20%">
							<col style="width:20%">
							<col style="width:20%">
							<col style="width:20%">
						</colgroup>
						<thead>
							<tr>
								<th>주요품목</th>
								<th>주요픔종</th>
								<th>거래량</th>
								<th>평균단가</th>
								<th>최저단가</th>
								<th>최고단가</th>
							</tr>
						</thead>
						<tbody id="cutFlowerTxt">
						</tbody>
					</table>
				</div>
			</div>
			<!--2pt-->
			<div class="record_box_b">
				<div class="record_pic_b">
					<img src="../images/2020/sub/step_22_off.png" alt="난">
				</div>
				<div class="record_graph_b">
					<div class="btn_tab_graph">
						<div class="dt01 tab_dt on"><a href="#!" class="btn_graph" id="cutChart3" onclick="cutChart2(1);">거래량</a></div>
						<div class="dt02 tab_dt"><a href="#!" class="btn_graph" id="cutChart4" onclick="cutChart2(2);">평균가</a></div>
					</div>
					<ul class="ag_box">
						<li class="auction_graph">
							<div id="chartHolder3" style="width:100%; height:228px;"></div>	
							<div id="chartHolder4" style="width:100%; height:228px;"></div>	
						</li>
					</ul>
				</div>
				<div class="record_list_b">
					<table>
						<caption>경매기록부</caption>
						<colgroup>
							<col style="width:20%">
							<col style="width:20%">
							<col style="width:20%">
							<col style="width:20%">
							<col style="width:20%">
							<col style="width:20%">
						</colgroup>
						<thead>
							<tr>
								<th>주요품목</th>
								<th>주요픔종</th>
								<th>거래량</th>
								<th>평균단가</th>
								<th>최저단가</th>
								<th>최고단가</th>
							</tr>
						</thead>
						<tbody id="orchFlowerTxt">
						</tbody>
					</table>
				</div>
			</div>
			<!--3pt-->
			<div class="record_box_b">
				<div class="record_pic_b">
					<img src="../images/2020/sub/step_23_off.png" alt="관엽">
				</div>
				<div class="record_graph_b">
					<div class="btn_tab_graph">
						<div class="dt01 tab_dt on"><a href="#!" class="btn_graph" id="cutChart5" onclick="cutChart3(1);">거래량</a></div>
						<div class="dt02 tab_dt"><a href="#!" class="btn_graph" id="cutChart6" onclick="cutChart3(2);">평균가</a></div>
					</div>
					<ul class="ag_box">
						<li class="auction_graph">
							<div id="chartHolder5" style="width:100%; height:228px;"></div>	
							<div id="chartHolder6" style="width:100%; height:228px;"></div>
						</li>
					</ul>
				</div>
				<div class="record_list_b">
					<table>
						<caption>경매기록부</caption>
						<colgroup>
							<col style="width:20%">
							<col style="width:20%">
							<col style="width:20%">
							<col style="width:20%">
							<col style="width:20%">
							<col style="width:20%">
						</colgroup>
						<thead>
							<tr>
								<th>주요품목</th>
								<th>주요픔종</th>
								<th>거래량</th>
								<th>평균단가</th>
								<th>최저단가</th>
								<th>최고단가</th>
							</tr>
						</thead>
						<tbody id="foliFlowerTxt">
						</tbody>
					</table>
				</div>
			</div>
			<!--4pt-->
			<div class="record_box_b">
				<div class="record_pic_b">
					<img src="../images/2020/sub/step_24_off.png" alt="춘란">
				</div>
				<div class="record_graph_b">
					<div class="btn_tab_graph">
						<div class="dt01 tab_dt on"><a href="#!" class="btn_graph" id="cutChart7" onclick="cutChart4(1);">거래량</a></div>
						<div class="dt02 tab_dt"><a href="#!" class="btn_graph" id="cutChart8" onclick="cutChart4(2);">평균가</a></div>
					</div>
					<ul class="ag_box">
						<li class="auction_graph">
							<div id="chartHolder7" style="width:100%; height:228px;"></div>	
							<div id="chartHolder8" style="width:100%; height:228px;"></div>
						</li>
					</ul>					
				</div>
				<div class="record_list_b">
					<table>
						<caption>경매기록부</caption>
						<colgroup>
							<col style="width:20%">
							<col style="width:20%">
							<col style="width:20%">
							<col style="width:20%">
							<col style="width:20%">
							<col style="width:20%">
						</colgroup>
						<thead>
							<tr>
								<th>주요품목</th>
								<th>주요픔종</th>
								<th>거래량</th>
								<th>평균단가</th>
								<th>최저단가</th>
								<th>최고단가</th>
							</tr>
						</thead>
						<tbody id="chunFlowerTxt">
						</tbody>
					</table>
				</div>
			</div>
			
			<!-- 버튼박스(S) -->
			<div class="dwn_bt_b" id="excelBtn1">
				<a href="#!"><img src="../images/2020/exel.png" alt="엑셀이미지">엑셀저장</a>
			</div>
			<!-- 버튼박스(E) -->
		</div>
		
		<div class="sub_guide">
			<div class="guide">
				<h2 class="title_02">이용안내</h2>
				<ul class="guide_box">
					<li>· <strong>당월</strong>의 <strong>각 공판장별 6개의 주요품종</strong>에 대한 <strong>거래량</strong>과 <strong>단가</strong>를 나타내는 화면이며, <strong>거래량차트</strong>와 <strong>평균가그래프</strong>를 <strong>클릭</strong>하시면 해당하는 차트 데이터가 나옵니다. </li>
					<li>· 단위 : 거래량(속), 단가(원) / 자료출처 : 각 공판장별 경매 자료 현황</li>
				</ul>
			</div>
		</div>
		<!--컨텐츠 내용(E)-->
		
		<jsp:include page="../inc/2020/IncFooter.jsp"/>
		
	</div>
	<!--WRAP(E)-->
</body>
</html>