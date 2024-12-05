<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
 
  <script type="text/javascript">
  $(function(){
  	$('#button-add-file').click(function(){
  			addFileForm();  			
  	});
  	
  	$(document).on('click', '.button-delete-file', function(event) {
  		$(this).parent().remove();
  	});
  });
  var count = 0;
  
  function addFileForm() {
	
  	var html = "<div id='item_"+count+"'>";
  	html += "<input type='file' name='file' />";
  	html += "<button class='button-delete-file' id='button-delete-file' 'display:none'>삭제</button></div>";
  	count++;
  	$("#my-form").append(html);
  }
  
  var myProgress = new AXProgress();      
  var myUpload = new AXUpload5();
  
  var fnObj = {
	        pageStart: function(){
  	        	
	        },

	        form: {
				submit: function(){
					
					var frm = document["send-form"];
					if(confirm("등록하시겠습니까?")==true){
			         var formData = new FormData(frm);
					  $.ajax({
			                 url : "/hba01/insertForecast.json",
			                  data : formData, 
			                 contentType: false,
			                 processData: false,
			                 type : "POST",
			                 success : function(res){   		                	
			                	 parent.myModal.close();
			                	 $("#listForm").attr("action", "<c:url value='/hba01/hba01.do'/>").submit(); 
			                 },
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
				           url : "/hba01/updateForecast.json",
				           data : formData,			           		           
				           contentType: false,
			               processData: false,
			               type : "POST",
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
	  
  
  jQuery(document.body).ready(function () {fnObj.pageStart()});
  
  </script>
<article>
	<div class="board_popup_wrap">
	<div class="board_popup_content">
		<div class="board_topbox">월간장미수급예측보고서</div>
			<div class="board_size">
			<div class="board_size_bottom">
				<form name="send-form" id="send-form" enctype="multipart/form-data">
				<div class="board_popup_content">				
						<c:set var="name" value="${gubn}" />
						<c:if test="${name eq 'reg'}">
						<div class="board_size_top">
							<div class="left_board4"><span class="left_board_title">제목</span></div>
							<div class="left_board5"><span class="left_board_title"><input type="text" name="TITLE" id="TITLE"/></span></div>
						</div>
						<div class="board_size_top">
							<div class="left_board4"><span class="left_board_title">파일업로드</span></div>
							<div class="left_board5"><input type="button" id='button-add-file' value="파일 추가"></input><div id='my-form'></div></div>
						</div>
						</c:if>
						<c:if test="${name eq 'update' }">
						<input type="hidden" name="SEQ_NO" id="SEQ_NO" value="${seqNum}"/>
						<div class="board_size_top">
							<div class="left_board4"><span class="left_board_title">번호</span></div>
							<div class="left_board5"><span class="left_board_title"><input type="text"  name="ANUM" id="ANUM" value="${seq}" disabled /></span></div>
						</div>
						<div class="board_size_top">
							<div class="left_board4"><span class="left_board_title">제목</span></div>
							<div class="left_board5"><span class="left_board_title"><input type="text" name="TITLE" id="TITLE"  value="${title}"  /></span></div>
						</div>
						<div class="board_size_top">
							<div class="left_board4"><span class="left_board_title">작성자</span></div>
							<div class="left_board5"><span class="left_board_title">관리자</span></div>
						</div>
						<div class="board_size_top">
							<div class="left_board4"><span class="left_board_title">작성일</span></div>
							<div class="left_board5"><span class="left_board_title"><input type="text" name="INS_DT" id="INS_DT"   value="${insDt}" disabled /></span></div>
						</div>
						<div class="board_size_top">
							<div class="left_board4"><span class="left_board_title">파일업로드</span></div>
							<div class="left_board3"><span class="left_board_title">${orFileNm}<input type="file" name="file" id="file" class="ml_10" value="${orFileNm}"  /></span></div>
						</div>
			
						</c:if>
					</div>
				</form>
			</div>
		</div>
		</div>
		<div class="cover_bpclose">
		<c:if test="${name eq 'reg'}">
		<button type="button" id="add" class="subBtn" onClick="fnObj.form.submit();" style="cursor:pointer">등록</button>
		</c:if>
		<c:if test="${name eq 'update'}">
		<button type="button" id="modify"  class="subBtn" onClick="fnObj.form.submit2();" style="cursor:pointer">수정</button>
		</c:if>
		<button type="button" class="subBtn" onClick=" parent.myModal.close();" style="cursor:pointer">닫기</button></div>
	</div>