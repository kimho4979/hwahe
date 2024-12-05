<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j"%>
<%
	request.setAttribute("ITEM_CD", request.getParameter("ITEM_CD"));
	request.setAttribute("searchCmpCd", request.getParameter("searchCmpCd"));
	request.setAttribute("searchSaleDate", request.getParameter("searchSaleDate"));
%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<!-- META -->
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
	<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1, maximum-scale=1, minimum-scale=1" />
	<meta name="apple-mobile-web-app-capable" content="yes">
	
	<title>화훼유통정보시스템 :::</title>
	<!-- @@@@@@@@@@@@@@@@@@@@@@ css begin @@@@@@@@@@@@@@@@@@@@@@ -->
	<link rel="stylesheet" type="text/css" href="<c:url value='/rMateChart/rMateChartH5/Assets/Css/rMateChartH5.css' />" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/axisj/axicon/axicon.min.css' />" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/arongi/AXJ.min.css' />" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/common.css' />" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/main.css' />" />
	
	<!-- @@@@@@@@@@@@@@@@@@@@@@ css end @@@@@@@@@@@@@@@@@@@@@@ -->
	<script type="text/javascript" src="<c:url value='/axisj/jquery/jquery.min.js' />"></script>
	<script type="text/javascript" src="<c:url value='/axisj/dist/AXJ.min.js' />"></script>
	<script type="text/javascript" src="<c:url value='/js/main_nav.js' />"></script>
	<script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/ax5-polyfill.js' />"></script>
	<script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/axjApp.js' />"></script>
	
	<!-- @@@@@@@@@@@@@@@@@@@@@@ css end   @@@@@@@@@@@@@@@@@@@@@@ -->
	<!-- rMateChartH5 라이센스 시작 -->
	<script type="text/javascript" src="<c:url value='/rMateChart/LicenseKey/rMateChartH5License.js' />"></script>
	<!-- rMateChartH5 라이센스 끝-->
	<!-- 실제적인 rMateChartH5 라이브러리 시작-->
	<script type="text/javascript" src="<c:url value='/rMateChart/rMateChartH5/JS/rMateChartH5.js' />"></script>
	<!-- 실제적인 rMateChartH5 라이브러리 끝-->
	
	<!-- rMateChartH5 테마 js -->
	<script type="text/javascript" src="<c:url value='/rMateChart/rMateChartH5/Assets/Theme/theme.js'/>"></script>

</head>

<body>
	<div class="code_popup">
		<h2 class="blind">품목검색</h2>
		<article>
			<section>
				<div class="searhWrap" align="center">
					<lable class="tit" for="searchItemCd">품목검색</lable>
					<input name="searchItemCd" id="searchItemCd" onKeyDown="index_onKeyDown();" value='' class="searchCD" />
					<button class="btn05" onclick="grid_ajaxNew();" style="cursor: pointer">조회</button>
				</div>
				<span class="hw_popup_arrow"></span> 
				<span class="popup_arrow_text">품목을 리스트에서 선택해 주세요.</span> 
				<input type="hidden" name="searchProductGubun" id="searchProductGubun" value='${searchProductGubun }' /> 
				<input type="hidden" name='ITEM_CD' id="ITEM_CD" value='' /> 
				<input type="hidden" name=searchSaleDate id="searchSaleDate" value='${searchSaleDate }' />
				<div id="AXGridTarget" style="height: 420px;"></div>
			</section>
		</article>
	</div>
</body>


<script type="text/javascript">
	var myGrid = new AXGrid();
	var searchProductGubun = "";
	var searchSaleDate = "";
	var searchCmpCd = "";

	//$("#FLOWER_CD").unbindInput();

	function index_onKeyDown() {
		if (event.keyCode == 13) {
			grid_ajaxNew();
		}
	};

	// (구)검색
	function grid_ajax() {
		var searchItemCd = $("#searchItemCd").val();

		$.ajax({
			type : 'get',
			url : "/main/gridListMokSub.json",
			data : '&searchProductGubun='+searchProductGubun+'&searchSaleDate='+searchSaleDate+'&searchCmpCd='+searchCmpCd+'&searchItemCd='+searchItemCd,
			dataType : '',
			success : function(res) {
				console.log(res.list);
				myGrid.setList(res.list);
				// $('#ITEM_CD').attr("value","국화");
			},
		});
	};
	
	// (신)검색
	function grid_ajaxNew() {
		var searchItemCd = $("#searchItemCd").val();

		$.ajax({
			type : 'get',
			url : "/real/getPumNameDate.json",
			data : '&searchProductGubun='+searchProductGubun+'&searchSaleDate='+searchSaleDate+'&searchCmpCd='+searchCmpCd+'&searchItemCd='+searchItemCd,
			dataType : '',
			success : function(res) {
				console.log(res.list);
				myGrid.setList(res.list);
				// $('#ITEM_CD').attr("value","국화");
			},
		});
	};

	var fnObj = {
		pageStart : function() {
			$("#searchProductGubun").val('${searchProductGubun}');
			console.log($("#searchCmpCd", opener.document).val());
			console.log($("#itemCd", opener.document).val());
			console.log($("#searchProductGubun", opener.document).val());
			console.log($("#searchSaleDate", opener.document).val());

			searchProductGubun = $("#searchProductGubun", opener.document).val();
			searchSaleDate = $("#searchSaleDate", opener.document).val();
			searchCmpCd = $("#searchCmpCd", opener.document).val();
			grid_ajaxNew();

			myGrid.setConfig({
				targetID : "AXGridTarget",
				theme : "AXGrid",
				fixedColSeq : '',
				fitToWidth : true,
				colGroup : [ {
					key : "pumName",
					label : "품목",
					width : "100",
					align : "center"
				} ],
				colHeadAlign : "center",
					body : {
						onclick : function() {
							var aaa = this.item.pumName
								console.log(this.item.goodName);
								opener.document.getElementById("itemCd").value = this.item.pumName;
								opener.search();
								
								window.close();
							},
							ondblclick : function() {
							},
							oncheck : function() {
							}
						},
						page : {
							display : false
						}
			}); //grid1end	
		},
	};
	jQuery(document).ready(fnObj.pageStart);
</script>

</html>
