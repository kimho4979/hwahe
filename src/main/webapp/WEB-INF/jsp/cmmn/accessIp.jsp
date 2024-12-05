<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
	String pageNo=request.getParameter("pageNo");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, user-scalable=no">
	<title>모니터요원 입력시스템-매뉴얼</title>
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



	<!-- rMateChartH5 라이센스 시작 -->
	<script type="text/javascript" src="<c:url value='/rMateChart/LicenseKey/rMateChartH5License.js' />"></script>
	<!-- rMateChartH5 라이센스 끝-->
	<!-- 실제적인 rMateChartH5 라이브러리 시작-->
	<script type="text/javascript" src="<c:url value='/rMateChart/rMateChartH5/JS/rMateChartH5.js' />"></script>
	<!-- 실제적인 rMateChartH5 라이브러리 끝-->
	<!-- rMateChartH5 테마 js -->
	<script type="text/javascript" src="<c:url value='/rMateChart/rMateChartH5/Assets/Theme/theme.js' />"></script>

	<script type="text/javascript">
		var myGrid = new AXGrid();
		let addList = [];
		$(document).ready(function() {
			setGrid();
		});
		function setGrid(){
			let list = ${userList};
			myGrid.setConfig({
				targetID : "AXGridTarget",
				theme : "AXGrid",
				fixedColSeq : '',
				fitToWidth:true,
				conHead:{
					rows: [{colSeq:0},{colSeq:1},{colSeq:2},{colSeq:3},{colSeq:4},{colSeq:5}]
				},
				colGroup : [
					{key:"userId", label:"유저ID", width:"50", align:"center", formatter:"text" },
					{key:"compCode", label:"CompCode", width:"50", align:"center", formatter:"text"},
					{key:"userType", label:"유저Type", width:"50", align:"center", formatter:"text"},
					{key:"userNm", label:"유저명", width:"50", align:"center", formatter:"text"},
					{key:"checkbox", label:"선택", width:"10", align:"center", formatter:"checkbox"},
				],
				colHeadAlign:"center",
				page:{
					paging:false
				}
			})
			myGrid.setList(list);
			console.log(myGrid.getList("selected"));
		}
		$(document).on('change', '#AXGridTarget_AX_tbody input[type="checkbox"]', function() {
			// 변경된 checkbox에 대한 작업 수행
			var trElement = $(this).closest('tr');
			var firstCellValue = trElement.find('td:first-child').text();
			if ($(this).is(':checked')) {
			       console.log(myGrid.getList("selected"));
			       addList.push(firstCellValue);
			        console.log('First cell value:', addList);
			} else {
				addList = addList.filter(element => element !== firstCellValue);
				console.log('remove after value: ', addList);
			}
		});
		function add(){
			$.ajax({
				type : "post",
				url : "/admin/data/addResearch.json",
				data :JSON.stringify(addList),
				contentType: "application/json",
		        dataType: 'json',
				async: false,
				success : function(res){
					alert("저장되었습니다");
					console.log(res);
				},
				error : function(e){
					alert("실패함");
				}
			});
			location.reload();
		}
		function remove(){
			$.ajax({
				type : "post",
				url : "/admin/data/removeResearch.json",
				data :JSON.stringify(addList),
				contentType: "application/json",
		        dataType: 'json',
				async: false,
				success : function(res){
					alert("저장되었습니다");
					console.log(res);
			
				},
				error : function(e){
					alert("실패함");
				}
			});
			location.reload();
		}
	</script>

</head>
<body>
<%@ include file="/WEB-INF/inc/IncHeader.jsp" %>

<article>
	<div class="wrap">

		<%@ include file="/WEB-INF/jsp/inc/IncMenu.jsp" %>

		<div class="hw_content"><!--컨텐츠 내용들어가는곳 시작-->
			<h3 class="hw_h3_ma">
				<div class="half1_white"></div>
				<span class="half_title">Research페이지 접근제한 설정</span>
			</h3>
			<div class="hw_clear"></div>
			<div style="border:1px solid #f3f3f3; font-size:12px; line-height:20px; text-align:left; margin-top:10px;color:#61616; background-color:#f3f3f3; ">
				<span class="purple"> ◎ Research페이지 접근권한 설정 </span><br/> 추가: 접근가능한 사용자를 추가합니다.<br/> 삭제: 접근가능한 사용자를 삭제합니다.<br/>
			</div>
			<form id="emailCreateFrm" name="emailCreateFrm" method="post" class="form-horizontal1111111" style="display:flex;width:auto;justify-content:center;margin-top:10px;margin-bottom:10px;">
				<input type="button" class="AXButton" id="search" name="search" value="삭제" onclick="remove();">
				<input type="button" class="AXButton" id="search" name="search" value="추가" onclick="add();">
			</form>
			<div class="hw_ma_grid">
				<div id="AXGridTarget" style="height:450px;"></div>
			</div>
		</div><!--wrap 끝-->
	</div>
</article>

<div class="hw_clear"></div>

<footer>
	<%@ include file="/WEB-INF/inc/IncFooter.jsp" %>
</footer>
</body>
</html>