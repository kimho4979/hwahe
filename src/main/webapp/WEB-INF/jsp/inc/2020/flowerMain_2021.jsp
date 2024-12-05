<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="Author" content="">
<meta name="Keywords" content="">
<meta name="Description" content="">
<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1" />
<meta name="viewport" content="initial-scale=1.0, maximum-scale=5.0, minimum-scale=1.0, width=device-width">
<!-- <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, user-scalable=no"> -->
<title>화훼유통정보시스템</title>

<%@include file="../common/main/commonJs.jsp" %>
<%@include file="../common/main/commonCss.jsp" %>

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
	//var mapDataBaseURL = "/rMateMapChart/Samples/MapDataBaseXml/SouthKoreaDrillDownSeoulDong_scale.xml";
	var mapDataBaseURL = "/rMateMapChart/xml/MapDataBaseXml/SouthKoreaDrillDownSeoulDong_scale.xml";
	
	//MapChart Source 선택
	var sourceURL = "/rMateMapChart/Samples/MapSource/SouthKoreaDrillDownSeoulDong.svg";

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
	
	function labelFunction(seriesId, code, label, data) {
		
		var text = {"text":label, "color":"#000000", "fontSize":"11", "fontWeight":"bold", "lineHeight":5};
		return text;
	}
	
	function divDataTipFunction(seriesId, code, label, data) {
		
		if(data.totQty != null){
			var html = "<div style=\"padding:3px;\"><div>"+label+"</div>";
				html += "<div>일일출하량 : "+data.totQty.toLocaleString('ko-KR')+" 단(속)</div>";
				html += "<div>일일출하액 : "+data.totAmt.toLocaleString('ko-KR')+" 만원</div></div>";
			return html;

		}else{
			return "데이터가 없습니다.";
		}
	  
	}
	
	function clickFunction(code, label, data) {
		var searchAreaSaleDate = $("#searchAreaSaleDate").val();
		getAreaChartData(searchAreaSaleDate, code);
	}
	
	var layoutStr = null;
	var mapData = null;
	//-----------------------맵차트 설정 끝 -----------------------
</script>

<script type="text/javascript">
	//----------------------- 차트 설정 시작 -----------------------
	//rMate 차트 생성 준비가 완료된 상태 시 호출할 함수를 지정합니다.
	var dataListChk = 1;
	var chartVars1 = "rMateOnLoadCallFunction=chartReadyHandler1";
	var chartVars2 = "rMateOnLoadCallFunction=chartReadyHandler2";
	
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
	
 	var layoutStr1 =
	             '<rMateChart backgroundColor="#FFFFFF" borderStyle="none" backgroundAlpha="0" >'
	                 +'<HalfPie2DChart showDataTips="true" dataTipJsFunction="dataTipFunction" paddingBottom="0">'
	                      +'<series>'
	                           +'<HalfPie2DSeries nameField="pumName" fontSize="17" field="totQty" outerRadius="1" labelPosition="inside" color="#fff" labelField="pumName" alwaysShowInsideLabel="true" textOverflowEllipsis="true" >'
	                                +'<fills>'
	                                  +'<SolidColor color="#FD5C52"/>'
	                                  +'<SolidColor color="#7A95EC"/>'
	                                  +'<SolidColor color="#C270EC"/>'
	                                  +'<SolidColor color="#69DBA0"/>'
	                                  +'<SolidColor color="#F3CA61"/>'
	                                  +'<SolidColor color="#B5B5B5"/>'
	                              +'</fills>'
	                               +'<showDataEffect>'
	                                    +'<SeriesInterpolate duration="1000"/>'
	                               +'</showDataEffect>'
	                          +'</HalfPie2DSeries>'
	                     +'</series>'
	                      +'<annotationElements>'
	                      +'<CanvasElement>'
	                           +'<CanvasLabel horizontalCenter="0" height="24" fontSize="19" verticalCenter="86" text="2019" color="#333333"/>'
	                         +'<CanvasLabel horizontalCenter="0" height="19" fontSize="14" verticalCenter="106" text="Annual Report" color="#666666"/>'
	                       +'</CanvasElement>'
	                  +'</annotationElements>'
	                  +'</HalfPie2DChart>'
	              +'</rMateChart>';
	 
	var layoutStr2 =
	             '<rMateChart backgroundColor="#FFFFFF" borderStyle="none">'
	                 +'<Options>'
	                   +'<SubCaption text="출하량(단(속))"  color="#000000"  textAlign="left"/>'
	                 +'</Options>'
	                 +'<NumberFormatter id="numFmt" useThousandsSeparator="true"/>'
	                   +'<Column2DChart showDataTips="true" selectionMode="multiple" columnWidthRatio="0.48">'
	                       +'<horizontalAxis>'
	                           +'<CategoryAxis categoryField="chartX"  labelJsFunction="changeColorLabel"   />'
	                       +'</horizontalAxis>'
	                       +'<verticalAxis>'
	                       	   +'<LinearAxis id="vAxis" formatter="{numFmt}" minimum="0"  labelJsFunction="changeColorLabel"  />'
	                       +'</verticalAxis>'
	                       +'<series>'
	                           +'<Column2DSeries yField="totQty">'
		                           +'<fills>'
			                           +'<SolidColor color="#67B7DC"/>'
			                           +'<SolidColor color="#6894DD"/>'
			                           +'<SolidColor color="#6671DB"/>'
			                           +'<SolidColor color="#8067DC"/>'
			                           +'<SolidColor color="#A267DB"/>'
			                           +'<SolidColor color="#C767DB"/>'
		                           +'</fills>'
	                           +'</Column2DSeries>'
	                       +'</series>'
	                  +'</Column2DChart>'
	               +'</rMateChart>';   
	              
	// 차트 데이터
	var chartData1 = [];
	var chartData2 = [];
	
	function rMateChartH5ChangeTheme(theme){
	    document.getElementById("chart1").setTheme(theme);
	}
	
	function changeColorLabel(id, value) {
		  return  value + "<font color='#000000'>"+value+"</font>";
	}
	
	
	function rMateChartH5ChangeTheme(theme){
	    document.getElementById("chart2").setTheme(theme);
	}
	
	function checkData1(data){
		if(data.length <= 0){
			// 데이터가 없을 경우 hasNoData함수를 실행하여 메세지창을 출력한다.
			//document.getElementById("chart1").hasNoData(false);
			document.getElementById("chart1").hasNoData(true, "<br>해당 데이터가 없습니다.", "알림");
		}		
	}
	
	function checkData2(data){
		if(data.length <= 0){
			// 데이터가 없을 경우 hasNoData함수를 실행하여 메세지창을 출력한다.
			//document.getElementById("chart2").hasNoData(true);
			document.getElementById("chart2").hasNoData(true, "<br>해당 데이터가 없습니다.", "알림");
		}
	}
	// ----------------------- 차트 설정 끝 -----------------------
	
	function dataTipFunction(seriesId, seriesName, index, xName, yName, data, values) {
		if(data.totQty != null){
			var html  = "<div style=\"padding:3px;\"><div>" + data.pumName + "</div>";
				html += "<div>거래량 : " + data.totQty.toLocaleString('ko-KR') + " 단(속)</div>";
				html += "<div>최고단가 : " + data.maxAmt.toLocaleString('ko-KR') + " 원</div>";
				html += "<div>최저단가 : " + data.minAmt.toLocaleString('ko-KR') + " 원</div>";
				html += "<div>평균단가 : " + data.avgAmt.toLocaleString('ko-KR') + " 원</div></div>";
			return html;
				
		}else{
			return "데이터가 없습니다.";
		}
	}
	
</script>

<script type="text/javascript">
	$(document).ready(function() {

		$(".tit_box2 .fl ul li").click(function(){
			$('.title-tab').attr('class','title-tab');
			$(this).attr('class', 'title-tab on');
			dataListChk = $('.title-tab.on > input').attr("value");
			
			if(dataListChk == 1){
				$("#realDataArea").css("display","block");
				$("#saleDataArea").css("display","none");
				$("#realCommnet").css("display","block");
				$("#realUrl").attr("href","/real/real2.do")
				getRealSaleDate();
			}else{
				$("#realDataArea").css("display","none");
				$("#saleDataArea").css("display","block");
				$("#realCommnet").css("display","none");
				$("#realUrl").attr("href","/haa00_new/haa00_new.do");
				//$("#realUrl").attr("href","/haa00/haa00.do");
				getSaleDate();
			}
			
		});
		
		$("#cmpCdReal").change(function(){
			getRealSaleDate();
			getSaleDate();
		});
		
		// 실시간 경매정보
		getRealSaleDate();
		// 정산 경매정보
		getSaleDate();
		// 품목별 거래현황
		getPumMokSaledate();
		// 지역별 거래현황
		getAreaSaleDate();
		
		if(matchMedia("screen and (max-width: 990px)").matches){ 
			$("#deal_trend_title").text("양재 거래동향");
		}else {
			$("#deal_trend_title").text ("양재공판장 거래동향");
		}; 
 	});
	
 	$(window).resize(function(){ 
		if (window.innerWidth > 990) {
			$("#deal_trend_title").text("양재공판장 거래동향");
		}else { 
			$("#deal_trend_title").text("양재 거래동향");
		} 
	}).resize();


	function getRealSaleDate(){
		var cmpCd = $("#cmpCdReal").val();
		
		$.ajax({
			type : "post",
			url : "/main/getRealSaleDate.json",
			data : {
				searchCmpCd : cmpCd
			},
			dataType : '',
			success : function(res){
				// 리스트 초기화
				$("#realDataList").html('');
				
				var val = res.list;
				if(res.list!=null && res.list.length > 0){
					// 실시간 경매정보
					getRealList(val[0].saleDate);
					
				}else{
					if(cmpCd != '6068207466' && cmpCd != '6158209828'){
						$("#realDataList").html('<tr><td colspan="7"><div class="no_data_box"><img alt="해당데이터가 없습니다." src="../images/main/no_data.png"></div></td></tr>');	
					}else{
						$("#realDataList").html('<tr><td colspan="7"><div class="no_data_box"><img src="../images/main/no_data1.png"></div></td></tr>');
					}
					
				}
			}
		});
	}
	
	function getSaleDate(){
		var cmpCd = $("#cmpCdReal").val();
		
		$.ajax({
			type : "post",
			url : "/main/getSaleDate.json",
			data : {
				searchCmpCd : cmpCd
			},
			dataType : '',
			success : function(res){
				// 리스트 초기화
				$("#saleDataList").html('');
				
				var val = res.list;
				if(res.list!=null && res.list.length > 0){
					// 실시간 경매정보
					getSaleList(val[0].saleDate);
					
				}else{
					$("#saleDataList").html('<tr><td colspan="7"><div class="no_data_box"><img src="../images/main/no_data.png"></div></td></tr>');
				}
			}
		});
	}
	
	
	function getPumMokSaledate(){
		var cmpCd = $("#cmpCdPumMok").val();
		var gubn = $("#gubnPumMok").val();
		
		$.ajax({
			type : "post",
			url : "/main/getPumMokSaledate.json",
			data : {
				searchCmpCd : cmpCd,
				searchGubn : gubn
			},
			dataType : '',
			success : function(res){
				var val = res.list;
				if(res.list!=null && res.list.length > 0){
					// 품목별 거래현황
					getPumMokData(val[0].saleDate);
	
					var saleDate = val[0].saleDate.replace(/-/gi, ".");
					$("#pumMokSaleDate").text(saleDate);
					
				}else{
					// 차트 초기화
					chartData1 = [];
					$("#pumMokTotal").hide();
					$("#pumMokBtn1").hide();
					$("#pumMokSaleDate").text('');
					
					if(!document.getElementById("chart1")){
				    	rMateChartH5.create("chart1", "chartHolder1", chartVars1, "100%", "99%"); 
					 } else{
						 chartReadyHandler1("chart1");
					}
				}
			}
		});
	}
	
	function getAreaSaleDate(){
		$.ajax({
			type : "post",
			url : "/main/getAreaSaleDate.json",
			data : {},
			dataType : '',
			success : function(res){
				var val = res.list;
				if(res.list!=null && res.list.length > 0){
					// 지역별 거래현황
					getAreaChartData(val[0].saleDate);
					getAreaMapData(val[0].saleDate);
					$("#searchAreaSaleDate").val(val[0].saleDate);
					
					var saleDate = val[0].saleDate.replace(/-/gi, ".");
					$("#areaSaleDate").text(saleDate);
					
				}else{
					// 차트 초기화
					chartData2 = [];
					mapData = [];
					
					$("#areaSaleDate").text('');
					
					if(!document.getElementById("chart2")){
				    	rMateChartH5.create("chart2", "chartHolder2", chartVars2, "100%", "99%"); 
					 } else{
						 chartReadyHandler2("chart2");
					}
				}
			}
		});
	}
	
	//실시간테이블
	function getRealList(saleDate){ 
		$("#realDataList").html('<tr><td colspan="7"><div class="loading_box"><div class="loading-container"><div class="loading"></div><div id="loading-text">로딩중...</div></div></div></td></tr>');
		
		$.ajax({
			type : 'get',
			url : "/main/getRealData.json",
			data : {
				cmpCd : $("#cmpCdReal").val(),
				searchSaleDate : saleDate
			},
			dataType : '',
			success : function(res) {
				var val = res.list;
				var html = '';
				if(res.list == null || res.list.length == 0) {
					
					if(cmpCd != '6068207466' && cmpCd != '6158209828'){
						html += '<tr><td colspan="7"><div class="no_data_box"><img alt="해당 데이터가 없습니다." src="../images/main/no_data.png"></div></td></tr>';	
					}else{
						html += '<tr><td colspan="7"><div class="no_data_box"><img alt="해당 공파장은 실시간 경매정보를 제공하지 않습니다."  src="../images/main/no_data1.png"></div></td></tr>';
					}

				}else {
					for(var i=0; i<val.length; i++) {
						html += '<tr>';
						html += '<td class="tc"><p>' + val[i].pumname + '</p></td>';
						html += '<td class="tc"><p>' + val[i].goodname + '</p></td>';
						html += '<td class="tc"><p>' + val[i].lvname + '</p></td>';
						html += '<td class="tc"><p>' + val[i].qty.toLocaleString('ko-KR') + '</p></td>';
						html += '<td class="tc"><p>' + val[i].cost.toLocaleString('ko-KR') + '</p></td>';
						html += '<td class="tc"><p>' + val[i].naktime + '</p></td>';	
						html += '</tr>';
					}
					
					$("#realDataList").html(html);
				}
			}
		});
	}
	
	
	//정산테이블
	function getSaleList(saleDate){ 
		$("#saleDataList").html('<tr><td colspan="7"><div class="loading_box"><div class="loading-container"><div class="loading"></div><div id="loading-text">로딩중...</div></div></div></td></tr>');
		
		$.ajax({
			type : 'get',
			url : "/main/getSaleData.json",
			data : {
				cmpCd : $("#cmpCdReal").val(),
				searchSaleDate : saleDate
			},
			dataType : '',
			success : function(res) {
				var val = res.list;
				var html = '';
				if(res.list == null || res.list.length == 0) {
					html += '<tr><td colspan="6"><div class="no_data_box"><img src="../images/main/no_data.png"></div></td></tr>';
					
				}else {
					for(var i=0; i<val.length; i++) {
						html += '<tr>';
						html += '<td class="tc"><p>' + val[i].pumName + '</p></td>';
						html += '<td class="tc"><p>' + val[i].goodName + '</p></td>';
						html += '<td class="tc"><p>' + val[i].lvName + '</p></td>';
						html += '<td class="tc"><p>' + val[i].totQty.toLocaleString('ko-KR') + '</p></td>';
						html += '<td class="tc"><p>' + val[i].avgAmt.toLocaleString('ko-KR') + '</p></td>';
						html += '<td class="tc"><p>' + val[i].saleDate + '</p></td>';
						html += '</tr>';
					}
					
					$("#saleDataList").html(html);
				}
			}
		});
	}
	
	//품목별 거래현황
	function getPumMokData(saleDate) {
		$.ajax({
			type : 'get',
			url : "/main/getPumMokData.json",
			data : {
				cmpCd : $("#cmpCdPumMok").val(),
				searchSaleDate : saleDate,
				searchGubn : $("#gubnPumMok").val()
			},
			dataType : '',
			success : function(res) {
				var val = res.list;
				var total = res.totalInfo;
				
				if(val.length > 0) {
					var btnHtml = '';
					var totHtml = '';
					chartData1 = res.list;
					
					if(!document.getElementById("chart1")){
	                	rMateChartH5.create("chart1", "chartHolder1", chartVars1, "100%", "99%"); 
	            	} else{
	            		 chartReadyHandler1("chart1");
	        		} 
					
					$("#pumMokTotal").empty();
					$("#pumMokBtn1").empty();

					totHtml += '<li><span>총거래량</span>' + total[0].totQty.toLocaleString('ko-KR') + ' 단(속)</li>';
					totHtml += '<li><span>최고단가</span>' + total[0].maxAmt.toLocaleString('ko-KR') + ' 원</li>';
					totHtml += '<li><span>최저단가</span>' + total[0].minAmt.toLocaleString('ko-KR') + ' 원</li>';
					totHtml += '<li><span>평균단가</span>' + total[0].avgAmt.toLocaleString('ko-KR') + ' 원</li>';
					
					for(var i=0; i<val.length; i++){
						if(i == 0) {
							btnHtml = '<li><img src="../images/main/chart_btn01.png" alt="차트컬럼이미지1">' + val[i].pumName + ' ' + val[i].qtyRate + '</li><br>';
						}else if(i == 1) {
							btnHtml = '<li><img src="../images/main/chart_btn02.png" alt="차트컬럼이미지2">' + val[i].pumName + ' ' + val[i].qtyRate + '</li><br>';
						}else if(i == 2) {
							btnHtml = '<li><img src="../images/main/chart_btn03.png" alt="차트컬럼이미지3">' + val[i].pumName + ' ' + val[i].qtyRate + '</li><br>';
						}else if(i == 3) {
							btnHtml = '<li><img src="../images/main/chart_btn04.png" alt="차트컬럼이미지4">' + val[i].pumName + ' ' + val[i].qtyRate + '</li><br>';
						}else if(i == 4) {
							btnHtml = '<li><img src="../images/main/chart_btn05.png" alt="차트컬럼이미지5">' + val[i].pumName + ' ' + val[i].qtyRate + '</li><br>';
						}else {
							btnHtml = '<li><img src="../images/main/chart_btn06.png" alt="차트컬럼이미지6">' + val[i].pumName + ' ' + val[i].qtyRate + '</li>';
						}
						
						$("#pumMokBtn1").append(btnHtml);
						$("#pumMokBtn1").show();
					}
						$("#pumMokTotal").append(totHtml);
						$("#pumMokTotal").show();
						
				}else {
					chartData1 = [];
					if(!document.getElementById("chart1")){
	                	rMateChartH5.create("chart1", "chartHolder1", chartVars1, "100%", "99%"); 
	            	} else{
	            		 chartReadyHandler1("chart1");
	        		} 
				} 
			}
		});
	}
	
	//지역별 거래현황(차트)
	function getAreaChartData(saleDate, areaCode){ 
		$.ajax({
			type : 'get',
			url : "/main/getAreaChartData.json",
			data : {
				searchSaleDate : saleDate,
				searchAreaCode : areaCode
			},
			dataType : '',
			success : function(res) {
				var val = res.list;
				
				if(val.length > 0) {
					chartData2 = res.list;
					if(!document.getElementById("chart2")){
	                	rMateChartH5.create("chart2", "chartHolder2", chartVars2, "100%", "99%"); 
	            	} else{
	            		 chartReadyHandler2("chart2");
	        		} 
					
				}else {
					chartData2 = [];
					if(!document.getElementById("chart2")){
	                	rMateChartH5.create("chart2", "chartHolder2", chartVars2, "100%", "99%"); 
	            	} else{
	            		 chartReadyHandler2("chart2");
	        		} 
				}
				
			}
		});
	}
	
	//지역별 거래현황(지도)
	function getAreaMapData(saleDate){ 
		$.ajax({
			type : 'get',
			url : "/main/getAreaMapData.json",
			data : {
				searchSaleDate : saleDate
			},
			dataType : '',
			success : function(res) {
				var val = res.list;
				var max = 0;
		    	var mapInteval = 10;
		    	mapData = val;
		    	var lastMapData = mapData.pop();
		    	mapInitData = mapData;
		    	
		    	mapData = mapInitData;
	    		for(var i=0; i<mapData.length; i++){
	    			if(max < mapData[i].totQty){
		    			max = mapData[i].totQty;
		    		}
		    	}
	    		
	    		mapInteval = (max/5).toFixed(0);
		    	if(mapInteval < 1){
		    		mapInteval = 1;
		    	}
		    	
		    	layoutStr = '<rMateMapChart>'
						  + '<MapChart id="mainMap1" showDataTips="true" drillDownEnabled="false" dataTipType="Type3" mapChangeJsFunction="clickFunction" divDataTipJsFunction="divDataTipFunction">'
						  + '	<series>'
						  + '	    <MapSeries id="mapseries" labelJsFunction="labelFunction" interactive="true" selectionMarking="line" color="#000000" labelPosition="inside" displayName="Map" rollOverFillJsFunction="rollOverFillFunction" localFillByRange="[#dcdfe8,#93D6F1,#4a88b7,#596283,#5b5e67]" rangeLegendDataField="totQty" localFillJsFunction="colorFunction" >'
						  + '	    	<stroke>'
						  + '	        	<Stroke color="#8C8C8C" weight="0.8" alpha="1"/>'
						  + '	        </stroke>'
						  + '		</MapSeries>'
						  + '	</series>'
						  + '</MapChart>'
//						  + '<DataRangeLegend width="200" height="35" minimum="0" maximum="' + max + '" dataRangeHeight="20" fontSize="10" arrowOffset="0" interval="' + mapInteval + '" showArrow="true" tickGap="5" stroke="#000000" arrowColor="#ffffff" arrowStroke="#000000" colors="[#dcdfe8,#93D6F1,#4a88b7,#596283,#5b5e67]"/>'
						  + '</rMateMapChart>';
			
		    	rMateMapChartH5.create("map1", "mapHolder", mapVars, "100%", "100%");
			}
		});
	}
	
</script>

</head>
<body>
	<input type="hidden" id="searchAreaSaleDate" name="searchAreaSaleDate" value=""/>

	<!--WRAP(S)-->
	<div class="wrap">
	
		<jsp:include page="../inc/2020/IncHeader_main.jsp"/>
	
		<!-- 모든콘텐츠(S) -->
		<div class="conts_main">
			<!-- 20211012 수정(S) -->						
			<!-- 상단 이미지(S) -->
			<div class="main_bg"> 
				<div class="main_in web">
					<img src="../images/main/main_bg2.png" alt="메인이미지">
				</div>
				<div class="main_in mobile">
					<img src="../images/main/main-img-mobile2.png" alt="모바일메인이미지">
				</div>
			</div>
			<!-- 상단 이미지(E) -->
			<!-- 20211012 수정(E) -->	

			<!-- 콘텐츠정보(S) -->
			
			<div class="conts_all">
			<!-- 컨텐츠순서 01(S)-->
			<div class="top_line01">
				<!-- 왼쪽콘텐츠(S) -->
				<div class="conts_left conts_left0">
				<!-- 상단박스(S) -->
					<div class="c_l_box_top">
						<!-- 타이틀박스(S) -->
						<div class="tit_box">
							<div class="fl w70p">
								<h2 class="main_conts_title dib">품목별 거래현황</h2>								
								<span class="sale_date" id="pumMokSaleDate"></span>
								<p class="tit_p">품목별 거래현황을 한눈에 확인하세요.</p>
							</div>							
							<div class="fr">
								<!-- <label for="gubnPumMok"></label> -->
								<a href="/haa00_new/haa00_new.do" class="btn_plus2">더보기</a>
								<!-- <a href="/haa00/haa00.do" class="btn_plus2">더보기</a> -->
							</div>

							<div class="fl">
								<select class="select main_g" id="cmpCdPumMok" name="cmpCdPumMok" onchange="getPumMokSaledate();">
									<option value="0000000001">aT화훼(양재)</option>
									<option value="1508500020">부산화훼(엄궁)</option>
									<option value="6068207466">부경화훼(강동)</option>
									<option value="4108212335">광주원예(풍암)</option>
									<option value="3848200087">한국화훼(음성)</option>
									<option value="1288202296">한국화훼(과천)</option>
									<option value="6158209828">영남화훼(김해)</option>
								</select>
								<!-- <label for="cmpCdPumMok"></label> -->
								<select class="select main small" id="gubnPumMok" name="gubnPumMok" onchange="getPumMokSaledate();">
									<option value="1">절화</option>
									<option value="2">관엽</option>
									<option value="3">난</option>
								</select>								
							</div>
						</div>
						<!-- 타이틀박스(E) -->


						<!-- 화훼유통별(S) -->					
						<div class="w_sale_box">
							<!-- 화훼유통별 오른쪽(S) -->
							<div class="w_s_right">
								<div class="w_s_graph">
									<div id="chartHolder1" style="width:100%; min-width:313px; height:236px;"></div>
								</div>
 								<div class="date_list_img">
									<ul id="pumMokBtn1"></ul>
								</div>
								<ul class="graph-total" id="pumMokTotal"></ul>
							</div>
							<!-- 화훼유통별 오른쪽(E) -->
						</div>
						<!-- 화훼유통별(E) -->
					</div>
				</div>	

				<!-- 오른쪽콘텐츠(S) -->
					<div class="conts_right">
						<!-- 지역별(S) -->
						<div class="district_box">
							<!-- 그래프박스(S) -->
							<div class="graph_box">
								<!-- 타이틀박스(S) -->
								<div class="tit_box">
									<div class="fl">
										<h2 class="main_conts_title dib">지역별 거래현황</h2>
										<span class="sale_date" id="areaSaleDate"></span>
										<p class="tit_p">지역별 거래현황을 한눈에 확인하세요.</p>										
									</div>
									<div class="fr">
										<a href="/hab07/hab07.do" class="btn_plus2">더보기</a>
									</div>
								</div>
								<!-- 타이틀박스(E) -->
								<!-- 지도(S) -->
								<div class="d_b_left">
									<div id="mapHolder" style="width:100%; min-width:313px; height:399px;"></div>
								</div>
								<!-- 지도(E) -->
								<!-- 그래프(S) -->
								<div class="d_b_right">
									<div id="chartHolder2" style="width:100%; min-width:312px; height:399px;"></div>
								</div>
								<!-- 그래프(E) -->
							</div>
							<!-- 그래프박스(E) -->
						</div>
						<!-- 지역별(E) -->						
					</div>
					<!-- 상단박스(E) -->
					<!-- 거래현황(E) -->
					<!-- 왼쪽콘텐츠 (E)-->
					</div>
					<!-- 컨텐츠순서01 (E)-->
					

				<!-- 가운데콘텐츠(S) -->
				<div class="conts_center">
					<!-- 상단박스(S) -->
					<div class="c_r_box_top">
						<!-- 타이틀박스(S) -->
						<div class="tit_box2 tab">
							<div class="fl">
							<ul class="tit-tab-box">
								<li class="title-tab on">
									<input type="hidden" value="1"/>
									<a class="dib">실시간 경매정보</a>
								</li>
								<li class="title-tab">
									<input type="hidden" value="2"/>
									<a class="dib">정산 가격정보</a>
								</li><li>
							</ul>
							<select class="select main" id="cmpCdReal" name="cmpCdReal">
									<option value="0000000001">aT화훼(양재)</option>
									<option value="1508500020">부산화훼(엄궁)</option>
									<option value="6068207466">부경화훼(강동)</option>
									<option value="4108212335">광주원예(풍암)</option>
									<option value="3848200087">한국화훼(음성)</option>
									<option value="1288202296">한국화훼(과천)</option>
									<option value="6158209828">영남화훼(김해)</option>
							</select>								
							</div>

							<div class="fr tr">								
								<!-- <label for="cmpCdReal"></label> -->
								<a href="/real/real2.do" class="btn_plus01" id="realUrl">더보기</a>
							</div>
						</div>
						<!-- 타이틀박스(E) -->
						<!-- 타이틀박스_02(S) -->
						<div class="tit_box type_02">
							<div class="fl" id="realCommnet">
								<a href="#!" class="btn_refresh" onclick="getRealSaleDate();"><span></span><em>새로고침</em></a>
								<p class="txt_notice">&nbsp;&nbsp;실시간 경매정보는 10초간격으로 자동 업데이트됩니다.</p>
							</div>
						</div>
						<!-- 타이틀박스_02(E) -->

						<!-- 경매현황(실시간) 테이블(S) -->
						<div class="main_table_box" id="realDataArea" style="display:block;">
							<table class="main_table">
								<caption>realTable</caption>
								<colgroup>
									<col style="width:17%;">
									<col style="width:25%;">
									<col style="width:15%;">
									<col style="width:10%;">
									<col style="width:15%;">
									<col style="width:18%">
								</colgroup>
								<thead>
									<tr>
										<th>품목</th>
										<th>품종</th>
										<th>등급</th>
										<th>단(속)</th>
										<th>낙찰금액</th>
										<th>낙찰시간</th>
									</tr>
								</thead>
								<tbody id="realDataList">

								</tbody>
							</table>
						</div>
						<!-- 경매현황(실시간) 테이블(E) -->
						
						<!-- 정산가격정보 테이블(S) -->
						<div class="main_table_box" id="saleDataArea" style="display:none;">
							<table class="main_table">
								<caption>realTable</caption>
								<colgroup>
									<col style="width:20%;">
									<col style="width:25%;">
									<col style="width:15%;">
									<col style="width:10%;">
									<col style="width:15%;">
									<col style="width:15%;">
								</colgroup>
								<thead>
									<tr>
										<th>품목</th>
										<th>품종</th>
										<th>등급</th>
										<th>단(속)</th>
										<th>평균가</th>
										<th>일자</th>
									</tr>
								</thead>
								<tbody id="saleDataList">

								</tbody>
							</table>
						</div>
						<!-- 정산가격정보 테이블(E) -->
						
					</div>
					<!-- 상단박스(E) -->	
				</div>
				<!-- 가운데콘텐츠(S) -->

				<!-- 컨텐츠순서 02(S)-->
			<div class="top_line02">
				<!-- 왼쪽콘텐츠(S) -->
				<div class="conts_left">

					<!-- 거래현황(S) -->
					
					
					<!-- 거래동향(S) -->
					<div class="c_l_box_bottom">
						<!-- 거래동향(S) -->
						<div class="deal_trend_box">
							<!-- 타이틀박스(S) -->
							<div class="tit_box" >
								<div class="fl">
									<h2 class="main_conts_title02 main_conts_title2 dib" id="deal_trend_title" >양재 거래동향</h2>
								</div>
								<div class="btn_main_box">
									<button type="button" class="btn_main prev touch_left_btn"></button>
									<button type="button" class="btn_main next touch_right_btn"></button>
								</div>
								<!-- 
								<div class="fr">
									<a href="#!" class="btn_tit_more">더보기</a>
								</div>
								 -->
							</div>
							<!-- 타이틀박스(E) -->
							
							<!-- 소매(S) -->
							<div class="d_t_right">
								<!-- 소매수치(S) -->
								<div class="d_t_buy">
									<!-- 20211012 슬라이드 수정(S) -->	
									<!-- 소매슬라이드(S) -->
									<div class="swiper-container swiper1">
										<ul class="swiper-wrapper"> <!-- 배너 목록 -->
											<li class="swiper-slide">
												<ul class="list_box l_b_02">
													   <li class="lb-title"><span>절화</span></li>
													   <c:set var="trendList1" value="${trendList1}"/>
														<c:if test="${!empty trendList1 }">
															<c:forEach var="deal" items="${trendList1}"  varStatus="status">
															   <li class="list_total">
																   <div class="lt-title-day">${deal.saleDate}</div>
																   <span class="total_bus">총 물량</span>
																   <p class="total_sum"><fmt:formatNumber value="${deal.totQty}" pattern="#,###"/><span>단(속)</span></p>
																   <span class="total_bus">총 금액</span>
																   <p class="total_sum"><fmt:formatNumber value="${deal.totAmt}" pattern="#,###"/><span>만원</span></p>
															   </li>
															</c:forEach>
														</c:if>
												   </ul>
												</li>
												<li class="swiper-slide">
													<ul class="list_box l_b_02">
														<li class="lb-title"><span>관엽</span></li>
													   <c:set var="trendList2" value="${trendList2}"/>
														<c:if test="${!empty trendList2 }">
															<c:forEach var="deal" items="${trendList2}"  varStatus="status">
															   <li class="list_total">
																   <div class="lt-title-day">${deal.saleDate}</div>
																   <span class="total_bus">총 물량</span>
																   <p class="total_sum"><fmt:formatNumber value="${deal.totQty}" pattern="#,###"/><span>단(속)</span></p>
																   <span class="total_bus">총 금액</span>
																   <p class="total_sum"><fmt:formatNumber value="${deal.totAmt}" pattern="#,###"/><span>만원</span></p>
															   </li>
															</c:forEach>
														</c:if>
													</ul>
												</li>
												<li class="swiper-slide">
													<ul class="list_box l_b_02">
														<li class="lb-title"><span>난</span></li>
														<c:set var="trendList3" value="${trendList3}"/>
														<c:if test="${!empty trendList3 }">
															<c:forEach var="deal" items="${trendList3}"  varStatus="status">
															   <li class="list_total">
																   <div class="lt-title-day">${deal.saleDate}</div>
																   <span class="total_bus">총 물량</span>
																   <p class="total_sum"><fmt:formatNumber value="${deal.totQty}" pattern="#,###"/><span>단(속)</span></p>
																   <span class="total_bus">총 금액</span>
																   <p class="total_sum"><fmt:formatNumber value="${deal.totAmt}" pattern="#,###"/><span>만원</span></p>
															   </li>
															</c:forEach>
														</c:if>
													</ul>
												</li>
											</ul>
										 
									    </div>
									<!-- 소매슬라이드(E) -->
								</div>
								<!-- 소매수치(E) -->
							</div>
							<!-- 소매(E) -->
						</div>
						<!-- 거래동향(E) -->
					</div>
					<!-- 거래동향(E) -->
					
				</div>		
				<!-- 왼쪽콘텐츠(E) -->

				<!-- 오른쪽콘텐츠(S) -->
				<div class="conts_right">
					

					<!-- 중간박스(S) -->
					<div class="c_r_box_middle">

						<!-- 타이틀박스(S) -->
						<div class="tit_box">
							<div class="fl">
								<h2 class="main_conts_title02 dib">공지사항</h2>
							</div>
							<div class="fr">
								<a href="/hfa01/hfa01.do" class="btn_plus">더보기</a>
							</div>
						</div>
						<!-- 타이틀박스(E) -->

						<!-- 공지사항 테이블(S) -->
						<div class="notice_table_box">
							<table class="notice_table">
								<caption>noticeTable</caption>
								<colgroup>
									<col style="width:87px">
									<col style="width:auto">
								</colgroup>
								<tbody>
									<c:set var="noticeList" value="${noticeList}"/>
									<c:if test="${!empty noticeList }">
										<c:forEach var="notice" items="${noticeList}"  varStatus="status">
											<tr>
												<th class="tl" class="btn_notice_go">
													<p>${notice.INS_DT}</p>
												</th>
												<td class="tr">
													<a href='/hfa01/hfa01.do?seq=${notice.ENCRPT_SEQ}' class="btn_notice_go">&ensp; ${notice.TITLE}</a>	
												</td>
											</tr>
										</c:forEach>
									</c:if>
									<c:if test="${empty noticeList}">
										<tr><td colspan="2">데이터가 없습니다.</td></tr>
									</c:if>
								</tbody>
							</table>
						</div>
						<!-- 공지사항 테이블(E) -->	
					</div>
					<!-- 중간박스(E) -->

					
				</div>		
				<!-- 오른쪽콘텐츠(E) -->
			</div>
			<!-- 콘텐츠정보(E) -->
		</div>
			<!-- 컨텐츠순서 02(S)-->

		</div>
		<!-- 모든콘텐츠(E) -->
		
		<!-- 하단박스(S) -->
					<div class="c_r_box_bottom">
						<!-- 콘텐츠 마지막줄 슬라이드(S) -->
							<div id="banner_wrap">
								<ul id="slide_banner">
									<li>
										<a href="https://www.atfis.or.kr/home/M000000000/index.do" target='_blank' tabindex="-1">
											<img src="../images/main/slide_02.png" alt="FIS식품산업통계연보"  tabindex="-1" />
										</a>
									</li>
									<li>
										<a href="https://edu.at.or.kr/cmm/main/mainPage.do" target='_blank' tabindex="-1">
											<img src="../images/main/slide_03.png" alt="농식품유통교육원" tabindex="-1" />
										</a>
									</li>
									<li>
										<a href="https://www.kamis.or.kr/customer/main/main.do" target='_blank' tabindex="-1">
											<img src="../images/main/slide_04.png" alt="ATKMIS"  tabindex="-1" />
										</a>
									</li>
									<li>
										<a href="http://www.at.or.kr/home/fmko000000/index.action" target='_blank' tabindex="-1">
											<img src="../images/main/slide_05.png" alt="AT화훼공판장"  tabindex="-1"  />
										</a>
									</li>
									<li>
										<a href="https://www.at.or.kr/home/acko000000/index.action" target='_blank' tabindex="-1">
											<img src="../images/main/slide_06.png" alt="AT센터" tabindex="-1" />
										</a>
									</li>
									<li>
										<a href="http://www.kati.net/index.do" target='_blank' tabindex="-1">
											<img src="../images/main/slide_07.png" alt="KATI" tabindex="-1" />
										</a>
									</li>
									<li>
										<a href="https://atpool.or.kr" target='_blank' tabindex="-1">
											<img src="../images/main/slide_09.png" alt="물류기기공동이용통합관리시스템" tabindex="-1" />
										</a>
									</li>
									<li>
										<a href="https://www.nongzip.or.kr" target='_blank' tabindex="-1">
											<img src="../images/main/slide_10.png" alt="농집" tabindex="-1" />
										</a>
									</li>
									<li>
										<a href="https://www.nongnet.or.kr" target='_blank' tabindex="-1">
											<img src="../images/main/slide_11.png" alt="농넷" tabindex="-1" />
										</a>
									</li>
									<li>
										<a href="https://kadx.co.kr" target='_blank' tabindex="-1">
											<img src="../images/main/slide_12.png" alt="KADX" tabindex="-1" />
										</a>
									</li>								
								</ul>
								<p><a href="#" id="prevBtn" tabindex="0"><img src="../images/main/prev_btn.png"alt="이전버튼" tabindex="0"/></a></p>
								<p><a href="#" id="nextBtn"><img src="../images/main/next_btn.png"alt="다음버튼"/></a></p>
							</div>
						<!-- 콘텐츠 마지막줄 슬라이드(E) -->
					</div>
					<!-- 하단박스(E) -->
					<script type="text/javascript">
	//공유
	$(document).ready(function(){		
				
		$(".sns_box > li > a").click(function() {
			
			//공유타입
			var linkType = $(this).children().attr("alt");
			var url=window.location.protocol+ '//'+window.location.host+window.location.pathname;
			var strTitle = $(".sub_tit").text();
			
			if(strTitle=='일자별 경매정보'){
				var itemCd = $('#itemCd option:selected').val();
				var itemCd2 = $('#itemCd2 option:selected').val();
				var searchStrDate = $("#searchStrDate").val();
				var searchEndDate = $("#searchEndDate").val();
			    var flowerCd = $("#flowerTab .on > input").attr("value");
				var cmpCd = $("#cmpCdTab .on > input").attr("value");   
				url+='?itemCd='+itemCd+'&itemCd2='+itemCd2+'&searchStrDate='+searchStrDate+'&searchEndDate='+searchEndDate+'&flowerCd='+flowerCd+'&cmpCd='+cmpCd
			}
						
		    var snsArray = new Array();
		    
			if(linkType=='링크복사'){
				var IE = (document.all) ? true : false;
			    if (IE) {
			        window.clipboardData.setData("Text", url);
			        alert("url이 클립보드에 복사되었습니다.");
			    } else {
			        temp = prompt("이 글의 단축url입니다. Ctrl+C를 눌러 클립보드로 복사하세요", url);
			    }
			}else if(linkType=='페이스북'){			
			    snsArray['facebook'] = "http://www.facebook.com/share.php?u=" + encodeURIComponent(url);
			    window.open(snsArray['facebook']);
			}else if(linkType=='트위터'){			
				snsArray['twitter'] = "http://twitter.com/home?status=" + encodeURIComponent(strTitle) + ' ' + encodeURIComponent(url);
			    window.open(snsArray['twitter']);
			}else if(linkType=='네이버밴드'){
				snsArray['band'] = "http://band.us/plugin/share?body=" + encodeURIComponent(strTitle) + "  " + encodeURIComponent(url) + "&route=" + encodeURIComponent(url);
				window.open(snsArray['band']);
			}
			
		});
				
	});
	

</script>
		<!-- <div class="sns_box_in">
            		sns연동(S)						
						<ul class="sns_box">			
							<li><a href="javascript:;"><img src="../images/main/sns_01.png" alt="페이스북"></a></li>
							<li><a href="javascript:;"><img src="../images/main/sns_02.png" alt="트위터"></a></li>
							<li><a href="javascript:;"><img src="../images/main/sns_03.png" alt="네이버밴드"></a></li>
							<li><a href="javascript:;"><img src="../images/main/sns_04.png" alt="링크복사"></a></li>
						</ul>					
					sns연동(E)
         </div> -->

		<jsp:include page="../inc/2020/IncFooter.jsp"/>

	</div>
	<!--WRAP(E)-->

	<script>
		// 20211012 슬라이드 수정(E)
		var swiper = new Swiper('.swiper1', {
			speed: 1000,	
			slidesPerView: 1,
			spaceBetween: 0,
			loop: true,
			autoplay: {
			delay: 2500,
			disableOnInteraction: false,
			},	
			pagination: {
			el: '.swiper-pagination',
			clickable: true,
			},
			navigation: {
			nextEl: '.btn_main.next',
			prevEl: '.btn_main.prev',
			},
		});
		// 20211012 슬라이드 수정(E)

	</script>
</body>
</html>

