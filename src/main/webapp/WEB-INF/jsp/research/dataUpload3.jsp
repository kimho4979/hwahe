<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<style type="text/css">
td, th {border: 1px solid;}
table {width:1024px;max-height: 300px;overflow-y: scroll;}
table tbody{width:1024px; max-height: 300px;overflow-y: scroll;}
.loadingWrap { display:none; }
.loadArea { position:fixed; display:table; left:0; top:0; width:100%; height:100%; background:#000; background-color:rgba(0,0,0,0.5); z-index:100; }
.loadArea .loading { display:table-cell; width:100%; height:100%; text-align:center; vertical-align:middle; }
.lds-dual-ring { display: inline-block; width: 80px; height: 80px; }
.lds-dual-ring:after { content: " "; display: block; width: 64px; height: 64px; margin: 8px; border-radius: 50%; border: 6px solid #fff; border-color: #fff transparent #fff transparent; animation: lds-dual-ring 1.2s linear infinite; }

@keyframes lds-dual-ring {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
}


</style>

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

<script type="text/javascript">

$(document).ready(function(){	

});

function goLogout(){
	var result = confirm('로그아웃하시겠습니까?'); 
	if(result) {
		location.href="/login/logoutProc.do";
	}
}

function goMain(){
	
}

function fn_validation(){
	
	$(".loadingWrap").show();
	var form = new FormData(document.getElementById('uploadForm'));
    
	/*
	if($("#uploadText").val() == null || $("#uploadText").val() == ""){
		alert("엑셀파일울 첨부해주세요.");
		return false;
	}
	$("#uploadingText").html("업로드중..");
	*/
	
	$.ajax({
      url: "/research/excellValidation.json",
      data: form,
      dataType: 'json',
      processData: false,
      contentType: false,
      type: 'POST',
      success: function (data){
         console.log(data);
         
         if(data.result == '4'){
        	 alert("파일을 첨부해주세요.");
        	 $(".loadingWrap").hide();
         }else{
        	 var errorList1 = data.errorList1;
             var errorList2 = data.errorList2;
             var html1 = "";
             var html2 = "";
             for(var i=0; i<errorList1.length; i++){
            	 html1 += "<tr>";
            	 html1 += "<td>"+errorList1[i].errorRow+"</td>";
            	 html1 += "<td>"+errorList1[i].errorMessage+"</td>";
            	 html1 += "</tr>";
             }
             
    		 for(var i=0; i<errorList2.length; i++){
    			 html2 += "<tr>";
            	 html2 += "<td>"+errorList2[i].errorRow+"</td>";
            	 html2 += "<td>"+errorList2[i].errorMessage+"</td>";
            	 html2 += "</tr>";
             }
    		 
    		 if(errorList1.length == 0){
    			 html1 += "<tr>";
            	 html1 += "<td colspan=\"2\">정상적인 데이터입니다</td>";
            	 html1 += "</tr>";
    		 }
    		 
    		 if(errorList2.length == 0){
    			 html2 += "<tr>";
            	 html2 += "<td colspan=\"2\">정상적인 데이터입니다</td>";
            	 html2 += "</tr>";
    		 }
    		 
             $("#tbody1").html(html1);
             $("#tbody2").html(html2);
             
             $(".loadingWrap").hide();
             
             if(errorList1.length == 0 && errorList2.length == 0){
            	 $("#saveBtn").css("display","");
             }
             
         }
         
      },error: function (jqXHR){
		alert("오류가 발생했습니다. 관리자에게 문의하세요.");
		//location.reload(true);
		$(".loadingWrap").hide();
	  }
	});	
}

function fn_save(){
	
	$(".loadingWrap").show();
	var form = new FormData(document.getElementById('uploadForm'));
    
	$.ajax({
      url: "/research/excellSave.json",
      data: form,
      dataType: 'json',
      processData: false,
      contentType: false,
      type: 'POST',
      success: function (data){
    	  var data1Cnt = data.data1Cnt;
    	  var data2Cnt = data.data2Cnt;
        alert("농가현황 "+data1Cnt+"건 /"+"재배현황 "+data2Cnt+"건 저장 완료.");
         
         $(".loadingWrap").hide();
        
         
      },error: function (jqXHR){
		alert("오류가 발생했습니다. 관리자에게 문의하세요.");
		//location.reload(true);
		$(".loadingWrap").hide();
	  }
	});	
}

function fn_fileChange(){
	$("#saveBtn").css("display","none");
}

</script>

<a href="/research/main.do">home</a>
<a href="/research/chulInfo.do">농가현황</a>
<a href="/research/prodInfo.do">재배현황</a>
<a href="/research/dataUpload.do">데이터관리</a>

<div> 
	
	<form id="uploadForm" enctype="multipart/form-data" method="POST" >
	년도
	<select name="stdYear" id="stdYear">
	<c:forEach begin="2019" end="2030" var="year">
	 <option value="${year}">${year}</option>
	 </c:forEach>
	</select>
	
	
	파일
	<input type="file" id="excellFile" name="excellFile" onchange="fn_fileChange();"/>
	
	
	<input type="button" class="AXButton" onclick="fn_validation();" value="데이터검증"/>
	<input type="button" class="AXButton" id="saveBtn" onclick="fn_save();" value="저장" style="display:none;">
	</form>
	
</div>

<div>
	<h3>data1<h3>
	<div>
		<table style="border: 1px solid ;">
			<caption><h3>data1<h3></caption>
			<colgroup>
				<col width="10%">
				<col width="90%">
			</colgroup>
			<thead>
				<tr>
					<th style="cursor: pointer;" onclick="fn_order1(0);">오류행</th>
					<th style="cursor: pointer;" onclick="fn_order1(2);">오류내용</th>
				</tr>
			</thead>
			<tbody id="tbody1">
				<tr>
					<td colspan="3">데이터 검증을 진행해주세요.</td>
				</tr>
			</tbody>
		</table>
	</div>
	<br>
	<h3>data2</h3>
	<div>
		<table style="border: 1px solid ;">
			<caption><h3>data2</h3></caption>
			<colgroup>
				<col width="10%">
				<col width="90%">
			</colgroup>
			<thead>
				<tr>
					<th style="cursor: pointer;" onclick="fn_order2(0);">오류행</th>
					<th style="cursor: pointer;" onclick="fn_order2(2);">오류내용</th>
				</tr>
			</thead>
			<tbody id="tbody2">
				<tr>
					<td colspan="2">데이터 검증을 진행해주세요.</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>

<div class="loadingWrap">
    <div class="loadArea">
        <div class="loading">
        	<div class="lds-dual-ring"></div>
        	<div class="text" id="procText" style="color: white;">
	        	처리중입니다.
	        </div>
        </div>
    </div>
</div>




