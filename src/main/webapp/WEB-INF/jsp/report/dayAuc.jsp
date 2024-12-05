<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head> 
	<meta charset="utf-8">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, user-scalable=no">
	<meta name="apple-mobile-web-app-title" content="화훼유통정보시스템">
	<meta name="robots" content="no-index,follow">
	<meta name="og:title" content="화훼유통정보시스템">
	<meta name="og:description" content="화훼유통정보시스템">
	<meta name="description" content="일별 경매실적">
	<meta name="content" content="화훼유통정보시스템 입니다.">
	<meta name="keywords" content="화훼경매시세, 화훼경매가격, Korea aT flower market auction price, 화훼공판장, 화훼거래정보, 꽃시장, 꽃값">
	<meta name="Author" content="화훼유통정보시스템 & www.woorim.co.kr">
	<title>일별 경매실적</title>
	<%@include file="../common/2020/commonJs.jsp" %>
	<%@include file="../common/2020/commonCss.jsp" %>
	
	<style>
		#progress_loading {position: absolute; left: 50%; background: #ffffff; text-align: center;}
	</style>
  
	<script type="text/javascript">
	
		$(document).ready(function(){
			$('#progress_loading').hide();
			
			$("#searchYear").bindDate({align:"right", valign:"bottom", separator:"-", selectType:"y",  defaultSelectType:"y", value:"",
				onchange:function(){
					var searchFlag = dateChkend();
					if(searchFlag == true){
						cmpCd = $("#cmpCdTab .on > input").attr("value");
						flowerCd = $("#flowerTab .on > input").attr("value");
						searchSaleDate = $("#searchEndDate").val();
					
					}else{
		       			alert("금년까지 선택이 가능합니다.")
		       		}
				}
			});

			$(".excelBtn1").empty();
			$(".excelBtn1").append('<a href="javascript:void(0);" id="exportBtn1" name="exportTable1" onclick="excelExport();"><img src="../images/2020/exel.png" alt="엑셀이미지">엑셀저장</a>');
			
			fn_search();
		})
		.ajaxStart(function() {
			$('#progress_loading').show();
		})
		.ajaxStop(function() {
			$('#progress_loading').hide();
		});
		
		function dateChkend(){
			
		    var searchGoFlag = false;
			var selectDate = $("#searchYear").val().replace(/-/gi, "");
			var today = new Date();
			
			var yy= today.getFullYear();
			today = yy;
			
			if(selectDate <= today){
				searchGoFlag = true;
			}
			
			return searchGoFlag;
		}

		
		function fn_search() {
			var pumName = $('#pumName option:selected').val();
			var searchYear = $("#searchYear").val();
			
			$.ajax({
				type:'post'
			,	url : "/report/selectDayAuc.json"
			,	data : {
					pumName : pumName
				,	searchYear : searchYear
				}
			,	dataType : ''
			,	success : function(res){
					var html = "";
					
					if(res.list.length > 0){
						for(var i=0;i<res.list.length;i++){
							html += "<tr>";
							html +=		"<td class='tc'>" + res.list[i].mmdd + "</td>";
							html += 	"<td class='tr'>" + res.list[i].totCnt.toLocaleString('ko-KR') + "</td>";
							html +=		"<td class='tr'>" + res.list[i].panCnt.toLocaleString('ko-KR') + "</td>";
							html +=		"<td class='tr'>" + res.list[i].yuchalCnt.toLocaleString('ko-KR') + "</td>";
							html +=		"<td class='tr'>" + res.list[i].avgAmt.toLocaleString('ko-KR') + "</td>";
							html +=		"<td class='tr'>" + res.list[i].preTotCnt.toLocaleString('ko-KR') + "</td>";
							html +=		"<td class='tr'>" + res.list[i].prePanCnt.toLocaleString('ko-KR') + "</td>";
							html +=		"<td class='tr'>" + res.list[i].preYuchalCnt.toLocaleString('ko-KR') + "</td>";
							html +=		"<td class='tr'>" + res.list[i].preAvgAmt.toLocaleString('ko-KR') + "</td>";
							html +=		"<td class='tr'>" + res.list[i].preTotCntPer.toLocaleString('ko-KR') + "</td>";
							html +=		"<td class='tr'>" + res.list[i].prePanCntPer.toLocaleString('ko-KR') + "</td>";
							html +=		"<td class='tr'>" + res.list[i].preYuchalCntPer.toLocaleString('ko-KR') + "</td>";
							html +=		"<td class='tr'>" + res.list[i].preAvgAmtPer.toLocaleString('ko-KR') + "</td>";
							html += 	"<td class='tr'>" + res.list[i].avgTotCnt.toLocaleString('ko-KR') + "</td>";
							html +=		"<td class='tr'>" + res.list[i].avgPanCnt.toLocaleString('ko-KR') + "</td>";
							html +=		"<td class='tr'>" + res.list[i].avgYuchalCnt.toLocaleString('ko-KR') + "</td>";
							html +=		"<td class='tr'>" + res.list[i].avgAvgAmt.toLocaleString('ko-KR') + "</td>";
							html += 	"<td class='tr'>" + res.list[i].avgTotCntPer.toLocaleString('ko-KR') + "</td>";
							html +=		"<td class='tr'>" + res.list[i].avgPanCntPer.toLocaleString('ko-KR') + "</td>";
							html +=		"<td class='tr'>" + res.list[i].avgYuchalCntPer.toLocaleString('ko-KR') + "</td>";
							html +=		"<td class='tr'>" + res.list[i].avgAvgAmtPer.toLocaleString('ko-KR') + "</td>";
							html += "</tr>";
						}
					}else {
						html += "<tr><td class='tc' colspan='21'>데이터가 없습니다.</td></tr>";
					}
					
					$("#resultList").html(html);
				}
			});
		}

		// 엑셀 다운로드
		function excelExport(){
			$("#excelForm > input[name='searchYear']").val($("#searchYear").prop("value"));
			$("#excelForm").submit();
		}
		
		
		$(function () {
			// divBodyScroll의 스크롤이 동작할때에 함수를 불러옵니다.
			$('#divBodyScroll').scroll(function () {
				// divBodyScroll의 x좌표가 움직인 거리를 가져옵니다.
				var xPoint = $('#divBodyScroll').scrollLeft();

				// 가져온 x좌표를 divHeadScroll에 적용시켜 같이 움직일수 있도록 합니다.
				$('#divHeadScroll').scrollLeft(xPoint);
			});
		});
	</script>
</head>


<body>

	<!--WRAP(S)-->
	<div class="wrap">

		<jsp:include page="../inc/2020/IncHeader.jsp"/>
		
		<!--서브 헤더 (S)-->
		<div class="lnb_box">
			<ul>
				<li><img src="../images/2020/m_lnb_img.png" alt="집"></li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li>공공데이터</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li>농식품부 보고자료</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li class="m_right">일별 경매실적</li>
			</ul>
		</div>
		<!--sub 헤더 (E)-->
		
		<!--서브 타이틀(S)-->
		<div class="sub_title">		
			<div class="title_box">
				<h2>일별 경매실적 (양재 화훼공판장)</h2>
				<img src="../images/2020/sub/t_line.png" alt="방울점선">
			</div>
		</div>
		<!--서브 타이틀(E)-->
		
		<!--콘텐츠_메인(S)-->
		<div class="sub_contents">	
			<!-- 검색창(S) -->
			<div class="search_box_s">
				<div class="search_01">
					<ul class="search_box01">
						<li class="calendar">
							<p class="search_01_txt">조회연도</p>
							<input type="text" class="datepicker except" name="searchYear" id="searchYear" value="${searchYear}"/>
						</li>
						
						<li id="pumSelectbox">
							<p class="search_01_txt">품목</p>
							<select id="pumName" name="pumName" class="form-control except">
								<option value="절화류">절화류(전체)</option>
								<option value="장미">장미</option>
								<option value="국화">국화</option>
								<option value="백합">백합</option>
								<option value="리시안사스">리시안사스</option>
								<option value="카네이션">카네이션</option>
								<option value="거베라">거베라</option>
								<option value="수국">수국</option>
								<option value="작약">작약</option>
								<option value="프리지아">프리지아</option>
								<option value="튜립">튜립</option>
								<option value="안개">안개</option>
								<option value="금어초">금어초</option>
								<option value="국화(대국)">국화(대국)</option>
								<option value="거베라(거베라)">거베라(거베라)</option>
							</select>
						</li>
						<li class="search_btn">
							<button type="button" class="btn_search" onclick="fn_search();">검색</button>
						</li>
					</ul>
				</div>
			</div>
			<!-- 검색창(E) -->
			
			<!-- 로딩바(S) -->
			<div id="progress_loading">
				<img src="../../images/loadingBar.gif"/>
			</div>
			<!-- 로딩바(E) -->
			<div style='float: right; margin-bottom: 10px;'>
				<span>(단위 물량:단(속), 단가:원, 증감:%)</span>
			</div>
			<!-- 테이블(S) -->
			<table id="tblBackground" class="scroll-table-01">
				<tr>
					<td>
						<div id="divHeadScroll">
							<table id="tblHead" class="table_type_01 btg tiny">
								<colgroup>
									<col style="width:100px;" />
									<col style="width:100px;" />
									<col style="width:100px;" />
									<col style="width:100px;" />
									<col style="width:100px;" />
									<col style="width:100px;" />
									<col style="width:100px;" />
									<col style="width:100px;" />
									<col style="width:100px;" />
									<col style="width:100px;" />
									<col style="width:100px;" />
									<col style="width:100px;" />
									<col style="width:100px;" />
									<col style="width:100px;" />
									<col style="width:100px;" />
									<col style="width:100px;" />
									<col style="width:100px;" />
									<col style="width:100px;" />
									<col style="width:100px;" />
									<col style="width:100px;" />
									<col style="width:117px;" />
								</colgroup>
								<thead>
								<tr>
									<th>경매일자</th>
									<th>금년출하물량</th>
									<th>금년거래물량</th>
									<th>금년유찰물량</th>
									<th>금년단가</th>
									<th>전년출하물량</th>
									<th>전년거래물량</th>
									<th>전년유찰물량</th>
									<th>전년단가</th>
									<th>출하량증감</th>
									<th>거래량증감</th>
									<th>유찰증감</th>
									<th>단가증감</th>
									<th>평년출하물량</th>
									<th>평년거래물량</th>
									<th>평년유찰물량</th>
									<th>평년단가</th>
									<th>출하량증감</th>
									<th>거래량증감</th>
									<th>유찰증감</th>
									<th>단가증감</th>
								</tr>
								</thead>
							</table>
						</div>
						<div id="divBodyScroll">
							<table id="tblBody"  class="table_type_01 body tiny">
								<colgroup>
									<col style="width:100px;" />
									<col style="width:100px;" />
									<col style="width:100px;" />
									<col style="width:100px;" />
									<col style="width:100px;" />
									<col style="width:100px;" />
									<col style="width:100px;" />
									<col style="width:100px;" />
									<col style="width:100px;" />
									<col style="width:100px;" />
									<col style="width:100px;" />
									<col style="width:100px;" />
									<col style="width:100px;" />
									<col style="width:100px;" />
									<col style="width:100px;" />
									<col style="width:100px;" />
									<col style="width:100px;" />
									<col style="width:100px;" />
									<col style="width:100px;" />
									<col style="width:100px;" />
									<col style="width:100px;" />
								</colgroup>
									<tbody id="resultList">
									</tbody>
								</table>
						</div>
					</td>
				</tr>
			</table>
			<!-- 테이블(E) -->	
			
			<!-- 버튼박스(S) -->
			<div class="dwn_bt_b excelBtn1">
				<a href="#!">엑셀저장</a>
			</div>
			<!-- 버튼박스(E) -->

		</div>
		<!--콘텐츠_메인(E)-->
	
		<jsp:include page="../inc/2020/IncFooter.jsp"/>	
		
		<form id="excelForm" action="/report/excel.do" method="post">
			<input type="hidden" name="searchYear"/>
		</form>

	</div>		
	<!--WRAP(E)-->		

</body>
</html>