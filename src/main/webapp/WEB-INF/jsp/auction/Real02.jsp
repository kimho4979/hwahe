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
	<meta name="viewport" content="initial-scale=1.0,  minimum-scale=1.0, width=device-width">
	<meta name="apple-mobile-web-app-title" content="화훼유통정보시스템">
	<meta name="robots" content="no-index,follow">
	<meta name="og:title" content="화훼유통정보시스템">
	<meta name="og:description" content="화훼유통정보시스템">
	<meta name="description" content="실시간 경매정보">
	<meta name="content" content="화훼유통정보시스템 입니다.">
	<meta name="keywords" content="화훼경매시세, 화훼경매가격, Korea aT flower market auction price, 화훼공판장, 화훼거래정보, 꽃시장, 꽃값">
	<meta name="Author" content="화훼유통정보시스템 & www.woorim.co.kr">
	<title>실시간 경매실적</title>
	<%@include file="../common/2020/commonJs.jsp" %>
	<%@include file="../common/2020/commonCss.jsp" %>

	<script type="text/ecmascript" src="/plugin/jquery.jqGrid-4.4.3/js/jquery.jqGrid_new.js"></script>
	<link type="text/css" rel="stylesheet" href="/plugin/jquery.jqGrid-4.4.3/css/ui.jqgrid_new.css"  />
	
	<style>
	@media screen and (min-width: 800px){
		#nodata1{text-align:center;font-size:30px;line-height:20;}
		#nodata2{text-align:center;font-size:30px;line-height:20;}
		#norecs{display: none;}
	}
	@media screen and (max-width: 800px){
		#nodata1{text-align:left;font-size:30px;line-height:20;position:relative;left:150px;}
		#nodata2{text-align:left;font-size:30px;line-height:20;position:relative;left:150px;}
		#norecs{display: none;}
	}
	
	</style>

	<script type="text/javascript">
		var flowerCd = null;
		var cmpCd = null;
		var pumName = null;
		var goodName = null;
		var searchSaleDate = null;
		var gridData = null;
		var gridData1 = null;
		//초기 로딩시 animate 비활성화
		var initFlag=false;
		
		$(window).on('resize.jqGrid', function () {
		    $("#jqGrid").jqGrid( 'setGridWidth', $(".sub_info_box > div").width());
		    $("#jqGrid").jqGrid( 'setGridHeight','auto');
		    $(".ui-jqgrid-bdiv").width($(".ui-jqgrid-bdiv").width()+1);
		});
		
		$(document).ready(function(){
			$("#searchSaleDate").datepicker({
				showOn: "button",
			    buttonImage: "../images/2020/ico_date_02.png",
			    buttonImageOnly: true,
				todayHighlight: true,
				autoclose: true,
				showMonthAfterYear: true,
		        dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
		        monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
				language: 'kr',
				minDate: '-6d',
				maxDate: '+1d',
				dateFormat: 'yy-mm-dd',
				beforeShowDay:datechktoday,
				yearSuffix: '년',
				changeMonth: true,
				changeYear: true,
				onSelect: function(selectedDate){       		
		       		flowerCd = $("#flowerTab .on > input").attr("value");
					cmpCd = $("#cmpCdTab .on > input").attr("value");
					init();
					// 품목조회
					fnObj.setPage(cmpCd, flowerCd);
					getRealPumList(cmpCd, flowerCd, selectedDate);
		       		
				}
			});
			// 품종 selectbox display
			$("#goodSelectbox").css('display','');
			
			$("#itemCd").change(function() {
				getRealGoodList();
			});
			
			//getSaledate(cmpCd, flowerCd);
			// 초기1회로딩
			fnObj.setPage(cmpCd, flowerCd);
			
			$("#excelBtn1").empty();
			//$("#excelBtn1").append('<button class="excelSaveBtn" id="exportBtn1" name="exportTable1" onclick="excelExport();">엑셀저장</button>');
		
			// 키보드 입력
			$('#searchSaleDate').keyup(function(key, event){
				auto_date_format(key.keyCode, this)
		         
				if(key.keyCode == 13){//키가 13이면 실행 (엔터는 13)
					dateComp();		
		        }
			});
		});
		
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
				flowerCd = $("#flowerTab .on > input").attr("value");
				cmpCd = $("#cmpCdTab .on > input").attr("value");
				init();
				// 품목조회
				fnObj.setPage(cmpCd, flowerCd);
				getRealPumList(cmpCd, flowerCd, oriDt);
			}else{
				alert('일주일전 기간만 선택가능합니다');
				$("#searchSaleDate").val(begindate);
				
				flowerCd = $("#flowerTab .on > input").attr("value");
				cmpCd = $("#cmpCdTab .on > input").attr("value");
				init();
				// 품목조회
				fnObj.setPage(cmpCd, flowerCd);
				getRealPumList(cmpCd, flowerCd, begindate);
			}
			return returnVal;
		}
		
		function datechktoday(date){
			//var d = new Date();
			//if(date.getDate() > (d.getDate()+1))
				//return [false];
			    //return [true];
			    afterDate = new Date();
			    afterDate.setDate(afterDate.getDate()+1)
			    if(date > afterDate) return [false]; return [true];
		}
		
		function excelExport(){
			var excelNm = "실시간경매실적";
			searchSaleDate = $("#searchSaleDate").val();
			cmpCd = $("#searchCmpCd").val();
			flowerCd = $("#mobFlowerCd").val();
			var itemCd = $("#itemCd option:selected").val();
			var itemCd2 = $("#itemCd2 option:selected").val();
			var param = "?excelNm="+excelNm+"&searchSaleDate="+searchSaleDate+"&cmpCd="+cmpCd+"&flowerCd="+flowerCd+"&itemCd="+itemCd+"&itemCd2="+itemCd2;
			location.href = "/excel/excelDownLoad.do"+param;
		}
		
		function search(){
			var itemCd = $('#itemCd option:selected').val();
			var itemCd2 = $('#itemCd2 option:selected').val();
			var searchSaleDate = $("#searchSaleDate").val().replace(/-/gi, "");
		    var flowerCd = $("#flowerTab .on > input").attr("value");
			var cmpCd = $("#cmpCdTab .on > input").attr("value");
			var sido = $('#sido option:selected').val();
			
			// 검색 시 쿠키저장
			$.cookie("cookie.cmpCd", cmpCd, {expires: 7, path: '/' });
			$.cookie("cookie.flowerCd", flowerCd, { expires: 7, path: '/' });
			$.cookie("cookie.pumCd", itemCd,{ expires: 7, path: '/' });
			$.cookie("cookie.goodCd", itemCd2, { expires: 7, path: '/' });
			
		    $("#jqGrid").setGridParam({
		   		datatype	: "json",
		   		postData	: {
		   			cmpCd : cmpCd,
		   			flowerCd : flowerCd,
		   			itemCd : itemCd,
		   			itemCd2 : itemCd2,
		   			searchSaleDate : searchSaleDate,
		   			sido:sido
		   		},
				page : 1
		    }).trigger("reloadGrid");
		    
		    $(".ui-th-column.ui-th-ltr").attr('scope','col')
		    $('table#jqGrid.boxList.ui-jqgrid-btable.ui-common-table tbody tr td').attr('scope','row')
		    $('input.ui-pg-input.ui-corner-all').attr('aria-labelledby','input_jqGridPager')
		}
		
		//일자 호출 , 품목호출
		// 1번
		function getSaledate(cmpCd, flowerCd){
			
			$.ajax({
				type : "post",
				url : "/search/selectSaleDateReal.json",
				data : {
					searchProductGubun : flowerCd,
					searchCmpCd : cmpCd
				},
				dataType : '',
				success : function(res){
					var val = res.list;
					if(res.list!=null && res.list.length > 0){
						init();
						$('#searchSaleDate').val(val[0].SALE_DATE);
						// 초기화
						// fnObj.setPage(cmpCd, flowerCd);
						getRealPumList(cmpCd, flowerCd, val[0].SALE_DATE);
					}else{
						// 데이터 없음
						$('#searchSaleDate').val("");
						init();
						
						if(cmpCd !='6068207466' && cmpCd !='1288202296' && cmpCd !='6158209828'){
        		    		//$("#jqGrid").append("<tr><th colspan='8' align='center' id='nodata1' >금일 경매없음</th></tr>");	
        		    	}else{
        		    		//$("#jqGrid").append("<tr style='line-height: 20;'><th colspan='8' align='center'  id='nodata2'>해당 공판장은 실시간 경매실적를 제공하지 않습니다.</th></tr>");	
        		    	}
					}
				}
			});
		}
		
		function init(){	
			// 값 초기화
			getItemInit();
			
			// 그리드초기화
			$("#jqGrid").jqGrid("clearGridData", true);
		}
		
		var fnObj = {
		        setPage : function(cmpCd, flowerCd){
		        	var itemCd = $('#itemCd option:selected').val();
		        	var itemCd2 = $('#itemCd2 option:selected').val();
		        	var searchSaleDate = $("#searchSaleDate").val().replace(/-/gi, "");
		            var flowerCd = $("#flowerTab .on > input").attr("value");
		        	var cmpCd = $("#cmpCdTab .on > input").attr("value");
		        	var sido = $('#sido option:selected').val();

					// 과천 탭 안보이게 (실시간 경매만)
					$.each($('#cmpCdTab input'),function (i,v) {
						if(v.value == "1288202296"){
							$('#cmpCdTab a:eq('+i+')').parent().attr('style','display:none;')
						}
					})
		        	
		        	 $("#jqGrid").jqGrid({
		        		url : "/real/getRealData1.json",
		           		mtype: 'POST',
		           		postData: 
		         	   {
		           			cmpCd : cmpCd,
		        			flowerCd : flowerCd,
		        			searchSaleDate : searchSaleDate,
		        			itemCd:itemCd,
		        			itemCd2:itemCd2,
		        			sido:sido
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
		                    { label: '품목', name: 'PUMNAME',width: 140, editable: false , align:"center"},
		                    { label: '품종', name: 'GOODNAME', width: 140, editable: false, align:"center" },
		                    { label: '등급', name: 'LVNAME', width: 80, editable: false, align:"center" },
		                    { label: '단(속)', name: 'QTY', width: 100, editable: false, align:"center", sorttype: 'float',  formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' }  },
		                    { label: '낙찰금액', name: 'COST', width: 120, editable: false, align:"center", sorttype: 'float', formatter:'integer',formatoptions: { defaultValue: '', thousandsSeparator: ',' } },
		                    { label: '낙찰시간', name: 'NAKTIME', width: 120, align:"center", editable: false },
		                    { label: '지역', name: 'SANNAME', width: 80, align:"center", editable: false }        
		                ] ,
		                loadonce: true,
		        		rownumbers : true,
		                autowidth:true,
		        		//viewrecords : true,
		        		//hoverrows : true,
		                height: '616',
		                rowNum: 15,
		        		sortable: true,
		        		//emptyrecords : '데이터가 없습니다.',
		        		viewrecords: false,
		                pager: "#jqGridPager",
		                loadComplete	: function(data) {
		                	// 포지션 이동
		                	/* if(initFlag&& data.page==null){
		                 		var scrollPosition = $("#boxContent").offset().top;
		                    	$('html, body').animate({scrollTop : scrollPosition}, 1000);	
		                 	} */
		        			initFlag=true;
		        			
		        			//최초 리사이즈
		        			$("#jqGrid").jqGrid( 'setGridWidth', $(".sub_info_box > div").width());
		        			//$("#jqGrid").jqGrid( 'setGridHeight', 'auto');		        			
		        			//$("#gview_jqGrid").jqGrid( 'setGridHeight', $(".sub_info_box > div").height());
		        			
		        		    $(".ui-jqgrid-bdiv").width($(".ui-jqgrid-bdiv").width()+1);
		        		    $(".ui-th-column.ui-th-ltr").attr('scope','col')
		        		    //$('table#jqGrid.boxList.ui-jqgrid-btable.ui-common-table tbody tr td').attr('scope','row')
		        		    //$('input.ui-pg-input.ui-corner-all').attr('aria-labelledby','input_jqGridPager')
		        		    //let rowCount = $("#jqGrid").getGridParam("reccount");
					 		//let gridHeight =$("#jqGrid").getGridParam("height");
					 		$("#jqGrid tr").not(":first-child").css('height','41');

		        		    setTimeout(function(){$('#jqGrid_SANNAME').css('width','95px')},1000)
		        		    
		        		    // 데이터 없을 경우
		        		    if(data.page == null){
			        		    if(data.list.length == 0) {
			        		    	
			        		    	if(cmpCd !='6068207466' || cmpCd !='1288202296' || cmpCd !='6158209828'){
			        		    		//$("#jqGrid").append("<tr><td colspan='8' id='nodata1' align='center'>금일 경매없음</td></tr>");
			        		    	}else{
			        		    		//$("#jqGrid").append("<tr><td colspan='8' id='nodata2' align='center'>해당 공판장은 실시간 경매자료가 존재 하지않습니다.</td></tr>");	
			        		    	}
			        		    	
			        		    }
		        		    }
		             	}
		            });
		            $('#jqGrid').navGrid('#jqGridPager',
		                // the buttons to appear on the toolbar of the grid
		                { edit: false, add: false, del: false, search: false, refresh: true, view: false, position: "left", cloneToTop: false },
		                // options for the Edit Dialog
		                 // options for the Delete Dailog
		                {
		                    errorTextFormat: function (data) {
		                        return 'Error: ' + data.responseText
		                    }
		                },
		        		{ multipleSearch: true} // search options - define multiple search
		       		);
		            $("#jqGrid").jqGrid("setLabel", "rn", "No.");
		            
		            //search();
		    }
		};
	
	</script>
</head>

<body>
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
				<li>경매실적</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li class="m_right">실시간 경매실적</li>
			</ul>
		</div>
		<!--sub 헤더 (E)-->
		<!--서브 타이틀(S)-->
		
		<jsp:include page="../inc/2020/IncShare.jsp"/>
		
		<div class="sub_title">
			<div class="title_box">
				<h2 class="sub_tit">실시간 경매실적</h2>
				<img src="../images/2020/sub/t_line.png" alt="방울점선">
			</div>
		</div>
		<!--서브 타이틀(E)-->
		
		<jsp:include page="../inc/2020/topMenu.jsp"/>
		
				
		<!--컨텐츠 내용(S)-->
		<div class="sub_guide">
			<div class="sub_info_box">
				<h2 class="title_02">실시간 경매실적</h2>
				<div class="info_box" >
				    <table id="jqGrid" class="boxList"></table>
				    <div id="jqGridPager"  aria-label="jqGridPager"  style="height:35px;"></div>
				</div>
			</div>			
			
			<div class="auction_time">
				<h2 class="title_02">공판장별 경매시간</h2>
				<table border="1">
					<caption>공판장별 경매시간</caption>
					<thead>
						<tr>
							<th style="width:15%">구분</th>
							<th style="width:15%">실시간 경매실적</th>
							<th style="width:45%">경매일시</th>
							<th style="width:30%">일자별 정산가격 확인 시점</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>aT화훼공판장 (양재동)</td>
							<td>제공 (10분 단위)</td>
							<td>절화: 일화목 23시30분  &nbsp; &nbsp;난: 월목 8시 &nbsp; &nbsp; 관엽: 화금 8시</td>
							<!-- <td>절화: 월수금 0시  &nbsp; &nbsp;난: 월목 8시 &nbsp; &nbsp; 관엽: 화금 8시</td> -->
							<td>오후 12시30분</td>
						</tr>
						<tr>
							<td>부산화훼공판장(엄궁동)</td>
							<td>제공(1시간단위)</td>
							<td>절화: 월수금 8시  &nbsp; &nbsp;난: 월 12시30분/목 9시 &nbsp; &nbsp; 관엽: 월 14시30분/목 10시</td>
							<td>익일 6시</td>
						</tr>
						<tr>
							<td>부산경남화훼농협(강동동)</td>
							<td>미제공</td>
							<td>절화: 월수금 0시  &nbsp; &nbsp;난, 관엽 통합경매: 월 12시/목 10시</td>
							<td>익일 6시</td>
						</tr>
						<tr>
							<td>광주원예농협(풍암)</td>
							<td>제공(1시간단위)</td>
							<td>절화: 월수금 5시  &nbsp; &nbsp;난: 목 10시</td>
							<td>익일 6시</td>
						</tr>
						<tr>
							<td>한국화훼농협(음성)</td>
							<td>제공(1시간단위)</td>
							<td>난 관엽 통합경매: 월목 8시</td>
							<td>익일 6시</td>
						</tr>
						<tr>
							<td>한국화훼농협(고양)</td>
							<td>미제공</td>
							<td>난: 금 8시</td>
							<td>익일 6시</td>
						</tr>
						<tr>
							<td>영남화훼농협(김해)</td>
							<td>미제공</td>
							<td>절화: 월수금 8시</td>
							<td>익일 6시</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="guide" id="boxContent">
				<h2 class="title_02">이용안내</h2>
				<ul class="guide_box">
					<li>· 경매정보를 일자별로 비교 분석 할수 있는 화면  </li>
					<li>· 품종별 종합경매정보 및 등급정보 목록을 선택하시면 해당하는 정보를 볼 수 있습니다.</li>
					<li>· 단위 : 단(속), 단가(원) / 자료출처 : 각 공판장별 경매 자료 현황</li>
					<li>· 이 자료는 착오의 정정, 하자처리 등이 반영되지 않은 결과이므로 정산자료와 차이가 있을 수 있으며, 증빙자료로 사용할 수 없습니다.</li>
					<li>· 부산경남화훼(강동동), 한국화훼농협(과천), 영남화훼농협(김해) 공판장은 실시간 경매정보를 제공하지 않습니다.</li>
				</ul>
			</div>
		</div>
		<!--컨텐츠 내용(E)-->		

		<jsp:include page="../inc/2020/IncFooter.jsp"/>
	</div>
	<!--WRAP(E)-->
</body>