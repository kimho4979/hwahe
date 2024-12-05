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
	<meta name="description" content="금주(월)의 인기품목">
	<meta name="content" content="화훼유통정보시스템 입니다.">
	<meta name="keywords" content="화훼경매시세, 화훼경매가격, Korea aT flower market auction price, 화훼공판장, 화훼거래정보, 꽃시장, 꽃값">
	<meta name="Author" content="화훼유통정보시스템 & www.woorim.co.kr">
	<title>금주(월)의 인기품목</title>	
	<%@include file="../common/2020/commonJs.jsp" %>
	<%@include file="../common/2020/commonCss.jsp" %>
	
	<script type="text/javascript">
	$(document).ready(function(){
		// 주/월 단위 선택
		$(".dateGbnTab li").click(function(){
			flowerCd = $("#flowerTab .on > input").attr("value");
			dateGbn = $(this).data('id');
			
			$(".dateGbnTab li").removeClass('s_on');
			$(this).addClass('s_on');
			
			selectPopular();
			return false;
		});
		
		// WEB 부류선택 선택
		$(".flowerTab li a").click(function(){
			flowerCd = $("#flowerTab .on > input").attr("value");
			dateGbn = $(".dateGbnTab  .s_on").data('id');
			
			selectPopular();
			return false;
		});
	});
	
	
	// ---------- 차트 설정 시작 --------------------
	
	var chartVars = "rMateOnLoadCallFunction=chartReadyHandler";
	var chartVars2 = "rMateOnLoadCallFunction=chartReadyHandler2";
	
	rMateChartH5.create("chart1", "chartHolder", chartVars, "100%", "100%"); 
	rMateChartH5.create("chart2", "chartHolder2", chartVars2, "100%", "100%"); 
	
	function chartReadyHandler(id) {
		document.getElementById(id).setLayout(layoutStr);
		document.getElementById(id).setData(chartData);
	}
	
	function chartReadyHandler2(id) {
		document.getElementById(id).setLayout(layoutStr2);
		document.getElementById(id).setData(chartData2);
	}
	
	
	
	
	
	var layoutStr = 
		'<rMateChart  backgroundColor="#ffffff" borderStyle="none">'
			+'<Options>'	
				+'<SubCaption text="단위 : 속" textAlign="left" />'
				+'<Legend defaultMouseOverAction="false" useVisibleCheck="true"/>'
			+'</Options>'
			+'<NumberFormatter id="numFmt" precision="0"/>'
			+'<NumberFormatter id="numFmt2" useThousandsSeparator="true"/>'
			+'<Line2DChart showDataTips="true" dataTipDisplayMode="axis" paddingTop="0">'
				+'<horizontalAxis>'
					+'<CategoryAxis categoryField="saleDate"/>'
				+'</horizontalAxis>'
				+'<verticalAxis>'
					+'<LinearAxis formatter="{numFmt2}" minimum="0" />'
				+'</verticalAxis>'
			+'<series>'
				+'<Line2DSeries  yField="qtyOne" minimum="0" fill="#ffffff" radius="5" displayName="1순위"  itemRenderer="DiamondItemRenderer">'
				/* 아이템렌더러(데이터 마커) 테두리 색상 */
					+'<stroke><Stroke color="#fe6500" weight="1"/></stroke>'
						+'<showDataEffect>'
							+'<SeriesInterpolate/>'
						+'</showDataEffect>'
					+'</Line2DSeries>'
				+'<Line2DSeries  yField="qtyTwo" minimum="0" fill="#ffffff" radius="5" displayName="2순위"  itemRenderer="CircleItemRenderer">'
				/* itemRenderer는 Circle입니다 */
					+'<stroke><Stroke color="#ffb801" weight="1"/></stroke>'
						+'<showDataEffect>'
							+'<SeriesInterpolate/>'
						+'</showDataEffect>'
					+'</Line2DSeries>'
				+'<Line2DSeries  yField="qtyThree" minimum="0" fill="#ffffff" radius="5" displayName="3순위"  itemRenderer="TriangleItemRenderer">'
				/* itemRenderer는 Triangle입니다 */
					+'<stroke><Stroke color="#5fc502" weight="1"/></stroke>'
						+'<showDataEffect>'
							+'<SeriesInterpolate/>'
						+'</showDataEffect>'
					+'</Line2DSeries>'
				+'<Line2DSeries  yField="qtyFour" minimum="0" fill="#ffffff" radius="5" displayName="4순위"  itemRenderer="CrossItemRenderer">'
				/* itemRenderer는 Triangle입니다 */
					+'<stroke><Stroke color="#666666" weight="1"/></stroke>'
						+'<showDataEffect>'
							+'<SeriesInterpolate/>'
						+'</showDataEffect>'
					+'</Line2DSeries>'
				+'<Line2DSeries  yField="qtyFive" minimum="0" fill="#ffffff" radius="5" displayName="5순위"  itemRenderer="XShapeItemRenderer">'
				/* itemRenderer는 Triangle입니다 */
					+'<stroke><Stroke color="#5ECFCF" weight="1"/></stroke>'
						+'<showDataEffect>'
							+'<SeriesInterpolate/>'
						+'</showDataEffect>'
				+'</Line2DSeries>'
				+'<Line2DSeries  yField="qtySix" minimum="0" fill="#ffffff" radius="5" displayName="6순위" itemRenderer="IShapeItemRenderer">'
				/* itemRenderer는 Triangle입니다 */
					+'<stroke><Stroke color="#3284C3" weight="1"/></stroke>'
						+'<showDataEffect>'
							+'<SeriesInterpolate/>'
						+'</showDataEffect>'
				+'</Line2DSeries>'
			+'</series>'
			+'</Line2DChart>'
		+'</rMateChart>';
	
	var layoutStr2 = 
		'<rMateChart  backgroundColor="#ffffff" borderStyle="none">'
		+'<Options>'			
			+'<SubCaption text="단위 : 원" textAlign="left" />'
			+'<Legend defaultMouseOverAction="false" useVisibleCheck="true"/>'
		+'</Options>'
		+'<NumberFormatter id="numFmt2" useThousandsSeparator="true"/>'
		+'<NumberFormatter id="numFmt" precision="0"/>'
		+'<Line2DChart showDataTips="true" dataTipDisplayMode="axis" paddingTop="0">'
			+'<horizontalAxis>'
				+'<CategoryAxis categoryField="saleDate"/>'
			+'</horizontalAxis>'
			+'<verticalAxis>'
				+'<LinearAxis formatter="{numFmt2}" minimum="0" />'
			+'</verticalAxis>'
			+'<series>'
			+'<Line2DSeries  yField="amtOne" minimum="0" fill="#ffffff" radius="5" displayName="1순위"  itemRenderer="DiamondItemRenderer">'
				/* 아이템렌더러(데이터 마커) 테두리 색상 */
				+'<stroke><Stroke color="#fe6500" weight="1"/></stroke>'
				+'<showDataEffect>'
					+'<SeriesInterpolate/>'
				+'</showDataEffect>'
			+'</Line2DSeries>'
			+'<Line2DSeries  yField="amtTwo" minimum="0" fill="#ffffff" radius="5" displayName="2순위"  itemRenderer="CircleItemRenderer">'
			/* itemRenderer는 Circle입니다 */
				+'<stroke><Stroke color="#ffb801" weight="1"/></stroke>'
				+'<showDataEffect>'
					+'<SeriesInterpolate/>'
				+'</showDataEffect>'
			+'</Line2DSeries>'
				+'<Line2DSeries  yField="amtThree" minimum="0" fill="#ffffff" radius="5" displayName="3순위"  itemRenderer="TriangleItemRenderer">'
				/* itemRenderer는 Triangle입니다 */
					+'<stroke><Stroke color="#5fc502" weight="1"/></stroke>'
					+'<showDataEffect>'
						+'<SeriesInterpolate/>'
					+'</showDataEffect>'
			+'</Line2DSeries>'
			+'<Line2DSeries  yField="amtFour" minimum="0" fill="#ffffff" radius="5" displayName="4순위" itemRenderer="CrossItemRenderer">'
			/* itemRenderer는 Triangle입니다 */
				+'<stroke><Stroke color="#666666" weight="1"/></stroke>'
				+'<showDataEffect>'
					+'<SeriesInterpolate/>'
				+'</showDataEffect>'
			+'</Line2DSeries>'
			+'<Line2DSeries  yField="amtFive" minimum="0" fill="#ffffff" radius="5" displayName="5순위" itemRenderer="XShapeItemRenderer">'
			/* itemRenderer는 Triangle입니다 */
				+'<stroke><Stroke color="#5ECFCF" weight="1"/></stroke>'
					+'<showDataEffect>'
						+'<SeriesInterpolate/>'
					+'</showDataEffect>'
			+'</Line2DSeries>'
			+'<Line2DSeries  yField="amtSix" minimum="0" fill="#ffffff" radius="5" displayName="6순위" itemRenderer="IShapeItemRenderer">'
			/* itemRenderer는 Triangle입니다 */
				+'<stroke><Stroke color="#3284C3" weight="1"/></stroke>'
				+'<showDataEffect>'
					+'<SeriesInterpolate/>'
				+'</showDataEffect>'
			+'</Line2DSeries>'
			+'</series>'
		+'</Line2DChart>'
		+'</rMateChart>';			

		var chartData =[];
		var chartData2 =[];

		function rMateChartH5ChangeTheme(theme){
			document.getElementById("chart1").setTheme(theme);
		}

	// ---------- 차트 설정 끝 --------------------

	
	function getBaseDate(){
		var BaseDate = new Date();
		BaseDate.setMonth(BaseDate.getMonth()-1);
		var bMonth = BaseDate.getMonth();
		var bYear = BaseDate.getFullYear();
		
		if(bMonth < 10) {bMonth = '0'+ bMonth;}
		
		return bYear + "-" + bMonth + '-01';
	}
		
	function selectPopular(){
		var flowerCd = $("#flowerTab .on > input").attr("value");
		var dateGubn = $(".dateGbnTab  .s_on").data('id');
		var searchStrDate = getBaseDate();

		$.cookie("cookie.flowerCd", flowerCd, { expires: 7, path: '/' });
		
	    $("#jqGrid").setGridParam({
	   	 	datatype	: "json"
	   	 ,	postData	: {
	   			flowerCd : flowerCd
			,	dateGubn : dateGubn
			,	searchStrDate : searchStrDate
			,	queryType : 'qty'
			}
    	,	page : 1
	    }).trigger("reloadGrid");

	    $("#jqGrid2").setGridParam({
	   	 	datatype	: "json"
	   	 ,	postData	: {
	   			flowerCd : flowerCd
			,	dateGubn : dateGubn
			,	searchStrDate : searchStrDate
			,	queryType : 'cost'
			}
    	,	page : 1
	    }).trigger("reloadGrid");

		
		$("#jqGrid").jqGrid({
			url : "/item/selectItemPopularList.json"
		,	mtype : "post"
		,	postData:{
				flowerCd : flowerCd
			,	dateGubn : dateGubn
			,	searchStrDate : searchStrDate
			,	queryType : 'qty'
			}
		,	datatype : "json"
		,	jsonReader : {
					root : "list"
				,	page : "page"
				,	total : "total"
				,	records : "records"
				,	repeatitems : false
			}
		,	colModel: [
					{ label: '품목', name: 'PUM_NAME', width: 120, editable: false , align:"center"}
				,	{ label: '금주(월) 최고거래량(속)', name: 'MAX_QTY', width: 100, editable: false, align:"center", sorttype: 'float', formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' } }
				,	{ label: '총 거래량(속)', name: 'TOT_QTY', width: 100, editable: false, align:"center", sorttype: 'float', formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' } }
				,	{ label: '품목코드', name: 'ITEM_CD', hidden:true}
				]
		,	loadonce : false
		,	rownumbers : true
		,	autowidth:true
		,	height: '100%'
		,	cmTemplate: { sortable: true }
		,	rowNum: 6
		,	loadComplete	: function(data) {
			var dataList = $("#jqGrid").getRowData();
			var qry_itemCd = "";
			for(var i = 0; i < dataList.length; i++){
				if(i == 0){
					qry_itemCd = qry_itemCd + dataList[i].ITEM_CD;
				}else{
					qry_itemCd = qry_itemCd + "," + dataList[i].ITEM_CD;
				}
			}
			makeChart(qry_itemCd);
		}
		});

		$("#jqGrid2").jqGrid({
			url : "/item/selectItemPopularList.json"
		,	mtype : "post"
		,	postData:{
				flowerCd : flowerCd
			,	dateGubn : dateGubn
			,	searchStrDate : searchStrDate
			,	queryType : 'cost'
			}
		,	datatype : "json"
		,	jsonReader : {
					root : "list"
				,	page : "page"
				,	total : "total"
				,	records : "records"
				,	repeatitems : false
			}
		,	colModel: [
					{ label: '품목', name: 'PUM_NAME', width: 120, editable: false , align:"center"}
				,	{ label: '최고단가(원)', name: 'MAX_AMT', width: 100, editable: false, align:"center", sorttype: 'float', formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' } }
				,	{ label: '평균단가(원)', name: 'AVG_AMT', width: 100, editable: false, align:"center", sorttype: 'float', formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' } }
				,	{ label: '품목코드', name: 'ITEM_CD', hidden:true}
				]
		,	loadonce : false
		,	rownumbers : true
		,	autowidth:true
		,	height: '100%'
		,	cmTemplate: {sortable: true }
		,	rowNum: 6
		,	loadComplete	: function(data) {
			var dataList = $("#jqGrid2").getRowData();
			var qry_itemCd = "";
			for(var i = 0; i < dataList.length; i++){
				if(i == 0){
					qry_itemCd = qry_itemCd + dataList[i].ITEM_CD;
				}else{
					qry_itemCd = qry_itemCd + "," + dataList[i].ITEM_CD;
				}
			}
			makeChart2(qry_itemCd);
		}
		});

	};
	
	function makeChart(qry_itemCd){
		var flowerCd = $("#flowerTab .on > input").attr("value");
		var dateGubn = $(".dateGbnTab  .s_on").data('id');
		var searchStrDate = getBaseDate();

		$.ajax({
			type : 'post'
		,	url : "/item/selectItemPopularChart.json"
		,	data : {
				flowerCd : flowerCd
			,	dateGubn : dateGubn
			,	qryItemCd : qry_itemCd
			,	searchStrDate : searchStrDate
			}
		,	dataType : ''
		,	success : function(res){
				chartData = res.list;
				
				rMateChartLoding("chart1", "chartReadyHandler");
			}
		});
	}

	function makeChart2(qry_itemCd){
		var flowerCd = $("#flowerTab .on > input").attr("value");
		var dateGubn = $(".dateGbnTab  .s_on").data('id');
		var searchStrDate = getBaseDate();

		$.ajax({
			type : 'post'
		,	url : "/item/selectItemPopularChart.json"
		,	data : {
				flowerCd : flowerCd
			,	dateGubn : dateGubn
			,	qryItemCd : qry_itemCd
			,	searchStrDate : searchStrDate
			}
		,	dataType : ''
		,	success : function(res){
				chartData2 = res.list;
				
				rMateChartLoding("chart2", "chartReadyHandler2");
			}
		});
	}

	
	function refreshChart(){
		chartData = [];                                                                                           
    	chartReadyHandler("chart1"); 
        chartData2 = [];                                                                                           
        chartReadyHandler2("chart2"); 
	}
	</script>

</head>
<body>
	<input type="hidden" id="searchProductGubun" name="searchProductGubun" value="1"/>
	<input type="hidden" id="searchCmpCd" name="searchCmpCd" value="0000000001"/>
	<input type="hidden" id="searchPumNm" name="searchPumNm" value=""/>
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
				<li>공판장 통합정보</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li class="m_right">금주(월)의 인기품목</li>
			</ul>
		</div>
		<!--sub 헤더 (E)-->
		<!--서브 타이틀(S)-->
		
		<jsp:include page="../inc/2020/IncShare.jsp"/>
		
		<div class="sub_title">
			<div class="title_box">
				<h2>금주(월)의 인기품목</h2>
				<img src="../images/2020/sub/t_line.png" alt="방울점선">
			</div>
		</div>
		<!--서브 타이틀(E)-->
				
		<div class="sub_contents">
			<!--서브 리스트 (S)-->
			<div class="sub_content">
				<ul class="sub_tab_02 dateGbnTab" id="dateGbnTab">
					<li class="s_on" data-id="week">
						<a href="#!">주 단위</a>
					</li>
					<li data-id="month">
						<a href="#!">월 단위</span></a>
					</li>
				</ul>
			</div>
			<!--서브 리스트 (E)-->
			<!--서브 TAB공통 (S)-->
			<div class="sub_tab_yangjae">
				<div class="yangjae_list">
					<ul class="sub_fw_btn_03 flowerTab btNo ptNo" id="flowerTab">
						<li class="step_01 on">
							<input type="hidden" value="1"/>
							<a href="#!" >								
								<img src="../images/2020/sub/step_01_on.png" alt="절화"><!--절화-->
							</a>
						</li>
						<li class="step_02">
							<input type="hidden" value="3"/>
							<a href="#!" >
								<img src="../images/2020/sub/step_02_off.png" alt="난"><!--난-->
							</a>
						</li>
						<li class="step_03">
							<input type="hidden" value="2"/>
							<a href="#!" >
								<img src="../images/2020/sub/step_03_off.png" alt="관엽"><!--관엽-->
							</a>
						</li>
					</ul>
				</div>
			</div>
		</div>
		
		<div class="sub_guide">
			<div class="col_wrap">
				<div class="cola">
					<h2 class="title_02">거래량</h2>
					<div class="graph_box" style="height:500px;">
						<!-- 그래프(S) -->
						<div class="auction_graph_b" id="chartHolder" style="height:500px;"></div>
						<!-- 그래프(E) -->
					</div>
					<div class="info_box" >
						<table id="jqGrid" class="boxList"></table>
					</div>
				</div>
				<div class="colb">
					<h2 class="title_02">평균단가</h2>
					<div class="graph_box">
						<!-- 그래프(S) -->
						<div class="auction_graph_b" id="chartHolder2" style="height:500px;"></div>
						<!-- 그래프(E) -->
					</div>
					<div class="info_box" >
						<table id="jqGrid2" class="boxList"></table>
					</div>
				</div>
			</div>
		</div>

		<div class="guide">
			<h2 class="title_02">이용안내</h2>
			<ul class="guide_box">
				<li>· 금주(월)의 인기품목을 비교 분석 할수 있는 화면  </li>
				<li>· 품종별 종합경매정보 및 등급정보 목록을 선택하시면 해당하는 정보를 볼 수 있습니다.</li>
				<li>· 단위 : 속수량(속), 단가(원) / 자료출처 : 각 공판장별 경매 자료 현황</li>
			</ul>
		</div>

		<!--컨텐츠 내용(E)-->
		
		<jsp:include page="../inc/2020/IncFooter.jsp"/>
		
	</div>
	<!--WRAP(E)-->
</body>
<script type="text/javascript">
$(window).load(function(){
	// 초기1회로딩
	selectPopular();
});
</script>
</html>