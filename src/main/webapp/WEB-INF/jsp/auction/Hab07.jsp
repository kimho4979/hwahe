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
	<meta name="description" content="지역별 월별 출하실적">
	<meta name="content" content="화훼유통정보시스템 입니다.">
	<meta name="keywords" content="화훼경매시세, 화훼경매가격, Korea aT flower market auction price, 화훼공판장, 화훼거래정보, 꽃시장, 꽃값">
	<meta name="Author" content="화훼유통정보시스템 & www.woorim.co.kr">
	<style type="text/css">
		ul.search_box01 li.search_btn{
		width: 90px!important
		}
	</style>
	<title>지역별 월별 출하실적</title>
	
	<%@include file="../common/2020/commonJs.jsp" %>	
	<%@include file="../common/2020/commonCss.jsp" %>
	
	<script type="text/javascript">
		var flowerCd = null;
		var cmpCd = null;
		var pumName = null;
		var goodName = null;
		//var searchSaleDate = null;
		var searchStrDate = null;
		var searchEndDate = null;
		
		//-----------------------차트 설정 시작-----------------------

		//rMate 차트 생성 준비가 완료된 상태 시 호출할 함수를 지정합니다.
		var chartVars = "rMateOnLoadCallFunction=chartReadyHandler";
		rMateChartH5.create("chart1", "chartHolder", chartVars, "100%", "100%"); 
		
		function chartReadyHandler(id) {
		 document.getElementById(id).setLayout(layoutStr);
		 document.getElementById(id).setData(chartData);
		}

		//스트링 형식으로 레이아웃 정의.
		var layoutStr = 
		             '<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'
		                 +'<Options>'                     
		                     +'<SubCaption text="출하량(단)" textAlign="left" />'                           
		                 +'</Options>'
		                 +'<NumberFormatter id="numFmt" useThousandsSeparator="true"/>'
		                 +'<Column2DChart showDataTips="true" cubeAngleRatio="1">'
		                     +'<horizontalAxis>'
		                         +'<CategoryAxis id="hAxis" categoryField="chartX" displayName="라벨"/>'
		                     +'</horizontalAxis>'
		                     +'<verticalAxis>'
		                         +'<LinearAxis  interval="1000"  formatter="{numFmt}" />'
		                     +'</verticalAxis>'
		                     +'<series>'
		                         +'<Column2DSeries labelPosition="outside" yField="totQty" displayName="출하량" >'
		                             +'<showDataEffect>'
		                                 +'<SeriesInterpolate/>'
		                             +'</showDataEffect>'
		                         +'</Column2DSeries>'
		                     +'</series>'
		                     +'<horizontalAxisRenderers>'
	                          // autoLineBreak - 축 라벨이 하나의 아이템이 그려질 총 width보다 커질경우 자동으로 개행처리 할지를 설정합니다.
	                           // lineBreakWidth - autoLineBreak가 true일 경우 개행처리 되어야 할 width 값. 수직 축일 경우는 기본 100
	                            +'<Axis2DRenderer axis="{hAxis}" autoLineBreak="true" lineBreakWidth="80"/>'
	                      +'</horizontalAxisRenderers>'
		                 +'</Column2DChart>'
		             +'</rMateChart>';

		//차트 데이터
		var chartData = [];
		
		function rMateChartH5ChangeTheme(theme){
			document.getElementById("chart1").setTheme(theme);
		}

		//-----------------------차트 설정 끝 -----------------------
		
		$(document).ready(function(){
			
			cmpCd = $("#cmpCdTab .on > input").attr("value");
			flowerCd = $("#flowerTab .on > input").attr("value");
			searchStrDate = $("#searchStrDate").attr("value");
			searchEndDate = $("#searchEndDate").attr("value");
			pumName = $('#itemCd option:selected').val();
			
			//getSaledate(cmpCd, flowerCd);
			
			$("#searchStrDate").bindDate({align:"right", valign:"bottom", separator:"-", selectType:"m",  defaultSelectType:"m", value:"",
		       	onchange:function(){
		       		var begins=$("#searchEndDate").val();
		       		var begindate=year_sample(begins,1);
		       		if($("#searchStrDate").val() < begindate)
					{
		       			   alert("1년까지만 선택가능합니다");
		       			   return;
		       		}
					init();
					var searchFlag=dateChkstr();
					if(searchFlag==true){
					cmpCd = $("#cmpCdTab .on > input").attr("value");
					flowerCd = $("#flowerTab .on > input").attr("value");
					pumName = $('#itemCd option:selected').val();
					// 품목조회
					var searchStrDate = $("#searchStrDate").val();
					var searchEndDate = $("#searchEndDate").val();
					
					getSaleMonthPumList(cmpCd, flowerCd, searchStrDate, searchEndDate, 0);
					//search();
					}else{
		       			alert("당월까지만 선택 가능합니다")
		       		}
				}
			});
			
			$("#searchEndDate").bindDate({align:"right", valign:"bottom", separator:"-", selectType:"m",  defaultSelectType:"m", value:"",
		       	onchange:function(){
		       		var begins=$("#searchStrDate").val();
		       		var begindate=year_sampled(begins,1);
		       		if($("#searchEndDate").val() > begindate)
		       		{
		       			alert("1년까지만 선택가능합니다");
		       			return;
		       		}
					init();
					var searchFlag=dateChkend();
		       		if(searchFlag==true){
					cmpCd = $("#cmpCdTab .on > input").attr("value");
					flowerCd = $("#flowerTab .on > input").attr("value");
					pumName = $('#itemCd option:selected').val();
					// 품목조회
					var searchStrDate = $("#searchStrDate").val();
					var searchEndDate = $("#searchEndDate").val()
					
					getSaleMonthPumList(cmpCd, flowerCd, searchStrDate, searchEndDate, 0);
					//search();
		       		}else{
		       			alert("당월까지만 선택 가능합니다")
		       		}
				}
			});
			
			$("#excelBtn1").empty();
			$("#excelBtn1").append('<a href="javascript:void(0);" id="exportBtn1" name="exportTable1" onclick="excelExport();"><img src="../images/2020/exel.png" alt="엑셀이미지">엑셀저장</a>');
		});
		function year_sample(value,num){
			var m,d;
			var arr=value.split('-');
			var dt_v= new Date(arr[0],arr[1]);
			m=dt_v.getMonth();
			if(m<10)
				{
					m='0'+m;
				}
				
			begindate=(dt_v.getFullYear()-num)+'-'+m;
			return begindate;
			
			}
		function year_sampled(value,num){
			var m,d;
			var arr=value.split('-');
			var dt_v= new Date(arr[0],arr[1]);
			m=dt_v.getMonth();
			if(m<10)
				{
					m='0'+m;
				}
				
			begindate=(dt_v.getFullYear()+num)+'-'+m;
			return begindate;
			
			}
		function dateChkstr(){
			
			var searchGoFlag=false;
			
			var selectDate = $("#searchStrDate").val().replace(/-/gi, "");
			var today = new Date();
			var mm = today.getMonth()+1;
			var yy= today.getFullYear();
			if(mm<10){
				mm='0'+mm;
			}
			today = yy+''+mm;
		
			if(selectDate<=today){
				searchGoFlag=true;
				if($("#searchStrDate").val() > $("#searchEndDate").val()){
					$("#searchEndDate").val($("#searchStrDate").val()) ;
				} 
			}
			return searchGoFlag;
		}

		function dateChkend(){
			
		    var searchGoFlag=false;
			var selectDate = $("#searchEndDate").val().replace(/-/gi, "");
			var today = new Date();
			var mm = today.getMonth()+1;
			var yy= today.getFullYear();
			if(mm<10){
				mm='0'+mm;
			}
			today = yy+''+mm;
			
			if(selectDate<=today){
				searchGoFlag=true;
				if($("#searchStrDate").val() > $("#searchEndDate").val()){
					$("#searchStrDate").val($("#searchEndDate").val()) ;
				} 
			}
			return searchGoFlag;
		}
		// 엑셀 다운로드
		function excelExport(){
			var excelNm = "지역별월별출하실적";
			searchStrDate = $("#searchStrDate").val();
			searchEndDate = $("#searchEndDate").val();
			cmpCd = $("#cmpCdTab .on > input").attr("value");
			flowerCd = $("#flowerTab .on > input").attr("value");
			var itemCd = $("#itemCd option:selected").val();
			var itemCd2 = $("#itemCd2 option:selected").val();
			var param = "?excelNm="+excelNm+"&searchStrDate="+searchStrDate+"&searchEndDate="+searchEndDate+"&cmpCd="+cmpCd+"&flowerCd="+flowerCd+"&itemCd="+itemCd;
			location.href = "/excel/excelDownLoad.do"+param;
		}
		
		function init(){
			getItemInit();
			$("#itemCd").html("");
			$("#itemCd").append("<option value='' selected>전체</option>");
			
			chartData = [];
			rMateChartLoding("chart1", "chartReadyHandler");		
			
			$("#get1").empty();
		}
		
		function search(){
			cmpCd = $("#cmpCdTab .on > input").attr("value");
			flowerCd = $("#flowerTab .on > input").attr("value");
			searchSaleDate = null;
			searchStrDate = $("#searchStrDate").val();
			searchEndDate = $("#searchEndDate").val();
			pumName = $('#itemCd option:selected').val();
			
			// 검색 시 쿠키저장
			$.cookie("cookie.cmpCd", cmpCd, {expires: 7, path: '/' });
			$.cookie("cookie.flowerCd", flowerCd, { expires: 7, path: '/' });
			$.cookie("cookie.pumCd", pumName,{ expires: 7, path: '/' });
			//$.cookie("cookie.goodCd", itemCd2, { expires: 7, path: '/' });

			getData(flowerCd, cmpCd, searchStrDate, searchEndDate, pumName);
		}
		
		function getSaledate(cmpCd, flowerCd){
			$.ajax({
				type : "post",
				url : "/search/selectSaleMonth.json",
				data : {
					searchProductGubun : flowerCd,
					searchCmpCd : cmpCd
				},
				dataType : '',
				success : function(res){
					var val = res.list;
					
					if(res.list!=null && res.list.length > 0){
						init();
						$("#searchStrDate").val(val[0].SALE_MONTH);
						$("#searchEndDate").val(val[0].SALE_MONTH);
						var pumName = $('#itemCd option:selected').val();
						getSaleMonthPumList(cmpCd, flowerCd, val[0].SALE_MONTH, val[0].SALE_MONTH, 0);
						//search();
					}else{
						//$('#searchSaleDate').val("");
						$("#searchStrDate").val("");
						$("#searchEndDate").val("");
						init();	
					}
				}
			});
			
		}
		
		function getData(flowerCd, cmpCd, searchStrDate, searchEndDate, pumName){
			$("#get1").empty();
			
			$.ajax({
				type : "post",
				url : "/hab07/selectHab07Json.json",
				data : {
					flowerCd : flowerCd,
					cmpCd : cmpCd,
					searchStrDate : searchStrDate,
					searchEndDate : searchEndDate,
					itemCd : pumName
				},
				dataType : '',
				success : function(res){
					
					var val = res.list;
					if(val != null&&val.length>0){
						for(var i=0; i<val.length; i++){
							$("#get1").append("<tr><td class='tc'><p>"+val[i].sanCdNm+"</p></td><td class='tc'><p>"+val[i].pumName+"</p></td><td class='tc'><p>"+addThousandSeparatorCommas(val[i].totAmt)+"</p></td><td class='tc'><p>"+addThousandSeparatorCommas(val[i].totQty)+"</p></td></tr>");
						}	
					}else{
						$("#get1").append("<tr><td colspan='6'>데이터가 없습니다.</td></tr>");
					}
					chartData = res.list;                     
					rMateChartLoding("chart1", "chartReadyHandler");
				}
			});
		}
	</script>
</head>
<body>
	<input type="hidden" id="searchProductGubun" name="searchProductGubun" value="1"/>
	<input type="hidden" id="searchCmpCd" name="searchCmpCd" value="0000000001"/>
	<!--WRAP(S)-->
	<div class="wrap">
		
		<jsp:include page="../inc/2020/IncHeader.jsp"/>
		
		<div class="lnb_box">
			<ul>
				<li><img src="../images/2020/m_lnb_img.png" alt="집"></li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li>경매정보</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li>경매통계</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li class="m_right">지역별 월별 출하실적</li>
			</ul>
		</div>
		<!--공통 HEADER(E)-->
		
		<!--서브 타이틀(S)-->
		<jsp:include page="../inc/2020/IncShare.jsp"/>
		
		<div class="sub_title">
			<div class="title_box">
				<h2>지역별 월별 출하실적</h2>
				<img src="../images/2020/sub/t_line.png" alt="방울점선">
			</div>
		</div>
		<!--서브 타이틀(E)-->
		
		<jsp:include page="../inc/2020/topMenuRange.jsp"/>
		
		<!--컨텐츠 내용(S)-->
		<div class="sub_guide">
			
			<!-- 그래픽(S) -->
			<div class="txt_graph">
				<div id="chartHolder" style="width:100%; height:380px;"></div>
			</div>
			<!-- 그래픽(E) -->

			<!-- 테이블(S) -->
			<div class="table_overflow_y">
				<table class="table_type_01 btg tiny">
					<caption>지역별 월별출하실적</caption>
					<colgroup>
						<col style="width:25%">
						<col style="width:25%">
						<col style="width:25%">
						<col style="width:25%">
					</colgroup>
					<thead>
						<tr>
							<th class="tc">지역</th>
							<th class="tc">품목명</th>
							<th class="tc">출하금액</th>
							<th class="tc">출하물량</th>
						</tr>
					</thead>
					<tbody id="get1"></tbody>
				</table>
			</div>
			<!-- 테이블(E) -->

			<!-- 버튼박스(S) -->
			<div class="dwn_bt_b" id="excelBtn1">
				<a href="#!"><img src="../images/2020/exel.png" alt="엑셀이미지">엑셀저장</a>
			</div>
			<!-- 버튼박스(E) -->

		</div>


		<div class="guide">
			<h2 class="title_02">이용안내</h2>
			<ul class="guide_box">
				<li class="">· 공판장별 실적을 한눈에 파악 할 수 있는 화면</li>
				<li class="">· 단위 :거래량(단), 경매금액(원) / 자료출처 : 각 공판장별 경매 자료 현황</li>
			</ul>
		</div>

		<!--컨텐츠 내용(E)-->		
		
		<jsp:include page="../inc/2020/IncFooter.jsp"/>
		
	</div>
	<!--WRAP(E)-->
</body>
</html>