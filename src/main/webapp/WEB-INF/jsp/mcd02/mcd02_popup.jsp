<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%   
  if(request.getParameter("eventGp")==null &&
	 request.getParameter("eventYmd")==null &&
	 request.getParameter("eventTim")==null &&
	 request.getParameter("eventNm")==null) {
    request.setAttribute("pageTitle", "행사일정 관리 등록"); 
    String id=(String)session.getAttribute("SESSION_USER_ID");
    request.setAttribute("pageopen", "");
    request.setAttribute("pageopen2", "display:none");            
  }
  else{
    request.setAttribute("pageTitle", "행사일정 관리 수정");
    request.setAttribute("pageopen", "display:none");
    request.setAttribute("pageopen2", "");
    request.setAttribute("pagecheck", "1");
    request.setAttribute("eventGp", request.getParameter("eventGp"));
    request.setAttribute("eventYmd", request.getParameter("eventYmd"));
    request.setAttribute("eventTim", request.getParameter("eventTim"));
    request.setAttribute("eventNm", request.getParameter("eventNm"));
    request.setAttribute("siNm", request.getParameter("siNm"));
    request.setAttribute("addr", request.getParameter("addr"));
    request.setAttribute("eventPls", request.getParameter("eventPls"));
  }   
%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, user-scalable=no">
	<title>행사일정 등록 </title>
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
	
var fnObj = {
	form: {
		submit: function(){
			var frm = document["send-form"];
			if(confirm("등록하시겠습니까?")==true){
				var formData = new FormData(frm);
				$.ajax({
					type : "post",
					url : "/mntr/mcd02/insertEventSch.json",
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
				$("#eventGp").removeAttr("disabled");
				var formData = new FormData(frm);
				$.ajax({
		           type : "post",
		           url : "/mntr/mcd02/updateEventSch.json",
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

function commonSelect(){
	$.ajax({
		type : 'post',
		url : "/mntr/mcd02/selectAreaNm.json",
		data : {},
		dataType : '',   	           
		success : function(res){
			var val = res.list;
			
			$("#siNm").empty();
			$("#siNm").append("<option value=''>전체</option>");
			for(var i=0; i<val.length; i++){
				$("#siNm").append("<option value="+val[i].cdId+">"+val[i].cdNm+"</option>");
			}
			
			if('${pagecheck}' == "1" ){
				$("select[name=siNm]").val("${siNm}");
			}
		}
	});
};

$(document).ready(function(){
	// 시 공통코드 조회
	commonSelect();
	
	if('${pagecheck}' == "1" ){
		$("#add").attr("type", "hidden");
		
		$("select[name=eventGp]").val("${eventGp}");
		$('#eventNm').val("${eventNm}");
		$('#eventYmd').val("${eventYmd}");
		$('#eventTim').val("${eventTim}");
		$('#addr').val("${addr}");
		$('#eventPls').val("${eventPls}");
		
		$("#eventGp").attr("disabled", true);
		$('#eventNm').attr("readonly", true);
		$('#eventYmd').attr("readonly", true);
		$('#eventTim').attr("readonly", true);
	}
	else {
		$("#update").attr("type", "hidden");
		
		//검색 조건 Default Date 설정 시작
		var date = new Date();
		var year = date.getFullYear();

		var month = date.getMonth()+1;
		month = month > 9 ? month : '0'+month;
		        
		var day = date.getDate();
		day = day > 9 ? day : '0'+day;

		var dt = year + "-" + month + "-" + day;
		        
		var rd1 = $('#eventYmd').val(dt);
				
		$('#eventYmd').bindDate({align:"right", valign:"bottom", separator:"-", selectType:"d",  defaultSelectType:"d", defaultDate : "rd1"});
		
		$('#siNm').change(function(){
			$('#addr').val($(this).val());
		});
	}
});
</script>
</head>
<body>  	 
	<article>
		<div class="ma_content"><!--컨텐츠 내용들어가는곳 시작-->
			<div><h4 class="hw_h3_ma_01" >${pageTitle}</h4></div>
		<form name="send-form" id="send-form" enctype="multipart/form-data">
			<h4 class="ma_title">행사구분</h4> <p class="hw_red">행사구분을 선택하세요</p>
			<div class="hw_clear"></div>				
			<div class="hw_infouse_01">
				<label class="hw_item_search_title" for="eventGp">행사구분</label>
				<select name="eventGp" id="eventGp" class="item_search_select">
					<option value="10">졸업식</option>
					<option value="11">화훼관련행사</option>
					<option value="50">국가공인시험</option>
				</select>
			</div>
			<div class="hw_clear"></div>
			
			<h4 class="ma_title">행사명</h4> <p class="hw_red">행사명을 입력하세요</p>
			<div class="hw_clear"></div>	
			<div class="hw_infouse_01">
				<label for="hide">행사명</label>
				<input name="eventNm" id="eventNm" value='${eventNm}' class="AXInput" />
			</div>
			<div class="hw_clear"></div>
			
			<h4 class="ma_title">행사일자</h4> <p class="hw_red">행사일자를 선택하세요</p>
			<div class="hw_clear"></div>	
			<div class="hw_infouse_01">
				<label for="hide">행사일자</label>
				<input type="text" name="eventYmd" id="eventYmd" class="AXInput" value="" />
			</div>
			<div class="hw_clear"></div>
			
			<h4 class="ma_title">행사시간</h4> <p class="hw_red">행사시간을 입력하세요</p>
			<div class="hw_clear"></div>	
			<div class="hw_infouse_01">
				<label for="hide">행사시간</label>
				<input name="eventTim" id="eventTim" value='${eventTim}' class="AXInput" maxlength="6" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"/>
			</div>
			<div class="hw_clear"></div>
			
			<h4 class="ma_title">시</h4> <p class="hw_red">시를 선택하세요</p>
			<div class="hw_clear"></div>				
			<div class="hw_infouse_01">
				<label class="hw_item_search_title" for="siNm">시</label>
				<select id="siNm" name="siNm" class="item_search_select"></select>
			</div>
			<div class="hw_clear"></div>
			
			<h4 class="ma_title">상세주소</h4> <p class="hw_red">상세주소를 입력하세요</p>
			<textarea name="addr" id="addr" class="AXTextarea" style="box-shadow:inset 0px 0px 3px #ccc;width:100%;height:30px; 
					  margin-top:10px; ime-mode:active;box-sizing: border-box;" title="상세주소" >${addr}</textarea>
			<div class="hw_clear"></div>
			
			<h4 class="ma_title">행사장명</h4> <p class="hw_red">행사장명을 입력하세요</p>
			<div class="hw_clear"></div>	
			<div class="hw_infouse_01">
				<label for="hide">행사장명</label>
				<input name="eventPls" id="eventPls" value='${eventPls}' class="AXInput" />
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

