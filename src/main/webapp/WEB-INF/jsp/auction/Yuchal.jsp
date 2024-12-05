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
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, user-scalable=no">
	<meta name="apple-mobile-web-app-title" content="화훼유통정보시스템">
	<meta name="robots" content="no-index,follow">
	<meta name="og:title" content="화훼유통정보시스템">
	<meta name="og:description" content="화훼유통정보. 일자별 유찰현황.">
	<meta name="description" content="화훼유통정보시스템">
	<meta name="content" content="화훼유통정보시스템 입니다.">
	<meta name="keywords" content="화훼경매시세, 화훼경매가격, Korea aT flower market auction price, 화훼공판장, 화훼거래정보, 꽃시장, 꽃값">
	<meta name="Author" content="화훼유통정보시스템 & www.woorim.co.kr">
	<title>일자별 유찰정보</title>
	
	<%@include file="../common/2020/commonJs.jsp" %>
	<%@include file="../common/2020/commonCss.jsp" %>
	
	<script type="text/javascript">
	var flowerCd = null;
	var cmpCd = null;
	var pumName = null;
	var goodName = null;
	var searchSaleDate = null;
	var searchEndDate = null;
	var gridData = null;
	var gridData1 = null;
	//초기 로딩시 animate 비활성화
	var initFlag=false;
	
	$(window).on('resize.jqGrid', function () {
		$("#jqGrid").jqGrid( 'setGridWidth', $(".sub_info_box > div").width());
		$(".ui-jqgrid-bdiv").width($(".ui-jqgrid-bdiv").width()+1);
	});
	
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
			minDate: '-6d',
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
				// 품목조회
				
				var searchStrDate = $("#searchStrDate").val().replace(/-/gi, "");
				var searchEndDate = $("#searchEndDate").val().replace(/-/gi, "");
				
				var searchSaleDate = selectedDate.replace(/-/gi, "");
				
				if(searchStrDate!=''&& searchEndDate!=''){
					getYuchalPumList(flowerCd, searchStrDate, searchEndDate);
					fnObj.setPage(flowerCd);
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
			minDate: '-6d',
			dateFormat: 'yy-mm-dd',
			beforeShowDay:datechktoday,
			yearSuffix: '년',
			changeMonth: true,
	        changeYear: true,
			onSelect: function(selectedDate){  
				dateChkend();
	       		flowerCd = $("#flowerTab .on > input").attr("value");
				cmpCd = $("#cmpCdTab .on > input").attr("value");
				init();
				
				// 품목조회
				var searchStrDate = $("#searchStrDate").val().replace(/-/gi, "");
				var searchEndDate = $("#searchEndDate").val().replace(/-/gi, "");
				
				var searchSaleDate = selectedDate.replace(/-/gi, "");
				
				if(searchStrDate!=''&& searchEndDate!=''){
					getYuchalPumList(flowerCd, searchStrDate, searchEndDate);
					fnObj.setPage(flowerCd);
				}
			}
		});
		
		// 초기1회로딩
		fnObj.setPage(flowerCd);
		
		$("#excelBtn1").empty();
		
		// 키보드 입력
		$('#searchStrDate').keyup(function(key, event){
			auto_date_format(key.keyCode, this)
	         
			if(key.keyCode == 13){//키가 13이면 실행 (엔터는 13)
				dateCompStr();		
	        }
		});
		$('#searchEndDate').keyup(function(key, event){
			auto_date_format(key.keyCode, this)
	         
			if(key.keyCode == 13){//키가 13이면 실행 (엔터는 13)
				dateCompEnd();		
	        }
		});
	});
	
	function auto_date_format( keyCode , oThis ){        
		var num_arr = [ 
	   	      97, 98, 99, 100, 101, 102, 103, 104, 105, 96,
	   	      48, 49, 50, 51, 52, 53, 54, 55, 56, 57
	   	  ];
	   	  
	   	  if( num_arr.indexOf( Number( keyCode ) ) != -1 ){
	   	  
	   	      var len = oThis.value.length;
	   	      if( len == 4 ) oThis.value += "-";
	   	      if( len == 7 ) oThis.value += "-";
	   	  }
	}
	
	function dateCompStr(){
		var returnVal=false;
		var oriDt =$("#searchStrDate").val();
		var dt= new Date();
		dt.setDate(dt.getDate()-6);
		
		yyyy= dt.getFullYear();
		m=dt.getMonth()+1;
		d=dt.getDate();
		
		if(m =="0"){
			m="12"; yyyy=yyyy-1;
		}
		if(m<10){
			m='0'+m;
		}
		if(d<10){
			d='0'+d;
		}
		begindate=yyyy+'-'+m+'-'+d;
		if(oriDt>=begindate){
			returnVal=true;
			dateChkstr();
			flowerCd = $("#flowerTab .on > input").attr("value");
			cmpCd = $("#cmpCdTab .on > input").attr("value");
			init();
			// 품목조회
			
			var searchStrDate = $("#searchStrDate").val().replace(/-/gi, "");
			var searchEndDate = $("#searchEndDate").val().replace(/-/gi, "");
			
			if(searchStrDate!=''&& searchEndDate!=''){
				getYuchalPumList(flowerCd, searchStrDate, searchEndDate);
				fnObj.setPage(flowerCd);
			}
		}else{
			alert('일주일전 기간만 선택가능합니다');
			$("#searchStrDate").val(begindate);
			
			dateChkstr();
			flowerCd = $("#flowerTab .on > input").attr("value");
			cmpCd = $("#cmpCdTab .on > input").attr("value");
			init();
			// 품목조회
			
			var searchStrDate = $("#searchStrDate").val().replace(/-/gi, "");
			var searchEndDate = $("#searchEndDate").val().replace(/-/gi, "");
			
			if(searchStrDate!=''&& searchEndDate!=''){
				getYuchalPumList(flowerCd, searchStrDate, searchEndDate);
				fnObj.setPage(flowerCd);
			}
		}
		return returnVal;
	}
	
	function dateCompEnd(){
		var returnVal=false;
		var oriDt =$("#searchEndDate").val();
		var dt= new Date();
		dt.setDate(dt.getDate()-6);
		
		yyyy= dt.getFullYear();
		m=dt.getMonth()+1;
		d=dt.getDate();
		
		if(m =="0"){
			m="12"; yyyy=yyyy-1;
		}
		if(m<10){
			m='0'+m;
		}
		if(d<10){
			d='0'+d;
		}
		begindate=yyyy+'-'+m+'-'+d;
		if(oriDt>=begindate){
			returnVal=true;
			dateChkend();
	   		flowerCd = $("#flowerTab .on > input").attr("value");
			cmpCd = $("#cmpCdTab .on > input").attr("value");
			init();
			
			// 품목조회
			var searchStrDate = $("#searchStrDate").val().replace(/-/gi, "");
			var searchEndDate = $("#searchEndDate").val().replace(/-/gi, "");
			
			if(searchStrDate!=''&& searchEndDate!=''){
				getYuchalPumList(flowerCd, searchStrDate, searchEndDate);
				fnObj.setPage(flowerCd);
			}
		}else{
			alert('일주일전 기간만 선택가능합니다');
			$("#searchEndDate").val(begindate);
			
			dateChkend();
	   		flowerCd = $("#flowerTab .on > input").attr("value");
			cmpCd = $("#cmpCdTab .on > input").attr("value");
			init();
			
			// 품목조회
			var searchStrDate = $("#searchStrDate").val().replace(/-/gi, "");
			var searchEndDate = $("#searchEndDate").val().replace(/-/gi, "");
			
			if(searchStrDate!=''&& searchEndDate!=''){
				getYuchalPumList(flowerCd, searchStrDate, searchEndDate);
				fnObj.setPage(flowerCd);
			}
		}
		return returnVal;
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
	
	
	//엑셀 다운로드
	function excelExport(){
		var excelNm = "일자별유찰정보";
		searchStrDate = $("#searchStrDate").val();
		searchEndDate = $("#searchEndDate").val();
		cmpCd = $("#searchCmpCd").val();
		flowerCd = $("#mobFlowerCd").val();
		var flowerGubn="N";
		if(flowerCd==1){
			flowerGubn="N";
		}else if(flowerCd==3){
			flowerGubn="Y";
		}else if(flowerCd==2){
			flowerGubn="C";
		}else{
			flowerGubn="G";
		}
		var itemCd = $("#itemCd option:selected").val();
		var itemCd2 = $("#itemCd2 option:selected").val();
		var param = "?excelNm="+excelNm+"&searchStrDate="+searchStrDate+"&searchEndDate="+searchEndDate+"&cmpCd="+cmpCd+"&flowerCd="+flowerGubn+"&itemCd="+itemCd;
		location.href = "/excel/excelDownLoad.do"+param;
	}
	
	function search(){
		var itemCd = $('#itemCd option:selected').val();
		var searchStrDate = $("#searchStrDate").val().replace(/-/gi, "");
		var searchEndDate = $("#searchEndDate").val().replace(/-/gi, "");
	    var flowerCd = $("#flowerTab .on > input").attr("value");
	    var flowerGubn="N";
	    
	 // 검색 시 쿠키저장
		$.cookie("cookie.flowerCd", flowerCd, {path: "/"});
		$.cookie("cookie.pumCd", itemCd, {path: "/"});
		
		if(flowerCd==1){
			flowerGubn="N";
		}else if(flowerCd==3){
			flowerGubn="Y";
		}else if(flowerCd==2){
			flowerGubn="C";
		}else{
			flowerGubn="G";
		}
	    $("#jqGrid").setGridParam({
	   	 datatype	: "json",
	   	 postData	: {
				flowerCd : flowerGubn,
				itemCd : itemCd,
				//itemCd2 : itemCd2,
				searchStrDate : searchStrDate,
				searchEndDate : searchEndDate
				},
				page : 1
	    }).trigger("reloadGrid");
	}
	
	//일자 호출 , 품목호출
	// 1번
	function getSaledate(flowerCd){
		var flowerGubn="N";
		
		if(flowerCd==1){
			flowerGubn="N";
		}else if(flowerCd==3){
			flowerGubn="Y";
		}else if(flowerCd==2){
			flowerGubn="C";
		}else{
			flowerGubn="G";
		}
		$.ajax({
			type : "post",
			url : "/search/selectSaleDateYuchal.json",
			data : {
				searchProductGubun : flowerGubn
			},
			dataType : '',
			success : function(res){
				var val = res.list;
				if(res.list!=null && res.list.length > 0){
					// 초기화
					init();
					
					$('#searchStrDate').val(val[0].SALE_DATE);
					$('#searchEndDate').val(val[0].SALE_DATE);
					
					/* var begins=val[0].SALE_DATE;
					
				    var begindate=month_sample(begins,12);
					$("#searchStrDate").datepicker("change",{ minDate: begindate }); */
					
					
					// 품목조회
					//fnObj.setPage(flowerCd);
					getYuchalPumList(flowerCd, $('#searchStrDate').val(), $('#searchEndDate').val() );
				}else{
					// 데이터 없음
					$('#searchStrDate').val("");
					$('#searchEndDate').val("");
					init();
				}
			}
		});
	}
	
	function init(){	
		// 값 초기화
		getItemInit();
		
		// 그리드초기화
		$("#jqGrid").jqGrid("clearGridData", true);
	}
	
	var fnObj = {
	        setPage : function(flowerCd){
	        	var itemCd = $('#itemCd option:selected').val();
	        	var itemCd2 = $('#itemCd2 option:selected').val();
	        	var searchStrDate = $("#searchStrDate").val().replace(/-/gi, "");
	        	var searchEndDate = $("#searchEndDate").val().replace(/-/gi, "");
	            var flowerCd = $("#flowerTab .on > input").attr("value");
	        	
	            var flowerGubn="N";
	        	
	        	if(flowerCd==1){
	        		flowerGubn="N";
	        	}else if(flowerCd==3){
	        		flowerGubn="Y";
	        	}else if(flowerCd==2){
	        		flowerGubn="C";
	        	}else{
	        		flowerGubn="G";
	        	}
	            
	        	 $("#jqGrid").jqGrid({
	        		url : "/yuchal/yuchalData.json",
	           		mtype: 'POST',
	           		postData: 
	         	   {
	        			flowerCd : flowerGubn,
	        			searchStrDate : searchStrDate,
	        			searchEndDate : searchEndDate,
	        			itemCd:itemCd
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
	                    { label: '품목', name: 'MOK_NAME',width: 150, editable: false , align:"center"},
	                    { label: '총출하량', name: 'TOT_CNT', width: 100, editable: false, align:"center", sorttype: 'float',  formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' }  },
	                    { label: '총유찰량', name: 'YUCHAL_CNT', width: 100, editable: false, align:"center", sorttype: 'float', formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' } },
	                    { label: '유찰률(%)', name: 'YUCHAL_PER', width: 100, editable: false, align:"center", sorttype: 'float', formatter:'integer', editable: false }        
	                ] ,
	                loadonce: true,
	        		rownumbers : true,
	                autowidth:true,
	                height: '414',
	                rowNum: 10,
	        		sortable: true,
	        		emptyrecords : '데이터가 없습니다.',
	                pager: "#jqGridPager",
	                loadComplete	: function(data) {
	                	// 포지션 이동
	                	/* if(initFlag&& data.page==null){
	                 		var scrollPosition = $("#boxContent").offset().top;
	                    	   $('html, body').animate({scrollTop : scrollPosition}, 1000);	
	                 	} */
	                	
	        			initFlag=true;
		        		$("#jqGrid").jqGrid( 'setGridWidth', $(".sub_info_box > div").width());
		        		$(".ui-jqgrid-bdiv").width($(".ui-jqgrid-bdiv").width()+1);
	             	}
	            });
	            $('#jqGrid').navGrid('#jqGridPager',
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
	    }
	};
	
	</script>
</head>
<body>	
	<!--WRAP(S)-->
	<div class="wrap">
		<form  id="myForm" name="myForm" method="post">
			<input type="hidden" id="searchProductGubun" name="searchProductGubun" value="1"/>
			<input type="hidden" id="searchCmpCd" name="searchCmpCd" value="0000000001"/>
			<input type="hidden" id="pumName" name="pumName" value=""/>
			<input type="hidden" id="goodName" name="goodName" value=""/>
		</form>
		
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
				<li class="m_right">일자별 유찰정보</li>
			</ul>
		</div>
		<!--공통 HEADER(E)-->
		
		<!--sub 헤더 (E)-->
		<!--서브 타이틀(S)-->
		
		<jsp:include page="../inc/2020/IncShare.jsp"/>
		
		<div class="sub_title">
			<div class="title_box">
				<h2>일자별 유찰정보</h2>
				<img src="../images/2020/sub/t_line.png" alt="방울점선">
			</div>
		</div>
		<!--서브 타이틀(E)-->
		
		<jsp:include page="../inc/2020/topFlowerAtMenu.jsp"/>
		
		<!--컨텐츠 내용(S)-->
		<div class="sub_guide">
			
			<div class="sub_info_box" id="boxContent">
				<h2 class="title_02">일자별 유찰정보</h2>
				<div class="info_box" >
					<table id="jqGrid" class="boxList"></table>
					<div id="jqGridPager" style="height:35px;"></div>
				</div>
			</div>	
			
		</div>
		<div class="guide">
				<h2 class="title_02">이용안내</h2>
				<ul class="guide_box">
					<li>· aT 화훼공판장 유찰자료만 표시됩니다.</li>
				</ul>
			</div>
		<!--컨텐츠 내용(E)-->
		
		<jsp:include page="../inc/2020/IncFooter.jsp"/>
		
	</div>
	<!--WRAP(E)-->
</body>
</html>