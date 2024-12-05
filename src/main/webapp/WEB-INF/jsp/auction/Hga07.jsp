<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, user-scalable=no">
	<meta name="apple-mobile-web-app-title" content="화훼유통정보시스템">
	<meta name="robots" content="no-index,follow">
	<meta name="og:title" content="화훼유통정보시스템">
	<meta name="og:description" content="화훼유통정보시스템">
	<meta name="description" content="식물검역정보">
	<meta name="content" content="화훼유통정보시스템 입니다.">
	<meta name="keywords" content="화훼경매시세, 화훼경매가격, Korea aT flower market auction price, 화훼공판장, 화훼거래정보, 꽃시장, 꽃값">
	<meta name="Author" content="화훼유통정보시스템 & www.woorim.co.kr : Kim Juyeon">
	<title>지역별 화훼관련 사업체 정보</title>
	
	<%@include file="../common/2020/commonJs.jsp" %>	
	<%@include file="../common/2020/commonCss.jsp" %>
	
	<style>
		#loading-indicator-back {
			background: rgba(0,0,0,.5) ;
			display: none;
		    position: fixed;
		    z-index: 999;
		    height: 100%;
		    width: 100%;
		    left: 0;
		    top: 0;
		}

		#loading-indicator {
		
			background:  url( '/images/loadingBar.gif' ) no-repeat;
			display: none;
		    position: fixed;
		    z-index: 999;
		    height: 100%;
		    width: 100%;
		    left: 50%;
		    top: 50%;
		}
		.conts_left {
		    float: left;
    		width: 50%;
    		overflow: hidden;
    		pointer-events : none;
		}
		.conts_right {
		    float: right;
    		width: 50%;
    		/*overflow: hidden;*/
		}
		
		.title_cus {
			position: static;
		    margin: 30px 0px 30px 0px;
		    color: #000859;
		    font-size: 22px;
		    font-weight: bold;
		}
		
		.ui-th-column {
			/*border: 1px solid;*/
		}
		.ui-widget.ui-widget-content {
    width: 100% !important;
}
	.ui-jqgrid .ui-jqgrid-view {
    width: 100% !important;
}
.ui-jqgrid .ui-jqgrid-htable {
    width: 100% !important;
}
		
@media screen and (max-width: 930px){
		.conts_left{
		    width: 100%;
		}
		.conts_right{
		    width: 100%;
		    float: inherit;
		    overflow: auto;
		}
		.rMateH5__MapChart {width: 100% !important;}
	}	
	</style>
	
	<script type="text/javascript">
	// -----------------------맵차트 설정 시작-----------------------
	// rMate 맵차트 생성 준비가 완료된 상태 시 호출할 함수를 지정합니다.
	var mapVars = "rMateOnLoadCallFunction=mapReadyHandler";
	var mapVars2 = "rMateOnLoadCallFunction=mapReadyHandler2";
	var remotehost = "<%=request.getRemoteHost()%>";
	
	// 맵차트의 속성인 rMateOnLoadCallFunction 으로 설정된 함수.
	// rMate 맵차트 준비가 완료된 경우 이 함수가 호출됩니다.
	// 이 함수를 통해 맵차트에 레이아웃과 데이터를 삽입합니다.
	// 파라메터 : id - rMateMapChartH5.create() 사용 시 사용자가 지정한 id 입니다.
	// 맵차트 콜백함수 7개 존재합니다.
	// 1. setLayout - 스트링으로 작성된 레이아웃 XML을 삽입합니다.
	// 2. setData - 배열로 작성된 데이터를 삽입합니다.
	// 3. setMapDataBase - 스트링으로 작성된 MapData XML을 삽입합니다.
	// 4. setLayoutURLEx - 레이아웃 XML 경로를 지시합니다.
	// 5. setDataURLEx - 데이터 XML 경로를 지시합니다.
	// 6. setMapDataBaseURLEx - MapData XML 경로를 지시합니다.
	// 7. setSourceURLEx - Map Source 경로를 지시합니다.
	function mapReadyHandler(id) {
 		document.getElementById(id).setLayout(layoutStr);
   		document.getElementById(id).setData(mapData);
   		document.getElementById(id).setMapDataBaseURLEx(mapDataBaseURL);
    	document.getElementById(id).setSourceURLEx(sourceURL);
	}
	function mapReadyHandler2(id) {
 		document.getElementById(id).setLayout(layoutStr2);
   		document.getElementById(id).setData(mapData);
   		document.getElementById(id).setMapDataBaseURLEx(mapDataBaseURL2);
    	document.getElementById(id).setSourceURLEx(sourceURL);
	}
	 
	// Map Data 경로 정의
	// setMapDataBase함수로 mapDataBase를 문자열로 넣어줄 경우 주석처리나 삭제하십시오.
	//var mapDataBaseURL = "./MapDataBaseXml/SouthKorea.xml";
	var mapDataBaseURL = "";
	if(remotehost == "0:0:0:0:0:0:0:1" || remotehost == "127.0.0.1"){
		mapDataBaseURL = "/rMateMapChart/Samples/MapDataBaseXml/SouthKoreaDrillDown_opacity.xml"; // 개발
	} else {
		mapDataBaseURL = "/rMateMapChart/xml/MapDataBaseXml/SouthKoreaDrillDown_opacity.xml"; // 운영
	}
	//var mapDataBaseURL = "/rMateMapChart/xml/MapDataBaseXml/SouthKoreaDrillDown_opacity.xml"; // 운영
	//var mapDataBaseURL = "/rMateMapChart/Samples/MapDataBaseXml/SouthKoreaDrillDown_opacity.xml"; // 개발
	//var mapDataBaseURL2 = "/rMateMapChart/Samples/MapDataBaseXml/SouthKoreaDrillDown2.xml"; // 개발
	 
	// MapChart Source 선택
	// MapSource 디렉토리의 지도 이미지중 택일가능하며, 이외에 사용자가 작성한 별도의 Svg이미지를 지정할 수 있습니다.(매뉴얼 참조)
	//var sourceURL = "./MapSource/SouthKorea.svg";
	//var sourceURL = "/rMateMapChart/Samples/MapSource/SouthKoreaDrillDownSeoulDong.svg"; // 운영
	var sourceURL = "/rMateMapChart/Samples/MapSource/SouthKoreaDrillDown.svg"; // 개발
	 
	// rMateMapChart 를 생성합니다.
	// 파라메터 (순서대로) 
	//  1. 맵차트의 id ( 임의로 지정하십시오. ) 
	//  2. 맵차트가 위치할 div 의 id (즉, 차트의 부모 div 의 id 입니다.)
	//  3. 맵차트 생성 시 필요한 환경 변수들의 묶음인 chartVars
	//  4. 맵차트의 가로 사이즈 (생략 가능, 생략 시 100%)
	//  5. 맵차트의 세로 사이즈 (생략 가능, 생략 시 100%)

	 
	var layoutStr = '';
	layoutStr += '<?xml version="1.0" encoding="utf-8"?>';
    layoutStr += '<rMateMapChart>';
        layoutStr += '<MapChart id="mainMap"  dataTipJsFunction="dataTipFunction"  showDataTips="true" >';
            layoutStr += '<series>';
                layoutStr += '<MapSeries id="mapseries"    labelJsFunction="labelFunction"   labelPosition="inside" displayName="Map Series">';
                    layoutStr += '<showDataEffect>';
                        layoutStr += '<SeriesInterpolate duration="1000"/>';
                    layoutStr += '</showDataEffect>';
                    layoutStr += '<stroke>';
                        layoutStr += '<Stroke color="#CAD7E0" weight="0.8" alpha="1"/>';
                    layoutStr += '</stroke>';
                    layoutStr += '<rollOverStroke>';
                        layoutStr += '<Stroke color="#CAD7E0" weight="0.8" alpha="1"/>';
                    layoutStr += '</rollOverStroke>';
                layoutStr += '</MapSeries>';
            layoutStr += '</series>';
        layoutStr += '</MapChart>';
    layoutStr += '</rMateMapChart>';
		
	var gDataList;
	var mapData;
	var loc;
	var checkedval = [];
	var loclvl3 = '';
	// -----------------------맵차트 설정 끝 -----------------------
	
	
		$(window).on('resize.jqGrid', function () {
		    //$("#jqGrid").jqGrid( 'setGridWidth', $(".plants_graph_b > div").width());
		    //$("#jqGrid2").jqGrid( 'setGridWidth', $(".plants_list_b > div").width());
		    //$(".ui-jqgrid-bdiv").width($(".ui-jqgrid-bdiv").width()+1);
		});
	
		var yyyymm = null;
		var itemCd = null;
		var gVAL = 0;
		function dataTipFunction(seriesId, code, label, data) {
			let c=0;
			console.log("검색시 데이터1",gDataList)
		    for(let i=1;i<=gDataList.length;i++){
				if(typeof gDataList[i] != "undefined"){
					console.log("code1-1:",gDataList[i].code,code)
					console.log("code1-2:",gDataList[i].VAL)
					//console.log("code2:",gDataList[i].code2)
					if(code == gDataList[i].code){
						c += (gDataList[i].VAL)
						//console.log("같을때")
						//return "첫번째:"+ c
					} else if(code == '1701'){
						c += (gDataList[i].VAL)
						//c += (gDataList[i].VAL)
						//console.log("다을때",gDataList[i])
						//return "두번째:" + c
					}	
				}
				
			}
			console.log(label)
		    return label + "<br>" + '화훼관련 총합 : ' + c
			//return label + ''  + '<br>' + '화훼관련 총합 : ' + gVAL; 
			
			 if (code == "100" || data.sales < 30)
			        return label+":저조";
			 else if (code == "1500" || data.sales < 50)
			      return label+":보통";
			 else if (data.sales < 90)
			        return label+":양호";
			 else
			        return label+":우수";
			}
		
		function clickFunction2(code, label, data) {
			 //alert("code:"+code+"\nlabel:"+label+"\ndata:"+data);
			 console.log("code:"+code+"\nlabel:"+label+"\ndata:"+data);
			 console.log(document.getElementById("map2"));
			 return 
		}
		
		function itemClick(seriesId, code, label,data){
			 locClickEvent(code, label, data); 
		}
		
		function labelFunction(seriesId, code, label, data) {
		    //console.log('라벨펑션 : ',seriesId, code, label, data, gDataList);
			let c=0;
		    for(let i=1;i<=gDataList.length;i++){
				if(typeof gDataList[i] != "undefined"){
					console.log("code1-1:",gDataList[i].code,code)
					console.log("code1-2:",gDataList[i].VAL)
					//console.log("code2:",gDataList[i].code2)
					if(code == gDataList[i].code){
						c += (gDataList[i].VAL)
						//console.log("같을때")
						//return "첫번째:"+ c
					} else if(code == '1701'){
						c += (gDataList[i].VAL)
						//c += (gDataList[i].VAL)
						//console.log("다을때",gDataList[i])
						//return "두번째:" + c
					}	
				}
				
			}
			console.log(label)
		    return label + "<br>" +c
		    if (code == "900") {
		    	return '{"text":"1위"'+label+'"특별시"+data.VAL+"", "color":"#ffffff", "fontSize":"13", "fontWeight":"bold", "lineHeight":5}';
		    }else {
		    	return '{"text":"'+label+'", "color":"#24b52e", "fontSize":"13", "fontWeight":"bold", "lineHeight":5}';
		    }
		}
		function colorFunction2(code, label, data) {
			console.log("색상영역자바스크")//localFillByRange="[#dcdfe8,#93D6F1,#4a88b7,#596283,#5b5e67]"
			if(typeof data == "undefined")
				return "#FF0000";
			let cmp = data.VAL;
			console.log(cmp)
			
			if(cmp > 2000 ){
				return "#f20515"
			} else if(cmp > 1000) {
				return "#1009db"
			} else if(cmp > 100) {
				return "#11ed44"
			} else {
				return "#11ed44"
			}
		}
		
		function colorFunction(code, label, data) {
			 if (code.toString().indexOf("0000") > -1 )
		      	return "#c7e5ef";
		   	 else
				return "#ebf0f4";
			 
			
			/*let cmp = parseInt(data.VAL2.substring(5,data.VAL2.length));
			if(cmp > 2000 ){
				return "#f20515"
			} else if(cmp > 1000) {
				return "#1009db"
			} else if(cmp > 100) {
				return "#11ed44"
			}*/
		}
		
		function locClickEvent(code, label, data) {
			loc = "";
			if(label.indexOf("서울") != -1){
				loc = "11"
			} else if(label.indexOf("부산") != -1){
				loc = "21"
			} else if(label.indexOf("제주") != -1){
				loc = "39"
			} else if(label.indexOf("경상남도") != -1){
				loc = "38"
			} else if(label.indexOf("전라북도") != -1){
				loc = "35"
			} else if(label.indexOf("충청남도") != -1){
				loc = "34"
			} else if(label.indexOf("경기도") != -1){
				loc = "31"
			} else if(label.indexOf("전라남도") != -1){
				loc = "36"
			} else if(label.indexOf("강원도") != -1){
				loc = "32"
			} else if(label.indexOf("경상북도") != -1){
				loc = "37"
			} else if(label.indexOf("인천") != -1){
				loc = "23"
			} else if(label.indexOf("충청북도") != -1){
				loc = "33"
			} else if(label.indexOf("울산") != -1){
				loc = "26"
			} else if(label.indexOf("대구") != -1){
				loc = "22"
			} else if(label.indexOf("광주") != -1){
				loc = "24"
			} else if(label.indexOf("대전") != -1){
				loc = "25"
			} else if(label.indexOf("세종") != -1){
				loc = "29"
			}
			
			$('#locDo').val('');
			$('#locSi').val('');
			if(label.substr(-1) == "도"){
				$('#locDo').val(label);
			} else {
				
				$('#locSi').val(label);
			}
			
			getLocation(loc);
			search(loc);
			
		}
		
		function getLocation(loc){
			let selected = loc == null || loc == '' ? '' : 'selected' 
			$.ajax({
				type : 'post',
				data : {loc:loc,year:$('#yyyymm').val()},
				url : '/excel/kosis/getLocation.json',
				dataType:'json',
				success:function(res){
					if(res.msg == "성공"){
						
						let lvl1 = '<option value="all">전체</option>';
						let lvl2 = '<option value="all"  '+selected+' >전체</option>';
						loclvl3 = '<option value="all">전체</option>';
						
						$.each(res.list1,function(i,v){
							//if(v.lvl == "1")								
								lvl1 += '<option '+selected+' value="'+v.CD+'" lvl="'+v.lvl+'">'+v.CPNM1+'</option>';
							//if(v.lvl == "2")
								//lvl2 += '<option value="'+v.CD+'" lvl="'+v.lvl+'">'+v.CPNM1+'</option>';
							//if(v.lvl == "3")
								//loclvl3 += '<option value="'+v.CD+'" lvl="'+v.lvl+'">'+v.CPNM1+'</option>';
								
						})
						$('#locDo').empty()
						
						$('#locDo').html(lvl1)
						$('#locSi').html(lvl2)
						$('#locSi').prop('disabled',true)
						$('#locGu').prop('disabled',true)
						$('#locDo').on('change',function(e){
							$('#locSi').prop('disabled',false)
							$('#locGu').prop('disabled',true)
							lvl2 = '<option value="all"  '+selected+'  >전체</option>';
							let filteredStr = ($(e.target).val().substring(0,2))
							$.each(res.list2,function(i,v){
								if(v.CD.substring(0,2) == filteredStr ){
									lvl2 += '<option value="'+v.CD+'" lvl="'+v.lvl+'">'+v.CPNM1+'</option>';
									
								} else {
									//$('#locSi').empty()
								}	
							})
							$('#locSi').empty()
							$('#locSi').html(lvl2)
						})
						//$('#locSi').html(lvl2)
						$('#locSi').on('change',function(e){
							$('#locSi').prop('disabled',false)
							$('#locGu').prop('disabled',false)
							loclvl3 = '<option value="all">전체</option>';
							let filteredStr = ($(e.target).val().substring(0,4))
							$.each(res.list3,function(i,v){
								if(v.CD.substring(0,4) == filteredStr ){
									loclvl3 += '<option value="'+v.CD+'" lvl="'+v.lvl+'">'+v.CPNM1+'</option>';
									
								} else {
									//$('#locSi').empty()
								}	
							})
							$('#locGu').empty()
							$('#locGu').html(loclvl3)
						})
						
					}
				},
				error:function(){
					console.log(res)
				}
			})
		}
		
		
		function gubun1Change(){
			
			let gubun2code1 = '';
			gubun2code1 += '<option value="all">전체</option>';
			gubun2code1 += '<option value="a1">남자</option>';
			gubun2code1 += '<option value="a2">여자</option>';
			
			let gubun2code2 = '';
			gubun2code2 += '<option value="all">전체</option>';
			gubun2code2 += '<option value="b1">개인사업체</option>';
			gubun2code2 += '<option value="b2">회사법인</option>';
			gubun2code2 += '<option value="b3">회사이외법인</option>';
			gubun2code2 += '<option value="b4">비법인단체</option>';
			
			let gubun2code3 = '';
			gubun2code3 += '<option value="all">전체</option>';
			gubun2code3 += '<option value="c1">단독사업체</option>';
			gubun2code3 += '<option value="c2">공장,지사</option>';
			gubun2code3 += '<option value="c3">본사,본점</option>';
			
			let gubun2code4 = '';
			gubun2code4 += '<option value="all">전체</option>';
			gubun2code4 += '<option value="d1">1~4명</option>';
			gubun2code4 += '<option value="d2">5~9명</option>';
			gubun2code4 += '<option value="d3">10~19명</option>';
			gubun2code4 += '<option value="d4">20~49명</option>';
			gubun2code4 += '<option value="d5">50~99명</option>';
			gubun2code4 += '<option value="d6">100~299명</option>';
			gubun2code4 += '<option value="d7">300~499명</option>';
			gubun2code4 += '<option value="d8">500~999명</option>';
			gubun2code4 += '<option value="d9">1000명이상</option>';
			
			let gubun2code5 = '';
			gubun2code5 += '<option value="all">전체</option>';
			gubun2code5 += '<option value="e1">자영업자</option>';
			gubun2code5 += '<option value="e2">무급가족</option>';
			gubun2code5 += '<option value="e3">상용</option>';
			gubun2code5 += '<option value="e4">임시및일용</option>';
			gubun2code5 += '<option value="e5">기타</option>';
			
			let gubun2code6 = '';
			gubun2code6 += '<option value="all">전체</option>';
			gubun2code6 += '<option value="f1">대표자남자</option>';
			gubun2code6 += '<option value="f2">대표자여자</option>';
			
			let gubun2code7 = '';
			gubun2code7 += '<option value="all">전체</option>';
			gubun2code7 += '<option value="g1">20세미만</option>';
			gubun2code7 += '<option value="g2">20~29세</option>';
			gubun2code7 += '<option value="g3">30~39세</option>';
			gubun2code7 += '<option value="g4">40~49세</option>';
			gubun2code7 += '<option value="g5">50~59세</option>';
			gubun2code7 += '<option value="g6">60세이상</option>';
			
			
			let gubun3code2 = '';
			gubun3code2 += '<option value="ex1">종사자수</option>';
			
			let gubun3code3 = '';
			gubun3code3 += '<option value="all">전체</option>';
			gubun3code3 += '<option value="ex2">사업체수</option>';
			gubun3code3 += '<option value="ex1">종사자수</option>';
			
			$('#gubun2').prop("disabled",true);
			$('#gubun3').prop("disabled",true);
			$('#gubun1').on('change',function(e){
				$('#gubun3').prop("disabled",false);
				$('#gubun2').prop("disabled",false);
				if($(e.target).val() == "all"){ // 전체
					$('#gubun2').empty()
					$('#gubun2').html('<option value="all">전체</option>')
					$('#gubun3').empty()
					$('#gubun3').html('<option value="all">전체</option>')
				}
				
				if($(e.target).val() == "all1"){ // 총사업체수
					$('#gubun2').empty()
					$('#gubun2').html('<option value="all">전체</option>')
					$('#gubun3').empty()
					$('#gubun3').html('<option value="all">전체</option>')
				}
				if($(e.target).val() == "all2"){ // 총종사자수
					$('#gubun2').empty()
					$('#gubun2').html('<option value="all">전체</option>')
					$('#gubun3').empty()
					$('#gubun3').html('<option value="all">전체</option>')
				}
				
				if($(e.target).val() == "a"){ // 종사자성별
					$('#gubun2').empty()
					$('#gubun2').html(gubun2code1)
					$('#gubun3').empty()
					$('#gubun3').html(gubun3code2)
				}
				if($(e.target).val() == "b"){ // 조직형태
					$('#gubun2').empty()
					$('#gubun2').html(gubun2code2)
					$('#gubun3').empty()
					$('#gubun3').html(gubun3code3)
				}
				if($(e.target).val() == "c"){ // 사업체구분
					$('#gubun2').empty()
					$('#gubun2').html(gubun2code3)
					$('#gubun3').empty()
					$('#gubun3').html(gubun3code3)
				}
				if($(e.target).val() == "d"){ // 종사자규모
					$('#gubun2').empty()
					$('#gubun2').html(gubun2code4)
					$('#gubun3').empty()
					$('#gubun3').html(gubun3code3)
				}
				if($(e.target).val() == "e"){ // 종사상지위
					$('#gubun2').empty()
					$('#gubun2').html(gubun2code5)
					$('#gubun3').empty()
					$('#gubun3').html(gubun3code2)
				}
				if($(e.target).val() == "f"){ // 대표자성별
					$('#gubun2').empty()
					$('#gubun2').html(gubun2code6)
					$('#gubun3').empty()
					$('#gubun3').html(gubun3code3)
				}
				if($(e.target).val() == "g"){ // 대표자연령대
					$('#gubun2').empty()
					$('#gubun2').html(gubun2code7)
					$('#gubun3').empty()
					$('#gubun3').html(gubun3code3)
				}
			})
			
			
		}
		
		
		$(document).ready(function(){
			gubun1Change();
			
			//$("#excelBtn1").empty();
			//$("#excelBtn1").append('<a href="javascript:void(0);" id="exportBtn1" name="exportTable1" onclick="excelExport();"><img src="../images/2020/exel.png" alt="엑셀이미지">엑셀저장</a>');
			$("#yyyymm").val('2022')
			$("#yyyymm").bindDate({align:"right", valign:"bottom", separator:"-", selectType:"y",  defaultSelectType:"y", defaultDate:"2022-01-01", 
				onchange : function(){
					getLocation('');
				} 
			})
			getLocation('');
			getExcelData();
			
			$("#excelBtn1").empty();
			$("#excelBtn1").append('<a href="javascript:void(0);" id="exportBtn1" name="exportTable1" onclick="excelExport();"><img src="../images/2020/exel.png" alt="엑셀이미지">엑셀저장</a>');
		});
		
		// 엑셀 다운로드
		function excelExport(){
			//var excelNm = "식물 검역정보";
			//yyyymm = $("#yyyymm").val();
			//itemCd = $("#itemCd").val();
			//var param = "?excelNm="+excelNm+"&yyyymm="+yyyymm+"&itemCd="+itemCd;
			//location.href = "/excel/excelDownLoad.do"+param;
			
			
		}
		
		function search(loc){	
			////getLocation('')
			var evt;
			if(typeof loc == 'object'){
				evt = loc
				loc = ''
			}
			let lvl = '';
			if($('#locSi option:selected').text() == '' || $('#locSi option:selected').text() == '전체'){
				lvl = 1
			}else if($('#locGu option:selected').text() != '' && $('#locGu option:selected').text() != '전체'){
				lvl = 3	
			} else {
				lvl = 2
			}
			$("#jqGrid").clearGridData();
			checkedval = []
			$.each( $('input[type=checkbox]:checked'),function(i,v){
				checkedval.push($(this).val())	
			})
			$("#jqGrid").setGridParam({
				url         : '/excel/kosis/onlineMagazine.json',
				mtype       : "post",
				datatype	: "json",
	   	 		postData    : JSON.stringify({ 
   					year : $.trim($('#yyyymm').val()),
   					locDo : $.trim($('#locDo option:selected').val()).length == 0 ? loc : $.trim($('#locDo option:selected').val()) ,
   					locSi : $.trim($('#locSi option:selected').text()).length == 0 ? '전체' : $.trim($('#locSi option:selected').text()),
   					locGu : $.trim($('#locGu option:selected').text()).length == 0 ? '전체' : $.trim($('#locGu option:selected').text()),
   					location : typeof loc != "undefined" ? loc : '' ,
   					gubun1 : $('#gubun1').val(),
   					gubun2 : $('#gubun2').val(),
   					gubun3 : $('#gubun3').val(),
   					chkopt : checkedval,
   					lvl : lvl
				}),
				page : 1,
				loadComplete	: function(data) {
					$("#jqGrid")[0].addJSONData(data.list)
					 
					//mapData = data.list
					//rMateMapChartH5.create("map1", "mapHolder", mapVars, "100%", "100%");
					//rMateMapChartH5.create("map2", "mapHolder2", mapVars2, "100%", "100%");
					
					gDataList = data.list
					$.each(data.list,function(i,v){
						console.log("code1: ",v.code);
						if($('#locDo option:selected').val() != 'all')	
							setSelectedItem(v.id,v.code,v);	
						else
							rMateMapChartH5.create("map1", "mapHolder", mapVars, "100%", "100%");
					
						
					})
					
					
	          	},
			}).trigger("reloadGrid");
		}
		
		
		function callbackForUpload(res){
			if(res.msg.indexOf("오류") != -1){
				toast.push({body:"서버오류발생",type:"Caution"})	
				return;
			}
			toast.push(res.msg);
			
		}
		
		
		//엑셀 업로드
		function uploadExcel(){
		 	
			if($.trim($('#yyyymm').val()).length == 0 ){
				toast.push({body:"년도를 선택해주세요!",type:"Caution"})
				return ;
			}
 			if($('#excelUploadFiles')[0].files.length == 0 ){
 				toast.push({body:"엑셀파일을 선택해주세요!(하나만 가능)",type:"Caution"})
				return ;
 			}
			
 			let formData = new FormData();
 			formData.set("year",$('#yyyymm').val());
 			formData.set("files",$('#excelUploadFiles')[0].files[0]);
 	 			
 	 			$.ajax({
 	 			   url:"/excel/kosis/upload.json",
 	 			   type:"post",
 	 			   enctype: 'multipart/form-data',
 	 			   data: formData,
 	 			   dataType:'json',
 	 			   processData: false,    
 	 		       contentType: false,      
 	 		       cache: false,   
 	 			   success:callbackForUpload,
 	 			   error:callbackForUpload,
 	 				beforeSend: function(){
 	 					$('#loading-indicator').show();
 	 					$('#loading-indicator-back').show();
 	 				},
 	 				complete: function(){
 	 					$('#loading-indicator').hide();
 	 					$('#loading-indicator-back').hide();
 	 				}
 	 		   })	
 			
 			
		 	
		}
		function changeCss(event) {
			//console.log(event)
	   		var activeClass = document.getElementsByClassName("active")[0];
		 	var tElement = event.srcElement || event.currentTarget;
		 	if ( activeClass )
	      		activeClass.className = activeClass.className.replace("active", "");
		    tElement.className += " active";
		}
		// 데이터 변경  함수
		function changeLayout(event,data) {
			//console.log('데이터변경함수내부',rollupCalc(data))
			//changeCss(event);
		  	//document.getElementById("map1").setLayout(layoutStr2);
		  	//document.getElementById("map1").setData(rollupCalc(data));
		} 
		
		function setSelectedItem(itemId, rootCode) {
	    	//var mapApp = document.getElementById("map1");
		  	var mapApp2 = document.getElementById("map1");
		  	//var mapRoot = mapApp.getRoot();
		 	var mapRoot2 = mapApp2.getRoot();
		 	
		   	//mapRoot.setSelectedItem("bubble", itemId);
		  	mapRoot2.setRootCode(rootCode);
		}
		
		
		// 조회 버튼1
		function getExcelData(){
			checkedval = []
			$.each( $('input[type=checkbox]:checked'),function(i,v){
					checkedval.push($(this).val())	
			})
			
			
			$("#jqGrid").jqGrid({
		   		/*url : "/excel/kosis/onlineMagazine.json",
	   			mtype: 'POST',
	      		postData: 
	    	   	{
	      			//yyyymm : $("#yyyymm").val(), 
	    			//itemCd : $("#itemCd").val()
	  			},*/
	           	datatype: function(){
           			$.ajax({
           				type:'post',
           				url:"/excel/kosis/onlineMagazine.json",
           				data:JSON.stringify({ 
           					year : $.trim($('#yyyymm').val()),
           					locDo : 'al',
           					locSi : $.trim($('#locSi option:selected').text()),
           					locGu : $.trim($('#locGu option:selected').text()),
           					location : loc,
           					gubun1 : $('#gubun1').val(),
           					gubun2 : $('#gubun2').val(),
           					gubun3 : $('#gubun3').val(),
           					chkopt : checkedval
        				}),
           				dataType:"json",
           				success:function(res){
           					$("#jqGrid")[0].addJSONData(res.list)
           					console.log("mapData",res.list)
           					
           					mapData = (res.list)
           					gDataList = res.list
           					rMateMapChartH5.create("map1", "mapHolder", mapVars, "100%", "100%");
           					//rMateMapChartH5.create("map2", "mapHolder2", mapVars2, "100%", "100%");
           					//setTimeout(function(){
           						//setSelectedItem(res.list[10].id,res.list[10].code);	
           					//},2000);
           					
           				},
           				error:function(err){
           					console.log(err)
           				},
           				beforeSend: function(){
        					$('#loading-indicator').show();
        					$('#loading-indicator-back').show();
        				},
        				complete: function(){
        					$('#loading-indicator').hide();
        					$('#loading-indicator-back').hide();
        				}
           			})
	           	},
	           	jsonReader: {    // json 데이터형식과 맞춰주는거 같다. (요기가 없으니까..그리드안 데이터를 못뿌리네..)
		   	   		root : "list",  // list 이름
		   	   		page : "page",
		   	   		total : "total",
		   	   		records : "records",
		   			repeatitems : false
	   			},
	           	colModel: [
	           		{ label: '행정구역 및 산업분류 코드', name: 'AD_CD_INDST_IDV_CD',width: 100, editable: false , align:"center",hidden:true},
	              	{ label: '행정구역 명칭',classes:"ui-ellipsis" , name: 'CPNM1', width: 100, editable: false, align:"center" },
	               	{ label: '산업분류명칭',classes:"ui-ellipsis"  ,name: 'INDST_NM', width: 100, editable: false, align:"center"},
	               	{ label: '구분1', name: 'GUBUN1',classes:"ui-ellipsis", width: 100, editable: true, align:"center", },
	               	{ label: '구분2', name: 'GUBUN2',classes:"ui-ellipsis", width: 100, editable: true, align:"center", }, 
	               	{ label: '구분3', name: 'GUBUN3',classes:"ui-ellipsis", width: 100, editable: true, align:"center", }, 
	               	{ label: '값', name: 'VAL',classes:"ui-ellipsis", width: 100, editable: true, align:"center", sorttype: 'float', formatter:integerFormatter,formatoptions: { defaultValue: '', thousandsSeparator: ',' },unformat:malformNumber } 
	               	 
	           	] ,
	           	loadonce:true,
	           	loadtext: "데이터를 불러오는중...",
	   		   	rownumbers : false,
	   		 	rownumWidth : '50',
	   		 	shrinkToFit : false,
	   		 	forceFit:false,
	   		 	autowidth:false,
	           	height: '250',
	           	rowNum: 1000,
	           	width:$(".plants_graph_b > div").width(),
	 		   	sortable: true,
	 		   	emptyrecords : '데이터가 없습니다.',
	           	pager: "#jqGridPager",
	      	   	loadComplete	: function(data) {
	      	   		
	          	},
	   			onSelectRow: function(rowid, status, e) {
	   				//var rowData = $(this).getLocalRow(rowid);
	   				//console.log(e)
	        	},
	        	rowattr: function (item) {
	        		//console.log('아이템',item)
	        	},
	        	beforeSelectRow: function (rowid, e) {
	        		return false;
	        	},
	       	});
	       	
			/*$('#jqGrid').navGrid('#jqGridPager',
				// the buttons to appear on the toolbar of the grid
				{ edit: false, add: false, del: false, search: false, refresh: true, view: false, position: "left", cloneToTop: false },
				{
					errorTextFormat: function (data) {
						return 'Error: ' + data.responseText
					}
				},
				{ multipleSearch: true } // search options - define multiple search
			);*/
	       	
			//$("#jqGrid").jqGrid("setLabel", "rn", "No.");
			//$("#jqGrid").jqGrid("hideCol", "rn");
	  		
	  		
		}
		
		function malformNumber(cellvalue, options){
			//console.log("잘못된 포맷")
			//console.log(cellvalue)
			return (parseInt(cellvalue) || 0);
		}

		function integerFormatter(cellvalue,options,rowData){
			//console.log("최종밸류1 : ",cellvalue)
			if(cellvalue == "X" || cellvalue == "" || typeof(cellvalue) == "undefined" || cellvalue == null){
				return "0";
			}
			//console.log("최종밸류2 : ",cellvalue)
			return comma(cellvalue);
		}
		
		// 천단위 콤마
		function comma(x) {
		    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		}
		
		function excelExport(loc){
			var evt;
			if(typeof loc == 'object'){
				evt = loc
				loc = ''
			}
			let lvl = '';
			if($('#locSi option:selected').text() == '' || $('#locSi option:selected').text() == '전체'){
				lvl = 1
			}else if($('#locGu option:selected').text() != '' && $('#locGu option:selected').text() != '전체'){
				lvl = 3	
			} else {
				lvl = 2
			}
			/////////$("#jqGrid").clearGridData();
			checkedval = []
			$.each( $('input[type=checkbox]:checked'),function(i,v){
				checkedval.push($(this).val())	
			})

   			var param1 = { 
   	   					year : $.trim($('#yyyymm').val()),
   	   					locDo : $.trim($('#locDo option:selected').val()).length == 0 ? loc : $.trim($('#locDo option:selected').val()) ,
   	   					locSi : $.trim($('#locSi option:selected').text()).length == 0 ? '전체' : $.trim($('#locSi option:selected').text()),
   	   					locGu : $.trim($('#locGu option:selected').text()).length == 0 ? '전체' : $.trim($('#locGu option:selected').text()),
   	   					location : typeof loc != "undefined" ? loc : '' ,
   	   					gubun1 : $('#gubun1').val(),
   	   					gubun2 : $('#gubun2').val(),
   	   					gubun3 : $('#gubun3').val(),
   	   					chkopt : checkedval,
   	   					lvl : lvl};
			url = "/excel/selectHga07excel.json";

     		let param = "?excelNm="+"지역별 화훼관련 사업체 정보"+"&year="+param1.year+"&locDo="+param1.locDo+"&locSi="+param1.locSi+"&locGu="+param1.locGu+"&location="+param1.location+"&gubun1="+param1.gubun1+"&gubun2="+param1.gubun2+"&gubun3="+param1.gubun3+"&chkopt="+param1.chkopt+"&lvl="+param1.lvl;
     		console.log("encoding", encodeURI(url+param));
     		
     		location.href = encodeURI(url+param);
		}
	</script>
</head>
<body>
<div id="loading-indicator"></div>
<div id="loading-indicator-back"></div>
	<!--WRAP(S)-->
	<div class="wrap">
		
		<jsp:include page="../inc/2020/IncHeader.jsp"/>
		
		<div class="lnb_box">
			<ul>
				<li><img src="../images/2020/m_lnb_img.png" alt="집"></li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li>공공데이터</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li>타 기관 정보</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li class="m_right">지역별 화훼관련 사업체 정보</li>
			</ul>
		</div>
		<!--공통 HEADER(E)-->
		
		<!--서브 타이틀(S)-->
		<jsp:include page="../inc/2020/IncShare.jsp"/>
		
		<div class="sub_title">
			<div class="title_box">
				<h2>지역별 화훼관련 사업체 정보</h2>
				<img src="../images/2020/sub/t_line.png" alt="방울점선">
			</div>
		</div>
		<!--서브 타이틀(E)-->
		<!--서브공통 (S)-->
		<div class="sub_contents">
			<div class="sub_info_box">
					<div class="tit_box_01" style="margin-bottom:5px">
						<div class="fr">
							<!-- <div class="dwn_bt_b btn_h_45" style="">
								<input type="file" id="excelUploadFiles" accept=".xlsx"  style=""   > 
							</div-->
							<!-- <div class="dwn_bt_b btn_h_45" style="">
								<a class="reset_btn" onclick="javascript:changeLayout(event);">지도내용바꾸기</a>
							</div> -->
							<div class="dwn_bt_b btn_h_45" >
								<button onclick="search(event);return false;" style="background:transparent">
									<a href="#" class="search_btn_n" >
									<img src="../images/2020/sub/search_img.png" alt="돋보기">검색
									</a>
								</button>
							</div>

						</div>
					</div>
				</div>
			<!--서브 TAB공통 (S)-->
			<div class="search_box_new statistic">
				<div class="s-line">
					<h4 class="sbn_tit_01">년도</h4>
					<ul class="grow_check_box" style="">
						<input type="text" class="datepicker" id="yyyymm" name="yyyymm" value="YYYY">
					</ul>
					<!-- <input type="text"  value="YYYY-MM-DD" alt="켈린더" class="datepicker" > -->
				</div>
				<div class="s-line">
					<h4 class="sbn_tit_01">지역</h4>
					<ul class="grow_check_box" style="">
						<li><select class="form-control" style="width: 150px;" id="locDo" name="locDo"><option value="all">전체</option></select></li>
						<li><select class="form-control" style="width: 150px;" id="locSi" name="locSi"><option value="all">전체</option></select></li>
						<li><select class="form-control" style="width: 150px;" id="locGu" name="locGu"><option value="all">전체</option></select></li>						
						<!-- <li><input type="text" class="AXInput W100" id="locGu" placeholder="구"></li> -->
					</ul>
				</div>
				<div class="s-line">
					<h4 class="sbn_tit_01">구분</h4>
					<ul class="grow_check_box" style="">
						<li>
							<select class="form-control" style="width: 150px;" id="gubun1" name="gubun1">
								<option value="all" selected>전체</option>
								<option value="all1" >총사업체수</option>
								<option value="all2" >총종사자수</option>
								<option value="a">종사자성별</option>					
								<option value="b">조직형태</option>					
								<option value="c">사업체구분</option>					
								<option value="d">종사자규모</option>					
								<option value="e">종사상지위</option>					
								<option value="f">대표자성별</option>					
								<option value="g">대표자연령대</option>					
							</select>
						</li>
						<li>
							<select class="form-control" style="width: 150px;" id="gubun2" name="gubun2">
								<option value="all" selected>전체</option>
													
							</select>
						</li>
						<li>
							<select class="form-control" style="width: 150px;" id="gubun3" name="gubun3">
								<option value="all" selected>전체</option>
													
							</select>
						</li>
					</ul>
				</div>
				<div class="s-line">
					<h4 class="sbn_tit_01">화훼관련</h4>
					<ul class="grow_check_box" style="margin-bottom:7px !important;margin-top:7px !important;">
						<li>
							<input type="checkbox" id="hwagubn1" name="hwagubn" value="1" checked>
							<label for="hwagubn1" class="title_box_chk"><em class="txt">채소,화훼 및 과실작물 시설 재배업</em><span></span></label>
						</li>
						<li>
							<input type="checkbox" id="hwagubn2" name="hwagubn" value="2" checked>
							<label for="hwagubn2" class="title_box_chk"><em class="txt">채소,화훼작물 및 종묘 재배업</em><span></span></label>
						</li>
						<li>
							<input type="checkbox" id="hwagubn3" name="hwagubn" value="3" checked>
							<label for="hwagubn3" class="title_box_chk"><em class="txt">화훼류 및 식물 도매업</em><span></span></label>
						</li>
						<li>
							<input type="checkbox" id="hwagubn4" name="hwagubn" value="4" checked>
							<label for="hwagubn4" class="title_box_chk"><em class="txt">화훼작물 재배업</em><span></span></label>
						</li>
					</ul>
				</div>
						<!-- <input type="file"    id="excelUploadFiles" accept=".xlsx"  style=""   > -->
							
							<!-- <select class="form-control" style="width: 150px;" id="itemCd" name="itemCd"></select> -->
						
						
							<!-- <a href="javascript:search()" style=""><img src="../images/2020/sub/search_img.png" alt="돋보기">검색</a> -->
							<!-- <a href="javascript:uploadExcel()"><i class="fa-solid fa-upload" style="color: #ffffff;"></i>업로드</a> -->
						
					
				</div>
			</div>
			<!--서브 TAB공통 (E)-->
		
		<!--컨텐츠 내용(S)-->
		
		
		
		<div class="sub_guide">
		<h2 class="title_02">지역별 화훼관련 사업체 정보</h2>
						<div class="tit_box_01">
					<div class="fr">
						<div class="dwn_bt_b" id="excelBtn1"><a href="#!"><img src="../images/2020/exel.png" alt="엑셀이미지">엑셀저장</a></div><br/>
					</div>
				</div>
			<div class="plants_box_b">
			<div class="conts_left">
					<!-- <div id="mapHolder" style="width:100%; min-width:313px; height:428px;"></div> -->
					<div id="mapHolder" style="width:100%; min-width:313px; height:428px;"></div>
				</div>
				<div class="plants_graph_b conts_right">
					
					<div class="export_graph01_b" >
						
						<table id="jqGrid" style="width:100%; /*height:350px;*/" class="boxList"></table>
						<div id="jqGridPager"></div>
						
						
					</div>
				</div>
								
			</div>
			
			
			
		
		</div>
		</div>
		
				
		<div class="guide">
			<h2 class="title_02">이용안내</h2>
			<ul class="guide_box">
				<li class="">·  출처 : KOSIS 국가통계포털 - 온라인간행물</li>
			</ul>
		</div>
		
			
		
		<!--컨텐츠 내용(E)-->
		
		<jsp:include page="../inc/2020/IncFooter.jsp"/>
		
	</div>
	
	<!--WRAP(E)-->
</body>
</html>