<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
    <%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%   
   if (request.getParameter("REG_DATE")==null){
    request.setAttribute("pageTitle", "공지 수정"); 
    String CHUL_NO=(String)session.getAttribute("SESSION_CMP_CODE");
    request.setAttribute("CONTENT", request.getParameter("CONTENT"));    
    request.setAttribute("TITLE", request.getParameter("TITLE"));
    request.setAttribute("pageopen", "");
    request.setAttribute("SEQ_NO", request.getParameter("SEQ_NO"));
    request.setAttribute("pageopen2", "display:none");            
  }
  else{
    request.setAttribute("pageTitle", "공지가격 수정");
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
				if(confirm("수정하시겠습니까?")==true){				
				$.ajax({
			           type : "POST",
			           url : "/admin/updateAdminNotice.json",
			           data : $(frm).serialize(),
			           dataType : '',   	           
			           success : function(res){	
			        	   parent.myModal.close();
			           },
			       });   
				}else{
					return;
				}
				//dialog.push( $(frm).serialize() );
				return false;
			},
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
<input type=hidden name="CHUL_NO" value="${CHUL_NO}"/>
<input type=hidden name="SAN_CD" value="${SESSION_SAN_CD}"/>
<input type=hidden name="SEQ" value="${SEQ_NO}"/>

<div class="hw_clear"></div>


<p class="hw_green"></p>
<div class="hw_clear"></div>	



</div>

<div class="hw_clear"></div>
<h4 class="ma_title">공지 제목</h4> <p class="hw_green"></p>
<div class="hw_clear"></div>	


	<textarea name="TITLE" id="TITLE" class="AXTextarea" style="box-shadow:inset 0px 0px 3px #ccc;width:100%;height:60px; margin-top:10px; ime-mode:active;box-sizing: border-box;" title="내용">${TITLE}</textarea>
<div class="hw_clear"></div>	
<div class="hw_clear"></div>
<h4 class="ma_title">공지 내용</h4> <p class="hw_green"></p>
<textarea name="CONTENT" id="CONTENT" class="AXTextarea" style="box-shadow:inset 0px 0px 3px #ccc;width:100%;height:60px; margin-top:10px; ime-mode:active;box-sizing: border-box;" title="내용">${CONTENT}</textarea>
<div class="hw_clear"></div>	     
<div><input style="${pageopen}"id="add" name="add" class="ma_add_01"  type="button" value="수정하기" onclick="fnObj.form.submit();" /></div>
  
<!-- <button class="AXButton" type="button" onclick="fnObj.form.submit();">저장하기</button> -->

</form>
</div>
</div><!--wrap 끝-->
</article>
</body>
</html>

