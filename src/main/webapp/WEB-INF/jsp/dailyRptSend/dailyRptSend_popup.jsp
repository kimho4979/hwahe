<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%   
  if (request.getParameter("emailAdrs")==null){
    request.setAttribute("pageTitle", "일일 보고자료 발송 등록"); 
    String id=(String)session.getAttribute("SESSION_USER_ID");
    request.setAttribute("pageopen", "");
    request.setAttribute("pageopen2", "display:none");            
  }else{
    request.setAttribute("pageTitle", "일일 보고자료 발송 수정");
    request.setAttribute("pageopen", "display:none");
    request.setAttribute("pageopen2", "");
    request.setAttribute("pagecheck", "1");
    request.setAttribute("emailAdrs", request.getParameter("emailAdrs"));
  }   
%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, user-scalable=no">
	<title>일일 보고자료 발송 등록 </title>
	<!-- @@@@@@@@@@@@@@@@@@@@@@ css begin @@@@@@@@@@@@@@@@@@@@@@ -->
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
	<%-- <script type="text/javascript" src="<c:url value='/js/mobile/common/jquery.form.js' />"></script> --%>
  
	<!-- rMateChartH5 라이센스 시작 -->
	<script type="text/javascript" src="<c:url value='/rMateChart/LicenseKey/rMateChartH5License.js' />"></script>
	<!-- rMateChartH5 라이센스 끝-->  
	<!-- 실제적인 rMateChartH5 라이브러리 시작-->
	<script type="text/javascript" src="<c:url value='/rMateChart/rMateChartH5/JS/rMateChartH5.js' />"></script>
	<!-- 실제적인 rMateChartH5 라이브러리 끝-->
  
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
	
var emailAdrs = null;
var sndDeptNm = null;
var sndOthNm = null;
var sndTel = null;
var endSndDt = null;
var useYn = null;
var userNm = null;

var fnObj = {
	pageStart: function(){
		if('${pagecheck}' == "1" ){
			$('#emailAdrs').val("${emailAdrs}");
			$("#emailAdrs").attr("readonly", true);
			$("#add").attr("type", "hidden");
			
	    	$.ajax({
	       		type : "post",
	       		url : "/mntr/dailyRptSend/selectDailtRptSendPopup.json",
	       		data : {
	       			emailAdrs : "${emailAdrs}"
	       		},
	       		dataType : '',
	       		success : function(res){
	       			var val = res.list;
	       			console.log(val);
	       			
	       			emailAdrs = val[0].emailAdrs;
	       			sndDeptNm = val[0].sndDeptNm;
	       			sndOthNm = val[0].sndOthNm;
	       			sndTel = val[0].sndTel;
	       			endSndDt = val[0].endSndDt;
	       			useYn = val[0].useYn;
	       			userNm = val[0].userNm;
	       			console.log("userNm : "+userNm);
	       			
	       			$("#emailAdrs").val(emailAdrs);
	       			$("#sndDeptNm").val(sndDeptNm);
	       			$("#sndOthNm").val(sndOthNm);
	       			$("#sndTel").val(sndTel);
	       			$("select[name=useYn]").val(useYn);
	       			$("#userNm").val(userNm);
	       		}
	       	});
		}
		else {
			$("#update").attr("type", "hidden");
		}
	},
	form: {
		submit: function(){
			var frm = document["send-form"];
			if(confirm("등록하시겠습니까?")==true){
				var formData = new FormData(frm);
				$.ajax({
					type : "post",
					url : "/mntr/dailyRptSend/insertDailtRptSend.json",
					data : formData, 
					contentType: false,
					processData: false,
					success : function(res){
						alert("등록되었습니다.");
						parent.grid_ajax();
						parent.myModal.close();
					}
				}); 
			}else{
				return;
			}
			return false;
		},
		submit2: function(){			
			var frm = document["send-form"];						
			if(confirm("수정하시겠습니까?")==true){
				var formData = new FormData(frm);
				$.ajax({
		           type : "post",
		           url : "/mntr/dailyRptSend/updateDailtRptSend.json",
		           data :  formData,
		           dataType : '',
		           contentType: false,
				   processData: false,
		           success : function(res){		        	    
		            	alert("수정되었습니다.");
		            	parent.grid_ajax();
		            	parent.myModal.close();
		           },
		       });   
			}else{
				return;
			}
			return false;
		}
	},  		
	close:function(){
		if(opener){
			window.close();
		}else if(parent){
			if(parent.myModal) parent.myModal.close();
		}else{
			window.close();
		}
	}
};

$(document).ready(function(){
	fnObj.pageStart();
	
	// 메일주소 영문+특수기호	
	$("#emailAdrs").keyup(function(event){
		if (!(event.keyCode >=37 && event.keyCode<=40)) {
			var inputVal = $(this).val();
			$(this).val(inputVal.replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g,''));
		}
	});
	
	// 부서명 한글만
	$("#sndDeptNm").keyup(function(event){
		if (!(event.keyCode >=37 && event.keyCode<=40)) {
			var inputVal = $(this).val();
			$(this).val(inputVal.replace(/[a-z0-9]/gi,''));
		}
	});
	
	// 성명 한글만
	$("#sndOthNm").keyup(function(event){
		if (!(event.keyCode >=37 && event.keyCode<=40)) {
			var inputVal = $(this).val();
			$(this).val(inputVal.replace(/[a-z0-9]/gi,''));
		}
	});
	
	// 발신자 한글만
	$("#userNm").keyup(function(event){
		if (!(event.keyCode >=37 && event.keyCode<=40)) {
			var inputVal = $(this).val();
			$(this).val(inputVal.replace(/[a-z0-9]/gi,''));
		}
	});
});
</script>
</head>
<body>  	 
	<article>
		<div class="ma_content"><!--컨텐츠 내용들어가는곳 시작-->
			<div><h4 class="hw_h3_ma_01" >${pageTitle}</h4></div>
		<form name="send-form" id="send-form" enctype="multipart/form-data">
			<h4 class="ma_title">메일주소</h4> <p class="hw_red">메일주소를 입력하세요</p>
			<div class="hw_clear"></div>	
			<div class="hw_infouse_01">
				<label for="hide">메일주소</label>
				<input name="emailAdrs" id="emailAdrs" value='${emailAdrs}' class="AXInput" />
			</div>
			<div class="hw_clear"></div>
			
			<h4 class="ma_title">부서명</h4> <p class="hw_red">부서명을 입력하세요</p>
			<div class="hw_clear"></div>	
			<div class="hw_infouse_01">
				<label for="hide">부서명</label>
				<input name="sndDeptNm" id="sndDeptNm" value='${sndDeptNm}' class="AXInput" />
			</div>
			<div class="hw_clear"></div>
			
			<h4 class="ma_title">성명</h4> <p class="hw_red">성명을 입력하세요</p>
			<div class="hw_clear"></div>	
			<div class="hw_infouse_01">
				<label for="hide">성명</label>
				<input name="sndOthNm" id="sndOthNm" value='${sndOthNm}' class="AXInput" />
			</div>
			<div class="hw_clear"></div>
			
			<h4 class="ma_title">연락처</h4> <p class="hw_red">연락처를 입력하세요</p>
			<div class="hw_clear"></div>	
			<div class="hw_infouse_01">
				<label for="hide">연락처</label>
				<input name="sndTel" id="sndTel" value='${sndTel}' class="AXInput" maxlength="11" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"/>
			</div>
			<div class="hw_clear"></div>
			
			<h4 class="ma_title">사용유무</h4> <p class="hw_red">사용유무를 선택하세요</p>
			<div class="hw_clear"></div>				
			<div class="hw_infouse_01">
				<label class="hw_item_search_title" for="siNm">사용유무</label>
				<select id="useYn" name="useYn" class="item_search_select">
					<option value="Y">Y</option>
					<option value="N">N</option>
				</select>
			</div>
			<div class="hw_clear"></div>
			
			<h4 class="ma_title">발신자</h4> <p class="hw_red">발신자를 입력하세요</p>
			<div class="hw_clear"></div>	
			<div class="hw_infouse_01">
				<label for="hide">발신자</label>
				<input name="userNm" id="userNm" value='${userNm}' class="AXInput" />
			</div>
			<div class="hw_clear"></div>
		</form>	
		<div class="hw_clear"></div>
		
	 	<div><input id="add" name="add" class="ma_add_01"  type="button" value="등록하기" onclick="fnObj.form.submit();" /></div>
	 	<div><input id="update" name="update" class="ma_add_01"  type="button" value="수정하기" onclick="fnObj.form.submit2();" /></div>
		<div class="hw_clear"></div>
	</div>
	<!--wrap 끝-->
</article>
</body>
</html>

