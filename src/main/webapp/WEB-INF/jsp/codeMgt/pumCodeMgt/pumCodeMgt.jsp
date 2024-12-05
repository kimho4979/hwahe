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
<title>모니터요원 입력시스템-품종코드관리</title>
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
var searchJongNm = null;

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
	searchJongNm = $("#searchJongNm").val();
	$.ajax({
		type : 'post',
		url : "/codeMgt/selectCodeMapList.json",
		data : {
			searchJongNm : searchJongNm
		},
		dataType : '',   	           
		success : function(res){
			var val = res.list;
			myGrid.setList(val);
		}
	});
};

function updateList(rn){
	var gridData = "rn="+rn;
	fnObj.modalOpen(gridData);
}

function deleteList(rn){
	$.ajax({
		type : 'post',
		url : "/codeMgt/deleteCodeMapList.json",
		data : {
			rn : rn
		},
		dataType : '',   	           
		success : function(res){
			var val = res.list;
			grid_ajax();
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
				{key:"rn", label:"순번", width:"50", align:"center", pk:true},
				{key:"pumNm", label:"aT품목명", width:"100", align:"center"},
				{key:"jongNm", label:"aT품종명", width:"100", align:"center"},
				{key:"cmpCdMapNm", label:"공판장명", width:"100", align:"center"},
				{key:"pumNmMap", label:"공판장 품목명", width:"100", align:"center"},
				{key:"jongNmMap", label:"공판장 품종명", width:"100", align:"center"},
				{key:"regDt", label:"등록일", width:"100", align:"center"},
				{key:"update", label:"수정버튼", width:"80", align:"center", formatter:function(){
					return '<input type="button" class="AXButton" id="uBtn'+this.item.rn+'" value="수정" onclick="updateList(\''+this.item.rn+'\')"/>';
				}},
				{key:"delete", label:"삭제버튼", width:"80", align:"center", formatter: function(){
					return '<input type="button" class="AXButton" id="dBtn'+this.item.rn+'" value="삭제" onclick="deleteList(\''+this.item.rn+'\')"/>';
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
    },
    modalOpen: function(gridData){
		myModal.open({
			type: "GET",
			url:"/codeMgt/pumCodeMgt_popup.do",				
			pars:("&"+gridData).queryToObject(),
			top: 50,
			closeByEscKey:true
		});
		myModal.setWidth("100%");
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
	
		<h3 class="hw_h3_ma"><span class="half_title">품목코드 관리</span></h3>
		<div class="hw_clear"></div>	
			
		<div class="hw_infouse_01">  <p> <span class="purple"> ◎ 이용안내 :</span> aT공판장과 타공판장의 품종명을 표준화합니다.</p></div>
		
		<div style="margin-bottom:10px; margin-top:10px;">	
			<div class="selectWrap">
				품종명
				<input type="text" id="searchJongNm" name="searchJongNm" class="AXInput"/>
				<input type="button" class="AXButton" id="btn1" value="검색" onclick="grid_ajax();"/>
			</div>
		</div>
		
		<div class="hw_clear"></div>
						
		<div style="margin-top:20px; margin-bottom:10px;">
			<div class="hw_clear"></div>
			<div class="hw_ma_grid">
				<div id="AXGridTarget" style="height:400px;"></div>
		 	</div>
		</div>
		<input style="float:right;width: 32.7%;height: 40px;font-size: 16px;line-height: 38px;color: white;background-color: #00582E;text-align: center;font-weight: bold;margin-right: 1%;" type="button" value="등록하기" onclick="fnObj.modalOpen();">
 	</div>
</div><!--wrap 끝-->


</article>

<div class="hw_clear"></div>
<footer>
<%@ include file="/WEB-INF/inc/IncFooter.jsp" %>
</footer>
</body>
</html>