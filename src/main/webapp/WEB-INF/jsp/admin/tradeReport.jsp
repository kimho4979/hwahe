<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<link rel="stylesheet" type="text/css"	href="<c:url value='/axisj/axicon/axicon.min.css' />" />
<link rel="stylesheet" type="text/css"	href="<c:url value='/axisj/ui/arongi/AXJ.min.css' />" />
	<link rel="stylesheet" type="text/css"	href="<c:url value='/css/hw/n_ma.css' />" />
<link rel="stylesheet" type="text/css"	href="<c:url value='/css/hw/n_common.css' />" />
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
		$("#accordian").find("li").eq(12).addClass('active');
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
		var  GUBN =$('#GUBN').val();
/* 
		if($('#REG_DATE').val().length==0){
			var stDt=dt.getFullYear()+'-'+(dt.getMonth()+1)+'-'+dt.getDate();
			document.getElementById('stDt').value = stDt;
			$('#REG_DATE').val($('#stDt').val());
			
	 		var F_DATE = document.getElementById("REG_DATE").value;
			
		}
		
		 var F_DATE = document.getElementById("REG_DATE").value; 
		 */
		$.ajax({
			type : 'get',
			url : "/admin/sugepReportList.json",
			data : '&pageNo2=' + pageNo2 + '&pageSize=' + pageSize
					+ '&startCount=' + startCount + '&endCount=' + endCount+'&GUBN=' + GUBN
					,
			dataType : '',
			success : function(res) {
				
				console.log(res.list);
				console.log(res.list2.pageNo2);
				
				if(res.list.length!=0){
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
					}//page end
				};//data end
				
				}else{
					var data = {
							list : res.list,
							page : {
								pageNo : 0, // 현재페이지
								pageCount : 0, // 전체 페이지수
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
				//alert("${SESSION_USER_ID}"+"${SESSION_CMP_CODE}"+"${SESSION_SAN_CD}");
				//	    	CHUL_NO=${SESSION_CMP_CODE};
				fnObj.bindEvent();
				grid_ajax();
			
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
					            {key : "btns",label : "삭제",width : "20",align : "center",	formatter : function() {
									return '<button type="button" name="delete" onclick="fnObj.getCheckedList('
											+ this.index
											+ ');"><i class="axi axi-trash-o"></i></button>';
								}
							},
					            
					            {key : "ANUM",label : "번호",width : "30",	align : "center"}, 
					             {key : "TITLE",	label : "제목",	width : "90",align : "center"},
					             {key : "WRITE_NAME",label : "작성자",width : "90",align : "center"},
					             {key : "ORIGINAL_FILE_NAME",label : "파일",width : "90",align : "center"},
					             {key : "INS_DT",label : "작성일",width : "90",align : "center"},
					             {key : "SEQ_NO",label : "번호",width : "90",align : "center",display:false},
					             {key : "GUBN",label : "구분",width : "90",align : "center",display:false}
					           
				
					],
					colHeadAlign : "center",

					body : {
						onclick : function() {

							var gridData = "&SEQ_NO=" + this.item.SEQ_NO
											+ "&REG_DATE=" + this.item.INS_DT
											+ "&GUBN=" + this.item.GUBN
											+ "&TITLE=" + this.item.TITLE;

					fnObj.modalOpen1(gridData);
				

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
			},
			 bindEvent: function(){
		
	             $("#ax-grid-btn-add").bind("click", function(){
	             	
	             	var gridData ="GUBN=" + $('#GUBN').val();
	             		fnObj.modalOpen(gridData);
	             	
	             });
		        },
			modalOpen : function(gridData) {

				myModal.open({
					type : "GET",
					url : "/maa01/Maa01MonitortradeReport_Popup.do",
					pars : ("&" + gridData).queryToObject(),
					top : axdom(window).scrollTop() + 30,
					closeByEscKey : true
				});
			},

			modalOpen1 : function(gridData) {
				
				myModal.open({
					type : "GET",
					url : "/maa01/Maa01MonitorTradeUpdate_Popup.do",
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
				var item = myGrid.list[index];
				value = item;
				console.log(value);
				

				deleteValue = (value.SEQ_NO  + ',' +value.GUBN +  '!');
				

				$.ajax({
					type : 'get',
					url : "/maa01/deleteMonitorReport.json",
					data : deleteValue,
					dataType : '',
					success : function(res) {

						var item = {
							COMP_CODE : $("#COMP_CODE").val()
						}
						grid_ajax(item);
						/* grid_ajax3(item); */

					},
				});

			},

		};

		function chart_ajax() {
			var F_DATE = document.getElementById("REG_DATE").value;

			if (F_DATE != '') {

				$.ajax({
					type : 'get',
					url : "/maa01/maa01MonitorSoMae_Date.json",
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


		<%@ include file="/WEB-INF/jsp/admin/adminheader.jsp"%>

		<div class="hw_clear"></div>


		<div class="content_wrap">
			<!--네비와 컨텐츠 감싸는 부분-->

			<div class="navarea">
				<h1 class="logo">
					<img src="../../admin/images/logo.jpg" alt="aT화훼유통정보시스템 관리자" />
				</h1>

				<!-- menu -->
				
				 <input type="hidden"id="ANUM" />
				 <input type="hidden"id="GUBN" value="2"/>  <!--  GUBN2 = 거래동향보고서 -->
				 
				 
				 
				<%@ include file="/WEB-INF/jsp/admin/adminleft.jsp"%>


			</div>
			<div class="sub_contents">
				<div class="sub_contents_title">거래동향 보고서</div>

				<div class="real_contents">


					<div class="shipment_schedule_all3">
						<div class="shipment_schedule_title">
							<div class="half1_purple"></div>
							<span class="half_title_purple">월간거래동향보고서</span>
						</div>

					<%-- 	<div class="hw_infouse_01" id="pagesearch">
							<input type="text" name="REG_DATE" id="REG_DATE"
								class="AXInput W100" value="${REG_DATE}" />
						</div> --%>
						
						<div class="hw_clear"></div>
						<div class="hw_ma_grid2">
							<div id="AXGridTarget" style="height: 350px;"></div>
						</div>
					</div>
				<div class="right">
							<button type="button" class="AXButton" id="ax-grid-btn-add">
								<i class="axi axi-plus-circle"></i> 추가
							</button>
						
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



