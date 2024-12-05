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
<title>정산 연계현황 조회</title>
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
var myGrid1 = new AXGrid();
var myModal = new AXModal();

// 정상, 비정상 List
function grid_ajax(){
	$.ajax({
		type : 'post',
		url : "/mntr/linkStatus/linkStatusCheckList.json",
		data : {},
		dataType : '',   	           
		success : function(res){
			var val = res.list;
			myGrid.setList(val);
		}
	});
};

// 상세 List
function grid_ajax1(){
	$.ajax({
		type : 'post',
		url : "/mntr/linkStatus/runManualBatchList.json",
		data : {},
		dataType : '',   	           
		success : function(res){
			var val = res.list;
			myGrid1.setList(val);
		}
	});
};

// 상세 페이지 이동
function goPage(loc){
	location.href=loc;
};

var fnObj = {
    pageStart: function(){
    	grid_ajax();
        
		myGrid.setConfig({
			targetID : "AXGridTarget",
			theme : "AXGrid",
			fixedColSeq : '',
			fitToWidth:true,
			colGroup : [
				{key:"status", label:"구분", width:"150", align:"center"},
				{key:"totalCnt", label:"총괄", width:"150", align:"center"},
				{key:"api", label:"OpenAPI", width:"150", align:"center"},
				{key:"pro", label:"Procedure", width:"150", align:"center"},
				{key:"dbl", label:"DB연계", width:"150", align:"center"},
				{key:"man", label:"수동배치", width:"150", align:"center"}
			],
			colHeadAlign:"center",

			body : {
			    onclick: function(){},
			    ondblclick: function(){},
			    oncheck: function(){}
			},
			page:{
			    paging:false
			}
		});
		
		grid_ajax1();
		
		myGrid1.setConfig({
			targetID : "AXGridTarget1",
			theme : "AXGrid",
			fixedColSeq : '',
			fitToWidth:true,
			colGroup : [
				{key:"jobId", label:"연계ID", width:"80", align:"center", pk:true},
				{key:"jobNm", label:"연계명", width:"200", align:"center"},
				{key:"jobType", label:"배치유형", width:"100", align:"center"},
				{key:"agency", label:"제공기관", width:"150", align:"center"},
				{key:"uptStat", label:"최종갱신상태", width:"100", align:"center"},
				{key:"uptDt", label:"최종갱신일", width:"100", align:"center"}
			],
			colHeadAlign:"center",

			body : {
			    onclick: function(){
			    	var loc = "/linkStatus/linkStatusCheckDetail.do?jobId="+this.item.jobId;
			    	goPage(loc);
			    },
			    ondblclick: function(){},
			    oncheck: function(){}
			},
			page:{
			    paging:false
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
	
		<h3 class="hw_h3_ma"><span class="half_title">정산 연계현황 조회</span></h3>
		<div class="hw_clear"></div>	
			
		<div class="hw_infouse_01">  <p> <span class="purple"> ◎ 이용안내 :</span> 글을 작성하시려면 등록하기를 누르셔서 작성하시면 됩니다.</p></div>
		<div class="hw_clear"></div>	
						
		<div style="margin-top:20px; margin-bottom:10px;">
			<div class="hw_clear"></div>
			<div class="hw_ma_grid">
				<div id="AXGridTarget" style="height:150px;"></div>
		 	</div>
		 	
		 	<div class="hw_clear"></div>
			<div class="hw_ma_grid" style="margin-top:20px;">
				<div id="AXGridTarget1" style="height:400px;"></div>
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