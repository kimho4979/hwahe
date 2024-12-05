<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>



<title>화훼유통정보시스템 관리자</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=9">
<meta http-equiv="X-UA-Compatible" content="IE=8">
<link rel="stylesheet" type="text/css" href="../../../css/layout.css" />

<!-- @@@@@@@@@@@@@@@@@@@@@@ css begin @@@@@@@@@@@@@@@@@@@@@@ -->
<link rel="stylesheet" type="text/css"
	href="<c:url value='/axisj/axicon/axicon.min.css' />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value='/axisj/ui/arongi/AXJ.min.css' />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value='/css/hw/n_ma.css' />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value='/css/hw/n_common.css' />" />
<!-- @@@@@@@@@@@@@@@@@@@@@@ css end   @@@@@@@@@@@@@@@@@@@@@@ -->
<!-- rMateChartH5 테마 js -->

<!-- @@@@@@@@@@@@@@@@@@@@@@ css end   @@@@@@@@@@@@@@@@@@@@@@ -->

<script type="text/javascript"
	src="<c:url value='/axisj/jquery/jquery.min.js' />"></script>
<script type="text/javascript"
	src="<c:url value='/axisj/dist/AXJ.min.js' />"></script>
<script type="text/javascript"
	src="<c:url value='/axisj/dist/cmmn/ax5-polyfill.js' />"></script>
<script type="text/javascript"
	src="<c:url value='/axisj/dist/cmmn/axjApp.js' />"></script>

<script>
	var myProgress = new AXProgress();
	var myGrid = new AXGrid();
	var myGrid2 = new AXGrid();
	
	
	var myModal = new AXModal();
	
	var REG_MONTH = "";
	var CHUL_NO = "";
	var MONTH_GUBN = "";
	var STATUS_CD = "";
	var BIGO = "";
	var pageNo2 = "";
	var pageSize = "";
	var startCount = "";
	var endCount = "";
	var loading_mask = new AXMask();
	var pageNo3 = "";
	var pageSize2 = "";
	var startCount2 = "";
	var endCount2 = "";
	$(function(){
		$("#accordian").find( "li" ).eq(6).addClass('active');
		$("#accordian h3").click(function(){
			$("#accordian ul ul").slideUp();
			if(!$(this).next().is(":visible"))
			{
				$(this).next().slideDown();
			}
		})
	});
	//기준월 첫날
	function getDt1(dt) {
		var newDt = new Date(dt);
		newDt.setDate(1);
		return converDateString(newDt);
	}

	//기준월 말일
	function getDt2(dt) {
		var newDt = new Date(dt);
		newDt.setMonth(newDt.getMonth() + 1);
		newDt.setDate(0);
		return converDateString(newDt);
	}

	function converDateString(dt) {
		return dt.getFullYear() + "-" + addZero(eval(dt.getMonth() + 1))
				
	}

	function addZero(i) {
		var rtn = i + 100;
		return rtn.toString().substring(1, 3);
	}
	function grid_ajax() {

		var dt = new Date();
		
		if($('#REG_DATE').val().length==0){
			document.getElementById('stDt').value = getDt2(dt);
			$('#REG_DATE').val(getDt1($('#stDt').val()));
			var F_DATE = document.getElementById("REG_DATE").value;
		}
		
		var F_DATE = document.getElementById("REG_DATE").value;

		$.ajax({
			type : 'get',
			url : "/maa01/maa01MonitorSobi.json",
			data : '&pageNo2=' + pageNo2 + '&pageSize=' + pageSize
					+ '&startCount=' + startCount + '&endCount=' + endCount
					+ '&CHUL_NO=' + CHUL_NO + '&F_DATE=' + F_DATE,
			dataType : '',
			success : function(res) {
				console.log(res.list);
				console.log(res.list2.pageNo2);
				var pageCount2 = res.list[0].TOTAL_COUNT/15;
				var pageRest = res.list[0].TOTAL_COUNT % 15;

				if (pageRest == 0) {
					pageRest = 0;
				} else {
					pageRest = 1;
				}
				pageCount2 = Math.floor(pageCount2);
				var pageResult = pageCount2 + pageRest;
				var data = {
					list : res.list,
					page : {
						pageNo : res.list2.pageNo2, // 현재페이지
						pageCount : pageResult, // 전체 페이지수
						listCount : res.list[0].TOTAL_COUNT
					// 우측하단 카운트 표시 갯수
					}
				};
				myGrid.setData(data);

				//myGrid.setList(res.list);
			},
		});
	};

	function grid_ajax1(item) {
		
		var F_DATE = $('#REG_DATE').val();
		
		console.log(item);
		$.ajax({
			type : 'get',
			url : "/maa01/maa01MonitorSobiDetail.json",
			data : '&COMP_CODE=' + item.COMP_CODE + '&F_DATE=' + F_DATE
					,
			dataType : '',
			success : function(res) {
				console.log(res.list);
				myGrid2.setList(res.list);
				//myGrid3.setList(res.list);
				//myGrid2.setList([]); 
				if (res.list.length > 0) {

				}
			},
		});

	}

	
	function grid_ajax3(item) {

		
		
		var F_DATE = $('#REG_DATE').val();
		
		
			
		$.ajax({
			type : 'get',
			url : "/maa01/maa01MonitorSobi_Date.json",
			data : '&COMP_CODE=' + item.COMP_CODE + '&F_DATE=' + F_DATE
					,
			dataType : '',
			success : function(res) {
				console.log(res.list);
				myGrid.setList(res.list);
				//myGrid3.setList(res.list);
				//myGrid2.setList([]); 
				if (res.list.length > 0) {

				}
			},
		});
	};
	

	var fnObj = {
		pageStart : function() {
			//alert("${SESSION_USER_ID}"+"${SESSION_CMP_CODE}"+"${SESSION_SAN_CD}");
			//	    	CHUL_NO=${SESSION_CMP_CODE};
			  fnObj.bindEvent();
			grid_ajax();
			
			$("#REG_DATE").bindDate({
				align : "right",
				valign : "bottom",
				separator : "-",
				selectType : "m",
				defaultSelectType : "m",
				onchange : function() {
					chart_ajax();
				}
			});

		
			myModal.setConfig({
				windowID : "myModalCT",
				width : 1150,

				displayLoading : true,
				scrollLock : false,
				onclose : function() {
					//toast.push("저장되었습니다.");
					
				}
			});

		
			myGrid.setConfig({
				targetID : "AXGridTarget",
				theme : "AXGrid",
				fixedColSeq : '',
				fitToWidth : true,
				colGroup : [  
				     {	key : "COMP_CODE",	label : "출하코드",width : "80",align : "center"	},
				 	 {	key : "USER_ID",label : "사용자",	width : "90",	align : "center"	}, 
					 {	key : "JAKWANG",label : "소비정보 등록 상태",	width : "90",align : "center"}
				,	 {	key : "SAN_BIGO",label : "주소",	width : "90",	align : "center"	}
				,	 {	key : "SAN_CD",label : "주소",	width : "90",	align : "center" ,display:false}
				],
				colHeadAlign : "center",

				body : {
					onclick : function() {
					
						grid_ajax1(this.item);
					 	
						
					 	$('#COMP_CODE').val(this.item.COMP_CODE);
					 	$('#SAN_CD').val(this.item.SAN_CD);
					/* fnObj.modalOpen(gridData); */ 
						
						
					},
					ondblclick : function() {

					},

					oncheck : function() {

					}
				},

				page : {
					paging : true,
					pageSize : 15,
					onchange : function(pageNo) {
						pageNo2 = this.pageNo;
						pageSize = this.pageSize;
						startCount = ((pageNo2 - 1) * pageSize) + 1;
						endCount = pageNo2 * pageSize;
						grid_ajax();
						//dialog.push(Object.toJSON(this));
						//alert(this.pageNo);
					}
				}
			});


			myGrid2
					.setConfig({
						targetID : "AXGridTarget2",
						theme : "AXGrid",
						fixedColSeq : '',
						fitToWidth : true,
						colGroup : [
							
								{
									key : "btns",
									label : "삭제",
									width : "40",
									align : "center",
									formatter : function() {
										return '<button type="button" name="delete" onclick="fnObj.getCheckedList('
												+ this.index
												+ ');"><i class="axi axi-trash-o"></i></button>';
									}
								},

								  {key:"REG_DATE1", label:"일자", width:"80", align:"center", pk:true},
								  {key:"REG_DATE", label:"일자", width:"80", align:"center", pk:true,display:false},       
			    	                 {key:"PUM_NAME", label:"품목명", width:"90", align:"center", display:false},
			    	                 {key:"SEQ_NO", label:"일련번호", width:"90", align:"center", display:false},
			    	                 {key:"CHUL_NO", label:"출하코드", width:"80", align:"center"}, 
			    	                 {key:"GOOD_NAME", label:"품종명", width:"100", align:"center"},    	                                     	                     	                  
			    	                 {key:"QTY", label:"거래량", width:"100", align:"right", formatter:"money"},    	                                 
			    	                 {key:"BIGO", label:"내용", width:"600"}, 

						],
						colHeadAlign : "center",

						body : {
							onclick : function() {
								
								
								var gridData = "REG_DATE=" + this.item.REG_DATE
										+ "&CHUL_NO=" + this.item.CHUL_NO
										+ "&QTY=" + this.item.QTY
										+ "&MARKET_CD=" + this.item.CMP_CODE
										+ "&GOOD_NAME=" + this.item.GOOD_NAME
										+ "&BIGO=" + this.item.BIGO
										+ "&SEQ_NO=" + this.item.SEQ_NO
										+ "&STATUS="+this.item.STATUS
										+ "&PUM_NAME="+this.item.PUM_NAME;
										
								fnObj.modalOpen(gridData);
							},
						},

						page : {
							paging : true,	
							pageSize : 15,
							onchange : function(pageNo) {
								pageNo3 = this.pageNo;
								pageSize2 = this.pageSize;
								startCount2 = ((pageNo3 - 1) * pageSize2) + 1;
								endCount2 = pageNo3 * pageSize2;

							}
						}

					});

		},
		 bindEvent: function(){
			 
	            //var _this = this;
      /*           $("#ax-page-btn-search").bind("click", function(){
                    _this.search.submit();
                });
                $("#ax-page-btn-save").bind("click", function(){
                    setTimeout(function() {
                        _this.save();
                    }, 500);
                });
                $("#ax-page-btn-excel").bind("click", function(){
                    app.modal.excel({
                        pars:"target=${className}"
                    });
                }); */
                $("#ax-grid-btn-add").bind("click", function(){
                	
                	
                	if($('#COMP_CODE').val()!=null && $('#COMP_CODE').val()!=''){
                			var gridData = "COMP_CODE=" + $('#COMP_CODE').val()+"&SAN_CD=" + $('#SAN_CD').val();
                		fnObj.modalOpen1(gridData);
                	}else{
                		alert('소비동향 등록 리스트를 선택해주세요.');
                	}
                	
                });
	        },
		
		modalOpen : function(gridData) {
			
			if (REG_MONTH == null || REG_MONTH == "") {
			}
			myModal.open({
				type : "GET",
				url : "/maa01/Maa01MonitorSobiPopup.do",
				pars : ("&" + gridData).queryToObject(),
				top : axdom(window).scrollTop() + 30,
				closeByEscKey : true
			});
		},
	
	modalOpen1 : function(gridData) {
			
			
			myModal.open({
				type : "GET",
				url : "/maa01/Maa01MonitorSobiPopup.do",
				pars : ("&" + gridData).queryToObject(),
				top : axdom(window).scrollTop() + 30,
				closeByEscKey : true
			});
		},
		

		

		getCheckedList : function(index) {

			if (!confirm("정말 삭제 하시겠습니까?"))
        		return;
			
			var deleteValue = [];

			$.Event(event).stopPropagation(); // 버튼클릭 이벤트가 row click 이벤트를 발생시키지 않도록 합니다.
			var item = myGrid2.list[index];
			value = item;
			console.log(value);
			if(value.GUBN=='출하예정물량'){
				value.GUBN='1'
			}else{
				value.GUBN='2'
			}
			
				
			if(value.CMP_CD=='광주원예농협(풍암)'){
				value.CMP_CD='4108212335'
			}else if(value.CMP_CD=='한국화훼농협(음성)'){
				value.CMP_CD='3848200087'
			}else if(value.CMP_CD=='한국화훼농협(과천)'){
				value.CMP_CD='1288202296'
			}else if(value.CMP_CD=='부산경남화훼농협(강동동)'){
				value.CMP_CD='6068207466'
			}else if(value.CMP_CD=='기타'){
				value.CMP_CD='9999999999'
			}else if(value.CMP_CD=='aT화훼공판장(양재동)'){
				value.CMP_CD='0000000001'
			}else if(value.CMP_CD=='부산화훼공판장(엄궁동)'){
				value.CMP_CD='1508500020'
			}
			
			deleteValue = (value.REG_DATE + ',' + value.PUM_NAME + ','
 					+ value.GOOD_NAME + ','
				+ value.CHUL_NO 
				+ ',' + value.GUBN
					+ ',' + value.CMP_CD + ',' + value.SEQ_NO + '!');
			  $("#COMP_CODE").val(value.CHUL_NO);
			  
			  $.ajax({
			    type : 'get',
			    url : "/maa01/deleteMonitorSobitDetail.json",
			    data :deleteValue,
			    dataType : '',   	           
			    success : function(res){        
			     
			     var item={
 			    		 COMP_CODE:$("#COMP_CODE").val()
			     }
			   	 grid_ajax1(item);
			      grid_ajax3(item);
			   	 
			    },
			});  
			
		},


	};

	function chart_ajax() {
		var F_DATE = document.getElementById("REG_DATE").value;
		
		if (F_DATE != '') {

			$.ajax({
				type : 'get',
				url : "/maa01/maa01MonitorSobi_Date.json",
				data : '&F_DATE=' + F_DATE,
				dataType : '',
				success : function(res) {
					console.log(res.list);
					myGrid.setList(res.list);
					chartData = res.list;

				},
			});
		} else {

		}
	};

	$(document).ready(fnObj.pageStart);
</script>
<!--[if lt IE 9]>
<script type="text/javascript" src="js/html5shiv.js"></script>
<![endif]-->
<!--[if lt IE 9]> 
	<script src="js/respond.min.js"></script> 
<![endif]-->


</head>
<body>

	<div id="wrap">
		<!--전체--->

		
			<%@ include file="/WEB-INF/jsp/admin/adminheader.jsp" %>
	
		<div class="hw_clear"></div>


		<div class="content_wrap">
			<!--네비와 컨텐츠 감싸는 부분-->

			<div class="navarea">
				<h1 class="logo">
					<img src="../../admin/images/logo.jpg" alt="aT화훼유통정보시스템 관리자" />
				</h1>

				<!-- menu -->
				<input type="hidden" id="stDt" /> 
				<input type="hidden"id="MARKET_CD" />
				<input type="hidden"id="COMP_CODE" />
				<input type="hidden"id="SAN_CD" />
					
			<%@ include file="/WEB-INF/jsp/admin/adminleft.jsp" %>


			</div>
			<div class="sub_contents">
				<div class="sub_contents_title">모니터요원 등록현황</div>

				<div class="real_contents">


					<div class="shipment_schedule_all3">
						<div class="shipment_schedule_title">
							<div class="half1_purple"></div>
							<span class="half_title_purple">소비동향 등록 리스트</span>
						</div>

						<div class="hw_infouse_01" id="pagesearch">
							<input type="text" name="REG_DATE" id="REG_DATE"
								class="AXInput W100" value="${REG_DATE}" />
						</div>
					
						
						<div class="hw_clear"></div>
						<div class="hw_ma_grid2">
							<div id="AXGridTarget" style="height: 350px;"></div>
						</div>
					</div>

					<div class="shipment_schedule_all3">
						<div class="shipment_schedule_title">
							<div class="half1_purple"></div>
							<span class="half_title_purple">소비동향 리스트</span>
						</div>
						
						<div class="hw_clear"></div>
						<div class="hw_ma_grid2">
							<div id="AXGridTarget2" style="height: 350px;"></div>
						</div>
						
									<div class="ax-button-group">
						<div class="right">
							<button type="button" class="AXButton" id="ax-grid-btn-add">
								<i class="axi axi-plus-circle"></i> 추가
							</button>
						
						</div>
						<div class="ax-clear"></div>
					</div>
						
					</div>
				
				</div>
			</div>
			<!--네비와 컨텐츠 감싸는 부분 끝-->





			<div class="hw_clear"></div>
			

		<%@ include file="/WEB-INF/jsp/admin/adminfooter.jsp" %>


		</div>
		<!--전체 끝--->
</body>

</html>



