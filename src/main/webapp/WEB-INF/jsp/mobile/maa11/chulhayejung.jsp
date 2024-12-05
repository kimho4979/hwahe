<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%   

String sessionCompCode = (String)session.getAttribute("SESSION_CMP_CODE");

if(sessionCompCode != null){
	if("nresearch".equals(sessionCompCode)){
		response.sendRedirect("/research/main.do");
	}
}


   if (request.getParameter("REG_DATE")==null){
    request.setAttribute("pageTitle", "출하예정물량 등록"); 
    String CHUL_NO=(String)session.getAttribute("SESSION_CMP_CODE");
    request.setAttribute("CHUL_NO", CHUL_NO);        
    request.setAttribute("GOOD_NAME", "비탈");
    request.setAttribute("pageopen", "");
    request.setAttribute("pageopen2", "display:none");            
  }
  else{
    request.setAttribute("pageTitle", "출하예정물량 수정");
    request.setAttribute("pageopen", "display:none");
    request.setAttribute("pageopen2", "");
    request.setAttribute("pagecheck", "1");
    request.setAttribute("REG_DATE", request.getParameter("REG_DATE"));
    request.setAttribute("CHUL_NO", request.getParameter("CHUL_NO"));  
    request.setAttribute("GOOD_NAME", request.getParameter("GOOD_NAME"));  
    request.setAttribute("MARKET_CD", request.getParameter("MARKET_CD"));    
    request.setAttribute("QTY", request.getParameter("QTY"));    
    request.setAttribute("BIGO", request.getParameter("BIGO"));           
  }  

%>
<!-- 
<!DOCTYPE html>
<html lang="ko" xmlns="http://www.w3.org/1999/xhtml">


	<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	 <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1, maximum-scale=1.0, minimum-scale=1" /> -->
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, user-scalable=no">
	<title>출하예정물량 ㅣ aT 화훼유통정보 모니터요원 입력시스템</title>		
	
	<link rel="shortcut icon" href="<c:url value='/axisj/ui//axisj.ico' />" type="image/x-icon" />
    <link rel="icon" href="<c:url value='/axisj/ui/axisj.ico' />" type="image/x-icon" />
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="<c:url value='/axisj/ui/AXJ.png' />" />
    <link rel="apple-touch-icon-precomposed" href="<c:url value='/axisj/ui/AXJ.png' />" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/arongi/page.css' />">
    <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/arongi/AXJ.min.css' />">
	
	<link rel="stylesheet" type="text/css" href="<c:url value='/axisj/axicon/axicon.min.css' />" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/arongi/mobileAXJ.min.css' />" />	
	<link rel="stylesheet" type="text/css" href="/css/mobile/common/layout.css"/>
	
	<script type="text/javascript" src="<c:url value='/axisj/jquery/jquery.min.js' />"></script>
	<script type="text/javascript" src="<c:url value='/axisj/dist/AXJ.min.js' />"></script>
	<script type="text/javascript" src="<c:url value='/axisj/lib/AXUpload5.js' />"></script>
	<script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/ax5-polyfill.js' />"></script>
	<script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/axjApp.js' />"></script>
	   
	</head>
<script>
var myGrid = new AXGrid();

var REG_MONTH="";
var CHUL_NO="";
var MONTH_GUBN="";
var STATUS_CD="";
var BIGO="";
var pageNo2="";
var pageSize="";
var startCount="";
var endCount="";

var pageNo3="";
var pageSize2="";
var startCount2="";
var endCount2="";

function checkData(){
	// 일자
	if($('input:radio[name=DAYS_GUBN]:checked').val() == undefined)
	{
		alert('일자를 선택하세요');
		return false;
	}
	
	// 일자
	if($('#QTY').val() == '')
	{
		alert('출하량을 입력하세요');
		return false;
	}
	
	return true;
}

function grid_ajax(){  
	
    $.ajax({
        type : 'get',
        url : "/mntr/maa01/gridListMobile.json",
        data :  '&pageNo2='+pageNo2+'&pageSize='+pageSize+'&startCount='+startCount+'&endCount='+endCount+'&CHUL_NO='+CHUL_NO,
        dataType : '',   	           
        success : function(res){  
        	if(res.list.length == undefined){
            	var data = {
   					list: [],   				
   					page:{
   						pageNo: res.list2.pageNo2, // 현재페이지
   						pageCount: 0, // 전체 페이지수
   						listCount: 0 // 우측하단 카운트 표시 갯수
   					}
   				};
   				myGrid.setData(data);
            }else{
            	 if(res.list[0].TOTAL_COUNT==null ){
                 	alert("stop");
                 }
                 var pageCount2 =  res.list[0].TOTAL_COUNT/3;
                 var pageRest = res.list[0].TOTAL_COUNT%3;
                 if(pageRest ==0){
              	   pageRest=0;
                 }else {
              	   pageRest=1;
                 }                              
                 pageCount2 = Math.floor(pageCount2);
                var pageResult = pageCount2+pageRest;
                 var data = {
   					list: res.list,   				
   					page:{
   						pageNo: res.list2.pageNo2, // 현재페이지
   						pageCount: pageResult, // 전체 페이지수
   						listCount: res.list[0].TOTAL_COUNT // 우측하단 카운트 표시 갯수
   					}
   				};
   				myGrid.setData(data);
            }
        },
    });      	    
};

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
           	
        	CHUL_NO='${SESSION_CMP_CODE}';    
        	grid_ajax();
        	
        	$('#sub_top_menu a span').removeClass('a_purple');
    		$('#sub_top_menu a span').eq($('#sub_top_menu a span').index()+1).addClass('a_purple');
    		
        	
        	$("#lo3").hide();
        	
        	if($("MARKET_CD").val() == '0000000100'){
        		$("#MARKET_CD option:eq(6)").attr("selected", "selected");
        		$("#hw_otherpart_search").attr("disabled",false);
        		$("#hw_otherpart_search").val("0000000100");
        	}
        	else if($("MARKET_CD").val() == '0000000200'){
        		$("#MARKET_CD option:eq(6)").attr("selected", "selected");
        		$("#hw_otherpart_search").attr("disabled",false);
        		$("#hw_otherpart_search").val("0000000200");
        	}
        	else if($("MARKET_CD").val() == '0000000300'){
        		$("#MARKET_CD option:eq(6)").attr("selected", "selected");
        		$("#hw_otherpart_search").attr("disabled",false);
        		$("#hw_otherpart_search").val("0000000300");
        	}
        	else if($("MARKET_CD").val() == '9999999999'){
        		$("#MARKET_CD option:eq(6)").attr("selected", "selected");
        		$("#hw_otherpart_search").attr("disabled",false);
        		$("#hw_otherpart_search").val("9999999999");
        	}
        	else{
        		$('#hw_otherpart_search').attr("disabled","disabled");
        	}
        	
        	$('#sub_top_menu a span').removeClass('a_purple');
    		$('#sub_top_menu a span').eq($('#sub_top_menu a span').index()+0).addClass('a_purple');
        	
        	//출하예정물량
    		 myGrid.setConfig({
	             targetID : "AXGridTarget",
	             theme : "AXGrid",
	             viewMode: "mobile", // ["grid","icon","mobile"]     	             
	             fitToWidth:true,    	             
	             colGroup : [	   
					{ key: "descSeq", label: "번호", width: "40", align:"center", formatter:function(){
					    return  (this.index + 1) + ( ( this.page.pageNo - 1) * this.page.pageSize );
					} 
					},
					{
					    key: "btns", label: "삭제", width: "40", align: "center", formatter: function () {
					    return '<button type="button" name="delete" onclick="fnObj.getCheckedList(' + this.index + ');"><i class="axi axi-trash-o"></i></button>';
					}
					},
					 {key:"REG_DATE_MON", label:"출하예정월", width:"60", align:"center", formatter:function(){
 	 					var regDate = this.item.REG_DATE;
 	 					if(regDate!= null){
 	 						var dateArr=regDate.split('-');
 		 					return dateArr[1];	
 	 					}
 	 				}},     
	                 {key:"DAYS_GUBN", label:"날짜구분", width:"100", align:"center", formatter:function(){
						var daysGubn = this.item.DAYS_GUBN;
						if(daysGubn == '1'){
							daysGubn = "초순";
							return daysGubn;
						}else if(daysGubn == '2'){
							daysGubn = "중순";
							return daysGubn;
						}else if(daysGubn == '3'){
							daysGubn = "하순";
							return daysGubn;
						}
					}},
	                 {key:"GUBN", label:"출하구분코드", width:"90", align:"center", display:false},
	                 {key:"SEQ_NO", label:"일련번호", width:"90", align:"center", display:false},
	                 {key:"REG_DATE", label:"출하예정일자", width:"90", align:"center", display:false},
	                 {key:"CHUL_NO", label:"출하코드", width:"80"},
	                 {key:"MARKET_NAME", label:"출하예정지역", width:"130", align:"center" },    
	                 {key:"GOOD_NAME", label:"품종", width:"100", align:"center"},                  
	                 {key:"QTY", label:"예정출하량", width:"90", align:"right", formatter:"money"},
	                 {key:"GUBN_NAME", label:"출하구분", width:"120", align:"center"},
	                 {key:"CMP_CD", label:"공판장코드", width:"80", display:false},
	                 {key:"BIGO", label:"출하내용", width:"400"},
	                 {
	      			    key: "btns", label: "수정", width: "40", align: "center", formatter: function () {
	      			    return '<button type="button" name="update" onclick="fnObj.getCheckedList1update(' + this.index + ');"><i class="axi axi-mode-edit"></i></button>';
	      			}
	      			}
	             ],
	             colHeadAlign:"center",
	            
	             body : {
	                 onclick: function(){  
	                	    	                	
	                 },
	                 ondblclick: function(){
	                    
	                 },
	                
	                 oncheck: function(){
	                         	                     
	                 }
	             },
	        page:{
	                    paging:true,   
	                    pageSize:3,
	                    onchange: function(pageNo){	
	                    	//alert(pageNo);
	                        pageNo2=this.pageNo;    	                      
	                        pageSize=this.pageSize;
	                        startCount = ((pageNo2-1) *pageSize)+1;
	                        endCount = pageNo2 * pageSize;
	                        grid_ajax();
	                    }
	                },
	                otherFunction: function(reqThis){
	    	            toast.push(reqThis.buttonItem.label+"//"+Object.toJSON(reqThis.item));
	    	        }		
	         }); 
        	
    		if(d>0&&d<=3){
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
			        	   location.reload();
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
				
				if($('#MARKET_CD').val()=="9999999999"){
					$('#ETC_CODE').val($('#hw_otherpart_search').prop("value"));
				}
				var frm = document["send-form"];
				if(confirm("수정하시겠습니까?")==true){
				$("#regMonth").attr("disabled",false);
				$.ajax({
			           type : "POST",
			           url : "/mntr/maa01/updateShipmntPrearngeVolmMobile.json",
			           data : $(frm).serialize(),
			           dataType : '',   	           
			           success : function(res){	
			        	   alert('수정되었습니다');
			        	   location.reload();
			           },
			       });
				$("#lo3").hide();
				$("#lo1").show();
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
        },
        getCheckedList: function(index){
	     	
        	if (!confirm("정말 삭제 하시겠습니까?"))
        		return;
        		var deleteValue = [];

	  			  $.Event(event).stopPropagation(); // 버튼클릭 이벤트가 row click 이벤트를 발생시키지 않도록 합니다.
	  	             var item = myGrid.list[index];
	  	             value=item;     	             
	  	             deleteValue =  (value.REG_DATE+','+value.PUM_NAME+','+value.GOOD_NAME+','+value.CHUL_NO+','+value.GUBN+','+value.CMP_CD+','+value.SEQ_NO+'!');
	  	             
	          $.ajax({
	              type : 'get',
	              url : "/mntr/maa01/deleteShipmntPrearngeVolm.json",
	              data :deleteValue,
	              dataType : '',   	           
	              success : function(res){                   	 
	              	alert('삭제되었습니다');
			        	location.reload();        	
	              },
	          });
         },
         // 출하예정물량 수정
         getCheckedList1update: function(index){
        	 
        	 if(confirm("출하예정물량을 수정하시겠습니까?") == true){
        		 $("#lo1").hide();
        		 $("#lo3").show();
        		 $("body").scrollTop(0);
        		 
        		 var item = myGrid.list[index];
        		 value=item;
        		 
        		 var daysGubn = value.DAYS_GUBN;
        		 $('input:radio[name=DAYS_GUBN]:input[value='+daysGubn+']').attr("checked", true);
        		 $("#PUM_NAME").val(value.PUM_NAME);
        		 $("#GOOD_NAME").val(value.GOOD_NAME);
        		 $("#CHUL_NO").val(value.CHUL_NO);
        		 $("#radio2").attr("checked","1");
        		 
        		 if(value.CMP_CD == '0000000100' || value.CMP_CD == '0000000200' || value.CMP_CD == '0000000300' || value.CMP_CD == '9999999999'){
             		$("#hw_otherpart_search").attr("disabled",false);
             		$("#hw_otherpart_search").val("0000000100");
             		 $("#MARKET_CD").val("9999999999");
             	}else{
             		$('#hw_otherpart_search').val("");
             		$('#hw_otherpart_search').attr("disabled","disabled");
             		 $("#MARKET_CD").val(value.CMP_CD);
             	}
        		 
        		 $("#QTY").val(value.QTY);
        		 $("#BIGO").val(value.BIGO);
        		 $("#SEQ_NO").val(value.SEQ_NO);
        	 }
         	}
    }; //fnObj End
    
   function marketChange(value){
	   //$('#hw_otherpart_search').val("1111111111");
	   $("#hw_otherpart_search option:eq(0)").prop("selected", true);
	   $('#hw_otherpart_search').attr("disabled","disabled");	
	   //$('#MARKET_CD').val(value);
	   if(value == '9999999999'){
			$('#hw_otherpart_search').removeAttr("disabled");
	   }else{
			$('#hw_otherpart_search').attr("disabled","disabled");
	   }
   }
    
    jQuery(document).ready(fnObj.pageStart);  
    
 
</script>
<!--  header -->	
<jsp:include page="../common/common.jsp"></jsp:include>
<!--  header end -->
	<div class="ma_half1_1"  id="content"><span class="white">출하예정물량</span></div>
      <div class="hw_clear"></div>
     <!-- 검색 시작-->
     
<form name="send-form" onsubmit="return false;">
<input type=hidden name="regDate"  id="regDate" value="${REG_DATE}"/>
<input type=hidden name="dayGubn"  id="dayGubn" value="${DAY_GUBN}"/>
<input type="hidden" id="CHUL_NO" name="CHUL_NO" value="${CHUL_NO}"/>
<input type="hidden" id="SEQ_NO" name="SEQ_NO" value="${SEQ_NO}"/>
<input type="hidden" id="ETC_CODE" name="ETC_CODE" value=""/>
<input type="hidden" id="CHANGE_NO" name="CHANGE_NO" value="${CHANGE_NO}"/>
<input type="hidden" id="SESSION_USER_ID" name="SESSION_USER_ID" value="${SESSION_USER_ID}" />
<input type="hidden" id="GUBN" name="GUBN" value="1" />

<div class="all_select_part">
        <span class="select_date_title1">일자</span>
        <span class="select_date_title2">일자를 선택하세요</span>
    </div>
    <div class="radio_btn_all">
    <label class="hw_item_search_title" for="regMonth">월선택</label>
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
		
		<%-- <input type="text" name="REG_DATE" id="REG_DATE" class="calender_datebox_1"  value="${REG_DATE}" /> --%>
		<input type="radio" id="DAYS_GUBN1" name="DAYS_GUBN" value="1" disabled="disabled"/><label for="DAYS_GUBN1">초순</label>
		<input type="radio" id="DAYS_GUBN2" name="DAYS_GUBN" value="2" disabled="disabled"/><label for="DAYS_GUBN2">중순</label>
		<input type="radio" id="DAYS_GUBN3" name="DAYS_GUBN" value="3" disabled="disabled"/><label for="DAYS_GUBN3">하순</label>
        <input type=hidden name="SAN_CD" value="${SESSION_SAN_CD}"/>
    </div>
    <div class="all_select_part">
        <span class="select_date_title1">품종선택</span>
        <span class="select_date_title2">품종을 선택하세요</span><!--화훼메인로고입니다-->
    </div>
    <div class="radio_btn_all">
		<label class="hw_item_search_title" for="PUM_NAME00">품목검색</label>
		<select name="PUM_NAME" id="PUM_NAME00" class="item_search_select">
			<option value="장미">장미</option>
		</select>
		<label class="hw_variety_search_title" for="GOOD_NAME">품종검색</label>
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
    <div class="all_select_part">
        <span class="select_date_title1">출하지역 선택</span>
        <span class="select_date_title2">출하지역을 선택하세요</span>
    </div>
    <div class="select_btn_all">
    	<label for="MARKET_CD" class="blind">출하지역 선택</label>
		<select id="MARKET_CD" name="MARKET_CD" class="select_area"  onchange="marketChange(this.value)">
			<option value="0000000001"selected> aT화훼공판장(양재동)  </option>                 
			<option value="1508500020"> 부산화훼공판장(엄궁동) </option>
			<option value="6068207466"> 부산경남화훼농협(강동동) </option>
			<option value="4108212335"> 광주원예농협(풍암) </option>
			<option value="3848200087"> 한국화훼농협(음성) </option>
			<option value="1288202296"> 한국화훼농협(과천) </option>
			<option value="9999999999"> 기타지역</option>
		</select>
 		<label class="hw_search_title" for="hw_otherpart_search">기타지역 선택</label>
		<select name="hw_otherpart_search" id="hw_otherpart_search" class="select_area" disabled="disabled">	 
		 	<option value=""> 선택 </option>
		 	<option value="0000000100"> 경부선 </option>                 
		    <option value="0000000200"> 호남선 </option>
		    <option value="0000000300"> 남대문 </option>
		    <option value="9999999999"> 기타 </option>
		 </select> 
    </div>
    
    
    <div class="all_select_part">
        <span class="select_date_title1">예상출하량 입력</span>
        <span class="select_date_title2">예상출하량을 적어주세요</span>
    </div>
    <div class="radio_btn_all">
    	<label for="QTY" class="blind">예상출하량 입력</label>
    	<input type="tel" name="QTY" id="QTY"class="text_input"/>
        <span class="input_title" >속</span>
    </div>
    <div class="all_select_part">
        <span class="select_date_title1">출하예정물량 요약</span>
        <span class="select_date_title2">요약정보를 입력하세요(100~300자)</span>
    </div>
    <div class="radio_btn_all2">
    	<label for="BIGO" class="blind">출하예정물량 요약 입력</label>
    	<textarea name="BIGO" id="BIGO"class="message_input"></textarea>
    </div>
           </form>
	<div id="rt_sch_btn">
	  <div id="rt_sch_btn_lay" style="cursor:pointer;">
           <ul>
              <li class="lo2" id="lo1"><button id="lo2" onclick="fnObj.form.submit();">등록하기</button></li>
             <li class="lo2" id="lo3"><button id="lo4" onclick="fnObj.form.submit2();">수정하기</button></li>
           </ul>
         </div>
     </div>    
   <br/><br/>
    
      <!-- </div> -->
    <table class="table_chart">
 	<tr>
        </tr>                                                  
    </table>   
<div id="AXGridTarget" style="height:100%;"></div>     
  <div id="bottom">
      <li class="lay1">
          <a href="/maa02/maa02.do"><button type=button class="pcver_btn">pc버전</button></a> 
          <a href="javascript:window.scrollTo(0,0)"><button type=button class="up_btn">맨위로</button></a>          
      </li>
      <li class="lay2">
      	  <address class="copyright_address">Copyright By <span class="ft_green">화훼유통정보시스템 모바일.</span> All rights reserved.</address>
      </li>
  </div>
  </div>
</body>

<script>


</script>
</html>