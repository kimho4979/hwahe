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
	<title>기간별 경매통계 조회</title>
	<%@include file="../common/2020/commonJs.jsp" %>
	<%@include file="../common/2020/commonCss.jsp" %>
	<style>
 		#progress_loading {display:block; position:absolute; top:50%; left:50%; transform:translateX(-50%) translateY(-50%); background: #ffffff; text-align: center; z-index:999999;}
		@media screen and (min-width: 800px){
		.ui-jqgrid .ui-jqgrid-htable{width:auto!important;}
		}
		
		
		#screenshot{
			position:absolute;
			border:1px solid #ccc;
			background:rgba(0, 0, 0, 0.5);
			padding:0px;
			display:none;
			color:#fff;
		}
		
	</style>
	<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/qtip2/2.1.0/jquery.qtip.min.js"></script>
	<script type="text/javascript">
		var firstSearch1=true;
		var firstSearch =true;
		var cmpCd = [];
		var flowerCd = [];
		var auctionType = 'sCmp';
		var dateType = 'day';
		var hisStrDate = "";
		var hisEndDate = "";
		var danCdType = false;
		var searchDate = "";
		var clickStatus = "0";
		

		$(window).on('resize.jqGrid', function () {
		    $("#jqGrid").jqGrid( 'setGridWidth', $(".sub_info_box > div").width());
		    $("#jqGridPager").jqGrid( 'setGridWidth', $(".sub_info_box > div").width());
		    $("#jqGrid2").jqGrid( 'setGridWidth', $(".cont_left_b").width());
		    $("#jqGridPager2").jqGrid( 'setGridWidth', $(".cont_left_b").width());
		    $(".ui-jqgrid-bdiv").width($(".ui-jqgrid-bdiv").width()+1);
		    auctionType = $(":input:radio[name=rr99]:checked").val();
			dateType = $(":input:radio[name=rr]:checked").val();

		});
		//rMate 차트 생성 준비가 완료된 상태 시 호출할 함수를 지정합니다.
		var chartVars = "rMateOnLoadCallFunction=chartReadyHandler";
		var chartVars2 = "rMateOnLoadCallFunction=chartReadyHandler2";
		var chartVars3 = "rMateOnLoadCallFunction=chartReadyHandler3";

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
		function chartReadyHandler(id) {
			document.getElementById(id).setLayout(layoutStr);
			document.getElementById(id).setData(chartData);
			checkData(chartData);
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

		function calendarShow(id){
			var pickId = "#inputBasic_AX_"+id+"_AX_dateHandle";
			$(pickId).click();
			$('#'+id).attr("readonly",true);
			setTimeout(function(){$('#'+id).attr("readonly",false);}, 50);
		}
		//스트링 형식으로 레이아웃 정의.
		var layoutStr =
			'<rMateChart backgroundColor="#ffffff" borderStyle="none">'
				+'<Options>'
					/* +'<Caption text="7개월간 거래동향"/>' */
					//+'<Caption text="Price Indices of Meats ($ Per Kilogram)"/>'
					//+'<SubCaption text="World Bank Commodity Price Data in 2013" textAlign="center" />'
					+'<Legend defaultMouseOverAction="false" useVisibleCheck="true" />'
				+'</Options>'
				+'<NumberFormatter id="numFmt" useThousandsSeparator="true"/>'
				+'<Line2DChart showDataTips="true" dataTipDisplayMode="axis" paddingTop="0">'
					+'<horizontalAxis>'
						+'<CategoryAxis categoryField="saleDate"/>'
					+'</horizontalAxis>'
					+'<verticalAxis>'
						+'<LinearAxis  formatter="{numFmt}"/>'
					+'</verticalAxis>'
				+'<series>'
					+'<Line2DSeries labelPosition="up" showMaxValueLabel="true"  yField="maxAmt" radius="5" displayName="최고가"  itemRenderer="DiamondItemRenderer">'
					/* 아이템렌더러(데이터 마커) 테두리 색상 */
						+'<fill>'
			          		+'<SolidColor color="#FA5858" alpha="1"/>'
						+'</fill>'
						+'<lineStroke>'
							+'<Stroke color="#FA5858" weight="2"/>'
						+'</lineStroke>'
		                +'<stroke>'
		                    +'<Stroke color="#FA5858" weight="2"/>'
		                +'</stroke>'
		                +'<showDataEffect>'
			                +'<SeriesInterpolate/>'
			            +'</showDataEffect>'
					+'</Line2DSeries>'
					+'<Line2DSeries  labelPosition="up" showMinValueLabel="true" showMaxValueLabel="true"  yField="minAmt" radius="5" displayName="최저가"  itemRenderer="CircleItemRenderer">'
					/* itemRenderer는 Circle입니다 */
						+'<fill>'
			          		+'<SolidColor color="#42b1e5" alpha="1"/>'
						+'</fill>'
						+'<lineStroke>'
							+'<Stroke color="#42b1e5" weight="2"/>'
						+'</lineStroke>'
		                +'<stroke>'
		                    +'<Stroke color="#42b1e5" weight="2"/>'
		                +'</stroke>'
		                +'<showDataEffect>'
			                +'<SeriesInterpolate/>'
			            +'</showDataEffect>'
					+'</Line2DSeries>'
					+'<Line2DSeries  yField="avgAmt" radius="5" displayName="평균가" itemRenderer="TriangleItemRenderer">'
					/* itemRenderer는 Triangle입니다 */
						+'<fill>'
			          		+'<SolidColor color="#01DF3A" alpha="1"/>'
						+'</fill>'
						+'<lineStroke>'
							+'<Stroke color="#01DF3A" weight="2"/>'
						+'</lineStroke>'
		                +'<stroke>'
		                    +'<Stroke color="#01DF3A" weight="2"/>'
		                +'</stroke>'
		                +'<showDataEffect>'
			                +'<SeriesInterpolate/>'
			            +'</showDataEffect>'
					+'</Line2DSeries>'
				+'</series>'
			+'</Line2DChart>'
			+'</rMateChart>';
			//스트링 형식으로 레이아웃 정의.

			var layoutStr2 =
	            '<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'
	              +'<Options>'
		              /* +'<Caption text="거래금액분포도"/>' */
		              +'<SubCaption text="수량" textAlign="left" />'
		              +'<Legend defaultMouseOverAction="false" useVisibleCheck="true" />'
	              +'</Options>'
	              +'<NumberFormatter id="numFmt" useThousandsSeparator="true"/>'
	             +'<Column2DChart showDataTips="true" columnWidthRatio="0.55" selectionMode="single"   dataTipJsFunction="dataTipFunc"  >'
	                 +'<horizontalAxis>'
	                 	+'<CategoryAxis categoryField="range" padding="0.5"/>'
	                  +'</horizontalAxis>'
	                  +'<verticalAxis>'
	                     +'<LinearAxis id="vAxis"  formatter="{numFmt}"  minimum="0" />'
	                 +'</verticalAxis>'
	                    +'<series>'
	                    +'<Column2DSeries yField="qty" displayName="수량">'
	                            +'<showDataEffect>'
	                               +'<SeriesInterpolate/>'
	                           +'</showDataEffect>'
	                      +'</Column2DSeries>'
	                  +'</series>'
	                  +'<annotationElements>'
	                  +'<CanvasElement fontFamily="dotum">'
	                     /* +'<Label right="0" bottom="-15" text="가격" fontSize="11" color="#999999"/>' */
	                     +'<Label right="0" bottom="-18"  height="16"  text="가격" fontSize="11" color="#999999"/>'
	                  +'</CanvasElement>'
	              +'</annotationElements>'
	              +'</Column2DChart>'
	           +'</rMateChart>';


          var layoutStr3 =
              '<rMateChart backgroundColor="#FFFFFF" borderStyle="none" >'
                   +'<Options>'
                       +'<Legend useVisibleCheck="true"  horizontalGap="0" direction="vertical" position="right" labelPlacement="left"/>'
                    +'</Options>'
                  +'<HalfPie2DChart showDataTips="true" paddingBottom="40">'
                 /* Pie2D 차트 생성시에 필요한 Pie2DChart 정의합니다. */
                /* showDataTips : 데이터에 마우스를 가져갔을 때 나오는 Tip을 보이기/안보이기 속성입니다. */
                       +'<series>'
                            +'<HalfPie2DSeries nameField="marketName" field="totQty" outerRadius="1" labelPosition="inside" color="#fff" labelField="marketName" alwaysShowInsideLabel="true" textOverflowEllipsis="true" >'
                                 +'<fills>'
                                     +'<SolidColor color="#40b1e6"/>'
                                   +'<SolidColor color="#074d81"/>'
                                   +'<SolidColor color="#20cbc2"/>'
                                   +'<SolidColor color="#fabb05"/>'
                                   +'<SolidColor color="#f97b17"/>'
                               +'</fills>'
                            /* Pie2DChart 정의 후 Pie2DSeries labelPosition="inside"정의합니다 */
                                +'<showDataEffect>'
                                /* 차트 생성시에 Effect를 주고 싶을 때 shoDataEffect정의합니다 */
                                     +'<SeriesInterpolate duration="1000"/>'
                                    /* SeriesSlide 효과는 시리즈 데이터가 데이터로 표시될 때 한쪽에서 미끄러지듯 나타나는 효과를 적용합니다. */
                                     /* elementOffset : effect를 지연시키는 시간을 지정합니다 default:20 */
                                     /* minimumElementDuration : 각 엘리먼트의 최소 지속 시간을 설정합니다 default:0 */
                                                  /* 이 값보다 짧은 시간에 effect가 실행되지 않습니다. */
                                   /* offset : effect개시의 지연시간을 설정합니다 default:0 */
                                   /* perElementOffset : 각 엘리먼트의 개시 지연시간을 설정합니다. */
                                     /* direction : left:왼쪽, right:오른쪽, up:위, down:아래 default는 left입니다. */
                                +'</showDataEffect>'
                           +'</HalfPie2DSeries>'
                      +'</series>'
                       /* +'<annotationElements>'
                            +'<CanvasElement>'
                                 +'<CanvasLabel horizontalCenter="0" height="24" fontSize="19" verticalCenter="86" text="2019" color="#333333"/>'
                               +'<CanvasLabel horizontalCenter="0" height="19" fontSize="14" verticalCenter="106" text="Annual Report" color="#666666"/>'
                             +'</CanvasElement>'
                        +'</annotationElements>' */
                   +'</HalfPie2DChart>'
               +'</rMateChart>';
		//차트 데이터
		var chartData = [];
		var chartData2 = [];
		var chartData3 = [];


		function rMateChartH5ChangeTheme(theme){
			document.getElementById("chart1").setTheme(theme);
			document.getElementById("chart2").setTheme(theme);
			document.getElementById("chart3").setTheme(theme);
		}

		function checkData(data){
			if(data.length <= 0){
				// 데이터가 없을 경우 hasNoData함수를 실행하여 메세지창을 출력한다.
				document.getElementById("chart1").hasNoData(true);
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

		function axisLabelFunc(id, value)
		{
			return value;
		}

		function dataTipFunc(seriesId, seriesName, index, xName, yName, data, values)
		{
			var preRange="";
			for(var i=0; i<chartData2.length; i++){
				if(chartData2[i].range==values[0]){
					if(i==0){
						preRange="0"
					}else{
						preRange=chartData2[i-1].range;
					}

				}
			}
			var html='';
			html='가격 : <b>'+preRange+'-'+values[0]+'</b><br/>';
			dataValue=values[0];
			html+='수량 : <b>'+values[1]+'</b>';
		       return html;
		}

		//-----------------------차트 설정 끝 -----------------------

		$(document).ready(function(){
			
			$('#progress_loading').hide();
			
			/* $('.calendar_focus').focus(function(){

				var id =this.id;
				var pickId = "#inputBasic_AX_"+id+"_AX_dateHandle";
				$(pickId).click();
				$('#'+id).attr("readonly",true);
				setTimeout(function(){$('#'+id).attr("readonly",true);}, 50);
			}); */

			/* var itemCd = "";
        	var itemCd2 = "";
        	var gubn = 0;
        	var type = $(":input:radio[name=rr]:checked").val();

        	if($('#itemCd option:selected').val() !== undefined){
        		itemCd = $('#itemCd option:selected').val();
        	}
        	if($('#itemCd2 option:selected').val() !== undefined){
        		itemCd2 = $('#itemCd2 option:selected').val();
        	}

    		$('input:checkbox[name="flowerGubn"]:checked').each(function(){
    			flowerCd.push($(this).val());
    		})

    		$('input:checkbox[name="cmpCd"]:checked').each(function(){
    			cmpCd.push($(this).val());
    		})

    		if($('input:checkbox[name="gubn"]:checked').length == 4){
       			gubn = 14;
       		}else{
	       		$('input:checkbox[name="gubn"]:checked').each(function(){
	       			gubn += parseInt($(this).val());
	       		})
       		} */


			$("#searchDateD").show();
			$("#searchDateM").hide();
			$("#searchDateY").hide();
			$("#sCmp").show();
			$("#tCmp").hide();

			$('#itemCd').select2();
			$('#itemCd2').select2();

			$("input[name=flowerGubn]").change(function(){
				if(this.checked){
					if($('input:checkbox[name="flowerGubn"]:checked').length == 4){
						$("#chk05").prop("checked",true);
					}
				}else{
					$("#chk05").prop("checked",false);
				}
				getSalePumList();
			});

			$("input[name=tCmpCd]").change(function(){
				if(this.checked){
					if($('input:checkbox[name="tCmpCd"]:checked').length == 7){
						$("#chk177").prop("checked",true);
					}
				}else{
					$("#chk177").prop("checked",false);
				}
				getSalePumList();
			});

			$("input[name=sCmpCd]").change(function(){
				getSalePumList();
			});

			$("input[name=gubn]").change(function(){
				if(this.checked){
					if($('input:checkbox[name="gubn"]:checked').length == 3){
						$("#chk33-02").prop("checked",true);
					}
				}else{
					$("#chk33-02").prop("checked",false);
				}
			});

			$("#itemCd").change(function() {
				getSaleGoodList();
				if($("#itemCd").val() != ''){
					$("#chk00-02").prop("checked",false);
					$("#chk11-02").prop("checked",true);
					$("#chk22-02").prop("checked",false);
					$("#chk33-02").prop("checked",false);
				}
			});

			$("#itemCd2").change(function() {
				if($("#itemCd2").val() != ''){
					$("#chk00-02").prop("checked",false);
					$("#chk11-02").prop("checked",false);
					$("#chk22-02").prop("checked",true);
					$("#chk33-02").prop("checked",false);
				}
			});

			$("input[name='rr']").change(function(){
				dateType = $(":input:radio[name=rr]:checked").val();
				if(dateType == "day"){
					$("#searchDateD").show();
					$("#searchDateM").hide();
					$("#searchDateY").hide();

				}else if(dateType == "month"){
					$("#searchDateD").hide();
					$("#searchDateM").show();
					$("#searchDateY").hide();
				}else{
					$("#searchDateD").hide();
					$("#searchDateM").hide();
					$("#searchDateY").show();
				}

			});

			$("input[name='rr99']").change(function(){

				if($(":input:radio[name=rr99]:checked").val() == "sCmp"){
					auctionType = 'sCmp';
					$("#sCmp").show();
					$("#tCmp").hide();
					$("#typeText").text("등급별비중");
				}else{
					auctionType = 'tCmp';
					$("#sCmp").hide();
					$("#tCmp").show();
					$("#typeText").text("공판장비중");
				}
				getSalePumList();
			});

			$("input[name='rr1']").change(function(){
				var now = new Date();
				var year = now.getFullYear();
				var month = now.getMonth() + 1;
				var date = now.getDate();

				if(date < '10'){
					date = '0'+date;
				}
				if(month < '10'){
					month = '0'+month;
				}

				if($(":input:radio[name=rr1]:checked").val() == "day"){
					$("#searchStrDateD").val(year+"-"+month+"-"+date);
					$("#searchEndDateD").val(year+"-"+month+"-"+date);

				}else if($(":input:radio[name=rr1]:checked").val() == "week"){
					var preWeek =  new Date(now.getFullYear(), now.getMonth(), now.getDate()-7);
					var wYear = preWeek.getFullYear();
					var wMonth = preWeek.getMonth() + 1;
					var wDate = preWeek.getDate();
					if(wDate < '10'){
						wDate = '0'+wDate;
					}
					if(wMonth < '10'){
						wMonth = '0'+wMonth;
					}

					$("#searchStrDateD").val(wYear+"-"+wMonth+"-"+wDate);
					$("#searchEndDateD").val(year+"-"+month+"-"+date);
				}else{
					var preMonth =  new Date(now.getFullYear(), now.getMonth()-1, now.getDate());
					var mYear = preMonth.getFullYear();
					var mMonth = preMonth.getMonth() + 1;
					var mDate = preMonth.getDate();
					if(mDate < '10'){
						mDate = '0'+mDate;
					}
					if(mMonth < '10'){
						mMonth = '0'+mMonth;
					}

					$("#searchStrDateD").val(mYear+"-"+mMonth+"-"+mDate);
					$("#searchEndDateD").val(year+"-"+month+"-"+date);
				}
			});
			
			
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
					/*if(!dateChkstr()){
						$("#searchStrDateD").val(hisStrDate);
					}*/
					dateChkstr('threeYear');
					cmpCd= [];
					flowerCd = [];
					var searchStrDate = $("#searchStrDateD").val();
					var searchEndDate = $("#searchEndDateD").val();
					
					$('input:checkbox[name="flowerGubn"]:checked').each(function(){
		       			flowerCd.push($(this).val());
		       		})

					if(searchStrDate!=''&& searchEndDate!=''){
						getSalePumList();
					}
					
					$("#rr33").prop("checked",false);
					$("#rr44").prop("checked",false);
					$("#rr55").prop("checked",false);
					$("#rr88").prop("checked",true);
					
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
				beforeShow: function (){
					hisEndDate = $("#searchEndDateD").val();
				},
				yearSuffix: '년',
				changeMonth: true,
				changeYear: true,
				onSelect: function(){
					if(!dateChkend()){
						$("#searchEndDateD").val(hisEndDate);
					}
					cmpCd= [];
					flowerCd = [];
					var searchStrDate = $("#searchStrDateD").val();
					var searchEndDate = $("#searchEndDateD").val();
					$('input:checkbox[name="flowerGubn"]:checked').each(function(){
		       			flowerCd.push($(this).val());
		       		})

					if(searchStrDate!=''&& searchEndDate!=''){
						getSalePumList();
					}
					
					$("#rr33").prop("checked",false);
					$("#rr44").prop("checked",false);
					$("#rr55").prop("checked",false);
					$("#rr88").prop("checked",true);
				}
			});
			$('.content').click(function(){});

			//달력 월별설정
			$("#searchStrDateM").bindDate({align:"right", valign:"bottom", separator:"-", selectType:"m",  defaultSelectType:"m", value:"",
		       	onchange:function(){
		       		dateChkstr();
					cmpCd= [];
					flowerCd = [];
					var searchStrDate = $("#searchStrDateM").val();
					var searchEndDate = $("#searchEndDateM").val();
					$('input:checkbox[name="flowerGubn"]:checked').each(function(){
		       			flowerCd.push($(this).val());
		       		})

					if(searchStrDate!=''&& searchEndDate!=''){
						getSalePumList();
					}
				},
			});

			$("#searchEndDateM").bindDate({align:"right", valign:"bottom", separator:"-", selectType:"m",  defaultSelectType:"m", value:"",

		       	onchange:function(){
		       		dateChkend();
					cmpCd= [];
					flowerCd = [];
					var searchStrDate = $("#searchStrDateM").val();
					var searchEndDate = $("#searchEndDateM").val();
					$('input:checkbox[name="flowerGubn"]:checked').each(function(){
		       			flowerCd.push($(this).val());
		       		})

					if(searchStrDate!=''&& searchEndDate!=''){
						getSalePumList();
					}
				},
			});

			//달력 연별설정
			$("#searchStrDateY").bindDate({align:"right", valign:"bottom", separator:"-", selectType:"y",  defaultSelectType:"y", value:"",
				onchange:function(){
					dateChkstr();
					cmpCd= [];
					flowerCd = [];
					var searchStrDate = $("#searchStrDateY").val();
					var searchEndDate = $("#searchEndDateY").val();
					$('input:checkbox[name="flowerGubn"]:checked').each(function(){
		       			flowerCd.push($(this).val());
		       		})

					if(searchStrDate!=''&& searchEndDate!=''){
						getSalePumList();
					}
				}

			});

			//달력 연별설정
			$("#searchEndDateY").bindDate({align:"right", valign:"bottom", separator:"-", selectType:"y",  defaultSelectType:"y", value:"",
				onchange:function(){
					dateChkend();
					cmpCd= [];
					flowerCd = [];
					var searchStrDate = $("#searchStrDateY").val();
					var searchEndDate = $("#searchEndDateY").val();
					$('input:checkbox[name="flowerGubn"]:checked').each(function(){
		       			flowerCd.push($(this).val());
		       		})

					if(searchStrDate!=''&& searchEndDate!=''){
						getSalePumList();
					}
				}

			});

			// 초기1회로딩
			//fnObj.setPage();
			getSalePumList();
			$("#excelBtn1").empty();
			$("#excelBtn1").append('<a href="javascript:void(0);" id="exportBtn1" name="exportTable1" onclick="excelExport();"><img src="../images/2020/exel.png" alt="엑셀이미지">엑셀저장</a>');

			let initData = {
				rsFlowerCtgr: [{cdId: '1', cdNm: '절화', cdSeq: 1}],
		    	rsMarket: [{cdId: '0000000001', cdNm: 'aT화훼(양재)', cdSeq: 1}],
		    	rsItem: [],
		    	rsItemDtl: []
			};
			fnObj.setPopupParam(initData);
			
			//$("#searchStrDateD").val('2022-12-01');// 개발데이터보기용초기값
			//$("#searchEndDateD").val('2022-12-31');// 개발데이터보기용초기값
			
		});
		
		
		function Mobile() {return /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent);}
		

		function year_sampled(value,num){
			var m,d;
			var arr=value.split('-');
			var dt_v= new Date(arr[0],arr[1]);
			m=dt_v.getMonth();
			if(m<10)
				{
					m='0'+m;
				}

			begindate=(dt_v.getFullYear()+num)+'-'+m;
			return begindate;

		}

		function dateChkstr(year){
			if(dateType=="day"){
				if($("#searchStrDateD").val() > $("#searchEndDateD").val()){
					$("#searchEndDateD").val($("#searchStrDateD").val()) ;
				}

				var strDate = new Date($("#searchStrDateD").val());
				var endDate = new Date($("#searchEndDateD").val());

				var btMs = endDate.getTime() - strDate.getTime();
				var btDay = btMs / (1000*60*60*24);
				if(btDay > 1095 && year == "threeYear"){
					alert("3년이상은 선택 하실수 없습니다.");
					$("#searchStrDateD").val('');
					return false;
				}
				if(btDay > 365 && typeof year == "undefined"){
					alert("1년이상은 선택 하실수 없습니다.");
					return false;
				}
				return true;
			}else if(dateType=="month"){
				var strDate = new Date($("#searchStrDateM").val());
				var endDate = new Date($("#searchEndDateM").val());

				var btMs = endDate.getTime() - strDate.getTime();
				var btMth = btMs / (1000*60*60*24 * 30);
				
				if(Math.floor(btMth) >= 37){
					alert("3년이상은 선택 하실수 없습니다.");
					$("#searchStrDateM").val('');
					return false;
				}

				if($("#searchStrDateM").val() > $("#searchEndDateM").val()){
					$("#searchEndDateM").val($("#searchStrDateM").val()) ;
				}
			}else{
				
				var strDate = new Date($("#searchStrDateY").val());
				var endDate = new Date($("#searchEndDateY").val());

				var btMs = endDate.getTime() - strDate.getTime();
				var btYear = btMs / (1000*60*60*24 * 30 * 12);
				
				if(Math.floor(Math.floor(btYear)) > 3){
					alert("3년이상은 선택 하실수 없습니다.");
					$("#searchStrDateY").val('');
					return false;
				}
				
				if($("#searchStrDateY").val() > $("#searchEndDateY").val()){
					$("#searchEndDateY").val($("#searchStrDateY").val()) ;
				}
			}
		}

		function dateChkend(){

			if(dateType=="day"){
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
			}else if(dateType=="month"){
				if($("#searchStrDateM").val() > $("#searchEndDateM").val()){
					$("#searchStrDateM").val($("#searchEndDateM").val()) ;
				}
			}else{
				if($("#searchStrDateY").val() > $("#searchEndDateY").val()){
					$("#searchStrDateY").val($("#searchEndDateY").val()) ;
				}
			}
		}

		function datechktoday(date){

			if(date > new Date()) return [false]; return [true];
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

			if(m =="0") {m="12"; yyyy=yyyy-1;}
			if(m<10) {m='0'+m;}
			if(d<10) {d='0'+d;}

			begindate=yyyy+'-'+m+'-'+d;
			return begindate;
		}


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

		function excelExport(){

			var excelNm = "경매정산통계";
        	var searchStrDate = "";
        	var searchEndDate = "";
        	var gubn = [];
        	var url ="";
        	
        	let param = "?excelNm="+excelNm+"&type="+dateType;
        	
        	//var param1 = "?excelNm="+excelNm+"&searchStrDate="+searchStrDate+"&searchEndDate="+searchEndDate+"&cmpCd="+cmpCd+"&flowerCd="+flowerCd+"&itemCd="+itemCd+"&itemCd2="+itemCd2+"&type="+dateType+"&gubn="+gubn;
			//var param2= "?excelNm="+excelNm+"&searchStrDate="+searchStrDate+"&searchEndDate="+searchEndDate+"&cmpCd="+cmpCd+"&flowerCd="+flowerCd+"&itemCd="+itemCd+"&itemCd2="+itemCd2+"&type="+dateType+"&gubn="+gubn+"&pumName="+pumName+"&goodName="+goodName;
        	
        	
        	if(dateType == "day"){
        		searchStrDate = $("#searchStrDateD").val();
            	searchEndDate = $("#searchEndDateD").val();
			}else if(dateType == "month"){
				searchStrDate = $("#searchStrDateM").val();
	        	searchEndDate = $("#searchEndDateM").val();
			}else{
				searchStrDate = $("#searchStrDateY").val();
	        	searchEndDate = $("#searchEndDateY").val();
			}
        	param += "&searchStrDate="+searchStrDate+"&searchEndDate="+searchEndDate;

        	$('input:checkbox[name="gubn"]:checked').each(function(){
    			gubn.push($(this).val());
    		})

    		if(isEmptyArr(gubn)){
    			gubn.push('5');
    		}
        	gubn.forEach(function(item){
        		param += "&gubn[]="+item;
			});
        	
	        fnObj.param.rsFlowerCtgr.forEach(function(item){
	        	param += "&flower[]="+item.cdId;
			});

        	fnObj.param.rsMarket.forEach(function(item){
        		param += "&market[]="+item.cdId;
			});

        	fnObj.param.rsItem.forEach(function(item){
        		param += "&item[]="+item.cdId;
			});

        	fnObj.param.rsItemDtl.forEach(function(item){
        		param += "&itemDtl[]="+item.cdId;
			});
       		
			if(auctionType == 'sCmp'){
     			url = "/excel/excelDownLoadHaa00_new.do";
     			location.href = url+param;
     		}else{
     			//cmpCd = [];
     			$('input:checkbox[name="tCmpCd"]:checked').each(function(){
           			cmpCd.push($(this).val());
           		})
     			//url = "/excel/excelDownLoadHaaTotal00_new.do";
     			url = "/excel/excelDownLoadHaa00_new.do";
     			if(isEmptyArr(cmpCd)){
	        		alert("선택한 공판장이 없습니다.");
	        		return false;
	        	}
     			location.href = url+param;
     		}

		}

		/* function search(){
			var itemCd = "";
        	var itemCd2 = "";
        	var gubn = 0;
        	var type = $(":input:radio[name=rr]:checked").val();
        	var searchStrDate = "";
        	var searchEndDate = "";
        	flowerCd = [];
        	cmpCd = [];

        	init();
        	if($('#itemCd option:selected').val() !== undefined){
        		itemCd = $('#itemCd option:selected').val();
        	}
        	if($('#itemCd2 option:selected').val() !== undefined){
        		itemCd2 = $('#itemCd2 option:selected').val();
        	}

       		$('input:checkbox[name="flowerGubn"]:checked').each(function(){
       			flowerCd.push($(this).val());
       		})

       		$('input:checkbox[name="cmpCd"]:checked').each(function(){
       			cmpCd.push($(this).val());
       		})

       		if($('input:checkbox[name="gubn"]:checked').length == 4){
       			gubn = 14;
       		}else{
	       		$('input:checkbox[name="gubn"]:checked').each(function(){
	       			gubn += parseInt($(this).val());
	       		})
       		}

        	if($(":input:radio[name=rr]:checked").val() == "day"){
        		searchStrDate = $("#searchStrDateD").val();
            	searchEndDate = $("#searchEndDateD").val();

			}else if($(":input:radio[name=rr]:checked").val() == "month"){
				searchStrDate = $("#searchStrDateM").val();
	        	searchEndDate = $("#searchEndDateM").val();
			}else{
				searchStrDate = $("#searchStrDateY").val();
	        	searchEndDate = $("#searchEndDateY").val();
			}
        	$("#jqGrid").clearGridData();
		    $("#jqGrid").setGridParam({
		   		datatype	: "json",
		   		postData	: {
		   			cmpCd : cmpCd,
        			flowerCd : flowerCd,
        			type: type,
        			gubn: gubn,
        			searchStrDate: searchStrDate,
        			searchEndDate: searchEndDate,
        			itemCd:itemCd,
        			itemCd2:itemCd2
		   		},
				page : 1
		    }).trigger("reloadGrid");

		} */

		function init(){
			// 그리드초기화
			$("#jqGrid").jqGrid("clearGridData", true);

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
				resetParam : function() {
					
					fnObj.param.rsFlowerCtgr = [{cdId: '1', cdNm: '절화', cdSeq: 1}];
					fnObj.param.rsMarket = [{cdId: '0000000001', cdNm: 'aT화훼(양재)', cdSeq: 1}];
					fnObj.param.rsItem.length = 0;
					fnObj.param.rsItemDtl.length = 0;
					fnObj.setInfoText();

					// 구분
					$("input:radio[name='rr99']:radio[value='sCmp']").prop('checked', true);
					// 기간
					$("input:radio[name='rr1']:radio[value='week']").prop('checked', true);
					var now = new Date();
					var year = now.getFullYear();
					var month = now.getMonth() + 1;
					var date = now.getDate();
					if(date < '10'){
						date = '0'+date;
					}
					if(month < '10'){
						month = '0'+month;
					}
					
					var preWeek =  new Date(now.getFullYear(), now.getMonth(), now.getDate()-7);
					var wYear = preWeek.getFullYear();
					var wMonth = preWeek.getMonth() + 1;
					var wDate = preWeek.getDate();
					if(wDate < '10'){
						wDate = '0'+wDate;
					}
					if(wMonth < '10'){
						wMonth = '0'+wMonth;
					}
					$("#searchStrDateD").val(wYear+"-"+wMonth+"-"+wDate);
					$("#searchEndDateD").val(year+"-"+month+"-"+date);
					// 조회단위
					$("input:radio[name='rr']:radio[value='day']").prop('checked', true);
					$("#searchDateD").show();
					$("#searchDateM").hide();
					$("#searchDateY").hide();
					// 표시단위
					$("#chk00-02").prop("checked", false);
					$("#chk11-02").prop("checked", true);
					$("#chk22-02").prop("checked", false);
					$("#chk33-02").prop("checked", false);
					
					//2024-12-16 추가내용 - 박대효
					let itemSrch = $('#tb__itemSrch').DataTable();
					itemSrch.search('').draw();
					
					let itemDtlSrch = $('#tb__itemDtlSrch').DataTable();
					itemDtlSrch.search('').draw();
				},
				
				setInfoText : function() {
					let paramText = '';
					fnObj.param.rsFlowerCtgr.forEach(function(item){
						if (!isEmpty(paramText)) {
							paramText += ', ';
						}
						paramText += item.cdNm;
					});
					$('.flower__text').text(paramText);

					paramText = '';
					fnObj.param.rsMarket.forEach(function(item){
						if (!isEmpty(paramText)) {
							paramText += ', ';
						}
						paramText += item.cdNm;
					});
					$('.market__text').text(paramText);

					paramText = '';
					fnObj.param.rsItem.forEach(function(item){
						if (!isEmpty(paramText)) {
							paramText += ', ';
						}
						paramText += item.cdNm;
					});
					$('.item__text').text(paramText);

					paramText = '';
					fnObj.param.rsItemDtl.forEach(function(item){
						if (!isEmpty(paramText)) {
							paramText += ', ';
						}
						paramText += item.cdNm;
					});
					$('.itemDtl__text').text(paramText);
				},
				setPopupParam : function (rs) {
					console.log("rs", rs);
					let paramText = ''
					fnObj.param.rsFlowerCtgr.length = 0;
					rs.rsFlowerCtgr.forEach(function(item){
						fnObj.param.rsFlowerCtgr.push(item);
						if (!isEmpty(paramText)) {
							paramText += ', ';
						}
						paramText += item.cdNm;
					});
					$('.flower__text').text(paramText);

					paramText = '';
					fnObj.param.rsMarket.length = 0;
					rs.rsMarket.forEach(function(item){
						fnObj.param.rsMarket.push(item);
						if (!isEmpty(paramText)) {
							paramText += ', ';
						}
						paramText += item.cdNm;
					});
					$('.market__text').text(paramText);

					paramText = '';
					fnObj.param.rsItem.length = 0;
					rs.rsItem.forEach(function(item){
						fnObj.param.rsItem.push(item);
						if (!isEmpty(paramText)) {
							paramText += ', ';
						}
						paramText += item.cdNm;
					});
					$('.item__text').text(paramText);

					paramText = '';
					fnObj.param.rsItemDtl.length = 0;
					rs.rsItemDtl.forEach(function(item){
						fnObj.param.rsItemDtl.push(item);
						if (!isEmpty(paramText)) {
							paramText += ', ';
						}
						paramText += item.cdNm;
					});
					$('.itemDtl__text').text(paramText);
					
					if(fnObj.param.rsItemDtl.length > 0){
						$("#chk00-02").prop("checked",false);
						$("#chk11-02").prop("checked",false);
						$("#chk22-02").prop("checked",true);
						$("#chk33-02").prop("checked",false);
					}
					
					
				},
		        setPage : function(){

		        	$("#jqGrid").jqGrid("GridUnload");
		        	//var auctionType = $(":input:radio[name=rr99]:checked").val();
		        	var url = '';
		        	var itemCd = "";
		        	var itemCd2 = "";
		        	var searchCmpCd = "";
		        	var searchStrDate = "";
		        	var searchEndDate = "";

		        	let flowers = [];
		        	let markets = [];
		        	let items = [];
		        	let itemDtls = [];
		        	
		        	flowerCd = [];
		        	cmpCd = [];
		        	
		        	fnObj.param.rsFlowerCtgr.forEach(function(item){
						flowers.push(item.cdId);
						flowerCd.push(item.cdId);
					});

		        	fnObj.param.rsMarket.forEach(function(item){
						markets.push(item.cdId);
						cmpCd.push(item.cdId);
					});

		        	fnObj.param.rsItem.forEach(function(item){
						items.push(item.cdId);
					});

		        	fnObj.param.rsItemDtl.forEach(function(item){
						itemDtls.push(item.cdId);
					});

		        	//var gubn = 0;

		        	//var type = $(":input:radio[name=rr]:checked").val();
		        	var gubn = [];
					//flowerCd = [];

					if (markets.length == 0) {
						alert("선택한 경매장이 없습니다.");
		        		return false;
					}

					if(auctionType == 'sCmp'){
						if (markets.length > 1) {
							alert("하나의 경매장만 선택하세요.");
			        		return false;
						}
		     			url = "/haa00_new/selectMultiAuctionList.json";
		     		}else{
		     			//url = "/haa00_new/selectAuctionListTotal.json";
		     			url = "/haa00_new/selectMultiAuctionList.json";
		     		}

	        		$('input:checkbox[name="gubn"]:checked').each(function(){
	        			gubn.push($(this).val());
	        		})

	        		if(isEmptyArr(gubn)){
	        			gubn.push('5');
	        		}
	        		if(dateType == "day"){
	            		searchStrDate = $("#searchStrDateD").val();
	                	searchEndDate = $("#searchEndDateD").val();

	    			}else if(dateType == "month"){
	    				searchStrDate = $("#searchStrDateM").val();
	    	        	searchEndDate = $("#searchEndDateM").val();
	    			}else{
	    				searchStrDate = $("#searchStrDateY").val();
	    	        	searchEndDate = $("#searchEndDateY").val();
	    			}

	        		let postParam = {
	           			//cmpCd : "0000000001",		//cmpCd 2022-12-12 조회조건 수정 필요
	        			//flowerCd : ["1"],			//flowerCd 2022-12-12 조회조건 수정 필요
	        			type: dateType,
	        			gubn: gubn,
	        			searchStrDate: searchStrDate,
	        			searchEndDate: searchEndDate,
	        			//itemCd:itemCd,
	        			//itemCd2:itemCd2
	        			flower: flowers,
	        			market: markets,
	        			item: items,
	        			itemDtl: itemDtls
	        		};

					$("#jqGrid").jqGrid({
		        		url : url,
		           		mtype: 'POST',
		           		postData: postParam,
		                datatype: "json",
		                jsonReader: {
		        	   		root : "list",  // list 이름
		        	   		page : "page",
		        	   		total : "total",
		        	   		records : "records",
		        			repeatitems : false
		        		},
		        		colModel: [
		                    { label: '부류', name: 'FLOWERNAME',width: 90, editable: false , align:"center", sorttype:'string'},
		                    { label: '품목', name: 'PUMNAME', width: 150, editable: false, align:"center" },
		                    { label: '품종', name: 'GOODNAME', width: 150, editable: false, align:"center" },
		                    { label: '총수량', name: 'TOTQTY', width: 110, editable: false, align:"center", sorttype: 'float',  formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' }  },
		                    { label: '총금액', name: 'TOTAMT', width: 150, editable: false, align:"center", sorttype: 'float', formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' } },
		                    { label: '최대금액', name: 'MAXAMT', width: 110, align:"center", editable: false, sorttype: 'float',  formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' }  },
		                    { label: '최저금액', name: 'MINAMT', width: 100, align:"center", editable: false, sorttype: 'float',  formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' } },
		                    { label: '평균금액', name: 'AVGAMT', width: 100, align:"center", editable: false, sorttype: 'float',  formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' } },
		                    { label: '날짜', name: 'SALEDATE', width: 100, align:"center", editable: false },
		                    { label: '법인', name: 'MARKETNAME', width: 130, align:"center", editable: false },
		                    { label: '법인코드', name: 'CMPCD', hidden:true},
		                    { label: '부류', name: 'FLOWERGUBN', hidden:true },
		                    { label: '부류단계', name: 'DANCD', hidden:true },
		                    { label: '품목코드', name: 'ITEMCD', hidden:true },
		                    { label: '품종코드', name: 'ITEMCD2', hidden:true },
		                    { label: '파일경로', name: 'FILEPATH', hidden:true }
		                ] ,
		                loadonce: true,
		        		rownumbers : true,
		                autowidth:true,
		                //shrinkToFit:true,
		                viewsortcols: [true,'vertical',true],
		                height: '616',
		                rowNum: 15,
		        		sortable: true,
		        		emptyrecords : '데이터가 없습니다.',
		                pager: "#jqGridPager",
		                loadComplete	: function(data) {
		                	
		                
		                	/* CONFIG */
		            		
		            		var xOffset = 10;
		            		var yOffset = 30;
		            		
		            		// these 2 variable determine popup's distance from the cursor
		            		// you might want to adjust to get the right result
		            		
		            		if(!Mobile()){
				            	$.each($('#jqGrid tr'),function(i,v){
				            		$.each($(v).children(),function(ii,vv){
										if($(vv).text().indexOf("/admin/") != -1){
											$(v).hover(function(e){
							            		this.t = $(vv)[0].title
							            		//this.title = "";	
							            		var jong = $(v).find("td:eq(3)").text()
							            		var mok = $(v).find("td:eq(2)").text()
							            		
							            		var c = (this.t != "") ? "https://flower.at.or.kr" + this.t : "";
							            		$('body').append("<p id='screenshot'  style='width:200px;border-radius:5px;text-align:center;'  ><img style='width:100%;height:180px;' src='"+ ""+c +"' alt='' />"+ mok + " / " +jong+  "</p>");								 
							            		$("#screenshot")
							            			.css("top",(e.pageY - xOffset) + "px")
							            			.css("left",(e.pageX + yOffset) + "px")
							            			.fadeIn("fast");						
							                },
							            	function(){
							            		//this.title = this.t;	
							            		$("#screenshot").remove();
							                });	
							            	$(v).mousemove(function(e){
							            		$("#screenshot")
							            			.css("top",(e.pageY - xOffset) + "px")
							            			.css("left",(e.pageX + yOffset) + "px");
							            	});	
										}
											
				            		})
				            	})
		            		}
		            		
		                	/*$( '#jqGrid' ).tooltip({
		                	      //items: 'td[aria-describedby="jqGrid_FILEPATH"]',
		                	      items: '#jqGrid tr',
		                	      track:true,
		                	      content: function() {
		                	        var element = $( this );
		                	        console.log(this)
		                	        console.log(element)
		                	        
		                	        let text = $('tr td[title^="/admin"]').text();
		                	        return "<img  style='width:100%;height:180px;'   alt='" + text +
	                	            "' src='"+ text +"'>";
		                	        	
		                	        
		                		}})
		                		*/
		                		
		                	
		                	
		                	// 프리뷰 이미지 
		                	/*$('#jqGrid').jqGrid('setGridParam', { onSelectRow: function(id){ 
		                		
		                		var imgpath = ($('td[aria-describedby="jqGrid_FILEPATH"]:eq('+(id-1)+')').text())
		                		var myModal = new AXModal();
		                    	let img = new Image();
		                    	img.src = imgpath;
		                    	let w = window.innerWidth;
		                    	img.onload = function(){
		                    		//alert(this.width + " X " + this.height);
		                    		myModal.openDiv({
		                    			modalID:"imageModal",				
		                    			targetID:"imageModalContent",
		                    			closeByEscKey:true,
		                    			closeButton:true,
		                    			width: '100%'
		                    			//height:this.height
		                    		});
		                    		//margin-top: 0;
		                    	    //height: 180px;
		                    	    //vertical-align: middle;
		                    	    //width: 100%; 
		                    		let h = window.innerHeight; 
		                    		$('#imageModalArea').attr("src",img.src)
		                    		//$('#imageModalArea').css("width",($('#imageModal').css('width') ))
		                    		$('#imageModalArea').css("width",'100%')
		                    		$('#imageModalArea').css("height","180px")
		                    		$('#imageModalArea').css("vertical-align","middle")
		                    		$('#imageModalArea').css("margin-top","0")
		                    		$('#imageModalArea').click(function(){
		                    			$('#imageModal_close').trigger('click')
		                    		})
		                    	}
		                	}});*/

		                	
		                	$("#jqGrid").jqGrid("setSelection", 1);
		                	var rowData = $('#jqGrid').jqGrid('getRowData', 1);
		                	var rowData1 = $('#jqGrid').jqGrid('getRowData');
		                	var rowIds = $('#jqGrid').jqGrid('getDataIDs');
		                	$.each(rowData1, function(idx,rowdata){
								if(rowdata.DANCD =='1'){
		                			$("#jqGrid").setRowData(rowIds[idx],false,{background:"#D7D9E3"});
		                		}else if(rowdata.DANCD =='2'){
		                			$("#jqGrid").setRowData(rowIds[idx],false,{background:"#D9E5D9"});
		                		}else if(rowdata.DANCD =='3'){
		                			$("#jqGrid").setRowData(rowIds[idx],false,{background:"#F1EAE4"});
		                		}
		                	});
		                	itemCd = rowData.PUMNAME;
		                	itemCd2 = rowData.GOODNAME;
		                	if(rowData.PUMNAME != null && rowData.PUMNAME != ""){
		             			itemCd = rowData.PUMNAME.replace(' -계','');
		             		}
		                	if(rowData.GOODNAME != null && rowData.GOODNAME != ""){
		             			itemCd2 = rowData.GOODNAME.replace(' -계','');
		             		}
		                	if(rowData.DANCD == '0'){
		                		searchStrDate = rowData.SALEDATE;
		                		searchEndDate = rowData.SALEDATE;
		                	}else{

		                	}

		                	if(rowData.PUMNAME != null && rowData.PUMNAME != ""){
		                		if(auctionType == 'sCmp'){
		                			//fnObj.setPage2(itemCd, itemCd2, cmpCd, rowData.FLOWERGUBN, searchStrDate, searchEndDate, '', '');
		                			//2022-12-12 조회조건 수정 필요
		                			fnObj.setPage2(itemCd, itemCd2, "0000000001", rowData.FLOWERGUBN, searchStrDate, searchEndDate, '', '');

		                		}else{
		                			fnObj.setPage2(rowData.PUMNAME, rowData.GOODNAME, rowData.CMPCD, rowData.FLOWERGUBN, searchStrDate, searchEndDate, rowData.ITEMCD, rowData.ITEMCD2);
		                		}
		                	}else{
		                		$("#jqGrid2").jqGrid("clearGridData", true);
		                		chartData = [];
		                		rMateChartH5.create("chart1", "chartHolder", chartVars, "100%", "99%");
		                		chartData2 = [];
		                		rMateChartH5.create("chart2", "chartHolder2", chartVars2, "100%", "99%");
		                		chartData3 = [];
		                		rMateChartH5.create("chart3", "chartHolder3", chartVars3, "100%", "99%");
		                	}

		        			//최초 리사이즈
		        			/* $("#jqGrid").jqGrid( 'setGridWidth', $(".info_box > div").width());
		        		    $("#gbox_jqGrid .ui-jqgrid-bdiv").width($("#gbox_jqGrid .ui-jqgrid-bdiv").width()+1); */
		             	}, onSelectRow: function(rowid, status, e) {


 		// 보여주기용 샘플
		/*var myModal = new AXModal();
    	let img = new Image();
    	img.src = "http://flower.at.or.kr/admin/img/loc/0157c795865c415c9aa7c1501139a48c.img";
    	let w = window.innerWidth;
    	img.onload = function(){
    		//alert(this.width + " X " + this.height);
    		myModal.openDiv({
    			modalID:"imageModal",				
    			targetID:"imageModalContent",
    			closeByEscKey:true,
    			closeButton:true,
    			width: (w/2 )
    			//height:this.height
    		});
    		
    		let h = window.innerHeight; 
    		$('#imageModalArea').attr("src",img.src)
    		//$('#imageModalArea').css("width",($('#imageModal').css('width') ))
    		$('#imageModalArea').css("width",'100%')
    		//$('#imageModalArea').css("display",'flex')
    		//$('#imageModalArea').css("height",(h/4 ))
    		$('#imageModalArea').click(function(){
    			$('#imageModal_close').trigger('click')
    		})
    	}*/

		             		var rowData = $(this).getLocalRow(rowid);
		             		//var type = $(":input:radio[name=rr]:checked").val();
		             		var searchStrDate = "";
		             		var searchEndDate = "";
		             		itemCd = rowData.PUMNAME;
		                	itemCd2 = rowData.GOODNAME;

		                	if(rowData.DANCD == '2'){
		                		clickStatus = "2";
		                	}else if(rowData.DANCD == '3'){
		                		clickStatus = "3";
		                	}else{
		                		clickStatus = "0";
		                	}


		                	var url = '';
	             			if(auctionType == 'sCmp'){
	             				searchCmpCd = cmpCd;
	             				url = '/haa00_new/selectHaa00LvJson.json';
	             				if(rowData.PUMNAME != null && rowData.PUMNAME != ""){
			             			itemCd = rowData.PUMNAME.replace(' -계','');
			             		}
			             		if(rowData.GOODNAME != null && rowData.GOODNAME != ""){
			             			itemCd2 = rowData.GOODNAME.replace(' -계','');
			             		}
	             			}else{
	             				searchCmpCd = rowData.CMPCD;
	             				itemCd = rowData.ITEMCD;
	             				itemCd2 = rowData.ITEMCD2;
	             				//url = '/haa00_new/selectHaa00LvJsonTotal.json';
	             				//url = '/haa00_new/selectHaa00LvJson.json';
	             				if(clickStatus == '2'){
	             					$("#typeText").text("공판장비중("+rowData.PUMNAME.replace(' -계','')+"-전체)");
	             				}else if(clickStatus =='3'){
	             					$("#typeText").text("공판장비중("+rowData.PUMNAME+"-"+rowData.GOODNAME.replace(' -계','')+")");
	             				}
	             			}

		             		if(rowData.DANCD == '0'){
		                		searchStrDate=rowData.SALEDATE;
		                		searchEndDate=rowData.SALEDATE;
		                		danCdType = true;
		                		searchDate = rowData.SALEDATE;
		             		}else{

			             		if(dateType == 'day'){
			             			searchStrDate = $("#searchStrDateD").val();
						        	searchEndDate = $("#searchEndDateD").val();
			             		}else if(dateType == 'month'){
			             			searchStrDate = $("#searchStrDateM").val();
						        	searchEndDate = $("#searchEndDateM").val();
			             		}else{
			             			searchStrDate = $("#searchStrDateY").val();
						        	searchEndDate = $("#searchEndDateY").val();
			             		}
			             		danCdType = false;
		             		}
		             	 	if(firstSearch){
		             	 		if(auctionType == 'sCmp'){
		                			fnObj.setPage2(itemCd, itemCd2, searchCmpCd, rowData.FLOWERGUBN, searchStrDate, searchEndDate, '','');
		                		}else{
		                			fnObj.setPage2(rowData.PUMNAME, rowData.GOODNAME, rowData.CMPCD, rowData.FLOWERGUBN, searchStrDate, searchEndDate, rowData.ITEMCD, rowData.ITEMCD2);
		                		}
		             			firstSearch = false;
		             		}else{

		             			var cmpCdList = [];
		             			if(auctionType == 'tCmp'){
			    	     			$('input:checkbox[name="tCmpCd"]:checked').each(function(){
			    	     				cmpCdList.push($(this).val());
			    	           		})
		             			}
		             			
		             			$("#jqGrid2").setGridParam({
		             				 url : url ,
				           		   	 datatype	: "json",
				           		   	 postData	: {
					           		   	cmpCd : (searchCmpCd && searchCmpCd.length > 0) ? searchCmpCd[0] : '',
					           		   	cmpCdList : cmpCdList,
					        			flowerCd : rowData.FLOWERGUBN,
					        			itemCd : itemCd,
					        			itemCd2 :  itemCd2,
				             			searchStrDate : searchStrDate,
				             			searchEndDate : searchEndDate,
				             			type : dateType
				      					},
				      					page : 1
				           		    }).trigger("reloadGrid");
		             		}


		             	}
		            });
		            $('#jqGrid').navGrid('#jqGridPager',
		                // the buttons to appear on the toolbar of the grid
		                { edit: false, add: false, del: false, search: false, refresh: true, view: false, position: "left", cloneToTop: false },
		                // options for the Edit Dialog
		                 // options for the Delete Dailog
		                {
		                    errorTextFormat: function (data) {
		                        return 'Error: ' + data.responseText
		                    }
		                },
		        		{ multipleSearch: true} // search options - define multiple search
		       		);
		            $("#jqGrid").jqGrid("setLabel", "rn", "No.");
		    },
		    setPage2 : function(pumName, goodName, cmpCd, flowerCd, searchStrDate, searchEndDate , itemCd){
		    	//var type = $(":input:radio[name=rr]:checked").val();
		    	//var auctionType = $(":input:radio[name=rr99]:checked").val();
		    	var url = '' ;
		    	var cmpCdList = [];
		    	if(auctionType == 'sCmp'){
		    		url = '/haa00_new/selectHaa00LvJson.json';
		    	}else{
		    		//url = '/haa00_new/selectHaa00LvJsonTotal.json'; //박대효
		    		//url = '/haa00_new/selectHaa00LvJson.json';
		    		//pumName = itemCd;
		    		/* 
	     			$('input:checkbox[name="tCmpCd"]:checked').each(function(){
	     				cmpCdList.push($(this).val());
	           		})
	           		 */
		    		//fnObj.param.rsMarket.forEach(function(item){
		    			//cmpCdList.push(item.cdId);
					//});
		    	}
		    	
    			$("#jqGrid2").jqGrid({
    	    		url : url,
    	       		mtype: 'POST',
    	       		postData:
    	     	   {
    	       			cmpCd : "0000000001",	//cmpCd 2022-12-12 조회조건 수정 필요
    	       			cmpCdList : cmpCdList,
	        			flowerCd :flowerCd,
	        			itemCd : pumName,
	        			itemCd2 :  goodName,
    	    			searchStrDate : searchStrDate,
    	    			searchEndDate : searchEndDate,
    	    			type : dateType
    	   			},
    	            datatype: "json",
    	            jsonReader: {    // json 데이터형식과 맞춰주는거 같다. (요기가 없으니까..그리드안 데이터를 못뿌리네..)
    	    	   		root : "list",  // list 이름
    	    	   		page : "page",
    	    	   		total : "total",
    	    	   		records : "records",
    	    			repeatitems : false
    	    		},
    	            colModel: [
						{ label: '품종명', name: 'GOOD_NAME', width: '120', editable: false , align:"center", sortable:true},
    	                { label: '등급', name: 'LV_NAME',width: '60', editable: false , align:"center", sortable:true},
    	                { label: '등급상세', name: 'LV_ETC_NM',width: '120', editable: false , align:"center", sortable:true},
    	                { label: '공판장', name: 'MARKET_NAME',width: '50', editable: false , align:"center", sortable:true},
    	                { label: '단(속)', name: 'TOT_QTY', width: '50', editable: false, align:"center", sorttype: 'float', formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' } },
    	                { label: '최저단가', name: 'MIN_AMT', width: '90', editable: false, align:"center", sorttype: 'float', formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' } },
    	                { label: '최고단가', name: 'MAX_AMT', width: '90', editable: false, align:"center", sorttype: 'float', formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' } },
    	                { label: '평균단가', name: 'AVG_AMT', width: '90', editable: false, align:"center", sorttype: 'float', formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' } },
    	                { label: '등급코드', name: 'LV_CD', hidden:true},
    	                { label: '품목명', name: 'PUM_NAME', hidden:true},
    	                { label: '법인코드', name: 'CMP_CD', hidden:true},
    	                { label: '검색일자', name: 'SALE_DATE', hidden:true },
    	                { label: '품목코드', name: 'ITEM_CD', hidden:true },
    	                { label: '품종코드', name: 'ITEM_CD2', hidden:true },
    	                { label: '부류', name: 'FLOWER_GUBN', hidden:true }
    	            ] ,
    	            loadonce: true,
    	    		rownumbers : true,
    	            autowidth:true,
    	            height: '228',
    	            rowNum: 15,
    	    		sortable: true,
    	    		emptyrecords : '데이터가 없습니다.',
    	            pager: "#jqGridPager2",
    	       	 	loadComplete	: function(data) {
    	       	 		// 페이지 이동 시
    	           	 	var ids = $("#jqGrid2").jqGrid('getDataIDs');
    	   	 			var idx=1;
    	   	 			if(ids != null && ids.length>0){
    	   	 				idx=ids[0];
    	   	 				var list = data.list;
    	   	 				if(list != null && list !="" ){


								if(clickStatus == '0'){
									$("#typeText").text("등급별비중");
									var newDataList = [];
									var newData = {};
									var totQty = 0;
		       	 					var lvName = "";
	    	       	 				for(var i = 0; i < list.length; i++ ){
	    	       	 					if(i == 0){
	    	       	 						lvName = list[i].LV_NAME;
	    	       	 						totQty = list[i].TOT_QTY;
	    	       	 						if(list.length == 1){
		    	       	 						newData = {"totQty":totQty,"marketName":lvName};
		   	 									newDataList.push(newData);
	    	       	 						}
	    	       	 					}else if(i+1 == list.length){
	    	       	 						if(lvName == list[i].LV_NAME){
	    	       	 							totQty += list[i].TOT_QTY;
	    	       	 							newData = {"totQty":totQty,"marketName":lvName};
	       	 									newDataList.push(newData);
	    	       	 						}else{
		    	       	 						newData = {"totQty":totQty,"marketName":lvName};
	   	 										newDataList.push(newData);
	    	       	 							lvName = list[i].LV_NAME;
	    	       	 							totQty = list[i].TOT_QTY;
	    	       	 							newData = {"totQty":totQty,"marketName":lvName};
	   	 										newDataList.push(newData);
	    	       	 						}

	    	       	 					}else {
		    	       	 					if(lvName == list[i].LV_NAME){
			       	 							totQty += list[i].TOT_QTY;
			       	 						}else{
			       	 							newData = {"totQty":totQty,"marketName":lvName};
			       	 							newDataList.push(newData);
			       	 							lvName = list[i].LV_NAME;
			       	 							totQty = list[i].TOT_QTY;
			       	 						}
	    	       	 					}
									}
	    	       	 				newDataList.sort(qtySort);
		    	       	 			chartData3 = newDataList;
		    						if(!document.getElementById("chart3")){
		    							rMateChartH5.create("chart3", "chartHolder3", chartVars3, "100%", "100%");
		    		            	} else{
		    		            		chartReadyHandler3("chart3");
		    		        		}
	    	       	 			}else if(auctionType =="sCmp" && clickStatus == '3'){
	    	       	 				$("#typeText").text("등급별비중");
		    	       	 			var newDataList = [];
									var newData = {};
									var totQty = 0;
		       	 					var lvName = "";
			       	 				for(var i = 0; i < list.length; i++ ){
			       	 					if(i == 0){
			       	 						lvName = list[i].LV_NAME;
			       	 						totQty = list[i].TOT_QTY;
			       	 						if(list.length == 1){
		    	       	 						newData = {"totQty":totQty,"marketName":lvName};
		   	 									newDataList.push(newData);
			       	 						}
			       	 					}else if(i+1 == list.length){
			       	 						if(lvName == list[i].LV_NAME){
			       	 							totQty += list[i].TOT_QTY;
			       	 							newData = {"totQty":totQty,"marketName":lvName};
		   	 									newDataList.push(newData);
			       	 						}else{
		    	       	 						newData = {"totQty":totQty,"marketName":lvName};
			 										newDataList.push(newData);
			       	 							lvName = list[i].LV_NAME;
			       	 							totQty = list[i].TOT_QTY;
			       	 							newData = {"totQty":totQty,"marketName":lvName};
			 										newDataList.push(newData);
			       	 						}

			       	 					}else {
		    	       	 					if(lvName == list[i].LV_NAME){
			       	 							totQty += list[i].TOT_QTY;
			       	 						}else{
			       	 							newData = {"totQty":totQty,"marketName":lvName};
			       	 							newDataList.push(newData);
			       	 							lvName = list[i].LV_NAME;
			       	 							totQty = list[i].TOT_QTY;
			       	 						}
			       	 					}
									}

		    	       	 			chartData3 = newDataList;
		    						if(!document.getElementById("chart3")){
		    							rMateChartH5.create("chart3", "chartHolder3", chartVars3, "100%", "100%");
		    		            	} else{
		    		            		chartReadyHandler3("chart3");
		    		        		}
	    	       	 			}else if(auctionType =="sCmp" && clickStatus == '2'){
	    	       	 				$("#typeText").text("품종별비중");
	    	       	 				list.sort(custonSort);
									var newDataList = [];
									var newData = {};
									var totQty = 0;
		       	 					var lvName = "";
			       	 				for(var i = 0; i < list.length; i++ ){
			       	 					if(i == 0){
			       	 						lvName = list[i].GOOD_NAME;
			       	 						totQty = list[i].TOT_QTY;
			       	 						if(list.length == 1){
		    	       	 						newData = {"totQty":totQty,"marketName":lvName};
		   	 									newDataList.push(newData);
			       	 						}
			       	 					}else if(i+1 == list.length){
			       	 						if(lvName == list[i].GOOD_NAME){
			       	 							totQty += list[i].TOT_QTY;
			       	 							newData = {"totQty":totQty,"marketName":lvName};
		   	 									newDataList.push(newData);
			       	 						}else{
		    	       	 						newData = {"totQty":totQty,"marketName":lvName};
			 									newDataList.push(newData);
			       	 							lvName = list[i].GOOD_NAME;
			       	 							totQty = list[i].TOT_QTY;
			       	 							newData = {"totQty":totQty,"marketName":lvName};
			 									newDataList.push(newData);
			       	 						}

			       	 					}else {
		    	       	 					if(lvName == list[i].GOOD_NAME){
			       	 							totQty += list[i].TOT_QTY;
			       	 						}else{
			       	 							newData = {"totQty":totQty,"marketName":lvName};
			       	 							newDataList.push(newData);
			       	 							lvName = list[i].GOOD_NAME;
			       	 							totQty = list[i].TOT_QTY;
			       	 						}
			       	 					}
									}
			       	 				newDataList.sort(qtySort);
		    	       	 			if(newDataList.length > 10){
		    	       	 				var totQty = 0;
		    	       	 				var newData2 = "";
		    	       	 				var newDataList2 = [];
		    	       	 				for(var i = 0; i < newDataList.length; i++ ){
		    	       	 					if(i > 8){
		    	       	 						totQty += newDataList[i].totQty;
		    	       	 					}else{
		    	       	 						newDataList2.push(newDataList[i]);
		    	       	 					}
		    	       	 				}
		    	       	 				newDataList2.push({"totQty":totQty,"marketName":"기타"});
		    	       	 				chartData3 = newDataList2;
		    	       	 			}else{
		    	       	 				chartData3 = newDataList;
		    	       	 			}

		    						if(!document.getElementById("chart3")){
		    							rMateChartH5.create("chart3", "chartHolder3", chartVars3, "100%", "100%");
		    		            	} else{
		    		            		chartReadyHandler3("chart3");
		    		        		}

	    	       	 			}

    	   	 				}
    	   	 			}else{
	    	   	 			chartData = [];
	                		rMateChartH5.create("chart1", "chartHolder", chartVars, "100%", "99%");
	                		chartData2 = [];
	                		rMateChartH5.create("chart2", "chartHolder2", chartVars2, "100%", "99%");
	                		chartData3 = [];
	                		rMateChartH5.create("chart3", "chartHolder3", chartVars3, "100%", "99%");
    	   	 			}
    	   	 			$("#jqGrid2").jqGrid("setSelection", idx);
    	   	 			
   	   	 				var thumbnail_url="/images/sns_01.png"; // 이미지 링크
   	   	 			
   	   	 				$("#jqGrid2 tr").each(function(){
	   	   	 				var col1 = $(this).find("td:eq(1)");
	   	   	 				
	   	   	 				$(col1).removeAttr("title");
	   	   	 				var image='<img src="'+thumbnail_url+'" alt="Chargement imagette…" width=100 height=100 />';
			   	   	 		$(col1).qtip({
	                            content: image,
	                            position: {
	                               corner: {
	                                  tooltip: 'bottomMiddle',
	                                  target: 'topMiddle'
	                               }
	                            },
	                            style: {
	                               tip: true, // Give it a speech bubble tip with automatic corner detection
	                               name: 'blue'
	                            }
               				});
    	   	 			});

    	         	}, onSelectRow: function(rowid) {
    	         		var rowData = $(this).getLocalRow(rowid);
    	         		// 공판장 별로 조회
    	      	 		//$('#jqGrid2').showCol('LV_ETC_NM');
    		   	    	var etcLvTitle='등급상세';
    		   	    	var hideLvCd=false;
    		   	    	$('#jqGrid2').showCol('GOOD_NAME');
    		   	    	$('#jqGrid2').showCol('MARKET_NAME');
    		   	    	$('#jqGrid2').showCol('LV_ETC_NM');
    		   	    	if(auctionType =='sCmp'){
    		   	    		$('#jqGrid2').hideCol('MARKET_NAME');
	    		   	    	if(clickStatus == '2'){
	    		   	    		$('#jqGrid2').hideCol('LV_ETC_NM');
	    		   	    		$('#jqGrid2').showCol('GOOD_NAME');
	    		   	    	}else{
	    		   	    		$('#jqGrid2').hideCol('GOOD_NAME');
	    		   	    		$('#jqGrid2').showCol('LV_ETC_NM');
	    		   	    	}
    		   	    	}else{
    		   	    		$('#jqGrid2').hideCol('LV_ETC_NM');
    		   	    		$('#jqGrid2').showCol('MARKET_NAME');
    		   	    		if(clickStatus != '2'){
    		   	    			$('#jqGrid2').hideCol('GOOD_NAME');
    		   	    		}
    		   	    	}

    		   	    	if(auctionType =='sCmp'){
	    	         		if(rowData.CMP_CD=='0000000001'){
	    	         			if(rowData.LV_ETC_NM != '0' && rowData.FLOWER_GUBN=='3'){
	    		   	    			etcLvTitle='가지(송이)';
	    		   	    		}else if(rowData.LV_ETC_NM != '0' && rowData.FLOWER_GUBN=='1'){
	    		   	    			etcLvTitle='송이';
	    		   	    		}else{
	    		   	    			$('#jqGrid2').hideCol('LV_ETC_NM');
	    		   	    		}
	    	         		}else if(rowData.CMP_CD=='1288202296'){
	    	         			$('#jqGrid2').hideCol('LV_ETC_NM');
	    	         		}
    		   	    	}
    	         		$("#jqGrid2").jqGrid( 'setGridWidth', $(".cont_left_b").width());
    	    		    $("#jqGridPager2").jqGrid( 'setGridWidth', $(".cont_left_b").width());
    	    		    $("#gbox_jqGrid2 .ui-jqgrid-bdiv").width($("#gbox_jqGrid2 .ui-jqgrid-bdiv").width()+1);
    	    		    $("#jqGrid2").jqGrid("setLabel", 'LV_ETC_NM', etcLvTitle);

    	         		$("#lvCd").val(rowData.LV_CD);

    	         		if(auctionType == 'sCmp'){
							fnObj.geungme(rowData.PUM_NAME, rowData.GOOD_NAME, rowData.CMP_CD, rowData.FLOWER_GUBN, rowData.LV_CD);
							fnObj.chart_sumary(rowData.PUM_NAME, rowData.GOOD_NAME, rowData.CMP_CD, rowData.FLOWER_GUBN, rowData.LV_CD, '' );
							//fnObj.cmpQtyPer(rowData.PUM_NAME, rowData.GOOD_NAME,rowData.FLOWER_GUBN);
    	         		}else{
    	         			fnObj.geungme(rowData.ITEM_CD, rowData.ITEM_CD2, rowData.CMP_CD, rowData.FLOWER_GUBN, rowData.LV_CD);
    	         			fnObj.chart_sumary(rowData.ITEM_CD, rowData.ITEM_CD2, rowData.CMP_CD, rowData.FLOWER_GUBN, rowData.LV_CD, '');

   	         				if(clickStatus == '3'){
   	         					fnObj.cmpQtyPer(rowData.ITEM_CD, rowData.ITEM_CD2,rowData.FLOWER_GUBN);
   	         				}else if(clickStatus == '2'){
   	         					fnObj.cmpQtyPer(rowData.ITEM_CD, '',rowData.FLOWER_GUBN);
   	         				}

    	         		}
	        		},

    	        });
    	        $('#jqGrid2').navGrid('#jqGridPager2',
    	            // the buttons to appear on the toolbar of the grid
    	            { edit: false, add: false, del: false, search: false, refresh: true, view: false, position: "left", cloneToTop: false },
    	            {
    	                errorTextFormat: function (data) {
    	                    return 'Error: ' + data.responseText
    	                }
    	            },
    	    		{ multipleSearch: true} // search options - define multiple search
    	   		);
    	        $("#jqGrid2").jqGrid("setLabel", "rn", "No.");

    		},
    		geungme : function(pumName, goodName, cmpCd, flowerCd, lvCd){
    			var url = '';
    			if(auctionType =='sCmp'){
    				url = "/haa00_new/selectHaa00InfoJson.json";
    			}else{
    				//url = "/haa00_new/selectHaa00InfoJsonTotal.json";
    			}


    			//var type = $(":input:radio[name=rr]:checked").val();
    			var searchStrDate = "";
         		var searchEndDate = "";
         		if(danCdType){
         			searchStrDate = searchDate;
         			searchEndDate = searchDate;
         		}else{
         			if(dateType == 'day'){
	         			searchStrDate = $("#searchStrDateD").val();
			        	searchEndDate = $("#searchEndDateD").val();
	         		}else if(dateType == 'month'){
	         			searchStrDate = $("#searchStrDateM").val();
			        	searchEndDate = $("#searchEndDateM").val();
	         		}else{
	         			searchStrDate = $("#searchStrDateY").val();
			        	searchEndDate = $("#searchEndDateY").val();
	         		}
         		}

    	    	$.ajax({
    	    		type : "post",
    	    		url : url,
    	    		data : {
    	    			itemCd : pumName,
    	    			itemCd2 : goodName,
    	    			cmpCd : cmpCd,
    	    			flowerCd : flowerCd,
    	    			searchStrDate : searchStrDate,
    	    			searchEndDate : searchEndDate,
    	    			lvCd : lvCd,
    	    			type : dateType
    	    		},
    	    		dataType : '',
    	    		success : function(res){
    	    			var val = res.list;
    	      			    if(val!=null&&val.length>0){
    	       				chartData2 = val;

    	   					if(!document.getElementById("chart2")){
    	   	                	rMateChartH5.create("chart2", "chartHolder2", chartVars2, "100%", "99%");
    	   	            	} else{
								chartReadyHandler2("chart2");
    	   	        		}
    	   				}else{
    	   					chartData2 = [];
    	   					if(!document.getElementById("chart2")){
    	   	                	rMateChartH5.create("chart2", "chartHolder2", chartVars2, "100%", "99%");
    	   	            	} else{
    	   	            		 chartReadyHandler2("chart2");
    	   	        		}
    	   				}
    	    		}
    	    	});
    	    },
    	    chart_sumary: function(pumName, goodName, cmpCd, flowerCd, lvCd, lvEtcNm){
    	    	//var type = $(":input:radio[name=rr]:checked").val();
    	    	var url = "";
    	    	if(auctionType == 'sCmp'){
    	    		url = "/haa00_new/selectHaa00ChartJson.json";
    	    	}else{
    	    		//url = "/haa00_new/selectHaa00ChartJsonTotal.json";
    	    	}

    			var searchStrDate = "";
         		var searchEndDate = "";

         		if(danCdType){
         			searchStrDate = searchDate;
         			searchEndDate = searchDate;
         		}else{
         			if(dateType == 'day'){
	         			searchStrDate = $("#searchStrDateD").val();
			        	searchEndDate = $("#searchEndDateD").val();
	         		}else if(dateType == 'month'){
	         			searchStrDate = $("#searchStrDateM").val();
			        	searchEndDate = $("#searchEndDateM").val();
	         		}else{
	         			searchStrDate = $("#searchStrDateY").val();
			        	searchEndDate = $("#searchEndDateY").val();
	         		}
         		}

    	    	$.ajax({
    				type : "post",
    				url : url,
    				data : {
    					itemCd : pumName,
    					itemCd2 : goodName,
    					cmpCd : cmpCd,
    					flowerCd : flowerCd,
    					searchStrDate : searchStrDate,
    					searchEndDate : searchEndDate,
    	    			lvCd : lvCd,
    	    			lvEtcNm : lvEtcNm,
    	    			type : dateType
    				},
    				dataType : '',
    				success : function(res){
    					var val = res.list;
    					if(val!=null && val.length > 0){
    						chartData = res.list;
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
    		cmpQtyPer : function(pumName, goodName, flowerCd){
    			//var type = $(":input:radio[name=rr]:checked").val();
    			var url ="";
    			if(auctionType == 'sCmp'){
    				url = "/haa00_new/selectHaa00QtyPerJson.json";
    			}else{
    				//url = "/haa00_new/selectHaa00QtyPerJsonTotal.json";
    			}

    			var searchStrDate = "";
         		var searchEndDate = "";

         		if(danCdType){
         			searchStrDate = searchDate;
         			searchEndDate = searchDate;
         		}else{
	         		if(dateType == 'day'){
	         			searchStrDate = $("#searchStrDateD").val();
			        	searchEndDate = $("#searchEndDateD").val();
	         		}else if(dateType == 'month'){
	         			searchStrDate = $("#searchStrDateM").val();
			        	searchEndDate = $("#searchEndDateM").val();
	         		}else{
	         			searchStrDate = $("#searchStrDateY").val();
			        	searchEndDate = $("#searchEndDateY").val();
	         		}
         		}
         		$.ajax({
    				type : "post",
    				url : url,
    				data : {
    					itemCd : pumName,
    					itemCd2 : goodName,
    					flowerCd : flowerCd,
    					searchStrDate : searchStrDate,
    					searchEndDate : searchEndDate,
    	    			type : dateType
    				},
    				dataType : '',
    				success : function(res){
    					var val = res.list;
    					if(val.length > 0){
    						chartData3 = res.list;
    						if(!document.getElementById("chart3")){
    							rMateChartH5.create("chart3", "chartHolder3", chartVars3, "100%", "100%");
    		            	 } else{
    		            		 chartReadyHandler3("chart3");
    		        		}

    					}else{
    						chartData = [];
    						if(!document.getElementById("chart3")){
    							rMateChartH5.create("chart3", "chartHolder3", chartVars3, "100%", "100%");
    		            	 } else{
    		            		 chartReadyHandler3("chart3");
    		        		}
    					}
    				}
    			});



    		},
    		cmpLVPer : function(pumName, goodName, cmpCd, flowerCd, searchStrDate, searchEndDate , itemCd){

    		},

    		// 팝업
    		modalOpen: function () {
    			let dateType = $(":input:radio[name=rr]:checked").val();
    			let strDate = '';
    			let endDate = '';
				if(dateType == "day"){
					strDate = $("#searchStrDateD").val();
					endDate = $("#searchEndDateD").val();
				}else if(dateType == "month"){
					strDate = $("#searchStrDateM").val() + "-01";
					endDate = $("#searchEndDateM").val() + "-31";
				}else{
					strDate = $("#searchStrDateY").val() + "-01-01";
					endDate = $("#searchEndDateY").val() + "-12-31";
				}
				console.log("date", strDate, endDate);
				fnObj.param.strDate = strDate;
				fnObj.param.endDate = endDate;
				console.log("fnObj.param", fnObj.param);
    			multiPopup.openPopup(fnObj.param);
		    }
		};

		function selectFlowerGubnAll(selectAll,gubn){
			var checkboxes = document.getElementsByName(gubn);
			for(var i = 0; i < checkboxes.length; i++){
				checkboxes[i].checked = selectAll.checked;
			}
		}

		//품목검색(정산테이블-일자별)
		function getSalePumList(){
			var url = '';
        	//var type = $(":input:radio[name=rr]:checked").val();
        	//var auctionType = $(":input:radio[name=rr99]:checked").val();
        	var searchStrDate = "";
     		var searchEndDate = "";
     		flowerCd = [];

     		if(auctionType == 'sCmp'){
     			cmpCd = $(":input:radio[name=sCmpCd]:checked").val();
     			url = "/search/selectPumNameCmpDate.json";
     		}else{
     			cmpCd = [];
     			$('input:checkbox[name="tCmpCd"]:checked').each(function(){
           			cmpCd.push($(this).val());
           		})
     			url = "/search/selectPumNameCmpTotal.json";
     		}

     		if(dateType == "day"){
        		searchStrDate = $("#searchStrDateD").val();
            	searchEndDate = $("#searchEndDateD").val();

			}else if(dateType == "month"){
				searchStrDate = $("#searchStrDateM").val();
	        	searchEndDate = $("#searchEndDateM").val();
				if(auctionType == 'tCmp'){
					searchStrDate += '-01';
		        	searchEndDate += '-31';
				}

			}else{
				searchStrDate = $("#searchStrDateY").val();
	        	searchEndDate = $("#searchEndDateY").val();
	        	if(auctionType == 'tCmp'){
	        		searchStrDate += '-01-01';
		        	searchEndDate += '-12-31';
				}

			}

    		$('input:checkbox[name="flowerGubn"]:checked').each(function(){
    			flowerCd.push($(this).val());
    		})
			/*
			$.ajax({
				type : 'post',
				url : url,
				data : {
					cmpCd : cmpCd,
					flowerCd : flowerCd,
					searchStrDate : searchStrDate,
					searchEndDate : searchEndDate,
					type : dateType
				},
				beforeSend: function() {
					$('#progress_loading').show();
			    },
			    complete: function() {
			    	$('#progress_loading').hide();
			    },
				dataType : '',
				success : function(res) {
					if(res.list.length>0){
						$("#itemCd").html("");
						$("#itemCd").append("<option value='' selected>전체</option>");
						if(auctionType == 'sCmp'){

							for(var i=0;i<res.list.length;i++){
								$("#itemCd").append("<option value='"+res.list[i].PUM_NAME+"'>"+res.list[i].PUM_NAME+"</option>");
							}
							//fnObj.setPage();
							getSaleGoodList();

						}else{
							for(var i=0;i<res.list.length;i++){
								$("#itemCd").append("<option value='"+ res.list[i].FLOWER_CODE + res.list[i].ITEM_CD+"'"+">"+res.list[i].ITEM_NM+"</option>");
							}

							getSaleGoodList();
						}
					}else{
						$("#itemCd").html("");
						$("#itemCd").append("<option value='' selected>데이터 없음</option>");
						// 검색하여 값 초기화
						//fnObj.setPage();
					}

				},
			});
    		*/
		}

		//품종검색(정산테이블-일자별)
		function getSaleGoodList(){
			//var auctionType = $(":input:radio[name=rr99]:checked").val();
			var itemCd = $('#itemCd option:selected').val();
			flowerCd = [];
			var searchStrDate = "";
			var searchEndDate = "";
			//var type = $(":input:radio[name=rr]:checked").val();
			var url = '';
			if(auctionType == 'sCmp'){
     			cmpCd = $(":input:radio[name=sCmpCd]:checked").val();
     			url = "/search/selectGoodNameCmpDate.json";
     		}else{
           		cmpCd = [];
     			$('input:checkbox[name="tCmpCd"]:checked').each(function(){
           			cmpCd.push($(this).val());
           		})
     			url = "/search/selectGoodNameCmpTotal.json";
     		}

			if(dateType == "day"){
        		searchStrDate = $("#searchStrDateD").val();
            	searchEndDate = $("#searchEndDateD").val();

			}else if(dateType == "month"){
				searchStrDate = $("#searchStrDateM").val();
	        	searchEndDate = $("#searchEndDateM").val();
				if(auctionType == 'tCmp'){
					searchStrDate += '-01';
		        	searchEndDate += '-31';
				}

			}else{
				searchStrDate = $("#searchStrDateY").val();
	        	searchEndDate = $("#searchEndDateY").val();
	        	if(auctionType == 'tCmp'){
	        		searchStrDate += '-01-01';
		        	searchEndDate += '-12-31';
				}

			}


			$('input:checkbox[name="flowerGubn"]:checked').each(function(){
       			flowerCd.push($(this).val());
       		})
			/*
			if(itemCd!=null && itemCd!=''){
				$.ajax({
					type : "post",
		    		url : url,
		    		data : {
		    			flowerCd : flowerCd,
		    			searchStrDate : searchStrDate,
		    			searchEndDate : searchEndDate,
		    			cmpCd : cmpCd,
		    			itemCd : itemCd,
		    			type : dateType
		    		},
					dataType : '',
					success : function(res) {
						$("#itemCd2").html("");
						$("#itemCd2").append("<option value='' selected>전체</option>");
						if(auctionType == 'sCmp'){
							for(var i=0;i<res.list.length;i++){
								$("#itemCd2").append("<option value='"+res.list[i].GOOD_NAME+"'>"+res.list[i].GOOD_NAME+"</option>");
							}
						}else{
							for(var i=0;i<res.list.length;i++){
								$("#itemCd2").append("<option value='"+ res.list[i].FLOWER_CODE + res.list[i].ITEM_CD + res.list[i].KIND_CD +"'"+">"+res.list[i].KIND_NM+"</option>");
							}
						}
					},
				});
			}else{
				$("#itemCd2").html("");
				$("#itemCd2").append("<option value='' selected>품목미선택</option>");
			}
			*/
		}

		function isEmptyArr(arr)  {
			if(Array.isArray(arr) && arr.length === 0)  {
				return true;
		}

		    return false;
		}

		function custonSort(a, b) {
			if(a.GOOD_NAME == b.GOOD_NAME){ return 0} return  a.GOOD_NAME > b.GOOD_NAME ? 1 : -1;
		}

		function qtySort(a, b){
			if(a.totQty == b.totQty){ return 0} return  a.totQty < b.totQty ? 1 : -1;
		}
		
		function chartHolderBtnClick(){
			// png 포맷으로 내보내기
			rMateChartH5.downloadToLocal("rMateChartH5", "png",
			"/rMateChartSamples/SnapshotServerSamples/downloadLocal.jsp",
			function() {
			return document.getElementById("chartHolder").saveAsImage();
			});
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
				<li class="m_right">기간별 경매통계 조회</li>
			</ul>
		</div>
		<!--sub 헤더 (E)-->
		<!--서브 타이틀(S)-->

		<jsp:include page="../inc/2020/IncShare.jsp"/>

		<div class="sub_title">
			<div class="title_box">
				<h2 class="sub_tit">기간별 경매통계 조회</h2>
				<p>전국 화훼공판장의 경매정보를 확인 할 수 있습니다.</p>
				<img src="../images/2020/sub/t_line.png" alt="방울점선">
			</div>
		</div>

		<!--서브 타이틀(E)-->
		<!--서브공통 (S)-->
		<div class="sub_contents">
		<div class="sub_info_box">
					<div class="tit_box_01">
						<div class="fr">
							<div class="dwn_bt_b btn_h_45" >
								<a class="reset_btn" href="javascript:fnObj.resetParam();"><img src="../images/main/btn_refresh_w.png" alt="초기화"> 초기화</a>
							</div>
							<div class="dwn_bt_b btn_h_45" >
								<a class="search_btn_n" href="javascript:fnObj.setPage();"><img src="../images/2020/sub/search_img.png" alt="돋보기"> 검색</a>
							</div>

						</div>
					</div>
				</div>

			<div class="search_box_new statistic">			
				<input type="hidden" id="searchStrDate" value="${searchStrDate}">
				<input type="hidden" id="searchEndDate" value="${searchEndDate}">				
				<div class="s-line">
					<h4 class="sbn_tit_01">구분</h4>
					<ul class="grow_check_box width_a">
						<li>
							<input type="radio" id="rr66" name="rr99" value="sCmp" checked>
							<label for="rr66" class="title_box_chk"><em class="txt">개별</em><span></span></label>
						</li>
						<li>
							<input type="radio" id="rr77" name="rr99" value="tCmp">
							<label for="rr77" class="title_box_chk"><em class="txt">통합(합산)</em><span></span></label>
						</li>
					</ul>
					

				</div>

				<div class="s-line">
					<h4 class="sbn_tit_01">기간</h4>
					<div class="sb_common_01 pack-01" style="    padding-top: 5px !important;">
						<div class="date-from-to" id="searchDateD" >
							<ul class="grow_check_box" style="    margin-left: 0px;">
								<li>
									<input type="radio" id="rr33" name="rr1" value="day">
									<label for="rr33" class="title_box_chk"><em class="txt">당일</em><span></span></label>
								</li>
								<li>
									<input type="radio" id="rr44" name="rr1" value="week" checked>
									<label for="rr44" class="title_box_chk"><em class="txt">1주일</em><span></span></label>
								</li>
								<li>
									<input type="radio" id="rr55" name="rr1" value="month">
									<label for="rr55" class="title_box_chk"><em class="txt">1개월</em><span></span></label>
								</li>
								<li>
									<input type="radio" id="rr88" name="rr1" value="month">
									<label for="rr88" class="title_box_chk"><em class="txt">기간</em><span></span></label>
								</li>
							</ul>

							<div class="calendar_new">
								<input type="text" alt="켈린더" id="searchStrDateD" value="${searchStrDate}" readonly/>
							</div>
							<span class="hyphen">~</span>
							<div class="calendar_new">
								<input type="text" alt="켈린더" id="searchEndDateD" value="${searchEndDate}" readonly/>
							</div>
							<label style="color: red;">※ 기간조회는 최대3년까지 가능합니다.</label>
							
						</div>
						
						<div class="date-from-to" id="searchDateM">
							<div class="calendar_new">
								<input type="text" alt="켈린더" class="calendar_focus" id="searchStrDateM" value="${searchStrDateM}" onClick="calendarShow(this.id);"/>
							</div>
							<span class="hyphen">~</span>
							<div class="calendar_new">
								<input type="text" alt="켈린더" class="calendar_focus" id="searchEndDateM" value="${searchEndDateM}" onClick="calendarShow(this.id);"/>
							</div>
							<label style="color: red;">※ 기간조회는 최대3년까찌 가능합니다.</label>
						</div>
						<div class="date-from-to" id="searchDateY">
							<div class="calendar_new">
								<input type="text" alt="켈린더" class="calendar_focus" id="searchStrDateY" value="${searchStrDateY}" onClick="calendarShow(this.id);"/>
							</div>
							<span class="hyphen">~</span>
							<div class="calendar_new">
								<input type="text" alt="켈린더" class="calendar_focus" id="searchEndDateY" value="${searchEndDateY}" onClick="calendarShow(this.id);"/>
							</div>
							<label style="color: red;">※ 기간조회는 최대3년까지 가능합니다.</label>
							
						</div>
						
					</div>
					
							
					
				</div>

				<div class="s-line">
					<h4 class="sbn_tit_01">조회단위</h4>
					<ul class="grow_check_box">
						<li>
							<input type="radio" id="rr00" name="rr" value="day" checked>
							<label for="rr00" class="title_box_chk"><em class="txt">일</em><span></span></label>
						</li>
						<li>
							<input type="radio" id="rr11" name="rr" value="month">
							<label for="rr11" class="title_box_chk"><em class="txt">월</em><span></span></label>
						</li>
						<li>
							<input type="radio" id="rr22" name="rr" value="year">
							<label for="rr22" class="title_box_chk"><em class="txt">연</em><span></span></label>
						</li>
					</ul>
				</div>

				<div class="s-line">
					<h4 class="sbn_tit_01">집계단위</h4>
					<ul class="grow_check_box width_a ">
						<li>
							<input type="checkbox" id="chk00-02" name="gubn" value="1">
							<label for="chk00-02" class="title_box_chk"><em class="txt">부류별</em><span></span></label>
						</li>
						<li>
							<input type="checkbox" id="chk11-02" name="gubn" value="2" checked>
							<label for="chk11-02" class="title_box_chk"><em class="txt">품목별</em><span></span></label>
						</li>
						<li>
							<input type="checkbox" id="chk22-02" name="gubn" value="3">
							<label for="chk22-02" class="title_box_chk"><em class="txt">품종별</em><span></span></label>
						</li>
						<li>
							<input type="checkbox" id="chk33-02" name="gubn" onclick='selectFlowerGubnAll(this,"gubn")' value="4">
							<label for="chk33-02" class="title_box_chk"><em class="txt">전체</em><span></span></label>
						</li>
					</ul>
					<div class="search_btn">
						<a href="javascript:fnObj.modalOpen();">상세조건</a>
					</div>

				</div>
				

				<!--
				<div class="s-line">
						<h4 class="sbn_tit_01">부류</h4>
						<ul class="grow_check_box">
							<li>
								<input type="checkbox" id="chk01" name="flowerGubn" value="1" checked>
								<label for="chk01" class="title_box_chk"><em class="txt">절화</em><span></span></label>
							</li>
							<li>
								<input type="checkbox" id="chk02" name="flowerGubn" value="3">
								<label for="chk02" class="title_box_chk"><em class="txt">난</em><span></span></label>
							</li>
							<li>
								<input type="checkbox" id="chk03" name="flowerGubn" value="2">
								<label for="chk03" class="title_box_chk"><em class="txt">관엽</em><span></span></label>
							</li>
							<li>
								<input type="checkbox" id="chk04" name="flowerGubn" value="4">
								<label for="chk04" class="title_box_chk"><em class="txt">춘란</em><span></span></label>
							</li>
							<li>
								<input type="checkbox" id="chk05" name="flowerGubn" onclick='selectFlowerGubnAll(this,"flowerGubn")' value="5">
								<label for="chk05" class="title_box_chk"><em class="txt">전체</em><span></span></label>
							</li>
						</ul>
				</div>
				<div class="s-line">
					<h4 class="sbn_tit_01">경매장</h4>
					<ul class="grow_check_box" id="sCmp">
						<li>
							<input type="radio" id="chk000" name ="sCmpCd" value='0000000001' checked>
							<label for="chk000" class="title_box_chk"><em class="txt">aT화훼(양재)</em><span></span></label>
						</li>
						<li>
							<input type="radio" id="chk011" name ="sCmpCd" value="1508500020">
							<label for="chk011" class="title_box_chk"><em class="txt">부산화훼(엄궁)</em><span></span></label>
						</li>
						<li>
							<input type="radio" id="chk022" name ="sCmpCd" value="6068207466">
							<label for="chk022" class="title_box_chk"><em class="txt">부경화훼(강동)</em><span></span></label>
						</li>
						<li>
							<input type="radio" id="chk033" name ="sCmpCd" value="4108212335">
							<label for="chk033" class="title_box_chk"><em class="txt">광주원예(풍암)</em><span></span></label>
						</li>
						<li>
							<input type="radio" id="chk044" name ="sCmpCd" value="3848200087">
							<label for="chk044" class="title_box_chk"><em class="txt">한국화훼(음성)</em><span></span></label>
						</li>
						<li>
							<input type="radio" id="chk055" name ="sCmpCd" value="1288202296">
							<label for="chk055" class="title_box_chk"><em class="txt">한국화훼(과천)</em><span></span></label>
						</li>
						<li>
							<input type="radio" id="chk066" name ="sCmpCd" value="6158209828">
							<label for="chk066" class="title_box_chk"><em class="txt">영남화훼(김해)</em><span></span></label>
						</li>
					</ul>


					<ul class="grow_check_box" id="tCmp">
						<li>
							<input type="checkbox" id="chk100" name ="tCmpCd" value='0000000001' checked>
							<label for="chk100" class="title_box_chk"><em class="txt">aT화훼(양재)</em><span></span></label>
						</li>
						<li>
							<input type="checkbox" id="chk111" name ="tCmpCd" value="1508500020">
							<label for="chk111" class="title_box_chk"><em class="txt">부산화훼(엄궁)</em><span></span></label>
						</li>
						<li>
							<input type="checkbox" id="chk122" name ="tCmpCd" value="6068207466">
							<label for="chk122" class="title_box_chk"><em class="txt">부경화훼(강동)</em><span></span></label>
						</li>
						<li>
							<input type="checkbox" id="chk133" name ="tCmpCd" value="4108212335">
							<label for="chk133" class="title_box_chk"><em class="txt">광주원예(풍암)</em><span></span></label>
						</li>
						<li>
							<input type="checkbox" id="chk144" name ="tCmpCd" value="3848200087">
							<label for="chk144" class="title_box_chk"><em class="txt">한국화훼(음성)</em><span></span></label>
						</li>
						<li>
							<input type="checkbox" id="chk155" name ="tCmpCd" value="1288202296">
							<label for="chk155" class="title_box_chk"><em class="txt">한국화훼(과천)</em><span></span></label>
						</li>
						<li>
							<input type="checkbox" id="chk166" name ="tCmpCd" value="6158209828">
							<label for="chk166" class="title_box_chk"><em class="txt">영남화훼(김해)</em><span></span></label>
						</li>
						<li>
							<input type="checkbox" id="chk177" name ="tCmpCd" onclick='selectFlowerGubnAll(this,"tCmpCd")'>
							<label for="chk177" class="title_box_chk"><em class="txt">전체</em><span></span></label>
						</li>
					</ul>
				</div>



				<div class="s-line">
					<h4 class="sbn_tit_01">품목</h4>
					<div class="sb_common_01">
						<select class="form-control" id="itemCd" name="itemCd">
						</select>
					</div>
				</div>
				<div class="s-line">
					<h4 class="sbn_tit_01">품종</h4>
					<div class="sb_common_01">
						<select class="form-control" id="itemCd2" name="itemCd">
						</select>
					</div>
				</div>
				-->


				<!-- 로딩바(S) -->
				<div id="progress_loading">
					<img src="../../images/loadingBar.gif"/>
				</div>
				<!-- 로딩바(E) -->

			</div>

		</div>
		<!--컨텐츠 내용(S)-->



		<!--컨텐츠 내용(S)-->
		<div class="sub_guide">

			<!-- 테이블(S) -->
			<div class="guide">
				<ul class="guide_box">
					<li><pre><span class="guide_box_span detail_title">상세조건</span></pre></li>
					<li><span class="guide_box_span"><br></span></li>
					<li><pre><span class="guide_box_span"><strong>1.부류 선택내역    : </strong></span><span class="flower__text param__info"></span></pre></li>
					<li><pre><span class="guide_box_span"><strong>2.경매장 선택내역 : </strong></span><span class="market__text param__info"></span></pre></li>
					<li><pre><span class="guide_box_span"><strong>3.품목 선택내역    : </strong></span><span class="item__text param__info"></span></pre></li>
					<li><pre><span class="guide_box_span"><strong>4.품종 선택내역    : </strong></span><span class="itemDtl__text param__info"></span></pre></li>
				</ul>
			</div>


			<div class="sub_info_box">
				<div class="tit_box_01">
					<div class="fl">
						<h2 class="title_02">경매정보</h2>
					</div>

					<div class="fr">
						<!-- <div class="icon-box tr">
							<span class="guide-icon width-scroll"></span>
						</div> -->
						<div class="dwn_bt_b" id="excelBtn1"><a href="#!"><img src="../images/2020/exel.png" alt="엑셀이미지">엑셀저장</a></div><br/>
						<span class="txt-unit">(단위 : 단/원)</span>
					</div>
				</div>

				<div class="info_box">
				    <table id="jqGrid" class="boxList" ></table>
				    <div id="jqGridPager" style="height:35px;"></div>
				</div>
			</div>


			<!-- 테이블(E) -->

			<div class="data_content_b">
				<div class="cont_left_b">
					<div class="cont_box_b">
						<div class="sub_info_box">
							<h2 class="title_02">등급정보</h2>
							<div class="info_box h-type-01">
								<table id="jqGrid2" class="boxList"></table>
								<div id="jqGridPager2" style="height:35px;"></div>
							</div>
						</div>
					</div>
				</div>
				<div class="cont_right_b">
					<div class="cont_box_b">
						<div class="sub_info_box">
							<div class="fl">
								<h2 class="title_02">거래동향</h2>
							</div>
		
							<div class="fr">
								<!-- <div class="icon-box tr">
									<span class="guide-icon width-scroll"></span>
								</div> -->
								<div class="dwn_bt_b" id="chartHolderBtn" onclick="chartHolderBtnClick()"><a href="#!">차트저장</a></div>
							</div>
							<div class="info_box h-type-01" id="chartHolder" style="width:100%; height:340px;">
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="data_content_b">
				<div class="cont_left_b">
					<div class="cont_box_b">
						<div class="sub_info_box">
							<h2 class="title_02">거래금액분포도</h2>
							<div class="info_box h-type-01" id="chartHolder2" style="width:100%; height:340px;">
							</div>
						</div>
					</div>
				</div>
				<div class="cont_right_b">
					<div class="cont_box_b">
						<div class="sub_info_box">
							<h2 class="title_02" id="typeText">등급별비중</h2>
							<div class="info_box h-type-01"  id="chartHolder3" style="width:100%; height:340px;">


							</div>
						</div>
					</div>
				</div>
			</div>


		</div>
		<!--컨텐츠 내용(E)-->

		<div class="guide">
			<h2 class="title_02">이용안내</h2>
			<ul class="guide_box">
				<li>· 경매통계를 기간별로 분석 할수 있는 화면 </li>
				<li>· 단위 : 단(속), 단가(원) / 자료출처 : 각 공판장별 경매 자료 현황</li>
				<li>· 단순집계 자료이므로 <strong>참고자료</strong>로만 활용하시기 바랍니다.</li>
				<li>- 개별 : 공판장별 경매결과 단순집계</li>
				<li>- 통합 : 공판장별 경매결과를 임의통합하여 집계(누락정보가 있을 수 있음)</li>
			</ul>
		</div>

		<jsp:include page="../inc/2020/IncFooter.jsp"/>
	</div>
	<!--WRAP(E)-->

	<!-- POPUP (S)-->
	<!-- The Modal -->
	<div id="multiPopup" class="modal">
	<div class="modal-content">
	    <div class="modal-body">
			<jsp:include page="../popup/multi_popup.jsp"/>
	    </div>
	  </div>   
	</div>
<script>
	multiPopup.init(function(rs) {
		fnObj.setPopupParam(rs);
	});
</script>
<div id="imageModalContent"  >
<img id="imageModalArea" />
</div>
	<!-- POPUP (E)-->
</body>
