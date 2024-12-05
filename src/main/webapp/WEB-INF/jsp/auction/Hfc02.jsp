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
<meta name="description" content="주요행사일정">
<meta name="content" content="화훼유통정보시스템 입니다.">
<meta name="keywords" content="화훼경매시세, 화훼경매가격, Korea aT flower market auction price, 화훼공판장, 화훼거래정보, 꽃시장, 꽃값">
<meta name="Author" content="화훼유통정보시스템 & www.woorim.co.kr">
<title>주요 행사일정</title>
<%@include file="../common/2020/commonJs.jsp" %>
<%@include file="../common/2020/commonCss.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6/index.global.min.js"></script>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdn.datatables.net/1.13.1/css/jquery.dataTables.min.css">
<script type="text/javascript" src="https://cdn.datatables.net/1.13.1/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/fixedcolumns/4.2.1/js/dataTables.fixedColumns.min.js"></script>

<style type="text/css">
	h2 {
		margin: 0;      
	}
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
	@media screen and (max-width: 990px) 
{
	.fc-h-event .fc-event-title{font-size: 10px;}
	}
</style>

<script>

	let scheduleInfo = [];

    document.addEventListener("DOMContentLoaded", function(){
        let today = new Date().toISOString().substr(0, 7);
        document.querySelector("input[type='month']").value = today;

        $('#tb__eventList').DataTable({
            scrollY: '400px',
            scrollCollapse: true,
            scrollX: "100%",
            scrollXInner: "800px",
            paging: false ,
			ordering: false,
            searching : false,
            info : false,
			language: {
				'search': '검색 : ', 
				"emptyTable": " "
			},
            columns: [
				{data: 'EVENT_GP_NM', className: 'dt-left'},
				{data: 'EVENT_NM', className: 'dt-left'},
				{data: 'EVENT_YMD', className: 'dt-left'},
				{data: 'SI_NM', className: 'dt-left'},
				{data: 'ADDR', className: 'dt-left'},
				{data: 'EVENT_PLS', className: 'dt-left'}
            ]
        });

		// 행사구분
		$.ajax({
			type : 'post',
			url : "/comm/selectComCdList.json",
			data : {
				gpId: 'EVENT_GP'	
			},
			dataType : 'json',
			success : function(res) {
				//$('#sel__eventGp').html('');
				$('#sel__eventGp').append("<option value='' selected>전체</option>");
				if (res.data.length > 0) {
					res.data.forEach(function(item) {
						console.log(item);
						$('#sel__eventGp').append("<option value='" + item.cdId + "'>" + item.cdNm + "</option>");
					});
				}
			}
		});
		
		// 시군구
		$.ajax({
			type : 'post',
			url : "/comm/selectComCdList.json",
			data : {
				gpId: 'AREA_NM'	
			},
			dataType : 'json',
			success : function(res) {
				//$('#sel__areaNm').html('');
				$('#sel__areaNm').append("<option value='' selected>전체</option>");
				if (res.data.length > 0) {
					res.data.forEach(function(item) {
						$('#sel__areaNm').append("<option value='" + item.cdId + "'>" + item.cdNm + "</option>");
					});
				}
			}
		});

		let btn_search = document.querySelector('button[name="btn_search"]');
		btn_search.addEventListener("click", function() {
			objHfc02.searchDate();
		});

		objHfc02.searchDate();
		
		
    });

	const objHfc02 = {
		setCalendar: function() {

		},
		searchDate: function() {
			let param = {
				eventGp: document.getElementById("sel__eventGp").value,
				siNm: document.getElementById("sel__areaNm").value,
				eventYmd: document.querySelector("input[name='cal__searchYmd'").value
			};
			$.ajax({
				type : 'post',
				url : "/hfc02/selectEventCalendarList.json",
				data : param,
				dataType : 'json',
				success : function(res) {
					$('#tb__eventList').DataTable().clear().rows.add(res.eventList).draw();

					scheduleInfo.length = 0;
					res.calendarList.forEach(function(schedule) {
						scheduleInfo.push(schedule);
					});

					console.log(res.calendarList);
					objHfc02.setCalendar(res.calendarList, param.eventYmd);
				}
			});
		},
		setCalendar: function(schedule, eventYmd) {
			var calendarEl = document.getElementById('eventCalendar');
			var calendar = new FullCalendar.Calendar(calendarEl, {
				
				customButtons : {
					today : {
						text : 'today',
						click : function() {
							calendar.today();
							let today = new Date();   

							let year = today.getFullYear(); // 년도
							let month = today.getMonth() + 1;  // 월
							let date = today.getDate();  // 날짜
							

							if(month <10){
								month = "0"+month;
							}
							if(date <10){
								date = "0"+date;
							}
							
							let monthToday = new Date().toISOString().substr(0, 7);
					        document.querySelector("input[type='month']").value = monthToday;
					        let btn_search = document.querySelector('button[name="btn_search"]');
					        btn_search.addEventListener("click", function() {
								objHfc02.searchDate();
							});

							objHfc02.searchDate();
							let eventYmd2 = '' + year + month + date;
							eventYmd2 = year + month + today + '';
							siNm = document.getElementById("sel__areaNm").value;
							let
							param = {
								eventYmd2 : eventYmd2,
								siNm : siNm
							};
							$.ajax({
								type : 'post',
								url : "/hfc02/selectEventList.json",
								data : param,
								dataType : 'json',
								success : function(res) {
									console.log("success")
									$('#tb__eventList').DataTable().clear().rows
											.add(res.eventList).draw();
								}
							});
							
						}
					},
					prev : {
						text : "prev",
						click : function(){
							document.querySelector("input[name='cal__searchYmd'").stepDown(1);
							let btn_search = document.querySelector('button[name="btn_search"]');
							calendar.prev();
							btn_search.addEventListener("click", function() {
								objHfc02.searchDate();
							});

							objHfc02.searchDate();
						}
						
					},
					next : {
						text : "next",
						click : function(){
							document.querySelector("input[name='cal__searchYmd'").stepUp(1);
							calendar.next();
							let btn_search = document.querySelector('button[name="btn_search"]');
							btn_search.addEventListener("click", function() {
								objHfc02.searchDate();
							});

							objHfc02.searchDate();
						}
					}
					
				},
				
				
				headerToolbar : {
					left : 'title',
					right : 'today prev,next'
				},

				initialView : 'dayGridMonth',
				//aspectRatio: 1,
				locale : "ko",
				//navLinks: true, // can click day/week names to navigate views
				selectable : true,
				selectMirror : true,
				select : function(arg) {
					calendar.unselect();
				},
				contentHeight : "auto",
				events : schedule,
				/* function(start, end, timezone, callback) {
				$.ajax({
					url: "/hfc01/selectMainList.json",
					dataType: 'json',
					type : "post",
					data: {
						//start: start.format(),
						//end: end.format()
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
				 */
				eventClick : function(calEvent, jsEvent) {
					console.log(calEvent.event.start);

					let
					start = calEvent.event.start;

					const
					year = start.getFullYear() * 1e4;
					const
					month = (start.getMonth() + 1) * 100;
					const
					day = start.getDate();
					const
					eventYmd2 = year + month + day + '';
					siNm = document.getElementById("sel__areaNm").value;
					if (eventYmd2) {
						let
						param = {
							eventYmd2 : eventYmd2,
							siNm : siNm
						};
						$.ajax({
							type : 'post',
							url : "/hfc02/selectEventList.json",
							data : param,
							dataType : 'json',
							success : function(res) {
								$('#tb__eventList').DataTable().clear().rows
										.add(res.eventList).draw();
							}
						});
					}

				},
				dateClick : function(e) {
					if (e && e.dateStr) {
						siNm = document.getElementById("sel__areaNm").value;
						let
						param = {
							eventYmd2 : e.dateStr,
							siNm : siNm
						};
						$.ajax({
							type : 'post',
							url : "/hfc02/selectEventList.json",
							data : param,
							dataType : 'json',
							success : function(res) {
								$('#tb__eventList').DataTable().clear().rows
										.add(res.eventList).draw();
							}
						});
					}
				},
				editable : false,
				dayMaxEvents : true,
				eventTimeFormat : {
					hour : '2-digit',
					minute : '2-digit',
					hour12 : false
				},
				initialDate : eventYmd + '-01',

			});

			calendar.render();
		}
	};
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
				<li class="m_right">주요 행사일정</li>
			</ul>
		</div>
		<!--공통 HEADER(E)-->
		<!--서브 타이틀(S)-->
		<jsp:include page="../inc/2020/IncShare.jsp" />

		<div class="sub_title">
			<div class="title_box">
				<h2>주요 행사일정</h2>
				<img src="../images/2020/sub/t_line.png" alt="방울점선">
			</div>
		</div>
		<!--서브 타이틀(E)-->

		<!-- 서브공통(S) -->
		<!--컨텐츠 내용(S)-->
		<div class="sub_contents">
		<div class="sub_info_box">
			<div class="tit_box_01 ">
				<div class="fl">
					<h4 class="title_02 mt0">검색조건</h4>
				</div>
				<div class="fr ml6">
					<button class="search_btn_n" name="btn_search"><img src="../images/2020/sub/search_img.png" alt="돋보기">검색</button>
				</div>
			</div>
			<div class="search_box_new statistic">
				<input type="hidden" id="searchStrDate" value="${searchStrDate}">
				<input type="hidden" id="searchEndDate" value="${searchEndDate}">
				<div class="s-line">
					<h4 class="sbn_tit_01">행사구분</h4>
					<div class="sb_common_01">
						<select id="sel__eventGp">
						</select>
					</div>
				</div>
				
				<div class="s-line">
					<h4 class="sbn_tit_01">조회연월</h4>
					<div class="sb_common_01 pack-01">						
						<div class="" id="searchDateM">
							<div class="calendar_new">
								<input type="month" alt="켈린더" class="calendar_focus" name="cal__searchYmd" value="2018-08" style="width:100%;padding: 5px 10px;">								
							</div>
						</div>
											
					</div>
				</div>
				
				<div class="s-line">
					<h4 class="sbn_tit_01">시/군/구</h4>
					<div class="sb_common_01">
						<select id="sel__areaNm">
						</select>
					</div>
					<!--
					<div class="sb_common_01">						
						<input class="ip_text code"  type="search" value="">
						<div class="btn_box_02 btn__search_sch ">
							<button type="button" class="btn_type_03" >검색</button>
						</div>			        
					</div>
					-->
				</div>
			</div>
		</div>
		</div>
		

		<div class="sub_contents">
			<!-- 행사일정 달력 -->
			<div class="w3-margin-top">
				<div id="eventCalendar"></div>
			</div>
			
			<div class="w3-container pd0">
				<h6 class="title_02">세부행사내역</h6>
				<table id="tb__eventList" class="display compact">
					<colgroup>
						<col width="10%" />
						<col width="20%" />
						<col width="10%" />
						<col width="10%" />
						<col width="25%" />
						<col width="25%" />
					</colgroup>
					<thead>
						<tr class="w3-light-grey">
							<th>구분</th>
							<th>행사명</th>
							<th>일시</th>
							<th>지역</th>
							<th>주소</th>
							<th>행사장</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
		<jsp:include page="../inc/2020/IncFooter.jsp"/>
	</div>
	<!-- WRAP(E) -->
</body>
</html>




