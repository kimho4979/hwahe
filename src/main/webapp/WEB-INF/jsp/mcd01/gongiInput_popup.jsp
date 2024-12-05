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
	<title>공지사항 입력창 </title>
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
					type : "POST",
					url : "/mntr/mcd01/insertGongiInput.json",
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
				$('#INS_ID').attr("disabled","disabled");
				var formData = new FormData(frm);
				$.ajax({
					type : "POST",
					url : "/mntr/mcd01/updateGongiInfoInput.json",
					data : formData,
					contentType: false,
					processData: false,
					success : function(res){
						//$('#INS_ID').attr("disabled","disabled");
						alert("수정완료");
						parent.myModal.close();
					}
				}); 
			}else{
				return;
			}
			alert("수정완료");
			parent.myModal.close();
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
		<c:set var="notice" value="${selectMcd01}"/>
			<div class="ma_content"><!--컨텐츠 내용들어가는곳 시작-->
				<div><h4 class="hw_h3_ma_01" >${pageTitle}</h4></div>
			<form name="send-form" id="send-form" enctype="multipart/form-data">
				<input type=hidden id="SEQ" name="SEQ" value="${notice.seq}"/>
				<input type=hidden id="BBS_GUBN" name="BBS_GUBN" value="1"/>
				<input type=hidden id="ORIGIN_FILE_NAME" name="ORIGIN_FILE_NAME" value="${notice.originFileName}"/>
				<input type=hidden id="STORED_FILE_NAME" name="STORED_FILE_NAME" value="${notice.storedFileName}"/>
				<input type=hidden id="FILE_SIZE" name="FILE_SIZE" value="${notice.fileSize}"/>
				
				<h4 class="ma_title">제목</h4> <p class="hw_red">제목을 입력하십시오.</p>
				<div class="hw_clear"></div>
				<div class="hw_infouse_01">
					<input type="text" id="TITLE" class="AXInput width94p" name="TITLE" value="${notice.title}"/>
				</div>
				<div class="hw_clear"></div>
				
				<h4 class="ma_title">작성자</h4> <p class="hw_red"></p>
				<div class="hw_clear"></div>
				<div class="hw_infouse_01">
					<c:if test="${!empty notice.seq }">
						<input type="text" id="INS_ID"  class="AXInput" name="INS_ID" value="${notice.insId}" readonly="readonly"/>
					</c:if>
					<c:if test="${empty notice.seq }">
					 	<input type="text" id="INS_ID"  class="AXInput" name="INS_ID" value="${SESSION_USER_ID}" readonly="readonly"/>
					</c:if>  
					
				</div>
				<div class="hw_clear"></div>
				
				<h4 class="ma_title">내용</h4> <p class="hw_red">내용을 입력하십시오.</p>
				<textarea name="CONTENT" id="CONTENT" class="AXTextarea" style="box-shadow:inset 0px 0px 3px #ccc;width:100%;height:60px; margin-top:10px; ime-mode:active;box-sizing: border-box;" title="내용">${notice.content}</textarea>
				<div class="hw_clear"></div>
					
 				<%-- <textarea name="BIGO" id="BIGO" class="AXTextarea" style="box-shadow:inset 0px 0px 3px #ccc;width:100%;height:60px; margin-top:10px; ime-mode:active;box-sizing: border-box;" title="내용">${BIGO}</textarea> --%>
				<div class="hw_clear"></div>
					
				<h4 class="ma_title">파일업로드</h4> <p class="hw_red">파일을 업로드해 주세요.</p>
				<div class="hw_clear"></div>
				<div class="hw_infouse_01">
					<a href="/mcd01/mcd01FileDown.json?seq=${notice.seq}">${notice.originFileName}</a>
					<input type="file" name="file" id="file"/>
				</div>
			</form>	
			<div class="hw_clear"></div>	
			
			<c:if test="${!empty notice.seq }">
				<div><input  id="modify" name="modify" class="ma_add_01"  type="button" value="수정하기" onclick="fnObj.form.submit2();" /></div>
			</c:if>
			<c:if test="${empty notice.seq }">
			 	<div><input id="add" name="add" class="ma_add_01"  type="button" value="등록하기" onclick="fnObj.form.submit();" /></div>
			</c:if>  
			<div class="hw_clear"></div>
		</div>
	</div><!--wrap 끝-->
</article>
</body>
</html>

