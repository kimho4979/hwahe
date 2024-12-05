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
	<title>작황정보 입력창 </title>
<!-- @@@@@@@@@@@@@@@@@@@@@@ css begin @@@@@@@@@@@@@@@@@@@@@@ -->
<link rel="stylesheet" type="text/css" href="<c:url value='/rMateChart/rMateChartH5/Assets/Css/rMateChartH5.css' />"/>   
<link rel="stylesheet" type="text/css" href="<c:url value='/axisj/axicon/axicon.min.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/arongi/AXJ.min.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/hw/ma.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/hw/common.css' />" />
<!-- @@@@@@@@@@@@@@@@@@@@@@ css end   @@@@@@@@@@@@@@@@@@@@@@ --> 

 
<script type="text/javascript" src="<c:url value='/axisj/jquery/jquery.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/axisj/dist/AXJ.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/axisj/lib/AXUpload5.js' />"></script>
<script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/ax5-polyfill.js' />"></script>
<script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/axjApp.js' />"></script>
 
<!-- rMateChartH5 라이센스 시작 -->
<script type="text/javascript" src="<c:url value='/rMateChart/LicenseKey/rMateChartH5License.js' />"></script>
<!-- rMateChartH5 라이센스 끝-->  
<!-- 실제적인 rMateChartH5 라이브러리 시작-->
<script type="text/javascript" src="<c:url value='/rMateChart/rMateChartH5/JS/rMateChartH5.js' />"></script>
<!-- 실제적인 rMateChartH5 라이브러리 끝-->

<style type="text/css">
	.modalProgramTitle{
		height:49px;line-height:49px;
		color:#282828;font-size:14px;font-weight:bold;
		padding-left:15px;
		border-bottom:1px solid #ccc;
	}
	.modalButtonBox{
		padding:10px;border-top:1px solid #ccc;
	}
</style>  
  <!-- @@@@@@@@@@@@@@@@@@@@@@ css begin @@@@@@@@@@@@@@@@@@@@@@ -->
 <link rel="stylesheet" type="text/css" href="<c:url value='/rMateChart/rMateChartH5/Assets/Css/rMateChartH5.css' />"/>   
 <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/axicon/axicon.min.css' />" />
 <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/arongi/AXJ.min.css' />" />
 <link rel="stylesheet" type="text/css" href="<c:url value='/css/hw/ma.css' />" />
 <link rel="stylesheet" type="text/css" href="<c:url value='/css/hw/common.css' />" />

  <script type="text/javascript" src="<c:url value='/axisj/jquery/jquery.min.js' />"></script>
  <script type="text/javascript" src="<c:url value='/axisj/dist/AXJ.min.js' />"></script>
  <script type="text/javascript" src="<c:url value='/axisj/lib/AXUpload5.js' />"></script>
  <script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/ax5-polyfill.js' />"></script>
  <script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/axjApp.js' />"></script>
  
  <!-- rMateChartH5 라이센스 시작 -->
  <script type="text/javascript" src="<c:url value='/rMateChart/LicenseKey/rMateChartH5License.js' />"></script>
  <!-- rMateChartH5 라이센스 끝-->  
  <!-- 실제적인 rMateChartH5 라이브러리 시작-->
   <script type="text/javascript" src="<c:url value='/rMateChart/rMateChartH5/JS/rMateChartH5.js' />"></script>
  <!-- 실제적인 rMateChartH5 라이브러리 끝-->
   <style type="text/css">
        .modalProgramTitle{
            height:49px;line-height:49px;
            color:#282828;font-size:14px;font-weight:bold;
            padding-left:15px;
            border-bottom:1px solid #ccc;
        }
        .modalButtonBox{
            padding:10px;border-top:1px solid #ccc;
        }
    </style>  
     <script type="text/javascript">
	    var myModal = new AXModal();
		var myGrid = new AXGrid();
		// 상세 List
		function grid_ajax(){
			$.ajax({
				type : 'post',
				url : "/mntr/linkStatus/selectFailList.json",
				data : {
					logSeq :  '${param.logSeq}'
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
	        	myGrid.setConfig({
	    			targetID : "AXGridTarget1",
	    			theme : "AXGrid",
	    			fixedColSeq : '',
	    			fitToWidth:true,
	    			colGroup : [
	    				{key:"failDetail", label:"실패사유", width:"200", align:"center"},
	    				{key:"failData", label:"실패데이터", width:"250", align:"center"}
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
	        	
	        	grid_ajax();
	        }
	    };
	    
	    jQuery(document).ready(fnObj.pageStart);  
    </script>
    
</head>

<body>
  	
 

<article>
<div>


<div class="ma_content"><!--컨텐츠 내용들어가는곳 시작-->
	<div>
		<h4 class="hw_h3_ma_01" >배치실패상세</h4> 
	</div>
	
	<form id="send-form" name="send-form" onsubmit="return false;">
		
		<div class="hw_clear"></div>
			<div class="hw_ma_grid" style="margin-top:20px;">
				<div id="AXGridTarget1" style="height:400px;"></div>
		 	</div>
		  
		<!-- <button class="AXButton" type="button" onclick="fnObj.form.submit();">저장하기</button> -->
		
	</form>
</div>
</div><!--wrap 끝-->
</article>
</body>
</html>

