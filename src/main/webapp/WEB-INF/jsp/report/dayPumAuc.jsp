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
	<meta name="description" content="일별 품목별 경매실적 및 동향">
	<meta name="content" content="화훼유통정보시스템 입니다.">
	<meta name="keywords" content="화훼경매시세, 화훼경매가격, Korea aT flower market auction price, 화훼공판장, 화훼거래정보, 꽃시장, 꽃값">
	<meta name="Author" content="화훼유통정보시스템 & www.woorim.co.kr">
	<title>일별 품목별 경매실적 및 동향</title>
	<%@include file="../common/2020/commonJs.jsp" %>
	<%@include file="../common/2020/commonCss.jsp" %>
	
	<style>
		#progress_loading {position: absolute; left: 50%; background: #ffffff; text-align: center;}
	</style>
  
	<script type="text/javascript">
	
		$(document).ready(function(){
			$('#progress_loading').hide();
			// 검색 selectbox
			$('#itemCd').select2();
			// 품목 선택
			getIntItemList();
			
			$("#searchStrDate").datepicker({
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
				beforeShowDay:datechktoday,
				yearSuffix: '년',
				changeMonth: true,
				changeYear: true,
				onSelect: function(){
					dateChkstr();
					getIntItemList();
				}
			});
	
			$("#searchEndDate").datepicker({
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
				beforeShowDay:datechktoday,
				yearSuffix: '년',
				changeMonth: true,
				changeYear: true,
				onSelect: function(){
					var begins=$("#searchEndDate").val();
					var begindate=month_sample(begins,12);
					$("#searchStrDate").datepicker("change",{minDate: begindate });
	
					dateChkend();
					getIntItemList();
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
		
		
		//품목 검색 (일자별)
		function getIntItemList() {
			if($("input:checkbox[id='hwahwanYn']").is(":checked") == true) {
				$("input:checkbox[id='hwahwanYn']").val('Y');    
		    } else {
		    	$("input:checkbox[id='hwahwanYn']").val('N');  
		    }   
			var hwahwanYn = $("input:checkbox[id='hwahwanYn']").val();
			var searchStrDate = $("#searchStrDate").val();
			var searchEndDate = $("#searchEndDate").val();
			var itemCd = $("#itemCd option:selected").val();
			var cmpCd = '0000000001';
			var flowerCd = '1';
			
			$("#itemCd").html("");
			$("#itemCd").append("<option value='' selected> 전체 </option>");
			
			$.ajax({
					type:'post'
				,	url : "/intCode/selectIntItemList.json"
				,	data : {
						hwahwanYn : hwahwanYn
					,	cmpCd : cmpCd
					,	flowerCd : flowerCd
					,	searchStrDate : searchStrDate
					,	searchEndDate : searchEndDate
					}
				,	dataType : ''
				,	success : function(res){
						if(res.list.length>0){
							for(var i=0;i<res.list.length;i++){
								var chkSelect = '';
								if(itemCd == res.list[i].itemNm){chkSelect = 'selected';};
								$("#itemCd").append("<option value='"+ res.list[i].itemNm +"'"+ chkSelect +">"+res.list[i].itemNm+"</option>");
							}
						}
					}
			});
		}
		

		function dateChkstr(){
			if($("#searchStrDate").val() > $("#searchEndDate").val()){
				$("#searchEndDate").val($("#searchStrDate").val()) ;
			}
		}

		function dateChkend(){
			if($("#searchStrDate").val() > $("#searchEndDate").val()){
				$("#searchStrDate").val($("#searchEndDate").val()) ;
			}
		}

		function datechktoday(date){
			if(date > new Date()) return [false]; return [true];
		}

		function month_sample(value,num){
			var yyyy,m,d;
			var arr=value.split('-');
			var dt= new Date(arr[0],arr[1],arr[2]);
			var dt_v= new Date(arr[0],arr[1],arr[2]);
			dt_v.setMonth(dt.getMonth()-num);
			yyyy= dt_v.getFullYear();
			m=dt_v.getMonth();
			d=dt_v.getDate();

			if(m =="0") {m="12"; yyyy=yyyy-1;}
			if(m<10) {m='0'+m;}
			if(d<10) {d='0'+d;}

			begindate=yyyy+'-'+m+'-'+d;
			return begindate;
		}
		
		
		function fn_search() {
			if($("input:checkbox[id='hwahwanYn']").is(":checked") == true) {
				$("input:checkbox[id='hwahwanYn']").val('Y');    
		    } else {
		    	$("input:checkbox[id='hwahwanYn']").val('N');  
		    }   
			var hwahwanYn = $("input:checkbox[id='hwahwanYn']").val();
			var itemCd = $('#itemCd option:selected').val();
			var searchStrDate = $("#searchStrDate").val();
			var searchEndDate = $("#searchEndDate").val();
			
			$.ajax({
				type:'post'
			,	url : "/report/selectDayPumAuc.json"
			,	data : {
					hwahwanYn : hwahwanYn
				,	itemCd : itemCd
				,	searchStrDate : searchStrDate
				,	searchEndDate : searchEndDate
				}
			,	dataType : ''
			,	success : function(res){
					var html = "";
					
					if(res.list.length > 0){
						for(var i=0;i<res.list.length;i++){
							html += "<tr>";
							html +=		"<td class='tc'>" + res.list[i].year + "</td>";
							html += 	"<td class='tc'>" + res.list[i].month + "</td>";
							html +=		"<td class='tc'>" + res.list[i].day + "</td>";
							html +=		"<td class='tc'>" + res.list[i].pumName + "</td>";
							html +=		"<td class='tr'>" + res.list[i].totCnt.toLocaleString('ko-KR') + "</td>";
							html +=		"<td class='tr'>" + res.list[i].panCnt.toLocaleString('ko-KR') + "</td>";
							html +=		"<td class='tr'>" + res.list[i].yuchalCnt.toLocaleString('ko-KR') + "</td>";
							html +=		"<td class='tr'>" + res.list[i].totAmt.toLocaleString('ko-KR') + "</td>";
							html +=		"<td class='tr'>" + res.list[i].avgAmt.toLocaleString('ko-KR') + "</td>";
							html += "</tr>";
						}
					}else {
						html += "<tr><td colspan='9' class='tc'>데이터가 없습니다.</td></tr>";
					}
					
					$("#listTable").html(html);
				}
			});
		}

		// 엑셀 다운로드
		function excelExport(){
			var excelNm = "일별 품목별 경매실적 및 동향";
			
			if($("input:checkbox[id='hwahwanYn']").is(":checked") == true) {
				$("input:checkbox[id='hwahwanYn']").val('Y');    
		    } else {
		    	$("input:checkbox[id='hwahwanYn']").val('N');  
		    }   
			var hwahwanYn = $("input:checkbox[id='hwahwanYn']").val();
			var searchStrDate = ($("#searchStrDate").val()).replaceAll('-', '');
			var searchEndDate = ($("#searchEndDate").val()).replaceAll('-', '');
			var itemCd = $("#itemCd option:selected").val();
			var searchTime = $("#searchTime option:selected").val();
			
			var param = "?excelNm=" + excelNm + "&searchStrDate=" + searchStrDate + "&searchEndDate=" + searchEndDate 
					+ "&itemCd=" + itemCd + "&hwahwanYn=" + hwahwanYn + "&searchTime=" + searchTime;
			location.href = "/excel/excelDownLoad.do" + param;
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
				<li class="m_right">일별 품목별 경매실적 및 동향</li>
			</ul>
		</div>
		<!--sub 헤더 (E)-->
		
		<!--서브 타이틀(S)-->
		<div class="sub_title">		
			<div class="title_box">
				<h2>일별 품목별 경매실적 및 동향 (양재 화훼공판장)</h2>
				<img src="../images/2020/sub/t_line.png" alt="방울점선">
			</div>
		</div>
		<!--서브 타이틀(E)-->
		
		<!--콘텐츠_메인(S)-->
		<div class="sub_contents">	
			<!-- 검색창(S) -->
			<div class="search_box_s">
				<input type="hidden" name="currentPageNo" value=""/>
				<div class="search_01">
					<ul class="search_box01" id="dayPumAuc_search_box01">
						<li class="calendar" id="liStrDate">
							<p class="search_01_txt">시작일자</p>
							<input type="text" class="datepicker except" name="searchStrDate" id="searchStrDate" value="${searchStrDate}"/>
						</li>
						<li class="calendar">
							<p class="search_01_txt">종료일자</p>
							<input type="text" class="datepicker except" name="searchEndDate" id="searchEndDate" value="${searchEndDate}"/>
						</li>
						<li id="hwahwanCheckbox">
							<p class="search_01_txt">화환류</p>
							<input type="checkbox" id="hwahwanYn" name="hwahwanYn" class="title_box_chk" value="N" onClick="getIntItemList();">
							<label for="hwahwanYn"><span></span>화환류(체크)</label>
						</li>
						<li id="pumSelectbox">
							<p class="search_01_txt">품목</p>
							<select id="itemCd" name="itemCd" class="form-control except">
							</select>
						</li>
						<li class="search_btn">
							<!-- <button type="button" class="btn_search" onclick="fn_search();">검색</button> -->
							<a href="javascript:fn_search()"><img src="../images/2020/sub/search_img.png" alt="돋보기"></a>
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
			
			<!-- 버튼박스(S) -->
			<div style='float: right; margin-bottom: 10px;'>
				<span>(단위 물량:단(속), 단가:원)</span>
			</div>
			<!-- 버튼박스(E) -->
				
			<!-- 테이블(S) -->
			<table id="tblBackground" class="scroll-table-01">
				<tr>
					<td>
						<div id="divHeadScroll">
							<table id="tblHead" class="table_type_01 btg tiny">
								<colgroup>
									<col style="width:100px;">
									<col style="width:100px;">
									<col style="width:100px;">
									<col style="width:300px;">
									<col style="width:100px;">
									<col style="width:100px;">
									<col style="width:100px;">
									<col style="width:100px;">
									<col style="width:115px;">
								</colgroup>
							<thead>
								<tr>
									<th>연</th>
									<th>월</th>
									<th>일</th>
									<th>품목</th>
									<th>출하물량</th>
									<th>판매물량</th>
									<th>유찰물량</th>
									<th>판매금액</th>
									<th>평균단가</th>
								</tr>
							</thead>
						</table>
						</div>
						<div id="divBodyScroll">
							<table id="tblBody"  class="table_type_01 body tiny w100p">
								<colgroup>
									<col style="width:100px;">
									<col style="width:100px;">
									<col style="width:100px;">
									<col style="width:300px;">
									<col style="width:100px;">
									<col style="width:100px;">
									<col style="width:100px;">
									<col style="width:100px;">
									<col style="width:100px;">
								</colgroup>
								<tbody id="listTable"></tbody>
							</table>
						</div>
					</td>
				</tr>
			</table>
			<!-- 테이블(E) -->	

			<!-- 엑셀 버튼박스(S) -->
			<div class="search_box_e">
				<div class="search_01">
					<ul class="search_box01">
						<li class="calendar" id="liStrDate">
							<select class="select" id="searchTime" name="searchTime">
								<option value="7">7시</option>
								<option value="13">13시</option>
							</select>
						</li>
						<li class="search_btn excelBtn1">
							<a href="#!">엑셀저장</a>
						</li>
					</ul>
				</div>
			</div>
			<!-- 엑셀 버튼박스(E) -->

		</div>
		<!--콘텐츠_메인(E)-->
		<jsp:include page="../inc/2020/IncFooter.jsp"/>	

	</div>		
	<!--WRAP(E)-->		

</body>
</html>