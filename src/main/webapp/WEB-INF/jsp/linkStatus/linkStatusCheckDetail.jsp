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
<title>모니터요원 입력시스템-연계현황 상세</title>
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
var jobId = '${param.jobId}';

// 상세 List
function grid_ajax(){
	$.ajax({
		type : 'post',
		url : "/mntr/linkStatus/runManualBatchList.json",
		data : {
			jobId : jobId
		},
		dataType : '',   	           
		success : function(res){
			var val = res.list;
			myGrid.setList(val);
		}
	});
};

// 연계현황 상세조회 :: 로그조회
function grid_ajax1(){
	$.ajax({
		type : 'post',
		url : "/mntr/linkStatus/selectCheckListDetailLog.json",
		data : {
			jobId : jobId
			, strDt: $('#REG_DATE1').val()
		    , endDt:$('#REG_DATE2').val()
		    , logStat:$('#logStat').val()
		},
		dataType : '',   	           
		success : function(res){
			var val = res.list;
			myGrid1.setList(val);
		}
	});
};

var fnObj = {
    pageStart: function(){
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
                
        var rd1 = $('#REG_DATE1').val(bdt);
        var rd2 = $('#REG_DATE2').val(dt);
        
        $('#REG_DATE1').bindDate({align:"right", valign:"bottom", separator:"-", selectType:"d",  defaultSelectType:"d", defaultDate : "rd1",
			onchange:function(){
				grid_ajax1();
			}
    	});
    	$('#REG_DATE2').bindDate({align:"right", valign:"bottom", separator:"-", selectType:"d",  defaultSelectType:"d", defaultDate : "rd2",
			onchange:function(){
				grid_ajax1();
            }
        });
    	
    	myModal.setConfig({
	            windowID: "myModalCT",
	            width: 1020,
	            opendModalID: "myModalCT",
	            displayLoading: true,
	            onclose: function () {
	                //toast.push("모달 close");
	            }
	     });
	 	myModal.setWidth("100%");
    	
		grid_ajax();
		
		myGrid.setConfig({
			targetID : "AXGridTarget",
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
				{key:"jobId", label:"연계ID", width:"80", align:"center", pk:true, display:false},
				{key:"logSeq", label:"연계실행seq", width:"80", align:"center", display:false},
				{key:"logStat", label:"실행상태", width:"80", align:"center"},
				{key:"logFailResn", label:"배치실패사유", width:"400", align:"center"},
				{key:"logDt", label:"실행시간", width:"80", align:"center"},
				{key:"logGubn", label:"구분", width:"80", align:"center"}
			],
			colHeadAlign:"center",

			body : {
			    onclick: function(){
                	fnObj.modalOpen(this.item.logSeq);
			    	
			    },
			    ondblclick: function(){},
			    oncheck: function(){}
			},
			page:{
			    paging:false
			}
		});
		
    },
    modalOpen: function(logSeq){
		myModal.open({    		 
			type: "GET",
			url:"/linkStatus/selectFailList.do?logSeq="+logSeq,				
			top:50,
			pars:"",
			closeByEscKey:true
		});	
		myModal.setWidth("100%");
	}
}	 

//상세 페이지 이동
function goPage(loc){
	location.href=loc;
};

  
$(document).ready(fnObj.pageStart);
</script>
   
</head>
<body>
<%@ include file="/WEB-INF/inc/IncHeader.jsp" %>
<article>
<div class="wrap">

	<%@ include file="/WEB-INF/jsp/inc/IncMenu.jsp" %>

	<div class="hw_content"><!--컨텐츠 내용들어가는곳 시작-->
	
		<h3 class="hw_h3_ma"><span class="half_title">연계현황 조회</span></h3>
		<div class="hw_clear"></div>	
			
		<div class="hw_infouse_01">  <p> <span class="purple"> ◎ 이용안내 :</span> 글을 작성하시려면 등록하기를 누르셔서 작성하시면 됩니다.</p></div>
		<div class="hw_clear"></div>	
						
		<div style="margin-top:20px; margin-bottom:10px;">
			<div class="hw_clear"></div>
			<div class="hw_ma_grid">
				<div id="AXGridTarget" style="height:150px;"></div>
		 	</div>
		 			 	
		 	<div class="hw_clear"></div>
		
			<div class="shipment_schedule_all">
				<div style="margin-bottom:10px; margin-top:10px;">	
					<div class="selectWrap">
						<label class="blind" for="REG_DATE1">날짜선택하기</label>
						<input type="text" name="REG_DATE1" id="REG_DATE1" class="AXInput W100" value="" />
						-
						<label class="blind" for="REG_DATE2">날짜선택하기</label>
						<input type="text" name="REG_DATE2" id="REG_DATE2" class="AXInput W100" value="" />
					</div><!--  selectWrap end  -->
					<div class="selectWrap mt10">
						<label class="blind" for="logStat">갱신여부</label>
						<select name="logStat" id="logStat" onchange="grid_ajax1()">
							<option value="">전체</option>
							<option value="1">성공</option>
							<option value="2">실패</option>    
						</select>
					 </div><!-- selectWrap end  -->
				</div>
		 	</div>
		 	
		 	
		 	<div class="hw_clear"></div>
			<div class="hw_ma_grid" style="margin-top:20px;">
				<div id="AXGridTarget1" style="height:400px;"></div>
		 	</div>
		 	<input type="hidden" name="jobId" id="jobId" value="">
		 	<div style="width:100%; margin: 10px 0px;">
				<button type="button" onclick="goPage('/linkStatus/linkStatusCheck.do');" class="addBtn" style="width: 100px;float: right;">뒤로가기</button>
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