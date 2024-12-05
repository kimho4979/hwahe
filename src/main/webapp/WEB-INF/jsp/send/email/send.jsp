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
	<title>모니터요원 입력시스템-그룹관리</title>
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
  
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.3.0/codemirror.min.js"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.3.0/mode/xml/xml.min.js"></script>
	<script type="text/javascript" src="/plugin/froala/js/froala_editor.min.js"></script>
	<script type="text/javascript" src="/plugin/froala/js/plugins/align.min.js"></script>
	<script type="text/javascript" src="/plugin/froala/js/plugins/code_beautifier.min.js"></script>
	<script type="text/javascript" src="/plugin/froala/js/plugins/code_view.min.js"></script>
	<script type="text/javascript" src="/plugin/froala/js/plugins/draggable.min.js"></script>
	<!-- <script type="text/javascript" src="/plugin/froala/js/plugins/image.min.js"></script>
	<script type="text/javascript" src="/plugin/froala/js/plugins/image_manager.min.js"></script> -->
	<script type="text/javascript" src="/plugin/froala/js/plugins/link.min.js"></script>
	<script type="text/javascript" src="/plugin/froala/js/plugins/lists.min.js"></script>
	<script type="text/javascript" src="/plugin/froala/js/plugins/paragraph_format.min.js"></script>
	<script type="text/javascript" src="/plugin/froala/js/plugins/paragraph_style.min.js"></script>
	<script type="text/javascript" src="/plugin/froala/js/plugins/table.min.js"></script>
	<!-- <script type="text/javascript" src="/plugin/froala/js/plugins/video.min.js"></script> -->
	<script type="text/javascript" src="/plugin/froala/js/plugins/url.min.js"></script>
	<script type="text/javascript" src="/plugin/froala/js/plugins/entities.min.js"></script>
	
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.4.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="/plugin/froala/css/froala_editor.css">
	<link rel="stylesheet" href="/plugin/froala/css/froala_style.css">
	<link rel="stylesheet" href="/plugin/froala/css/plugins/code_view.css">
	<!-- <link rel="stylesheet" href="/plugin/froala/css/plugins/image_manager.css">
	<link rel="stylesheet" href="/plugin/froala/css/plugins/image.css"> -->
	<link rel="stylesheet" href="/plugin/froala/css/plugins/table.css">
	<!-- <link rel="stylesheet" href="/plugin/froala/css/plugins/video.css"> -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.3.0/codemirror.min.css">
  
	
<script type="text/javascript">
	var fullUrl = location.protocol+'//'+location.hostname+(location.port ? ':'+location.port: '');
	//console.log(full);
	
	$(document).ready(function() {
		/* $('#edit').on('froalaEditor.initialized', function (e, editor) {
          $('#edit').parents('form').on('submit', function () {
            //console.log($('#edit').val());
            return false;
          })
        }).froalaEditor({enter: $.FroalaEditor.ENTER_P, placeholderText: null}); */
		
		// ajax 때문에 초기화 한번 해줘야함(값이 남아 있기 때문)
		//resetFileEl();
		//initFileEl("fileData", 1, 80, "zip,png,gif,bmp,jpg,jpeg,7z,hwp,ppt,xls,doc,txt,text,pdf,xlsx,pptx,docx", 0);
	});
	
	// 이메일 등록 처리
	function sendEmail(){
		/* if($("input[name=sender]").val() ==""){
			alert("보내는 사람을 입력해주시기 바랍니다.");
			$("input[name=sender]").focus();
			return false;
		} */
		if($("input[name=address]").val() ==""){
			alert("받는 사람을 입력해주시기 바랍니다.");
			$("input[name=address]").focus();
			return false;
		}
		if($("input[name=title]").val() ==""){
			alert("제목을 입력해주시기 바랍니다.");
			$("input[name=title]").focus();
			return false;
		}
		var cont = $('#edit').val();
		if(cont =="<p>&nbsp;</p>" || cont =="<p></p>" || cont == "" || cont == "<p><br></p>"){
			alert("내용을 입력해주시기 바랍니다.");
			$('#edit').focus();
			return false;
		}
		
		/* if (!confirm('이메일을 발송하시겠습니까?\n다중전송의 경우 메일의 양에 따라 일정 시간이 걸릴 수 있습니다.')) return false;
		
		$("#emailCreateFrm input[name=multiMail]").val($('.mailListInput').val());
		$("#emailCreateFrm").ajaxFormUnbind();
		// 에디터일때
		$("#emailCreateFrm input[name=conHtml]").val(cont);  
		
		ajaxFileFrm("emailCreateFrm", "emailCreateProc" );
		$("#emailCreateFrm").attr("action", "/sendEmail/createProc.do");
		$("#emailCreateFrm").submit(); */
		var address = $("#address").val();
		var title = $("#title").val();
		$.ajax({
			type: "POST",
			url: "/send/sendEmailTranferInsert.json",
			data: {
				address:address,
				title : title,
				cont : cont
			},
			success: function(res) {
				alert("발송을 완료하였습니다.");
				$("#address").val("");
				$("#title").val("");
				$("#edit").val("");
			}
		});
		
		return false;
	}
</script>
   
</head>
<body>
	<%@ include file="/WEB-INF/inc/IncHeader.jsp" %>
	<article>
		<div class="wrap">
		<%@ include file="/WEB-INF/jsp/inc/IncMenu.jsp" %>

		<div class="hw_content"><!--컨텐츠 내용들어가는곳 시작-->
		<h3 class="hw_h3_ma"><div class="half1_white"></div><span class="half_title">E-Mail발송</span></h3>
		<div class="hw_clear"></div>	
	
		<div class="hw_infouse_01">  <p> <span class="purple"> ◎ 이용안내 :</span> 아래의 내용을 입력해 주시기 바랍니다.</p></div>
		<div class="hw_clear"></div>

		<div class="ibox-content">
			<form id="emailCreateFrm" name="emailCreateFrm" method="post" class="form-horizontal" enctype="multipart/form-data" >
				<div class="emailBox">
					<label for="subject">받는 사람 :</label>
					<input type="text" class="emailInput" id="address" name="address" value="" /> <br/>
					
					<label for="subject">제목 :</label>
					<input type="text" class="emailInput input02" id="title" name="title" value="" /> <br/>
					
					<label for="subject">첨부파일 :</label>
					<input type="file" id="file" name="file" value=""/>
				</div><!-- emailBox end -->
				
				<textarea id="edit" name="edit" style="margin-top:0px;width:100%;height:300px;" placeholder="내용을 입력하여 주십시오."></textarea>
				
				<button type="button" class="ma_add_01" type="button" onclick="sendEmail();">이메일보내기</button>
			</form>
		</div>
		</div><!--wrap 끝-->
	</article>
	<footer>
		<%@ include file="/WEB-INF/inc/IncFooter.jsp" %>
	</footer>
</body>
</html>