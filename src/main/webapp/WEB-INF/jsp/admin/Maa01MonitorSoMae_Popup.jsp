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
    request.setAttribute("COMP_CODE", request.getParameter("COMP_CODE"));
    request.setAttribute("GOOD_NAME", request.getParameter("GOOD_NAME")); 
    request.setAttribute("SAN_CD", request.getParameter("SAN_CD"));
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
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1, maximum-scale=1.0, minimum-scale=1" />
<title>재배동향 입력창 </title>
  <!-- @@@@@@@@@@@@@@@@@@@@@@ css begin @@@@@@@@@@@@@@@@@@@@@@ -->
 <link rel="stylesheet" type="text/css" href="<c:url value='/rMateChart/rMateChartH5/Assets/Css/rMateChartH5.css' />"/>   
 <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/axicon/axicon.min.css' />" />
 <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/arongi/AXJ.min.css' />" />
 <link rel="stylesheet" type="text/css" href="<c:url value='/css/hw/n_ma.css' />" />
 <link rel="stylesheet" type="text/css" href="<c:url value='/css/hw/n_common.css' />" />
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

    var fnObj = {
        pageStart: function(){
        	$("#REG_DATE").bindDate({align:"right", valign:"bottom", separator:"-", selectType:"d",  defaultSelectType:"d",
        	onchange:function(){
                //toast.push(Object.toJSON(this));
            }
        	});        	
        	
        	$("#AXInputMoney").bindMoney({
				min:0,
				max:900000000,
				onchange : function(){
					trace(this);
				}
			});
        	
        	if('${pagecheck}' == "1" ){
        		$('#GOOD_NAME').val("${GOOD_NAME}");	
        		$("#REG_DATE").unbindInput();
        		$('#REG_DATE').attr("disabled","disabled");	  
        		$('#PUM_NAME').attr("disabled","disabled");	  
        		$('#GOOD_NAME').attr("disabled","disabled");	          
            	
        	}        	        	        	
        	$("input:radio[name='MONTH_GUBN']:radio[value='${MONTH_GUBN}']").attr("checked",true);
        	
        	$("input:radio[name='ITEM_CD']:radio[value='${ITEM_CD}']").attr("checked",true);        	        	
        	        	
        	//fnObj.upload.init();
        },  

        form: {			
submit: function(){
				
				var frm = document["send-form"];
				
				$('#COMP_CODE').val('${COMP_CODE}');
				if(confirm("등록하시겠습니까?")==true){				
				$.ajax({
			           type : "POST",
			           url : "/maa01/Maa01MonitorSoMaePopupInsert.json",
			           data : $(frm).serialize(),
			           dataType : '',   	           
			           success : function(res){	
			        	   var COMP_CODE= $('#CHUL_NO').val();
				            
			            	var obj={
			            			COMP_CODE: COMP_CODE
			            	};
											            	
			            	parent.grid_ajax();
			            	parent.grid_ajax1(obj);
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
				var frm = document["send-form"];						
				if(confirm("수정하시겠습니까?")==true){
					$('#REG_DATE').attr("disabled",false);	  
	        		$('#PUM_NAME').attr("disabled",false);	  
	        		$('#GOOD_NAME').attr("disabled",false);	             	
				$.ajax({
			           type : "POST",
			           url : "/maa01/Maa01MonitorSoMaePopupUpdate.json",
			           data :  "&"+$(frm).serialize(),
			           dataType : '',   	           
			           success : function(res){			        	    
			        	   $('#REG_DATE').attr("disabled","disabled");	  
			        		$('#PUM_NAME').attr("disabled","disabled");	  
			        		$('#GOOD_NAME').attr("disabled","disabled");				            
			            	alert("수정완료");
			            	var COMP_CODE= $('#CHUL_NO').val();
				            
			            	var obj={
			            			COMP_CODE: COMP_CODE
			            	};
											            	
			            	parent.grid_ajax1(obj);
			            	 parent.myModal.close();
			           },
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
<div class="wrap">


<div class="ma_content"><!--컨텐츠 내용들어가는곳 시작-->
	
<div>
<h4 class="hw_h3_ma_01" >${pageTitle}</h4> 

</div>

<form name="send-form" onsubmit="return false;">
<div class="hw_clear"></div>
<input type=hidden name="CHUL_NO" id="CHUL_NO" value="${CHUL_NO}"/>
<input type=hidden name="SEQ_NO"id="SEQ_NO" value="${SEQ_NO}"/>
<input type=hidden name="SAN_CD" value="${SAN_CD}"/>
<input type=hidden name="COMP_CODE" value="${COMP_CODE}"/>
<h4 class="ma_title">날짜선택</h4> <p class="hw_green">날짜를 선택해주세요</p>
<div class="hw_clear"></div>	
<div class="hw_infouse_01" id="pagesearch" ><input type="text" name="REG_DATE" id="REG_DATE" class="AXInput W100" value="${REG_DATE}" />
</div>
<div class="hw_clear"></div>

<h4 class="ma_title">품종선택</h4> <p class="hw_green">품종을 선택하세요</p>
<div class="hw_clear"></div>	
<div class="hw_infouse_01">
<span class="hw_item_search_title">품목검색</span>
<select name="PUM_NAME" id="PUM_NAME" class="item_search_select">
	<option value="장미">장미</option>   
</select>
<span class="hw_variety_search_title">품종검색</span>
<select name="GOOD_NAME" id="GOOD_NAME" class="variety_search_select">
	<option value="비탈">비탈</option>   
	<option value="아쿠아">아쿠아</option>   
	<option value="부루트">부루트</option>   
	<option value="헤라">헤라</option>   
	<option value="어피니티">어피니티</option>   
	<option value="클럽니카">클럽니카</option>   
	<option value="푸에고">푸에고</option>   
	<option value="도미니카">도미니카</option>   
	<option value="이구아나">이구아나</option>   
	<option value="레가토">레가토</option> 
	<option value="핑크파티">핑크파티</option> 
	<option value="오션송">오션송</option>
	<option value="카렌쟈">카렌쟈</option>
	<option value="색장미(블루)">색장미(블루)</option>
	<option value="클럽니카">클럽니카</option>
	<option value="카렌쟈">카렌쟈</option>
	
</select>
</div>

<div class="hw_clear"></div>
<h4 class="ma_title">소매가격</h4> <p class="hw_green">소매가격을 적어주세요</p>
<div class="hw_clear"></div>	
<div class="hw_infouse_01" ><input name="SALE_PRICE" id="AXInputMoney" value='${SALE_PRICE}' class="AXInput" />
<span>원</span>
</div>

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


