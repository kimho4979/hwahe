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
<title>모니터요원 입력시스템-공공데이터 신청조회</title>
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
var rn = null;
var useYn = null;
var searchUseYn = null;

//공공데이터 OpenAPI명 List :: 공통
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
	searchUseYn = $("#searchUseYn option:selected").val();
	searchNm = $("#searchNm option:selected").val();
	$.ajax({
		type : 'post',
		url : "/apiMgt/selectApiDegreeList.json",
		data : {
			useYn : searchUseYn,
			searchNm : searchNm
		},
		dataType : '',   	           
		success : function(res){
			var val = res.list;
			myGrid.setList(val);
			
			for(var i=0; i<val.length; i++){
				if(val[i].useYn == 'Y'){
					$("#useYn"+(i+1)).val("Y");
				}else{
					$("#useYn"+(i+1)).val("N");
				}
			}
		}
	});
};

function execute(rn, serviceKey){
	useYn = $("#useYn"+rn+" option:selected").val();
	
	$.ajax({
		type : 'post',
		url : "/apiMgt/updateApiDegreeList.json",
		data : {
			useYn : useYn,
			serviceKey : serviceKey
		},
		dataType : '',   	           
		success : function(res){
			alert("저장하였습니다.");
		}
	});
}

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
				{key:"rn", label:"순번", width:"80", align:"center", pk:true},
				{key:"reqDataNm", label:"OpenAPI명", width:"150", align:"center"},
				{key:"regDt", label:"신청일", width:"100", align:"center"},
				{key:"compMgr", label:"담당자 명", width:"100", align:"center"},
				{key:"compTel", label:"담당자 연락처", width:"100", align:"center"},
				{key:"ip", label:"접속IP", width:"150", align:"center"},
				{key:"useYn", label:"승인여부", width:"200", align:"center", formatter:function(){
					return '<select id="useYn'+this.item.rn+'" name="useYn'+this.item.rn+'" class="AXSelect" style="width:100%;"><option value="Y">승인</option><option value="N">미승인</option></select>';
				}},
				{key:"button", label:"승인버튼", width:"80", align:"center", formatter: function(){
					return '<input type="button" class="AXButton" id="btn'+this.item.rn+'" value="확인" onclick="execute(\''+this.item.rn+'\',\''+this.item.serviceKey+'\')"/>';
				}},
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
	
		<h3 class="hw_h3_ma"><span class="half_title">공공데이터 신청조회</span></h3>
		<div class="hw_clear"></div>	
			
		<div class="hw_infouse_01">  <p> <span class="purple"> ◎ 이용안내 :</span> 공공데이터를 신청한 회원들에게 승인/미승인 권한을 부여합니다.</p></div>
		
		<div style="margin-bottom:10px; margin-top:10px;">	
			<div class="selectWrap">
				<select id="searchUseYn" name="searchUseYn" class="AXSelect" style="width:15%;">
					<option value="">전체</option>
					<option value="Y">승인</option>
					<option value="N">미승인</option>
				</select>
				
				OpenAPI명
				<label class="blind" for="searchNm">OpenAPI명</label>
				<select id="searchNm" name="searchNm"></select>
				<input type="button" class="AXButton" id="search" name="search" value="검색" onclick="grid_ajax();"/>
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