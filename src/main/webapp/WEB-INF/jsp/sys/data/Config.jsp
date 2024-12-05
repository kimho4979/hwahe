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
 			   url:"/admin/data/selectDailyConfig.json",
 			   type:"post",
 			   data: {CONFIG: "1"},
 			   dataType:'',
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
		
		
		var today = new Date();

		var year = today.getFullYear();
		var month = ('0' + (today.getMonth() + 1)).slice(-2);
		var day = ('0' + today.getDate()).slice(-2);

		var dateString = year + '-' + month  + '-' + day;

		$("#searchEndDate").val(dateString);
		
		$.ajax({
			   url:"/admin/data/selectDailyConfig.json",
			   type:"post",
// 			   enctype: 'multipart/form-data',
			   data: {CONFIG: "2"},
			   dataType:'',
// 			   processData: false,    
// 		       contentType: false,      
// 		       cache: false,   
			   success: function(res){
					setGrid2(res);
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
		$("#searchEndDate2").val(dateString);
		
		$.ajax({
			   url:"/admin/data/selectConfig.json",
			   type:"post",
//			   enctype: 'multipart/form-data',
			   data: {IP: "all"},
			   dataType:'',
//			   processData: false,    
//		       contentType: false,      
//		       cache: false,   
			   success: function(res){
					setGrid3(res);
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
				{key:"RK", label:"순서", width:"50", align:"center", formatter:"text"},
				{key:"PUM_NAME", label:"품목 명", width:"100", align:"center", formatter:"number"},
				{key:"DAN", label:"단위 명", width:"100", align:"center", formatter:"text"},
				{key:"GOOD_NAME", label:"품종 명", width:"290", align:"center", formatter:"text"},
				{key:"CMP_GOOD", label:"품종 코드", width:"290", align:"center", formatter:"text"},
				{key:"checkbox", label:"삭제", width:"30", align:"center", formatter:"checkbox"},
			],
			colHeadAlign:"center",

			body : {
			    onclick: function(){
			    	myGrid.setEditor(this.item, this.index);
			    },
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
				    				   alert("순서는 필수 입력 항목입니다");
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
				    				   alert("품목 명은 필수 입력 항목입니다");
				    				   return false;
				    			   }
				    				return true;
				    		   	}
		    		   		}
				       },
				       { colSeq:3, align:"center", valign:"middle", form:{
				    		   type:"text"
				    		   , value:"itemValue"
				    		   , validate:function(){
				    			   if (this.value == ""){
				    				   alert("단위 명은 필수 입력 항목입니다");
				    				   return false;
				    			   }
				    				return true;
				    		   	}
		    		   		}
				       },
				       { colSeq:4, align:"center", valign:"middle", form:{type:"text", value:"itemValue"}},
				       { colSeq:5, align:"center", valign:"middle", form:{type:"readonly", value:"itemValue"}},
				       { colSeq:6, align:"center", valign:"middle", form:{type:"checkbox"}}
				       ]
			      ],
			      response: function(){ // ajax 응답에 대해 예외 처리 필요시 response 구현
			    	  var pushItem = this.res.item;
			      	console.log("pushItem", pushItem);
			            // response에서 처리 할 수 있는 객체 들
			            console.log({res:this.res, index:this.index, insertIndex:this.insertIndex, list:this.list, page:this.page});
			            if(this.error){
			                console.log("error this", this);
			                return;
			            }


			            var curList = myGrid.getList();
			            for(var i=0; i<curList.length; i++){;
			            	if (curList[i].PUM_NAME == pushItem.PUM_NAME && i != this.index){
			            		alert("품목 명은 중복해서 입력할 수 없습니다.");
			            		return;
			            	}
			            }
			            
			            var cmpGood = "";
			            
			            var pumName = this.res.item.PUM_NAME;
			            var goodNameArr = this.res.item.GOOD_NAME.replaceAll(' ', '')
			            if (goodNameArr != ""){
				            var isNotExist = false;
				            var cmpGoodArr = [];
			            	goodNameArr = goodNameArr.split(',');
				            for(var i=0; i<goodNameArr.length; i++){;
					            $.ajax({
					 			   url:"/admin/data/selectPumJongInfo.json",
					 			   type:"post",
					 			   data: {PUM_NAME: pumName, GOOD_NAME: goodNameArr[i]},
					 			   dataType:'',
					 			   async: false,
					 			   success: function(res){
					 				  	res = res.list;
					 					if(res.length == 0){
					 						alert(goodNameArr[i]+"은(는) 존재하지않는 품종입니다.");
					 						isNotExist = true;
					 						return;
					 					}
					 					cmpGoodArr.push(res[0].PUM_CODE);
					 			   },
					 		   });
			            	}
				            
							if (isNotExist) return;
							
							cmpGood = cmpGoodArr.join();
			            }


			            if(this.index == null){ // 추가
			            	pushItem.CMP_GOOD = cmpGood;
			            	myGrid.pushList(pushItem, this.insertIndex);
			            }else{
			            	this.res.item.CMP_GOOD = cmpGood;
                            AXUtil.overwriteObject(this.list[this.index], this.res.item, true); // this.list[this.index] object 에 this.res.item 값 덮어쓰기
                            myGrid.updateList(this.index, this.list[this.index]);
			            }
                        
		        	}
			},
	        appendGrid: function(index){
	            var item = {};
	            if(index){
	                myGrid.appendList(item, index);
	            }else{
	                myGrid.appendList(item);
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
    	if(addRow.length == 0 && updateRow.length == 0 && removedRow.length == 0){
    		alert("저장할 내용이 없습니다.");
    		return;
    	}
    	var insertList = []
    	for(var i=0; i<addRow.length; i++){
    		row = {};
    		row['CONFIG'] = "1";
    		row['RK'] = addRow[i].RK;
    		row['PUM_NAME'] = addRow[i].PUM_NAME;
    		row['DAN'] = addRow[i].DAN;
    		row['CMP_GOOD'] = addRow[i].CMP_GOOD;
    		row['GOOD_NAME'] = addRow[i].GOOD_NAME;
    		insertList.push(row);
    	}
    	var updateList = []
    	for(var i=0; i<updateRow.length; i++){
    		row = {};
    		row['CONFIG'] = "1";
    		row['RK'] = updateRow[i].RK;
    		row['PUM_NAME'] = updateRow[i].PUM_NAME;
    		row['DAN'] = updateRow[i].DAN;
    		row['CMP_GOOD'] = updateRow[i].CMP_GOOD;
    		row['GOOD_NAME'] = updateRow[i].GOOD_NAME;
    		updateList.push(row);
    	}
    	var deleteList = []
    	for(var i=0; i<removedRow.length; i++){
    		row = {};
    		row['CONFIG'] = "1";
    		row['PUM_NAME'] = removedRow[i].PUM_NAME;
    		deleteList.push(row);
    	}
    	
    	
    	var data = {'insertList': insertList, 'updateList': updateList, 'deleteList': deleteList};
    	console.log("data", data);
    	
    	$.ajax({
			type : "post",
			url : "/admin/data/saveDailyConfig.json",
			data : JSON.stringify(data),
			dataType : 'json',
			async: false,
			success : function(res){
				alert("저장되었습니다");
			}
		});
    	
    	removedRow = [];
		$.ajax({
			   url:"/admin/data/selectDailyConfig.json",
			   type:"post",
			   data: {CONFIG: "1"},
			   dataType:'',
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
		var checkedList = myGrid.getCheckedList(6);// colSeq
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
	
	function preview(){
		var searchEndDate = $("#searchEndDate").val().toString();
		url = "/admin/data/preview.do";
 		let param = "?excelNm="+"품목품종별 출하시기"+"&searchEndDate="+searchEndDate;
 		location.href = url+param;
	}
	var myGrid2 = new AXGrid();
	function setGrid2(res){
		var val = res.list;
		console.log("val2", val);
		myGrid2.setConfig({
			targetID : "AXGridTarget2",
			theme : "AXGrid",
			fixedColSeq : '',
			fitToWidth:true,
			conHead:{
				rows: [[],[{colSeq:0},{colSeq:1},{colSeq:2},{colSeq:3},{colSeq:4}]]
			},
			colGroup : [
				{key:"idx", label:"구분", width:"0", align:"center", display: false},
				{key:"PUM_NAME", label:"품목 명", width:"120", align:"center", formatter:"number"},
				{key:"GOOD_NAME", label:"품종 명", width:"350", align:"center", formatter:"text"},
				{key:"CMP_GOOD", label:"품종 코드", width:"350", align:"center", formatter:"text"},
				{key:"checkbox", label:"삭제", width:"30", align:"center", formatter:"checkbox"},
			],
			colHeadAlign:"center",

			body : {
			    onclick: function(){
			    	myGrid2.setEditor(this.item, this.index);
			    },
			    oncheck: function(){}
			},
			page:{
			    paging:false
			},
			editor: {
				rows: [
				       [
						{ colSeq:0, align:"center", valign:"middle", form:{type:"readonly", value:"itemValue"}},
				       { colSeq:1, align:"center", valign:"middle", form:{
				    		   type:"text"
				    		   , value:"itemValue"
				    		   , validate:function(){
				    			   if (this.value == ""){
				    				   alert("품목 명은 필수 입력 항목입니다");
				    				   return false;
				    			   }
				    				return true;
				    		   	}
		    		   		}
				       },
				       { colSeq:2, align:"center", valign:"middle", form:{type:"text", value:"itemValue"}},
				       { colSeq:3, align:"center", valign:"middle", form:{type:"readonly", value:"itemValue"}},
				       { colSeq:4, align:"center", valign:"middle", form:{type:"checkbox"}}
				       ]
			      ],
			      response: function(){ // ajax 응답에 대해 예외 처리 필요시 response 구현
			    	  var pushItem = this.res.item;
			      	console.log("pushItem", pushItem);
			            // response에서 처리 할 수 있는 객체 들
			            console.log({res:this.res, index:this.index, insertIndex:this.insertIndex, list:this.list, page:this.page});
			            if(this.error){
			                console.log("error this", this);
			                return;
			            }


			            var curList = myGrid2.getList();
			            for(var i=0; i<curList.length; i++){;
			            	if (curList[i].PUM_NAME == pushItem.PUM_NAME && i != this.index){
			            		alert("품목 명은 중복해서 입력할 수 없습니다.");
			            		return;
			            	}
			            }
			            
			            var cmpGood = "";
			            
			            var pumName = this.res.item.PUM_NAME;
			            var goodNameArr = this.res.item.GOOD_NAME.replaceAll(' ', '')
			            if (goodNameArr != ""){
				            var isNotExist = false;
				            var cmpGoodArr = [];
			            	goodNameArr = goodNameArr.split(',');
				            for(var i=0; i<goodNameArr.length; i++){;
					            $.ajax({
					 			   url:"/admin/data/selectPumJongInfo.json",
					 			   type:"post",
					 			   data: {PUM_NAME: pumName, GOOD_NAME: goodNameArr[i]},
					 			   dataType:'',
					 			   async: false,
					 			   success: function(res){
					 				  	res = res.list;
					 					if(res.length == 0){
					 						alert(goodNameArr[i]+"은(는) 존재하지않는 품종입니다.");
					 						isNotExist = true;
					 						return;
					 					}
					 					cmpGoodArr.push(res[0].PUM_CODE);
					 			   },
					 		   });
			            	}
				            
							if (isNotExist) return;
							
							cmpGood = cmpGoodArr.join();
			            }


			            if(this.index == null){ // 추가
			            	pushItem.CMP_GOOD = cmpGood;
			            	myGrid2.pushList(pushItem, this.insertIndex);
			            }else{
			            	this.res.item.CMP_GOOD = cmpGood;
                            AXUtil.overwriteObject(this.list[this.index], this.res.item, true); // this.list[this.index] object 에 this.res.item 값 덮어쓰기
                            myGrid2.updateList(this.index, this.list[this.index]);
			            }
                        
		        	}
			},
	        appendGrid: function(index){
	            var item = {};
	            if(index){
	                myGrid2.appendList(item, index);
	            }else{
	                myGrid2.appendList(item);
	            }
	        }
		});
		myGrid2.setList(val);
	}
	
	var removedRow2 = [];
	
	function remove2(){
		var checkedList = myGrid2.getCheckedList(4);// colSeq
		console.log("checkedList", checkedList)
		var removeList = [];
		$.each(checkedList, function(){
		    removeList.push({idx: this.idx});
		    removedRow2.push(this);
		});
		console.log("removeList", removeList);
		myGrid2.removeList(removeList);
	}
	
	//CONFIG_CODE,CONFIG_VAL,CONFIG_INFO
	var myGrid3 = new AXGrid();
	function setGrid3(res){
		var val = res.list;
		console.log("val3", val);
		myGrid3.setConfig({
			targetID : "AXGridTarget3",
			theme : "AXGrid",
			fixedColSeq : '',
			fitToWidth:true,
			conHead:{
				rows: [[],[{colSeq:0},{colSeq:1},{colSeq:2},{colSeq:3},{colSeq:4}]]
			},
			colGroup : [
				{key:"idx", label:"구분", width:"120", align:"center", display: false},
				{key:"CONFIG_CODE", label:"키", width:"120", align:"center", formatter:"text"},
				{key:"CONFIG_VAL", label:"허용IP", width:"350", align:"center", formatter:"text"},
				{key:"CONFIG_INFO", label:"분류", width:"350", align:"center", formatter:"text"},
				{key:"checkbox", label:"YN", width:"30", align:"center", formatter:"checkbox"},
			],
			colHeadAlign:"center",

			body : {
			    onclick: function(){
			    	myGrid3.setEditor(this.item, this.index);
			    },
			    oncheck: function(){}
			},
			page:{
			    paging:false
			},
			editor: {
				rows: [
				       [
						{ colSeq:0, align:"center", valign:"middle", form:{type:"readonly", value:"itemValue"}},
						{ colSeq:1, align:"center", valign:"middle", form:{type:"readonly", value:"itemValue"}},
				       { colSeq:2, align:"center", valign:"middle", form:{
				    		   type:"text"
				    		   , value:"itemValue"
				    		   , validate:function(){
				    			   if (this.value == ""){
				    				   alert("IP는 필수입력 항목입니다.");
				    				   return false;
				    			   }
				    				return true;
				    		   	}
		    		   		}
				       },
				       { colSeq:3, align:"center", valign:"middle", form:{
		    		   		type:"select"
			    		    //, value:"itemValue"
			    		    //,optionValue:"value"
			    		    //,optionText:"key"
			    		    ,options:[
			    		    	{optionValue:"관리자IP",optionText:"관리자IP"},
			    		    	{optionValue:"상황판IP",optionText:"상황판IP"},
			    		    ]
			    		    
				       }},
				       { colSeq:4, align:"center", valign:"middle", form:{type:"checkbox"}},
				       //{ colSeq:4, align:"center", valign:"middle", form:{type:"checkbox"}}
				       ]
			      ],
			      beforeUpdate: function(val){ // 수정이 되기전 value를 처리 할 수 있음.
			            // 선택된 값은
			            console.log('선택된:',val);
			            return val;
			      },
			      response: function(){ // ajax 응답에 대해 예외 처리 필요시 response 구현
			    		var pushItem = this.res.item;
			      		console.log("pushItem", pushItem);
			            // response에서 처리 할 수 있는 객체 들
			            console.log({res:this.res, index:this.index, insertIndex:this.insertIndex, list:this.list, page:this.page});
			            if(this.error){
			                console.log("error this", this);
			                return;
			            }
			            
			            var $this = this
			            
			            fetch("/admin/data/selectConfig2.json", {
			      		  method: "POST",
			      		  headers: {
			      		    "Content-Type": "application/json",
			      		  },
			      		  body: JSON.stringify({IP:''}),
			      		}).then((response) => response.json())
			      	  .then((data) => {
			      		  if(data.list.length > 0){
			      			// 새로 추가시 코드 자동 넘버링
					            if($this.res.item.requestType == "new"){
									var arr =[];
									for (const x of data.list) {
										arr.push(x.CONFIG_CODE);
									}
									var maxValue = arr.reduce(function(a, b) {
										return Math.max(a, b);
									});

					            	pushItem.CONFIG_CODE = parseInt(maxValue) + 1
					            	myGrid3.pushList(pushItem,$this.insertIndex)
					            	
					            } else if($this.res.item.requestType == "edit") {
					            	AXUtil.overwriteObject($this.list[$this.index], $this.res.item, true); // this.list[this.index] object 에 this.res.item 값 덮어쓰기
		                            myGrid3.updateList($this.index, $this.list[$this.index]);
					            }  
			      		  }
			      		  
			      	  });
			      			
			            
			            

			            
			            
/*
			            var curList = myGrid.getList();
			            for(var i=0; i<curList.length; i++){;
			            	if (curList[i].PUM_NAME == pushItem.PUM_NAME && i != this.index){
			            		alert("품목 명은 중복해서 입력할 수 없습니다.");
			            		return;
			            	}
			            }
			            
			            var cmpGood = "";
			            
			            var pumName = this.res.item.PUM_NAME;
			            var goodNameArr = this.res.item.GOOD_NAME.replaceAll(' ', '')
			            if (goodNameArr != ""){
				            var isNotExist = false;
				            var cmpGoodArr = [];
			            	goodNameArr = goodNameArr.split(',');
				            for(var i=0; i<goodNameArr.length; i++){;
					            $.ajax({
					 			   url:"/admin/data/selectPumJongInfo.json",
					 			   type:"post",
					 			   data: {PUM_NAME: pumName, GOOD_NAME: goodNameArr[i]},
					 			   dataType:'',
					 			   async: false,
					 			   success: function(res){
					 				  	res = res.list;
					 					if(res.length == 0){
					 						alert(goodNameArr[i]+"은(는) 존재하지않는 품종입니다.");
					 						isNotExist = true;
					 						return;
					 					}
					 					cmpGoodArr.push(res[0].PUM_CODE);
					 			   },
					 		   });
			            	}
				            
							if (isNotExist) return;
							
							cmpGood = cmpGoodArr.join();
			            }


			            if(this.index == null){ // 추가
			            	pushItem.CMP_GOOD = cmpGood;
			            	myGrid2.pushList(pushItem, this.insertIndex);
			            }else{
			            	this.res.item.CMP_GOOD = cmpGood;
                            AXUtil.overwriteObject(this.list[this.index], this.res.item, true); // this.list[this.index] object 에 this.res.item 값 덮어쓰기
                            myGrid2.updateList(this.index, this.list[this.index]);
			            }
                     */   
		        	}
			},
	        appendGrid: function(index){
	            var item = {};
	            if(index){
	                myGrid3.appendList(item, index);
	            }else{
	                myGrid3.appendList(item);
	            }
	        }
		});
		myGrid3.setList(val);
	}
	
	function save3(){
		var addRow = myGrid3.getList("C", true);
    	var updateRow = myGrid3.getList("U", true);

    	console.log(addRow,updateRow,removedRow3)
    	addRow = addRow.concat(updateRow)
    	addRow = addRow.concat(removedRow3)
    	
    	
    	console.log(addRow)
    	
    	fetch("/admin/data/setupIpConfig.json", {
    		  method: "POST",
    		  headers: {
    		    "Content-Type": "application/json",
    		  },
    		  body: JSON.stringify(addRow),
    		  /*body: JSON.stringify({
    		    title: "Test",
    		    body: "I am testing!",
    		    userId: 1,
    		  }),*/
    		}).then((response) => {
    			console.log(response)
    			if(response.ok){
    				toast.push("수정완료")
    			}else{
    				toast.push("오류발생")
    			}
    			
    		}).catch((res) => {toast.push("오류발생")});
	}
	
	function save2(){
    	console.log("--save--")
    	var addRow = myGrid2.getList("C", true);
    	var updateRow = myGrid2.getList("U", true);

    	console.log("addRow", addRow);
    	console.log("updateRow", updateRow);
    	console.log("removedRow2", removedRow2);
    	if(addRow.length == 0 && updateRow.length == 0 && removedRow2.length == 0){
    		alert("저장할 내용이 없습니다.");
    		return;
    	}
    	var insertList = []
    	for(var i=0; i<addRow.length; i++){
    		row = {};
    		row['CONFIG'] = "2";
    		row['RK'] = addRow[i].RK;
    		row['PUM_NAME'] = addRow[i].PUM_NAME;
    		row['DAN'] = addRow[i].DAN;
    		row['CMP_GOOD'] = addRow[i].CMP_GOOD;
    		row['GOOD_NAME'] = addRow[i].GOOD_NAME;
    		insertList.push(row);
    	}
    	var updateList = []
    	for(var i=0; i<updateRow.length; i++){
    		row = {};
    		row['CONFIG'] = "2";
    		row['RK'] = updateRow[i].RK;
    		row['PUM_NAME'] = updateRow[i].PUM_NAME;
    		row['DAN'] = updateRow[i].DAN;
    		row['CMP_GOOD'] = updateRow[i].CMP_GOOD;
    		row['GOOD_NAME'] = updateRow[i].GOOD_NAME;
    		updateList.push(row);
    	}
    	var deleteList = []
    	for(var i=0; i<removedRow2.length; i++){
    		row = {};
    		row['CONFIG'] = "2";
    		row['PUM_NAME'] = removedRow2[i].PUM_NAME;
    		deleteList.push(row);
    	}
    	
    	
    	var data = {'insertList': insertList, 'updateList': updateList, 'deleteList': deleteList};
    	console.log("data", data);
    	
    	$.ajax({
			type : "post",
			url : "/admin/data/saveDailyConfig.json",
			data : JSON.stringify(data),
			dataType : 'json',
			async: false,
			success : function(res){
				alert("저장되었습니다");
			}
		});
    	
    	removedRow2 = [];
		$.ajax({
			   url:"/admin/data/selectDailyConfig.json",
			   type:"post",
			   data: {CONFIG: "2"},
			   dataType:'',
			   success: function(res){
					setGrid2(res);
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
	

	var removedRow3 = []
	function remove3(){
		var checkedList = myGrid3.getCheckedList(4);// colSeq
		
		console.log("checkedList", checkedList)
				
		var removeList = [];
		$.each(checkedList, function(i,v){
		    removeList.push({CONFIG_CODE: v.CONFIG_CODE});
		    this.requestType = "del";
		    removedRow3.push(this);
		});
		console.log("removeList", removeList);
		console.log("removedRow3", removedRow3);
		myGrid3.removeList(removeList);
	}
	
	function add2(){
		var item = {};
		myGrid2.appendList(item);
	}
	
	function add3(){
		var item = {};
		item.CONFIG_INFO = '관리자IP'
		myGrid3.appendList(item);
	}
	
	function preview2(){
		var searchEndDate = $("#searchEndDate2").val().toString();
		url = "/admin/data/preview2.do";
 		let param = "?excelNm="+"품목품종별 출하시기"+"&searchEndDate="+searchEndDate;
 		location.href = url+param;
	}
	function selectAuthKey(){
		
		$.ajax({
			url:"/admin/data/authKeySelect.json",
			type:"get",
			contentType: "application/json",
			success: function(res){
				console.log(res.list);
				$("#wrapKey").empty();
				res.list.forEach((el) => {
				   var element ="<span>"+el.CONFIG_INFO+"<br/>"+el.CONFIG_VAL +"</span><br/><br/>"
					$("#wrapKey").append(element);
				})
			},
			error: function(jqXHR, textStatus, errorThrown){
				alert(jqXHR, textStats,errorThrown);
				}
		})
		var myModal = window.div_modal_target = new AXModal();
		myModal.setConfig({
			windowID:"myModalCT",
			width:740,
			onclose: function(){
				toast.push("api Check close");
			}
		});
		
		myModal.openDiv({
			modalID: "my-modal-div",
			targetID: "ui-modal-div-content",
			width: 800,
			closeByEscKey:true
		});
	}
	function updateAuthKey(){
		let key = $("#authKey").val();
		key = key.replace(/ /g, '');
		let configCode = $("#configCode").val();
		console.log(key);
		key = encodeURIComponent(key);

		$.ajax({
			url:"/admin/data/authKeyUpdate.json?key="+key+"&configCode=" + configCode,
			type:"get",
			contentType: "application/json",
			
			success: function(res){
				alert(res.result);
				$("#authKey").val("");
			},
			error: function(jqXHR, textStatus, errorThrown){
				alert(jqXHR.responseJSON.result);
				$("#authKey").val("");
			}
		})
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
					<span class="half_title">소프트 코딩</span>
				</h3>
				<div class="hw_clear"></div>


<!--  				<div class="hw_infouse_01"> -->
 				<div style="border:1px solid #f3f3f3; font-size:12px; line-height:20px; text-align:left; margin-top:10px;color:#61616; background-color:#f3f3f3; ">
					<span class="purple"> ◎ 주요절화류 도매가격 설정</span><br/> 순서: 오름차순으로 품목을 정렬합니다.<br/>품목 명: 가격을 계산할 품목 이름입니다.<br/>단위 명: 품목의 단위입니다.<br/>품종 명: ','구분자를 이용하여 특정 품종만 계산할 수 있습니다. 아무 것도 입력하지 않는 경우 모든 품종에 대하여 계산됩니다.
				</div>
				<div class="hw_clear"></div>

				<div class="ibox-content11111">
					<form id="emailCreateFrm" name="emailCreateFrm" method="post" class="form-horizontal1111111" enctype="multipart/form-data">
							<input type="button" class="AXButton" id="search" name="search" value="삭제" onclick="remove();">
							<input type="button" class="AXButton" id="search" name="search" value="저장" onclick="save();">
							<input type="button" class="AXButton" id="search" name="search" value="추가" onclick="add();">
							
					</form>
				</div>
				
				<div class="hw_clear"></div>
				<div class="hw_ma_grid">
					<div id="AXGridTarget" style="height:450px;"></div>
			 	</div>

			 	<div style="border:1px solid #f3f3f3; font-size:12px; line-height:20px; text-align:left; margin-top:10px;color:#61616; background-color:#f3f3f3; ">
					<span class="purple"> ◎ 주요절화류 도매가격 동향 미리보기</span><br/>날짜를 입력하고 미리보기 버튼을 눌러 주요절화류 도매가격 동향을 다운로드 할 수 있습니다.
				</div>
				<div align="left" style="padding-top:3px;">
					<input id="searchEndDate" value="${searchEndDate}"  height=:15px style="border:1px solid #b6b6b6; background:#fff; border-radius:4px 5px 5px; padding:0px 8px"/>	
					<input type="button" class="AXButton" id="search" name="search" value="미리보기" onclick="preview();" />
				</div>
				
 				<div style="padding-top:20px; border:1px solid #f3f3f3; font-size:12px; line-height:20px; text-align:left; margin-top:10px;color:#61616; background-color:#f3f3f3; ">
					<span class="purple"> ◎ 일별 품목별 경매실적 및 동향(daily.xlsx) 설정</span><br/>품목 명: 가격을 계산할 품목 이름입니다.<br/>품종 명: ','구분자를 이용하여 특정 품종만 계산할 수 있습니다. 아무 것도 입력하지 않는 경우 모든 품종에 대하여 계산됩니다.
				</div>
				<div class="hw_clear"></div>

				<div class="ibox-content11111">
					<form id="emailCreateFrm" name="emailCreateFrm" method="post" class="form-horizontal1111111" enctype="multipart/form-data">
							<input type="button" class="AXButton" id="search" name="search" value="삭제" onclick="remove2();">
							<input type="button" class="AXButton" id="search" name="search" value="저장" onclick="save2();">
							<input type="button" class="AXButton" id="search" name="search" value="추가" onclick="add2();">
							
					</form>
				</div>
				
				<div class="hw_clear"></div>
				<div class="hw_ma_grid">
					<div id="AXGridTarget2" style="height:450px;"></div>
			 	</div>

			 	<div style="border:1px solid #f3f3f3; font-size:12px; line-height:20px; text-align:left; margin-top:10px;color:#61616; background-color:#f3f3f3; ">
					<span class="purple"> ◎ 일별 품목별 경매실적 및 동향  미리보기</span><br/>날짜를 입력하고 미리보기 버튼을 눌러 일별 품목별 경매실적 및 동향을 다운로드 할 수 있습니다.
				</div>
				<div align="left" style="padding-top:3px;">
					<input id="searchEndDate2" value="${searchEndDate2}"  height=:15px style="border:1px solid #b6b6b6; background:#fff; border-radius:4px 5px 5px; padding:0px 8px;cursor: text"/>
					<input type="button" class="AXButton" id="search" name="search" value="미리보기" onclick="preview2();" />
				</div>

				<div style="border:1px solid #f3f3f3; font-size:12px; line-height:20px; text-align:left; margin-top:10px;color:#61616; background-color:#f3f3f3; ">
					<span class="purple"> ◎ Neis API authKey 업데이트</span><br/> NEIS API 만료된 KEY값을 업데이트합니다.
				</div>
				<div style="float: left; padding-top:3px;">
					<select id="configCode" style="font-size:14px;border-radius:5px;padding:2px;">
					<option value="1" style="font-size:14px;border-radius:5px;padding:2px;" selected>Neis학사정보 데이터</option>
					<option value="2" style="font-size:14px;border-radius:5px;padding:2px;">공공 데이터</option>
					<option value="3" style="font-size:14px;border-radius:5px;padding:2px;">식물검역 데이터</option>
					<option value="4" style="font-size:14px;border-radius:5px;padding:2px;">관세청 데이터</option>
					
					</select>
					<input type="text" id="authKey" placeholder="KEY입력" height=:15px style="border:1px solid #b6b6b6; background:#fff; border-radius:4px 5px 5px; padding:0px 8px;width:15vw;cursor: text" />
					<input type="button" class="AXButton" value="업데이트" onclick="updateAuthKey();" />
					<input type="button" class="AXButton" value="KEY조회" onclick="selectAuthKey();" />
				</div>


				<div class="hw_clear"></div>
				<div style="border:1px solid #f3f3f3; font-size:12px; line-height:20px; text-align:left; margin-top:10px;color:#61616; background-color:#f3f3f3; ">
					<span class="purple"> ◎ 관리자 접근제어 </span><br/> 관리자페이지에 접근가능한 IP를 설정합니다.<br/>체크박스는 삭제시에만 사용하고, 추가,수정은 체크여부에 상관없이 반영됩니다.
				</div>
				<div class="hw_clear"></div>
				<input type="button" class="AXButton" id="search" name="search" value="삭제" onclick="remove3();">
							<input type="button" class="AXButton" id="search" name="search" value="저장" onclick="save3();">
							<input type="button" class="AXButton" id="search" name="search" value="추가" onclick="add3();">
				<div class="hw_ma_grid">
					<div id="AXGridTarget3" style="height:450px;"></div>
			 	</div>
		<div style="display:none;">
		<!-- AXModal 이 컨텐츠로 사용하게된 레이어 -->
		<div id="ui-modal-div-content" style="padding:20px;">
			<h2>API KEY확인</h2>
			<br/>
			<br/>
			<div id="wrapKey">
			</div>
			<br/>
			<br/>
			<input type="button" value="창닫기" class="AXButton" onclick="div_modal_target.close('my-modal-div');" />
		</div>
		</div>
			</div>
			<!--wrap 끝-->
	</article>
	<footer>
		<%@ include file="/WEB-INF/inc/IncFooter.jsp"%>
	</footer>
</body>
</html>