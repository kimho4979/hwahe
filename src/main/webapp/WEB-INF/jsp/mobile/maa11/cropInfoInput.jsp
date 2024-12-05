<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%   
   if (request.getParameter("regDate")==null){
    request.setAttribute("pageTitle", "작황동향 등록"); 
    request.setAttribute("chulNo", "0001");
    request.setAttribute("goodName", "비탈");
    request.setAttribute("pageopen", "");
    request.setAttribute("pageopen2", "display:none");            
  }else{
    request.setAttribute("pageTitle", "작황동향 수정");
    request.setAttribute("pageopen", "display:none");
    request.setAttribute("pageopen2", "");
    request.setAttribute("pagecheck", "1");
    request.setAttribute("regDate", request.getParameter("regDate"));
    request.setAttribute("chulNo", request.getParameter("chulNo"));
    request.setAttribute("goodName", request.getParameter("goodName"));
    request.setAttribute("bigo", request.getParameter("bigo"));
    request.setAttribute("status", request.getParameter("status"));
  }   
%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, user-scalable=no">
	<title>작황동향 ㅣ aT 화훼유통정보 모니터요원 입력시스템</title>

	<link rel="stylesheet" type="text/css" href="/css/mobile/common/layout.css"/>
	<link rel="shortcut icon" href="<c:url value='/axisj/ui//axisj.ico' />" type="image/x-icon" />
    <link rel="icon" href="<c:url value='/axisj/ui/axisj.ico' />" type="image/x-icon" />
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="<c:url value='/axisj/ui/AXJ.png' />" />
    <link rel="apple-touch-icon-precomposed" href="<c:url value='/axisj/ui/AXJ.png' />" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/arongi/page.css' />">
    <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/arongi/AXJ.min.css' />">
	
	<link rel="stylesheet" type="text/css" href="<c:url value='/axisj/axicon/axicon.min.css' />" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/arongi/mobileAXJ.min.css' />" />
	
	<script type="text/javascript" src="<c:url value='/axisj/jquery/jquery.min.js' />"></script>
	<script type="text/javascript" src="<c:url value='/axisj/dist/AXJ.min.js' />"></script>
	<script type="text/javascript" src="<c:url value='/axisj/lib/AXUpload5.js' />"></script>
	<script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/ax5-polyfill.js' />"></script>
	<script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/axjApp.js' />"></script>
	<script type="text/javascript" src="<c:url value='/js/common.js' />"></script>
<script>
var myGrid = new AXGrid();
var myModal = new AXModal();
var regDate="";
var chulNo="";
var MONTH_GUBN="";
var STATUS="";
var bigo="";
var seqNo="";
var selectedVal = null;

function checkData(){
	// 일자
	if($('#regDate').val() == '')
	{
		alert('조사일자를 선택하세요');
		return false;
	}
	
	// 작황정보
	if($('input:radio[name=status]:checked').val() == undefined)
	{
		alert('작황정보(전년대비)를 선택하세요');
		return false;
	}
	
	// 일조량
	if($('input:radio[name=statSun]:checked').val() == undefined)
	{
		alert('일조량를 선택하세요');
		return false;
	}
	
	// 기후
	if($('input:radio[name=statClimate]:checked').val() == undefined)
	{
		alert('기후를 선택하세요');
		return false;
	}
	
	if($("#ORIGINAL_FILE_NAME").val()==''){
		// 작황사진
		if($('#input_file').val() == '')
		{
			alert('작황사진을 선택하세요');
			return false;
		}	
	}
	return true;
}

function grid_ajax(pageList){   		     		    	          	 
    $.ajax({
        type : 'get',
        url : "/mntr/mab02/gridList.json",
        data : '&chulNo='+chulNo,
        dataType : '',   	           
        success : function(res){ 
        	 if(res.list.length == undefined){
              	var data = {
     					list: [],   				
     					page:{
     						pageNo: (pageList==undefined)? '1':pageList.pageNo, // 현재페이지
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
    	chulNo = '${SESSION_CMP_CODE}';
    	grid_ajax();
    	
    	$("#lo2").hide();
    	
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
	           				alert(thisMonth+"월 작황동향은 마감되었습니다.\n다음달 작황동향을 등록해주세요.");
	           				
	           				thisMonth = thisMonth+1;
	           				if(thisMonth<10){
	           					thisMonth = "0" + thisMonth;
	           				}
	           				
	           				if(thisMonth == "13"){
	           					thisMonth = "01";
	           					thisYear = thisYear+1;
	           				}
	           				
	           				$("#regDate").bindDate({align:"right", valign:"bottom", separator:"-", selectType:"d",  defaultSelectType:"d", minDate: thisYear+"-"+thisMonth+"-01",
	           		        	onchange:function(){
	           		        		var stDate = thisYear+"-"+thisMonth+"-01";
	           		        		if($("#regDate").val().replace(/-/gi,"") <  stDate.replace(/-/gi,"")){
	           		        			$("#regDate").val(thisYear+"-"+thisMonth+"-01");
	           		        		}
	           		            }
	           		        	}); 
	           			}else{
	           				if(thisMonth<10){
	           					thisMonth = "0" + thisMonth;
	           				}
	           				
	           				$("#regDate").bindDate({align:"right", valign:"bottom", separator:"-", selectType:"d",  defaultSelectType:"d", minDate: thisYear+"-"+thisMonth+"-01",
	           		        	onchange:function(){
	           		        		var stDate = thisYear+"-"+thisMonth+"-01";
	           		        		if($("#regDate").val().replace(/-/gi,"") <  stDate.replace(/-/gi,"")){
	           		        			$("#regDate").val(thisYear+"-"+thisMonth+"-01");
	           		        		}
	           		            }
	           		        	});
	           			}
           			}else{
           				var regDate = $("#regDate").val();
           				var regYear = regDate.substring(0,4);
           				var regMonth = regDate.substring(5,7);
           				
           				$("#regDate").bindDate({align:"right", valign:"bottom", separator:"-", selectType:"d",  defaultSelectType:"d", minDate: regYear+"-"+regMonth+"-01", maxDate: regYear+"-"+regMonth+"-31",
           		        	onchange:function(){
           		        		var stDate = regYear+"-"+regMonth+"-01";
           		        		if($("#regDate").val().replace(/-/gi,"") <  stDate.replace(/-/gi,"")){
           		        			$("#regDate").val(regYear+"-"+regMonth+"-01");
           		        		}
           		        		
           		        		var enDate = regYear+"-"+regMonth+"-31";
           		        		if($("#regDate").val().replace(/-/gi,"") >  enDate.replace(/-/gi,"")){
           		        			$("#regDate").val(regDate);
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
	           				alert((thisMonth-1)+"월 작황동향은 마감되었습니다.\n"+(thisMonth)+"월 작황동향을 등록해주세요.");
	           				thisMonth = thisMonth;
	           				if(thisMonth<10){
	           					thisMonth = "0" + thisMonth;
	           				}
	           				
	           				if(thisMonth == "13"){
	           					thisMonth = "01";
	           					thisYear = thisYear+1;
	           				}
	           				
	           				$("#regDate").bindDate({align:"right", valign:"bottom", separator:"-", selectType:"d",  defaultSelectType:"d", minDate: thisYear+"-"+thisMonth+"-01",
	           		        	onchange:function(){
	           		        		var stDate = thisYear+"-"+thisMonth+"-01";
	           		        		if($("#regDate").val().replace(/-/gi,"") <  stDate.replace(/-/gi,"")){
	           		        			$("#regDate").val(thisYear+"-"+thisMonth+"-01");
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
	           				
	           				$("#regDate").bindDate({align:"right", valign:"bottom", separator:"-", selectType:"d",  defaultSelectType:"d", minDate: thisYear+"-"+agoMonth+"-01",
	           		        	onchange:function(){
	           		        		var stDate = thisYear+"-"+thisMonth+"-01";
	           		        		if($("#regDate").val().replace(/-/gi,"") <  stDate.replace(/-/gi,"")){
	           		        			$("#regDate").val(thisYear+"-"+thisMonth+"-01");
	           		        		}
	           		            }
	           		        	});
	           			}
           			}else{
           				var regDate = $("#regDate").val();
           				var regYear = regDate.substring(0,4);
           				var regMonth = regDate.substring(5,7);
           				
           				$("#regDate").bindDate({align:"right", valign:"bottom", separator:"-", selectType:"d",  defaultSelectType:"d", minDate: regYear+"-"+regMonth+"-01", maxDate: regYear+"-"+regMonth+"-31",
           		        	onchange:function(){
           		        		var stDate = regYear+"-"+regMonth+"-01";
           		        		if($("#regDate").val().replace(/-/gi,"") <  stDate.replace(/-/gi,"")){
           		        			$("#regDate").val(regYear+"-"+regMonth+"-01");
           		        		}
           		        		
           		        		var enDate = regYear+"-"+regMonth+"-31";
           		        		if($("#regDate").val().replace(/-/gi,"") >  enDate.replace(/-/gi,"")){
           		        			$("#regDate").val(regDate);
           		        		}
           		            }
           		        	}); 
           			}
       			} 
       		}
       	});
    	/*     
    	$("#regDate").bindDate({align:"right", valign:"bottom", separator:"-", selectType:"d",  defaultSelectType:"d",
			onchange:function(){
			}});*/
    	
    	$('#sub_top_menu a span').removeClass('a_purple');
		$('#sub_top_menu a span').eq($('#sub_top_menu a span').index()+2).addClass('a_purple');
		
    	
    	// 병충해 유무 option값에 따른 이벤트 발생
    	$("#statInsectYn").change(function(){
    		if(this.value == 'Y'){
        		$("select[name=statInsectKind]").removeProp("disabled")
    		}else if(this.value == 'N'){
    			$('#statInsectKind').val("");
    			$("select[name=statInsectKind]").prop("disabled", true);
    		}
    	})
    	
    	
		myGrid.setConfig({
			targetID : "AXGridTarget",
			theme : "AXGrid",
			fixedColSeq : '',
			fitToWidth:true,
			colGroup : [
			            
						{ key: "descSeq", label: "번호", width: "40", align:"center", formatter:function(){
						    return  (this.index + 1) + ( ( this.page.pageNo - 1) * this.page.pageSize );
						} },
			            {
			                   key: "btns", label: "삭제", width: "40", align: "center", formatter: function () {
			                   return '<button type="button" name="delete" onclick="fnObj.getCheckedList(' + this.index + ');"><i class="axi axi-trash-o"></i></button>';
			               }
			           },
			        // checkbox 개체를 checked 된 상태로 만들기
			    {key:"regDate", label:"등록일자", width:"100", align:"center", pk:true},                     	                 
			    {key:"chulNo", label:"출하코드",align:"center", width:"80"},                     	                                              
			    {key:"pumName", label:"품목명",align:"center", width:"80"},
                {key:"goodName", label:"품종명",align:"center", width:"80"},
                {key:"uniqueColor", label:"꽃의고유색",align:"center", width:"80",formatter :"flowerColor"},
			    {key:"bigo", label:"작황내용", width:"600"},  
			    {key:"seqNo", label:"일련번호", width:"80"},   
			    {
      			    key: "btns", label: "수정", width: "40", align: "center", formatter: function () {
      			    return '<button type="button" name="update" onclick="fnObj.getCheckedList1update(' + this.index + ');"><i class="axi axi-mode-edit"></i></button>';
      			}
      			}
			   ],
			
			page:{
			    paging:true,
			    pageSize:3,
			    onchange: function(pageNo){
					//pageNo=1000;    	                
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
     
     submit: function(){
    	 if(!checkData()){
				return;
			}
    	 
    	 var frm = document["frm_ssq"];
			if(confirm("등록하시겠습니까?")==true){
	        var formData = new FormData(frm);
			  $.ajax({
				  	 type : "POST",
	                 url : "/mntr/mab02/insertCropInfoInput.json",
	                 data : formData,
	                 contentType: false,
	                 processData: false,
	                 success : function(res){   		
	                	 alert('등록되었습니다');
	                	 location.reload();
	                 },
	             }); 
			}else{
				return;
			}
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
				url : "/mntr/mab02/updateCropInfoInput.json",
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
		},
		
		getCheckedList1update: function(index){
			if(confirm("작황정보을 수정하시겠습니까?") == true){
				
				$("#lo1").hide();
				$("#lo2").show();
				$("body").scrollTop(0);
				
				var item = myGrid.list[index];
				value=item; 
				seqNo = value.seqNo;
				
				$.ajax({
					type : 'post',
					url : '/mntr/mab02/gridList.json',
					data : {
						seqNo : seqNo,
						chulNo : value.chulNo
					},
					dataType : '',
					success : function(res){
						var val = res.list[0];
						$("#regDate").val(val.regDate);
						$("#pumName").val(val.pumName);
						$("#goodName").val(val.goodName);
						$("#uniqueColor").val(val.uniqueColor);
						
						$('input:radio[name="status"]:radio[value="' + val.status + '"]').prop("checked", true);
						$('input:radio[name="statSun"]:radio[value="'+val.statSun+'"]').prop('checked', true);
						$('input:radio[name="statSize"]:radio[value="'+val.statSize+'"]').prop('checked', true);
						$('input:radio[name="statClimate"]:radio[value="'+val.statClimate+'"]').prop('checked', true);
						$('input:radio[name="statDefinition"]:radio[value="'+val.statDefinition+'"]').prop('checked', true);
						$('input:radio[name="statThick"]:radio[value="'+val.statThick+'"]').attr("checked",true);
						
						$("#statTemper").val(val.statTemper);
						
						$("#statColor").val(val.statColor);
						$("#statLength").val(val.statLength);
						$("#statThick").val(val.statThick);
												
						$("#statInsectYn").val(val.statInsectYn);
						

				    	// 수정 페이지 들어갔을 때 초기값에 대한 disabled 정의
				    	var selectedVal = val.statInsectYn;

				    	if(selectedVal == 'Y'){
				    		$("#statInsectKind").val(val.statInsectKind);
				    		$("select[name=statInsectKind]").removeProp("disabled");
						}else if(selectedVal == 'N'){
							$("#statInsectKind").prop("disabled", true);
						}
				    	
						$("#fileName").html("<div style='float:left; margin-left:15px;'>" + val.originalFileName + "</div>");
						$("#ORIGINAL_FILE_NAME").val(val.originalFileName);
						$("#STORED_FILE_NAME").val(val.storedFileName);
						$("#FILE_SIZE").val(val.fileSize);
						$("#seqNo").val(val.seqNo);
						$("#bigo").val(val.bigo);
						
						var regDate = $("#regDate").val();
						var regYear = regDate.substring(0,4);
						var regMonth = regDate.substring(5,7);
						
						$("#regDate").bindDate({align:"right", valign:"bottom", separator:"-", selectType:"d",  defaultSelectType:"d", minDate: regYear+"-"+regMonth+"-01", maxDate: regYear+"-"+regMonth+"-31",
				        	onchange:function(){
				        		var stDate = regYear+"-"+regMonth+"-01";
	       		        		if($("#regDate").val().replace(/-/gi,"") <  stDate.replace(/-/gi,"")){
	       		        			$("#regDate").val(regYear+"-"+regMonth+"-01");
	       		        		}
	       		        		
	       		        		var enDate = regYear+"-"+regMonth+"-31";
	       		        		if($("#regDate").val().replace(/-/gi,"") >  enDate.replace(/-/gi,"")){
	       		        			$("#regDate").val(regDate);
	       		        		}
				            }
				        });
					}
				});
       	 	}
		},
   
		getCheckedList : function(index) {
       
		if (!confirm("정말 삭제 하시겠습니까?"))
        		return;
			
     		var deleteValue = [];

			  $.Event(event).stopPropagation(); // 버튼클릭 이벤트가 row click 이벤트를 발생시키지 않도록 합니다.
	             var item = myGrid.list[index];
	             value=item; 
	             deleteValue = (value.regDate+','+value.chulNo+','+value.pumName+','+value.goodName+','+value.seqNo+'!');
       
	       $.ajax({
	           type : 'POST',
	           url : "/mntr/mab02/deleteCropInfoInput.json",
	           data :deleteValue,
	           dataType : '',   	           
	           success : function(res){               
	          	 alert('삭제되었습니다');
	          	 grid_ajax();            	 	 
	           },
	       }); 
     },
   
    };
  

$(document).ready(fnObj.pageStart);
	$(document).ready(function(){
		   myGrid.changeGridView({
			          viewMode:"mobile"
			 });
	});

</script>
</head>
<jsp:include page="../common/common.jsp"></jsp:include> 
  
<div class="ma_half1_1"  id="content"><span class="half_title2">작황동향</span></div>
<!-- 검색 시작-->
<form name="frm_ssq" enctype="multipart/form-data">
 	<input type=hidden name="chulNo" value="${SESSION_CMP_CODE}"/>
	<input type=hidden name="sanCd" value="${SESSION_SAN_CD}"/>
	<input type="hidden" id="ORIGINAL_FILE_NAME" name="ORIGINAL_FILE_NAME" value="${sumnail.ORIGINAL_FILE_NAME}"/>
	<input type="hidden" id="STORED_FILE_NAME" name="STORED_FILE_NAME" value="${sumnail.STORED_FILE_NAME}"/>
	<input type="hidden" id="FILE_SIZE" name="FILE_SIZE" value="${sumnail.FILE_SIZE}"/>
	<input type=hidden id="seqNo" name="seqNo" value="${result.seqNo }"/>
	
	<div class="all_select_part">
        <span class="select_date_title1">조사일자</span>
        <span class="select_date_title2">조사일자를 선택하세요</span>
    </div>
    <div class="radio_btn_all">
    	<label for="regDate" class="blind">조사일자 선택</label>
		<input type="text" name="regDate" id="regDate" class="calender_datebox_1"  value="${regDate}" onkeydown="return false;"/>
    </div>
    
    <div class="all_select_part">
        <span class="select_date_title1">품종선택</span>
        <span class="select_date_title2">품종을 선택하세요</span>
    </div>

      <div class="radio_btn_all">
        <label class="hw_item_search_title" for="pumName00">품목검색</label>
        <select name="pumName" class="item_search_select" id="pumName00">
            <option  value="장미">장미</option>
        </select>
        <label class="hw_variety_search_title" for="goodName">품종검색</label>
       <select name="goodName" id="goodName" class="variety_search_select">
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
    	<label class="hw_item_search_title" for="uniqueColor">꽃의 고유색</label>
       		<select name="uniqueColor" id="uniqueColor" class="variety_search_select">
				<option value="red">빨강</option>
				<option value="blue">파랑</option>
				<option value="yellow">노랑</option>   
				<option value="white">하얀</option>   
				<option value="pink">분홍</option>   
				<option value="orange">주황</option>   
				<option value="puple">보라</option>   
				<option value="black">검정</option>   
				<option value="etc">그외</option>    
			</select>
    </div>
    <div class="all_select_part">
        <span class="select_date_title1">작황정보 (전년대비)</span>
        <span class="select_date_title2">전년대비 작황정보를 선택해주세요</span>
    </div>
    <div class="radio_btn_all">
            <input id="radio3" type="radio" name="status" value="3"><label for="radio3">매우좋음</label>
            <input id="radio2" type="radio" name="status" value="2"><label for="radio2">좋음</label>
            <input id="radio1" type="radio" name="status" value="1"><label for="radio1">나쁨</label>
            <input id="radio0" type="radio" name="status" value="0"><label for="radio0">매우나쁨</label>       
    </div>
    
    <div class="all_select_part">
        <span class="select_date_title1">작황상태</span>
        <span class="select_date_title2">작황상태를 선택해 주세요</span>
    </div>
    
    <ul class="hw_list radio_btn_all">
		<li>
            <span class="hw_list_tit">- 일조량</span>
				<input type="radio" name="statSun" id="statSun3" value="3" /><label for="statSun3">매우좋음</label>
				<input type="radio" name="statSun" id="statSun2" value="2" /><label for="statSun2">좋음</label>
		    	<input type="radio" name="statSun" id="statSun1" value="1" /><label for="statSun1">나쁨</label>
		    	<input type="radio" name="statSun" id="statSun0" value="0" /><label for="statSun0">매우나쁨</label>    
  		</li>  	
  		<li>
            <span class="hw_list_tit">- 기후</span>
			<input type="radio" name="statClimate" value="3" id="statClimate3" /><label for="statClimate3">매우좋음</label>
			<input type="radio" name="statClimate" value="2" id="statClimate2" /><label for="statClimate2">좋음</label>
	    	<input type="radio" name="statClimate" value="1" id="statClimate1" /><label for="statClimate1">나쁨</label>
	    	<input type="radio" name="statClimate" value="0" id="statClimate0" /><label for="statClimate0">매우나쁨</label>
	   </li>	
    	<li>
            <span class="hw_list_tit">- 꽃의 크기</span>
			<input type="radio" name="statSize" value="3" id="statSize3" /><label for="statSize3">특상</label>
			<input type="radio" name="statSize" value="2" id="statSize2" /><label for="statSize2">상</label>
	    	<input type="radio" name="statSize" value="1" id="statSize1" /><label for="statSize1">중</label>
	    	<input type="radio" name="statSize" value="0" id="statSize0" /><label for="statSize0">하</label>
	    </li>
	    
    	<li>
	    	<span class="hw_list_tit">- 꽃대 굵기</span>
	    	<%-- <input type="text" name="statThick" id="statThick" class="AXInput" value="${result.statThick}" /> --%>
	    	<input type="radio" id="statThick4" name="statThick" value="4"/><label for="statThick4">특상</label>
			<input type="radio" id="statThick3" name="statThick" value="3"/><label for="statThick3">상</label> 
			<input type="radio" id="statThick2" name="statThick" value="2"/><label for="statThick2">중</label> 
			<input type="radio" id="statThick1" name="statThick" value="1"/><label for="statThick1">하</label> 
	    </li>
    	<li>
            <span class="hw_list_tit">- 색택의 선명함</span>			
			<input type="radio" name="statDefinition" value="3" id="statDefinition3" /><label for="statDefinition3">매우선명</label>
			<input type="radio" name="statDefinition" value="2" id="statDefinition2" /><label for="statDefinition2">선명</label>
	    	<input type="radio" name="statDefinition" value="1" id="statDefinition1" /><label for="statDefinition1">탁함</label>
	    	<input type="radio" name="statDefinition" value="0" id="statDefinition0" /><label for="statDefinition0">매우탁함</label>
	    </li>
    	<li>
	    	<label class="hw_list_tit2" for="statLength">- 꽃대 길이 (cm)</label>
	    	<input type="tel" name="statLength" id="statLength" class="AXInput" value="${result.statLength}"/>
	    </li>
    	<li>
    		<label class="hw_list_tit2" for="statInsectYn">- 병충해 유무</label>
       		<select name="statInsectYn" id="statInsectYn" class="variety_search_select">
				<option value="N">무</option>
				<option value="Y">유</option>
			</select>
	    </li>
    	<li>
    		<label class="hw_list_tit2" for="statInsectKind">- 병충해 종류</label>
       		<select name="statInsectKind" id="statInsectKind" class="variety_search_select" disabled=true >
					<option value="">선택</option>
					<option value="응애">응애</option>
					<option value="총채">총채</option>
					<option value="온실가루이">온실가루이</option>
					<option value="뿌리혹선충">뿌리혹선충</option>
					<option value="진딧물류">진딧물류</option>
					<option value="나방류">나방류</option>
					<option value="흰가루병">흰가루병</option>
					<option value="노균병">노균병</option>
					<option value="가지마름병">가지마름병</option>
					<option value="잿빛곰팡이병">잿빛곰팡이병</option>
					<option value="검은별무늬병">검은별무늬병</option>
					<option value="근두암종병">근두암종병</option>
					<option value="역병">역병</option>
					<option value="기타">기타</option>
				</select>
		</li>
    </ul>
    
    <div class="all_select_part">
        <span class="select_date_title1">작황상태 요약</span>
        <span class="select_date_title2">작황상태 요약정보를 입력하세요(100자~300자)</span>
    </div>
    <div class="radio_btn_all2">
    	<label for="bigo" class="blind">작황상태 요약 입력</label>
    	<textarea name="bigo" id="bigo" class="message_input"></textarea>
    </div>
    <div class="all_select_part">
        <span class="select_date_title1">작황사진 업로드</span>
        <span class="select_date_title2">작황사진을 업로드하세요</span>
    </div>
    <div class="radio_btn_all">
    	<div id="fileName"></div>
    	<label for="input_file" class="blind">작황사진 업로드</label>
    	<input accept="image/*" id="input_file" name="input_file" class="file_input" type="file">
    	<!-- <input type="file" id="input_file" name="input_file" class="file_input" /> -->
    	
    </div>
    
    </form>
	<div id="rt_sch_btn">
	  <div id="rt_sch_btn_lay"style="cursor:pointer;">
           <ul>
              <li class="lo2" id="lo1"><button onclick="fnObj.submit();"  style="display:block; margin:0 auto;">등록하기</button></li>
              <li class="lo2" id="lo2"><button onclick="fnObj.submit2();"  style="display:block; margin:0 auto;">수정하기</button></li>
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
          <a href="/mab02/mab02.do"><button type=button class="pcver_btn">pc버전</button></a> 
          <a href="javascript:window.scrollTo(0,0)"><button type=button class="up_btn">맨위로</button></a>          
      </li>
      <li class="lay2">
      	  <address class="copyright_address">Copyright By <span class="ft_green">화훼유통정보시스템 모바일.</span> All rights reserved.</address>
      </li>
  </div> 
  </div>
  </div>
  </div>
</body>
</html>