<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, user-scalable=no">
	<title>모니터요원 입력시스템-발송이력관리</title>
	<!-- @@@@@@@@@@@@@@@@@@@@@@ css begin @@@@@@@@@@@@@@@@@@@@@@ -->
	 <link rel="stylesheet" type="text/css" href="<c:url value='/rMateChart/rMateChartH5/Assets/Css/rMateChartH5.css' />"/>   
	<link rel="stylesheet" type="text/css" href="<c:url value='/axisj/axicon/axicon.min.css' />" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/arongi/AXJ.min.css' />" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/hw/ma.css' />" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/hw/common.css' />" />
	 <!-- @@@@@@@@@@@@@@@@@@@@@@ css end   @@@@@@@@@@@@@@@@@@@@@@ --> 
  
	<script type="text/javascript" src="<c:url value='/axisj/jquery/jquery.min.js' />"></script>
	<script type="text/javascript" src="<c:url value='/axisj/dist/AXJ.min.js' />"></script>
	<script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/ax5-polyfill.js' />"></script>
	<script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/axjApp.js' />"></script>
	
	
	<!-- rMateChartH5 라이센스 시작 -->
	<script type="text/javascript" src="<c:url value='/rMateChart/LicenseKey/rMateChartH5License.js' />"></script>
	<!-- rMateChartH5 라이센스 끝-->  
	<!-- 실제적인 rMateChartH5 라이브러리 시작-->
	 <script type="text/javascript" src="<c:url value='/rMateChart/rMateChartH5/JS/rMateChartH5.js' />"></script>
	<!-- 실제적인 rMateChartH5 라이브러리 끝-->  
	<!-- rMateChartH5 테마 js -->
	<script type="text/javascript" src="<c:url value='/rMateChart/rMateChartH5/Assets/Theme/theme.js' />"></script>
	<!-- @@@@@@@@@@@@@@@@@@@@@@ css end   @@@@@@@@@@@@@@@@@@@@@@ -->
	
	<script type="text/javascript" src="<c:url value='/js/validation.js' />"></script>
	
	
<script type="text/javascript">
var myProgress = new AXProgress();
var myGrid = new AXGrid();
var myModal = new AXModal();

//데이터 입력
function grid_ajax(pageNo){   
	if(pageNo == null || pageNo == "") pageNo = 1;
	
	var $frm = $("#SearchFrm");
	$.ajax({
       type : 'post',
       url : "/mntr/mdd01/getLogList.json",
       data : "pageNumber=" + (pageNo) + "&pageSize=10"+"&" + $frm.serialize(),
       success : function(res){ 
    	   //console.log(res.list);
    	   if(res.error){
               alert(res.error.message);
           }else{
               var gridData = {
                   list: res.list,
                   page:{
                       pageNo: res.page.currentPage,
                       pageSize: res.page.pageSize,
                       pageCount: res.page.totalPages,
                       listCount: res.page.totalElements
                   }
               };
               myGrid.setData(gridData);
               
           }
         	
       },
   });      	    
};


//그리드 설정시작
var fnObj = {
	    pageStart: function(){
	    	grid_ajax();
	    	//fnObj.search.bind();
	    	
	    	myModal.setConfig({
                 windowID: "myModalCT",
                 width: 1020,
                 opendModalID: "myModalCT",
                 displayLoading: true,
                 onclose: function () {
                     //toast.push("모달 close");
                 }
          });
	    	myModal.setWidth("100%");
	    	
	    	myGrid.setConfig({
	             targetID : "AXGridTarget",
	             theme : "AXGrid",
	             fixedColSeq : '',
	             fitToWidth:false,
	             colGroup : [
					 {key:"SEQ", label:"발송아이디", width:"80", align:"center", pk:true},
	                 {key:"DEST", label:"수신자", width:"200", align:"center"}, 
	                 {key:"SUBJECT", label:"제목", width:"150", align:"center"},
	                 {key:"MSG_BODY", label:"내용", width:"*", align:"center"},
	                 {key:"SEND_TIME", label:"발송시간", width:"130", align:"center"},
	                 {key:"STATUS", label:"발송상태", width:"90", align:"center"},
	                 {key:"TYPE_NM", label:"구분", width:"100", align:"center"}
	             ],
	             colHeadAlign:"center",
	             body : {
	                 onclick: function(){  
	                	var $frm = $("#SearchFrm");
	                	console.log("this.item", this.item);
	                	//var gridData= "SEQ=" + this.item.USER_ID+"&"+$frm.serialize();
	                	var gridData= "SEQ=" + this.item.SEQ+"&TYPE="+ this.item.TYPE;
	                	fnObj.modalOpen(gridData);
	                 },
	             },
	             page: {
                   display: true,
                   paging: true,
                   pageNo:1,
                   pageSize:10,
                   onchange: function (pageNo) {
                      grid_ajax(pageNo);
                   }
               }
	         }); 
	    },//pageStart
	    modalOpen: function(gridData){
			myModal.open({    		 
				type: "GET",
				url:"/mntr/mdd01/pushLogDetail.do",				
				top:50,
				pars:("&"+gridData).queryToObject(),
				closeByEscKey:true
			});	
			myModal.setWidth("100%");
		},
	    
	};

$(document).ready(fnObj.pageStart);

</script>
</head>
<body>

<%@ include file="/WEB-INF/inc/IncHeader.jsp" %>

<article>
	<div class="wrap">
		<%@ include file="/WEB-INF/jsp/inc/IncMenu.jsp" %>
	
	
		<div class="hw_content"><!--컨텐츠 내용들어가는곳 시작-->
			<h3 class="hw_h3_ma"><!-- <div class="half1_white"></div> --><span class="half_title">발송이력관리</span></h3>
			<div class="hw_clear"></div>
		
			<div class="hw_infouse_01">
				<p><span class="purple"> ◎ 발송이력관리 :</span> 메일 및 카카오 메시지 전송이력</p>
			</div>

			<div style="width:100%; margin: 10px 0px;">
				<div class="selectWrap mt10">
					<div class="shipment_schedule_all">
						<div style="margin-bottom:10px; margin-top:10px;">	
							<form name="SearchFrm" id="SearchFrm" method="post" onsubmit="return false;">
								<ul class="titList2">
									<li class="th">검색 :</li>
									<li class="td">
										<label class="blind" for="searchWord">검색 입력</label>
										<input type="text" class="AXInput" name="searchWord" id="searchWord" value="" placeholder="수신자 검색" onkeypress="if( event.keyCode==13 ){grid_ajax(1);}" />
									</li>
									<li class="th">연도 :</li>
									<li class="td">
										<label class="blind" for="searchYear">연도 입력</label>
										<select id="searchYear" name="searchYear" onchange="grid_ajax(1);">
											<c:forEach begin="${nowYear - 50 }" end="${nowYear + 5 }" varStatus="num" step="1" >
												<option value="${num.index }" <c:if test="${nowYear eq num.index}">selected="selected"</c:if>>${num.index }년</option>
											</c:forEach>
										</select>
									</li>
									<li class="th">월 :</li>
									<li class="td">
										<label class="blind" for="searchMonth">월 선택</label>
										<select id="searchMonth" name="searchMonth" onchange="grid_ajax(1);">
											<option value="01" <c:if test="${nowMon eq '01' }">selected="selected"</c:if>>01월</option>
											<option value="02" <c:if test="${nowMon eq '02' }">selected="selected"</c:if>>02월</option>
											<option value="03" <c:if test="${nowMon eq '03' }">selected="selected"</c:if>>03월</option>
											<option value="04" <c:if test="${nowMon eq '04' }">selected="selected"</c:if>>04월</option>
											<option value="05" <c:if test="${nowMon eq '05' }">selected="selected"</c:if>>05월</option>
											<option value="06" <c:if test="${nowMon eq '06' }">selected="selected"</c:if>>06월</option>
											<option value="07" <c:if test="${nowMon eq '07' }">selected="selected"</c:if>>07월</option>
											<option value="08" <c:if test="${nowMon eq '08' }">selected="selected"</c:if>>08월</option>
											<option value="09" <c:if test="${nowMon eq '09' }">selected="selected"</c:if>>09월</option>
											<option value="10" <c:if test="${nowMon eq '10' }">selected="selected"</c:if>>10월</option>
											<option value="11" <c:if test="${nowMon eq '11' }">selected="selected"</c:if>>11월</option>
											<option value="12" <c:if test="${nowMon eq '12' }">selected="selected"</c:if>>12월</option>
										</select>
									</li>
								</ul>
							</form>
						</div>
					</div>
				</div>
			</div>
			<div class="hw_clear"></div>
			<div class="hw_ma_grid">
				<div id="AXGridTarget" style="height: 425px;"></div>
			</div>
		</div>
		<!--// hw_content -->
	</div>
	<!--// wrap-->
</article>

	<div class="hw_clear"></div>
	<footer>
		<%@ include file="/WEB-INF/inc/IncFooter.jsp" %>
	</footer>
</body>
</html>




