<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, user-scalable=no">
	<meta name="apple-mobile-web-app-title" content="화훼유통정보시스템">
	<meta name="robots" content="no-index,follow">
	<meta name="og:title" content="화훼유통정보시스템">
	<meta name="og:description" content="화훼유통정보시스템">
	<meta name="description" content="월별전년대비실적">
	<meta name="content" content="화훼유통정보시스템 입니다.">
	<meta name="keywords" content="화훼경매시세, 화훼경매가격, Korea aT flower market auction price, 화훼공판장, 화훼거래정보, 꽃시장, 꽃값">
	<meta name="Author" content="화훼유통정보시스템 & www.woorim.co.kr">
	<title>월별 전년대비 실적</title>
	
	<%@include file="../common/2020/commonJs.jsp" %>
	<%@include file="../common/2020/commonCss.jsp" %>
	
	<script type="text/javascript">
		var flowerCd = null;
		var cmpCd = null;
		var pumName = null;
		var goodName = null;
		var searchSaleDate = null;
		var init = true;
		//-----------------------차트 설정 시작-----------------------


		// rMate 차트 생성 준비가 완료된 상태 시 호출할 함수를 지정합니다.
		var chartVars = "rMateOnLoadCallFunction=chartReadyHandler";
		 rMateChartH5.create("chart1", "chartHolder", chartVars, "100%", "100%"); 
		 
		function chartReadyHandler(id) {			
		    document.getElementById(id).setLayout(layoutStr);
		    document.getElementById(id).setData(chartData);
		}
		
		function dataTipFunc(seriesId, seriesName, index, xName, yName, data, values)
		{
			var html = "";
			var xValue = values[0];
			var yValue = values[1];
			if(seriesName == "대상년도 전년 거래량" || seriesName == "대상년도 전년 거래금액" ){
				html += (xValue.substring(0,4)-1) + xValue.substring(4,7);
			}else{
				html += xValue;
			}
			html += "<br>"+seriesName+" : "+comma(yValue);
			
		   return html;
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
		 
		// 스트링 형식으로 레이아웃 정의.
		var layoutStr = 
			 '<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'
		     +'<Options>'                     
		                     +'<SubCaption text="출하량(만단)" textAlign="left" />'
		                     +'<SubCaption text="금액(백만원)" textAlign="right" />'
		                     +'<Legend position="bottom" defaultMouseOverAction="false" useVisibleCheck="false" />'
		                 +'</Options>'
		    +'<NumberFormatter id="numFmt" useThousandsSeparator="true"/>'
		    +'<Combination2DChart showDataTips="true" dataTipJsFunction="dataTipFunc">'
		        +'<horizontalAxis>'
		           +'<CategoryAxis categoryField="saleMonth"/>'
		        +'</horizontalAxis>'
		        +'<verticalAxis>'
		            +'<LinearAxis id="vAxis1"  formatter="{numFmt}" />'
		            +'<LinearAxis id="vAxis2"  formatter="{numFmt}" />'
		        +'</verticalAxis>'
		        +'<series>'
		            +'<Column2DSet type="clustered">'
		                +'<series>'
		                    +'<Column2DSeries verticalAxis="{vAxis1}" yField="totQty" displayName="대상년도 거래량">'
		                        +'<showDataEffect>'
		                            +'<SeriesInterpolate/>'
		                        +'</showDataEffect>'
		                    +'</Column2DSeries>'
		                    +'<Column2DSeries verticalAxis="{vAxis1}" yField="oldTotQty" displayName="대상년도 전년 거래량">'
		                        +'<showDataEffect>'
		                            +'<SeriesInterpolate/>'
		                        +'</showDataEffect>'
		                    +'</Column2DSeries>'
		                +'</series>'
		            +'</Column2DSet>'
		            +'<Line2DSeries verticalAxis="{vAxis2}" yField="totAmt" radius="4" itemRenderer="CircleItemRenderer" displayName="대상년도거래금액">'
		            +'<fill>'
	          		+'<SolidColor color="#04B45F" alpha="1"/>'
				+'</fill>'	
				+'<lineStroke>'
					+'<Stroke color="#04B45F" weight="2"/>'
				+'</lineStroke>'
                +'<stroke>'
                    +'<Stroke color="#04B45F" weight="2"/>'
                +'</stroke>'    
		            +'<showDataEffect>'
		                    +'<SeriesInterpolate/>'
		                +'</showDataEffect>'
		            +'</Line2DSeries>'
		            +'<Line2DSeries verticalAxis="{vAxis2}" yField="oldTotAmt" radius="4" itemRenderer="CircleItemRenderer" displayName="대상년도 전년 거래금액">'
		            +'<fill>'
	          		+'<SolidColor color="#0000FF" alpha="1"/>'
				+'</fill>'	
				+'<lineStroke>'
					+'<Stroke color="#0000FF" weight="2"/>'
				+'</lineStroke>'
                +'<stroke>'
                    +'<Stroke color="#0000FF" weight="2"/>'
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

		//차트 데이터
		var chartData = [];
		 
		function rMateChartH5ChangeTheme(theme){
		    document.getElementById("chart1").setTheme(theme);
		}
		 
		// -----------------------차트 설정 끝 -----------------------
		
		$(document).ready(function(){
			$("#pumSelectbox").css('display','none');
			$("#liStrDate").css("display","none");
			
			$("#searchEndDate").bindDate({align:"right", valign:"bottom", separator:"-", selectType:"y",  defaultSelectType:"y", value:"",
				onchange:function(){
					var searchFlag=dateChkend();
					if(searchFlag==true){
						cmpCd = $("#cmpCdTab .on > input").attr("value");
						flowerCd = $("#flowerTab .on > input").attr("value");
						searchSaleDate = $("#searchEndDate").val();
					
					}else{
						alert("2014년도부터 당월년도까지만 선택이 가능합니다");
		       		}					
				}
			
			});
			$("#excelBtn1").empty();
			$("#excelBtn1").append('<a href="javascript:void(0);" id="exportBtn1" name="exportTable1" onclick="excelExport();"><img src="../images/2020/exel.png" alt="엑셀이미지">엑셀저장</a>');			
		});
			
	
		function dateChkend(){
			
		    var searchGoFlag=false;
			var selectDate = $("#searchEndDate").val().replace(/-/gi, "");
			var today = new Date();
			
			var yy= today.getFullYear();
			
			today = yy;
			
			if(2014 <= selectDate && selectDate<=today){
				searchGoFlag=true;
			}
			return searchGoFlag;
		}
		// 엑셀 다운로드
		function excelExport(){
			var excelNm = "월별전년대비실적";
			searchEndDate = $("#searchEndDate").val();
			cmpCd = $("#cmpCdTab .on > input").attr("value");
			flowerCd = $("#flowerTab .on > input").attr("value");
			var itemCd = $("#itemCd option:selected").val();
			var itemCd2 = $("#itemCd2 option:selected").val();
			var param = "?excelNm="+excelNm+"&searchYear="+searchEndDate+"&searchCmpCd="+cmpCd+"&searchProductGubun="+flowerCd;
			location.href = "/excel/excelDownLoad.do"+param;
		}
		
		function init(){
			chartData = [];
			rMateChartLoding("chart1", "chartReadyHandler");
			
			$("#get1").empty();
			$("#get1").append("<tr><td colspan='8'>데이터가 없습니다.</td></tr>"); 
			$("#get2").empty();
		}
		
		function search(){
			cmpCd = $("#cmpCdTab .on > input").attr("value");
			flowerCd = $("#flowerTab .on > input").attr("value");
			searchSaleDate = $("#searchEndDate").val(); 
			
			if(2014 > searchSaleDate){	
				return;
			}
			
			// 검색 시 쿠키저장
			$.cookie("cookie.cmpCd", cmpCd, {expires: 7, path: '/' });
			$.cookie("cookie.flowerCd", flowerCd, { expires: 7, path: '/' });
			//$.cookie("cookie.pumCd", itemCd,{ expires: 7, path: '/' });
			//$.cookie("cookie.goodCd", itemCd2, { expires: 7, path: '/' });
			
			getChartData(flowerCd, cmpCd, searchSaleDate);
			getData(flowerCd, cmpCd, searchSaleDate);
			getHab06Hap(flowerCd, cmpCd, searchSaleDate);
		}
		
		
		function SeparatCom(num) {
			num = typeof num == 'undefined' || num == null ? "0" : num;  
		    return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		}
		
		function getSaledate(cmpCd, flowerCd){
			$.ajax({
				type : "post",
				url : "/search/selectSaleMonth.json",
				data : {
					searchProductGubun : flowerCd,
					searchCmpCd : cmpCd
				},
				dataType : '',
				success : function(res){
					var val = res.list;
					if(res.list!=null && res.list.length > 0){
						var saleMonth=val[0].SALE_MONTH;
						searchSaleDate = saleMonth.substring(0,4);
						$("#searchEndDate").val(searchSaleDate);
						if (init) {
							let year = "${year}";
							if (year != "") {
								$("#searchEndDate").val(year);
								init = false;
							}
						}
						search();
					}
					if(val[0] == null){
						searchSaleDate = '';
						$('#searchEndDate').val(searchSaleDate);
						init();
					}
				}
			});
		}
		
		function getChartData(flowerCd, cmpCd, searchSaleDate){
			$.ajax({
				type : "post",
				url : "/hab06/hab06ChartData.json",
				data : {
					searchProductGubun : flowerCd,
					searchCmpCd : cmpCd,
					searchYear : searchSaleDate
				},
				dataType : '',
				success : function(res){
					var val = res.list;
					
					//val = [{"searchCondition":"","searchKeyword":"","searchUseYn":"","pageIndex":1,"pageUnit":10,"pageSize":10,"firstIndex":1,"lastIndex":1,"recordCountPerPage":10,"sessionUserId":"","sessionUserName":"","totalCount":"","sessionUserMasking":"","sessionUserOrgnId":"","sessionUserOrgnNm":"","sessionMenuId":"","sessionUserMngrRule":"","insDt":null,"uptDt":null,"insId":null,"insUserNm":null,"uptId":null,"uptUserNm":null,"sessionUserOrgnTypeCd":"","sessionUserOrgnLvlCd":"","sessionUserLogisCnterYn":"","sessionUserMskAuthYn":"","cmpCd":"0000000001","cmpCdNm":null,"saleMonth":"2021-01","saleYear":null,"flowerGubn":"2","flowerGubnNm":"관엽","pumName":null,"goodName":null,"mmCd":null,"mmCdNm":null,"danCd":null,"danCdNm":null,"pojCd":null,"pojCdNm":null,"lvCd":null,"lvCdNm":null,"danQ":0.0,"maxAmt":200000,"minAmt":160,"avgAmt":6631,"sizeCd":null,"sizeCdNm":null,"sanCd":null,"sanCdNm":null,"totAmt":"117849","totQty":"43","oldMaxAmt":"145950","oldMinAmt":"140","oldAvgAmt":"5545.131","oldTotAmt":"95054","oldTotQty":"36","perTotAmt":"23.98","perTotQty":"19.58","perAmtCol":"red","perQtyCol":"red"},{"searchCondition":"","searchKeyword":"","searchUseYn":"","pageIndex":1,"pageUnit":10,"pageSize":10,"firstIndex":1,"lastIndex":1,"recordCountPerPage":10,"sessionUserId":"","sessionUserName":"","totalCount":"","sessionUserMasking":"","sessionUserOrgnId":"","sessionUserOrgnNm":"","sessionMenuId":"","sessionUserMngrRule":"","insDt":null,"uptDt":null,"insId":null,"insUserNm":null,"uptId":null,"uptUserNm":null,"sessionUserOrgnTypeCd":"","sessionUserOrgnLvlCd":"","sessionUserLogisCnterYn":"","sessionUserMskAuthYn":"","cmpCd":"0000000001","cmpCdNm":null,"saleMonth":"2021-02","saleYear":null,"flowerGubn":"2","flowerGubnNm":"관엽","pumName":null,"goodName":null,"mmCd":null,"mmCdNm":null,"danCd":null,"danCdNm":null,"pojCd":null,"pojCdNm":null,"lvCd":null,"lvCdNm":null,"danQ":0.0,"maxAmt":200000,"minAmt":130,"avgAmt":6067,"sizeCd":null,"sizeCdNm":null,"sanCd":null,"sanCdNm":null,"totAmt":"191457","totQty":"76","oldMaxAmt":"376825","oldMinAmt":"140","oldAvgAmt":"5193.82","oldTotAmt":"184126","oldTotQty":"80","perTotAmt":"3.98","perTotQty":"4.62","perAmtCol":"red","perQtyCol":"blue"},{"searchCondition":"","searchKeyword":"","searchUseYn":"","pageIndex":1,"pageUnit":10,"pageSize":10,"firstIndex":1,"lastIndex":1,"recordCountPerPage":10,"sessionUserId":"","sessionUserName":"","totalCount":"","sessionUserMasking":"","sessionUserOrgnId":"","sessionUserOrgnNm":"","sessionMenuId":"","sessionUserMngrRule":"","insDt":null,"uptDt":null,"insId":null,"insUserNm":null,"uptId":null,"uptUserNm":null,"sessionUserOrgnTypeCd":"","sessionUserOrgnLvlCd":"","sessionUserLogisCnterYn":"","sessionUserMskAuthYn":"","cmpCd":"0000000001","cmpCdNm":null,"saleMonth":"2021-03","saleYear":null,"flowerGubn":"2","flowerGubnNm":"관엽","pumName":null,"goodName":null,"mmCd":null,"mmCdNm":null,"danCd":null,"danCdNm":null,"pojCd":null,"pojCdNm":null,"lvCd":null,"lvCdNm":null,"danQ":0.0,"maxAmt":170000,"minAmt":151,"avgAmt":5651,"sizeCd":null,"sizeCdNm":null,"sanCd":null,"sanCdNm":null,"totAmt":"346098","totQty":"138","oldMaxAmt":"81000","oldMinAmt":"140","oldAvgAmt":"4148.952","oldTotAmt":"192930","oldTotQty":"97","perTotAmt":"79.39","perTotQty":"42.48","perAmtCol":"red","perQtyCol":"red"}]; 
					
					if(val.length < 12){
						var searchEndDate = $("#searchEndDate").val();
						for(var i=val.length+1; i<=12; i++ ){
							var saleMonth = "";
							if(i<10){
								saleMonth = searchEndDate + "-0"+i;
							}else{
								saleMonth = searchEndDate + "-" +i;
							}
							val.push({"saleMonth":saleMonth});
						}
					}
					chartData = val;
					
					var maximum = 0;
					
					for(var i=0; i<val.length; i++){
						var compareQty = 0;
						var oldTotQty = parseInt(typeof  val[i].oldTotQty == 'undefined' || val[i].oldTotQty == null || val[i].oldTotQty == 'null' ? 0 : val[i].oldTotQty);
						var totQty = parseInt(typeof  val[i].totQty == 'undefined' || val[i].totQty == null || val[i].totQty == 'null' ? 0 : val[i].totQty);
						//var totQty = parseInt(val[i].totQty);
						
						if(oldTotQty<totQty){
							compareQty = totQty;
						}else{
							compareQty = oldTotQty;
						}
						
						if(maximum < compareQty){
							maximum = compareQty;
						}
						
					}
					
					console.log(maximum);
					
					layoutStr = 
						 '<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'
					     +'<Options>'                     
					                     +'<SubCaption text="출하량(만단)" textAlign="left" />'
					                     +'<SubCaption text="금액(백만원)" textAlign="right" />'
					                     +'<Legend position="bottom" defaultMouseOverAction="false" useVisibleCheck="false" />'
					                 +'</Options>'
					    +'<NumberFormatter id="numFmt" useThousandsSeparator="true"/>'
					    +'<Combination2DChart showDataTips="true" dataTipJsFunction="dataTipFunc">'
					        +'<horizontalAxis>'
					           +'<CategoryAxis categoryField="saleMonth"/>'
					        +'</horizontalAxis>'
					        +'<verticalAxis>'
					            +'<LinearAxis id="vAxis1"  formatter="{numFmt}" maximum="'+maximum+'"/>'
					            +'<LinearAxis id="vAxis2"  formatter="{numFmt}" />'
					        +'</verticalAxis>'
					        +'<series>'
					            +'<Column2DSet type="clustered">'
					                +'<series>'
					                    +'<Column2DSeries verticalAxis="{vAxis1}" yField="totQty" displayName="대상년도 거래량">'
					                        +'<showDataEffect>'
					                            +'<SeriesInterpolate/>'
					                        +'</showDataEffect>'
					                    +'</Column2DSeries>'
					                    +'<Column2DSeries verticalAxis="{vAxis1}" yField="oldTotQty" displayName="대상년도 전년 거래량">'
					                        +'<showDataEffect>'
					                            +'<SeriesInterpolate/>'
					                        +'</showDataEffect>'
					                    +'</Column2DSeries>'
					                +'</series>'
					            +'</Column2DSet>'
					            +'<Line2DSeries verticalAxis="{vAxis2}" yField="totAmt" radius="4" itemRenderer="CircleItemRenderer" displayName="대상년도거래금액">'
					            +'<fill>'
				          		+'<SolidColor color="#04B45F" alpha="1"/>'
							+'</fill>'	
							+'<lineStroke>'
								+'<Stroke color="#04B45F" weight="2"/>'
							+'</lineStroke>'
			                +'<stroke>'
			                    +'<Stroke color="#04B45F" weight="2"/>'
			                +'</stroke>'    
					            +'<showDataEffect>'
					                    +'<SeriesInterpolate/>'
					                +'</showDataEffect>'
					            +'</Line2DSeries>'
					            +'<Line2DSeries verticalAxis="{vAxis2}" yField="oldTotAmt" radius="4" itemRenderer="CircleItemRenderer" displayName="대상년도 전년 거래금액">'
					            +'<fill>'
				          		+'<SolidColor color="#0000FF" alpha="1"/>'
							+'</fill>'	
							+'<lineStroke>'
								+'<Stroke color="#0000FF" weight="2"/>'
							+'</lineStroke>'
			                +'<stroke>'
			                    +'<Stroke color="#0000FF" weight="2"/>'
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
					
					
					rMateChartLoding("chart1", "chartReadyHandler");
				}
			});
		}
		
		function getData(flowerCd, cmpCd, searchSaleDate){
			$("#get1").empty();
			
			$.ajax({
				type : "post",
				url : "/hab06/hab06Data.json",
				data : {
					searchProductGubun : flowerCd,
					searchCmpCd : cmpCd,
					searchYear : searchSaleDate
				},
				dataType : '',
				success : function(res){
					var val = res.list;
					$("#txt1").text(searchSaleDate-1+"년");
					$("#txt2").text(searchSaleDate+"년");
					$("#txt3").text(searchSaleDate-1+"년");
					$("#txt4").text(searchSaleDate+"년");
					
					var perTotQty = [];
					var perTotAmt = [];
					
					var today = new Date();
					var yy= today.getFullYear();
					var mm= today.getMonth()+1;
					if(mm<10){
						mm = "0"+mm;
					}
					var yymm = yy + "-" + mm;
					
					if(val != ""){
						for(var i=0; i<val.length; i++){
							if(val[i].totQty == 'null' || val[i].totQty == null){
								val[i].totQty = "0";
							}
							if(val[i].totAmt == 'null' || val[i].totAmt == null){
								val[i].totAmt = "0";
							}
							if(val[i].perQtyCol == 'blue'){
								perTotQty[i] = "<p class='txt_down'>"+val[i].perTotQty+"% ▼</p>";
							}
							if(val[i].perQtyCol == 'green'){
								if(val[i].perTotQty > 0){
									perTotQty[i] = "<p class=''>"+val[i].perTotQty+"% -</p>";
								}else{
									perTotQty[i] = "<p class=''> 0 </p>";
								}								
							}
							if(val[i].perQtyCol == 'red'){
								perTotQty[i] = "<p class='txt_up'>"+val[i].perTotQty+"% ▲</p>";
							}
							if(val[i].perAmtCol == 'blue'){
								perTotAmt[i] = "<p class='txt_down'>"+val[i].perTotAmt+"% ▼</p>";
							}
							if(val[i].perAmtCol == 'green'){
								if(val[i].perTotQty > 0){
									perTotAmt[i] = "<p class=''>"+val[i].perTotAmt+"% -</p>";
								}else{
									perTotAmt[i] = "<p class=''> 0 </p>";
								}								
							}
							if(val[i].perAmtCol == 'red'){
								perTotAmt[i] = "<p class='txt_up'>"+val[i].perTotAmt+"% ▲</p>";
							}
							
							
							var totQty = val[i].totQty;
							if(totQty == 0){
								totQty = "0"
							}
							
							var totAmt = val[i].totAmt;
							if(totAmt == 0){
								totAmt = "0"
							}
							if(yymm == val[i].saleMonth){
								$("#get1").append("<tr><td class='tc'><p>"+val[i].saleYear+"까지</p></td><td class='tc'><p>"+SeparatCom(val[i].oldTotQty)+"</p></td><td class='tc'><p>"+SeparatCom(totQty)+"</p></td><td class='tc'><p>"+perTotQty[i]+"</p></td><td class='tc'><p>"+SeparatCom(val[i].oldTotAmt)+"</p></td><td class='tc'><p>"+SeparatCom(totAmt)+"</p></td><td class='tc'><p>"+perTotAmt[i]+"</p></td></tr>");	
							}else{
								$("#get1").append("<tr><td class='tc'><p>"+val[i].saleMonth.substr(5,2)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].oldTotQty)+"</p></td><td class='tc'><p>"+SeparatCom(totQty)+"</p></td><td class='tc'><p>"+perTotQty[i]+"</p></td><td class='tc'><p>"+SeparatCom(val[i].oldTotAmt)+"</p></td><td class='tc'><p>"+SeparatCom(totAmt)+"</p></td><td class='tc'><p>"+perTotAmt[i]+"</p></td></tr>");
							}
						}
					}else{
						$("#get1").append("<tr><td colspan='9'>데이터가 없습니다.</td></tr>");
					}
				}
			});
		}
		
		function getHab06Hap(flowerCd, cmpCd, searchSaleDate){
			$("#get2").empty();
			
			$.ajax({
				type : "post",
				url : "/hab06/selectHab06Hap.json",
				data : {
					searchProductGubun : flowerCd,
					searchCmpCd : cmpCd,
					searchYear : searchSaleDate
				},
				dataType : '',
				success : function(res){
					var val = res.list;
					var perTotQty = [];
					var perTotAmt = [];
					if(val!=null&& val.length>0){
						if(val[0].perQtyCol == 'blue'){
							perTotQty[0] = "<p class='txt_down'>"+val[0].perTotQty+"% ▼</p>";
						}
						if(val[0].perQtyCol == 'green'){
							perTotQty[0] = "<p class=''>"+val[0].perTotQty+"% -</p>";
						}
						if(val[0].perQtyCol == 'red'){
							perTotQty[0] = "<p class='txt_up'>"+val[0].perTotQty+"% ▲</p>";
						}
						if(val[0].perAmtCol == 'blue'){
							perTotAmt[0] = "<p class='txt_down'>"+val[0].perTotAmt+"% ▼</p>";
						}
						if(val[0].perAmtCol == 'green'){
							perTotAmt[0] = "<p class=''>"+val[0].perTotAmt+"% -</p>";
						}
						if(val[0].perAmtCol == 'red'){
							perTotAmt[0] = "<p class='txt_up'>"+val[0].perTotAmt+"% ▲</p>";
						}
						
						$("#get2").append("<tr><td class='tc'>합계</td><td class='tc'><p>"+SeparatCom(val[0].oldTotQty)+"</p></td><td class='tc'><p>"+SeparatCom(val[0].totQty)+"</p></td><td class='tc'><p>"+perTotQty[0]+"</p></td><td class='tc'><p>"+SeparatCom(val[0].oldTotAmt)+"</p></td><td class='tc'><p>"+SeparatCom(val[0].totAmt)+"</p></td><td class='tc'><p>"+perTotAmt[0]+"</p></td></tr>");
					}else{
						$("#get2").empty();
					}
					
				}
			});
		}
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
				<li>경매통계</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li class="m_right">월별 전년대비 실적</li>
			</ul>
		</div>
		<!--공통 HEADER(E)-->
		
		<!--서브 타이틀(S)-->
		<jsp:include page="../inc/2020/IncShare.jsp"/>
		
		<div class="sub_title">
			<div class="title_box">
				<h2>월별 전년대비 실적</h2>
				<img src="../images/2020/sub/t_line.png" alt="방울점선">
			</div>
		</div>
		<!--서브 타이틀(E)-->
		
		<jsp:include page="../inc/2020/topMenuRange.jsp"/>
		
		<!--컨텐츠 내용(S)-->
		<div class="sub_guide">
			
			<!-- 그래픽(S) -->
			<div class="txt_graph">
				<div id="chartHolder" style="width:100%; height:380px;"></div>
			</div>
			<!-- 그래픽(E) -->

			<!-- 테이블(S) -->
			<div class="table_overflow_y">
				<table class="table_type_01 btg tiny">
					<caption>월별 전년대비 실적</caption>
					<colgroup>
						<col style="width:12%">
						<col style="width:14%">
						<col style="width:14%">
						<col style="width:14%">
						<col style="width:14%">
						<col style="width:14%">
						<col style="width:14%">
					</colgroup>
					<thead>
						<tr>
							<th class="tc" rowspan="2">월별</th>
							<th class="tc" colspan="3">거래량(만단)</th>
							<th class="tc" colspan="3">경매금액(백만원)</th>
						</tr>
						<tr>
							<th class="tc" id="txt1">2019년</th>
							<th class="tc" id="txt2">2020년</th>
							<th class="tc">전년동기대비</th>
							<th class="tc" id="txt3">2019년</th>
							<th class="tc" id="txt4">2020년</th>
							<th class="tc">전년동기대비</th>
						</tr>
					</thead>
					<tbody id="get1"></tbody>
					<tbody id="get2"></tbody>
				</table>
			</div>
			<!-- 테이블(E) -->

			<!-- 버튼박스(S) -->
			<div class="dwn_bt_b" id="excelBtn1">
				<a href="#!"><img src="../images/2020/exel.png" alt="엑셀이미지">엑셀저장</a>
			</div>
			<!-- 버튼박스(E) -->

		</div>


		<div class="guide">
			<h2 class="title_02">이용안내</h2>
			<ul class="guide_box">
				<li class="">· 공판장별 실적을 한눈에 파악 할 수 있는 화면</li>
				<li class="">· 단위 :거래량(만단), 경매금액(백만원) / 자료출처 : 각 공판장별 경매 자료 현황</li>
				<li class="">· 당월 정보는 전년 동기 정보로 비교됩니다.</li>
			</ul>
		</div>

		<!--컨텐츠 내용(E)-->
		
		<jsp:include page="../inc/2020/IncFooter.jsp"/>
		
	</div>
	<!--WRAP(E)-->
</body>
</html>