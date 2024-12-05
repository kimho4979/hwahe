<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%   
	if (request.getParameter("SEQ_NO")==null){
		request.setAttribute("pageTitle", "화훼 유사시장보고서 등록"); 
		request.setAttribute("WRITE_NAME", request.getParameter("sessionId"));
		request.setAttribute("pageopen", "");
		request.setAttribute("pageopen2", "display:none");            
	}else{
		request.setAttribute("pageTitle", "화훼 유사시장보고서 수정");
		request.setAttribute("pageopen", "display:none");
		request.setAttribute("pageopen2", "");
		request.setAttribute("pagecheck", "1");
		request.setAttribute("SEQ_NO", request.getParameter("SEQ_NO"));
		request.setAttribute("TITLE", request.getParameter("TITLE"));
		request.setAttribute("WRITE_NAME", request.getParameter("WRITE_NAME"));
		request.setAttribute("USE_YN", request.getParameter("USE_YN"));   
		request.setAttribute("INS_DT", request.getParameter("INS_DT"));
		request.setAttribute("CONTENT", request.getParameter("CONTENT"));
		request.setAttribute("ORIGINAL_FILE_NAME", request.getParameter("ORIGINAL_FILE_NAME"));
		request.setAttribute("STORED_FILE_NAME", request.getParameter("STORED_FILE_NAME"));
		request.setAttribute("FILE_SIZE", request.getParameter("FILE_SIZE"));
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
	pageStart: function(){
		/* $("#REG_DATE").bindDate({align:"right", valign:"bottom", separator:"-", selectType:"d",  defaultSelectType:"d",
			onchange:function(){
				//toast.push(Object.toJSON(this));
			}
		});  */       	
		
		if('${pagecheck}' == "1" ){
			//$("#WRITE_NAME").unbindInput();
			$('#WRITE_NAME').attr("disabled","disabled");
			//$('#PUM_NAME').attr("disabled",false);
			//$('#GOOD_NAME').attr("disabled",false);
		}        	        	        	        
        	
		//$("input:radio[name='STATUS']:radio[value='${STATUS}']").attr("checked",true);        	        	
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
					url : "/mntr/mcc01/insertSimilarInput.json",
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
			//dialog.push( $(frm).serialize() );
			return false;
		},
		submit2: function(){				
			var frm = document["send-form"];
			//var obj = app.form.serializeObjectWithIds($("#form-notice"));
			if(confirm("수정하시겠습니까?")==true){
				$('#WRITE_NAME').attr("disabled","disabled");
				var formData = new FormData(frm);
				$.ajax({
					type : "POST",
					url : "/mntr/mcc01/updateSimilarInfoInput.json",
					data : formData,
					contentType: false,
					processData: false,
					success : function(res){
						$('#WRITE_NAME').attr("disabled","disabled");
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
		}else if(parent){
			if(parent.myModal) parent.myModal.close();
		}else{
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
				<div><h4 class="hw_h3_ma_01" >${pageTitle}</h4></div>

			<form name="send-form" id="send-form" enctype="multipart/form-data">
				<input type=hidden id="SEQ_NO" name="SEQ_NO" value="${SEQ_NO}"/>
				<input type=hidden id="GUBN" name="GUBN" value="3"/>
				<input type=hidden id="ORIGINAL_FILE_NAME" name="ORIGINAL_FILE_NAME" value="${ORIGINAL_FILE_NAME}"/>
				<input type=hidden id="STORED_FILE_NAME" name="STORED_FILE_NAME" value="${STORED_FILE_NAME}"/>
				<input type=hidden id="FILE_SIZE" name="FILE_SIZE" value="${FILE_SIZE}"/>
				
				<h4 class="ma_title">제목</h4> <p class="hw_red">제목을 입력하십시오.</p>
				<div class="hw_clear"></div>
				<div class="hw_infouse_01">
					<input type="text"  class="AXInput width94p" id="TITLE" name="TITLE" value="${TITLE}"/>
				</div>
				<div class="hw_clear"></div>
				
				<h4 class="ma_title">작성자</h4> <p class="hw_red"></p>
				<div class="hw_clear"></div>
				<div class="hw_infouse_01">
					<input type="text" id="WRITE_NAME" class="AXInput" name="WRITE_NAME" value="${WRITE_NAME}"/>
				</div>
				<div class="hw_clear"></div>
				
				<h4 class="ma_title">내용</h4> <p class="hw_red">내용을 입력하십시오.</p>
				<textarea name="CONTENT" id="CONTENT" class="AXTextarea" style="box-shadow:inset 0px 0px 3px #ccc;width:100%;height:60px; margin-top:10px; ime-mode:active;box-sizing: border-box;" title="내용">${CONTENT}</textarea>
				<div class="hw_clear"></div>
					
 				<%-- <textarea name="BIGO" id="BIGO" class="AXTextarea" style="box-shadow:inset 0px 0px 3px #ccc;width:100%;height:60px; margin-top:10px; ime-mode:active;box-sizing: border-box;" title="내용">${BIGO}</textarea> --%>
				
					
				<h4 class="ma_title">사진업로드</h4> <p class="hw_red">파일을 업로드해 주세요.</p>
				<div class="hw_clear"></div>
				<div class="hw_infouse_01">
					<a href="/mcc01/mcc01FileDown.json?seq=${SEQ_NO}">${ORIGINAL_FILE_NAME}</a>
					<input type="file" name="file" id="file"/>
				</div>
			</form>	
			<div class="hw_clear"></div>	
			
			<div><input style="${pageopen}"id="add" name="add" class="ma_add_01"  type="button" value="등록하기" onclick="fnObj.form.submit();" /></div>
			<div><input style="${pageopen2}" id="modify" name="modify" class="ma_add_01"  type="button" value="수정하기" onclick="fnObj.form.submit2();" /></div>  
			<div class="hw_clear"></div>
		</div>
	</div><!--wrap 끝-->
</article>
</body>
</html>

