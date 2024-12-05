<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!doctype html>
<html lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, user-scalable=no">
	<meta name="apple-mobile-web-app-title" content="화훼유통정보시스템">
	<meta name="robots" content="no-index,follow">
	<meta name="og:title" content="화훼유통정보시스템">
	<meta property="og:type" content="website">
	<meta name="og:description" content="화훼유통정보시스템">
	<meta name="description" content="화훼유통정보시스템">
	<meta name="content" content="화훼유통정보시스템 입니다.">
	<meta name="keywords" content="화훼경매시세, 화훼경매가격, Korea aT flower market auction price, 화훼공판장, 화훼거래정보, 꽃시장, 꽃값">
	<meta name="Author" content="화훼유통정보시스템 & www.woorim.co.kr : Kim Juyeon">
	<title>화훼유통정보시스템</title>
	
	<%@include file="../common/commonJs.jsp" %>	
	<%@include file="../common/commonCss.jsp" %>
	
<script type="text/javascript">
$(document).ready(function() {
	// cell merge
	$(".eventList colgroup col").each(function(col) {
		$(".eventList tbody").rowspan(col, false);
	});
	
});

/*
*
* 같은 값이 있는 열을 병합함
*
* 사용법 : $('#테이블 ID').rowspan(0);
*
*/
$.fn.rowspan = function(colIdx) {
	return this.each(function(){
		var that;
		var mon = 1;
		var oldMon = 1;
		   
		$('tr', this).each(function(row) {
			//console.log("tr :" + colIdx +", row: "+row, this);
		    var m1 = $(this).attr("class").split("mm")[1];
    	   //console.log("m1", m1);
       	   if(typeof m1 !== "undefined" && m1 != "") {
       		   mon = m1;
       	   }else{
       		   mon = oldMon;
       	   }
       	   
       	   var el1  = $('td, th',this).eq(colIdx).filter(':visible');
       	   //console.log("el1", el1.html());
	       	if (el1.html() !="&nbsp;" && el1.html() == $(that).html() && mon == oldMon) {
	       		rowspan = $(that).attr("rowSpan");
				if (rowspan == undefined) {
				  $(that).attr("rowSpan",1);
				  rowspan = $(that).attr("rowSpan");
				}
				rowspan = Number(rowspan)+1;
				$(that).attr("rowSpan",rowspan); // do your action for the colspan cell here
				el1.hide(); // .hide(); // do your action for the old cell here
				//console.log("ttt", el1);
	       	} else {
				that = el1;
			}
	       	that = (that == null) ? el1 : that; // set the that if not already set
	       	oldMon = mon;
       	 
		});

	});
};


function rowSpan(idx){
	
	$(".eventList tbody tr td:eq("+idx+")")
	
	
	$(".gubun").each(function () {
	    var rows = $(".gubun:contains('" + $(this).text() + "')");
	    if (rows.length > 1) {
	        rows.eq(0).attr("rowspan", rows.length);
	        rows.not(":eq(0)").remove();
	    }
	});	
}



function fctPrintInPopup()  {
	var objWin=null;
	var strFeature;
	strFeature = "width=842,height=595,toolbar=no,location=no,directories=no";
	strFeature += ",status=no,menubar=no,scrollbars=yes,resizable=no";
	var data = $("#printEl").html();
	
	objWin = window.open('', 'print', strFeature);
	self.focus();
	objWin.document.open();
	objWin.document.write('<html><head>');
	objWin.document.write('<link type="text/css" rel="stylesheet" href="/css/common.css">');
	objWin.document.write('<link type="text/css" rel="stylesheet" href="/css/sub.css">');
	objWin.document.write('<link type="text/css" rel="stylesheet" href="/css/media.css" media="(max-width:1155px)">');
	objWin.document.write('<style type="text/css">@page { size: landscape; }</style>');
	objWin.document.write('</head><body>');
	
	objWin.document.write('<div class="eventPopup" id="printEl">');
	objWin.document.write(data);
	objWin.document.write('</div>');
	
	objWin.document.write('</body></html>');
	objWin.document.close();
	
	window.setTimeout(function(){objWin.print();objWin.close();}, 200);
	
}



</script>


</head>
<body>
	<div class="eventPopup" id="printEl">
		<h1 class="eventTit">${searchYear } 년 화훼관련 행사 일정</h1><!-- eventTit end -->
		<table class="eventList" id="eventList">
			<caption>${searchYear } 년 화훼관련 행사 일정 리스트입니다.</caption>
			<colgroup>
				<!-- 월 -->
				<col style="width:5%;">
				<!-- 교회력 -->
				<col style="width:9%;">
				<col style="width:10%;">
				<!-- 불교 -->
				<col style="width:9%;">
				<col style="width:10%;">
				<!-- 전례력(성당) -->
				<col style="width:9%;">
				<col style="width:10%;">
				<!-- 주말길일 -->
				<col style="width:9%;">
				<col style="width:10%;">
				<!-- 기타행사 -->
				<col style="width:9%;">
				<col style="width:10%;">
			</colgroup>
			<thead>
				<tr>
					<th>월</th>
					<th colspan="2">교회력</th>
					<th colspan="2">불교</th>
					<th colspan="2">전례력(성당)</th>
					<th colspan="2">주말길일(결혼)</th>
					<th colspan="2">기타행사</th>
				</tr>
			</thead>
			<tbody>
				<c:set var="criNum" value="0"/>
				<c:set var="buNum" value="0"/>
				<c:set var="caNum" value="0"/>
				<c:set var="weekNum" value="0"/>
				<c:set var="etcNum" value="0"/>
				
				<c:forEach items="${dataRow }" var="row" varStatus="num">
					<c:if test="${row.CRI_CNT ne 0 }"><c:set var="criN1" value="${row.ROW_SPAN div row.CRI_CNT}"/></c:if>
					<c:if test="${row.BU_CNT ne 0 }"><c:set var="buN1" value="${row.ROW_SPAN div row.BU_CNT}"/></c:if>
					<c:if test="${row.CAT_CNT ne 0 }"><c:set var="caN1" value="${row.ROW_SPAN div row.CAT_CNT}"/></c:if>
					<c:if test="${row.WEEK_CNT ne 0 }"><c:set var="weN1" value="${row.ROW_SPAN div row.WEEK_CNT}"/></c:if>
					<c:if test="${row.ETC_CNT ne 0 }"><c:set var="etcN1" value="${row.ROW_SPAN div row.ETC_CNT}"/></c:if>
					
					<c:if test="${row.ROW_SPAN eq 0}"><c:set var="ROW_SPAN" value="0"/></c:if>
					<c:if test="${row.ROW_SPAN ne 0}"><c:set var="ROW_SPAN" value="${row.ROW_SPAN -1 }"/></c:if>
					<c:forEach begin="0" end="${ROW_SPAN }" varStatus="i">
						<tr class="mm${row.MM }">
							<th>${row.MM } 월</th>
							
							<%-- 교회력 --%>
							<c:if test="${row.CRI_CNT eq '0' }"><%-- 데이터 없을때 --%>
								<td >&nbsp;</td>
								<td >&nbsp;</td>
							</c:if>
							<c:if test="${row.CRI_CNT ne '0' }"><%-- 데이터 있을때 --%>
								<c:if test="${row.CRI_CNT eq row.ROW_SPAN}"><%-- 데이터 있으면서 크기 같을 때 --%>
									<td>${criData[criNum].E_DATE }</td>
									<td>${criData[criNum].EVENT_NM }</td>
									<c:set var="criNum" value="${criNum +1 }"/>
								</c:if>
								
								<c:if test="${row.CRI_CNT ne row.ROW_SPAN && row.ROW_SPAN >= i.index}"><%-- 데이터 있으면서 크기 다르면서 현재 월 데이터 뿌릴때 --%>
									<c:if test="${row.CRI_CNT eq i.index+1}">
										<td>${criData[criNum].E_DATE }</td>
										<td>${criData[criNum].EVENT_NM }</td>
									</c:if>
									<c:if test="${row.CRI_CNT ne i.index+1 and i.count mod criN1 ne 0 }">
										<td>${criData[criNum].E_DATE }</td>
										<td>${criData[criNum].EVENT_NM }</td>
									</c:if>
									<c:if test="${row.CRI_CNT ne i.index+1 and i.count mod criN1 eq 0 }">
										<td>${criData[criNum].E_DATE }</td>
										<td>${criData[criNum].EVENT_NM }</td>
										<c:set var="criNum" value="${criNum +1 }"/>
									</c:if>
									<c:if test="${i.count mod criN1 ne 0 and row.ROW_SPAN eq i.index+1 }">
										<c:set var="criNum" value="${criNum +1 }"/>
									</c:if>
								</c:if>
								<c:if test="${row.CRI_CNT ne row.ROW_SPAN && row.ROW_SPAN < i.index }"><%-- 데이터 있으면서 크기 다르면서 현재 월 데이터 다뿌리고 남았을때 --%>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
								</c:if>
							</c:if>
							
							<%-- 불교 --%>
							<c:if test="${row.BU_CNT eq '0'}">
								<td >&nbsp;</td>
								<td >&nbsp;</td>
							</c:if>
							<c:if test="${row.BU_CNT ne '0' }">
								<c:if test="${row.BU_CNT eq row.ROW_SPAN}">
									<td>${buData[buNum].E_DATE }</td>
									<td>${buData[buNum].EVENT_NM }</td>
									<c:set var="buNum" value="${buNum +1 }"/>
								</c:if>
								
								<c:if test="${row.BU_CNT ne row.ROW_SPAN && row.ROW_SPAN >= i.index}">
									<c:if test="${row.BU_CNT eq i.index+1}">
										<td>${buData[buNum].E_DATE }</td>
										<td>${buData[buNum].EVENT_NM }</td>
									</c:if>
									<c:if test="${row.BU_CNT ne i.index+1 and i.count mod buN1 ne 0 }">
										<td>${buData[buNum].E_DATE }</td>
										<td>${buData[buNum].EVENT_NM }</td>
									</c:if>
									<c:if test="${row.BU_CNT ne i.index+1 and i.count mod buN1 eq 0 }">
										<td>${buData[buNum].E_DATE }</td>
										<td>${buData[buNum].EVENT_NM }</td>
										<c:set var="buNum" value="${buNum +1 }"/>
									</c:if>
									<c:if test="${i.count mod buN1 ne 0 and row.ROW_SPAN eq i.index+1 }">
										<c:set var="buNum" value="${buNum +1 }"/>
									</c:if>
								</c:if>
								<c:if test="${row.BU_CNT ne row.ROW_SPAN && row.ROW_SPAN < i.index }">
									<td>&nbsp;</td>
									<td>&nbsp;</td>
								</c:if>
							</c:if>
							
							<%-- 전례력(성당) --%>
							<c:if test="${row.CAT_CNT eq '0'}">
								<td >&nbsp;</td>
								<td >&nbsp;</td>
							</c:if>
							<c:if test="${row.CAT_CNT ne '0' }">
								<c:if test="${row.CAT_CNT eq row.ROW_SPAN}">
									<td>${caData[caNum].E_DATE }</td>
									<td>${caData[caNum].EVENT_NM }</td>
									<c:set var="caNum" value="${caNum +1 }"/>
								</c:if>
								<c:if test="${row.CAT_CNT ne row.ROW_SPAN && row.ROW_SPAN >= i.index}">								
									<c:if test="${row.CAT_CNT eq i.index+1}">
										<td>${caData[caNum].E_DATE }</td>
										<td>${caData[caNum].EVENT_NM }</td>
									</c:if>									
									<c:if test="${row.CAT_CNT ne i.index+1 and i.count mod caN1 ne 0 }">
										<td>${caData[caNum].E_DATE }</td>
										<td>${caData[caNum].EVENT_NM }</td>
										<c:if test="${row.CAT_CNT < i.count and i.count div caN1 eq caN1}">
											<c:set var="caNum" value="${caNum +1 }"/>	
										</c:if>
									</c:if>
									<c:if test="${row.CAT_CNT ne i.index+1 and i.count mod caN1 eq 0 }">
										<td>${caData[caNum].E_DATE }</td>
										<td>${caData[caNum].EVENT_NM }</td>
										<c:set var="caNum" value="${caNum +1 }"/>
									</c:if>									
									<c:if test="${i.count mod caN1 ne 0 and row.ROW_SPAN eq i.index+1 }">
										<c:set var="caNum" value="${caNum +1 }"/>
									</c:if>
								</c:if>
								<c:if test="${row.CAT_CNT ne row.ROW_SPAN && row.ROW_SPAN < i.index }">
									<td>&nbsp;</td>
									<td>&nbsp;</td>
								</c:if>
							</c:if>	
							<!-- 
							2 4 0 1 2 17 1 1
							2 4 1 2 2 17 0 1
							2 4 2 3 2 17 1 2
							2 4 3 4 2 17 0 2
							 -->
							<%-- ${row.WEEK_CNT} || ${row.ROW_SPAN}|| ${i.index}||  ${i.count}||${weN1} ${weekNum}|| ${i.count mod weN1}|| ${i.count div weN1}, --%>
							<%-- 주말길일(결혼) --%>
							<c:if test="${row.WEEK_CNT eq '0'}">
								<td >&nbsp;</td>
								<td >&nbsp;</td>
							</c:if>
							<c:if test="${row.WEEK_CNT ne '0' }">
								<c:if test="${row.WEEK_CNT eq row.ROW_SPAN}">
									<td>${weekData[weekNum].E_DATE }</td>
									<td>${weekData[weekNum].EVENT_NM }</td>
									<c:set var="weekNum" value="${weekNum +1 }"/>
								</c:if>
								<c:if test="${row.WEEK_CNT ne row.ROW_SPAN && row.ROW_SPAN >= i.index}">
									<c:if test="${row.WEEK_CNT eq i.index+1}">
										<td>${weekData[weekNum].E_DATE }</td>
										<td>${weekData[weekNum].EVENT_NM }</td>
									</c:if>
									<c:if test="${row.WEEK_CNT ne i.index+1 and i.count mod weN1 ne 0 }">
										<td>${weekData[weekNum].E_DATE }</td>
										<td>${weekData[weekNum].EVENT_NM }</td>
										<c:if test="${row.WEEK_CNT < i.count and i.count div weN1 eq weN1}">
											<c:set var="weekNum" value="${weekNum +1 }"/>	
										</c:if>
									</c:if>
									<c:if test="${row.WEEK_CNT ne i.index+1 and i.count mod weN1 eq 0 }">
										<td>${weekData[weekNum].E_DATE }</td>
										<td>${weekData[weekNum].EVENT_NM }</td>
										<c:set var="weekNum" value="${weekNum +1 }"/>
									</c:if>
									<c:if test="${i.count mod weN1 ne 0 and row.ROW_SPAN eq i.index+1 }">
										<c:set var="weekNum" value="${weekNum +1 }"/>
									</c:if>
								</c:if>
								<c:if test="${row.WEEK_CNT ne row.ROW_SPAN && row.ROW_SPAN < i.index }">
									<td>&nbsp;</td>
									<td>&nbsp;</td>
								</c:if>
							</c:if>
							
							<%-- 기타행사 --%>
							<c:if test="${row.ETC_CNT eq '0'}">
								<td >&nbsp;</td>
								<td >&nbsp;</td>
							</c:if>
							<c:if test="${row.ETC_CNT ne '0' }">
								<c:if test="${row.ETC_CNT eq row.ROW_SPAN}">
									<td>${etcData[etcNum].E_DATE }</td>
									<td>${etcData[etcNum].EVENT_NM }</td>
									<c:set var="etcNum" value="${etcNum +1 }"/>
								</c:if>
								
								<c:if test="${row.ETC_CNT ne row.ROW_SPAN && row.ROW_SPAN >= i.index}">
									<c:if test="${i.count mod etcN1 ne 0 }">
										<td>${etcData[etcNum].E_DATE }</td>
										<td>${etcData[etcNum].EVENT_NM }</td>
									</c:if>
									<c:if test="${i.count mod etcN1 eq 0 }">
										<td>${etcData[etcNum].E_DATE }</td>
										<td>${etcData[etcNum].EVENT_NM }</td>
										<c:set var="etcNum" value="${etcNum +1 }"/>
									</c:if>
									<c:if test="${i.count mod etcN1 ne 0 and row.ROW_SPAN eq i.index+1 }">
										<c:set var="etcNum" value="${etcNum +1 }"/>
									</c:if>
								</c:if>
								<c:if test="${row.ETC_CNT ne row.ROW_SPAN && row.ROW_SPAN < i.index }">
									<td>&nbsp;</td>
									<td>&nbsp;</td>
								</c:if>
							</c:if>
						</tr>
					</c:forEach>
				</c:forEach>
			</tbody>
		</table><!-- eventList end-->
		<div class="btnWrap2">
			<button class="btn05 mr1p" type="button" onclick="fctPrintInPopup();">인쇄하기</button>
		</div>
	</div><!-- eventPopup end -->

</body>
</html>