<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%   
   if (request.getParameter("groupCd")==null){
    request.setAttribute("pageTitle", "그룹관리 등록"); 
    String CHUL_NO=(String)session.getAttribute("SESSION_CMP_CODE");
    String id=(String)session.getAttribute("SESSION_USER_ID");
    //request.setAttribute("CHUL_NO",CHUL_NO);
    //request.setAttribute("GOOD_NAME", "비탈");    
    request.setAttribute("pageopen", "");
    request.setAttribute("pageopen2", "display:none");            
  }else{
    request.setAttribute("pageTitle", "그룹관리 수정");
    request.setAttribute("pageopen", "display:none");
    request.setAttribute("pageopen2", "");
    request.setAttribute("pagecheck", "1");
    request.setAttribute("groupCd", request.getParameter("groupCd"));
    //request.setAttribute("CHUL_NO", request.getParameter("CHUL_NO"));
    //request.setAttribute("GOOD_NAME", request.getParameter("GOOD_NAME"));      
    //request.setAttribute("STATUS", request.getParameter("STATUS"));
    //request.setAttribute("AREA", request.getParameter("AREA"));    
    //request.setAttribute("BIGO", request.getParameter("BIGO"));   
    //request.setAttribute("SEQ_NO", request.getParameter("SEQ_NO")); 
  }   
%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, user-scalable=no">
<title>재배동향 입력창 </title>
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
        	if('${pagecheck}' == "1" ){
        		$('#groupCd').val("${groupCd}");
        		
	        	$.ajax({
	           		type : "post",
	           		url : "/menuMgt/groupManageMentList.json",
	           		data : {
	           			groupCd : "${groupCd}"
	           		},
	           		dataType : '',
	           		success : function(res){
	           			var val = res.list;
	           			
	           			$("#groupNm").val(val[0].groupNm);
	           			
	           			if(val[0].useYn == "사용"){
	           				$("#useYn").val("Y").prop("selected",true);
	           			}else{
	           				$("#useYn").val("N").prop("selected",true);
	           			}
	           		}
	           	});
        	}
        	
        	$("#regDt").bindDate({align:"right", valign:"bottom", separator:"-", selectType:"d",  defaultSelectType:"d",
	        	onchange:function(){
	                //toast.push(Object.toJSON(this));
	            }
        	});
        	//$("input:radio[name='STATUS']:radio[value='${STATUS}']").attr("checked",true);   
        	//fnObj.upload.init();
        },  

        form: {			
			submit: function(){
				var frm = document["send-form"];
				if(confirm("등록하시겠습니까?")==true){				
				$.ajax({
			           type : "POST",
			           url : "/menuMgt/insertGroupMenuInput.json",
			           data : $(frm).serialize(),
			           dataType : '',   	           
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
				if(confirm("수정하시겠습니까?")==true){
					//$('#REG_DATE').attr("disabled",false);	  
	        		//$('#PUM_NAME').attr("disabled",false);	  
	        		//$('#GOOD_NAME').attr("disabled",false);	           	
				$.ajax({
			           type : "POST",
			           url : "/menuMgt/updateGroupMenuInput.json",
			           data :  "&"+$(frm).serialize(),
			           dataType : '',
			           success : function(res){		        	    
			            	alert("수정되었습니다.");
			            	parent.myModal.close();
			           },
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
		<form name="send-form" onsubmit="return false;">
			<div class="hw_clear"></div>
			<input type=hidden name="groupCd" value="${groupCd}"/>
			<input type=hidden name="id" value="${SESSION_USER_ID}"/>
			
			<%-- <h4 class="ma_title">일자</h4> <p class="hw_red">일자를 선택해주세요</p>
			<div class="hw_clear"></div>	
			<div class="hw_infouse_01" id="pagesearch" ><label class="hide">일자</label><input type="text" name="regDt" id="regDt" class="AXInput W100" value="${regDt}" onkeydown="return false;" />
			</div> --%>
			
			<div class="hw_clear"></div>
			<h4 class="ma_title">그룹명</h4> <p class="hw_red">그룹명을 입력하세요</p>
			<div class="hw_clear"></div>
			<div class="hw_infouse_01">
				<label for="hide">그룹명</label><input name="groupNm" id="groupNm" value='${groupNm}' class="AXInput" />
			</div>
			
			<div class="hw_clear"></div>
			<h4 class="ma_title">사용여부</h4> <p class="hw_red">사용여부를 선택하세요</p>
			<div class="hw_clear"></div>	
			<div class="hw_infouse_01">
				<label class="hw_item_search_title" for="useYn">사용여부</label>
				<select name="useYn" id="useYn" class="item_search_select">
					<option value="Y">사용</option>
					<option value="N">비사용</option>
				</select>
			</div>
			<div class="hw_clear"></div>
			     
			<div><input style="${pageopen}" id="add" name="add" class="ma_add_01"  type="button" value="등록하기" onclick="fnObj.form.submit();" /></div>
			<div><input style="${pageopen2}" id="modify" name="modify" class="ma_add_01"  type="button" value="수정하기" onclick="fnObj.form.submit2();" /></div>  
			<!-- <button class="AXButton" type="button" onclick="fnObj.form.submit();">저장하기</button> -->
		</form>
	</div><!-- ma_content end  -->
	</div><!-- 끝-->
</article>
</body>
</html>

