<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%
	String seqNo = (String)request.getAttribute("mainSeq");
	String title = (String)request.getAttribute("mainTitle");
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
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, user-scalable=no">
	<meta name="apple-mobile-web-app-title" content="화훼유통정보시스템">
	<meta name="robots" content="no-index,follow">
	<meta name="og:title" content="화훼유통정보시스템">
	<meta property="og:type" content="website">
	<meta name="og:description" content="화훼유통정보시스템">
	<meta name="description" content="월간장미수급예측보고서">
	<meta name="content" content="화훼유통정보시스템 입니다.">
	<meta name="keywords" content="화훼경매시세, 화훼경매가격, Korea aT flower market auction price, 화훼공판장, 화훼거래정보, 꽃시장, 꽃값">
	<meta name="Author" content="화훼유통정보시스템 & www.woorim.co.kr : Kim Juyeon">
	<title>월간장미수급예측보고서</title>
	<%@include file="../common/commonJs.jsp" %>
	<%@include file="../common/commonCss.jsp" %>
	
	<script type="text/javascript">
	var seqNo = '<%=seqNo%>';
	var title = '<%=title%>';
	var insId = '<%=insId%>';
	var insDt = '<%=insDt%>';
	var gubn = '<%=gubn%>';
	var orFileNm = '<%=orFileNm%>';
	var seqNum = '<%=seqNum%>';
	
	var myProgress = new AXProgress();
	var myGrid1 = new AXGrid();
	var myGrid2 = new AXGrid();
	var myModal = new AXModal();
	var fnObj = {
	    pageStart: function () {
	        myModal.setConfig({
	            windowID: "myModalCT", width: 740,
	            mediaQuery: {
	                mx: {min: 0, max: 767}, dx: {min: 767}
	            },
	            displayLoading: true,
	            scrollLock: true,
	            onclose: function () {
	              //  toast.push("모달 close");
	            }
	        });
	        
	        if(seqNo != 'null'){
	        	fnObj.modalOpenNew(seqNo,title,insId,insDt,gubn,orFileNm,seqNum);
	        }
	    },
	    
	    modalOpen: function (seq,title,insId,insDt,gubn,orFileNm,seqNum) {
	    	
	    	var all = [];
	    	all = "&seq="+seq+"&title="+title+"&insId="+insId+"&insDt="+insDt+"&gubn="+'update'+"&orFileNm="+orFileNm+"&seqNum="+seqNum;
	        myModal.open({
	            url:"/hba01/hba01_Popup.do",   
	            pars: all.queryToObject(),
	            top: 167,
	            closeByEscKey: true
	        });
	    },
	    
		modalOpenNew: function (seqNo,title,insId,insDt,gubn,orFileNm,seqNum) {
	    	
	    	var all = [];
	    	all = "&seq="+seqNo+"&title="+title+"&insId="+insId+"&insDt="+insDt+"&gubn="+'update'+"&orFileNm="+orFileNm+"&seqNum="+seqNum;
	        myModal.open({
	            url:"/hba01/hba01_Popup.do",   
	            pars: all.queryToObject(),
	            top: 167,
	            closeByEscKey: true
	        });
	    },
	    
	    regOpen: function (seq,title,insId,insDt,gubn,orFileNm) {
	    	
	    	var all = [];
	    	all = "&seq="+seq+"&title="+title+"&insId="+insId+"&insDt="+insDt+"&gubn="+'reg'+"&orFileNm="+orFileNm;
	        myModal.open({
	            url: "/hba01/hba01_Popup.do",            
	            pars: all.queryToObject(),
	            top: 167,
	            closeByEscKey: true
	        });
	    }
};

$(document.body).ready(function () {fnObj.pageStart()});

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
    comSubmit.setUrl("<c:url value='/hba01/hba01.do'/>");
    comSubmit.addParam("currentPageNo", pageNo);
    comSubmit.addParam("searchValue",$("#searchForm").val());
    comSubmit.addParam("searchType",$("#searchType").val());
    comSubmit.submit();
};

function fn_search(pageNo) {
	$("#pageIndex").val(pageNo);
	$("#searchForm").attr("action","<c:url value='/hba01/hba01.do'/>").submit();
};

$(document).ready(function(){
	 $("#chkall").click(function(){
	        if($("#chkall").prop("checked")){
	            //input태그의 name이 chk인 태그들을 찾아서 checked옵션을 true로 정의
	            $("input[name=clochk]").prop("checked",true);
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
    	var storedFileName = $("input[name='STORED_FILE_NAME']").eq(i).val();
    	param = param + "&seq_no="+seq_no+"&storedFileName="+storedFileName;
    });
    
    $.ajax({
        url : '/hba01/deleteSugeup.json',
        type : 'post',
        data : param,
        dataType : "json",
        success : function(data) {
          $("#dialog-message").html("<p> 삭제가 완료되었습니다. 페이지 로딩 중입니다. </p> <br> <p> 잠시만기다려 주세요. </p>");
          $("#listForm").attr("action", "<c:url value='/hba01/hba01.do'/>").submit(); 
        },
    	error : function( error ) {
    	  alert('오류가 발생하였습니다.');
    	  $("#dialog-message").dialog("close");
    	}
      });
}	
</script>
</head>


<body>
	<ul class="skip_nav">
		<li><a href="#header">상단바로가기</a></li>
		<li><a href="#content">본문바로가기</a></li>
	</ul><!-- skip end -->
	<div id="wrap">
	<form  id="myForm" name="myForm" method="post">
    	<input type="hidden" id="searchProductGubun" name="searchProductGubun" value="${searchProductGubun}"/>    	
	</form>
	<jsp:include page="../inc/IncHeader.jsp"/>
		
	<article>
	<h2 class="blind">화훼유통정보시스템 본문</h2>
		<div class="sub_header">
			<ul class="hd_gnb">
				<li><img src="/images/btn/sub_homeBtn.png" alt="홈"/></li>
				<li class="txt">
					보고서
				</li>
				<li class="txt">
					거래동향보고서
				</li>
				<li class="txt">
					월간장미수급예측보고서
				</li>
			</ul><!-- hd_gnb end -->
			<h3 class="sub_tit04 mb70">월간장미수급예측보고서</h3><!-- sub_tit end -->
		</div><!-- sub_header end -->
		<div class="contentWrap" id="content">
			<div class="sub_content">
				<section class="section content01">
					<div class="gridWrap width100p">
					<form:form commandName="calculateVo" name="listForm" id="listForm" method="post">
						<table class="boxList">
								<caption>월간장미수급예측보고서</caption>
								<colgroup>
									<col style="width:15%;">
									<col style="width:*;">
									<col style="width:15%;">
									<col style="width:15%;">
									<col style="width:18%;">
								</colgroup>
								<thead>
									<tr>
										<th>번호</th>
										<th>제목</th>
										<th>작성자</th>
										<th>파일</th>
										<th>작성일</th>
									</tr>
								</thead>
								<tbody>
								<c:set var="hba01" value="${selectHba01}"/>
								<c:if test="${!empty hba01}">
								<c:forEach var="shba01" items="${selectHba01}"  varStatus="status">
									<tr>
										<td>${shba01.ANUM}</td>
										<td>
											<%-- <a href="javascript:;" onclick="fnObj.modalOpen('${shba01.ANUM}','${shba01.TITLE}','${shba01.WRITE_NAME}','${shba01.INS_DT}','update','${shba01.ORIGINAL_FILE_NAME}',${shba01.SEQ_NO});" style="cursor:pointer"  >${shba01.TITLE}</a> --%>
											${shba01.TITLE}
										</td>
										<td>관리자</td>
										<td class="fileDown">
										<c:if test="${not empty shba01.STORED_FILE_NAME}">
											<a href="/hba01/hba01FileDown.json?seq=${shba01.SEQ_NO}" download><img src="<c:url value='/images/filedownload.gif'/>" alt="파일다운로드" >FileDownLoad</a>
										</c:if>
										<c:if test="${empty shba01.STORED_FILE_NAME}">
											&nbsp;
										</c:if>
										</td>
										<td>${shba01.INS_DT}</td>
									</tr>
								</c:forEach>
								</c:if>
								<c:if test="${empty hba01}">
									<tr><td colspan="6">데이터가 없습니다.</td></tr>
								</c:if>
								</tbody>
							</table><!-- boxList end -->
						</form:form>
						</div><!-- grisWrap end -->
						<div class="pagingArea">
							<div class="paging">
								<c:if test="${not empty paginationInfo}">
									<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_searchPage"/>
								</c:if>
								<input type="hidden" id="currentPageNo" name="currentPageNo"/>
							</div><!-- paging end -->
						</div>
						<!-- <div class="subBtn01area">
							<button type="button" class="subBtn01" onClick="fnObj.regOpen();" style="cursor:pointer">등록</button>
							<button type="button" class="subBtn02" onClick="javascript:fn_delete()" style="cursor:pointer">삭제</button>
						</div> -->
						<!-- pagingWrap end  -->
				</section><!-- section content01 end -->
				<ul class="ct_txt mt16">
					<li class="tit">◎ 이용안내</li>
					<li>월별 수급예측 보고서를 다운로드 할 수 있는 화면</li>
					<li>자료출처 : aT화훼공판장(양재동) 수급예측보고서</li>
				</ul><!-- ct_txt end -->
			</div><!-- sub_content end -->
		</div><!-- contentWrap end -->
	</article>
	<jsp:include page="../inc/IncFooter.jsp"/>
</div>
<form id="commonForm" name="commonForm"></form>
</body>
</html>