<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>품목코드 SELECTBOX 페이지</title>

	<link rel="shortcut icon" href="<c:url value='/axisj/ui//axisj.ico' />" type="image/x-icon" />
    <link rel="icon" href="<c:url value='/axisj/ui/axisj.ico' />" type="image/x-icon" />
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="<c:url value='/axisj/ui/AXJ.png' />" />
    <link rel="apple-touch-icon-precomposed" href="<c:url value='/axisj/ui/AXJ.png' />" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/arongi/page.css' />">
    <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/arongi/AXJ.min.css' />">
	
	<link rel="stylesheet" type="text/css" href="<c:url value='/axisj/axicon/axicon.min.css' />" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/arongi/mobileAXJ.min.css' />" />	
	<link rel="stylesheet" type="text/css" href="/css/mobile/common/layout.css"/>
	
	<script type="text/javascript" src="<c:url value='/axisj/jquery/jquery.min.js' />"></script>
	<script type="text/javascript" src="<c:url value='/axisj/dist/AXJ.min.js' />"></script>
	<script type="text/javascript" src="<c:url value='/axisj/lib/AXUpload5.js' />"></script>
	<script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/ax5-polyfill.js' />"></script>
	<script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/axjApp.js' />"></script>
</head>

<script type="text/javascript">

	<%-- Page Start --%>
	$(document).ready(function(){
		largeNmOn('01');
		//smallNmOn('01');
		
		// 지워야할 코딩 (Test Coding)
		$("#largeCd").append("<option value=''>선택</option>");
		$("#smallCd").append("<option value=''>선택</option>");
	});
	
	<%-- Large_Name을 출력하는 JSON --%>
	function largeNmOn(index){
		$.ajax({
			type : "post",
			url : "/cmmn/item/itemListLargeNm.json",
			data : {
				largeCd : index
			},
			dataType : '',
			success : function(res){
				var val = res.result;
				for(var i=0; i<=val.length; i++){
					$("#largeCd").append("<option value='"+val[i].largeCd+"'>"+val[i].largeName+"</option>");
					//$("#largeCd").val(val[0].largeCd);
				}
			}
		});
	}
	
	<%-- Small_Name을 출력하는 JSON --%>
	function smallNmOn(index){
		$.ajax({
			type : "post",
			url : "/cmmn/item/itemListSmallNm.json",
			data : {
				largeCd : index
			},
			dataType : '',
			success : function(res){
				var val = res.result;
				console.log(val);
				for(var i=0; i<=val.length; i++){
					$("#smallCd").append("<option value='"+val[i].smallCd+"'>"+val[i].smallName+"</option>");
					$("#smallCd").val(val[0].smallCd);
				}
			}
		});
		if($("#largeCd").val()==""){
			$("#smallCd").empty();
			$("#smallCd").append("<option value=''>선택</option>");
		}
	}

</script>

<body>
<div class="radio_btn_all">
	<span class="hw_item_search_title">품목검색</span>
	<select name="largeCd" id="largeCd" class="item_search_select" onchange="smallNmOn(this.value)">
	</select>

	<span class="hw_variety_search_title">품종검색</span>
	<select name="smallCd" id="smallCd" class="variety_search_select">
	</select>
</div>
</body>
</html>