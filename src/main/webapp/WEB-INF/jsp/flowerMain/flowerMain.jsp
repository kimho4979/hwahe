<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1" />
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, user-scalable=no">
	<meta name="apple-mobile-web-app-title" content="화훼유통정보시스템">
	<meta name="robots" content="no-index,follow">
	<meta name="og:title" content="화훼유통정보시스템">
	<meta name="og:description" content="화훼유통정보. 전국 화훼공판장 경매시세 조회 및 화훼 관련 정보 제공. 화훼 경락가격, 유찰정보, 수출입량 등 다양한 정보를 만나보세요.">
	<meta name="content" content="화훼유통정보시스템 입니다.">
	<meta name="keywords" content="화훼경매시세, 화훼경매가격, Korea aT flower market auction price, 화훼공판장, 화훼거래정보, 꽃시장, 꽃값">
	<meta name="description" content="화훼유통정보. 전국 화훼공판장 경매시세 조회 및 화훼 관련 정보 제공. 화훼 경락가격, 유찰정보, 수출입량 등 다양한 정보를 만나보세요.">
	<meta name="Author" content="화훼유통정보시스템 & www.woorim.co.kr">
	<title>화훼유통정보시스템</title>
	
	<!-- CSS(S) -->
	<link rel="stylesheet" type="text/css" href="../css/2020/reset.css">
	<link rel="stylesheet" type="text/css" href="../css/2020/common.css">
	<link rel="stylesheet" type="text/css" href="../css/2020/main.css">
	<link rel="stylesheet" type="text/css" href="../css/2020/jquery-ui.css"> <!-- datepicker style -->
	
	<link rel="stylesheet" type="text/css" href="../css/2020/calendar.css">
	<!-- CSS(E) -->
	
	<link type="text/css" rel="stylesheet" href="/plugin/jquery-ui-1.12.1.custom/jquery-ui.min.css">
		
	<!-- rMate common File -->
	<link rel="stylesheet" type="text/css" href="/rMateChart/rMateChartH5/Assets/Css/rMateChartH5.css"/> 

	<!-- SCRIPT(S) -->
	<script type="text/javascript" src="../js/2020/jquery-3.6.0.min.js"></script>
	<script type="text/javascript" src="../js/2020/jquery-ui.js"></script> <!-- datepicker js -->
	<script type="text/javascript" src="../js/2020/script.js"></script>
	<script type="text/javascript" src="../js/2020/jquery.bxslider.min.js"></script>
	<script type="text/javascript" src="../js/2020/swipe.js"></script><!-- 메인슬라이드  -->
	
	<script type="text/javascript" src="../js/2020/calendar.js"></script>
	<!-- SCRIPT(E) -->


	<!--  파비콘 소스  -->
	<link rel="apple-touch-icon" href="/images/content/favicon.png" />
	<link rel="apple-touch-icon-precomposed" href="/images/content/favicon.png" />
	<link rel="shortcut icon" href="/images/content/favicon.png" />
	<link rel="shortcut icon" href="/images/content/favicon.png" type="image/x-icon" >

	
	<!-- Global site tag (gtag.js) - Google Analytics -->	
	<!-- <script async src="https://www.googletagmanager.com/gtag/js?id=UA-124845654-1"></script>
	<script>
		  window.dataLayer = window.dataLayer || [];
		  function gtag(){dataLayer.push(arguments);}
		  gtag('js', new Date());
		
		  gtag('config', 'UA-124845654-1');
	</script> -->
	<!--Google tag (gtag.js) GA4 25 화훼공판장 2023.01 -->
	<script async src="https://www.googletagmanager.com/gtag/js?id=G-GH4XDEKH3E"></script>
	<script>
		window.dataLayer = window.dataLayer || [];
		function gtag(){dataLayer.push(arguments);}
		gtag('js',new Date());
		
		gtag('config','G-GH4XDEKH3E'),{'content_group':'FlowerInfo'};
		gtag('config','G-1C6GSRP5Z8'),{'content_group':'FlowerInfo'};
	</script>
	
	<!-- rMate common File -->
	<script type="text/javascript" src="/rMateChart/LicenseKey/rMateChartH5License.js"></script>
	<script type="text/javascript" src="/rMateChart/rMateChartH5/JS/rMateChartH5.js"></script>
	<script type="text/javascript" src="/rMateChart/rMateChartH5/Assets/Theme/theme.js"></script>
	
	<script type="text/javascript">
		var chartDate1 = "";
		var chartDate2 = "";
		var chartDate3 = "";
		//-----------------------차트 설정 시작-----------------------
		
		//rMate 차트 생성 준비가 완료된 상태 시 호출할 함수를 지정합니다.
		
		var chartVars1 = "rMateOnLoadCallFunction=chartReadyHandler1";
		var chartVars2 = "rMateOnLoadCallFunction=chartReadyHandler2";
		var chartVars3 = "rMateOnLoadCallFunction=chartReadyHandler3";
		var chartVars4 = "rMateOnLoadCallFunction=chartReadyHandler4";
		var chartVars5 = "rMateOnLoadCallFunction=chartReadyHandler5";
		var chartVars6 = "rMateOnLoadCallFunction=chartReadyHandler6";
		//rMateChart 를 생성합니다.
		//파라메터 (순서대로) 
		//1. 차트의 id ( 임의로 지정하십시오. ) 
		//2. 차트가 위치할 div 의 id (즉, 차트의 부모 div 의 id 입니다.)
		//3. 차트 생성 시 필요한 환경 변수들의 묶음인 chartVars
		//4. 차트의 가로 사이즈 (생략 가능, 생략 시 100%)
		//5. 차트의 세로 사이즈 (생략 가능, 생략 시 100%)
		rMateChartH5.create("chart1", "chartHolder1", chartVars1, "100%", "100%"); 
		rMateChartH5.create("chart2", "chartHolder2", chartVars2, "100%", "100%"); 
		rMateChartH5.create("chart3", "chartHolder3", chartVars3, "100%", "100%"); 
		rMateChartH5.create("chart4", "chartHolder4", chartVars4, "100%", "100%"); 
		rMateChartH5.create("chart5", "chartHolder5", chartVars5, "100%", "100%"); 
		rMateChartH5.create("chart6", "chartHolder6", chartVars6, "100%", "100%"); 

		//차트의 속성인 rMateOnLoadCallFunction 으로 설정된 함수.
		//rMate 차트 준비가 완료된 경우 이 함수가 호출됩니다.
		//이 함수를 통해 차트에 레이아웃과 데이터를 삽입합니다.
		//파라메터 : id - rMateChartH5.create() 사용 시 사용자가 지정한 id 입니다.
		function chartReadyHandler1(id) {
			if(document.getElementById(id) != null){
				document.getElementById(id).setLayout(layoutStr1);
				document.getElementById(id).setData(chartData1);
			}			
		}
		function chartReadyHandler2(id) {
			if(document.getElementById(id) != null){
			 	document.getElementById(id).setLayout(layoutStr2);
			 	document.getElementById(id).setData(chartData2);
			}
		}
		function chartReadyHandler3(id) {
			if(document.getElementById(id) != null){
			 document.getElementById(id).setLayout(layoutStr3);
			 document.getElementById(id).setData(chartData3);
			}
		}
		function chartReadyHandler4(id) {
			if(document.getElementById(id) != null){
			 document.getElementById(id).setLayout(layoutStr4);
			 document.getElementById(id).setData(chartData4);
			}
		}
		function chartReadyHandler5(id) {
			if(document.getElementById(id) != null){
			 document.getElementById(id).setLayout(layoutStr5);
			 document.getElementById(id).setData(chartData5);
			}
		}
		function chartReadyHandler6(id) {
			if(document.getElementById(id) != null){
			 document.getElementById(id).setLayout(layoutStr6);
			 document.getElementById(id).setData(chartData6);
			}
		}
	
		//스트링 형식으로 레이아웃 정의.
		var layoutStr1 = 
	     '<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'
	         +'<Options>'
	             +'<Caption text=""/>'
	         +'</Options>'
	         +'<Pie2DChart showDataTips="true">'
	             +'<series>'
	                 +'<Pie2DSeries nameField="marketName" field="totQty" labelField="per" startAngle="-90" renderDirection="clockwise" labelPosition="inside" fontSize="20" color="#ffffff" fillJsFunction="fillJsFunc">'
			             +'<showDataEffect>'
	                         +'<SeriesSlide duration="1000"/>'
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
	
		//차트 데이터
		var chartData1 = [];		
		
		//스트링 형식으로 레이아웃 정의.
		var layoutStr2 = 
			'<rMateChart backgroundColor="#FFFFFF"  borderThickness="1" borderStyle="none">'
			  +'<Options>'
			   +'<Caption text="" />'
			  +'</Options>'
			  +'<NumberFormatter id="numFmt" precision="0"/>'
			  +'<Line2DChart showDataTips="true" dataTipDisplayMode="axis" paddingTop="0">'
			   +'<horizontalAxis>'
			    +'<CategoryAxis title="" categoryField="weeklyNm"/>'
			   +'</horizontalAxis>'
			   +'<verticalAxis>'
				+'<LinearAxis title="" formatter="{numFmt}"/>'
				+'</verticalAxis>'
			   +'<series>'
			    +'<Line2DSeries yField="col0000000001" displayName="aT화훼공판장(양재동)" itemRenderer="CircleItemRenderer" radius="4">'
			     +'<showDataEffect>'
			      + '<SeriesClip duration="1000"/>'
			     +'</showDataEffect>'
			    +'</Line2DSeries>'
			    +'<Line2DSeries yField="col1288202296" displayName="한국화훼농협(과천)" itemRenderer="CircleItemRenderer" radius="4">'
			     +'<showDataEffect>'
			     	+'<SeriesClip duration="1000"/>'
			     +'</showDataEffect>'
			    +'</Line2DSeries>'
			    +'<Line2DSeries yField="col1508500020" displayName="부산화훼공판장(엄궁동)" itemRenderer="CircleItemRenderer" radius="4">'
			     +'<showDataEffect>'
			      + '<SeriesClip duration="1000"/>'
			     +'</showDataEffect>'
			    +'</Line2DSeries>'
			    +'<Line2DSeries yField="col3848200087" displayName="한국화훼농협(음성)" itemRenderer="CircleItemRenderer" radius="4">'
			     +'<showDataEffect>'
			      + '<SeriesClip duration="1000"/>'
			     +'</showDataEffect>'
			    +'</Line2DSeries>'
			    +'<Line2DSeries yField="col4108212335" displayName="광주원예농협(풍암)" itemRenderer="CircleItemRenderer" radius="4">'
			     +'<showDataEffect>'
			      + '<SeriesClip duration="1000"/>'
			     +'</showDataEffect>'
			    +'</Line2DSeries>'
			    +'<Line2DSeries yField="col6068207466" displayName="부산경남화훼공판장(강동동)" itemRenderer="CircleItemRenderer" radius="4">'
			     +'<showDataEffect>'
			      + '<SeriesClip duration="1000"/>'
			     +'</showDataEffect>'
			    +'</Line2DSeries>'
			   +'</series>'
			   +'<annotationElements>'
			    +'<CrossRangeZoomer enableZooming="false" horizontalLabelFormatter="{numFmt}" horizontalStrokeEnable="false"/>'
			   +'</annotationElements>'
			  +'</Line2DChart>'
			 +'</rMateChart>';
	 
		// 차트 데이터
		var chartData2 = [];
		
		//스트링 형식으로 레이아웃 정의.
		var layoutStr3 = 
	     '<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'
	         +'<Options>'
	             +'<Caption text=""/>'
	         +'</Options>'
	         +'<Pie2DChart showDataTips="true">'
	             +'<series>'
	                 +'<Pie2DSeries nameField="marketName" field="totQty" labelField="per" startAngle="-90" renderDirection="clockwise" labelPosition="inside" fontSize="20" color="#ffffff" fillJsFunction="fillJsFunc">'
			             +'<showDataEffect>'
	                         +'<SeriesSlide duration="1000"/>'
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
	
		//차트 데이터
		var chartData3 = [];		
		
		//스트링 형식으로 레이아웃 정의.
		var layoutStr4 = 
			'<rMateChart backgroundColor="#FFFFFF"  borderThickness="1" borderStyle="none">'
			  +'<Options>'
			   +'<Caption text="" />'
			  +'</Options>'
			  +'<NumberFormatter id="numFmt" precision="0"/>'
			  +'<Line2DChart showDataTips="true" dataTipDisplayMode="axis" paddingTop="0">'
			   +'<horizontalAxis>'
			    +'<CategoryAxis title="" categoryField="weeklyNm"/>'
			   +'</horizontalAxis>'
			   +'<verticalAxis>'
				+'<LinearAxis title="" formatter="{numFmt}"/>'
				+'</verticalAxis>'
			   +'<series>'
			    +'<Line2DSeries yField="col0000000001" displayName="aT화훼공판장(양재동)" itemRenderer="CircleItemRenderer" radius="4">'
			     +'<showDataEffect>'
			      + '<SeriesClip duration="1000"/>'
			     +'</showDataEffect>'
			    +'</Line2DSeries>'
			    +'<Line2DSeries yField="col1288202296" displayName="한국화훼농협(과천)" itemRenderer="CircleItemRenderer" radius="4">'
			     +'<showDataEffect>'
			     	+'<SeriesClip duration="1000"/>'
			     +'</showDataEffect>'
			    +'</Line2DSeries>'
			    +'<Line2DSeries yField="col1508500020" displayName="부산화훼공판장(엄궁동)" itemRenderer="CircleItemRenderer" radius="4">'
			     +'<showDataEffect>'
			      + '<SeriesClip duration="1000"/>'
			     +'</showDataEffect>'
			    +'</Line2DSeries>'
			    +'<Line2DSeries yField="col3848200087" displayName="한국화훼농협(음성)" itemRenderer="CircleItemRenderer" radius="4">'
			     +'<showDataEffect>'
			      + '<SeriesClip duration="1000"/>'
			     +'</showDataEffect>'
			    +'</Line2DSeries>'
			    +'<Line2DSeries yField="col4108212335" displayName="광주원예농협(풍암)" itemRenderer="CircleItemRenderer" radius="4">'
			     +'<showDataEffect>'
			      + '<SeriesClip duration="1000"/>'
			     +'</showDataEffect>'
			    +'</Line2DSeries>'
			    +'<Line2DSeries yField="col6068207466" displayName="부산경남화훼공판장(강동동)" itemRenderer="CircleItemRenderer" radius="4">'
			     +'<showDataEffect>'
			      + '<SeriesClip duration="1000"/>'
			     +'</showDataEffect>'
			    +'</Line2DSeries>'
			   +'</series>'
			   +'<annotationElements>'
			    +'<CrossRangeZoomer enableZooming="false" horizontalLabelFormatter="{numFmt}" horizontalStrokeEnable="false"/>'
			   +'</annotationElements>'
			  +'</Line2DChart>'
			 +'</rMateChart>';
	 
		// 차트 데이터
		var chartData4 = [];
		
		//스트링 형식으로 레이아웃 정의.
		var layoutStr5 = 
	     '<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'
	         +'<Options>'
	             +'<Caption text=""/>'
	         +'</Options>'
	         +'<Pie2DChart showDataTips="true">'
	             +'<series>'
	                 +'<Pie2DSeries nameField="marketName" field="totQty" labelField="per" startAngle="-90" renderDirection="clockwise" labelPosition="inside" fontSize="20" color="#ffffff" fillJsFunction="fillJsFunc">'
			             +'<showDataEffect>'
	                         +'<SeriesSlide duration="1000"/>'
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
	
		//차트 데이터
		var chartData5 = [];		
		
		//스트링 형식으로 레이아웃 정의.
		var layoutStr6 = 
			'<rMateChart backgroundColor="#FFFFFF"  borderThickness="1" borderStyle="none">'
			  +'<Options>'
			   +'<Caption text="" />'
			  +'</Options>'
			  +'<NumberFormatter id="numFmt" precision="0"/>'
			  +'<Line2DChart showDataTips="true" dataTipDisplayMode="axis" paddingTop="0">'
			   +'<horizontalAxis>'
			    +'<CategoryAxis title="" categoryField="weeklyNm"/>'
			   +'</horizontalAxis>'
			   +'<verticalAxis>'
				+'<LinearAxis title="" formatter="{numFmt}"/>'
				+'</verticalAxis>'
			   +'<series>'
			    +'<Line2DSeries yField="col0000000001" displayName="aT화훼공판장(양재동)" itemRenderer="CircleItemRenderer" radius="4">'
			     +'<showDataEffect>'
			      + '<SeriesClip duration="1000"/>'
			     +'</showDataEffect>'
			    +'</Line2DSeries>'
			    +'<Line2DSeries yField="col1288202296" displayName="한국화훼농협(과천)" itemRenderer="CircleItemRenderer" radius="4">'
			     +'<showDataEffect>'
			     	+'<SeriesClip duration="1000"/>'
			     +'</showDataEffect>'
			    +'</Line2DSeries>'
			    +'<Line2DSeries yField="col1508500020" displayName="부산화훼공판장(엄궁동)" itemRenderer="CircleItemRenderer" radius="4">'
			     +'<showDataEffect>'
			      + '<SeriesClip duration="1000"/>'
			     +'</showDataEffect>'
			    +'</Line2DSeries>'
			    +'<Line2DSeries yField="col3848200087" displayName="한국화훼농협(음성)" itemRenderer="CircleItemRenderer" radius="4">'
			     +'<showDataEffect>'
			      + '<SeriesClip duration="1000"/>'
			     +'</showDataEffect>'
			    +'</Line2DSeries>'
			    +'<Line2DSeries yField="col4108212335" displayName="광주원예농협(풍암)" itemRenderer="CircleItemRenderer" radius="4">'
			     +'<showDataEffect>'
			      + '<SeriesClip duration="1000"/>'
			     +'</showDataEffect>'
			    +'</Line2DSeries>'
			    +'<Line2DSeries yField="col6068207466" displayName="부산경남화훼공판장(강동동)" itemRenderer="CircleItemRenderer" radius="4">'
			     +'<showDataEffect>'
			      + '<SeriesClip duration="1000"/>'
			     +'</showDataEffect>'
			    +'</Line2DSeries>'
			   +'</series>'
			   +'<annotationElements>'
			    +'<CrossRangeZoomer enableZooming="false" horizontalLabelFormatter="{numFmt}" horizontalStrokeEnable="false"/>'
			   +'</annotationElements>'
			  +'</Line2DChart>'
			 +'</rMateChart>';
	 
		// 차트 데이터
		var chartData6 = [];
		
		// 파이차트 색상
		function fillJsFunc(seriesId, index, data, values){
			
			if(data.cmpCd == "0000000001"){	//aT화훼공판장(양재동)
				return "#b73530";
			}else if(data.cmpCd == "1288202296"){	//한국화훼농협(과천)
				return "#95637f";
			}else if(data.cmpCd == "1508500020"){	//부산화훼공판장(엄궁동)
				return "#d98960";
			}else if(data.cmpCd == "3848200087"){	//한국화훼농협(음성)
				return "#5f9ba2";
			}else if(data.cmpCd == "4108212335"){	//광주원예농협(풍암)
				return "#2c4553";
			}else if(data.cmpCd == "6068207466"){	//부산경남화훼공판장(강동동)
				return "#0096b0";
			}
			
		}
				
		// -----------------------차트 설정 끝 ----------------------- 
	   
		var fnObj = {
	    	pageStart: function(){
	    		//datepicker				
	    	   	$("#datepicker").datepicker({
					showOn: "button",
				    buttonImage: "../images/2020/ico_date_02.png",
				    buttonImageOnly: true,
					todayHighlight: true,
					autoclose: true,
					showMonthAfterYear: true,
			        dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
			        monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
					language: 'kr',
					dateFormat: 'yy-mm-dd',
					/* beforeShowDay:datechktoday, */
					yearSuffix: '년',
					changeMonth: true,
			        changeYear: true,
					beforeShowDay: function(date){	        	
			        	
			        	var day = date.getDay();			
			        	
			        	if(date > new Date())
							return [false];
			        	
			        	return [(day == 1 || day == 3 || day == 5)];			        				
					},
					onSelect: function(selectedDate){
						buttonEvent(selectedDate);
					}
				});
	       }
		};  	
		
		function datechktoday(date){
		   if(date > new Date())
		    return [false];
		    return [true];
		    
		}
		
	</script>
	
	<script type="text/javascript">
	
	 	window.dataLayer = window.dataLayer || [];
	  	function gtag(){dataLayer.push(arguments);}
	  	gtag('js', new Date());
	
	  	gtag('config', 'UA-124845654-1');
	  
	 	history.replaceState({}, null, location.pathname);
		
		$(document).ready(function(){
			fnObj.pageStart();
			
			// 공지사항 목록 로딩
			//gongi(1,3);
			
			// 메인 메뉴 목록 로딩
			//noLoginMainMenu();
			
			//최초 절화 검색
			//getSaledate("1");
			getFirstSaledate();
			hfc01Event();
			
			$("#messageButtom").hide();		
			
			
			// WEB 부류선택 선택			
			$(".tab li a").click(function(){
				
				var flowerCd = $(this).parent().children("input").attr("value");
				
				var searchDate =  $("#datepicker").val();
				datepickerCreate(flowerCd);
				
				if(flowerCd == "1"){//절화
					
					if(chartData1.length == 0){
						getSaledate(flowerCd);
					}else{
						if(chartDate1 != searchDate){
							$("#datepicker").val(chartDate1);
						}
						
						chartReadyHandler1("chart1");
						chartReadyHandler2("chart2");
						
					}
				}else if(flowerCd == "3"){//난
					
					if(chartData3.length == 0){
						getSaledate(flowerCd);
					}else{
						if(chartDate2 != searchDate){
							$("#datepicker").val(chartDate2);
						}
						
						chartReadyHandler3("chart3");
						chartReadyHandler4("chart4");
						
					}				
				}else if(flowerCd == "2"){//관엽
					
					if(chartData5.length == 0){
						getSaledate(flowerCd);
					}else{
						if(chartDate3 != searchDate){
							$("#datepicker").val(chartDate3);
						}
						chartReadyHandler5("chart5");
						chartReadyHandler6("chart6");
						
					}
				}
								
				//return false;
			});
			
			
			//calendar			
	        var $ca = $('#main_calendar').calendar({
	            width: 263,
	            height: 206,
	        	prev: '',
	        	next: '',
	        	weekArray: ['S', 'M', 'T', 'W', 'T', 'F', 'S'],
	        	monthArray: ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'],
	          	date: new Date("${searchSaleDate}")	            
	        });
			
		});
		
		/* function gongi(startPageNo, endPageNo){
			$.ajax({
				type : "post",
				url : "/main/flowerMain_gongi.json",
				data : {
					startPageNo : startPageNo,
					endPageNo : endPageNo
				},
				dataType : '',
				success : function(res){
					var val = res.result;
					var html='';
					for(var i=0; i<val.length; i++){					
						html+='<li>';
						html+="<a href='/hfa01/hfa01.do?seq="+val[i].seq1+"&seqNum="+val[i].seq1+"'>";
						html+='<strong class="tit">'+val[i].title1+'</strong>';
						html+='<span class="day">'+val[i].insDt+'</span>';
						html+='</a>';
						html+='</li>';					
					}
					$("#gongi").append(html);
				}
			});
		} */
		
		// 본인 설정메뉴, 관리자 설정 메뉴
		/*
		function noLoginMainMenu(){
			$.ajax({
				type : "post",
				url : "/main/selectNoLoginMenuList.json",
				data : {},
				dataType : '',
				success : function(res){
					if(res.userList!=null){
						var val = res.userList;
						if(val.length != 0){
							$("#visualList").empty();
							var html='';
							
							for(var i=0; i<val.length; i++){					
								html+='<li class=li0'+val[i].MENU_ORDER+'><a href='+val[i].MENU_URL+'>'+val[i].MENU_NM+'</a></li>';
							}
							$("#visualList").append(html);	
						}
					}else{
						var val = res.list;
						if(val.length != 0){
							$("#visualList").empty();
							var html='';
							
							for(var i=0; i<val.length; i++){					
								html+='<li class=li0'+(i+1)+'><a href='+val[i].menuUrl+'>'+val[i].menuNm+'</a></li>';
							}
							$("#visualList").append(html);	
						}
					}				
				}
			});
		}
		*/
		
		function init(searchProductGubun){
			var flowerCd = "#flowerCd1";
			var cmpCd = "cmpCdBtn1";
			
			if(searchProductGubun == "1"){
				flowerCd = "#flowerCd1";
				cmpCd = "#cmpCdBtn1";
			}else if(searchProductGubun == "3"){
				flowerCd = "#flowerCd2";
				cmpCd = "#cmpCdBtn2";
			}else if(searchProductGubun == "2"){
				flowerCd = "#flowerCd3";
				cmpCd = "#cmpCdBtn3";
			}
						
			$(flowerCd).empty();			
			$(cmpCd).empty();
			
			if(searchProductGubun == "1"){//절화
				// 그래프 초기화
				chartData1 = [];
				
				if(!document.getElementById("chart1")){
					rMateChartH5.create("chart1", "chartHolder1", chartVars1, "100%", "100%");  
				 } else{
					chartReadyHandler1("chart1");
				}
				
				// 그래프 초기화				
				chartData2= [];
				
				if(!document.getElementById("chart2")){
					rMateChartH5.create("chart2", "chartHolder2", chartVars2, "100%", "100%"); 
				 } else{
					chartReadyHandler2("chart2");
				} 
			}else if(searchProductGubun == "3"){//난
				// 그래프 초기화
				chartData3 = [];
				
				if(!document.getElementById("chart3")){
					rMateChartH5.create("chart3", "chartHolder3", chartVars1, "100%", "100%");  
				 } else{
					chartReadyHandler3("chart3");
				}
				
				// 그래프 초기화					
				chartData4= [];
				
				if(!document.getElementById("chart4")){
					rMateChartH5.create("chart4", "chartHolder4", chartVars4, "100%", "100%"); 
				 } else{
					chartReadyHandler4("chart4");
				} 
			}else if(searchProductGubun == "2"){//관엽
				// 그래프 초기화
				chartData5 = [];
				
				if(!document.getElementById("chart5")){
					rMateChartH5.create("chart5", "chartHolder5", chartVars1, "100%", "100%");  
				 } else{
					chartReadyHandler5("chart5");
				}
				
				// 그래프 초기화					
				chartData6= [];
				
				if(!document.getElementById("chart6")){
					rMateChartH5.create("chart6", "chartHolder6", chartVars6, "100%", "100%"); 
				 } else{
					chartReadyHandler6("chart6");
				} 
			}
			
		}
		
		
		// 최초 호출
		function getFirstSaledate(){
			
			//절화
			$.ajax({
				type : "post",
				url : "/search/selectSaleDateWeekday.json",
				data : {
					searchProductGubun : "1"
				},
				dataType : '',
				success : function(res){
					var val = res.list;
					if(res.list!=null && res.list.length > 0){
												
						var begins=val[0].SALE_DATE;
						if(begins!=''&&begins!=''){
							$('#datepicker').val(val[0].SALE_DATE);
						}else{
							$('#datepicker').val("${searchSaleDate}");
							begins = "${searchSaleDate}";
						}
						
						// 품목조회
						buttonEvent(begins, "1");
					}else{
						// 데이터 없음
						$('#datepicker').val("${searchSaleDate}");
								
						
						buttonEvent("${searchSaleDate}", "1");
					}
				}
			});
			
			//난
			$.ajax({
				type : "post",
				url : "/search/selectSaleDateWeekday.json",
				data : {
					searchProductGubun : "3"
				},
				dataType : '',
				success : function(res){
					var val = res.list;
					if(res.list!=null && res.list.length > 0){
												
						var begins=val[0].SALE_DATE;
						if(begins!=''&&begins!=''){
							chartDate2 = val[0].SALE_DATE;
						}else{
							chartDate2 = "${searchSaleDate}";
						}
						
						// 품목조회
						buttonEvent(chartDate2, "3");
					}
				}
			});
			
			//관엽
			$.ajax({
				type : "post",
				url : "/search/selectSaleDateWeekday.json",
				data : {
					searchProductGubun : "2"
				},
				dataType : '',
				success : function(res){
					var val = res.list;
					if(res.list!=null && res.list.length > 0){
												
						var begins=val[0].SALE_DATE;
						if(begins!=''&&begins!=''){
							chartDate3 = val[0].SALE_DATE;
						}else{
							chartDate3 = "${searchSaleDate}";
						}
						
						// 품목조회
						buttonEvent(chartDate3, "2");
					}
				}
			});
		}
		
		
		//일자 조회
		function getSaledate(flowerCd){
			$.ajax({
				type : "post",
				url : "/search/selectSaleDateWeekday.json",
				data : {
					searchProductGubun : flowerCd
				},
				dataType : '',
				success : function(res){
					var val = res.list;
					if(res.list!=null && res.list.length > 0){
												
						var begins=val[0].SALE_DATE;
						if(begins!=''&&begins!=''){
							$('#datepicker').val(val[0].SALE_DATE);
						}else{
							$('#datepicker').val("${searchSaleDate}");
							begins = "${searchSaleDate}";
						}
						
						// 품목조회
						buttonEvent(begins, flowerCd);
					}else{
						// 데이터 없음
						$('#datepicker').val("${searchSaleDate}");
								
						
						buttonEvent("${searchSaleDate}", flowerCd);
					}
				}
			});
		}
		
		
		//일자별 품종
		function buttonEvent(selectedDate, productGubun){
			
			var searchDate = selectedDate;
			var searchProductGubun = "";
			
			if(typeof productGubun == "undefined" || productGubun == null || productGubun == ""){
				searchProductGubun = $("#tab .on > input").attr("value");
			}else{
				searchProductGubun = productGubun;
			}
			
			$.ajax({
				url: "/main/hab01Button.json",
				dataType: 'json',
				type : "post",
				data: {
					searchDate: searchDate,
					searchProductGubun: searchProductGubun
				}, 
				success: function (result) {
					var flowerCd = "#flowerCd1";
					
					if(searchProductGubun == "1"){
						flowerCd = "#flowerCd1";
						chartDate1 = searchDate;
					}else if(searchProductGubun == "3"){
						flowerCd = "#flowerCd2";
						chartDate2 = searchDate;
					}else if(searchProductGubun == "2"){
						flowerCd = "#flowerCd3";
						chartDate3 = searchDate;
					}
					
										
					if(result.list!=null && result.list.length > 0){
						$(flowerCd).empty();
						
						for(var i=0;i<result.list.length;i++){
							if(i == 0){
								$(flowerCd).append('<li class="c_on"><a href="#"><input type="hidden" value="'+result.list[i].pumCode+'"/>'+result.list[i].pumName+'</a></li>');
								
							}else{
								$(flowerCd).append('<li><a href="#"><input type="hidden" value="'+result.list[i].pumCode+'"/>'+result.list[i].pumName+'</a></li>');
							}
						}
						
						$(flowerCd+" li a").click(function(){
							$(flowerCd+" li").each(function(index, item){
								$(item).removeClass("c_on");
							});
							
							$(this).parent().addClass("c_on");
							
							hab08Chart1(selectedDate, searchProductGubun, $(this).children("input").val());
							hab08Chart2(selectedDate, searchProductGubun, $(this).children("input").val());
							
							return false;
						});
						
						
						hab08Chart1(selectedDate, searchProductGubun, result.list[0].pumCode);
						hab08Chart2(selectedDate, searchProductGubun, result.list[0].pumCode);
					}else{
						alert("해당일자에 데이터가 없습니다.");
						init(searchProductGubun);
					}
					
					
				},
				error:function(xhr, textStatus, error){
					alert("알수없는 오류가 발생하였습니다.\n관리자에게 문의해 주시기 바랍니다.");
					return false;
				}
			});
		}
		
		// 물량비중
		function hab08Chart1(selectedDate, productGubun, itemCd){		
			var searchDate = selectedDate;
		    var searchProductGubun = "";
		    var searchItemCd = itemCd;
			
			if(typeof productGubun == "undefined" || productGubun == null || productGubun == ""){
				searchProductGubun = $("#tab .on > input").attr("value");
			}else{
				searchProductGubun = productGubun;
			}
			
			$.ajax({
				type : "post",
				url : "/main/hab01Chart1.json",
				data : {
	    			searchDate : searchDate,
	    			searchProductGubun : searchProductGubun,
	    			searchItemCd : searchItemCd
	    		},
				dataType : '',
				success : function(res){
					
					if(res.list!=null && res.list.length > 0){
						
						if(searchProductGubun == "1"){//절화
							chartData1 = res.list;							
							
							chartReadyHandler1("chart1");
							
						}else if(searchProductGubun == "3"){//난
							chartData3 = res.list;							
							
							chartReadyHandler3("chart3");
							
						}else if(searchProductGubun == "2"){//관엽
							chartData5 = res.list;							
							
							chartReadyHandler5("chart5");
							
						}						
						
						
					}else{					
						if(searchProductGubun == "1"){//절화
							// 그래프 초기화
							chartData1 = [];
							
							if(!document.getElementById("chart1")){
								rMateChartH5.create("chart1", "chartHolder1", chartVars1, "100%", "100%");  
							 } else{
								chartReadyHandler1("chart1");
							}
						}else if(searchProductGubun == "3"){//난
							// 그래프 초기화
							chartData3 = [];
							
							if(!document.getElementById("chart3")){
								rMateChartH5.create("chart3", "chartHolder3", chartVars1, "100%", "100%");  
							 } else{
								chartReadyHandler3("chart3");
							}
						}else if(searchProductGubun == "2"){//관엽
							// 그래프 초기화
							chartData5 = [];
							
							if(!document.getElementById("chart5")){
								rMateChartH5.create("chart5", "chartHolder5", chartVars1, "100%", "100%");  
							 } else{
								chartReadyHandler5("chart5");
							}
						}						
						
					}
					
				}
			});		
			
		}
		
		// 일자별 평균단가
		function hab08Chart2(selectedDate, productGubun, itemCd){
			var searchDate = selectedDate;
			var searchProductGubun = "";
			var searchItemCd = itemCd;
			
			if(typeof productGubun == "undefined" || productGubun == null || productGubun == ""){
				searchProductGubun = $("#tab .on > input").attr("value");
			}else{
				searchProductGubun = productGubun;
			}
			
			$.ajax({
				type : "post",
				url : "/main/hab01Chart2.json",
				data : {
	    			searchDate : searchDate,
	    			searchProductGubun : searchProductGubun,
	    			searchItemCd : searchItemCd
	    		},
				dataType : '',
				success : function(res){					
					
					if(res.list!=null && res.list.length > 0){
						if(searchProductGubun == "1"){//절화
							// 차트 가변
							layoutStr2 = 
								'<rMateChart backgroundColor="#FFFFFF"  borderThickness="1" borderStyle="none">'
									+'<Options>'
										+'<Caption text="" />'
									+'</Options>'
									+'<NumberFormatter id="numFmt" precision="0"/>'
									+'<Line2DChart showDataTips="true" dataTipDisplayMode="axis" paddingTop="0">'
										+'<horizontalAxis>'
										//	+'<CategoryAxis title="일자" categoryField="weeklyNm"/>'
											+'<CategoryAxis title="" categoryField="saleDate"/>'
										+'</horizontalAxis>'
										+'<verticalAxis>'
											+'<LinearAxis title="" formatter="{numFmt}"/>'
										+'</verticalAxis>'
										+'<series>';
							
							var col0000000001 = "0";
							var col1288202296 = "0";
							var col1508500020 = "0";
							var col3848200087 = "0";
							var col4108212335 = "0";
							var col6068207466 = "0";
							
							for(var i=0;i<res.list.length;i++){
								if(res.list[i].col0000000001 > 0){
									col0000000001++;
								}
								if(res.list[i].col1288202296 > 0){
									col1288202296++;
								}
								if(res.list[i].col1508500020 > 0){
									col1508500020++;
								}
								if(res.list[i].col3848200087 > 0){
									col3848200087++;
								}
								if(res.list[i].col4108212335 > 0){
									col4108212335++;
								}
								if(res.list[i].col6068207466 > 0){
									col6068207466++;
								}
								
							}
							
							if(col0000000001 == res.list.length){
								
								layoutStr2 +=''
											+'<Line2DSeries yField="col0000000001" displayName="aT화훼공판장(양재동)" fill="#ffffff" itemRenderer="CircleItemRenderer" radius="4">'
												+'<lineStroke>'
		                                        	+'<Stroke color="#b73530" weight="2"/>'
		                                    	+'</lineStroke>'
		                                    	+'<stroke>'
		                                        	+'<Stroke color="#b73530" weight="2"/>'
		                                    	+'</stroke>'
												+'<showDataEffect>'
													+'<SeriesClip duration="1000"/>'
												+'</showDataEffect>'
											+'</Line2DSeries>';
							}
							if(col1288202296 == res.list.length){
								
								layoutStr2 +=''
											+'<Line2DSeries yField="col1288202296" displayName="한국화훼농협(과천)" fill="#ffffff" itemRenderer="CircleItemRenderer" radius="4">'
												+'<lineStroke>'
                                        			+'<Stroke color="#95637f" weight="2"/>'
                                    			+'</lineStroke>'	
                                    			+'<stroke>'
	                                        		+'<Stroke color="#95637f" weight="2"/>'
	                                    		+'</stroke>'
												+'<showDataEffect>'
													+'<SeriesClip duration="1000"/>'
												+'</showDataEffect>'
											+'</Line2DSeries>';
							}
							if(col1508500020 == res.list.length){
								
								layoutStr2 +=''
											+'<Line2DSeries yField="col1508500020" displayName="부산화훼공판장(엄궁동)" fill="#ffffff" itemRenderer="CircleItemRenderer" radius="4">'
												+'<lineStroke>'
		                                			+'<Stroke color="#d98960" weight="2"/>'
		                            			+'</lineStroke>'	
		                            			+'<stroke>'
                                        			+'<Stroke color="#d98960" weight="2"/>'
                                    			+'</stroke>'
												+'<showDataEffect>'
													+'<SeriesClip duration="1000"/>'
												+'</showDataEffect>'
											+'</Line2DSeries>';
							}
							if(col3848200087 == res.list.length){
								
								layoutStr2 +=''
											+'<Line2DSeries yField="col3848200087" displayName="한국화훼농협(음성)" fill="#ffffff" itemRenderer="CircleItemRenderer" radius="4">'
												+'<lineStroke>'
		                                			+'<Stroke color="#5f9ba2" weight="2"/>'
		                            			+'</lineStroke>'	
		                            			+'<stroke>'
                                    				+'<Stroke color="#5f9ba2" weight="2"/>'
                                				+'</stroke>'
												+'<showDataEffect>'
													+'<SeriesClip duration="1000"/>'
												+'</showDataEffect>'
											+'</Line2DSeries>';
							}
							if(col4108212335 == res.list.length){
								
								layoutStr2 +=''
											+'<Line2DSeries yField="col4108212335" displayName="광주원예농협(풍암)" fill="#ffffff" itemRenderer="CircleItemRenderer" radius="4">'
												+'<lineStroke>'
		                                			+'<Stroke color="#2c4553" weight="2"/>'
		                            			+'</lineStroke>'	
		                            			+'<stroke>'
                                					+'<Stroke color="#2c4553" weight="2"/>'
                            					+'</stroke>'
												+'<showDataEffect>'
													+'<SeriesClip duration="1000"/>'
												+'</showDataEffect>'
											+'</Line2DSeries>';
							}
							if(col6068207466 == res.list.length){
								
								layoutStr2 +=''
											+'<Line2DSeries yField="col6068207466" displayName="부산경남화훼공판장(강동동)" fill="#ffffff" itemRenderer="CircleItemRenderer" radius="4">'
												+'<lineStroke>'
		                                			+'<Stroke color="#0096b0" weight="2"/>'
		                            			+'</lineStroke>'
		                            			+'<stroke>'
                            						+'<Stroke color="#0096b0" weight="2"/>'
                        						+'</stroke>'
												+'<showDataEffect>'
													+'<SeriesClip duration="1000"/>'
												+'</showDataEffect>'
											+'</Line2DSeries>';
							}
														    
							layoutStr2 += ''
										+'</series>'
										+'<annotationElements>'
											+'<CrossRangeZoomer enableZooming="false" horizontalLabelFormatter="{numFmt}" horizontalStrokeEnable="false"/>'
										+'</annotationElements>'
									+'</Line2DChart>'
								+'</rMateChart>';
							
							
							chartData2 = res.list;
							
							//rMateChartH5.call("chart2", "setLayout", layoutStr2);
							//rMateChartH5.call("chart2", "setData", chartData2);
							chartReadyHandler2("chart2");
															
							$("#cmpCdBtn1").empty();
							
							if(col0000000001 == res.list.length){
								$("#cmpCdBtn1").append('<li><img src="../images/2020/tab_btn01.png" alt="">aT화훼공판장 (양재동)</li>');	
							}
							if(col1288202296 == res.list.length){
								$("#cmpCdBtn1").append('<li><img src="../images/2020/tab_btn06.png" alt="">한국화훼농협 (과천)</li>');
							}
							if(col1508500020 == res.list.length){
								$("#cmpCdBtn1").append('<li><img src="../images/2020/tab_btn02.png" alt="">부산화훼공판장 (엄궁동)</li>');
							}
							if(col3848200087 == res.list.length){
								$("#cmpCdBtn1").append('<li><img src="../images/2020/tab_btn05.png" alt="">한국화훼농협 (음성)</li>');
							}
							if(col4108212335 == res.list.length){
								$("#cmpCdBtn1").append('<li><img src="../images/2020/tab_btn04.png" alt="">광주원예농협 (풍암)</li>');
							}
							if(col6068207466 == res.list.length){
								$("#cmpCdBtn1").append('<li><img src="../images/2020/tab_btn03.png" alt="">부산경남화훼농협 (강동동)</li>');
							}								
							
							
						}else if(searchProductGubun == "3"){//난
							// 차트 가변
							layoutStr4 = 
								'<rMateChart backgroundColor="#FFFFFF"  borderThickness="1" borderStyle="none">'
									+'<Options>'
										+'<Caption text="" />'
									+'</Options>'
									+'<NumberFormatter id="numFmt" precision="0"/>'
									+'<Line2DChart showDataTips="true" dataTipDisplayMode="axis" paddingTop="0">'
										+'<horizontalAxis>'
										//	+'<CategoryAxis title="일자" categoryField="weeklyNm"/>'
											+'<CategoryAxis title="" categoryField="saleDate"/>'
										+'</horizontalAxis>'
										+'<verticalAxis>'
											+'<LinearAxis title="" formatter="{numFmt}"/>'
										+'</verticalAxis>'
										+'<series>';
							
							var col0000000001 = "0";
							var col1288202296 = "0";
							var col1508500020 = "0";
							var col3848200087 = "0";
							var col4108212335 = "0";
							var col6068207466 = "0";
							
							for(var i=0;i<res.list.length;i++){
								if(res.list[i].col0000000001 > 0){
									col0000000001++;
								}
								if(res.list[i].col1288202296 > 0){
									col1288202296++;
								}
								if(res.list[i].col1508500020 > 0){
									col1508500020++;
								}
								if(res.list[i].col3848200087 > 0){
									col3848200087++;
								}
								if(res.list[i].col4108212335 > 0){
									col4108212335++;
								}
								if(res.list[i].col6068207466 > 0){
									col6068207466++;
								}
								
							}
							
							if(col0000000001 == res.list.length){
								
								layoutStr4 +=''
											+'<Line2DSeries yField="col0000000001" displayName="aT화훼공판장(양재동)" fill="#ffffff" itemRenderer="CircleItemRenderer" radius="4">'
												+'<lineStroke>'
		                                        	+'<Stroke color="#b73530" weight="2"/>'
		                                    	+'</lineStroke>'
		                                    	+'<stroke>'
		                                        	+'<Stroke color="#b73530" weight="2"/>'
		                                    	+'</stroke>'
												+'<showDataEffect>'
													+'<SeriesClip duration="1000"/>'
												+'</showDataEffect>'
											+'</Line2DSeries>';
							}
							if(col1288202296 == res.list.length){
								
								layoutStr4 +=''
											+'<Line2DSeries yField="col1288202296" displayName="한국화훼농협(과천)" fill="#ffffff" itemRenderer="CircleItemRenderer" radius="4">'
												+'<lineStroke>'
                                        			+'<Stroke color="#95637f" weight="2"/>'
                                    			+'</lineStroke>'	
                                    			+'<stroke>'
	                                        		+'<Stroke color="#95637f" weight="2"/>'
	                                    		+'</stroke>'
												+'<showDataEffect>'
													+'<SeriesClip duration="1000"/>'
												+'</showDataEffect>'
											+'</Line2DSeries>';
							}
							if(col1508500020 == res.list.length){
								
								layoutStr4 +=''
											+'<Line2DSeries yField="col1508500020" displayName="부산화훼공판장(엄궁동)" fill="#ffffff" itemRenderer="CircleItemRenderer" radius="4">'
												+'<lineStroke>'
		                                			+'<Stroke color="#d98960" weight="2"/>'
		                            			+'</lineStroke>'	
		                            			+'<stroke>'
                                        			+'<Stroke color="#d98960" weight="2"/>'
                                    			+'</stroke>'
												+'<showDataEffect>'
													+'<SeriesClip duration="1000"/>'
												+'</showDataEffect>'
											+'</Line2DSeries>';
							}
							if(col3848200087 == res.list.length){
								
								layoutStr4 +=''
											+'<Line2DSeries yField="col3848200087" displayName="한국화훼농협(음성)" fill="#ffffff" itemRenderer="CircleItemRenderer" radius="4">'
												+'<lineStroke>'
		                                			+'<Stroke color="#5f9ba2" weight="2"/>'
		                            			+'</lineStroke>'	
		                            			+'<stroke>'
                                    				+'<Stroke color="#5f9ba2" weight="2"/>'
                                				+'</stroke>'
												+'<showDataEffect>'
													+'<SeriesClip duration="1000"/>'
												+'</showDataEffect>'
											+'</Line2DSeries>';
							}
							if(col4108212335 == res.list.length){
								
								layoutStr4 +=''
											+'<Line2DSeries yField="col4108212335" displayName="광주원예농협(풍암)" fill="#ffffff" itemRenderer="CircleItemRenderer" radius="4">'
												+'<lineStroke>'
		                                			+'<Stroke color="#2c4553" weight="2"/>'
		                            			+'</lineStroke>'	
		                            			+'<stroke>'
                                					+'<Stroke color="#2c4553" weight="2"/>'
                            					+'</stroke>'
												+'<showDataEffect>'
													+'<SeriesClip duration="1000"/>'
												+'</showDataEffect>'
											+'</Line2DSeries>';
							}
							if(col6068207466 == res.list.length){
								
								layoutStr4 +=''
											+'<Line2DSeries yField="col6068207466" displayName="부산경남화훼공판장(강동동)" fill="#ffffff" itemRenderer="CircleItemRenderer" radius="4">'
												+'<lineStroke>'
		                                			+'<Stroke color="#0096b0" weight="2"/>'
		                            			+'</lineStroke>'
		                            			+'<stroke>'
                            						+'<Stroke color="#0096b0" weight="2"/>'
                        						+'</stroke>'
												+'<showDataEffect>'
													+'<SeriesClip duration="1000"/>'
												+'</showDataEffect>'
											+'</Line2DSeries>';
							}
														    
							layoutStr4 += ''
										+'</series>'
										+'<annotationElements>'
											+'<CrossRangeZoomer enableZooming="false" horizontalLabelFormatter="{numFmt}" horizontalStrokeEnable="false"/>'
										+'</annotationElements>'
									+'</Line2DChart>'
								+'</rMateChart>';
							
							
							chartData4 = res.list;
							
							//rMateChartH5.call("chart4", "setLayout", layoutStr4);
							//rMateChartH5.call("chart4", "setData", chartData4);	
							chartReadyHandler4("chart4");
							
							$("#cmpCdBtn2").empty();	
							
							if(col0000000001 == res.list.length){
								$("#cmpCdBtn2").append('<li><img src="../images/2020/tab_btn01.png" alt="">aT화훼공판장 (양재동)</li>');	
							}
							if(col1288202296 == res.list.length){
								$("#cmpCdBtn2").append('<li><img src="../images/2020/tab_btn06.png" alt="">한국화훼농협 (과천)</li>');
							}
							if(col1508500020 == res.list.length){
								$("#cmpCdBtn2").append('<li><img src="../images/2020/tab_btn02.png" alt="">부산화훼공판장 (엄궁동)</li>');
							}
							if(col3848200087 == res.list.length){
								$("#cmpCdBtn2").append('<li><img src="../images/2020/tab_btn05.png" alt="">한국화훼농협 (음성)</li>');
							}
							if(col4108212335 == res.list.length){
								$("#cmpCdBtn2").append('<li><img src="../images/2020/tab_btn04.png" alt="">광주원예농협 (풍암)</li>');
							}
							if(col6068207466 == res.list.length){
								$("#cmpCdBtn2").append('<li><img src="../images/2020/tab_btn03.png" alt="">부산경남화훼농협 (강동동)</li>');
							}								
							
						}else if(searchProductGubun == "2"){//관엽
							// 차트 가변
							layoutStr6 = 
								'<rMateChart backgroundColor="#FFFFFF"  borderThickness="1" borderStyle="none">'
									+'<Options>'
										+'<Caption text="" />'
									+'</Options>'
									+'<NumberFormatter id="numFmt" precision="0"/>'
									+'<Line2DChart showDataTips="true" dataTipDisplayMode="axis" paddingTop="0">'
										+'<horizontalAxis>'
										//	+'<CategoryAxis title="일자" categoryField="weeklyNm"/>'
											+'<CategoryAxis title="" categoryField="saleDate"/>'
										+'</horizontalAxis>'
										+'<verticalAxis>'
											+'<LinearAxis title="" formatter="{numFmt}"/>'
										+'</verticalAxis>'
										+'<series>';
							
							var col0000000001 = "0";
							var col1288202296 = "0";
							var col1508500020 = "0";
							var col3848200087 = "0";
							var col4108212335 = "0";
							var col6068207466 = "0";
							
							for(var i=0;i<res.list.length;i++){
								if(res.list[i].col0000000001 > 0){
									col0000000001++;
								}
								if(res.list[i].col1288202296 > 0){
									col1288202296++;
								}
								if(res.list[i].col1508500020 > 0){
									col1508500020++;
								}
								if(res.list[i].col3848200087 > 0){
									col3848200087++;
								}
								if(res.list[i].col4108212335 > 0){
									col4108212335++;
								}
								if(res.list[i].col6068207466 > 0){
									col6068207466++;
								}
								
							}
							
							if(col0000000001 == res.list.length){
								
								layoutStr6 +=''
											+'<Line2DSeries yField="col0000000001" displayName="aT화훼공판장(양재동)" fill="#ffffff" itemRenderer="CircleItemRenderer" radius="4">'
												+'<lineStroke>'
		                                        	+'<Stroke color="#b73530" weight="2"/>'
		                                    	+'</lineStroke>'
		                                    	+'<stroke>'
		                                        	+'<Stroke color="#b73530" weight="2"/>'
		                                    	+'</stroke>'
												+'<showDataEffect>'
													+'<SeriesClip duration="1000"/>'
												+'</showDataEffect>'
											+'</Line2DSeries>';
							}
							if(col1288202296 == res.list.length){
								
								layoutStr6 +=''
											+'<Line2DSeries yField="col1288202296" displayName="한국화훼농협(과천)" fill="#ffffff" itemRenderer="CircleItemRenderer" radius="4">'
												+'<lineStroke>'
                                        			+'<Stroke color="#95637f" weight="2"/>'
                                    			+'</lineStroke>'	
                                    			+'<stroke>'
	                                        		+'<Stroke color="#95637f" weight="2"/>'
	                                    		+'</stroke>'
												+'<showDataEffect>'
													+'<SeriesClip duration="1000"/>'
												+'</showDataEffect>'
											+'</Line2DSeries>';
							}
							if(col1508500020 == res.list.length){
								
								layoutStr6 +=''
											+'<Line2DSeries yField="col1508500020" displayName="부산화훼공판장(엄궁동)" fill="#ffffff" itemRenderer="CircleItemRenderer" radius="4">'
												+'<lineStroke>'
		                                			+'<Stroke color="#d98960" weight="2"/>'
		                            			+'</lineStroke>'	
		                            			+'<stroke>'
                                        			+'<Stroke color="#d98960" weight="2"/>'
                                    			+'</stroke>'
												+'<showDataEffect>'
													+'<SeriesClip duration="1000"/>'
												+'</showDataEffect>'
											+'</Line2DSeries>';
							}
							if(col3848200087 == res.list.length){
								
								layoutStr6 +=''
											+'<Line2DSeries yField="col3848200087" displayName="한국화훼농협(음성)" fill="#ffffff" itemRenderer="CircleItemRenderer" radius="4">'
												+'<lineStroke>'
		                                			+'<Stroke color="#5f9ba2" weight="2"/>'
		                            			+'</lineStroke>'	
		                            			+'<stroke>'
                                    				+'<Stroke color="#5f9ba2" weight="2"/>'
                                				+'</stroke>'
												+'<showDataEffect>'
													+'<SeriesClip duration="1000"/>'
												+'</showDataEffect>'
											+'</Line2DSeries>';
							}
							if(col4108212335 == res.list.length){
								
								layoutStr6 +=''
											+'<Line2DSeries yField="col4108212335" displayName="광주원예농협(풍암)" fill="#ffffff" itemRenderer="CircleItemRenderer" radius="4">'
												+'<lineStroke>'
		                                			+'<Stroke color="#2c4553" weight="2"/>'
		                            			+'</lineStroke>'	
		                            			+'<stroke>'
                                					+'<Stroke color="#2c4553" weight="2"/>'
                            					+'</stroke>'
												+'<showDataEffect>'
													+'<SeriesClip duration="1000"/>'
												+'</showDataEffect>'
											+'</Line2DSeries>';
							}
							if(col6068207466 == res.list.length){
								
								layoutStr6 +=''
											+'<Line2DSeries yField="col6068207466" displayName="부산경남화훼공판장(강동동)" fill="#ffffff" itemRenderer="CircleItemRenderer" radius="4">'
												+'<lineStroke>'
		                                			+'<Stroke color="#0096b0" weight="2"/>'
		                            			+'</lineStroke>'
		                            			+'<stroke>'
                            						+'<Stroke color="#0096b0" weight="2"/>'
                        						+'</stroke>'
												+'<showDataEffect>'
													+'<SeriesClip duration="1000"/>'
												+'</showDataEffect>'
											+'</Line2DSeries>';
							}
														    
							layoutStr6 += ''
										+'</series>'
										+'<annotationElements>'
											+'<CrossRangeZoomer enableZooming="false" horizontalLabelFormatter="{numFmt}" horizontalStrokeEnable="false"/>'
										+'</annotationElements>'
									+'</Line2DChart>'
								+'</rMateChart>';
							
							
							chartData6 = res.list;
							
							//rMateChartH5.call("chart6", "setLayout", layoutStr6);
							//rMateChartH5.call("chart6", "setData", chartData6);	
							chartReadyHandler6("chart6");
							
							
							$("#cmpCdBtn3").empty();
							
							if(col0000000001 == res.list.length){
								$("#cmpCdBtn3").append('<li><img src="../images/2020/tab_btn01.png" alt="">aT화훼공판장 (양재동)</li>');	
							}
							if(col1288202296 == res.list.length){
								$("#cmpCdBtn3").append('<li><img src="../images/2020/tab_btn06.png" alt="">한국화훼농협 (과천)</li>');
							}
							if(col1508500020 == res.list.length){
								$("#cmpCdBtn3").append('<li><img src="../images/2020/tab_btn02.png" alt="">부산화훼공판장 (엄궁동)</li>');
							}
							if(col3848200087 == res.list.length){
								$("#cmpCdBtn3").append('<li><img src="../images/2020/tab_btn05.png" alt="">한국화훼농협 (음성)</li>');
							}
							if(col4108212335 == res.list.length){
								$("#cmpCdBtn3").append('<li><img src="../images/2020/tab_btn04.png" alt="">광주원예농협 (풍암)</li>');
							}
							if(col6068207466 == res.list.length){
								$("#cmpCdBtn3").append('<li><img src="../images/2020/tab_btn03.png" alt="">부산경남화훼농협 (강동동)</li>');
							}								
							
						}
											
					    
					}else{				
						if(searchProductGubun == "1"){//절화
							// 그래프 초기화				
							chartData2= [];
							
							if(!document.getElementById("chart2")){
								rMateChartH5.create("chart2", "chartHolder2", chartVars2, "100%", "100%"); 
							 } else{
								chartReadyHandler2("chart2");
							} 
						}else if(searchProductGubun == "3"){//난
							// 그래프 초기화					
							chartData4= [];
							
							if(!document.getElementById("chart4")){
								rMateChartH5.create("chart4", "chartHolder4", chartVars4, "100%", "100%"); 
							 } else{
								chartReadyHandler4("chart4");
							} 
						}else if(searchProductGubun == "2"){//관엽
							// 그래프 초기화					
							chartData6= [];
							
							if(!document.getElementById("chart6")){
								rMateChartH5.create("chart6", "chartHolder6", chartVars6, "100%", "100%"); 
							 } else{
								chartReadyHandler6("chart6");
							} 
						}			
						
					}				
				}
			});
		}
		
						
		
		//기념일
		function hfc01Event(){
			var startDate = "${searchSaleDate}";
			var endDate = "${searchSaleDate}";
			
			$.ajax({
				url: "/hfc01/selectMainList.json",
				dataType: 'json',
				type : "post",
				data: {
					start: startDate,
	                end: endDate
				}, 
				success: function (result) {
					$("#anniversary").empty();
					
					if(result.resultList!=null && result.resultList.length > 0){				
						for(var i=0;i<result.resultList.length;i++){
							
							var img = "";
							
							if(result.resultList[i].EVENT_TYPE == "1"){
								img = '<img src="/images/2020/sub/church_2.png" alt="교회력" style="width: 15px;height: 15px;" > ';
								$("#anniversary").append('<p style="background: '+result.resultList[i].color+';">' + img +result.resultList[i].title + "</p>")
							}else if(result.resultList[i].EVENT_TYPE == "2"){
								img = '<img src="/images/2020/sub/buddhism_2.png" alt="불교" style="width: 15px;height: 15px;"> ';
								$("#anniversary").append('<p style="background: '+result.resultList[i].color+';">' + img +result.resultList[i].title + "</p>")
							}else if(result.resultList[i].EVENT_TYPE == "3"){
								img = '<img src="/images/2020/sub/catholic_2.png" alt="전례력(성당)" style="width: 15px;height: 15px;"> '
								$("#anniversary").append('<p style="background: '+result.resultList[i].color+';">'+ img + result.resultList[i].title + "</p>")
							}else if(result.resultList[i].EVENT_TYPE == "4"){
								img = '<img src="/images/2020/sub/wedding_2.png" alt="주말길일(결혼)" style="width: 15px;height: 15px;"> ';
								$("#anniversary").append('<p style="background: '+result.resultList[i].color+';">'+ img + result.resultList[i].title +"</p>")
							}else if(result.resultList[i].EVENT_TYPE == "5"){
								img = '<img src="/images/2020/sub/etc_2.png" alt="기타행사" style="width: 15px;height: 15px;"> '
								$("#anniversary").append('<p style="background: '+result.resultList[i].color+';">' + img + result.resultList[i].title + "</p>")
							}							
						}
					}else{
						img = '<img src="../images/2020/day_nothing.png" class="nothing_img" alt="스케쥴없음" >'
						$("#anniversary").append(img + '<p class="ment">이벤트가 없습니다.</p>')						
					}
				},
				error:function(xhr, textStatus, error){
					alert("알수없는 오류가 발생하였습니다.\n관리자에게 문의해 주시기 바랍니다.");
					return false;
				}
			});
		}
		
		
		// 달력 컨트롤
		function datepickerCreate(flowerCd){
			
			if(flowerCd == "1"){
				$("#datepicker").datepicker("destroy");
				$("#datepicker").datepicker({
					showOn: "button",
				    buttonImage: "../images/2020/ico_date_02.png",
				    buttonImageOnly: true,
					todayHighlight: true,
					autoclose: true,
					showMonthAfterYear: true,
			        dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
			        monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
					language: 'kr',
					dateFormat: 'yy-mm-dd',
					/* beforeShowDay:datechktoday, */
					yearSuffix: '년',
					changeMonth: true,
			        changeYear: true,
					beforeShowDay: function(date){	        	
			        	
			        	var day = date.getDay();
			        	
			        	if(date > new Date())
							return [false];
			        	
			        	return [(day == 1 || day == 3 || day == 5)];			        				
					},
					onSelect: function(selectedDate){
						buttonEvent(selectedDate);
					}
				});
			}else if(flowerCd == "2"){
				$("#datepicker").datepicker("destroy");
				$("#datepicker").datepicker({
					showOn: "button",
				    buttonImage: "../images/2020/ico_date_02.png",
				    buttonImageOnly: true,
					todayHighlight: true,
					autoclose: true,
					showMonthAfterYear: true,
			        dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
			        monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
					language: 'kr',
					dateFormat: 'yy-mm-dd',
					/* beforeShowDay:datechktoday, */
					yearSuffix: '년',
					changeMonth: true,
			        changeYear: true,
					beforeShowDay: function(date){	        	
			        	
			        	var day = date.getDay();		
			        	
			        	if(date > new Date())
							return [false];
			        	
			        	return [(day == 1 || day == 2)];			        				
					},
					onSelect: function(selectedDate){
						buttonEvent(selectedDate);
					}
				});
			}else if(flowerCd == "3"){
				$("#datepicker").datepicker("destroy");
				$("#datepicker").datepicker({
					showOn: "button",
				    buttonImage: "../images/2020/ico_date_02.png",
				    buttonImageOnly: true,
					todayHighlight: true,
					autoclose: true,
					showMonthAfterYear: true,
			        dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
			        monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
					language: 'kr',
					dateFormat: 'yy-mm-dd',
					/* beforeShowDay:datechktoday, */
					yearSuffix: '년',
					changeMonth: true,
			        changeYear: true,
					beforeShowDay: function(date){	        	
			        	
			        	var day = date.getDay();		
			        	
			        	if(date > new Date())
							return [false];
			        	
			        	return [(day == 1)];			        				
					},
					onSelect: function(selectedDate){
						buttonEvent(selectedDate);
					}
				});
			}		
		}
	
	</script>
	
	
</head>
<body>
	<!--WRAP(S)-->
    <div class="wrap">
    	
		<jsp:include page="../inc/2020/IncHeader.jsp"/>
    	
		
		<!--콘텐츠_메인(S)-->
	    <div class="conts_main">
	
	        <!-- 메인슬라이드(S) 웹 -->
	        <div id="visual" class="slide">
	            <!-- 배너 목록 웹(S)-->
	            <!-- 웹(S) -->
	            <div id="mySwipe" class='swipe'>
	                <ul class="touch_banner swipe-wrap">
	                    <li class="slide_img">
							<a href="#">
								<img class="web_slide_img" src="../images/2020/main_slide_01.jpg" alt="웹메인슬라이드">
								<img class="mobile_slide_img" src="../images/2020/main_slide_01_mobile.jpg" alt="모바일메인슬라이드">
							</a>
						</li>
                           <li class="slide_img">
							<a href="#">
								<img class="web_slide_img" src="../images/2020/main_slide_02.jpg" alt="웹메인슬라이드">
								<img class="mobile_slide_img" src="../images/2020/main_slide_02_mobile.jpg" alt="모바일메인슬라이드">
							</a>
						</li>
						<li class="slide_img">
							<a href="#">
								<img class="web_slide_img" src="../images/2020/main_slide_03.jpg" alt="웹메인슬라이드">
								<img class="mobile_slide_img" src="../images/2020/main_slide_03_mobile.jpg" alt="모바일메인슬라이드">
							</a>
						</li>
	                </ul>
	            </div>
	            <!-- 웹(E) -->
	            <!-- 배너 목록 웹(E)-->
	            <p class="touch_left_btn">
	                <!-- 이전 버튼 -->
	                <a href="#"> <img src="../images/2020/visual_btn_left.png" alt="이전 배너"> </a>
	            </p>
	            <p class="touch_right_btn">
	                <!-- 이전 버튼 -->
	                <a href="#"><img src="../images/2020/visual_btn_right.png" alt="다음 배너"></a>
	            </p>
	        </div>
	        <!-- 메인슬라이드(E) 웹 -->
	
	        <!-- 메인슬라이드(S) 모바일 -->
	
	        <!-- 메인슬라이드(E) 모바일 -->
	
	        <!-- 타이틀박스(S) -->
	        <div class="tit_box">
	            <h2 class="title_02">일자별 경매정보 보기</h2>
	        </div>
	        <!-- 타이틀박스(E) -->
	
	
	
	        <!-- 메인 탭 메뉴(S) -->
			<div class="tab_box">
				<ul class="tab" id="tab">
					<li><input type="hidden" value="1"/><a href="#!">절화</a></li>
					<li><input type="hidden" value="3"/><a href="#!">난</a></li>
					<li><input type="hidden" value="2"/><a href="#!">관엽</a></li>
				</ul>
				
				<div class="date_box_01 main">
					<input type="text" class="datepicker" id="datepicker" value="${searchSaleDate}" readonly>
				</div>
			</div>
			<div class="tab_con" id="tab_con">
			<!-- 절화(S) -->
				<div style="display: block;">
					<div class="main_content_box">
						<div class="tab_btn_list">
							<ul class="tab_btn" id="flowerCd1">
							</ul>
						</div>
						<div class="date_list_img">
							<ul id="cmpCdBtn1">
							</ul>
						</div>
						<div class="date_box01">
							<div class="datel_list">
								<div class="datel_pt">
									<div id="chartHolder1" style="width:100%; height:100%;"></div>
									<div class="datel_txt"><p>물량비중</p></div>
								</div>
							</div>
							<div class="dater_list">
								<div class="dater_pt">
									<div class="dater_txt"><p>평균단가</p></div>
									<div id="chartHolder2" style="width:100%; height:100%;"></div>
									<div class="dater_txt01"><p class="dater_txt02">일자</p></div>
								</div>
							</div>
						</div>
													
						<!-- <a href="#!"><img src="../img/graph_img.png"></a> -->
					</div>
				</div>
			<!-- 절화(E) -->
	
	        <!-- 난(S) -->
				<div style="display: none;">
					<div class="main_content_box">
						<div class="tab_btn" id="flowerCd2">
							<ul>
							</ul>
						</div>
						<div class="date_list_img">
							<ul id="cmpCdBtn2">
							</ul>
						</div>
						<div class="date_box01">
							<div class="datel_list">
								<div class="datel_pt">
									<div id="chartHolder3" style="width:100%; height:100%;"></div>
									<div class="datel_txt"><p>물량비중</p></div>
								</div>
							</div>
							<div class="dater_list">
								<div class="dater_pt">
									<div class="dater_txt"><p>평균단가</p></div>
									<div id="chartHolder4" style="width:100%; height:100%;"></div>
									<div class="dater_txt01"><p class="dater_txt02">일자</p></div>
								</div>
							</div>
						</div>
						<!-- <a href="#!"><img src="../img/graph_img.png"></a> -->
					</div>
				</div>
			<!-- 난(E) -->
	
			<!-- 관엽(S) -->
				<div style="display: none;">
					<div class="main_content_box">
						<div class="tab_btn" id="flowerCd3">
							<ul>
							</ul>
						</div>
						<div class="date_list_img">
							<ul id="cmpCdBtn3">
							</ul>
						</div>
						<div class="date_box01">
							<div class="datel_list">
								<div class="datel_pt">
									<div id="chartHolder5" style="width:100%; height:100%;"></div>
									<div class="datel_txt"><p>물량비중</p></div>
								</div>
							</div>
							<div class="dater_list">
								<div class="dater_pt">
									<div class="dater_txt"><p>평균단가</p></div>
									<div id="chartHolder6" style="width:100%; height:100%;"></div>
									<div class="dater_txt01"><p class="dater_txt02">일자</p></div>
								</div>
							</div>
						</div>
						<!-- <a href="#!"><img src="../img/graph_img.png"></a> -->
					</div>
				</div>
			<!-- 관엽(E) -->
		
			</div>
			<div class="bottom_content">
				<div class="left_box">
					<h2 class="title_02">기념일 달력</h2>
					<a class="plus_bt" href="/hfc01/hfc01.do">+ 더보기</a>
					<ul>
						<li>
							<div id="main_calendar"></div>
						</li>
						<li>
							<p><span>오늘</span>${searchSaleDate}</p>
							<div class="cl_title" id="anniversary">
							</div>
						</li>
					</ul>
				</div>
				<div class="right_box">
					<h2 class="title_02">가격문자 알림서비스</h2>
					<ul>
						<li>
							<p>실시간 경매정보를 알고 싶다면<br>알림서비스를 신청하세요!</p>
							<strong>전국 화훼공판장의 실시간 경매정보를 <br>문자로 받아 볼 수 있습니다.</strong>
						</li>
						<li>
							<div>
								<img src="../images/2020/right_img.png" alt="신청하기 아이콘">
								<a href="/customInfo/customInfoForm.do">신청하기</a>
							</div>
						</li>
					</ul>
				</div>
			</div>
			<!-- 메인 탭 메뉴(E) -->
	
		</div>
	    <!--콘텐츠_메인(E)-->
	
		<jsp:include page="../inc/2020/IncFooter.jsp"/>			
	    
	</div>
	<!--WRAP(E)-->
</body>
</html>