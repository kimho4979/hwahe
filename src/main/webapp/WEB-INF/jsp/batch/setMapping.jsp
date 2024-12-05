<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"
%><%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form"
%><%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"
%><%@ taglib prefix="spring" uri="http://www.springframework.org/tags"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"
%><!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title>통합코드 매핑</title>
		<script type="text/javascript" src="<c:url value='/axisj/jquery/jquery.min.js' />"></script>
		<script src="http://malsup.github.com/jquery.form.js"></script>
		<script type="text/javascript">
			function checkFileType(filePath) {
				var fileFormat = filePath.split(".");
				if (fileFormat.indexOf("xlsx") > -1) {
					return true;
				} else if (fileFormat.indexOf("xls") > -1) {
					return true;
				} else {
					return false;
				}
	
			}

			function check() {
				var file = $("#excelFile").val();
				if (file == "" || file == null) {
					alert("파일을 선택해주세요.");
					return false;
				} else if (!checkFileType(file)) {
					alert("엑셀 파일만 업로드 가능합니다.");
					return false;
				}
	
				if (confirm("업로드 하시겠습니까?")) {
					var options = {
						success : function(data) {
							alert("모든 데이터가 업로드 되었습니다.");
							alert(data);
						},
						type : "POST"
					};
					$("#excelUploadForm").ajaxSubmit(options);
	
				}
			}
		</script>
	</head>
	<body>
		<form id="excelUploadForm" name="excelUploadForm" enctype="multipart/form-data" method="post" 
								action= "${pageContext.request.contextPath}/mig/setMappingProcess.do">
			<div class="contents">
				<div>첨부파일은 한개만 등록 가능합니다.</div>
				<dl class="vm_name">
					<dt class="down w90">첨부 파일</dt>
					<dd><input id="excelFile" type="file" name="excelFile" /></dd>
				</dl>
			</div>
			<div class="bottom">
				<button type="button" id="addExcelImpoartBtn" class="btn" onclick="check()" ><span>추가</span></button> 
			</div>
		</form> 
	</body>
</html>