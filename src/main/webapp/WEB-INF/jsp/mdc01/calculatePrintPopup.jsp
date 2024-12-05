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
	<title>화훼유통정보시스템 모니터요원 입력시스템 </title>
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
	
	<style type="text/css">
		.boxList { width:100%; border-top: 2px solid #1e6d52;}
		.boxList thead {}
		.boxList thead tr {  height:33px; border-bottom:1px solid #dadada; background-color:#f9f9f9;  }
		.boxList thead tr th { border-bottom:1px solid #dadada;line-height:34px; text-align:center; font-size:12px; font-weight: bold; }
		.boxList tbody {  }
		.boxList tbody tr { height:35px; border-bottom:1px solid #e3e3e3;  }
		.boxList tbody tr td {border-bottom:1px solid #dadada; line-height:34px;  text-align:center; font-size:12px;  white-space: nowrap; overflow: hidden; text-overflow: ellipsis;}
		.boxList tbody tr td span { font-size:12px; }
		
		@page a4sheet { size: 21.0cm 29.7cm }
    	.a4 { page: a4sheet; page-break-after: always }
    	
    	body {
		  -webkit-print-color-adjust: exact;
		}
	</style>

<script type="text/javascript">
var myProgress = new AXProgress();
var myGrid = new AXGrid();
//데이터 입력
function grid_ajax(pageNo){   
	if(pageNo == null || pageNo == "") pageNo = 1;
	
	var $frm = $("#calSearchFrm");
	$.ajax({
       type : 'post',
       url : "/mntr/mdc01/gridFullList.json",
       data : $frm.serialize(),
       success : function(res){ 
    	   if(res.error){
               alert(res.error.message);
           }else{
               totalData(res.list);
               var gridHeight = $(".AXgridScrollBody").height() + 200;
               $(".AXgridScrollBody").css("height", gridHeight);
               
               setTimeout(function() {
            	   window.focus();                                         
            	   window.print();
            	}, 1000);
               //self.close();
           }
       }
   });      	    
};


//생산에만 공통이 있다 -> 생산은 계량, 비계량 다 있음
//소비는 공통없음 -> 소비는 비계량만
function totalData(list){
	var proTotalCnt=0, proSumCnt=0, proKCnt=0, proNCnt=0, proKSum=0, proNSum=0, proTotalSum=0
	var sobiTotalCnt=0, sobiSumCnt=0, sobiNCnt=0, sobiNSum=0, sobiTotalSum=0
	var totalCnt=0, totalSumCnt=0, totalKSumCnt=0, totalNSumCnt=0, totalKSum=0, totalNSum=0, allTotalSum=0
	var tbodyHtml = "";
	for(var i=0;i<list.length;i++){
		var data = list[i];
		
		if(data.MONITOR_TYPE == "생산"){	// 생산
			proTotalCnt++;
			if(data.CNT1 != 0 || data.CNT2 != 0 ){
				proSumCnt++;
				proKCnt += data.CNT1;
				proNCnt += data.CNT2;
				proKSum += data.SUM1;
				proNSum += data.SUM2;
				proTotalSum += data.TOT_SUM;
			}
		}else if(data.MONITOR_TYPE == "소비"){		// 소비
			sobiTotalCnt++;
			if(data.CNT2 != 0 ){
				sobiSumCnt++;
				sobiNCnt += data.CNT2;
				sobiNSum += data.SUM2;
				sobiTotalSum += data.TOT_SUM;
			}
		}else if(data.MONITOR_TYPE == "공통"){		// 공통
			proTotalCnt++;
			if(data.CNT1 != 0 || data.CNT2 != 0 ){
				proSumCnt++;
				proKCnt += data.CNT1;
				proNCnt += data.CNT2;
				proKSum += data.SUM1;
				proNSum += data.SUM2;
				proTotalSum += data.TOT_SUM;
			}
		}
	}
	
	totalCnt = proTotalCnt + sobiTotalCnt;	// 합계총인원
	totalSumCnt = proSumCnt + sobiSumCnt;	// 합계참여인원
	totalKSumCnt = proKCnt;					// 합계 계량 개수 합
	totalNSumCnt = proNCnt + sobiNCnt;		// 합계 비계량 개수 합
	totalKSum = proKSum;					// 합계 계량 지급액 합
	totalNSum = proNSum + sobiNSum;			// 합계 비계량 지급액 합
	allTotalSum = proTotalSum + sobiTotalSum;	// 총 지급액 합
	
	tbodyHtml += '<tr>'
					+'<td>생상자 모니터요원</td><td>'+proTotalCnt+'</td><td>'+proSumCnt+'</td>'
					+'<td>'+proKCnt+'</td><td>'+proNCnt+'</td><td>'+proKSum+'</td><td>'+proNSum+'</td><td>'+proTotalSum+'</td>'
				+'</tr>';
	tbodyHtml += '<tr>'
					+'<td>소비자 모니터요원</td><td>'+sobiTotalCnt+'</td><td>'+sobiSumCnt+'</td>'
					+'<td>-</td><td>'+sobiNCnt+'</td><td>-</td><td>'+sobiNSum+'</td><td>'+sobiTotalSum+'</td>'
				+'</tr>';
	tbodyHtml += '<tr>'
					+'<td>합계</td><td>'+totalCnt+'</td><td>'+totalSumCnt+'</td>'
					+'<td>'+totalKSumCnt+'</td><td>'+totalNSumCnt+'</td><td>'+totalKSum+'</td><td>'+totalNSum+'</td><td>'+allTotalSum+'</td>'
				+'</tr>';
				
	$("#KCnt").text(proTotalCnt + "명");
	$("#NCnt").text(sobiTotalCnt + "명");
	
	$("#totalData").html(tbodyHtml);
}


//그리드 설정시작
var fnObj = {
	    pageStart: function(){
	    	grid_ajax();
	    }
	};

$(document).ready(fnObj.pageStart);

</script>
</head>
<body >
<article>
	<div class="a4,wrap">
		<div class="hw_content"><!--컨텐츠 내용들어가는곳 시작-->
			<h3 class="hw_h3_ma"><!-- <div class="half1_white"></div> --><span class="half_title">정산내역</span></h3>
			<div class="hw_clear"></div>
		
			<div class="hw_infouse_01">
				<p><span class="purple"> ◎ 정산정보 관리 :</span> 정산정보에 대한 지표 별 관리</p>
			</div>
			<div style="width:100%; margin: 10px 0px;">
				<div class="selectWrap mt10">
					<div class="shipment_schedule_all">
						<div style="margin-bottom:10px; margin-top:10px;">	
							<form name="calSearchFrm" id="calSearchFrm" method="post" onsubmit="return false;">
								<input type="hidden" name="searchWord" value="${searchFrm.searchWord }" />
								<input type="hidden" name="searchYear" value="${searchFrm.searchYear }" />
								<input type="hidden" name="searchMonth" value="${searchFrm.searchMonth }" />
								<ul class="titList2">
									<c:if test="${not empty searchFrm.searchWord }">
										<li class="th">대상 : ${searchFrm.searchWord }</li>	
									</c:if>
									<li class="th">대상년월 : ${searchFrm.searchYear }년 ${searchFrm.searchMonth }월</li>
								</ul>
							</form>
						</div>
					</div>
				</div>
			</div>
			<div class="hw_clear"></div>
			
			<div style="width:100%; margin: 10px 0px;">
				<table class="boxList" style="width: 100%;">
					<colgroup>
						<col width="15%">
						<col width="10%">
						<col width="10%">
						<col width="10%">
						<col width="10%">
						<col width="10%">
						<col width="10%">
						<col width="10%">
					</colgroup>
					<thead>
						<tr>
							<th rowspan="2">아이디</th>
							<th rowspan="2">모니터요원명</th>
							<th rowspan="2">구분</th>
							<th colspan="2">건수</th>
							<th colspan="2">누계(금액)</th>
							<th rowspan="2">총계</th>
							<th rowspan="2">계좌번호</th>
							<th rowspan="2">은행코드</th>
						</tr>
						<tr>
							<th>계량</th>
							<th>비계량</th>
							<th>계량(합)</th>
							<th>비계량(합)</th>
						</tr>
					</thead>
					<tbody id="monitorData">
						<c:forEach var="list" items="${list}" varStatus="status">
							<c:choose>
								<c:when test="${list.MONITOR_TYPE == '공통'}">
									<tr  style="background-color:yellow;">
								</c:when>
								<c:otherwise>
									<tr>
								</c:otherwise>
							</c:choose>
								<td>${list.USER_ID}</td>
								<td>${list.USER_NM}</td>
								<td>${list.MONITOR_TYPE}</td>
								<td>${list.CNT1}</td>
								<td>${list.CNT2}</td>
								<td>${list.SUM1}</td>
								<td>${list.SUM2}</td>
								<td>${list.TOT_SUM}</td>
								<td>${list.BANK_NUM}</td>
								<td>${list.BANK_CODE}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			
			
				<h4 style="float: right;">* <span style="background-color: yellow;">노란색 표시</span> : 계량, 비계량 공통</h4>
				<div class="hw_clear"></div>
				
				<h4 class="ma_title"> 모니터 요원 : 계량(<span id="KCnt">&nbsp;</span>), 비계량(<span id="NCnt">&nbsp;</span>)</h4>
				<table class="boxList" style="width: 100%;">
					<colgroup>
						<col width="15%">
						<col width="10%">
						<col width="10%">
						<col width="10%">
						<col width="10%">
						<col width="15%">
						<col width="15%">
						<col width="15%">
					</colgroup>
					<thead>
						<tr>
							<th rowspan="2">구분</th><th rowspan="2">총인원</th><th rowspan="2">참여인원</th><th colspan="2">건수</th><th colspan="3">지급액</th>
						</tr>
						<tr>
							<th>계량</th><th>비계량</th><th>계량</th><th>비계량</th><th>합계</th>
						</tr>
					</thead>
					<tbody id="totalData">
						<tr><td colspan="8">&nbsp;<td></tr>
					</tbody>
				</table>
			</div>
			
		</div>
		<!--// hw_content -->
	</div>
	<!--// wrap-->
</article>
</body>
</html>