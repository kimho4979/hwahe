<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1" />
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, user-scalable=no">
	<meta name="apple-mobile-web-app-title" content="화훼유통정보시스템">
	<meta name="robots" content="no-index,follow">
	<meta name="og:title" content="화훼유통정보시스템">
	<meta name="og:description" content="화훼유통정보. 전국 화훼공판장 경매시세 조회 및 화훼 관련 정보 제공. 화훼 경락가격, 유찰정보, 수출입량 등 다양한 정보를 만나보세요.">
	<meta name="content" content="화훼유통정보시스템 입니다.">
	<meta name="keywords" content="화훼경매시세, 화훼경매가격, Korea aT flower market auction price, 화훼공판장, 화훼거래정보, 꽃시장, 꽃값">
	<meta name="description" content="화훼유통정보. 전국 화훼공판장 경매시세 조회 및 화훼 관련 정보 제공. 화훼 경락가격, 유찰정보, 수출입량 등 다양한 정보를 만나보세요.">
	<meta name="Author" content="화훼유통정보시스템 & www.woorim.co.kr">
	<title>화훼유통정보시스템</title>
	
	<!-- CSS(S) -->
	<link rel="stylesheet" type="text/css" href="../css/2020/reset.css">
	<link rel="stylesheet" type="text/css" href="../css/2020/common.css">
	<link rel="stylesheet" type="text/css" href="../css/2020/main.css">
	<link rel="stylesheet" type="text/css" href="../css/2020/sub.css">
	<link rel="stylesheet" type="text/css" href="../css/2020/jquery-ui.css"> <!-- datepicker style -->
	
	<link rel="stylesheet" type="text/css" href="../css/2020/calendar.css">
	<!-- CSS(E) -->
	
	<link type="text/css" rel="stylesheet" href="/plugin/jquery-ui-1.12.1.custom/jquery-ui.min.css">
		
	<!-- rMate common File -->
	<link rel="stylesheet" type="text/css" href="/rMateChart/rMateChartH5/Assets/Css/rMateChartH5.css"/> 

	<!-- SCRIPT(S) -->
	<script type="text/javascript" src="../js/2020/jquery-1.11.3.min.js"></script>
	<script type="text/javascript" src="../js/2020/jquery-ui.js"></script> <!-- datepicker js -->
	<script type="text/javascript" src="../js/2020/script.js"></script>
	<script type="text/javascript" src="../js/2020/jquery.bxslider.min.js"></script>
	<script type="text/javascript" src="../js/2020/swipe.js"></script><!-- 메인슬라이드  -->
	
	<script type="text/javascript" src="../js/2020/calendar.js"></script>
	<!-- SCRIPT(E) -->


	<!--  파비콘 소스  -->
	<link rel="apple-touch-icon" href="/images/content/favicon.png" />
	<link rel="apple-touch-icon-precomposed" href="/images/content/favicon.png" />
	<link rel="shortcut icon" href="/images/content/favicon.png" />
	<link rel="shortcut icon" href="/images/content/favicon.png" type="image/x-icon" >

	
	<!-- Global site tag (gtag.js) - Google Analytics -->	
	<!-- <script async src="https://www.googletagmanager.com/gtag/js?id=UA-124845654-1"></script>
	<script>
		  window.dataLayer = window.dataLayer || [];
		  function gtag(){dataLayer.push(arguments);}
		  gtag('js', new Date());
		
		  gtag('config', 'UA-124845654-1');
	</script> -->
	<!--Google tag (gtag.js) GA4 25 화훼공판장 2023.01 -->
	<script async src="https://www.googletagmanager.com/gtag/js?id=G-GH4XDEKH3E"></script>
	<script>
		window.dataLayer = window.dataLayer || [];
		function gtag(){dataLayer.push(arguments);}
		gtag('js',new Date());
		
		gtag('config','G-GH4XDEKH3E'),{'content_group':'FlowerInfo'};
		gtag('config','G-1C6GSRP5Z8'),{'content_group':'FlowerInfo'};
	</script>
	
	<!-- rMate common File -->
	<script type="text/javascript" src="/rMateChart/LicenseKey/rMateChartH5License.js"></script>
	<script type="text/javascript" src="/rMateChart/rMateChartH5/JS/rMateChartH5.js"></script>
	<script type="text/javascript" src="/rMateChart/rMateChartH5/Assets/Theme/theme.js"></script>
	
	<script type="text/javascript">
	$(document).ready(function(){
		
		hfc01Event();
		selectFlowerMainMonth();
		//calendar			
        var $ca = $('#main_calendar').calendar({
            width: 263,
            height: 206,
        	prev: '',
        	next: '',
        	weekArray: ['S', 'M', 'T', 'W', 'T', 'F', 'S'],
        	monthArray: ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'],
          	date: new Date("${searchSaleDate}")	            
        });
		
	});
		
	
		function selectFlowerMainMonth(){
			$.ajax({
				url: "/main/selectFlowerMainMonth.json",
				dataType: 'json',
				type : "post",
				data: {
				}, 
				success: function (result) {
					console.log(result.result);
					var list = result.result;
					var html = "";
					console.log(list[0].pumName);
					for(var i=0; i<list.length; i++){
						if(i == 0 || i%4 == 0){
							html += "<tr>";
							html += "<td rowspan ='4'>"+list[i].pumName+"</td>";
							html += "<td>"+list[i].gubn.substring(1)+"</td>";
							html += "<td>"+list[i].jan+"</td>";
							html += "<td>"+list[i].feb+"</td>";
							html += "<td>"+list[i].mar+"</td>";
							html += "<td>"+list[i].apr+"</td>";
							html += "<td>"+list[i].may+"</td>";
							html += "<td>"+list[i].jun+"</td>";
							html += "<td>"+list[i].jul+"</td>";
							html += "<td>"+list[i].aug+"</td>";
							html += "<td>"+list[i].sep+"</td>";
							html += "<td>"+list[i].oct+"</td>";
							html += "<td>"+list[i].nov+"</td>";
							html += "<td>"+list[i].dec+"</td>";
							html += "</tr>"
						}else{
							html += "<tr>";
							html += "<td>"+list[i].gubn.substring(1)+"</td>";
							html += "<td>"+list[i].jan+"</td>";
							html += "<td>"+list[i].feb+"</td>";
							html += "<td>"+list[i].mar+"</td>";
							html += "<td>"+list[i].apr+"</td>";
							html += "<td>"+list[i].may+"</td>";
							html += "<td>"+list[i].jun+"</td>";
							html += "<td>"+list[i].jul+"</td>";
							html += "<td>"+list[i].aug+"</td>";
							html += "<td>"+list[i].sep+"</td>";
							html += "<td>"+list[i].oct+"</td>";
							html += "<td>"+list[i].nov+"</td>";
							html += "<td>"+list[i].dec+"</td>";
							html += "</tr>"
						}
					}
					$("#get1").append(html);
				},
				error:function(xhr, textStatus, error){
					alert("알수없는 오류가 발생하였습니다.\n관리자에게 문의해 주시기 바랍니다.");
					return false;
				}
			});
		}
		
			
		//기념일
		function hfc01Event(){
			var startDate = "${searchSaleDate}";
			var endDate = "${searchSaleDate}";
			
			$.ajax({
				url: "/hfc01/selectMainList.json",
				dataType: 'json',
				type : "post",
				data: {
					start: startDate,
	                end: endDate
				}, 
				success: function (result) {
					$("#anniversary").empty();
					
					if(result.resultList!=null && result.resultList.length > 0){				
						for(var i=0;i<result.resultList.length;i++){
							
							var img = "";
							
							if(result.resultList[i].EVENT_TYPE == "1"){
								img = '<img src="/images/2020/sub/church_2.png" alt="교회력" style="width: 15px;height: 15px;" > ';
								$("#anniversary").append('<p style="background: '+result.resultList[i].color+';">' + img +result.resultList[i].title + "</p>")
							}else if(result.resultList[i].EVENT_TYPE == "2"){
								img = '<img src="/images/2020/sub/buddhism_2.png" alt="불교" style="width: 15px;height: 15px;"> ';
								$("#anniversary").append('<p style="background: '+result.resultList[i].color+';">' + img +result.resultList[i].title + "</p>")
							}else if(result.resultList[i].EVENT_TYPE == "3"){
								img = '<img src="/images/2020/sub/catholic_2.png" alt="전례력(성당)" style="width: 15px;height: 15px;"> '
								$("#anniversary").append('<p style="background: '+result.resultList[i].color+';">'+ img + result.resultList[i].title + "</p>")
							}else if(result.resultList[i].EVENT_TYPE == "4"){
								img = '<img src="/images/2020/sub/wedding_2.png" alt="주말길일(결혼)" style="width: 15px;height: 15px;"> ';
								$("#anniversary").append('<p style="background: '+result.resultList[i].color+';">'+ img + result.resultList[i].title +"</p>")
							}else if(result.resultList[i].EVENT_TYPE == "5"){
								img = '<img src="/images/2020/sub/etc_2.png" alt="기타행사" style="width: 15px;height: 15px;"> '
								$("#anniversary").append('<p style="background: '+result.resultList[i].color+';">' + img + result.resultList[i].title + "</p>")
							}							
						}
					}else{
						img = '<img src="../images/2020/day_nothing.png" class="nothing_img" alt="스케쥴없음" >'
						$("#anniversary").append(img + '<p class="ment">이벤트가 없습니다.</p>')						
					}
				},
				error:function(xhr, textStatus, error){
					alert("알수없는 오류가 발생하였습니다.\n관리자에게 문의해 주시기 바랍니다.");
					return false;
				}
			});
		}
		
		// 달력 컨트롤
		function datepickerCreate(flowerCd){
			
			if(flowerCd == "1"){
				$("#datepicker").datepicker("destroy");
				$("#datepicker").datepicker({
					showOn: "button",
				    buttonImage: "../images/2020/ico_date_02.png",
				    buttonImageOnly: true,
					todayHighlight: true,
					autoclose: true,
					showMonthAfterYear: true,
			        dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
			        monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
					language: 'kr',
					dateFormat: 'yy-mm-dd',
					/* beforeShowDay:datechktoday, */
					yearSuffix: '년',
					changeMonth: true,
			        changeYear: true,
					beforeShowDay: function(date){	        	
			        	
			        	var day = date.getDay();
			        	
			        	if(date > new Date())
							return [false];
			        	
			        	return [(day == 1 || day == 3 || day == 5)];			        				
					},
					onSelect: function(selectedDate){
						buttonEvent(selectedDate);
					}
				});
			}else if(flowerCd == "2"){
				$("#datepicker").datepicker("destroy");
				$("#datepicker").datepicker({
					showOn: "button",
				    buttonImage: "../images/2020/ico_date_02.png",
				    buttonImageOnly: true,
					todayHighlight: true,
					autoclose: true,
					showMonthAfterYear: true,
			        dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
			        monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
					language: 'kr',
					dateFormat: 'yy-mm-dd',
					/* beforeShowDay:datechktoday, */
					yearSuffix: '년',
					changeMonth: true,
			        changeYear: true,
					beforeShowDay: function(date){	        	
			        	
			        	var day = date.getDay();		
			        	
			        	if(date > new Date())
							return [false];
			        	
			        	return [(day == 1 || day == 2)];			        				
					},
					onSelect: function(selectedDate){
						buttonEvent(selectedDate);
					}
				});
			}else if(flowerCd == "3"){
				$("#datepicker").datepicker("destroy");
				$("#datepicker").datepicker({
					showOn: "button",
				    buttonImage: "../images/2020/ico_date_02.png",
				    buttonImageOnly: true,
					todayHighlight: true,
					autoclose: true,
					showMonthAfterYear: true,
			        dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
			        monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
					language: 'kr',
					dateFormat: 'yy-mm-dd',
					/* beforeShowDay:datechktoday, */
					yearSuffix: '년',
					changeMonth: true,
			        changeYear: true,
					beforeShowDay: function(date){	        	
			        	
			        	var day = date.getDay();		
			        	
			        	if(date > new Date())
							return [false];
			        	
			        	return [(day == 1)];			        				
					},
					onSelect: function(selectedDate){
						buttonEvent(selectedDate);
					}
				});
			}		
		}
	
	</script>
	
	
</head>
<body>
	<!--WRAP(S)-->
    <div class="wrap">
    	
		<jsp:include page="../inc/2020/IncHeader.jsp"/>
    	
		
		<!--콘텐츠_메인(S)-->
	    <div class="conts_main">
	
	        <!-- 메인슬라이드(S) 웹 -->
	        <div id="visual" class="slide">
	            <!-- 배너 목록 웹(S)-->
	            <!-- 웹(S) -->
	            <div id="mySwipe" class='swipe'>
	                <ul class="touch_banner swipe-wrap">
	                    <li class="slide_img">
							<a href="#">
								<img class="web_slide_img" src="../images/2020/main_slide_01.jpg" alt="웹메인슬라이드">
								<img class="mobile_slide_img" src="../images/2020/main_slide_01_mobile.jpg" alt="모바일메인슬라이드">
							</a>
						</li>
                           <li class="slide_img">
							<a href="#">
								<img class="web_slide_img" src="../images/2020/main_slide_02.jpg" alt="웹메인슬라이드">
								<img class="mobile_slide_img" src="../images/2020/main_slide_02_mobile.jpg" alt="모바일메인슬라이드">
							</a>
						</li>
						<li class="slide_img">
							<a href="#">
								<img class="web_slide_img" src="../images/2020/main_slide_03.jpg" alt="웹메인슬라이드">
								<img class="mobile_slide_img" src="../images/2020/main_slide_03_mobile.jpg" alt="모바일메인슬라이드">
							</a>
						</li>
	                </ul>
	            </div>
	            <!-- 웹(E) -->
	            <!-- 배너 목록 웹(E)-->
	            <p class="touch_left_btn">
	                <!-- 이전 버튼 -->
	                <a href="#"> <img src="../images/2020/visual_btn_left.png" alt="이전 배너"> </a>
	            </p>
	            <p class="touch_right_btn">
	                <!-- 이전 버튼 -->
	                <a href="#"><img src="../images/2020/visual_btn_right.png" alt="다음 배너"></a>
	            </p>
	        </div>
	        <!-- 메인슬라이드(E) 웹 -->
	
	        <!-- 메인슬라이드(S) 모바일 -->
	
	        <!-- 메인슬라이드(E) 모바일 -->
	
	        <!-- 타이틀박스(S) -->
	        <div class="tit_box">
	            <h2 class="title_02">일자별 경매정보 보기</h2>
	        </div>
	        <!-- 타이틀박스(E) -->
	
	
			<!--컨텐츠 내용(S)-->
		<div class="sub_guide">
			
			<!-- 텍스트그래픽(S) -->
			<div class="txt_graph" style="display:none;">
				<div id="chartHolder" style="width:100%; height:340px;"></div>
			</div>
			<!-- 텍스트그래픽(E) -->

			<!-- 테이블(S) -->
			<div class="table_overflow_y">
				<table class="table_type_01 btg tiny">
					<caption>품목별 총 거래정보</caption>
					<colgroup>
						<col style="width:20%">
						<col style="width:20%">
						<col style="width:5%">
						<col style="width:5%">
						<col style="width:5%">
						<col style="width:5%">
						<col style="width:5%">
						<col style="width:5%">
						<col style="width:5%">
						<col style="width:5%">
						<col style="width:5%">
						<col style="width:5%">
						<col style="width:5%">
						<col style="width:5%">
						<col style="width:5%">
					</colgroup>
					<thead>
						<tr>
							<th class="tc">품목/품종</th>
							<th class="tc">구분</th>
							<th class="tc">1월</th>
							<th class="tc">2월</th>
							<th class="tc">3월</th>
							<th class="tc">4월</th>
							<th class="tc">5월</th>
							<th class="tc">6월</th>
							<th class="tc">7월</th>
							<th class="tc">8월</th>
							<th class="tc">9월</th>
							<th class="tc">10월</th>
							<th class="tc">11월</th>
							<th class="tc">12월</th>
						</tr>
					</thead>
					<tbody id="get1">
					</tbody>
				</table>
			</div>
			<!-- 테이블(E) -->

			<!-- 버튼박스(S) -->
			<div class="dwn_bt_b" id="excelBtn1">
				<a href="#!"><img src="../images/2020/exel.png" alt="엑셀이미지">엑셀저장</a>
			</div>
			<!-- 버튼박스(E) -->

		</div>
	     
			<div class="bottom_content">
				<div class="left_box">
					<h2 class="title_02">기념일 달력</h2>
					<a class="plus_bt" href="/hfc01/hfc01.do">+ 더보기</a>
					<ul>
						<li>
							<div id="main_calendar"></div>
						</li>
						<li>
							<p><span>오늘</span>${searchSaleDate}</p>
							<div class="cl_title" id="anniversary">
							</div>
						</li>
					</ul>
				</div>
				<div class="right_box">
					<h2 class="title_02">가격문자 알림서비스</h2>
					<ul>
						<li>
							<p>실시간 경매정보를 알고 싶다면<br>알림서비스를 신청하세요!</p>
							<strong>전국 화훼공판장의 실시간 경매정보를 <br>문자로 받아 볼 수 있습니다.</strong>
						</li>
						<li>
							<div>
								<img src="../images/2020/right_img.png" alt="신청하기 아이콘">
								<a href="/customInfo/customInfoForm.do">신청하기</a>
							</div>
						</li>
					</ul>
				</div>
			</div>
			<!-- 메인 탭 메뉴(E) -->
	
		</div>
	    <!--콘텐츠_메인(E)-->
	
		<jsp:include page="../inc/2020/IncFooter.jsp"/>			
	    
	</div>
	<!--WRAP(E)-->
</body>
</html>