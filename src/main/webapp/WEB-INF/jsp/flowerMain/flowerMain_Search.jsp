<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%   
	String CMP_CD = request.getParameter("CMP_CD");
	String FLOWER_CD = request.getParameter("flowerCd");
	String SALE_DATE = request.getParameter("SALE_DATE");
	
    request.setAttribute("ITEM_CD", request.getParameter("CMP_CD"));
	request.setAttribute("FLOWER_CD", request.getParameter("FLOWER_CD"));
	request.setAttribute("SALE_DATE", request.getParameter("SALE_DATE"));
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <!-- META -->
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1, maximum-scale=1, minimum-scale=1" />
    <meta name="apple-mobile-web-app-capable" content="yes">
    
  <title>화훼유통정보시스템 ::: </title>
  <!-- @@@@@@@@@@@@@@@@@@@@@@ css begin @@@@@@@@@@@@@@@@@@@@@@ -->
  <link rel="stylesheet" type="text/css" href="<c:url value='/rMateChart/rMateChartH5/Assets/Css/rMateChartH5.css' />"/>   
  <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/axicon/axicon.min.css' />" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/arongi/AXJ.min.css' />" />
  <link rel="stylesheet" type="text/css" href="<c:url value='/css/common.css' />" />
  <link rel="stylesheet" type="text/css" href="<c:url value='/css/main.css' />" />
   
  <!-- @@@@@@@@@@@@@@@@@@@@@@ css end @@@@@@@@@@@@@@@@@@@@@@ --> 
  
  <script type="text/javascript" src="<c:url value='/axisj/jquery/jquery.min.js' />"></script>
    <script type="text/javascript" src="<c:url value='/axisj/dist/AXJ.min.js' />"></script>
  <script type="text/javascript" src="<c:url value='/js/main_nav.js' />"></script>
   <script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/ax5-polyfill.js' />"></script>
  <script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/axjApp.js' />"></script>
   <!-- @@@@@@@@@@@@@@@@@@@@@@ css end   @@@@@@@@@@@@@@@@@@@@@@ --> 
  <!-- rMateChartH5 라이센스 시작 -->
  <script type="text/javascript" src="<c:url value='/rMateChart/LicenseKey/rMateChartH5License.js' />"></script>
  <!-- rMateChartH5 라이센스 끝-->  
  <!-- 실제적인 rMateChartH5 라이브러리 시작-->
   <script type="text/javascript" src="<c:url value='/rMateChart/rMateChartH5/JS/rMateChartH5.js' />"></script>
  <!-- 실제적인 rMateChartH5 라이브러리 끝-->          
 
   <!-- rMateChartH5 테마 js -->
   <script type="text/javascript" src="<c:url value='/rMateChart/rMateChartH5/Assets/Theme/theme.js'/>"></script>

 </head>

<body>
	<div class="code_popup">
		<h2 class="blind">품목검색</h2>
		<article>
			<section>
				<div class="searhWrap" align="center">
					<lable class="tit" for="searchItemCd">품목검색</lable>
					<input name="searchItemCd" id="searchItemCd" onKeyDown="index_onKeyDown();" value='' class="searchCD" />
					<button class="btn05" onclick="grid_ajax();" style="cursor:pointer">조회</button>
				</div>
				<span class="hw_popup_arrow"></span>
				<span class="popup_arrow_text">품목을 리스트에서 선택해 주세요.</span>			
					<input type="hidden" name="FLOWER_CD" id="FLOWER_CD" value='<%=FLOWER_CD%>' />					
					<input type="hidden" name="ITEM_CD" id="ITEM_CD" value=''/>
					<input type="hidden" name="SALE_DATE" id="SALE_DATE" value='<%=SALE_DATE%>'/>
					<input type="hidden" name="CMP_CD" id="CMP_CD" value='<%=CMP_CD%>'/>						
				 <div id="AXGridTarget" style="height:420px;"></div> 
			</section>
		</article>
	</div>
</body>


 <script type="text/javascript">
    var myGrid = new AXGrid();
	var FLOWER_CD = "";
	var SALE_DATE = ""; 
	var CMP_CD="";
	
     function index_onKeyDown()
   {
        if(event.keyCode == 13)
        {
        	grid_ajax();
        }
   };
   
    function grid_ajax(){
    	
	 var searchItemCd = $("#searchItemCd").val();
       $.ajax({
           type : 'get',
           url : "/main/gridListMok.json",
           data :  '&FLOWER_CD='+$("#FLOWER_CD").val()+'&SALE_DATE='+$("#SALE_DATE").val()+'&CMP_CD='+$("#CMP_CD").val()+'&searchItemCd='+searchItemCd ,
           dataType : '',   	           
           success : function(res){           
             	 myGrid.setList(res.list);
           },
       });      	    
   };
   
    var fnObj = {
            pageStart: function(){
            	grid_ajax();
            	
            	myGrid.setConfig({
      	             targetID : "AXGridTarget",
      	             theme : "AXGrid",
      	             fixedColSeq : '',
      	             fitToWidth:true,
      	             colGroup : [       	              
      	                 {key:"PUM_NAME", label:"품목", width:"100", align:"center"}                     	                        	                           
      	             ],
      	             colHeadAlign:"center",
      	            
      	             body : {
      	                 onclick: function(){         	                	       	                
      	                	var aaa= this.item.PUM_NAME
      	                	
      	           			opener.document.getElementById("item2").value=this.item.PUM_NAME;   
      	                 	         
      	                	window.close();
      	                 },
      	                 ondblclick: function(){
      	                    
      	                 },
      	                
      	                 oncheck: function(){
      	                     
      	                     
      	                 }
      	             },

      	             page:{
      	            	 display:false
      	                 
      	             }     	            
      	             
      	         }); //grid1end	
            	
            },                                                         
           
        };
    jQuery(document).ready(fnObj.pageStart);  
    </script>
    
</html> 