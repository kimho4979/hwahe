<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
	String seq = (String)request.getAttribute("mainSeq");
	String title = (String)request.getAttribute("mainTitle");
	String content = (String)request.getAttribute("mainContent");
	String insId = (String)request.getAttribute("mainInsId");
	String insDt = (String)request.getAttribute("mainInsDt");
	String gubn = (String)request.getAttribute("mainGubn");
	String orFileNm = (String)request.getAttribute("mainOrFileNm");
	String seqNum = (String)request.getAttribute("mainSeqNum");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
	<meta charset="utf-8">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, user-scalable=no">
	<meta name="apple-mobile-web-app-title" content="화훼유통정보시스템">
	<meta name="robots" content="no-index,follow">
	<meta name="og:title" content="화훼유통정보시스템">
	<meta name="og:description" content="화훼유통정보시스템">
	<meta name="description" content="공지사항">
	<meta name="content" content="화훼유통정보시스템 입니다.">
	<meta name="keywords" content="화훼경매시세, 화훼경매가격, Korea aT flower market auction price, 화훼공판장, 화훼거래정보, 꽃시장, 꽃값">
	<meta name="Author" content="화훼유통정보시스템 & www.woorim.co.kr">
	<title>공지사항</title>
	<%@include file="../common/2020/commonJs.jsp" %>
	<%@include file="../common/2020/commonCss.jsp" %>
  
	<script type="text/javascript">
		var myModal = new AXModal();
	
		/**
		 * Require Files for AXISJ UI Component...
		 * Based        : jQuery
		 * Javascript    : AXJ.js, AXModal.js
		 * CSS            : AXJ.css
		 */
		var seq = '<%=seq%>';
		var title = '<%=title%>';
		var content = '<%=content%>';
		var insId = '<%=insId%>';
		var insDt = '<%=insDt%>';
		var gubn = '<%=gubn%>';
		var orFileNm = '<%=orFileNm%>';
		var seqNum = '<%=seqNum%>';
		
		var fnObj = {
		    pageStart: function () {
		        if(seq != null&&seq != ''&&seq != 'null'){ 
		        	fnObj.modalOpenNew(seq);
		        }
		    },
		    
		    modalOpen: function (seq) {
		    	addClickCnt(seq);
		    	$.ajax({
		            url : "/hfa01/getHfa01Seq.json",
		            data : {
		           	 seq : seq
		    		},
		    		dataType : '',
		            success : function(res){
		               	$("#rNum").text(res.list.rnum1);
		               	$("#insId").text('관리자');
		               	$("#title").text(res.list.title);
		               	
		               	var html='';
		               	var emp=res.list.content;
		               	emp = emp.replace(/< BR >/gi, "<br />");
		               	if(res.list.origin_FILE_NAME!=null){
		               		if(res.list.origin_FILE_NAME.indexOf(".png")>-1||res.list.origin_FILE_NAME.indexOf(".jpg")>-1){
		               			html='<img src="/upload/'+res.list.stored_FILE_NAME+'" alt="첨부파일"/><br/>'+emp;
		               		}else{
		               			html=emp;
		               		}
		               	}else{
		               		html=emp;
		               	}
		                var contentView = document.getElementById("contentView");
		                contentView.innerHTML = emp;
		               	if(res.list.origin_FILE_NAME!= null&&res.list.origin_FILE_NAME!= ''){
		               		//var aString = "<a href='/hfa01/hfa01FileDown.json?seq="+res.list.encrpt_SEQ+"' download><img src='/images/filedownload.gif' alt='파일다운로드' >"+res.list.origin_FILE_NAME+"</a>";
		               		var aString = "<a href='/hfa01/hfa01FileDown.json?seq="+res.list.encrpt_SEQ+"' class='file_down' download><span class='file_name'>"+res.list.origin_FILE_NAME+"</span></a>";
		                   	
		               		$("#fileName").html(aString);
		               	}else{
		               		$("#fileName").html('');
		               	}
		               	//fnShowLayer('#utda_input');	               	
		               	fnLayerPopup('#utda_input');
		            }
		        }); 
		    },
		    // 17.08.11 희준 작업 :: SEQ로만 데이터 1건 조회 하는 Funtion 추가
			modalOpenNew: function (seq) {
				addClickCnt(seq);
				fnObj.modalOpen(seq);
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
		
		function gfn_isNull(str) {
			if (str == null) return true;
			if (str == "NaN") return true;
			if (new String(str).valueOf() == "undefined") return true;    
		   var chkStr = new String(str);
		   if( chkStr.valueOf() == "undefined" ) return true;
		   if (chkStr == null) return true;    
		   if (chkStr.toString().length == 0 ) return true;   
		   return false; 
		}
		
		function ComSubmit(opt_formId) {
			this.formId = gfn_isNull(opt_formId) == true ? "commonForm" : opt_formId;
			this.url = "";
			
			if(this.formId == "commonForm"){
				$("#commonForm")[0].reset();
			}
			
			this.setUrl = function setUrl(url){
				this.url = url;
			};
			
			this.addParam = function addParam(key, value){
				$("#"+this.formId).append($("<input type='hidden' name='"+key+"' id='"+key+"' value='"+value+"' >"));
			};
			 
			
			 this.submit = function submit(){
				var frm = $("#"+this.formId)[0];
				frm.action = this.url;
				frm.method = "post";
				frm.submit();	
			};
		
		}
		
		function fn_searchPage(pageNo){
		   var comSubmit = new ComSubmit();
		   comSubmit.setUrl("<c:url value='/hfa01/hfa01.do'/>");
		   comSubmit.addParam("currentPageNo", pageNo);
		   
		   comSubmit.addParam("searchType", $("#searchType").val());
		   comSubmit.addParam("searchValue", $("#searchValue").val());
		   
		   comSubmit.submit();
		};
		
		$(document).ready(function(){
			 $("#chkall").click(function(){
				//클릭되었으면
				if($("#chkall").prop("checked")){
			        //input태그의 name이 chk인 태그들을 찾아서 checked옵션을 true로 정의
			        $("input[name=clochk]").prop("checked",true);
			        //클릭이 안되있으면
			    }else{
			        //input태그의 name이 chk인 태그들을 찾아서 checked옵션을 false로 정의
					$("input[name=clochk]").prop("checked",false);
				}
			});
		});
		
		function fn_delete() {	
			if($("input[name='clochk']:checked").length<1){
				alert("1개 이상의 체크박스를 선택 하세요.");
				return false;
			}
			
			var checkboxValues = [];
			var param = "";
			
		   $("input[name='clochk']:checked").each(function(i) {
		   	var seq_no  = $(this).val();
		
		   	param = param + "&seq_no="+seq_no;
		
		   });
		
		}	
		
		function fn_search(pageNo) {		
			$("#currentPageNo").val(pageNo);
			$("#searchForm").attr("action", "<c:url value='/hfa01/hfa01.do'/>").submit();
		}
		
		function addClickCnt(SEQ){
			$.ajax({
				type : "post",
				url : "/hfa01/updateNoticeClickCnt.json",
				data : {
					SEQ : SEQ
				},
				dataType : '',
				success : function(res){
					var clickCnt = $(".td_"+SEQ).html();
					$(".td_"+SEQ).html((Number(clickCnt)+1));
				}
			});
		}
		
	</script>
</head>


<body>	
	<!--WRAP(S)-->
	<div class="wrap">
		<form  id="myForm" name="myForm" method="post">
    		<input type="hidden" id="searchProductGubun" name="searchProductGubun" value="${searchProductGubun}"/>    	
		</form>
	
		<jsp:include page="../inc/2020/IncHeader.jsp"/>
		
		<!--서브 헤더 (S)-->
		<div class="lnb_box">
			<ul>
				<li><img src="../images/2020/m_lnb_img.png" alt="집"></li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li>열린광장</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li>알림마당</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li class="m_right">공지사항</li>
			</ul>
		</div>
		<!--sub 헤더 (E)-->
		<!--서브 타이틀(S)-->
		<div class="sub_sns">
		</div>
		
		<div class="sub_title">			
			<div class="title_box">
				<h2>공지사항</h2>
				<img src="../images/2020/sub/t_line.png" alt="방울점선">
			</div>
		</div>
		<!--서브 타이틀(E)-->
		
		<!--콘텐츠_메인(S)-->
		<div class="sub_contents">			
				
			<form name="searchForm" id="searchForm" method="post">
				<input type="hidden" name="currentPageNo" value="" />
					
			<!-- 검색창(S) -->
			<div class="search_box_s">
				<div class="fr">
					<select class="select search" name="searchType" id="searchType">
						<option value="searchTitle" <c:if test="${pRequestParamMap.searchType == 'searchTitle'}">selected="selected"</c:if> >제목</option>
						<option value="searchCnts" <c:if test="${pRequestParamMap.searchType == 'searchCnts'}">selected="selected"</c:if> >내용</option>
					</select>
					<label for="sel_search"></label>

					<input type="text" class="ip_search" name="searchValue" id="searchValue" placeholder="검색어를 입력하세요" value="<c:out value='${pRequestParamMap.searchValue}'/>" />
					<label for="searchValue"></label>

					<button type="button" class="btn_search" onclick="fn_search(1)">검색</button>
				</div>
			</div>
			<!-- 검색창(E) -->
				
			</form>
				
			<form:form commandName="calculateVo" name="listForm" id="listForm" method="post">
			<!-- 테이블02(S) -->
			<table class="table_type_02">
				<caption>공지사항</caption>
				<colgroup>
					<col style="width:10%">
					<col style="width:40%">
					<col style="width:16%">
					<col style="width:10%">
					<col style="width:12%">
					<col style="width:12%">
				</colgroup>
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>첨부파일</th>
						<th>작성일</th>
						<th>조회수</th>
					</tr>
				</thead>
				<tbody>
					<c:set var="hfa01" value="${selectHfa01}"/>
					<c:if test="${!empty hfa01 }">
						<c:forEach var="notice" items="${selectHfa01}"  varStatus="status">
							<tr>
								<td class="tc">
									${notice.RNUM}
								</td>
								<td>
									<a href="#" class="ellipsis" onclick="fnObj.modalOpen('${notice.ENCRPT_SEQ}');" >${notice.TITLE}</a>
									<%-- <input type='hidden' name='noticeContent${notice.SEQ}' id='noticeContent${notice.SEQ}' value='${notice.CONTENT}'> --%>
								</td>
								<td class="tc">
									<%-- ${notice.INS_ID} --%>관리자
								</td>
								<td class="tc">
									<c:if test="${not empty notice.STORED_FILE_NAME}">
										<a href="/hfa01/hfa01FileDown.json?seq=${notice.ENCRPT_SEQ}" class="file_down" download></a>
									</c:if>
									<c:if test="${empty notice.STORED_FILE_NAME}">
										&nbsp;
									</c:if>
								</td>
								<td class="tc">
									<a href="#!">${notice.INS_DT}</a>
								</td>
								<td class="tc td_${notice.SEQ}">
									<a href="#!">${notice.CLICK_CNT}</a>
								</td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${empty hfa01}">
						<tr><td colspan="6">데이터가 없습니다.</td></tr>
					</c:if>						
				</tbody>
			</table>
			<!-- 테이블02(E) -->	
			</form:form>
				
			<!-- 페이지버튼(S) -->
			<div class="paging_box">
				<c:if test="${not empty paginationInfo}">
					<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_searchPage"/>
				</c:if>
				<input type="hidden" id="currentPageNo" name="currentPageNo"/>
			</div>
			<!-- 페이지버튼(E) -->				
				
		</div>
		<!--콘텐츠_메인(E)-->
	
		<jsp:include page="../inc/2020/IncFooter.jsp"/>	
	
	
		<!-- 팝업(S) -->
		<form name="send-form" id="send-form" enctype="multipart/form-data">
		<c:set var="name" value="${gubn}" />
		<input type="hidden" id="contentHidden" name="contentHidden" value=""/>
		
		<div class="dim-layer" id="utda_input">
			<div class="dimBg"></div>
			<div class="pop-layer popbox">
				<div class="pop-container">
					<div class="pop-conts_00">
						<!-- 팝업타이틀(S) -->
						<div class="pop_title_box">
							<h2 class="pop_title">공지사항</h2>
							<a href="#!" class="btn-layerClose close_B">Ⅹ</a>
						</div>
						<!-- 팝업타이틀(E) -->
	
						<!-- 팝업 콘텐츠(S) -->
						<div class="pop_conts">
							<!-- 테이블02(S) -->
								<table class="table_type_02 pop">
									<caption>noticePopTable</caption>
									<colgroup>
										<col style="width:20%">
										<col style="width:30%">
										<col style="width:20%">
										<col style="width:30%">
									</colgroup>
									
									<tbody>
										<tbody>
											<tr>
												<th>번호</th>
												<td><p id="rNum"></p></td>
												<th>작성자</th>
												<td><p id="insId"></p></td>
											</tr>
											<tr>
												<th>제목</th>
												<td colspan="3"><p id="title"></p></td>
											</tr>
											<tr>
												<th>내용</th>
												<td colspan="3"><p id="contentView"></p></td>
											</tr>
											<tr>
												<th>파일다운로드</th>
												<td colspan="3">
													<div class="file_box" id="fileName">
														<a href="/hfa01/hfa01FileDown.json?seq=${notice.ENCRPT_SEQ}" class="file_down" download></a>
														<span class="file_name"></span>
													</div>
												</td>
											</tr>											
										</tbody>
									</tbody>
								</table>
								<!-- 테이블02(E) -->				
						</div>
						<!-- 팝업 콘텐츠(E) -->
					</div>
				</div>
			</div>
		</div>
		
		</form>
		<form id="commonForm" name="commonForm"></form>
		<!-- 팝업(E) -->	
	
	</div>		
	<!--WRAP(E)-->		

</body>
</html>