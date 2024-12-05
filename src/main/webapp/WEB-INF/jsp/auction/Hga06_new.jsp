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
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, user-scalable=no">
<meta name="apple-mobile-web-app-title" content="화훼유통정보시스템">
<meta name="robots" content="no-index,follow">
<meta name="og:title" content="화훼유통정보시스템">
<meta name="og:description" content="화훼유통정보시스템">
<meta name="description" content="국가별 월간 화훼 수출입 현황조회">
<meta name="content" content="화훼유통정보시스템 입니다.">
<meta name="keywords"
	content="화훼경매시세, 화훼경매가격, Korea aT flower market auction price, 화훼공판장, 화훼거래정보, 꽃시장, 꽃값">
<meta name="Author" content="화훼유통정보시스템 & www.woorim.co.kr">
<title>국가별 월간 화훼 수출입 현황조회</title>
<%@include file="../common/2020/commonJs.jsp"%>
<%@include file="../common/2020/commonCss.jsp"%>
<script type="text/javascript">
	//-----------------------국가별 수출입 현황 차트 설정 시작-----------------------

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
		console.log("setLayout", makeLayout(chartData));
		console.log("setData", chartData);
		document.getElementById(id).setLayout(makeLayout(chartData));
		document.getElementById(id).setData(chartData);
		//checkData(chartData);
	}

	function makeLayout(chartData) {
		var dynamicLayout = "";
		var prcqtyGubun = $(":input:radio[name=rr22]:checked").val();
		var maximum = 1000;
		var interval = 100;
		var title = "금액(천달러)";
		if (chartData[0].Gubun == "수입" && chartData[0].type2 == "sPrc") {
			maximum = 20000;
			interval = 2000;
			title = "금액(천달러)";
		}
		if (chartData[0].Gubun == "수입" && chartData[0].type2 == "sQty") {
			maximum = 15000;
			interval = 1500;
			title = "물량(톤)";
		}
		if(chartData[0].Gubun == "수출" && chartData[0].type2 == "sPrc"){
			maximum = 1500;
			interval = 150;
			title = "금액(천달러)";
		}

		if(chartData[0].Gubun == "수출" && chartData[0].type2 == "sQty"){
			maximum = 300;
			interval = 30;
			title = "물량(톤)";
		}

		var key_list = Object.keys(chartData[0]);

		for (var i = 0; i < key_list.length; i++) {
			if ("yyyymm" == key_list[i] || "Gubun" == key_list[i] || "type2" == key_list[i])
				continue;
			if ("기타" == key_list[i]) // 기타는 최상단에 표시되도록 수정.
				continue;
			dynamicLayout += '<Column2DSeries yField="'+key_list[i]+'" displayName="'+key_list[i]+'" labelPosition="inside" color="#ffffff" strokeJsFunction="strokeFunction">'
					+ '<showDataEffect> <SeriesInterpolate/></showDataEffect></Column2DSeries>';
		}
		
		dynamicLayout += '<Column2DSeries yField="기타" displayName="기타" labelPosition="inside" color="#ffffff" strokeJsFunction="strokeFunction">'
		+ '<showDataEffect> <SeriesInterpolate/></showDataEffect></Column2DSeries>';
		

		var layoutStr = '<rMateChart backgroundColor="#FFFFFF" borderStyle="none">'
				+ '<Options>'
				+ '</Options>'
				+ '<Column2DChart showDataTips="true" columnWidthRatio="0.4">'
				+ '<horizontalAxis>'
				+ '<CategoryAxis categoryField="yyyymm"/>' // 가로축
				+ '</horizontalAxis>'

				+ '<verticalAxis>'
				+ '<LinearAxis maximum="'+maximum+'" interval="'+interval+'" title="'+title+'"/>' // 세로축
				+ '</verticalAxis>'

				+ '<series>'
				+ '<Column2DSet type="stacked" showTotalLabel="true" totalLabelJsFunction="totalFunc">'
				+ '<series>'
				/*  Column2D Stacked 를 생성시에는 Column2DSeries를 최소 2개 정의합니다 */
				+ dynamicLayout
				+ '</series>'
				+ '</Column2DSet>'
				+ '</series>'
				+ '</Column2DChart>' + '</rMateChart>';

		return layoutStr;
	}

	//차트 데이터
	var chartData = [];
	var chartData2 = [];

	rMateChartH5.registerTheme(rMateChartH5.themes);

	function rMateChartH5ChangeTheme(theme) {
		document.getElementById("chart1").setTheme(theme);
	}

	function strokeFunction(id, index, data, values) {
		console.log("stroke_test", data, values);
	}
	//-----------------------국가별 수출입 현황 차트 설정 끝 -----------------------

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

						//달력 월별설정
						$("#searchStrDateM")
								.bindDate(
										{
											align : "right",
											valign : "bottom",
											separator : "-",
											selectType : "m",
											defaultSelectType : "m",
											value : "",
											onchange : function() {
												dateChkstr();
												cmpCd = [];
												flowerCd = [];
												var searchStrDate = $(
														"#searchStrDateM")
														.val();
												//var searchEndDate = $("#searchEndDateM").val();
												$(
														'input:checkbox[name="flowerGubn"]:checked')
														.each(
																function() {
																	flowerCd
																			.push($(
																					this)
																					.val());
																})

												//if(searchStrDate!=''&& searchEndDate!=''){
												//	getSalePumList();
												//}
											},
										});

						$('#itemCd').select2();

						getItem();

						getSearchDate();

						//getTrendAnalysisList();

						// 라디오 버튼에 따라서 타이틀 변경
						// $("input[name='rr11']").change(
						// 		function() {
									gubun = $(":input[name=rr11]:checked")
											.next().text();
									label = $(":input[name=rr22]:checked")
											.next().text();

									$("#subTileNm").html(
											gubun + "현황" + "(" + label + ")");
									$("#subTileNm2").html(
											gubun + "현황" + "(" + label + ")");
								// });

						// $("input[name='rr22']").change(
						// 		function() {
						// 			gubun = $(":input[name=rr11]:checked")
						// 					.next().text();
						// 			label = $(":input[name=rr22]:checked")
						// 					.next().text();
						//
						// 			$("#subTileNm").html(
						// 					gubun + "현황" + "(" + label + ")");
						// 			$("#subTileNm2").html(
						// 					gubun + "현황" + "(" + label + ")");
						// 		});
					});

	// 엑셀 다운로드
	function excelExport() {
		var excelNm = "국가별월간화훼수출입현황조회";
		searchDate = $("#searchDate").val();
		var type = $(":input:radio[name=rr11]:checked").val(); // 수출입기준
		var type2 = $(":input:radio[name=rr22]:checked").val(); // 표시단위
		var param = "?excelNm=" + excelNm + "&searchDate=" + searchDate
				+ "&type=" + type + "&type2=" + type2 + "&itemCd=" + $("#itemCd").val();

		location.href = "/excel/excelDownLoadHga06_new.do" + param;
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
				//getTrendAnalysisList();
				fn_search();
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

	// 검색 버튼
	function fn_search() {
		var type = $(":input:radio[name=rr11]:checked").val(); // 수출입기준
		var type2 = $(":input:radio[name=rr22]:checked").val(); // 표시단위
		// 		itemCd = [];	// 품목
		// 		$('input:checkbox[name="flowerGubn"]:checked').each(function(){
		// 			itemCd.push($(this).val());
		// 		})
		var searchDateM = $("#searchDate").val(); // 기준년월
		var itemCd = $("#itemCd").val();
		$.ajax({
			type : "post",
			url : "/hga06_new/selectNatCnt.json",
			data : {
				// 조회조건
				type : type,
				type2 : type2,
				searchDateM : searchDateM,
				itemCd : itemCd
			},
			dataType : 'json',
			success : function(res) {
				var val = res.list;
				trace(">>>>>>>>>>>>>>>>>>>>>>>> selectNatCnt: " + val.length);
				if (val != null && val.length > 0) {

					// 그리드 헤더
					$("#thead").empty();
					$("#thead").append("<th>국가</th>");
					$("#thead").append("<th>구분</th>");
					for (var i = 0; i < val.length; i++) {
						$("#thead").append("<th>" + val[i].yyyymm + "</th>");
					}

					chartData2 = val;

					fn_search2(type, type2, searchDateM, val.length, itemCd); // 그리드 바디 조회
					gubun = $(":input[name=rr11]:checked")
							.next().text();
					label = $(":input[name=rr22]:checked")
							.next().text();

					$("#subTileNm").html(
							gubun + "현황" + "(" + label + ")");
					$("#subTileNm2").html(
							gubun + "현황" + "(" + label + ")");
					if(label == '금액'){
						$("#subTileNm3").html("금액(천달러)");
					}else{
						$("#subTileNm3").html("물량(톤)");
					}
				}
			}
		});
	}

	function fn_search2(type, type2, searchDateM, natCnt, itemCd) {
		var natCnt = natCnt; // 월별 국가 수
		$.ajax({
			type : "post",
			url : "/hga06_new/selectExpImpInfo.json",
			data : {
				// 조회조건
				type : type,
				type2 : type2,
				searchDateM : searchDateM,
				itemCd : itemCd
			},
			dataType : 'json',
			success : function(res) {
				if (type == "sExp") {
					var expVal = res.expList; // 수출 조회 list

					// 수출 그리드 바디 생성
					trace(">>>>>>>>>>>>>>>>>>>>>>>> expVal : "
							+ expVal.length);

					$("#tBody").empty();

					for (var i = 0; i < expVal.length; i++) {
						if (type2 == "sPrc") {
							$("#tBody").append(
									"<tr><td>" + expVal[i].natNm
											+ "</td><td>"
											+ expVal[i].impexpGubun
											+ "</td><td>"
											+ expVal[i].expPrc1
											+ "</td><td>"
											+ expVal[i].expPrc2
											+ "</td><td>"
											+ expVal[i].expPrc3
											+ "</td><td>"
											+ expVal[i].expPrc4
											+ "</td><td>"
											+ expVal[i].expPrc5
											+ "</td><td>"
											+ expVal[i].expPrc6
											+ "</td><td>"
											+ expVal[i].expPrc7
											+ "</td><td>"
											+ expVal[i].expPrc8
											+ "</td><td>"
											+ expVal[i].expPrc9
											+ "</td><td>"
											+ expVal[i].expPrc10
											+ "</td><td>"
											+ expVal[i].expPrc11
											+ "</td><td>"
											+ expVal[i].expPrc12
											+ "</td></tr>");

						} else if (type2 == "sQty") {
							$("#tBody").append(
									"<tr><td>" + expVal[i].natNm
											+ "</td><td>"
											+ expVal[i].impexpGubun
											+ "</td><td>"
											+ expVal[i].expQty1
											+ "</td><td>"
											+ expVal[i].expQty2
											+ "</td><td>"
											+ expVal[i].expQty3
											+ "</td><td>"
											+ expVal[i].expQty4
											+ "</td><td>"
											+ expVal[i].expQty5
											+ "</td><td>"
											+ expVal[i].expQty6
											+ "</td><td>"
											+ expVal[i].expQty7
											+ "</td><td>"
											+ expVal[i].expQty8
											+ "</td><td>"
											+ expVal[i].expQty9
											+ "</td><td>"
											+ expVal[i].expQty10
											+ "</td><td>"
											+ expVal[i].expQty11
											+ "</td><td>"
											+ expVal[i].expQty12
											+ "</td></tr>");
						}
					}
					// 차트 생성
					// 			    	chartData = expVal;
					//  					rMateChartLoding("chart1", "chartReadyHandler");
				} else if (type == "sImp") {
					var impVal = res.impList; // 수입 조회 list

					// 수입 그리드 바디 생성
					trace(">>>>>>>>>>>>>>>>>>>>>>>> impVal : "
							+ impVal.length);
					$("#tBody").empty();
					for (var i = 0; i < impVal.length; i++) {
						if (type2 == "sPrc") {
							$("#tBody").append(
									"<tr><td>" + impVal[i].natNm
											+ "</td><td>"
											+ impVal[i].impexpGubun
											+ "</td><td>"
											+ impVal[i].impPrc1
											+ "</td><td>"
											+ impVal[i].impPrc2
											+ "</td><td>"
											+ impVal[i].impPrc3
											+ "</td><td>"
											+ impVal[i].impPrc4
											+ "</td><td>"
											+ impVal[i].impPrc5
											+ "</td><td>"
											+ impVal[i].impPrc6
											+ "</td><td>"
											+ impVal[i].impPrc7
											+ "</td><td>"
											+ impVal[i].impPrc8
											+ "</td><td>"
											+ impVal[i].impPrc9
											+ "</td><td>"
											+ impVal[i].impPrc10
											+ "</td><td>"
											+ impVal[i].impPrc11
											+ "</td><td>"
											+ impVal[i].impPrc12
											+ "</td></tr>");
						} else if (type2 == "sQty") {
							$("#tBody").append(
									"<tr><td>" + impVal[i].natNm
											+ "</td><td>"
											+ impVal[i].impexpGubun
											+ "</td><td>"
											+ impVal[i].impQty1
											+ "</td><td>"
											+ impVal[i].impQty2
											+ "</td><td>"
											+ impVal[i].impQty3
											+ "</td><td>"
											+ impVal[i].impQty4
											+ "</td><td>"
											+ impVal[i].impQty5
											+ "</td><td>"
											+ impVal[i].impQty6
											+ "</td><td>"
											+ impVal[i].impQty7
											+ "</td><td>"
											+ impVal[i].impQty8
											+ "</td><td>"
											+ impVal[i].impQty9
											+ "</td><td>"
											+ impVal[i].impQty10
											+ "</td><td>"
											+ impVal[i].impQty11
											+ "</td><td>"
											+ impVal[i].impQty12
											+ "</td></tr>");
						}
					}
				}

				// 차트용 조회
				fn_chartSearch(type, type2, searchDateM, itemCd);
			}
		});
	}

	// 차트용 조회
	function fn_chartSearch(type, type2, searchDateM, itemCd) {
		$.ajax({
			type : "post",
			url : "/hga06_new/selectChartInfo.json",
			data : {
				// 조회조건
				type : type,
				type2 : type2,
				searchDateM : searchDateM,
				itemCd : itemCd
			},
			dataType : 'json',
			success : function(res) {
				if (type == "sExp") {
					var expVal = res.expChartList; // 수출 차트 조회 list

					if (expVal != null & expVal.length > 0) {
						chartData = expVal;
						rMateChartLoding("chart1", "chartReadyHandler");
					}
				} else if (type == "sImp") {
					var impVal = res.impChartList; // 수입 차트 조회 list

					if (impVal != null & impVal.length > 0) {
						chartData = impVal;
						rMateChartLoding("chart1", "chartReadyHandler");
					}
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
			url : "/hga06_new/selectTrendAnalysisList.json",
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

					//chartData1 = val;
					//rMateChartLoding("chart2", "chartReadyHandler1");

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
				<li class="m_right">국가별 월간 화훼 수출입 현황조회</li>
			</ul>
		</div>
		<!--공통 HEADER(E)-->

		<!--서브 타이틀(S)-->
		<jsp:include page="../inc/2020/IncShare.jsp" />

		<div class="sub_title">
			<div class="title_box">
				<h2>국가별 월간 화훼 수출입 현황</h2>
				<img src="../images/2020/sub/t_line.png" alt="방울점선">
			</div>
		</div>
		<!--서브 타이틀(E)-->
		<!--서브공통 (S)-->
		<div class="sub_contents">

			<!--서브 TAB공통 (S)-->

			<div class="search_box_new statistic">
				<input type="hidden" id="searchStrDate" value="${searchStrDate}">
				<input type="hidden" id="searchEndDate" value="${searchEndDate}">
				<div class="s-line">
					<h4 class="sbn_tit_01">수출입기준</h4>
					<ul class="grow_check_box">
						<li><input type="radio" id="rr11" name="rr11" value="sExp"
							checked> <label for="rr11" class="title_box_chk"><em
								class="txt">수출</em><span></span></label></li>
						<li><input type="radio" id="rr22" name="rr11" value="sImp">
							<label for="rr22" class="title_box_chk"><em class="txt">수입</em><span></span></label>
						</li>
					</ul>

				</div>

				<div class="s-line">
					<h4 class="sbn_tit_01">표시단위</h4>
					<ul class="grow_check_box">
						<li><input type="radio" id="rr33" name="rr22" value="sPrc"
							checked> <label for="rr33" class="title_box_chk"><em
								class="txt">금액</em><span></span></label></li>
						<li><input type="radio" id="rr44" name="rr22" value="sQty">
							<label for="rr44" class="title_box_chk"><em class="txt">물량</em><span></span></label>
						</li>
					</ul>
				</div>
				<div class="s-line">
					<h4 class="sbn_tit_01">품목</h4>
					<ul class="sb_common_01">
						<li><select class="form-control" style="width: 150px;" id="itemCd" name="itemCd"></select></li>
					</ul>
				</div>
				<div class="s-line">
					<h4 class="sbn_tit_01">기준년월</h4>


					<div class="sb_common_02 pack-01">
						<div class="date-from-to" id="searchDateM">
							<div class="calendar_new">
								<!-- <input type="text" alt="켈린더" class="calendar_focus" id="searchStrDateM" value="${searchStrDateM}" onClick="calendarShow(this.id);"/> -->
								<input type="text" class="datepicker" name="searchDate"	id="searchDate" value="날짜선택">
							</div>
						</div>
					</div>
					<div class="search_btn">
						<a href="javascript:void(0);" onclick="fn_search();"><img src="../images/2020/sub/search_img.png" alt="돋보기">검색</a>
					</div>
				</div>
			</div>
			<!--서브 TAB공통 (E)-->
		</div>
		<!--컨텐츠 내용(S)-->
		<div class="sub_guide">
			<div class=" export_box_b">
				<div class="export_graph_b">
					<!-- <h2 class="title_02" id="subTileNm">수출현황(금액)</h2>
					<div class="export_graph01_b">
						<div id="chartHolder1" style="width: 100%; height: 344px;"></div>
					</div>
				</div>
				 -->
					<div class="export_list_b">
						<h2 class="title_02" id="subTileNm">수출현황(금액)</h2>
						<div class="export_list01_b">
							<div id="chartHolder" style="width: 100%; height: 344px;"></div>
						</div>
					</div>
					<div class="tit_box_01">
						<div class="fl">
							<h2 class="title_02" id="subTileNm2" style="margin-bottom:">수출현황(금액)</h2>
						</div>
						<div class="fr">
							<div class="icon-box tr">
								<span class="guide-icon width-scroll"></span>
							</div>
							<!-- 버튼박스(S) -->
							<div class="dwn_bt_b mb5" id="excelBtn1">
								<a href="#!">엑셀저장</a>
							</div>
							<br/>
							<span class="txt-unit" id="subTileNm3">금액(천달러)</span>
							<!-- 버튼박스(E) -->
						</div>
					</div>
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
								<col style="width: 5%">
							</colgroup>
							<thead>
								<tr id="thead">

								</tr>
							</thead>
							<tbody id="tBody">

							</tbody>
						</table>
					</div>
				</div>

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