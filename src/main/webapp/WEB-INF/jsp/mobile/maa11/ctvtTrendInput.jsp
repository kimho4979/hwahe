<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%   
   if (request.getParameter("REG_DATE")==null){
    request.setAttribute("pageTitle", "재배동향 등록"); 
    request.setAttribute("CHUL_NO", "0001");
    request.setAttribute("GOOD_NAME", "비탈");
    request.setAttribute("SAN_CD", "1111");
    request.setAttribute("pageopen", "");
    request.setAttribute("pageopen2", "display:none");            
  }
  else{
    request.setAttribute("pageTitle", "재배동향 수정");
    request.setAttribute("pageopen", "display:none");
    request.setAttribute("pageopen2", "");
    request.setAttribute("pagecheck", "1");
    request.setAttribute("REG_DATE", request.getParameter("REG_DATE"));
    request.setAttribute("CHUL_NO", request.getParameter("CHUL_NO"));
    request.setAttribute("GOOD_NAME", request.getParameter("GOOD_NAME"));      
    request.setAttribute("STATUS", request.getParameter("STATUS"));
    request.setAttribute("AREA", request.getParameter("AREA"));    
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
	<title>재배동향 ㅣ aT 화훼유통정보 모니터요원 입력시스템</title>
	<link rel="stylesheet" type="text/css" href="/css/mobile/common/layout.css"/>

  <script type="text/javascript" src="<c:url value='/axisj/jquery/jquery.min.js' />"></script>
  <script type="text/javascript" src="<c:url value='/axisj/dist/AXJ.min.js' />"></script>
  <script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/ax5-polyfill.js' />"></script>
  <script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/axjApp.js' />"></script>
  <script type="text/javascript" src="<c:url value='/js/mobile/common/ctvtTrendInput.js' />"></script>
  
 <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/axicon/axicon.min.css' />" />
 <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/arongi/mobileAXJ.min.css' />" />  
  <!-- rMateChartH5 라이센스 시작 -->
  <script type="text/javascript" src="<c:url value='/rMateChart/LicenseKey/rMateChartH5License.js' />"></script>
  <!-- rMateChartH5 라이센스 끝-->  
  <!-- 실제적인 rMateChartH5 라이브러리 시작-->
   <script type="text/javascript" src="<c:url value='/rMateChart/rMateChartH5/JS/rMateChartH5.js' />"></script>
  <!-- 실제적인 rMateChartH5 라이브러리 끝-->  
  
<script>
var myProgress = new AXProgress();
var myGrid = new AXGrid();
var myModal = new AXModal();
var REG_DATE="";
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
	if($('#AREA').val() == '')
	{
		alert('재배면적(본인) 평수를 입력하세요');
		return false;
	}
	
	return true;
}


var fnObj = {
	    pageStart: function(){
	    	
	    	CHUL_NO='${SESSION_CMP_CODE}';
	    	grid_ajax();    	        	
	    	
	    	$('#sub_top_menu a span').removeClass('a_purple');
			$('#sub_top_menu a span').eq($('#sub_top_menu a span').index()+3).addClass('a_purple');
			
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
				}});*/
	    
	    	$("#lo3").hide();
	    	
	    	 myGrid.setConfig({
	    	             targetID : "AXGridTarget",
	    	             theme : "AXGrid",
	    	             fixedColSeq : '',
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
		                     {key:"CHUL_NO", label:"출하코드", width:"80", align:"center"},                      
	    	                 {key:"REG_DATE", label:"재배일자", width:"100", align:"center", pk:true},                     	                     	                 
	    	                 {key:"PUM_NAME", label:"품목명", width:"140", align:"center"},                     	                 
	    	                 {key:"GOOD_NAME", label:"품종명", width:"140", align:"center"},
	    	                 {key:"STATUS_NAME", label:"전년대비면적", width:"140", align:"center"},    
	    	                 {key:"AREA", label:"재배면적", width:"140", align:"right", formatter:"money"}, 
	    	                 {key:"BIGO", label:"동향", width:"140", align:"center"},    
	    	                 {key:"SEQ_NO", label:"일련번호", width:"80"}, 
	    	                 {
	    	       			    key: "btns", label: "수정", width: "40", align: "center", formatter: function () {
	    	       			    return '<button type="button" name="update" onclick="fnObj.getCheckedList1update(' + this.index + ');"><i class="axi axi-mode-edit"></i></button>';
	    	       			}
	    	       			}
	    	             ],
	    	             colHeadAlign:"center",
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
	    	         }); 

	     },//pageStart
	     submit: function(){
	    	 if(!checkData()){
					return;
				}
				
				var frm = document["frm_ssq"];
				if(confirm("등록하시겠습니까?")==true){				
				$.ajax({
			           type : "POST",
			           url : "/mntr/mac01/insertCtvtTrendInput.json",
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
					url : "/mntr/mac01/updateCtvtTrendInput.json",
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
				if(confirm("재배정보을 수정하시겠습니까?") == true){
					$("#lo1").hide();
					$("#lo3").show();
					$("body").scrollTop(0);
					
					var item = myGrid.list[index];
					value=item; 
					seqNo = value.SEQ_NO;
					
					$.ajax({
						type : 'post',
						url : '/mntr/mac01/gridListSeq.json',
						data : {
							seqNo : seqNo
						},
						dataType : '',
						success : function(res){
							var val = res.result;
							$("#REG_DATE").val(val.regDate);
							$("#PUM_NAME").val(val.pumName);
							$("#GOOD_NAME").val(val.goodName);
							
							if(val.status == '1'){
								$("#radio1").attr("checked",true);
								$("#radio2").attr("checked",false);
								$("#radio3").attr("checked",false);
							}
							if(val.status == '2'){
								$("#radio1").attr("checked",false);
								$("#radio2").attr("checked",true);
								$("#radio3").attr("checked",false);
							}
							if(val.status == '3'){
								$("#radio1").attr("checked",false);
								$("#radio2").attr("checked",false);
								$("#radio3").attr("checked",true);
							}
							
							$("#AREA").val(val.area);
							$("#BIGO").val(val.bigo);
							
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
	   
			getCheckedList : function(index) {
				if (!confirm("정말 삭제 하시겠습니까?"))
	        		return;
				
	 			var deleteValue = [];

				  $.Event(event).stopPropagation(); // 버튼클릭 이벤트가 row click 이벤트를 발생시키지 않도록 합니다.
		             var item = myGrid.list[index];
		             value=item;
		             deleteValue = (value.REG_DATE+','+value.PUM_NAME+','+value.GOOD_NAME+','+value.CHUL_NO+','+value.SEQ_NO+'!');
		         $.ajax({
		             type : 'POST',
		             url : "/mntr/mac01/deleteCtvtTrendInput.json",
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


	function  grid_ajax(pageList){   		     		    	          	 
	    $.ajax({
	        type : 'get',
	        url : "/mntr/mac01/gridList.json",
	        data :  '&CHUL_NO='+CHUL_NO,
	        dataType : '',   	           
	        success : function(res){               
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
	        },
	    });      	       	    
	};


	$(document).ready(function(){
		$('#lo2').click(function(){
			url="/mntr/mac01/insertCtvtTrendInput.json";
			Insert(url);		
		});
	});

	$(document).ready(function(){
		   myGrid.changeGridView({
			          viewMode:"mobile"
			 });
	});

</script>
</head>
<jsp:include page="../common/common.jsp"></jsp:include> 
  
	<div class="ma_half1_1"  id="content"><span class="half_title2">재배동향</span></div>
  
     <!-- 검색 시작-->
<form name="frm_ssq">

<div class="all_select_part">
      <span class="select_date_title1">조사일자</span>
      <span class="select_date_title2">조사일자를 선택하세요</span>
</div>
<div class="radio_btn_all">
	<label for="REG_DATE" class="blind">조사일자 선택</label>
	<input type="text" name="REG_DATE" id="REG_DATE" class="calender_datebox_1"  value="${REG_DATE}" onkeydown="return false;"/>
</div>
    
<input type=hidden name="CHUL_NO" value="${SESSION_CMP_CODE}"/>
<input type=hidden name="SAN_CD" value="${SESSION_SAN_CD}"/>
<input type=hidden name="CMP_CD" value="0000000001"/>		
<input type=hidden id="SEQ_NO" name="SEQ_NO" value="${result.seqNo }"/> 
    
    <div class="all_select_part">
        <span class="select_date_title1">품종선택</span>
        <span class="select_date_title2">품종을 선택하세요</span>
    </div>
    <div class="radio_btn_all">
        <label class="hw_item_search_title" for="PUM_NAME00">품목검색</label>
        <select name="PUM_NAME" id="PUM_NAME00" class="item_search_select">
            <option  value="장미">장미</option>
     <!--        <option value="item2">아쿠아</option>
            <option value="item3">비탈</option> -->
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
        <span class="select_date_title1">전년대비면적(본인)</span>
        <span class="select_date_title2">전년대비 재배면적(본인)을 선택해주세요</span>
    </div>
    <div class="radio_btn_all">
    	<input id="radio1" type="radio" name="STATUS" value="1" checked="checked"><label for="radio1">증가</label>
        <input id="radio2" type="radio" name="STATUS" value="2"><label for="radio2">비슷</label>
        <input id="radio3" type="radio" name="STATUS" value="3"><label for="radio3">감소</label>	  
	</div>
    <div class="all_select_part">
        <span class="select_date_title1">재배면적(본인)</span>
        <span class="select_date_title2">본인의 재배면적을 입력하세요</span>
    </div>
    <div class="radio_btn_all">
    	<label for="AREA" class="blind">재배면적(본인) 입력</label>
    	<input type="tel" id="AREA" name=AREA class="text_input" value="${AREA}"/>
        <span class="input_title">평</span>
    </div>
    <div class="all_select_part">
        <span class="select_date_title1">재배면적 동향</span>
        <span class="select_date_title2">근방의 면적과 함께 합산값을 입력해주세요</span>
    </div>
    <div class="radio_btn_all2">
    	<label for="BIGO" class="blind">재배면적 동향 입력</label>
    	<textarea id="BIGO" name="BIGO" class="message_input"></textarea>
    </div>
    </form>
	<div id="rt_sch_btn">
	  <div id="rt_sch_btn_lay" style="cursor:pointer;">
           <p class="lo2" id="lo1"><button id="lo2"onclick="fnObj.submit();"  style="display:block; margin:0 auto;">등록하기</button></p>
           <p class="lo2" id="lo3"><button id="lo2"onclick="fnObj.submit2();"  style="display:block; margin:0 auto;">수정하기</button></p>
         </div>
     </div>    
       	<table class="table_chart">
 				<tr></tr>
   		</table>
           
	<div id="AXGridTarget" style="height:400px;"></div>  	  


  <div id="bottom">
      <li class="lay1">
          <a href="/mac01/mac01.do"><button type=button class="pcver_btn">pc버전</button></a> 
          <a href="javascript:window.scrollTo(0,0)"><button type=button class="up_btn">맨위로</button></a>          
      </li>
      <li class="lay2">
      	  <address class="copyright_address">Copyright By <span class="ft_green">화훼유통정보시스템 모바일.</span> All rights reserved.</address>
      </li>
  </div>
  </div>
</body>
</html>
