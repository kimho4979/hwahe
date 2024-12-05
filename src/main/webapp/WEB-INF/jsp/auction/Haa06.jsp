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
	<meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, user-scalable=no">
	<meta name="apple-mobile-web-app-title" content="화훼유통정보시스템">
	<meta name="robots" content="no-index,follow">
	<meta name="og:title" content="화훼유통정보시스템">
	<meta name="og:description" content="화훼유통정보시스템">
	<meta name="description" content="실시간 경매정보">
	<meta name="content" content="화훼유통정보시스템 입니다.">
	<meta name="keywords" content="화훼경매시세, 화훼경매가격, Korea aT flower market auction price, 화훼공판장, 화훼거래정보, 꽃시장, 꽃값">
	<meta name="Author" content="화훼유통정보시스템 & www.woorim.co.kr">
	<title>주간 거래동향</title>
	<%@include file="../common/2020/commonJs.jsp" %>
	<%@include file="../common/2020/commonCss.jsp" %>
	<style>
 		#progress_loading {display:block; position:absolute; top:50%; left:50%; transform:translateX(-50%) translateY(-50%); background: #ffffff; text-align: center; z-index:999999;}
		@media screen and (min-width: 800px){
		.ui-jqgrid .ui-jqgrid-htable{width:auto!important;}
		}
		
		{
		 background: linear-gradient(45deg, palevioletred 25%, pink 0, pink 50%, palevioletred 0, palevioletred 75%, pink 0 );
    background-size:42.4px 42.4px
    }
	</style>

	<script type="text/javascript">
	$(document).ready(function(){
		var now = new Date();
		now.setMonth(now.getMonth()+1);
		$("#searchEndDateD").val(now.getFullYear().toString());
		$("#searchDateD").show();

    });

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
		var chartVars11 = "rMateOnLoadCallFunction=chartReadyHandler11";

		//rMateChart 를 생성합니다.
		function chartReadyHandler(id) {
			document.getElementById(id).setLayout(layoutStr);
			document.getElementById(id).setData(chartData);
			checkData(chartData);
		}
		//rMateChart 를 생성합니다.
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
		function chartReadyHandler7(id) {
			document.getElementById(id).setLayout(layoutStr7);
			document.getElementById(id).setData(chartData7);
		}
		function chartReadyHandler8(id) {
			document.getElementById(id).setLayout(layoutStr8);
			document.getElementById(id).setData(chartData8);
		}
		function chartReadyHandler9(id) {
			document.getElementById(id).setLayout(layoutStr9);
			document.getElementById(id).setData(chartData9);
		}
		function chartReadyHandler10(id) {
			document.getElementById(id).setLayout(layoutStr10);
			document.getElementById(id).setData(chartData10);
		}
		function chartReadyHandler11(id) {
			document.getElementById(id).setLayout(layoutStr11);
			document.getElementById(id).setData(chartData11);
		}

		var layoutStr =
		 '<rMateChart backgroundColor="#FFFFFF" borderStyle="none">'
		       +'<Options>'
		          +'<Caption text="Global Temperature"/>'
		           +'<Legend />'
		     +'</Options>'
		     +'<NumberFormatter id="nft" precision="2"/>'
		      +'<Line2DChart showDataTips="true" dataTipFormatter="{nft}">'
		         +'<horizontalAxis>'
		               +'<CategoryAxis id="hAxis" categoryField="date"/>'
		            +'</horizontalAxis>'
		          +'<verticalAxis>'
		             +'<LinearAxis id="vAxis" title="Temperature Anomaly (℃)"/>'
		           +'</verticalAxis>'
		            +'<series>'
		               +'<Line2DSeries yField="각구도라" displayName="각구도라">'
		                   +'<showDataEffect>'
		                       + '<SeriesClip duration="1000"/>'
		                 +'</showDataEffect>'
		              +'</Line2DSeries>'
		                +'<Line2DSeries yField="개나리" displayName="개나리">'
		                 +'<showDataEffect>'
		                       + '<SeriesClip duration="1000"/>'
		                 +'</showDataEffect>'
		              +'</Line2DSeries>'
		            +'</series>'
		      +'</Line2DChart>'
		 +'</rMateChart>';
		 var layoutStr2 =
			 '<rMateChart backgroundColor="#FFFFFF" borderStyle="none">'
             +'<Options>'
//                 +'<Caption text="Sales by Month"/>'
//                  +'<SubCaption text="( $M )" textAlign="right" />'
               +'<Legend defaultMouseOverAction="false" useVisibleCheck="true"/>'
              +'</Options>'
           +'<Bar2DChart showDataTips="true" selectionMode="single" barWidthRatio="0.66">'
                 +'<horizontalAxis>'
                     +'<LinearAxis/>'
                +'</horizontalAxis>'
                +'<verticalAxis>'
                   +'<CategoryAxis id="hAxis" categoryField="pumNm"/>'
                +'</verticalAxis>'
                  +'<series>'
                 /* Bar2D Multi-Sereis 를 생성시에는 Bar2DSeries 여러 개 정의합니다 */
                   +'<Bar2DSeries labelPosition="inside" halfWidthOffset="1" showValueLabels="[3]" xField="2021" displayName="2021" color="#ffffff" insideLabelYOffset="-2">'
                       +'<showDataEffect>'
                             +'<SeriesInterpolate/>'
                         +'</showDataEffect>'
                    +'</Bar2DSeries>'
                   +'<Bar2DSeries labelPosition="inside" halfWidthOffset="1" showValueLabels="[3]" xField="2022" displayName="2022" color="#ffffff" insideLabelYOffset="-2">'
                          +'<showDataEffect>'
                             +'<SeriesInterpolate/>'
                         +'</showDataEffect>'
                    +'</Bar2DSeries>'
               +'</series>'
				+'<verticalAxisRenderers>'
					+'<Axis2DRenderer axis="{hAxis}" canDropLabels="false" showLine="false" />'
             	+'</verticalAxisRenderers>'
            +'</Bar2DChart>'
        +'</rMateChart>';
        
        var layoutStr3 = layoutStr2;
        var layoutStr4 = layoutStr2;
        var layoutStr5 =      '<rMateChart>'
        	+'<NumberFormatter id="numfmt" precision="1"/>'
            +'<Options>'
//             +'<Caption text="Number of Restaurants by Region" />'
       +'</Options>'
       /*
            TreeMapChart를 설정하기 위하여 TreeMapChart 노드를 설정하도록 합니다.
            buttonMode - 각 차트 아이템에 마우스 오버시 손가락 표시를 나타내도록 설정합니다.
       */
        +'<TreeMapChart showDataTips="true" buttonMode="true" selectionMode="single" dataTipFormatter="{numfmt}">'
              +'<series>'
                 /*
                    TreeMapChart의 series속성으로 TreeMapSeries를 설정하도록 합니다.
                    weightField - 트리 맵으로 출력하려는 데이터 값 필드 명을 설정합니다.
                     nameField - 트리 맵 안에 출력할 문자열의 필드 명을 설정합니다.
                     groupField - 차트 데이터가 계층형 데이터일 해당 데이터들 중 그룹으로 가져올 데이터 필드 명을 설정합니다.
                     labelPosition - weightField, nameField 값이 표현하는 문자열을 트리 맵에 출력할지 설정합니다.
                     showGroupHeader - 차트 데이터가 계층형 데이터일 경우 각 계층에 해당하는 대표 문자열을 출력할지 설정합니다.
                      groupNameField - showGroupHeader가 true일 경우 groupHeader에 출력할 문자열의 데이터 필드 명을 설정합니다.
                 */
                +'<TreeMapSeries weightField="rate" nameField="pumNm" showGroupHeader="true" displayName="차지하는 비율(In %)" groupField="items" groupNameField="name" color="#ffffff" labelPosition="inside" labelJsFunction="labelFunc" groupHeaderFontColor="#000000" fontSize="12">'
                    /* grgoupHeader의 채우기 색상 */
                    +'<groupHeaderColor>'
                       +'<SolidColor color="#eeeeee" />'
                   +'</groupHeaderColor>'
                      +'<showDataEffect>'
                         +'<SeriesZoom relativeTo="chart" horizontalFocus="center" verticalFocus="middle" duration="1000"/>'
                     +'</showDataEffect>'
                    +'<fills>'
                          +'<SolidColor color="#67315f"/>'
                        +'<SolidColor color="#8c347f"/>'
                        +'<SolidColor color="#d03d53"/>'
                        +'<SolidColor color="#f5743c"/>'
                        +'<SolidColor color="#f5983c"/>'
                        +'<SolidColor color="#ed545f"/>'
                        +'<SolidColor color="#ffb00d"/>'
                        +'<SolidColor color="#b5c977"/>'
                        +'<SolidColor color="#9ddac6"/>'
                        +'<SolidColor color="#c2e7db"/>'
                    +'</fills>'
                 +'</TreeMapSeries>'
             +'</series>'
        +'</TreeMapChart>'
      +'</rMateChart>';
      var layoutStr6 = layoutStr5;
      var layoutStr7 = layoutStr5;
      var layoutStr8 = layoutStr5;
      var layoutStr9 = layoutStr5;
      var layoutStr10 = layoutStr5;
      var layoutStr11 = layoutStr5;
      
// 		//차트 데이터
		var chartData = [];
		var chartData2 = [];
		var chartData3 = [];
		var chartData4 = [];
		var chartData4 = [];
		var chartData5 = [];
		var chartData6 = [];
		var chartData7 = [];
		var chartData8 = [];
		var chartData9 = [];
		var chartData10 = [];
		var chartData11 = [];

		function rMateChartH5ChangeTheme(theme){
			document.getElementById("chart1").setTheme(theme);
			document.getElementById("chart2").setTheme(theme);
			document.getElementById("chart3").setTheme(theme);
			document.getElementById("chart4").setTheme(theme);
			document.getElementById("chart5").setTheme(theme);
			document.getElementById("chart6").setTheme(theme);
			document.getElementById("chart7").setTheme(theme);
			document.getElementById("chart8").setTheme(theme);
			document.getElementById("chart9").setTheme(theme);
			document.getElementById("chart10").setTheme(theme);
		}

		function checkData(data){
			if(data.length <= 0){
				// 데이터가 없을 경우 hasNoData함수를 실행하여 메세지창을 출력한다.
				document.getElementById("chart1").hasNoData(true);
			}
		}
		function datechktoday(date){
			/*var oneWeekAgo = new Date(date.getFullYear(), date.getMonth(), date.getDate() - 7);
			if(date > new Date() || date < oneWeekAgo){
				return [false]; 
			} 
			return [true];*/
			    var oneWeekAgo = new Date();
			    oneWeekAgo.setDate(oneWeekAgo.getDate() - 7);

			    // 비교할 때 날짜만 비교하기 위해 시간 정보를 0으로 설정
			    oneWeekAgo.setHours(0, 0, 0, 0);
			    date.setHours(0, 0, 0, 0);

			    if (date > new Date() || date < oneWeekAgo) {
			        //return [false, '']; // 비활성화
			    }

			    return [true, '']; // 활성화
		}
		
		function dateChkend(){

			if($("#searchStrDateD").val() > $("#searchEndDateD").val()){
				$("#searchStrDateD").val($("#searchEndDateD").val()) ;
			}
			var strDate = new Date($("#searchStrDateD").val());
			var endDate = new Date($("#searchEndDateD").val());

			var btMs = endDate.getTime() - strDate.getTime();
			var btDay = btMs / (1000*60*60*24);
			if(btDay > 365){
				alert("1년이상은 선택 하실수 없습니다.");
				return false;
			}
			return true;

		}
		
		$(document).ready(function(){

			
			
			//일병 설정
			$("#searchStrDateD").datepicker({
				showOn: "both",
				buttonImage: "../images/2020/ico_date_02.png",
				buttonImageOnly: true,
				todayHighlight: true,
				autoclose: true,
				showMonthAfterYear: true,
				dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
				monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
				language: 'kr',
				dateFormat: 'yy-mm-dd',
				beforeShowDay:datechktoday,
				beforeShow: function (){
					hisStrDate = $("#searchStrDateD").val();
				},
				yearSuffix: '년',
				changeMonth: true,
				changeYear: true,
				onSelect: function(){

					cmpCd= [];
					flowerCd = [];
					var searchStrDate = $("#searchStrDateD").val();
					var searchEndDate = $("#searchEndDateD").val();
				}
			});

			$("#searchEndDateD").datepicker({
				showOn: "both",
				buttonImage: "../images/2020/ico_date_02.png",
				buttonImageOnly: true,
				todayHighlight: true,
				autoclose: true,
				showMonthAfterYear: true,
				dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
				monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
				language: 'kr',
				dateFormat: 'yy-mm-dd',
				beforeShowDay:datechktoday,
// 				beforeShow: function (){
// 					hisEndDate = $("#searchEndDateD").val();
// 				},
				yearSuffix: '년',
				changeMonth: true,
				changeYear: true,
				onSelect: function(dateText, inst){
					var date = $(this).datepicker('getDate');
					
					startDate = new Date(date.getFullYear(), date.getMonth(), date.getDate() - date.getDay()+1);
					endDate = new Date(date.getFullYear(), date.getMonth(), date.getDate() - date.getDay()+6);

					var dateFormat = 'yy-mm-dd';
					
					startDate = $.datepicker.formatDate(dateFormat, startDate, inst.settings);
					endDate = $.datepicker.formatDate(dateFormat, endDate, inst.settings);

					$("#searchEndDateD").val(startDate + " ~ " + endDate);
			        }
				
			});
			$('.content').click(function(){});
			var date = new Date();
			date.setDate(date.getDate()-7);
			
			startDate = new Date(date.getFullYear(), date.getMonth(), date.getDate() - date.getDay()+1);
			endDate = new Date(date.getFullYear(), date.getMonth(), date.getDate() - date.getDay()+6);

			
			startDate = $.datepicker.formatDate("yy-mm-dd", startDate );
			endDate = $.datepicker.formatDate("yy-mm-dd", endDate );
			
			var dateFormat = 'yy-mm-dd';
			$("#searchEndDateD").val(startDate + " ~ " + endDate);
			
			
			fnObj.setPage();
		});
		function labelFunc(seriesID, index, data, values)
		{
		  return data.TOT_QTY + "\n" + values[1];
		}
		function axisDataTipFunc(id, text){
		    return "Month : " + text;
		}

		function formatDate(date) {
		    var d = new Date(date),
		        month = '' + (d.getMonth() + 1),
		        day = '' + d.getDate(),
		        year = d.getFullYear();

		    if (month.length < 2) 
		        month = '0' + month;
		    if (day.length < 2) 
		        day = '0' + day;

		    return [year, month, day].join('-');
		}
		var fnObj = {
			param : {
				strDate: '',
		    	endDate: '',
		    	rsFlowerCtgr: [],
		    	rsMarket: [],
		    	rsItem: [],
		    	rsItemDtl: []
			},
	        setPage : function(){
		            fnObj.chart_sumary();
		            fnObj.chart_sumary2();
		            fnObj.chart_sumary3();
		            fnObj.chart_sumary5();
		    },
    	    chart_sumary: function(){
	     		url = "/haa06/selectHaa06ChartJson1.json";


		    
				var searchStrDate = (Number($("#searchEndDateD").val().toString().substring(0, 4))-1).toString();
				var searchEndDate = $("#searchEndDateD").val().substring(0, 4);
				
    	    	$.ajax({
    				type : "post",
    				url : url,
    				data : {
	        			searchStrDate: searchStrDate,
	        			searchEndDate: searchEndDate,
    				},
    				dataType : '',
    				success : function(res){
    					var val = res.list;
    					
						layoutStr = '<rMateChart backgroundColor="#FFFFFF" borderStyle="none">'
						       +'<Options>'
							       +'<SubCaption text="(단위 : 분(속))" textAlign="left" />'
							       +'<Legend />'
						     +'</Options>'
						     +'<CurrencyFormatter id="fmt" useThousandsSeparator="true" currencySymbol="" alignSymbol="right"/>'
						     +'<NumberFormatter id="nft" precision="2" />'
						      +'<Line2DChart showDataTips="true" dataTipFormatter="{fmt}">'
						         +'<horizontalAxis>'
						               +'<CategoryAxis id="hAxis" categoryField="date"/>'
						            +'</horizontalAxis>'
						          +'<verticalAxis>'
						             +'<LinearAxis id="vAxis" formatter="{fmt}"/>'
						           +'</verticalAxis>'
						            +'<series>';
						            
						let jongNmList = Object.keys(val[0]);
						jongNmList.splice(jongNmList.indexOf('date'), 1);
									
						var body = "";            
			            tempDate= Number(searchStrDate);
			            var lineColor = ["#4374D9", "#F361A6"]
						for(var i=0; i<2; i++){
							body += '<Line2DSeries radius="4.5" fill="'+lineColor[i]+'" form="curve" itemRenderer="CircleItemRenderer" yField="' + (tempDate+i).toString() + '" displayName="' + (tempDate+i).toString()  + '" >'
											+ '<stroke>'
											+ '<Stroke color="'+lineColor[i]+'" weight="3"/>'
											+ '</stroke>'
											+ '<lineStroke>'
											+ '<Stroke color="'+lineColor[i]+'" weight="3"/>'
											+ '</lineStroke>'
											+ '<showDataEffect>'
											+ '<SeriesInterpolate/>'
											+ '</showDataEffect>'
										+'</Line2DSeries>'
						}            
						body += '</series>'
						      +'</Line2DChart>'
 						 +'</rMateChart>';
						layoutStr += body;
    					if(val!=null && val.length > 0){
    						chartData = val;
    						if(!document.getElementById("chart1")){
    		                	rMateChartH5.create("chart1", "chartHolder", chartVars, "100%", "99%");
    		            	 } else{
    		            		 chartReadyHandler("chart1");
    		        		}
    	   					
    					}else{
    						chartData = [];
    						if(!document.getElementById("chart1")){
    		                	rMateChartH5.create("chart1", "chartHolder", chartVars, "100%", "99%");
    		            	 } else{
    		            		 chartReadyHandler("chart1");
    		        		}
    					}
    				}
    			});
    	    	
    	    },
    	    chart_sumary2: function(){
	     		url = "/haa06/selectHaa06ChartJson2.json";
				var dateArr = $("#searchEndDateD").val().toString().split(' ~ ');
				var searchStrDate = dateArr[0];
				var searchEndDate = dateArr[1];
				
				var offset;
				const strDate = new Date(searchStrDate);
				const endDate = new Date(searchEndDate);
				if ((strDate.getFullYear()-1) % 4 == 0 || (strDate.getFullYear()) % 4 == 0){// 전 년도가 윤년인 경우
					offset = 2;
				}
				else { // 전 년도가 평년인 경우
					offset = 1;
				}
				var searchPreStrDate = new Date( strDate.getFullYear()-1, strDate.getMonth(), strDate.getDate()+offset);
				var searchPreEndDate = new Date( endDate.getFullYear()-1, endDate.getMonth(), endDate.getDate()+offset);
				var strYear = (strDate.getFullYear()-1).toString();
				var endYear = strDate.getFullYear().toString();
				
    	    	$.ajax({
    				type : "post",
    				url : url,
    				data : {
	        			searchStrDate: searchStrDate,
	        			searchEndDate: searchEndDate,
	        			searchPreStrDate: formatDate(searchPreStrDate),
	        			searchPreEndDate: formatDate(searchPreEndDate),
	        			strYear: strYear,
	        			endYear: endYear,
    				},
    				dataType : '',
    				success : function(res){
    					var val = res.list;
    					
    					var displayName1 = formatDate(searchPreStrDate) + " ~ " + formatDate(searchPreEndDate);
						var displayName2 = $("#searchEndDateD").val().toString();
    					 layoutStr2 =
    						 '<rMateChart backgroundColor="#FFFFFF" borderStyle="none">'
						       +'<Options>'
						       +'<SubCaption text="(단위 : 분(속))" textAlign="left" />'
						          +'<Caption text=" "/>'
						           +'<Legend />'
						     +'</Options>'
    			           +'<Bar2DChart showDataTips="true" selectionMode="single" barWidthRatio="0.78">'
    			                +'<verticalAxis>'
    			                   +'<CategoryAxis id="hAxis" categoryField="pumNm" />'
    			                +'</verticalAxis>'
    			                  +'<series>'
    			                 /* Bar2D Multi-Sereis 를 생성시에는 Bar2DSeries 여러 개 정의합니다 */
    			                   +'<Bar2DSeries labelPosition="outside" halfWidthOffset="1" xField="'+endYear+'" displayName="'+displayName2+'">'
		    			               	+'<fill>'
			    			           		+'<SolidColor color="#F361A6" alpha="1"/>'
			    			           	+'</fill>'
			    			           	+'<stroke>'
			    			           		+'<Stroke color="#F361A6" weight="1"/>'
			    			           	+'</stroke>'
   			                   			+'<showDataEffect>'
    			                             +'<SeriesInterpolate/>'
    			                         +'</showDataEffect>'
    			                    +'</Bar2DSeries>'
    			                   +'<Bar2DSeries labelPosition="outside" halfWidthOffset="1" xField="'+strYear+'" displayName="'+displayName1+'">'
		    			               	+'<fill>'
			    			           		+'<SolidColor color="#4374D9" alpha="1"/>'
			    			           	+'</fill>'
			    			           	+'<stroke>'
			    			           		+'<Stroke color="#4374D9" weight="1"/>'
			    			           	+'</stroke>'       
    			                  		 +'<showDataEffect>'
    			                             +'<SeriesInterpolate/>'
    			                         +'</showDataEffect>'
    			                    +'</Bar2DSeries>'
    			               +'</series>'
    							+'<verticalAxisRenderers>'
    								+'<Axis2DRenderer axis="{hAxis}" canDropLabels="false" showLine="false" />'
    			             	+'</verticalAxisRenderers>'
    			            +'</Bar2DChart>'
    			        +'</rMateChart>';
    			        
    			        layoutStr3 = layoutStr2;
    			        layoutStr4 = layoutStr2;
    			        
    					chartData2 = val[0];
    					chartData3 = val[1];
    					chartData4 = val[2];
    					rMateChartH5.create("chart2", "chartHolder2", chartVars2, "100%", "99%");
    					rMateChartH5.create("chart3", "chartHolder3", chartVars3, "100%", "99%");
    					rMateChartH5.create("chart4", "chartHolder4", chartVars4, "100%", "99%");

    				}
    			});
    	    	
    	    },
    	    chart_sumary3: function(){
	     		url = "/haa06/selectHaa06ChartJson3.json";
				var dateArr = $("#searchEndDateD").val().toString().split(' ~ ');
				var searchStrDate = dateArr[0];
				var searchEndDate = dateArr[1];
				var offset;
				const strDate = new Date(searchStrDate);
				const endDate = new Date(searchEndDate);
				if ((strDate.getFullYear()-1) % 4 == 0 || (strDate.getFullYear()) % 4 == 0){// 전 년도가 윤년인 경우
					offset = 2;
				}
				else { // 전 년도가 평년인 경우
					offset = 1;
				}
				var searchPreStrDate = new Date( strDate.getFullYear()-1, strDate.getMonth(), strDate.getDate()+offset);
				var searchPreEndDate = new Date( endDate.getFullYear()-1, endDate.getMonth(), endDate.getDate()+offset);
				var strYear = (strDate.getFullYear()-1).toString();
				var endYear = strDate.getFullYear().toString();
				
    	    	$.ajax({
    				type : "post",
    				url : url,
    				data : {
	        			searchStrDate: searchStrDate,
	        			searchEndDate: searchEndDate,
	        			searchPreStrDate: formatDate(searchPreStrDate),
	        			searchPreEndDate: formatDate(searchPreEndDate),
    				},
    				dataType : '',
    				success : function(res){
    					var valarr = res.list;
    					var val = valarr[0]
    					chartData5 = val[0];
    					chartData6 = val[1];
    					chartData7 = val[2];
    					var head1 = '<rMateChart>'
    			        	+'<NumberFormatter id="numfmt" precision="1"/>'
    			            +'<Options></Options>'

    			        +'<TreeMapChart showDataTips="true" buttonMode="true" selectionMode="single" dataTipFormatter="{numfmt}">'
    			              +'<series>'
    			                +'<TreeMapSeries weightField="rate" nameField="pumNm" showGroupHeader="true" displayName="차지하는 비율(%)" groupField="items" groupNameField="name" color="#ffffff" labelPosition="inside" labelJsFunction="labelFunc" groupHeaderFontColor="#000000" fontSize="12">'
    			                    +'<groupHeaderColor>'
    			                       +'<SolidColor color="#eeeeee" />'
    			                   +'</groupHeaderColor>'
    			                      +'<showDataEffect>'
    			                         +'<SeriesZoom relativeTo="chart" horizontalFocus="center" verticalFocus="middle" duration="1000"/>'
    			                     +'</showDataEffect>'
    			                    +'<fills>';
    			                    
    			                    var bdy = "";
    			                    chartData5[0].items.forEach(function(e){
    			                	   bdy += '<SolidColor color="' + e.rgb +'"/>';
    			                   });

    			                        var tail = '</fills>'
    			                 +'</TreeMapSeries>'
    			             +'</series>'
    			        +'</TreeMapChart>'
    			      +'</rMateChart>';
    			      layoutStr5 =  head1 + bdy + tail;
    			      bdy = "";
	                   chartData6[0].items.forEach(function(e){
	                	   bdy += '<SolidColor color="' + e.rgb +'"/>';
	                   });
    			      layoutStr6 =  head1 + bdy + tail;
    			      bdy = "";
	                   chartData7[0].items.forEach(function(e){
	                	   bdy += '<SolidColor color="' + e.rgb +'"/>';
	                   });
    			      layoutStr7 =  head1 + bdy + tail;
    					rMateChartH5.create("chart5", "chartHolder5", chartVars5, "100%", "99%");
    					rMateChartH5.create("chart6", "chartHolder6", chartVars6, "100%", "99%");
    					rMateChartH5.create("chart7", "chartHolder7", chartVars7, "100%", "99%");
    					fnObj.chart_sumary4(valarr[1]);
    				}
    			});
    	    	
    	    },
    	    chart_sumary4: function(val){
   					chartData8 = val[0];
   					chartData9 = val[1];
   					chartData10 = val[2];
   					var head1 = '<rMateChart>'
   			        	+'<NumberFormatter id="numfmt" precision="1"/>'
   			            +'<Options></Options>'															
   			        +'<TreeMapChart showDataTips="true" buttonMode="true" selectionMode="single" dataTipFormatter="{numfmt}" >'
   			              +'<series>'
   			                +'<TreeMapSeries weightField="rate" nameField="pumNm" showGroupHeader="true" displayName="차지하는 비율(%)" groupField="items" groupNameField="name" color="#ffffff" labelPosition="inside" labelJsFunction="labelFunc" groupHeaderFontColor="#000000" fontSize="12">'
   			                    +'<groupHeaderColor>'
   			                       +'<SolidColor color="#eeeeee" />'
   			                   +'</groupHeaderColor>'
   			                      +'<showDataEffect>'
   			                         +'<SeriesZoom relativeTo="chart" horizontalFocus="center" verticalFocus="middle" duration="1000"/>'
   			                     +'</showDataEffect>'
   			                    +'<fills>';
   			                    
   			                    var bdy = "";
   			                   chartData8[0].items.forEach(function(e){
   			                	   bdy += '<SolidColor color="' + e.rgb +'"/>';
   			                   });

   			                        var tail = '</fills>'
   			                 +'</TreeMapSeries>'
   			             +'</series>'
   			        +'</TreeMapChart>'
   			      +'</rMateChart>';
   			      layoutStr8 =  head1 + bdy + tail;
   			      bdy = "";
                   chartData9[0].items.forEach(function(e){
                	   bdy += '<SolidColor color="' + e.rgb +'"/>';
                   });
   			      layoutStr9 =  head1 + bdy + tail;
   			      bdy = "";
                   chartData10[0].items.forEach(function(e){
                	   bdy += '<SolidColor color="' + e.rgb +'"/>';
                   });
   			      layoutStr10 =  head1 + bdy + tail;
   					rMateChartH5.create("chart8", "chartHolder8", chartVars8, "100%", "99%");
   					rMateChartH5.create("chart9", "chartHolder9", chartVars9, "100%", "99%");
   					rMateChartH5.create("chart10", "chartHolder10", chartVars10, "100%", "99%");
   				
    	    },
    	    
    	    chart_sumary5: function(){
    	    	url = "/haa06/selectHaa06ChartJson4.json";
				var dateArr = $("#searchEndDateD").val().toString().split(' ~ ');
				var searchStrDate = dateArr[0];
				var searchEndDate = dateArr[1];
				
    	    	$.ajax({
    				type : "post",
    				url : url,
    				data : {
	        			searchStrDate: searchStrDate,
	        			searchEndDate: searchEndDate,
    				},
    				dataType : '',
    				success : function(res){
    					var val = res.list;
	   					chartData11 = val;
	   					var head1 = '<rMateChart>'
	   			        	+'<NumberFormatter id="numfmt" precision="1"/>'
	   			            +'<Options></Options>'
	
		   			        +'<TreeMapChart showDataTips="true" buttonMode="true" selectionMode="single" dataTipFormatter="{numfmt}">'
		   			              +'<series>'
		   			                +'<TreeMapSeries weightField="rate" nameField="pumNm" showGroupHeader="true" displayName="차지하는 비율(%)" groupField="items" groupNameField="name" color="#ffffff" labelPosition="inside" labelJsFunction="labelFunc" groupHeaderFontColor="#000000" fontSize="12">'
		   			                    +'<groupHeaderColor>'
		   			                       +'<SolidColor color="#eeeeee" />'
		   			                   +'</groupHeaderColor>'
		   			                      +'<showDataEffect>'
		   			                         +'<SeriesZoom relativeTo="chart" horizontalFocus="center" verticalFocus="middle" duration="1000"/>'
		   			                     +'</showDataEffect>'
		   			                    +'<fills>';
		   			                    
		   			                    var bdy = "";
		   			                   chartData11[0].items.forEach(function(e){
		   			                	   bdy += '<SolidColor color="' + e.rgb +'"/>';
		   			                   });
		
		   			                        var tail = '</fills>'
		   			                 +'</TreeMapSeries>'
		   			             +'</series>'
		   			        +'</TreeMapChart>'
		   			      +'</rMateChart>';
		   			      layoutStr11 =  head1 + bdy + tail;
	
						rMateChartH5.create("chart11", "chartHolder11", chartVars11, "100%", "99%");
    				}
    			});
    	    },
		};


		async function img_save(){
			var imgData;
			var imgWidth = 190;
			var imgHeight;
			var heightLeft;
			
			 // 이미지 가로 길이(mm) / A4 기준 210mm
		    var pageHeight = imgWidth * 1.414;  // 출력 페이지 세로 길이 계산 A4 기준
		    var margin = 10; // 출력 페이지 여백설정
		    var doc = new jsPDF('p', 'mm');
		    var position = 10;
		    
	        await html2canvas(document.getElementById("title"), {background:'#fff', onrendered: function( canvas ) {  
				// 캔버스를 이미지로 변환
			    imgData = canvas.toDataURL('image/jpeg');
		    	imgHeight = canvas.height * imgWidth / canvas.width;
		    	heightLeft = imgHeight;
	        }});

		    // 첫 페이지 출력
		    doc.addImage(imgData, 'JPEG', margin, position, imgWidth, imgHeight);
		    position += imgHeight+20;

	        await html2canvas(document.getElementById("searchOption"), {background:'#fff', onrendered: function( canvas ) {  
				// 캔버스를 이미지로 변환
			    imgData = canvas.toDataURL('image/jpeg');
		    	imgHeight = canvas.height * imgWidth / canvas.width;
		    	heightLeft = imgHeight;
	        }});

		    // 첫 페이지 출력
		    doc.addImage(imgData, 'JPEG', margin, position, imgWidth, imgHeight);
		    position += imgHeight+20;

	        await html2canvas(document.getElementById("chart_img3"), {background:'#fff', onrendered: function( canvas ) {  
				// 캔버스를 이미지로 변환
			    imgData = canvas.toDataURL('image/jpeg');
		    	imgHeight = canvas.height * imgWidth / canvas.width;
		    	heightLeft = imgHeight;
	        }});

		    // 첫 페이지 출력
		    doc.addImage(imgData, 'JPEG', margin, position, imgWidth, imgHeight);
		    position = 0;		   
		    doc.addPage();
		  
	        await html2canvas(document.getElementById("chart_img4"), {background:'#fff', onrendered: function( canvas ) {  
				// 캔버스를 이미지로 변환
			    imgData = canvas.toDataURL('image/jpeg');
		    	imgHeight = canvas.height * imgWidth / canvas.width;
		    	heightLeft = imgHeight;
	        }});

		    // 첫 페이지 출력
		    doc.addImage(imgData, 'JPEG', margin, position, imgWidth, imgHeight);
		    position += imgHeight;
		    // 파일 저장
		    doc.save('주간 거래동향.pdf');
		}

		function calendarShow(id){
			var pickId = "#inputBasic_AX_"+id+"_AX_dateHandle";
			$(pickId).click();
			$('#'+id).attr("readonly",true);
			setTimeout(function(){$('#'+id).attr("readonly",false);}, 50);
		}
	</script>
</head>

<body>

	<input type="hidden" id="lvCd" name="lvCd" value="92"/>
	<!--WRAP(S)-->
	<div class="wrap">

		<jsp:include page="../inc/2020/IncHeader.jsp"/>

		<!--서브 헤더 (S)-->
		<div class="lnb_box">
			<ul>
				<li><img src="../images/2020/m_lnb_img.png" alt="집"></li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li>경매정보</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li>경매통계</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li class="m_right">주간 거래동향</li>
			</ul>
		</div>

		<jsp:include page="../inc/2020/IncShare.jsp"/>
		
		<div class="sub_title">
			<div class="title_box">
				<div id="title">
				<h2 class="sub_tit">주간 거래동향</h2>
				</div>
				<img src="../images/2020/sub/t_line.png" alt="방울점선">
			</div>
		</div>

		<div class="sub_contents" id="searchOption">
			<div class="search_box_new statistic">			
				<input type="hidden" id="searchStrDate" value="${searchStrDate}">
				<input type="hidden" id="searchEndDate" value="${searchEndDate}">				
				<div class="s-line" style="overflow:initial">
					<h4 class="sbn_tit_01">기준기간</h4>
					<div class="sb_common_01 pack-01" style="padding-top: 5px !important;display:flex;flex-wrap:wrap;">

						<div class="date-from-to" id="searchDateY" style="width:auto">
							<div class="calendar_new" style="display: none">
								<input type="text" alt="켈린더" class="calendar_focus" id="searchStrDateD" value="${searchStrDateY}" onClick="calendarShow(this.id);"/>
							</div>
							<div class="calendar_new">
								<input type="text" style="width: 100%" alt="켈린더" class="calendar_focus" id="searchEndDateD" value="${searchEndDateY}" onClick="calendarShow(this.id);"/>
							</div>
						</div>
						<div style="margin-left:auto; border-radius: 4px; width: 120px;   padding-margin: 10px; text-align: center;     height: 45px;     background: #888888; display:inline-block; float:right;" data-html2canvas-ignore="true">
							<a class="search_btn_n" style="margin-left:0px;" href="javascript:fnObj.setPage();"><img src="../images/2020/sub/search_img.png" alt="돋보기"> 검색</a>
						</div>
						<div  data-html2canvas-ignore="true" class="dwn_bt_b" id="chartHolderBtn" onclick="img_save()" style="margin-top:0px"><a href="#!" style="margin-left:5px;line-height:45px;">차트저장</a></div>
					</div>
				</div>
			</div>
		</div>
		<div class="sub_guide" id="chart_img3" style="height: auto; min-height: 100px; overflow: auto;">
			<!-- 테이블(E) -->
			<div class="data_content_b" id="chart_img2" style="height: auto; min-height: 630px;">
				<div class="first" style="height: auto; min-height: 630px;">
					<h2 class="title_02">절화</h2>
					<div class="info_box h-type-01" id="chartHolder2"  style="height: auto; min-height: 630px;"></div>
				</div>
				<div class="second" style="height: auto; min-height: 630px;">
					<h2 class="title_02">관엽</h2>
					<div class="info_box h-type-01" id="chartHolder3"  style="height: auto; min-height: 630px;"></div>
				</div>
				<div class="third" style="height: auto; min-height: 630px;">
					<h2 class="title_02">난</h2>
					<div class="info_box h-type-01" id="chartHolder4" style="height: auto; min-height: 630px;"></div>
				</div>
			</div>
			<div class="cont_box_b"  >
			<div style="display: flex;justify-content: space-between;">
				<h2 class="title_02">품목별 거래량</h2>
			</div>
				<div class="export_date_b">
				<div id="chartHolder5" style="width:33%; height:340px; float:left;"></div>
				<div id="chartHolder6" style="width:33%; height:340px; float:left;"></div>
				<div id="chartHolder7" style="width:33%; height:340px; float:left;"></div>
				<div id="chartHolder8" style="width:33%; height:340px; float:left;"></div>
				<div id="chartHolder9" style="width:33%; height:340px; float:left;"></div>
				<div id="chartHolder10" style="width:33%; height:340px; float:left;"></div>
				</div>
			</div>
		</div>
			<!--컨텐츠 내용(S)-->
		<div class="sub_guide" id="chart_img4"style="height: auto; min-height: 100px; overflow: auto;">
			<div class="cont_box_b"  id="chart_img4">
				<div class="sub_info_box">
					<div class="fl">
						<h2 class="title_02">품종별 거래량(절화)</h2>
					</div>
					<div id="chartHolder11" style="width:100%; height:340px; float:left;"></div>
				</div>
			</div> 
			<!-- 테이블(E) -->
			<div class="cont_box_b"  id="chart_img1">
				<div class="sub_info_box">
					<div class="fl">
						<h2 class="title_02">월별판매물량<span class="flower__text param__info" style="font-size : 12px">(절화, 관엽, 난 합산 판매물량)</span></h2>
					</div>
					<div class="info_box h-type-01" id="chartHolder" style="width:100%; height:380px;"></div>
				</div>
			</div> 
		</div>
	</div>

		<jsp:include page="../inc/2020/IncFooter.jsp"/>
	</div>
	<!--WRAP(E)-->

	<!-- POPUP (S)-->
	<!-- The Modal -->
	<div id="multiPopup" class="modal">
	<div class="modal-content">
	    <div class="modal-body">
			<jsp:include page="../popup/multi_popup2.jsp"/>
	    </div>
	  </div>   
	</div>
<script>
	multiPopup.init(function(rs) {
		fnObj.setPopupParam(rs);
	});
</script>

	<!-- POPUP (E)-->
</body>