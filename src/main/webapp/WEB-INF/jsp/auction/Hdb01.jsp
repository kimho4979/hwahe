<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
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
	<meta name="description" content="소매가격동향">
	<meta name="content" content="화훼유통정보시스템 입니다.">
	<meta name="keywords" content="화훼경매시세, 화훼경매가격, Korea aT flower market auction price, 화훼공판장, 화훼거래정보, 꽃시장, 꽃값">
	<meta name="Author" content="화훼유통정보시스템 & www.woorim.co.kr">
	<title>소매가격동향</title>
	<%@include file="../common/2020/commonJs.jsp" %>
	<%@include file="../common/2020/commonCss.jsp" %>
	
	<script type="text/javascript">   
		$(window).on('resize.jqGrid', function () {
			$("#jqGrid").jqGrid( 'setGridWidth', $(".retail_box_b > div").width());
			$("#jqGridPager").jqGrid( 'setGridWidth', $(".retail_box_b > div").width());
		    $(".ui-jqgrid-bdiv").width($(".ui-jqgrid-bdiv").width()+1);
		});
		
		var myProgress = new AXProgress();
		var myGrid = new AXGrid();		
				 
		//-----------------------차트 설정 시작-----------------------
		
		//rMate 차트 생성 준비가 완료된 상태 시 호출할 함수를 지정합니다.
		var chartVars = "rMateOnLoadCallFunction=chartReadyHandler";
		
		//rMateChart 를 생성합니다.
		//파라메터 (순서대로) 
		//1. 차트의 id ( 임의로 지정하십시오. ) 
		//2. 차트가 위치할 div 의 id (즉, 차트의 부모 div 의 id 입니다.)
		//3. 차트 생성 시 필요한 환경 변수들의 묶음인 chartVars
		//4. 차트의 가로 사이즈 (생략 가능, 생략 시 100%)
		//5. 차트의 세로 사이즈 (생략 가능, 생략 시 100%)
		rMateChartH5.create("chart1", "chartHolder", chartVars, "100%", "100%"); 
		
		//차트의 속성인 rMateOnLoadCallFunction 으로 설정된 함수.
		//rMate 차트 준비가 완료된 경우 이 함수가 호출됩니다.
		//이 함수를 통해 차트에 레이아웃과 데이터를 삽입합니다.
		//파라메터 : id - rMateChartH5.create() 사용 시 사용자가 지정한 id 입니다.
		function chartReadyHandler(id) {
			document.getElementById(id).setLayout(layoutStr);
			document.getElementById(id).setData(chartData);
		}
		
		//스트링 형식으로 레이아웃 정의.
		var layoutStr = '<rMateChart paddingTop="24">'
							+'<Options>'
								+'<Caption text="지역별 소매가격 동향 그래프 입니다."/>'
								+'<SubCaption text="단위:원" textAlign="left" />'	
							+'</Options>'
							+'<NumberFormatter id="numfmt" useThousandsSeparator="true"/>' 
							// 데이터 드릴 다운을 위하여 차트 아이템에 click 이벤트를 설정하도록 합니다.
							//+'<Column2DChart showDataTips="true" itemClickJsFunction="itemClick" maxColumnWidth="15" buttonMode="true">'
							+'<Column2DChart showDataTips="true" maxColumnWidth="15" buttonMode="true">'
								+'<horizontalAxis>'
									+'<CategoryAxis categoryField="SAN_NAME"/>'
								+'</horizontalAxis>'
								+'<series>'
									//+'<Column2DSeries yField="REAL_PRICE" displayName="Profit" labelPosition="both" insideLabelJsFunction="labelFunc" fontSize="12">'
									+'<Column2DSeries yField="REAL_PRICE" displayName="Profit">'
										+'<showDataEffect>'
											+'<SeriesInterpolate/>'
										+'</showDataEffect>'
									+'</Column2DSeries>'
								+'</series>'
							+'</Column2DChart>'
						+'</rMateChart>';
		
		//차트 데이터
		var chartData = [];
		
		/*	------------------------- 수치 필드 사용자 정의 함수 -----------------------------------------------------
			챠트의 시리즈에서 labelPosition 속성을 설정한 경우 수치 필드를 사용자 정의하는 함수입니다.
			layout XML 에서 Series 속성을 넣을때 라벨펑션을 설정하고 속성 값으로 javascript 함수명을 넣어줍니다
		
			예) <Column2DSeries yField="Profit" labelPosition="outside" outsideLabelJsFunction="seriesLabelFunc">
		
			파라메터 설명
			seriesID : 해당 시리즈의 ID.
			index : 해당 시리즈 아이템의 인덱스.
			data : 해당 item의 값을 표현하기 위해 입력된 data(입력된 데이타중 해당 row(레코드) 자료입니다)
			values : 해당 item의 값 (배열로 전달되며, 챠트 종류에 따라 아래와 같이 들어옵니다.)
					Pie2DSeries,Pie3DSeries			0:값 1:퍼센트값
					Bubble3DSeries,Matrix2DSeries   0:x축값 1:y축값 2:z값
					Candlestick2DSeries             0:x축값 1:open값 2:close값 3:high값 4:low값
					Bar2D, Column2DWingSeries		0:x축값 1:y축값 2:xOpp값 3:yOpp값
					TreeMapSeries					0:weight값 1:text값
					BoxPlotSeries					0:upper값 1:median값 2:lower값 3:min값 4:hidden값
					Vector2DSeries					0:degree값 1:velocity값 2:meter값
					WordCloudSeries					0:weight값 1:text값
					위 시리즈들을 제외한 시리즈 들  0:x축값 1:y축값 2:min값
					* min값은 type을 '100%' 또는 'stacked' 인 경우만 유효합니다. 쌓아올릴 경우 해당 데이터의 시작값을 의미합니다.
		*/
		function labelFunc(seriesId, index, data, values){
			var str = values[0], depth;
		
			// 차트가 출력하고 있는 데이터의 depth를 가져오도록 합니다.
			// 처음 차트 출력시 0을 반환하며 drilldown 할 때마다 1씩 증가 됩니다.
			// 데이터가 없을 경우 -1을 반환합니다.
			depth = document.getElementById("chart1").getDrillDownDepth();
		
			if(depth == 0)
				str += "\n월별\n클릭";
			else if(depth == 1)
				str += "\n주별\n클릭";
		
			return "<font color='#ffffff'>" + str + "</font>";
		}
		
		/*	------------------------- 챠트에서 item클릭시 불려지는 함수 설정 -----------------------------------------------------
			layout XML 에서 Chart 속성을 넣을때 itemClickJsFunction를 주고,만든 javascript 함수명을 넣어줍니다
			예) <Column2DChart showDataTips="true" itemClickJsFunction="chartItemClickHandler">
		
			파라메터 설명
			seriesId : layout XML에서 부여한 series의 id가 있을 경우, 해당 id를 보내줍니다.
			displayText : 화면상에 보여주는 dataTip(마우스 올라갔을때 보여주는 박스-tooltip)의 내용
			index : 클릭된 item(막대나 파이조각등)의 index 번호 - 맨 왼쪽 또는 맨 위 것이 0번입니다
			data : 해당 item의 값을 표현하기 위해 입력된 data(입력된 데이타중 해당 row(레코드) 자료입니다)
			values : 해당 item의 값 (배열로 전달되며, 챠트 종류에 따라 아래와 같이 들어옵니다.)
					Bar2D, Bar3DSeries				0:x축값 1:y축값
					Column2D, Columnd3DSeries		0:x축값 1:y축값
					Area2DSeries					0:x축값 1:y축값
					Bubble3DSeries					0:x축값 1:y축값 2:radius값
					Line2DSeries					0:x축값 1:y축값
					Candlestick2DSeries				0:x축값 1:open값 2:close값 3:high값 4:low값
					Pie2D, Pie3DSeries				0:값 1:퍼센트값 2:nameFiled명
					Bar2D, Column2DWingSeries		0:x축값 1:y축값 2:xOpp값 3:yOpp값
					Histogram2D, Histogram3DSeries	0:x축값 1:y축값
					TreeMapSeries					0:weight값 1:name값
					BoxPlotSeries					0:upper값 1:median값 2:lower값 3:min값 4:hidden값
					Vector2DSeries					0:degree값 1:velocity값 2:meter값
					WordCloudSeries					0:weight값 1:text값
		*/
		function itemClick(seriesId, displayText, index, data, values){
			var data, depth;
		
			// 차트가 출력하고 있는 데이터의 depth를 가져오도록 합니다.
			// 처음 차트 출력시 0을 반환하며 drilldown 할 때마다 1씩 증가 됩니다.
			// 데이터가 없을 경우 -1을 반환합니다.
			depth = document.getElementById("chart1").getDrillDownDepth();
		
			// 출력하려는 depth에 제한이 있다면 데이터를 추가 하지 않도록 설정합니다.
			if(depth == 2){
				alert("데이터가 없습니다.");
				return;
			}
		
			// 현재 차트의 drilldown depth를 보고 출력하고자 하는 데이터를 생성하여 차트에 설정합니다.
			document.getElementById("chart1").setDataDrilldown(makeData(depth));
		}
		
		function makeData(depth){
			var i = 0, n, arr = [], obj,
				categoryDatas = [
					["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
					["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
				];
		
			n = categoryDatas[depth].length;
			
			for(i ; i < n ; i += 1){
				obj = {};
				obj.Month = categoryDatas[depth][i];
				obj.Profit = Math.round(Math.random() * 1500);
				arr.push(obj);
			}
			return arr;
		}
		
		//-----------------------차트 설정 끝 -----------------------

		var fnObj = {
				pageStart: function(){
				$("#excelBtn1").empty();
				$("#excelBtn1").append('<a href="javascript:void(0);" id="exportBtn1" name="exportTable1" onclick="excelExport();"><img src="../images/2020/exel.png" alt="엑셀이미지">엑셀저장</a>');
		    	   
				$("#datepicker").bindDate({align:"right", valign:"bottom", separator:"-", selectType:"m",  defaultSelectType:"m", value:"",
					onchange:function(){
						chart_ajax();
					}
				});
		    	//chart_ajax();
		    	   
				var SALE_MONTH =$("#datepicker").val();
				$.ajax({
			    	type : 'post',
			    	url : "/hdb01/chartList.json",
			    	data :  '&REG_MONTH='+SALE_MONTH,
			    	dataType : '',   	           
			    	success : function(res){			      		
			     		chartData = res.list;                                                                                           
			      		rMateChartLoding("chart1", "chartReadyHandler");			      		
					}
				});
				$("#jqGrid").jqGrid({
					url : "/hdb01/chartList.json",
		          	mtype: 'POST',
		          	postData: {
		          		REG_MONTH : SALE_MONTH
					},
					datatype: "json",
					jsonReader: {    // json 데이터형식과 맞춰주는거 같다. (요기가 없으니까..그리드안 데이터를 못뿌리네..)
						root : "list",  // list 이름
						page : "page",
						total : "total",
						records : "records",
						repeatitems : false
					},
					colModel: [
						{ label: '날짜', name: 'REG_MONTH', hidden:true },
						{ label: '날짜', name: 'REG_MONTH',width: 80, editable: false , align:"center"},
						{ label: '지역명', name: 'SAN_NAME', width: 90, editable: false, align:"center" },
						{ label: '소매가격(원)', name: 'REAL_PRICE', width: 90, editable: false, align:"center", sorttype: 'float', formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' } }
					],
					loadonce: true,
					//rownumbers : true,
					autowidth: true,
					//viewrecords : true,
					//hoverrows : true,
					height: '267',
					sortable: true,
					emptyrecords : '데이터가 없습니다.',
					pager: "#jqGridPager",
					loadComplete : function(res) {
						$("#jqGrid").jqGrid( 'setGridWidth', $(".retail_box_b > div").width());
						$("#jqGridPager").jqGrid( 'setGridWidth', $(".retail_box_b > div").width());
					    $(".ui-jqgrid-bdiv").width($(".ui-jqgrid-bdiv").width()+1);
					}
				});
				
	      		$('#jqGrid').navGrid('#jqGridPager',
					// the buttons to appear on the toolbar of the grid
					{ edit: false, add: false, del: false, search: false, refresh: true, view: false, position: "left", cloneToTop: false },
					{
						errorTextFormat: function (data) {
							return 'Error: ' + data.responseText
						}
					},
					{ multipleSearch: true} // search options - define multiple search
				);
			}
		};

		function excelExport(){
			var excelNm = "소매가격동향";
			var searchSaleDate = $("#datepicker").val();
			var param = "?excelNm="+excelNm+"&REG_MONTH="+searchSaleDate;
			location.href = "/excel/excelDownLoad.do"+param;
		}


		function chart_ajax(){   		
			var SALE_MONTH =$("#datepicker").val();	   
			$.ajax({
		    	type : 'get',
		    	url : "/hdb01/chartList.json",
		    	data :  '&REG_MONTH='+SALE_MONTH,
		    	dataType : '',   	           
		    	success : function(res){
			    	/* //품목별 그리드
		    		myGrid.setConfig({
		    			targetID : "AXGridTarget",
		    			theme : "AXGrid",
		    			fixedColSeq : '',
		    			fitToWidth:true,
		    			colGroup : [       	              
			    			{key:"REG_MONTH", label:"날짜", width:"80", align:"center"},                 
			    			{key:"SAN_NAME", label:"지역명", width:"90", align:"center"},
			    			{key:"REAL_PRICE", label:"소매가격(원)", width:"90", align:"right", formatter: "money"}       	                   	                           
			    		],
		    			colHeadAlign:"center",
		    			page:{
			    			display:true       	                 
			    			}       	                    	            
	    			});
		       	 
		     		myGrid.setList(res.list); */
		      		
		     		chartData = res.list;                                                                                           
		      		rMateChartLoding("chart1", "chartReadyHandler");	      		
		      		
				}
			});			
		     
			$("#jqGrid").setGridParam({
				datatype	: "json",
				postData	: {
					REG_MONTH : SALE_MONTH
				},
				page : 1
			}).trigger("reloadGrid");
      		
		}; 
		 
		$(document).ready(fnObj.pageStart);   
   
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
				<li>생산/소비정보</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li>소매가격(장미)</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li class="m_right">소매가격동향</li>
			</ul>
		</div>
		<!--공통 HEADER(E)-->
		
		<!--서브 타이틀(S)-->
		<jsp:include page="../inc/2020/IncShare.jsp"/>
		
		<div class="sub_title">
			<div class="title_box">
				<h2>소매가격동향</h2>
				<img src="../images/2020/sub/t_line.png" alt="방울점선">
			</div>
		</div>
		<!--서브 타이틀(E)-->
		<!--서브공통 (S)-->
		<div class="sub_contents">
			<!--서브 리스트 (S)-->
			
			<!--서브 리스트 (E)-->
			<!--서브 TAB공통 (S)-->
			<div class="search_box">
				<div class="search_01">
					<form action="/auction/SalePrice.do" method="post" id="saleForm" name="saleForm">
						<ul class="search_box01">
							<li class="calendar">
								<p class="search_01_txt">날짜선택</p>
								<input type="text"  class="datepicker" name="datepicker" id="datepicker" value="${regMonth}">
								<!-- <input type="text"  value="YYYY-MM-DD" alt="켈린더" class="datepicker" > -->
							</li>						
						</ul>
					</form>
				</div>
			</div>
			<!--서브 TAB공통 (E)-->
		</div>		
		
		<!--컨텐츠 내용(S)-->
		<div class="sub_guide">
			<div class="retail_box_b">
				<div class="retail_graph_b">
					<div id="chartHolder" style="height:400px;"></div>
				</div>
				<div class="retail_list_b">
					<!-- <div id="AXGridTarget" style="height:267px;"></div>  -->
					<table id="jqGrid" class="boxList"></table>
					<div id="jqGridPager" style="height:35px;"></div>
				</div>
			</div>
			
			<!-- 버튼박스(S) -->
			<div class="dwn_bt_b" id="excelBtn1">
				<a href="#!">엑셀저장</a>
			</div>
			<!-- 버튼박스(E) -->
		
			<div class="guide">
				<h2 class="title_02">이용안내</h2>
				<ul class="guide_box">
					<li>· 지역별 소매가격동향을 알아볼수있는 화면</li>
					<li>· 대상품목 : 장미</li>
					<li>· 자료출처 : 선정 된 15개 업체의 입력 정보(유사시장 : 5, 직매장 및 화원 : 10)</li>
				</ul>
			</div>
		</div>
		<!--컨텐츠 내용(E)-->
		
		<jsp:include page="../inc/2020/IncFooter.jsp"/>
		
	</div>
	<!--WRAP(E)-->
</body>
</html>
