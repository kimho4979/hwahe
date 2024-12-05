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
	<meta name="description" content="공판장별 거래현황">
	<meta name="content" content="화훼유통정보시스템 입니다.">
	<meta name="keywords" content="화훼경매시세, 화훼경매가격, Korea aT flower market auction price, 화훼공판장, 화훼거래정보, 꽃시장, 꽃값">
	<meta name="Author" content="화훼유통정보시스템 & www.woorim.co.kr">
	<title>공판장별 거래현황</title>	
	<%@include file="../common/2020/commonJs.jsp" %>
	<%@include file="../common/2020/commonCss.jsp" %>
	
	<script type="text/javascript">
			
		
	//-----------------------차트 설정 시작-----------------------
	
	//rMate 차트 생성 준비가 완료된 상태 시 호출할 함수를 지정합니다.
	
	var chartVars1 = "rMateOnLoadCallFunction=chartReadyHandler1";
	var chartVars2 = "rMateOnLoadCallFunction=chartReadyHandler2";
	//rMateChart 를 생성합니다.
	//파라메터 (순서대로) 
	//1. 차트의 id ( 임의로 지정하십시오. ) 
	//2. 차트가 위치할 div 의 id (즉, 차트의 부모 div 의 id 입니다.)
	//3. 차트 생성 시 필요한 환경 변수들의 묶음인 chartVars
	//4. 차트의 가로 사이즈 (생략 가능, 생략 시 100%)
	//5. 차트의 세로 사이즈 (생략 가능, 생략 시 100%)
	rMateChartH5.create("chart1", "chartHolder1", chartVars1, "100%", "100%"); 
	rMateChartH5.create("chart2", "chartHolder2", chartVars2, "100%", "100%"); 

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
		 document.getElementById(id).setLayout(layoutStr2);
		 document.getElementById(id).setData(chartData2);
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
	
	$(document).ready(function(){
		
		// datePicker		
		$("#searchSaleDate").datepicker({
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
			beforeShowDay:datechktoday,
			yearSuffix: '년',
			changeMonth: true,
	        changeYear: true,
	        beforeShowDay: function(date){
	        	
	        	var flowerCd = "1";
	        	
	        	if('${sessionScope.searchList}'!=null&&'${sessionScope.searchList}'!=''){
	        		flowerCd = '${sessionScope.searchList.flowerCd}';
	        		
	        	}else if($.cookie("cookie.cmpCd")!=undefined&&$.cookie("cookie.cmpCd")!=''){// 쿠키설정 로드
	        		flowerCd = $.cookie("cookie.flowerCd");
	        	}
	        	
	        	var day = date.getDay();
	        	
	        	if(date > new Date())
					return [false];
	        	
	        	if(flowerCd == "1"){
	        		return [(day == 1 || day == 3 || day == 5)];
	        	}else if(flowerCd == "2"){
	        		return [(day == 1 || day == 2)];
	        	}else if(flowerCd == "3"){
	        		return [(day == 1)];
	        	}else{
	        		return [(day == 1 || day == 3 || day == 5 || day<date.getDay())];
	        	}
			},
			onSelect: function(selectedDate){
				
				var flowerCd = $("#flowerTab .on > input").attr("value");
				var searchSaleDate = selectedDate;
				
				getSalePumList(flowerCd, searchSaleDate);
				//buttonEvent(flowerCd);
			}
		});
		
						
		$('#searchSaleDate').keyup(function(key, event){
			auto_date_format(key.keyCode, this);
			if(key.keyCode == 13){//키가 13이면 실행 (엔터는 13)
				var flowerCd = $("#flowerTab .on > input").attr("value");
				
				buttonEvent(flowerCd);
	        }
		});				
			
	});
	
	function auto_date_format( keyCode, oThis ){
		
		var num_arr = [ 
		      97, 98, 99, 100, 101, 102, 103, 104, 105, 96,
		      48, 49, 50, 51, 52, 53, 54, 55, 56, 57
		  ]
		  
		  if( num_arr.indexOf( Number( keyCode ) ) != -1 ){
		  
		      var len = oThis.value.length;
		      if( len == 4 ) oThis.value += "-";
		      if( len == 7 ) oThis.value += "-";
		  }
	}
	
	function dateChkstr(){
		
		if($("#searchStrDate").val() > $("#searchEndDate").val()){
			$("#searchEndDate").val($("#searchStrDate").val()) ;
		} 
	
	}
	
	function dateChkend(){
		
		if($("#searchStrDate").val() > $("#searchEndDate").val()){
			$("#searchStrDate").val($("#searchEndDate").val()) ;
		} 
	}
	
	function datechktoday(date){
	   if(date > new Date())
	    return [false];
	    return [true];
	    
	}
	
	function month_sample(value,num){
		var yyyy,m,d;
		var arr=value.split('-');
		var dt= new Date(arr[0],arr[1],arr[2]);
		var dt_v= new Date(arr[0],arr[1],arr[2]);
		dt_v.setMonth(dt.getMonth()-num);
		yyyy= dt_v.getFullYear();
		m=dt_v.getMonth();
		d=dt_v.getDate();
	
		if(m =="0")
		{
			m="12"; yyyy=yyyy-1;
		}
		if(m<10)
		{
			m='0'+m;
		}
		if(d<10)
		{
			d='0'+d;
		}
		begindate=yyyy+'-'+m+'-'+d;
		return begindate;	
	}
	
		
	function init(){
		var cmpCd = "cmpCdBtn1";
		
		$(cmpCd).empty();		
		
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
		
	}
	
	// 항상 1번 호출
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
						$('#searchSaleDate').val(val[0].SALE_DATE);
					}else{
						$('#searchSaleDate').val("${searchSaleDate}");
					}
					
					// 품목조회
					getSalePumList(flowerCd, $('#searchSaleDate').val());
					
					//buttonEvent(flowerCd);
				}else{
					// 데이터 없음
					$('#searchSaleDate').val("${searchSaleDate}");
					
					// 초기화
					init();
				}
			}
		});
	}
	
	
	function search(){
		var itemCd = $('#itemCd option:selected').val();
	    var flowerCd = $("#flowerTab .on > input").attr("value");
		
		$.cookie("cookie.flowerCd", flowerCd, { expires: 7, path: '/' });
		$.cookie("cookie.pumCd", itemCd,{ expires: 7, path: '/' });
		
		
		hab08Chart1(flowerCd, itemCd);
		hab08Chart2(flowerCd, itemCd);	   
	}
		
	// 물량비중
	function hab08Chart1(productGubun, itemCd){
		var searchDate = $("#searchSaleDate").val();
	    var searchProductGubun = "";
	    var searchItemCd = itemCd;
			    
		if(typeof productGubun == "undefined" || productGubun == null || productGubun == ""){
			searchProductGubun = $("#tab .on > input").attr("value");
		}else{
			searchProductGubun = productGubun;
		}
		
		$.cookie("cookie.flowerCd", productGubun, { expires: 7, path: '/' });
		
		var searchProductNm = "";
		if(searchProductGubun == "1"){
			searchProductNm = "절화"
		}else if(searchProductGubun == "3"){
			searchProductNm = "난"			
		}else if(searchProductGubun == "2"){
			searchProductNm = "관엽"			
		}
		
		var searchItemNm = "";
		if(searchItemCd == ""){
			searchItemNm = "전체";
		}else{
			searchItemNm = $('#itemCd option:selected').text();
		}
		
		$("#resultNm").html("조회결과 (" + searchProductNm + " - " + searchItemNm + ")");
		
		$.ajax({
			type : "post",
			url : "/hab08/hab08Chart1.json",
			data : {
    			searchDate : searchDate,
    			searchProductGubun : searchProductGubun,
    			searchItemCd : searchItemCd
    		},
			dataType : '',
			success : function(res){
				
				if(res.list!=null && res.list.length > 0){					
					
					chartData1 = res.list;							
						
					chartReadyHandler1("chart1");						
									
				}else{		
					
					// 그래프 초기화
					chartData1 = [];
						
					if(!document.getElementById("chart1")){
						rMateChartH5.create("chart1", "chartHolder1", chartVars1, "100%", "100%");  
					 } else{
						chartReadyHandler1("chart1");
					}					
					
				}
				
			}
		});		
		
	}
	
	// 일자별 평균단가
	function hab08Chart2(productGubun, itemCd){
		var searchDate = $("#searchSaleDate").val();
		var searchProductGubun = "";
		var searchItemCd = itemCd;
		
		if(typeof productGubun == "undefined" || productGubun == null || productGubun == ""){
			searchProductGubun = $("#tab .on > input").attr("value");
		}else{
			searchProductGubun = productGubun;
		}
		
		$.ajax({
			type : "post",
			url : "/hab08/hab08Chart2.json",
			data : {
    			searchDate : searchDate,
    			searchProductGubun : searchProductGubun,
    			searchItemCd : searchItemCd
    		},
			dataType : '',
			success : function(res){					
				
				if(res.list!=null && res.list.length > 0){
					
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
				    
				}else{					
					// 그래프 초기화				
					chartData2= [];
					
					if(!document.getElementById("chart2")){
						rMateChartH5.create("chart2", "chartHolder2", chartVars2, "100%", "100%"); 
					 } else{
						chartReadyHandler2("chart2");
					}					
				}				
			}
		});
	}
	
	function datepickerCreate(flowerCd){
		
		if(flowerCd == "1"){
			$("#searchSaleDate").datepicker("destroy");
			$("#searchSaleDate").datepicker({
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
				beforeShowDay:datechktoday,
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
					
					var flowerCd = $("#flowerTab .on > input").attr("value");
					var searchSaleDate = selectedDate;
					
					getSalePumList(flowerCd, searchSaleDate);
					//buttonEvent(flowerCd);
				}
			});
		}else if(flowerCd == "2"){
			$("#searchSaleDate").datepicker("destroy");
			$("#searchSaleDate").datepicker({
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
				beforeShowDay:datechktoday,
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
					
					var flowerCd = $("#flowerTab .on > input").attr("value");
					var searchSaleDate = selectedDate;
					
					getSalePumList(flowerCd, searchSaleDate);
					//buttonEvent(flowerCd);
				}
			});
		}else if(flowerCd == "3"){
			$("#searchSaleDate").datepicker("destroy");
			$("#searchSaleDate").datepicker({
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
				beforeShowDay:datechktoday,
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
					
					var flowerCd = $("#flowerTab .on > input").attr("value");
					var searchSaleDate = selectedDate;
					
					getSalePumList(flowerCd, searchSaleDate);
					//buttonEvent(flowerCd);
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
		
		<!--서브 헤더 (S)-->
		<div class="lnb_box">
			<ul>
				<li><img src="../images/2020/m_lnb_img.png" alt="집"></li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li>경매정보</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li>공판장 통합정보</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li class="m_right">공판장별 거래현황</li>
			</ul>
		</div>
		<!--sub 헤더 (E)-->
		<!--서브 타이틀(S)-->
		
		<jsp:include page="../inc/2020/IncShare.jsp"/>
		
		<div class="sub_title">
			<div class="title_box">
				<h2>공판장별 거래현황</h2>
				<img src="../images/2020/sub/t_line.png" alt="방울점선">
			</div>
		</div>
		<!--서브 타이틀(E)-->
				
		<jsp:include page="../inc/2020/topMenuStatus.jsp"/>
		
		<!--컨텐츠 내용(S)-->
		<div class="sub_contents">
			<h2 class="title_02" id="resultNm">조회결과</h2>
			<div class="main_content_box bd_gray">				
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
			</div>
		</div>
		<!--컨텐츠 내용(E)-->
		
		<jsp:include page="../inc/2020/IncFooter.jsp"/>
		
	</div>
	<!--WRAP(E)-->
</body>
</html>