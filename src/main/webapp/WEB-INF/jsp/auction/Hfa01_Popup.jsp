<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

  <script type="text/javascript">
  var fnObj = {
	        pageStart: function(){
  	        	
	        },

	        form: {
				submit: function(){
					
					var frm = document["send-form"];
					if(confirm("등록하시겠습니까?")==true){
					//alert($(frm).serialize());
			         var formData = new FormData(frm);
					 //frm.action = "/mntr/mab01/insertCropInfoInput.json";
					  $.ajax({
			                 url : "/hfa01/insertNotice.json",
			                  data : formData, 
			                 contentType: false,
			                 processData: false,
			                 type : "POST",
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
		        		  var formData = new FormData(frm);
					$.ajax({			        
				           url : "/hfa01/updateNotice.json",
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
  
  <div class="lp_wrap">
		<div class="lp_container" id="utda_input"><!-- D: ID 필수 -->
			<div class="lp_area">
				
				<div class="lp_content">
					<h2 class="lp_tit">공지사항</h2><!-- lp_tit end -->
					<table class="boxList">
						<caption>공지사항</caption>
						<colgroup>
							<col style="width:30%;">
							<col style="width:*;">
							<col style="width:30%;">
							<col style="width:30%;">
						</colgroup>
						<tbody>
							<tr>
								<th>번호</th>
								<td id="rNum"></td>
								<th>작성자</th>
								<td id="insId"></td>
							</tr>
							<tr>
								<th>제목</th>
								<td colspan="3" id="title"></td>
							</tr>
							<tr>
								<th>내용</th>
								<td colspan="3" id="contentView"></td>
							</tr>
							<tr class="fileUp">
								<th>파일업로드</th>
								<td colspan="3" id="fileName" class="mxWidth80" >
								<a href="/hfa01/hfa01FileDown.json?seq=${notice.SEQ}" download><img src="<c:url value='/images/filedownload.gif'/>" alt="파일다운로드" >FileDownLoad</a>
								</td>
							</tr>
						</tbody>
					</table><!-- boxList end -->
					<!-- <div class="btnWrap">
						<button class="btn02">수정</button>
						<button class="btn02">닫기</button>
					</div> --><!-- btnWrap end -->
				</div>
				<button type="button" class="lp_close"><span>닫기</span></button>
			</div>
		</div><!-- // lp_container end -->
	</div><!-- // layer popup wrap end -->
  
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
							<div class="left_board4"><span class="left_board_title">내용</span></div>
							<div class="left_board5"><span class="left_board_title"><input type="textarea" name="CONTENT" id="CONTENT"/></span></div>
						</div>
						<div class="board_size_top">
							<div class="left_board4"><span class="left_board_title">파일업로드</span></div>
							<div class="left_board5"><span class="left_board_title"><input type="file" name="file" id="file"/></span></div>
						</div>
						</c:if>
						<c:if test="${name eq 'update' }">
						<input type="hidden" name="SEQ" id="SEQ" value="${seqNum}"/>
						<div class="board_size_top">
							<div class="left_board4"><span class="left_board_title">번호</span></div>
							<div class="left_board5"><span class="left_board_title"><input type="text"  name="RNUM" id="RNUM" value="${seq}" disabled /></span></div>
						</div>
						<div class="board_size_top">
							<div class="left_board4"><span class="left_board_title">제목</span></div>
							<div class="left_board5"><span class="left_board_title"><input type="text" name="TITLE" id="TITLE"  value="${title}"  /></span></div>
						</div>
						<div class="board_size_top">
							<div class="left_board4"><span class="left_board_title">내용</span></div>
							<div class="left_board5"><span class="left_board_title"><input type="text" name="CONTENT" id="CONTENT"  value="${content}"  /></span></div>
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