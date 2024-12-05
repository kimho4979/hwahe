<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
<meta name="viewport"
	content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, user-scalable=no">
<meta name="apple-mobile-web-app-title" content="화훼유통정보시스템">
<meta name="robots" content="no-index,follow">
<meta name="og:title" content="화훼유통정보시스템">
<meta name="og:description" content="화훼유통정보시스템">
<meta name="description" content="월간 화훼 수출입 현황">
<meta name="content" content="화훼유통정보시스템 입니다.">
<meta name="keywords"
	content="화훼경매시세, 화훼경매가격, Korea aT flower market auction price, 화훼공판장, 화훼거래정보, 꽃시장, 꽃값">
<meta name="Author" content="화훼유통정보시스템 & www.woorim.co.kr">
<title>월간 화훼 수출입 현황</title>
<%@include file="../common/2020/commonJs.jsp"%>
<%@include file="../common/2020/commonCss.jsp"%>
<script type="text/javascript">
	//-----------------------수입동향 차트 설정 시작-----------------------

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
	var layoutStr = '<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'
			+ '<Options>'
			+ '<Legend defaultMouseOverAction="false" useVisibleCheck="true"/>'
			+ '</Options>'
			+ '<NumberFormatter id="numFmt" useThousandsSeparator="true"/>'
			+ '<Combination2DChart showDataTips="true">'
			+ '<horizontalAxis>'
			+ '<CategoryAxis categoryField="dtNew" padding="1"/>'
			+ '</horizontalAxis>'
			+ '<verticalAxis>'
			+ '<LinearAxis id="vAxis1" interval="1000"  formatter="{numFmt}" minimum="0" title="물량(톤)"/>'
			+ '</verticalAxis>'
			+ '<series>'
			+ '<Column2DSet type="clustered">'
			+ '<series>'
			+ '<Column2DSeries yField="impWgt7" displayName="전년물량">'
			+ '<fill>'
			+ '<SolidColor color="#86E57F"/>'
			+ '</fill>'
			+ '<showDataEffect>'
			+ '<SeriesInterpolate/>'
			+ '</showDataEffect>'
			+ '</Column2DSeries>'
			+ '<Column2DSeries yField="impWgt3" displayName="금년물량">'
			+ '<fill>'
			+ '<SolidColor color="#5CD1E5"/>'
			+ '</fill>'
			+ '<showDataEffect>'
			+ '<SeriesInterpolate/>'
			+ '</showDataEffect>'
			+ '</Column2DSeries>'
			+ '</series>'
			+ '</Column2DSet>'
			+ '<Line2DSeries selectable="true" yField="impPrc8" radius="4.5" form="curve" displayName="전년금액" itemRenderer="CircleItemRenderer">'
			+ '<stroke>'
			+ '<Stroke color="#F361A6" weight="3"/>'
			+ '</stroke>'
			+ '<lineStroke>'
			+ '<Stroke color="#F361A6" weight="3"/>'
			+ '</lineStroke>'
			+ '<verticalAxis>'
			+ '<LinearAxis id="vAxis2" interval="1000" formatter="{numFmt}" minimum="0" title="금액(천달러)"/>'
			+ '</verticalAxis>'
			+ '<showDataEffect>'
			+ '<SeriesInterpolate/>'
			+ '</showDataEffect>'
			+ '</Line2DSeries>'
			+ '<Line2DSeries selectable="true" yField="impPrc4" radius="4.5" form="curve" displayName="금년금액" itemRenderer="CircleItemRenderer">'
			+ '<stroke>'
			+ '<Stroke color="#4374D9" weight="3"/>'
			+ '</stroke>'
			+ '<lineStroke>'
			+ '<Stroke color="#4374D9" weight="3"/>'
			+ '</lineStroke>'
			+ '<verticalAxis>'
			+ '<LinearAxis id="vAxis3" interval="1000" formatter="{numFmt}" minimum="0" title="금액(천달러)"/>'
			+ '</verticalAxis>'
			+ '<showDataEffect>'
			+ '<SeriesInterpolate/>'
			+ '</showDataEffect>'
			+ '</Line2DSeries>'
			+ '</series>'
			+ '<verticalAxisRenderers>'
			+ '<Axis2DRenderer axis="{vAxis1}" showLine="false" />'
			+ '<Axis2DRenderer axis="{vAxis2}" showLine="false" />'
			+ '</verticalAxisRenderers>'
			+ '</Combination2DChart>'
			+ '</rMateChart>';

	//차트 데이터
	var chartData = [];

	rMateChartH5.registerTheme(rMateChartH5.themes);

	function rMateChartH5ChangeTheme(theme) {
		document.getElementById("chart1").setTheme(theme);
	}

	//-----------------------수입동향 차트 설정 끝 -----------------------

	//-----------------------수출동향 차트 설정 시작-----------------------

	//rMate 차트 생성 준비가 완료된 상태 시 호출할 함수를 지정합니다.
	var chartVars = "rMateOnLoadCallFunction=chartReadyHandler1";

	//rMateChart 를 생성합니다.
	//파라메터 (순서대로) 
	//1. 차트의 id ( 임의로 지정하십시오. ) 
	//2. 차트가 위치할 div 의 id (즉, 차트의 부모 div 의 id 입니다.)
	//3. 차트 생성 시 필요한 환경 변수들의 묶음인 chartVars
	//4. 차트의 가로 사이즈 (생략 가능, 생략 시 100%)
	//5. 차트의 세로 사이즈 (생략 가능, 생략 시 100%)
	rMateChartH5.create("chart2", "chartHolder1", chartVars, "100%", "100%");

	//차트의 속성인 rMateOnLoadCallFunction 으로 설정된 함수.
	//rMate 차트 준비가 완료된 경우 이 함수가 호출됩니다.
	//이 함수를 통해 차트에 레이아웃과 데이터를 삽입합니다.
	//파라메터 : id - rMateChartH5.create() 사용 시 사용자가 지정한 id 입니다.
	function chartReadyHandler1(id) {
		document.getElementById(id).setLayout(layoutStr1);
		document.getElementById(id).setData(chartData1);
		//checkData1(chartData1);
	}

	//스트링 형식으로 레이아웃 정의.
	var layoutStr1 = '<rMateChart backgroundColor="#FFFFFF"  borderStyle="none" >'
			+ '<Options>'
			+ '<Legend defaultMouseOverAction="false" useVisibleCheck="true"/>'
			+ '</Options>'
			+ '<NumberFormatter id="numFmt" useThousandsSeparator="true"/>'
			+ '<Combination2DChart showDataTips="true">'
			+ '<horizontalAxis>'
			+ '<CategoryAxis categoryField="dtNew" padding="1"/>'
			+ '</horizontalAxis>'
			+ '<verticalAxis>'
			+ '<LinearAxis id="vAxis1" interval="1000" formatter="{numFmt}" minimum="0" title="물량(톤)"/>'
			+ '</verticalAxis>'
			+ '<series>'
			+ '<Column2DSet type="clustered">'
			+ '<series>'
			+ '<Column2DSeries yField="expWgt5" displayName="전년물량">'
			+ '<fill>'
			+ '<SolidColor color="#86E57F"/>'
			+ '</fill>'
			+ '<showDataEffect>'
			+ '<SeriesInterpolate/>'
			+ '</showDataEffect>'
			+ '</Column2DSeries>'
			+ '<Column2DSeries yField="expWgt1" displayName="금년물량">'
			+ '<fill>'
			+ '<SolidColor color="#5CD1E5"/>'
			+ '</fill>'
			+ '<showDataEffect>'
			+ '<SeriesInterpolate/>'
			+ '</showDataEffect>'
			+ '</Column2DSeries>'
			+ '</series>'
			+ '</Column2DSet>'
			+ '<Line2DSeries selectable="true" yField="expPrc6" radius="4.5" form="curve" displayName="전년금액" itemRenderer="CircleItemRenderer">'
			+ '<stroke>'
			+ '<Stroke color="#F361A6" weight="3"/>'
			+ '</stroke>'
			+ '<lineStroke>'
			+ '<Stroke color="#F361A6" weight="3"/>'
			+ '</lineStroke>'
			+ '<verticalAxis>'
			+ '<LinearAxis id="vAxis2" interval="1000" formatter="{numFmt}" minimum="0" title="금액(천달러)"/>'
			+ '</verticalAxis>'
			+ '<showDataEffect>'
			+ '<SeriesInterpolate/>'
			+ '</showDataEffect>'
			+ '</Line2DSeries>'
			+ '<Line2DSeries selectable="true" yField="expPrc2" radius="4.5" form="curve" displayName="금년금액" itemRenderer="CircleItemRenderer">'
			+ '<stroke>'
			+ '<Stroke color="#4374D9" weight="3"/>'
			+ '</stroke>'
			+ '<lineStroke>'
			+ '<Stroke color="#4374D9" weight="3"/>'
			+ '</lineStroke>'
			+ '<verticalAxis>'
			+ '<LinearAxis id="vAxis3" interval="1000" formatter="{numFmt}" minimum="0" title="금액(천달러)"/>'
			+ '</verticalAxis>'
			+ '<showDataEffect>'
			+ '<SeriesInterpolate/>'
			+ '</showDataEffect>'
			+ '</Line2DSeries>'
			+ '</series>'
			+ '<verticalAxisRenderers>'
			+ '<Axis2DRenderer axis="{vAxis1}" showLine="false"/>'
			+ '<Axis2DRenderer axis="{vAxis2}" showLine="false"/>'
			+ '</verticalAxisRenderers>'
			+ '</Combination2DChart>'
			+ '</rMateChart>';

	//차트 데이터
	var chartData1 = [];

	rMateChartH5.registerTheme(rMateChartH5.themes);

	function rMateChartH5ChangeTheme(theme) {
		document.getElementById("chart2").setTheme(theme);
	}

	//-----------------------수출동향 차트 설정 끝 -----------------------

	var searchDate = null;
	var itemCd = null;
	$(document)
			.ready(
					function() {
						$("#excelBtn1").empty();
						$("#excelBtn1")
								.append(
										'<a href="javascript:void(0);" id="exportBtn1" name="exportTable1" onclick="excelExport();"><img src="../images/2020/exel.png" alt="엑셀이미지">엑셀저장</a>');

						$("#searchDate").bindDate({
							align : "right",
							valign : "bottom",
							separator : "-",
							selectType : "m",
							defaultSelectType : "m",
							value : ""
						});

						$('#itemCd').select2();

						getItem();

						getSearchDate();

						//getTrendAnalysisList();
					});

	// 엑셀 다운로드
	function excelExport() {
		var excelNm = "월간화훼수출입현황";
		searchDate = $("#searchDate").val();
		var param = "?excelNm=" + excelNm + "&searchDate=" + searchDate + "&itemCd=" + $("#itemCd").val();
		location.href = "/excel/excelDownLoad.do" + param;
	}

	// Max 날짜 가져오기
	function getSearchDate() {
		$.ajax({
			type : "post",
			url : "/hga01/selectGetDate.json",
			data : {},
			dataType : '',
			success : function(res) {
				var val = res.list;
				if (val != null && val.length > 0) {
					$("#searchDate").val(val[0].yyyymm);
				} else {
					$('#searchDate').val("");
				}
				getTrendAnalysisList();
			}
		});
	}

	// 품목 List
	function getItem() {
		$.ajax({
			type : "post",
			url : "/hga01/selectGetItem.json",
			data : {
				searchDate : $('#searchDate').val()
			},
			dataType : '',
			success : function(res) {
				var val = res.list;
				if (val.length > 0) {
					$("#itemCd").html("");
					$("#itemCd")
							.append("<option value='' selected>전체</option>");
					for (var i = 0; i < val.length; i++) {
						$("#itemCd").append(
								"<option value='"+val[i].hsCd+"'>"
										+ val[i].hsNm + "</option>");
					}
				} else {
					alert('해당일자에 데이터가 없습니다.')
				}
			}
		});
	}

	// 조회 버튼
	function getTrendAnalysisList() {
		var searchDate = $("#searchDate").val();
		var itemCd = $("#itemCd").val();
		$.ajax({
			type : "post",
			url : "/hga01/selectTrendAnalysisList.json",
			data : {
				searchDate : searchDate,
				itemCd : itemCd
			},
			dataType : '',
			success : function(res) {
				var val = res.list;
				if (val != null && val.length > 0) {
					chartData = val;
					rMateChartLoding("chart1", "chartReadyHandler");

					chartData1 = val;
					rMateChartLoding("chart2", "chartReadyHandler1");

					$("#thead").empty();
					$("#thead").append("<th>월</th>");
					for (var i = 0; i < val.length; i++) {
						$("#thead").append("<th>" + val[i].dtNew + "</th>");
					}

					$("#incomeTotQty").empty();
					$("#incomeTotQty").append("<td>총수입물량(톤)</td>");
					for (var i = 0; i < val.length; i++) {
						$("#incomeTotQty").append(
								"<td>" + comma(val[i].impWgt3) + "</td>");
					}

					$("#incomeTotAmt").empty();
					$("#incomeTotAmt").append("<td>총수입금액(천달러)</td>");
					for (var i = 0; i < val.length; i++) {
						$("#incomeTotAmt").append(
								"<td>" + comma(val[i].impPrc4) + "</td>");
					}

					$("#exportTotQty").empty();
					$("#exportTotQty").append("<td>총수출물량(톤)</td>");
					for (var i = 0; i < val.length; i++) {
						$("#exportTotQty").append(
								"<td>" + comma(val[i].expWgt1) + "</td>");
					}

					$("#exportTotAmt").empty();
					$("#exportTotAmt").append("<td>총수출금액(천달러)</td>");
					for (var i = 0; i < val.length; i++) {
						$("#exportTotAmt").append(
								"<td>" + comma(val[i].expPrc2) + "</td>");
					}

					$("#payBal").empty();
					$("#payBal").append("<td>무역수지(천달러)</td>");
					for (var i = 0; i < val.length; i++) {
						if (val[i].balPay == 0) {
							$("#payBal").append(
									"<td>" + comma(val[i].balPay) + "</td>");
						} else if (val[i].balPay > 0) {
							$("#payBal").append(
									"<td class='wt_red'>"
											+ comma(val[i].balPay) + "</td>");
						} else {
							$("#payBal").append(
									"<td class='wt_blue'>"
											+ comma(val[i].balPay) + "</td>");
						}

					}

				}
			}
		});
	}
	// 천단위 콤마
	function comma(x) {
		return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
</script>
</head>
<body>
	<!--WRAP(S)-->
	<div class="wrap">

		<jsp:include page="../inc/2020/IncHeader.jsp" />

		<div class="lnb_box">
			<ul>
				<li><img src="../images/2020/m_lnb_img.png" alt="집"></li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li>공공데이터</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li>타 기관 정보</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li class="m_right">월간 화훼 수출입 현황</li>
			</ul>
		</div>
		<!--공통 HEADER(E)-->

		<!--서브 타이틀(S)-->
		<jsp:include page="../inc/2020/IncShare.jsp" />

		<div class="sub_title">
			<div class="title_box">
				<h2>월간 화훼 수출입 현황</h2>
				<img src="../images/2020/sub/t_line.png" alt="방울점선">
			</div>
		</div>
		<!--서브 타이틀(E)-->
		<!--서브공통 (S)-->
		<div class="sub_contents">

			<!--서브 TAB공통 (S)-->

			<div class="dwn_bt_hga">
				<a href="/hga06_new/hga06_new.do">국가별 월간 화훼 수출입 현황 </a>
			</div>
			<div class="search_box">
				<div class="search_01">
					<ul class="search_box01">
						<li class="calendar">
							<p class="search_01_txt">날짜선택</p> <input type="text"
							class="datepicker" name="searchDate" id="searchDate" value="날짜선택">
							<!-- <input type="text"  value="YYYY-MM-DD" alt="켈린더" class="datepicker" > -->
						</li>
						<li>
							<p class="search_01_txt">품목선택</p> <select class="form-control"
							style="width: 150px;" id="itemCd" name="itemCd"></select>
						</li>
						<li class="search_btn"><a href="javascript:void(0);"
							onclick="getTrendAnalysisList();"><img
								src="../images/2020/sub/search_img.png" alt="돋보기">검색</a></li>
					</ul>
				</div>
			</div>
			<!--서브 TAB공통 (E)-->
		</div>
		<!--컨텐츠 내용(S)-->
		<div class="sub_guide">
			<div class=" export_box_b">
				<div class="export_graph_b">
					<h2 class="title_02">수출현황</h2>
					<div class="export_graph01_b">
						<div id="chartHolder1" style="width: 100%; height: 344px;"></div>
					</div>
				</div>
				<div class="export_list_b">
					<h2 class="title_02">수입현황</h2>
					<div class="export_list01_b">
						<div id="chartHolder" style="width: 100%; height: 344px;"></div>
					</div>
				</div>
				<h2 class="title_02">수출입현황</h2>
				<div class="export_date_b">
					<table>
						<caption>품종별 종합 경매정보</caption>
						<colgroup>
							<col style="width: 8%">
							<col style="width: 5%">
							<col style="width: 5%">
							<col style="width: 5%">
							<col style="width: 5%">
							<col style="width: 5%">
							<col style="width: 5%">
							<col style="width: 5%">
							<col style="width: 5%">
							<col style="width: 5%">
							<col style="width: 5%">
							<col style="width: 5%">
							<col style="width: 5%">
						</colgroup>
						<thead>
							<tr id="thead">
								<th>월</th>
								<th>01</th>
								<th>02</th>
								<th>03</th>
								<th>04</th>
								<th>05</th>
								<th>06</th>
								<th>07</th>
								<th>08</th>
								<th>09</th>
								<th>10</th>
								<th>11</th>
								<th>12</th>
							</tr>
						</thead>
						<tbody>
							<tr id="exportTotQty">
								<td>수출물량(톤)</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
							</tr>
							<tr id="incomeTotQty">
								<td>수입물량(톤)</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
							</tr>
							<tr id="exportTotAmt">
								<td>수출금액(천원)</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
							</tr>
							<tr id="incomeTotAmt">
								<td>수입금액(천원)</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
							</tr>
							<tr id="payBal">
								<td>무역수지</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
								<td>-</td>
							</tr>
						</tbody>
					</table>
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
					<li>· 출처 : 관세청</li>
				</ul>
			</div>
		</div>
		<!--컨텐츠 내용(E)-->

		<jsp:include page="../inc/2020/IncFooter.jsp" />

	</div>
	<!--WRAP(E)-->
</body>
</html>