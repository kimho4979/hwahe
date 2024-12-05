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
	<meta name="description" content="일자별 경매정보">
	<meta name="content" content="화훼유통정보시스템 입니다.">
	<meta name="keywords" content="화훼경매시세, 화훼경매가격, Korea aT flower market auction price, 화훼공판장, 화훼거래정보, 꽃시장, 꽃값">
	<meta name="Author" content="화훼유통정보시스템 & www.woorim.co.kr">
	<title>일자별 품종 경매정보</title>	
	<%@include file="../common/2020/commonJs.jsp" %>
	<%@include file="../common/2020/commonCss.jsp" %>
	
	<script type="text/javascript">
	$(window).on('resize.jqGrid', function () {
		$("#jqGrid").jqGrid( 'setGridWidth', $(".sub_info_box > div").width());
		$("#jqGridPager").jqGrid( 'setGridWidth', $(".sub_info_box > div").width());
		$(".ui-jqgrid-bdiv").width($(".ui-jqgrid-bdiv").width()+1);
	});
	
	var flowerCd = null;
	var cmpCd = null;
	var pumName = null;
	var goodName = null;
	var searchStrDate = null;
	var searchEndDate = null;
	var gridData = null;
	var gridData1 = null;
	var itemCd = null;
	//초기 로딩시 animate 비활성화
	var initFlag=false;
	var initFlagLv=false;
	//월별, 일별 구분
	var chkMonth = false;
	//품종, 품목 구분
	var chkKind = true;

	$(document).ready(function(){
		$("#searchStrDate").datepicker({
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
			onSelect: function(selectedDate){
				dateChkstr();
				flowerCd = $("#flowerTab .on > input").attr("value");
				cmpCd = $("#mobCmpCd option:selected").val();
				init();
				
				var searchStrDate = $("#searchStrDate").val();
				var searchEndDate = $("#searchEndDate").val();
				var searchSaleDate = selectedDate;
				
				if(searchStrDate!=''&& searchEndDate!=''){
					fnObj.setPage(cmpCd, flowerCd);
				}
			}
		});
		
		$("#searchEndDate").datepicker({
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
			onSelect: function(selectedDate){	
				var begins=$("#searchEndDate").val();
			
				var begindate=month_sample(begins,12);		
			 
				$("#searchStrDate").datepicker("change",{minDate: begindate });
			
				dateChkend();
				flowerCd = $("#flowerTab .on > input").attr("value");
				cmpCd = $("#mobCmpCd option:selected").val();
				init();
				
				// 품종조회
				var searchStrDate = $("#searchStrDate").val();
				var searchEndDate = $("#searchEndDate").val();
				var searchSaleDate = selectedDate;
				
				if(searchStrDate!=''&& searchEndDate!=''){
					fnObj.setPage(cmpCd, flowerCd);
				}
			}
		});
		
		$("#excelBtn1").empty();		
		$("#excelBtn1").append('<a href="javascript:void(0);" id="exportBtn1" name="exportTable1" onclick="excelExport();"><img src="../images/2020/exel.png" alt="엑셀이미지">엑셀저장</a>');
		
		$("#goodSelectbox").css('display', '');
	});
	
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
	
	
	// 엑셀 다운로드
	function excelExport(){
		var excelNm = "일자별품종경매정보";
		var cmpCd = $("#mobCmpCd option:selected").attr("value");   
		var flowerCd = $("#flowerTab .on > input").attr("value");
		var itemCd = $('#itemCd option:selected').val();
		var itemCd2 = $('#itemCd2 option:selected').val();
		var searchStrDate = $("#searchStrDate").val();
		var searchEndDate = $("#searchEndDate").val();
		var param = "?excelNm="+excelNm+"&searchStrDate="+searchStrDate+"&searchEndDate="+searchEndDate+"&cmpCd="+cmpCd+"&flowerCd="+flowerCd+"&itemCd="+itemCd+"&itemCd2="+itemCd2;
		location.href = "/excel/excelDownLoad.do"+param;
	}
	
	function search(){
		cmpCd = $("#mobCmpCd option:selected").attr("value");   
		flowerCd = $("#flowerTab .on > input").attr("value");
		itemCd = $('#itemCd option:selected').val();
		itemCd2 = $('#itemCd2 option:selected').val();
		searchStrDate = $("#searchStrDate").val();
		searchEndDate = $("#searchEndDate").val();
		
		$("#jqGrid").setGridParam({
				datatype	: "json"
			,	postData	: {
					cmpCd : cmpCd
				,	flowerCd : flowerCd
				,	itemCd : itemCd
				,	itemCd2 : itemCd2
				,	searchStrDate : searchStrDate
				,	searchEndDate : searchEndDate
				}
			,	page : 1
		}).trigger("reloadGrid");
	}
	
	// 항상 1번 호출
	function getSaledate(cmpCd, flowerCd){
		cmpCd = $("#mobCmpCd").val();
		flowerCd = $("#flowerTab .on > input").attr("value");

		$.ajax({
			type : "post",
			url : "/search/selectSaleDate.json",
			data : {
					searchProductGubun : flowerCd
				,	searchCmpCd : cmpCd
			},
			dataType : '',
			success : function(res){
				var val = res.list;
				if(res.list!=null && res.list.length > 0){
					// 초기화
					var begins=val[0].SALE_DATE;
					if('${param.searchStrDate}'!=''&&'${param.searchEndDate}'!=''){
						$('#searchStrDate').val('${param.searchStrDate}');
						$('#searchEndDate').val('${param.searchEndDate}');
						history.replaceState({}, null, location.pathname);
					}else{
						$('#searchStrDate').val(val[0].SALE_DATE);
						$('#searchEndDate').val(val[0].SALE_DATE);
					}
					
					var begindate=month_sample(begins,12);
					$("#searchStrDate").datepicker("change",{ minDate: begindate });
					
					// HIDDEN
					fnObj.setPage(cmpCd, flowerCd);
					init();
				}else{
					// 데이터 없음
					$('#searchStrDate').val("");
					$('#searchEndDate').val("");
				}
			}
		});
	}
	
	var fnObj = {
			setPage : function(cmpCd, flowerCd){
				var itemCd = $('#itemCd').val();
	//			var itemCd2 = $('#itemCd2 option:selected').val();
				var searchStrDate = $("#searchStrDate").val();
				var searchEndDate = $("#searchEndDate").val();
				var flowerCd = $("#flowerTab .on > input").attr("value");
				var cmpCd = $("#mobCmpCd option:selected").attr("value");

				$("#jqGrid").jqGrid({
					url : "/kind/selectKindDaily.json"
				,	mtype : "post"
				,	postData:{
							cmpCd : cmpCd
						,	flowerCd : flowerCd
						,	searchStrDate : searchStrDate
						,	searchEndDate: searchEndDate
						,	itemCd : itemCd
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
							{ label: '공판장', name: 'MARKET_NAME', width: 120, editable: false , align:"center"}
						,	{ label: '품목명', name: 'ITEM_NM', width: 120, editable: false , align:"center"}
						,	{ label: '품종명', name: 'KIND_NM', width: 120, editable: false , align:"center"}
						,	{ label: '거래량', name: 'TOT_QTY', width: 100, editable: false, align:"center", sorttype: 'float', formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' } }
						,	{ label: '최고단가', name: 'MAX_AMT', width: 120, editable: false, align:"center", sorttype: 'float', formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' } }
						,	{ label: '최저단가', name: 'MIN_AMT', width: 120, editable: false, align:"center", sorttype: 'float', formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' } }
						,	{ label: '평균단가', name: 'AVG_AMT', width: 120, editable: false, align:"center", sorttype: 'float', formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' } }
						,	{ label: '공판장코드', name: 'MARKET_CD', hidden:true}
						,	{ label: '품종코드', name: 'ITEM_CD', hidden:true}
					]
				,	loadonce : true
				,	sortable: true
				,	rownumbers : false
				,	loadonce: true
				,	autowidth:true
				,	height: '500'
				,	rowNum: 12
				,	emptyrecords : '데이터가 없습니다.'
				,	pager: "#jqGridPager"
				,	loadComplete	: function(data) {
						// 페이지 이동 시
						var ids = jQuery("#jqGrid").jqGrid('getDataIDs');
						var idx=1;
						if(ids != null && ids.length>0){
							idx=ids[0];
						}

						var rowData = $('#jqGrid').jqGrid('getRowData', idx);
//						$('#jqGrid').hideCol('subgrid');
						
						$("#jqGrid").jqGrid( 'setGridWidth', $(".sub_info_box > div").width());
						$(".ui-jqgrid-bdiv").width($(".ui-jqgrid-bdiv").width()+1);
						$('.ui-jqgrid .ui-jqgrid-bdiv').css('overflow-x', 'hidden');
					}
				,	subGrid: true
				,	subGridRowExpanded: function(subgrid_id, row_id) {
						var subgrid_table_id = subgrid_id+"_t"
						,	pager_id = "p_"+subgrid_table_id
						,	localRowData = $(this).jqGrid("getLocalRow", row_id);
						
						$("#"+ subgrid_id).html("<table id='"+subgrid_table_id+"'></table><div id='"+pager_id+"'></div>");
						
						$("#"+ subgrid_table_id).jqGrid({
							url : "/kind/selectKindDailyDate.json"
						,	mtype : "post"
						,	postData:{
									cmpCd : localRowData['MARKET_CD']
								,	flowerCd : $("#flowerTab .on > input").attr("value")
								,	searchStrDate : $("#searchStrDate").val()
								,	searchEndDate: $("#searchEndDate").val()
								,	itemCd : localRowData['ITEM_CD']
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
								{ label: '거래일', name: 'SALE_DATE', width: 120, editable: false , align:"center"}
							,	{ label: '거래량', name: 'TOT_QTY', width: 100, editable: false, align:"center", sorttype: 'float', formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' } }
							,	{ label: '최고단가', name: 'MAX_AMT', width: 120, editable: false, align:"center", sorttype: 'float', formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' } }
							,	{ label: '최저단가', name: 'MIN_AMT', width: 120, editable: false, align:"center", sorttype: 'float', formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' } }
							,	{ label: '평균단가', name: 'AVG_AMT', width: 120, editable: false, align:"center", sorttype: 'float', formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' } }
							,	{ label: '공판장코드', name: 'MARKET_CD', hidden:true}
							,	{ label: '품종코드', name: 'ITEM_CD', hidden:true}
							]
						,	loadonce : true
						,	sortable: true
						,	rownumbers : false
						,	idPrefix: "s_" + row_id + "_"
			            ,	autowidth: true
			            ,	gridview: true
			            ,	autoencode: true
			            ,	height: "auto"
			            ,	loadComplete	: function(data) {
//								$('#jqGrid_'+ row_id +'_t').hideCol('subgrid');
								
								$('#'+subgrid_table_id).jqGrid( 'setGridWidth', $(".sub_info_box > div").width()-8);
								$('.ui-jqgrid .ui-jqgrid-bdiv').css('overflow-x', 'hidden');
							}
			            ,	subGrid: true
			            ,	subGridRowExpanded: function(subgrid_id2, row_id2) {
								var subgrid_table_id2 = subgrid_id2 +"_t"
								,	pager_id2 = "p_"+subgrid_table_id2
								,	localRowData2 = $(this).jqGrid("getRowData", row_id2);
							$("#"+subgrid_id2).html("<table id='"+subgrid_table_id2+"'></table><div id='"+pager_id2+"'></div>");
							
							$("#"+subgrid_table_id2).jqGrid({
								url : "/kind/selectKindDailyDateLevel.json"
							,	mtype : "post"
							,	postData:{
										cmpCd : localRowData2['MARKET_CD']
									,	flowerCd : $("#flowerTab .on > input").attr("value")
									,	searchStrDate : localRowData2['SALE_DATE']
									,	searchEndDate: localRowData2['SALE_DATE']
									,	itemCd : localRowData2['ITEM_CD']
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
									{ label: '등급', name: 'LEVEL_NAME', width: 120, editable: false , align:"center"}
								,	{ label: '서브등급', name: 'LV_ETC_NM', width: 120, editable: false , align:"center"}
								,	{ label: '거래량', name: 'TOT_QTY', width: 100, editable: false, align:"center", sorttype: 'float', formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' } }
								,	{ label: '최고단가', name: 'MAX_AMT', width: 120, editable: false, align:"center", sorttype: 'float', formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' } }
								,	{ label: '최저단가', name: 'MIN_AMT', width: 120, editable: false, align:"center", sorttype: 'float', formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' } }
								,	{ label: '평균단가', name: 'AVG_AMT', width: 120, editable: false, align:"center", sorttype: 'float', formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' } }
								]
							,	loadonce : true
							,	sortable: true
							,	rownumbers : false
							,	idPrefix: "s_" + row_id2 + "_"
				            ,	autowidth: true
				            ,	gridview: true
				            ,	autoencode: true
				            ,	height: "auto"
			            	,	loadComplete	: function(data) {
				            	
								$('#'+subgrid_table_id2).jqGrid( 'setGridWidth', $(".sub_info_box > div").width()-4);
							}
				        	});
				   		}
			            , onSelectRow: function(rowid, status, e) {
			                var rowIds = $('#jqGrid_'+ row_id + '_t').getDataIDs();
			                $.each(rowIds, function (index, rowId) {
			                    if (rowid != rowId) {
			                    	$('#jqGrid_'+ row_id + '_t').collapseSubGridRow(rowId);
			                    }
			                });
			                
			            	$('#jqGrid_'+ row_id + '_t').jqGrid('toggleSubGridRow', rowid);
			            	$('.subgrid-cell').remove();
						}
			        	});
		   		}
				, onSelectRow: function(rowid, status, e) {
	                var rowIds = $('#jqGrid').getDataIDs();
	                $.each(rowIds, function (index, rowId) {
	                    if (rowid != rowId) {
	                    	$('#jqGrid').collapseSubGridRow(rowId);
	                    }
	                });
	                
					$('#jqGrid').jqGrid('toggleSubGridRow', rowid);
					$('.subgrid-cell').remove();
				}
				});
				$('#jqGrid').navGrid('#jqGridPager2',
					// the buttons to appear on the toolbar of the grid
					{ edit: false, add: false, del: false, search: false, refresh: true, view: false, position: "left", cloneToTop: false },
					{
						errorTextFormat: function (data) {
							return 'Error: ' + data.responseText
						}
					},
					{ multipleSearch: true} // search options - define multiple search
				);
		}
	}
</script>

</head>
<body>
	<input type="hidden" id="searchProductGubun" name="searchProductGubun" value="1"/>
	<input type="hidden" id="searchCmpCd" name="searchCmpCd" value=""/>
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
				<li class="m_right">일자별 품종 경매정보</li>
			</ul>
		</div>
		<!--sub 헤더 (E)-->
		<!--서브 타이틀(S)-->
		
		<jsp:include page="../inc/2020/IncShare.jsp"/>
		
		<div class="sub_title">
			<div class="title_box">
				<h2>일자별 품종 경매정보</h2>
				<img src="../images/2020/sub/t_line.png" alt="방울점선">
			</div>
		</div>
		<!--서브 타이틀(E) 여기서 품종, 공판장선택해서 데이터 불러올수 있도록 한다.-->
		<jsp:include page="../inc/2020/topMenuRangeAuctionNew.jsp"/>
		
		<!--컨텐츠 내용(S)-->
		<div class="sub_guide">
			<div class="sub_info_box" id="boxContent">
				<h2 class="title_02">일자별 품종 경매정보</h2>
				<div class="info_box" >
					<table id="jqGrid" class="boxList"></table>
					<div id="jqGridPager" style="height:35px;"></div>
				</div>
			</div>
		</div>
		<div class="guide">
			<h2 class="title_02">이용안내</h2>
			<ul class="guide_box">
				<li>· 경매정보를 일자별로 비교 분석 할수 있는 화면  </li>
				<li>· 품종별 종합경매정보 및 등급정보 목록을 선택하시면 해당하는 정보를 볼 수 있습니다.</li>
				<li>· 단위 : 속수량(속), 단가(원) / 자료출처 : 각 공판장별 경매 자료 현황</li>
				<li>· 이 자료는 공판장 별로 실제 품목, 품종명과 차이가 있을 수 있으며, 증빙자료로 사용할 수 없습니다.</li>
			</ul>
		</div>

		<!--컨텐츠 내용(E)-->
		
		<jsp:include page="../inc/2020/IncFooter.jsp"/>
		
	</div>
	<!--WRAP(E)-->
</body>
<script type="text/javascript">
$(window).load(function(){
	
	getSaledate();
});
</script>
</html>