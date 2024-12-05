<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
$(document).ready(function(){
	init();
});

function init(){
	var title = $(".half_title").text();
	var sessionId = '${SESSION_USER_ID}';
	var monitorType = '${SESSION_MONITOR_TYPE}';
	
	$(".sub_list_ma_off").each( function(index) {
		if($(this).text() == title){
			$(this).attr('class','sub_list_ma_on');
		}
	});
	/*
	if(title.indexOf("매뉴얼") != -1 ){
		$("#menu3, #menu6").attr('class','sub_title_ma_on');
	}else if(title.indexOf("소비동향") == -1 && title.indexOf("소매가격") == -1){
		$("#menu1, #menu4").attr('class','sub_title_ma_on');
	}else{
		$("#menu2, #menu5").attr('class','sub_title_ma_on');
	}
	*/
	
	if(title == '공지사항' || title == '행사일정관리'|| title == '고객상담실'){
		$("#menu7, #menu8").attr('class','sub_title_ma_on');
	}else{
		$("#menu7, #menu8").attr('class','sub_title_ma_off');
	}
	
	if(title == '계량/비계량 설정' || title == '모니터요원 관리' || title ==  '정산내역' || title == '발송이력관리'){
		$("#menu9, #menu10").attr('class','sub_title_ma_on');
	}else{
		$("#menu9, #menu10").attr('class','sub_title_ma_off');
	}
	
	if(title == '메뉴관리' || title == '그룹메뉴관리') {
		$("#menu13, #menu14").attr('class','sub_title_ma_on');
	}else{
		$("#menu13, #menu14").attr('class','sub_title_ma_off');
	}
	if(title =='그룹관리'){
		$("#menu9").attr('class','sub_title_ma_on');
	}else{
		$("#menu9").attr('class','sub_title_ma_off');
	}	
	if(title == '개방설정' || title == '공공데이터 신청조회' || title == '공공데이터 호출이력보기'||title =='지역별화훼사업체관리') {
		$("#menu15, #menu16").attr('class','sub_title_ma_on');
	}else{
		$("#menu15, #menu16").attr('class','sub_title_ma_off');
	}
	
	if(title == '품목코드 관리' || title == '전송 데이터 코드 관리') {
		$("#MS2").attr('class','sub_title_ma_on');
	}else{
		$("#MS2").attr('class','sub_title_ma_off');
	}
	
	if(title == 'SMS발송'||title == 'E-Mail발송') {
		$("#menu11").attr('class','sub_title_ma_on');
	}else{
		$("#menu11").attr('class','sub_title_ma_off');
	}
	if(title == '일일보고자료관리'||title == '일일보고자료발송관리') {
		$("#MS1").attr('class','sub_title_ma_on');
	}else{
		$("#MS1").attr('class','sub_title_ma_off');
	}
	if(title == '연계현황 조회' || title == '연계 시스템 LOG 관리' || title == '소프트 코딩' || title == '사용자 접근권한 설정'){
		$("#MS3").attr('class','sub_title_ma_on');
	}else{
		$("#MS3").attr('class','sub_title_ma_off');
	}
	if(title == '이미지 업로드' || title == '이미지 조회'){
		$("#menu23").attr('class','sub_title_ma_on');
	}else{
		$("#menu23").attr('class','sub_title_ma_off');
	}
	if(title == '재배현황 업로드'){
		$("#menu24").attr('class','sub_title_ma_on');
	}else{
		$("#menu24").attr('class','sub_title_ma_off');
	}
	if(title == 'Research페이지 접근제한 설정'){
		$("#menu25").attr('class','sub_title_ma_on');
	}else{
		$("#menu25").attr('class','sub_title_ma_off');
	}
	if(title == '매뉴얼'){
		$("#menu26").attr('class','sub_title_ma_on');
	}else{
		$("#menu26").attr('class','sub_title_ma_off');
	}
	

	
	if(sessionId!= 'admin' && sessionId != 'at99999999'){
		if(monitorType=='A'){
			// 공통
			$("#saleIdx2 li").each(function( index, value ) {
				if($(this).attr('class')=='subLi'){
					$(this).attr('class','subLi not');
					$(this).children().click(function () {return false;});
				}else{
					$(this).children().click(function () {return false;});
				}
			});
			
			$("#saleIdx4 li").each(function( index, value ) {
				if($(this).attr('class')=='subLi'){
					$(this).attr('class','subLi not');
					$(this).children().click(function () {return false;});
				}else{
					$(this).children().click(function () {return false;});
				}
			});
			
		}else if(monitorType=='P'){
			// 생산
			$("#saleIdx2 li").each(function( index, value ) {
				if($(this).attr('class')=='subLi'){
					$(this).attr('class','subLi not');
					$(this).children().click(function () {return false;});
				}else{
					$(this).children().click(function () {return false;});
				}
			});
			
			$("#saleIdx1 li").each(function( index, value ) {
				if(index> 2){
					$(this).attr('class','subLi not');
					$(this).children().click(function () {return false;});
				}
			});
			
			$("#saleIdx4 li").each(function( index, value ) {
				if($(this).attr('class')=='subLi'){
					$(this).attr('class','subLi not');
					$(this).children().click(function () {return false;});
				}else{
					$(this).children().click(function () {return false;});
				}
			});
			
			$("#saleIdx3 li").each(function( index, value ) {
				if(index> 2){
					$(this).attr('class','subLi not');
					$(this).children().click(function () {return false;});
				}
			});
			
		}else if(monitorType=='C'){
			// 소비
			$("#saleIdx1 li").each(function( index, value ) {
				if($(this).attr('class')=='subLi'){
					$(this).attr('class','subLi not');
					$(this).children().click(function () {return false;});
				}else{
					$(this).children().click(function () {return false;});
				}
			});
			
			$("#saleIdx3 li").each(function( index, value ) {
				if($(this).attr('class')=='subLi'){
					$(this).attr('class','subLi not');
					$(this).children().click(function () {return false;});
				}else{
					$(this).children().click(function () {return false;});
				}
			});
		}		
	}	
}

$("document").ready(function(){
	
	$(".navibar").click(function(){
		$(".nav_sub_m").show();
	});
	$(".closeBtn").click(function(){
		$(".nav_sub_m").hide();
	});

	$(".sub_list_ma_on").closest('a').css('pointer-events','none');


})
</script>
<div class="nav_sub_a" style="padding-bottom : 0px !important;"><!--서브 네비게이션시작-->
<img src="/images/hw/ma_img.jpg" alt="모니터요원입력화면" /><!--서브이미지-->
<nav>
<ul class="nav_sub_ma" id="saleIdx1">
	<li><a href=""><span class="sub_title_ma_off" id="menu1">공지사항</span></a></li>
	<li class="subLi"><a href="/mcd01/mcd01.do"><span class="sub_list_ma_off">공지사항관리</span></a></li>
	<li class="subLi"><a href="/mcd02/mcd02.do"><span class="sub_list_ma_off">행사일정관리</span></a></li>
	
	<!-- <li class="subLi"><a href="/maa01/maa01.do"><span class="sub_list_ma_off">출하예정물량 입력</span></a></li>
	<li class="subLi"><a href="/maa02/maa02.do"><span class="sub_list_ma_off">출하물량 입력</span></a></li>
	<li class="subLi"><a href="/mab01/mab01.do"><span class="sub_list_ma_off">작황동향 입력</span></a></li>
	<li class="subLi" style=""><a href="/mab02/mab02.do"><span class="sub_list_ma_off">작황동향 입력</span></a></li>
	<li class="subLi"><a href="/mac01/mac01.do"><span class="sub_list_ma_off">재배동향 입력</span></a></li> -->
</ul>
<ul class="nav_sub_ma" id="saleIdx2">
	<li><a href=""><span class="sub_title_ma_off" id="menu14">메뉴관리</span></a></li>
	<li class="subLi"><a href="/menuMgt/menuManageMent.do"><span class="sub_list_ma_off">메뉴관리</span></a></li>
	
	<!-- <li class="subLi"><a href="/mba01/mba01.do"><span class="sub_list_ma_off">소비동향 입력</span></a></li>
	<li class="subLi"><a href="/mbb01/mbb01.do"><span class="sub_list_ma_off">소매가격 입력</span></a></li> -->
</ul>
<c:choose>
	<c:when test="${SESSION_GRP_AUTH_CODE == 'M001'}">
		
		<ul class="nav_sub_ma">
			<li><a href=""><span class="sub_title_ma_off" id="menu9">사용자관리</span></a></li>
			<li class="subLi"><a href="/menuMgt/groupManageMent.do"><span class="sub_list_ma_off">그룹관리</span></a></li>
			
			<!-- <li class="subLi"><a href="/mda01/mda01.do"><span class="sub_list_ma_off">계량/비계량 설정</span></a></li>
			<li class="subLi"><a href="/mdb01/mdb01.do"><span class="sub_list_ma_off">모니터요원 관리</span></a></li>
			<li class="subLi"><a href="/mdc01/mdc01.do"><span class="sub_list_ma_off">정산내역</span></a></li>
			<li class="subLi"><a href="/mdc01/mdc02.do"><span class="sub_list_ma_off">정산마감관리</span></a></li>
			<li class="subLi"><a href="/mdc01/mdd01.do"><span class="sub_list_ma_off">발송이력관리</span></a></li> -->
		</ul>

		<ul class="nav_sub_ma">
			<li><a href=""><span class="sub_title_ma_off" id="menu15">공공데이터 관리</span></a></li>
			<li class="subLi"><a href="/apiMgt/apiOpenSetting.do"><span class="sub_list_ma_off">개방설정</span></a></li>
			<li class="subLi"><a href="/apiMgt/apiApply.do"><span class="sub_list_ma_off">공공데이터 신청조회</span></a></li>
			<li class="subLi"><a href="/apiMgt/apiLog.do"><span class="sub_list_ma_off">공공데이터 호출이력보기</span></a></li>
			<li class="subLi"><a href="/admin/flowerCompany.do"><span class="sub_list_ma_off">지역별화훼사업체관리</span></a></li>
			
			<!-- <li class="subLi"><a href="/mcc02/mcc02.do"><span class="sub_list_ma_off">순별장미수급예측보고서</span></a></li>
			<li class="subLi"><a href="/mca01/mca01.do"><span class="sub_list_ma_off">월간장미수급예측보고서</span></a></li>
			<li class="subLi"><a href="/mcb01/mcb01.do"><span class="sub_list_ma_off">월간동향보고서</span></a></li>
			<li class="subLi"><a href="/mcc01/mcc01.do"><span class="sub_list_ma_off">화훼 유사시장보고서</span></a></li>
			<li class="subLi"><a href="/mce01/mce01.do"><span class="sub_list_ma_off">행사일정관리</span></a></li>
			<li class="subLi"><a href="/mcf01/mcf01.do"><span class="sub_list_ma_off">고객상담실</span></a></li> -->
		</ul>
		
		<ul class="nav_sub_ma">
			<li><a href=""><span class="sub_title_ma_off" id="menu11">발송관리</span></a></li>
			<li class="subLi"><a href="/send/sendSms.do"><span class="sub_list_ma_off">SMS발송</span></a></li>
			<li class="subLi"><a href="/send/sendEmail.do"><span class="sub_list_ma_off">E-Mail발송</span></a></li>
		</ul>
		
		<ul class="nav_sub_ma">
			<li><a href=""><span class="sub_title_ma_off" id="MS1">일일보고</span></a></li>
			<li class="subLi"><a href="/dailyRptMgt/dailyRptMgt.do"><span class="sub_list_ma_off">일일보고자료관리</span></a></li>
			<li class="subLi"><a href="/dailyRptSend/dailyRptSend.do"><span class="sub_list_ma_off">일일보고자료발송관리</span></a></li>
		</ul>
		
		<ul class="nav_sub_ma">
			<li><a href=""><span class="sub_title_ma_off" id="MS2">코드관리</span></a></li>
			<li class="subLi"><a href="/codeMgt/pumCodeMgt.do"><span class="sub_list_ma_off">품목코드 관리</span></a></li>
			<li class="subLi"><a href="/code/saleCode.do"><span class="sub_list_ma_off">전송 데이터 코드 관리</span></a></li>
		</ul>
		
		<ul class="nav_sub_ma">
			<li><a href=""><span class="sub_title_ma_off" id="MS3">시스템관리</span></a></li>
			<li class="subLi"><a href="/linkStatus/linkStatusCheck.do"><span class="sub_list_ma_off">정산 연계현황 조회</span></a></li>
			<li class="subLi"><a href="/linkStatus/linkStatusLog.do"><span class="sub_list_ma_off">API연계시스템LOG관리</span></a></li>
			<li class="subLi"><a href="/linkStatus/runManualBatch.do"><span class="sub_list_ma_off">수동배치 실행</span></a></li>
			<li class="subLi"><a href="/admin/data/config.do"><span class="sub_list_ma_off">소프트코딩</span></a></li>
			<li class="subLi"><a href="/sys/menu/auth-config.do"><span class="sub_list_ma_off">농식품부자료접근제한</span></a></li>
		</ul>
	
		<ul class="nav_sub_ma">
			<li><a href=""><span class="sub_title_ma_off" id="menu23">이미지 관리</span></a></li>
			<li class="subLi"><a href="/admin/img/manage.do"><span class="sub_list_ma_off">이미지 업로드</span></a></li>
			<li class="subLi"><a href="/admin/img/getImgList.do"><span class="sub_list_ma_off">이미지 조회</span></a></li>
		</ul>
		<ul class="nav_sub_ma">
			<li><a href=""><span class="sub_title_ma_off" id="menu24">재배현황 관리</span></a></li>
			<li class="subLi"><a href="/admin/data/hga08manage.do"><span class="sub_list_ma_off">재배현황 업로드</span></a></li>
		</ul>
		<ul class="nav_sub_ma">
			<li><a href="/cmmn/userIp.do"><span class="sub_title_ma_off" id="menu25">리서치 접근설정</span></a></li>
		</ul>
		
	</c:when>
</c:choose>
<ul class="nav_sub_ma">
<li style="border-bottom:0px !important;"><a href="/cmmn/manual.do"><span class="sub_title_ma_off"  id="menu26" >매뉴얼</span></a></li>
</ul>
</nav>
</div><!--서브 네비게이션끝-->

<!--  모바일 네비게이션  -->
	<div class="navibar"><a href="javascript:void(0);"><img class="" src="/images/hw/navibar.png" alt="네비게이션열기"/></a></div>
	<div class="nav_sub_m">
	
	<nav class="mbNav">
		<img src="/images/hw/ma_img.jpg" alt="모니터요원입력화면" /><!--서브이미지-->
		<ul class="nav_sub_ma" id="saleIdx3">
			<li><a href=""><span class="sub_title_ma_off" id="menu4">공지사항</span></a></li>
			<li class="subLi"><a href="/mcd01/mcd01.do"><span class="sub_list_ma_off">공지사항관리</span></a></li>
			<li class="subLi"><a href="/mcd02/mcd02.do"><span class="sub_list_ma_off">행사일정관리</span></a></li>
			<!-- <li class="subLi"><a href="/maa01/maa01.do"><span class="sub_list_ma_off">출하예정물량 입력</span></a></li> -->
			<!-- <li class="subLi"><a href="/maa02/maa02.do"><span class="sub_list_ma_off">출하물량 입력</span></a></li> -->
			<!-- <li class="subLi"><a href="/mab01/mab01.do"><span class="sub_list_ma_off">작황동향 입력</span></a></li> -->
			<!-- <li class="subLi"><a href="/mab02/mab02.do"><span class="sub_list_ma_off">작황동향 입력</span></a></li> -->
			<!-- <li class="subLi"><a href="/mac01/mac01.do"><span class="sub_list_ma_off">재배동향 입력</span></a></li> -->
		</ul>
		<ul class="nav_sub_ma"  id="saleIdx4">
			<li><a href=""><span class="sub_title_ma_off" id="menu14">메뉴관리</span></a></li>
			<li class="subLi"><a href="/menuMgt/menuManageMent.do"><span class="sub_list_ma_off">메뉴관리</span></a></li>
			<!-- <li class="subLi"><a href="/mba01/mba01.do"><span class="sub_list_ma_off">소비동향 입력</span></a></li> -->
			<!-- <li class="subLi"><a href="/mbb01/mbb01.do"><span class="sub_list_ma_off">소매가격 입력</span></a></li> -->
		</ul>
		<c:choose>
			<c:when test="${SESSION_USER_ID == 'admin' || SESSION_USER_ID == 'at99999999'}">
			
				<ul class="nav_sub_ma">
					<li><a href=""><span class="sub_title_ma_off" id="menu10">사용자관리</span></a></li>
					<li class="subLi"><a href="/menuMgt/groupManageMent.do"><span class="sub_list_ma_off">그룹관리</span></a></li>
					<!-- <li class="subLi"><a href="/mda01/mda01.do"><span class="sub_list_ma_off">계량/비계량 설정</span></a></li> -->
					<!-- <li class="subLi"><a href="/mdb01/mdb01.do"><span class="sub_list_ma_off">모니터요원 관리</span></a></li> -->
					<!-- <li class="subLi"><a href="/mdc01/mdc01.do"><span class="sub_list_ma_off">정산내역</span></a></li> -->
					<!-- <li class="subLi"><a href="/mdc01/mdc02.do"><span class="sub_list_ma_off">정산마감관리</span></a></li> -->
					<!-- <li class="subLi"><a href="/mdc01/mdd01.do"><span class="sub_list_ma_off">발송이력관리</span></a></li> -->
				</ul>
		
				<ul class="nav_sub_ma">
			<li><a href=""><span class="sub_title_ma_off" id="menu15">공공데이터 관리</span></a></li>
					<li class="subLi"><a href="/apiMgt/apiOpenSetting.do"><span class="sub_list_ma_off">개방설정</span></a></li>
					<li class="subLi"><a href="/apiMgt/apiApply.do"><span class="sub_list_ma_off">공공데이터 신청조회</span></a></li>
					<li class="subLi"><a href="/apiMgt/apiLog.do"><span class="sub_list_ma_off">공공데이터 호출이력보기</span></a></li>
					<li class="subLi"><a href="/admin/flowerCompany.do"><span class="sub_list_ma_off">지역별화훼사업체관리</span></a></li>
					<!-- <li class="subLi"><a href="/mcc02/mcc02.do"><span class="sub_list_ma_off">순별장미수급예측보고서</span></a></li>
					<li class="subLi"><a href="/mca01/mca01.do"><span class="sub_list_ma_off">월간장미수급예측보고서</span></a></li>
					<li class="subLi"><a href="/mcb01/mcb01.do"><span class="sub_list_ma_off">월간동향보고서</span></a></li>
					<li class="subLi"><a href="/mcc01/mcc01.do"><span class="sub_list_ma_off">화훼 유사시장보고서</span></a></li>
					<li class="subLi"><a href="/mcd01/mcd01.do"><span class="sub_list_ma_off">공지사항</span></a></li>
					<li class="subLi"><a href="/mce01/mce01.do"><span class="sub_list_ma_off">행사일정관리</span></a></li>
					<li class="subLi"><a href="/mcf01/mcf01.do"><span class="sub_list_ma_off">고객상담실</span></a></li> -->
				</ul>
				
				<ul class="nav_sub_ma">
					<li><a href=""><span class="sub_title_ma_off" id="menu20">발송관리</span></a></li>
					<li class="subLi"><a href="/send/sendSms.do"><span class="sub_list_ma_off">SMS발송</span></a></li>
					<li class="subLi"><a href="/send/sendEmail.do"><span class="sub_list_ma_off">E-Mail발송</span></a></li>
				</ul>				
				<ul class="nav_sub_ma">
					<li><a href=""><span class="sub_title_ma_off" id="menu13">일일보고</span></a></li>
					<li class="subLi"><a href="/dailyRptMgt/dailyRptMgt.do"><span class="sub_list_ma_off">일일보고자료관리</span></a></li>
					<li class="subLi"><a href="/dailyRptSend/dailyRptSend.do"><span class="sub_list_ma_off">일일보고자료발송관리</span></a></li>
				</ul>
				<ul class="nav_sub_ma">
					<li><a href=""><span class="sub_title_ma_off" id="menu22">코드관리</span></a></li>
					<li class="subLi"><a href="/codeMgt/pumCodeMgt.do"><span class="sub_list_ma_off">품목코드 관리</span></a></li>
					<li class="subLi"><a href="/code/saleCode.do"><span class="sub_list_ma_off">전송데이터 코드관리</span></a></li>
				</ul>
				
				<ul class="nav_sub_ma">
					<li><a href=""><span class="sub_title_ma_off" id="menu16">시스템관리</span></a></li>
					<li class="subLi"><a href="/linkStatus/linkStatusCheck.do"><span class="sub_list_ma_off">정산 연계현황 조회</span></a></li>
					<li class="subLi"><a href="/linkStatus/linkStatusLog.do"><span class="sub_list_ma_off">API연계시스템LOG관리</span></a></li>
					<li class="subLi"><a href="/linkStatus/runManualBatch.do"><span class="sub_list_ma_off">수동배치 실행</span></a></li>
					<li class="subLi"><a href="/sys/menu/auth-config.do"><span class="sub_list_ma_off">농식품부자료접근제한</span></a></li>
				</ul>
				
				<ul class="nav_sub_ma">
					<li><a href=""><span class="sub_title_ma_off" id="menu23">이미지 관리</span></a></li>
					<li class="subLi"><a href="/admin/img/manage.do"><span class="sub_list_ma_off">이미지 업로드</span></a></li>
					<li class="subLi"><a href="/admin/img/getImgList.do"><span class="sub_list_ma_off">이미지 조회</span></a></li>
				</ul>
				
			</c:when>
		</c:choose>
		<ul class="nav_sub_ma">
			<li><a href="/cmmn/manual.do"><span class="sub_title_ma_off" id="menu6">매뉴얼</span></a></li>
		</ul>
		<p class="closeBtn"><a href="#"><img src="/images/hw/closeBtn.png" alt="닫기"/></a></p>
	</nav>
</div>

