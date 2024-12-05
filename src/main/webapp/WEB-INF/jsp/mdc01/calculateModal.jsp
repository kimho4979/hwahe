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
<title>모니터요원 정산내역 상세 </title>
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
<!-- rMateChartH5 테마 js -->
<script type="text/javascript" src="<c:url value='/rMateChart/rMateChartH5/Assets/Theme/theme.js' />"></script>
  
  
<script type="text/javascript">

var height = 0;
$(document).ready(function() {
	height = $(window.document.body).height();
	getDataTable();
}); 
	
	// 데이터 입력
	function getDataTable(){   
		var type = "${userInfo.MONITOR_TYPE}";
		var $frm = $("#calSearchFrm");
		$.ajax({
			type : 'post',
			url : "/mntr/mdc01/getDataTable.do",
			data : $frm.serialize() +"&USER_ID=" + "${param.USER_ID}" +"&MONITOR_TYPE=" + type,
			success : function(res){ 
				//console.log(res.list);
				if(res.error){
					alert(res.error.message);
				}else{
					$("#mdc01DataTable").html(res);
					funLoad();
					return false;
				}
	         	
			}
		});
	};
	
	// 높이변경 적용
	function funLoad(){
		var changeHeight = height + $("#mdc01DataTable").height() + 100;
		parent.modalResize(changeHeight);
    }
  
	// 인쇄하기
    function printMdc01(){
    	var objWin=null;
    	$("#btnEl").hide();
    	
    	var strFeature;
    	strFeature = "width=842,height=595,toolbar=no,location=no,directories=no";
    	strFeature += ",status=no,menubar=no,scrollbars=yes,resizable=no";
    	var data = $(window.document.body).html();
    	
    	objWin = window.open('', 'print', strFeature);
    	self.focus();
    	objWin.document.open();
    	objWin.document.write('<html><head>');
    	
    	objWin.document.write('<link rel="stylesheet" type="text/css" href="/css/hw/ma.css" />');
    	objWin.document.write('<link rel="stylesheet" type="text/css" href="/css/hw/common.css" />');
    	objWin.document.write('<style type="text/css">@page { size: landscape; }</style>');
    	objWin.document.write('</head><body>');
    	
    	objWin.document.write(data);
    	
    	objWin.document.write('</body></html>');
    	objWin.document.close();
    	
    	//console.log("objWin", objWin );
    	
    	window.setTimeout(function(){
    		objWin.print();
    		objWin.close();
    	}, 200);
    	$("#btnEl").show();
    }
	
</script>
</head>
<body>

<article>
<div>
	<div class="ma_content"><!--컨텐츠 내용들어가는곳 시작-->
		<div>
			<h4 class="hw_h3_ma_01" >모니터요원 정산내역 상세</h4> 
		</div>
		<div class="hw_infouse_01">
			<ul class="hw_list">
				<li>
					<span class="hw_item_search_title2">요원 아이디</span>
					<span>${userInfo.USER_ID }</span>
				</li>
				<li>
					<span class="hw_item_search_title2">요원명</span>
					<span>${userInfo.USER_NM }</span>
				</li>
				<li>
					<span class="hw_item_search_title2">이메일</span>
					<span>${userInfo.EMAIL }</span>
				</li>
				<li>
					<span class="hw_item_search_title2">휴대폰</span>
					<span>${userInfo.MOB }</span>
				</li>
				<li>
					<span class="hw_item_search_title2">계좌번호</span>
					<span>${userInfo.BANK_NUM }</span>
				</li>
				<li>
					<span class="hw_item_search_title2">요원 구분</span>
					<span>
						<c:if test="${userInfo.MONITOR_TYPE eq 'P'}">생산</c:if>
						<c:if test="${userInfo.MONITOR_TYPE eq 'C'}">소비</c:if>
						<c:if test="${userInfo.MONITOR_TYPE eq 'A'}">공통</c:if>
					</span>
				</li>
			</ul>
		</div>
		
		<div style="width:100%; margin: 10px 0px;">
			<div class="selectWrap mt10">
				<div class="shipment_schedule_all">
					<div style="margin-bottom:10px; margin-top:10px;">	
						<form name="calSearchFrm" id="calSearchFrm" method="post" onsubmit="return false;">
							<ul class="titList2">
								<li class="th">구분 :</li>
								<li class="td">
									<label class="blind" for="searchType">구분 선택</label>
									<select id="searchType" name="searchType" onchange="getDataTable();">
										<option value="">전체  </option>
										<option value="1">출하예정물량</option>
										<option value="2">출하물량</option>
										<option value="3">작황동향</option>
										<option value="4">재배동향</option>
										<option value="5">소비동향</option>
										<option value="6">소매가격</option>
									</select>
								</li>
								<li class="th">연도 :</li>
								<li class="td">
									<label class="blind" for="searchYear">연도 선택</label>
									<select id="searchYear" name="searchYear" onchange="getDataTable();">
										<c:forEach begin="${searchYear - 50 }" end="${searchYear + 5 }" varStatus="num" step="1" >
											<option value="${num.index }" <c:if test="${searchYear eq num.index}">selected="selected"</c:if>>${num.index }년</option>
										</c:forEach>
									</select>
								</li>
								<li class="th">월 :</li>
								<li class="td">
									<label class="blind" for="searchMonth">월 선택</label>
									<select id="searchMonth" name="searchMonth" onchange="getDataTable();">
										<option value="01" <c:if test="${searchMonth eq '01' }">selected="selected"</c:if>>01월</option>
										<option value="02" <c:if test="${searchMonth eq '02' }">selected="selected"</c:if>>02월</option>
										<option value="03" <c:if test="${searchMonth eq '03' }">selected="selected"</c:if>>03월</option>
										<option value="04" <c:if test="${searchMonth eq '04' }">selected="selected"</c:if>>04월</option>
										<option value="05" <c:if test="${searchMonth eq '05' }">selected="selected"</c:if>>05월</option>
										<option value="06" <c:if test="${searchMonth eq '06' }">selected="selected"</c:if>>06월</option>
										<option value="07" <c:if test="${searchMonth eq '07' }">selected="selected"</c:if>>07월</option>
										<option value="08" <c:if test="${searchMonth eq '08' }">selected="selected"</c:if>>08월</option>
										<option value="09" <c:if test="${searchMonth eq '09' }">selected="selected"</c:if>>09월</option>
										<option value="10" <c:if test="${searchMonth eq '10' }">selected="selected"</c:if>>10월</option>
										<option value="11" <c:if test="${searchMonth eq '11' }">selected="selected"</c:if>>11월</option>
										<option value="12" <c:if test="${searchMonth eq '12' }">selected="selected"</c:if>>12월</option>
									</select>
								</li>
							</ul>
						</form>
					</div>
				</div>
			</div>
		</div>

		<div id="mdc01DataTable" class="modalListWrap" style="margin-bottom: 20px;">
			&nbsp;
		</div><!--  modalListWrap end  -->
		<div class="hw_clear"></div>
		<div id="btnEl">
			<button type="button" class="ma_add_01" onclick="printMdc01();">인쇄하기</button>
		</div>
	</div>
</div>
</article>

</body>
</html>