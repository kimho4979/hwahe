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
	<title>모니터요원 입력시스템-정산마감관리</title>
	
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/hw/ma.css' />" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/hw/common.css' />" />
  
	<script type="text/javascript" src="<c:url value='/axisj/jquery/jquery.min.js' />"></script>
	<script type="text/javascript" src="<c:url value='/axisj/dist/AXJ.min.js' />"></script>
	<script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/ax5-polyfill.js' />"></script>
	<script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/axjApp.js' />"></script>
	
	
	
	<script type="text/javascript" src="<c:url value='/js/validation.js' />"></script>
	
	
<script type="text/javascript">
 function save(){
	 var deadlineDate = $("#deadlineDate").prop("value");
	 var deadlineGubn = $("#deadlineGubn").prop("value");
	 
 	$.ajax({
		type : "post",
		url : "/mdc01/updateDeadLineDate.json",
		data : {
			deadlineDate : deadlineDate,
			deadlineGubn : deadlineGubn
		},
		dataType : '',
		success : function(res){
			if(res.result>0){
				alert("저장되었습니다.");	
			}else{
				alert("실패하였습니다.");
			}
			
		}
	});
 }
	
</script>
</head>
<body>

<%@ include file="/WEB-INF/inc/IncHeader.jsp" %>

<article>
	<div class="wrap">
		<%@ include file="/WEB-INF/jsp/inc/IncMenu.jsp" %>
	
	
		<div class="hw_content"><!--컨텐츠 내용들어가는곳 시작-->
			<h3 class="hw_h3_ma"><!-- <div class="half1_white"></div> --><span class="half_title">정산마감관리</span></h3>
			<div class="hw_clear"></div>
		
			<div class="hw_infouse_01">
				<p><span class="purple"> ◎ 정산정보 관리 :</span> 정산정보에 대한 지표 별 관리</p>
			</div>

			<div id="manageDiv" style="width:100%; margin: 10px 0px;">
				<div class="selectWrap mt10">
						<div style="margin-bottom: 10px;">
							<ul class="titList3">
								<li class="th">마감일자 : </li>
								<li class="td">
									<label class="blind" for="deadlineGubn">마감일자</label>
									<select id="deadlineGubn" name="deadlineGubn" class="titSelect">
										<option value="this" <c:if test="${result.deadlineGubn=='this'}">selected="selected"</c:if>>당월</option>
										<option value="next" <c:if test="${result.deadlineGubn=='next'}">selected="selected"</c:if>>익월</option>
									</select>
									<label class="blind" for="deadlineDate">마감일자</label>
									<select id="deadlineDate" name="deadlineDate" class="titSelect">
										<c:forEach begin="1" end="31" varStatus="num">
											<option value="${num.index }" <c:if test="${result.deadlineDate eq num.index }">selected="selected"</c:if>>${num.index }</option>
										</c:forEach>
									</select>
								</li>
							</ul><!--   -->
							<div class="btnWrap"><button id="btnType" class="ma_add_2" onclick="save();">저장하기</button></div>
						</div>
				</div>
			</div>
			<div class="hw_clear"></div>
			
			
		</div>
		<!--// hw_content -->
	</div>
	<!--// wrap-->
</article>

	<div class="hw_clear"></div>
	<footer>
		<%@ include file="/WEB-INF/inc/IncFooter.jsp" %>
	</footer>
</body>
</html>

