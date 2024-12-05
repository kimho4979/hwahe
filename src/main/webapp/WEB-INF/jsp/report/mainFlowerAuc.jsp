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
	<meta name="description" content="경락단가내역">
	<meta name="content" content="화훼유통정보시스템 입니다.">
	<meta name="keywords" content="화훼경매시세, 화훼경매가격, Korea aT flower market auction price, 화훼공판장, 화훼거래정보, 꽃시장, 꽃값">
	<meta name="Author" content="화훼유통정보시스템 & www.woorim.co.kr : Kim Juyeon">
	<title>경락단가내역</title>
	
	<%@include file="../common/2020/commonJs.jsp" %>
	<%@include file="../common/2020/commonCss.jsp" %>
	
	<style>
		#progress_loading {position: absolute; left: 50%; background: #ffffff; text-align: center;}
	</style>
	
	
	<script type="text/javascript">
		$(document).ready(function(){
			$('#progress_loading').hide();
			
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
					
				}
			});
			
			$("#excelBtn1").empty();
			$("#excelBtn1").append('<a href="javascript:void(0);" id="exportBtn1" name="exportTable1" onclick="excelExport();"><img src="../images/2020/exel.png" alt="엑셀이미지">엑셀저장</a>');
			
			fn_search();
		})
		.ajaxStart(function() {
			$('#progress_loading').show();
		})
		.ajaxStop(function() {
			$('#progress_loading').hide();
		});
		
		
		
		function datechktoday(date){
			if(date > new Date()) return [false]; return [true];
		}
	
		// 엑셀 다운로드
		function excelExport(){
			var choose = $(".sub_tab_btn").children().children(".on").attr("value");			
			
			var excelNm = "주요절화류도매가격동향";
			var searchStrDate = $("#searchStrDate").val();
			//var cmpCd = $("#cmpCdTab .on > input").attr("value");
			var cmpCd = '0000000001';
			var searchTime = $("#searchTime").val();
			var param = "?excelNm="+excelNm+"&searchStrDate="+searchStrDate+"&cmpCd="+cmpCd+"&searchTime="+searchTime;
			location.href = "/excel/excelDownLoad.do"+param;			
		}
		
		function init(){
			$("#get1").empty();
			$("#get1").append("<tr><td colspan='14'>데이터가 없습니다.</td></tr>");
		}
		
		function fn_search(){
			var searchStrDate = $("#searchStrDate").val();
			//var cmpCd = $("#cmpCdTab .on > input").attr("value");
			var cmpCd = '0000000001';
			$.ajax({
				type : 'post',
				url : '/report/selectMainFlowerAuc.json',
				data : {
					searchStrDate : searchStrDate,
					cmpCd : cmpCd
				},
				success : function(res){
					var val = res.list;
						
					if(val != ""){
						var check = null;
						var preCheck = null;
						var monCheck  = null;
						var sunYear = null;
						var iyear = searchStrDate.substring(0,4);
						var iMonth = searchStrDate.substring(5,7);
						var html = "";
						
						if(res.check == "1"){
							check = '상순';
							preCheck = '하순';
							monCheck = res.preMonth;
							if(iMonth == "01"){
								sunYear = res.preYear;
							}else{
								sunYear = iyear;
							}
						}else if(res.check == "2"){
							check = '중순';
							preCheck = '상순';
							monCheck = iMonth;
							sunYear = iyear;
						}else{
							check = '하순';
							preCheck = '중순';
							monCheck = iMonth;
							sunYear = iyear;
						}
						
						$("#commonYear").html("평년 "+iMonth+"월 <br>"+check+"(A)");
						$("#preYear").html(res.preYear+"년"+iMonth+"월 <br>"+check+"(B)");
						$("#preMonth").html(iyear+"년"+res.preMonth+"월 <br>"+check+"(C)");
						$("#preSun").html(sunYear+"년"+monCheck+"월 <br>"+preCheck+"(D)");
						$("#preDay").html(res.yesterDay+"<br>(전일)");
						$("#iDay").html(searchStrDate+"<br>(E)");
						for(var i=0; i<val.length; i++){
							if(val[i].cyAvg == 0){
								val[i].cyAvg = "-";
							}
							if(val[i].preyAvg == 0){
								val[i].preyAvg = "-";
							}
							if(val[i].premAvg == 0){
								val[i].premAvg = "-";
							}
							if(val[i].sdayAvg == 0){
								val[i].sdayAvg = "-";
							}
							if(val[i].ydayAvg == 0){
								val[i].ydayAvg = "-";
							}
							if(val[i].todayAvg == 0){
								val[i].todayAvg = "-";
							}
							if(val[i].cyPer == -100 || val[i].cyPer == 0){
								val[i].cyper = "-";
							}
							if(val[i].preyPer == -100 || val[i].preyPer == 0){
								val[i].preyper = "-";
							}
							if(val[i].premPer == -100 || val[i].premPer == 0){
								val[i].premper = "-";
							}
							if(val[i].sdayPer == -100 || val[i].sdayPer == 0){
								val[i].sdayper = "-";
							}
							html += "<tr><td class='tc'>"+val[i].pumName+"</td><td class='tc'>"+val[i].dan+"</td><td class='tc'>"+val[i].cyAvg.toLocaleString('ko-KR')+"</td>"+
									"<td class='tc'>"+val[i].preyAvg.toLocaleString('ko-KR')+"</td><td class='tc'>"+val[i].premAvg.toLocaleString('ko-KR')+"</td><td class='tc'>"+val[i].sdayAvg.toLocaleString('ko-KR')+"</td><td class='tc'>"+
									val[i].ydayAvg.toLocaleString('ko-KR')+"</td><td class='tc'>"+val[i].todayAvg.toLocaleString('ko-KR')+"</td><td class='tc'>"+val[i].cyPer+"</td><td class='tc'>"+val[i].preyPer+"</td>"+
									"<td class='tc'>"+val[i].premPer+"</td><td class='tc'>"+val[i].sdayPer+"</td></tr>";
						}
						$("#get1").html(html);
					}else{
						$("#get1").html("<tr><td class='tc' colspan='12'>데이터가 없습니다.</td></tr>");
					}	
					
				}
			});
		}
		
		function SeparatCom(num) {
		    return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		}
		
		
	</script>
</head>
<body>
	<input type="hidden" id="searchProductGubun" name="searchProductGubun" value="1"/>
	<input type="hidden" id="searchCmpCd" name="searchCmpCd" value="0000000001"/>
	<input type="hidden" id="searchPumGubn" name="searchPumGubn" value="1"/>
	
	<!--WRAP(S)-->
	<div class="wrap">
			
		<jsp:include page="../inc/2020/IncHeader.jsp"/>
		
		<div class="lnb_box">
			<ul>
				<li><img src="../images/2020/m_lnb_img.png" alt="집"></li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li>공공데이터</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li>농식품부 보고자료</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li class="m_right">주요 절화류 도매가격 동향</li>
			</ul>
		</div>
		<!--공통 HEADER(E)-->
		
		<!--서브 타이틀(S)-->
		
		<div class="sub_title">
			<div class="title_box">
				<h2>주요 절화류 도매가격 동향(양재 화훼공판장)</h2>
				<img src="../images/2020/sub/t_line.png" alt="방울점선">
			</div>
		</div>
		<!--서브 타이틀(E)-->
		<div class="sub_contents">	
			<!-- <div class="sub_content">
				<ul class="sub_tab ct_gnb" id="cmpCdTab">
					<li class="on s_on"><input type="hidden" value="0000000001"/><a href="#">aT화훼공판장 <br/> <span>(양재동)</span></a></li>
					<li><input type="hidden" value="1508500020"/><a href="#">부산화훼공판장 <br/> <span>(엄궁동)</span></a></li>
					<li><input type="hidden" value="6068207466"/><a href="#">부산경남화훼농협 <br/> <span>(강동동)</span></a></li>
					<li><input type="hidden" value="4108212335"/><a href="#">광주원예농협 <br/> <span>(풍암)</span></a></li>
					<li><input type="hidden" value="3848200087"/><a href="#">한국화훼농협 <br/> <span>(음성)</span></a></li>
					<li><input type="hidden" value="1288202296"/><a href="#">한국화훼농협 <br/> <span>(과천)</span></a></li>
					<li><input type="hidden" value="6158209828"/><a href="#">영남화훼농협 <br/> <span>(김해)</span></a></li>
				</ul>
			</div> -->
			<!-- 검색창(S) -->
			<div class="search_box_s">
				<div class="search_01">
					<ul class="search_box01">
						<li class="calendar" id="liStrDate">
							<p class="search_01_txt">날짜</p>
							<input type="text" class="datepicker except" name="searchStrDate" id="searchStrDate" value="${searchStrDate}"/>
						</li>
						<li class="search_btn">
							<!-- <button type="button" class="btn_search" onclick="fn_search();">검색</button> -->
							<a href="javascript:fn_search()"><img src="../images/2020/sub/search_img.png" alt="돋보기"></a>
						</li>
					</ul>
				</div>
			</div>
			
			<!-- 로딩바(S) -->
			<div id="progress_loading">
				<img src="../../images/loadingBar.gif"/>
			</div>
			<!-- 로딩바(E) -->
			
			<!--컨텐츠 내용(S)-->
			<div class="sub_guide">
				<!-- 탭콘텐츠(S) -->
				<ul class="tab_contents">
					<li>				
						<!-- 테이블(S) -->
						<div class="overflow-x">
						<table class="table_type_01 btg tiny">
							<caption>경락단가내역</caption>
							<colgroup>
								<col style="width:20%">
								<col style="width:9%">
								<col style="width:7%">
								<col style="width:7%">
								<col style="width:7%">
								<col style="width:7%">
								<col style="width:7%">
								<col style="width:7%">
								<col style="width:7%">
								<col style="width:7%">
								<col style="width:7%">
								<col style="width:7%">
							</colgroup>
							<tbody>
								<thead>
									<tr>
										<th class="tc" rowspan="2">품목</th>
										<th class="tc" rowspan="2">단위</th>
										<th class="tc" colspan="6">가격(원)</th>
										<th class="tc" colspan="4">등락율(%)</th>
									</tr>
									<tr>
										<th class="tc" id="commonYear"></th>
										<th class="tc" id="preYear"></th>
										<th class="tc" id="preMonth"></th>
										<th class="tc" id="preSun"></th>
										<th class="tc" id="preDay"></th>
										<th class="tc" id="iDay"></th>
										<th class="tc">평년(E/A)</th>
										<th class="tc">전년(E/B)</th>
										<th class="tc">전월(E/C)</th>
										<th class="tc">전순(E/D)</th>
									</tr>
								</thead>
								<tbody id="get1"></tbody>						
							</tbody>
						</table>
						</div>
						<!-- 테이블(E) -->
					</li>
				</ul>
				<!-- 탭콘텐츠(E) --> 
				
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
							<li class="search_btn" id="excelBtn1">
								<a href="#!">엑셀저장</a>
							</li>
						</ul>
					</div>
				</div>
				<!-- 엑셀 버튼박스(E) -->
				
			</div>
			<!--컨텐츠 내용(E)-->
			</div>
			<jsp:include page="../inc/2020/IncFooter.jsp"/>
		
	</div>
	<!--WRAP(E)-->
</body>
</html>