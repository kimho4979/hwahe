<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


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
	<meta name="description" content="실시간 경매정보">
	<meta name="content" content="화훼유통정보시스템 입니다.">
	<meta name="keywords" content="화훼경매시세, 화훼경매가격, Korea aT flower market auction price, 화훼공판장, 화훼거래정보, 꽃시장, 꽃값">
	<meta name="Author" content="화훼유통정보시스템 & www.woorim.co.kr">
	<title>화훼 재배현황</title>
	<%@include file="../common/2020/commonJs.jsp" %>
	<%@include file="../common/2020/commonCss.jsp" %>
	<style>
 		#progress_loading {display:block; position:absolute; top:50%; left:50%; transform:translateX(-50%) translateY(-50%); background: #ffffff; text-align: center; z-index:999999;}
		@media screen and (min-width: 800px){
		.ui-jqgrid .ui-jqgrid-htable{width:auto!important;}
		}
	</style>

	<script type="text/javascript">

		//rMate 차트 생성 준비가 완료된 상태 시 호출할 함수를 지정합니다.
		var mapVars = "rMateOnLoadCallFunction=mapReadyHandler";
		var mapApp = null;
		var mapRoot = null;
		
		function mapReadyHandler(id) {
			document.getElementById(id).setLayout(layoutStr);
			document.getElementById(id).setData(mapData);
			document.getElementById(id).setMapDataBaseURLEx(mapDataBaseURL);
			document.getElementById(id).setSourceURLEx(sourceURL);
		}
		var mapData = null;
		
		//Map Data 경로 정의
		//var mapDataBaseURL = "/rMateMapChart/Samples/MapDataBaseXml/SouthKoreaDrillDownSeoulDong_scale.xml";
		var mapDataBaseURL = "/rMateMapChart/xml/MapDataBaseXml/SouthKoreaDrillDownSeoulDong_scale.xml";
		//MapChart Source 선택
		var sourceURL = "/rMateMapChart/Samples/MapSource/SouthKoreaDrillDownSeoulDong.svg";

		var layoutStr = '<?xml version="1.0" encoding="utf-8"?>'
			  +'<rMateMapChart>'
			    +'  <MapChart id="mainMap" drillDownEnabled="false" showDataTips="true" scaleMode="auto" dataTipType="Type4" divDataTipJsFunction="DataTipFunction">'
			 +'      <series>'
			 +'          <MapSeries id="mapseries" selectionMarking="line" color="#777777" labelPosition="inside" displayName="Map Series">'
			   +'              <stroke>'
			 +'                  <Stroke color="#CAD7E0" weight="0.8" alpha="1"/>'
			 +'              </stroke>'
			    +'          </MapSeries>'
			 +'      </series>'
			    +'  </MapChart>'
			  +'</rMateMapChart>';

// 		//차트 데이터
		var mapInitData = [];
		
		var codes = {
				"100":true
			  , "200":true
			  , "300":true
			  , "400":true
			  , "500":true
			  , "600":true
			  , "700":true
			  , "800":true
			  , "90000":true
			  , "1000":true
			  , "1100":true
			  , "1200":true
			  , "1300":true
			  , "1400":true
			  , "1500":true
			  , "1600":true
			  , "1700":true
			};
			
		function rollOverFillFunction(code, label, data) {
			if ( codes[code]){
			 return "#2e7dca";
			} else if ( code > 90000 ) {
			if ( code%100 == 0  )
			      return "#2e7dca";
			  else
			       return "#f6b149";
			} else
			 return "#a08e78";
		}
		
		function colorFunction(code, label, data) {
			
			if ( codes[code]){
			 return "#62bfea";
			} else if ( code > 90000 ) {
			if ( code%100 == 0 )
			       return "#62bfea";
			  else
			       return "#ccbca5";
			} else
			 return "#62bfea";
		}
		
		function strokeFunction(code, label, data) {
			if ( codes[code]){
			 return "#BBE1EA";
			} else if ( code > 90000 ) {
			if ( code%100 == 0 )
			       return "#BBE1EA";
			  else
			       return "#e2d5c5";
			} else
			 return "#BBE1EA";
		}
		
		var mapInitData = [];
		
		function labelFunction(seriesId, code, label, data) {
			
			var text = {"text":label, "color":"#000000", "fontSize":"11", "fontWeight":"bold", "lineHeight":5};
			return text;
		}
		
// 		function divDataTipFunction(seriesId, code, label, data) {
			
// 			if(data.totQty != null){
// // 				var html = "<div><div>"+label+"</div>";
// // 					html += "<div>전업농가 : "+data.val1.toLocaleString('ko-KR')+"</div>";
// // 					html += "<div>겸업농가 : "+data.val2.toLocaleString('ko-KR')+"</div>";
// // 					html += "<div>합계: "+data.totQty.toLocaleString('ko-KR')+"</div></div>";
// // 				return html;
// 				var html = "<table margin=0 padding=0 width=196 height=150 style='text-align:left;color:#888888;letter-spacing:-1px;'>"
// 					html += "<tr><td>전업농가 : "+data.val1.toLocaleString('ko-KR')+"</tr></td>";
// 					html += "<tr><td>겸업농가 : "+data.val2.toLocaleString('ko-KR')+"</tr></td>";
// 					html += "<tr><td>합계: "+data.totQty.toLocaleString('ko-KR')+"</tr></td></table>";
// 				return html;

// 			}else{
// 				return "데이터가 없습니다.";
// 			}
		  
// 		}
		
		function dataTipFunction(seriesId, code, label, data) {
			return label + ''  + '<br>' + '전업농가 : ' + data.val1.toLocaleString('ko-KR')+ '<br>' + '겸업농가: ' + data.val2.toLocaleString('ko-KR')+ '<br>' + '합계 : ' + data.totQty.toLocaleString('ko-KR'); 
		}
		function clickFunction(code, label, data) {
			$("#jqGrid").jqGrid("clearGridData", true);
			console.log("code, label, data", code, label, data)
			fnObj.chart_sumary3(data.yyyy, data.location);
		}
		
		
		$(document).ready(function(){

			var now = new Date();
			now.setMonth(now.getMonth());
			$("#searchEndDateY").val(now.getFullYear().toString());
			$('#searchEndDateY').val('2022')
			fnObj.setPage();
		});
		
		$(document).ready(function(){
			$('#progress_loading').hide();

			//달력 연별설정
			$("#searchEndDateY").bindDate({align:"right", valign:"bottom", separator:"-", selectType:"y",  defaultSelectType:"y", value:"",
				onchange:function(){
					cmpCd= [];
					flowerCd = [];
					var searchEndDate = $("#searchEndDateY").val();
					var searchStrDate = (Number(searchEndDate)-3).toString();
					$("#searchStrDateY").val(searchStrDate);
					$('input:checkbox[name="flowerGubn"]:checked').each(function(){
		       			flowerCd.push($(this).val());
		       		})
					
					console.log("searchStrDate", searchStrDate);
					console.log("searchEndDate", searchEndDate);
				}

			});
			function calendarShow(id){
				var pickId = "#inputBasic_AX_"+id+"_AX_dateHandle";
				$(pickId).click();
				$('#'+id).attr("readonly",true);
				setTimeout(function(){$('#'+id).attr("readonly",false);}, 50);
			}
			
			$('.content').click(function(){});
			$("#excelBtn1").empty();
			$("#excelBtn1").append('<a href="javascript:void(0);" id="exportBtn1" name="exportTable1" onclick="excelExport();"><img src="../images/2020/exel.png" alt="엑셀이미지">엑셀저장</a>');

		});
		
		var selectedLocation = '';
		function search(){
        	var searchEndDate = $("#searchEndDateY").val().toString();
        	var location = '';
        	fnObj.search(searchEndDate, location);
		}
		function excelExport(){
			url = "/excel/selectHga08ChartJson2.json";
			var searchEndDate = $("#searchEndDateY").val().toString();
			
     		let param = "?excelNm="+"화훼재배현황"+"&searchEndDate="+searchEndDate+"&location="+selectedLocation;
     		console.log("encoding", encodeURI(url+param));
     		location.href = encodeURI(url+param);
		}
		
		function labelFunc(seriesID, index, data, values)
		{
		  return data.TOT_QTY + "\n" + values[1];
		}
		function axisDataTipFunc(id, text){
		    return "Month : " + text;
		}

		
		var fnObj = {
			param : {
				strDate: '',
		    	endDate: '',
			},
	        setPage : function(){
		            fnObj.chart_sumary();
		            fnObj.create_grid();
		    },
	        search : function(yyyy, location){
		            fnObj.chart_sumary();
		            fnObj.chart_sumary3(yyyy, location);
		    },
    	    chart_sumary: function(){
	     		url = "/hga08/selectHga08ChartJson1.json";
				var searchEndDate = $("#searchEndDateY").val().toString();
				selectedLocation = '';
    	    	$.ajax({
    				type : "post",
    				url : url,
    				data : {
	        			searchEndDate: searchEndDate,
    				},
    				dataType : '',
    				success : function(res){
    					var val = res.list;
    					console.log('val', val);
    					
    					var max = 0;
    			    	var mapInteval = 10;
    			    	mapData = val;
    			    	var lastMapData = mapData.pop();
    			    	mapInitData = mapData;
    			    	
    			    	mapData = mapInitData;
    		    		for(var i=0; i<mapData.length; i++){
    		    			if(max < mapData[i].totQty){
    			    			max = mapData[i].totQty;
    			    		}
    			    	}
    		    		
    		    		mapInteval = (max/5).toFixed(0);
    			    	if(mapInteval < 1){
    			    		mapInteval = 1;
    			    	}
    			    	

    			    	layoutStr = '<rMateMapChart>'
						  + '<MapChart id="mainMap1" showDataTips="true" drillDownEnabled="false" dataTipType="Type4" mapChangeJsFunction="clickFunction" dataTipJsFunction="dataTipFunction">'
						  + '	<series>'
						  + '	    <MapSeries id="mapseries" labelJsFunction="labelFunction" interactive="true" selectionMarking="line" color="#000000" labelPosition="inside" displayName="Map" rollOverFillJsFunction="rollOverFillFunction" localFillByRange="[#dcdfe8,#93D6F1,#4a88b7,#596283,#5b5e67]" rangeLegendDataField="totQty" localFillJsFunction="colorFunction" >'
						  + '	    	<stroke>'
						  + '	        	<Stroke color="#8C8C8C" weight="0.8" alpha="1"/>'
						  + '	        </stroke>'
						  + '		</MapSeries>'
						  + '	</series>'
						  + '</MapChart>'
						  + '</rMateMapChart>';
    				
    			    	rMateMapChartH5.create("map1", "mapHolder", mapVars, "100%", "100%");
    				}
    			});
    	    	
    	    },
    	    create_grid: function(){
    	    	
	        	var url = "/hga08/selectHga08ChartJson2.json";
	        	var searchEndDate = $("#searchEndDateY").val().toString();
        		let postParam = {
        			searchEndDate: searchEndDate
        		};
				$("#jqGrid").jqGrid({
	        		url : url,
	           		mtype: 'POST',
	           		postData: postParam,
	                datatype: "json",
	                jsonReader: {
	        	   		root : "list",  // list 이름
	        	   		page : "page",
	        	   		total : "total",
	        	   		records : "records",
	        			repeatitems : false
	        		},
	        		colModel: [
	                    //{ label: '연도', name: 'yyyy',width: 70, editable: false , align:"center", sorttype:'string'},
	                    { label: '지역', name: 'location', width: 135, editable: false, align:"center", sorttype:'text', sorttype:'text' },
	                    { label: '전업', name: 'val1', width: 135, editable: false, align:"center", formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' },  sorttype:'int'},
	                    { label: '　　겸업', name: 'val2', width: 135, editable: false, align:"center", formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' },sorttype:'int'},
	                    { label: '　　합계', name: 'totQty', width: 130, align:"center", editable: false, formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' }  },
	                ] ,
	                loadonce: true,
	                height: '340',
	                sortable: true,
	        		emptyrecords : '데이터가 없습니다.',
	        		width:$(".cont_box_b > div").width(),
		   		   	rownumbers : false,
		   		 	rownumWidth : '50',
		   		 	shrinkToFit : false,
		   		 	forceFit:false,
		   		 	autowidth:false,
	                loadComplete	: function(data) {
	                	console.log("test");
	                	console.log("grid data", data);
	                	$("#jqGrid").jqGrid("setSelection", 1);

	             	},
	             	onSelectRow: function(rowid, status, e) {
	             		var rowData = $(this).getLocalRow(rowid);
	             		var searchEndDate = "";
	             	}
	            });

    	    },
    	    chart_sumary3: function(yyyy, location){
    	    	$("#jqGrid").clearGridData();
	        	//var auctionType = $(":input:radio[name=rr99]:checked").val();
	        	var url = "/hga08/selectHga08ChartJson2.json";
	        	var location = location;
	        	var searchEndDate = yyyy;
	        	selectedLocation = location;
	        	
        		var postParam = {
        			searchEndDate: searchEndDate,
        			locaiton: location
        		};
            	var searchEndDate = $("#searchEndDateY").val().toString();

    			$("#jqGrid").setGridParam({
    				url         : "/hga08/selectHga08ChartJson2.json",
    				mtype       : "post",
    				datatype	: "json",
    	   	 		postData    : postParam,
    				page : 1,
    				loadComplete	: function(data) {
    					$("#jqGrid")[0].addJSONData(data.list)
    					//if(typeof evt == 'object')  changeLayout(evt,data.list) 
    					console.log("data", data);
    	          	},
    			}).trigger("reloadGrid");
    	    },
		};



	</script>
</head>

<body>

	<input type="hidden" id="lvCd" name="lvCd" value="92"/>
	<!--WRAP(S)-->
	<div class="wrap">

		<jsp:include page="../inc/2020/IncHeader.jsp"/>

		<!--서브 헤더 (S)-->
		<div class="lnb_box">
			<ul>
				<li><img src="../images/2020/m_lnb_img.png" alt="집"></li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li>경매정보</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li>타 기관 정보</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li class="m_right">화훼 재배현황</li>
			</ul>
		</div>
		<!--sub 헤더 (E)-->
		<!--서브 타이틀(S)-->

		<jsp:include page="../inc/2020/IncShare.jsp"/>
		
				<div class="sub_title">
			<div class="title_box">
				<h2 class="sub_tit">화훼 재배현황</h2>
				<img src="../images/2020/sub/t_line.png" alt="방울점선">
			</div>
		</div>
<!--서브 타이틀(E)-->
		<!--서브공통 (S)-->
		<div class="sub_contents">
		<div class="sub_info_box">
					<div class="tit_box_01">
						<div class="fr">
							<div class="dwn_bt_b btn_h_45" >
								<a class="reset_btn" href="javascript:fnObj.resetParam();"><img src="../images/main/btn_refresh_w.png" alt="초기화"> 초기화</a>
							</div>
							<div class="dwn_bt_b btn_h_45" >
								<a class="search_btn_n" href="javascript:search();"><img src="../images/2020/sub/search_img.png" alt="돋보기"> 검색</a>
							</div>

						</div>
					</div>
				</div>

			<div class="search_box_new statistic">			
				<input type="hidden" id="searchStrDate" value="${searchStrDate}">
				<input type="hidden" id="searchEndDate" value="${searchEndDate}">				
				<div class="s-line" style="display: none" >
					<h4 class="sbn_tit_01">구분</h4>
					<ul class="grow_check_box width_a">
						<li>
							<input type="radio" id="rr66" name="rr99" value="sCmp" checked>
							<label for="rr66" class="title_box_chk"><em class="txt">개별</em><span></span></label>
						</li>
						<li>
							<input type="radio" id="rr77" name="rr99" value="tCmp">
							<label for="rr77" class="title_box_chk"><em class="txt">통합</em><span></span></label>
						</li>
					</ul>
					

				</div>

				<div class="s-line">
					<h4 class="sbn_tit_01">기준년도</h4>
					<div class="sb_common_01 pack-01" style="    padding-top: 5px !important;">
						<div class="date-from-to" id="searchDateD" >
							<ul class="grow_check_box" style="display: none"  >
								<li>
									<input type="radio" id="rr33" name="rr1" value="day">
									<label for="rr33" class="title_box_chk"><em class="txt">당일</em><span></span></label>
								</li>
								<li>
									<input type="radio" id="rr44" name="rr1" value="week" checked>
									<label for="rr44" class="title_box_chk"><em class="txt">1주일</em><span></span></label>
								</li>
								<li>
									<input type="radio" id="rr55" name="rr1" value="month">
									<label for="rr55" class="title_box_chk"><em class="txt">1개월</em><span></span></label>
								</li>
								<li>
									<input type="radio" id="rr88" name="rr1" value="month">
									<label for="rr88" class="title_box_chk"><em class="txt">기간</em><span></span></label>
								</li>
							</ul>

							<div class="date-from-to" id="searchDateY">
								<div class="calendar_new" style="display: none">
									<input type="text" alt="켈린더" class="calendar_focus" id="searchStrDateY" value="${searchStrDateY}" onClick="calendarShow(this.id);"/>
								</div>
								<div class="calendar_new">
									<input type="text" alt="켈린더" class="calendar_focus" id="searchEndDateY" value="${searchEndDateY}" onClick="calendarShow(this.id);"/>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="s-line" style="display: none" >
					<h4 class="sbn_tit_01">조회단위</h4>
					<ul class="grow_check_box">
						<li>
							<input type="radio" id="rr00" name="rr" value="day" checked>
							<label for="rr00" class="title_box_chk"><em class="txt">일</em><span></span></label>
						</li>
						<li>
							<input type="radio" id="rr11" name="rr" value="month">
							<label for="rr11" class="title_box_chk"><em class="txt">월</em><span></span></label>
						</li>
						<li>
							<input type="radio" id="rr22" name="rr" value="year">
							<label for="rr22" class="title_box_chk"><em class="txt">연</em><span></span></label>
						</li>
					</ul>
				</div>


				<!-- 로딩바(S) -->
				<div id="progress_loading">
					<img src="../../images/loadingBar.gif"/>
				</div>
				<!-- 로딩바(E) -->

			</div>

		</div>
		<!--컨텐츠 내용(S)-->

		<!--컨텐츠 내용(S)-->
		<div class="sub_guide">
			<!-- 테이블(E) -->
			<div class="data_content_b">
				<div class="tit_box_01">
					<div class="fr">
						<div class="dwn_bt_b" id="excelBtn1" style="margin-right:15px; margin-bottom: 8px;"><a href="#!"><img src="../images/2020/exel.png" alt="엑셀이미지">엑셀저장</a></div><br/>
					</div>
				</div>
				
				<div class="cont_left_b"style="overflow:hidden;">
					<div class="cont_box_b" style="overflow:hidden;">
						<div class="sub_info_box">
							<div id="mapHolder" style="width:100%; min-width:313px; height:399px;"></div>
						</div>
					</div>
				</div>
				<div class="cont_right_b" style="width: 50%;">
					<div class="cont_box_b" style="overflow:hidden;">
						<div class="sub_info_box" style="overflow:hidden;">
						    <table id="jqGrid" class="boxList" ></table>
					    </div>
				    </div>    
				</div>
			</div>
		</div>

		<div class="guide">
			<h2 class="title_02">이용안내</h2>
			<ul class="guide_box">
				<li>· 출처 : 통계청</li>
			</ul>
		</div>
		<jsp:include page="../inc/2020/IncFooter.jsp"/>
	</div>


<script>

</script>

	<!-- POPUP (E)-->
</body>