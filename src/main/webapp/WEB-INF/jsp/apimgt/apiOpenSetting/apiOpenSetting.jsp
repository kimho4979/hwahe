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
<title>모니터요원 입력시스템-공공데이터 개방설정 관리</title>
<!-- @@@@@@@@@@@@@@@@@@@@@@ css begin @@@@@@@@@@@@@@@@@@@@@@ -->
<link rel="stylesheet" type="text/css" href="<c:url value='/rMateChart/rMateChartH5/Assets/Css/rMateChartH5.css' />"/>   
<link rel="stylesheet" type="text/css" href="<c:url value='/axisj/axicon/axicon.min.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/arongi/AXJ.min.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/hw/ma.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/hw/common.css' />" />
<!-- @@@@@@@@@@@@@@@@@@@@@@ css end   @@@@@@@@@@@@@@@@@@@@@@ -->

<script type="text/javascript" src="<c:url value='/axisj/jquery/jquery.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/axisj/dist/AXJ.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/ax5-polyfill.js' />"></script>
<script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/axjApp.js' />"></script>

<!-- jsTree Start -->
<link rel="stylesheet" href="/css/jstree/default/style.min.css" />
<script type="text/javascript"  src="/dist/jquery-1.12.1.min.js"></script>
<script type="text/javascript"  src="/dist/jstree.min.js"></script>
<!-- jsTree End -->
  
<script type="text/javascript">
var openGubn = null;
var maxCallCnt = null;
var openTerm = null;
var regDt = null;
var uptDt = null;

// 공공데이터 개방설정 저장
function apiSave(){
	openGubn = $("#openGubn").val();
	maxCallCnt = $("#maxCallCnt").val();
	openTerm = $("#openTerm").val();
	
	$.ajax({
		type : 'post',
	    url : "/apiMgt/updateApiMgtList.json",
	    data : {
	    	openGubn : openGubn,
	    	maxCallCnt : maxCallCnt,
	    	openTerm : openTerm
	    },
	    dataType : '',   	           
	    success : function(res){
	    	alert("설정이 저장되었습니다.");
	    	apiList();
	    }
	});
}

function apiList(){
	$.ajax({
		type : 'post',
	    url : "/apiMgt/selectApiMgtList.json",
	    data : {},
	    dataType : '',   	           
	    success : function(res){
	    	var val = res.list;
	    	
	    	if(val[0].openGubn == 'Y'){
	    		$("#openGubn").val("Y");
	    	}else{
	    		$("#openGubn").val("N");
	    	}
	    	
	    	$("#maxCallCnt").val(val[0].maxCallCnt);
	    	$("#openTerm").val(val[0].openTerm);
	    	$("#uptDt").val(val[0].uptDt);
	    	$("#uptTime").val(val[0].uptTime);
	    }
	});
}

// 스크립트 로드
$(function(){
	apiList();
});
</script>
   
</head>
<body>
<%@ include file="/WEB-INF/inc/IncHeader.jsp" %>
<article>
<div class="wrap">
<%@ include file="/WEB-INF/jsp/inc/IncMenu.jsp" %>


<div class="hw_content"><!--컨텐츠 내용들어가는곳 시작-->
	
<h3 class="hw_h3_ma"><div class="half1_white"></div><span class="half_title">개방설정</span></h3>
<div class="hw_clear"></div>	
	
<div class="hw_infouse_01">  <p> <span class="purple"> ◎ 이용안내 :</span> API를 개방 설정 하는 페이지입니다.</p></div>
<div class="hw_clear"></div>	
<!-- <div class="ma_btn_allbox">
		<button class="ma_add" type="button" value="등록하기" onclick="fnObj.modalOpen();">등록하기</button>
		<button class="ma_del" type="button" value="삭제하기" onclick="fnObj.getCheckedList();">삭제하기</button>
		<button class="ma_re" type="button" value="새로고침" onclick="grid_ajax();">새로고침</button>
</div> -->
<div style="margin-top:20px;">
	<!-- <div class="treeBasic2">
		<div id="jstree_demo" class="demo"></div>
	</div> -->
	<div style="width:100%; margin-bottom:20px;float:left">
		<form name="send-form" onsubmit="return false;">
				<div class="hw_clear"></div>
				<input type=hidden id="id" name="id" value="${SESSION_USER_ID}"/>
				
				<div class="hw_clear"></div>
				<h4 class="ma_title">승인여부</h4> <p class="hw_red">승인여부를 선택하세요</p>
				<div class="hw_clear"></div>	
				<div class="hw_infouse_01">
					<label class="hw_item_search_title" for="useYn">승인여부</label>
					<select name="openGubn" id="openGubn" class="item_search_select">
						<option value="Y">자동승인</option>
						<option value="N">비승인</option>
					</select>
				</div>

				<div class="hw_clear"></div>
				<h4 class="ma_title">최대호출건수</h4> <!-- <p class="hw_red">현재 선택된 메뉴명 입니다.</p> -->
				<div class="hw_clear"></div>
				<div class="hw_infouse_01">
					<label for="hide">최대호출건수</label><input name="maxCallCnt" id="maxCallCnt" value="" class="AXInput"/>건
				</div>
				
				<div class="hw_clear"></div>
				<h4 class="ma_title">개방승인기간</h4> <!-- <p class="hw_red">현재 선택된 메뉴명 입니다.</p> -->
				<div class="hw_clear"></div>
				<div class="hw_infouse_01">
					<label for="hide">개방승인기간</label><input name="openTerm" id="openTerm" value="" class="AXInput"/>개월
				</div>
				
				<div class="hw_clear"></div>
				<h4 class="ma_title">최종수정일자</h4> <!-- <p class="hw_red">현재 선택된 메뉴명 입니다.</p> -->
				<div class="hw_clear"></div>
				<div class="hw_infouse_01">
					<label for="hide">최종수정일자</label><input name="uptDt" id="uptDt" value="" class="AXInput" readOnly/>
				</div>
				
				<div class="hw_clear"></div>
				<h4 class="ma_title">최종수정시간</h4> <!-- <p class="hw_red">현재 선택된 메뉴명 입니다.</p> -->
				<div class="hw_clear"></div>
				<div class="hw_infouse_01">
					<label for="hide">최종수정시간</label><input name="uptTime" id="uptTime" value="" class="AXInput" readOnly/>
				</div>
				
				<div class="hw_clear"></div>
				<div>
					<input id="update" name="update" class="ma_del"  type="button" value="저장하기" onclick="apiSave();" />
				</div>
				<!-- <button class="AXButton" type="button" onclick="fnObj.form.submit();">저장하기</button> -->
			</form>
	</div>
</div>

</article>

<div class="hw_clear"></div>
<footer>
<%@ include file="/WEB-INF/inc/IncFooter.jsp" %>
</footer>
</body>
</html>