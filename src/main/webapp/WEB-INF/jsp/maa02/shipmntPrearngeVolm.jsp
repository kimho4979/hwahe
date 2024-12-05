<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
	String pageNo=request.getParameter("pageNo"); 
%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, user-scalable=no">
<title>모니터요원 입력시스템-출하물량 입력  </title>
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
  <!-- @@@@@@@@@@@@@@@@@@@@@@ css end   @@@@@@@@@@@@@@@@@@@@@@ --> 
  <!-- rMateChartH5 테마 js -->
  <script type="text/javascript" src="<c:url value='/rMateChart/rMateChartH5/Assets/Theme/theme.js' />"></script>
  
  
  <script type="text/javascript">
var myProgress = new AXProgress();
var myGrid2 = new AXGrid();
var myGrid4 = new AXGrid();
var myModal = new AXModal();
var myModal2 = new AXModal();
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

var pageNo4="";
var pageSize3="";
var startCount3="";
var endCount3="";

var pageNo5="";
var pageSize4="";
var startCount4="";
var endCount4="";
   
   function grid_ajax2(){   		     		    	          	 
       $.ajax({
           type : 'get',
           url : "/mntr/maa02/gridList.json",
           data :  '&pageNo3='+pageNo3+'&pageSize2='+pageSize2+'&startCount2='+startCount2+'&endCount2='+endCount2+'&CHUL_NO='+CHUL_NO,
           dataType : '',   	           
           success : function(res){
        	   if(res.list.length > 0 ){
	               var pageCount2 =  res.list[0].TOTAL_COUNT/15;
	               var pageRest = res.list[0].TOTAL_COUNT%15;
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
	   				myGrid2.setData(data);
        	   }
           },
       });      	    
   };
   
   function grid_ajax4(){
	   var REG_DATE3 	= $("#REG_DATE3").val();
	   var REG_DATE4 	= $("#REG_DATE4").val();
	   var PUM_NAME2	= $("#PUM_NAME2").val();
	   var GOOD_NAME2 	= $("#GOOD_NAME2").val();
	   var MARKET_CD2 	= $("#MARKET_CD2").val();
       $.ajax({
           type : 'post',
           url : "/mntr/maa01/gridListTotal2.json",
           data : {
        	   pageNo5 : pageNo5,
        	   pageSize4 : pageSize4,
        	   startCount4 : startCount4,
        	   endCount4: endCount4,
        	   REG_DATE3 : REG_DATE3,
        	   REG_DATE4 : REG_DATE4,
        	   PUM_NAME2 : PUM_NAME2,
        	   GOOD_NAME2 : GOOD_NAME2,
        	   MARKET_CD2 : MARKET_CD2
           },
           dataType : '',   	           
           success : function(res){        
               var pageCount2 = 0;
               var pageRest = 0;
               var tempTotalCount = 0;
               if(res.list.length > 0 ){
            	   tempTotalCount =  res.list[0].TOTAL_COUNT;
            	   pageCount2 =  tempTotalCount/15;
            	   pageCount2 = Math.floor(pageCount2);
            	   pageRest = tempTotalCount%15;
            	   
            	   if(pageRest ==0){
                	   pageRest=0;
                   }else {
                	   pageRest=1;
                   }                              
                   
                   var pageResult = pageCount2+pageRest;
                   var data = {
       					list: res.list,   				
       					page:{
       						pageNo: res.list2.pageNo5, // 현재페이지
       						pageCount: pageResult, // 전체 페이지수
       						listCount: tempTotalCount // 우측하단 카운트 표시 갯수
       					}
       				};
       				myGrid4.setData(data);
               }               
           },
       });      	    
   };
   
   
var fnObj = {
    pageStart: function(){
    	CHUL_NO="${SESSION_CMP_CODE}";
    	grid_ajax2();
    	
    	// 검색 조건 Default Date 설정 시작
    	var date = new Date();
    	var year = date.getFullYear();
    	
        var month = date.getMonth()+1;
        month = month > 9 ? month : '0'+month;
        
        var byear = date.getFullYear();
        var bmonth = date.getMonth();
        if(bmonth==0){
        	bmonth=12;
        	byear = byear-1;
        }
        bmonth = bmonth > 9 ? bmonth : '0'+bmonth;
        
        var day = date.getDate();
        day = day > 9 ? day : '0'+day;
        
        var dt = year + "-" + month + "-" + day;
        var bdt = byear + "-" + bmonth + "-" + day;
        
        var rd1 = $('#REG_DATE1').val(bdt);
        var rd2 = $('#REG_DATE2').val(dt);
        var rd3 = $('#REG_DATE3').val(bdt);
        var rd4 = $('#REG_DATE4').val(dt);
        // 검색 조건 Default Date 설정 끝
    	
    	$("#AXInputDate").bindDate({align:"right", valign:"bottom", separator:"/", defaultSelectType:"d", onchange:function(){
        }});
    	
    	grid_ajax4();
    	
    	$('#REG_DATE3').bindDate({align:"right", valign:"bottom", separator:"-", selectType:"d",  defaultSelectType:"d", defaultDate : "rd3",
			onchange:function(){
				grid_ajax4();
			}
    	});
    	$('#REG_DATE4').bindDate({align:"right", valign:"bottom", separator:"-", selectType:"d",  defaultSelectType:"d", defaultDate : "rd4",
			onchange:function(){
				grid_ajax4();
            }
        });
    	
    	$('#GOOD_NAME').hide();
    	$('#GOOD_NAME2').hide();
    	$('#PUM_NAME').change(function(){
    		var pum = $('#PUM_NAME').val();
    		if(pum == "장미"){
    			$('#GOOD_NAME').show();
    		}else{
    			$('#GOOD_NAME').hide();
    		}
    	});
    	$('#PUM_NAME2').change(function(){
    		var pum = $('#PUM_NAME2').val();
    		if(pum == "장미"){
    			$('#GOOD_NAME2').show();
    		}else{
    			$('#GOOD_NAME2').hide();
    		}
    	});
        
        myModal2.setConfig({
			windowID:"myModalCT2", width:1150,
			
			displayLoading:true,
         scrollLock: false,
			onclose: function(){
				//toast.push("myModal2 저장되었습니다.");	
				grid_ajax2();
				grid_ajax4();
			}
		}); 
        myModal2.setWidth("100%");
    	 myGrid2.setConfig({
             targetID : "AXGridTarget2",
             theme : "AXGrid",
             fixedColSeq : '',
             fitToWidth:true,    	             
             colGroup : [
                 {
                     key:"no", label:"checkbox", width:"30", align:"center", formatter:"checkbox", 
                     disabled:function(){
                         return false;
                         return (this.index % 2 != 0);
                     },
                     
                     checked:function(){
                         return false;
                       
                         return (this.index % 2 == 0);
                     }
                 },
                 {key:"REG_DATE_MON", label:"출하월", width:"60", align:"center", formatter:function(){
	 					var regDate = this.item.REG_DATE;
	 					if(regDate!= null){
	 						var dateArr=regDate.split('-');
		 					return dateArr[1];	
	 					}
	 				}},
				{key:"DAYS_GUBN", label:"일자", width:"80", align:"center", formatter:function(){
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
                 {key:"CHUL_NO", label:"출하코드", width:"80",align:"center", display:false},
				 {key:"CHUL_NO2", label:"출하코드", width:"80",align:"center" ,formatter:function(){
					var CHUL_NO = this.item.CHUL_NO;
					var userId = "${sessionScope.SESSION_USER_ID}"; 
					
					if(userId == "admin" || userId == "at99999999"){
						return CHUL_NO;
					}else{
						return "-";
					}
				 }},
                 {key:"GUBN", label:"출하구분코드", width:"90", align:"center", display:false},
                 {key:"SEQ_NO", label:"출하구분코드", width:"90", align:"center", display:false},
                 {key:"MARKET_NAME", label:"출하지역", width:"130", align:"center" },    
                 {key:"GOOD_NAME", label:"품종", width:"100", align:"center"},                  
                 {key:"QTY", label:"출하량", width:"80", align:"right", formatter:"money"},
                 {key:"GUBN_NAME", label:"출하구분", width:"80", align:"center"},
                 {key:"CMP_CD", label:"공판장코드", width:"80", display:false},         	                     	                     	                       	                 
                 {key:"BIGO", label:"출하내용", width:"150"},
                 {key:"REG_DT", label:"등록일", width:"100"},
                 {key:"UPT_DT", label:"수정일", width:"100"},
                 {key:"REG_DATE", label:"출하일", width:"100", align:"center"}
             ],
             colHeadAlign:"center",
             body : {
                 onclick: function(){  
					var CHANGE_NO = $('#CHANGE_NO').val();
                	var gridData= "REG_DATE=" + this.item.REG_DATE+"&CHUL_NO="+this.item.CHUL_NO+"&QTY="+this.item.QTY+"&DAYS_GUBN="+this.item.DAYS_GUBN
                     +"&MARKET_CD="+this.item.CMP_CD+"&GOOD_NAME="+this.item.GOOD_NAME+"&BIGO="+this.item.BIGO+"&SEQ_NO="+this.item.SEQ_NO+"&CHANGE_NO="+CHANGE_NO;	
                		fnObj.modalOpen2(gridData); 	    	                	
                 },
                 ondblclick: function(){                    
                 },                
                 oncheck: function(){                                         
                 }
             },

             page:{
                 paging:true,   
                 pageSize:15,
                 onchange: function(pageNo){                    
                	 pageNo3=this.pageNo;    	                     
                     pageSize2=this.pageSize;
                     startCount2 = ((pageNo3-1) *pageSize2)+1;
                     endCount2 = pageNo3 * pageSize2;    	                        
                     grid_ajax2();
                 	
                 }
             }    	                	            
         }); 

    	 myGrid4.setConfig({
             targetID : "AXGridTarget4",
             theme : "AXGrid",
             fixedColSeq : '',
             fitToWidth:true,    	             
             colGroup : [
                 /* {key:"REG_DATE", label:"출하일자", width:"100", align:"center", pk:true}, */    
                 {key:"DAYS_GUBN", label:"일자", width:"80", align:"center", formatter:function(){
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
                 {key:"CHUL_NO", label:"출하코드", width:"80",align:"center", display:false},
			 	 {key:"CHUL_NO2", label:"출하코드", width:"80",align:"center" ,formatter:function(){
					var CHUL_NO = this.item.CHUL_NO;
					var userId = "${sessionScope.SESSION_USER_ID}"; 
					
					if(userId == "admin" || userId == "at99999999"){
						return CHUL_NO;
					}else{
						return "-";
					}
				 }},
                 {key:"GUBN", label:"출하구분코드", width:"90", align:"center", display:false},
                 {key:"SEQ_NO", label:"출하구분코드", width:"90", align:"center", display:false},
                 {key:"MARKET_NAME", label:"출하지역", width:"130", align:"center" },    
                 {key:"GOOD_NAME", label:"품종", width:"100", align:"center"},                  
                 {key:"QTY", label:"출하량", width:"80", align:"right", formatter:"money"},
                 {key:"GUBN_NAME", label:"출하구분", width:"80", align:"center"},
                 {key:"CMP_CD", label:"공판장코드", width:"80", display:false},         	                     	                     	                       	                 
                 {key:"BIGO", label:"출하내용", width:"150"},
                 {key:"REG_DT", label:"등록일", width:"100"},
                 {key:"UPT_DT", label:"수정일", width:"100"}
             ],
             colHeadAlign:"center",
            
             body : {
                 onclick: function(){
                	 var session = "${sessionScope.SESSION_USER_ID}";
                	 if(session == "at99999999"){
                		 CHUL_NO = this.item.CHUL_NO;
                		 grid_ajax2();
                	 }else{
                		 
                	 }    	    	                	
                 },
                 ondblclick: function(){                    
                 },                
                 oncheck: function(){                                         
                 }
             },

             page:{
                 paging:true,   
                 pageSize:15,
                 onchange: function(pageNo){                    
                	 pageNo5=this.pageNo;    	                     
                     pageSize4=this.pageSize;
                     startCount4 = ((pageNo5-1) *pageSize4)+1;
                     endCount4 = pageNo5 * pageSize4;    	                        
                     grid_ajax4();
                 	
                 }
             }    	                	            
         }); 
    	 
    	 
     },
     
	 modalOpen2: function(gridData){

			var CHANGE_NO = $('#CHANGE_NO').val();
	    	gridData += "&CHANGE_NO="+CHANGE_NO;
	    	  myModal2.open({    		 
					type: "GET",
					url:"/maa02/shipmntPrearngeVolm_popup.do",				
					pars:("&"+gridData).queryToObject(),
					top:50,
					closeByEscKey:true
				});	
	    	  myModal2.setWidth("100%");
		},
     getCheckedList2: function(){
	     	
    	  var checkedList = myGrid2.getCheckedList(0);// colSeq
          
          if(checkedList.length == 0){
              alert("선택된 목록이 없습니다. 삭제하시려는 목록을 체크하세요");    
              return;
          }
         
          if(!confirm("정말 삭제 하시겠습니까?")) return;        	
         	 var obj2=checkedList;
              var deleteValue = [];
          $.each(obj2,function(key,value) {
          	deleteValue +=  (value.REG_DATE+','+value.PUM_NAME+','+value.GOOD_NAME+','+value.CHUL_NO+','+value.GUBN+','+value.CMP_CD+','+value.SEQ_NO+'!');
          });          
          $.ajax({
              type : 'post',
              url : "/mntr/maa01/deleteShipmntPrearngeVolm.json",
              data :deleteValue,
              dataType : '',   	           
              success : function(res){
            	  alert("삭제되었습니다.");
             	 grid_ajax2();
             	grid_ajax4();
              },
          }); 
          
      }
};

    $(document).ready(fnObj.pageStart);
    
    function deadlineCheck(){
    	$.ajax({
    		type : "post",
    		url : "/mdc01/selectDeadLineDate.json",
    		data : {
    		},
    		dataType : '',
    		success : function(res){
    			//res.result.deadlineDate
    			var d = new Date();
    			var thisMonth = (d.getMonth() + 1);
    			var thisDay = d.getDate();
    			
    			if(res.result.deadlineGubn=='this'){
       				// 이번달
        			if(thisDay>res.result.deadlineDate){
        			   alert(thisMonth+"월 출하물량은 마감되었습니다.\n다음달 출하물량을 등록해주세요.");
        			}
       			}else{
       				if('${pagecheck}' != "1" ){
       					// 다음달
	           			if(thisDay>res.result.deadlineDate){
	           				// 오늘이 마감일보다 클경우
	           				alert((thisMonth-1)+"월 출하물량은 마감되었습니다.\n"+thisMonth+"월 출하물량을 등록해주세요.");
	           			}else{
	           				thisMonth = thisMonth;
	           			}
           			}
       			}
    		}
    	});
    	fnObj.modalOpen2();
    }
</script>
   
</head>
<body>
<%@ include file="/WEB-INF/inc/IncHeader.jsp" %>
<article>
<div class="wrap">

<%@ include file="/WEB-INF/jsp/inc/IncMenu.jsp" %>

<div class="hw_content"><!--컨텐츠 내용들어가는곳 시작-->
	
<div class="ma_all">
	<div class="ma_half1"><!-- <div class="half1_white"></div> --><span class="half_title">출하물량 입력</span></div>
</div>
<div class="hw_clear"></div>	
<div class="hw_infouse_01">  <p> <span class="purple"> ◎ 이용안내 :</span> 글을 작성하시려면 등록하기를 누르셔서 작성하시면 됩니다.</p></div>
<div class="hw_clear"></div>	
	<div class="shipment_schedule_all">
		<div class="ma_btn_allbox">
			<button  class="ma_add" id="btn2" onclick="deadlineCheck();">등록하기</button>
			<button  class="ma_del" onclick="fnObj.getCheckedList2();">삭제하기</button>
			<button  class="ma_re" onclick="grid_ajax2();">새로고침</button>
		</div>
		<div class="hw_ma_grid3">
		<div id="AXGridTarget2" style="height:400px;"></div>
		</div><!--wrap 끝-->
	</div>	
	<div class="hw_clear"></div>
	
	<div class="shipment_schedule_all">
		<div style="margin-bottom:10px; margin-top:10px;">	
			<div class="selectWrap">
				<label class="blind" for="REG_DATE3">날짜선택하기</label>
				<input type="text" name="REG_DATE3" id="REG_DATE3" class="AXInput W100" value="" />
				-
				<label class="blind" for="REG_DATE4">날짜선택하기</label>
				<input type="text" name="REG_DATE4" id="REG_DATE4" class="AXInput W100" value="" />
			</div>
			<div class="selectWrap mt10">
				<label class="blind" for="PUM_NAME2">품목선택</label>
				<select id="PUM_NAME2" name="PUM_NAME2" onchange="grid_ajax4();">
					<option value="">품목 선택</option>
					<option value="장미">장미</option>
				</select>
				
				<label class="blind" for="GOOD_NAME2">품종선택</label>
				<select name="GOOD_NAME2" id="GOOD_NAME2" onchange="grid_ajax4();">
					<option value="">품종 선택</option>
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
				
				<label class="blind" for="MARKET_CD2">공판장선택</label>
				<select name="MARKET_CD2" id="MARKET_CD2" onchange="grid_ajax4();" >
					<option value="">공판장 선택</option>
			 		<option value="0000000001"> aT화훼공판장(양재동)  </option>                 
			    	<option value="1508500020"> 부산화훼공판장(엄궁동) </option>
				    <option value="6068207466"> 부산경남화훼농협(강동동) </option>
				    <option value="4108212335"> 광주원예농협(풍암) </option>
				    <option value="3848200087"> 한국화훼농협(음성) </option>
				    <option value="1288202296"> 한국화훼농협(과천) </option>
				    <option value="9999999999"> 기타지역</option>
			 	</select>
			 </div>
		</div>
		<!-- <div class="shipment_schedule_title">
			<div class="half1_purple"></div>
			<span class="half_title_purple">전체 출하물량 리스트</span>
		</div> -->
		<div class="hw_ma_grid3">
		<div id="AXGridTarget4" style="height:400px;"></div>
		</div><!--wrap 끝-->
	</div>	
	</div>
	</div>
</article>

<div class="hw_clear"></div>

<footer>
<%@ include file="/WEB-INF/inc/IncFooter.jsp" %>
</footer>
</body>
</html>