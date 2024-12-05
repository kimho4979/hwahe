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
	<title>모니터요원 입력시스템-모니터요원 관리</title>
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
	var chulno = "0001"
	var myProgress = new AXProgress();
	var myGrid = new AXGrid();
	var myModal = new AXModal();
	var defaultHtml = "";

	// 데이터 입력
	function grid_ajax(pageNo){   
		if(pageNo == null || pageNo == "") pageNo = 1;
		
		var $frm = $("#userSearchFrm");
		$.ajax({
	       type : 'post',
	       url : "/mntr/mdb01/gridList.json",
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
		    	CHUL_NO="${SESSION_CMP_CODE}";
		    	grid_ajax();
		    	defaultHtml = $("#manageDiv").html();
		    	//fnObj.search.bind();
		    	
		    	myModal.setConfig({
                    windowID: "myModalCT",
                    width: 1020,
                    displayLoading: true,
                    onclose: function () {
                        //toast.push("모달 close");
                    }
                });
		    	myModal.setWidth("100%");
		    	
		    	myGrid.setConfig({
    	             targetID : "AXGridTarget",
    	             theme : "AXGrid",
    	             //fixedColSeq : '',
    	             fitToWidth:false,
    	             colGroup : [
    	                {
    	                    key:"USER_ID", label:"checkbox", width:"30", align:"center", formatter:"checkbox", pk:true,
    	                    disabled:function(){
    	                        return false;
    	                        return (this.index % 2 != 0);
    	                    },
    	                    checked:function(){
    	                        return false;
    	                        return (this.index % 2 == 0);
    	                    }
    	                },
    	                {key:"USER_ID2", label:"아이디", width:"100", align:"center", pk:true}, 
    	                {key:"USER_NM", label:"이름", width:"100", align:"center"},
    	                {key:"COMP_CODE", label:"법인코드", width:"80", align:"center"},
    	                {key:"MONITOR_TYPE", label:"생산/소비/공통", width:"100", align:"center"},
    	                {key:"MOB", label:"전화번호", width:"120", align:"center"},
    	                {key:"BANK_NUM", label:"계좌번호", width:"160", align:"left"},
    	                {key:"BANK_CODE", label:"은행코드", width:"150", align:"center"},
    	                {key:"USE_YN", label:"사용여부", width:"*", align:"center"}
    	             ],
    	             colHeadAlign:"center",
    	             body : {
    	                 onclick: function(){  
    	                	 $.ajax({
    	    		             type : 'post',
    	    		             url : "/mntr/mdb01/updateUserInput.do",
    	    		             data :{
    	    		            	 USER_ID : this.item.USER_ID
    	    		             },
    	    		             success : function(res){                   	 
    	    		            	 $("#manageDiv").html(res);
    	    		             },
    	    		         }); 
    	                	 
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
									{label:"검색", labelWidth:"80", type:"inputText", width:"150", placeholder:"아이디, 요원명 검색" ,key:"searchWord", addClass:"", valueBoxStyle:"padding-left:10px;", value:"",
										onChange: function(changedValue){
											grid_ajax(1);
										}
									},                                       
									{label:"법인코드", labelWidth:"80", type:"inputText", width:"150" ,key:"searchCode", addClass:"", valueBoxStyle:"padding-left:10px;", value:"",
										onChange: function(changedValue){
											grid_ajax(1);
										}
									},
	                           ]}
	                    ]
	                });
	            },
	            submit: function(){
	              
	            }
	        }, */
		    modalOpen: function(){
				myModal.open({    		 
					type: "GET",
					url:"/mntr/mda01/userInfoLogView.do",				
					top:50,
					pars:"",
					closeByEscKey:true
				});	
				myModal.setWidth("100%");
			},
		    getCheckedList: function(){
			    
		         var checkedList = myGrid.getCheckedList(0);// colSeq
		         
		         if(checkedList.length == 0){
		             alert("선택된 목록이 없습니다. 삭제하시려는 목록을 체크하세요");    
		             return;
		         }
		        
		         if(!confirm("정말 삭제 하시겠습니까?")) return;        	
		        	 var obj2=checkedList;
		             var deleteValue = "";
		         $.each(obj2,function(num,value) {
		         	//alert('key:'+key+', REG_DATE:'+value.REG_DATE+',CHUL_NO2:'+value.CHUL_NO2+',MONTH_GUBN'+value.MONTH_GUBN);
		         	if(num == (obj2.length-1)){
		         		deleteValue += value.USER_ID;
		         	}else{
		         		deleteValue += value.USER_ID+',';
		         	}
		         	
		         });          
		         $.ajax({
		             type : 'post',
		             url : "/mntr/mdb01/deleteUserInput.json",
		             data :{
		            	 deleteValue : deleteValue
		             },
		             dataType : '',   	           
		             success : function(res){                   	 
						//console.log(res);
						if(res.error){
							alert(res.error.message);
						}else{
							alert(res.result.message);
							grid_ajax(1);
						}          	 
		             },
		         }); 
		         
		     },
		};

	$(document).ready(fnObj.pageStart);
	
	
	// 생산정보 등록
	function inputUserData($frm){
		/* if(!handPhoneChk($frm.find("input[name=mob]").val())){
			alert("잘못된 형식의 휴대폰번호입니다.");
			$frm.find("input[name=mob]").focus();
			return false;
		} */
		
		if(!confirm("등록 하시겠습니까?")) return false;
		
		
		
		$.ajax({
	          type : 'post',
	          url : "/mntr/mdb01/UserInputProc.json",
	          data : $frm.serialize(),
	          success : function(res){               
	        	   if(res.error){
	                   alert(res.error.message);
	               }else{
	            	   alert(res.result.message);
	            	   
	            	   if(res.result.stat == "2"){
	            		   $("#manageDiv").html(defaultHtml); 
		            	   grid_ajax(1);   
	            	   }
	            	   
	               }
	          },
		});
		
		return false;
	}
	
	// 설정 데이터 삭제
	function deleteUserData(){
		fnObj.getCheckedList();
	}
	
	// 카카오톡 재발송
	function sendKakao(){
		var $frm = $("#userSearchFrm");
		if(!confirm("카카오톡 발송이 처리됩니다. 발송 하시겠습니까?")) return false;
		$.ajax({
	          type : 'post',
	          url : "/mntr/mdc01/sendKakao.json",
	          data : $frm.serialize(),
	          success : function(res){               
	        	   if(res.error){
	                   alert(res.error.message);
	               }else{
	            	   alert(res.result.message);
	            	   if(res.result.stat == "2"){
	            		   //grid_ajax(1);   
	            	   }
	               }
	          },
		});
		return false;
	}
	
	// 수정창에서 기존 등록창 호출
	function defaultFrm(){
		$("#manageDiv").html(defaultHtml); 
	}
	
	// 변경이력 모달 호출
	function userInfoLogView(){
		fnObj.modalOpen();
		$(window).scrollTop(0);
	}
	
	
</script>
</head>
<body>

<%@ include file="/WEB-INF/inc/IncHeader.jsp" %>

<article>
	<div class="wrap">
		<%@ include file="/WEB-INF/jsp/inc/IncMenu.jsp" %>
	
	
		<div class="hw_content"><!--컨텐츠 내용들어가는곳 시작-->
			<h3 class="hw_h3_ma"><!-- <div class="half1_white"></div> --><span class="half_title">모니터요원 관리</span></h3>
			<div class="hw_clear"></div>
		
			<div class="hw_infouse_01">
				<p><span class="purple"> ◎ 정산정보 관리 :</span> 정산정보에 대한 지표 별 관리</p>
			</div>
			
			<div id="manageDiv" style="width:100%; margin: 10px 0px;">
				<div class="selectWrap mt10">
					<form id="userFrm" name="userFrm" method="post" onsubmit="return inputUserData($(this));">
						<div style="margin-bottom: 10px;">
							<ul class="titList">
								<li class="th">아이디 : </li>
								<li class="td">
									<label class="blind" for="userId">아이디</label>
									<input type="text" name="userId" id="userId" value="" required="required" class="AXInput">
								</li>
								<li class="th">이름 : </li>
								<li class="td">
									<label class="blind" for="userNm">이름</label>
									<input type="text" name="userNm" id="userNm" value="" required="required" class="AXInput">
								</li>
								<li class="th">비밀번호 : </li>
								<li class="td">
									<label class="blind" for="userPasswd">비밀번호</label>
									<input type="password" name="userPasswd" id="userPasswd" value="" autocomplete="off" required="required" class="AXInput">
								</li>
								<li class="th bbNo">생산/소비 선택 : </li>
								<li class="td bbNo">
									<label class="blind" for="monitorType">생산/소비 선택</label>
									<select id="monitorType" name="monitorType" class="titSelect2">
										<option value="P">생산</option>
										<option value="C">소비</option>
										<option value="A">공통</option>
									</select>
								</li>
								<li class="th bbNo">사용여부 선택 : </li>
								<li class="td bbNo">
									<label class="blind" for="useYn">생산/소비 선택</label>
									<select id="useYn" name="useYn" class="titSelect2">
										<option value="Y">사용</option>
										<option value="N">미사용</option>
									</select>
								</li>
							</ul><!-- titList end  -->
						</div>
						<div style="margin-bottom: 10px;">
							<ul class="titList2">
								<li class="th blNo">법인코드 : </li>
								<li class="td">
									<label class="blind" for="compCode">법인코드 입력</label>
									<input type="text" name="compCode" id="compCode" value="" required="required" maxlength="10" class="AXInput noKorean">
								</li>
								<li class="th">휴대폰번호 입력 : </li>
								<li class="td">
									<label class="blind" for="mob">휴대폰번호 입력</label>
									<input type="text" name="mob" id="mob" value="" class="AXInput onlyNum" placeholder="'-' 을 제외한 번호">
								</li>
								<li class="th bbNo">은행 및 계좌번호 입력 : </li>
								<li class="td bbNo">
									<label class="blind" for="bankNum">은행 및 계좌번호 입력</label>
									<input type="text" name="bankNum" id="bankNum" value="" class="AXInput">
								</li>
								<li class="th bbNo">은행코드 입력 : </li>
								<li class="td bbNo">
									<label class="blind" for="bankCode">은행 및 계좌번호 입력</label>
									<input type="text" name="bankCode" id="bankCode" value="" class="AXInput">
								</li>
							</ul><!-- titList end  -->
							<div class="btnWrap">
								<button type="submit" id="btnType" class="ma_add_2">등록하기</button>
							</div>
						</div>
					</form>
				</div>
			</div>
			<div style="width:100%; margin: 10px 0px;">
				<div class="selectWrap mt10">
					<form name="userSearchFrm" id="userSearchFrm" method="post" onsubmit="return false;">
						<ul class="titList3">
							<li class="th">검색 :</li>
							<li class="td">
								<label class="blind" for="searchWord">검색 입력</label>
								<input type="text" class="AXInput" name="searchWord" id="searchWord" value="" placeholder="아이디, 요원명 검색" onkeypress="if( event.keyCode==13 ){grid_ajax(1);}" />
							</li>
							<li class="th">법인코드 :</li>
							<li class="td">
								<label class="blind" for="searchCode">법인코드 입력</label>
								<input type="text" class="AXInput" name="searchCode" id="searchCode" value="" onkeypress="if( event.keyCode==13 ){grid_ajax(1);}" />
							</li>
						</ul>
					</form>
				</div>
			</div>
			<div class="hw_clear"></div>
			
			<div class="hw_ma_grid">
				<div id="AXGridTarget" style="height: 430px;"></div>
			</div>
			<div style="width:100%; margin: 10px 0px;">
				<button type="button" onclick="deleteUserData();" class="delBtn">삭제</button>
				<button type="button" onclick="sendKakao();" class="kakaoBtn">카카오톡재발송</button>
				<button type="button" onclick="userInfoLogView();" class="addBtn" style="width: 100px;float: right;">변경이력</button>
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

