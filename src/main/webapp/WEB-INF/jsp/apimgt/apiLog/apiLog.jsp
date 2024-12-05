<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, user-scalable=no">
<title>모니터요원 입력시스템-공공데이터 호출이력보기</title>
<!-- @@@@@@@@@@@@@@@@@@@@@@ css begin @@@@@@@@@@@@@@@@@@@@@@ -->
<link rel="stylesheet" type="text/css" href="<c:url value='/rMateChart/rMateChartH5/Assets/Css/rMateChartH5.css' />"/>   
<link rel="stylesheet" type="text/css" href="<c:url value='/axisj/axicon/axicon.min.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/arongi/AXJ.min.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/hw/ma.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/hw/common.css' />" />
<!-- @@@@@@@@@@@@@@@@@@@@@@ css end   @@@@@@@@@@@@@@@@@@@@@@ --> 

<script type="text/javascript" src="<c:url value='/axisj/jquery/jquery.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/axisj/dist/AXJ.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/ax5-polyfill.js' />"></script>
<script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/axjApp.js' />"></script>

<!-- rMateChartH5 라이센스 시작 -->
<script type="text/javascript" src="<c:url value='/rMateChart/LicenseKey/rMateChartH5License.js' />"></script>
<!-- rMateChartH5 라이센스 끝-->  
<!-- 실제적인 rMateChartH5 라이브러리 시작-->
 <script type="text/javascript" src="<c:url value='/rMateChart/rMateChartH5/JS/rMateChartH5.js' />"></script>
<!-- 실제적인 rMateChartH5 라이브러리 끝-->  
<!-- rMateChartH5 테마 js -->
<script type="text/javascript" src="<c:url value='/rMateChart/rMateChartH5/Assets/Theme/theme.js' />"></script>
<!-- @@@@@@@@@@@@@@@@@@@@@@ css end   @@@@@@@@@@@@@@@@@@@@@@ --> 

<script type="text/javascript">
var myProgress = new AXProgress();
var myGrid = new AXGrid();
var myModal = new AXModal();
var searchNm = null;
var searchDate1 = null;
var searchDate2 = null;

// 공공데이터 OpenAPI명 List :: 공통
function commonSelect(){
	$.ajax({
		type : 'post',
		url : "/apiMgt/selectApiSelectBoxList.json",
		data : {},
		dataType : '',   	           
		success : function(res){
			var val = res.list;
			
			$("#searchNm").empty();
			$("#searchNm").append("<option value=''>전체</option>");
			for(var i=0; i<val.length; i++){
				$("#searchNm").append("<option value="+val[i].reqDataCd+">"+val[i].reqDataNm+"</option>");
			}
		}
	});
};

function grid_ajax(){
	searchNm = $("#searchNm option:selected").val();
	searchDate1 = $("#searchDate1").val();
	searchDate2 = $("#searchDate2").val();
	$.ajax({
		type : 'post',
		url : "/apiMgt/selectApiLogList.json",
		data : {
			searchNm : searchNm,
			searchDate1 : searchDate1,
			searchDate2 : searchDate2
		},
		dataType : '',   	           
		success : function(res){
			var val = res.list;
			myGrid.setList(val);
		}
	});
};

var fnObj = {
    pageStart: function(){
    	commonSelect();
    	grid_ajax();
        
		myGrid.setConfig({
			targetID : "AXGridTarget",
			theme : "AXGrid",
			fixedColSeq : '',
			fitToWidth:true,
			colGroup : [
				{key:"reqDataNm", label:"OpenAPI명", width:"150", align:"center"},
				{key:"callDt", label:"호출일자", width:"100", align:"center"},
				{key:"callTime", label:"호출시간", width:"100", align:"center"},
				{key:"compMgr", label:"담당자 명", width:"100", align:"center"},
				{key:"compTel", label:"담당자 연락처", width:"150", align:"center"},
				{key:"ip", label:"접속IP", width:"200", align:"center"}
			],
			colHeadAlign:"center",

			body : {
			    onclick: function(){},
			    ondblclick: function(){},
			    oncheck: function(){}
			},
			page:{
			    paging:true
			}
		});
		
		// 검색 조건 Default Date 설정 시작
    	var date = new Date();
    	var year = date.getFullYear();
    	
        var month = date.getMonth()+1;
        month = month > 9 ? month : '0'+month;
        
        var byear = date.getFullYear();
        var bmonth = date.getMonth();
        if(bmonth==0){
        	bmonth=12;
        	byear = byear-1;
        }
        bmonth = bmonth > 9 ? bmonth : '0'+bmonth;
        
        var day = date.getDate();
        day = day > 9 ? day : '0'+day;
        
        var dt = year + "-" + month + "-" + day;
        var bdt = byear + "-" + bmonth + "-" + day;
        
        var rd1 = $('#searchDate1').val(bdt);
        var rd2 = $('#searchDate2').val(dt);
		
		$('#searchDate1').bindDate({align:"right", valign:"bottom", separator:"-", selectType:"d",  defaultSelectType:"d", defaultDate : "rd1",
			onchange:function(){
				grid_ajax();
			}
    	});
    	$('#searchDate2').bindDate({align:"right", valign:"bottom", separator:"-", selectType:"d",  defaultSelectType:"d", defaultDate : "rd2",
			onchange:function(){
				grid_ajax();
            }
        });
    }
}	 
  
$(document).ready(fnObj.pageStart);
</script>
   
</head>
<body>
<%@ include file="/WEB-INF/inc/IncHeader.jsp" %>
<article>
<div class="wrap">

	<%@ include file="/WEB-INF/jsp/inc/IncMenu.jsp" %>

	<div class="hw_content"><!--컨텐츠 내용들어가는곳 시작-->
	
		<h3 class="hw_h3_ma"><span class="half_title">공공데이터 호출이력보기</span></h3>
		<div class="hw_clear"></div>	
			
		<div class="hw_infouse_01">  <p> <span class="purple"> ◎ 이용안내 :</span> 공공데이터의 호출이력을 조회합니다.</p></div>
		
		<div style="margin-bottom:10px; margin-top:10px;">	
			<div class="selectWrap">
				기간
				<label class="blind" for="searchDate1">날짜선택하기</label>
				<input type="text" name="searchDate1" id="searchDate1" class="AXInput W100" value="" />
				-
				<label class="blind" for="searchDate2">날짜선택하기</label>
				<input type="text" name="searchDate2" id="searchDate2" class="AXInput W100" value="" />
				
				OpenAPI명
				<label class="blind" for="searchNm">OpenAPI명</label>
				<select id="searchNm" name="searchNm"></select>
				<input type="button" class="AXButton" id="searchBtn" name="searchBtn" value="검색" onclick="grid_ajax()"/>
			</div>
		</div>
		
		<div class="hw_clear"></div>
						
		<div style="margin-top:20px; margin-bottom:10px;">
			<div class="hw_clear"></div>
			<div class="hw_ma_grid">
				<div id="AXGridTarget" style="height:400px;"></div>
		 	</div>
		</div>
 	</div>
</div><!--wrap 끝-->


</article>

<div class="hw_clear"></div>
<footer>
<%@ include file="/WEB-INF/inc/IncFooter.jsp" %>
</footer>
</body>
</html>