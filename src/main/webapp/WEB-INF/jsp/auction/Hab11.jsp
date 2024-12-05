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
	<title>경매통계 비교</title>
	<%@include file="../common/2020/commonJs.jsp" %>
	<%@include file="../common/2020/commonCss.jsp" %>
	<style>
 		#progress_loading {display:block; position:absolute; top:50%; left:50%; transform:translateX(-50%) translateY(-50%); background: #ffffff; text-align: center; z-index:999999;}
		@media screen and (min-width: 800px){
		/* .ui-jqgrid .ui-jqgrid-htable{width:auto!important;} */
		}

		.qty__blue {
			color: blue;
			font-weight: 900;
		}
		.qty__red {
			color: red;
			font-weight: 900;
		}

	</style>

	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<link rel="stylesheet" href="https://cdn.datatables.net/1.13.1/css/jquery.dataTables.min.css">

	<script type="text/javascript" src="https://cdn.datatables.net/1.13.1/js/jquery.dataTables.min.js"></script>
	<script type="text/javascript" src="https://cdn.datatables.net/fixedcolumns/4.2.1/js/dataTables.fixedColumns.min.js"></script>

	<script type="text/javascript">

		const isEmpty = function(value) {
		    if (value === null) return true
		    if (typeof value === 'undefined') return true
		    if (typeof value === 'string' && value === '') return true
		    if (Array.isArray(value) && value.length < 1) return true
		    if (typeof value === 'object' && value.constructor.name === 'Object' && Object.keys(value).length < 1 && Object.getOwnPropertyNames(value) < 1) return true
		    if (typeof value === 'object' && value.constructor.name === 'String' && Object.keys(value).length < 1) return true // new String()

		    return false;
		};

		//-----------------------차트 설정   -----------------------
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
		}
		var layoutStr =
            '<rMateChart backgroundColor="#FFFFFF" borderStyle="none">'
               +'<Options>'
                  +'<Legend defaultMouseOverAction="false" />'
              +'</Options>'

             +'<Column2DChart showDataTips="true" columnWidthRatio="0.55" selectionMode="single">'
                 +'<horizontalAxis>'
                       +'<CategoryAxis categoryField="Month"/>'
                  +'</horizontalAxis>'

                  +'<verticalAxis>'
                     +'<LinearAxis maximum="1000" interval="100"/>'
                 +'</verticalAxis>'

                    +'<series>'
                      +'<Column2DSeries labelPosition="outside" yField="2011" displayName="조건1" >'
                           +'<showDataEffect>'
                               +'<SeriesInterpolate/>'
                           +'</showDataEffect>'
                      +'</Column2DSeries>'

                      +'<Column2DSeries labelPosition="outside" yField="2012" displayName="조건2" >'
                           +'<showDataEffect>'
                               +'<SeriesInterpolate/>'
                           +'</showDataEffect>'
                      +'</Column2DSeries>'
                  +'</series>'
              +'</Column2DChart>'
           +'</rMateChart>';
	//차트 데이터
	var chartData = [];
	//-----------------------차트 설정 끝 -----------------------
	
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
				<li class="m_right">경매통계 비교</li>
			</ul>
		</div>
		<!--sub 헤더 (E)-->
		<!--서브 타이틀(S)-->

		<jsp:include page="../inc/2020/IncShare.jsp"/>

		<div class="sub_title">
			<div class="title_box">
				<h2 class="sub_tit">경매통계 비교</h2>
				<p>전국 화훼공판장의 경매정보를 확인 할 수 있습니다.</p>
				<img src="../images/2020/sub/t_line.png" alt="방울점선">
			</div>
		</div>

		<!--서브 타이틀(E)-->
		<!--서브공통 (S)-->
		<div class="sub_contents">
			<div class="sub_info_box">
				<div class="tit_box_01 ">
					<div class="fl">
						<h4 class="title_02 mt0">검색조건</h4>
					</div>

					<div class="fr ml6">
						<button class="search_btn_n" name="btn_search"><img src="../images/2020/sub/search_img.png" alt="돋보기">검색</button>
					</div>
					<div class="fr">
						<button class="reset_btn" name="btn_reset"><img src="../images/main/btn_refresh_w.png" alt="초기화"> 초기화</button>
					</div>
				</div>
			</div>
			<div>
				<table class="table_type_03">
				    <colgroup>
						<col width="15%" />
						<col width="40%" />
						<col width="40%" />
						<col width="5%" />
					</colgroup>
				    <thead>
			      		<tr>
					      	<th>구분</th>
					        <th>조건1</th>
					        <th>조건2</th>
					        <th>변경</th>
				      	</tr>
				    </thead>
				    <tr>
				      <td class="sbn_tit_001">기간</td>
				      <td><span class="paramPeriod1 "></span></td>
				      <td><span class="paramPeriod2"></span></td>
				      <td><button class="btn_type_05" id="btn_cmprPeriod">변경</button></td>
				    </tr>
				    <tr>
				      <td class="sbn_tit_001">부류</td>
				      <td><ul class="param__list paramFlowerCtgr1"></ul></td>
				      <td><ul class="param__list paramFlowerCtgr2"></ul></td>
				      <td><button class="btn_type_05" id="btn_cmprFlowerCtgr">변경</button></td>
				    </tr>
				    <tr>
				      <td class="sbn_tit_001">경매장</td>
				      <td><ul class="param__list paramMarket1"></ul></td>
				      <td><ul class="param__list paramMarket2"></ul></td>
				      <td><button class="btn_type_05" id="btn_cmprMarket">변경</button></td>
				    </tr>
				    <tr>
				      <td class="sbn_tit_001">품목</td>
				      <td><ul class="param__list paramItem1"></ul></td>
				      <td><ul class="param__list paramItem2"></ul></td>
				      <td><button class="btn_type_05" id="btn_cmprItem">변경</button></td>
				    </tr>
				    <tr>
				      <td class="sbn_tit_001">품종</td>
				      <td><ul class="param__list paramItemDtl1"></ul></td>
				      <td><ul class="param__list paramItemDtl2"></ul></td>
				      <td><button class="btn_type_05" id="btn_cmprItemDtl">변경</button></td>
				    </tr>
			  	</table>
			</div>

			<!-- 로딩바(S) -->
			<div id="progress_loading">
				<img src="../../images/loadingBar.gif"/>
			</div>
			<!-- 로딩바(E) -->
		</div>


		<!--컨텐츠 내용(S)-->
		<div class="sub_guide">
			<div class="sub_info_box">
				<div class="tit_box_01">
					<div class="fl">
						<h4 class="title_02">검색결과</h4>
					</div>
					<!-- <div class="fr dwn_bt_b"> -->
					<div class="fr">
						<div class="dwn_bt_b" id="excelBtn1"><a href="javascript:void(0);" id="exportBtn1" name="exportTable1" onclick="excelExport();"><img src="../images/2020/exel.png" alt="엑셀이미지">엑셀저장</a></div><br/>
						<span class="txt-unit">(단위 : 원/단)</span>
					</div>
				</div>
			</div>
			<!-- 테이블(S) -->
			<div>
				<table class="table_type_01 btg tiny">
					<caption>통계비교</caption>
					<colgroup>
						<col style="width:18%">
						<col style="width:18%">
						<col style="width:18%">
						<col style="width:18%">
						<col style="width:18%">
						<col style="width:18%">
					</colgroup>
					<thead>
						<tr>
							<th class="tc">비교</th>
							<th class="tc">총금액</th>
							<th class="tc">최대금액</th>
							<th class="tc">최저금액</th>
							<th class="tc">평균금액</th>
							<th class="tc">수량</th>
						</tr>
					</thead>
					<tbody id="get1"></tbody>
					<tbody id="get2"></tbody>
				</table>
			</div>
			<!-- 테이블(E) -->
				<!-- table -->
				<!--
				<div class="info_box">
					<div class="ui-jqgrid ui-widget ui-widget-content ui-corner-all">
						<div class="ui-jqgrid-view">
							<div class="ui-state-default ui-jqgrid-hdiv">
								<div class="ui-jqgrid-hbox">
									<table id="tb__list" class="display compact nowrap ui-jqgrid-htable" style="width: 100%;">
										<colgroup>
											<col width="10%" />
											<col width="18%" />
											<col width="18%" />
											<col width="18%" />
											<col width="18%" />
											<col width="18%" />
										</colgroup>
										<thead>
										  <tr class="ui-jqgrid-labels ui-sortable">
											<th class="ui-state-default ui-th-column ui-th-ltr"><div class="ui-jqgrid-sortable">비교</div></th>
											<th class="ui-state-default ui-th-column ui-th-ltr"><div class="ui-jqgrid-sortable">총금액</div></th>
											<th class="ui-state-default ui-th-column ui-th-ltr"><div class="ui-jqgrid-sortable">최대금액</div></th>
											<th class="ui-state-default ui-th-column ui-th-ltr"><div class="ui-jqgrid-sortable">최저금액</div></th>
											<th class="ui-state-default ui-th-column ui-th-ltr"><div class="ui-jqgrid-sortable">평균금액</div></th>
											<th class="ui-state-default ui-th-column ui-th-ltr"><div class="ui-jqgrid-sortable">수량</div></th>
										  </tr>
										</thead>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
				-->
				<!-- chart -->
				<!--
				<div class="sub_info_box">
					<div class="tit_box_01">
						<div class="fl">
							<h4 class="title_02">검색결과</h4>
						</div>
					</div>
				</div>
				-->
				<div class="info_box">
					<div id="chartHolder" style="width: 100%; height: 344px;"></div>
				</div>

				<div class="guide">
					<h2 class="title_02">이용안내</h2>
					<ul class="guide_box">
						<li>· 경매통계를 조건별로 비교할 수 있는 화면 </li>
						<li>· 단위 : 단(속), 단가(원) / 자료출처 : 각 공판장별 경매 자료 현황</li>
						<li>· 최대, 최소금액은 조회기간중에 최대값과 최소값을 나타내는 수치입니다. </li>
						<li>· 단순집계 자료이므로 <strong>참고자료</strong>로만 활용하시기 바랍니다.</li>
					</ul>
				</div>
			</div>

		<!--컨텐츠 내용(E)-->

		<jsp:include page="../inc/2020/IncFooter.jsp"/>
	</div>
	<!--WRAP(E)-->

	<!-- POPUP (S)-->
	<!-- The Modal -->
	<div id="cmprPopup" class="modal">
	  <!-- Modal content -->
	  <div class="modal-content">
	    <div class="modal-body">
			<jsp:include page="../popup/cmpr_popup.jsp"/>
	    </div>
	  </div>
	</div>
<script>

	function SeparatCom(num) {
		return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
	}

	let tempDate = new Date();
	let defaultDate = tempDate.toISOString().substr(0, 10);

	const objHab11 = {
		param: {
			period: {
				isPeriodCmpr: false,
				isDayCond1: false,
				cond1DateFrom: defaultDate.substr(0, 8) + '01',
				cond1DateTo: defaultDate,
				isDayCond2: false,
				cond2DateFrom: defaultDate.substr(0, 8) + '01',
				cond2DateTo: defaultDate
			},
			flowerCtgr: [],
			market: [],
			item: [],
			itemDtl: []
		},
		setGrid : function() {
			$("#get1").empty();
			$("#get2").empty();

			let flower1 = [];
			let flower2 = [];
			objHab11.param.flowerCtgr.forEach(function(cond, idx, arr) {
				if (!isEmpty(cond.cdId1)) {
					flower1.push(cond.cdId1);
				}
				if (!isEmpty(cond.cdId2)) {
					flower2.push(cond.cdId2);
				}
			});

			let market1 = [];
			let market2 = [];
			objHab11.param.market.forEach(function(cond, idx, arr) {
				if (!isEmpty(cond.cdId1)) {
					market1.push(cond.cdId1);
				}
				if (!isEmpty(cond.cdId2)) {
					market2.push(cond.cdId2);
				}
			});

			let item1 = [];
			let item2 = [];
			objHab11.param.item.forEach(function(cond, idx, arr) {
				if (!isEmpty(cond.cdId1)) {
					item1.push(cond.cdId1);
				}
				if (!isEmpty(cond.cdId2)) {
					item2.push(cond.cdId2);
				}
			});

			let itemDtl1 = [];
			let itemDtl2 = [];
			objHab11.param.itemDtl.forEach(function(cond, idx, arr) {
				if (!isEmpty(cond.cdId1)) {
					itemDtl1.push(cond.cdId1);
				}
				if (!isEmpty(cond.cdId2)) {
					itemDtl2.push(cond.cdId2);
				}
			});

			// console.log(objHab11.param);
			let param = {
				saleDate1From: objHab11.param.period.cond1DateFrom,
				saleDate1To: objHab11.param.period.cond1DateTo,
				saleDate2From: objHab11.param.period.cond2DateFrom,
				saleDate2To: objHab11.param.period.cond2DateTo,
				flower1: flower1,
				market1: market1,
				item1: item1,
				itemDtl1: itemDtl1,
				flower2: flower2,
				market2: market2,
				item2: item2,
				itemDtl2: itemDtl2
			};

			let url = "/hab11/selectList.json";
			$.ajax({
				type : "post",
				url : url,
				data : param,
				dataType : 'json',
				success : function(res){
					let val = res.list;

					let diffVal = {
						cdNm: "차이",
						totAmt: 0,
						maxAmt: 0,
						minAmt: 0,
						avgAmt: 0,
						totQty: 0
					}

					if(val != ""){
						let html = "";
						for(var i=0; i<val.length; i++){

							let totAmt = parseInt(val[i].totAmt) || 0;
							let maxAmt = parseInt(val[i].maxAmt) || 0;
							let minAmt = parseInt(val[i].minAmt) || 0;
							let avgAmt = parseInt(val[i].avgAmt) || 0;
							let totQty = parseInt(val[i].totQty) || 0;

							// 비교 | 총금액 | 최대 | 최저 | 평균 | 총수량
							html += "<tr>";
							html += "<td class='tc'><p>" + val[i].cdNm + "</p></td>";
							html += "<td class='tc'><p>" + SeparatCom(totAmt) + "</p></td>";
							html += "<td class='tc'><p>" + SeparatCom(maxAmt) + "</p></td>";
							html += "<td class='tc'><p>" + SeparatCom(minAmt) + "</p></td>";
							html += "<td class='tc'><p>" + SeparatCom(avgAmt) + "</p></td>";
							html += "<td class='tc'><p>" + SeparatCom(totQty) + "</p></td>";
							html += "</tr>";
							if (i == 0) {
								diffVal.totAmt += totAmt;
								diffVal.maxAmt += maxAmt;
								diffVal.minAmt += minAmt;
								diffVal.avgAmt += avgAmt;
								diffVal.totQty += totQty;
							} else {
								diffVal.totAmt -= totAmt;
								diffVal.maxAmt -= maxAmt;
								diffVal.minAmt -= minAmt;
								diffVal.avgAmt -= avgAmt;
								diffVal.totQty -= totQty;
							}
						}
						$("#get1").append(html);

						/* 
						html = "";
						html += "<tr>";
						html += "<td class='tc'><p>" + diffVal.cdNm + "</p></td>";
						if (diffVal.totAmt > 0) {
							html += "<td class='tc'><span class='qty__blue'>" + SeparatCom(diffVal.totAmt) + "</span></td>";
						} else {
							html += "<td class='tc'><span class='qty__red'>" + SeparatCom(diffVal.totAmt) + "</span></td>";
						}
						if (diffVal.maxAmt > 0) {
							html += "<td class='tc'><span class='qty__blue'>" + SeparatCom(diffVal.maxAmt) + "</span></td>";
						} else {
							html += "<td class='tc'><span class='qty__red'>" + SeparatCom(diffVal.maxAmt) + "</span></td>";
						}
						if (diffVal.minAmt > 0) {
							html += "<td class='tc'><span class='qty__blue'>" + SeparatCom(diffVal.minAmt) + "</span></td>";
						} else {
							html += "<td class='tc'><span class='qty__red'>" + SeparatCom(diffVal.minAmt) + "</span></td>";
						}
						if (diffVal.avgAmt > 0) {
							html += "<td class='tc'><span class='qty__blue'>" + SeparatCom(diffVal.avgAmt) + "</span></td>";
						} else {
							html += "<td class='tc'><span class='qty__red'>" + SeparatCom(diffVal.avgAmt) + "</span></td>";
						}
						if (diffVal.totQty > 0) {
							html += "<td class='tc'><span class='qty__blue'>" + SeparatCom(diffVal.totQty) + "</span></td>";
						} else {
							html += "<td class='tc'><span class='qty__red'>" + SeparatCom(diffVal.totQty) + "</span></td>";
						}
						html += "</tr>";
						$("#get2").append(html);
						 */
					}else{
						$("#get1").append("<tr><td colspan='5'>데이터가 없습니다.</td></tr>");
					}

					objHab11.setChart(val);
				}
			});
		},
		setChart: function(data) {

			let maxQty = 0;
			let axisMax = 0;
			let axisMax2 = 0;

			chartData = [];
			chartData2 = [];
			const cmprTotAmt = {
				"ctgr" : "총금액",
				"cmpr1" : 0,
				"cmpr2" : 0
			};
			const cmprMaxAmt = {
				"ctgr" : "최대금액",
				"cmpr1" : 0,
				"cmpr2" : 0
			};
			const cmprMinAmt = {
				"ctgr" : "최저금액",
				"cmpr1" : 0,
				"cmpr2" : 0
			};
			const cmprAvgAmt = {
				"ctgr" : "평균금액",
				"cmpr1" : 0,
				"cmpr2" : 0
			};
			const cmprTotQty = {
				"ctgr" : "총수량",
				"cmpr1" : 0,
				"cmpr2" : 0
			};

			for(var i=0; i<data.length; i++){

				let totQty = parseInt(data[i].totQty);
				let totAmt = parseInt(data[i].totAmt);
				let maxAmt = parseInt(data[i].maxAmt);
				let minAmt = parseInt(data[i].minAmt);
				let avgAmt = parseInt(data[i].avgAmt);

				maxQty = maxQty > totQty ? maxQty : totQty;
				axisMax = axisMax > totAmt ? axisMax : totAmt;
				axisMax = axisMax > totQty ? axisMax : totQty;

				axisMax2 = axisMax2 > maxAmt ? axisMax2 : maxAmt;
				axisMax2 = axisMax2 > minAmt ? axisMax2 : minAmt;
				axisMax2 = axisMax2 > avgAmt ? axisMax2 : avgAmt;
				axisMax2 = axisMax2 > totQty ? axisMax2 : totQty;

				if (i==0) {
					cmprTotAmt.cmpr1 = data[i].totAmt;
					cmprMaxAmt.cmpr1 = data[i].maxAmt;
					cmprMinAmt.cmpr1 = data[i].minAmt;
					cmprAvgAmt.cmpr1 = data[i].avgAmt;
					cmprTotQty.cmpr1 = data[i].totQty;
				} else {
					cmprTotAmt.cmpr2 = data[i].totAmt;
					cmprMaxAmt.cmpr2 = data[i].maxAmt;
					cmprMinAmt.cmpr2 = data[i].minAmt;
					cmprAvgAmt.cmpr2 = data[i].avgAmt;
					cmprTotQty.cmpr2 = data[i].totQty;
				}
			}
			chartData.push(cmprTotAmt);
			chartData.push(cmprMaxAmt);
			chartData.push(cmprMinAmt);
			chartData.push(cmprAvgAmt);
			chartData.push(cmprTotQty);

			let brokenMinimum = 0;
			let brokenMaximum = 0;
			let needBrokenAxis = false;
			if (axisMax > axisMax2 * 10) {
				needBrokenAxis = true;
				brokenMinimum = axisMax2 * 1.2;
				brokenMaximum = axisMax * 0.7;
			}

			axisMax *= 1.1;
			maxQty *= 1.1;
			layoutStr =
				'<rMateChart backgroundColor="#FFFFFF" borderStyle="none">'
				+'<Options>'
					+'<SubCaption text="금액(원)" textAlign="left" />'
					+'<SubCaption text="수량(단)" textAlign="right" />'
					+'<Legend position="bottom" defaultMouseOverAction="false" useVisibleCheck="false" />'
				+'</Options>'
				+'<NumberFormatter id="numFmt" useThousandsSeparator="true"/>'
				+'<Column2DChart showDataTips="true" columnWidthRatio="0.55" selectionMode="single">'
                    +'<horizontalAxis>'
                       +'<CategoryAxis categoryField="ctgr"/>'
                    +'</horizontalAxis>'
					+'<verticalAxis>'
						+ '<LinearAxis id="vAxis1" formatter="{numFmt}" maximum="'+axisMax+'"/>'
					+'</verticalAxis>'
					+'<series>'
						+'<Column2DSeries halfWidthOffset="1" labelPosition="outside" yField="cmpr1" displayName="조건1" showValueLabels="[3]" outsideLabelYOffset="-2">'
                          +'<showDataEffect>'
                               +'<SeriesInterpolate/>'
                           +'</showDataEffect>'
                      	+'</Column2DSeries>'
						  +'<Column2DSeries halfWidthOffset="1" labelPosition="outside" yField="cmpr2" displayName="조건2" showValueLabels="[3]" outsideLabelYOffset="-2">'
                          +'<showDataEffect>'
                               +'<SeriesInterpolate/>'
                           +'</showDataEffect>'
                      	+'</Column2DSeries>'
					+'</series>'
					+'<verticalAxisRenderers>'
		            	+'<Axis2DRenderer axis="{vAxis1}" placement="left" showLine="false"/>'
		        	+'</verticalAxisRenderers>'
				+'</Column2DChart>'
			+'</rMateChart>';

			rMateChartLoding("chart1", "chartReadyHandler");
		}
	};

	const resetParam = function() {
		
		objHab11.param.period = {
				isPeriodCmpr: false,
				isDayCond1: false,
				cond1DateFrom: '',
				cond1DateTo: '',
				isDayCond2: false,
				cond2DateFrom: '',
				cond2DateTo: ''
		};
		objHab11.param.flowerCtgr.length = 0;
		objHab11.param.market.length = 0;
		objHab11.param.item.length = 0;
		objHab11.param.itemDtl.length = 0;

		let paramPeriod1 = document.querySelector('.paramPeriod1');
		paramPeriod1.textContent = '';
		let paramPeriod2 = document.querySelector('.paramPeriod2');
		paramPeriod2.textContent = '';
		let paramFlowerCtgr1 = document.querySelector('.paramFlowerCtgr1');
		while (paramFlowerCtgr1.firstChild) {
			paramFlowerCtgr1.firstChild.remove()
        }
		let paramFlowerCtgr2 = document.querySelector('.paramFlowerCtgr2');
		while (paramFlowerCtgr2.firstChild) {
			paramFlowerCtgr2.firstChild.remove()
        }
		let paramMarket1 = document.querySelector('.paramMarket1');
		while (paramMarket1.firstChild) {
			paramMarket1.firstChild.remove()
        }
		let paramMarket2 = document.querySelector('.paramMarket2');
		while (paramMarket2.firstChild) {
			paramMarket2.firstChild.remove()
        }
		let paramItem1 = document.querySelector('.paramItem1');
		while (paramItem1.firstChild) {
			paramItem1.firstChild.remove()
        }
		let paramItem2 = document.querySelector('.paramItem2');
		while (paramItem2.firstChild) {
			paramItem2.firstChild.remove()
        }
		let paramItemDtl1 = document.querySelector('.paramItemDtl1');
		while (paramItemDtl1.firstChild) {
			paramItemDtl1.firstChild.remove()
        }
		let paramItemDtl2 = document.querySelector('.paramItemDtl2');
		while (paramItemDtl2.firstChild) {
			paramItemDtl2.firstChild.remove()
        }
	};

	const setParam = function(param) {

		resetParam();

		if (!isEmpty(param.period)) {

			objHab11.param.period = param.period;

			let paramPeriod1 = document.querySelector('.paramPeriod1');
			let paramPeriod2 = document.querySelector('.paramPeriod2');
			if (!isEmpty(param.period.cond1DateFrom)) {
				paramPeriod1.textContent = param.period.cond1DateFrom;
			}
			if (!isEmpty(param.period.cond1DateTo)) {
				paramPeriod1.textContent += ' ~ ' + param.period.cond1DateTo;
			}

			if (!isEmpty(param.period.cond2DateFrom)) {
				paramPeriod2.textContent = param.period.cond2DateFrom;
			}
			if (!isEmpty(param.period.cond1DateTo)) {
				paramPeriod2.textContent += ' ~ ' + param.period.cond2DateTo;
			}
		}

		if (!isEmpty(param.flowerCtgr)) {
			param.flowerCtgr.forEach(function(item){
				objHab11.param.flowerCtgr.push(item);
			});

			let paramFlowerCtgr1 = document.querySelector('.paramFlowerCtgr1');
			let paramFlowerCtgr2 = document.querySelector('.paramFlowerCtgr2');
			param.flowerCtgr.forEach(function(rs) {
				if (!isEmpty(rs.cdId1)) {
					let li = document.createElement('li');
			        li.innerText = rs.cdNm1;
			        paramFlowerCtgr1.appendChild(li);
				}
				if (!isEmpty(rs.cdId2)) {
					let li = document.createElement('li');
			        li.innerText = rs.cdNm2;
			        paramFlowerCtgr2.appendChild(li);
				}
		    });
		}

		if (!isEmpty(param.market)) {
			param.market.forEach(function(item){
				objHab11.param.market.push(item);
			});
			let paramMarket1 = document.querySelector('.paramMarket1');
			let paramMarket2 = document.querySelector('.paramMarket2');
			param.market.forEach(function(rs) {
				if (!isEmpty(rs.cdId1)) {
					let li = document.createElement('li');
			        li.innerText = rs.cdNm1;
			        paramMarket1.appendChild(li);
				}
				if (!isEmpty(rs.cdId2)) {
					let li = document.createElement('li');
			        li.innerText = rs.cdNm2;
			        paramMarket2.appendChild(li);
				}
		    });
		}

		if (!isEmpty(param.item)) {
			param.item.forEach(function(item){
				objHab11.param.item.push(item);
			});
			let paramItem1 = document.querySelector('.paramItem1');
			let paramItem2 = document.querySelector('.paramItem2');
			param.item.forEach(function(rs) {
				if (!isEmpty(rs.cdId1)) {
					let li = document.createElement('li');
			        li.innerText = rs.cdNm1;
			        paramItem1.appendChild(li);
				}
				if (!isEmpty(rs.cdId2)) {
					let li = document.createElement('li');
			        li.innerText = rs.cdNm2;
			        paramItem2.appendChild(li);
				}
		    });
		}

		if (!isEmpty(param.itemDtl)) {
			param.itemDtl.forEach(function(item){
				objHab11.param.itemDtl.push(item);
			});

			let paramItemDtl1 = document.querySelector('.paramItemDtl1');
			let paramItemDtl2 = document.querySelector('.paramItemDtl2');
			param.itemDtl.forEach(function(rs) {
				if (!isEmpty(rs.cdId1)) {
					let li = document.createElement('li');
			        li.innerText = rs.cdNm1;
			        paramItemDtl1.appendChild(li);
				}
				if (!isEmpty(rs.cdId2)) {
					let li = document.createElement('li');
			        li.innerText = rs.cdNm2;
			        paramItemDtl2.appendChild(li);
				}
		    });
		}
	};

	document.addEventListener("DOMContentLoaded", function(){

		$('#progress_loading').hide();

		cmprPopup.init(setParam);

		let btn_cmprPeriod = document.querySelector('#btn_cmprPeriod');
		btn_cmprPeriod.addEventListener("click", function() {
			cmprPopup.openPopup("tp__period", objHab11.param);
		});
		let btn_cmprFlowerCtgr = document.querySelector('#btn_cmprFlowerCtgr');
		btn_cmprFlowerCtgr.addEventListener("click", function() {
			cmprPopup.openPopup("tp__flowerCtgr", objHab11.param);
		});
		let btn_cmprMarket = document.querySelector('#btn_cmprMarket');
		btn_cmprMarket.addEventListener("click", function() {
			cmprPopup.openPopup("tp__market", objHab11.param);
		});
		let btn_cmprItem = document.querySelector('#btn_cmprItem');
		btn_cmprItem.addEventListener("click", function() {
			cmprPopup.openPopup("tp__item", objHab11.param);
		});
		let btn_cmprItemDtl = document.querySelector('#btn_cmprItemDtl');
		btn_cmprItemDtl.addEventListener("click", function() {
			cmprPopup.openPopup("tp__itemDtl", objHab11.param);
		});

		let btn_search = document.querySelector('button[name="btn_search"]');
		btn_search.addEventListener("click", function() {
			objHab11.setGrid();
		});



		let btn_reset = document.querySelector('button[name="btn_reset"]');
		btn_reset.addEventListener("click", function() {
			resetParam();
			cmprPopup.setResult(objHab11.param);
			cmprPopup.redrawResult();
		});

		// tb__list set grid
		// 부류 결과 Table
		$('#tb__list').DataTable({
			scrollCollapse: false,
			paging: false ,
			searching : false,
			info : false,
			columns: [
				{data: 'cdNm', className: 'dt-center', orderable: false, searchable: false},
				{
					data: 'totAmt',
					orderable: false,
					searchable: false,
					className : 'dt-right'
				},
				{
					data: 'maxAmt',
					orderable: false,
					searchable: false,
					className : 'dt-right'
				},
				{
					data: 'minAmt',
					orderable: false,
					searchable: false,
					className : 'dt-right'
				},
				{
					data: 'avgAmt',
					orderable: false,
					searchable: false,
					className : 'dt-right'
				},
				{
					data: 'totQty',
					orderable: false,
					searchable: false,
					className : 'dt-right'
				}
			]
		});
	});

	function excelExport(){

		var excelNm = "경매통계비교";
		let url = "/excel/excelDownLoadHab11.do";
   		let param = "?excelNm=" + excelNm
   					+ "&saleDate1From=" + objHab11.param.period.cond1DateFrom
   					+ "&saleDate1To=" + objHab11.param.period.cond1DateTo
   					+ "&saleDate2From=" + objHab11.param.period.cond2DateFrom
   					+ "&saleDate2To=" + objHab11.param.period.cond2DateTo;
   		
		
		let flower1 = [];
		let flower2 = [];
		objHab11.param.flowerCtgr.forEach(function(cond, idx, arr) {
			if (!isEmpty(cond.cdId1)) {
				flower1.push(cond.cdId1);
			}
			if (!isEmpty(cond.cdId2)) {
				flower2.push(cond.cdId2);
			}
		});
		param += "&flower1Str="+ flower1.join(',');
		param += "&flower2Str="+ flower2.join(',');

		let market1 = [];
		let market2 = [];
		objHab11.param.market.forEach(function(cond, idx, arr) {
			if (!isEmpty(cond.cdId1)) {
				market1.push(cond.cdId1);
			}
			if (!isEmpty(cond.cdId2)) {
				market2.push(cond.cdId2);
			}
		});
		param += "&market1Str="+ market1.join(',');
		param += "&market2Str="+ market2.join(',');

		let item1 = [];
		let item2 = [];
		objHab11.param.item.forEach(function(cond, idx, arr) {
			if (!isEmpty(cond.cdId1)) {
				item1.push(cond.cdId1);
			}
			if (!isEmpty(cond.cdId2)) {
				item2.push(cond.cdId2);
			}
		});
		param += "&item1Str="+ item1.join(',');
		param += "&item2Str="+ item2.join(',');

		let itemDtl1 = [];
		let itemDtl2 = [];
		objHab11.param.itemDtl.forEach(function(cond, idx, arr) {
			if (!isEmpty(cond.cdId1)) {
				itemDtl1.push(cond.cdId1);
			}
			if (!isEmpty(cond.cdId2)) {
				itemDtl2.push(cond.cdId2);
			}
		});
		param += "&itemDtl1Str="+ itemDtl1.join(',');
		param += "&itemDtl2Str="+ itemDtl2.join(',');
		// console.log(url+param);
		
   		location.href = url+param;
   		
	}

</script>
	<!-- POPUP (E)-->

</body>