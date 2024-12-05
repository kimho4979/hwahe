<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
Calendar cal = Calendar.getInstance ( );
cal.add ( cal.MONTH, -1);
%>

<c:set var="nowdate" value="<%=new Date()%>"/>
<c:set var="preMonth" value="<%=cal.getTime()%>"/>

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
	<meta name="description" content="출하 및 예정물량">
	<meta name="content" content="화훼유통정보시스템 입니다.">
	<meta name="keywords" content="화훼경매시세, 화훼경매가격, Korea aT flower market auction price, 화훼공판장, 화훼거래정보, 꽃시장, 꽃값">
	<meta name="Author" content="화훼유통정보시스템 & www.woorim.co.kr">
	<title>출하 및 예정물량</title>
	
	<%@include file="../common/2020/commonJs.jsp" %>
	<%@include file="../common/2020/commonCss.jsp" %>
  
	<script type="text/javascript">
		var myProgress = new AXProgress();
		var myGrid1 = new AXGrid();
		var myGrid2 = new AXGrid();
		var myModal = new AXModal();
		//-----------------------차트 설정 시작-----------------------
		
		//rMate 차트 생성 준비가 완료된 상태 시 호출할 함수를 지정합니다.
		
		var chartVars = "rMateOnLoadCallFunction=chartReadyHandler";
		var chartVars2 = "rMateOnLoadCallFunction=chartReadyHandler2";
		//rMateChart 를 생성합니다.
		//파라메터 (순서대로) 
		//1. 차트의 id ( 임의로 지정하십시오. ) 
		//2. 차트가 위치할 div 의 id (즉, 차트의 부모 div 의 id 입니다.)
		//3. 차트 생성 시 필요한 환경 변수들의 묶음인 chartVars
		//4. 차트의 가로 사이즈 (생략 가능, 생략 시 100%)
		//5. 차트의 세로 사이즈 (생략 가능, 생략 시 100%)
		rMateChartH5.create("chart1", "chartHolder", chartVars, "100%", "100%"); 
		rMateChartH5.create("chart2", "chartHolder2", chartVars2, "100%", "100%"); 
		//차트의 속성인 rMateOnLoadCallFunction 으로 설정된 함수.
		//rMate 차트 준비가 완료된 경우 이 함수가 호출됩니다.
		//이 함수를 통해 차트에 레이아웃과 데이터를 삽입합니다.
		//파라메터 : id - rMateChartH5.create() 사용 시 사용자가 지정한 id 입니다.
		function chartReadyHandler(id) {
		 document.getElementById(id).setLayout(layoutStr);
		 document.getElementById(id).setData(chartData);
		}
	
		function chartReadyHandler2(id) {
			 document.getElementById(id).setLayout(layoutStr2);
			 document.getElementById(id).setData(chartData2);
		}
		//스트링 형식으로 레이아웃 정의.
		var layoutStr = 
	     '<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'
	         +'<Options>'
	             +'<Caption text=""/>'
	             +'<Legend useVisibleCheck="true"/>'
	         +'</Options>'
	         +'<Pie2DChart id="chart" innerRadius="0.3" showDataTips="true" selectionMode="single">'
	             +'<series>'
	                 +'<Pie2DSeries nameField="market_NAME" field="tot_QTY" startAngle="-90" renderDirection="clockwise" labelPosition="inside" color="#ffffff">'
	                     +'<showDataEffect>'
	                         +'<SeriesZoom duration="1000"/>'
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
		var chartData = JSON.parse('${list}');
		
		//스트링 형식으로 레이아웃 정의.
		var layoutStr2 = 
			'<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'
	        +'<Options>'
	            +'<Caption text=""/>'
	            +'<Legend useVisibleCheck="true"/>'
	        +'</Options>'
	        +'<Pie2DChart id="chart" innerRadius="0.3" showDataTips="true" selectionMode="single">'
	            +'<series>'
	                +'<Pie2DSeries nameField="market_NAME" field="tot_QTY" startAngle="-90" renderDirection="clockwise" labelPosition="inside" color="#ffffff">'
	                    +'<showDataEffect>'
	                        +'<SeriesZoom duration="1000"/>'
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
	 
		// 차트 데이터
		var chartData2 =JSON.parse('${list2}');
		
		// -----------------------차트 설정 끝 -----------------------
	
	   
	   var fnObj = {
	       pageStart: function(){    	    
				$("#datepicker").bindDate({align:"right", valign:"bottom", separator:"-", selectType:"m",  defaultSelectType:"m", value:"",
					onchange:function(){
						searchMonth();
					},
				});
				
				$("#excelBtn1").empty();
				$("#excelBtn1").append('<a href="javascript:void(0);" id="exportBtn1" name="exportTable1" onclick="excelExport();"><img src="../images/2020/exel.png" alt="엑셀이미지">엑셀저장</a>');
	       }
		};  
		
		// 엑셀 다운로드
		function excelExport(){
			var excelNm = "출하및예정물량";
			var REG_MONTH = $("#datepicker").val();
			var param = "?excelNm="+excelNm+"&REG_MONTH="+REG_MONTH;
			location.href = "/excel/excelDownLoad.do"+param;
		}
	
		function searchMonth(){	   
		   var frm = $("#myForm");
		   frm.action="/hca01/hca01.do";
		   frm.submit();
		}
		
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
				<li>생산/소비정보</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li>출하 및 작황정보(장미)</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li class="m_right">출하 및 예정물량</li>
			</ul>
		</div>
		<!--공통 HEADER(E)-->
		
		<!--서브 타이틀(S)-->
		<jsp:include page="../inc/2020/IncShare.jsp"/>
		
		<div class="sub_title">
			<div class="title_box">
				<h2>출하 및 예정물량</h2>
				<img src="../images/2020/sub/t_line.png" alt="방울점선">
			</div>
		</div>
		<!--서브 타이틀(E)-->
		<!--서브공통 (S)-->
		<div class="sub_contents">
			<!--서브 리스트 (S)-->
			
			<!--서브 리스트 (E)-->
			<!--서브 TAB공통 (S)-->
			<div class="sub_tab_yangjae">
				
				<div class="search_box">
					<div class="search_01">
						<form name="myForm" id="myForm" action="/hca01/hca01.do" method="post">
						<ul class="search_box01">
							<li class="calendar">
								<p class="search_01_txt">날짜선택</p>
								<input type="text" class="datepicker" name="datepicker" id="datepicker" value="${regMonth}">
								<!-- <input type="text"  value="YYYY-MM-DD" alt="켈린더" class="datepicker" > -->
							</li>
						</ul>
						</form>						
					</div>
				</div>
			</div>
			<!--서브 TAB공통 (E)-->
		</div>
		<!--컨텐츠 내용(S)-->
		<div class="sub_guide">
			<div class="spedition_list_b">
				<div class="spedition_box_b">
					<h2 class="title_02">출하물량</h2>
					<div class="spedition_box_date_b">
						<div id="chartHolder" style="width:100%; height:321px;"></div>
					</div>
					<div class="graph_box scroll_y h350">
					<table>
						<caption>출하물량</caption>
						<colgroup>
							<col style="width:30%">
							<col style="width:14%">
							<col style="width:23%">
							<col style="width:23%">
						</colgroup>
						<thead>
							<tr>
								<th>공판장</th>
								<th>순</th>
								<th>순별 출하물량(속)</th>
								<th>총 출하물량(속)</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="top" items="${selectTop}" varStatus="status">
								<tr class="tb_line_b">
									<td></td>
									<td>초순</td>
									<td><fmt:formatNumber value="${top.QTY_1}" type="number"/></td>
									<td></td>
								</tr>
								<tr>
									<td colspan="1">${top.MARKET_NAME}</td>
									<td>중순</td>
									<td><fmt:formatNumber value="${top.QTY_2}" type="number"/></td>
									<td colspan="1"><fmt:formatNumber value="${top.TOT_QTY }" type="number"/></td>
								</tr>
								<tr>
									<td></td>
									<td>하순</td>
									<td><fmt:formatNumber value="${top.QTY_3}" type="number"/></td>
									<td></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					</div>
				</div>
				<div class="spedition_box_b">
					<h2 class="title_02">출하예정물량</h2>
					<div class="spedition_box_date_b">
						<div id="chartHolder2" style="width:100%; height:321px;"></div>
					</div>
					<div class="graph_box scroll_y h350">
					<table>
						<caption>출하예정물량</caption>
						<colgroup>
							<col style="width:30%">
							<col style="width:14%">
							<col style="width:23%">
							<col style="width:23%">
						</colgroup>
						<thead>
							<tr>
								<th>공판장</th>
								<th>순</th>
								<th>순별 출하물량(속)</th>
								<th>총 출하물량(속)</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="bottom" items="${selectBottom}" varStatus="status">
								<tr class="tb_line_b">
									<td></td>
									<td>초순</td>
									<td><fmt:formatNumber value="${bottom.QTY_1}" type="number"/></td>
									<td></td>
								</tr>
								<tr>
									<td colspan="1">${bottom.MARKET_NAME}</td>
									<td>중순</td>
									<td><fmt:formatNumber value="${bottom.QTY_2}" type="number"/></td>
									<td colspan="1"><fmt:formatNumber value="${bottom.TOT_QTY }" type="number"/></td>
								</tr>
								<tr>
									<td></td>
									<td>하순</td>
									<td><fmt:formatNumber value="${bottom.QTY_3}" type="number"/></td>
									<td></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
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
					<li>· 선정 된 70개 농가의 출하물량 및 출하예정물량 정보를 확인 할 수 있는 화면 </li>
					<li>· 대상품목 : 장미</li>
					<li>· 단위 :출하물량(속) / 자료출처 : 선정 된 70개 농가의 입력 자료</li>
				</ul>
			</div>
		</div>
		<!--컨텐츠 내용(E)-->
		
		<jsp:include page="../inc/2020/IncFooter.jsp"/>
		
	</div>
	<!--WRAP(E)-->
</body>
</html>