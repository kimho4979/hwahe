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
	<meta name="description" content="화훼 유사시장보고서">
	<meta name="content" content="화훼유통정보시스템 입니다.">
	<meta name="keywords" content="화훼경매시세, 화훼경매가격, Korea aT flower market auction price, 화훼공판장, 화훼거래정보, 꽃시장, 꽃값">
	<meta name="Author" content="화훼유통정보시스템 & www.woorim.co.kr : Kim Juyeon">
	<title>화훼 유사시장보고서</title>
	<%@include file="../common/commonJs.jsp" %>
	<%@include file="../common/commonCss.jsp" %>
  
  <script type="text/javascript">

var fnObj = {
    pageStart: function () {
        
    },
    modalOpen: function (seq, title, insId, insDt, gubn, orFileNm, seqNum) {
    	addClickCnt(seqNum);
    	$("#rNum").text(seq);
    	//$("#insId").text(insId);
    	$("#insId").text('관리자');
    	$("#title").text(title);
    	var emp = $("#noticeContent"+seq).val().replace(/< BR >/gi, "<br />");

    	document.getElementById("contentView").innerHTML=emp;    	
    	
    	if(orFileNm!= ''){
    		var aString = "<a href='/hba03/hba03FileDown.json?seq="+seqNum+"' download><img src='/images/filedownload.gif' alt='파일다운로드' >"+orFileNm+"</a>";
        	$("#fileName").html(aString);
    	}else{
    		$("#fileName").html('');
    	}
    	fnShowLayer('#utda_input');
    },
    regOpen: function (seq,title,insId,insDt,gubn,orFileNm) {
    	
    	var all = [];
    	all = "&seq="+seq+"&title="+title+"&insId="+insId+"&insDt="+insDt+"&gubn="+'reg'+"&orFileNm="+orFileNm;
        myModal.open({
            url: "/hba01/hba03_Popup.do",            
            pars: all.queryToObject(),
            top: 167,
            closeByEscKey: true
        });
    }
    ,
	
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
   comSubmit.setUrl("<c:url value='/hba03/hba03.do'/>");
   comSubmit.addParam("currentPageNo", pageNo);
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
	$("#pageIndex").val(pageNo);
	$("#searchForm").attr("action","<c:url value='/hba03/hba03.do'/>").submit();
}

function addClickCnt(SEQ_NO){
	$.ajax({
		type : "post",
		url : "/hba01/updateForecastClickCnt.json",
		data : {
			SEQ_NO : SEQ_NO
		},
		dataType : '',
		success : function(res){
			var clickCnt = $(".td_"+SEQ_NO).html();
			$(".td_"+SEQ_NO).html((Number(clickCnt)+1));
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
					화훼 유사시장보고서
				</li>
			</ul><!-- hd_gnb end -->
			<h3 class="sub_tit05">화훼 유사시장보고서</h3><!-- sub_tit end -->
		</div><!-- sub_header end -->
		<div class="contentWrap" id="content">
			<div class="sub_content">
				<section class="section content01">
					<div class="gridWrap width100p">
					<form:form commandName="calculateVo" name="listForm" id="listForm" method="post">
						<table class="boxList">
								<caption>공지사항</caption>
								<colgroup>
									<col style="width:15%;">
									<col style="width:*;">
									<col style="width:15%;">
									<col style="width:15%;">
									<col style="width:18%;">
									<col style="width:10%;">
								</colgroup>
								<thead>
									<tr>
										<th>번호</th>
										<th>제목</th>
										<th>작성자</th>
										<th>파일</th>
										<th>작성일</th>
										<th>조회수</th>
									</tr>
								</thead>
								<tbody>
								<c:set var="hba03" value="${selecthba03}"/>
								<c:if test="${!empty hba03}">
								<c:forEach var="notice" items="${selecthba03}"  varStatus="status">
									<tr>
										<td>${notice.ANUM}</td>
										<td>
											<a href="#" onclick="fnObj.modalOpen('${notice.ANUM}','${notice.TITLE}','${notice.WRITE_NAME}','${notice.INS_DT}','update','${notice.ORIGINAL_FILE_NAME}','${notice.SEQ_NO}');" style="cursor:pointer">${notice.TITLE}</a>
											<input type="hidden" name="noticeContent${notice.ANUM}" id="noticeContent${notice.ANUM}" value="${notice.CONTENT}">
										</td>
										<td>관리자<%-- ${notice.WRITE_NAME} --%></td>
										<td class="fileDown">
										<c:if test="${not empty notice.STORED_FILE_NAME}">
											<a href="/hba03/hba03FileDown.json?seq=${notice.SEQ_NO}" download><img src="<c:url value='/images/filedownload.gif'/>" alt="파일다운로드" >FileDownLoad</a>
										</c:if>
										<c:if test="${empty notice.STORED_FILE_NAME}">
											&nbsp;
										</c:if>
										</td>
										<td>${notice.INS_DT}</td>
										<td class="td_${notice.SEQ_NO}">${notice.CLICK_CNT}</td>
									</tr>
								</c:forEach>
								</c:if>
								<c:if test="${empty hba03}">
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
				</section><!-- section content01 end -->
				<ul class="ct_txt mt16">
					<li class="tit">◎ 이용안내</li>
					<li>화훼 유사시장보고서를 조회 할 수 있는 화면</li>
				</ul><!-- ct_txt end -->
			</div><!-- sub_content end -->
		</div><!-- contentWrap end -->
	</article>
	<jsp:include page="../inc/IncFooter.jsp"/>
</div>	
<form name="send-form" id="send-form" enctype="multipart/form-data">
<c:set var="name" value="${gubn}" />
  <!-- layer popup wrap begin -->
	<div class="lp_wrap">
		<div class="lp_container" id="utda_input"><!-- D: ID 필수 -->
			<div class="lp_area">
				
				<div class="lp_content">
					<h2 class="lp_tit">화훼 유사시장보고서</h2><!-- lp_tit end -->
					<table class="boxList">
						<caption>화훼 유사시장보고서</caption>
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
								<td colspan="3" id="contentView"><!-- <textarea class="textarea01" id="CONTENT" name="CONTENT"></textarea> --></td>
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
	</form>
	<form id="commonForm" name="commonForm"></form>
</body>
</html>