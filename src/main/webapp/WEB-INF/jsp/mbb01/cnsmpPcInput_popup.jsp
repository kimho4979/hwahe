<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%   
   if (request.getParameter("REG_DATE")==null){
    request.setAttribute("pageTitle", "소매가격 등록"); 
    String CHUL_NO=(String)session.getAttribute("SESSION_CMP_CODE");
    request.setAttribute("CHUL_NO", CHUL_NO);    
    request.setAttribute("GOOD_NAME", "비탈");
    request.setAttribute("pageopen", "");
    request.setAttribute("pageopen2", "display:none");            
  }
  else{
    request.setAttribute("pageTitle", "소매가격 수정");
    request.setAttribute("pageopen", "display:none");
    request.setAttribute("pageopen2", "");
    request.setAttribute("pagecheck", "1");
    request.setAttribute("REG_DATE", request.getParameter("REG_DATE"));
    request.setAttribute("CHUL_NO", request.getParameter("CHUL_NO"));
    request.setAttribute("GOOD_NAME", request.getParameter("GOOD_NAME"));    
    request.setAttribute("SEQ_NO", request.getParameter("SEQ_NO"));
    request.setAttribute("SALE_PRICE", request.getParameter("SALE_PRICE"));            
  }   
String sanCd = "110542";
if ((String)session.getAttribute("SESSION_SAN_CD")!=null){
	sanCd=session.getAttribute("SESSION_SAN_CD").toString();
 }  
%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, user-scalable=no">
<title>재배동향 입력창 </title>
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

	function checkData(){
		// 일자
		if($('#REG_DATE').val() == '')
		{
			alert('조사일자를 선택하세요');
			return false;
		}
		
		// 일자
		if($('#AXInputMoney').val() == '')
		{
			alert('소매가격을 입력하세요');
			return false;
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
    	           				alert(thisMonth+"월 재배동향은 마감되었습니다.\n다음달 재배동향을 등록해주세요.");
    	           				
    	           				thisMonth = thisMonth+1;
    	           				if(thisMonth<10){
    	           					thisMonth = "0" + thisMonth;
    	           				}
    	           				
    	           				if(thisMonth == "13"){
    	           					thisMonth = "01";
    	           					thisYear = thisYear+1;
    	           				}
    	           				
    	           				$("#REG_DATE").bindDate({align:"right", valign:"bottom", separator:"-", selectType:"d",  defaultSelectType:"d", minDate: thisYear+"-"+thisMonth+"-01",
    	           		        	onchange:function(){
    	           		        		var stDate = thisYear+"-"+thisMonth+"-01";
    	           		        		if($("#REG_DATE").val().replace(/-/gi,"") <  stDate.replace(/-/gi,"")){
    	           		        			$("#REG_DATE").val(thisYear+"-"+thisMonth+"-01");
    	           		        		}
    	           		            }
    	           		        	}); 
    	           			}else{
    	           				if(thisMonth<10){
    	           					thisMonth = "0" + thisMonth;
    	           				}
    	           				
    	           				$("#REG_DATE").bindDate({align:"right", valign:"bottom", separator:"-", selectType:"d",  defaultSelectType:"d", minDate: thisYear+"-"+thisMonth+"-01",
    	           		        	onchange:function(){
    	           		        		var stDate = thisYear+"-"+thisMonth+"-01";
    	           		        		if($("#REG_DATE").val().replace(/-/gi,"") <  stDate.replace(/-/gi,"")){
    	           		        			$("#REG_DATE").val(thisYear+"-"+thisMonth+"-01");
    	           		        		}
    	           		            }
    	           		        	});
    	           			}
               			}else{
               				var regDate = $("#REG_DATE").val();
               				var regYear = regDate.substring(0,4);
               				var regMonth = regDate.substring(5,7);
               				
               				$("#REG_DATE").bindDate({align:"right", valign:"bottom", separator:"-", selectType:"d",  defaultSelectType:"d", minDate: regYear+"-"+regMonth+"-01", maxDate: regYear+"-"+regMonth+"-31",
               		        	onchange:function(){
               		        		var stDate = regYear+"-"+regMonth+"-01";
               		        		if($("#REG_DATE").val().replace(/-/gi,"") <  stDate.replace(/-/gi,"")){
               		        			$("#REG_DATE").val(regYear+"-"+regMonth+"-01");
               		        		}
               		        		
               		        		var enDate = regYear+"-"+regMonth+"-31";
               		        		if($("#REG_DATE").val().replace(/-/gi,"") >  enDate.replace(/-/gi,"")){
               		        			$("#REG_DATE").val(regDate);
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
    	           				alert((thisMonth-1)+"월 재배동향은 마감되었습니다.\n"+(thisMonth)+"월 재배동향을 등록해주세요.");
    	           				thisMonth = thisMonth;
    	           				if(thisMonth<10){
    	           					thisMonth = "0" + thisMonth;
    	           				}
    	           				
    	           				if(thisMonth == "13"){
    	           					thisMonth = "01";
    	           					thisYear = thisYear+1;
    	           				}
    	           				
    	           				$("#REG_DATE").bindDate({align:"right", valign:"bottom", separator:"-", selectType:"d",  defaultSelectType:"d", minDate: thisYear+"-"+thisMonth+"-01",
    	           		        	onchange:function(){
    	           		        		var stDate = thisYear+"-"+thisMonth+"-01";
    	           		        		if($("#REG_DATE").val().replace(/-/gi,"") <  stDate.replace(/-/gi,"")){
    	           		        			$("#REG_DATE").val(thisYear+"-"+thisMonth+"-01");
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
    	           				
    	           				$("#REG_DATE").bindDate({align:"right", valign:"bottom", separator:"-", selectType:"d",  defaultSelectType:"d", minDate: thisYear+"-"+agoMonth+"-01",
    	           		        	onchange:function(){
    	           		        		var stDate = thisYear+"-"+thisMonth+"-01";
    	           		        		if($("#REG_DATE").val().replace(/-/gi,"") <  stDate.replace(/-/gi,"")){
    	           		        			$("#REG_DATE").val(thisYear+"-"+thisMonth+"-01");
    	           		        		}
    	           		            }
    	           		        	});
    	           			}
               			}else{
               				var regDate = $("#REG_DATE").val();
               				var regYear = regDate.substring(0,4);
               				var regMonth = regDate.substring(5,7);
               				
               				$("#REG_DATE").bindDate({align:"right", valign:"bottom", separator:"-", selectType:"d",  defaultSelectType:"d", minDate: regYear+"-"+regMonth+"-01", maxDate: regYear+"-"+regMonth+"-31",
               		        	onchange:function(){
               		        		var stDate = regYear+"-"+regMonth+"-01";
               		        		if($("#REG_DATE").val().replace(/-/gi,"") <  stDate.replace(/-/gi,"")){
               		        			$("#REG_DATE").val(regYear+"-"+regMonth+"-01");
               		        		}
               		        		
               		        		var enDate = regYear+"-"+regMonth+"-31";
               		        		if($("#REG_DATE").val().replace(/-/gi,"") >  enDate.replace(/-/gi,"")){
               		        			$("#REG_DATE").val(regDate);
               		        		}
               		            }
               		        	}); 
               			}
           			} 
           		}
           	});
        	/*
        	$("#REG_DATE").bindDate({align:"right", valign:"bottom", separator:"-", selectType:"d",  defaultSelectType:"d",
        	onchange:function(){
            }
        	});*/        	
        	
        	$("#AXInputMoney").bindMoney({
				min:0,
				max:900000000,
				onchange : function(){
					trace(this);
				}
			});
        	
        	if('${pagecheck}' == "1" ){
        		$('#GOOD_NAME').val("${GOOD_NAME}");
        		$('#REG_DATE').attr("disabled",false);
        		$('#PUM_NAME').attr("disabled",false);
        		$('#GOOD_NAME').attr("disabled",false);
            	
        	}        	        	        	
        	$("input:radio[name='MONTH_GUBN']:radio[value='${MONTH_GUBN}']").attr("checked",true);
        	
        	$("input:radio[name='ITEM_CD']:radio[value='${ITEM_CD}']").attr("checked",true);        	        	
        	        	
        },  

        form: {			
			submit: function(){
				if(!checkData()){
					return;
				}
				
				var frm = document["send-form"];
				if(confirm("등록하시겠습니까?")==true){				
				$.ajax({
			           type : "POST",
			           url : "/mntr/mbb01/insertCnsmpPcInput.json",
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
				//dialog.push( $(frm).serialize() );
				return false;
			},
			submit2: function(){	
				if(!checkData()){
					return;
				}
				
				var frm = document["send-form"];						
				if(confirm("수정하시겠습니까?")==true){
					$('#REG_DATE').attr("disabled",false);	  
	        		$('#PUM_NAME').attr("disabled",false);	  
	        		$('#GOOD_NAME').attr("disabled",false);	             	
				$.ajax({
			           type : "POST",
			           url : "/mntr/mbb01/updateCnsmpPcInput.json",
			           data :  "&"+$(frm).serialize(),
			           dataType : '',   	           
			           success : function(res){			        	    
			        	   $('#REG_DATE').attr("disabled","disabled");	  
			        		$('#PUM_NAME').attr("disabled","disabled");	  
			        		$('#GOOD_NAME').attr("disabled","disabled");				            
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

<form name="send-form" onsubmit="return false;">
<div class="hw_clear"></div>
<input type=hidden name="CHUL_NO" value="${CHUL_NO}"/>
<input type=hidden name="SAN_CD" value="<%= sanCd%>"/>
<input type=hidden name="SEQ_NO" value="${SEQ_NO}"/>
<h4 class="ma_title">조사일자</h4> <p class="hw_red">조사일자를 선택해주세요</p>
<div class="hw_clear"></div>	
<div class="hw_infouse_01" id="pagesearch" ><input type="text" name="REG_DATE" id="REG_DATE" class="AXInput W100" value="${REG_DATE}" onkeydown="return false;"/>
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
<h4 class="ma_title">소매가격</h4> <p class="hw_red">소매가격을 적어주세요</p>
<div class="hw_clear"></div>	
<div class="hw_infouse_01" ><input type="tel" name="SALE_PRICE" id="AXInputMoney" value='${SALE_PRICE}' class="AXInput" />
<span>원</span>
</div>

<div class="hw_clear"></div>	
     
<div><input style="${pageopen}"id="add" name="add" class="ma_add_01"  type="button" value="등록하기" onclick="fnObj.form.submit();" /></div>
<div><input style="${pageopen2}" id="modify" name="modify" class="ma_add_01"  type="button" value="수정하기" onclick="fnObj.form.submit2();" /></div>  
  


</form>
</div>
</div><!-- 끝-->
</article>
</body>
</html>

