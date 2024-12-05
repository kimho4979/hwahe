<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
$(document).ready(function(){
	init();
});

function init(){
	var title = $(".half_title").text();
	var sessionId = '${SESSION_USER_ID}';
	
	$(".sub_list_ma_off").each( function(index) {
		if($(this).text() == title){
			$(this).attr('class','sub_list_ma_on');
			var titl
		}
	});

	if(title.indexOf("매뉴얼") != -1 ){
		$("#menu3, #menu6").attr('class','sub_title_ma_on');
	}else if(title.indexOf("소비동향") == -1 && title.indexOf("소매가격") == -1){
		$("#menu1, #menu4").attr('class','sub_title_ma_on');
	}else{
		$("#menu2, #menu5").attr('class','sub_title_ma_on');
	}
	
	if(title == '월간수급예측보고서' || title == '순별수급예측보고서' || title == '월간동향보고서' || title == '화훼 유사시장보고서' || title == '공지사항' || title == '행사일정관리'){
		$("#menu7, #menu8").attr('class','sub_title_ma_on');
	}else{
		$("#menu7, #menu8").attr('class','sub_title_ma_off');
	}
	
	if(title == '계량/비계량 설정' || title == '모니터요원 관리' || title ==  '정산내역' ){
		$("#menu9, #menu10").attr('class','sub_title_ma_on');
	}else{
		$("#menu9, #menu10").attr('class','sub_title_ma_off');
	}
	
	if(title == '연계현황조회' || title == '수동배치실행' || title == '연계관리'){
		$("#menu11, #menu12").attr('class','sub_title_ma_on');
	}else{
		$("#menu11, #menu12").attr('class','sub_title_ma_off');
	}
	
}

$("document").ready(function(){
	
	$(".navibar").click(function(){
		$(".nav_sub_m").show();
	});
	$(".closeBtn").click(function(){
		$(".nav_sub_m").hide();
	});
})
</script>
<div class="nav_sub_a"><!--서브 네비게이션시작-->
<img src="/images/hw/ma_img.jpg" alt="모니터요원입력화면" /><!--서브이미지-->
<nav>
<ul class="nav_sub_ma">
	<li><a href="/maa01/maa01.do"><span class="sub_title_ma_off" id="menu1">공지사항</span></a></li>
	<li class="subLi"><a href="/mcd01/mcd01.do"><span class="sub_list_ma_off">공지사항관리</span></a></li>
	<li class="subLi"><a href="/mcd01/mcd01.do"><span class="sub_list_ma_off">행사일정관리</span></a></li>

	<!-- <li class="subLi"><a href="/maa01/maa01.do"><span class="sub_list_ma_off">출하예정물량 입력</span></a></li> -->
	<!-- <li class="subLi"><a href="/maa02/maa02.do"><span class="sub_list_ma_off">출하물량 입력</span></a></li> -->
	<!-- <li class="subLi"><a href="/mab01/mab01.do"><span class="sub_list_ma_off">작황동향 입력</span></a></li> -->
	<!-- <li class="subLi"><a href="/mab02/mab02.do"><span class="sub_list_ma_off">작황동향 입력</span></a></li> -->
	<!-- <li class="subLi"><a href="/mac01/mac01.do"><span class="sub_list_ma_off">재배동향 입력</span></a></li> -->
</ul>


<ul class="nav_sub_ma">
	<li><a href="/mba01/mba01.do"><span class="sub_title_ma_off" id="menu2">소비정보입력</span></a></li>
	<li class="subLi"><a href="/mba01/mba01.do"><span class="sub_list_ma_off">소비동향 입력</span></a></li>
	<li class="subLi"><a href="/mbb01/mbb01.do"><span class="sub_list_ma_off">소매가격 입력</span></a></li>
</ul>
<c:choose>
	<c:when test="${SESSION_USER_ID == 'admin' || SESSION_USER_ID == 'at99999999'}">
		
		<ul class="nav_sub_ma">
			<li><a href="/mda01/mda01.do"><span class="sub_title_ma_off" id="menu9">정산정보 관리</span></a></li>
			<li class="subLi"><a href="/mda01/mda01.do"><span class="sub_list_ma_off">계량/비계량 설정</span></a></li>
			<li class="subLi"><a href="/mdb01/mdb01.do"><span class="sub_list_ma_off">모니터요원 관리</span></a></li>
			<li class="subLi"><a href="/mdc01/mdc01.do"><span class="sub_list_ma_off">정산내역</span></a></li>
		</ul>

		<ul class="nav_sub_ma">
			<li><a href="/mca01/mca01.do"><span class="sub_title_ma_off" id="menu7">게시판관리</span></a></li>
			<li class="subLi"><a href="/mcc02/mcc02.do"><span class="sub_list_ma_off">순별장미수급예측보고서</span></a></li>
			<li class="subLi"><a href="/mca01/mca01.do"><span class="sub_list_ma_off">월간장미수급예측보고서</span></a></li>
			<li class="subLi"><a href="/mcb01/mcb01.do"><span class="sub_list_ma_off">월간동향보고서</span></a></li>
			<li class="subLi"><a href="/mcc01/mcc01.do"><span class="sub_list_ma_off">화훼 유사시장보고서</span></a></li>
			<li class="subLi"><a href="/mcd01/mcd01.do"><span class="sub_list_ma_off">공지사항</span></a></li>
			<li class="subLi"><a href="/mce01/mce01.do"><span class="sub_list_ma_off">행사일정관리</span></a></li>
		</ul>
		
		<ul class="nav_sub_ma">
			<li><a href="/linkStatus/linkStatusCheck.do"><span class="sub_title_ma_off" id="menu11">연계관리</span></a></li>
			<li class="subLi"><a href="/linkStatus/linkStatusCheck.do"><span class="sub_list_ma_off">연계현황조회</span></a></li>
			<li class="subLi"><a href="/linkStatus/runManualBatch.do"><span class="sub_list_ma_off">수동배치실행</span></a></li>
		</ul>
	</c:when>
</c:choose>
<ul class="nav_sub_ma">
<li><a href="/cmmn/manual.do"><span class="sub_title_ma_off"  id="menu3">매뉴얼</span></a></li>
</ul>
</nav>
</div><!--서브 네비게이션끝-->

<!--  모바일 네비게이션  -->
	<div class="navibar"><a href="javascript:void(0);"><img class="" src="/images/hw/navibar.png" alt="네비게이션열기"/></a></div>
	<div class="nav_sub_m">
	
	<nav class="mbNav">
		<img src="/images/hw/ma_img.jpg" alt="모니터요원입력화면" /><!--서브이미지-->
		<ul class="nav_sub_ma">
			<li><a href="/maa01/maa01.do"><span class="sub_title_ma_off" id="menu4">생산정보입력</span></a></li>
			<li class="subLi"><a href="/maa01/maa01.do"><span class="sub_list_ma_off">출하예정물량 입력</span></a></li>
			<li class="subLi"><a href="/maa02/maa02.do"><span class="sub_list_ma_off">출하물량 입력</span></a></li>
			<!-- <li class="subLi"><a href="/mab01/mab01.do"><span class="sub_list_ma_off">작황동향 입력</span></a></li> -->
			<li class="subLi"><a href="/mab02/mab02.do"><span class="sub_list_ma_off">작황동향 입력</span></a></li>
			<li class="subLi"><a href="/mac01/mac01.do"><span class="sub_list_ma_off">재배동향 입력</span></a></li>
		</ul>
		<ul class="nav_sub_ma">
			<li><a href="/mba01/mba01.do"><span class="sub_title_ma_off" id="menu5">소비정보입력</span></a></li>
			<li class="subLi"><a href="/mba01/mba01.do"><span class="sub_list_ma_off">소비동향 입력</span></a></li>
			<li class="subLi"><a href="/mbb01/mbb01.do"><span class="sub_list_ma_off">소매가격 입력</span></a></li>
		</ul>
		<c:choose>
			<c:when test="${SESSION_USER_ID == 'admin' || SESSION_USER_ID == 'at99999999'}">
			
				<ul class="nav_sub_ma">
					<li><a href="/mda01/mda01.do"><span class="sub_title_ma_off" id="menu10">정산정보 관리</span></a></li>
					<li class="subLi"><a href="/mda01/mda01.do"><span class="sub_list_ma_off">계량/비계량 설정</span></a></li>
					<li class="subLi"><a href="/mdb01/mdb01.do"><span class="sub_list_ma_off">모니터요원 관리</span></a></li>
					<li class="subLi"><a href="/mdc01/mdc01.do"><span class="sub_list_ma_off">정산내역</span></a></li>
				</ul>
		
				<ul class="nav_sub_ma">
					<li><a href="/mca01/mca01.do"><span class="sub_title_ma_off" id="menu8">게시판관리</span></a></li>
					<li class="subLi"><a href="/mcc02/mcc02.do"><span class="sub_list_ma_off">순별장미수급예측보고서</span></a></li>
					<li class="subLi"><a href="/mca01/mca01.do"><span class="sub_list_ma_off">월별장미수급예측보고서</span></a></li>
					<li class="subLi"><a href="/mcb01/mcb01.do"><span class="sub_list_ma_off">월간동향보고서</span></a></li>
					<li class="subLi"><a href="/mcc01/mcc01.do"><span class="sub_list_ma_off">화훼 유사시장보고서</span></a></li>

					<li class="subLi"><a href="/mce01/mce01.do"><span class="sub_list_ma_off">행사일정관리</span></a></li>
				</ul>
				
				<ul class="nav_sub_ma">
					<li><a href="/linkStatus/linkStatusCheck.do"><span class="sub_title_ma_off" id="menu12">연계관리</span></a></li>
					<li class="subLi"><a href="/linkStatus/linkStatusCheck.do"><span class="sub_list_ma_off">연계현황조회</span></a></li>
					<li class="subLi"><a href="/linkStatus/runManualBatch.do"><span class="sub_list_ma_off">수동배치실행</span></a></li>
				</ul>
			</c:when>
		</c:choose>
		<ul class="nav_sub_ma">
			<li><a href="/cmmn/manual.do"><span class="sub_title_ma_off" id="menu6">매뉴얼</span></a></li>
		</ul>
		<p class="closeBtn"><a href="#"><img src="/images/hw/closeBtn.png" alt="닫기"/></a></p>
	</nav>
</div>

