<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%   
   if (request.getParameter("REG_DATE")==null){
    request.setAttribute("pageTitle", "작황동향 등록"); 
    String CHUL_NO=(String)session.getAttribute("SESSION_CMP_CODE");
    request.setAttribute("CHUL_NO", CHUL_NO);
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
    request.setAttribute("STATUS", request.getParameter("STATUS"));
    request.setAttribute("BIGO", request.getParameter("BIGO"));   
    request.setAttribute("SEQ_NO", request.getParameter("SEQ_NO"));
  }   
%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, user-scalable=no">
<title>작황정보 입력창 </title>
  <!-- @@@@@@@@@@@@@@@@@@@@@@ css begin @@@@@@@@@@@@@@@@@@@@@@ -->
 <link rel="stylesheet" type="text/css" href="<c:url value='/rMateChart/rMateChartH5/Assets/Css/rMateChartH5.css' />"/>   
 <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/axicon/axicon.min.css' />" />
 <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/arongi/AXJ.min.css' />" />
 <link rel="stylesheet" type="text/css" href="<c:url value='/css/hw/ma.css' />" />
 <link rel="stylesheet" type="text/css" href="<c:url value='/css/hw/common.css' />" />
  <!-- @@@@@@@@@@@@@@@@@@@@@@ css end   @@@@@@@@@@@@@@@@@@@@@@ --> 
   
  <script type="text/javascript" src="<c:url value='/axisj/jquery/jquery.min.js' />"></script>
  <script type="text/javascript" src="<c:url value='/axisj/dist/AXJ.min.js' />"></script>
  <script type="text/javascript" src="<c:url value='/axisj/lib/AXUpload5.js' />"></script>
  <script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/ax5-polyfill.js' />"></script>
  <script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/axjApp.js' />"></script>
  <script type="text/javascript" src="<c:url value='/js/mobile/common/jquery.form.js' />"></script>
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
        	if('${pagecheck}' == "1" ){
        		$('#GOOD_NAME').val("${GOOD_NAME}");
        		//$("#REG_DATE").unbindInput();
        		$('#REG_DATE').attr("disabled",false);	  
        		$('#PUM_NAME').attr("disabled",false);	  
        		$('#GOOD_NAME').attr("disabled",false);	        		                           	
        	}        	        	        	        
        	
        	$("input:radio[name='STATUS']:radio[value='${STATUS}']").attr("checked",true);
        	
			//$('#REG_DATE').attr("disabled",false);	  
    		//$('#PUM_NAME').attr("disabled",false);	  
    		//$('#GOOD_NAME').attr("disabled",false);
        },

        form: {
			submit: function(){
				
				var frm = document["send-form"];
				if(confirm("등록하시겠습니까?")==true){
				//alert($(frm).serialize());
		        var formData = new FormData(frm);
				 //frm.action = "/mntr/mab01/insertCropInfoInput.json";
				  $.ajax({
					  	 type : "POST",
		                 url : "/mntr/mab01/insertCropInfoInput.json",
		                 data : formData,
		                 contentType: false,
		                 processData: false,
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
			submit2: function(){				
				var frm = document["send-form"];		
				 //var obj = app.form.serializeObjectWithIds($("#form-notice"));
				if(confirm("수정하시겠습니까?")==true){
					$('#REG_DATE').attr("disabled",false);	  
	        		$('#PUM_NAME').attr("disabled",false);	  
	        		$('#GOOD_NAME').attr("disabled",false);
	        		var formData = new FormData(frm);
				$.ajax({
					   type : "POST",
			           url : "/mntr/mab01/updateCropInfoInput.json",
			           data : formData,
			           contentType: false,
		               processData: false,
			           success : function(res){			        	   
			        	    $('#REG_DATE').attr("disabled","disabled");	  
			        		$('#PUM_NAME').attr("disabled","disabled");	  
			        		$('#GOOD_NAME').attr("disabled","disabled");
			        		alert("수정완료");
			            	parent.myModal.close();
			           }
			       });   
				}else{
					return;
				}
				//dialog.push( $(frm).serialize() );
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
        }
    };
    
    /* function delFileName(){
    	var frm = document["send-form"];		
		 //var obj = app.form.serializeObjectWithIds($("#form-notice"));
		 var SEQ_NO = "${SEQ_NO}";
		 if(confirm("삭제하시겠습니까?")==true){
			 $.ajax({
				   type : "POST",
		           url : "/mntr/mab01/deleteCropFile.json",
		           data : {
		        	   SEQ_NO : SEQ_NO
		           },
		           contentType: false,
	               processData: false,
		           success : function(res){			        	   
		        		alert("삭제완료");
		           }
		       });
		 }else{
			 return;
		 }
		 return false;
    } */
    
    jQuery(document).ready(fnObj.pageStart);  
    </script>
    
</head>

<body>  	 

<article>
<div>


<div class="ma_content"><!--컨텐츠 내용들어가는곳 시작-->
	
<div>
<h4 class="hw_h3_ma_01" >${pageTitle}</h4> 

</div>

<form name="send-form" id="send-form" enctype="multipart/form-data">
	<div class="hw_clear"></div>
	<input type=hidden name="CHUL_NO" value="${CHUL_NO}"/>
	<input type=hidden name="SEQ_NO" value="${SEQ_NO}"/>
	<input type=hidden name="SAN_CD" value="${SESSION_SAN_CD}"/>
	<input type="hidden" name="ORIGINAL_FILE_NAME" value="${sumnail.ORIGINAL_FILE_NAME}"/>
	<input type="hidden" name="STORED_FILE_NAME" value="${sumnail.STORED_FILE_NAME}"/>
	<input type="hidden" name="FILE_SIZE" value="${sumnail.FILE_SIZE}"/>

	<h4 class="ma_title">날짜선택</h4> <p class="hw_red">날짜를 선택해주세요</p>
	<div class="hw_clear"></div>	

	<div class="hw_infouse_01" id="pagesearch" ><input type="text" name="REG_DATE" id="REG_DATE" class="AXInput W100" value="${REG_DATE}" /></div>
	<div class="hw_clear"></div>

	<h4 class="ma_title">품종선택</h4> <p class="hw_red">품종을 선택하세요</p>
	<div class="hw_clear"></div>	
	<div class="hw_infouse_01">
		<span class="hw_item_search_title">품목검색</span>
		
		<select name="PUM_NAME" id="PUM_NAME" class="item_search_select">
			<option value="장미">장미</option>   
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

	<h4 class="ma_title">작황정보</h4> <p class="hw_red">전년대비 작황상황을 선택해주세요</p>
	<div class="hw_clear"></div>	
	<div class="hw_infouse_01">
 		<input type="radio" name="STATUS" value="1" />좋음                         
    	<input type="radio" name="STATUS" value="2" />보통
    	<input type="radio" name="STATUS" value="3" />나쁨
	</div>

	<h4 class="ma_title">작황상태 요약</h4> <p class="hw_red">작황상태를 간략하게200자 이내로 적어주세요</p>
	<div class="hw_clear"></div>	
 
	<textarea name="BIGO" id="BIGO" class="AXTextarea" style="box-shadow:inset 0px 0px 3px #ccc;width:100%;height:60px; margin-top:10px; ime-mode:active;box-sizing: border-box;" title="내용">${BIGO}</textarea>
	<div class="hw_clear"></div>	
	
	<h4 class="ma_title">작황 사진업로드</h4> <p class="hw_red">작황사진을 업로드해 주세요</p>
	<div class="hw_clear"></div>
	<div class="hw_infouse_01">
 		<span id="fileEl" >
 			<a>${sumnail.ORIGINAL_FILE_NAME}</a>&nbsp;
 			<!-- <a href="" id="delFile" name="delFile" style="color: #FF0000;" onClick="delFileName();">[X]</a> -->
 		</span>
 		 	&nbsp;<input type="file" name="file" id="file" value="${sumnail.ORIGINAL_FILE_NAME }" readonly><br>
 		<%-- <img src="/upload/${sumnail.STORED_FILE_NAME}" width="100px" height="100px;"/> --%>
	</div>
</form>	
<div class="hw_clear"></div>	
   
<div><input style="${pageopen}"id="add" name="add" class="ma_add_01"  type="button" value="등록하기" onclick="fnObj.form.submit();" /></div>
<div><input style="${pageopen2}" id="modify" name="modify" class="ma_add_01"  type="button" value="수정하기" onclick="fnObj.form.submit2();" /></div>  
  
<div class="hw_clear"></div>



</div>
</div><!-- 끝-->
</article>
</body>
</html>

