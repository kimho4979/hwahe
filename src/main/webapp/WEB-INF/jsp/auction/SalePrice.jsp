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
	<meta name="description" content="소비동향">
	<meta name="content" content="화훼유통정보시스템 입니다.">
	<meta name="keywords" content="화훼경매시세, 화훼경매가격, Korea aT flower market auction price, 화훼공판장, 화훼거래정보, 꽃시장, 꽃값">
	<meta name="Author" content="화훼유통정보시스템 & www.woorim.co.kr">
	<title>소비동향</title>
	<%@include file="../common/2020/commonJs.jsp" %>
	<%@include file="../common/2020/commonCss.jsp" %>
	
	<script type="text/javascript">
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
	var layoutStr = 
					'<rMateChart backgroundColor="#FFFFFF"  borderStyle="none">'		
					+'<Options>'
					+'<Legend position="right" direction="vertical" hAlign="left" vAlign="middle" labelPlacement="right" useVisibleCheck="false" horizontalGap="1" fontSize="14" verticalGap="1" paddingLeft="1"  />'
					+'</Options>'
						+'<Pie2DChart id="chart" innerRadius="0.3" showDataTips="true" selectionMode="single">'
					/* 
					Doughnut2D 차트 생성시에 필요한 Pie2DChart 정의합니다 
					showDataTips : 데이터에 마우스를 가져갔을 때 나오는 Tip을 보이기/안보이기 속성입니다.  
					innerRadius : PieChart 가운데에 빈 공간을 만듭니다. 유효값 0.1 ~ 0.9 0은 PieChart 1은 차트 사라짐
					*/
							+'<series>'
								+'<Pie2DSeries nameField="goodName" field="qty" startAngle="-90" renderDirection="clockwise" labelPosition="inside" labelJsFunction="pieSeriesLabelFunc" color="#ffffff">'
								/* Pie2DChart 정의 후 Pie2DSeries labelPosition="inside"정의합니다 */
									+'<showDataEffect>'
									/* 차트 생성시에 Effect를 주고 싶을 때 shoDataEffect정의합니다 */
										+'<SeriesZoom duration="1000"/>'
					/* 
					SeriesInterpolate 효과는 시리즈 데이터가 데이터로 표시될 때 한쪽에서 미끄러지듯 나타나는 효과를 적용합니다
					- 공통속성 -						
					elementOffset : effect를 지연시키는 시간을 지정합니다 default:20
					minimumElementDuration : 각 엘리먼트의 최소 지속 시간을 설정합니다 default:0
								 이 값보다 짧은 시간에 effect가 실행되지 않습니다
					offset : effect개시의 지연시간을 설정합니다 default:0
					perElementOffset : 각 엘리먼트의 개시 지연시간을 설정합니다
					- SeriesSlide속성 -
					direction : left:왼쪽, right:오른쪽, up:위, down:아래 default는 left입니다
					*/
									+'</showDataEffect>'
								+'</Pie2DSeries>'
							+'</series>'
							+'<backgroundElements>'
								+'<CanvasElement>'
									+'<Label text="" horizontalCenter="0" verticalCenter="0" fontSize="15" fontWeight="bold" color="#777777" backgroundAlpha="0"/>'
								+'</CanvasElement>'
							+'</backgroundElements>'
						+'</Pie2DChart>'
					+'</rMateChart>';

	//차트 데이터
	var chartData = JSON.parse( '${list}');


	function pieSeriesLabelFunc(seriesId, index, data, values){
	    return Number(values[1]).toFixed(2)+"%";
	}
	/**
	* rMateChartH5 3.0이후 버전에서 제공하고 있는 테마기능을 사용하시려면 아래 내용을 설정하여 주십시오.
	* 테마 기능을 사용하지 않으시려면 아래 내용은 삭제 혹은 주석처리 하셔도 됩니다.
	*
	* -- rMateChartH5.themes에 등록되어있는 테마 목록 --
	* - simple
	* - cyber
	* - modern
	* - lovely
	* - pastel
	* -------------------------------------------------
	*
	* rMateChartH5.themes 변수는 theme.js에서 정의하고 있습니다.
	*/
	//rMateChartH5.registerTheme(rMateChartH5.themes);

	/**
	* 샘플 내의 테마 버튼 클릭 시 호출되는 함수입니다.
	* 접근하는 차트 객체의 테마를 변경합니다.
	* 파라메터로 넘어오는 값
	* - simple
	* - cyber
	* - modern
	* - lovely
	* - pastel
	* - default
	*
	* default : 테마를 적용하기 전 기본 형태를 출력합니다.
	*/
	function rMateChartH5ChangeTheme(theme){
		document.getElementById("chart1").setTheme(theme);
	}

	function chartText(){
		
		  var list2 = JSON.parse( '${jsonList}');	
		  
		var test = "";	
		  for(i=0 ; i < list2.length; i++){
			  test +=  list2[i].bigo 		 
		  }
		  
		  var divSaleText=document.getElementById("saleText");
			
		  divSaleText.innerHTML=test;	  	  	  	  
		
	}

	//-----------------------차트 설정 끝 -----------------------
	 // 액시스제이 시작
	   var fnObj = {
	       pageStart: function(){
	    	   
	    	   
	    	   $("#datepicker").bindDate({align:"right", valign:"bottom", separator:"-", selectType:"m",  defaultSelectType:"m", value:"",
			       	onchange:function(){
			       		fn_search(1);
					},
				});
	       }     
	   };
	
		// 엑셀 다운로드
		function excelExport(){
			var excelNm = "소비동향";
			var regMonth = $("#datepicker").val();
			var param = "?excelNm="+excelNm+"&regMonth="+regMonth;
			location.href = "/excel/excelDownLoad.do"+param;
		}

	   function gfn_isNull(str) {
			if (str == null) return true;
			if (str == "NaN") return true;
			if (new String(str).valueOf() == "undefined") return true;    
		    var chkStr = new String(str);
		    if( chkStr.valueOf() == "undefined" ) return true;
		    if (chkStr == null) return true;    
		    if (chkStr.toString().length == 0 ) return true;   
		    return false; 
		}

	   function fn_search(pageNo){
		   $("#currentPageNo").val(pageNo);
		    var frm = $("#saleForm");
			frm.action = this.url;
			frm.method = "post";
			frm.submit();	
		}
		
		function chart_ajax(){   		
		   var SALE_MONTH = $("#datepicker").val();
	     	$.ajax({
	         type : 'get',
	         url : "/hdb02/chartList.json",
	         data :  '&REG_MONTH='+SALE_MONTH,
	         dataType : '',   	           
	         success : function(res){ 
			     chartData = res.list;                                                                                           
			     rMateChartLoding("chart1", "chartReadyHandler");
	         },
	     });      	    
	 }
		

   $(document).ready(fnObj.pageStart);   
   $(document).ready(function(){		
	   	$("#excelBtn1").empty();
		//$("#excelBtn1").append('<button type="button" class="excelSaveBtn" id="exportBtn1" name="exportTable1" onclick="excelExport();">엑셀저장</button>');
		$("#excelBtn1").append('<a href="javascript:void(0);" id="exportBtn1" name="exportTable1" onclick="excelExport();"><img src="../images/2020/exel.png" alt="엑셀이미지">엑셀저장</a>');
   });
	</script>
</head>

<body>
	<div class="wrap">
		 <!-- 모바일_LNB(E) -->
		 <!--공통 HEADER(S)-->
		 <jsp:include page="../inc/2020/IncHeader.jsp"/>

		
		<div class="lnb_box">
			<ul>
				<li><img src="../images/2020/m_lnb_img.png" alt="집"></li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li>생산/소비정보</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li>소비동향(장미)</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li class="m_right">소비동향</li>
			</ul>
		</div>
		<!--공통 HEADER(E)-->
		
		<!--서브 타이틀(S)-->
		<jsp:include page="../inc/2020/IncShare.jsp"/>
		<div class="sub_title">
			<div class="title_box">
				<h2>소비동향</h2>
				<img src="../images/2020/sub/t_line.png" alt="방울점선">
			</div>
		</div>
		<!--서브 타이틀(E)-->
		<!--서브공통 (S)-->
		<div class="sub_contents">
			<!--서브 리스트 (S)-->
			<!-- <div class="sub_content">
				<ul class="sub_tab">
					<li class="s_on"><a href="#!">aT화훼공판장 <span>(양재동)</span></a></li>
					<li><a href="#!">부산화훼공판장 <span>(엄궁동)</span></a></li>
					<li><a href="#!">부산경남화훼농협 <span>(강동동)</span></a></li>
					<li><a href="#!">광주원예농협 <span>(풍암)</span></a></li>
					<li><a href="#!">한국화훼농협 <span>(음성)</span></a></li>
					<li><a href="#!">aT화훼농협 <span>(과천)</span></a></li>
				</ul>
			</div> -->
			<!--서브 리스트 (E)-->
			<!--서브 TAB공통 (S)-->
			<!--서브 TAB공통 (S)-->
			
			<div class="search_box">
				<div class="search_01">
					<form action="/auction/SalePrice.do" method="post" id="saleForm" name="saleForm">
						<ul class="search_box01">
							<li class="calendar">
								<p class="search_01_txt">날짜선택</p>
								<input type="text" class="datepicker" name="datepicker" id="datepicker" value="${regMonth}">
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
			<div class="trend_box_b">
						
				<div class="big_box_b">
					<div class="trend_graph_b">
						<div id="chartHolder" style="width:100%; height:340px;"></div>
					</div>
					<div class="trend_list_b">
						<table>
							<caption>소비동향</caption>
							<colgroup>
								<col style="width:20%">
								<col style="width:45%">
								<col style="width:35%">
							</colgroup>
							<thead>
								<tr>
									<th>순위</th>
									<th>품종</th>
									<th>판매량</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="hda01" items="${resultList}" varStatus="status">  
								  <tr>
									<td>${hda01.rnum}</td>
									<td>${hda01.goodName}</td>
									<td><fmt:formatNumber value="${hda01.qty}" type="number"/></td>					
								  </tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
				<div class="trend_txt_b">
					<table>
						<caption>소비동향</caption>
						<colgroup>
							<col style="width:20%">
							<col style="width:10%">
							<col style="width:60%">
							<col style="width:10%">
						</colgroup>
						<thead>
							<tr>
								<th>일자</th>
								<th>품종</th>
								<th>내용</th>
								<th>지역</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="pointSale" items="${pointSale}" varStatus="status">  
							  <tr>
								<td>${pointSale.regDate}</td>
								<%-- <td>${pointSale.pumName}</td> --%>
								<td>${pointSale.goodName}</td>
								<td>${pointSale.bigo}</td>			
								<td>${pointSale.chulNo}</td>								
							  </tr>
							</c:forEach>
						</tbody>
					</table>
					<div class="paging_box">
						<div class="paging">
							<c:if test="${not empty paginationInfo}">
								<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_search"/>
							</c:if>
							<input type="hidden" id="currentPageNo" name="currentPageNo"/>
						</div><!-- paging end -->
					</div>
					<div class="dwn_bt_b" id="excelBtn1">
						<a href="#!"><img src="../images/2020/exel.png" alt="엑셀이미지">엑셀저장</a>
					</div>
				</div>
			</div>
			
			<div class="guide">
				<h2 class="title_02">이용안내</h2>
				<ul class="guide_box">
					<li>· 소비자 선호 품종 및 주 소비처(예식장 등)별 소비동향을 파악하기 위한 화면  </li>
					<li>· 대상품목 : 장미</li>
					<li>· 자료출처 : 선정 된 15개 업체의 입력 정보(유사시장 : 5, 직매장 및 화원 : 10)</li>
				</ul>
			</div>
		</div>
		<!--컨텐츠 내용(E)-->
		<!--FOOTER(S)-->
		<jsp:include page="../inc/2020/IncFooter.jsp"/>
		<!--FOOTER(S)-->
	</div>
	<!--WRAP(E)-->
</body>

</html>
