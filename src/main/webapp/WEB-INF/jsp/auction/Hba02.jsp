<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

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
	<meta name="description" content="월간거래동향보고서">
	<meta name="content" content="화훼유통정보시스템 입니다.">
	<meta name="keywords" content="화훼경매시세, 화훼경매가격, Korea aT flower market auction price, 화훼공판장, 화훼거래정보, 꽃시장, 꽃값">
	<meta name="Author" content="화훼유통정보시스템 & www.woorim.co.kr : Kim Juyeon">
	<title>월간거래동향보고서</title>
	<%@include file="../common/commonJs.jsp" %>
	<%@include file="../common/commonCss.jsp" %>
	
	<script type="text/javascript">

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
	    },
	    
	    modalOpen: function (seq,title,insId,insDt,gubn,orFileNm,seqNum) {
	    	
	    	var all = [];
	    	all = "&seq="+seq+"&title="+title+"&insId="+insId+"&insDt="+insDt+"&gubn="+'update'+"&orFileNm="+orFileNm+"&seqNum="+seqNum;
	        myModal.open({
	            url: "/hba02/hba02_Popup.do",            
	            pars: all.queryToObject(),
	            top: 167,
	            closeByEscKey: true
	        });
	        
	    },
	    regOpen: function (seq,title,insId,insDt,gubn,orFileNm) {
	    	
	    	var all = [];
	    	all = "&seq="+seq+"&title="+title+"&insId="+insId+"&insDt="+insDt+"&gubn="+'reg'+"&orFileNm="+orFileNm;
	        myModal.open({
	            url: "/hba02/hba02_Popup.do",            
	            pars: all.queryToObject(),
	            top: 167,
	            closeByEscKey: true
	        });
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
    comSubmit.setUrl("<c:url value='/hba02/hba02.do'/>");
    comSubmit.addParam("currentPageNo", pageNo);
    comSubmit.addParam("searchValue",$("#searchForm").val());
    comSubmit.addParam("searchType",$("#searchType").val());
    comSubmit.submit();
};

function fn_search(pageNo) { 

	$("#pageIndex").val(pageNo);
	$("#searchForm").attr("action","<c:url value='/hba02/hba02.do'/>").submit();
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
		
    	var storedFileName = $("input[name='STORED_FILE_NAME']").eq(i).val();
		
    	param = param + "&seq_no="+seq_no+"&storedFileName="+storedFileName;

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
					월간거래동향보고서
				</li>
			</ul><!-- hd_gnb end -->
			<h3 class="sub_tit04">월간거래동향보고서</h3><!-- sub_tit end -->
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
								<c:set var="hba02" value="${selecthba02}"/>
								<c:if test="${!empty hba02 }">
								<c:forEach var="shba02" items="${selecthba02}"  varStatus="status">
									<tr>
										<td>${shba02.ANUM}</td>
										<td>
											<%-- <a href="javascript:;" onclick="fnObj.modalOpen('${shba02.ANUM}','${shba02.TITLE}','${shba02.WRITE_NAME}','${shba02.INS_DT}','update','${shba02.ORIGINAL_FILE_NAME}',${shba02.SEQ_NO});" style="cursor:pointer"  >${shba02.TITLE}</a> --%>
											${shba02.TITLE}
										</td>
										<td><%-- ${shba02.WRITE_NAME} --%>관리자</td>
										<td class="fileDown">
										<c:if test="${not empty shba02.STORED_FILE_NAME}">
											<a href="/hba02/hba02FileDown.json?seq=${shba02.SEQ_NO}" download><img src="<c:url value='/images/filedownload.gif'/>" alt="파일다운로드" >FileDownLoad</a>
										</c:if>
										<c:if test="${empty shba02.STORED_FILE_NAME}">
											&nbsp;
										</c:if>
										</td>
										<td>${shba02.INS_DT}</td>
									</tr>
								</c:forEach>
								</c:if>
								<c:if test="${empty hba02 }">
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
				</section><!-- section content01 end -->
				<ul class="ct_txt mt16">
					<li class="tit">◎ 이용안내</li>
					<li>월별거래동향보고서를 다운로드 할 수 있는 화면</li>
					<li>자료출처 : aT화훼공판장(양재동) 거래동향보고서</li>
				</ul><!-- ct_txt end -->
			</div><!-- sub_content end -->
		</div><!-- contentWrap end -->
	</article>
	<jsp:include page="../inc/IncFooter.jsp"/>
</div>
<form id="commonForm" name="commonForm"></form>		

</body>
</html>