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
<title>모니터요원 정보 변경이력 </title>
<!-- @@@@@@@@@@@@@@@@@@@@@@ css begin @@@@@@@@@@@@@@@@@@@@@@ -->
<link rel="stylesheet" type="text/css" href="<c:url value='/rMateChart/rMateChartH5/Assets/Css/rMateChartH5.css' />"/>   
<link rel="stylesheet" type="text/css" href="<c:url value='/axisj/axicon/axicon.min.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/arongi/AXJ.min.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/hw/ma.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/hw/common.css' />" />
<!-- @@@@@@@@@@@@@@@@@@@@@@ css end   @@@@@@@@@@@@@@@@@@@@@@ --> 

<script type="text/javascript" src="<c:url value='/axisj/jquery/jquery.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/axisj/dist/AXJ.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/axisj/lib/AXUpload5.js' />"></script>
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
  
  
<script type="text/javascript">
	var myProgress = new AXProgress();
	var myGrid = new AXGrid();
	var myModal = new AXModal();
	
	// 데이터 입력
	function grid_ajax(pageNo){   
		if(pageNo == null || pageNo == "") pageNo = 1;
		
		var $frm = $("#userLogSearchFrm");
		$.ajax({
	       type : 'post',
	       url : "/mntr/mdb01/gridList2.json",
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
	
	// 그리드 설정시작
	var fnObj = {
		    pageStart: function(){
		    	grid_ajax();
		    	//fnObj.search.bind();
		    	
		    	myGrid.setConfig({
    	             targetID : "AXGridTarget",
    	             theme : "AXGrid",
    	             fixedColSeq : '',
    	             fitToWidth:false,
    	             colGroup : [
						 {key:"USER_LOG_TYPE", label:"구분", width:"80", align:"center", pk:true},
    	                 {key:"USER_ID", label:"아이디", width:"150", align:"center", pk:true}, 
    	                 {key:"USER_NM", label:"이름", width:"150", align:"center"},
    	                 {key:"COMP_CODE", label:"법인코드", width:"80", align:"center"},
    	                 {key:"MOB", label:"휴대폰", width:"80", align:"center"},
    	                 {key:"BANK_NUM", label:"계좌번호", width:"150", align:"center"},
    	                 {key:"MONITOR_TYPE", label:"생산/소비", width:"100", align:"center"},
    	                 {key:"INS_DT", label:"등록일", width:"100", align:"center"},
    	                 {key:"INS_ID", label:"등록자ID", width:"100", align:"center"}
    	             ],
    	             colHeadAlign:"center",
    	             body : {
    	                 onclick: function(){  
    	                	 //console.log("thisItem", this.item);
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
		    }//pageStart
		   /*  search: {
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
									{label:"생산/소비", labelWidth:"80", type:"selectBox", width:"100", key:"searchType", addClass:"", valueBoxStyle:"", value:"0",
										options:[
											{optionValue:"0", optionText:"전체"},
											{optionValue:"1", optionText:"생산"},
											{optionValue:"2", optionText:"소비"}
									    ],
										AXBind:{
											type:"select", config:{
												onchange:function(){
													grid_ajax(1);
												}
											}
										}
									},
									{label:"로그구분", labelWidth:"80", type:"selectBox", width:"100", key:"searchLogType", addClass:"", valueBoxStyle:"", value:"0",
										options:[
											{optionValue:"0", optionText:"전체"},
											{optionValue:"1", optionText:"등록"},
											{optionValue:"2", optionText:"수정"},
											{optionValue:"3", optionText:"삭제"}
									    ],
										AXBind:{
											type:"select", config:{
												onchange:function(){
													grid_ajax(1);
												}
											}
										}
									},
									{label:"아이디", labelWidth:"80", type:"inputText", width:"100", key:"searchWord", addClass:"", valueBoxStyle:"padding-left:10px;", value:"",
										onChange: function(changedValue){
											grid_ajax(1);
										}
									}
	                           ]}
	                    ]
	                });
	            },
	            submit: function(){
	              
	            }
	        } */
		    
		};

	$(document).ready(fnObj.pageStart);

</script>

</head>
<body>

<article>
<div>
	<div class="ma_content"><!--컨텐츠 내용들어가는곳 시작-->
		<div>
			<h4 class="hw_h3_ma_01" >모니터요원 정보변경이력</h4> 
		</div>
		<div class="ax_searchWrap">
			<div style="margin-bottom:10px; margin-top:10px;">	
				<form name="userLogSearchFrm" id="userLogSearchFrm" method="post" onsubmit="return false;">
					<ul class="titList3">
						<li class="th">생산/소비 :</li>
						<li class="td">
							<label class="blind" for="userPasswd">생산/소비</label>
							<select name="searchType" id="searchType" onchange="grid_ajax(1);">
								<option value="0">전체</option>
								<option value="1">생산</option>
								<option value="2">소비</option>
							</select>
						</li>
						<li class="th">로그 구분 :</li>
						<li class="td">
							<label class="blind" for="searchLogType">로그 구분</label>
							<select name="searchLogType" id="searchLogType" onchange="grid_ajax(1);" >
								<option value="0">전체</option>
						 		<option value="1">등록</option>
						 		<option value="2">수정</option>
						 		<option value="3">삭제</option>
						 	</select>
						</li>
						<li class="th">아이디 :</li>
						<li class="td">
							<label class="blind" for="searchWord">아이디 입력</label>
							<input type="text" class="AXInput" name="searchWord" id="searchWord" value="" onkeypress="if( event.keyCode==13 ){grid_ajax(1);}" />
						</li>
					</ul>
				</form>
			</div>
	 	</div>
		<div class="hw_ma_grid" style="margin-bottom: 20px;">
			<div id="AXGridTarget" style="height: 400px;"></div>
		</div>
	</div>
</div>
</article>

</body>
</html>