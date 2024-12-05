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
	<title>모니터요원 입력시스템-정산내역</title>
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
	
	var $frm = $("#calSearchFrm");
	$.ajax({
       type : 'post',
       url : "/mntr/mdc01/gridList.json",
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
					 {key:"USER_ID", label:"아이디", width:"100", align:"center", pk:true},
	                 {key:"USER_NM", label:"모니터요원명", width:"100", align:"center"},
	                 {key:"MONITOR_TYPE", label:"구분", width:"50", align:"center"},
	                 {key:"CNT1", label:"계량", width:"50", align:"center"},
	                 {key:"CNT2", label:"비계량", width:"55", align:"center"},
	                 {key:"SUM1", label:"계량(합)", width:"60", align:"center"},
	                 {key:"SUM2", label:"비계량(합)", width:"80", align:"center"},
	                 {key:"TOT_SUM", label:"총계", width:"100", align:"center"},
	                 {key:"BANK_NUM", label:"계좌번호", width:"180", align:"left"},
	                 {key:"BANK_CODE", label:"은행코드", width:"*", align:"left"},
	             ],
	             colHead : {
		                heights: [30,30],
	                    rows: [
	                        [
	                            {key:"USER_ID", rowspan:2, align:"center", valign:"middle"},
	                            {key:"USER_NM", rowspan:2, align:"center", valign:"middle"},
	                            {key:"MONITOR_TYPE", rowspan:2, align:"center", valign:"middle"},
	                            {colspan:2, label:"건수", align:"center", valign:"middle"},
	                            {colspan:2, label:"누계(금액)", align:"center", valign:"middle"},
	                            {key:"TOT_SUM", rowspan:2, align:"center", valign:"middle"},
	                            {key:"BANK_NUM", rowspan:2, align:"center", valign:"middle"},
	                            {key:"BANK_CODE", rowspan:2, align:"center", valign:"middle"},
	                        ],
	                        [
	                            {key:"CNT1"},
	                            {key:"CNT2"},
	                            {key:"SUM1"},
	                            {key:"SUM2"}
	                        ]
	                    ]
	             },
	             colHeadAlign:"center",
	             body : {
	                 onclick: function(){  
	                	//console.log("thisItem", this.item);
	                	var $frm = $("#calSearchFrm");
	                	var gridData= "USER_ID=" + this.item.USER_ID+"&"+$frm.serialize();
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
	    /* search: {
            target: new AXSearch(),
            bind: function(){
            	fnObj.search.target.setConfig({
                    targetID:"page-search-box",
                    theme : "AXSearch",
                    mediaQuery: {
                        mx:{min:0, max:767}, dx:{min:767}
                    },
                    onsubmit: function(){
                        // 버튼이 선언되지 않았거나 submit 개체가 있는 경우 발동 합니다.
                    	fnObj.search.submit();
                    },
                    rows:[
                           {display:true, addClass:"", style:"", list:[
								{label:"검색", labelWidth:"80", type:"inputText", width:"200", placeholder:"아이디, 모니터요원명 검색" ,key:"searchWord", addClass:"", valueBoxStyle:"padding-left:10px;", value:"",
									onChange: function(changedValue){
										grid_ajax(1);
									}
								},                                       
          						
								{label:"연도", labelWidth:"80", type:"selectBox", width:"100", key:"searchYear", addClass:"", valueBoxStyle:"", value:"${nowYear}",
									options:[
										<c:forEach begin="${nowYear - 50 }" end="${nowYear + 5 }" varStatus="num" step="1" >	
											{optionValue:"${num.index }", optionText:"${num.index }년"}<c:if test="${not num.last}" >,</c:if>
										</c:forEach>
								    ],
									AXBind:{
										type:"select", config:{
											onchange:function(){
												grid_ajax(1);
											},
										}
									}
								},
								{label:"월", labelWidth:"80", type:"selectBox", width:"100", key:"searchMonth", addClass:"", valueBoxStyle:"", value:"${nowMon}",
									options:[
										{optionValue:"01", optionText:"01월"},
										{optionValue:"02", optionText:"02월"},
										{optionValue:"03", optionText:"03월"},
										{optionValue:"04", optionText:"04월"},
										{optionValue:"05", optionText:"05월"},
										{optionValue:"06", optionText:"06월"},
										{optionValue:"07", optionText:"07월"},
										{optionValue:"08", optionText:"08월"},
										{optionValue:"09", optionText:"09월"},
										{optionValue:"10", optionText:"10월"},
										{optionValue:"11", optionText:"11월"},
										{optionValue:"12", optionText:"12월"}
								    ],
									AXBind:{
										type:"select", config:{
											onchange:function(){
												grid_ajax(1);
											},
										}
									}
								}
								
                           ]}
                    ]
                });
            },
            submit: function(){
              
            }
        }, */
	    modalOpen: function(gridData){
			myModal.open({    		 
				type: "GET",
				url:"/mntr/mdc01/calculateInfo.do",				
				top:50,
				pars:("&"+gridData).queryToObject(),
				closeByEscKey:true
			});	
			myModal.setWidth("100%");
		},
	    
	};

$(document).ready(fnObj.pageStart);

// 모달 리사이즈
function modalResize(changeHeight) {
	//alert("test" + changeHeight);
	$("#myModalCT .windowbox").css("height",changeHeight);
	$("#myModalCT iframe").css("height",changeHeight);
}

// 정산내역 인쇄하기
function printMdc01(){
	var cForm = document.calSearchFrm;
	var url = "/mntr/mdc01/print.do";
	window.open("/mntr/mdc01/print.do" ,"popForm", "toolbar=no, width=1087, height=595, directories=no, status=no, scrollorbars=yes, resizable=no"); 
	cForm.action =url; 
	cForm.method="post";
	cForm.target="popForm";
	cForm.testVal = 'test';
	cForm.submit();

}

	
</script>
</head>
<body>

<%@ include file="/WEB-INF/inc/IncHeader.jsp" %>

<article>
	<div class="wrap">
		<%@ include file="/WEB-INF/jsp/inc/IncMenu.jsp" %>
	
	
		<div class="hw_content"><!--컨텐츠 내용들어가는곳 시작-->
			<h3 class="hw_h3_ma"><!-- <div class="half1_white"></div> --><span class="half_title">정산내역</span></h3>
			<div class="hw_clear"></div>
		
			<div class="hw_infouse_01">
				<p><span class="purple"> ◎ 정산정보 관리 :</span> 정산정보에 대한 지표 별 관리</p>
			</div>

			<div style="width:100%; margin: 10px 0px;">
				<div class="selectWrap mt10">
					<div class="shipment_schedule_all">
						<div style="margin-bottom:10px; margin-top:10px;">	
							<form name="calSearchFrm" id="calSearchFrm" method="post" onsubmit="return false;">
								<ul class="titList2">
									<li class="th">검색 :</li>
									<li class="td">
										<label class="blind" for="searchWord">검색 입력</label>
										<input type="text" class="AXInput" name="searchWord" id="searchWord" value="" placeholder="아이디, 요원명 검색" onkeypress="if( event.keyCode==13 ){grid_ajax(1);}" />
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
				<div id="AXGridTarget" style="height: 450px;"></div>
			</div>
			<div style="width:100%; margin: 10px 0px;">
				<button type="button" onclick="printMdc01();" class="addBtn" style="width: 100px;float: right;">인쇄하기</button>
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