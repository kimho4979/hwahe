<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>

<!doctype html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="Author" content="">
<meta name="Keywords" content="">
<meta name="Description" content="">
<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>데이터관리</title>

<!-- CSS(S) -->
<link rel="stylesheet" type="text/css" href="/research/css/reset.css">
<link rel="stylesheet" type="text/css" href="/research/css/common.css">
<link rel="stylesheet" type="text/css" href="/research/css/sub.css">
<!-- CSS(E) -->

<!-- SCRIPT(S) -->
<script type="text/javascript" src="/research/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="/research/js/script.js"></script> 
<!-- SCRIPT(E) -->

<style type="text/css">

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

<script type="text/javascript">
var kindNm = "";
$(document).ready(function(){	
	if($('#kind option:selected').val() !== undefined){
		kindCd = $('#kind option:selected').val();
	}
	
	//절화
	$("#cut1").show();
	$("#cut2").show();
	$("#cut3").show();
	$("#cut4").show();
	
	//난
	$("#orchid1").hide();
	$("#orchid2").hide();	
	
	// 종류 콤보
	fn_searchKind();
});

// 종류 콤보 조회
function fn_searchKind() {
	$.ajax({
	    type : 'post',
	    url : "/reseach/searchCombo.json",
	    data : {
	    	
	    },
	    dataType : 'json',   	           
	    success : function(res){
	    	var val = res.list;
	    	$("#kind").html("");
			for (var i = 0; i < val.length; i++) {
				$("#kind").append("<option value='"+val[i].cdId+"'"+">"+val[i].cdNm+"</option>");	
			}
			
			$(".main_title").html($("#stdYear").prop("value") + "년 " + val[0].cdNm + " 데이터관리");
	    },
	});
}

function goLogout(){
	var result = confirm('로그아웃하시겠습니까?'); 
	if(result) {
		location.href="/login/logoutProc.do";
	}
}

function goMain(){
	
}
// 데이터 검증 종류 분기
function fn_validationDiv() {
	if($('#kind option:selected').val() == "1") {
		fn_validation();
	}
	else {
		fn_validation2();
	}
	
}
// 절화 데이터 검증
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

// 난 데이터 검증
function fn_validation2(){
	
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
      url: "/research/excellValidation2.json",
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
        	 // 난 추가
       		 var errorList3 = data.errorList3;                 
             var html3 = "";
       		 
             for(var i=0; i<errorList3.length; i++){
               	 html3 += "<tr>";
               	 html3 += "<td>"+errorList3[i].errorRow+"</td>";
               	 html3 += "<td>"+errorList3[i].errorMessage+"</td>";
               	 html3 += "</tr>";
                }
       		 
       		 if(errorList3.length == 0){
       			 html3 += "<tr>";
               	 html3 += "<td colspan=\"2\">정상적인 데이터입니다</td>";
               	 html3 += "</tr>";
       		 }
       		 
       		 $("#tbody3").html(html3);
       		 
			 $(".loadingWrap").hide();
                
             if(errorList3.length == 0){
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

//데이터 저장 종류 분기
function fn_saveDiv() {
	if($('#kind option:selected').val() == "1") {
		fn_save();
	}
	else {
		fn_save2();
	}
	
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
        alert("절화 농가현황 "+data1Cnt+"건 /"+"재배현황 "+data2Cnt+"건 저장 완료.");
         
         $(".loadingWrap").hide();
         
      },error: function (jqXHR){
		alert("오류가 발생했습니다. 관리자에게 문의하세요.");
		//location.reload(true);
		$(".loadingWrap").hide();
	  }
	});	
}

// 난 데이터 저장
function fn_save2(){
	
	$(".loadingWrap").show();
	var form = new FormData(document.getElementById('uploadForm'));
    
	$.ajax({
      url: "/research/excellSave2.json",
      data: form,
      dataType: 'json',
      processData: false,
      contentType: false,
      type: 'POST',
      success: function (data){
    	  var data3Cnt = data.data3Cnt;
    	  
        alert("난 농가현황 "+data3Cnt+"건 저장 완료.");
         
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

function fn_stdYearChange(){
	kindNm = $('#kind option:selected').text();
	$(".main_title").html($("#stdYear").prop("value") + "년 " + kindNm + " 데이터관리");
	
}

function fn_stdKindChange() {	
	kindCd = $('#kind option:selected').val();
	kindNm = $('#kind option:selected').text();
	
	$(".main_title").html($("#stdYear").prop("value") + "년 " + kindNm + " 데이터관리");
	
	var stdKind = $("#kind").prop("value");
	
	if(stdKind == "1") {
		//절화
		$("#cut1").show();
		$("#cut2").show();
		$("#cut3").show();
		$("#cut4").show();
		
		//난
		$("#orchid1").hide();
		$("#orchid2").hide();	
	}
	else {
		//절화
		$("#cut1").hide();
		$("#cut2").hide();
		$("#cut3").hide();
		$("#cut4").hide();
		
		//난
		$("#orchid1").show();
		$("#orchid2").show();
	}
	
}

</script>

</head>

<body> 
	<!-- warp(S) -->
	<div class="wrap">
		<!-- header(S) -->
		<div class="header">
			<div class="header_in">
				<a href="/research/main.do" class="btn_home">HOME</a>
				<ul class="menu">
					<li><a href="/research/chulInfo.do" class="btn_menu">전국절화 농가현황</a></li>
					<li><a href="/research/prodInfo.do" class="btn_menu">재배현황</a></li>
					<li><a href="/research/dataUpload.do" class="btn_menu on">데이터관리</a></li>
				</ul>
				<a href="/login/logoutProc.do" class="btn_logout">로그아웃</a>
			</div>
		</div>
		<!-- header(E) -->

		<!-- sub-conts(S) -->
		<div class="content">
			<div class="content_in">
				<!-- main title(S) -->
				<h2 class="main_title">데이터관리</h2>
				<!-- main title(E) -->

				<!-- title(S) -->
				<div class="title_box t1 mt70">
					<form id="uploadForm" enctype="multipart/form-data" method="POST" >
					<div class="fr">
						<dl class="dl_column">
							<dt><p class="tit_tag">종류</p></dt>
							<dd>
								<div class="select_type_01">
									<!-- <select name="kind" id="kind" onchange="fn_stdKindChange();">										
									</select> -->
									<select class="form-control" id="kind" name="kind" onchange="fn_stdKindChange();">
									</select>
								</div>
							</dd>
							<dt><p class="tit_tag">년도</p></dt>
							<dd>
								<div class="select_type_01">
									<select name="stdYear" id="stdYear" onchange="fn_stdYearChange();">
										<c:forEach begin="2019" end="2030" var="year" >
										 	<option value="${year}">${year}</option>
										</c:forEach>
									</select>
									<label for="stdYear"></label>
								</div>
							</dd>
							<dt><p class="tit_tag">파일첨부</p></dt>
							<dd>
								<div class="file_attach">
									<input type="text" id="fileName" class="file_input_textbox" readonly="readonly">
									<div class="file_input_div">
										<input type="button" value="" class="file_input_button">
										<input type="file" id="excellFile" name="excellFile" class="file_input_hidden" onchange="fn_fileChange();javascript:document.getElementById('fileName').value = this.value.split('\\')[this.value.split('\\').length-1]">
									</div>
								</div>
							</dd>
						</dl>
						
						
						<div class="title_btn">
							<a href="javascript:fn_validationDiv();" class="btn_type_01 check">데이터 검증</a>
							<a href="javascript:fn_saveDiv();" id="saveBtn" class="btn_type_01 save" style="display:none;">저장</a>
						</div>
					</div>
					</form>
				</div>
				<!-- title(E) -->
				<!-- 절화 cut 난 orchid -->
				<!-- 농가현황(S)-->
				<div class="title_box mt50" id="cut1">
					<div class="fl">
						<h4 class="tit_02">농가현황(DATA1)</h4>
					</div>
				</div>

				<!-- 테이블(S) -->
				<div class="table_type_01 overflow_x mt30" id="cut2">
					<table>
						<caption>자료갱신 일시</caption>
						<colgroup>
							<col width="200px">
							<col width="1200px">
						</colgroup>
						<thead>
							<tr>
								<th>오류행</th>
								<th>오류내용</th>
							</tr>
						</thead>
						<tbody id="tbody1">
							<tr>
								<td colspan="2"><p class="txt_01">데이터 검증을 진행해주세요.</p></td>
							</tr>
						</tbody>
					</table>
				</div>
				<!-- 테이블(E) -->
				<!-- 농가현황(E)-->
				
				<!-- 재배현황(S)-->
				<div class="title_box mt50" id="cut3">
					<div class="fl">
						<h4 class="tit_02">재배현황(DATA2)</h4>
					</div>
				</div>

				<!-- 테이블(S) -->
				<div class="table_type_01 overflow_x mt30" id="cut4">
					<table>
						<caption>자료갱신 일시</caption>
						<colgroup>
							<col width="200px">
							<col width="1200px">
						</colgroup>
						<thead>
							<tr>
								<th>오류행</th>
								<th>오류내용</th>
							</tr>
						</thead>
						<tbody id="tbody2">
							<tr>
								<td colspan="2"><p class="txt_01">데이터 검증을 진행해주세요.</p></td>
							</tr>
						</tbody>
					</table>
				</div>
				<!-- 테이블(E) -->
				<!-- 재배현황(E)-->
				<!-- 재배현황(S)-->
				<div class="title_box mt50" id="orchid1">
					<div class="fl">
						<h4 class="tit_02">농가현황(DATA1)</h4>
					</div>
				</div>

				<!-- 테이블(S) -->
				<div class="table_type_01 overflow_x mt30" id="orchid2">
					<table>
						<caption>자료갱신 일시</caption>
						<colgroup>
							<col width="200px">
							<col width="1200px">
						</colgroup>
						<thead>
							<tr>
								<th>오류행</th>
								<th>오류내용</th>
							</tr>
						</thead>
						<tbody id="tbody3">
							<tr>
								<td colspan="2"><p class="txt_01">데이터 검증을 진행해주세요.</p></td>
							</tr>
						</tbody>
					</table>
				</div>
				<!-- 테이블(E) -->
				<!-- 재배현황(E)-->
			</div>
		</div>
		<!-- sub-conts(E) -->
	</div>
	<!-- wrap(E) -->		
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
		

</body>
</html>



