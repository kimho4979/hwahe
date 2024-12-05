<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, user-scalable=no">
	<meta name="apple-mobile-web-app-title" content="화훼유통정보시스템">
	<meta name="robots" content="no-index,follow">
	<meta name="og:title" content="화훼유통정보시스템">
	<meta name="og:description" content="화훼유통정보시스템">
	<meta name="description" content="기념일달력">
	<meta name="content" content="화훼유통정보시스템 입니다.">
	<meta name="keywords" content="화훼경매시세, 화훼경매가격, Korea aT flower market auction price, 화훼공판장, 화훼거래정보, 꽃시장, 꽃값">
	<meta name="Author" content="화훼유통정보시스템 & www.woorim.co.kr">
	<title>기념일달력</title>
	<%@include file="../common/2020/commonJs.jsp" %>	
	<%@include file="../common/2020/commonCss.jsp" %>
	
	<link href="/plugin/fullcalendar-3.5.1/fullcalendar.min.css" rel="stylesheet" />
	<link href="/plugin/fullcalendar-3.5.1/fullcalendar.print.min.css" rel='stylesheet' media="print" />
	<script type="text/javascript" src="/plugin/fullcalendar-3.5.1/lib/moment.min.js"></script>
	<script type="text/javascript" src="/plugin/fullcalendar-3.5.1/fullcalendar.min.js"></script>
	<script type="text/javascript" src="/plugin/fullcalendar-3.5.1/locale/ko.js"></script>

	<style type="text/css">
		#calendar tr, td{line-height: 25px;}
		#calendar td.fc-day-top{line-height: 15px;}
		/* #calendar td a.fc-day-grid-event{cursor: pointer;} */
		#calendar td a span.fc-title{font-size: 0.7em;}
		#calendar .fc-header-toolbar h2{font-size: 1.6em;font-weight: bold;}
		#calendar .fc-body span.fc-title{color: #FFFFFF;}
		
		#calendar th.fc-day-header{background-color: #bcebd3;}
		#loading {
			display: none;
			position: absolute;
			top: 10px;
			right: 10px;
		}
	</style>

	<script type="text/javascript">   
		var calEl = null;
		var myModal = new AXModal();
		
		$(window).on('resize.calendar', function () {
			if($('#calendar').width() < 500){
				$('#calendar').fullCalendar('changeView', 'listMonth');
			}else{
				$('#calendar').fullCalendar('changeView', 'month');
			}
		});
		
		$(document).ready(function() {
			
			// 모달 준비
			myModal.setConfig({
		        windowID: "myEventModal", width: 740,
		        displayLoading: true,
		        scrollLock: false,
		        onclose: function () {
		          //  toast.push("모달 close");
		        }
		    });
			myModal.setWidth("100%");
			
			
			// 풀칼린더
			calEl = $('#calendar').fullCalendar({
						editable: true,
						eventLimit: true, // allow "more" link when too many events
						lang : "ko",
						editable: false,
						events: function(start, end, timezone, callback) {  
							//console.log("start",start.format());
							//console.log("end",end.format());
							
							$.ajax({
								url: "/hfc01/selectMainList.json",
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
							//console.log("event", event);
							if(event.EVENT_TYPE == "1"){
								element.find('span.fc-title').html('<img src="/images/2020/sub/church_2.png" alt="교회력" style="width: 15px;height: 15px;" > '+event.title);
							}else if(event.EVENT_TYPE == "2"){
								element.find('span.fc-title').html('<img src="/images/2020/sub/buddhism_2.png" alt="불교" style="width: 15px;height: 15px;"> '+event.title);
							}else if(event.EVENT_TYPE == "3"){
								element.find('span.fc-title').html('<img src="/images/2020/sub/catholic_2.png" alt="전례력(성당)" style="width: 15px;height: 15px;"> '+event.title);
							}else if(event.EVENT_TYPE == "4"){
								element.find('span.fc-title').html('<img src="/images/2020/sub/wedding_2.png" alt="주말길일(결혼)" style="width: 15px;height: 15px;"> '+event.title);
							}else if(event.EVENT_TYPE == "5"){
								element.find('span.fc-title').html('<img src="/images/2020/sub/etc_2.png" alt="기타행사" style="width: 15px;height: 15px;"> '+event.title);
							}
						}
					});
			
			if($('#calendar').width() < 500){
				$('#calendar').fullCalendar('changeView', 'listMonth');
			}else{
				$('#calendar').fullCalendar('changeView', 'month');
			}
		});
		
		// 연별행사리스트 모달 팝업 호출
		function yearEventModal(){
			myModal.open({    		 
				type: "GET",
				url:"/hfc01/yearEventModal.do",				
				top:50,
				pars:{
					searchYear : $('#calendar').fullCalendar('getDate').format("YYYY") 
				},
				closeByEscKey:true
			});	
			myModal.setWidth("100%");
			$(window).scrollTop(0);
		}
	
	</script> 	
</head>
<body>
	<!--WRAP(S)-->
	<div class="wrap">
		
		<jsp:include page="../inc/2020/IncHeader.jsp"/>
		
		<div class="lnb_box">
			<ul>
				<li><img src="../images/2020/m_lnb_img.png" alt="집"></li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li>열린광장</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li>알림마당</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li class="m_right">기념일달력</li>
			</ul>
		</div>
		<!--공통 HEADER(E)-->		
		<!--서브 타이틀(S)-->
		
		<div class="sub_title">
			
			<div class="title_box">
				<h2>기념일달력</h2>
				<img src="../images/2020/sub/t_line.png" alt="방울점선">
			</div>
		</div>
		<!--서브 타이틀(E)-->
		
		<!-- 서브공통(S) -->
		<!--컨텐츠 내용(S)-->
		<div class="sub_contents">
			
			<!-- 달력(S) -->
			<div class="calendar_box">
				<div id="calendar"></div>
			</div>
			<!-- 달력(E) -->
			
			<!-- 버튼(S) -->
			<div class="btn_box">
				<div class="fr">
					<a href="javascript:yearEventModal();" class="btn_type_04">년별행사일정보기</a>
				</div>
			</div>
			<!-- 버튼(E) -->

			<!-- 이용안내(S) -->
			<div class="guide">
				<h2 class="title_02">이용안내</h2>
				<ul class="guide_box">
					<span class="ml15"><img src="/images/2020/sub/church.png" alt="교회력" > 교회력</span>
					<span class="ml15"><img src="/images/2020/sub/buddhism.png" alt="불교" > 불교</span>
					<span class="ml15"><img src="/images/2020/sub/catholic.png" alt="전례력(성당)" > 전례력(성당)</span>
					<span class="ml15"><img src="/images/2020/sub/wedding.png" alt="주말길일(결혼)" > 주말길일(결혼)</span>
					<span class="ml15"><img src="/images/2020/sub/etc.png" alt="기타행사" > 기타행사</span>
				</ul>
			</div>
			<!-- 이용안내(E) -->
		</div>
		
		<jsp:include page="../inc/2020/IncFooter.jsp"/>
		
	</div>
	<!-- WRAP(E) -->
</body>
</html>
	 
	 
	 
	 
	 