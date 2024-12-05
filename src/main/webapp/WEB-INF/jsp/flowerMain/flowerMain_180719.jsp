<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
	<title>화훼유통정보시스템</title>
	<link type="text/css" rel="stylesheet" href="/css/common.css">
	<link type="text/css" rel="stylesheet" href="/css/main.css">
	<link type="text/css" rel="stylesheet" href="/css/media.css" media="(max-width:1155px)">
	<link type="text/css" rel="stylesheet" href="/css/jquery-ui.min.css">
	<link rel="stylesheet" type="text/css" href="/rMateChart/rMateChartH5/Assets/Css/rMateChartH5.css"/> 
	
	<script type="text/javascript" src="/js/jquery-1.11.2.min.js"></script>
	<script type="text/javascript" src="/js/display.js"></script>
   	<script type="text/javascript" src="/js/jquery-ui.min.js"></script>
   	
   	<!-- rMateChartH5 라이센스 시작 -->
	<script type="text/javascript" src="/rMateChart/LicenseKey/rMateChartH5License.js"></script>
	<!-- rMateChartH5 라이센스 끝-->  
	<!-- 실제적인 rMateChartH5 라이브러리 시작-->
	<script type="text/javascript" src="/rMateChart/rMateChartH5/JS/rMateWordCloudH5.js"></script>
	<!-- 실제적인 rMateChartH5 라이브러리 끝-->
    <!-- rMateChartH5 테마 js -->
	<script type="text/javascript" src="/rMateChart/rMateChartH5/Assets/Theme/theme.js"></script>
	
	<script type="text/javascript">
		var startPageNo;
		var endPageNo;
		var layoutStr1 = "";
		var layoutStr2 = "";
		var layoutStr3 = "";
		var layoutStr4 = "";
		
		var chartData1 = [];
		var chartData2 = [];
		var chartData3 = [];
		var chartData4 = [];
		
		var chartVars1 = "rMateOnLoadCallFunction=chartReadyHandler1";
		var chartVars2 = "rMateOnLoadCallFunction=chartReadyHandler2";
		var chartVars3 = "rMateOnLoadCallFunction=chartReadyHandler3";
		var chartVars4 = "rMateOnLoadCallFunction=chartReadyHandler4";
		
		$(document).ready(function(){
			var d = new Date();
			
			//var thisYear = d.getFullYear();
			var thisMonth = (d.getMonth() + 1);
			//var thisDay = d.getDate();
			
			if(thisMonth>=3 && thisMonth<=5){
				$(".visualImg").removeClass("vs_Img04" );
				$(".visualImg").addClass("vs_Img01");	
			}else if(thisMonth>=6 && thisMonth<=8){
				$(".visualImg").removeClass("vs_Img04" );
				$(".visualImg").addClass("vs_Img02");
			}else if(thisMonth>=9 && thisMonth<=11){
				$(".visualImg").removeClass("vs_Img04" );
				$(".visualImg").addClass("vs_Img03");
			}else{

			}
			
			
			$("#datepicker").datepicker({
				showOn: "button",
			    buttonImage: "/images/btn/calendar.png",
				todayHighlight: true,
				autoclose: true,
				showMonthAfterYear: true,
		        dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
		        monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
				language: 'kr',
				dateFormat: 'yy-mm-dd',
				onSelect: function(selectedDate){
	                //$("#datepicker").datepicker("option", "minDate", selectedDate);
	           }
			});
			
			fnObj.pageStart();
		});
		
		 // 액시스제이 시작
		var fnObj = {
			pageStart: function(){ 
				// 절화/난/관엽/춘란 경매정보 분석
				productGubun('1');
				// 공지사항
				gongi('1','3');
				// 수급예측보고서 
				sugup('1','3');
				// 재배동향
				cropTrend('1','3');
				// 행사일정
				schedule('3');
				
			},
			
			//경매날짜 선택
		   	wsale_date: function(){  
		   		var cmpCd = $("#cmpCd").val();
		   		var flowerCd = $("#flowerCd").val();
		   		$.ajax({
					type : "post",
					url : "/main/selectAuctionDate.json",
					data : {
						CMP_CD : cmpCd,
						FLOWER_CD : flowerCd
					},
					dataType : '',
					success : function(res){
						var list = res.list;
						
						if(list.length > 0){
							$("#datepicker").val(list[0].SALE_DATE);
							$("#item2").val(list[0].PUM_NAME);
							searchSale();
							searchReal();
							getChartData1();
							//if(flowerCd == "1"){
								getChartData2();
								getChartData3();	
							//}
							getChartData4();
						}else{
							// 데이터가 없습니다
						}
					}
				});
		   	}
		 };
		
		function gongi(startPageNo, endPageNo){
			$.ajax({
				type : "post",
				url : "/main/flowerMain_backup_gongi.json",
				data : {
					startPageNo : startPageNo,
					endPageNo : endPageNo
				},
				dataType : '',
				success : function(res){
					var val = res.result;
					for(var i=0; i<val.length; i++){
						$("#gongi").append('<li><a href="/hfa01/hfa01.do?seq='+val[i].seq1+'&title='+val[i].title1+'&content='+val[i].content1+'&insId='+val[i].insId+'&insDt='+val[i].insDt1+'&gubn=update'+'&orFileNm='+val[i].originFileName+'&seqNum='+val[i].seq1+'"><span class="tit">'+val[i].title1+'</span><span class="day">'+val[i].insDt+'</span></a></li>');
					}
				}
			});
		}
		
		function sugup(startPageNo, endPageNo){
			$.ajax({
				type : "post",
				url : "/main/flowerMain_backup_sugup.json",
				data : {
					startPageNo : startPageNo,
					endPageNo : endPageNo
				},
				dataType : '',
				success : function(res){
					var val = res.result;
					for(var i=0; i<val.length; i++){
						$("#sugup").append('<li><a href="/hba01/hba01.do?seqNo='+val[i].seqNo+'&title='+val[i].title1+'&insId='+val[i].writeName+'&insDt='+val[i].insDt+'&gubn=update'+'&orFileNm='+val[i].originalFileName+'&seqNum='+val[i].seqNo+'"><span class="tit">'+val[i].title1+'</span><span class="down">&nbsp;</span></a></li>');
					}
				}
			});
		}
		
		function cropTrend(startPageNo, endPageNo){
			$.ajax({
				type : "post",
				url : "/main/flowerMain_backup_cropTrend.json",
				data : {
					startPageNo : startPageNo,
					endPageNo : endPageNo
				},
				dataType : '',
				success : function(res){
					var val = res.result;
					
					for(var i=0; i<val.length; i++){
						var bigo = val[i].BIGO;
						var bigoTxt = "";
						if(bigo==null){
							bigoTxt ="내용없음";
						}else{
							bigoTxt =val[i].BIGO;
						}
						$("#cropTrend").append('<li><a href="/hca02/hca02.do"><span class="tit">'+bigoTxt+'</span><span class="day">'+val[i].REG_DATE+'</span></a></li>');
					}
				}
			});
		}
		
		function schedule(rowcnt){
			$.ajax({
				type : "post",
				url : "/main/flowerMain_backup_schedule.json",
				data : {
					rowcnt : rowcnt
				},
				dataType : '',
				success : function(res){
					var val = res.result;
					if(val.length<=0){
						$("#schedule").append('<li><a href="/hfc01/hfc01.do"><span class="tit">행사일정이 없습니다.</span><span class="day"></span></a></li>');
					}else{
						for(var i=0; i<val.length; i++){
							$("#schedule").append('<li><a href="/hfc01/hfc01.do"><span class="tit">'+val[i].TITLE+'</span><span class="day">'+val[i].STARTDT+'</span></a></li>');
						}
					}
				}
			});
		}
		
		function chart1(){
			
			// 스트링 형식으로 레이아웃 정의.
			layoutStr1 = 
				 '<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'
			     +'<Options>'                     
			                     +'<SubCaption text="물량(만속/만분)" textAlign="left" />'
			                     +'<SubCaption text="금액(원)" textAlign="right" />'
			                     +'<Legend position="bottom" defaultMouseOverAction="false" useVisibleCheck="false" />'
			                 +'</Options>'
			    +'<NumberFormatter id="numFmt" useThousandsSeparator="true"/>'
			    +'<Combination2DChart showDataTips="true" dataTipDisplayMode="axis">'
			/* 
			Combination2D 차트 생성시에 필요한 Combination2DChart 정의합니다 
			showDataTips : 데이터에 마우스를 가져갔을 때 나오는 Tip을 보이기/안보이기 속성입니다  
			*/
			        +'<horizontalAxis>'
			           +'<CategoryAxis categoryField="saleMonth"/>'
			        +'</horizontalAxis>'
			        +'<verticalAxis>'
			            +'<LinearAxis id="vAxis1"  formatter="{numFmt}" />'
			            +'<LinearAxis id="vAxis2"  minimum="1" formatter="{numFmt}" />'
			        +'</verticalAxis>'
			        +'<series>'
			        /* Combination2D Multi-Sereis 를 넣고자 하는 series를 여러개 정의합니다 */
			           
			            +'<Column2DSet type="clustered">'
			/* 
			Combination 차트에서는 Column차트와 Bar차트를 사용할때 Column3DSet(Colum2DSet),Bar3DSet(Bar2DSet)을 사용합니다
			예제로 Column3DSeries를 사용하려 할 때는 Column3DSet을 정의 후 +'<series>'와+'<Column3DSet>'을 정의합니다
			Column3DSet(Colum2DSet),Bar3DSet(Bar2DSet)의 Type은 일반 Type과 동일 합니다
			그러나 기본 Type은 overlaid입니다
			*/
			                +'<series>'
			                    +'<Column2DSeries verticalAxis="{vAxis1}" yField="totQty" displayName="금년물량">'
			                    	+'<fill>'
										/* Series안에 색을 채울 때(단일색) fill에 주목 */
										+'<SolidColor color="#4453A8" alpha="1"/>'
										/* color:색깔 alpha:투명도 */
									+'</fill>'
			                        +'<showDataEffect>'
			                            +'<SeriesInterpolate/>'
			                        +'</showDataEffect>'
			                    +'</Column2DSeries>'
			                    +'<Column2DSeries verticalAxis="{vAxis1}" yField="oldTotQty" displayName="전년물량">'
					                +'<fill>'
										/* Series안에 색을 채울 때(단일색) fill에 주목 */
										+'<SolidColor color="#40B2E6" alpha="1"/>'
										/* color:색깔 alpha:투명도 */
									+'</fill>'
			                    	+'<showDataEffect>'
			                            +'<SeriesInterpolate/>'
			                        +'</showDataEffect>'
			                    +'</Column2DSeries>'
			                +'</series>'
			            +'</Column2DSet>'
			            +'<Line2DSeries verticalAxis="{vAxis2}" yField="avgAmt" radius="4" displayName="경매가격">'
			            	+'<lineStroke>'
								+'<Stroke color="#03A9F7" weight="2"/>'
							+'</lineStroke>'
			            /*+'<verticalAxis>'
			                    +'<LinearAxis id="vAxis2"  formatter="{numFmt}"/>'
			                +'</verticalAxis>'*/
			                +'<showDataEffect>'
			                    +'<SeriesInterpolate/>'
			                +'</showDataEffect>'
			            +'</Line2DSeries>'
			            +'<Line2DSeries verticalAxis="{vAxis2}" yField="oldAvgAmt" radius="4" displayName="전년경매가격">'
			            	+'<lineStroke>'
								+'<Stroke color="#F6BD00" weight="2"/>'
							+'</lineStroke>'
			            	    
			            	/*+'<verticalAxis>'
				                +'<LinearAxis id="vAxis2"  formatter="{numFmt}"/>'
				            +'</verticalAxis>'*/
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
			
			 
			rMateChartH5.create("chart1", "chartHolder1", chartVars1, "100%", "100%"); 
			

		}
		
	function chart2(regDate){
		    
			var month = regDate.substr(5,2);
			
			if(month!="10"){
				month = month.replace("0","");
			}
			
			var title = "장미 "+month+"월 출하물량" + "<span class=\"more\"><a href=\"/hca01/hca01.do\">+</a></span>"
			
			$(".ct08 > h4").html(title);
			
			// 스트링 형식으로 레이아웃 정의.
			layoutStr2 = 
				'<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'
				+'<Options>'
				 	+'<SubCaption text="물량(속)" textAlign="left" />'
				+'</Options>'
				+'<NumberFormatter id="numfmt" useThousandsSeparator="true"/>' 
				+'<Combination3DChart showDataTips="true" >'
			/*  
			Target_3D 차트 생성시에 필요한 Combination3DChart 정의합니다 
			showDataTips : 데이터에 마우스를 가져갔을 때 나오는 Tip을 보이기/안보이기 속성입니다.
			*/ 
					+'<horizontalAxis>'
						+'<CategoryAxis categoryField="day_GUBN" padding="1"/>' 
					+'</horizontalAxis>'
					+'<verticalAxis>'
						+'<LinearAxis  formatter="{numfmt}" />'
					+'</verticalAxis>'
					+'<series>'
					/* 목표비실적Chart의 지켜야 할 점은 실적에 해당되는 시리즈를 먼저 정의 후에 목표 시리즈를 정의 해야 합니다 */
						/* 실적에 해당 필히 순서 준수*/
						+'<VTarget3DResultSeries yField="qty_2" displayName="출하물량" labelPosition="outside"  columnWidthRatio="0.5" >'
							+'<fill>'
								+'<SolidColor color="#43b3e6"/>'
							+'</fill>'
						/* Combination3DChart 정의 후 Target3DResultSeries 정의합니다 */
							+'<showDataEffect>'
							/*  차트 생성시에 Effect를 주고 싶을 때 shoDataEffect정의합니다 */
								+'<SeriesInterpolate/>' 
								/*  
								SeriesInterpolate는 시리즈 데이터가 새로운 시리즈 데이터로 표시될 때 이동하는 효과를 적용합니다 
								- 공통속성 -						
								elementOffset : effect를 지연시키는 시간을 지정합니다 default:20
								minimumElementDuration : 각 엘리먼트의 최소 지속 시간을 설정합니다 default:0
											 이 값보다 짧은 시간에 effect가 실행되지 않습니다
								offset : effect개시의 지연시간을 설정합니다 default:0
								perElementOffset : 각 엘리먼트의 개시 지연시간을 설정합니다
								*/
							+'</showDataEffect>'
						+'</VTarget3DResultSeries>'
						/* 목표에 해당 */
						+'<VTarget3DGoalSeries yField="qty_1" displayName="출하예정물량" columnWidthRatio="0.52" >'
						/* Target3DResultSeries 정의 후 Target3DGoalSeries 정의합니다 */
							+'<showDataEffect>'
								+'<SeriesInterpolate/>' 
							+'</showDataEffect>'
							+'<fill>'
								+'<SolidColor color="#bde3fa" alpha="0.5"/>'
							+'</fill>'
						+'</VTarget3DGoalSeries>'
						/* 목표비실적Chart는 두개의 시리즈만 정의 하여야 합니다 */
					+'</series>'
				+'</Combination3DChart>'
			+'</rMateChart>';
			
			rMateChartH5.create("chart2", "chartHolder2", chartVars2, "100%", "100%"); 
			

		}
	
	
	function chart3(regDate){
		
		var month = regDate.substr(5,2);
		
		if(month!="10"){
			month = month.replace("0","");
		}
		
		var title = "장미 "+month+"월 작황동향" + "<span class=\"more\"><a href=\"/hca03/hca03.do\">+</a></span>"
		
		$(".ct09 > h4").html(title);
		
		// 스트링 형식으로 레이아웃 정의.
		layoutStr3 = 
			'<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'
		    +'<Options>'
		        +'<Caption text=""/>'
		    +'</Options>'
		    +'<Pie2DChart id="chartPie" innerRadius="0.25" showDataTips="true" selectionMode="single" >'
		/* 
		Doughnut2D 차트 생성시에 필요한 Pie2DChart 정의합니다 
		showDataTips : 데이터에 마우스를 가져갔을 때 나오는 Tip을 보이기/안보이기 속성입니다.  
		innerRadius : PieChart 가운데에 빈 공간을 만듭니다. 유효값 0.1 ~ 0.9 0은 PieChart 1은 차트 사라짐
		*/
		        +'<series>'
		            +'<Pie2DSeries nameField="status" field="statusCnt" startAngle="-90" renderDirection="clockwise" labelPosition="inside" color="#ffffff" labelJsFunction="pieSeriesLabelFunc" outerRadius="0.8">'
		            /* Pie2DChart 정의 후 Pie2DSeries labelPosition="inside"정의합니다 */
		                +'<showDataEffect>'
		                /* 차트 생성시에 Effect를 주고 싶을 때 shoDataEffect정의합니다 */
		                    +'<SeriesZoom duration="1000"/>'
							     /* 
							     SeriesInterpolate 효과는 시리즈 데이터가 데이터로 표시될 때 한쪽에서 미끄러지듯 나타나는 효과를 적용합니다
							     - 공통속성 -                        
							     elementOffset : effect를 지연시키는 시간을 지정합니다 default:20
							     minimumElementDuration : 각 엘리먼트의 최소 지속 시간을 설정합니다 default:0
							                  이 값보다 짧은 시간에 effect가 실행되지 않습니다
							     offset : effect개시의 지연시간을 설정합니다 default:0
							     perElementOffset : 각 엘리먼트의 개시 지연시간을 설정합니다
							     - SeriesSlide속성 -
							     direction : left:왼쪽, right:오른쪽, up:위, down:아래 default는 left입니다
							     */
		                +'</showDataEffect>'
		            +'</Pie2DSeries>'
		        +'</series>'
		        +'<backgroundElements>'
		            +'<CanvasElement>'
		                +'<Label text="" horizontalCenter="0" verticalCenter="0" fontSize="20" fontWeight="bold" color="#777777" backgroundAlpha="0"/>'
		            +'</CanvasElement>'
		        +'</backgroundElements>'
		    +'</Pie2DChart>'
		+'</rMateChart>';
		
		rMateChartH5.create("chart3", "chartHolder3", chartVars3, "100%", "100%"); 
	}
	
	function chart4(){
		
		layoutStr4 = '<rMateChart backgroundColor="#FFFFFF"  borderStyle="none" fontFamily="Noto Sans KR">' // 이 예제에서는 구글 웹폰트를 적용하였습니다.
			+'<WordCloudChart showDataTips="true">'
				+'<series>'
					+'<WordCloudSeries textField="pumName" weightField="totQty">'
						+'<showDataEffect>'
							+'<SeriesInterpolate duration="1000"/>'
						+'</showDataEffect>'
					+'</WordCloudSeries>'
				+'</series>'
			+'</WordCloudChart>'
		+'</rMateChart>';
		
		rMateChartH5.create("chart4", "chartHolder4", chartVars4, "100%", "100%"); 
	}
	
	
	
		
		function chartReadyHandler1(id) {
			
		    document.getElementById(id).setLayout(layoutStr1);
		    document.getElementById(id).setData(chartData1);
		    //rMateChartH5.registerTheme(rMateChartH5.themes);
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
		
		function pieSeriesLabelFunc(seriesId, index, data, values){
			
			return values[1].toFixed(2) + "%";
		}
		
		
		function getChartData1(){
			var searchYear = $("#datepicker").val().substr(0,4);
			var cmpCd = $("#cmpCd").val();
	   		var flowerCd = $("#flowerCd").val();
	   		var itemCd = $("#item2").val();
			$.ajax({
				type : "post",
				url : "/hab06/hab06ChartData.json",
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
					//rMateChartLoding("chart1", "chartReadyHandler1");
				}
			});
		}
		
		function getChartData2(){
			var searchMonth = $("#datepicker").val().substr(0,7);
			var cmpCd = $("#cmpCd").val();
	   		var flowerCd = $("#flowerCd").val();
			$.ajax({
				type : "post",
				url : "/hca01/selectMainChulChart.json",
				data : {
					searchProductGubun : flowerCd,
					searchCmpCd : cmpCd,
					searchMonth : searchMonth
				},
				dataType : '',
				success : function(res){
					var val = res.list;
					chartData2 = val;
					chart2(res.list[0].reg_DATE);
				}
			});
		}
		
		function getChartData3(){
			
			var searchMonth = $("#datepicker").val().substr(0,7);
			var cmpCd = $("#cmpCd").val();
	   		var flowerCd = $("#flowerCd").val();
			$.ajax({
				type : "post",
				url : "/hca03/selectCropMainChart.json",
				data : {
					searchProductGubun : flowerCd,
					searchCmpCd : cmpCd,
					searchMonth : searchMonth
				},
				dataType : '',
				success : function(res){
					var val = res.list;
					chartData3 = val;
					chart3(res.list[0].regDate);
				}
			});
			
		}
		
		function getChartData4(){
			
			var searchMonth = $("#datepicker").val().substr(0,7);
			var cmpCd = $("#cmpCd").val();
	   		var flowerCd = $("#flowerCd").val();
			$.ajax({
				type : "post",
				url : "/hab04/selectHab04Json.json",
				data : {
					searchProductGubun : flowerCd,
					searchCmpCd : cmpCd,
					searchSaleMonth : searchMonth,
					searchGubn : "main"
				},
				dataType : '',
				success : function(res){
					var val = res.list;
					chartData4 = val;
					chart4();
				}
			});
			
			
		}
		
		function productGubun(gubn){
			$("#flowerCd").val(gubn);
			fnObj.wsale_date(); 
		}
		
		//품목별 경매정보 분석
		function searchSale(){
			var cmpCd = $("#cmpCd").val();
			var flowerCd = $("#flowerCd").val();
			var saleDate = $("#datepicker").val();
			var itemCd = $("#item2").val();
			
	       $.ajax({
	           type : 'get',
	           url : "/main/getPumInfo.json",
	           data :  '&CMP_CD='+cmpCd+'&FLOWER_CD='+flowerCd+'&SALE_DATE='+saleDate+'&ITEM_CD='+encodeURI(itemCd),
	           dataType : '',   	           
	           success : function(res){         
               	var result_jong = res.list;
	           	if(res.list.length!=0 ){
                 		var AVG_AMT2= result_jong[0].AVG_AMT;
                 		var AVG_AMT=Math.floor(AVG_AMT2);
                 		var TOT_QTY= result_jong[0].TOT_QTY;
                 		var PER_TOT_AMT= result_jong[0].PER_TOT_AMT;
                 		var PER_TOT_QTY= result_jong[0].PER_TOT_QTY;
                 		var PER_AMT_COL= result_jong[0].PER_AMT_COL;
                 		var PER_QTY_COL= result_jong[0].PER_QTY_COL;
                 		
                 		var AVG_AMT_comma= numberWithCommas(AVG_AMT);  
                  	var TOT_QTY_comma= numberWithCommas(TOT_QTY);  
                  	
                  	// 평균가
                  	var divPrice=document.getElementById("price");  
                	divPrice.innerHTML= AVG_AMT_comma+"원";
                	
                	// 거래량
                	var divQty=document.getElementById("qty");  
                	divQty.innerHTML= TOT_QTY_comma+"속";
                	
                	var divMonAmt=document.getElementById("monAmt");  
                	if(PER_AMT_COL == "ft_red"){
                		divMonAmt.innerHTML= "전월대비 <span class="+PER_AMT_COL+">"+PER_TOT_AMT+"%▲</span>"; 
                	}else if(PER_AMT_COL == "ft_blue"){
                		divMonAmt.innerHTML= "전월대비 <span class="+PER_AMT_COL+">"+PER_TOT_AMT+"%▼</span>"; 	
                	} else{
                		divMonAmt.innerHTML= "전월대비 <span class="+PER_AMT_COL+">"+PER_TOT_AMT+"%</span>";
                	}
                	
                	var divMonQty=document.getElementById("monQty");  
                	if(PER_QTY_COL == "ft_red"){
                		divMonQty.innerHTML= "전월대비 <span class="+PER_QTY_COL+">"+PER_TOT_QTY+"%▲</span>"; 
                	}else if(PER_QTY_COL == "ft_blue"){
                		divMonQty.innerHTML= "전월대비 <span class="+PER_QTY_COL+">"+PER_TOT_QTY+"%▼</span>"; 	
                	}else{
                		divMonQty.innerHTML= "전월대비 <span class="+PER_QTY_COL+">"+PER_TOT_QTY+"%</span>";
                	}
	        	};
	           },
	       });      	 
	   }; 
	   
	   // 실시간 경매정보
	   function searchReal(){
			var cmpCd = $("#cmpCd").val();
			var flowerCd = $("#flowerCd").val();
			var saleDate = $("#datepicker").val();
			var itemCd = $("#item2").val();
			
			$.ajax({
				type : "post",
				url : "/real/getRealMainData.json",
				data : {
					cmpCd : cmpCd,
					flowerCd : flowerCd,
					itemCd : itemCd
				},
				dataType : '',
				success : function(res){
					var val = res.list;
					$("#tRealData").html("");
					if(val.length == 0){
						var str = 
						$("#tRealData").append("<tr><td colspan='6'>데이터가 없습니다.</td></tr>");
					}
					else if(val.length < 6){
						for(var i=0; i<val.length; i++){
							var nakTimeH = val[i].nakTime.substring(8,10);
							var nakTimeM = val[i].nakTime.substring(10,12);
							
							$("#tRealData").append('<tr><td>'+val[i].pumName+'</td><td>'+val[i].goodName+'</td><td>'+val[i].lvName+'</td><td>'+val[i].qty+'</td><td>' + val[i].cost+'</td><td>'+nakTimeH+':'+nakTimeM+'</td></tr>');
						}
					}else{
						for(var i=0; i<6; i++){
							var nakTimeH = val[i].nakTime.substring(8,10);
							var nakTimeM = val[i].nakTime.substring(10,12);
							
							$("#tRealData").append('<tr><td>'+val[i].pumName+'</td><td>'+val[i].goodName+'</td><td>'+val[i].lvName+'</td><td>'+val[i].qty+'</td><td>' + val[i].cost+'</td><td>'+nakTimeH+':'+nakTimeM+'</td></tr>');
						}
					}
					
				}
			});
		}
		
		 //숫자 콤마 함수
		function numberWithCommas(x) {
			if(x != null && x != ""){
				return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");	
			}else{
				return "-";
			}
		};
		
		//코드검색 버튼
		function NewWindow(mypage,myname,w,h,scroll){
			var LeftPosition = (screen.width) ? (screen.width-w)/2 : 0;
			var TopPosition = (screen.height) ? (screen.height-h)/2 : 0;
			var settings = 'location=no,height='+h+',width='+w+',top='+TopPosition+',left='+LeftPosition;
			var win = window.open("/flowerMain/flowerMain_Search.do?flowerCd="+$("#flowerCd").val()+"&SALE_DATE="+$("#datepicker").val()+"&CMP_CD="+$("#cmpCd").val(),myname,settings);
			
		}
	   
	</script>
	
</head>
<body>
	<form>
		<input type="hidden" id="startPageNo" name="startPageNo" value="1"/>
		<input type="hidden" id="endPageNo" name="endPageNo" value="3"/>
		<input type="hidden" id="cmpCd" name="cmpCd" value="0000000001" />
		<input type="hidden" id="flowerCd" name="flowerCd"/>
	</form>
	<ul class="skip_nav">
		<li><a href="#header">상단바로가기</a></li>
		<li><a href="#content">본문바로가기</a></li>
	</ul><!-- skip end -->
	<div id="wrap_wrap">
		<div class="visualImg vs_Img04">
			<div class="container">
				<jsp:include page="../inc/IncHeader.jsp"/>
				<p class="vs_tit">화훼 실시간 <span class="mb_br">거래 시스템 NO.1</span></p>
				<div class="visualWrap">
					
					<h3 class="blind">주메뉴 바로가기</h3>
					<ul class="visual">
						<li class="li01">
							<a href="/real/real2.do"><span class="tit tit01">실시간 경매정보</span></a>
						</li>
						<!-- 배너 1 end -->
						<li class="li02">
							<a href="/hab01/hab01.do"><span class="tit tit02">일자별 경매정보</span></a>
						</li>
						<!-- 배너 2 end -->
						<li class="li03">
							<a href="/hca01/hca01.do"><span class="tit tit03">출하 및 작황정보</span></a>
						</li>
						<!-- 배너 3 end -->
					</ul><!-- visual end-->
				</div><!-- visualWrap end -->
			</div><!-- contaiver end -->
		</div><!--  visualImg end -->
		
			<article>
				<h2 class="blind">화훼유통정보시스템 본문</h2>
				<div class="contentWrap" id="content">
					<section class="section sec01">
						<div class="container">
							<h3 class="blind">경매정보 조회 및 분석</h3>
							<div class="content ct01">
								<h4 class="blind">경매정보 조회</h4>
								<ul class="dt">
									<li class="dt01 on"><a href="#" onclick="javascript:productGubun(1);">절화</a></li>
									<li class="dt02"><a href="#" onclick="javascript:productGubun(3);">난</a></li>
									<li class="dt03"><a href="#" onclick="javascript:productGubun(2);">관엽</a></li>
									<li class="dt04"><a href="#" onclick="javascript:productGubun(4);">춘란</a></li>
								</ul><!-- dt end-->
								<ul class="dd">
									<li class="dd01">
										<ul class="dd_ct">
											<li class="dd_txt">경매날짜선택</li>
											<li class="search">
												<div class="date-picker">
													<input type="text" name="datepicker" id="datepicker"  title="날짜"/>
												</div>
											</li>
											<li class="dd_txt pt13">품목선택</li>
											<li class="search">
												<label for="item2" class="hide">품목입력</label>
												<input type="text" id="item2" value="장미"/>
												<button class="item_searchBtn" onclick="NewWindow(this,'name','350','500','yes');return false">코드검색</button>
												<!-- <div class="hw_select_05_1"><a href="/flowerMain/flowerMain_Search.do" onclick="NewWindow(this,'name','350','500','yes');return false">코드검색</a></div> -->
											</li>
											<li><button class="searchBtn01" onclick="searchSale();searchReal();getChartData1();getChartData2();getChartData3();getChartData4();">조 회</button></li>
										</ul><!-- dd_ct end -->
									</li><!-- dd01 end-->
								</ul><!-- dd end -->
							</div><!-- content ct01 -->
							<div class="content ct02">
								<h4>실시간 경매정보<span class="more"><a href="/real/real2.do">+</a></span></h4>
								<table class="realtime">
									<caption>실시간 경매정보 표 입니다.</caption>
									<colgroup>
										<col style="width:13%;">
										<col style="width:*;">
										<col style="width:12%;">
										<col style="width:19%;">
										<col style="width:18%;">
										<col style="width:19%;">
									</colgroup>
									<thead>
										<tr>
											<th>품목</th>
											<th>품종</th>
											<th>등급</th>
											<th>속수량</th>
											<th>낙찰<span class="br">금액</span></th>
											<th>낙찰<span class="br">시간</span></th>
										</tr>
									</thead>
									<tbody id="tRealData">
									</tbody>
								</table><!-- realtime end -->
							</div><!-- content ct02 -->
							<div class="content ct03">
								<h4 class="blind">경매정보분석</h4>
								<ul class="analysis">
									<li class="tit">경매정보분석</li>
									<li class="txt">
										<span class="txt01">평균가</span>
										<span class="txt02" id="price">-원</span>
										<span class="txt03"  id="monAmt">전월대비 <span class="ft_red">-</span></span>
									</li>
									<li class="txt brNo">
										<span class="txt01">거래량</span>
										<span class="txt02"   id="qty">-속</span>
										<span class="txt03" id="monQty">전월대비 <span class="ft_red">-</span></span>
									</li>
								</ul><!-- analysis end -->
							</div><!-- content ct03 -->
						</div><!--  container end  -->
					</section><!-- section end-->
					
					<section class="section sec02">
						<div class="container">
							<div class="content3 ct07">
								<h4>시세동향<span class="more"><a href="/hab06/hab06.do">+</a></span></h4>
									<div class="chart1" id="chartHolder1" style="width:100%; height:380px;"></div>
							</div><!-- content ct07 -->
						</div><!--  container end  -->
					</section>
					<section class="section sec03">
						<div class="container">
							<div class="content4 ct08">
								<h4>장미 출하물량<span class="more"><a href="/hca01/hca01.do">+</a></span></h4>
								<div class="chart2" id="chartHolder2" style="width:100%; height:280px;"></div>
							</div><!-- content ct08 -->
							<div class="content4 ct09">
								<h4>장미 작황동향<span class="more"><a href="/hca03/hca03Select.do">+</a></span></h4>
								<div class="chart2" id="chartHolder3" style="width:100%; height:280px;"></div>
							</div><!-- content ct09 -->
							<div class="content4 ct10">
								<h4>행사예정<span class="more"><a href="/hfc01/hfc01.do">+</a></span></h4>
								<div class="chart2" id="chartHolder4" style="width:100%; height:170px;"></div>
								<ul class="notice" id="schedule">
								</ul>
							</div><!-- content ct10 -->
						</div><!--  container end  -->
					</section>
					
					<section class="section sec04">
						<div class="container">
							<h3 class="blind">주요 안내</h3>
							<div class="content2 ct04">
								<h4>공지사항<span class="more"><a href="/hfa01/hfa01.do">+</a></span></h4>
								<ul class="notice" id="gongi">
								</ul>
							</div><!-- content2 ct04 -->
							<div class="content2 ct05">
								<h4>월간장미수급예측보고서<span class="more"><a href="/hba01/hba01.do">+</a></span></h4>
								<ul class="notice" id="sugup">
								</ul>
							</div><!-- content2 ct05 -->
							<div class="content2 ct06">
								<h4>재배동향<span class="more"><a href="/hca02/hca02.do">+</a></span></h4>
								<ul class="notice" id="cropTrend">
								</ul>
								<!-- <p class="notice2">
									경기도의 작황은 연초부터 연말까지 별 다른 애로사항없이 평년작을 보였다고 볼 수 있다. 다만 올해는 경기 북부와 강원도의 가뭄, 그리고 남부권의 경기도의 작황은 ..
								</p> -->
							</div><!-- content2 ct06 -->
						</div><!--  container end  -->
					</section><!-- section end-->
				</div><!-- contentWrap end -->
			</article>
			<jsp:include page="../inc/IncFooter.jsp"/>
		
	</div><!--  wrap_wrap end -->
</body>
</html>