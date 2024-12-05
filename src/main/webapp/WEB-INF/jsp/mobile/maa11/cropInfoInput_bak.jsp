<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%   
   if (request.getParameter("REG_DATE")==null){
    request.setAttribute("pageTitle", "작황동향 등록"); 
    request.setAttribute("CHUL_NO", "0001");
    request.setAttribute("GOOD_NAME", "비탈");
    request.setAttribute("pageopen", "");
    request.setAttribute("pageopen2", "display:none");            
  }
  else{
    request.setAttribute("pageTitle", "작황동향 수정");
    request.setAttribute("pageopen", "display:none");
    request.setAttribute("pageopen2", "");
    request.setAttribute("pagecheck", "1");
    request.setAttribute("REG_DATE", request.getParameter("REG_DATE"));
    request.setAttribute("CHUL_NO", request.getParameter("CHUL_NO"));
    request.setAttribute("GOOD_NAME", request.getParameter("GOOD_NAME"));
    request.setAttribute("BIGO", request.getParameter("BIGO"));   
    request.setAttribute("STATUS_CD", request.getParameter("STATUS_CD"));
  }   
%>

<!-- <!DOCTYPE html>
<html lang="ko" xmlns="http://www.w3.org/1999/xhtml">
 

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" /> -->
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, user-scalable=no">
	<title>출하 및 예정물량 ㅣ aT 화훼유통정보 모니터요원 입력시스템</title>
	<link rel="stylesheet" type="text/css" href="/css/mobile/common/layout.css"/>

  <script type="text/javascript" src="<c:url value='/axisj/jquery/jquery.min.js' />"></script>
  <script type="text/javascript" src="<c:url value='/axisj/dist/AXJ.min.js' />"></script>
  <script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/ax5-polyfill.js' />"></script>
  <script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/axjApp.js' />"></script>
  <script type="text/javascript" src="<c:url value='/js/mobile/common/ctvtTrendInput.js' />"></script>
    <script type="text/javascript" src="<c:url value='/js/mobile/common/jquery.form.js' />"></script>
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
var seqNo="";

function grid_ajax(pageList){   		     		    	          	 
    $.ajax({
        type : 'get',
        url : "/mntr/mab01/gridList.json",
        data : '&CHUL_NO='+CHUL_NO,
        dataType : '',   	           
        success : function(res){               
            console.log(res.list);
            //console.log(res.list2.pageNo2);    
            var pageCount2 =  res.list.length/3;
            console.log(res.list.length);
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
   /*  	alert(pageResult);
    	alert(pageCount2);
    	alert(pageRest); */
		
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
	        		console.log(pageList);
	        }
        	   
           }
	        	
           console.log(list1);
            var data = {
					list:  list1,   				
					page:{
						pageNo:  (pageList==undefined)? '1':pageList.pageNo, // 현재페이지
						pageCount: pageResult, // 전체 페이지수
						listCount: res.list.length // 우측하단 카운트 표시 갯수
					}
				};
            	
				myGrid.setData(data);
            
          	 //myGrid.setList(res.list);
        },
    });      	    
};
var fnObj = {
    pageStart: function(){
    	CHUL_NO = '${SESSION_CMP_CODE}';
    	grid_ajax();
    	
    	$("#lo2").hide();
    	     
    	$("#REG_DATE").bindDate({align:"right", valign:"bottom", separator:"-", selectType:"d",  defaultSelectType:"d",
			onchange:function(){
				//toast.push(Object.toJSON(this));
			}});
    	
    	$('#sub_top_menu a span').removeClass('a_purple');
		$('#sub_top_menu a span').eq($('#sub_top_menu a span').index()+1).addClass('a_purple');
		
    	$('input[type=radio]').bindChecked();
     
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
			    {key:"REG_DATE", label:"등록일자", width:"100", align:"center", pk:true},                     	                 
			    {key:"CHUL_NO", label:"출하코드",align:"center", width:"80"},                     	                                              
			    {key:"STATUS_NAME", label:"작황상태", width:"120",align:"center"},
			    {key:"STATUS", label:"작황상태코드", width:"120", display: false},
			    {key:"BIGO", label:"작황내용", width:"600"},  
			    {key:"SEQ_NO", label:"일련번호", width:"80"},   
			    {
      			    key: "btns", label: "수정", width: "40", align: "center", formatter: function () {
      			    return '<button type="button" name="update" onclick="fnObj.getCheckedList1update(' + this.index + ');"><i class="axi axi-trash-o"></i></button>';
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
			   	//dialog.push(Object.toJSON(this));
			       //alert(this.pageNo);
			    }
			},
			colHeadAlign:"center",
		});
     },
     
     submit: function(){
    	 var frm = document["frm_ssq"];
			if(confirm("등록하시겠습니까?")==true){
	        var formData = new FormData(frm);
			  $.ajax({
				  	 type : "POST",
	                 url : "/mntr/mab01/insertCropInfoInput.json",
	                 data : formData,
	                 contentType: false,
	                 processData: false,
	                 success : function(res){   		                	
	                	 location.reload();
	                 },
	             }); 
			}else{
				return;
			}
			return false;
		},
		
		submit2: function(){
			var frm = document["frm_ssq"];
			if(confirm("수정하시겠습니까?")==true){
			var formData = new FormData(frm);
			$.ajax({
				type : "POST",
				url : "/mntr/mab01/updateCropInfoInput.json",
				data : formData,
				contentType: false,
				processData: false,
				success : function(res){   		                	
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
				seqNo = value.SEQ_NO;
				
				$.ajax({
					type : 'post',
					url : '/mntr/mab01/gridListSeq.json',
					data : {
						seqNo : seqNo
					},
					dataType : '',
					success : function(res){
						var val = res.result;
						$("#REG_DATE").val(val.regDate);
						$("#PUM_NAME").val(val.pumName);
						$("#GOOD_NAME").val(val.goodName);
						
						$(".AXbindCheckedHandle_radio").each(function(index){
							$(".AXbindCheckedHandle_radio").eq(index).attr("class","AXbindCheckedHandle_radio");
							if($("input[name=STATUS]").eq(index).val()==val.status){
								$("input[name=STATUS]").eq(index).attr("checked",true);
								$(".AXbindCheckedHandle_radio").eq(index).attr("class","AXbindCheckedHandle_radio checked");
							};
						});
						
						$("#BIGO").val(val.bigo);
						$("#fileName").html("<div style='float:left; margin-left:15px;'>" + val.fileName + "</div>");
						
						$("#ORIGINAL_FILE_NAME").val(val.fileName);
						$("#STORED_FILE_NAME").val(val.storedFileName);
						$("#FILE_SIZE").val(val.fileSize);
						$("#SEQ_NO").val(val.seqNo);
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
	             deleteValue = (value.REG_DATE+','+value.CHUL_NO+','+value.PUM_NAME+','+value.GOOD_NAME+','+value.SEQ_NO+'!');
         
         $.ajax({
             type : 'POST',
             url : "/mntr/mab01/deleteCropInfoInput.json",
             data :deleteValue,
             dataType : '',   	           
             success : function(res){                   	 
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
  
<div class="ma_half1_1"><span class="half_title2">작황동향</span></div>
<!-- 검색 시작-->
<form name="frm_ssq" enctype="multipart/form-data">
 	<input type=hidden name="CHUL_NO" value="${SESSION_CMP_CODE}"/>
	<input type=hidden name="SAN_CD" value="${SESSION_SAN_CD}"/>
	<input type="hidden" id="ORIGINAL_FILE_NAME" name="ORIGINAL_FILE_NAME" value="${sumnail.ORIGINAL_FILE_NAME}"/>
	<input type="hidden" id="STORED_FILE_NAME" name="STORED_FILE_NAME" value="${sumnail.STORED_FILE_NAME}"/>
	<input type="hidden" id="FILE_SIZE" name="FILE_SIZE" value="${sumnail.FILE_SIZE}"/>
	<input type=hidden id="SEQ_NO" name="SEQ_NO" value="${result.seqNo }"/>
	
	<jsp:include page="../common/commonDate.jsp"/>
    <div class="all_select_part">
        <span class="select_date_title1">품종선택</span>
        <span class="select_date_title2">품종을 선택하세요</span>
    </div>

      <div class="radio_btn_all">
        <span class="hw_item_search_title">품목검색</span>
       
        <select name="PUM_NAME" class="item_search_select">
            <option  value="장미">장미</option>
     		<!-- <option value="item2">아쿠아</option>
            <option value="item3">비탈</option> -->
        </select>
        <span class="hw_variety_search_title">품종검색</span>
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
        <span class="select_date_title1">작황정보</span>
        <span class="select_date_title2">품종을 선택하세요</span>
    </div>
    <div class="radio_btn_all">
            <input id="radio1" type="radio" name="STATUS" value="1" checked="checked"><label for="radio1">좋음</label>
            <input id="radio2" type="radio" name="STATUS" value="2"><label for="radio2">보통</label>
            <input id="radio3" type="radio" name="STATUS" value="3"><label for="radio3">나쁨</label>       
    </div>
    <div class="all_select_part">
        <span class="select_date_title1">작황상태 요약</span>
        <span class="select_date_title2">작황상태 요약정보를 입력하세요(100자~300자)</span>
    </div>
    <div class="radio_btn_all2">
    	<textarea name="BIGO" id="BIGO" class="message_input"></textarea>
    </div>
    <div class="all_select_part">
        <span class="select_date_title1">작황사진 업로드</span>
        <span class="select_date_title2">작황사진을 업로드하세요</span>
    </div>
    <div class="radio_btn_all">
    	<div id="fileName"></div>
    	<input type="file" id="input_file" name="input_file" class="file_input" accept="image/*;"/>
    </div>
    
    </form>
	<div id="rt_sch_btn">
	  <div id="rt_sch_btn_lay"style="cursor:pointer;">
           <ul>
             <!-- <li class="lo1"><img src="../../../../images/common/sch_btn_img1.png" alt="img" /></li>
             <li class="lo2"><img src="../../../../images/common/sch_btn_ment.png" alt="등록하기"  onclick="fnObj.submit();"  style="display:block; margin:0 auto;"/></li>
             <li class="lo3"><img src="../../../../images/common/sch_btn_img2.png" alt="img"/></li> -->
              <li class="lo2" id="lo1"><a onclick="fnObj.submit();"  style="display:block; margin:0 auto;">등록하기</a></li>
              <li class="lo2" id="lo2"><a onclick="fnObj.submit2();"  style="display:block; margin:0 auto;">수정하기</a></li>
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
  	<ul>
      <li class="lay1">
          <a href=""><button type=button class="pcver_btn">pc버전</button></a> 
          <a href=""><button type=button class="up_btn">맨위로</button></a>
      </li>
      <li class="lay2">
      	  <address class="copyright_address">Copyright By <span class="ft_green">화훼유통정보시스템 모바일.</span> All rights reserved.</address>
      </li>
    </ul>  
  </div>
  </div>
  </div>
</body>
</html>