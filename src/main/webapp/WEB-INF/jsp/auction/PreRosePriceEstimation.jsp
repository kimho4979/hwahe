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
	<meta name="description" content="장미가격 예측평가">
	<meta name="content" content="화훼유통정보시스템 입니다.">
	<meta name="keywords" content="화훼경매시세, 화훼경매가격, Korea aT flower market auction price, 화훼공판장, 화훼거래정보, 꽃시장, 꽃값">
	<meta name="Author" content="화훼유통정보시스템 & www.woorim.co.kr : Kim Juyeon">
	<title>장미가격 예측평가</title>
	<%@include file="../common/2020/commonJs.jsp" %>
	<%@include file="../common/2020/commonCss.jsp" %>
  
	<script type="text/javascript">

		$(window).on('resize.jqGrid', function () {
		    $("#jqGrid").jqGrid( 'setGridWidth', $(".rose_list_b > div").width());
		    $(".ui-jqgrid-bdiv").width($(".ui-jqgrid-bdiv").width()+1);
		});
	
		//-----------------------차트 설정 시작-----------------------
		var initFlag=true;
		
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
		'<rMateChart backgroundColor="#ffffff" borderStyle="none">'
			+'<Options>'
				+'<Legend defaultMouseOverAction="false" useVisibleCheck="false"/>'
			+'</Options>'
			+'<NumberFormatter id="numFmt" useThousandsSeparator="true"/>'
			+'<Line2DChart showDataTips="true" dataTipDisplayMode="axis" paddingTop="0">'
				+'<horizontalAxis>'
					+'<CategoryAxis categoryField="repComp" />'
				+'</horizontalAxis>'
				+'<verticalAxis>'
					+'<LinearAxis  id="vAxis1" formatter="{numFmt}"/>'
				+'</verticalAxis>'
			+'<series>'
				+'<Line2DSeries labelPosition="up"  formatter="{numFmt}" showMinValueLabel="true" showMaxValueLabel="true" verticalAxis="{vAxis1}" yField="avgAmt" radius="3" displayName="금년평균가격" itemRenderer="CircleItemRenderer">'
					  +'<fill>'
		          		+'<SolidColor color="#42b1e5" alpha="1"/>'
					+'</fill>'	
					+'<lineStroke>'
						+'<Stroke color="#42b1e5" weight="2"/>'
					+'</lineStroke>'
					+'<stroke>'
			            +'<Stroke color="#42b1e5" weight="2"/>'
			        +'</stroke>'		
			        +'<showDataEffect>'
			            +'<SeriesInterpolate/>'
				        +'</showDataEffect>'
			         +'</Line2DSeries>'
				 +'<Line2DSeries labelPosition="up" radius="3" yField="prePrice" showMinValueLabel="true" showMaxValueLabel="true"  lineStyle="dashLine" dashLinePattern="2" itemRenderer="CircleItemRenderer" displayName="예측가격">'
					 +'<fill>'
		       			+'<SolidColor color="#e54242" alpha="1"/>'
					+'</fill>'	
				 	+'<lineStroke>'
						+'<Stroke color="#e54242" weight="2"/>'
							+'</lineStroke>'
							+'<stroke>'
					            +'<Stroke color="#e54242" weight="2"/>'
					        +'</stroke>'		
					        +'<showDataEffect>'
					            +'<SeriesInterpolate/>'
					        +'</showDataEffect>'
			   +'</Line2DSeries>'
			+'</series>'
			+'<verticalAxisRenderers>'
	        +'<Axis2DRenderer axis="{vAxis1}" placement="left" showLine="false"/>'
	    +'</verticalAxisRenderers>'
		+'</Line2DChart>'
		+'</rMateChart>';
		
		//차트 데이터
		var chartData = [];
		
		rMateChartH5.registerTheme(rMateChartH5.themes);
		
		function rMateChartH5ChangeTheme(theme){
		document.getElementById("chart1").setTheme(theme);
		}
		
		//-----------------------차트 설정 끝 -----------------------
		
		$(document).ready(function(){		
			$("#baseDate").datepicker({
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
				yearSuffix: '년',
				changeMonth: true,
		        changeYear: true,
				beforeShowDay: function(date){
					var day = date.getDay();
					return [(day == 1 || day == 3 || day == 5)];
				},
				onSelect: function(selectedDate){       		
					cmpCd = $("#cmpCdTab .on > input").attr("value");
					//init();
					// 품목조회
					getSaledate(cmpCd);
				}
			});
			
			$("#pumCd").change(function() {
				getLvList();
			});
			
			$("#excelBtn1").empty();
		});
		
		// Excel DownLoad
		function excelExport(){
			var excelNm = "장미가격예측평가";
			var param = "?excelNm="+excelNm+"&sidoCd="+sidoCd;
			//location.href = "/excel/excelDownLoad.do"+param;
		}
		
		// 마지막 일자, 품종 List
		function getSaledate(cmpCd){
			var baseDate = $('#baseDate').val();
			$.ajax({
				type : "post",
				url : "/preRose/selectPreRosePumListEst.json",
				data : {
					baseDate:baseDate,
					searchCmpCd : cmpCd
				},
				dataType : '',
				success : function(res){
					var val = res.list;
					
					if(val!=null&&val.length>0){
						$("#baseDate").val(val[0].baseDate);	
						$("#pumCd").empty();
						for(var i=0; i<val.length; i++){
							$("#pumCd").append("<option value="+val[i].goodName+">"+val[i].goodName+"</option>");
						}
						
					}else{
						$("#pumCd").empty();
					}
					getLvList();
				}
			});
		}
		
		// 등급 List
		function getLvList(){
			var baseDate=$("#baseDate").val();
			var cmpCd = $("#cmpCdTab .on > input").attr("value");
			var pumCd = $("#pumCd option:selected").val();
			$.ajax({
				type : "post",
				url : "/preRose/selectPreRoseLvList.json",
				data : {
					baseDate:baseDate,
					searchCmpCd:cmpCd,
					pumName : pumCd
				},
				dataType : '',
				success : function(res){
					var val = res.list;
					
					$("#lvCd").empty();
					for(var i=0; i<val.length; i++){
						$("#lvCd").append("<option value="+val[i].lvCd+">"+val[i].lvName+"</option>");
					}
					
					if(initFlag){
						list();
						gridList();
						initFlag=false;
					}else{
						search();
					}
				}
			});
		}
		
		function search(){
			var baseDate=$("#baseDate").val();
			var cmpCd = $("#cmpCdTab .on > input").attr("value");
			var pumCd = $("#pumCd option:selected").val();
			var lvCd = $("#lvCd option:selected").val();
			
			list();
			
			$("#jqGrid").setGridParam({
			   	 datatype	: "json",
			   	 postData	: {
			   		baseDate:baseDate,
					searchCmpCd:cmpCd,
					pumCd : pumCd,
					lvCd:lvCd
				},
				page : 1
		    }).trigger("reloadGrid");
		}
		
		// 장미가격예측평가 List
		function list(){
			var baseDate=$("#baseDate").val();
			var cmpCd = $("#cmpCdTab .on > input").attr("value");
			var pumCd = $("#pumCd option:selected").val();
			var lvCd = $("#lvCd option:selected").val();
			
			
			$.ajax({
				type : "post",
				url : "/preRose/selectPreEstList.json",
				data : {
					baseDate:baseDate,
					searchCmpCd:cmpCd,
					pumCd : pumCd,
					lvCd:lvCd
				},
				dataType : '',
				success : function(data){
					var val = data.list;
					if(val!=null&&val.length>0){
		      			  chartData = data.list;
						  rMateChartLoding("chart1", "chartReadyHandler");
					}else{
						chartData =[];
						rMateChartLoding("chart1", "chartReadyHandler");
					}
				}
			});
		}
		
		// 장미가격예측평가 List
		function gridList(){
			var baseDate=$("#baseDate").val();
			var cmpCd = $("#cmpCdTab .on > input").attr("value");
			var pumCd = $("#pumCd option:selected").val();
			var lvCd = $("#lvCd option:selected").val();
			
			$("#jqGrid").jqGrid({
		   		url : "/preRose/selectPreEstGridList.json",
		      		mtype: 'POST',
		      		postData: 
		    	   {
		      			baseDate:baseDate,
						searchCmpCd:cmpCd,
						pumCd : pumCd,
						lvCd:lvCd
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
		               { label: '예측대상일', name: 'repComp',width: 100, editable: false , align:"center"},
		               { label: '금년평균가격(원)', name: 'avgAmt', width: 100, editable: false, align:"center" , sorttype: 'float', formatter:'integer',formatoptions: { defaultValue: '-', thousandsSeparator: ',' }},
		               { label: '예측가격(원)', name: 'prePrice', width: 100, editable: false, align:"center", sorttype: 'float', formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' } },
		               { label: '오차율(%)', name: 'per', width: 100, editable: false, align:"center", sorttype: 'float', formatter:'integer',formatoptions: { defaultValue: '-', thousandsSeparator: ',' } }
		           ] ,
		           loadonce: true,
		   		   rownumbers : true,
		           autowidth:true,
		           height: '330',
		           rowNum: 8,
		 		   sortable: true,
		 		   emptyrecords : '데이터가 없습니다.',
		           pager: "#jqGridPager",
		      	   loadComplete	: function(data) {
		      		 	var ids = $("#jqGrid").getDataIDs();
			     	 	$.each(
			     	 		ids,function(idx,rowId)
			     	 		{
			     	 			rowData=$("#jqGrid").getRowData(rowId);
			     	 			
			     	 			if(rowData.per==''){
			     	 				
			     	 			}else if(rowData.per<=10){
		     	 					$("#jqGrid").setRowData(rowId, false, {background: '#fcfeb8'});
		     	 				}else if(rowData.per<=20){
		     	 					$("#jqGrid").setRowData(rowId, false, {background: '#fbebb4'});
		     	 				}else if(rowData.per<=30){
		     	 					$("#jqGrid").setRowData(rowId, false, {background: '#fedbb5'});
		     	 				}else if(rowData.per>=30){
		     	 					$("#jqGrid").setRowData(rowId, false, {background: '#f7c1ae'});
		     	 				}
		     	 				
			     	 		}
			     	 	);
		      	   
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
		  		)
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
				<li>생산/소비정보</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li>장미가격 예측정보</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li class="m_right">장미가격 예측평가</li>
			</ul>
		</div>
		<!--공통 HEADER(E)-->
		
		<!--서브 타이틀(S)-->
		<jsp:include page="../inc/2020/IncShare.jsp"/>
		
		<div class="sub_title">
			<div class="title_box">
				<h2>장미가격 예측평가</h2>
				<img src="../images/2020/sub/t_line.png" alt="방울점선">
			</div>
		</div>
		<!--서브 타이틀(E)-->
		
		<jsp:include page="../inc/2020/topPreMenu.jsp"/>
		
		<!--컨텐츠 내용(S)-->
		<div class="sub_guide">
			<div class="rose_box_b">
				<div class="rose_graph_b">
					<div id="chartHolder" style="width: 100%; height: 344px;"></div>
				</div>
				<div class="rose_list_b">
					<div style="width:100%; height:100%">
						<table id="jqGrid" style="width:100%; height:100%" class="boxList"></table>
						<div id="jqGridPager"></div>
					</div>
				</div>
			</div>
			<div class="guide">
				<h2 class="title_02">이용안내</h2>
				<ul class="guide_box">
					<li>· 예측가격과 실제거래가격의 오차를 보여줍니다. </li>
				</ul>
			</div>
		</div>
		<!--컨텐츠 내용(E)-->
		
		<jsp:include page="../inc/2020/IncFooter.jsp"/>
		
	</div>
	<!--WRAP(E)-->

</body>
</html>