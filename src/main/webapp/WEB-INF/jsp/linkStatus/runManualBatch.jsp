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
<title>모니터요원 입력시스템-수동배치 실행</title>
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


// function grid_ajax(){
// 	$.ajax({
// 		type : 'post',
// 		url : "/mntr/linkStatus/runManualBatchList.json",
// 		data : {},
// 		dataType : '',
// 		success : function(res){
// 			var val = res.list;
// 			myGrid.setList(val);
//
// 			for(var i=0; i<val.length; i++){
// 				if(val[i].uptDtFormat == 'YYYY-MM'){
// 					$('#inputDate'+val[i].jobId).bindDate({align:"right", valign:"bottom", separator:"-", selectType:"m",  defaultSelectType:"m"});
// 				}else{
// 					$('#inputDate'+val[i].jobId).bindDate({align:"right", valign:"bottom", separator:"-", selectType:"d",  defaultSelectType:"d"});
// 				}
// 			}
// 		}
// 	});
// };

//갱신실행
// function execute(jobId, fomat){
// 	var inputEl = $("#inputDate"+jobId);
// 	var dateStr = $("#inputDate"+jobId).val();
//
// 	// 날짜 입력이 있으면 형식체크
// 	if(inputEl.length != 0 ){
// 		var dayRegExp = null;
//
// 		if(fomat == "YYYY-MM-DD-HH"){
// 			dayRegExp = /^(19|20|21)\d{2}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[0-1])-(0[1-9]|1[0-9]|2[0-4])$/;
// 		}else if(fomat == "YYYY-MM-DD"){
// 			dayRegExp = /^(19|20|21)\d{2}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[0-1])$/;
// 		}else if(fomat == "YYYY-MM"){
// 			dayRegExp = /^(19|20|21)\d{2}-(0[1-9]|1[012])$/;
// 		}else if(fomat == "YYYY"){
// 			dayRegExp = /^(19|20|21)\d{2}$/;
// 		}
//
// 		if(dateStr == "" || !dayRegExp.test(dateStr)){
// 			alert("정상적인 일자 형식이 아닙니다.");
// 			$("#inputDate"+jobId).focus();
// 			return false;
// 		}
// 		dateStr = dateStr.replace(/-/gi, "");
// 	}
//
// 	if (!confirm('수동배치를 시작하시겠습니까?')) return false;
//
// 	$.ajax({
// 		type: "POST",
// 		url: "/dataUpdate/linkStatus/updateProc.json",
// 		data: {
// 			jobId : jobId,
// 			startDt : dateStr
// 		},
// 		success: function(res) {
// 			if(res.message==undefined){
// 				alert('API 서버 비실행');
// 			}else{
// 				alert(res.message);
// 				grid_ajax();
// 			}
// 		}
// 	});
// }
//
// var fnObj = {
//     pageStart: function(){
//     	grid_ajax();
//
// 		myGrid.setConfig({
// 			targetID : "AXGridTarget",
// 			theme : "AXGrid",
// 			fixedColSeq : '',
// 			fitToWidth:true,
// 			colGroup : [
// 				{key:"jobId", label:"연계ID", width:"80", align:"center", pk:true},
// 				{key:"jobNm", label:"연계명", width:"200", align:"center"},
// 				{key:"jobDetil", label:"연계상세", width:"80", align:"center", display:false},
// 				{key:"jobCycle", label:"연계주기", width:"400", align:"center"},
// 				{key:"input", label:"날짜입력", width:"170", align:"center", formatter: function(){
// 					if(this.item.uptDtFormat == null || this.item.uptDtFormat == '' ||  this.item.uptDtFormat == 'null'){
// 						return '';
// 					}else if(this.item.uptDtFormat != null || this.item.uptDtFormat != '' || this.item.uptDtFormat != 'null'){
// 						return '<input type="text" class="AXInput" id="inputDate'+this.item.jobId+'" value="" placeholder="'+this.item.uptDtFormat+'"/>';
// 					}
// 				}},
// 				{key:"button", label:"실행", width:"80", align:"center", formatter: function(){
// 					return '<input type="button" class="AXButton" id="btn'+this.item.jobId+'" value="실행" onclick="execute(\''+this.item.jobId+'\',\''+this.item.uptDtFormat+'\')"/>';
// 				}},
// 				{key:"jobType", label:"배치유형", width:"100", align:"center"},
// 				{key:"agency", label:"제공기관", width:"150", align:"center"},
// 				{key:"useTbNm", label:"사용 테이블명", width:"150", align:"center"},
// 				{key:"uptStat", label:"최종갱신상태", width:"100", align:"center"},
// 				{key:"uptDtFormat", label:"갱신날짜형식", width:"100", align:"center"},
// 				{key:"uptDt", label:"최종갱신일", width:"100", align:"center"}
// 			],
// 			colHeadAlign:"center",
//
// 			body : {
// 			    onclick: function(){},
// 			    ondblclick: function(){},
// 			    oncheck: function(){}
// 			},
// 			page:{
// 			    paging:false
// 			}
// 		});
//     }
// }
  
$(document).ready(function(){

});

selectText = [{
	atMartRealSchedule:"atMarketRealData에서 VV_RFLO 테이블을 현재시간으로 부터 10분 전까지 조회. 해당 쿼리의 결과 값을 SP_EPIS_MARTKET_JUNG 프로시저에 전달. 해당 프로시저는 T_REAL테이블에 INSERT를 수행. 인자로 .txt파일 명을 전달받으나 실제로 파일을 주고받는 것이 아닌 '파일명'문자열만 전달 받음. 해당 파일명에 기술된 날짜 텍스트를 추출하기 위해 사용.프로시저에서 INSERT할 데이터를 추출하기 위해 주 사용되는 v_RECORDTEXT 컬럼은 txt파일에서 추출한 값이 아니고 프로시저 실행할 때 전달되어진 인자 값임(쿼리ID:insertRealAt에서 전달).",
	atMartSchedule:"실행 순서대로 기재	1. startJobLog: 스케쥴러를 실행했다는 내용을 TB_JOB_LOG테이블에 INSERT함. LOG_SEQ컬럼을 통해 스케쥴러 실행 순서를 조회하기 위해 사용하는 것으로 추정됨…2. deleteTsaleAllByDate: T_SALE 테이블에서 3일 전 데이터만 지움.3. atMarketData:  VV_RFLO 테이블을 현재시간으로 부터 3일 전까지 조회.4. insertTsaleAT: 3번에서 조회한 3일 동안의 데이터를 T_SALE 테이블에 INSERT5. deleteSaleDate: T_SALE_DATE 테이블에서 3일 동안의 데이터를 삭제6. insertSaleDate: T_SALE 테이블에서 3일 동안의 데이터를 SELECT > T_SALE_DATE 테이블에 INSERT7. deleteSaleMonth: T_SALE_MONTH 테이블에서 3일 동안의 데이터를 삭제8. insertSaleMonth: T_SALE_DATE 테이블에서 당월 데이터 SELECT > T_SALE_MONTH 테이블에 INSERT9. deleteSaleRaw: T_INT_SALE_RAW.MAPPING_ID IN (T_INT_MAPPING.MAPPING_ID)에 해당하는 값들 중 3일 동안의 데이터를 삭제10. insertSaleRaw: V_DATA와 T_SALE 테이블을 조인(3일 동안의 데이터)하여 얻은 값을 T_INT_SALE_RAW에 INSERT. T_INT_MAPPING, T_INT_KIND 등의 테이블을 조인하여 더 여러 조건에 해당하는 데이터 값만 넣는 것 같은데 잘 모르겠음... 쿼리 복잡함.11. updateJobList: 함수 종료시각 저장",
	atMartYuchalSchedule:"1. deleteYuchal: TB_YUCHAL 테이블에서 3일 간 데이터를 DELETE	2. atMarketYuchalData: V_AUC_MNT 테이블에서 3일 간 유찰 건 수, 유찰률 데이터를 SELECT3. insertYuchal: 2번에서 가져온 데이터를 TB_YUCHAL 테이블에 INSERT",
	CustomInfoSchedule:"1. getSnsList: T_CUSTOMINFO, T_CUSTOMINFO, T_CUSTOMINFO_REAL 테이블에서 REAL_TIME 컬럼과 현재 시간이 일치하는 데이터를 SELECT 2. selectPumAvg: 고객에게 전달할 내용인 실시간 가격 정보를 T_REAL 테이블에서 SELECT 3. selectLvCdAvg: 고객에게 전달할 내용인 등급별 거래량/평균가 정보를 T_REAL, T_LEVEL테이블에서 SELECT 4. sendMail: 전달 방식이 Email인 경우 BIZ_MAIL 테이블에 INSERT 5. sendKakao: 전달 방식이 문자인 경우 BIZ_MSG 테이블에 INSERT",
	CustomMntSchedule:`'--조건 A: 년, 월과 무관하게 현재 일자가 1일 일 때 실행된다--1. deleteSso: T_SSO_LOGIN 테이블에서 모든 데이터 삭제 2. insertSso: T_USER, T_USER_AUTH 테이블에서 여러 요소 확인한 뒤(WHERE절 참조) 암호화한 user.id와, MOB, MONITER_TYPE을 T_SSO_LOGIN 테이블에 INSERT 3. selectSso: T_SSO_LOGIN 테이블에서 SSO_KEY, MOB, MONITER_TYPE컬럼을 SELECT 4. sendService(): 3번에서 조회한 결과 값을 참조하여 "모니터요원자료입력"의 내용을 작성한다.MONITER_TYPE = 'A'일 때는 "출하물량&출하예정물량&작황동향&재배동향"MONITER_TYPE = 'P'일 때는 "출하물량&출하예정물량"MONITER_TYPE = 'C'일 때는 "소비동향&소매가격"을 작성한다.MOB는 수신자의 userID이다.5. sendSms: 4에서 작성한 내용을 SMS(SMS로 보내는 것인지 불확실... sendSms의 'sms' 파라메터는 "LMS"라고 적혀있음. LMS라는 전송방식이 있는지 확인이 필요함)로 전달한다.'--조건 B: 년, 월과 무관하게 현재 일자가 29일 일 때 실행된다--* Scheduler는 1일 14일 24일에만 실행되기 때문에 해당 조건이 실행되는 경우는 없을 것으로 예상됨...*1. selectSso: 조건 A의 3번과 동일 2. sendService(): 조건 A의 4번과 동일'--조건 C: 조건 A, 조건 B에 해당하지 않을 때 실행된다--1. selectSso: 조건 A의 3번과 동일 2. sendService(): 조건 A의 4번과 동일`,
	Hab09UploadSchedule:`1. getDataCmpList: T_SALE_DATE 테이블에서 6일 전 ~ 1일 전 기간 동안 경매 건수가 0건인 공판장과 날자를 조회한다.
2. insertAucBbs: 1번에서 조회한 값을 TB_SALE_BBS 테이블에 INSERT`,
	MafraAvgSchedule:`1. selectCutFlowerCmpList: T_SALE_DATE 테이블에서 FLOWER_GUBN이 1인 CMP_CD 를 SELECT
2. selectYsDay: T_SALE_DATE 테이블에서 1번에서 조회한 CMP_CD 값을 가진 데이터 중 요일이 월, 수, 금에 속하는 날짜 중 가장 최신 날짜(SALE_DATE)를 SELECT

--조건 A: cmpCD가 "0000000001"인 경우--
 1. seletInsertAvgPreYearAt: T_SALE 테이블에서 작년 1월 1일 부터 12월 31일까지의 PUM_NAME별 평균 가격을 계산하여 T_SALE_PREYEAR 테이블에 INSERT.(전년도 평균)
 2. seletInsertAvgYearAt: T_SALE 테이블에서 5년 전 1월 1일 부터 1년전 12월 31일까지의 PUM_NAME별 평균 가격을 계산하여 T_SALE_AVGYEAR 테이블에 INSERT.(평년 평균)
 3. selectInsertPreDayAt: T_SALE, TB_YUCHAL 테이블에서 작년 1월 1일부터 12월 31일까지의 PUM_NAME별 평균 가격, 유찰을 계산하여 T_SALE_PREDAY 테이블에 INSERT(전년도 물량, 유찰물량, 평균가)
 4. selectInsertAvgDayAt: T_SALE, TB_YUCHAL 테이블에서 5년 전 1월 1일 부터 1년 전 12월 31일까지의 PUM_NAME별 평균 가격, 유찰을 계산하여 T_SALE_PREDAY 테이블에 INSERT(전년도 물량, 유찰물량, 평균가)
--조건 B: 조건 A에 해당하지 않는 경우--
 1. seletInsertAvgPreYearAll: 조건 A의 1번과 동일
 2. seletInsertAvgYearAll: 조건 A의 2번과 동일`,
	ReportDataInsertSchedule : `1. insertDayPumAucAt: 오늘 날짜를 기준으로 T_SALE 테이블에서 거래 총 액을 계산, TB_YUCHAL 테이블에서 유찰률을 계산, T_SALE_DATE에서 평균 단가를 계산하여 T_DAY_PUM_AUC 테이블에 INSERT
	--조건 A: cmpCD가 "0000000001"인 경우--
1. insertMainFlowerAucAt: 오늘 날짜를 기준으로 T_SALE_AVG_YEAR 테이블에서 평균 금액을 계산, T_SALE_PREYEAR 테이블에서 평균 금액을 계산, T_SALE에서 해당되는 분기의 평균 금액을 계산하여 T_MAIN_FLOWER_AUC 테이블에 INSERT
--조건 B: 조건 A에 해당하지 않는 경우--
1. insertMainFlowerAucAll: 조건 A의 1번과 동일
(단, INSERT_TIME은 7로 설정한다.)
(단, INSERT_TIME은 7로 설정한다.)`
}];

function submitJob(){
	let cronJobId = $("#cronJobId").val();
	if(cronJobId == 'ReportDataInsertSchedule'){
		let subMenu1 = $("#cronJobSubMenu1").val();
		let subMenu2 = $("#cronJobSubMenu2").val();
		if(subMenu1 == 'insertDayPumAucAt'){
			cronJobId = subMenu2 == 7?'dayPumScheduleRun1':'dayPumScheduleRun2';
		}else{
			cronJobId = subMenu2 == 7?'mainFlowerScheduleRun1':'mainFlowerScheduleRun2';
		}
	}
	console.log(cronJobId);
	$.ajax({
		type: "GET",
		url: "/dataUpdate/linkStatus/cronJobManual.json",
		data: {"cronJobId":cronJobId},
		success: function(res) {
			alert(res);
			console.log(res);
		}
	});

}
function fnSelect(el){
	let textareaVal = $(el).val();
	$("#jobText").val(selectText[0][textareaVal]);
	if(textareaVal == 'ReportDataInsertSchedule'){
		$("#cronJobSubMenu1").show();
	}
}
function subMenuSelect(){
	$("#cronJobSubMenu2").show();
}
</script>
   
</head>
<body>
<%@ include file="/WEB-INF/inc/IncHeader.jsp" %>
<article>
<div class="wrap">

	<%@ include file="/WEB-INF/jsp/inc/IncMenu.jsp" %>

	<div class="hw_content"><!--컨텐츠 내용들어가는곳 시작-->
	
		<h3 class="hw_h3_ma"><span class="half_title">수동배치 실행</span></h3>
		<div class="hw_clear"></div>	
			
		<div class="hw_infouse_01">  <p> <span class="purple"> ◎ 이용안내 :</span> 글을 작성하시려면 등록하기를 누르셔서 작성하시면 됩니다.</p></div>
		<div class="hw_clear"></div>	
						
		<div style="margin-top:20px; margin-bottom:10px;display: flex">
			<div style="flex-grow: 1;float: left">
				<div style="width: 100%; margin-bottom: 10px">
				<select onchange="fnSelect(this);" id="cronJobId">
					<option value="atMartRealSchedule" selected>atMartRealSchedule</option>
					<option value="atMartSchedule">atMartSchedule</option>
					<option value="atMartYuchalSchedule">atMartYuchalSchedule</option>
					<option value="CustomInfoSchedule">CustomInfoSchedule</option>
					<option value="CustomMntSchedule">CustomMntSchedule</option>
					<option value="Hab09UploadSchedule">Hab09UploadSchedule</option>
					<option value="MafraAvgSchedule.java">MafraAvgSchedule</option>
					<option value="ReportDataInsertSchedule">ReportDataInsertSchedule</option>
				</select>
					<select style="display: none" id="cronJobSubMenu1" onchange="subMenuSelect();">
						<option selected>선택</option>
						<option value="insertDayPumAucAt">insertDayPumAucAt</option>
						<option value="insertMainFlowerAucAt">insertMainFlowerAucAt</option>
					</select>
					<select style="display: none" id="cronJobSubMenu2">
						<option selected>선택</option>
						<option value="7">InsertTime: 7</option>
						<option value="13">InsertTime: 13</option>
					</select>
					<button id="cronJobButton" onclick="submitJob();" style="border: 1px solid black"><label for="cronJobButton" style="cursor:pointer">배치 실행</label></button>
				</div>
				<div>
					<textarea id="jobText" rows="10" cols="100">
atMarketRealData에서 VV_RFLO 테이블을 현재시간으로 부터 10분 전까지 조회. 해당 쿼리의 결과 값을 SP_EPIS_MARTKET_JUNG 프로시저에 전달. 해당 프로시저는 T_REAL테이블에 INSERT를 수행. 인자로 .txt파일 명을 전달받으나 실제로 파일을 주고받는 것이 아닌 '파일명'문자열만 전달 받음. 해당 파일명에 기술된 날짜 텍스트를 추출하기 위해 사용.프로시저에서 INSERT할 데이터를 추출하기 위해 주 사용되는 v_RECORDTEXT 컬럼은 txt파일에서 추출한 값이 아니고 프로시저 실행할 때 전달되어진 인자 값임(쿼리ID:insertRealAt에서 전달).
					</textarea>
				</div>

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