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
	<title>모니터요원 입력시스템-행사일정 관리</title>
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
	
	<script type="text/javascript" src="<c:url value='/js/validation.js' />"></script>
	
	<link rel="stylesheet" type="text/css" href="/plugin/bgrins-spectrum/spectrum.css">
    <script type="text/javascript" src="/plugin/bgrins-spectrum/spectrum.js"></script>
    
    <link href="/plugin/fullcalendar-3.5.1/fullcalendar.min.css" rel="stylesheet" />
	<link href="/plugin/fullcalendar-3.5.1/fullcalendar.print.min.css" rel='stylesheet' media="print" />
	<script type="text/javascript" src="/plugin/fullcalendar-3.5.1/lib/moment.min.js"></script>
	<script type="text/javascript" src="/plugin/fullcalendar-3.5.1/fullcalendar.min.js"></script>
	<script type="text/javascript" src="/plugin/fullcalendar-3.5.1/locale/ko.js"></script>

<style type="text/css">
	#calendar tr, td{line-height: 25px;}
	#calendar td.fc-day-top{line-height: 15px;}
	#calendar td a.fc-day-grid-event{cursor: pointer;}
	#calendar td a span.fc-title{font-size: 1.2em;}
	
	#calendar th.fc-day-header{background-color: #bcebd3;}
	#loading {
		display: none;
		position: absolute;
		top: 10px;
		right: 10px;
	}
</style>


<script type="text/javascript">
var startDt = null;
var endDt = null;
var calEl = null;
var defaultHtml = "";

$(document).ready(function() {
	defaultHtml = $("#manageDiv").html();
	
	startDt = $('#START_DT').bindDate({align:"right", valign:"bottom", separator:"-", selectType:"d",  defaultSelectType:"d"});
	endDt = $('#END_DT').bindDate({align:"right", valign:"bottom", separator:"-", selectType:"d",  defaultSelectType:"d"});
	
	// 컬러픽커
	$("#EVENT_COLOR").spectrum({
		preferredFormat: "hex",
	    showPaletteOnly: true,
	    togglePaletteOnly: true,
	    togglePaletteMoreText: 'more',
	    togglePaletteLessText: 'less',
	    color: '#3d85c6',
	    palette: [
	        ["#000","#444","#666","#999","#ccc","#eee","#f3f3f3","#fff"],
	        ["#f00","#f90","#ff0","#0f0","#0ff","#00f","#90f","#f0f"],
	        ["#f4cccc","#fce5cd","#fff2cc","#d9ead3","#d0e0e3","#cfe2f3","#d9d2e9","#ead1dc"],
	        ["#ea9999","#f9cb9c","#ffe599","#b6d7a8","#a2c4c9","#9fc5e8","#b4a7d6","#d5a6bd"],
	        ["#e06666","#f6b26b","#ffd966","#93c47d","#76a5af","#6fa8dc","#8e7cc3","#c27ba0"],
	        ["#c00","#e69138","#f1c232","#6aa84f","#45818e","#3d85c6","#674ea7","#a64d79"],
	        ["#900","#b45f06","#bf9000","#38761d","#134f5c","#0b5394","#351c75","#741b47"],
	        ["#600","#783f04","#7f6000","#274e13","#0c343d","#073763","#20124d","#4c1130"]
	    ]
	});
	
	// 풀칼린더
	calEl = $('#calendar').fullCalendar({
				editable: true,
				eventLimit: true, // allow "more" link when too many events
				lang : "ko",
				editable: false,
				events: function(start, end, timezone, callback) {  
					
					$.ajax({
						url: "/mntr/mce01/getEventCalendar.json",
						dataType: 'json',
						type : "post",
						data: {
							start: start.format(),
			                end: end.format()
						}, 
						success: function (result) {
							callback(result.resultList);
						},
						error:function(xhr, textStatus, error){
							alert("알수없는 오류가 발생하였습니다.\n관리자에게 문의해 주시기 바랍니다.");
							return false;
						}
					});
				},
				loading: function(bool) {
					$('#loading').toggle(bool);
					$('#calendar .fc-head-container table thead').before('<caption>fullCalendar</caption>');
					
				},
				eventRender: function(event, element) {
					if(event.EVENT_TYPE == "1"){
						element.find('span.fc-title').html('<img src="/images/event/church_2.png" alt="교회력" style="width: 15px;height: 15px;"> '+event.title);
					}else if(event.EVENT_TYPE == "2"){
						element.find('span.fc-title').html('<img src="/images/event/buddhism_2.png" alt="불교" style="width: 15px;height: 15px;"> '+event.title);
					}else if(event.EVENT_TYPE == "3"){
						element.find('span.fc-title').html('<img src="/images/event/catholic_2.png" alt="전례력(성당)" style="width: 15px;height: 15px;"> '+event.title);
					}else if(event.EVENT_TYPE == "4"){
						element.find('span.fc-title').html('<img src="/images/event/wedding_2.png" alt="주말길일(결혼)" style="width: 15px;height: 15px;"> '+event.title);
					}else if(event.EVENT_TYPE == "5"){
						element.find('span.fc-title').html('<img src="/images/event/etc_2.png" alt="기타행사" style="width: 15px;height: 15px;"> '+event.title);
					}
				},
				eventClick: function(data, jsEvent, view) {
			        updateEventForm(data);
			    }
			});
}); 

//수정폼 호출
function updateEventForm(data){
	$.ajax({
		type : 'post',
		url : "/mntr/mce01/updateEventForm.do",
		data : {
			EVENT_SEQ : data.EVENT_SEQ
		},
		success : function(res){               
			$("#manageDiv").html(res);
		},
	});
	
}


// 등록처리
function inputEventProc($frm){
	
	// 달력확인
	var d1 = new Date($frm.find("#START_DT").val());
	var d2 = new Date($frm.find("#END_DT").val());
	if(d1 > d2){
		alert("종료일은 시작일 이전으로 입력하실수 없습니다.");
		$frm.find("#END_DT").focus();
		return false;
	}
	
	if(!confirm("등록 하시겠습니까?")) return false;
	 
	$.ajax({
          type : 'post',
          url : "/mntr/mce01/inputEventProc.json",
          data : $frm.serialize(),
          success : function(res){         
	    	   if(res.error){
                   alert(res.error.message);
               }else{
            	   alert(res.result.message);
            	   if(res.result.stat == "1"){
            		   defaultForm();
            	   }
            	   
               }
          },
	});
	
	return false;
}


// 초기화 폼
function defaultForm(){
	$("#manageDiv").html(defaultHtml);
	
	startDt = $('#START_DT').bindDate({align:"right", valign:"bottom", separator:"-", selectType:"d",  defaultSelectType:"d"});
	endDt = $('#END_DT').bindDate({align:"right", valign:"bottom", separator:"-", selectType:"d",  defaultSelectType:"d"});
	
	// 컬러픽커
	$("#EVENT_COLOR").spectrum({
		preferredFormat: "hex",
	    showPaletteOnly: true,
	    togglePaletteOnly: true,
	    togglePaletteMoreText: 'more',
	    togglePaletteLessText: 'less',
	    color: '#3d85c6',
	    palette: [
	        ["#000","#444","#666","#999","#ccc","#eee","#f3f3f3","#fff"],
	        ["#f00","#f90","#ff0","#0f0","#0ff","#00f","#90f","#f0f"],
	        ["#f4cccc","#fce5cd","#fff2cc","#d9ead3","#d0e0e3","#cfe2f3","#d9d2e9","#ead1dc"],
	        ["#ea9999","#f9cb9c","#ffe599","#b6d7a8","#a2c4c9","#9fc5e8","#b4a7d6","#d5a6bd"],
	        ["#e06666","#f6b26b","#ffd966","#93c47d","#76a5af","#6fa8dc","#8e7cc3","#c27ba0"],
	        ["#c00","#e69138","#f1c232","#6aa84f","#45818e","#3d85c6","#674ea7","#a64d79"],
	        ["#900","#b45f06","#bf9000","#38761d","#134f5c","#0b5394","#351c75","#741b47"],
	        ["#600","#783f04","#7f6000","#274e13","#0c343d","#073763","#20124d","#4c1130"]
	    ]
	});
	
	calEl.fullCalendar( 'refetchEvents' );
}



</script>
</head>
<body>

<%@ include file="/WEB-INF/inc/IncHeader.jsp" %>

<article>
	<div class="wrap">
		<%@ include file="/WEB-INF/jsp/inc/IncMenu.jsp" %>
	
	
		<div class="hw_content"><!--컨텐츠 내용들어가는곳 시작-->
			<h3 class="hw_h3_ma"><!-- <div class="half1_white"></div> --><span class="half_title">행사일정관리</span></h3>
			<div class="hw_clear"></div>
		
			<div class="hw_infouse_01">
				<p><span class="purple"> ◎ 행사일정관리 :</span> 달력형태의 행사 정보를 관리</p>
			</div>

			<div id="manageDiv" style="width:100%; margin: 10px 0px;">
				<div class="selectWrap mt10">
					<form id="eventFrm" name="eventFrm" method="post" onsubmit="return inputEventProc($(this));">
						<div style="margin-bottom: 10px;">
							<ul class="titList3" style="border-bottom: 0px;">
								<li class="th">일정 : </li>
								<li class="td">
									<label class="blind" for="START_DT">날짜 선택</label>
									<input type="text" name="START_DT" id="START_DT" class="AXInput W100" value="" />
									 ~ 
									 <label class="blind" for="END_DT">날짜 선택</label>
									 <input type="text" name="END_DT" id="END_DT" class="AXInput W100" value="" />
								</li>
								<li class="th">색상 :</li>
								<li class="td">
									<label class="blind" for="EVENT_COLOR">색상 선택</label>
									<input type="text" class="AXInput" name="EVENT_COLOR" id="EVENT_COLOR" value="#3d85c6" />
								</li>
							</ul>
							<ul class="titList" style="border-top: 0px;">
								<li class="th">행사구분 : </li>
								<li class="td">
									<label><input type="radio" name="EVENT_TYPE" value="1" checked="checked"/> 교회력 </label>
									<label><input type="radio" name="EVENT_TYPE" value="2" /> 불교 </label>
									<label><input type="radio" name="EVENT_TYPE" value="3" /> 전례력(성당) </label>
									<label><input type="radio" name="EVENT_TYPE" value="4" /> 주말길일(결혼) </label>
									<label><input type="radio" name="EVENT_TYPE" value="5" /> 기타행사 </label>
								</li>
								<li class="th">행사명 :</li>
								<li class="td">
									<label class="blind" for="EVENT_NM">행사명</label>
									<input type="text" class="AXInput" name="EVENT_NM" id="EVENT_NM" value="" required="required" style="width: 85%;" maxlength="100" />
								</li>
								<li class="th">비고 :</li>
								<li class="td">
									<label class="blind" for="REMARKS">비고</label>
									<input type="text" class="AXInput" name="REMARKS" id="REMARKS" value="" style="width: 85%;" maxlength="150" />
								</li>
							</ul><!-- titList end  -->
							<div class="btnWrap"><button type="submit" class="ma_add_2">등록하기</button></div>
						</div>
					</form>
				</div>
			</div>
			<div class="hw_clear"></div>
			
			<div class="hw_infouse_01" style="margin: 30px 0px;">
				<p>
					<span style="margin-left: 15px;"><img src="/images/event/church.png" alt="교회력" style="vertical-align: middle;"/> 교회력</span>
					<span style="margin-left: 15px;"><img src="/images/event/buddhism.png" alt="불교" style="vertical-align: middle;"/> 불교</span>
					<span style="margin-left: 15px;"><img src="/images/event/catholic.png" alt="전례력(성당)" style="vertical-align: middle;"/> 전례력(성당)</span>
					<span style="margin-left: 15px;"><img src="/images/event/wedding.png" alt="주말길일(결혼)" style="vertical-align: middle;"/> 주말길일(결혼)</span>
					<span style="margin-left: 15px;"><img src="/images/event/etc.png" alt="기타행사" style="vertical-align: middle;"/> 기타행사</span>
				</p>
			</div>
			
			<div style="width:100%; margin: 10px 0px;">
				<div id="loading" style="display: none;">loading...</div>
				<div id="calendar"></div>
			</div>
			
		</div>
		<!--// hw_content -->
	</div>
	<!--// wrap-->
</article>

	<div class="hw_clear"></div>
	<footer>
		<%@ include file="/WEB-INF/inc/IncFooter.jsp" %>
	</footer>
</body>
</html>







