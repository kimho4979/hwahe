<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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
	<meta name="description" content="고객상담실">
	<meta name="content" content="화훼유통정보시스템 입니다.">
	<meta name="keywords" content="화훼경매시세, 화훼경매가격, Korea aT flower market auction price, 화훼공판장, 화훼거래정보, 꽃시장, 꽃값">
	<meta name="Author" content="화훼유통정보시스템 & www.woorim.co.kr">
	<title>고객상담실</title>
	<%@include file="../common/2020/commonJs.jsp" %>
	<%@include file="../common/2020/commonCss.jsp" %>
  
	<script type="text/javascript">
	 
		function initReg(){
			$('#seq').val('');
			$('#parentSeq').val('0');
			$('#title').val('');
			$('#usrNm').val('');
			$('#usrPass').val('');
			$('#usrPass2').val('');
			$('#mobNum').val('');
			$('#cont').val('');
			$("#fileName").html("찾아보기<input type=\"file\" id=\"file\" name=\"file\" value=\"\" onchange=\"javascript:document.getElementById('file_route').value=this.value\">");
			$("#fileDown").html("");
			
			$('#titleTxt1').text('등록하기');
			$('#showConfrim').show();
			$('#showUpdate').hide();
		}
		  
		function openRegPop(){	  
			//fnShowLayer('#upload_popup');
			fnLayerPopup('#upload_popup');
		}
		  
		function closeRegPop(){
			//hideLayer('#upload_popup');
			fnHidePopup('#upload_popup');
		}
		  
		function initPass(){
			$('#passPass').val('');
		}
		  
		function openPassPop(){
			//fnShowLayer('#password_popup');
			fnLayerPopup('#password_popup');
		}
		  
		function closePassPop(){
			//hideLayer('#password_popup');
			fnHidePopup('#password_popup');
		}
		    
		/* 휴대폰번호 체크 */
		function chkMob(){
			var re = /^\d{3}\d{3,4}\d{4}$/;
			var phone = $("#mobNum").val();
			if (phone == '' || !re.test(phone)) {
				alert("올바른 휴대폰번호를 입력하세요");
				return false;
			}
			return true;
		} 
			
		function RegForm(){
			if($('#title').val()==''){
				alert('제목을 입력하세요');
				return false;
			}
			
			if($('#usrNm').val()==''){
				alert('성명을 입력하세요');
				return;
			}
			
			if($('#pass').val()==''){
				alert('비밀번호를 입력하세요');
				return;
			}
			
			if($('#usrPass').val()==''){
				alert('비밀번호를 입력하세요');
				return;
			}
			
			if($('#usrPass').val()!=$('#usrPass2').val()){
				alert('입력한 비밀번호와 비밀번호 확인 입력값이 다릅니다.');
				return;
			}
			if($('#cont').val()==''){
				alert('본문을 입력하세요');
				return;
			}
			if($("#mobNum").val()!=''){
				if(!chkMob()){
					return;
				}  
			}	  
			var frm = document["send-form"];
			if(confirm("등록하시겠습니까?")==true){
				var formData = new FormData(frm);
				$.ajax({
					type : "POST",
					url : "/bbs/insertCustomerBbs.json",
					data : formData, 
					contentType: false,
					processData: false,
					success : function(res){
						if(res.result!=null&&res.result=='0'){
							alert(res.resultMsg);
							location.href='/bbs/customerBbsList.do';
						}else{
							alert(res.resultMsg);
						}
					}
				}); 
			}else{
				return;
			}
		}
		  
		function delForm(){
			var frm = document["send-form"];
			if(confirm("삭제하시겠습니까?")==true){
			var formData = new FormData(frm);
				$.ajax({
					type : "POST",
					url : "/bbs/customerBbsDel.json",
					data : formData, 
					contentType: false,
					processData: false,
					success : function(res){
						if(res.result!=null&&res.result=='0'){
							alert('삭제되었습니다');
							location.href='/bbs/customerBbsList.do';
						}else{
							alert('삭제가 실패하였습니다. 관리자에게 문의해주세요');
						}
					}
				}); 
			}else{
				return;
			}
		}
		  
		function openPass(seq){
			$('#passSeq').val(seq);
			initPass();
			openPassPop();
		}
		  
		function addClickCnt(seq){
			$.ajax({
				type : "post",
				url : "/bbs/updateClickCnt.json",
				data : {
				seq : seq
				},
				dataType : 'json',
				success : function(res){
					var clickCnt = $(".td_"+seq).html();
					$(".td_"+seq).html((Number(clickCnt)+1));
				}
			});
		}
		  
		function viewForm(){
			var passSeq=$('#passSeq').val();
			var passPass=$('#passPass').val();
			
			$.ajax({
		  		type : "POST",
		  		url : "/bbs/selectCustomerBbsBySeq.json",
		  		data : {
		  			seq : passSeq,
		        	pass : passPass
		  		},
		  		dataType : '',
		  		success : function(res){    
		  			if(res.result=='0'){
		  				addClickCnt(res.list.seq);
		  				$("#seq").val(res.list.encryptSeq);
		             	$("#title").val(res.list.titleOri);
		             	$("#usrNm").val(res.list.usrNmOri);
		             	$("#usrPass").val(res.list.usrPass);
		             	$("#usrPass2").val(res.list.usrPass);
		             	$("#mobNum").val(res.list.mobNum);
		             	if(res.list.cont!=null){
		             		$("#cont").val(res.list.cont.replace(/< BR >/gi, ""));
		             	}else{
		             		$("#cont").val(res.list.cont);
		             	}
		             	
		             	if(res.list.originFileName!= null&&res.list.originFileName!= ''){
		             		var aString = "찾아보기<input type=\"file\" id=\"file\" name=\"file\" value=\"\" onchange=\"javascript:document.getElementById('file_route').value=this.value\">";
		                 	var bString = "<a href='/bbs/customerBbsFileDown.json?seq="+res.list.encryptSeq+"' class='btn_file_down' download>"+res.list.originFileName+"</a>";
		             		
		                 	$("#fileName").html(aString);
		             		$("#fileDown").html(bString);
		             	}else{
		             		$("#fileName").html("찾아보기<input type=\"file\" id=\"file\" name=\"file\" value=\"\" onchange=\"javascript:document.getElementById('file_route').value=this.value\">");
		             		$("#fileDown").html("");
		             	}
		             	
		             	
		             	if(res.list.levelSeq=='1'){
		             		$('#titleTxt1').text('수정하기');
		                 	$('#showUpdate').show();
		                 	$('#showConfrim').show();	
		                 	
		             	}else{
		             		if(res.list.originFileName!= null&&res.list.originFileName!= ''){
		                 		var aString = "찾아보기<input type=\"file\" id=\"file\" name=\"file\" value=\"\" onchange=\"javascript:document.getElementById('file_route').value=this.value\">";
		                 		var bString = "<a href='/bbs/customerBbsFileDown.json?seq="+res.list.encryptSeq+"' class='btn_file_down' download>"+res.list.originFileName+"</a>";
			             		
		                 		$("#fileName").html(aString);
		                 		$("#fileDown").html(bString);
		                 	}else{
		                 		$("#fileName").html("");
		                 		$("#fileDown").html("");
		                 	}
		             		
		             		$('#titleTxt1').text('답변보기');
		             		$('#showUpdate').hide();
		                 	$('#showConfrim').hide();	
		             	}
		             	
		             	closePassPop();
		             	openRegPop();
		  				
		  			}else{
		  				alert(res.result);
		  				return;
		  			}         	 
				}
			}); 
		}
		  
		function fn_searchPage(pageNo){
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/bbs/customerBbsList.do'/>");
			comSubmit.addParam("currentPageNo", pageNo);
			comSubmit.submit();
		}
		
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
			
		function chkPassword(password){
			var chkBoolean =true;
			var chkNumber = password.search(/[0-9]/g);
			var chkEnglish = password.search(/[a-z]/ig);
			
			if(password.length == 0){
				chkText = "비밀번호를 입력하세요.";
				chkBoolean= false;
			}else if(!/^(?=.*[a-zA-Z])((?=.*\d)|(?=.*\W)).{12,20}$/.test(password)){
				chkText = '숫자와 영문자, 특수문자 조합으로 12자리 이상을 사용해야 합니다.';
				chkBoolean= false;
			} else if(chkNumber <0 || chkEnglish <0){
				chkText ="숫자와 영문자를 혼용하여야 합니다."; 
				chkBoolean= false;
			} else if(/(\w)\1\1\1/.test(password)){
				chkText ="444같은 문자를 4번 이상 사용하실 수 없습니다."; 
				chkBoolean= false;
			} else  if(password.search($("userId").val()) > 0){
				chkText ="비밀번호에 아이디가 포함되었습니다."; 
				chkBoolean= false;
			}
			
			if(chkBoolean==true){
				chkText="사용가능한 패스워드입니다.";
			}
			
			$("#chkPass").text(chkText);
			return chkText
		}
		
		function chkSamePw(password){
			var chkText = "";
			var chkBoolean =true;
			var passwd = $("#usrPass").val();
			
			if(password.length==0){
				chkText = '';
			}else if(passwd == password){
				chkText = '비밀번호 일치';
			}else{
				chkText = '비밀번호 불일치';
			}
			
			$("#chkDup").text(chkText);
			return chkText;
		}

	</script>
</head>


<body>
	<!--WRAP(S)-->
	<div class="wrap">
		
		<jsp:include page="../inc/2020/IncHeader.jsp"/>
		
		<div class="lnb_box">
			<ul>
				<li><img src="../images/2020/m_lnb_img.png" alt="집"></li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li>열린광장</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li>알림마당</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li class="m_right">고객상담실</li>
			</ul>
		</div>
		<!--공통 HEADER(E)-->
		
		<!--서브 타이틀(S)-->
		<div class="sub_sns">
		</div>
		
		<div class="sub_title">
			
			<div class="title_box">
				<h2>고객상담실</h2>
				<img src="../images/2020/sub/t_line.png" alt="방울점선">
			</div>
		</div>
		<!--서브 타이틀(E)-->
		
		<!-- 서브공통(S) -->
		<!--컨텐츠 내용(S)-->
		<div class="sub_contents">
						
			<!-- 테이블02(S) -->
			<table class="table_type_02">
				<caption>noticeTable</caption>
				<colgroup>
					<col style="width:10%">
					<col style="width:50%">
					<col style="width:16%">
					<col style="width:12%">
					<col style="width:12%">
				</colgroup>
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>조회수</th>
					</tr>
				</thead>
				<tbody>
					<c:set var="list" value="${list}"></c:set>
					<c:if test="${!empty list }">
					<c:forEach var="data" items="${list}"  varStatus="status">
						<tr>
							<c:if test="${data.levelSeq eq '1' }">
								<td class="tc">${data.rankSeq}</td>
							</c:if>
							<c:if test="${data.levelSeq ne '1' }">
								<td class="tc">└</td>
							</c:if>
							
							<td class="tc">
								<a href="#" onclick="openPass('${data.seq}');">${data.title}</a>
							</td>
							<td class="tc">${data.usrNm}</td>
							
							<td class="tc">${data.insDt}</td>
							<td class="tc td_${data.seq}">${data.clickCnt}</td>
						</tr>
					</c:forEach>
					</c:if>
					<c:if test="${empty list}">
						<tr><td class="tc" colspan="5">데이터가 없습니다.</td></tr>
					</c:if>				
				</tbody>
			</table>
			<!-- 테이블02(E) -->	
			
			<!-- 페이지버튼(S) -->
			<div class="paging_box">
				<c:if test="${not empty paginationInfo}">
					<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_searchPage"/>
				</c:if>
				<input type="hidden" id="currentPageNo" name="currentPageNo"/>
			</div>
			<!-- 페이지버튼(E) -->
			<div class="info_btn">
				<button onclick="initReg();openRegPop();">등록</button>
			</div>
		</div>
		
		<jsp:include page="../inc/2020/IncFooter.jsp"/>
			
		
		<!-- 팝업(S) -->
		<form name="send-form2" id="send-form2" method="post" onSubmit="return false;">
		<input type="hidden" name="passSeq" id="passSeq" value="">
		<div class="dim-layer" id="password_popup">
			<div class="dimBg"></div>
			<div class="pop-layer popbox w_auto">
				<div class="pop-container">
					<div class="pop-conts_00">
						<!-- 팝업타이틀(S) -->
						<div class="pop_title_box">
							<h2 class="title_02">비밀번호</h2>
							<a href="#!" class="btn-layerClose close_B">Ⅹ</a>
						</div>
						<!-- 팝업타이틀(E) -->

						<!-- 팝업 콘텐츠(S) -->
						<div class="pop_conts01">
							<!-- 비밀번호(S) -->
								  <input type='password' id="passPass" name="passPass" autocomplete="off"  onkeypress='if(event.keyCode==13) {viewForm(); return false;}' />
							<!-- 비밀번호(E) -->		
							<div class="info_btn">
								<button onclick="viewForm()">확인</button>
								<button onclick="closePassPop()">취소</button>
							</div>
						</div>
						<!-- 팝업 콘텐츠(E) -->
					</div>
				</div>
			</div>
		</div>
		</form>
		<form id="commonForm" name="commonForm"></form>
		<!-- 팝업(E) -->		
		
		<!-- 등록 팝업(S) -->
		<form name="send-form" id="send-form" enctype="multipart/form-data" onSubmit="return false;">
		<input type="hidden" id="seq" name="seq">
		<input type="hidden" id="parentSeq" name="parentSeq" value="0">
		
		<div class="dim-layer" id="upload_popup">
			<div class="dimBg"></div>
			<div class="pop-layer popbox">
				<div class="pop-container">
					<div class="pop-conts_00">
						<!-- 팝업타이틀(S) -->
						<div class="pop_title_box">
							<h2 class="pop_title title_03" id="titleTxt1">등록하기</h2>
							<a href="#!" class="btn-layerClose close_B">Ⅹ</a>
						</div>
						<!-- 팝업타이틀(E) -->

						<!-- 팝업 콘텐츠(S) -->
						<div class="pop_conts01">
							<div class="info_pop">
								<span class="warn">※필수 입력항목입니다.</span>

								<span class="info_title">제목</span>
								<input type="text" name="title" id="title" />

								<span class="info_title">성명</span>
								<input type="text" name="usrNm" id="usrNm" />

								<span class="info_title">비밀번호</span>
								<input type="password" name="usrPass" id="usrPass" onkeyup="chkPassword(this.value)" autocomplete="off" />
								<p class="warn_02" id="chkPass"></p>
								<p class="warn_02">비밀번호는 12자 이상의 대소문자, 숫자를 조합하거나 특수문자를 포함하여 조합하셔야 합니다.</p>

								<span class="info_title">비밀번호 확인</span>
								<input type="password" name="usrPass2" id="usrPass2" onkeyup="chkSamePw(this.value)" autocomplete="off" />
								<p class="warn_02" id="chkDup"></p>

								<span class="info_title">연락처</span>
								<input type="text" name="mobNum" id="mobNum" />

								<span class="info_title">본문</span>
								<textarea id="cont" name="cont" class="txt_area"></textarea>

								<span class="info_title type_02">첨부파일</span>
								<div class="file_down_box" id="fileDown"></div>
								<div class="file_input">
									<label id="fileName">
										찾아보기
										<input type="file" id="file" name="file" value="" onchange="javascript:document.getElementById('file_route').value=this.value">
									</label>
									<input type="text" readonly="readonly" title="File Route" id="file_route">
								</div>
								
							</div>
						</div>							
						<div class="pop_conts02">
							<div class="info_btn">
								<button onclick="RegForm()" id="showConfrim">등록</button>
								<button onclick="delForm()" id="showUpdate">삭제</button>
								<button onclick="closeRegPop()">취소</button>
							</div>
						</div>
						<!-- 팝업 콘텐츠(E) -->
					</div>
				</div>
			</div>
		</div>
		</form>
		<!--등록 팝업(E) -->

	</div>
	<!--WRAP(E)-->
	
</body>
</html>