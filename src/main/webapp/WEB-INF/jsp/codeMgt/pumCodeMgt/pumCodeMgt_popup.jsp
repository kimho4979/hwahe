<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%   
   if (request.getParameter("rn")==null){
    request.setAttribute("pageTitle", "품목코드 등록"); 
    String CHUL_NO=(String)session.getAttribute("SESSION_CMP_CODE");
    String id=(String)session.getAttribute("SESSION_USER_ID");
    //request.setAttribute("CHUL_NO",CHUL_NO);
    //request.setAttribute("GOOD_NAME", "비탈");    
    request.setAttribute("pageopen", "");
    request.setAttribute("pageopen2", "display:none");            
  }else{
    request.setAttribute("pageTitle", "품목코드 수정");
    request.setAttribute("pageopen", "display:none");
    request.setAttribute("pageopen2", "");
    request.setAttribute("pagecheck", "1");
    request.setAttribute("rn", request.getParameter("rn"));
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
var flowerGubn = null;
var pumNm = null;
var jongNm = null;
var cmpCdMap = null;
var flowerGubnMap = null;
var pumNmMap = null;
var jongNmMap = null;

var fnObj = {
	pageStart: function(){
		if('${pagecheck}' == "1" ){
			$('#rn').val("${rn}");
			
	    	$.ajax({
	       		type : "post",
	       		url : "/codeMgt/selectCodeMapList.json",
	       		data : {
	       			rn : "${rn}"
	       		},
	       		dataType : '',
	       		success : function(res){
	       			var val = res.list;
	       			console.log(val);
	       			flowerGubn = val[0].flowerGubn;
	       			pumNm = val[0].pumNm;
	       			jongNm = val[0].jongNm;
	       			cmpCdMap = val[0].cmpCdMap;
	       			flowerGubnMap = val[0].flowerGubnMap;
	       			pumNmMap = val[0].pumNmMap;
	       			jongNmMap = val[0].jongNmMap;
	       			
	       			$("select[name=flowerGubn]").val(flowerGubn);
	       			$("#pumNm").val(pumNm);
	       			$("#jongNm").val(jongNm);
	       			$("select[name=cmpCdMap]").val(cmpCdMap);
	       			$("select[name=flowerGubnMap]").val(flowerGubnMap);
	       			$("#pumNmMap").val(pumNmMap);
	       			$("#jongNmMap").val(jongNmMap);
	       		}
	       	});
		}
		
		//$("input:radio[name='STATUS']:radio[value='${STATUS}']").attr("checked",true);   
		//fnObj.upload.init();
	},  
	
	form: {			
		submit: function(){
			var frm = document["send-form"];
			if(confirm("등록하시겠습니까?")==true){				
			$.ajax({
		           type : "POST",
		           url : "/codeMgt/insertCodeMapList.json",
		           data : $(frm).serialize(),
		           dataType : '',   	           
		           success : function(res){
		        	   parent.grid_ajax();
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
		           url : "/codeMgt/updateCodeMapList.json",
		           data :  "&"+$(frm).serialize(),
		           dataType : '',
		           success : function(res){		        	    
		            	alert("수정되었습니다.");
		            	parent.grid_ajax();
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
			<input type=hidden id="cmpCd" name="cmpCd" value="0000000001"/>
			<input type=hidden id="rn" name="rn" value="${rn}"/>
			<input type=hidden id="userId" name="userId" value="${SESSION_USER_ID}"/>
			
			
			<div class="hw_clear"></div>
			<h4 class="ma_title">aT화훼구분</h4> <p class="hw_red">AT화훼구분을 선택하세요</p>
			<div class="hw_clear"></div>
			<div class="hw_infouse_01">
				<label class="hw_item_search_title" for="flowerGubn">화훼구분</label>
				<select name="flowerGubn" id="flowerGubn" class="item_search_select">
					<option value="1">절화</option>
					<option value="3">난</option>
					<option value="2">관엽</option>
					<option value="4">춘란</option>
				</select>
			</div>
			
			<div class="hw_clear"></div>
			<h4 class="ma_title">aT품목명</h4> <p class="hw_red">aT품목명를 입력하세요</p>
			<div class="hw_clear"></div>	
			<div class="hw_infouse_01">
				<label for="hide">aT품목명</label><input name="pumNm" id="pumNm" value='${pumNm}' class="AXInput" />
			</div>
			<div class="hw_clear"></div>
			
			<div class="hw_clear"></div>
			<h4 class="ma_title">aT품종명</h4> <p class="hw_red">aT품목명를 입력하세요</p>
			<div class="hw_clear"></div>	
			<div class="hw_infouse_01">
				<label for="hide">aT품종명</label><input name="jongNm" id="jongNm" value='${jongNm}' class="AXInput" />
			</div>
			<div class="hw_clear"></div>
			
			<div class="hw_clear"></div>
			<h4 class="ma_title">공판장명</h4> <p class="hw_red">공판장명를 선택하세요</p>
			<div class="hw_clear"></div>	
			<div class="hw_infouse_01">
				<label class="hw_item_search_title" for="cmpCdMap">공판장명</label>
				<select name="cmpCdMap" id="cmpCdMap" class="item_search_select">
					<option value="1508500020">부산화훼공판장(엄궁동)</option>
					<option value="6068207466">부산경남화훼농협(강동동)</option>
					<option value="4108212335">광주원예농협(풍암)</option>
					<option value="3848200087">한국화훼농협(음성)</option>
					<option value="1288202296">한국화훼농협(과천)</option>
				</select>
			</div>
			
			<div class="hw_clear"></div>
			<h4 class="ma_title">공판장화훼구분</h4> <p class="hw_red">공판장화훼구분을 선택하세요</p>
			<div class="hw_clear"></div>
			<div class="hw_infouse_01">
				<label class="hw_item_search_title" for="flowerGubnMap">공판장화훼구분</label>
				<select name="flowerGubnMap" id="flowerGubnMap" class="item_search_select">
					<option value="1">절화</option>
					<option value="3">난</option>
					<option value="2">관엽</option>
					<option value="4">춘란</option>
				</select>
			</div>
			
			<div class="hw_clear"></div>
			<h4 class="ma_title">품목명</h4> <p class="hw_red">품목명를 입력하세요</p>
			<div class="hw_clear"></div>	
			<div class="hw_infouse_01">
				<label for="hide">품목명</label><input name="pumNmMap" id="pumNmMap" value="${pumNmMap}" class="AXInput" />
			</div>
			<div class="hw_clear"></div>
			
			<div class="hw_clear"></div>
			<h4 class="ma_title">품종명</h4> <p class="hw_red">품목명를 입력하세요</p>
			<div class="hw_clear"></div>	
			<div class="hw_infouse_01">
				<label for="hide">품종명</label><input name="jongNmMap" id="jongNmMap" value="${jongNmMap}" class="AXInput" />
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

