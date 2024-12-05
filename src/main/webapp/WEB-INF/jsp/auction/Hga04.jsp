<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!doctype html>
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
	<meta name="description" content="주출하지별 출고현황">
	<meta name="content" content="화훼유통정보시스템 입니다.">
	<meta name="keywords" content="화훼경매시세, 화훼경매가격, Korea aT flower market auction price, 화훼공판장, 화훼거래정보, 꽃시장, 꽃값">
	<meta name="Author" content="화훼유통정보시스템 & www.woorim.co.kr">
	<title>주출하지별 출고현황</title>
	<%@include file="../common/2020/commonJs.jsp"%>
	<%@include file="../common/2020/commonCss.jsp"%>

<!-- rMateChartH5 라이센스 -->
<script language="javascript" type="text/javascript" src="/rMateMapChart/LicenseKey/rMateMapChartH5License.js"></script>
<!-- rMateMapChartH5 라이브러리 -->
<script type="text/javascript" src="/rMateMapChart/rMateMapChartH5/JS/rMateMapChartH5.js"></script>
<!-- rMateMapChartH5 CSS -->
<link rel="stylesheet" type="text/css" href="/rMateMapChart/rMateMapChartH5/Assets/rMateMapChartH5.css"/>

<link rel="stylesheet" type="text/css" href="<c:url value='/rMateChart/rMateChartH5/Assets/Css/rMateChartH5.css' />"/>   
 <!-- @@@@@@@@@@@@@@@@@@@@@@ css end   @@@@@@@@@@@@@@@@@@@@@@ --> 

<!-- rMateChartH5 에서 사용하는 스타일 -->
<link rel="stylesheet" type="text/css" href="/rMateChart/rMateChartH5/Assets/Css/rMateChartH52.css"/>
<!-- rMateChartH5 라이센스 -->
<script language="javascript" type="text/javascript" src="/rMateChart/LicenseKey/rMateChartH5License.js"></script>
<!-- 실제적인 rMateChartH5 라이브러리-->
<script type="text/javascript" src="/rMateChart/rMateChartH5/JS/rMateChartH5.js"></script>

<!-- rMateChartH5 테마 js -->
<script type="text/javascript" src="/rMateChart/rMateChartH5/Assets/Theme/theme.js"></script>
<script type="text/javascript" src="/rMateMapChart/rMateMapChartH5/JS/html2canvas.js"></script>
<script type="text/javascript" src="/rMateMapChart/rMateMapChartH5/JS/promise.min.js"></script>
<script type="text/javascript" src="/rMateMapChart/rMateMapChartH5/JS/canvg.js"></script>
<script type="text/javascript" src="/rMateMapChart/rMateMapChartH5/JS/rgbcolor.js"></script>

<script type="text/javascript">
var cmpCd = [];	
var cmpNm = [];
var flowerCd = [];
var flowerNm = [];

//-----------------------맵차트 설정 시작-----------------------
//rMate 맵차트 생성 준비가 완료된 상태 시 호출할 함수를 지정합니다.
var mapVars = "rMateOnLoadCallFunction=mapReadyHandler";
var mapApp = null;
var mapRoot = null;
//맵차트의 속성인 rMateOnLoadCallFunction 으로 설정된 함수.
//rMate 맵차트 준비가 완료된 경우 이 함수가 호출됩니다.
//이 함수를 통해 맵차트에 레이아웃과 데이터를 삽입합니다.
//파라메터 : id - rMateMapChartH5.create() 사용 시 사용자가 지정한 id 입니다.
//맵차트 콜백함수 7개 존재합니다.
//1. setLayout - 스트링으로 작성된 레이아웃 XML을 삽입합니다.
//2. setData - 배열로 작성된 데이터를 삽입합니다.
//3. setMapDataBase - 스트링으로 작성된 MapData XML을 삽입합니다.
//4. setLayoutURLEx - 레이아웃 XML 경로를 지시합니다.
//5. setDataURLEx - 데이터 XML 경로를 지시합니다.
//6. setMapDataBaseURLEx - MapData XML 경로를 지시합니다.
//7. setSourceURLEx - Map Source 경로를 지시합니다.
function mapReadyHandler(id) {
 document.getElementById(id).setLayout(layoutStr);
 document.getElementById(id).setData(mapData);
 document.getElementById(id).setMapDataBaseURLEx(mapDataBaseURL);
 document.getElementById(id).setSourceURLEx(sourceURL);
 
}

//Map Data 경로 정의
//setMapDataBase함수로 mapDataBase를 문자열로 넣어줄 경우 주석처리나 삭제하십시오.
var mapDataBaseURL = "/rMateMapChart/Samples/MapDataBaseXml/SouthKorea.xml";

//MapChart Source 선택
//MapSource 디렉토리의 지도 이미지중 택일가능하며, 이외에 사용자가 작성한 별도의 Svg이미지를 지정할 수 있습니다.(매뉴얼 참조)
var sourceURL = "/rMateMapChart/Samples/MapSource/SouthKorea.svg";

//rMateMapChart 를 생성합니다.
//파라메터 (순서대로) 
//1. 맵차트의 id ( 임의로 지정하십시오. ) 
//2. 맵차트가 위치할 div 의 id (즉, 차트의 부모 div 의 id 입니다.)
//3. 맵차트 생성 시 필요한 환경 변수들의 묶음인 chartVars
//4. 맵차트의 가로 사이즈 (생략 가능, 생략 시 100%)
//5. 맵차트의 세로 사이즈 (생략 가능, 생략 시 100%)
/*
000		서울/경기
100		강원도
1000	울산
1100	인천
1200	전라남도
1300	전라북도
1400	제주도
1500	충청남도
1600	충청북도
1700	세종
1800	강원(영동)
1900	강원(영서)
200		경기도
300		경상남도
400		경상북도
500		광주
600		대구
700		대전
800		부산
900		서울
*/
var codes = {
	"100":true		//강원도
  , "200":true		//경기도
  , "300":true		//경상남도
  , "400":true		//경상북도
  , "500":true		//광주
  , "600":true		//대구
  , "700":true		//대전
  , "800":true		//부산
  , "900":true
  , "90000":true
  , "1000":true		//울산
  , "1100":true		//인천
  , "1200":true		//전라남도
  , "1300":true		//전라북도
  , "1400":true		//제주도
  , "1500":true		//충청남도
  , "1600":true		//충청북도
  , "1700":true		//세종
}

var mapInitData = [];

//mapChart func
function labelFunction(seriesId, code, label, data) {
	
    var text = null;
//    	text = label+ "<br> 비율 : "+ data.av1+"%";
   	text = label;
    return text;
}

//mapChart func
function divDataTipFunction(seriesId, code, label, data) {
	// 맵차트 디테일
	if(data.av1 != null){
		return label + "<br> 비율 : " + data.av1;
		
		/* var html = "<div style=\"padding:3px;\"><div>"+label+"</div>";
		html += "<div>비율 : "+data.av1+"</div>";
		
		return html; */
		
	}else{
		return "데이터가 없습니다.";
	}     
}

//mapChart func
function divDataTipFunction2(seriesId, code, label, data) {
	// 맵차트 디테일
	if(data.av1 != null){
		return label + "<br> 비율 : " + data.av2;
		
		/* var html = "<div style=\"padding:3px;\"><div>"+label+"</div>";
		html += "<div>비율 : "+data.av1+"</div>";
		
		return html; */
		
	}else{
		return "데이터가 없습니다.";
	}     
}

var layoutStr = null;
var mapData = null;
//-----------------------맵차트 설정 끝 -----------------------
$(document).ready(function() {
								var itemCd = "";
								var kindCd = "";
								var searchStrDate = $('#searchStrDateD').val();
								var searchEndDate = $('#searchEndDateD').val();
								
								var type = $(":input:radio[name=rr2]:checked").val();
								
								var type2 = $(":input:radio[name=rr3]:checked").val();	// 금액/물량 기준
								
								if($('#itemCd option:selected').val() !== undefined){
					        		itemCd = $('#itemCd option:selected').val();
					        	}
								
								if($('#kindCd option:selected').val() !== undefined){
									kindCd = $('#kindCd option:selected').val();
					        	}
								
								$('input:checkbox[name="cmpCd"]:checked').each(function(){
					    			cmpCd.push($(this).val());
					    		})
					    		
					    		// 캐린더 초기 세팅								
								$("#searchDateD").hide();
								$("#searchDateM").hide();
								$("#searchDateY").show();
								
								// 경매장 초기 세팅
								$("#sCmp").show();
								$("#tCmp").hide();
								
								// 품목 콤보 필터링
								$('#itemCd').select2();
								
								// 품종 콤보 필터링
								$('#kindCd').select2();	
								
								// 통합 경매장 체크박스
								$("input[name=cmpCd]").change(function(){
									if(this.checked){
										if($('input:checkbox[name="cmpCd"]:checked').length == 7){
											$("#chk77").prop("checked",true);
										}
									}else{
										$("#chk77").prop("checked",false);
									}
									
									// 품목조회
									getItem();
								});
								
								// 개별 경매장 라디오
								$("input[name=cmpCd2]").change(function(){
									// 품목조회
									getItem();
								});
								
								// 기준 선택에 따라서 경매장 변경
								// 개별 : 라디오, 통합 : 체크박스
								$("input[name='rr2']").change(function(){
									
									if($(":input:radio[name=rr2]:checked").val() == "E"){
										// 개별
										auctionType = 'sCmp';
										$("#sCmp").show();
										$("#tCmp").hide();
									}else{
										// 통합
										auctionType = 'tCmp';
										$("#sCmp").hide();
										$("#tCmp").show();
									}
									
									// 품목조회
									getItem();
								});
								
								// 품목 변경시 품종 재조회
								/* $("#itemCd").change(function() {
									getItem2();									
								}); */
								
								// 조회기간 라디오 선택시 캘린더 변경
								$("input[name='rr']").change(function(){
									if($(":input:radio[name=rr]:checked").val() == "day"){
										$("#searchDateD").show();
										$("#searchDateM").hide();
										$("#searchDateY").hide();
										
									}else if($(":input:radio[name=rr]:checked").val() == "month"){
										$("#searchDateD").hide();
										$("#searchDateM").show();
										$("#searchDateY").hide();
									}else{
										$("#searchDateD").hide();
										$("#searchDateM").hide();
										$("#searchDateY").show();
									}
									
								});
								
								// 부류 전체 체크
								$("input[name=flowerGubn]").change(function(){
									if(this.checked){
										if($('input:checkbox[name="flowerGubn"]:checked').length == 4){
											$("#chk05").prop("checked",true);
										}
									}else{
										$("#chk05").prop("checked",false);
									}
									// 품목조회
									getItem();
								});
								
								//달력 일별설정
								$("#searchStrDateD").datepicker({
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
										cmpCd= [];
										
										var searchStrDate = $("#searchStrDateD").val();
										var searchEndDate = $("#searchEndDateD").val();
										
							       		$('input:checkbox[name="cmpCd"]:checked').each(function(){
							       			cmpCd.push($(this).val());
							       		})
							       		
							       		if(searchStrDate!=''&& searchEndDate!=''){
							       			// 품목조회
											getItem();
										}
									}
								});
								
								//달력 일별설정
								$("#searchEndDateD").datepicker({
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
										dateChkend();
										cmpCd= [];
										
										var searchStrDate = $("#searchStrDateD").val();
										var searchEndDate = $("#searchEndDateD").val();
										
							       		$('input:checkbox[name="cmpCd"]:checked').each(function(){
							       			cmpCd.push($(this).val());
							       		})
							       		
							       		if(searchStrDate!=''&& searchEndDate!=''){
							       			// 품목조회
											getItem();
										}
									}
								});
								
								//달력 월별설정
								$("#searchStrDateM").bindDate({align:"right", valign:"bottom", separator:"-", selectType:"m",  defaultSelectType:"m", value:"",
							       	onchange:function(){
							       		monthChkstr();
										cmpCd= [];

										var searchStrDate = $("#searchStrDateM").val();
										var searchEndDate = $("#searchEndDateM").val();

							       		$('input:checkbox[name="cmpCd"]:checked').each(function(){
							       			cmpCd.push($(this).val());
							       		})
							       		
							       		if(searchStrDate!=''&& searchEndDate!=''){
							       			// 품목조회
											getItem();
										}
									},
								});
								
								// 달력 월별설정
								$("#searchEndDateM").bindDate({align:"right", valign:"bottom", separator:"-", selectType:"m",  defaultSelectType:"m", value:"",
									
							       	onchange:function(){
							       		monthChkend();
										cmpCd= [];

										var searchStrDate = $("#searchStrDateM").val();
										var searchEndDate = $("#searchEndDateM").val();

							       		$('input:checkbox[name="cmpCd"]:checked').each(function(){
							       			cmpCd.push($(this).val());
							       		})
							       		
							       		if(searchStrDate!=''&& searchEndDate!=''){
							       			// 품목조회
											getItem();
										}
									},
								});
							
								//달력 연별설정
								$("#searchStrDateY").bindDate({align:"right", valign:"bottom", separator:"-", selectType:"y",  defaultSelectType:"y", value:"",
									onchange:function(){
										yearChkstr();
										cmpCd= [];
										
										var searchStrDate = $("#searchStrDateY").val();
										var searchEndDate = $("#searchEndDateY").val();

							       		$('input:checkbox[name="cmpCd"]:checked').each(function(){
							       			cmpCd.push($(this).val());
							       		})
							       		
							       		if(searchStrDate!=''&& searchEndDate!=''){
							       			// 품목조회
											getItem();
										}
									}
								});
								
								//달력 연별설정
								$("#searchEndDateY").bindDate({align:"right", valign:"bottom", separator:"-", selectType:"y",  defaultSelectType:"y", value:"",
									onchange:function(){
										yearChkend();
										cmpCd= [];
										
										var searchStrDate = $("#searchStrDateY").val();
										var searchEndDate = $("#searchEndDateY").val();

							       		$('input:checkbox[name="cmpCd"]:checked').each(function(){
							       			cmpCd.push($(this).val());
							       		})
							       		
							       		if(searchStrDate!=''&& searchEndDate!=''){
							       			// 품목조회
											getItem();
										}
									}
								});
								
								// 품목조회
								getItem();

								$("#excelBtn1").empty();
								$("#excelBtn1").append('<a href="javascript:void(0);" id="exportBtn1" name="exportTable1" onclick="excelExport();"><img src="../images/2020/exel.png" alt="엑셀이미지">엑셀저장</a>');
							
								// 키보드 입력
								$('#searchSaleDate').keyup(function(key, event){
									auto_date_format(key.keyCode, this)
							         
									if(key.keyCode == 13){//키가 13이면 실행 (엔터는 13)
										dateComp();		
							        }
								});
								
								// 조회
								//fn_mapInit();	// 맵차트
								searchBtn();
							 });
							 
//엑셀 다운로드
function excelExport() {
	var excelNmEach = "개별 주출하지별출고현황"	//"EachTest";
	var excelNmTot = "TotTest" 		//"통합 주출하지별출고현황";

	// 조회조건
	var itemCd = "";
	var itemNm = "";
	var kindCd = "";
	var kindNm = "";
	var searchStrDate = "";
	var searchEndDate = "";
	var type = $(":input:radio[name=rr2]:checked").val();
	var type2 = $(":input:radio[name=rr3]:checked").val();		// 금액/물량 기준
	var dateType = $(":input:radio[name=rr]:checked").val();
	
	// 품목 콤보
	if($('#itemCd option:selected').val() !== undefined){
		itemCd = $('#itemCd option:selected').val();
		itemNm = $('#itemCd option:selected').text();
	}
	
	// 품종 콤보
	if($('#kindCd option:selected').val() !== undefined){
		kindCd = $('#kindCd option:selected').val();
		kindNm = $('#kindCd option:selected').text();
	}
	
	// 경매장 체크박스
	cmpCd = [];
	cmpNm = [];
	$('input:checkbox[name="cmpCd"]:checked').each(function(){
		cmpCd.push($(this).val());
		cmpNm.push($(this).next('label').text());
	})
			
	// 개별 경매장 라디오 버튼
	var cmpCd2 = $(":input:radio[name=cmpCd2]:checked").val();
	var chkId = $(":input:radio[name=cmpCd2]:checked").attr("id");
	var cmpNm2 = $("label[for='"+chkId+"']").text();
	
	// 부류 체크박스
	flowerCd = [];
	flowerNm = [];
	$('input:checkbox[name="flowerGubn"]:checked').each(function(){
		flowerCd.push($(this).val());
		flowerNm.push($(this).next('label').text());
	})
			        	
	if($(":input:radio[name=rr]:checked").val() == "day"){
		searchStrDate = $("#searchStrDateD").val();
 		searchEndDate = $("#searchEndDateD").val();
		
	}else if($(":input:radio[name=rr]:checked").val() == "month"){
		searchStrDate = $("#searchStrDateM").val();
 		searchEndDate = $("#searchEndDateM").val();
	}else{
		searchStrDate = $("#searchStrDateY").val();
 		searchEndDate = $("#searchEndDateY").val();
	}

	// 우측하단 조회조건 년도, 시작일자의 년도
	var searchStrYear = searchStrDate.substring(0, 4);
	
	//dateType, searchStrDate, searchEndDate, itemCd, itemNm, kindCd, kindNm, cmpCd, flowerCd
	//개별 통합 param, 서비스 분기
	if(type == 'E'){	// 개별
		var param1 = "?excelNm=" + excelNmEach + 
				     "&dateType=" + dateType + 
				     "&searchStrDate=" + searchStrDate + 
				     "&searchEndDate=" + searchEndDate +
				     "&itemCd=" + itemCd +
				     "&itemNm=" + itemNm +
				     "&kindCd=" + kindCd +
				     "&kindNm=" + kindNm +
				     "&cmpCd2=" + cmpCd2 +
				     "&cmpNm2=" + cmpNm2 +
				     "&flowerCd=" + flowerCd +
				     "&flowerNm=" + flowerNm +
				     "&searchStrYear=" + searchStrYear +
				     "&type2=" + type2;				     
		location.href = "/excel/excelDownLoadHga04Each.do" + param1;
		/*
		$.ajax({
			type : "post",
		    url : "/excel/excelDownLoadHga04Each.do",
		    data : {	
		    	// 조회조건
		    	excelNm : excelNmEach,
		    	dateType : dateType,
		    	searchStrDate : searchStrDate,
		    	searchEndDate : searchEndDate,
		    	itemCd : itemCd,
		    	itemNm : itemNm,
		    	kindCd : kindCd,
		    	kindNm : kindNm,
		    	cmpCd2 : cmpCd2,
		    	flowerCd : flowerCd,
		    	searchStrYear : searchStrYear
		    },
		    dataType : 'json', 
		    success : function(res){
		    		
		    }
		});*/
	}
	else {	// 통합
		var param2 = "?excelNm=" + encodeURIComponent(excelNmTot) + 
				     "&dateType=" + dateType + 
				     "&searchStrDate=" + searchStrDate + 
				     "&searchEndDate=" + searchEndDate +
				     "&itemCd=" + itemCd +
				     "&itemNm=" + itemNm +
				     "&kindCd=" + kindCd +
				     "&kindNm=" + kindNm +
				     "&cmpCd=" + cmpCd +
				     "&cmpNm=" + cmpNm +
				     "&flowerCd=" + flowerCd +
				     "&flowerNm=" + flowerNm +
				     "&searchStrYear=" + searchStrYear +
				     "&type2=" + type2;	
		location.href = "/excel/excelDownLoadHga04Tot.do" + param2; 
		/* excelNm = excelNmTot;
		$.ajax({
			type : "post",
		    url : "/excel/excelDownLoadHga04Tot.do",
		    data : {	
		    	// 조회조건
		    	excelNm : excelNm,
		    	dateType : dateType,
		    	searchStrDate : searchStrDate,
		    	searchEndDate : searchEndDate,
		    	itemCd : itemCd,
		    	itemNm : itemNm,
		    	kindCd : kindCd,
		    	kindNm : kindNm,
		    	cmpCd : cmpCd,
		    	flowerCd : flowerCd,
		    	searchStrYear : searchStrYear
		    },
		    dataType : 'json', 
		    success : function(res){
		    		
		    }
		}); */
	}
}	

//품목 조회
function getItem() {
	// 조회조건
	var url = '';
	var type = $(":input:radio[name=rr2]:checked").val();		// 기준
	var type2 = $(":input:radio[name=rr3]:checked").val();		// 금액/물량 기준
	var dateType = $(":input:radio[name=rr]:checked").val();
	// 개별 경매장 라디오 버튼
	var cmpCd2 = $(":input:radio[name=cmpCd2]:checked").val();
	
	// 통한 경매장 체크박스
	cmpCd= [];		
	$('input:checkbox[name="cmpCd"]:checked').each(function(){
		cmpCd.push($(this).val());
	})
	
	// 부류 체크박스
	flowerCd = [];
	$('input:checkbox[name="flowerGubn"]:checked').each(function(){
		flowerCd.push($(this).val());
	})
	
	if(type == 'E'){
		url = "/hga04/selectGetItemEach.json";	// 개별 조회
	}else{
		url = "/hga04/selectGetItemTotal.json";	// 통합조회
	}
	
	if($(":input:radio[name=rr]:checked").val() == "day"){
		searchStrDate = $("#searchStrDateD").val();
 		searchEndDate = $("#searchEndDateD").val();
		
	}else if($(":input:radio[name=rr]:checked").val() == "month"){
		searchStrDate = $("#searchStrDateM").val();
 		searchEndDate = $("#searchEndDateM").val();
	}else{
		searchStrDate = $("#searchStrDateY").val();
 		searchEndDate = $("#searchEndDateY").val();
	}
	
	$.ajax({
		type : "post",
		url : url,
		data : {
			type : type,
			dateType : dateType,
			cmpCd : cmpCd,
			cmpCd2 : cmpCd2,
			searchStrDate : searchStrDate,
			searchEndDate : searchEndDate,
			flowerCd : flowerCd
			
		},
		dataType : 'json',
		success : function(res) {
			var val = res.list;
			if (val.length > 0) {
				$("#itemCd").html("");
				$("#itemCd").append("<option value='' selected>전체</option>");
				if(type == 'E'){	// 개별
					for (var i = 0; i < val.length; i++) {
						$("#itemCd").append("<option value='"+val[i].itemCd+"'>"+val[i].itemCd+"</option>");
					}
				
					// 품종조회
					getItem2();
				}
				else {		// 통합
					for(var i=0;i<res.list.length;i++){
						$("#itemCd").append("<option value='"+val[i].flowerCode+val[i].itemCd+"'"+">"+val[i].itemNm+"</option>");
					}
				
					// 품종조회
					getItem2();
				}
			} else {
				alert('해당일자에 데이터가 없습니다.');
			}
		}
	});
}

//품종 조회
function getItem2() {
	// 조회조건
	var url = '';
	var itemCd = $('#itemCd option:selected').val();
	var type = $(":input:radio[name=rr2]:checked").val();		// 기준
	var type2 = $(":input:radio[name=rr3]:checked").val();		// 금액/물량 기준
	var dateType = $(":input:radio[name=rr]:checked").val();
	// 개별 경매장 라디오 버튼
	var cmpCd2 = $(":input:radio[name=cmpCd2]:checked").val();
	
	// 통한 경매장 체크박스
	cmpCd= [];		
	$('input:checkbox[name="cmpCd"]:checked').each(function(){
		cmpCd.push($(this).val());
	})
	
	// 부류 체크박스
	flowerCd = [];
	$('input:checkbox[name="flowerGubn"]:checked').each(function(){
		flowerCd.push($(this).val());
	})
	
	if(type == 'E'){
		url = "/hga04/selectGetItem2Each.json";	// 개별 조회
	}else{
		url = "/hga04/selectGetItem2Total.json";	// 통합조회
	}
	
	if($(":input:radio[name=rr]:checked").val() == "day"){
		searchStrDate = $("#searchStrDateD").val();
 		searchEndDate = $("#searchEndDateD").val();
		
	}else if($(":input:radio[name=rr]:checked").val() == "month"){
		searchStrDate = $("#searchStrDateM").val();
 		searchEndDate = $("#searchEndDateM").val();
	}else{
		searchStrDate = $("#searchStrDateY").val();
 		searchEndDate = $("#searchEndDateY").val();
	}
	
	if(itemCd!=null && itemCd!=''){
		$.ajax({
			type : "post",
			url : url,
			data : {
				// 조회조건
				type : type,
				dateType : dateType,
				itemCd : itemCd,
				cmpCd : cmpCd,
				cmpCd2 : cmpCd2,
				searchStrDate : searchStrDate,
				searchEndDate : searchEndDate,
				flowerCd : flowerCd
			},
			dataType : 'json',
			success : function(res) {
				var val = res.list;
				if (val.length > 0) {
					$("#kindCd").html("");
					$("#kindCd").append("<option value='' selected>전체</option>");
					if(type == 'E'){	// 개별
						for (var i = 0; i < val.length; i++) {
							$("#kindCd").append("<option value='"+val[i].kindNm+"'>"+val[i].kindNm+"</option>");
						}
					}
					else {				// 통합
						for(var i=0;i<res.list.length;i++){
							$("#kindCd").append("<option value='"+val[i].flowerCode+val[i].itemCd+val[i].kindCd+"'"+">"+val[i].kindNm+"</option>");
						}
					}				
				} else {
					alert('해당일자에 데이터가 없습니다.');				
				}
			}
		});
	}
	else {
		$("#kindCd").html("");
		$("#kindCd").append("<option value='' selected>품목미선택</option>");
	}	
}

// from-to 날짜 비교. from
function dateChkstr(){
	if($("#searchStrDateD").val() > $("#searchEndDateD").val()){
		$("#searchEndDateD").val($("#searchStrDateD").val()) ;
	}
}

// from-to 날짜 비교. to
function dateChkend(){
	if($("#searchStrDateD").val() > $("#searchEndDateD").val()){
		$("#searchStrDateD").val($("#searchEndDateD").val()) ;
	}
}

// from-to 월 비교. from
function monthChkstr(){
	if($("#searchStrDateM").val() > $("#searchEndDateM").val()){
		$("#searchEndDateM").val($("#searchStrDateM").val()) ;
	}
}

//from-to 월 비교. to
function monthChkend(){
	if($("#searchStrDateM").val() > $("#searchEndDateM").val()){
		$("#searchStrDateM").val($("#searchEndDateM").val()) ;
	}
}

//from-to 년 비교. from
function yearChkstr(){
	if($("#searchStrDateY").val() > $("#searchEndDateY").val()){
		$("#searchEndDateY").val($("#searchStrDateY").val()) ;
	}
}

//from-to 년 비교. to
function yearChkend(){
	if($("#searchStrDateY").val() > $("#searchEndDateY").val()){
		$("#searchStrDateY").val($("#searchEndDateY").val()) ;
	}
}

// 조회버튼
function searchBtn(){
	// 조회조건
	var itemCd = "";
	var itemNm = "";
	var kindCd = "";
	var kindNm = "";
	var searchStrDate = "";
	var searchEndDate = "";
	var sidoCode = "";
	var type = $(":input:radio[name=rr2]:checked").val();
	var type2 = $(":input:radio[name=rr3]:checked").val();	// 금액/물량 기준
	var dateType = $(":input:radio[name=rr]:checked").val();
	// 개별 경매장 라디오 버튼
	var cmpCd2 = $(":input:radio[name=cmpCd2]:checked").val();
	
	cmpCd= [];	
	
	if($('#itemCd option:selected').val() !== undefined){
		itemCd = $('#itemCd option:selected').val();
		itemNm = $('#itemCd option:selected').text();
	}
	
	if($('#kindCd option:selected').val() !== undefined){
		kindCd = $('#kindCd option:selected').val();
		kindNm = $('#kindCd option:selected').text();
	}
	
	$('input:checkbox[name="cmpCd"]:checked').each(function(){
		cmpCd.push($(this).val());
	})
	
	// 부류 체크박스
	flowerCd = [];
	$('input:checkbox[name="flowerGubn"]:checked').each(function(){
		flowerCd.push($(this).val());
	})
		        	
	if($(":input:radio[name=rr]:checked").val() == "day"){
		searchStrDate = $("#searchStrDateD").val();
 		searchEndDate = $("#searchEndDateD").val();
		
	}else if($(":input:radio[name=rr]:checked").val() == "month"){
		searchStrDate = $("#searchStrDateM").val();
 		searchEndDate = $("#searchEndDateM").val();
	}else{
		searchStrDate = $("#searchStrDateY").val();
 		searchEndDate = $("#searchEndDateY").val();
	}

	// 우측하단 조회조건 년도, 시작일자의 년도
	var searchStrYear = searchStrDate.substring(0, 4);
	
	//fn_mapInit();	// 맵차트
	fn_chart(searchStrYear, itemCd, itemNm, kindCd, kindNm, flowerCd, sidoCode);		// 차트 조회조건 : 시작일자 년도, 품목코드, 품목명, 품종코드, 품종명, 부류, 시도코드
	fn_search();	// 조회
}

function datechktoday(date){
	if(date > new Date()) return [false]; return [true];
}

function auto_date_format( keyCode, oThis ){
	
	var num_arr = [ 
	      97, 98, 99, 100, 101, 102, 103, 104, 105, 96,
	      48, 49, 50, 51, 52, 53, 54, 55, 56, 57
	  ]
	  
	  if( num_arr.indexOf( Number( keyCode ) ) != -1 ){
	  
	      var len = oThis.value.length;
	      if( len == 4 ) oThis.value += "-";
	      if( len == 7 ) oThis.value += "-";
	  }
}

function dateComp(){
	var returnVal=false;
	var oriDt =$("#searchSaleDate").val();
	var dt= new Date();
	dt.setDate(dt.getDate()-6);
	
	yyyy= dt.getFullYear();
	m=dt.getMonth()+1;
	d=dt.getDate();

	if(m =="0"){
		m="12"; yyyy=yyyy-1;
	}
	if(m<10){
		m='0'+m;
	}
	if(d<10){
		d='0'+d;
	}
	begindate=yyyy+'-'+m+'-'+d;
	if(oriDt>=begindate){
		returnVal=true;
		init();
	}else{
		alert('일주일전 기간만 선택가능합니다');
		$("#searchSaleDate").val(begindate);
		
		cmpCd = $("#cmpCdTab .on > input").attr("value");
	}
	return returnVal;
}

//검색
function fn_search(){
	//조회조건
	var itemCd = "";
	var itemNm = "";
	var kindCd = "";
	var kindNm = "";
	var searchStrDate = "";
	var searchEndDate = "";
	var type = $(":input:radio[name=rr2]:checked").val();
	var type2 = $(":input:radio[name=rr3]:checked").val();	// 금액/물량 기준
	var dateType = $(":input:radio[name=rr]:checked").val();
	cmpCd = [];
	// 개별 경매장 라디오 버튼
	var cmpCd2 = $(":input:radio[name=cmpCd2]:checked").val();
	
	if($('#itemCd option:selected').val() !== undefined){
		itemCd = $('#itemCd option:selected').val();
		itemNm = $('#itemCd option:selected').text();
	}
	
	if($('#kindCd option:selected').val() !== undefined){
		kindCd = $('#kindCd option:selected').val();
		kindNm = $('#kindCd option:selected').text();
	}
	
	$('input:checkbox[name="cmpCd"]:checked').each(function(){
		cmpCd.push($(this).val());
	})
	
	// 부류 체크박스
	flowerCd = [];
	$('input:checkbox[name="flowerGubn"]:checked').each(function(){
		flowerCd.push($(this).val());
	})
		        	
	if($(":input:radio[name=rr]:checked").val() == "day"){
		searchStrDate = $("#searchStrDateD").val();
 		searchEndDate = $("#searchEndDateD").val();
		
	}else if($(":input:radio[name=rr]:checked").val() == "month"){
		searchStrDate = $("#searchStrDateM").val();
 		searchEndDate = $("#searchEndDateM").val();
	}else{
		searchStrDate = $("#searchStrDateY").val();
 		searchEndDate = $("#searchEndDateY").val();
	}

	// 기준 통합(T), 개별(E)
	if(type == "T"){
		// 우측상단 산지별집계(통합)
		fn_prodSearchTot(dateType, searchStrDate, searchEndDate, itemCd, itemNm, kindCd, kindNm, cmpCd, flowerCd, type2);	//기간, 품목, 품목명, 품종, 품종명, 경매장, 부류, 조회기준(금액/물량)
		
		// 좌측 지도유통비율(통합)
		fn_mapInit();
	}
	else{
		// 우측상단 산지별 집계(개별)
		fn_prodSearchEach(dateType, searchStrDate, searchEndDate, itemCd, itemNm, kindCd, kindNm, cmpCd2, flowerCd, type2);	//기간, 품목, 품목명, 품종, 품종명, 경매장, 부류
		
		// 좌측 지도유통비율(개별)	
		fn_mapInit();
	}	
}

//우측상단 산지별집계(통합)
//기간, 품목, 품종, 경매장
function fn_prodSearchTot(dateType, searchStrDate, searchEndDate, itemCd, itemNm, kindCd, kindNm, cmpCd, flowerCd, type2) {
	$.ajax({
		type : "post",
	    url : "/hga04/selectProdSearchTot.json",
	    data : {	
	    	// 조회조건
	    	dateType : dateType,
	    	searchStrDate : searchStrDate,
	    	searchEndDate : searchEndDate,
	    	itemCd : itemCd,
	    	itemNm : itemNm,
	    	kindCd : kindCd,
	    	kindNm : kindNm,
	    	cmpCd : cmpCd,
	    	flowerCd : flowerCd,
	    	type2 : type2
	    },
	    dataType : 'json', 
	    success : function(res){
	    	var resultList = res.selectProdSearchTot;
	    	var html = "";
		    var html2 = "";
		    var html3 = "";
		    
		    var sanName = "";	// 산지	
		    var av1 = 0;		// 평균
		    
		    if(resultList.length > 0){
		    	for(var i=0; i<resultList.length; i++){
	    			if(i<5){	// 한줄당 5개
						html +="<li>                                                  		";
						html +="	<h4 class=\"tit_si\">"+resultList[i].label+"</h4>       ";
						html +="	<div>                        							";
						html +="		<br>                                         		";
						html +="		<dl>                                          		";
						html +="			<dd><p class=\"sd_tit\">점유율 </p></dd>   			";
						html +="		</dl>                                         		";
						html +="		</br>                                         		";
						if(type2 == "QTY") {	// 물량
							html +="		<dl>                                          	";
							html +="			<dd><p class=\"sd_num\">"+resultList[i].av1+"%</p></dd>     ";
							html +="		</dl>                                         	";
							html +="		</br>                                         	";
							html +="		<dl>                                          	";
							html +="			<dd><p class=\"sd_tit\">수량</p></dd>   	";
							html +="		</dl>                                         	";
							html +="		</br>                                         	";
							html +="		<dl>                                          	";
							html +="			<dd><p class=\"sd_num\">"+comma(resultList[i].qty)+"만단</p></dd>     ";
							html +="		</dl>                                         	";
						}
						else {					// 금액
							html +="		<dl>                                          	";
							html +="			<dd><p class=\"sd_num\">"+resultList[i].av2+"%</p></dd>     ";
							html +="		</dl>                                         	";
							html +="		</br>                                         	";
							html +="		<dl>                                          	";
							html +="			<dd><p class=\"sd_tit\">금액</p></dd>   		";
							html +="		</dl>                                         	";
							html +="		</br>                                         	";							
							html +="		<dl>                                          	";
							html +="			<dd><p class=\"sd_num\">"+comma(resultList[i].amt)+"억원</p></dd>     ";
							html +="		</dl>                                         	";
						}
						html +="	</div>                                            		";
						html +="</li> 											      		";
					}
					else{
						html2 +="<li>                                                  		";
						html2 +="	<h4 class=\"tit_si\">"+resultList[i].label+"</h4>       ";
						html2 +="	<div>                        							";
						html2 +="		<br>                                         		";
						html2 +="		<dl>                                          		";
						html2 +="			<dd><p class=\"sd_tit\">점유율 </p></dd>   			";
						html2 +="		</dl>                                         		";
						html2 +="		<br>                                         		";
						if(type2 == "QTY") {		// 물량
							html2 +="		<dl>                                          	";
							html2 +="			<dd><p class=\"sd_num\">"+resultList[i].av1+"%</p></dd>     ";
							html2 +="		</dl>                                         	";
							html2 +="		<br>                                         	";	
							html2 +="		<dl>                                          	";
							html2 +="			<dd><p class=\"sd_tit\">금액/수량</p></dd>   	";
							html2 +="		</dl>                                         	";
							html2 +="		<br>                                         	";
							html2 +="		<dl>                                          	";
							html2 +="			<dd><p class=\"sd_num\">"+comma(resultList[i].qty)+"만단</p></dd>     ";
							html2 +="		</dl>										  	";
						}
						else {						// 금액
							html2 +="		<dl>                                          	";
							html2 +="			<dd><p class=\"sd_num\">"+resultList[i].av2+"%</p></dd>     ";
							html2 +="		</dl>                                         	";
							html2 +="		<br>                                         	";
							html2 +="		<dl>                                          	";
							html2 +="			<dd><p class=\"sd_tit\">금액</p></dd>   	";
							html2 +="		</dl>                                         	";
							html2 +="		<br>                                         	";							
							html2 +="		<dl>                                          	";
							html2 +="			<dd><p class=\"sd_num\">"+comma(resultList[i].amt)+"억원</p></dd>     ";
							html2 +="		</dl>										  	";
						}
						html2 +="	</div>                                            		";
						html2 +="</li> 											      		";
					}
		    	}					
		    }
		    $("#subDiv").html(html);
	    	$("#subDiv2").html(html2);
	    }
	});		
}

//우측상단 산지별 집계(개별)
//기간, 품목, 품종, 경매장
function fn_prodSearchEach(dateType, searchStrDate, searchEndDate, itemCd, itemNm, kindCd, kindNm, cmpCd2, flowerCd, type2){
	$.ajax({
		type : "post",
	    url : "/hga04/selectProdSearchEach.json",
	    data : {	
	    	// 조회조건
	    	dateType : dateType,
	    	searchStrDate : searchStrDate,
	    	searchEndDate : searchEndDate,
	    	itemCd : itemCd,
	    	itemNm : itemNm,
	    	kindCd : kindCd,
	    	kindNm : kindNm,
	    	cmpCd2 : cmpCd2,
	    	flowerCd : flowerCd,
	    	type2 : type2
	    },
	    dataType : 'json', 
	    success : function(res){
	    	var resultList = res.selectProdSearchEach;
	    	var html = "";
		    var html2 = "";
		    
		    var sanName = "";	// 산지	
		    var av1 = 0;		// 평균
		    
		    if(resultList.length > 0){
		    	for(var i=0; i<resultList.length; i++){
	    			if(i<5){	// 한줄당 5개
						html +="<li>                                                  		";
						html +="	<h4 class=\"tit_si\">"+resultList[i].sanName+"</h4>     ";
						html +="	<div>                        							";
						html +="		<br>                                         		";
						html +="		<dl>                                          		";
						html +="			<dd><p class=\"sd_tit\">점유율 </p></dd>   			";
						html +="		</dl>                                         		";
						html +="		<br>                                         		";
						if(type2 == "QTY") {		// 물량
							html +="		<dl>                                          	";
							html +="			<dd><p class=\"sd_num\">"+resultList[i].av1+"%</p></dd>     ";
							html +="		</dl>                                         	";
							html +="		<br>                                         	";	
							html +="		<dl>                                          	";
							html +="			<dd><p>수량</p></dd>   						";
							html +="		</dl>                                        	";
							html +="		<br>                                         	";
							html +="		<dl>                                          	";
							html +="			<dd><p class=\"sd_num\">"+comma(resultList[i].qty)+"만단</p></dd>     ";
							html +="		</dl>                                       	"; 
						}
						else {						// 금액
							html +="		<dl>                                          	";
							html +="			<dd><p class=\"sd_num\">"+resultList[i].av2+"%</p></dd>     ";
							html +="		</dl>                                         	";
							html +="		<br>                                         	";
							html +="		<dl>                                          	";
							html +="			<dd><p>금액</p></dd>   						";
							html +="		</dl>                                        	";
							html +="		<br>                                         	";
							html +="		<dl>                                          	";
							html +="			<dd><p class=\"sd_num\">"+comma(resultList[i].amt)+"억원</p></dd>     ";
							html +="		</dl>                                       	";
						}
						html +="	</div>                                            		";
						html +="</li> 											      		";
					}
					else{
						html2 +="<li>                                                  		";
						html2 +="	<h4 class=\"tit_si\">"+resultList[i].sanName+"</h4>     ";
						html2 +="	<div>                        							";
						html2 +="		<br>                                         		";
						html2 +="		<dl>                                          		";
						html2 +="			<dd><p class=\"sd_tit\">점유율 </p></dd>   			";
						html2 +="		</dl>                                         		";
						html2 +="		<br>                                         		";
						if(type2 == "QTY") {		// 물량
							html2 +="		<dl>                                          	";
							html2 +="			<dd><p class=\"sd_num\">"+resultList[i].av1+"%</p></dd>     ";
							html2 +="		</dl>                                         	";						
							html2 +="		<br>                                         	";
							html2 +="		<dl>                                          	";
							html2 +="			<dd><p class=\"sd_tit\">수량</p></dd>   		";
							html2 +="		</dl>                                         	";
							html2 +="		<br>                                         	";							
							html2 +="		<dl>                                          	";
							html2 +="			<dd><p class=\"sd_num\">"+comma(resultList[i].qty)+"만단</p></dd>     ";
							html2 +="		</dl>                                       	";
						}
						else {					// 금액							
							html2 +="		<dl>                                          	";
							html2 +="			<dd><p class=\"sd_num\">"+resultList[i].av2+"%</p></dd>     ";
							html2 +="		</dl>                                         	";						
							html2 +="		<br>                                         	";
							html2 +="		<dl>                                          	";
							html2 +="			<dd><p class=\"sd_tit\">금액</p></dd>   		";
							html2 +="		</dl>                                         	";
							html2 +="		<br>                                         	";							
							html2 +="		<dl>                                          	";
							html2 +="			<dd><p class=\"sd_num\">"+comma(resultList[i].amt)+"억원</p></dd>     ";
							html2 +="		</dl>                                       	";
						}
						html2 +="	</div>                                            		";
						html2 +="</li> 											      		";
					}
		    	}					
		    }
		    
		    $("#subDiv").html(html);
	    	$("#subDiv2").html(html2);			    
	    }
	});
	
}	

//map chart 생성, 조회
function fn_mapInit(){
	//조회조건
	var itemCd = "";
	var itemNm = "";
	var kindCd = "";
	var kindNm = "";
	var searchStrDate = "";
	var searchEndDate = "";
	var type = $(":input:radio[name=rr2]:checked").val();
	var type2 = $(":input:radio[name=rr3]:checked").val();	// 금액/물량 기준
	var dateType = $(":input:radio[name=rr]:checked").val();
	// 개별 경매장 라디오 버튼
	var cmpCd2 = $(":input:radio[name=cmpCd2]:checked").val();
	
	cmpCd= [];
	
	if($('#itemCd option:selected').val() !== undefined){
		itemCd = $('#itemCd option:selected').val();
		itemNm = $('#itemCd option:selected').text();
	}
	
	if($('#kindCd option:selected').val() !== undefined){
		kindCd = $('#kindCd option:selected').val();
		kindNm = $('#kindCd option:selected').text();
	}
	
	$('input:checkbox[name="cmpCd"]:checked').each(function(){
		cmpCd.push($(this).val());
	})
	
	// 부류 체크박스
	flowerCd = [];
	$('input:checkbox[name="flowerGubn"]:checked').each(function(){
		flowerCd.push($(this).val());
	})
		        	
	if($(":input:radio[name=rr]:checked").val() == "day"){
		searchStrDate = $("#searchStrDateD").val();
 		searchEndDate = $("#searchEndDateD").val();
		
	}else if($(":input:radio[name=rr]:checked").val() == "month"){
		searchStrDate = $("#searchStrDateM").val();
 		searchEndDate = $("#searchEndDateM").val();
	}else{
		searchStrDate = $("#searchStrDateY").val();
 		searchEndDate = $("#searchEndDateY").val();
	}
	
	var url = ""; 
	if(type == "T"){
		// 통합
		// 기간, 품목, 품종, 경매장
		url = "/hga04/selectMapSearchListTot.json"	
	}
	else{
		// 개별
		// 기간, 품목, 품종, 경매장
		url = "/hga04/selectMapSearchListEach.json"
	}	
	
	$.ajax({
		type : "post",
	    url : url,
	    data : {
	    	// 조회조건
	    	dateType : dateType,
	    	searchStrDate : searchStrDate,
	    	searchEndDate : searchEndDate,
	    	itemCd : itemCd,
	    	itemNm : itemNm, 
	    	kindCd : kindCd,
	    	kindNm : kindNm,
	    	cmpCd : cmpCd,
	    	cmpCd2 : cmpCd2,
	    	flowerCd : flowerCd,
	    	type2 : type2
	    },
	    dataType : 'json',   	           
	    success : function(res){        
	    	var resultList = "";
	    	if(type == "T"){
	    		// 통합
	    		resultList = res.selectMapSearchListTot;	    		
	    	}else{
	    		// 개별
	    		resultList = res.selectMapSearchListEach;
	    	} 
	    	
	    	var max = 0;
	    	var cnt = 0;
	    	var mapInteval = 10;
	    	mapData = resultList;
	    	var lastMapData = mapData.pop();
	    	mapInitData = mapData;
	    	
	    	var areaData = [];
	    	for(var i =0; i<mapData.length; i++){
	    		areaData.push(mapData[i]);
	    		cnt = i;
	    	}
	    	
	    	areaData.pop();
			mapData = areaData;
			
			for(var i=0; i<mapData.length; i++){
				if(type2 == "QTY") {	// 물류
					if(max < mapData[i].av1){
		    			max = mapData[i].av1;
		    		}	
				}
				else {					// 금액
					if(max < mapData[i].av2){
		    			max = mapData[i].av2;
		    		}
				}
	    	}
	    	
	    	mapInteval = (max/5).toFixed(0);
	    	if(mapInteval < 1){
	    		mapInteval = 1;
	    	}	    	

	    	if(type2 == "QTY") {		// 물량
	    		layoutStr = '<rMateMapChart>                                                                                                                                                                                       '
	  			  +'<MapChart id="mainMap1" drillDownEnabled="false" dataTipType="Type3" showDataTips="true" dataTipJsFunction="divDataTipFunction" followDataTip="true" itemClickJsFunction="itemClickFunction">                                                       '
	  			  +'	<series>                                                                                                                                                                                              '
	  			  +'		<MapSeries id="mapseries" interactive="false"  >                                                                                                                                                        '
	  			  +'			<stroke>                                                                                                                                                                                              '
	  			  +'				<Stroke color="#8C8C8C" weight="0.8" alpha="1"/>                                                                                                                                                      '
	  			  +'			</stroke>                                                                                                                                                                                             '
	  			  +'		</MapSeries>                                                                                                                                                                                          '
	  			  +'		<MapBubbleSeries id="bubble" radiusField="av1" maxRadius="30" minRadius="5" color="#6C6C6C" labelPosition="inside" displayName="Map" fontSize="12" labelJsFunction="labelFunction" horizontalCenterGapField="h" rangeLegendDataField="av1" itemRenderer="BallItemRenderer" >'
	  			  +'			<fill>                                                                                                                                                                                                '
	  			  +'				<SolidColor color="#60c0ea"/>                                                                                                                                                                         '
	  			  +'			</fill>                                                                                                                                                                                               '
	  			  +'			<showDataEffect>                                                                                                                                                                                      '
	  			  +'				<SeriesSlide duration="1000"/>                                                                                                                                                                        '
	  			  +'			</showDataEffect>                                                                                                                                                                                     '
	  			  +'			<stroke>                                                                                                                                                                                              '
	  			  +'				<Stroke color="#3C99C4" weight="0.5"/>                                                                                                                                                                '
	  			  +'			</stroke>                                                                                                                                                                                             '
	  			  +'		</MapBubbleSeries>                                                                                                                                                                                    '
	  			  +'	</series>                                                                                                                                                                                             '
	  			  +'</MapChart>                                                                                                                                                                                           '
	  			  +'<DataRangeLegend width="200" height="35" minimum="0" maximum="'+max+'" dataRangeHeight="20" fontSize="10" arrowOffset="0" interval="'+mapInteval+'" showArrow="true" tickGap="5" stroke="#000000" arrowColor="#ffffff" arrowStroke="#000000" colors="[#dcdfe8,#93D6F1,#4a88b7,#596283,#5b5e67]"/>'
	  			  +'</rMateMapChart>'; 
	    	}
	    	else {						// 금액
	    		layoutStr = '<rMateMapChart>                                                                                                                                                                                       '
	  			  +'<MapChart id="mainMap1" drillDownEnabled="false" dataTipType="Type3" showDataTips="true" dataTipJsFunction="divDataTipFunction2" followDataTip="true" itemClickJsFunction="itemClickFunction">                                                       '
	  			  +'	<series>                                                                                                                                                                                              '
	  			  +'		<MapSeries id="mapseries" interactive="false"  >                                                                                                                                                        '
	  			  +'			<stroke>                                                                                                                                                                                              '
	  			  +'				<Stroke color="#8C8C8C" weight="0.8" alpha="1"/>                                                                                                                                                      '
	  			  +'			</stroke>                                                                                                                                                                                             '
	  			  +'		</MapSeries>                                                                                                                                                                                          '
	  			  +'		<MapBubbleSeries id="bubble" radiusField="av2" maxRadius="30" minRadius="5" color="#6C6C6C" labelPosition="inside" displayName="Map" fontSize="12" labelJsFunction="labelFunction" horizontalCenterGapField="h" rangeLegendDataField="av2" itemRenderer="BallItemRenderer" >'
	  			  +'			<fill>                                                                                                                                                                                                '
	  			  +'				<SolidColor color="#60c0ea"/>                                                                                                                                                                         '
	  			  +'			</fill>                                                                                                                                                                                               '
	  			  +'			<showDataEffect>                                                                                                                                                                                      '
	  			  +'				<SeriesSlide duration="1000"/>                                                                                                                                                                        '
	  			  +'			</showDataEffect>                                                                                                                                                                                     '
	  			  +'			<stroke>                                                                                                                                                                                              '
	  			  +'				<Stroke color="#3C99C4" weight="0.5"/>                                                                                                                                                                '
	  			  +'			</stroke>                                                                                                                                                                                             '
	  			  +'		</MapBubbleSeries>                                                                                                                                                                                    '
	  			  +'	</series>                                                                                                                                                                                             '
	  			  +'</MapChart>                                                                                                                                                                                           '
	  			  +'<DataRangeLegend width="200" height="35" minimum="0" maximum="'+max+'" dataRangeHeight="20" fontSize="10" arrowOffset="0" interval="'+mapInteval+'" showArrow="true" tickGap="5" stroke="#000000" arrowColor="#ffffff" arrowStroke="#000000" colors="[#dcdfe8,#93D6F1,#4a88b7,#596283,#5b5e67]"/>'
	  			  +'</rMateMapChart>'; 
	    	}
	    	  

 			rMateMapChartH5.create("map1", "mapHolder", mapVars, "100%", "100%");

	    },
	});
}

function comma(num){
    var len, point, str; 
       
    num = num + ""; 
    point = num.length % 3 ;
    len = num.length; 
   
    str = num.substring(0, point); 
    while (point < len) { 
        if (str != "") str += ","; 
        str += num.substring(point, point + 3); 
        point += 3; 
    } 
     
    return str;
}

function selectFlowerGubnAll(selectAll,gubn){
	var checkboxes = document.getElementsByName(gubn);
	for(var i = 0; i < checkboxes.length; i++){
		checkboxes[i].checked = selectAll.checked;
	}
}

// 맵 차트 클릭 function
function itemClickFunction(seriesId, code, label, data) {
	// 조회조건
	var itemCd = "";
	var itemNm = "";
	var kindCd = "";
	var kindNm = "";
	var searchStrDate = "";
	var searchEndDate = "";
	var sidoCode = code;
	var type = $(":input:radio[name=rr2]:checked").val();
	var type2 = $(":input:radio[name=rr3]:checked").val();	// 금액/물량 기준
	var dateType = $(":input:radio[name=rr]:checked").val();
	// 개별 경매장 라디오 버튼
	var cmpCd2 = $(":input:radio[name=cmpCd2]:checked").val();
	
	cmpCd= [];	
	
	if($('#itemCd option:selected').val() !== undefined){
		itemCd = $('#itemCd option:selected').val();
		itemNm = $('#itemCd option:selected').text();
	}
	
	if($('#kindCd option:selected').val() !== undefined){
		kindCd = $('#kindCd option:selected').val();
		kindNm = $('#kindCd option:selected').text();
	}
	
	$('input:checkbox[name="cmpCd"]:checked').each(function(){
		cmpCd.push($(this).val());
	})
	
	// 부류 체크박스
	flowerCd = [];
	$('input:checkbox[name="flowerGubn"]:checked').each(function(){
		flowerCd.push($(this).val());
	})
		        	
	if($(":input:radio[name=rr]:checked").val() == "day"){
		searchStrDate = $("#searchStrDateD").val();
 		searchEndDate = $("#searchEndDateD").val();
		
	}else if($(":input:radio[name=rr]:checked").val() == "month"){
		searchStrDate = $("#searchStrDateM").val();
 		searchEndDate = $("#searchEndDateM").val();
	}else{
		searchStrDate = $("#searchStrDateY").val();
 		searchEndDate = $("#searchEndDateY").val();
	}

	// 우측하단 조회조건 년도, 시작일자의 년도
	var searchStrYear = searchStrDate.substring(0, 4);

	//fn_mapInit();	// 맵차트
	fn_chart(searchStrYear, itemCd, itemNm, kindCd, kindNm, flowerCd, sidoCode);		// 차트 조회조건 : 시작일자 년도, 품목코드, 품목명, 품종코드, 품종명, 부류, 시도코드
}

//-----------------------차트 설정 시작-----------------------
	
//rMate 차트 생성 준비가 완료된 상태 시 호출할 함수를 지정합니다.
var chartVars1 = "rMateOnLoadCallFunction=chartReadyHandler1";
//rMateChart 를 생성합니다.
//파라메터 (순서대로) 
//1. 차트의 id ( 임의로 지정하십시오. ) 
//2. 차트가 위치할 div 의 id (즉, 차트의 부모 div 의 id 입니다.)
//3. 차트 생성 시 필요한 환경 변수들의 묶음인 chartVars
//4. 차트의 가로 사이즈 (생략 가능, 생략 시 100%)
//5. 차트의 세로 사이즈 (생략 가능, 생략 시 100%)
//rMateChartH5.create("chart1", "chartHolder", chartVars, "100%", "55%"); 

//차트의 속성인 rMateOnLoadCallFunction 으로 설정된 함수.
//rMate 차트 준비가 완료된 경우 이 함수가 호출됩니다.
//이 함수를 통해 차트에 레이아웃과 데이터를 삽입합니다.
//파라메터 : id - rMateChartH5.create() 사용 시 사용자가 지정한 id 입니다.
function chartReadyHandler1(id) {
	document.getElementById(id).setLayout(makeLayout());	//makeLayout()  layoutStr1
	document.getElementById(id).setData(chartData1);
	checkData1(chartData1);
}

// Chart func
 function dataTipFuncPer(seriesId, seriesName, index, xName, yName, data, values){
	var html = "";
		html += values[0] + "<br>";
		html += seriesName + " : " + values[1];
	
	return html;
} 

//스트링 형식으로 레이아웃 정의.
// 차트 타이틀 날짜 구하기
function chartTitle(flag) {
	if(flag == "date") {
		// 조회조건의 기간 가져오기
		var searchStrDate = "";
		var searchEndDate = "";
		var searchStrDateConv = "";
		var searchEndDateConv = "";
		
		// 조회조건에서 년도만 가져오기
		var searchStrYear = searchStrDate.substring(0, 4);
		var chartTitle = "";
		var dt= new Date();
		dt.setDate(dt.getDate());

		var yyyy = dt.getFullYear();
		var m = dt.getMonth()+1;
		var d = dt.getDate();
		var d2 = dt.getDate()-1;	// 현재일 -1일
		
		if(m =="0"){
			m="12"; 
			yyyy=yyyy-1;
		}
		if(m<10){
			m='0'+m;
		}
		if(d<10){
			d='0'+d;
		}
		var curDate = yyyy+"-"+m+"-"+d;	// 현재일
		var curMonth = yyyy+"-"+m;		// 현재월
		var curYear = yyyy;				// 현재년
		
		if($(":input:radio[name=rr]:checked").val() == "day"){
			searchStrDate = $("#searchStrDateD").val();
	 		searchEndDate = $("#searchEndDateD").val();
	 		
	 		// 날짜 표현 변경
	 		searchStrDateConv = searchStrDate.replaceAll('-', '.');
	 		searchEndDateConv = searchEndDate.replaceAll('-', '.');
	 		
	 		// to날짜와 현재일자 비교
	 		if(searchEndDate == curDate){
	 			// from날짜, to날짜 비교
	 			if(searchStrDate < searchEndDate){
	 				chartTitle = '전일기준 ( '+searchStrDateConv+' ~ '+yyyy+'.'+m+'.'+d2+' )';	
	 			}
	 			else if(searchStrDate == searchEndDate){
	 				chartTitle = '전일기준 ( '+yyyy+'.'+m+'.'+d2+' ~ '+yyyy+'.'+m+'.'+d2+' )';		
	 			}
	 		}
	 		else if(searchEndDate < curDate){
	 			chartTitle = '조회기간( '+searchStrDateConv + ' ~ ' + searchEndDateConv+' )';
	 		}
			
		}else if($(":input:radio[name=rr]:checked").val() == "month"){
			searchStrDate = $("#searchStrDateM").val();
	 		searchEndDate = $("#searchEndDateM").val();
	 		
	 		// 날짜 표현 변경
	 		searchStrDateConv = searchStrDate.replaceAll('-', '.');
	 		searchEndDateConv = searchEndDate.replaceAll('-', '.');
	 		
	 		// to월과 현재월 비교
	 		if(searchEndDate == curMonth){
	 			// from월, to월 비교
	 			if(searchStrDate < searchEndDate){
	 				chartTitle = '전일기준 ( '+searchStrDateConv+' ~ '+yyyy+'.'+m+' )';	
	 			}
	 			else if(searchStrDate == searchEndDate){
	 				chartTitle = '전일기준 ( '+yyyy+'.'+m+' ~ '+yyyy+'.'+m+' )';		
	 			}
	 		}
	 		else if(searchEndDate < curMonth){
	 			chartTitle = '조회기간 ( '+searchStrDateConv + ' ~ ' + searchEndDateConv+' )';
	 		}
	 		
		}else{
			searchStrDate = $("#searchStrDateY").val();
	 		searchEndDate = $("#searchEndDateY").val();
	 		
	 		// to년과 현재년 비교
	 		if(searchEndDate == curYear){
	 			// from년, to년 비교
	 			if(searchStrDate < searchEndDate){
	 				chartTitle = '전일기준 ( '+searchStrDate+' ~ '+yyyy+' )';	
	 			}
	 			else if(searchStrDate == searchEndDate){
	 				chartTitle = '전일기준 ( '+yyyy+' ~ '+yyyy+' )';		
	 			}
	 		}
	 		else if(searchEndDate < curYear){
	 			chartTitle = '조회기간 ( '+searchStrDate + ' ~ ' + searchEndDate+' )';
	 		}
		}
		return chartTitle;
	}
	else if(flag == "unit") {
		var type2 = $(":input:radio[name=rr3]:checked").val();
		var chartUnit = "";
		if(type2 == "QTY") {	// 물량
			chartUnit = "단위 : 만(단)";
		}
		else {					// 금액
			chartUnit = "단위 : 만(원)";
		}
		return chartUnit;
	}
}

// 우측하단 유통현황 차트 layout 동적 생성
function makeLayout() {
	var setTile = chartTitle("date");
	var setUnit = chartTitle("unit");
	
	var layoutStr1 = 
		'<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'
			+'<Options>'
			+'<Caption text="'+ setTile + '" />'		
		    +'</Options>'
		    +'<NumberFormatter id="numFmt" useThousandsSeparator="true"/>'	    
		    +'<Box width="100%" height="20" horizontalAlign="right" verticalAlign="middle">'
				+'<Label text="'+ setUnit +'" color="red"/>'
		    +'</Box>'
		    +'<Column2DChart showDataTips="true" columnWidthRatio="0.7" selectionMode="single" displayCompleteCallFunction="displayCallFunction" dataTipJsFunction="dataTipFuncPer" >'
			    +'<horizontalAxis>'
			    	+'<CategoryAxis id="hAxis" categoryField="mth"/>'		// padding="0.4"
		        +'</horizontalAxis>'
		        +'<verticalAxis>'
		        	+'<LinearAxis id="vAxis" interval="200" formatter="{numFmt}"/>'
		        +'</verticalAxis>'
		        +'<series>'
		        	+'<Column2DSeries yField="qty" halfWidthOffset="20" labelPosition="outside">'
		        		+'<fill>'
		        			+'<SolidColor color="#536BC9" alpha="1"/>'
			            +'</fill>'
	                    +'<showDataEffect>'
	                    	+'<SeriesInterpolate/>'
		                +'</showDataEffect>'
			      	+'</Column2DSeries>'		      
		        +'</series>'	        
		     	+'<verticalAxisRenderers>'
		     		+'<Axis2DRenderer axis="{vAxis}" left="15px;" showLine="false"/>'
		     	+'</verticalAxisRenderers>'
		     +'</Column2DChart>'
		+'</rMateChart>'; 
		
	return layoutStr1;
} 
	                                                                                                                                                             
//차트 데이터
var chartData1 = [];

function checkData1(data){
	if(data.length <= 0){
		// 데이터가 없을 경우 hasNoData함수를 실행하여 메세지창을 출력한다.
		//document.getElementById("chart1").hasNoData(true);
		// hasNoData(false); - 데이터가 존재하지 않으므로 차트의 기본 구조도 보이지 않아야 한다면 false로 주어 차트 전체의 visible을 false로 설정합니다.
		// hasNoData(true);  - 데이터가 존재하지 않아도 차트의 기본 구조는 보여야 한다면 true로 주어 visible을 true로 설정합니다.
	}
}

// mapChart func
function displayCallFunction(){
	/* 
	if(chartData2.length==1){
		$('#chartHolder2 .rMateH5__Column2DChart > canvas:eq(1)').css('left','125px');
	}else if(chartData2.length==2){
		$('#chartHolder2 .rMateH5__Column2DChart > canvas:eq(1)').css('left','62.5px');
	}else if(chartData2.length==3){
		$('#chartHolder2 .rMateH5__Column2DChart > canvas:eq(1)').css('left','41px');
	}else if(chartData2.length==4){
		$('#chartHolder2 .rMateH5__Column2DChart > canvas:eq(1)').css('left','31px');
	}else if(chartData2.length==5){
		$('#chartHolder2 .rMateH5__Column2DChart > canvas:eq(1)').css('left','25px');
	} */
}

function axisLabelFunc(id, value)
{
	return value;
}
//-----------------------차트 설정 끝 -----------------------
// 우측하단 유통현황 차트
function fn_chart(searchStrYear, itemCd, itemNm, kindCd, kindNm, flowerCd, sidoCode){
	
	var type = $(":input:radio[name=rr2]:checked").val();
	var type2 = $(":input:radio[name=rr3]:checked").val();	// 금액/물량 기준
	var dateType = $(":input:radio[name=rr]:checked").val();
	var searchStrDate = "";
	var searchEndDate = "";
	
	if($(":input:radio[name=rr]:checked").val() == "day"){
		searchStrDate = $("#searchStrDateD").val();
 		searchEndDate = $("#searchEndDateD").val();
		
	}else if($(":input:radio[name=rr]:checked").val() == "month"){
		searchStrDate = $("#searchStrDateM").val();
 		searchEndDate = $("#searchEndDateM").val();
	}else{
		searchStrDate = $("#searchStrDateY").val();
 		searchEndDate = $("#searchEndDateY").val();
	}
	
	var url = ""; 
	if(type == "T"){
		// 통합
		// 연도, 품목, 품종
		url = "/hga04/selectDistSearchTot.json"	
	}
	else{
		// 개별
		// 연도, 품목, 품종
		url = "/hga04/selectDistSearchEach.json"
	}
	$.ajax({
		type : "post",
	    url : url,
	    data : {
	    	// 조회조건
	    	searchStrYear : searchStrYear,
	    	itemCd : itemCd,
	    	itemNm : itemNm,
	    	kindCd : kindCd,
	    	kindNm : kindNm,
	    	flowerCd : flowerCd,
	    	type2 : type2,
	    	sidoCode : sidoCode,
	    	searchStrDate : searchStrDate,
	    	searchEndDate : searchEndDate,
	    	dateType : dateType
	    },
	    dataType : 'json',   	           
	    success : function(res){        
	    	var resultList = "";
	    	if(type == "T"){
	    		// 통합
	    		resultList = res.selectDistSearchTot;	    		
	    	}else{
	    		// 개별
	    		resultList = res.selectDistSearchEach;
	    	}
	    	
	    	if(resultList.length > 0){
	    		chartData1 = resultList;
			    
		    	rMateChartH5.create("chart1", "chartHolder", chartVars1, "100%", "100%");
		    	
	    	}else{
	    		chartNullData = [];
	    		document.getElementById("chart1").setLayout(makeLayout());
		    	document.getElementById("chart1").setData(chartNullData);  			    	
	    	}
	    },
	});
}

function fn_printDiv(id){
	//$(".imgBtn1").css("display","none");
	//$(".btn_search").css("display","none");
	var fileName = "주출하지별 출고현황";
	var div = $("#"+id).get(0);
	mapApp = document.getElementById("map1");
	mapRoot = mapApp.getRoot();
	mapRoot.saveImage('printArea', fileName, "png", "http://demo.riamore.net/demo/chart/downloadLocal.jsp");
	//$(".imgBtn1").css("display","");
	//$(".btn_search").css("display",""); 
	
/* 	rMateChartH5.downloadToLocal("rMateChartH5", "png", "http://demo.riamore.net/demo/chart/downloadLocal.jsp", function(){
		return document.getElementById("map1").saveAsImage();
    }); */
}

function saveAsImage(){
	   rMateChartH5.downloadToLocal("rMateChartH5", "png", "http://demo.riamore.net/demo/chart/downloadLocal.jsp", function(){
	      return document.getElementById("chart1").saveAsImage();
	     });
	}

</script>	

</head>

<body> 
	<!-- warp(S) -->
	<div class="wrap">
		
		<jsp:include page="../inc/2020/IncHeader.jsp"/>
		
		<!--공통 HEADER(S)-->
		<div class="lnb_box">
			<ul>
				<li><img src="../images/2020/m_lnb_img.png" alt="집"></li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li>통계기타</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li class="m_right">주출하지별 출고현황</li>
			</ul>
		</div>		
		<!--공통 HEADER(E)-->
		
		<!--서브 타이틀(S)-->
		<jsp:include page="../inc/2020/IncShare.jsp"/>
		
		<div class="sub_title">
			<div class="title_box">
				<h2>주출하지별 출고현황</h2>
				<img src="../images/2020/sub/t_line.png" alt="방울점선">
			</div>
		</div>
		<!--서브 타이틀(E)-->
	
		<!-- sub-conts(S) -->
		<div class="sub_contents">
			<!-- search box(S) -->
			<div class="search_box_new statistic">
				<input type="hidden" id="searchStrDate" value="${searchStrDate}">
				<input type="hidden" id="searchEndDate" value="${searchEndDate}">
				<div class="s-line">
					<h4 class="sbn_tit_01">기준</h4>
					<ul class="grow_check_box">						
						<li>
							<input type="radio" id="rr111" name="rr2" value="E" checked>
							<label for="rr111" class="title_box_chk"><em class="txt">개별</em><span></span></label>
						</li>	
						<li>
							<input type="radio" id="rr000" name="rr2" value="T" >
							<label for="rr000" class="title_box_chk"><em class="txt">통합</em><span></span></label>
						</li>
						<li><label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label></li>			
						<li>
							<input type="radio" id="rr0000" name="rr3" value="QTY" checked>
							<label for="rr0000" class="title_box_chk"><em class="txt">물량</em><span></span></label>
						</li>
						<li>
							<input type="radio" id="rr1111" name="rr3" value="AMT" >
							<label for="rr1111" class="title_box_chk"><em class="txt">금액</em><span></span></label>
						</li>										
					</ul>
				</div>
				<!-- 부류 (s) -->
				<div class="s-line">
					<h4 class="sbn_tit_01">부류</h4>
					<ul class="grow_check_box">
						<li>
							<input type="checkbox" id="chk01" name="flowerGubn" value="1" checked>
							<label for="chk01" class="title_box_chk"><em class="txt">절화</em><span></span></label>
						</li>
						<li>
							<input type="checkbox" id="chk02" name="flowerGubn" value="3">
							<label for="chk02" class="title_box_chk"><em class="txt">난</em><span></span></label>
						</li>
						<li>
							<input type="checkbox" id="chk03" name="flowerGubn" value="2">
							<label for="chk03" class="title_box_chk"><em class="txt">관엽</em><span></span></label>
						</li>
						<li>
							<input type="checkbox" id="chk04" name="flowerGubn" value="4">
							<label for="chk04" class="title_box_chk"><em class="txt">춘란</em><span></span></label>
						</li>
						<li>
							<input type="checkbox" id="chk05" name="flowerGubn" onclick='selectFlowerGubnAll(this,"flowerGubn")' value="5">
							<label for="chk05" class="title_box_chk"><em class="txt">전체</em><span></span></label>
						</li>
					</ul>
				</div>		
				<!-- 부류 (e) -->
				<div class="s-line">
					<h4 class="sbn_tit_01">경매장</h4>
					<!-- 통합 경매장 체크박스 s -->
					<ul class="grow_check_box" id="tCmp">						
						<li>
							<input type="checkbox" id="chk77" name ="cmpCd" onclick='selectFlowerGubnAll(this,"cmpCd")'>
							<label for="chk77" class="title_box_chk"><em class="txt">전체</em><span></span></label>
						</li>
						<li>
							<input type="checkbox" id="chk00" name ="cmpCd" value="0000000001"  checked>
							<label for="chk00" class="title_box_chk"><em class="txt">at화훼(양재)</em><span></span></label>
						</li>
						<li>
							<input type="checkbox" id="chk11" name ="cmpCd" value="1508500020">
							<label for="chk11" class="title_box_chk"><em class="txt">부산화훼(엄궁)</em><span></span></label>
						</li>
						<li>
							<input type="checkbox" id="chk22" name ="cmpCd" value="6068207466">
							<label for="chk22" class="title_box_chk"><em class="txt">부경화훼(강동)</em><span></span></label>
						</li>
						<li>
							<input type="checkbox" id="chk33" name ="cmpCd" value="4108212335">
							<label for="chk33" class="title_box_chk"><em class="txt">광주원예(풍암)</em><span></span></label>
						</li>
						<li>
							<input type="checkbox" id="chk44" name ="cmpCd" value="3848200087">
							<label for="chk44" class="title_box_chk"><em class="txt">한국화훼(음성)</em><span></span></label>
						</li>
						<li>
							<input type="checkbox" id="chk55" name ="cmpCd" value="1288202296">
							<label for="chk55" class="title_box_chk"><em class="txt">한국화훼(과천)</em><span></span></label>
						</li>
						<li>
							<input type="checkbox" id="chk66" name ="cmpCd" value="9999999999">
							<label for="chk66" class="title_box_chk"><em class="txt">영남화훼(김해)</em><span></span></label>
						</li>
					</ul>
					<!-- 통합 경매장 체크박스 e -->
					
					<!-- 개별 경매장 라디오 s-->
					<ul class="grow_check_box" id="sCmp">
						<li>
							<input type="radio" id="chk000" name ="cmpCd2" value='0000000001' checked>
							<label for="chk000" class="title_box_chk"><em class="txt">at화훼(양재)</em><span></span></label>
						</li>
						<li>
							<input type="radio" id="chk011" name ="cmpCd2" value="1508500020">
							<label for="chk011" class="title_box_chk"><em class="txt">부산화훼(엄궁)</em><span></span></label>
						</li>
						<li>
						<input type="radio" id="chk022" name ="cmpCd2" value="6068207466">
						<label for="chk022" class="title_box_chk"><em class="txt">부경화훼(강동)</em><span></span></label>
						</li>
						<li>
						<input type="radio" id="chk033" name ="cmpCd2" value="4108212335">
						<label for="chk033" class="title_box_chk"><em class="txt">광주원예(풍암)</em><span></span></label>
						</li>
						<li>
						<input type="radio" id="chk044" name ="cmpCd2" value="3848200087">
						<label for="chk044" class="title_box_chk"><em class="txt">한국화훼(음성)</em><span></span></label>
						</li>
						<li>
						<input type="radio" id="chk055" name ="cmpCd2" value="1288202296">
						<label for="chk055" class="title_box_chk"><em class="txt">한국화훼(과천)</em><span></span></label>
						</li>
						<li>
						<input type="radio" id="chk066" name ="cmpCd2" value="9999999999">
						<label for="chk066" class="title_box_chk"><em class="txt">영남화훼(김해)</em><span></span></label>
						</li>
					</ul>
					<!-- 개별 경매장 라디오 e-->					
				</div>
				<div class="s-line">
					<h4 class="sbn_tit_01">기간</h4>					
					<div class="grow_check_box">
						<div class="date-from-to" id="searchDateD">
							<div class="calendar_new">
								<input type="text" alt="켈린더" id="searchStrDateD" value="${searchStrDate}"/>
							</div>
							<span class="hyphen">~</span>
							<div class="calendar_new">
								<input type="text" alt="켈린더" id="searchEndDateD" value="${searchEndDate}"/>
							</div>
						</div>
						<div class="date-from-to" id="searchDateM">
							<div class="calendar_new">
								<input type="text" alt="켈린더" id="searchStrDateM" value="${searchStrDateM}"/>
							</div>
							<span class="hyphen">~</span>
							<div class="calendar_new">
								<input type="text" alt="켈린더" id="searchEndDateM" value="${searchEndDateM}"/>
							</div>
						</div>
						<div class="date-from-to" id="searchDateY">
							<div class="calendar_new">
								<input type="text" alt="켈린더" id="searchStrDateY" value="${searchStrDateY}"/>
							</div>
							<span class="hyphen">~</span>
							<div class="calendar_new">
								<input type="text" alt="켈린더" id="searchEndDateY" value="${searchEndDateY}"/>
							</div>
						</div>
						<li>
							<input type="radio" id="rr00" name="rr" value="day">
							<label for="rr00" class="title_box_chk"><em class="txt">일</em><span></span></label>
						</li>
						<li>
							<input type="radio" id="rr11" name="rr" value="month">
							<label for="rr11" class="title_box_chk"><em class="txt">월</em><span></span></label>
						</li>
						<li>
							<input type="radio" id="rr22" name="rr" value="year" checked>
							<label for="rr22" class="title_box_chk"><em class="txt">연</em><span></span></label>
						</li>
					</div>
					
				</div>
				<div class="s-line">
					<h4 class="sbn_tit_01">품목</h4>
					<div class="sb_common_01">
						<select class="form-control" id="itemCd" name="itemCd" onchange="getItem2();">
						</select>
					</div>
				</div>	
				<div class="s-line">
					<h4 class="sbn_tit_01">품종</h4>
					<div class="sb_common_01">
						<select class="form-control" id="kindCd" name="kindCd">
						</select>	
											
						<div class="search_btn" id="imgBtn1" >
							<a href="javascript:fn_printDiv('printArea');"><img src="../images/2020/sub/icon_download.png" alt="이미지저장">이미지</a>
						</div>
						
						<div class="search_btn" id="excelBtn1">
							<a href="#!"><img src="../images/2020/exel.png" alt="엑셀저장">엑셀저장</a>
						</div>
						
						<div class="search_btn">						
							<a href="javascript:searchBtn();"><img src="../images/2020/sub/search_img.png" alt="돋보기">검색</a>								
						</div>	
												
					</div>					
				</div>					
			</div>
		<!-- search box(E) -->
			
		<div class="sub_guide" id="printArea">
			<div class="img_capture mt30" >				
				<div class="area mt20 a1">
					<!-- 좌측 지도(S) -->
					<div class="map_chart" >
						<div id="mapHolder" style="width:100%;height:100%;"></div>
					</div>
					<!-- 좌측 지도(E) -->
					<!-- 우측 상단(S) -->
					<div class="cont_right_b"  >
						<div class="cont_box_b">							
							<div class="sub_info_box" >								
								<div class="map_chart_detail" >
									<h2 class="title_02">주출하시군 (상위 10개  시군)</h2>
									<ul class="state_info" id="subDiv" >
									</ul>
									<ul class="state_info" id="subDiv2" >								
									</ul>
									<ul class="state_info" id="subDiv3" >								
									</ul>
								</div>		
							</div>													
						</div>
					</div>
					<!-- 우측 상단(E) -->	
				</div>
				<!-- 우측 하단(S) -->
				<div class="cont_right_b"  >
					<div class="cont_box_b">						
						<div class="sub_info_box">
							<h2 class="title_02">유통현황</h2>
							<div class="info_box h-type-01" id="chartHolder" style="width:100%; height:340px;">
							</div>							
						</div>
					</div>
				</div>
				<!-- 우측 하단(E) -->									
			</div>			
		<!-- sub-conts(E) -->
		</div>				
	</div>
	
	<jsp:include page="../inc/2020/IncFooter.jsp"/>
	<!-- wrap(E) -->	
</body>
</html>

