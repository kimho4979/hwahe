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
	<meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, user-scalable=no">
	<meta name="apple-mobile-web-app-title" content="화훼유통정보시스템">
	<meta name="robots" content="no-index,follow">
	<meta name="og:title" content="화훼유통정보시스템">
	<meta name="og:description" content="화훼유통정보시스템">
	<meta name="description" content="월별전년대비실적">
	<meta name="content" content="화훼유통정보시스템 입니다.">
	<meta name="keywords" content="화훼경매시세, 화훼경매가격, Korea aT flower market auction price, 화훼공판장, 화훼거래정보, 꽃시장, 꽃값">
	<meta name="Author" content="화훼유통정보시스템 & www.woorim.co.kr">
	<title>연도별 실적</title>

	<%@include file="../common/2020/commonJs.jsp" %>
	<%@include file="../common/2020/commonCss.jsp" %>

<style>
.btn_type_grid{display:inline-block; min-width:50px;  border:1px solid #dcdcdc; line-height:20px; color:#777777; font-size:15px;}
.btn_type_grid:hover{background:#4d6bed; border:1px solid #ffffff; color:#ffffff; }
.btn_type_grid.on{background:#4d6bed; border:1px solid #ffffff; color:#ffffff; }
</style>
	<script type="text/javascript">
		var flowerCd = null;
		var cmpCd = null;
		var pumName = null;
		var goodName = null;
		var searchSaleDate = null;

		//-----------------------차트 설정 시작-----------------------


		// rMate 차트 생성 준비가 완료된 상태 시 호출할 함수를 지정합니다.
		var chartVars = "rMateOnLoadCallFunction=chartReadyHandler";
		 rMateChartH5.create("chart1", "chartHolder", chartVars, "100%", "100%");

		function chartReadyHandler(id) {
		    document.getElementById(id).setLayout(layoutStr);
		    document.getElementById(id).setData(chartData);
		}

		function dataTipFunc(seriesId, seriesName, index, xName, yName, data, values)
		{
			var html = "";
			var xValue = values[0];
			var yValue = values[1];

			if(seriesName == "거래금액(백만원)") {
				return "";
			}
			if(seriesName == "대상년도 전년 거래량" || seriesName == "대상년도 전년 거래금액" ){
				html += (xValue.substring(0,4)-1) + xValue.substring(4,7);
			}else{
				html += xValue;
			}
			
			var data = chartData[index];
			html = "";
			html += data.saleYear;
			html += "<br>거래량(만단) : " + data.totQty;
			html += "<br>거래금액(백만원) : " + data.totAmt;
			//html += "<br>"+seriesName+" : "+comma(yValue);

		   return html;
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

		// 스트링 형식으로 레이아웃 정의.
		var layoutStr =
			 '<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'
		     +'<Options>'
		                     +'<SubCaption text="거래량(만단)" textAlign="left" />'
		                     +'<SubCaption text="거래금액(백만원)" textAlign="right" />'
		                     +'<Legend position="bottom" defaultMouseOverAction="false" useVisibleCheck="false" />'
		                 +'</Options>'
		    +'<NumberFormatter id="numFmt" useThousandsSeparator="true"/>'
		    +'<Combination2DChart showDataTips="true" dataTipJsFunction="dataTipFunc">'
		        +'<horizontalAxis>'
		           +'<CategoryAxis categoryField="saleMonth"/>'
		        +'</horizontalAxis>'
		        +'<verticalAxis>'
		            +'<LinearAxis id="vAxis1"  formatter="{numFmt}" />'
		            +'<LinearAxis id="vAxis2"  formatter="{numFmt}" />'
		        +'</verticalAxis>'
		        +'<series>'
		            +'<Column2DSet type="clustered">'
		                +'<series>'
		                    +'<Column2DSeries verticalAxis="{vAxis1}" yField="totQty" displayName="거래량(만단)">'
		                        +'<showDataEffect>'
		                            +'<SeriesInterpolate/>'
		                        +'</showDataEffect>'
		                    +'</Column2DSeries>'
		                +'</series>'
		            +'</Column2DSet>'
		            +'<Line2DSeries verticalAxis="{vAxis2}" yField="totAmt" radius="4" itemRenderer="CircleItemRenderer" displayName="거래금액(백만원)">'
		            +'<fill>'
	          		+'<SolidColor color="#04B45F" alpha="1"/>'
				+'</fill>'
				+'<lineStroke>'
					+'<Stroke color="#04B45F" weight="2"/>'
				+'</lineStroke>'
                +'<stroke>'
                    +'<Stroke color="#04B45F" weight="2"/>'
                +'</stroke>'
		            +'<showDataEffect>'
		                    +'<SeriesInterpolate/>'
		                +'</showDataEffect>'
		            +'</Line2DSeries>'
		        +'</series>'
		        +'<verticalAxisRenderers>'
		            +'<Axis2DRenderer axis="{vAxis1}" placement="left" showLine="false"/>'
		            +'<Axis2DRenderer axis="{vAxis2}" placement="right" showLine="false"/>'
		        +'</verticalAxisRenderers>'
		    +'</Combination2DChart>'
		+'</rMateChart>';

		//차트 데이터
		var chartData = [];

		function rMateChartH5ChangeTheme(theme){
		    document.getElementById("chart1").setTheme(theme);
		}

		// -----------------------차트 설정 끝 -----------------------

		$(document).ready(function(){
			$("#pumSelectbox").css('display','none');
			$("#liStrDate").css("display","none");
			$("#liEndDate").children(".search_01_txt").text("기준년도");
			$("#searchEndDate").bindDate({align:"right", valign:"bottom", separator:"-", selectType:"y",  defaultSelectType:"y", value:"",
				onchange:function(){
					var searchFlag=dateChkend();
					if(searchFlag==true){
						cmpCd = $("#cmpCdTab .on > input").attr("value");
						flowerCd = $("#flowerTab .on > input").attr("value");
						searchSaleDate = $("#searchEndDate").val();
					}else{
		       			alert("2014년도부터 당월년도까지만 선택이 가능합니다");
		       		}
				}

			});
			$("#excelBtn1").empty();
			$("#excelBtn1").append('<a href="javascript:void(0);" id="exportBtn1" name="exportTable1" onclick="excelExport();"><img src="../images/2020/exel.png" alt="엑셀이미지">엑셀저장</a>');

		});

		function dateChkend(){

		    var searchGoFlag=false;
			var selectDate = $("#searchEndDate").val().replace(/-/gi, "");
			var today = new Date();

			var yy= today.getFullYear();

			today = yy;

			if(2014 <= selectDate && selectDate<=today){
				searchGoFlag=true;
			}
			return searchGoFlag;
		}
		// 엑셀 다운로드
		function excelExport(){
			var excelNm = "연도별 실적";
			searchEndDate = $("#searchEndDate").val();
			cmpCd = $("#cmpCdTab .on > input").attr("value");
			flowerCd = $("#flowerTab .on > input").attr("value");
			var itemCd = $("#itemCd option:selected").val();
			var itemCd2 = $("#itemCd2 option:selected").val();
			var param = "?excelNm="+excelNm+"&searchYear="+searchEndDate+"&searchCmpCd="+cmpCd+"&searchProductGubun="+flowerCd;
			location.href = "/excel/excelDownLoadHab10.do"+param;
		}

		function init(){
			chartData = [];
			rMateChartLoding("chart1", "chartReadyHandler");

			$("#get1").empty();
			$("#get1").append("<tr><td colspan='8'>데이터가 없습니다.</td></tr>");
			$("#get2").empty();
		}

		function search(){
			cmpCd = $("#cmpCdTab .on > input").attr("value");
			flowerCd = $("#flowerTab .on > input").attr("value");
			searchSaleDate = $("#searchEndDate").val();
			
			if(2014 > searchSaleDate){	
				return;
			}
			

			// 검색 시 쿠키저장
			$.cookie("cookie.cmpCd", cmpCd, {expires: 7, path: '/' });
			$.cookie("cookie.flowerCd", flowerCd, { expires: 7, path: '/' });
			//$.cookie("cookie.pumCd", itemCd,{ expires: 7, path: '/' });
			//$.cookie("cookie.goodCd", itemCd2, { expires: 7, path: '/' });

			getChartData(flowerCd, cmpCd, searchSaleDate);
			getData(flowerCd, cmpCd, searchSaleDate);
		}


		function SeparatCom(num) {
		    return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		}

		function getSaledate(cmpCd, flowerCd){
			$.ajax({
				type : "post",
				url : "/search/selectSaleYear.json",
				data : {
					searchProductGubun : flowerCd,
					searchCmpCd : cmpCd
				},
				dataType : '',
				success : function(res){
					var val = res.list;
					if(res.list!=null && res.list.length > 0){
						var saleYear=val[0].SALE_YEAR;
						searchSaleDate = saleYear.substring(0,4);
						$("#searchEndDate").val(searchSaleDate);
						search();
					}
					if(val[0] == null){
						searchSaleDate = '';
						$('#searchEndDate').val(searchSaleDate);
						init();
					}
				}
			});
		}

		function getChartData(flowerCd, cmpCd, searchSaleDate){
			$.ajax({
				type : "post",
				url : "/hab10/hab10ChartData.json",
				data : {
					searchProductGubun : flowerCd,
					searchCmpCd : cmpCd,
					searchYear : searchSaleDate
				},
				dataType : '',
				success : function(res){
					var val = res.list;

					chartData = val;

					var maxQty = 0;
					var maxAmt = 0;

					for(var i=0; i<val.length; i++){

						var totQty = parseInt(val[i].totQty);
						var totAmt = parseInt(val[i].totAmt);

						maxQty = maxQty > totQty ? maxQty : totQty;
						maxAmt = maxAmt > totAmt ? maxAmt : totAmt;
					}
					maxQty *= 1.2;
					maxAmt *= 1.2;
					layoutStr =
						 '<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'
					     +'<Options>'
					     	+'<SubCaption text="출하량(만단)" textAlign="left" />'
					        +'<SubCaption text="금액(백만원)" textAlign="right" />'
					        +'<Legend position="bottom" defaultMouseOverAction="false" useVisibleCheck="false" />'
										
						+'</Options>'
					    +'<NumberFormatter id="numFmt" useThousandsSeparator="true"/>'
					    +'<Combination2DChart showDataTips="true" dataTipDisplayMode="axis" >'
					        +'<horizontalAxis>'
					           +'<CategoryAxis categoryField="saleYear"/>'
					        +'</horizontalAxis>'
					        +'<verticalAxis>'
					            +'<LinearAxis id="vAxis1"  formatter="{numFmt}" maximum="'+maxQty+'"/>'
					            +'<LinearAxis id="vAxis2"  formatter="{numFmt}" maximum="'+maxAmt+'"/>'
					        +'</verticalAxis>'
					        +'<series>'
					            +'<Column2DSet type="clustered">'
					                +'<series>'
					                    +'<Column2DSeries verticalAxis="{vAxis1}" yField="totQty" displayName="거래량(만단)">'
					                        +'<showDataEffect>'
					                            +'<SeriesInterpolate/>'
					                        +'</showDataEffect>'
					                    +'</Column2DSeries>'
					                +'</series>'
					            +'</Column2DSet>'
					            +'<Line2DSeries verticalAxis="{vAxis2}" yField="totAmt" radius="4" itemRenderer="CircleItemRenderer" displayName="거래금액(백만원)">'
						            +'<fill>'
					          			+'<SolidColor color="#04B45F" alpha="1"/>'
									+'</fill>'
									+'<lineStroke>'
										+'<Stroke color="#04B45F" weight="2"/>'
									+'</lineStroke>'
				                	+'<stroke>'
				                    	+'<Stroke color="#04B45F" weight="2"/>'
				                	+'</stroke>'
						            +'<showDataEffect>'
					                    +'<SeriesInterpolate/>'
					                +'</showDataEffect>'
					            +'</Line2DSeries>'
					        +'</series>'
					        +'<verticalAxisRenderers>'
					            +'<Axis2DRenderer axis="{vAxis1}" placement="left" showLine="false"/>'
					            +'<Axis2DRenderer axis="{vAxis2}" placement="right" showLine="false"/>'
					        +'</verticalAxisRenderers>'
					    +'</Combination2DChart>'
					+'</rMateChart>';


					rMateChartLoding("chart1", "chartReadyHandler");
				}
			});
		}

		function getData(flowerCd, cmpCd, searchSaleDate){
			$("#get1").empty();

			$.ajax({
				type : "post",
				url : "/hab10/hab10Data.json",
				data : {
					searchProductGubun : flowerCd,
					searchCmpCd : cmpCd,
					searchYear : searchSaleDate
				},
				dataType : '',
				success : function(res){
					var val = res.list;

					if(val != ""){
						var html = "";
						for(var i=0; i<val.length; i++){
							// 기준년도 | 상세버튼 | 거래량 | 거래금액
							html += "<tr>";
							html += "<td class='tc'><p>" + val[i].saleYear + "년</p></td>";
							let url = 'location.href="/hab06/hab06.do?year=' + val[i].saleYear + '"';
							html += "<td><button class='btn_type_grid' onClick='" + url + "'>상세</button></td>";
							html += "<td class='tc'><p>" + SeparatCom(val[i].totQty) + "</p></td>";
							html += "<td class='tc'><p>" + SeparatCom(val[i].totAmt) + "</p></td>";
							html += "</tr>";
						}
						$("#get1").append(html);
					}else{
						$("#get1").append("<tr><td colspan='5'>데이터가 없습니다.</td></tr>");
					}


				}
			});
		}

	</script>
</head>
<body>
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
				<li class="m_right">연도별 실적</li>
			</ul>
		</div>
		<!--공통 HEADER(E)-->

		<!--서브 타이틀(S)-->
		<jsp:include page="../inc/2020/IncShare.jsp"/>

		<div class="sub_title">
			<div class="title_box">
				<h2>연도별 실적</h2>
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
			<div>
				<table class="table_type_01 btg tiny">
					<caption>연도별 실적</caption>
					<colgroup>
						<col style="width:20%">
						<col style="width:10%">
						<col style="width:35%">
						<col style="width:35%">
					</colgroup>
					<thead>
						<tr>
							<th class="tc" colspan="2">기준년도</th>
							<th class="tc">거래량(만단)</th>
							<th class="tc">경매금액(백만원)</th>
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
				<li class="">· 연도별 실적을 한눈에 파악 할 수 있는 화면</li>
				<li class="">· 단위 :거래량(만단), 경매금액(백만원) / 자료출처 : 각 공판장별 경매 자료 현황</li>
			</ul>
		</div>

		<!--컨텐츠 내용(E)-->

		<jsp:include page="../inc/2020/IncFooter.jsp"/>

	</div>
	<!--WRAP(E)-->
</body>
</html>