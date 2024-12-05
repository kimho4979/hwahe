<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	$(function() {
		$("#accordian").find( "li" ).eq(7).addClass('active');
		$("#accordian h3").click(function() {
			$("#accordian ul ul").slideUp();
			if (!$(this).next().is(":visible")) {
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
		return dt.getFullYear() + "-" + addZero(eval(dt.getMonth() + 1));
	}

	function addZero(i) {
		var rtn = i + 100;
		return rtn.toString().substring(1, 3);
	}
	
	function grid_ajax() {


		 var dt = new Date(); 


		if($('#REG_DATE').val().length==0){
			var stDt=dt.getFullYear()+'-'+(dt.getMonth()+1)+'-'+dt.getDate();
			document.getElementById('stDt').value = stDt;
			$('#REG_DATE').val($('#stDt').val());
			
	 		var F_DATE = document.getElementById("REG_DATE").value;
			
		}
		
		 var F_DATE = document.getElementById("REG_DATE").value; 
		
		$.ajax({
			type : 'get',
			url : "/admin/userLogList.json",
			data : '&pageNo2=' + pageNo2 + '&pageSize=' + pageSize
					+ '&startCount=' + startCount + '&endCount=' + endCount
					+ '&CHUL_NO=' + CHUL_NO+'&F_DATE=' + F_DATE,
			dataType : '',
			success : function(res) {
				console.log(res.list);
				console.log(res.list2.pageNo2);
				
				if(res.list.length!=0){
				var pageCount2 = res.list[0].total_COUNT/15;
				var pageRest = res.list[0].total_COUNT % 15;
	
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
						listCount : res.list[0].total_COUNT
					// 우측하단 카운트 표시 갯수
					}//page end
				};//data end
				}else {
					var data = {
							list : res.list,
							page : {
								pageNo : 0, // 현재페이지
								pageCount :0, // 전체 페이지수
							listCount : 0
							// 우측하단 카운트 표시 갯수
							}//page end
						};//data end
				
				}
				myGrid.setData(data);
				//myGrid.setList(res.list);
			},
		});
	};

	var fnObj = {
		pageStart : function() {
			
			grid_ajax();
			$("#REG_DATE").bindDate({
				align : "right",
				valign : "bottom",
				separator : "-",
				selectType : "d",
				defaultSelectType : "d",
				onchange : function() {
					grid_ajax();
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
				colGroup : [ {
					key : "user_IP",
					label : "사용자IP",
					width : "90",
					align : "center"
				}, {
					key : "menu_ID",
					label : "메뉴ID",
					width : "90",
					align : "center"
				}, {
					key : "ins_DT",
					label : "등록일",
					width : "90",
					align : "center"
				}
				],
				colHeadAlign : "center",

				body : {
					onclick : function() {
				
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
		}

	};

	function chart_ajax() {
		var F_DATE = document.getElementById("REG_DATE").value;
		

		if (F_DATE != '') {

			$.ajax({
				type : 'get',
				url : "/admin/userLogList.json",
				data : '&F_DATE=' + F_DATE ,
				dataType : '',
				success : function(res) {
					console.log(res.list);
					console.log(res.list2.pageNo2);
					
					if(res.list.length!=0){
						var pageCount2 = res.list[0].total_COUNT/15;
						var pageRest = res.list[0].total_COUNT % 15;
					
		
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
						//listCount : res.list[0].total_COUNT
						// 우측하단 카운트 표시 갯수
						}//page end
					};//data end
				}else {
					
					var data = {
							list : res.list,
							page : {
								pageNo : 0, // 현재페이지
								pageCount :0, // 전체 페이지수
							listCount : 0
							// 우측하단 카운트 표시 갯수
							}//page end
						};//data end
				
				}
					myGrid.setList(res.list);
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


		<%@ include file="/WEB-INF/jsp/admin/adminheader.jsp"%>

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
				 <input type="hidden" id="COMP_CODE" />
				 <input type="hidden"id="SAN_CD" />
				 
				<%@ include file="/WEB-INF/jsp/admin/adminleft.jsp"%>


			</div>
			<div class="sub_contents">
				<div class="sub_contents_title">거래동향 보고서</div>

				<div class="real_contents">


					<div class="shipment_schedule_all3">
						<div class="shipment_schedule_title">
							<div class="half1_purple"></div>
							<span class="half_title_purple">로그관리</span>
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


					
				
				</div>
			</div>
			<!--네비와 컨텐츠 감싸는 부분 끝-->





			<div class="hw_clear"></div>


			<%@ include file="/WEB-INF/jsp/admin/adminfooter.jsp"%>


		</div>
		<!--전체 끝--->
</body>

</html>



