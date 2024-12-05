<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
  
<%
request.setAttribute("callBack", request.getParameter("callBack"));
request.setAttribute("itemIndex", request.getParameter("itemIndex"));
request.setAttribute("sysCd", request.getParameter("sysCd"));
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
  <link rel="stylesheet" type="text/css" href="<c:url value='/css/hw/common.css' />" />
  <link rel="stylesheet" type="text/css" href="<c:url value='/css/hw/main.css' />" />
  <link rel="stylesheet" type="text/css" href="<c:url value='/css/hw/main_nav.css' />" />
  <link rel="stylesheet" type="text/css" href="<c:url value='/css/hw/sub.css' />" />
   
  <!-- @@@@@@@@@@@@@@@@@@@@@@ css end @@@@@@@@@@@@@@@@@@@@@@ --> 
  
  <script type="text/javascript" src="<c:url value='/axisj/jquery/jquery.min.js' />"></script>
    <script type="text/javascript" src="<c:url value='/axisj/dist/AXJ.min.js' />"></script>
  <script type="text/javascript" src="<c:url value='/js/main_nav.js' />"></script>
   <script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/ax5-polyfill.js' />"></script>
  <script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/modal.js' />"></script>
  <script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/axjApp.js' />"></script>

 
 </head>

<body>
<div class="header_popup1">
	<p class="hw_popup_p">품목검색</p>
	</div>
	<article>
		<section>
			<span class="hw_popup_arrow"></span>
			<span class="popup_arrow_text">품목을 리스트에서 선택해 주세요.</span>			
			
			 <div id="AXGridTarget" style="height:420px;"></div> 
		</section>
	</article>

</body>


 <script type="text/javascript">
    var myGrid = new AXGrid();
	var FLOWER_CD = "";
	var SALE_DATE = ""; 
	var CMP_CD="";
	var callBackName = "${callBack}";
	var itemIndex = "${itemIndex}";
	var SysCd = "${sysCd}";
   
    
    function grid_ajax(){   	


       $.ajax({
           type : 'get',
           url : "/admin/searchAdminActiveProgList.json",
           data :  'sysCd='+SysCd,
           dataType : '',   	           
           success : function(res){               
               console.log(res.list);
             	 myGrid.setList(res.list);
             	 // $('#ITEM_CD').attr("value","국화");
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
      	                 {key:"progCd", label:"프로그램코드", width:"100", align:"center"}                     	                        	                           
      	             ],
      	             colHeadAlign:"center",
      	            
      	             body : {
      	                 onclick: function(){     
      	                	 
      	                	var aaa= this.item.progCd;
      	                          
      	                	//parent.document.getElementById("progCd").value=this.item.progCd; 
      	                	app.modal.save(window.callBackName, {
							progCd: this.item.progCd
						}, itemIndex);
      	                	
      	                	
      	             	 parent.myModal.close();
      	                 },
      	                 ondblclick: function(){
      	                    
      	                 },
      	                
      	                 oncheck: function(){
      	                     
      	                     
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