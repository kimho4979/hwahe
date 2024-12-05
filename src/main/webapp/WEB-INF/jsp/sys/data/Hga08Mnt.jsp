<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, user-scalable=no">
<title>모니터요원 입력시스템-이미지관리</title>
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
<!-- @@@@@@@@@@@@@@@@@@@@@@ css end   @@@@@@@@@@@@@@@@@@@@@@ --> 


<link rel="stylesheet" type="text/css" href="<c:url value='/rMateChart/rMateChartH5/Assets/Css/rMateChartH5.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/axisj/axicon/axicon.min.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/arongi/AXJ.min.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/hw/ma.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/hw/common.css' />" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/admin/css/bootstrap.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/admin/css/bootstrap-theme.css">
<!-- @@@@@@@@@@@@@@@@@@@@@@ css end   @@@@@@@@@@@@@@@@@@@@@@ -->

<script type="text/javascript"
	src="<c:url value='/axisj/jquery/jquery.min.js' />"></script>
<script type="text/javascript"
	src="<c:url value='/axisj/dist/AXJ.min.js' />"></script>
<script type="text/javascript"
	src="<c:url value='/axisj/dist/cmmn/ax5-polyfill.js' />"></script>
<script type="text/javascript"
	src="<c:url value='/axisj/dist/cmmn/axjApp.js' />"></script>

<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.3.0/codemirror.min.js"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.3.0/mode/xml/xml.min.js"></script>
<script type="text/javascript"
	src="/plugin/froala/js/froala_editor.min.js"></script>
<script type="text/javascript"
	src="/plugin/froala/js/plugins/align.min.js"></script>
<script type="text/javascript"
	src="/plugin/froala/js/plugins/code_beautifier.min.js"></script>
<script type="text/javascript"
	src="/plugin/froala/js/plugins/code_view.min.js"></script>
<script type="text/javascript"
	src="/plugin/froala/js/plugins/draggable.min.js"></script>
<!-- <script type="text/javascript" src="/plugin/froala/js/plugins/image.min.js"></script>
	<script type="text/javascript" src="/plugin/froala/js/plugins/image_manager.min.js"></script> -->
<script type="text/javascript"
	src="/plugin/froala/js/plugins/link.min.js"></script>
<script type="text/javascript"
	src="/plugin/froala/js/plugins/lists.min.js"></script>
<script type="text/javascript"
	src="/plugin/froala/js/plugins/paragraph_format.min.js"></script>
<script type="text/javascript"
	src="/plugin/froala/js/plugins/paragraph_style.min.js"></script>
<script type="text/javascript"
	src="/plugin/froala/js/plugins/table.min.js"></script>
<!-- <script type="text/javascript" src="/plugin/froala/js/plugins/video.min.js"></script> -->
<script type="text/javascript"
	src="/plugin/froala/js/plugins/url.min.js"></script>
<script type="text/javascript"
	src="/plugin/froala/js/plugins/entities.min.js"></script>
<script type="text/javascript" src="/admin/js/vibrant.js"></script>
<script type="text/javascript" src="/admin/js/script.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/admin/js/bootstrap.min.js"></script>
<!-- We support more than 40 localizations -->
<script type="text/ecmascript" src="/plugin/jquery.jqGrid-4.4.3/js/grid.locale-kr.js"></script>
<script type="text/ecmascript" src="/plugin/jquery.jqGrid-4.4.3/js/jquery.jqGrid.js"></script>
	

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/js/jquery-ui.min.js"></script>


<link rel="stylesheet" href="/admin/css/jquery-ui.min.css">
<link rel="stylesheet" href="/admin/css/jquery-ui.theme.min.css">
<link rel="stylesheet" href="/admin/css/jquery-ui.structure.min.css">
<link rel="stylesheet" href="/admin/css/demo.css">
<link rel="stylesheet" href="/admin/css/style.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.4.0/css/font-awesome.min.css">
<link rel="stylesheet" href="/plugin/froala/css/froala_editor.css">
<link rel="stylesheet" href="/plugin/froala/css/froala_style.css">
<link rel="stylesheet" href="/plugin/froala/css/plugins/code_view.css">
<!-- <link rel="stylesheet" href="/plugin/froala/css/plugins/image_manager.css">
	<link rel="stylesheet" href="/plugin/froala/css/plugins/image.css"> -->
<link rel="stylesheet" href="/plugin/froala/css/plugins/table.css">
<!-- <link rel="stylesheet" href="/plugin/froala/css/plugins/video.css"> -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.3.0/codemirror.min.css">

<style>
@media screen and (min-width: 800px){
.ui-jqgrid .ui-jqgrid-htable{width:auto!important;}
}
		
.preview-area {
	display: flex;
	flex-wrap: wrap;
}

.preview-area img {
	width: 50%;
	margin: 0 0 10px;
	object-fit: contain;
}

.preview-area
 
img
:not
 
(
:nth-child(4n)
 
){
margin-right
:
 
1
.333
%;


}
.swatch {
	display: inline-block;
	height: 40px;
	width: 40px;
	border-radius: 50px;
	-webkit-transition: 0.3s;
	-moz-transition: 0.3s;
}

.swatch.active {
	display: inline-block;
	height: 45px;
	width: 45px;
	/*border: 2mm dashed rgba(0,0,0);*/
	border-style: dashed;
	/*box-shadow : 5px 5px 5px black;*/
	border-radius: 50px;
	-webkit-transition: 0.3s;
	-moz-transition: 0.3s;
	transition-duration: 0.3s;
}

#loading-indicator-back {
	background: rgba(0,0,0,.5) ;
	display: none;
    position: fixed;
    z-index: 999;
    height: 100%;
    width: 100%;
    left: 0;
    top: 0;
}

#loading-indicator {

	background:  url( '/images/loadingBar.gif' ) no-repeat;
	display: none;
    position: fixed;
    z-index: 999;
    height: 100%;
    width: 100%;
    left: 50%;
    top: 50%;
}

#progress_loading {display:block; position:absolute; top:50%; left:50%; transform:translateX(-50%) translateY(-50%); background: #ffffff; text-align: center; z-index:999999;}
@media screen and (min-width: 800px){
.ui-jqgrid .ui-jqgrid-htable{width:auto!important;}
}

</style>

<script type="text/javascript">
	var myGrid = new AXGrid();

	
	var fullUrl = location.protocol+'//'+location.hostname+(location.port ? ':'+location.port: '');
	//console.log(full);
	
	$(document).ready(function() {
		var temp = [];
		console.log("ready");
		
		$.ajax({
 			   url:"/admin/data/selectCultivationStatus.json",
 			   type:"post",
 			   enctype: 'multipart/form-data',
 			   data: {data: "data"},
 			   dataType:'json',
 			   processData: false,    
 		       contentType: false,      
 		       cache: false,   
 			   success: function(res){
					setGrid(res);
 			   },
 				beforeSend: function(){
 					$('#loading-indicator').show();
 					$('#loading-indicator-back').show();
 				},
 				complete: function(){
 					$('#loading-indicator').hide();
 					$('#loading-indicator-back').hide();
 				}
 		   });
	});


	function uploadExcel(){
		if($('#excelUploadFiles')[0].files.length == 0 ){
			toast.push({body:"엑셀파일을 선택해주세요!(하나만 가능)",type:"Caution"})
		return ;
		}
	
		let formData = new FormData();
		formData.set("files",$('#excelUploadFiles')[0].files[0]);
 			
 			$.ajax({
 			   url:"/admin/data/readExcel.json",
 			   type:"post",
 			   enctype: 'multipart/form-data',
 			   data: formData,
 			   dataType:'json',
 			   processData: false,    
 		       contentType: false,      
 		       cache: false,   
 			   success: function(res){
					setGrid(res);
 			   },
 				beforeSend: function(){
 					$('#loading-indicator').show();
 					$('#loading-indicator-back').show();
 				},
 				complete: function(){
 					$('#loading-indicator').hide();
 					$('#loading-indicator-back').hide();
 				}
 		   });
	}
	
	function setGrid(res){
		var val = res.list;
		console.log("val", val);
		myGrid.setConfig({
			targetID : "AXGridTarget",
			theme : "AXGrid",
			fixedColSeq : '',
			fitToWidth:true,
			conHead:{
				rows: [[],[{colSeq:0},{colSeq:1},{colSeq:2},{colSeq:3},{colSeq:4},{colSeq:5}]]
			},
			colGroup : [
				{key:"idx", label:"구분", width:"0", align:"center", display: false},
				{key:"YYYY", label:"연도", width:"150", align:"center", formatter:"number"},
				{key:"LOCATION", label:"지역", width:"150", align:"center", formatter:"text"},
				{key:"VAL1", label:"전업농가", width:"150", align:"center", formatter:"number", editor:{type:"number"}},
				{key:"VAL2", label:"겸업농가", width:"150", align:"center", formatter:"number", editor:{type:"number"}},
				{key:"checkbox", label:"YN", width:"80", align:"center", formatter:"checkbox"},
			],
			colHeadAlign:"center",

			body : {
			    onclick: function(){},
			    oncheck: function(){}
			},
			page:{
			    paging:false
			},
			editor: {
				rows: [
				       [
						{ colSeq:0, align:"center", valign:"middle", form:{type:"readonly", value:"itemValue"}},
				       { colSeq:1, align:"center", valign:"middle", 
				    	   form:{
				    		   type:"text"
				    		   , value:"itemValue"
				    		   , validate:function(){
				    			   if (this.value == ""){
				    				   alert("연도는 필수 입력 항목입니다");
				    				   return false;
				    			   }
				    			   if (this.value.length != 4){
				    				   alert("연도는 4자리만 입력 가능합니다.")
				    				   return false;
				    			   }
				    				return true;
				    		   	}
		    		   		}
				       },
				       { colSeq:2, align:"center", valign:"middle", form:{
				    		   type:"text"
				    		   , value:"itemValue"
				    		   , validate:function(){
				    			   if (this.value == ""){
				    				   alert("지역은 필수 입력 항목입니다");
				    				   return false;
				    			   }
				    				return true;
				    		   	}
		    		   		}
				       },
				       { colSeq:3, align:"center", valign:"middle", form:{type:"text", value:"itemValue"}},
				       { colSeq:4, align:"center", valign:"middle", form:{type:"text", value:"itemValue"}},
				       { colSeq:5, align:"center", valign:"middle", form:{type:"checkbox"}}
				       ]
			      ],
			      response: function(){ // ajax 응답에 대해 예외 처리 필요시 response 구현
			    	  var pushItem = this.res.item;
			            // response에서 처리 할 수 있는 객체 들
			            //console.log({res:this.res, index:this.index, insertIndex:this.insertIndex, list:this.list, page:this.page});
			            if(this.error){
			                console.log("error this", this);
			                return;
			            }


			            var curList = myGrid.getList();
			            for(var i=0; i<curList.length; i++){;
			            	if (curList[i].YYYY == pushItem.YYYY && curList[i].LOCATION == pushItem.LOCATION){
			            		alert("연도와 지역은 중복해서 입력할 수 없습니다.");
			            		return;
			            	}
			            }
                        myGrid.pushList(pushItem, this.insertIndex);
		        	}
			}
		});
		myGrid.setList(val);
	}
	function save(){
    	console.log("--save--")
    	var addRow = myGrid.getList("C", true);
    	var updateRow = myGrid.getList("U", true);

    	console.log("addRow", addRow);
    	console.log("updateRow", updateRow);
    	console.log("removedRow", removedRow);
    	
    	var insertList = []
    	for(var i=0; i<addRow.length; i++){
    		row = {};
    		row['YYYY'] = addRow[i].YYYY;
    		row['LOCATION'] = addRow[i].LOCATION;
    		row['VAL1'] = addRow[i].VAL1;
    		row['VAL2'] = addRow[i].VAL2;
    		insertList.push(row);
    	}
    	var updateList = []
    	for(var i=0; i<updateRow.length; i++){
    		row = {};
    		row['YYYY'] = updateRow[i].YYYY;
    		row['LOCATION'] = updateRow[i].LOCATION;
    		row['VAL1'] = updateRow[i].VAL1;
    		row['VAL2'] = updateRow[i].VAL2;
    		updateList.push(row);
    	}
    	var deleteList = []
    	for(var i=0; i<removedRow.length; i++){
    		row = {};
    		row['YYYY'] = removedRow[i].YYYY;
    		row['LOCATION'] = removedRow[i].LOCATION;
    		deleteList.push(row);
    	}
    	
    	
    	var data = {'insertList': insertList, 'updateList': updateList, 'deleteList': deleteList};
    	console.log("data", data);
    	
    	$.ajax({
			type : "post",
			url : "/admin/data/saveExcel.json",
			data : JSON.stringify(data),
			dataType : 'json',
			async: false,
			success : function(res){
				alert("저장되었습니다");
			}
		});
    	
    	removedRow = [];
		$.ajax({
			   url:"/admin/data/selectCultivationStatus.json",
			   type:"post",
			   enctype: 'multipart/form-data',
			   data: {data: "data"},
			   dataType:'json',
			   processData: false,    
		       contentType: false,      
		       cache: false,   
			   success: function(res){
					setGrid(res);
			   },
				beforeSend: function(){
					$('#loading-indicator').show();
					$('#loading-indicator-back').show();
				},
				complete: function(){
					$('#loading-indicator').hide();
					$('#loading-indicator-back').hide();
				}
		   });
	}
	
	var removedRow = [];
	
	function remove(){
		var checkedList = myGrid.getCheckedList(5);// colSeq
		console.log("checkedList", checkedList)
		var removeList = [];
		$.each(checkedList, function(){
		    removeList.push({idx: this.idx});
		    removedRow.push(this);
		});
		console.log("removeList", removeList);
		myGrid.removeList(removeList);
	}
	function add(){
		var item = {};
		myGrid.appendList(item);
	}
	
</script>



</head>
<body>
<div id="loading-indicator"></div>
<div id="loading-indicator-back"></div>
	<%@ include file="/WEB-INF/inc/IncHeader.jsp"%>
	<article>
		<div class="wrap">
			<%@ include file="/WEB-INF/jsp/inc/IncMenu.jsp"%>

			<div class="hw_content">
				<!--컨텐츠 내용들어가는곳 시작-->
				<h3 class="hw_h3_ma">
					<div class="half1_white"></div>
					<span class="half_title">재배현황 업로드</span>
				</h3>
				<div class="hw_clear"></div>

				<div class="hw_infouse_01">
					<p>
						<span class="purple"> ◎ 이용안내 :</span>&nbsp;꽃이미지를 여러장 색상을 선택하여 올리거나
						엑셀로 일괄 업로드가 가능합니다.
					</p>
				</div>
				<div class="hw_clear"></div>

				<div class="ibox-content11111">
					<form id="emailCreateFrm" name="emailCreateFrm" method="post"
						class="form-horizontal1111111" enctype="multipart/form-data">
						<div class="search_01">
							<input type="file"    id="excelUploadFiles" accept=".xlsx"  style=""   >
								<!-- <p class="search_01_txt">품목선택</p> -->
								<!-- <select class="form-control" style="width: 150px;" id="itemCd" name="itemCd"></select> -->
							</li>
							<li class="search_btn" style="">
								<a href="javascript:search()" style="display: none;"><img src="../images/2020/sub/search_img.png" alt="돋보기">검색</a>
								<a href="javascript:uploadExcel()"><i class="fa-solid fa-upload" style="color: #ffffff;"></i>업로드</a>
								
							</li>
						</div>
<!-- 						<input type="button" class="AXButton" id="search" name="search" value="검색" onclick="grid_ajax();"> -->
							<input type="button" class="AXButton" id="search" name="search" value="검색">
							<input type="button" class="AXButton" id="search" name="search" value="삭제" onclick="remove();">
							<input type="button" class="AXButton" id="search" name="search" value="저장" onclick="save();">
							<input type="button" class="AXButton" id="search" name="search" value="추가" onclick="add();">
					</form>
				</div>
				
				<div class="hw_clear"></div>
				<div class="hw_ma_grid">
					<div id="AXGridTarget" style="height:450px;"></div>
			 	</div>
			</div>
			<!--wrap 끝-->
	</article>
	<footer>
		<%@ include file="/WEB-INF/inc/IncFooter.jsp"%>
	</footer>
</body>
</html>