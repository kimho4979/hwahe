<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%   
   if (request.getParameter("REG_DATE")==null){
    request.setAttribute("pageTitle", "소비동향 등록"); 
    request.setAttribute("CHUL_NO", "0001");
    request.setAttribute("GOOD_NAME", "비탈");
    request.setAttribute("SAN_CD", "1111");
    request.setAttribute("pageopen", "");
    request.setAttribute("pageopen2", "display:none");            
  }
  else{
    request.setAttribute("pageTitle", "소비동향 수정");
    request.setAttribute("pageopen", "display:none");
    request.setAttribute("pageopen2", "");
    request.setAttribute("pagecheck", "1");
    request.setAttribute("REG_DATE", request.getParameter("REG_DATE"));
    request.setAttribute("CHUL_NO", request.getParameter("CHUL_NO"));
    request.setAttribute("GOOD_NAME", request.getParameter("GOOD_NAME"));      
    request.setAttribute("ITEM_CD", request.getParameter("ITEM_CD"));
    request.setAttribute("QTY", request.getParameter("QTY"));    
    request.setAttribute("BIGO", request.getParameter("BIGO"));
    request.setAttribute("SAN_CD", request.getParameter("SAN_CD"));
    
  }   
%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, user-scalable=no">
	<title>소비동향 ㅣ aT 화훼유통정보 모니터요원 입력시스템</title>
    <script type="text/javascript" src="<c:url value='/axisj/jquery/jquery.min.js' />"></script>
	<script type="text/javascript" src="<c:url value='/axisj/dist/AXJ.min.js' />"></script>
	<script type="text/javascript" src="<c:url value='/axisj/lib/AXUpload5.js' />"></script>
	<script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/ax5-polyfill.js' />"></script>
	<script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/axjApp.js' />"></script>
	<script type="text/javascript" src="<c:url value='/js/mobile/common/chulha.js' />"></script>

	<link rel="stylesheet" type="text/css" href="<c:url value='/axisj/axicon/axicon.min.css' />" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/arongi/mobileAXJ.min.css' />" />
	<link rel="stylesheet" type="text/css" href="/css/mobile/common/layout.css"/>
	</head>
  <script type="text/javascript">
var myProgress = new AXProgress();
var myGrid = new AXGrid();

var myModal = new AXModal();
var REG_MONTH="";
var CHUL_NO="";
var MONTH_GUBN="";
var STATUS_CD="";
var BIGO="";

function checkData(){
	// 일자
	if($('#REG_DATE').val() == '')
	{
		alert('조사일자를 선택하세요');
		return false;
	}
	
	// 일자
	if($('#QTY').val() == '')
	{
		alert('거래량을 입력하세요');
		return false;
	}
	
	return true;
}


function grid_ajax(pageList){   		     		    	          	 
    $.ajax({
        type : 'get',
        url : "/mntr/mba01/gridList.json",
        data :  '&CHUL_NO='+CHUL_NO,
        dataType : '',   	           
        success : function(res){   
        	if(res.list.length == undefined){
        		var data = {
   					list:  [],   				
   					page:{
   						pageNo:  (pageList==undefined)? '1':pageList.pageNo, // 현재페이지
   						pageCount: 0, // 전체 페이지수
   						listCount: 0 // 우측하단 카운트 표시 갯수
   					}
   				};
               	
   				myGrid.setData(data);
              }else{
                  var pageCount2 =  res.list.length/3;
                  var pageRest = res.list.length/3;
                 
                  if(pageRest ==0){
               	   pageRest=0;
                  }else {
               	   pageRest=1;
                  }                              
                  pageCount2 = Math.floor(pageCount2);
                 var pageResult = pageCount2;
                 if(pageList!=undefined){
      	           if(pageResult< pageList.pageNo){
      	        	   alert('조회가능한 데이터가 없습니다.');
      	        	   return false;
      	           }
                 }
      		
                 var list1=[];
                 if(pageList==undefined){
              	   var startCount=0;
                     var  endCount=3;
              	   for(var i=startCount;  i<endCount; i++){
      	        		list1.push(res.list[i]);
      	        	
      	        }
              	 
                 }else{
              	   for(var i=pageList.startCount;  i<pageList.endCount; i++){
      	        		list1.push(res.list[i]);
      	        }
              	   
                 }
                  var data = {
   					list:  list1,   				
   					page:{
   						pageNo:  (pageList==undefined)? '1':pageList.pageNo, // 현재페이지
   						pageCount: pageResult, // 전체 페이지수
   						listCount: res.list.length // 우측하단 카운트 표시 갯수
   					}
   				};
               	
   				myGrid.setData(data);
              }
        	
        },
    });      	   	    
};


var fnObj = {
pageStart: function(){
	CHUL_NO='${SESSION_CMP_CODE}';
 	grid_ajax();

	$('#sub_top_menu a span').removeClass('a_purple');
	$('#sub_top_menu a span').eq($('#sub_top_menu a span').index()+4).addClass('a_purple');
	
	$.ajax({
   		type : "post",
   		url : "/mdc01/selectDeadLineDate.json",
   		data : {
   		},
   		dataType : '',
   		success : function(res){
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
    
    $("#lo3").hide();
    	
	myGrid.setConfig({
		targetID : "AXGridTarget",
		theme : "AXGrid",
		fixedColSeq : '',
		fitToWidth:true,
		colGroup : [
			{ 
				key: "descSeq", label: "번호", width: "40", align:"center", formatter:function(){
    			return  (this.index + 1) + ( ( this.page.pageNo - 1) * this.page.pageSize );
			}},
			{
    			key: "btns", label: "삭제", width: "40", align: "center", formatter: function () {
    			return '<button type="button" name="delete" onclick="fnObj.getCheckedList(' + this.index + ');"><i class="axi axi-trash-o"></i></button>';
			}},
			{key:"CHUL_NO", label:"출하코드", width:"80", align:"center"},   
			{key:"REG_DATE", label:"일자", width:"140", align:"center", pk:true},                 
			{key:"PUM_NAME", label:"품목명", width:"140", align:"center", display:false},
			{key:"GOOD_NAME", label:"품종명", width:"100", align:"center"}, 	                                    	                     	                  
			{key:"QTY", label:"거래량", width:"100", align:"right", formatter:"money"},    	                                 
			{key:"BIGO", label:"내용", width:"600"},    	  
			{key:"SEQ_NO", label:"일련번호", width:"80"},
			{
				key: "btns", label: "수정", width: "40", align: "center", formatter: function () {
				return '<button type="button" name="update" onclick="fnObj.getCheckedList1update(' + this.index + ');"><i class="axi axi-mode-edit"></i></button>';
			}}
		],

		page:{
			paging:true,
			pageSize:3,
			onchange: function(pageNo){
				var pageNo2=this.pageNo;
				var pageSize = this.pageSize;
				var pageList={
					pageNo : pageNo,
					startCount : ((pageNo2-1) *pageSize),
					endCount : pageNo2 * pageSize
				};
				if(pageList.pageNo!=undefined){
					grid_ajax(pageList);
				}
			}
		},
		colHeadAlign:"center",
	}); 
	},
	getCheckedList : function(index) {
		if (!confirm("정말 삭제 하시겠습니까?"))
    		return;
		
			var deleteValue = [];

			$.Event(event).stopPropagation(); // 버튼클릭 이벤트가 row click 이벤트를 발생시키지 않도록 합니다.
			var item = myGrid.list[index];
			value=item;
			deleteValue =   (value.REG_DATE+','+value.PUM_NAME+','+value.GOOD_NAME+','+value.CHUL_NO+','+value.SEQ_NO+'!');
	           
			$.ajax({
				type : 'POST',
				url : "/mntr/mba01/deleteCnsmpTrendInput.json",
	          	data :deleteValue,
	          	dataType : '',   	           
	          	success : function(res){    
	          		alert('삭제되었습니다');
					grid_ajax();
				},
			}); 
		
	},
	getCheckedList1update: function(index){
		if(confirm("작황정보을 수정하시겠습니까?") == true){
			$("#lo1").hide();
			$("#lo3").show();
			$("body").scrollTop(0);
			
			var item = myGrid.list[index];
			value=item;
			seqNo = value.SEQ_NO;
			
			$.ajax({
				type : 'post',
				url : '/mntr/mba01/gridListSeq.json',
				data : {
					seqNo : seqNo
				},
				dataType : '',
				success : function(res){
					var val = res.result;
					$("#REG_DATE").val(val.regDate);
					$("#PUM_NAME").val(val.pumName);
					$("#GOOD_NAME").val(val.goodName);
					$("#QTY").val(val.qty);
					$("#BIGO").val(val.bigo);
					$("#CHUL_NO").val(val.chulNo);
					$("#SEQ_NO").val(val.seqNo);
					
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
			});
   	 	}
	},
  	removeList: function(){
		var checkedList = myGrid.getCheckedList(0);// colSeq
		alert(checkedList);
		if(checkedList.length == 0){
			alert("선택된 목록이 없습니다. 삭제하시려는 목록을 체크하세요");    
			return;
		}
		if(!confirm("정말 삭제 하시겠습니까?")) return;
      
		var removeList = [];
		$.each(checkedList, function(){
			removeList.push({no:this.no});
		});
		myGrid.removeList(removeList); // 전달한 개체와 비교하여 일치하는 대상을 제거 합니다. 이때 고유한 값이 아닌 항목을 전달 할 때에는 에러가 발생 할 수 있습니다.
	},
	submit: function(){
		if(!checkData()){
			return;
		}
				
		var frm = document["frm_ssq"];
		if(confirm("등록하시겠습니까?")==true){
		$.ajax({
			type : "POST",
			url : "/mntr/mba01/insertCnsmpTrendInput.json",
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
		
		var frm = document["frm_ssq"];
		if(confirm("수정하시겠습니까?")==true){
		var formData = new FormData(frm);
		$.ajax({
			type : "POST",
			url : "/mntr/mba01/updateCnsmpTrendInput.json",
			data : formData,
			contentType: false,
			processData: false,
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
};

$(document).ready(function(){
	fnObj.pageStart();
	myGrid.changeGridView({
		viewMode:"mobile"
	});
});
   
</script>
</head>
<!--  header -->	
<jsp:include page="../common/common.jsp"></jsp:include>
<!--  header end -->
	
	<form name="frm_ssq">
	<div class="hw_clear"></div> 
	<div class="ma_half1_1" id="content"><span class="half_title2">소비동향</span></div>
	<!--  날짜선택 -->
	<div class="all_select_part">
        <span class="select_date_title1">조사일자</span>
        <span class="select_date_title2">조사일자를 선택하세요</span>
    </div>
    <div class="radio_btn_all">
    	<label for="REG_DATE" class="blind">조사일자 선택</label>
		<input type="text" name="REG_DATE" id="REG_DATE" class="calender_datebox_1"  value="${REG_DATE}" onkeydown="return false;" />
    </div>
	<!--  날짜선택 END -->
  	<input type=hidden name="CHUL_NO" value="${SESSION_CMP_CODE}"/>
	<input type=hidden name="SAN_CD" value="${SESSION_SAN_CD}"/>
	<input type=hidden id="SEQ_NO" name="SEQ_NO" value="${result.seqNo }"/>
	<input type=hidden id="CHUL_NO" name="CHUL_NO" value="${result.chulNo }"/>

    <div class="all_select_part">
        <span class="select_date_title1">품종선택</span>
        <span class="select_date_title2">품종을 선택하세요</span>
    </div>
    <div class="radio_btn_all">
        <label class="hw_item_search_title" for="PUM_NAME">품목검색</label>
        <select name="PUM_NAME"   id="PUM_NAME" class="item_search_select">
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
        <span class="select_date_title1">거래량 입력</span>
        <span class="select_date_title2">거래량을 적어주세요</span>
    </div>
    <div class="radio_btn_all">
    	<label for="QTY" class="blind">거래량 입력</label>
    	<input type="tel" id="QTY" name="QTY" class="text_input"/>속
    </div>
    <div class="all_select_part">
        <span class="select_date_title1">소비동향 내용요약</span>
        <span class="select_date_title2">소비동향 내용을 200자 이내로 적어주세요
	</span>
    </div>
    <div class="radio_btn_all2">
    	<label for="BIGO" class="blind">소비동향 내용요약 입력</label>
    	<textarea id="BIGO" name="BIGO" class="message_input"></textarea>
    </div>
    </form>
	<div id="rt_sch_btn">
	  <div id="rt_sch_btn_lay" style="cursor:pointer;">
           <ul>
             <li class="lo2" id="lo1"><button onclick="fnObj.submit();"  style="display:block; margin:0 auto;">등록하기</button></li>
             <li class="lo2" id="lo3"><button onclick="fnObj.submit2();"  style="display:block; margin:0 auto;">수정하기</button></li>
           </ul>
         </div>
     </div>    
    <table class="table_chart">
 	<tr>
        </tr>                                                  
    </table>
     <div id="AXGridTarget" style="height:400px;"></div>	    

   </div>
  <div id="bottom">
      <li class="lay1">
          <a href="/mba01/mba01.do"><button type=button class="pcver_btn">pc버전</button></a> 
          <a href="javascript:window.scrollTo(0,0)"><button type=button class="up_btn">맨위로</button></a>          
      </li>
      <li class="lay2">
      	  <address class="copyright_address">Copyright By <span class="ft_green">화훼유통정보시스템 모바일.</span> All rights reserved.</address>
      </li>
  </div>
  </div>
</body>
</html>
