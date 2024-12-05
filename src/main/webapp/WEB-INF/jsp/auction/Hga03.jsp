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
	<meta name="description" content="식물검역정보">
	<meta name="content" content="화훼유통정보시스템 입니다.">
	<meta name="keywords" content="화훼경매시세, 화훼경매가격, Korea aT flower market auction price, 화훼공판장, 화훼거래정보, 꽃시장, 꽃값">
	<meta name="Author" content="화훼유통정보시스템 & www.woorim.co.kr : Kim Juyeon">
	<title>식물 검역정보</title>
	
	<%@include file="../common/2020/commonJs.jsp" %>	
	<%@include file="../common/2020/commonCss.jsp" %>
	
	<script type="text/javascript">
		$(window).on('resize.jqGrid', function () {
		    $("#jqGrid").jqGrid( 'setGridWidth', $(".plants_graph_b > div").width());
		    $("#jqGrid2").jqGrid( 'setGridWidth', $(".plants_list_b > div").width());
		    $(".ui-jqgrid-bdiv").width($(".ui-jqgrid-bdiv").width()+1);
		});
	
		var yyyymm = null;
		var itemCd = null;
		
		$(document).ready(function(){
			$("#excelBtn1").empty();
			$("#excelBtn1").append('<a href="javascript:void(0);" id="exportBtn1" name="exportTable1" onclick="excelExport();"><img src="../images/2020/exel.png" alt="엑셀이미지">엑셀저장</a>');
			
			$("#yyyymm").bindDate({align:"right", valign:"bottom", separator:"-", selectType:"m",  defaultSelectType:"m", value:"",
				onchange : function() {
					
					search();
				}});
			
			getSearchDate();
			
			$('#itemCd').select2();
			
			getTrendAnalysisList();
		});
		
		// 엑셀 다운로드
		function excelExport(){
			var excelNm = "식물 검역정보";
			yyyymm = $("#yyyymm").val();
			itemCd = $("#itemCd").val();
			var param = "?excelNm="+excelNm+"&yyyymm="+yyyymm+"&itemCd="+itemCd;
			location.href = "/excel/excelDownLoad.do"+param;
		}
		
		function search(){	
			
		    $("#jqGrid").setGridParam({
		   	 datatype	: "json",
		   	 postData	: {
			   		yyyymm : $("#yyyymm").val(), 
					itemCd : $("#itemCd").val()
				},
				page : 1
		    }).trigger("reloadGrid");
		    
		    $("#jqGrid2").setGridParam({
		      	 datatype	: "json",
		      	 postData	: {
		      		yyyymm : $("#yyyymm").val(), 
					itemCd : $("#itemCd").val()
		   		},
				page : 1
		       }).trigger("reloadGrid");
		}
		
		// Max 날짜 가져오기
		function getSearchDate(){
			$.ajax({
				type : "post",
				url : "/hga03/selectGetDate.json",
				data : {},
				dataType : '',
				success : function(res){
					var saleDate = res.saleDate;
					if(saleDate !=null && saleDate.length > 0){
						$("#yyyymm").val(saleDate.substring(0,4)+'-'+saleDate.substring(4,6));
						getItem(saleDate);
					}else{
						$('#yyyymm').val("");
					}
				}
			});
		}
		
		// 품목 List
		function getItem(yyyymm){
			var itemCdTemp = $("#itemCd option:selected").val();
			
			$.ajax({
				type : "post",
				url : "/hga03/selectGetItemList.json",
				data : {
					yyyymm : yyyymm
				},
				dataType : '',
				success : function(res){
					var val = res.list;
					if(val.length>0){
						$("#itemCd").html("");
						for(var i=0;i<val.length;i++){
							$("#itemCd").append("<option value='"+val[i].plntNm+"'>"+val[i].plntNm+"</option>");
						}
						
						if(itemCdTemp==undefined){
							$("#itemCd").val('국화절화');
						}else{
							$("#itemCd").val(itemCdTemp);
							
							if( $("#itemCd option:selected").val()==undefined){
								$("#itemCd").val('국화절화');
							}
						}
						search();
					}else{
						$("#itemCd").html("");
						alert('해당일자에 데이터가 없습니다.');
					}
				}
			});
		}
		
		// 조회 버튼
		function getTrendAnalysisList(){
			$("#jqGrid").jqGrid({
		   		url : "/hga03/selectPlntList1.json",
	   			mtype: 'POST',
	      		postData: 
	    	   	{
	      			yyyymm : $("#yyyymm").val(), 
	    			itemCd : $("#itemCd").val()
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
	           		{ label: '식물', name: 'plntNm',width: 150, editable: false , align:"center",hidden:true},
	              	{ label: '국가', name: 'natNm', width: 150, editable: false, align:"center" },
	               	{ label: '단위', name: 'qumNm', width: 50, editable: false, align:"center"},
	               	{ label: '수량', name: 'insCnt', width: 100, editable: false, align:"center", sorttype: 'float', formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' } ,hidden:true},
	               	{ label: '수출량', name: 'insQty', width: 100, editable: false, align:"center", sorttype: 'float', formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' } }
	           	] ,
	           	loadonce: true,
	   		   	rownumbers : true,
	   		 	rownumWidth : '50',
	           	autowidth:true,
	           	height: '290',
	           	rowNum: 15,
	 		   	sortable: true,
	 		   	emptyrecords : '데이터가 없습니다.',
	           	pager: "#jqGridPager",
	      	   	loadComplete	: function(data) {
	          	},
	   			onSelectRow: function(rowid, status, e) {
	        	}
	       	});
	       	$('#jqGrid').navGrid('#jqGridPager',
				// the buttons to appear on the toolbar of the grid
				{ edit: false, add: false, del: false, search: false, refresh: true, view: false, position: "left", cloneToTop: false },
				{
					errorTextFormat: function (data) {
						return 'Error: ' + data.responseText
					}
				},
				{ multipleSearch: true } // search options - define multiple search
			);
	       	$("#jqGrid").jqGrid("setLabel", "rn", "No.");
	  		
	  		$("#jqGrid2").jqGrid({
	   			url : "/hga03/selectPlntList2.json",
	      		mtype: 'POST',
	      		postData:
	      		{
	      			yyyymm : $("#yyyymm").val(), 
	    			itemCd : $("#itemCd").val()
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
	           		{ label: '식물', name: 'plntNm',width: 150, editable: false , align:"center",hidden:true },
	           		{ label: '국가', name: 'natNm', width: 150, editable: false, align:"center" },
	               	{ label: '수송구분', name: 'matNm', width: 100, editable: false, align:"center"},
	               	{ label: '단위', name: 'qumNm', width: 50, editable: false, align:"center"},
	               	{ label: '수입수량', name: 'insCnt', width: 100, editable: false, align:"center", sorttype: 'float', formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' },hidden:true },
	               	{ label: '수입량', name: 'insQty', width: 100, editable: false, align:"center", sorttype: 'float', formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' } },
	               	{ label: '소독수량', name: 'antCnt', width: 100, editable: false, align:"center", sorttype: 'float', formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' },hidden:true },
	               	{ label: '소독량', name: 'antQty', width: 100, editable: false, align:"center", sorttype: 'float', formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' } },
	               	{ label: '폐기수량', name: 'wasCnt', width: 100, editable: false, align:"center", sorttype: 'float', formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' },hidden:true },
	               	{ label: '폐기량', name: 'wasQty', width: 100, editable: false, align:"center", sorttype: 'float', formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' } }
	           	] ,
	           	loadonce: true,
	   		   	rownumbers : true,
	   		 	rownumWidth : '50',
	           	autowidth:true,
	           	height: '290',
	           	rowNum: 15,
	 		   	sortable: true,
	 		   	emptyrecords : '데이터가 없습니다.',
	           	pager: "#jqGridPager2",
	      	   	loadComplete	: function(data) {
				},
				onSelectRow: function(rowid, status, e) {
	        	}
	       	});
			$('#jqGrid2').navGrid('#jqGridPager2',
				// the buttons to appear on the toolbar of the grid
				{ edit: false, add: false, del: false, search: false, refresh: true, view: false, position: "left", cloneToTop: false },
				{
					errorTextFormat: function (data) {
						return 'Error: ' + data.responseText
					}
				},
	   			{ multipleSearch: true } // search options - define multiple search
			);
			$("#jqGrid2").jqGrid("setLabel", "rn", "No.");
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
		
		<jsp:include page="../inc/2020/IncHeader.jsp"/>
		
		<div class="lnb_box">
			<ul>
				<li><img src="../images/2020/m_lnb_img.png" alt="집"></li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li>공공데이터</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li>타 기관 정보</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li class="m_right">식물 검역정보</li>
			</ul>
		</div>
		<!--공통 HEADER(E)-->
		
		<!--서브 타이틀(S)-->
		<jsp:include page="../inc/2020/IncShare.jsp"/>
		
		<div class="sub_title">
			<div class="title_box">
				<h2>식물 검역정보</h2>
				<img src="../images/2020/sub/t_line.png" alt="방울점선">
			</div>
		</div>
		<!--서브 타이틀(E)-->
		<!--서브공통 (S)-->
		<div class="sub_contents">
	
			<!--서브 TAB공통 (S)-->
			<div class="search_box">
				<div class="search_01">
					<ul class="search_box01">
						<li class="calendar">
							<p class="search_01_txt">날짜선택</p>
							<input type="text" class="datepicker" id="yyyymm" name="yyyymm" value="날짜선택">
							<!-- <input type="text"  value="YYYY-MM-DD" alt="켈린더" class="datepicker" > -->
						</li>
						<li>
							<p class="search_01_txt">품목선택</p>
							<select class="form-control" style="width: 150px;" id="itemCd" name="itemCd"></select>
						</li>
						<li class="search_btn">
							<a href="javascript:search();"><img src="../images/2020/sub/search_img.png" alt="돋보기">검색</a>
						</li>
					</ul>
				</div>
			</div>
			<!--서브 TAB공통 (E)-->
		</div>
		<!--컨텐츠 내용(S)-->
		<div class="sub_guide">
			<div class="plants_box_b">
				<div class="plants_graph_b">
					<h2 class="title_02">수출현황</h2>
					<div class="export_graph01_b">
						<table id="jqGrid" style="width:100%; height:100%" class="boxList"></table>
						<div id="jqGridPager"></div>
					</div>
				</div>
				<div class="plants_list_b">
					<h2 class="title_02">수입현황</h2>
					<div class="export_list01_b">
						<table id="jqGrid2" style="width:100%; height:100%" class="boxList"></table>
						<div id="jqGridPager2"></div>
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
					<li>· 출처 : 농림축산검역본부</li>
				</ul>
			</div>
		</div>
		<!--컨텐츠 내용(E)-->
		
		<jsp:include page="../inc/2020/IncFooter.jsp"/>
		
	</div>
	<!--WRAP(E)-->
</body>
</html>