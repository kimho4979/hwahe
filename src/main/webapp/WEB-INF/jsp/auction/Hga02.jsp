<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, user-scalable=no">
	<meta name="apple-mobile-web-app-title" content="화훼유통정보시스템">
	<meta name="robots" content="no-index,follow">
	<meta name="og:title" content="화훼유통정보시스템">
	<meta name="og:description" content="화훼유통정보시스템">
	<meta name="description" content="기상동향 분석">
	<meta name="content" content="화훼유통정보시스템 입니다.">
	<meta name="keywords" content="화훼경매시세, 화훼경매가격, Korea aT flower market auction price, 화훼공판장, 화훼거래정보, 꽃시장, 꽃값">
	<meta name="Author" content="화훼유통정보시스템 & www.woorim.co.kr">
	<title>기상동향 분석</title>

	<%@include file="../common/2020/commonJs.jsp" %>	
	<%@include file="../common/2020/commonCss.jsp" %>
	<script type="text/javascript">
	
		//-----------------------기상동향 차트 설정 시작-----------------------
		
		//rMate 차트 생성 준비가 완료된 상태 시 호출할 함수를 지정합니다.
		var chartVars = "rMateOnLoadCallFunction=chartReadyHandler";
		
		//rMateChart 를 생성합니다.
		//파라메터 (순서대로) 
		//1. 차트의 id ( 임의로 지정하십시오. ) 
		//2. 차트가 위치할 div 의 id (즉, 차트의 부모 div 의 id 입니다.)
		//3. 차트 생성 시 필요한 환경 변수들의 묶음인 chartVars
		//4. 차트의 가로 사이즈 (생략 가능, 생략 시 100%)
		//5. 차트의 세로 사이즈 (생략 가능, 생략 시 100%)
		rMateChartH5.create("chart1", "chartHolder", chartVars, "100%", "100%"); 
		
		//차트의 속성인 rMateOnLoadCallFunction 으로 설정된 함수.
		//rMate 차트 준비가 완료된 경우 이 함수가 호출됩니다.
		//이 함수를 통해 차트에 레이아웃과 데이터를 삽입합니다.
		//파라메터 : id - rMateChartH5.create() 사용 시 사용자가 지정한 id 입니다.
		function chartReadyHandler(id) {
			document.getElementById(id).setLayout(layoutStr);
			document.getElementById(id).setData(chartData);
			//checkData(chartData);
		}
		
		//스트링 형식으로 레이아웃 정의.
		var layoutStr = 
			'<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'
				+'<Options>'
					+'<Legend useVisibleCheck="true" horizontalGap="0" position="bottom" horizontalScrollPolicy="off"/>'
				+'</Options>'
				+'<NumberFormatter id="numFmt" useThousandsSeparator="true"/>'
				+'<Combination2DChart showDataTips="true">'
		              /* Combination2D 차트 생성시에 필요한 Combination2DChart 정의합니다 
		            	showDataTips : 데이터에 마우스를 가져갔을 때 나오는 Tip을 보이기/안보이기 속성입니다 */    
					+'<horizontalAxis>'
						+'<CategoryAxis categoryField="fcstDate" padding="1"/>'
					+'</horizontalAxis>'
					+'<verticalAxis>'
						+'<LinearAxis id="vAxis1" interval="10" formatter="{numFmt}" title="℃" maximum="40"/>'
					+'</verticalAxis>'
				+'<series>'
					+'<Line2DSeries labelPosition="up" showMinValueLabel="true" showMaxValueLabel="true" yField="maxT3h"  radius="3"  lineStyle="dashLine" dashLinePattern="2" dashLineSeperatePos="7" dashLinePlacement="after" itemRenderer="CircleItemRenderer" displayName="최고기온">'
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
					+'<Line2DSeries labelPosition="up" showMinValueLabel="true" showMaxValueLabel="true" yField="minT3h"  radius="3"  lineStyle="dashLine" dashLinePattern="2" dashLineSeperatePos="7" dashLinePlacement="after" itemRenderer="CircleItemRenderer" displayName="최저기온">'
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
					+'<Column2DSet type="clustered">'
						+'<series>'
							+'<Column2DSeries yField="r06" displayName="강수량" labelPosition="up" showMaxValueLabel="true" >'
								+'<fill>'
									+'<SolidColor color="#86E57F"/>'
								+'</fill>'
								+'<verticalAxis>'
		                        +'<LinearAxis id="vAxis2" interval="10" formatter="{numFmt}" minimum="0" maximum="100"  title="mm"/>'
		                      +'</verticalAxis>'
								+'<showDataEffect>'
									+'<SeriesInterpolate/>'
								+'</showDataEffect>'
							+'</Column2DSeries>'
						+'</series>'
					+'</Column2DSet>'
				+'</series>'
				+'<verticalAxisRenderers>'
					+'<Axis2DRenderer axis="{vAxis1}" showLine="false" />'
					+'<Axis2DRenderer axis="{vAxis2}" showLine="false" />'
				+'</verticalAxisRenderers>'
			+'</Combination2DChart>'
			+'</rMateChart>';
		
		//차트 데이터
		var chartData = [];
		
		/**
		* rMateChartH5 3.0이후 버전에서 제공하고 있는 테마기능을 사용하시려면 아래 내용을 설정하여 주십시오.
		* 테마 기능을 사용하지 않으시려면 아래 내용은 삭제 혹은 주석처리 하셔도 됩니다.
		*
		* -- rMateChartH5.themes에 등록되어있는 테마 목록 --
		* - simple
		* - cyber
		* - modern
		* - lovely
		* - pastel
		* -------------------------------------------------
		*
		* rMateChartH5.themes 변수는 theme.js에서 정의하고 있습니다.
		*/
		rMateChartH5.registerTheme(rMateChartH5.themes);
		
		/**
		* 샘플 내의 테마 버튼 클릭 시 호출되는 함수입니다.
		* 접근하는 차트 객체의 테마를 변경합니다.
		* 파라메터로 넘어오는 값
		* - simple
		* - cyber
		* - modern
		* - lovely
		* - pastel
		* - default
		*
		* default : 테마를 적용하기 전 기본 형태를 출력합니다.
		*/
		function rMateChartH5ChangeTheme(theme){
			document.getElementById("chart1").setTheme(theme);
		}
		
		/* function checkData(data){
			if(data.length <= 0){
				// 데이터가 없을 경우 hasNoData함수를 실행하여 메세지창을 출력한다.
				document.getElementById("chart1").hasNoData(true);
				// hasNoData(false); - 데이터가 존재하지 않으므로 차트의 기본 구조도 보이지 않아야 한다면 false로 주어 차트 전체의 visible을 false로 설정합니다.
				// hasNoData(true);  - 데이터가 존재하지 않아도 차트의 기본 구조는 보여야 한다면 true로 주어 visible을 true로 설정합니다.
			}
		} */
		
		//-----------------------기상동향 차트 설정 끝 -----------------------
		
		var sidoCd = null;
		$(function(){
			$("#excelBtn1").empty();
			$("#excelBtn1").append('<button class="excelSaveBtn" id="exportBtn1" name="exportTable1" onclick="excelExport();">엑셀저장</button>');
			
			$('#sido').select2();
			$('#gugun').select2();
			getSido();
			getItem();
		});
		
		function excelExport(){
			var excelNm = "기상동향분석";
			if(sidoCd == null){
				sidoCd = '1114000000';
			}else{
				sidoCd = $("#gugun").val();
			}
			var param = "?excelNm="+excelNm+"&sidoCd="+sidoCd;
			location.href = "/excel/excelDownLoad.do"+param;
		}
		
		function getSido(){
			$.ajax({
				type : "post",
				url : "/hga02/selectGetSido.json",
				data : {},
				dataType : '',
				success : function(res){
					var val = res.list;
					
					$("#sido").empty();
					for(var i=0; i<val.length; i++){
						$("#sido").append("<option value="+val[i].areaCd+">"+val[i].sidoNm+"</option>");
					}
					
					var gugun = res.gugun;
					
					$("#gugun").empty();
					for(var i=0; i<gugun.length; i++){
						$("#gugun").append("<option value="+gugun[i].areaCd+">"+gugun[i].gunNm+"</option>");
					}
				}
			});
		}
		
		function getGugun(selSido){
			var sidoNm=$(selSido).children("option:selected").text();
			
			$.ajax({
				type : "post",
				url : "/hga02/selectGetSido.json",
				data : {
					sidoNm : sidoNm
				},
				dataType : '',
				success : function(res){
					var gugun = res.gugun;
					
					$("#gugun").empty();
					for(var i=0; i<gugun.length; i++){
						$("#gugun").append("<option value="+gugun[i].areaCd+">"+gugun[i].gunNm+"</option>");
					}
				}
			});
		}
		
		function getItem(){
			if(sidoCd == null){
				sidoCd = '1114000000';
			}else{
				sidoCd = $("#gugun").val();
			}
			$.ajax({
				type : "post",
				url : "/hga02/selectGetItemList.json",
				data : {
					sidoCd : sidoCd
				},
				dataType : '',
				success : function(res){
					var val = res.list;
					if(val!=null&&val.length>0){
						$("#weather01").empty();
						$("#weather01etc").empty();
						$("#weather01txt").text("오늘("+val[0].fcstDate+")");
						$("#weather01etc").append("<p><span>강수량 :"+val[0].r06+"</span><span class='line_of'>ㅣ</span><span> 습도 :"+val[0].reh+"%</span></p>");
						if(val[0].sky == '1'){
							//$("#weather01").append("<img class='weather_icon' src='/images/content/weather01.png' alt='맑음'><span class='weather_txt'><span class='ft_blue'>"+val[0].minT3h+"℃</span><span class='bar'>/</span><span class='ft_red'>"+val[0].maxT3h+"℃</span><span class='weather_subTxt'>강수량: "+val[0].r06+"mm / 습도: "+val[0].reh+"%</span></span>");		
							$("#weather01").append("<li><img src='../images/2020/weather01.png' alt='맑음'></li><li><span class='wt_blue'>"+val[0].minT3h+"℃</span><span>/</span><span class='wt_red'>"+val[0].maxT3h+"℃</span></li>");
						}else if(val[0].sky == '2'){
							//$("#weather01").append("<img class='weather_icon' src='/images/content/weather02.png' alt='구름조금'><span class='weather_txt'><span class='ft_blue'>"+val[0].minT3h+"℃</span><span class='bar'>/</span><span class='ft_red'>"+val[0].maxT3h+"℃</span><span class='weather_subTxt'>강수량: "+val[0].r06+"mm / 습도: "+val[0].reh+"%</span></span>");
							$("#weather01").append("<li><img src='../images/2020/weather02.png' alt='구름조금'></li><li><span class='wt_blue'>"+val[0].minT3h+"℃</span><span>/</span><span class='wt_red'>"+val[0].maxT3h+"℃</span></li>");
						}else if(val[0].sky == '3'){
							//$("#weather01").append("<img class='weather_icon' src='/images/content/weather03.png' alt='구름많음'><span class='weather_txt'><span class='ft_blue'>"+val[0].minT3h+"℃</span><span class='bar'>/</span><span class='ft_red'>"+val[0].maxT3h+"℃</span><span class='weather_subTxt'>강수량: "+val[0].r06+"mm / 습도: "+val[0].reh+"%</span></span>");
							$("#weather01").append("<li><img src='../images/2020/weather03.png' alt='구름많음'></li><li><span class='wt_blue'>"+val[0].minT3h+"℃</span><span>/</span><span class='wt_red'>"+val[0].maxT3h+"℃</span></li>");
						}else if(val[0].sky == '4'){
							if(val[0].pty == '0'){
								//$("#weather01").append("<img class='weather_icon' src='/images/content/weather04.png' alt='맑음/비'><span class='weather_txt'><span class='ft_blue'>"+val[0].minT3h+"℃</span><span class='bar'>/</span><span class='ft_red'>"+val[0].maxT3h+"℃</span><span class='weather_subTxt'>강수량: "+val[0].r06+"mm / 습도: "+val[0].reh+"%</span></span>");
								$("#weather01").append("<li><img src='../images/2020/weather04.png' alt='맑음/비'></li><li><span class='wt_blue'>"+val[0].minT3h+"℃</span><span>/</span><span class='wt_red'>"+val[0].maxT3h+"℃</span></li>");
							}else if(val[0].pty == '1'||val[0].pty == '2'){
								//$("#weather01").append("<img class='weather_icon' src='/images/content/weather05.png' alt='비'><span class='weather_txt'><span class='ft_blue'>"+val[0].minT3h+"℃</span><span class='bar'>/</span><span class='ft_red'>"+val[0].maxT3h+"℃</span><span class='weather_subTxt'>강수량: "+val[0].r06+"mm / 습도: "+val[0].reh+"%</span></span>");
								$("#weather01").append("<li><img src='../images/2020/weather05.png' alt='비'></li><li><span class='wt_blue'>"+val[0].minT3h+"℃</span><span>/</span><span class='wt_red'>"+val[0].maxT3h+"℃</span></li>");
							}else{
								//$("#weather01").append("<img class='weather_icon' src='/images/content/weather05_1.png' alt='눈'><span class='weather_txt'><span class='ft_blue'>"+val[0].minT3h+"℃</span><span class='bar'>/</span><span class='ft_red'>"+val[0].maxT3h+"℃</span><span class='weather_subTxt'>강수량: "+val[0].r06+"mm / 습도: "+val[0].reh+"%</span></span>");
								$("#weather01").append("<li><img src='../images/2020/weather05_1.png' alt='눈'></li><li><span class='wt_blue'>"+val[0].minT3h+"℃</span><span>/</span><span class='wt_red'>"+val[0].maxT3h+"℃</span></li>");
							}
						}
						
						$("#weather02").empty();
						$("#weather02etc").empty();
						$("#weather02txt").text("내일("+val[1].fcstDate+")");
						$("#weather02etc").append("<p><span>강수량 :"+val[1].r06+"</span><span class='line_of'>ㅣ</span><span> 습도 :"+val[1].reh+"%</span></p>");
						if(val[1].sky == '1'){
							$("#weather02").append("<li><img src='../images/2020/weather01.png' alt='맑음'></li><li><span class='wt_blue'>"+val[1].minT3h+"℃</span><span>/</span><span class='wt_red'>"+val[1].maxT3h+"℃</span></li>");
						}else if(val[1].sky == '2'){
							$("#weather02").append("<li><img src='../images/2020/weather02.png' alt='구름조금'></li><li><span class='wt_blue'>"+val[1].minT3h+"℃</span><span>/</span><span class='wt_red'>"+val[1].maxT3h+"℃</span></li>");
						}else if(val[1].sky == '3'){
							$("#weather02").append("<li><img src='../images/2020/weather03.png' alt='구름많음'></li><li><span class='wt_blue'>"+val[1].minT3h+"℃</span><span>/</span><span class='wt_red'>"+val[1].maxT3h+"℃</span></li>");
						}else if(val[1].sky == '4'){
							if(val[1].pty == '0'){
								$("#weather02").append("<li><img src='../images/2020/weather04.png' alt='맑음/비'></li><li><span class='wt_blue'>"+val[1].minT3h+"℃</span><span>/</span><span class='wt_red'>"+val[1].maxT3h+"℃</span></li>");
							}else if(val[1].pty == '1'|| val[1].pty == '2'){
								$("#weather02").append("<li><img src='../images/2020/weather05.png' alt='비'></li><li><span class='wt_blue'>"+val[1].minT3h+"℃</span><span>/</span><span class='wt_red'>"+val[1].maxT3h+"℃</span></li>");
							}else{
								$("#weather02").append("<li><img src='../images/2020/weather05_1.png' alt='눈'></li><li><span class='wt_blue'>"+val[1].minT3h+"℃</span><span>/</span><span class='wt_red'>"+val[1].maxT3h+"℃</span></li>");
							}
						}
						$("#weather03").empty();
						$("#weather03etc").empty();
						$("#weather03txt").text("모레("+val[2].fcstDate+")");
						$("#weather03etc").append("<p><span>강수량 :"+val[2].r06+"</span><span class='line_of'>ㅣ</span><span> 습도 :"+val[2].reh+"%</span></p>");
						if(val[2].sky == '1'){
							$("#weather03").append("<li><img src='../images/2020/weather01.png' alt='맑음'></li><li><span class='wt_blue'>"+val[2].minT3h+"℃</span><span>/</span><span class='wt_red'>"+val[2].maxT3h+"℃</span></li>");
						}else if(val[2].sky == '2'){
							$("#weather03").append("<li><img src='../images/2020/weather02.png' alt='구름조금'></li><li><span class='wt_blue'>"+val[2].minT3h+"℃</span><span>/</span><span class='wt_red'>"+val[2].maxT3h+"℃</span></li>");
						}else if(val[2].sky == '3'){
							$("#weather03").append("<li><img src='../images/2020/weather03.png' alt='구름많음'></li><li><span class='wt_blue'>"+val[2].minT3h+"℃</span><span>/</span><span class='wt_red'>"+val[2].maxT3h+"℃</span></li>");
						}else if(val[2].sky == '4'){
							if(val[2].pty == '0'){
								$("#weather03").append("<li><img src='../images/2020/weather04.png' alt='맑음/비'></li><li><span class='wt_blue'>"+val[2].minT3h+"℃</span><span>/</span><span class='wt_red'>"+val[2].maxT3h+"℃</span></li>");
							}else if(val[1].pty == '1'|| val[1].pty == '2'){
								$("#weather03").append("<li><img src='../images/2020/weather05.png' alt='비'></li><li><span class='wt_blue'>"+val[2].minT3h+"℃</span><span>/</span><span class='wt_red'>"+val[2].maxT3h+"℃</span></li>");
							}else{
								$("#weather03").append("<li><img src='../images/2020/weather05_1.png' alt='눈'></li><li><span class='wt_blue'>"+val[2].minT3h+"℃</span><span>/</span><span class='wt_red'>"+val[2].maxT3h+"℃</span></li>");
							}
						}
						
						var val1= res.list1;
						chartData = val1;
						rMateChartLoding("chart1", "chartReadyHandler");
						
						$("#tbodyList").empty();
						for(var i=0; i<val1.length; i++){
							$("#tbodyList").append("<tr><td>"+val1[i].fcstDate+"</td><td>"+val1[i].sidoNm+"</td><td>"+val1[i].minT3h+"</td><td>"+val1[i].maxT3h+"</td><td>"+val1[i].r06+"</td></tr>");
						}
					}else{
						/* $("#weather01").empty();
						$("#weather02").empty();
						$("#weather03").empty(); */
						chartData =[];
						rMateChartLoding("chart1", "chartReadyHandler");
						$("#tbodyList").empty();
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
				<li>공공데이터</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li>타 기관 정보</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li class="m_right">기상동향 분석</li>
			</ul>
		</div>
		<!--공통 HEADER(E)-->
		
		<!--서브 타이틀(S)-->
		<jsp:include page="../inc/2020/IncShare.jsp"/>
		
		<div class="sub_title">
			<div class="title_box">
				<h2>기상동향 분석</h2>
				<img src="../images/2020/sub/t_line.png" alt="방울점선">
			</div>
		</div>
		<!--서브 타이틀(E)-->
		<!--서브공통 (S)-->
		<div class="sub_contents">
			<div class="search_box">
				<div class="search_01">
					<ul class="search_box01">
						<li>
							<p class="search_01_txt">시/도</p>
							<select class="form-control" style="width: 150px;" id="sido" name="sido" onchange="getGugun(this)"></select>							
						</li>
						<li>
							<p class="search_01_txt">구/군</p>
							<select class="form-control" style="width: 150px;" id="gugun" name="gugun"></select>
						</li>
						<li class="search_btn">
							<a href="javasciprt:void(0);" onclick="getItem();"><img src="../images/2020/sub/search_img.png" alt="돋보기">검색</a>
						</li>
					</ul>
				</div>
			</div>
		</div>
		<!--컨텐츠 내용(S)-->
		<div class="sub_guide">
			<div class="weather_box_b">
				<ul class="weather_list_b">
					<!--오늘-->
					<li>
						<ul class="days_box_b">
							<li class="days_b">
								<p id="weather01txt">오늘 (20.02.19)</p>
							</li>
							<li class="temperature_b">
								<ul class="temperature_box_b" id="weather01">
									<li>
										<img src="../images/2020/weather01.png" alt="맑음">
									</li>
									<li>
										<span class="wt_blue">6℃</span>
										<span>/</span>
										<span class="wt_red">9℃</span>
									</li>
								</ul>
							</li>
							<li class="humidity_b" id="weather01etc">
								<p><span>강수량 : 4mm</span>
								<span class="line_of">ㅣ</span>
								<span> 습도 : 69%</span></p>
							</li>
						</ul>
					</li>
					<!--내일-->
					<li>
						<ul class="days_box_b">
							<li class="days_b">
								<p id="weather02txt">내일 (20.02.20)</p>
							</li>
							<li class="temperature_b">
								<ul class="temperature_box_b" id="weather02">
									<li>
										<img src="../images/2020/weather02.png" alt="맑음">
									</li>
									<li>
										<span class="wt_blue">6℃</span>
										<span class="line_of">/</span>
										<span class="wt_red">9℃</span>
									</li>
								</ul>
							</li>
							<li class="humidity_b" id="weather02etc">
								<p><span>강수량 : 4mm</span>
								<span class="line_of">ㅣ</span>
								<span> 습도 : 69%</span></p>
							</li>
						</ul>
					</li>
					<!--모레-->
					<li>
						<ul class="days_box_b">
							<li class="days_b">
								<p id="weather03txt">모레 (20.02.21)</p>
							</li>
							<li class="temperature_b">
								<ul class="temperature_box_b" id="weather03">
									<li>
										<img src="../images/2020/weather03.png" alt="맑음">
									</li>
									<li>
										<span class="wt_blue">6℃</span>
										<span>/</span>
										<span class="wt_red">9℃</span>
									</li>
								</ul>
							</li>
							<li class="humidity_b" id="weather03etc">
								<p><span>강수량 : 4mm</span>
								<span class="line_of">ㅣ</span>
								<span> 습도 : 69%</span></p>
							</li>
						</ul>
					</li>
				</ul>
			</div>
			<!--그래프-->
			<div class="weather_graph_b">
				<div class="graph_01_b">
					<h2 class="title_02">기온 강수량</h2>
					<div>
						<div id="chartHolder" style="width:100%; height:493px;"></div>
					</div>
				</div>
				<div class="graph_02_b">
					<p>(단위:기온( ℃ ),강수량(mm))</p>
					<table>
						<caption>기상동향</caption>
						<colgroup>
							<col style="width:20%">
							<col style="width:20%">
							<col style="width:20%">
							<col style="width:20%">
							<col style="width:20%">
						</colgroup>
						<thead>
							<tr>
								<th>날짜</th>
								<th>지역</th>
								<th>최저기온</th>
								<th>최고기온</th>
								<th>강수량</th>
							</tr>
						</thead>
						<tbody id="tbodyList"></tbody>
					</table>
				</div>
			</div>
			<div class="guide">
				<h2 class="title_02">이용안내</h2>
				<ul class="guide_box">
					<li>· 데이터 출처 : 기상청 </li>
				</ul>
			</div>
		</div>
		
		<!--컨텐츠 내용(E)-->
		
		<jsp:include page="../inc/2020/IncFooter.jsp"/>
		
	</div>
	<!--WRAP(E)-->
</body>
</html>