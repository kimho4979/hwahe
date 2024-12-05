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
	<meta name="description" content="월간 화훼 수출입 현황">
	<meta name="content" content="화훼유통정보시스템 입니다.">
	<meta name="keywords" content="화훼경매시세, 화훼경매가격, Korea aT flower market auction price, 화훼공판장, 화훼거래정보, 꽃시장, 꽃값">
	<meta name="Author" content="화훼유통정보시스템 & www.woorim.co.kr">
	<title>월간 화훼 수출입 현황</title>
	<%@include file="../common/2020/commonJs.jsp" %>
	<%@include file="../common/2020/commonCss.jsp" %>
	<script type="text/javascript">
		var searchStrDate = "";
		var searchEndDate = "";
		var hsCode = "";
		var natCode = "";
		var gubn = "I";
		
		$(window).on('resize.jqGrid', function () {
			$("#jqGrid").jqGrid( 'setGridWidth', $(".sub_info_box > div").width());
		    $("#jqGridPager").jqGrid( 'setGridWidth', $(".sub_info_box > div").width());
		    $(".ui-jqgrid-bdiv").width($(".ui-jqgrid-bdiv").width()+1);
		});
		
		$(document).ready(function(){
			$('#progress_loading').hide();
			$('#itemCd').select2();
			$('#itemCd2').select2();
			
			$("input[name='rr99']").change(function(){
				if($(":input:radio[name=rr99]:checked").val() == "I"){
					gubn = "I"
				}else{
					gubn = "E"
				}
				searchPumList();
				searchNatList();
			});
			//달력 월별설정
			$("#searchStrDateM").bindDate({align:"right", valign:"bottom", separator:"-", selectType:"m",  defaultSelectType:"m", value:"",
		       	onchange:function(){
					searchStrDate = $("#searchStrDateM").val();
					searchEndDate = $("#searchEndDateM").val();
				},
			});
		
			$("#searchEndDateM").bindDate({align:"right", valign:"bottom", separator:"-", selectType:"m",  defaultSelectType:"m", value:"",
		       	onchange:function(){
					searchStrDate = $("#searchStrDateM").val();
					searchEndDate = $("#searchEndDateM").val();
				},
			});
			
			$("#excelBtn1").empty();
			$("#excelBtn1").append('<a href="javascript:void(0);" id="exportBtn1" name="exportTable1" onclick="excelExport();"><img src="../images/2020/exel.png" alt="엑셀이미지">엑셀저장</a>');
			
			searchPumList();
			searchNatList();
			fnObj.setPage();
		});
		
		var fnObj = {
			setPage : function(){
				searchStrDate = $('#searchStrDateM').val().replace('-','');
				searchEndDate = $('#searchEndDateM').val().replace('-','');
				hsCode = $('#itemCd').val();
				natCode = $('#itemCd2').val();
				gubn = $(":input:radio[name=rr99]:checked").val();
				
				$("#jqGrid").jqGrid("GridUnload");
				$("#jqGrid").jqGrid({
	        		url : '/kati/selectImportList.json',
	           		mtype: 'POST',
	           		postData: {
	           			searchStrDate : searchStrDate,
	           			searchEndDate : searchEndDate,
	           			hsCode : hsCode,
	           			natCode : natCode,
	           			gubn : gubn},
	           		datatype: "json",
	                jsonReader: {   
	        	   		root : "list",  // list 이름
	        	   		page : "page",
	        	   		total : "total",
	        	   		records : "records",
	        			repeatitems : false
	                },
	                colModel: [
						{ label: '국가', name: 'NATCD',width: 250, editable: false , align:"center", sorttype:'string'},
						{ label: '품목', name: 'NAME', width: 300, editable: false, align:"center" },
						{ label: '금액(달러)', name: 'TOT_AMT', width: 230, editable: false, align:"right", sorttype: 'float', formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' }},
						{ label: '물량(kg)', name: 'TOT_WGT', width: 230, editable: false, align:"right", sorttype: 'float',  formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' }  },
						{ label: '날짜', name: 'BASIS_YYMM', width: 210, editable: false, align:"right" },
						{ label: '단', name: 'DAN', hidden:true}
					],
					loadonce: true,
	        		rownumbers : true,
	                autowidth:true,
	                //shrinkToFit:false,
	                viewsortcols: [true,'vertical',true],
	                height: '616',
	                rowNum: 15,
	        		sortable: true,
	        		emptyrecords : '데이터가 없습니다.',
	        		pager: "#jqGridPager",
	        		loadComplete	: function(data) {
	        			var rowData = $('#jqGrid').jqGrid('getRowData', 1);
	        			var rowData1 = $('#jqGrid').jqGrid('getRowData');
	        			var rowIds = $('#jqGrid').jqGrid('getDataIDs');
	        			
	        			$.each(rowData1, function(idx,rowdata){
		        			if(rowdata.DAN == '1'){
		        				$("#jqGrid").setRowData(rowIds[idx],false,{background:"#D9E5D9"});
		        			}
	        			});
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
		}
	}
	
	function calendarShow(id){
		var pickId = "#inputBasic_AX_"+id+"_AX_dateHandle";
		$(pickId).click();
		$('#'+id).attr("readonly",true);
		setTimeout(function(){$('#'+id).attr("readonly",false);}, 50);
	}
		
	function search(){
		searchStrDate = $('#searchStrDateM').val().replace('-','');
		searchEndDate = $('#searchEndDateM').val().replace('-','');
		hsCode = $('#itemCd').val();
		natCode = $('#itemCd2').val();
		gubn = $(":input:radio[name=rr99]:checked").val();
		
		$("#jqGrid").setGridParam({
			datatype	: "json",
			postData: {
       			searchStrDate : searchStrDate,
       			searchEndDate : searchEndDate,
       			hsCode : hsCode,
       			natCode : natCode,
       			gubn : gubn},
       		page :1
		}).trigger("reloadGrid");
	}
	
	function searchPumList(){
		
		
		$.ajax({
			type : 'post',
			url : '/search/selectImportPumList.json',
			data : {
				gubn : gubn,
				searchStrDate : searchStrDate,
				searchEndDate : searchEndDate
			},
			dataType : '',
			success : function(res) {
				if(res.list.length>0){
					$("#itemCd").html("");
					$("#itemCd").append("<option value='' selected>전체</option>");
					
					for(var i=0;i<res.list.length;i++){
						$("#itemCd").append("<option value='"+res.list[i].HSCD+"'>"+res.list[i].NAME+"</option>");
					}
				}
			}
		});
	}
	
	function searchNatList(){
		
		$.ajax({
			type : 'post',
			url : '/search/selectImportNatList.json',
			data : {
				gubn : gubn,
				searchStrDate : searchStrDate,
				searchEndDate : searchEndDate
			},
			dataType : '',
			success : function(res) {
				if(res.list.length>0){
					$("#itemCd2").html("");
					$("#itemCd2").append("<option value='' selected>전체</option>");
					
					for(var i=0;i<res.list.length;i++){
						$("#itemCd2").append("<option value='"+res.list[i].NAT_CD+"'>"+res.list[i].NAT_NM+"</option>");
					}
				}
			}
		});
	}
	
	function excelExport(){
		var excelNm = "월간화훼수출입";
		hsCode = $('#itemCd').val();
		natCode = $('#itemCd2').val();
		var param = "?excelNm=" + excelNm + "&gubn="+gubn+"&natCode="+natCode+"&hsCode="+hsCode+ "&searchStrDate="+searchStrDate+"&searchEndDate="+searchEndDate
		location.href = "/excel/excelDownLoad.do" + param;
		
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
				<li>공공데이터</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li>타 기관 정보</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li class="m_right">월간 화훼 수출입현황</li>
			</ul>
		</div>
		<!--sub 헤더 (E)-->
		<!--서브 타이틀(S)-->
		
		<jsp:include page="../inc/2020/IncShare.jsp"/>
		
		<div class="sub_title">
			<div class="title_box">
				<h2 class="sub_tit">월간 화훼 수출입현황</h2>
				<p>월간 화훼 수출입현황을 확인 할 수 있습니다.</p>
				<img src="../images/2020/sub/t_line.png" alt="방울점선">
			</div>
		</div>
		
		<!--서브 타이틀(E)-->
		<!--서브공통 (S)-->
		<div class="sub_contents">
			<div class="search_box_new statistic">
				<input type="hidden" id="searchStrDate" value="">
				<input type="hidden" id="searchEndDate" value="">
				
				<div class="s-line">
					<h4 class="sbn_tit_01">구분</h4>
					<ul class="grow_check_box">
						<li>
							<input type="radio" id="rr66" name="rr99" value="I" checked>
							<label for="rr66" class="title_box_chk"><em class="txt">수입</em><span></span></label>
						</li>
						<li>
							<input type="radio" id="rr77" name="rr99" value="E">
							<label for="rr77" class="title_box_chk"><em class="txt">수출</em><span></span></label>
						</li>
					</ul>
				</div>
				
				
				<div class="s-line">
					<h4 class="sbn_tit_01">기간</h4>

					<div class="sb_common_01 pack-01">
						<div class="date-from-to" id="searchDateD">
							<div class="calendar_new">
								<input type="text" alt="켈린더" id="searchStrDateM" class="calendar_focus" value="${searchStrDateM}" onClick="calendarShow(this.id);">
							</div>
							<span class="hyphen">~</span>
							<div class="calendar_new">
								<input type="text" alt="켈린더" id="searchEndDateM" class="calendar_focus" value="${searchEndDateM}" onClick="calendarShow(this.id);">
							</div>
						</div>
					</div>
				</div>
		
							
				<div class="s-line">
					<h4 class="sbn_tit_01">품목조회[HS코드]</h4>
					<div class="sb_common_01">
						<select class="form-control" id="itemCd" name="itemCd">
						</select>
					</div>
				</div>	
				<div class="s-line">
					<h4 class="sbn_tit_01">상대국가</h4>
					<div class="sb_common_01">
						<select class="form-control" id="itemCd2" name="itemCd2">
						</select>
						<div class="search_btn">
							<a href="javascript:search()"><img src="../images/2020/sub/search_img.png" alt="돋보기">검색</a>
						</div>
					</div>
					
				</div>	

								
				<!-- 로딩바(S) -->
				<div id="progress_loading" style="display: none;">
					<img src="../../images/loadingBar.gif">
				</div>
				<!-- 로딩바(E) -->
				
			</div>
		</div>
		<!--컨텐츠 내용(S)-->
		
		
				
		<!--컨텐츠 내용(S)-->
		<div class="sub_guide">
			<div class="tit_box_01">
				<div class="fl">
					<h2 class="title_02">수출입정보</h2>	
				</div>
					
				<div class="fr">
					<div class="icon-box tr">
						<span class="guide-icon width-scroll"></span>
					</div>
					<div class="dwn_bt_b" id="excelBtn1"><a href="javascript:void(0);" id="exportBtn1" name="exportTable1" onclick="excelExport();"><img src="../images/2020/exel.png" alt="엑셀이미지">엑셀저장</a></div><br>
					<!--  <span class="txt-unit">(단위 : 단/원)</span>  -->
				</div>
			</div>
			
			<div class="info_box">
			    <table id="jqGrid" class="boxList"></table>
			    <div id="jqGridPager"></div>
			</div>
		</div>
		<!--컨텐츠 내용(E)-->	
		
		<div class="guide">
			<h2 class="title_02">이용안내</h2>
			<ul class="guide_box">
				<li>· 출처 : KATI</li>
			</ul>
		</div>

		<jsp:include page="../inc/2020/IncFooter.jsp"/>
	</div>
	<!--WRAP(E)-->
</body>