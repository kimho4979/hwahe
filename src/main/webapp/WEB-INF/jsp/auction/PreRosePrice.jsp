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
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, user-scalable=no">
	<meta name="apple-mobile-web-app-title" content="화훼유통정보시스템">
	<meta name="robots" content="no-index,follow">
	<meta name="og:title" content="화훼유통정보시스템">
	<meta name="og:description" content="화훼유통정보시스템">
	<meta name="description" content="장미가격 예측정보">
	<meta name="content" content="화훼유통정보시스템 입니다.">
	<meta name="keywords" content="화훼경매시세, 화훼경매가격, Korea aT flower market auction price, 화훼공판장, 화훼거래정보, 꽃시장, 꽃값">
	<meta name="Author" content="화훼유통정보시스템 & www.woorim.co.kr : Kim Juyeon">
	<title>장미가격 예측정보</title>
	<%@include file="../common/2020/commonJs.jsp" %>
	<%@include file="../common/2020/commonCss.jsp" %>
  
	<script type="text/javascript">
		$(window).on('resize.jqGrid', function () {
		    $("#jqGrid").jqGrid( 'setGridWidth', $(".rosepay01_list_b > div").width());
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
				+'<Legend defaultMouseOverAction="false" useVisibleCheck="true"/>'
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
				+'<Line2DSeries  yField="avgAmt"  radius="3" displayName="전년평균가격"  itemRenderer="CircleItemRenderer">'
					+'<fill>'
		          		+'<SolidColor color="#f9bb17" alpha="1"/>'
					+'</fill>'	
					+'<lineStroke>'
						+'<Stroke color="#f9bb17" weight="2"/>'
					+'</lineStroke>'
	                +'<stroke>'
	                    +'<Stroke color="#f9bb17" weight="2"/>'
	                +'</stroke>'
	                +'<showDataEffect>'
		                +'<SeriesInterpolate/>'
		            +'</showDataEffect>'
	    		+'</Line2DSeries>'
				+'<Line2DSeries labelPosition="up" showMinValueLabel="true" showMaxValueLabel="true"  yField="realPrice" radius="3" itemRenderer="CircleItemRenderer" displayName="금년평균가격" verticalAxis="{vAxis1}">'
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
				 +'<Line2DSeries labelPosition="up" radius="3" yField="prePrice" showMinValueLabel="true" showMaxValueLabel="true"  lineStyle="dashLine" dashLinePattern="3" itemRenderer="CircleItemRenderer" displayName="예측가격" verticalAxis="{vAxis1}">'
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
	            +'<Axis2DRenderer axis="{vAxis1}"  showLine="false"/>'
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
			$("#baseDateLi").hide();	
			
			$("#pumCd").change(function() {
				getLvList();
			});
			
			$("#excelBtn1").empty();
		});
		
		// Excel DownLoad
		function excelExport(){
			var excelNm = "장미가격예측정보";
			var param = "?excelNm="+excelNm+"&sidoCd="+sidoCd;
			//location.href = "/excel/excelDownLoad.do"+param;
		}
		
		// 마지막 일자, 품종 List
		function getSaledate(cmpCd){
			$.ajax({
				type : "post",
				url : "/preRose/selectPreRosePumList.json",
				data : {
					searchCmpCd : cmpCd
				},
				dataType : '',
				success : function(res){
					var val = res.list;
					
					if(val!=null&&val.length>0){
						$("#pumCd").empty();
						$("#baseDate").val(val[0].baseDate);
						$("#baseDateTxt").html('기준일 : ' + val[0].baseDate);
						
						
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
		
		// 장미가격예측정보 List
		function list(){
			var baseDate=$("#baseDate").val();
			var cmpCd = $("#cmpCdTab .on > input").attr("value");
			var pumCd = $("#pumCd option:selected").val();
			var lvCd = $("#lvCd option:selected").val();
			
			
			$.ajax({
				type : "post",
				url : "/preRose/selectPreRoseList.json",
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
						  
						var html1='';
						var dayCnt='';
						var weekCnt='';
						var nextCnt=0; 
						var preData0=0;
						var preData1=0;
						var preData2=0;
						var preData3=0;
						  
						var dataT=data.list;
						for(var i=0; i<dataT.length;i++){
							if(dataT[i].preIdx==1){
								dayCnt = dataT[i].dayCnt;
								weekCnt = parseInt(dataT[i].weekCnt)+4;
								if(weekCnt>52){
									weekCnt=1;
								}
								if(weekCnt<10){
									weekCnt='0'+weekCnt;
								}
								  
								 
								html1+='<li class="rosepay01_b"><p>다음경매<br/><strong>'+dataT[i].repComp+' ('+dataT[i].dayYoil+')</strong><br/>예측가격</p></li>';
								
								// 비교
								preData0=dataT[i-1].prePrice;
								preData1=dataT[i].prePrice;
								  								  
								if(preData0<preData1){
									html1+='<li class="rosepay02_b"><p class="rose_red">'+comma(dataT[i].prePrice)+' 원</p></li>';
									html1+='<li class="rosepay03_b"><p>이전대비<span class="rose_red">'+comma(preData1-preData0)+'▲</span></p><p>등락률<span class="rose_red">'+((preData1-preData0)/preData0*100).toFixed(1)+'%</span></p></li>';
								}else if(preData0==preData1){
									html1+='<li class="rosepay02_b"><p class="">'+comma(dataT[i].prePrice)+' 원</p></li>';
									html1+='<li class="rosepay03_b"><p>이전대비<span>'+comma(preData1-preData0)+'</span></p><p>등락률<span class="">'+((preData1-preData0)/preData0*100).toFixed(1)+'%</span></p></li>';
								}else {
									html1+='<li class="rosepay02_b"><p class="rose_blue">'+comma(dataT[i].prePrice)+' 원</p></li>';
									html1+='<li class="rosepay03_b"><p>이전대비<span class="rose_blue">'+comma((preData1-preData0)*(-1))+'▼</span></p><p>등락률<span class="rose_blue">'+((preData1-preData0)/preData0*(-1)*100).toFixed(1)+'%</span></p></li>';
								}
								
								$('#ulTable01').html(html1);
							}
							  
							html1='';
							if(dataT[i].preIdx>1&&nextCnt==0&&dayCnt==dataT[i].dayCnt){
								  
								html1+='<li class="rosepay01_b"><p>차주경매<br/><strong>'+dataT[i].repComp+' ('+dataT[i].dayYoil+')</strong><br/>예측가격</p></li>';
								  
								preData2=dataT[i].prePrice;
																
								if(preData1<preData2){
									html1+='<li class="rosepay02_b"><p class="rose_red">'+comma(dataT[i].prePrice)+' 원</p></li>';
									html1+='<li class="rosepay03_b"><p>이전대비<span class="rose_red">'+comma(preData2-preData0)+'▲</span></p><p>등락률<span class="rose_red">'+((preData2-preData1)/preData1*100).toFixed(1)+'%</span></p></li>';
								}else if(preData1==preData2){
									html1+='<li class="rosepay02_b"><p class="">'+comma(dataT[i].prePrice)+' 원</p></li>';
									html1+='<li class="rosepay03_b"><p>이전대비<span>'+comma(preData2-preData1)+'</span></p><p>등락률<span class="">'+((preData2-preData1)/preData1*100).toFixed(1)+'%</span></p></li>';
								}else {
									html1+='<li class="rosepay02_b"><p class="rose_blue">'+comma(dataT[i].prePrice)+' 원</p></li>';
									html1+='<li class="rosepay03_b"><p>이전대비<span class="rose_blue">'+comma((preData2-preData1)*(-1))+'▼</span></p><p>등락률<span class="rose_blue">'+((preData2-preData1)/preData1*(-1)*100).toFixed(1)+'%</span></p></li>';
								}
																 
								$('#ulTable02').html(html1);
								  
								nextCnt=1;
							}
							  
							html1='';
							if(nextCnt==1&&dayCnt==dataT[i].dayCnt&&weekCnt==dataT[i].weekCnt){
								  
								html1+='<li class="rosepay01_b"><p>한달후경매<br/><strong>'+dataT[i].repComp+' ('+dataT[i].dayYoil+')</strong><br/>예측가격</p></li>';
								  
								preData3=dataT[i].prePrice;
								  
								if(preData2<preData3){
									html1+='<li class="rosepay02_b"><p class="rose_red">'+comma(dataT[i].prePrice)+' 원</p></li>';
									html1+='<li class="rosepay03_b"><p>이전대비<span class="rose_red">'+comma(preData3-preData2)+'▲</span></p><p>등락률<span class="rose_red">'+((preData3-preData2)/preData2*100).toFixed(1)+'%</span></p></li>';
								}else if(preData2==preData3){
									html1+='<li class="rosepay02_b"><p class="">'+comma(dataT[i].prePrice)+' 원</p></li>';
									html1+='<li class="rosepay03_b"><p>이전대비<span class="">'+comma(preData3-preData2)+'▲</span></p><p>등락률<span class="">'+((preData3-preData2)/preData2*100).toFixed(1)+'%</span></p></li>';
								}else {
									html1+='<li class="rosepay02_b"><p class="rose_blue">'+comma(dataT[i].prePrice)+' 원</p></li>';
									html1+='<li class="rosepay03_b"><p>이전대비<span class="rose_blue">'+comma((preData3-preData2)*(-1))+'▼</span></p><p>등락률<span class="rose_blue">'+((preData3-preData2)/preData2*(-1)*100).toFixed(1)+'%</span></p></li>';
								}
								  
								$('#ulTable03').html(html1);
								  
								nextCnt=2;
							}
						}
					}else{
						chartData =[];
						rMateChartLoding("chart1", "chartReadyHandler");
						
						var html1='';					
						html1+='<li class="ulthead" id="weather01txt">다음경매(-) 예측가격</li>';
						html1+='<li class="tbody td2" id="weather01">';
						html1+='<span class="rosePrice_txt">';
						html1+='<span class="main">0 원</span>';
						html1+='<span class="subTxt"> 0 </span>';
						html1+='<span class="subTxt2"> 0 % </span>';
						html1+='</span>';
						html1+='</li>';
						$('#ulTable01').html(html1);
						
						html1='';
						html1+='<li class="ulthead" id="weather01txt">차주경매(-) 예측가격</li>';
						html1+='<li class="tbody td2" id="weather01">';
						html1+='<span class="rosePrice_txt">';
						html1+='<span class="main">0 원</span>';
						html1+='<span class="subTxt"> 0 </span>';
						html1+='<span class="subTxt2"> 0 % </span>';
						html1+='</span>';
						html1+='</li>';
						$('#ulTable02').html(html1);
						
						html1='';
						html1+='<li class="ulthead" id="weather01txt">한달후경매(-) 예측가격</li>';
						html1+='<li class="tbody td2" id="weather01">';
						html1+='<span class="rosePrice_txt">';
						html1+='<span class="main">0 원</span>';
						html1+='<span class="subTxt"> 0 </span>';
						html1+='<span class="subTxt2"> 0 % </span>';
						html1+='</span>';
						html1+='</li>';
						$('#ulTable03').html(html1);
					}
				}
			});
		}
		
		// 장미가격예측정보 List
		function gridList(){
			var baseDate=$("#baseDate").val();
			var cmpCd = $("#cmpCdTab .on > input").attr("value");
			var pumCd = $("#pumCd option:selected").val();
			var lvCd = $("#lvCd option:selected").val();
			
			$("#jqGrid").jqGrid({
		   		url : "/preRose/selectPreRoseGridList.json",
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
		               { label: '전년최고가격(원)', name: 'maxAmt', width: 100, editable: false, align:"center", sorttype: 'float', formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' } },
		               { label: '전년최저가격(원)', name: 'minAmt', width: 100, editable: false, align:"center", align:"center", sorttype: 'float', formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' }},
		               { label: '전년평균가격(원)', name: 'avgAmt', width: 100, editable: false, align:"center", sorttype: 'float', formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' }},
		               { label: '예측가격(원)', name: 'prePrice', width: 100, editable: false, align:"center", sorttype: 'float', formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' } }
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
		
		function comma(x) {
			return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
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
				<li class="m_right">장미가격 예측정보</li>
			</ul>
		</div>
		<!--공통 HEADER(E)-->
		
		<!--서브 타이틀(S)-->
		<jsp:include page="../inc/2020/IncShare.jsp"/>
		
		<div class="sub_title">
			<div class="title_box">
				<h2>장미가격 예측정보</h2>
				<img src="../images/2020/sub/t_line.png" alt="방울점선">
			</div>
		</div>
		<!--서브 타이틀(E)-->
		
		<jsp:include page="../inc/2020/topPreMenu.jsp"/>
		
		<!--컨텐츠 내용(S)-->
		<div class="sub_guide">
			<div class="rosepays_box_b">
				<ul class="rosepay_list_b">
					<!--오늘-->
					<li>
						<ul class="rosepay_box_b" id="ulTable01">
						</ul>
					</li>
					<!--내일-->
					<li>
						<ul class="rosepay_box_b" id="ulTable02">
						</ul>
					</li>
					<!--모레-->
					<li>
						<ul class="rosepay_box_b" id="ulTable03">
						</ul>
					</li>
				</ul>
			</div>
			<!--그래프-->
			<div class="rosepay_graph_box_b">
				<div class="rosepay_graph_b" style="height: 344px;">
					<div id="chartHolder" style="width: 100%; height: 100%;"></div>
				</div>
				<div class="rosepay01_list_b">
					<div style="width:100%; height:100%">
					    <table id="jqGrid" style="width:100%; height:100%" class="boxList"></table>
			    		<div id="jqGridPager"></div>
					</div>
				</div>
			</div>
			<div class="guide">
				<h2 class="title_02">이용안내</h2>
				<ul class="guide_box">
					<li>· 공판장별 거래량이 많은 품종과 등급을 대상으로 4개년 거래데이터를 인공지능 기법으로 학습하여 예측가격을 도출합니다</li>
					<li>· 각 공판장마다 다량거래품종과 등급기준이 달라 공판장별로 예측 대상이 상이합니다</li>
					<li>· 예측실시시간 : aT화훼공판장(양재동) - 월/수/금 13시, 그 외 공판장 - 화/목/토 6시</li>
				</ul>
			</div>
		</div>
		<!--컨텐츠 내용(E)-->
		
		<jsp:include page="../inc/2020/IncFooter.jsp"/>
		
	</div>
	<!--WRAP(E)-->
</body>
</html>