<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, user-scalable=no">
	<meta name="apple-mobile-web-app-title" content="화훼유통정보시스템">
	<meta name="robots" content="no-index,follow">
	<meta name="og:title" content="화훼유통정보시스템">
	<meta name="og:description" content="화훼유통정보시스템">
	<meta name="description" content="재배동향">
	<meta name="content" content="화훼유통정보시스템 입니다.">
	<meta name="keywords" content="화훼경매시세, 화훼경매가격, Korea aT flower market auction price, 화훼공판장, 화훼거래정보, 꽃시장, 꽃값">
	<meta name="Author" content="화훼유통정보시스템 & www.woorim.co.kr">
	<title>재배동향</title>
	
	<%@include file="../common/2020/commonJs.jsp" %>
	<%@include file="../common/2020/commonCss.jsp" %>
	
	<script type="text/javascript">
		var myGrid = new AXGrid();
		var itemSum = 0;
		
		var san_id_list = new Array();
		 <c:forEach items="${san_id_list}" var="item1">
			san_id_list.push("${item1}");
		</c:forEach>
		var subCnt=0;
		var comSubmit = new ComSubmit();
 
		var fnObj = {
		        pageStart: function(){
		        	$("#excelBtn1").empty();
		        	$("#excelBtn1").append('<a href="javascript:void(0);" id="exportBtn1" name="exportTable1" onclick="excelExport();"><img src="../images/2020/exel.png" alt="엑셀이미지">엑셀저장</a>');
		        	
		        	$("#allSelect").change(function(){
		        		$("input[name='subSelect']").prop("checked",$(this).prop("checked"));
		        		if($(this).prop("checked")==true){
		        			$("input[name='subSelect']").parent().addClass("checked");
		        		}else{
		        			$("input[name='subSelect']").parent().removeClass("checked");
		        			comSubmit.delParam("san_list");
		    		    	comSubmit.delParam("san_id_list");
		        		}
		        	});
		        	
		        	$("input[name='subSelect']").change(function(){
		        		if($("input[name='subSelect']:checked").length < $("input[name='subSelect']").length){
		        			$("#allSelect").prop("checked", false);
		        			$("#allSelect").parent().removeClass("checked");
		        		}else{
		        			$("#allSelect").prop("checked", true);
		        			$("#allSelect").parent().addClass("checked");
		        		}
		        	});
		        	
					var subCnt = 0;	// 전체 체크 확인
		        	
		        	for (var i = 0; i < san_id_list.length; i++) {
		        		if(san_id_list[i].lastIndexOf('check') != -1){
		        			subCnt++;	
		        		}
		        	}	
		        	
		        	if(subCnt >= 9){
		        		 $("#allSelect").prop("checked", true);
			        	 $("#allSelect").parent().addClass("checked");
			        	 $("#allSelect").change();	
			        	 $("input[name='subSelect']").change();	
		        	}else{
		        		for (var i = 0; i < san_id_list.length; i++) {
			        		 $("#"+san_id_list[i]).prop("checked", true);
				        	 $("#"+san_id_list[i]).parent().addClass("checked");
				        	 $("#subSelect").change();	
			        	}
	        			 $("#allSelect").prop("checked", false);
			        	 $("#allSelect").parent().removeClass("checked");
		        	}
		        	
		        	if('${initFlag}'=='T'){
		        		$("#allSelect").prop("checked", true);
			        	$("#allSelect").parent().addClass("checked");
			        	$("#allSelect").change();	
			        	$("input[name='subSelect']").change();
		        	}
		        	
		        	/* 체크박스  */
		        	$(".checkWrap .check").click(function(){
		        		if( $(this).prop("checked") == true ){
		        			$(this).prop("checked", true);
		        			$(this).parent().addClass("checked");		        			
		        		}else{
		        			$(this).prop("checked", false);
		        			$(this).parent().removeClass("checked");
		        		}
		        		//$("#allSelect").change();
		        		
		        		//fn_search(1);
		        	});
		        	
		        	
		        	$("#allSelect").click(function(){
		        		$("input[name='subSelect']").prop("checked",$(this).prop("checked"));
		        		if($(this).prop("checked")==true){
		        			$("input[name='subSelect']").parent().addClass("checked");
		        		}else{
		        			$("input[name='subSelect']").parent().removeClass("checked");
		        			/* comSubmit.delParam("san_list");
		    		    	comSubmit.delParam("san_id_list"); */
		        		}
		        		fn_search(1);
		        	});
		        	
		        	$("input[name='subSelect']").click(function(){		        		
		        		if($("input[name='subSelect']:checked").length < $("input[name='subSelect']").length){
		        			$("#allSelect").prop("checked", false);
		        			$("#allSelect").parent().removeClass("checked");
		        		}else{
		        			$("#allSelect").prop("checked", true);
		        			$("#allSelect").parent().addClass("checked");
		        		}
		        		fn_search(1);
		        	});
		        	
		        }
		    };
		
		// 엑셀 다운로드
		function excelExport(){
			var excelNm = "재배동향";
			var allSelect = $("#allSelect").val();
			var checkArr = [];
			$("input[name='subSelect']:checked").each(function(i){
				checkArr.push($(this).val());
			});
			var param = "?excelNm="+excelNm+"&san_list="+checkArr;
			location.href = "/excel/excelDownLoad.do"+param;
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
				$("#commonForm").empty();
			}
			
			this.setUrl = function setUrl(url){
				this.url = url;
			};
			
			this.addParam = function addParam(key, value){
				$("#"+this.formId).append($("<input type='hidden' name='"+key+"' id='"+key+"' value='"+value+"' >"));
			};
			
			this.delParam = function delParam(key){
				$("#"+this.formId).empty();				
			};
			 			
			 this.submit = function submit(){
				var frm = $("#"+this.formId)[0];
				frm.action = this.url;
				frm.method = "post";
				frm.submit();	
			};
		
		}
		
		function fn_search(pageNo){
			comSubmit.setUrl("<c:url value='/hca02/hca02Select.do'/>");
			
			$("#commonForm")[0].reset();
			
			var initVar = false;
		    $(".checkWrap .check").each(function(i) {
		    	if( $(this).prop('checked') == true ){
		    		var param = $(this).val();
					var paramId = $(this).attr('id');
					
			    	comSubmit.addParam("san_list", param);
			    	comSubmit.addParam("san_id_list", paramId);     
			    	initVar = true;
        		}
		    });
		    
		    if(initVar==false){
		    	comSubmit.delParam("san_list");
		    	comSubmit.delParam("san_id_list");
		    }
		           
		   comSubmit.addParam("currentPageNo", pageNo);
		    
		   comSubmit.submit();
		};
		
		$(document).ready(fnObj.pageStart);
		
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
				<li>생산/소비정보</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li>출하 및 작황정보(장미)</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li class="m_right">재배동향</li>
			</ul>
		</div>
		<!--공통 HEADER(E)-->
		
		<!--서브 타이틀(S)-->
		<jsp:include page="../inc/2020/IncShare.jsp"/>
		
		<div class="sub_title">
			<div class="title_box">
				<h2>재배동향</h2>
				<img src="../images/2020/sub/t_line.png" alt="방울점선">
			</div>
		</div>
		<!--서브 타이틀(E)-->
		<!--서브공통 (S)-->
		<div class="sub_contents">
			<!--서브 리스트 (S)-->
			
			<!--서브 리스트 (E)-->
			<!--서브 TAB공통 (S)-->
			
			<!--서브 TAB공통 (E)-->
		</div>
		<!--컨텐츠 내용(S)-->
		<div class="sub_guide">			
			<ul class="grow_check_box checkWrap">
				<li>
					<input type="checkbox" class="check" id="allSelect" name="allSelect" value="전체">
					<label for="allSelect" class="title_box_chk"><em class="txt">전체</em><span></span></label>
				</li>
				<li>
					<input type="checkbox" class="check" id="check02" name="subSelect" value="서울">
					<label for="check02" class="title_box_chk"><em class="txt">서울</em><span></span></label>
				</li>
				<li>
					<input type="checkbox" class="check" id="check03" name="subSelect" value="경기">
					<label for="check03" class="title_box_chk"><em class="txt">경기도</em><span></span></label>
				</li>
				<li>
					<input type="checkbox" class="check" id="check04" name="subSelect" value="강원">
					<label for="check04" class="title_box_chk"><em class="txt">강원도</em><span></span></label>
				</li>
				<li>
					<input type="checkbox" class="check" id="check05" name="subSelect" value="충북">
					<label for="check05" class="title_box_chk"><em class="txt">충청북도</em><span></span></label>
				</li>
				<li>
					<input type="checkbox" class="check" id="check06" name="subSelect" value="충남">
					<label for="check06" class="title_box_chk"><em class="txt">충청남도</em><span></span></label>
				</li>
				<li>
					<input type="checkbox" class="check" id="check07" name="subSelect" value="전북">
					<label for="check07" class="title_box_chk"><em class="txt">전라북도</em><span></span></label>
				</li>
				<li>
					<input type="checkbox" class="check" id="check08" name="subSelect" value="전남">
					<label for="check08" class="title_box_chk"><em class="txt">전라남도</em><span></span></label>
				</li>
				<li>
					<input type="checkbox" class="check" id="check09" name="subSelect" value="경북">
					<label for="check09" class="title_box_chk"><em class="txt">경상북도</em><span></span></label>
				</li>
				<li>
					<input type="checkbox" class="check" id="check10" name="subSelect" value="경남">
					<label for="check10" class="title_box_chk"><em class="txt">경상남도</em><span></span></label>
				</li>			
			</ul>
			<div class="grow_list_b">
				<table>
					<caption>재배동향</caption>
					<colgroup>
						<col style="width:15%">
						<col style="width:10%">
						<col style="width:10%">
						<col style="width:10%">
						<col style="width:30%">
						<col style="width:15%">
						<col style="width:15%">
					</colgroup>
					<thead>
						<tr>
							<th>작성일자</th>
							<th>품목</th>
							<th>품종</th>
							<th>재배면적</th>
							<th>재배면적내용</th>
							<th>전년대비</th>
							<th>지역</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="hca02" items="${selectHca02}"  varStatus="status">
							<tr>
								<td>${hca02.REG_DATE}</td>						
								<td>${hca02.PUM_NAME}</td>
								<td>${hca02.GOOD_NAME}</td>
								<td><fmt:formatNumber value="${hca02.AREA}" type="number"/></td>						
								<td>${hca02.BIGO}</td>
								<td>${hca02.STATUS}</td>
								<td>${hca02.SIDO}</td>												
						  	</tr>				
						</c:forEach>
					</tbody>
				</table>
				<!-- 페이지버튼(S) -->
				<div class="paging_box">
					<c:if test="${not empty paginationInfo}">
					<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_search"/>
					</c:if>
					<input type="hidden" id="currentPageNo" name="currentPageNo"/>
				</div>
			<!-- 페이지버튼(E) -->
			</div>
			
			<!-- 버튼박스(S) -->
			<div class="dwn_bt_b" id="excelBtn1">
				<a href="#!">엑셀저장</a>
			</div>
			<!-- 버튼박스(E) -->
			
			<div class="guide">
				<h2 class="title_02">이용안내</h2>
				<ul class="guide_box">
					<li>· 선정 된 70개 농가의 재배동향 정보를 확인 할 수 있는 화면</li>
					<li>· 대상품목 : 장미</li>
					<li>· 단위 :재배면적(m2) / 자료출처 : 선정 된 70개 농가의 입력 자료</li>
				</ul>
			</div>
		</div>
		<!--컨텐츠 내용(E)-->
		<form id="commonForm" name="commonForm"></form>
		<jsp:include page="../inc/2020/IncFooter.jsp"/>
		
	</div>
	<!--WRAP(E)-->
</body>
</html>