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
	<title>품목, 품종별 출하시기</title>
	<%@include file="../common/2020/commonJs.jsp" %>
	<%@include file="../common/2020/commonCss.jsp" %>


	<script type="text/javascript">
		var firstSearch1=true;
		var firstSearch =true;
		var cmpCd = [];
		var flowerCd = [];
		var auctionType = 'sCmp';
		var dateType = 'day';
		var hisStrDate = "";
		var hisEndDate = "";
		var danCdType = false;
		var searchDate = "";
		var clickStatus = "0";


		$(window).on('resize.jqGrid', function () {
		    $("#jqGrid").jqGrid( 'setGridWidth', $(".sub_info_box > div").width());
		    $("#jqGridPager").jqGrid( 'setGridWidth', $(".sub_info_box > div").width());
		    $("#jqGrid2").jqGrid( 'setGridWidth', $(".cont_left_b").width());
		    $("#jqGridPager2").jqGrid( 'setGridWidth', $(".cont_left_b").width());
		    $(".ui-jqgrid-bdiv").width($(".ui-jqgrid-bdiv").width()+1);
		    auctionType = $(":input:radio[name=rr99]:checked").val();
			dateType = $(":input:radio[name=rr]:checked").val();

		});
		
		$(document).ready(function(){
			var now = new Date();
			now.setMonth(now.getMonth());
			$("#searchStrDateY").val((now.getFullYear()-3).toString());
			$("#searchEndDateY").val(now.getFullYear().toString());
			$("#excelBtn1").empty();
			$("#excelBtn1").append('<a href="javascript:void(0);" id="exportBtn1" name="exportTable1" onclick="excelExport();"><img src="../images/2020/exel.png" alt="엑셀이미지">엑셀저장</a>');

	    });
		//rMate 차트 생성 준비가 완료된 상태 시 호출할 함수를 지정합니다.
		var chartVars = "rMateOnLoadCallFunction=chartReadyHandler";
		var chartVars3 = "rMateOnLoadCallFunction=chartReadyHandler3";

		//rMateChart 를 생성합니다.
		function chartReadyHandler(id) {
			document.getElementById(id).setLayout(layoutStr);
			document.getElementById(id).setData(chartData);
			checkData(chartData);
		}

		function chartReadyHandler3(id) {
			document.getElementById(id).setLayout(layoutStr3);
			document.getElementById(id).setData(chartData3);
			checkData3(chartData3);
		}


		var layoutStr =
		 '<rMateChart backgroundColor="#FFFFFF" borderStyle="none">'
		       +'<Options>'
		          +'<Caption text="Global Temperature"/>'
		           +'<Legend />'
		     +'</Options>'
		     +'<NumberFormatter id="nft" precision="2"/>'
		      +'<Line2DChart showDataTips="true" dataTipFormatter="{nft}">'
		         +'<horizontalAxis>'
		               +'<CategoryAxis id="hAxis" categoryField="date"/>'
		            +'</horizontalAxis>'
		          +'<verticalAxis>'
		             +'<BrokenAxis id="vAxis" brokenMinimum="3000" brokenMaximum="100000" maximum="116000" brokenRatio="0.8" />'
		           +'</verticalAxis>'
		            +'<series>'
		               +'<Line2DSeries yField="각구도라" displayName="각구도라">'
		                   +'<showDataEffect>'
		                       + '<SeriesClip duration="1000"/>'
		                 +'</showDataEffect>'
		              +'</Line2DSeries>'
		                +'<Line2DSeries yField="개나리" displayName="개나리">'
		                 +'<showDataEffect>'
		                       + '<SeriesClip duration="1000"/>'
		                 +'</showDataEffect>'
		              +'</Line2DSeries>'
		            +'</series>'
		      +'</Line2DChart>'
		 +'</rMateChart>';
		var layoutStr3 =
		 '<rMateChart backgroundColor="#FFFFFF" borderStyle="none">'
		       +'<Options>'
		          +'<Caption text="Global Temperature"/>'
		           +'<Legend />'
		     +'</Options>'
		     +'<NumberFormatter id="nft" precision="2"/>'
		      +'<Line2DChart showDataTips="true" dataTipFormatter="{nft}">'
		         +'<horizontalAxis>'
		               +'<CategoryAxis id="hAxis" categoryField="date"/>'
		            +'</horizontalAxis>'
		          +'<verticalAxis>'
		             +'<LinearAxis id="vAxis" title="Temperature Anomaly (℃)"/>'
		           +'</verticalAxis>'
		            +'<series>'
		               +'<Line2DSeries yField="각구도라" displayName="각구도라">'
		                   +'<showDataEffect>'
		                       + '<SeriesClip duration="1000"/>'
		                 +'</showDataEffect>'
		              +'</Line2DSeries>'
		                +'<Line2DSeries yField="개나리" displayName="개나리">'
		                 +'<showDataEffect>'
		                       + '<SeriesClip duration="1000"/>'
		                 +'</showDataEffect>'
		              +'</Line2DSeries>'
		            +'</series>'
		      +'</Line2DChart>'
		 +'</rMateChart>';
 
// 		//차트 데이터
		var chartData = [];
		var chartData2 = [];
		var chartData3 = [];
		
		var fristSale;
		
		function rMateChartH5ChangeTheme(theme){
			document.getElementById("chart1").setTheme(theme);
			document.getElementById("chart3").setTheme(theme);
		}

		function checkData(data){
			if(data.length <= 0){
				// 데이터가 없을 경우 hasNoData함수를 실행하여 메세지창을 출력한다.
				document.getElementById("chart1").hasNoData(true);
			}
		}



		function checkData3(data){
			if(data.length <= 0){
				// 데이터가 없을 경우 hasNoData함수를 실행하여 메세지창을 출력한다.
				document.getElementById("chart3").hasNoData(true);
			}
		}
		
		function excelExport(){

        	var url = '';
        	var itemCd = "";
        	var itemCd2 = "";
        	var searchStrDate = $("#searchStrDateY").val() + '-01-01';
        	var searchEndDate = $("#searchEndDateY").val() + '-12-31';

        	let flowers = [];
        	let items = [];
        	let itemDtls = [];
        	
        	flowerCd = [];
        	cmpCd = [];
        	if(fnObj.param.rsItem.length == 0){
        		alert("품목은 필수선택 항목입니다.");
        		return;
        	}
        	fnObj.param.rsFlowerCtgr.forEach(function(item){
				flowers.push(item.cdId);
				flowerCd.push(item.cdId);
			});


        	fnObj.param.rsItem.forEach(function(item){
				items.push(item.cdId);
			});

        	fnObj.param.rsItemDtl.forEach(function(item){
				itemDtls.push(item.cdId);
			});

        	var gubn = [];
        	var excelNm = "품목품종별 출하시기("+items[0];
        	if (itemDtls.length != 0){
        		excelNm += ", " + itemDtls[0] + ")";
        	}
        	else{
        		excelNm += ")";
        	}
			console.log("excelNm", excelNm)

     		url = "/excel/selectHaa00ChartJson2.json";
     		let param = "?excelNm="+excelNm+"&searchStrDate="+searchStrDate+"&searchEndDate="+searchEndDate+"&flower[]="+flowers+"&item[]="+items+"&itemDtl[]="+itemDtls;
     		location.href = url+param;
		}
		
		//-----------------------차트 설정 끝 -----------------------

		$(document).ready(function(){
			$('#progress_loading').hide();
			$("#sCmp").show();
			$("#tCmp").hide();

			$('#itemCd').select2();
			$('#itemCd2').select2();

			$("input[name=flowerGubn]").change(function(){
				if(this.checked){
					if($('input:checkbox[name="flowerGubn"]:checked').length == 4){
						$("#chk05").prop("checked",true);
					}
				}else{
					$("#chk05").prop("checked",false);
				}
				getSalePumList();
			});

			$("input[name=tCmpCd]").change(function(){
				if(this.checked){
					if($('input:checkbox[name="tCmpCd"]:checked').length == 7){
						$("#chk177").prop("checked",true);
					}
				}else{
					$("#chk177").prop("checked",false);
				}
				getSalePumList();
			});

			$("input[name=sCmpCd]").change(function(){
				getSalePumList();
			});

			$("input[name=gubn]").change(function(){
				if(this.checked){
					if($('input:checkbox[name="gubn"]:checked').length == 3){
						$("#chk33-02").prop("checked",true);
					}
				}else{
					$("#chk33-02").prop("checked",false);
				}
			});

			$("#itemCd").change(function() {
				getSaleGoodList();
				if($("#itemCd").val() != ''){
					$("#chk00-02").prop("checked",false);
					$("#chk11-02").prop("checked",true);
					$("#chk22-02").prop("checked",false);
					$("#chk33-02").prop("checked",false);
				}
			});

			$("#itemCd2").change(function() {
				if($("#itemCd2").val() != ''){
					$("#chk00-02").prop("checked",false);
					$("#chk11-02").prop("checked",false);
					$("#chk22-02").prop("checked",true);
					$("#chk33-02").prop("checked",false);
				}
			});

			//달력 연별설정
			$("#searchStrDateY").bindDate({align:"right", valign:"bottom", separator:"-", selectType:"y",  defaultSelectType:"y", value:"",
				onchange:function(){
					cmpCd= [];
					flowerCd = [];
					var searchEndDate = $("#searchEndDateY").val();
					new Date(searchEndDate);
					$('input:checkbox[name="flowerGubn"]:checked').each(function(){
		       			flowerCd.push($(this).val());
		       		})

					if(searchStrDate!=''&& searchEndDate!=''){
						getSalePumList();
					}
				}

			});

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

					if(searchStrDate!=''&& searchEndDate!=''){
						getSalePumList();
					}
					
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

			// 초기1회로딩
			getSalePumList();
			let initData = {
				rsFlowerCtgr: [{cdId: '1', cdNm: '절화', cdSeq: 1}],
		    	rsMarket: [{cdId: '0000000001', cdNm: 'aT화훼(양재)', cdSeq: 1}
		    	],
		    	rsItem: [],
		    	rsItemDtl: []
			};
			fnObj.setPopupParam(initData);
		});

		function datechktoday(date){
			if(date > new Date()) return [false]; return [true];
		}


		var fnObj = {
				param : {
					strDate: '',
			    	endDate: '',
			    	rsFlowerCtgr: [],
			    	rsMarket: [],
			    	rsItem: [],
			    	rsItemDtl: []
				},
				resetParam : function() {
					
					
					fnObj.param.rsFlowerCtgr = [{cdId: '1', cdNm: '절화', cdSeq: 1}];
					fnObj.param.rsMarket = [{cdId: '0000000001', cdNm: 'aT화훼(양재)', cdSeq: 1}
			    	];
					fnObj.param.rsItem.length = 0;
					fnObj.param.rsItemDtl.length = 0;
					fnObj.setInfoText();

					// 구분
					$("input:radio[name='rr99']:radio[value='sCmp']").prop('checked', true);
					// 기간
					$("input:radio[name='rr1']:radio[value='week']").prop('checked', true);
					var now = new Date();
					now.setMonth(now.getMonth());
 					$("#searchStrDateY").val((now.getFullYear()-3).toString());
 					$("#searchEndDateY").val(now.getFullYear().toString());
					// 조회단위
					$("input:radio[name='rr']:radio[value='day']").prop('checked', true);
					$("#searchDateY").show();
					// 표시단위
					$("#chk00-02").prop("checked", false);
					$("#chk11-02").prop("checked", true);
					$("#chk22-02").prop("checked", false);
					$("#chk33-02").prop("checked", false);
					$('#tb__itemSrch').DataTable().search('').draw();
					$('#tb__itemDtlSrch').DataTable().search('').draw();
				},
				setInfoText : function() {
					console.log("setInfoText");
					let paramText = '';
					fnObj.param.rsFlowerCtgr.forEach(function(item){
						if (!isEmpty(paramText)) {
							paramText += ', ';
						}
						paramText += item.cdNm;
					});
					$('.flower__text').text(paramText);

					paramText = '';
					fnObj.param.rsMarket.forEach(function(item){
						if (!isEmpty(paramText)) {
							paramText += ', ';
						}
						paramText += item.cdNm;
					});
					$('.market__text').text(paramText);

					paramText = '';
					fnObj.param.rsItem.forEach(function(item){
						if (!isEmpty(paramText)) {
							paramText += ', ';
						}
						paramText += item.cdNm;
					});
					$('.item__text').text(paramText);

					paramText = '';
					fnObj.param.rsItemDtl.forEach(function(item){
						if (!isEmpty(paramText)) {
							paramText += ', ';
						}
						paramText += item.cdNm;
					});
					$('.itemDtl__text').text(paramText);
				},
				setPopupParam : function (rs) {
					console.log("rs", rs);
					let paramText = '';
					fnObj.param.rsFlowerCtgr.length = 0;
					rs.rsFlowerCtgr.forEach(function(item){
						fnObj.param.rsFlowerCtgr.push(item);
						if (!isEmpty(paramText)) {
							paramText += ', ';
						}
						paramText += item.cdNm;
					});
					$('.flower__text').text(paramText);
					paramText = '';
					fnObj.param.rsMarket.length = 0;
					rs.rsMarket.forEach(function(item){
						fnObj.param.rsMarket.push(item);
						if (!isEmpty(paramText)) {
							paramText += ', ';
						}
						paramText += item.cdNm;
					});
					$('.market__text').text(paramText);

					paramText = '';
					fnObj.param.rsItem.length = 0;
					rs.rsItem.forEach(function(item){
						fnObj.param.rsItem.push(item);
						if (!isEmpty(paramText)) {
							paramText += ', ';
						}
						paramText += item.cdNm;
					});
					$('.item__text').text(paramText);
					paramText = '';
					fnObj.param.rsItemDtl.length = 0;
					if (rs.rsItemDtl.length == 0 && rs.rsItem.length != 0){

					}
					else{
						rs.rsItemDtl.forEach(function(item){
							fnObj.param.rsItemDtl.push(item);
							if (!isEmpty(paramText)) {
								paramText += ', ';
							}
							paramText += item.cdNm;
						});
					}
					$('.itemDtl__text').text(paramText);
					$("#chk22-02").prop("checked",true);
				},
	        setPage : function(){
		            fnObj.chart_sumary();
		    },
			Mobile : function () {return /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent);},
    	    chart_sumary: function(){
	        	var url = '';
	        	var itemCd = "";
	        	var itemCd2 = "";
	        	var searchStrDate = $("#searchStrDateY").val() + '-01-01';
	        	var searchEndDate = $("#searchEndDateY").val() + '-12-31';

	        	let flowers = [];
	        	let items = [];
	        	let itemDtls = [];
	        	
	        	flowerCd = [];
	        	cmpCd = [];
	        	if(fnObj.param.rsItem.length == 0){
	        		alert("품목은 필수선택 항목입니다.");
	        		return;
	        	}
	        	fnObj.param.rsFlowerCtgr.forEach(function(item){
					flowers.push(item.cdId);
					flowerCd.push(item.cdId);
				});


	        	fnObj.param.rsItem.forEach(function(item){
					items.push(item.cdId);
				});

	        	fnObj.param.rsItemDtl.forEach(function(item){
					itemDtls.push(item.cdId);
				});

	        	var gubn = [];

	     		url = "/haa05/selectHaa00ChartJson2.json";
				
	     		console.log("searchStrDate", searchStrDate)
	     		console.log("searchEndDate", searchEndDate)
	     		console.log("flowers", flowers)
	     		console.log("items", items)
	     		console.log("itemDtls", itemDtls)
	     		
    	    	$.ajax({
    				type : "post",
    				url : url,
    				data : {
	        			searchStrDate: searchStrDate,
	        			searchEndDate: searchEndDate,
	        			flower: flowers,
	        			item: items,
	        			itemDtl: itemDtls
	        			
    				},
    				dataType : '',
    				success : function(res){
    					var val = res.list;
    					console.log('val', val);
    					chartData = [];
    					chartData2 = [];
    					chartData3 = [];
    					if(val!=null && val.length > 0){
    						chartData = val[0];
    						chartData2 = val[1];
    						chartData3 = val[2];
    						layoutStr = '<rMateChart backgroundColor="#FFFFFF" borderStyle="none">'
    							+'<NumberFormatter id="numfmt" useThousandsSeparator="true"/>'
    						       +'<Options>'
    						       +'<SubCaption text="(단위 : 분(속))" textAlign="left" />'
    						          +'<Caption text=" "/>'
    						           +'<Legend />'
    						     +'</Options>'
    						     +'<NumberFormatter id="nft" precision="2"/>'
    						      +'<Line2DChart showDataTips="true" dataTipFormatter="{nft}">'
    						         +'<horizontalAxis>'
    						               +'<CategoryAxis id="hAxis" categoryField="date"/>'
    						            +'</horizontalAxis>'
    						          +'<verticalAxis>'
    						             +'<LinearAxis id="vAxis" formatter="{numfmt}"/>'
    						           +'</verticalAxis>'
    						            +'<series>';
    						            
    						var body = "";
							let jongNmList = Object.keys(val[0][0]);
							jongNmList.splice(jongNmList.indexOf('date'), 1);
							
							tempDate= Number(searchEndDate.toString().substring(0, 4));
							var default_color = ["#cbd2d8", "#9099a3", "#4f5b68", "#dd0c14"];
							
							for(var i=0; i<4; i++){
								body += '<Line2DSeries radius="2.5" fill="'+default_color[i]+'" form="curve" itemRenderer="CircleItemRenderer" yField="' + (tempDate-3+i).toString() + '" displayName="' + (tempDate-3+i).toString() + '">'
								+ '<stroke>'
								+ '<Stroke color="'+default_color[i]+'" weight="3"/>'
								+ '</stroke>'
								+ '<lineStroke>'
								+ '<Stroke color="'+default_color[i]+'" weight="3"/>'
								+ '</lineStroke>'
								+ '<showDataEffect>'
								+ '<SeriesInterpolate/>'
								+ '</showDataEffect>'
							+'</Line2DSeries>'
							}
							body += '</series>'
									+'</Line2DChart>'
		   						 +'</rMateChart>';
	   						layoutStr += body;
	   						
		   					layoutStr3 = '<rMateChart backgroundColor="#FFFFFF" borderStyle="none">'
		   						+'<NumberFormatter id="numfmt" useThousandsSeparator="true"/>'
	 						       +'<Options>'
    						       +'<SubCaption text="(단위 : 원)" textAlign="left" />'
 						          +'<Caption text=" "/>'
 						           +'<Legend />'
							     +'</Options>'
							     +'<NumberFormatter id="nft" precision="2"/>'
							      +'<Line2DChart showDataTips="true" dataTipFormatter="{nft}">'
							         +'<horizontalAxis>'
							               +'<CategoryAxis id="hAxis" categoryField="date"/>'
							            +'</horizontalAxis>'
							          +'<verticalAxis>'
							             +'<LinearAxis id="vAxis" formatter="{numfmt}"/>'
							           +'</verticalAxis>'
							            +'<series>' + body;

							rMateChartH5.create("chart1", "chartHolder", chartVars, "100%", "99%");
							rMateChartH5.create("chart3", "chartHolder3", chartVars3, "100%", "99%");
    						gridData = []
    						typeList = ['판매물량', '평균단가'];
    						for(var i=0; i<jongNmList.length; i++){
    							for(var j=0; j<2; j++){
    								gridData.push([jongNmList[i], typeList[j]]);
    								for(var k=0; k<36*4; k++){
    									gridData[i*2+j].push(0);
    								}
    							}
    						}
    						var stdrdYYYY = Number(searchEndDate.substring(0,4));
    						var stdrdMM = Number(searchEndDate.substring(5,7));
    						var stdrdSUN = Number(searchEndDate.substring(8,10));
    						if (stdrdSUN >0 && stdrdSUN <= 10)
    							stdrdSUN = 0;
    						else if(stdrdSUN > 10 && stdrdSUN <= 20)
    							stdrdSUN = 1;
    						else
    							stdrdSUN = 2;
    						for(var i=0; i<2; i++){
    							for(var j=0; j<val[i].length; j++){
    								var curDate = val[i][j].date;
    								var curYYYY = Number(curDate.substring(0,4));
    								var curMM = Number(curDate.substring(5,7));
    								var curSUN = Number(curDate.substring(8,9));
    								dateIdx = (36*4 - ((stdrdYYYY - curYYYY) * 36) + ((stdrdMM - curMM) * 3) + (stdrdSUN - curSUN)); 
    								for(var k=0; k<jongNmList.length; k++){
   										var jongNm = jongNmList[k];

   										gridData[k*2+i][dateIdx] = val[i][j][jongNm];
   									}
    							}
    						}
    						fristSale = val[3];
							if(!fnObj.Mobile()){
							//export_date_b
								$('.export_date_b table').css('width','100%');
							} else {
								$('.export_date_b table').css('width','100vw');
							}

    						$("#thead").empty();
    						var row = "<tr><th>기간</th>";
							for(var i=0; i<4; i++){
								row += "<th colspan='2'>" + (tempDate-3+i).toString()+ "<span style='color:blue'> (최초출하: "+fristSale[i]["dateDtl"]+")</th>";
							}
							row += "</tr>";
							$("#thead").append(row);
							row = "<tr><th></th>";
							for(var i=0; i<4; i++){
								['판매물량', ' 평균단가'].forEach(function(e){
									row += "<th>" + e+ "</th>"
								});
							}
							row += "</tr>";
							$("#thead").append(row);

							sunArr = ["상순","중순","하순"];
							$("#tBody").empty();
							for(var i=0; i<36; i++){
								var row = "<tr><td>" + chartData[i].date + "</td>";
								for(var j=-3; j<=0; j++){
									if ((Math.floor(i/3)+1).toString()+"월-"+sunArr[(i%3)] == fristSale[j+3]["endValue"] && fristSale[j+3]["verticalEndValue"] != 0){
										row += "<td bgcolor='#D9E5FF'>" + chartData[i][(tempDate+j).toString()] + "</td>";
										row += "<td bgcolor='#D9E5FF'>" + Math.floor(chartData3[i][(tempDate+j).toString()]) + "</td>";
									}
									else{
									row += "<td>" + chartData[i][(tempDate+j).toString()] + "</td>";
									row += "<td>" + Math.floor(chartData3[i][(tempDate+j).toString()]) + "</td>";
									}
								}
								row += "</tr>";
								$("#tBody").append(row);
							}
							
							document.getElementById('unit').innerText = '단위 : 분(속)';
    					}else{
    						chartData = [];
    						chartData2 = [];
    						chartData3 = [];
    						if(!document.getElementById("chart1")){
    		                	rMateChartH5.create("chart1", "chartHolder", chartVars, "100%", "99%");
    		            	 } else{
    		            		 chartReadyHandler("chart1");
    		        		}
    						if(!document.getElementById("chart3")){
    		                	rMateChartH5.create("chart3", "chartHolder3", chartVars3, "100%", "99%");
    		            	 } else{
    		            		 chartReadyHandler("chart3");
    		        		}
    					}
    				}
    			});
    	    	
    	    },

    		// 팝업
    		modalOpen: function () {
    			let dateType = $(":input:radio[name=rr]:checked").val();
    			let strDate = $("#searchStrDateY").val() + '-01-01';
    			let endDate = $("#searchEndDateY").val() + '-12-31';

				console.log("date", strDate, endDate);
				fnObj.param.strDate = strDate;
				fnObj.param.endDate = endDate;
				console.log("fnObj.param", fnObj.param);
    			multiPopup.openPopup(fnObj.param);
		    }
		};

		function selectFlowerGubnAll(selectAll,gubn){
			var checkboxes = document.getElementsByName(gubn);
			for(var i = 0; i < checkboxes.length; i++){
				checkboxes[i].checked = selectAll.checked;
			}
		}

		//품목검색(정산테이블-일자별)
		function getSalePumList(){
			var url = '';
        	var searchStrDate = $("#searchStrDateY").val() + '-01-01';
     		var searchEndDate = $("#searchEndDateY").val() + '-12-31';
     		flowerCd = [];

     		if(auctionType == 'sCmp'){
     			cmpCd = $(":input:radio[name=sCmpCd]:checked").val();
     			url = "/search/selectPumNameCmpDate.json";
     		}else{
     			cmpCd = [];
     			$('input:checkbox[name="tCmpCd"]:checked').each(function(){
           			cmpCd.push($(this).val());
           		})
     			url = "/search/selectPumNameCmpTotal.json";
     		}

    		$('input:checkbox[name="flowerGubn"]:checked').each(function(){
    			flowerCd.push($(this).val());
    		})
		}

		//품종검색(정산테이블-일자별)
		function getSaleGoodList(){
			var itemCd = $('#itemCd option:selected').val();
			flowerCd = [];
			var searchStrDate = $("#searchStrDateY").val() + '-01-01';
			var searchEndDate = $("#searchEndDateY").val() + '-12-31';
			var url = '';
			if(auctionType == 'sCmp'){
     			cmpCd = $(":input:radio[name=sCmpCd]:checked").val();
     			url = "/search/selectGoodNameCmpDate.json";
     		}else{
           		cmpCd = [];
     			$('input:checkbox[name="tCmpCd"]:checked').each(function(){
           			cmpCd.push($(this).val());
           		})
     			url = "/search/selectGoodNameCmpTotal.json";
     		}

			$('input:checkbox[name="flowerGubn"]:checked').each(function(){
       			flowerCd.push($(this).val());
       		})
		}
		

		
		async function img_save(){
			
			var imgData;
			var imgWidth = 190;
			var imgHeight;
			var heightLeft;
			
			 // 이미지 가로 길이(mm) / A4 기준 210mm
		    var pageHeight = imgWidth * 1.414;  // 출력 페이지 세로 길이 계산 A4 기준
		    var margin = 10; // 출력 페이지 여백설정
		    var doc = new jsPDF('p', 'mm');
		    var position = 10;
	        await html2canvas(document.getElementById("capture_area"), {background:'#fff', onrendered: function( canvas ) {  
			    imgData = canvas.toDataURL('image/jpeg');
		    	imgHeight = canvas.height * imgWidth / canvas.width;
		    	heightLeft = imgHeight;
	        }});

		    doc.addImage(imgData, 'JPEG', margin, position, imgWidth, imgHeight);
		    heightLeft -= pageHeight;
		    var temp = imgHeight + 10;
		    
	        await html2canvas(document.getElementById("capture_area3"), {background:'#fff', onrendered: function( canvas ) {  
			    imgData = canvas.toDataURL('image/jpeg');
		    	imgHeight = canvas.height * imgWidth / canvas.width;
		    	heightLeft = imgHeight;
	        }});

		    doc.addImage(imgData, 'JPEG', margin, temp+position, imgWidth, imgHeight);
		    temp += imgHeight;
		    
			var imgData2;
	        await html2canvas(document.getElementById("capture_area2"), {background:'#fff', onrendered: function( canvas ) {  
		    	imgData2 = canvas.toDataURL('image/jpeg');
		    	imgHeight = canvas.height * imgWidth / canvas.width;
		    	heightLeft = imgHeight;
	        }});
		       
		    doc.addImage(imgData2, 'JPEG', margin, temp+position, imgWidth, imgHeight);
		    temp += imgHeight;
		    
			var imgData3;
	        await html2canvas(document.getElementById("boxContent"), {background:'#fff', onrendered: function( canvas ) {  
		    	imgData3 = canvas.toDataURL('image/jpeg');
		    	imgHeight = canvas.height * imgWidth / canvas.width;
		    	heightLeft = imgHeight;
	        }});
		       
		    doc.addImage(imgData3, 'JPEG', margin, temp+position, imgWidth, imgHeight);
		    doc.save('품목, 품종별 출하시기.pdf');
		}


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
				<li>경매통계</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li class="m_right">품목·품종별 출하시기</li>
			</ul>
		</div>
		<!--sub 헤더 (E)-->
		<!--서브 타이틀(S)-->

		<jsp:include page="../inc/2020/IncShare.jsp"/>

			<div class="sub_title">
				<div class="title_box">
				<div id="capture_area">
					<h2 class="sub_tit">품목·품종별 출하시기</h2>
					<div data-html2canvas-ignore="true">
					<p>전국 화훼공판장의 품목, 품종별 출하시기를 확인 할 수 있습니다.</p>
					<img src="../images/2020/sub/t_line.png" alt="방울점선">
					</div>
				</div>
			</div>

	
			<!--서브 타이틀(E)-->
			<!--서브공통 (S)-->
			<div id="capture_area3" class="sub_contents">
				<div class="sub_info_box"  data-html2canvas-ignore="true">
					<div class="tit_box_01">
						<div class="fr">
							<div class="dwn_bt_b btn_h_45" >
								<a class="reset_btn" href="javascript:fnObj.resetParam();"><img src="../images/main/btn_refresh_w.png" alt="초기화"> 초기화</a>
							</div>
							<div class="dwn_bt_b btn_h_45" >
								<a class="search_btn_n" href="javascript:fnObj.setPage();"><img src="../images/2020/sub/search_img.png" alt="돋보기"> 검색</a>
							</div>
	
						</div>
					</div>
				</div>
	
				<div class="search_box_new statistic">			
					<input type="hidden" id="searchStrDate" value="${searchStrDate}">
					<input type="hidden" id="searchEndDate" value="${searchEndDate}">				
					<div style="display: none" >
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
					<div id="s-line"     class="s-line">
						<h4 class="sbn_tit_01">기준년도</h4>
						<div class="sb_common_01 pack-01">
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
									<label style="color: red;">※ 기준연도를 포함한 이전 3년을 조회합니다.</label>
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
					<div class="s-line">
						<h4 class="sbn_tit_01">품목/품종</h4>
						<ul class="grow_check_box width_a ">
							<li>
								<span class="guide_box_span" style="font-size : 18px"><strong>부류 : </strong></span><span class="flower__text param__info" style="font-size : 18px"></span>
							</li>
							<li>
								<span class="guide_box_span" style="font-size : 18px"><strong>　　품목 : </strong></span><span class="item__text param__info" style="font-size : 18px"></span>
							</li>
							<li>
								<span class="guide_box_span" style="font-size : 18px"><strong>　　품종 : </strong></span><span class="itemDtl__text param__info" style="font-size : 18px"></span>
							</li>
						</ul>
						<div style=" border-radius: 4px; margin-top:8px; width: 120px;     text-align: center;     height: 40px;     background: #888888; display:inline-block; float:right;">
							<a style="  display: block; color: #fff; font-size: 18px;  line-height: 40px;" href="javascript:fnObj.modalOpen();">상세조건</a>
						</div>
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
	
				<!-- 테이블(S) -->
				<div class="guide">
				</div>
	
	
				<div class="sub_info_box" style="display: none" >
					<div class="tit_box_01">
						<div class="fl">
							<h2 class="title_02">경매정보</h2>
						</div>
					</div>
	
					<div class="info_box">
					    <table id="jqGrid" class="boxList" ></table>
					    <div id="jqGridPager" style="height:35px;"></div>
					</div>
				</div>
	
				<div id="capture_area2">
					<div class="data_content_b">
		 				<div class="cont_box_b">
							<div class="sub_info_box">
								<div class="fl">
									<h2 class="title_02">판매물량</h2>
								</div>
								<div class="fr" id="save_div" data-html2canvas-ignore="true">
									<div class="dwn_bt_b" id="chartHolderBtn" onclick="img_save()"><a href="#!">차트저장</a></div>
								</div>
								<div class="info_box h-type-01" id="chartHolder" style="width:100%; height:340px;"></div>
							</div>
						</div> 
					</div>
					<!-- 테이블(E) -->
					<div class="data_content_b">
						<h2 class="title_02">평균단가</h2>
						<div class="info_box h-type-01" id="chartHolder3" style="width:100%; height:340px;"></div>
					</div>
				</div>
			</div>
		<div class="sub_guide">
			<div class=" export_box_b">
				<div class="tit_box_01">
					<div class="fr">
						<div class="dwn_bt_b" id="excelBtn1"><a href="#!"><img src="../images/2020/exel.png" alt="엑셀이미지">엑셀저장</a></div><br/>
					</div>
				</div>
				<div style="width:45%; height:30px; float:right;" align="right">
						<label id="unit"></label>
				</div>

				<div class="export_date_b" style="overflow:initial !important">
					<table style="width:100vw;">
						<caption>품종별 종합 경매정보</caption>
						<colgroup>
								<col style="width: 6%">
								<col style="width: 10%">
								<col style="width: 10%">
								<col style="width: 10%">
								<col style="width: 10%">
								<col style="width: 10%">
								<col style="width: 10%">
								<col style="width: 10%">
								<col style="width: 10%">
						</colgroup>
						<thead id="thead">

						</thead>
						<tbody id="tBody">
	
						</tbody>
					</table>
				</div>
			</div>
			
			<div class="guide" id="boxContent">
				<h2 class="title_02">이용안내</h2>
				<ul class="guide_box">
					<li>· 상순 : 1~10일, 중순 : 11~20일, 하순 : 21~말일
					</li>
					<li>· 파란 배경으로 칠해진 부분은  최초출하된 시기를 의미함.</li>
					<li>· 양재동 화훼공판장 데이터만 제공됩니다.</li>
				</ul>
			</div>
		</div>
			
	<jsp:include page="../inc/2020/IncFooter.jsp"/>
	<div id="multiPopup" class="modal">
		<div class="modal-content">
		    <div class="modal-body">
				<jsp:include page="../popup/multi_popup2.jsp"/>
		    </div>
		</div>   
	</div>
<script>
	multiPopup.init(function(rs) {
		fnObj.setPopupParam(rs);
	});
</script>

	<!-- POPUP (E)-->
</body>