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
	<title>고객상담실 입력창 </title>
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
		html{
			min-height:900px;
		}
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

function showReply(){
	$('html').css('min-height','900px');
	$('#myModalCT').css('height','900px');
	
	$('#reply').show();
	$(window).resize();
}

$(document).ready(function(){
		$('#reply').hide();
});
	
var fnObj = {
	form: {
		submit: function(){
			var frm = document["send-form"];
			if(confirm("등록하시겠습니까?")==true){
				var formData = new FormData(frm);
				$.ajax({
					type : "POST",
					url : "/mnt/mcf01/insertCustomerBbs.json",
					data : formData, 
					contentType: false,
					processData: false,
					success : function(res){   		                	
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
				$('#insId').attr("disabled","disabled");
				var formData = new FormData(frm);
				$.ajax({
					type : "POST",
					url : "/mnt/mcf01/insertCustomerBbs.json",
					data : formData,
					contentType: false,
					processData: false,
					success : function(res){
						$('#insId').attr("disabled","disabled");
						alert("수정완료");
						parent.myModal.close();
					}
				}); 
			}else{
				return;
			}
			return false;
		}
		,
		submit3: function(){				
			var frm = document["send-form"];
			if(confirm("삭제하시겠습니까?")==true){
				var deleteValue = ($('#seq').val()+','+$('#title').val()+','+$('#insId').val()+','+$('#storedFileName').val()+'!');
				$('#insId').attr("disabled","disabled");
				var formData = new FormData(frm);
				$.ajax({
					type : "POST",
					url : "/mntr/mcf01/deleteCustomerBbs.json",
					data : deleteValue,
					success : function(res){
						$('#insId').attr("disabled","disabled");
						alert("삭제완료");
						parent.myModal.close();
					}
				}); 
			}else{
				return;
			}
			return false;
		}
		,
		submit4: function(){				
			var frm = document["send-form2"];
			if(confirm("답글등록하시겠습니까?")==true){
				var formData = new FormData(frm);
				$.ajax({
					type : "POST",
					url : "/mnt/mcf01/insertCustomerBbs.json",
					data : formData, 
					contentType: false,
					processData: false,
					success : function(res){   		                	
						parent.myModal.close();
					}
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
</script>
</head>
<body>  	 
	<article>
		<div>
		<c:set var="data" value="${list}"/>
			<div class="ma_content"><!--컨텐츠 내용들어가는곳 시작-->
				<div><h4 class="hw_h3_ma_01" >${pageTitle}</h4></div>
			<form name="send-form" id="send-form" enctype="multipart/form-data">
				<input type=hidden id="seq" name="seq" value="${data.encryptSeq}"/>
				<input type=hidden id="parentSeq" name="parentSeq" value="${data.parentSeq}"/>
				<input type=hidden id="usrNm" name="usrNm" value="관리자"/>
				<input type=hidden id="originFileName" name="originFileName" value="${data.originFileName}"/>
				<input type=hidden id="storedFileName" name="storedFileName" value="${data.storedFileName}"/>
				<input type=hidden id="fileSize" name="fileSize" value="${data.fileSize}"/>
				
				<h4 class="ma_title">제목</h4> <p class="hw_red">제목을 입력하십시오.</p>
				<div class="hw_clear"></div>
				<div class="hw_infouse_01">
					<input type="text" id="title" class="AXInput width94p" name="title" value="${data.titleOri}"/>
				</div>
				<div class="hw_clear"></div>
				
				<h4 class="ma_title">작성자</h4> <p class="hw_red"></p>
				<div class="hw_clear"></div>
				<div class="hw_infouse_01">
					<c:if test="${!empty data.seq }">
						<input type="text" id="insId"  class="AXInput" name="insId" value="${data.usrNmOri}" readonly="readonly"/>
					</c:if>
					<c:if test="${empty data.seq }">
					 	<input type="text" id="insId"  class="AXInput" name="insId" value="관리자" readonly="readonly"/>
					</c:if>  
					
				</div>
				<div class="hw_clear"></div>
				
				<h4 class="ma_title">내용</h4> <p class="hw_red">내용을 입력하십시오.</p>
				<textarea name="cont" id="cont" class="AXTextarea" style="box-shadow:inset 0px 0px 3px #ccc;width:100%;height:60px; margin-top:10px; ime-mode:active;box-sizing: border-box;" title="내용">${data.contOri}</textarea>
				<div class="hw_clear"></div>
					
				<h4 class="ma_title">파일업로드</h4> <p class="hw_red">파일을 업로드해 주세요.</p>
				<div class="hw_clear"></div>
				<div class="hw_infouse_01">
					<a href="/bbs/customerBbsFileDown.json?seq=${data.encryptSeq}">${data.originFileName}</a>
					<input type="file" name="file" id="file"/>
				</div>
			</form>	
			<div class="hw_clear"></div>	
			
			<c:if test="${!empty data.seq }">
				<div align="center"><input  id="modify" name="modify" class="ma_add"  type="button" value="수정" onclick="fnObj.form.submit2();" />
				<input  id="modify" name="modify" class="ma_del"  type="button" value="삭제" onclick="fnObj.form.submit3();" />
				<input  id="modify" name="modify" class="ma_re"  type="button" value="답글" onclick="showReply();" />
				</div>
			</c:if>
			<c:if test="${empty data.seq }">
			 	<div><input id="add" name="add" class="ma_add_01"  type="button" value="등록" onclick="fnObj.form.submit();" /></div>
			</c:if>  
			
			<div id="reply">
				<form name="send-form2" id="send-form2" enctype="multipart/form-data">
					<input type=hidden id="parentSeq" name="parentSeq" value="${data.seq}"/>
					<input type=hidden id="usrPass" name="usrPass" value="${data.usrPass}"/>
					<input type=hidden id="usrNm" name="usrNm" value="관리자"/>
					
					<h4 class="ma_title">답글 제목</h4> <p class="hw_red">답글 제목을 입력하십시오.</p>
					<div class="hw_clear"></div>
					<div class="hw_infouse_01">
						<input type="text" id="title" class="AXInput width94p" name="title""/>
					</div>
					<div class="hw_clear"></div>
										
					<h4 class="ma_title">내용</h4> <p class="hw_red">내용을 입력하십시오.</p>
					<textarea name="cont" id="cont" class="AXTextarea" style="box-shadow:inset 0px 0px 3px #ccc;width:100%;height:60px; margin-top:10px; ime-mode:active;box-sizing: border-box;" title="내용"></textarea>
					<div class="hw_clear"></div>
						
					<h4 class="ma_title">파일업로드</h4> <p class="hw_red">파일을 업로드해 주세요.</p>
					<div class="hw_clear"></div>
					<div class="hw_infouse_01">
						<input type="file" name="file" id="file"/>
					</div>
				</form>	
				
				<div class="hw_clear"></div>
					<div><input id="add" name="add" class="ma_add_01"  type="button" value="답글등록" onclick="fnObj.form.submit4();" /></div>
			</div>
			
		</div>
	</div><!--wrap 끝-->
</article>
</body>
</html>

