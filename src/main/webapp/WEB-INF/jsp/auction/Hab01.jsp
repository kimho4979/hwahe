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
	<title>일자별 경매정보</title>	
	<%@include file="../common/2020/commonJs.jsp" %>
	<%@include file="../common/2020/commonCss.jsp" %>
	
	<script type="text/javascript">
	
	$(window).on('resize.jqGrid', function () {
	    $("#jqGrid").jqGrid( 'setGridWidth', $(".sub_info_box > div").width());
	    $("#jqGridPager").jqGrid( 'setGridWidth', $(".sub_info_box > div").width());
	    $("#jqGrid2").jqGrid( 'setGridWidth', $(".sub_info_box > div").width());
	    $("#jqGridPager2").jqGrid( 'setGridWidth', $(".sub_info_box > div").width());
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
	//초기 로딩시 animate 비활성화
	var initFlag=false;
	var initFlagLv=false;
	//-----------------------차트 설정 시작-----------------------
	
	//rMate 차트 생성 준비가 완료된 상태 시 호출할 함수를 지정합니다.
	var chartVars = "rMateOnLoadCallFunction=chartReadyHandler";
	var chartVars2 = "rMateOnLoadCallFunction=chartReadyHandler2";
	
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
	
	
	//스트링 형식으로 레이아웃 정의.
	var layoutStr = 
		'<rMateChart backgroundColor="#ffffff" borderStyle="none">'
			+'<Options>'
			  	/* +'<Caption text="10일간 거래동향"/>' */
				+'<Legend defaultMouseOverAction="false" useVisibleCheck="true"/>'
			+'</Options>'
			+'<NumberFormatter id="numFmt" useThousandsSeparator="true"/>'
			+'<Line2DChart showDataTips="true" dataTipDisplayMode="axis" paddingTop="0">'
				+'<horizontalAxis>'
					+'<CategoryAxis categoryField="saleDate" />'
				+'</horizontalAxis>'
				+'<verticalAxis>'
					+'<LinearAxis  formatter="{numFmt}"/>'
				+'</verticalAxis>'
			+'<series>'
				+'<Line2DSeries  labelPosition="up" showMaxValueLabel="true"  minimum="0"  yField="maxAmt"  radius="3" displayName="최고가"  itemRenderer="CircleItemRenderer">'
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
				+'<Line2DSeries labelPosition="up" showMinValueLabel="true" minimum="0" showMaxValueLabel="true" yField="minAmt"  radius="3" displayName="최저가"  itemRenderer="CircleItemRenderer">'
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
				+'<Line2DSeries   yField="avgAmt"  radius="3"  minimum="0" displayName="평균가"  itemRenderer="CircleItemRenderer">'
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
	             +'<Column2DChart showDataTips="true" columnWidthRatio="0.55" selectionMode="single" displayCompleteCallFunction="displayCallFunction"  dataTipJsFunction="dataTipFunc"  >'
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
			
	//차트 데이터
	var chartData = [];
	var chartData2 = [];
	
	
	function rMateChartH5ChangeTheme(theme){
		document.getElementById("chart1").setTheme(theme);
	}
	
	function rMateChartH5ChangeTheme(theme){
		document.getElementById("chart2").setTheme(theme);
	}
	
	function checkData(data){
		if(data.length <= 0){
			// 데이터가 없을 경우 hasNoData함수를 실행하여 메세지창을 출력한다.
			document.getElementById("chart1").hasNoData(true);
		}
	}
	
	function checkData2(data){
		if(data.length <= 0){
			// 데이터가 없을 경우 hasNoData함수를 실행하여 메세지창을 출력한다.
			document.getElementById("chart2").hasNoData(true);
		}
	}
	
	function displayCallFunction(){
		/* if(chartData2.length==1){
			$('#chartHolder2 .rMateH5__Column2DChart > canvas:eq(1)').css('left','125px');
		}else if(chartData2.length==2){
			$('#chartHolder2 .rMateH5__Column2DChart > canvas:eq(1)').css('left','62.5px');
		}else if(chartData2.length==3){
			$('#chartHolder2 .rMateH5__Column2DChart > canvas:eq(1)').css('left','41px');
		}else if(chartData2.length==4){
			$('#chartHolder2 .rMateH5__Column2DChart > canvas:eq(1)').css('left','31px');
		}else if(chartData2.length==5){
			$('#chartHolder2 .rMateH5__Column2DChart > canvas:eq(1)').css('left','25px');
		} */
	}
	
	//-----------------------차트 설정 끝 -----------------------
	
	$(document).ready(function(){
		// datePicker
		
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
				cmpCd = $("#cmpCdTab .on > input").attr("value");
				init();
				var searchStrDate = $("#searchStrDate").val();
				var searchEndDate = $("#searchEndDate").val();
				var searchSaleDate = selectedDate;
				
				if(searchStrDate!=''&& searchEndDate!=''){
					getSalePumList(cmpCd, flowerCd, searchSaleDate, searchEndDate);
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
				cmpCd = $("#cmpCdTab .on > input").attr("value");
				
				init();
				
				// 품목조회
				var searchStrDate = $("#searchStrDate").val();
				var searchEndDate = $("#searchEndDate").val();
				
				var searchSaleDate = selectedDate;
				
				if(searchStrDate!=''&& searchEndDate!=''){
					getSalePumList(cmpCd, flowerCd, searchStrDate, searchSaleDate);
					fnObj.setPage(cmpCd, flowerCd);
				}
			}
		});
		 
		// 품종 selectbox display
		$("#goodSelectbox").css('display','');
		
		$("#itemCd").change(function() {
			getSaleGoodList();
		});
		
		// 초기1회로딩
		fnObj.setPage(cmpCd, flowerCd);
		
		$("#excelBtn1").empty();		
		$("#excelBtn1").append('<a href="javascript:void(0);" id="exportBtn1" name="exportTable1" onclick="excelExport();"><img src="../images/2020/exel.png" alt="엑셀이미지">엑셀저장</a>');
		
		$('#searchStrDate').keyup(function(key, event){
			auto_date_format(key.keyCode, this);
			if(key.keyCode == 13){//키가 13이면 실행 (엔터는 13)
				search();		
	        }
		});
		
		$('#searchEndDate').keyup(function(key, event){
			auto_date_format(key.keyCode, this);
			if(key.keyCode == 13){//키가 13이면 실행 (엔터는 13)
				search();		
	        }
		});
		
	});
	
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
	   if(date > new Date())
	    return [false];
	    return [true];
	    
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
		
		var dt_lastDate= new Date(dt_v.getFullYear(), dt_v.getMonth(), 0);		
		var d2=dt_lastDate.getDate(); 
				
		if(m =="0")
		{
			m="12"; yyyy=yyyy-1;
		}
		if(m<10)
		{
			m='0'+m;
		}
		
		if(d > d2)
		{
			d=d2;
		}
		if(d<10)
		{
			d='0'+d;
		}
		begindate=yyyy+'-'+m+'-'+d;
		return begindate;	
	}
	
	
	// 엑셀 다운로드
	function excelExport(){
		var excelNm = "일자별경매정보";
		searchStrDate = $("#searchStrDate").val();
		searchEndDate = $("#searchEndDate").val();
		cmpCd = $("#searchCmpCd").val();
		flowerCd = $("#mobFlowerCd").val();
		var itemCd = $("#itemCd option:selected").val();
		var itemCd2 = $("#itemCd2 option:selected").val();
		var param = "?excelNm="+excelNm+"&searchStrDate="+searchStrDate+"&searchEndDate="+searchEndDate+"&cmpCd="+cmpCd+"&flowerCd="+flowerCd+"&itemCd="+itemCd+"&itemCd2="+itemCd2;
		location.href = "/excel/excelDownLoad.do"+param;
	}
	
	function search(){
		var itemCd = $('#itemCd option:selected').val();
		var itemCd2 = $('#itemCd2 option:selected').val();
		var searchStrDate = $("#searchStrDate").val();
		var searchEndDate = $("#searchEndDate").val();
	    var flowerCd = $("#flowerTab .on > input").attr("value");
		var cmpCd = $("#cmpCdTab .on > input").attr("value");   
		
		$.cookie("cookie.cmpCd", cmpCd, {expires: 7, path: '/' });
		$.cookie("cookie.flowerCd", flowerCd, { expires: 7, path: '/' });
		$.cookie("cookie.pumCd", itemCd,{ expires: 7, path: '/' });
		$.cookie("cookie.goodCd", itemCd2, { expires: 7, path: '/' });
		
		$("#searchPumNm").val(itemCd);
		
	    $("#jqGrid").setGridParam({
	   	 datatype	: "json",
	   	 postData	: {
	   		 cmpCd : cmpCd,
				flowerCd : flowerCd,
				itemCd : itemCd,
				itemCd2 : itemCd2,
				searchStrDate : searchStrDate,
				searchEndDate : searchEndDate
				},
				page : 1
	    }).trigger("reloadGrid");
	   
	}
	
	function init(){
		// itemCd 초기화
		getItemInit();
		$("#itemCd2").html("");
		$("#itemCd2").append("<option value='' selected>전체</option>");
		
		$('#pumNameTxt').text('품종별 종합 경매정보');
		$('#lvNameTxt').text('등급정보');
		
		// grid 초기화
		$("#jqGrid").jqGrid("clearGridData", true);
		$("#jqGrid2").jqGrid("clearGridData", true);
		
	}
	
	// 항상 1번 호출
	function getSaledate(cmpCd, flowerCd){
		$.ajax({
			type : "post",
			url : "/search/selectSaleDate.json",
			data : {
				searchProductGubun : flowerCd,
				searchCmpCd : cmpCd
			},
			dataType : '',
			success : function(res){
				var val = res.list;
				if(res.list!=null && res.list.length > 0){
					// 초기화
					init();
					
					var begins=val[0].SALE_DATE;
					if('${param.searchStrDate}'!=''&&'${param.searchEndDate}'!=''){
						$('#searchStrDate').val('${param.searchStrDate}');
						$('#searchEndDate').val('${param.searchEndDate}');
						history.replaceState({}, null, location.pathname);
					}else{
						$('#searchStrDate').val(val[0].SALE_DATE);
						$('#searchEndDate').val(val[0].SALE_DATE);
					}
					
					//console.log(val[0].SALE_DATE);
					
				    var begindate=month_sample(begins,12);
					$("#searchStrDate").datepicker("change",{ minDate: begindate });
					
					// 품목조회
					getSalePumList(cmpCd, flowerCd, $('#searchStrDate').val(), $('#searchEndDate').val());
					// HIDDEN
					//fnObj.setPage(cmpCd, flowerCd);
				}else{
					// 데이터 없음
					$('#searchStrDate').val("");
					$('#searchEndDate').val("");
					
					init();
					
					// 그래프 초기화
					chartData = [];
					if(!document.getElementById("chart1")){
				    	rMateChartH5.create("chart1", "chartHolder", chartVars, "100%", "99%"); 
					 } else{
						 chartReadyHandler("chart1");
					} 
					
					chartData2= [];
					if(!document.getElementById("chart2")){
				    	rMateChartH5.create("chart2", "chartHolder2", chartVars2, "100%", "99%"); 
					 } else{
						 chartReadyHandler("chart2");
					} 
				}
			}
		});
	}
	
	var fnObj = {
	        setPage : function(cmpCd, flowerCd){        	
	        	var itemCd = $('#itemCd option:selected').val();
	        	var itemCd2 = $('#itemCd2 option:selected').val();
	        	var searchStrDate = $("#searchStrDate").val();
	        	var searchEndDate = $("#searchEndDate").val();
	            var flowerCd = $("#flowerTab .on > input").attr("value");
	        	var cmpCd = $("#cmpCdTab .on > input").attr("value");
	        	
	        	$("#jqGrid").jqGrid({
	        		url : "/hab01/selectHab01Json.json",
	           		mtype: 'POST',
	           		postData: 
	         	   {
	           			cmpCd : cmpCd,
	        			flowerCd : flowerCd,
	        			itemCd : itemCd,
	        			itemCd2 : itemCd2,
	        			searchStrDate : searchStrDate,
	        			searchEndDate: searchEndDate
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
	                    { label: '품목', name: 'PUM_NAME',width: 120, editable: false , align:"center"},
	                    { label: '품종', name: 'GOOD_NAME', width: 140, editable: false, align:"center" },
	                    { label: '속수량', name: 'TOT_QTY', width: 100, editable: false, align:"center", sorttype: 'float', formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' } },
	                    { label: '최저단가', name: 'MIN_AMT', width: 120, editable: false, align:"center", sorttype: 'float', formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' } },
	                    { label: '최고단가', name: 'MAX_AMT', width: 120, editable: false, align:"center", sorttype: 'float', formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' } },
	                    { label: '평균단가', name: 'AVG_AMT', width: 120, editable: false, align:"center", sorttype: 'float', formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' } },
	                    { label: '법인코드', name: 'CMP_CD', hidden:true},
	                    { label: '부류', name: 'FLOWER_GUBN', hidden:true }
	                ] ,
	                loadonce: true,
	        		rownumbers : true,
	                autowidth:true,
	                height: '228',
	                rowNum: 15,
	        		sortable: true,
	        		emptyrecords : '데이터가 없습니다.',
	                pager: "#jqGridPager",
	           	 	loadComplete	: function(data) {
	           	 		// 페이지 이동 시
		           	 	var ids = jQuery("#jqGrid").jqGrid('getDataIDs');
		   	 			var idx=1;
		   	 			if(ids != null && ids.length>0){
		   	 				idx=ids[0];
		   	 			}
		   	 			
			   	 		var searchStrDate = $("#searchStrDate").val();
			        	var searchEndDate = $("#searchEndDate").val();
		   	 			
			   	 		$("#jqGrid").jqGrid("setSelection", idx);
			   	 		// 데이터 가져옴
		   	 			var rowData = $('#jqGrid').jqGrid('getRowData', idx);
		   	 			
	           	 		if(data.list!=null&&data.list.length>0){
	           	 			fnObj.setPage2(rowData.PUM_NAME, rowData.GOOD_NAME, rowData.CMP_CD, rowData.FLOWER_GUBN, searchStrDate, searchEndDate);
	           	 		}else{
	           	 			// 그리드초기화
	           	 			$("#jqGrid2").jqGrid("clearGridData", true);
	           	 		}
	           	 		
	             	}, onSelectRow: function(rowid, status, e) {
	             		var itemCd = $("#searchPumNm").val();
	             		
	             		if(itemCd==''){
	             			$('#pumNameTxt').text('품종별 종합 경매정보');
	             			$('#jqGrid').showCol('PUM_NAME');
	             		}else{
	             			$('#pumNameTxt').text('품종별 종합 경매정보('+itemCd+')');
	             			$('#jqGrid').hideCol('PUM_NAME');
	             		}
	             		$("#jqGrid").jqGrid( 'setGridWidth', $(".sub_info_box > div").width());
	             		$("#jqGridPager").jqGrid( 'setGridWidth', $(".sub_info_box > div").width());
	             	    $("#gview_jqGrid>.ui-jqgrid-bdiv").width($("#gview_jqGrid>.ui-jqgrid-bdiv").width()+1);
	             		
	             		// 포지션 이동
	             		/* if(e==undefined){
	             			if(initFlag){
	                     		var scrollPosition = $("#boxContent").offset().top;
	                        	 $('html, body').animate({scrollTop : scrollPosition}, 1000);
	                     	}    
	             		}else{
	             			var scrollPosition = $("#boxContentLv").offset().top;
	                 	    $('html, body').animate({scrollTop : scrollPosition}, 1000);
	             		} */
	                 	
	             	    var rowData = $(this).getLocalRow(rowid);
	             	    
	             	   	var searchStrDate = $("#searchStrDate").val();
			        	var searchEndDate = $("#searchEndDate").val();
			        	
	             	   $("#jqGrid2").setGridParam({
	           		   	 datatype	: "json",
	           		   	 postData	: {
		           		   	cmpCd : rowData.CMP_CD,
		        			flowerCd : rowData.FLOWER_GUBN,
		        			itemCd : rowData.PUM_NAME,
		        			itemCd2 :  rowData.GOOD_NAME,
	             			searchStrDate : searchStrDate,
	             			searchEndDate : searchEndDate
	      					},
	      					page : 1
	           		    }).trigger("reloadGrid");
	           		    initFlag=true;
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
	        		{ multipleSearch: true} // search options - define multiple search
	       		);
	            $("#jqGrid").jqGrid("setLabel", "rn", "No.");
	       		//search();
	    },
	    setPage2 : function(pumName, goodName, cmpCd, flowerCd, searchStrDate, searchEndDate){
	    			$("#jqGrid2").jqGrid({
	    	    		url : "/hab01/selectHab01LvJson.json",
	    	       		mtype: 'POST',
	    	       		postData: 
	    	     	   {
	    	       			cmpCd : cmpCd,
		        			flowerCd :flowerCd,
		        			itemCd : pumName,
		        			itemCd2 :  goodName,
	    	    			searchStrDate : searchStrDate,
	    	    			searchEndDate: searchEndDate
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
	    	                { label: '등급', name: 'LV_NAME',width: '100', editable: false , align:"center", sortable:true},
	    	                { label: '등급상세', name: 'LV_ETC_NM',width: '150', editable: false , align:"center", sortable:true},
	    	                { label: '속수량', name: 'TOT_QTY', width: '80', editable: false, align:"center", sorttype: 'float', formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' } },
	    	                { label: '최저단가', name: 'MIN_AMT', width: '100', editable: false, align:"center", sorttype: 'float', formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' } },
	    	                { label: '최고단가', name: 'MAX_AMT', width: '100', editable: false, align:"center", sorttype: 'float', formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' } },
	    	                { label: '평균단가', name: 'AVG_AMT', width: '100', editable: false, align:"center", sorttype: 'float', formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' } },
	    	                { label: '등급코드', name: 'LV_CD', hidden:true},
	    	                { label: '품목', name: 'PUM_NAME', hidden:true},
	    	                { label: '품종', name: 'GOOD_NAME', hidden:true},
	    	                { label: '법인코드', name: 'CMP_CD', hidden:true},
	    	                { label: '검색일자', name: 'SALE_DATE', hidden:true },
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
	    	   	 			}
	    	   	 			$("#jqGrid2").jqGrid("setSelection", idx);
	    		   	    	
	    	         	}, onSelectRow: function(rowid) {
	    	         		var rowData = $(this).getLocalRow(rowid);
	    	         		var searchStrDate = $("#searchStrDate").val();
	    	         		var searchEndDate = $("#searchEndDate").val();
	    	            	$.ajax({
	    	            		type : "post",
	    	            		url : "/hab01/selectHab01LvCntJson.json",
	    	            		data : {
	    	    	    			itemCd : rowData.PUM_NAME,
	    	            			itemCd2 : rowData.GOOD_NAME,
	    	            			cmpCd : rowData.CMP_CD,
	    	            			flowerCd : rowData.FLOWER_GUBN,
	    	            			searchStrDate :searchStrDate,
	    	            			searchEndDate :searchEndDate
	    	            		},
	    	            		dataType : '',
	    	            		success : function(res){    
	    	            			
	    	            			var lvCnt = res.lvCnt;
			    	      	 		$("#lvCd").val(rowData.LV_CD);	
			    	      	 		
			    	      	 		// 공판장 별로 조회
			    	      	 		$('#jqGrid2').showCol('LV_ETC_NM');
			    		   	    	var etcLvTitle='등급상세';
			    		   	    	var hideLvCd=false;
			    		   	    	
			    		   	    	if(rowData.CMP_CD=='0000000001'){
			    		   	    		if(lvCnt!='0'&&rowData.FLOWER_GUBN=='3'){
			    		   	    			etcLvTitle='가지(송이)';
			    		   	    		}else if(lvCnt!='0'&&rowData.FLOWER_GUBN=='1'){
			    		   	    			etcLvTitle='송이';
			    		   	    		}else{
			    		   	    			$('#jqGrid2').hideCol('LV_ETC_NM');
			    		   	    			hideLvCd=true;
			    		   	    		}
			    		   	    	}else if(rowData.CMP_CD=='1288202296'){
			    		   	    		$('#jqGrid2').hideCol('LV_ETC_NM');
			    		   	    		hideLvCd=true;
			    		   	    	}
			    	      	 		$("#jqGrid2").jqGrid( 'setGridWidth', $(".sub_info_box > div").width());
			    	      	 		$("#jqGridPager2").jqGrid( 'setGridWidth', $(".sub_info_box > div").width());
			    	      	 		$("#gview_jqGrid2>.ui-jqgrid-bdiv").width($("#gview_jqGrid2>.ui-jqgrid-bdiv").width()+1);
			    	      	 		
			    		   	    	$("#jqGrid2").jqGrid("setLabel", 'LV_ETC_NM', etcLvTitle);
	
			    		   	    	var itemCd = $('#itemCd option:selected').val();
			    		   	    	
		                 			$('#lvNameTxt').text('등급정보('+rowData.PUM_NAME+'-'+rowData.GOOD_NAME+')');
			                 		
			    		   			var lvCd = rowData.LV_CD;
			    		   			if(hideLvCd){
			    		   				fnObj.geungme(rowData.PUM_NAME, rowData.GOOD_NAME, rowData.CMP_CD, rowData.FLOWER_GUBN, rowData.LV_CD, '');
				    		           	fnObj.chart_sumary(rowData.PUM_NAME, rowData.GOOD_NAME, rowData.CMP_CD, rowData.FLOWER_GUBN, rowData.LV_CD, '');
			    		   			}else{
			    		   				fnObj.geungme(rowData.PUM_NAME, rowData.GOOD_NAME, rowData.CMP_CD, rowData.FLOWER_GUBN, rowData.LV_CD, rowData.LV_ETC_NM.replace('~', '-'));
				    		           	fnObj.chart_sumary(rowData.PUM_NAME, rowData.GOOD_NAME, rowData.CMP_CD, rowData.FLOWER_GUBN, rowData.LV_CD, rowData.LV_ETC_NM.replace('~', '-'));	
			    		   			}
			    		   			
			    	          	}
		 	                });
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
	    	    		{ multipleSearch: true} // search options - define multiple search
	    	   		);
	    	        $("#jqGrid2").jqGrid("setLabel", "rn", "No.");
	    	
	    },
	    geungme : function(pumName, goodName, cmpCd, flowerCd, lvCd, lvEtcNm){
	    	var searchStrDate = $("#searchStrDate").val();
	    	var searchEndDate = $("#searchEndDate").val();
	    	
	    	$.ajax({
	    		type : "post",
	    		url : "/hab01/selectHab01InfoJson.json",
	    		data : {
	    			itemCd : pumName,
	    			itemCd2 : goodName,
	    			cmpCd : cmpCd,
	    			flowerCd : flowerCd,
	    			searchStrDate : searchStrDate,
	    			searchEndDate : searchEndDate,
	    			lvCd : lvCd,
	    			lvEtcNm:lvEtcNm
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
	    	var searchStrDate = $("#searchStrDate").val();
	    	var searchEndDate = $("#searchEndDate").val();
	    	
	    	$.ajax({
				type : "post",
				url : "/hab01/selectHab01ChartJson.json",
				data : {
					itemCd : pumName,
					itemCd2 : goodName,
					cmpCd : cmpCd,
					flowerCd : flowerCd,
					searchStrDate : searchStrDate,
					searchSaleDate : searchEndDate,
	    			lvCd : lvCd,
	    			lvEtcNm:lvEtcNm
				},
				dataType : '',
				success : function(res){
					var val = res.list;
					console.log(val);
					if(val.length > 0){
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
	    }
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
				<li>경매실적</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li class="m_right">일자별 경매정보</li>
			</ul>
		</div>
		<!--sub 헤더 (E)-->
		<!--서브 타이틀(S)-->
		
		<jsp:include page="../inc/2020/IncShare.jsp"/>
		
		<div class="sub_title">
			<div class="title_box">
				<h2>일자별 경매정보</h2>
				<img src="../images/2020/sub/t_line.png" alt="방울점선">
			</div>
		</div>
		<!--서브 타이틀(E)-->
				
		<jsp:include page="../inc/2020/topMenuRange.jsp"/>
		
		<!--컨텐츠 내용(S)-->
		<div class="sub_guide">
			<div class="data_content_b">
				<div class="cont_left_b">
					<div class="cont_box_b">
						<div class="sub_info_box" id="boxContent">
							<h2 class="title_02">품종별 종합 경매정보</h2>
							<div class="info_box" >
								<table id="jqGrid" class="boxList"></table>
								<div id="jqGridPager" style="height:35px;"></div>
							</div>
						</div>	
					</div>
				</div>
				<div class="cont_right_b" >
					<div class="cont_box_b">
						<div class="sub_info_box" id="boxContentLv">
							<h2 class="title_02" id="lvNameTxt">등급정보</h2>
							<div class="info_box" >
								<table id="jqGrid2" class="boxList"></table>
								<div id="jqGridPager2" style="height:35px;"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="data_content_b">
				<div class="cont_left_b">
					<h2 class="title_02">10일간 거래동향</h2>
					<div class="cont_box_b">
						<div id="chartHolder" style="width:100%; height:480px;"></div>	
					</div>
				</div>
				<div class="cont_right_b">
					<h2 class="title_02">거래금액분포도</h2>
					<div class="cont_box_b">
						<div id="chartHolder2" style="width:100%; height:480px;"></div>	
					</div>
				</div>
			</div>
			<div class="dwn_bt_b" id="excelBtn1">
				<a href="#!"><img src="../images/2020/exel.png" alt="엑셀이미지">엑셀저장</a>
			</div>
		</div>
		<div class="guide">
			<h2 class="title_02">이용안내</h2>
			<ul class="guide_box">
				<li>· 경매정보를 일자별로 비교 분석 할수 있는 화면  </li>
				<li>· 품종별 종합경매정보 및 등급정보 목록을 선택하시면 해당하는 정보를 볼 수 있습니다.</li>
				<li>· 단위 : 속수량(속), 단가(원) / 자료출처 : 각 공판장별 경매 자료 현황</li>
				<li>· 공판장별 단순집계 자료이므로 참고자료로만 활용하시기 바랍니다.</li>
			</ul>
		</div>

		<!--컨텐츠 내용(E)-->
		
		<jsp:include page="../inc/2020/IncFooter.jsp"/>
		
	</div>
	<!--WRAP(E)-->
</body>
</html>