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
<title>모니터요원 입력시스템-재배동향 입력</title>
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
  
  <script type="text/javascript">
var myProgress = new AXProgress();
var myGrid = new AXGrid();
var myGrid1 = new AXGrid();
var myModal = new AXModal();
var REG_DATE="";
var CHUL_NO="";
var MONTH_GUBN="";
var STATUS_CD="";
var BIGO="";

 function grid_ajax(){   
	 	var REG_DATE1 = $('#REG_DATE1').val();
	 	var REG_DATE2 = $('#REG_DATE2').val();
	 	var PUM_NAME = $('#PUM_NAME').val();
	 	var GOOD_NAME = $('#GOOD_NAME').val();
	 	var STATUS = $('#STATUS').val();
	 
       $.ajax({
           type : 'post',
           url : "/mntr/mac01/gridList.json",
           data : {
				CHUL_NO : CHUL_NO,
				REG_DATE1 : REG_DATE1,
				REG_DATE2 : REG_DATE2,
				PUM_NAME : PUM_NAME,
				GOOD_NAME : GOOD_NAME,
				STATUS : STATUS
           },
           dataType : '',   	           
           success : function(res){
        	   if(res.list.length>0){
        		   myGrid.setList(res.list);	  
          	  }else{
          			myGrid.setList([]);	  
          	  }
           },
       });      	    
   };
   
   function grid_ajax1(){   
      $.ajax({
          type : 'post',
          url : "/mntr/mac01/gridListAll.json",
          data : {},
          dataType : '',   	           
          success : function(res){       
        	  if(res.list.length>0){
       		  	 myGrid1.setList(res.list);	  
         	  }else{
         		 myGrid1.setList([]);	  
         	  }
          },
      });      	    
  };

var fnObj = {
    pageStart: function(){
    	//alert("${SESSION_USER_ID}"+"${SESSION_CMP_CODE}"+"${SESSION_SAN_CD}");
    	CHUL_NO="${SESSION_CMP_CODE}";
    	//grid_ajax();    	        	
     
    	// $('input[type=radio]').bindChecked();
        myModal.setConfig({
				windowID:"myModalCT", width:1150,
				displayLoading:true,
	            scrollLock: false,
				onclose: function(){
				//toast.push("저장되었습니다.");	
				grid_ajax();
				grid_ajax1();
			}
		}); 
        myModal.setWidth("100%");
        
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
        
        $('#REG_DATE1').bindDate({align:"right", valign:"bottom", separator:"-", selectType:"d",  defaultSelectType:"d", defaultDate : "rd1",
			onchange:function(){
				//toast.push(Object.toJSON(this));
				grid_ajax();
			}
    	});
    	$('#REG_DATE2').bindDate({align:"right", valign:"bottom", separator:"-", selectType:"d",  defaultSelectType:"d", defaultDate : "rd2",
			onchange:function(){
				//toast.push(Object.toJSON(this));
				grid_ajax();
            }
        });
    	grid_ajax();
    	grid_ajax1();

    	$('#GOOD_NAME').hide();
    	$('#PUM_NAME').change(function(){
    		var pum = $('#PUM_NAME').val();
    		if(pum == "장미"){
    			$('#GOOD_NAME').show();
    		}else{
    			$('#GOOD_NAME').hide();
    		}
    	});
    	
    	 myGrid.setConfig({
    	             targetID : "AXGridTarget",
    	             theme : "AXGrid",
    	             fixedColSeq : '',
    	             fitToWidth:false,
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
    	                 {key:"REG_DATE", label:"조사일자", width:"80", align:"center", pk:true}, 
    	                 {key:"CHUL_NO", label:"출하코드", width:"80", align:"center", display:false},
    	 				 {key:"CHUL_NO2", label:"출하코드", width:"80",align:"center" ,formatter:function(){
    						var CHUL_NO = this.item.CHUL_NO;
    						var userId = "${sessionScope.SESSION_USER_ID}"; 
    						
    						if(userId == "admin" || userId == "at99999999"){
    							return CHUL_NO;
    						}else{
    							return "-";
    						}
    					 }}, 
    	                 {key:"SEQ_NO", label:"일련번호", width:"60", align:"center",display:false}, 
    	                 {key:"PUM_NAME", label:"품목명", width:"80", align:"center"},                     	                 
    	                 {key:"GOOD_NAME", label:"품종명", width:"80", align:"center"},    	                 
    	                 {key:"STATUS", label:"상태코드", width:"60", align:"center",display:false}, 
    	                 {key:"STATUS_NAME", label:"전년대비면적", width:"100", align:"center"},    
    	                 {key:"AREA", label:"재배면적", width:"80", align:"right", formatter:"money"},    	                                     	                 	                
    	                 {key:"BIGO", label:"동향", width:"200"},
    	                 {key:"REG_DT", label:"등록일", width:"100", align:"center"},
    	                 {key:"UPT_DT", label:"수정일", width:"100", align:"center"}
    	             ],
    	             colHeadAlign:"center",
    	            
    	             body : {
    	                 onclick: function(){  
    	                	var gridData= "REG_DATE=" + this.item.REG_DATE+"&PUM_NAME="+this.item.PUM_NAME+"&GOOD_NAME="+this.item.GOOD_NAME+"&CHUL_NO="+this.item.CHUL_NO+"&STATUS="+this.item.STATUS+"&AREA="+this.item.AREA
	                         +"&BIGO="+this.item.BIGO+"&SAN_CD="+this.item.SAN_CD+"&SEQ_NO="+this.item.SEQ_NO;
    	                	fnObj.modalOpen(gridData);          	    	                
    	                 },
    	                 ondblclick: function(){
    	                    
    	                 },
    	                 oncheck: function(){

    	                 }
    	             },

    	             page:{
    	                 paging:false
    	             }    	               	             
    	         }); 
    	 
    	 myGrid1.setConfig({
             targetID : "AXGridTargetAll",
             theme : "AXGrid",
             fixedColSeq : '',
             fitToWidth:false,
             colGroup : [
                 {key:"REG_DATE", label:"조사일자", width:"80", align:"center", pk:true}, 
                 {key:"CHUL_NO", label:"출하코드", width:"80", align:"center", display:false},
 				 {key:"CHUL_NO2", label:"출하코드", width:"80",align:"center" ,formatter:function(){
						var CHUL_NO = this.item.CHUL_NO;
						var userId = "${sessionScope.SESSION_USER_ID}"; 
						
						if(userId == "admin" || userId == "at99999999"){
							return CHUL_NO;
						}else{
							return "-";
						}
					 }}, 
                 {key:"SEQ_NO", label:"일련번호", width:"60", align:"center",display:false}, 
                 {key:"PUM_NAME", label:"품목명", width:"80", align:"center"},                     	                 
                 {key:"GOOD_NAME", label:"품종명", width:"80", align:"center"},    	                 
                 {key:"STATUS", label:"상태코드", width:"60", align:"center",display:false}, 
                 {key:"STATUS_NAME", label:"전년대비면적", width:"100", align:"center"},    
                 {key:"AREA", label:"재배면적", width:"100", align:"right", formatter:"money"},    	                                     	                 	                
                 {key:"BIGO", label:"동향", width:"200"},
                 {key:"REG_DT", label:"등록일", width:"100", align:"center"},
                 {key:"UPT_DT", label:"수정일", width:"100", align:"center"}
             ],
             colHeadAlign:"center"  	             
         }); 

     },//pageStart
     
     modalOpen: function(gridData){    	  		
    	  myModal.open({    		 
				type: "GET",
				url:"/mac01/ctvtTrendInput_popup.do",				
				pars:("&"+gridData).queryToObject(),
				top: 50,
				closeByEscKey:true
			});
    	  myModal.setWidth("100%");
	},
     
     appendGrid: function(index){
         var item = {amount:0};
         if(index == "last") {
             myGrid.appendList(item, myGrid.list.length);
         }else if(typeof index != "undefined"){
             myGrid.appendList(item, index);
         }else{
             myGrid.appendList(item);
         }
     },
     getCheckedList: function(){
	     	
         var checkedList = myGrid.getCheckedList(0);// colSeq
         
         if(checkedList.length == 0){
             alert("선택된 목록이 없습니다. 삭제하시려는 목록을 체크하세요");    
             return;
         }
        
         if(!confirm("정말 삭제 하시겠습니까?")) return;        	
        	 var obj2=checkedList;
             var deleteValue = [];
         $.each(obj2,function(key,value) {
         	deleteValue += (value.REG_DATE+','+value.PUM_NAME+','+value.GOOD_NAME+','+value.CHUL_NO+','+value.SEQ_NO+'!');
         });          
         $.ajax({
             type : 'post',
             url : "/mntr/mac01/deleteCtvtTrendInput.json",
             data :deleteValue,
             dataType : '',   	           
             success : function(res){                   	 
            	 alert('삭제되었습니다');
            	 grid_ajax();
            	 grid_ajax1();
             },
         }); 
         
     },
     removeList: function(){
         var checkedList = myGrid.getCheckedList(0);// colSeq
         alert(checkedList);
         if(checkedList.length == 0){
             alert("선택된 목록이 없습니다. 삭제하시려는 목록을 체크하세요");    
             return;
         }
         if(!confirm("정말 삭제 하시겠습니까?")) return;
         
         /// something do for server
         
         var removeList = [];
         $.each(checkedList, function(){
             removeList.push({no:this.no});
         });
         myGrid.removeList(removeList); // 전달한 개체와 비교하여 일치하는 대상을 제거 합니다. 이때 고유한 값이 아닌 항목을 전달 할 때에는 에러가 발생 할 수 있습니다.
     }
    };
 
$(document).ready(fnObj.pageStart);
</script>
   
</head>
<body>
<%@ include file="/WEB-INF/inc/IncHeader.jsp" %>
<article>
<div class="wrap">
<%@ include file="/WEB-INF/jsp/inc/IncMenu.jsp" %>


<div class="hw_content"><!--컨텐츠 내용들어가는곳 시작-->
	
<h3 class="hw_h3_ma"><div class="half1_white"></div><span class="half_title">재배동향 입력</span></h3>
<div class="hw_clear"></div>	
	
<div class="hw_infouse_01">  <p> <span class="purple"> ◎ 이용안내 :</span> 글을 작성하시려면 등록하기를 누르셔서 작성하시면 됩니다.</p></div>
<div class="hw_clear"></div>	
<div class="ma_btn_allbox">
		<button class="ma_add" type="button" value="등록하기" onclick="fnObj.modalOpen();">등록하기</button>
		<button class="ma_del" type="button" value="삭제하기" onclick="fnObj.getCheckedList();">삭제하기</button>
		<button class="ma_re" type="button" value="새로고침" onclick="grid_ajax();">새로고침</button>
</div>

<div style="width:600px; margin-bottom:10px;">
	<div class="selectWrap">
		<label class="blind" for="REG_DATE1">날짜선택하기</label>
		<input type="text" name="REG_DATE1" id="REG_DATE1" class="AXInput W100" value="" />
		-
		<label class="blind" for="REG_DATE2">날짜선택하기</label>
		<input type="text" name="REG_DATE2" id="REG_DATE2" class="AXInput W100" value="" />
	</div>
	<div class="selectWrap mt10">
		<label class="blind" for="PUM_NAME">품목 선택</label>
		<select id="PUM_NAME" name="PUM_NAME" onchange="grid_ajax();">
			<option value="">품목 선택</option>
			<option value="장미">장미</option>
		</select>
		<label class="blind" for="GOOD_NAME">품종 선택</label>
		<select name="GOOD_NAME" id="GOOD_NAME" onchange="grid_ajax();">
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
		<label class="blind" for="STATUS">상태 선택</label>
		<select name="STATUS" id="STATUS" onchange="grid_ajax();">
			<option value="">상태 선택</option>
			<option value="1">증가</option>
			<option value="2">비슷</option>
			<option value="3">감소</option>
		</select>
	</div>
</div>

<div class="hw_clear"></div>


<div class="hw_ma_grid">
 <div id="AXGridTarget" style="height:400px;"></div>
 <br/>
 <div id="AXGridTargetAll" style="height:400px;"></div>
</div><!--wrap 끝-->


</article>

<div class="hw_clear"></div>
<footer>
<%@ include file="/WEB-INF/inc/IncFooter.jsp" %>
</footer>
</body>
</html>