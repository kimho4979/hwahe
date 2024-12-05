<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%   
   if (request.getParameter("regDate")==null){
    request.setAttribute("pageTitle", "작황동향 등록"); 
    String chulNo=(String)session.getAttribute("SESSION_CMP_CODE");
    request.setAttribute("chulNo", chulNo);
    request.setAttribute("goodName", "비탈");
    request.setAttribute("pageopen", "");
    request.setAttribute("pageopen2", "display:none");            
  }else{
    request.setAttribute("pageTitle", "작황동향 수정");
    request.setAttribute("pageopen", "display:none");
    request.setAttribute("pageopen2", "");
    request.setAttribute("pagecheck", "1");
    request.setAttribute("regDate", request.getParameter("regDate"));
    request.setAttribute("chulNo", request.getParameter("chulNo"));
    request.setAttribute("goodName", request.getParameter("goodName"));
    request.setAttribute("status", request.getParameter("status"));
    request.setAttribute("bigo", request.getParameter("bigo"));   
    request.setAttribute("seqNo", request.getParameter("seqNo"));
    request.setAttribute("STORED_FILE_NAME", request.getParameter("STORED_FILE_NAME"));
    request.setAttribute("ORIGINAL_FILE_NAME", request.getParameter("ORIGINAL_FILE_NAME"));
  }   
%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, user-scalable=no">
<title>작황정보 입력창 </title>
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
  <script type="text/javascript" src="<c:url value='/js/mobile/common/jquery.form.js' />"></script>
  <!-- rMateChartH5 라이센스 시작 -->
  <script type="text/javascript" src="<c:url value='/rMateChart/LicenseKey/rMateChartH5License.js' />"></script>
  <!-- rMateChartH5 라이센스 끝-->  
  <!-- 실제적인 rMateChartH5 라이브러리 시작-->
   <script type="text/javascript" src="<c:url value='/rMateChart/rMateChartH5/JS/rMateChartH5.js' />"></script>
  <!-- 실제적인 rMateChartH5 라이브러리 끝-->
  <!-- rMateChartH5 테마 js -->
  <script type="text/javascript" src="<c:url value='/rMateChart/rMateChartH5/Assets/Theme/theme.js' />"></script>
  <!-- @@@@@@@@@@@@@@@@@@@@@@ css end   @@@@@@@@@@@@@@@@@@@@@@ --> 
  
  
   <style type="text/css">
        .modalProgramTitle{
            height:49px;line-height:49px;
            color:#282828;font-size:14px;font-weight:bold;
            padding-left:15px;
            border-bottom:1px solid #ccc;
        }
        .modalButtonBox{
            padding:10px;border-top:1px solid #ccc;
        }
    </style>

<script type="text/javascript">
	var myProgress = new AXProgress();      
    var myModal = new AXModal();
	var myUpload = new AXUpload5();
	var selectedVal = null;
	
	function checkData(){
		// 일자
		if($('#regDate').val() == '')
		{
			alert('조사일자를 선택하세요');
			return false;
		}
		
		// 작황정보
		if($('input:radio[name=status]:checked').val() == undefined)
		{
			alert('작황정보(전년대비)를 선택하세요');
			return false;
		}
		
		// 일조량
		if($('input:radio[name=statSun]:checked').val() == undefined)
		{
			alert('일조량를 선택하세요');
			return false;
		}
		
		// 기후
		if($('input:radio[name=statClimate]:checked').val() == undefined)
		{
			alert('기후를 선택하세요');
			return false;
		}
		
		if($("#ORIGINAL_FILE_NAME").val()==''){
			// 작황사진
			if($('#input_file').val() == '')
			{
				alert('작황사진을 선택하세요');
				return false;
			}	
		}
		return true;
	}
	
    var fnObj = {
        pageStart: function(){
        	
        	$.ajax({
           		type : "post",
           		url : "/mdc01/selectDeadLineDate.json",
           		data : {
           		},
           		dataType : '',
           		success : function(res){
           			//res.result.deadlineDate
           			var d = new Date();
           			var thisYear = d.getFullYear();
           			var thisMonth = (d.getMonth() + 1);
           			var thisDay = d.getDate();
           			
           			if(res.result.deadlineGubn=='this'){
           				// 이번달
           				
           				if('${pagecheck}' != "1" ){
    	           			if(thisDay>res.result.deadlineDate){
    	           				alert(thisMonth+"월 작황동향은 마감되었습니다.\n다음달 작황동향을 등록해주세요.");
    	           				
    	           				thisMonth = thisMonth+1;
    	           				if(thisMonth<10){
    	           					thisMonth = "0" + thisMonth;
    	           				}
    	           				
    	           				if(thisMonth == "13"){
    	           					thisMonth = "01";
    	           					thisYear = thisYear+1;
    	           				}
    	           				
    	           				$("#regDate").bindDate({align:"right", valign:"bottom", separator:"-", selectType:"d",  defaultSelectType:"d", minDate: thisYear+"-"+thisMonth+"-01",
    	           		        	onchange:function(){
    	           		        		var stDate = thisYear+"-"+thisMonth+"-01";
    	           		        		if($("#regDate").val().replace(/-/gi,"") <  stDate.replace(/-/gi,"")){
    	           		        			$("#regDate").val(thisYear+"-"+thisMonth+"-01");
    	           		        		}
    	           		            }
    	           		        	}); 
    	           			}else{
    	           				if(thisMonth<10){
    	           					thisMonth = "0" + thisMonth;
    	           				}
    	           				
    	           				$("#regDate").bindDate({align:"right", valign:"bottom", separator:"-", selectType:"d",  defaultSelectType:"d", minDate: thisYear+"-"+thisMonth+"-01",
    	           		        	onchange:function(){
    	           		        		var stDate = thisYear+"-"+thisMonth+"-01";
    	           		        		if($("#regDate").val().replace(/-/gi,"") <  stDate.replace(/-/gi,"")){
    	           		        			$("#regDate").val(thisYear+"-"+thisMonth+"-01");
    	           		        		}
    	           		            }
    	           		        	});
    	           			}
               			}else{
               				var regDate = $("#regDate").val();
               				var regYear = regDate.substring(0,4);
               				var regMonth = regDate.substring(5,7);
               				
               				$("#regDate").bindDate({align:"right", valign:"bottom", separator:"-", selectType:"d",  defaultSelectType:"d", minDate: regYear+"-"+regMonth+"-01", maxDate: regYear+"-"+regMonth+"-31",
               		        	onchange:function(){
               		        		var stDate = regYear+"-"+regMonth+"-01";
               		        		if($("#regDate").val().replace(/-/gi,"") <  stDate.replace(/-/gi,"")){
               		        			$("#regDate").val(regYear+"-"+regMonth+"-01");
               		        		}
               		        		
               		        		var enDate = regYear+"-"+regMonth+"-31";
               		        		if($("#regDate").val().replace(/-/gi,"") >  enDate.replace(/-/gi,"")){
               		        			$("#regDate").val(regDate);
               		        		}
               		            }
               		        	}); 
               			}
           			}else{
           				if('${pagecheck}' != "1" ){
           					
           					if(thisDay>res.result.deadlineDate){
    	           				// 오늘이 마감일보다 클경우
    	           				thisMonth = thisMonth;	
    	           				$("#regMonth").attr("disabled","disabled");
    	           			}else{
    	           				thisMonth = thisMonth;
    	           				$("#regMonth").removeAttr("disabled");
    	           			}
           					
    	           			if(thisDay>res.result.deadlineDate){
    	           				alert((thisMonth-1)+"월 작황동향은 마감되었습니다.\n"+(thisMonth)+"월 작황동향을 등록해주세요.");
    	           				thisMonth = thisMonth;
    	           				if(thisMonth<10){
    	           					thisMonth = "0" + thisMonth;
    	           				}
    	           				
    	           				if(thisMonth == "13"){
    	           					thisMonth = "01";
    	           					thisYear = thisYear+1;
    	           				}
    	           				
    	           				$("#regDate").bindDate({align:"right", valign:"bottom", separator:"-", selectType:"d",  defaultSelectType:"d", minDate: thisYear+"-"+thisMonth+"-01",
    	           		        	onchange:function(){
    	           		        		var stDate = thisYear+"-"+thisMonth+"-01";
    	           		        		if($("#regDate").val().replace(/-/gi,"") <  stDate.replace(/-/gi,"")){
    	           		        			$("#regDate").val(thisYear+"-"+thisMonth+"-01");
    	           		        		}
    	           		            }
    	           		        	}); 
    	           			}else{
    	           				var agoMonth=thisMonth-1;
    	           				if(agoMonth<10){
    	           					agoMonth = "0" + agoMonth;
    	           				}
    	           				if(thisMonth<10){
    	           					thisMonth = "0" + thisMonth;
    	           				}
    	           				
    	           				$("#regDate").bindDate({align:"right", valign:"bottom", separator:"-", selectType:"d",  defaultSelectType:"d", minDate: thisYear+"-"+agoMonth+"-01",
    	           		        	onchange:function(){
    	           		        		var stDate = thisYear+"-"+thisMonth+"-01";
    	           		        		if($("#regDate").val().replace(/-/gi,"") <  stDate.replace(/-/gi,"")){
    	           		        			$("#regDate").val(thisYear+"-"+thisMonth+"-01");
    	           		        		}
    	           		            }
    	           		        	});
    	           			}
               			}else{
               				var regDate = $("#regDate").val();
               				var regYear = regDate.substring(0,4);
               				var regMonth = regDate.substring(5,7);
               				
               				$("#regDate").bindDate({align:"right", valign:"bottom", separator:"-", selectType:"d",  defaultSelectType:"d", minDate: regYear+"-"+regMonth+"-01", maxDate: regYear+"-"+regMonth+"-31",
               		        	onchange:function(){
               		        		var stDate = regYear+"-"+regMonth+"-01";
               		        		if($("#regDate").val().replace(/-/gi,"") <  stDate.replace(/-/gi,"")){
               		        			$("#regDate").val(regYear+"-"+regMonth+"-01");
               		        		}
               		        		
               		        		var enDate = regYear+"-"+regMonth+"-31";
               		        		if($("#regDate").val().replace(/-/gi,"") >  enDate.replace(/-/gi,"")){
               		        			$("#regDate").val(regDate);
               		        		}
               		            }
               		        	}); 
               			}
           			}           			
           		}
           	});
        	
        		        	        	        	        	        	        
        	
        	var kind="";
        	
        	if('${result.goodName}'!=''){
        		$('#goodName').val("${result.goodName}");
            	$('#pumName').val("${result.pumName}");
            	$('#uniqueColor').val("${result.uniqueColor}");
            	$('#statColor').val("${result.statColor}");
            	$('#statInsectYn').val("${result.statInsectYn}");
            	if('${result.statInsectKind}' != ''){
	            	kind = "${result.statInsectKind}";        		
            	}
            	$("input:radio[name='status']:radio[value='${result.status}']").attr("checked",true);
            	$("input:radio[name='statSun']:radio[value='${result.statSun}']").attr("checked",true);
            	$("input:radio[name='statSize']:radio[value='${result.statSize}']").attr("checked",true);
            	$("input:radio[name='statClimate']:radio[value='${result.statClimate}']").attr("checked",true);
            	$("input:radio[name='statDefinition']:radio[value='${result.statDefinition}']").attr("checked",true);
            	$("input:radio[name='statSun']:radio[value='${result.statSun}']").attr("checked",true);
            	$("input:radio[name='statThick']:radio[value='${result.statThick}']").attr("checked",true);
        	}
        	
        	// 수정 페이지 들어갔을 때 초기값에 대한 disabled 정의
        	var selectedVal = $("#statInsectYn option:selected").val();

        	if(selectedVal == 'Y'){
        		$('#statInsectKind').val(kind);
        		$("select[name=statInsectKind]").removeProp("disabled");
    		}else if(selectedVal == 'N'){
    			$("#statInsectKind").prop("disabled", true);
    		}
        	
        	// 병충해 유무 option값에 따른 이벤트 발생
        	$("#statInsectYn").change(function(){
        		if(this.value == 'Y'){
            		$("select[name=statInsectKind]").removeProp("disabled")
        		}else if(this.value == 'N'){
        			$('#statInsectKind').val("");
        			$("select[name=statInsectKind]").prop("disabled", true);
        		}
        	});
        },

        form: {
			submit: function(){
				 if(!checkData()){
						return;
					}
		    	 
				
				var frm = document["send-form"];
				if(confirm("등록하시겠습니까?")==true){
		        var formData = new FormData(frm);
				  $.ajax({
					  	 type : "POST",
		                 url : "/mntr/mab02/insertCropInfoInput.json",
		                 data : formData,
		                 contentType: false,
		                 processData: false,
		                 success : function(res){
		                	 alert("등록되었습니다.");
		                	 parent.myModal.close();
		                 },
		             }); 
				}else{
					return;
				}
				return false;
			},
			submit2: function(){	
				 if(!checkData()){
						return;
					}
		    	 
				 
				var frm = document["send-form"];
				if(confirm("수정하시겠습니까?")==true){
					$('#regDate').attr("disabled",false);	  
	        		$('#pumName').attr("disabled",false);	  
	        		$('#goodName').attr("disabled",false);
	        		var formData = new FormData(frm);
				$.ajax({
					   type : "POST",
			           url : "/mntr/mab02/updateCropInfoInput.json",
			           data : formData,
			           contentType: false,
		               processData: false,
			           success : function(res){			        	   
			        	    $('#regDate').attr("disabled","disabled");	  
			        		$('#pumName').attr("disabled","disabled");	  
			        		$('#goodName').attr("disabled","disabled");
			        		alert("수정되었습니다.");
			            	parent.myModal.close();
			           }
			       });   
				}else{
					return;
				}
				//dialog.push( $(frm).serialize() );
				return false;
			}
			
		},  		
		
        close:function(){
            if(opener){
                window.close();
            }
            else
            if(parent){
                if(parent.myModal) parent.myModal.close();
            }
            else
            {
                window.close();
            }
        }
    };
    
    jQuery(document).ready(fnObj.pageStart);  
    </script>
    
</head>

<body>  	 

<article>
<div>
	<div class="ma_content"><!--컨텐츠 내용들어가는곳 시작-->
		
	<div>
	<h4 class="hw_h3_ma_01" >${pageTitle}</h4> 
	
	</div>
	
	<form name="send-form" id="send-form" enctype="multipart/form-data">
		<div class="hw_clear"></div>
		<input type=hidden name="chulNo" value="${chulNo}"/>
	<input type=hidden name="seqNo" value="${result.seqNo}"/>
	<input type=hidden name="sanCd" value="${SESSION_SAN_CD}"/>
	<input type="hidden" name="ORIGINAL_FILE_NAME" value="${ORIGINAL_FILE_NAME}"/>
	<input type="hidden" name="STORED_FILE_NAME" value="${STORED_FILE_NAME}"/>
	<input type="hidden" name="FILE_SIZE" value="${FILE_SIZE}"/>
	
		<h4 class="ma_title">조사일자</h4> <p class="hw_red">조사일자를 선택해주세요</p>
		<div class="hw_clear"></div>	
	
		<div class="hw_infouse_01" id="pagesearch" ><input type="text" name="regDate" id="regDate" class="AXInput W100" value="${result.regDate}" onkeydown="return false;"/></div>
		<div class="hw_clear"></div>
	
		<h4 class="ma_title">품종선택</h4> <p class="hw_red">품종을 선택하세요</p>
		<div class="hw_clear"></div>	
		<div class="hw_infouse_01">
			<label class="hw_item_search_title" for="pumName">품목검색</label>
			<select name="pumName" id="pumName" class="item_search_select">
				<option value="장미">장미</option>   
			</select>
			<label class="hw_variety_search_title" for="goodName">품종검색</label>
			<select name="goodName" id="goodName" class="variety_search_select">
				<option value="그레이스">그레이스</option>
				<option value="그린나오미">그린나오미</option>
				<option value="나오미골드">나오미골드</option>   
				<option value="나이팅게일">나이팅게일</option>   
				<option value="달리">달리</option>   
				<option value="도미니카">도미니카</option>   
				<option value="돌세토">돌세토</option>   
				<option value="라펄">라펄</option>   
				<option value="레가토">레가토</option>   
				<option value="레드나오미">레드나오미</option>   
				<option value="레드이글">레드이글</option>  
				<option value="리바이벌">리바이벌</option> 
				<option value="마르시아">마르시아</option>
				<option value="마이걸">마이걸</option>
				<option value="미스홀렌드">미스홀렌드</option>
				<option value="밀바">밀바</option>
				<option value="버블검">버블검</option>
				<option value="보르도">보르도</option>
				<option value="부루트">부루트</option>
				<option value="블론디">블론디</option>
				<option value="비탈">비탈</option>
				<option value="빅토리아">빅토리아</option>
				<option value="사비나">사비나</option>
				<option value="샤만트">샤만트</option>
				<option value="샹그리라">샹그리라</option>
				<option value="스위트돌로미트">스위트돌로미트</option>
				<option value="슈퍼센세이션">슈퍼센세이션</option>
				<option value="선스타">선스타</option>
				<option value="아쿠아">아쿠아</option>
				<option value="어피니티">어피니티</option>
				<option value="F1">F1</option>
				<option value="엑설런트">엑설런트</option>
				<option value="오션송">오션송</option>
				<option value="오로라">오로라</option>
				<option value="올포러브">올포러브</option>
				<option value="이구아나">이구아나</option>
				<option value="일레오스">일레오스</option>
				<option value="와우">와우</option>
				<option value="자나">자나</option>
				<option value="지니">지니</option>
				<option value="카렌자">카렌자</option>
				<option value="클럽니카">클럽니카</option>
				<option value="푸에고">푸에고</option>
				<option value="피치걸">피치걸</option>
				<option value="피치벨리">피치벨리</option>
				<option value="핑크파티">핑크파티</option>
				<option value="핑크하트">핑크하트</option>
				<option value="헤라">헤라</option>
				<option value="기타">기타</option>        
			</select>
			<label class="hw_variety_search_title" for="uniqueColor">꽃의 고유색</label>
			<select name="uniqueColor" id="uniqueColor" class="variety_search_select">
				<option value="red">빨강</option>
				<option value="blue">파랑</option>
				<option value="yellow">노랑</option>   
				<option value="white">하얀</option>   
				<option value="pink">분홍</option>   
				<option value="orange">주황</option>   
				<option value="puple">보라</option>   
				<option value="black">검정</option>   
				<option value="etc">그외</option>    
			</select>
		</div>
		<h4 class="ma_title">작황정보 (전년대비)</h4> <p class="hw_red">전년대비 작황정보를 선택해주세요</p>
		<div class="hw_clear"></div>	
		<div class="hw_infouse_01 radio_btn_all">
	 		<input type="radio" id="status3" name="status" value="3" /><label for="status3">매우좋음</label>
			<input type="radio" id="status2" name="status" value="2" /><label for="status2">좋음</label>         
	    	<input type="radio"  id="status1" name="status" value="1" /><label for="status1">나쁨</label>
	    	<input type="radio" id="status0" name="status" value="0" /><label for="status0">매우나쁨</label>
		</div>
		<h4 class="ma_title">작황상태</h4> <p class="hw_red">작황상태를 선택해 주세요.</p>
		<div class="hw_clear"></div>
		<div class="hw_infouse_01">
			<ul class="hw_list radio_btn_all">
				<li>
					<span class="hw_item_search_title2">일조량</span>
					<input type="radio" name="statSun" id="statSun3" value="3" /><label for="statSun3">매우좋음</label>
					<input type="radio" name="statSun" id="statSun2" value="2" /><label for="statSun2">좋음</label>
			    	<input type="radio" name="statSun" id="statSun1" value="1" /><label for="statSun1">나쁨</label>
			    	<input type="radio" name="statSun" id="statSun0" value="0" /><label for="statSun0">매우나쁨</label>
				</li>
				<li>
					<span class="hw_item_search_title2">기후</span>
					<input type="radio" name="statClimate" value="3" id="statClimate3" /><label for="statClimate3">매우좋음</label>
					<input type="radio" name="statClimate" value="2" id="statClimate2" /><label for="statClimate2">좋음</label>
			    	<input type="radio" name="statClimate" value="1" id="statClimate1" /><label for="statClimate1">나쁨</label>
			    	<input type="radio" name="statClimate" value="0" id="statClimate0" /><label for="statClimate0">매우나쁨</label>
				</li>
				<li>
					<span class="hw_item_search_title2">꽃의 크기</span>
					<input type="radio" name="statSize" value="3" id="statSize3" /><label for="statSize3">특상</label>
					<input type="radio" name="statSize" value="2" id="statSize2" /><label for="statSize2">상</label>
			    	<input type="radio" name="statSize" value="1" id="statSize1" /><label for="statSize1">중</label>
			    	<input type="radio" name="statSize" value="0" id="statSize0" /><label for="statSize0">하</label>
				</li>
				<li>
					<label class="hw_item_search_title2" for="statThick">꽃대 굵기</label>
					<%-- <input type="text" name="statThick" id="statThick" class="AXInput W100" value="${result.statThick}" /> --%>
					<input type="radio" id="statThick4" name="statThick" value="4"/><label for="statThick4">특상</label>
					<input type="radio" id="statThick3" name="statThick" value="3"/><label for="statThick3">상</label> 
					<input type="radio" id="statThick2" name="statThick" value="2"/><label for="statThick2">중</label> 
					<input type="radio" id="statThick1" name="statThick" value="1"/><label for="statThick1">하</label> 
				</li>
				<li>
					<span class="hw_item_search_title2">색택의 선명함</span>
					<input type="radio" name="statDefinition" value="3" id="statDefinition3" /><label for="statDefinition3">매우선명</label>
					<input type="radio" name="statDefinition" value="2" id="statDefinition2" /><label for="statDefinition2">선명</label>
			    	<input type="radio" name="statDefinition" value="1" id="statDefinition1" /><label for="statDefinition1">탁함</label>
			    	<input type="radio" name="statDefinition" value="0" id="statDefinition0" /><label for="statDefinition0">매우탁함</label>
				</li>
				<%-- <li>
					<label class="hw_item_search_title2" for="statTemper">기온</label>
				    <input type="text" name="statTemper" id="statTemper" class="AXInput W100" value="${result.statTemper}"/> ℃
				</li> 
				<li>
					<label class="hw_item_search_title2" for="statColor">꽃의 색상</label>
					<select name="statColor" id="statColor" class="variety_search_select">
							<option value="red">빨강</option>
							<option value="blue">파랑</option>
							<option value="yellow">노랑</option>   
							<option value="white">하얀</option>   
							<option value="pink">분홍</option>   
							<option value="orange">주황</option>   
							<option value="puple">보라</option>   
							<option value="black">검정</option>   
							<option value="etc">그외</option>    
					</select>
				</li> --%>
				<li>
					<label class="hw_item_search_title2" for="statLength">꽃대 길이 (cm)</label>
					<input type="text" name="statLength" id="statLength" class="AXInput W100" value="${result.statLength}"/>
				</li>
				<li>
					<label class="hw_item_search_title2" for="statInsectYn">병충해 유무</label>
					<select name="statInsectYn" id="statInsectYn" class="variety_search_select">
						<option value="N">무</option>
						<option value="Y">유</option>
					</select>
				</li>
				<li>
					<label class="hw_item_search_title2" for="statInsectKind">병충해 종류 선택</label>
					<select name="statInsectKind" id="statInsectKind" class="variety_search_select" disabled=true >
						<option value="">선택</option>
						<option value="응애">응애</option>
						<option value="총채">총채</option>
						<option value="온실가루이">온실가루이</option>
						<option value="뿌리혹선충">뿌리혹선충</option>
						<option value="진딧물류">진딧물류</option>
						<option value="나방류">나방류</option>
						<option value="흰가루병">흰가루병</option>
						<option value="노균병">노균병</option>
						<option value="가지마름병">가지마름병</option>
						<option value="잿빛곰팡이병">잿빛곰팡이병</option>
						<option value="검은별무늬병">검은별무늬병</option>
						<option value="근두암종병">근두암종병</option>
						<option value="역병">역병</option>
						<option value="기타">기타</option>
					</select>
				</li>
			</ul>
		</div>
	   	<h4 class="ma_title">기타</h4> <p class="hw_red">작황동향을 간략하게200자 이내로 적어주세요</p>
		<div class="hw_clear"></div>	
	 
		<textarea name="bigo" id="bigo" class="AXTextarea" style="box-shadow:inset 0px 0px 3px #ccc;width:100%;height:60px; margin-top:10px; ime-mode:active;box-sizing: border-box;" title="내용">${result.bigo}</textarea>
		<div class="hw_clear"></div>	
		
		<h4 class="ma_title">작황 사진업로드</h4> <p class="hw_red">작황사진을 업로드해 주세요</p>
		<div class="hw_clear"></div>
		<div class="hw_infouse_01">
	 		<span id="fileEl" >
	 			<a href="/mab02/mab02FileDown.json?seq=${seqNo}">${ORIGINAL_FILE_NAME}</a>&nbsp;
	 		</span>
	 		 	&nbsp;<input type="file" name="file" id="file" value="${ORIGINAL_FILE_NAME }" readonly><br>
		</div>
	</form>	
	<div class="hw_clear"></div>	
	<div><input style="${pageopen}"id="add" name="add" class="ma_add_01"  type="button" value="등록하기" onclick="fnObj.form.submit();" /></div>
	<div><input style="${pageopen2}" id="modify" name="modify" class="ma_add_01"  type="button" value="수정하기" onclick="fnObj.form.submit2();" /></div>  
	<div class="hw_clear"></div>
	</div>
</div><!--wrap 끝-->
</article>
</body>
</html>

