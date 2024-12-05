<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%   
   if (request.getParameter("REG_DATE")==null){
    request.setAttribute("pageTitle", "출하예정물량 등록"); 
    String CHUL_NO=(String)session.getAttribute("SESSION_CMP_CODE");
    request.setAttribute("CHUL_NO", CHUL_NO);        
    request.setAttribute("GOOD_NAME", "비탈");
    request.setAttribute("pageopen", "");
    request.setAttribute("pageopen2", "display:none"); 
  }else{
    request.setAttribute("pageTitle", "출하예정물량 수정");
    request.setAttribute("pageopen", "display:none");
    request.setAttribute("pageopen2", "");
    request.setAttribute("pagecheck", "1");
    request.setAttribute("REG_DATE", request.getParameter("REG_DATE"));
    request.setAttribute("DAYS_GUBN", request.getParameter("DAYS_GUBN"));
    request.setAttribute("CHUL_NO", request.getParameter("CHUL_NO"));  
    request.setAttribute("GOOD_NAME", request.getParameter("GOOD_NAME"));  
    request.setAttribute("MARKET_CD", request.getParameter("MARKET_CD"));    
    request.setAttribute("QTY", request.getParameter("QTY"));    
    request.setAttribute("BIGO", request.getParameter("BIGO"));  
    request.setAttribute("SEQ_NO", request.getParameter("SEQ_NO"));    
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
 
<!-- rMateChartH5 라이센스 시작 -->
<script type="text/javascript" src="<c:url value='/rMateChart/LicenseKey/rMateChartH5License.js' />"></script>
<!-- rMateChartH5 라이센스 끝-->  
<!-- 실제적인 rMateChartH5 라이브러리 시작-->
<script type="text/javascript" src="<c:url value='/rMateChart/rMateChartH5/JS/rMateChartH5.js' />"></script>
<!-- 실제적인 rMateChartH5 라이브러리 끝-->

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
  <!-- @@@@@@@@@@@@@@@@@@@@@@ css begin @@@@@@@@@@@@@@@@@@@@@@ -->
 <link rel="stylesheet" type="text/css" href="<c:url value='/rMateChart/rMateChartH5/Assets/Css/rMateChartH5.css' />"/>   
 <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/axicon/axicon.min.css' />" />
 <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/arongi/AXJ.min.css' />" />
 <link rel="stylesheet" type="text/css" href="<c:url value='/css/hw/ma.css' />" />
 <link rel="stylesheet" type="text/css" href="<c:url value='/css/hw/common.css' />" />

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
		var daysGubn = '${DAYS_GUBN}';
		var regMonth = '${REG_DATE}';
		var qty = '${QTY}';

		function checkData(){
			// 일자
			if($('input:radio[name=DAYS_GUBN]:checked').val() == undefined)
			{
				alert('일자를 선택하세요');
				return false;
			}
			
			// 일자
			if($('#AXInputMoney').val() == '')
			{
				alert('출하량을 입력하세요');
				return false;
			}
			
			return true;
		}

		
    var fnObj = {
        pageStart: function(){
        	
        	var daysGubn = '${DAYS_GUBN}';
        	
        	if(daysGubn!=''){
        		if(daysGubn == '1'){
    				$("#DAYS_GUBN1").attr("checked", true);
            	}else if(daysGubn == '2'){
            		$("#DAYS_GUBN2").attr("checked", true);
            	}else if(daysGubn == '3'){
            		$("#DAYS_GUBN3").attr("checked", true);
            	}
        		$('#dayGubn').val(daysGubn);
        		
        		if(regMonth != ''){
    				$("#regMonth").val(regMonth.substring(5,7));
            	}else {
            		var d = new Date();
            		var curMonth = d.getMonth() + 1
            		if(curMonth.length < 2) {
            			curMonth = '0'+curMonth;
            		}
            		$("#regMonth").val(curMonth);
            	}
        	}else{
        		var date = new Date();
            	yyyy= date.getFullYear();
            	yyyy1=date.getFullYear();
            	m=date.getMonth()+1;
            	d=date.getDate();

            	var m2=m+1;
            	if(m2 =="13"){
            		m2="1"; yyyy1=yyyy1+1;
            	}
            	
            	if(m2<10){
            		m2='0'+m2;
            	}
            	if(m<10){
            		m='0'+m;
            	}
            	if(d<10){
            		d='0'+d;	
            	}
            	
            	if(d>0&&d<=3){
            		$("#regMonth").val(m);
            		$("#regDate").val(yyyy+'-'+m+'-05');
            		$("#dayGubn").val('1');
            		$("#DAYS_GUBN1").attr("checked", true);
            		$("#DAYS_GUBN1").removeAttr("disabled");
            		$("#DAYS_GUBN2").removeAttr("disabled");
            	}else if(d>3&&d<=10){
            		$("#regMonth").val(m);
            		$("#regDate").val(yyyy+'-'+m+'-15');
            		$("#dayGubn").val('2');
            		$("#DAYS_GUBN2").attr("checked", true);
            	}else if(d>10&&d<=13){
            		$("#regMonth").val(m);
            		$("#regDate").val(yyyy+'-'+m+'-15');
            		$("#dayGubn").val('2');
            		$("#DAYS_GUBN2").attr("checked", true);
            		$("#DAYS_GUBN2").removeAttr("disabled");
            		$("#DAYS_GUBN3").removeAttr("disabled");
            	}else if(d>13&&d<=20){
            		$("#regMonth").val(m);
            		$("#regDate").val(yyyy+'-'+m+'-25');
            		$("#dayGubn").val('3');
            		$("#DAYS_GUBN3").attr("checked", true);
            	}else if(d>20&&d<=23){
            		$("#regMonth").val(m);
            		$("#regDate").val(yyyy+'-'+m+'-25');
            		$("#dayGubn").val('3');
            		$("#DAYS_GUBN3").attr("checked", true);
            		$("#DAYS_GUBN3").removeAttr("disabled");
            		$("#DAYS_GUBN1").removeAttr("disabled");
            	}else if(d>23&&d<=31){
            		$("#regMonth").val(m2);
            		$("#regDate").val(yyyy1+'-'+m2+'-05');
            		$("#dayGubn").val('1');
            		$("#DAYS_GUBN1").attr("checked", true);
            	}
        	}
        	
        	$("#AXInputMoney").bindMoney({
				min:0,
				max:900000000,
				onchange : function(){
					trace(this);
				}
			});
			
        	if('${pagecheck}' == "1" ){
        		$('#GOOD_NAME').val("${GOOD_NAME}");	
        		$('#MARKET_CD').val("${MARKET_CD}");
        		$('#PUM_NAME').attr("disabled",false);
        		$('#GOOD_NAME').attr("disabled",false);
            	$('#MARKET_CD').attr("disabled",false);
        	}
        	
        	if("${MARKET_CD}" == '0000000100'){
        		$("#MARKET_CD option:eq(6)").attr("selected", "selected");
        		$("#hw_otherpart_search").attr("disabled",false);
        		$("#hw_otherpart_search").val("0000000100");
        	}
        	else if("${MARKET_CD}" == '0000000200'){
        		$("#MARKET_CD option:eq(6)").attr("selected", "selected");
        		$("#hw_otherpart_search").attr("disabled",false);
        		$("#hw_otherpart_search").val("0000000200");
        	}
        	else if("${MARKET_CD}" == '0000000300'){
        		$("#MARKET_CD option:eq(6)").attr("selected", "selected");
        		$("#hw_otherpart_search").attr("disabled",false);
        		$("#hw_otherpart_search").val("0000000300");
        	}
        	else if("${MARKET_CD}" == '9999999999'){
        		$("#MARKET_CD option:eq(6)").attr("selected", "selected");
        		$("#hw_otherpart_search").attr("disabled",false);
        		$("#hw_otherpart_search").val("9999999999");
        	}
        	else{
        		$('#hw_otherpart_search').attr("disabled","disabled");
        	}
        	
        	if(qty != ''){
        		var parQty = parseInt(qty);
        		$("#AXInputMoney").val(parQty);
        	}
        	
        	var date = new Date();
        	yyyy= date.getFullYear();
        	m=date.getMonth()+1;
        	d=date.getDate();
        	
        	if(d>0&&d<=3){
        		$("#DAYS_GUBN1").change(function(){
            		if($("#DAYS_GUBN1").is(":checked")){
            			
            			var date = new Date();
            			yyyy=date.getFullYear();
            			yyyy1=date.getFullYear();
                    	m=date.getMonth()+1;
                    	d=date.getDate();

                    	var m2=m+1;
                    	if(m2 =="13"){
                    		m2="1"; yyyy1=yyyy1+1;
                    	}
                    	if(m2<10){
                    		m2='0'+m2;
                    	}
                    	if(m<10){
                    		m='0'+m;
                    	}
                    	if(d<10){
                    		d='0'+d;	
                    	}
                    	
                    	$("#regMonth").val(m);
                		$("#regDate").val(yyyy+'-'+m+'-05');
                		$("#dayGubn").val('1');
                    }
                });
        		
        		$("#DAYS_GUBN3").change(function(){
    				if($("#DAYS_GUBN3").is(":checked")){
            			
            			var date = new Date();
                    	yyyy= date.getFullYear();
                    	yyyy1= date.getFullYear();
                    	m=date.getMonth()+1;
                    	d=date.getDate();

                    	var m2=m-1;
                    	if(m2 =="0"){
                    		m2="12"; yyyy1=yyyy1-1;
                    	}
                    	if(m2<10){
                    		m2='0'+m2;
                    	}
                    	if(m<10){
                    		m='0'+m;
                    	}
                    	if(d<10){
                    		d='0'+d;	
                    	}
                    	
                    	$("#regMonth").val(m2);
                		$("#regDate").val(yyyy1+'-'+m2+'-25');
                		$("#dayGubn").val('3');
                    }
                });
        		
        	}else{
        		$("#DAYS_GUBN1").change(function(){
            		if($("#DAYS_GUBN1").is(":checked")){
            			
            			var date = new Date();
                    	yyyy= date.getFullYear();
                    	yyyy1=date.getFullYear();
                    	m=date.getMonth()+1;
                    	d=date.getDate();

                    	var m2=m+1;
                    	if(m2 =="13"){
                    		m2="1"; yyyy1=yyyy1+1;
                    	}
                    	if(m2<10){
                    		m2='0'+m2;
                    	}
                    	if(m<10){
                    		m='0'+m;
                    	}
                    	if(d<10){
                    		d='0'+d;	
                    	}
                    	
                    	$("#regMonth").val(m2);
                		$("#regDate").val(yyyy1+'-'+m2+'-05');
                		$("#dayGubn").val('1');
                    }
                });
        		
        		$("#DAYS_GUBN3").change(function(){
    				if($("#DAYS_GUBN3").is(":checked")){
            			
            			var date = new Date();
                    	yyyy= date.getFullYear();
                    	yyyy1=date.getFullYear();
                    	m=date.getMonth()+1;
                    	d=date.getDate();

                    	var m2=m+1;
                    	if(m2 =="13"){
                    		m2="1"; yyyy1=yyyy1+1;
                    	}
                    	
                    	if(m2<10){
                    		m2='0'+m2;
                    	}
                    	if(m<10){
                    		m='0'+m;
                    	}
                    	if(d<10){
                    		d='0'+d;	
                    	}
                    	
                    	$("#regMonth").val(m);
                		$("#regDate").val(yyyy+'-'+m+'-25');
                		$("#dayGubn").val('3');
                    }
                });
        	}
        	
        	
        	$("#DAYS_GUBN2").change(function(){
        		if($("#DAYS_GUBN2").is(":checked")){
        			
        			var date = new Date();
                	yyyy= date.getFullYear();
                	yyyy1=date.getFullYear();
                	m=date.getMonth()+1;
                	d=date.getDate();

                	var m2=m+1;
                	if(m2 =="13"){
                		m2="1"; yyyy1=yyyy1+1;
                	}
                	
                	if(m2<10){
                		m2='0'+m2;
                	}
                	if(m<10){
                		m='0'+m;
                	}
                	if(d<10){
                		d='0'+d;	
                	}
                	
                	$("#regMonth").val(m);
            		$("#regDate").val(yyyy+'-'+m+'-15');
            		$("#dayGubn").val('2');
                }
            });
        },  
        form: {			
			submit: function(){
				if(!checkData()){
					return;
				}
				
				if($('#MARKET_CD').val()=="9999999999"){
					$('#ETC_CODE').val($('#hw_otherpart_search').prop("value"));
				}
				
				var frm = document["send-form"];
				if(confirm("등록하시겠습니까?")==true){
				$("#regMonth").attr("disabled",false);
				$.ajax({
			           type : "POST",
			           url : "/mntr/maa01/insertShipmntPrearngeVolm.json",
			           data : $(frm).serialize(),
			           dataType : '',   	           
			           success : function(res){	
			        	   alert('등록되었습니다');
			        	   parent.myModal.close();
			           },
			       });   
				}else{
					return;
				}
				return false;
			},
			submit2: function(){
				if($('#MARKET_CD').val()=="9999999999"){
					$('#ETC_CODE').val($('#hw_otherpart_search').prop("value"));
				}
				
				var frm = document["send-form"];
				if(confirm("수정하시겠습니까?")==true){
					$("#regMonth").attr("disabled",false);
					//$('#REG_DATE').attr("disabled",false);
	        		$('#PUM_NAME').attr("disabled",false);
	        		$('#GOOD_NAME').attr("disabled",false);
	            	$('#MARKET_CD').attr("disabled",false);
				$.ajax({
			           type : "POST",
			           url : "/mntr/maa01/updateShipmntPrearngeVolm.json",
			           data :  $('#send-form').serialize(),
			           dataType : '',   	           
			           success : function(res){			        	    
			        	   //$('#REG_DATE').attr("disabled",false);
			        		$('#PUM_NAME').attr("disabled",false);
			        		$('#GOOD_NAME').attr("disabled",false);
			            	$('#MARKET_CD').attr("disabled",false);
			            	alert("수정되었습니다.");
			            	parent.myModal.close();
			           },
			       });   
				}else{
					return;
				}
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
    
   function marketChange(value){
	   $("#hw_otherpart_search option:eq(0)").prop("selected", true);
	   $('#MARKET_CD').val(value);
	   if(value == '9999999999'){
			$('#hw_otherpart_search').removeAttr("disabled");
	   }else{
			$('#hw_otherpart_search').attr("disabled","disabled");
	   }		  
   }
    
   function addTsc(num) {
	    return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
	}
   
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
	
	<form id="send-form" name="send-form" onsubmit="return false;">
		<div class="hw_clear"></div>
		<input type=hidden name="regDate"  id="regDate" value="${REG_DATE}"/>
		<input type=hidden name="dayGubn"  id="dayGubn" value="${DAY_GUBN}"/>
		<input type=hidden name="CHUL_NO" value="${CHUL_NO}"/>
		<input type=hidden name="GUBN" value="1"/>
		<input type=hidden name="SAN_CD" value="${SESSION_SAN_CD}"/>
		<input type=hidden name="SEQ_NO" value="${SEQ_NO}"/>
		<input type=hidden id="ETC_CODE" name="ETC_CODE" value=""/>
		<input type=hidden id="CHANGE_NO" name="CHANGE_NO" value="${CHANGE_NO}"/>
		<input type="hidden" id="SESSION_USER_ID" name="SESSION_USER_ID" value="${SESSION_USER_ID}" />
		<h4 class="ma_title">일자</h4> <p class="hw_red">일자를 선택해주세요(다음순+3일까지 입력 가능)</p>
		<div class="hw_clear"></div>
			<div class="hw_infouse_01" id="pagesearch" >
				<span class="hw_item_search_title">월선택</span>
				<select name="regMonth" id="regMonth" class="item_search_select" disabled="disabled">
					<option value="01">01</option>
					<option value="02">02</option>
					<option value="03">03</option>
					<option value="04">04</option>
					<option value="05">05</option>
					<option value="06">06</option>
					<option value="07">07</option>
					<option value="08">08</option>
					<option value="09">09</option>
					<option value="10">10</option>
					<option value="11">11</option>
					<option value="12">12</option>
				</select>
				<input type="radio" id="DAYS_GUBN1" name="DAYS_GUBN" value="1" disabled="disabled"/>초순
				<input type="radio" id="DAYS_GUBN2" name="DAYS_GUBN" value="2" disabled="disabled"/>중순
				<input type="radio" id="DAYS_GUBN3" name="DAYS_GUBN" value="3" disabled="disabled"/>하순
			</div>
		<div class="hw_clear"></div>
		
		<h4 class="ma_title">품종선택</h4> <p class="hw_red">품종을 선택하세요</p>
		<div class="hw_clear"></div>	
		<div class="hw_infouse_01">
			<span class="hw_item_search_title">품목검색</span>
			<select name="PUM_NAME" id="PUM_NAME" class="item_search_select">
				<option value="장미">장미</option>   
			</select>
			<span class="hw_variety_search_title">품종검색</span>
			<select name="GOOD_NAME" id="GOOD_NAME" class="variety_search_select">
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
		</div>
		<div class="hw_clear"></div>
		<h4 class="ma_title">출하예정지역선택</h4> <p class="hw_red">출하예정지역을 선택하세요</p>
		<div class="hw_clear"></div>	
		<div class="hw_infouse_01">
			<span class="hw_jointmarket_search_title">공판장 선택</span>
			<select name="MARKET_CD" id="MARKET_CD" class="jointmarket_search_select" onchange="marketChange(this.value)">
			 	<option value="0000000001"> aT화훼공판장(양재동)  </option>                 
			    <option value="1508500020"> 부산화훼공판장(엄궁동) </option>
			    <option value="6068207466"> 부산경남화훼농협(강동동) </option>
			    <option value="4108212335"> 광주원예농협(풍암) </option>
			    <option value="3848200087"> 한국화훼농협(음성) </option>
			    <option value="1288202296"> 한국화훼농협(과천) </option>
			    <option value="9999999999"> 기타지역</option>
			 </select>   
			<span class="hw__search_title">기타지역 선택</span>
			<select name="hw_otherpart_search" id="hw_otherpart_search" class="otherpart_search_select" onchange="otherpartChange(this.value)">	 
			 	<option value=""> 선택 </option>
			 	<option value="0000000100"> 경부선 </option>                 
			    <option value="0000000200"> 호남선 </option>
			    <option value="0000000300"> 남대문 </option>
			    <option value="9999999999"> 기타 </option>
			 </select>   	    
		</div>
		<div class="hw_clear"></div>
		<h4 class="ma_title">예정출하량</h4> <p class="hw_red">예정출하량을 적어주세요</p>
		<div class="hw_clear"></div>	
		<div class="hw_infouse_01" ><input type="tel" name="QTY" id="AXInputMoney" value='${QTY}' class="AXInput" />
		속
		</div>
		<div class="hw_clear"></div>	
		<h4 class="ma_title">출하예정물량 요약</h4> <p class="hw_red">출하예정물량을 간략하게200자 이내로 적어주세요</p>
		<div class="hw_clear"></div>	
		 <textarea name="BIGO" id="BIGO" class="AXTextarea" style="box-shadow:inset 0px 0px 3px #ccc;width:100%;height:60px; margin-top:10px; ime-mode:active;box-sizing: border-box;" title="내용">${BIGO}</textarea>
		<div class="hw_clear"></div>	
		     
		<div><input style="${pageopen}"id="add" name="add" class="ma_add_01"  type="button" value="등록하기" onclick="fnObj.form.submit();" /></div>
		<div><input style="${pageopen2}" id="modify" name="modify" class="ma_add_01"  type="button" value="수정하기" onclick="fnObj.form.submit2();" /></div>  
		  
		<!-- <button class="AXButton" type="button" onclick="fnObj.form.submit();">저장하기</button> -->
		
	</form>
</div>
</div><!--wrap 끝-->
</article>
</body>
</html>

