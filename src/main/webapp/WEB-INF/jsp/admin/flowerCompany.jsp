<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"	  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"	 uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, user-scalable=no">
<title>모니터요원 입력시스템-지역별 화훼관련 사업체정보관리</title>
<!-- @@@@@@@@@@@@@@@@@@@@@@ css begin @@@@@@@@@@@@@@@@@@@@@@ -->
<link rel="stylesheet" type="text/css" href="<c:url value='/rMateChart/rMateChartH5/Assets/Css/rMateChartH5.css' />"/>   
<link rel="stylesheet" type="text/css" href="<c:url value='/axisj/axicon/axicon.min.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/arongi/AXJ.min.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/hw/ma.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/hw/common.css' />" />
<link rel="stylesheet" href="/admin/css/jquery-ui.min.css">
<link rel="stylesheet" href="/admin/css/jquery-ui.theme.min.css">
<link rel="stylesheet" href="/admin/css/jquery-ui.structure.min.css">
<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/ax5ui/ax5ui-grid/master/dist/ax5grid.css">
<style type="text/css">
/* loading Animation */
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
<!-- @@@@@@@@@@@@@@@@@@@@@@ css end   @@@@@@@@@@@@@@@@@@@@@@ --> 
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.3.min.js"></script>
<script type="text/javascript" src="https://cdn.rawgit.com/ax5ui/ax5core/master/dist/ax5core.min.js"></script>
<script type="text/javascript" src="https://cdn.rawgit.com/ax5ui/ax5ui-grid/master/dist/ax5grid.min.js"></script>
<script type="text/javascript" src="<c:url value='/axisj/jquery/jquery.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/axisj/dist/AXJ.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/ax5-polyfill.js' />"></script>
<script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/axjApp.js' />"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/js/jquery-ui.min.js"></script>
<!-- rMateChartH5 라이센스 시작 -->
<script type="text/javascript" src="<c:url value='/rMateChart/LicenseKey/rMateChartH5License.js' />"></script>
<!-- rMateChartH5 라이센스 끝-->  
<!-- 실제적인 rMateChartH5 라이브러리 시작-->
 <script type="text/javascript" src="<c:url value='/rMateChart/rMateChartH5/JS/rMateChartH5.js' />"></script>
<!-- 실제적인 rMateChartH5 라이브러리 끝-->  
<!-- rMateChartH5 테마 js -->
<script type="text/javascript" src="<c:url value='/rMateChart/rMateChartH5/Assets/Theme/theme.js' />"></script>
<!-- @@@@@@@@@@@@@@@@@@@@@@ css end @@@@@@@@@@@@@@@@@@@@@@ --> 

<script type="text/javascript">
var myProgress = new AXProgress();
var myGrid = new AXGrid();
myGrid.getSelectedItem();
var myModal = new AXModal();
var rn = null;
var searchJongNm = null;
var pageNo2="";
var pageSize="";
var startCount="";
var endCount="";
var rnum="";
var cmpCd="";
var num="";
var pumName2="";
var pumName="";
var goodName="";
var itemCd="";
var kindCd="";
var flowerGubn="";
var flowerCode="";
var mejang="";
var listSize = 0;
var listList = null;
var txtsale="";


function fn_search(){
	pageNo2 = "1";
	startCount = "0";
	endCount = "10";
	
	grid_ajax();
	
}


function getLocation(loc){
	let selected = loc == null || loc == '' ? '' : 'selected' 
	$.ajax({
		type : 'post',
		data : $("#searchStartDate").val(),
		url : '/excel/kosis/getLocation.json',
		dataType:'json',
		success:function(res){
			if(res.msg == "성공"){
				
				let lvl1 = '<option value="all">전체</option>';
				let lvl2 = '<option value="all"  '+selected+' >전체</option>';
				loclvl3 = '<option value="all">전체</option>';
				
				$.each(res.list1,function(i,v){
					//if(v.lvl == "1")								
						lvl1 += '<option '+selected+' value="'+v.CD+'" lvl="'+v.lvl+'">'+v.CPNM1+'</option>';
					//if(v.lvl == "2")
						//lvl2 += '<option value="'+v.CD+'" lvl="'+v.lvl+'">'+v.CPNM1+'</option>';
					//if(v.lvl == "3")
						//loclvl3 += '<option value="'+v.CD+'" lvl="'+v.lvl+'">'+v.CPNM1+'</option>';
						
				})
				$('#locDo').empty()
				
				$('#locDo').html(lvl1)
				$('#locSi').html(lvl2)
				$('#locSi').prop('disabled',true)
				$('#locGu').prop('disabled',true)
				$('#locDo').on('change',function(e){
					$('#locSi').prop('disabled',false)
					$('#locGu').prop('disabled',true)
					lvl2 = '<option value="all"  '+selected+'  >전체</option>';
					let filteredStr = ($(e.target).val().substring(0,2))
					$.each(res.list2,function(i,v){
						if(v.CD.substring(0,2) == filteredStr ){
							lvl2 += '<option value="'+v.CD+'" lvl="'+v.lvl+'">'+v.CPNM1+'</option>';
							
						} else {
							//$('#locSi').empty()
						}	
					})
					$('#locSi').empty()
					$('#locSi').html(lvl2)
				})
				//$('#locSi').html(lvl2)
				$('#locSi').on('change',function(e){
					$('#locSi').prop('disabled',false)
					$('#locGu').prop('disabled',false)
					loclvl3 = '<option value="all">전체</option>';
					let filteredStr = ($(e.target).val().substring(0,4))
					$.each(res.list3,function(i,v){
						if(v.CD.substring(0,4) == filteredStr ){
							loclvl3 += '<option value="'+v.CD+'" lvl="'+v.lvl+'">'+v.CPNM1+'</option>';
							
						} else {
							//$('#locSi').empty()
						}	
					})
					$('#locGu').empty()
					$('#locGu').html(loclvl3)
				})
				
			}
		},
		error:function(){
			console.log(res)
		}
	})
}


function grid_ajax(){
	
	
	$(".loadingWrap").show();
	//var searchStartDate = $("#searchStartDate").val();
	//var searchEndDate = $("#searchEndDate").val();
	//var searchPumNm = $("#searchPumNm").val();
	//var searchGoodNm = $("#searchGoodNm").val();
	//var searchMejang = $("#searchMejang").val();
	var loc = 'al';
	$.ajax({
		type : 'post',
		url : '/admin/kosis/onlineMagazine.json',
		data : { 
			year : $("#searchStartDate").val(),
			loc : $('#searchCPNM1').val(),
			indst : $.trim($('#searchINDST_NM').val()),
			//locDo : $.trim($('#locDo option:selected').val()).length == 0 ? loc : $.trim($('#locDo option:selected').val()) ,
			//locSi : $.trim($('#locSi option:selected').text()).length == 0 ? '전체' : $.trim($('#locSi option:selected').text()),
			//locGu : $.trim($('#locGu option:selected').text()).length == 0 ? '전체' : $.trim($('#locGu option:selected').text()),
			pageNo2 : pageNo2,
			pageSize : pageSize,
			startCount : startCount,
			endCount : endCount = endCount == "" ? "10" : endCount,
		},
		dataType : '',
		success : function(res){
			
			if(res.list.length > 0 ){
				var pageCount2 =  res.list[0].TOTCOUNT/10;
				var pageRest = res.list[0].TOTCOUNT%10;
				if(pageRest ==0){
					pageRest=0;
				}else {
					pageRest=1;
				}
				pageCount2 = Math.floor(pageCount2);
				var pageResult = pageCount2+pageRest;
				var data = {
					list: res.list,
					page:{
						pageNo: JSON.parse(res.list2).pageNo2, // 현재페이지
						pageCount: pageResult, // 전체 페이지수
						listCount: res.list[0].TOTCOUNT // 우측하단 카운트 표시 갯수
					}
				};
				myGrid.setData(data);
				
				$('input:checkbox').attr("checked",false);
	 		  
			}else{
				//alert("검색된 데이터가 없습니다.");
		 		   //$("#searchGoodNm").val("");
		 		   var data = {
	  					list: res.list,   				
	  					page:{
	  						pageNo: 1, // 현재페이지
	  						pageCount: 0, // 전체 페이지수
	  						listCount: 0// 우측하단 카운트 표시 갯수
	  					}
	  				};
		 		   myGrid.setData(data);	
			}
			$(".loadingWrap").hide();   
			
			
	 	   }
			
			
		
	});
};

function fn_onInput(){
	$('input[type=number]').on('input',function(e){
		myGrid.saveEditor();
		console.log('온인풋이벤트 : ',$(e.target).val())
		console.log('온인풋이벤트 : ',e)
	})
}

function fn_onChange(index){
	var data = {};
	data.C1 = $('.C1:eq('+index+')').val()
	data.C2 = $('.C2:eq('+index+')').val()
	data.C3 = $('.C3:eq('+index+')').val()
	data.C4 = $('.C4:eq('+index+')').val()
	data.C5 = $('.C5:eq('+index+')').val()
	data.C6 = $('.C6:eq('+index+')').val()
	data.C7 = $('.C7:eq('+index+')').val()
	data.C8 = $('.C8:eq('+index+')').val()
	data.C9 = $('.C9:eq('+index+')').val()
	data.C10 = $('.C10:eq('+index+')').val()
	data.C11 = $('.C11:eq('+index+')').val()
	data.C12 = $('.C12:eq('+index+')').val()
	data.C13 = $('.C13:eq('+index+')').val()
	data.C14 = $('.C14:eq('+index+')').val()
	data.C15 = $('.C15:eq('+index+')').val()
	data.C16 = $('.C16:eq('+index+')').val()
	data.C17 = $('.C17:eq('+index+')').val()
	data.C18 = $('.C18:eq('+index+')').val()
	data.C19 = $('.C19:eq('+index+')').val()
	data.C20 = $('.C20:eq('+index+')').val()
	data.C21 = $('.C21:eq('+index+')').val()
	data.C22 = $('.C22:eq('+index+')').val()
	data.C23 = $('.C23:eq('+index+')').val()
	data.C24 = $('.C24:eq('+index+')').val()
	data.C25 = $('.C25:eq('+index+')').val()
	data.C26 = $('.C26:eq('+index+')').val()
	data.C27 = $('.C27:eq('+index+')').val()
	data.C28 = $('.C28:eq('+index+')').val()
	data.C29 = $('.C29:eq('+index+')').val()
	data.C30 = $('.C30:eq('+index+')').val()
	console.log(data)
	console.log(myGrid.getCheckedList(0))
}


function updateList(rn){
	var gridData = "rn="+rn;
	fnObj.modalOpen(gridData);
}

function deleteList(rn){
	$.ajax({
		type : 'post',
		url : "/codeMgt/deleteCodeMapList.json",
		data : {
			rn : rn
		},
		dataType : '',   			   
		success : function(res){
			var val = res.list;
			grid_ajax();
		}
	});
};

var fnObj = {
	pageStart: function(){
		
		////$('.loadingWrap').show();
		
		////return;
		$.ajax({
			type : 'post',
			data : {year:$("#searchStartDate").val(),loc:''},
			url : '/excel/kosis/getLocation.json',
			dataType:'json',
			success:function(res){
				if(res.msg == "성공"){
					var datas = [];
					$.each(res.list,function(i,v){
						let obj = {};
						obj.label = v.CPNM1;
						obj.value = v.CD;
						datas.push(obj)
					})
					$('#searchCPNM1').autocomplete({
						source: datas,
						select: function(event,ui){
							$(this).val(ui.item.label);
							$(this).attr('val',ui.item.label);
							
							return false;
						},
						focus: function(event,ui){
							return false;
						}
					})		
				}
			}
		})
		
		
		
		$('#searchStartDate').bindDate({align:"right", valign:"bottom", separator:"-", selectType:"y",  defaultSelectType:"y", defaultDate : "rd1",
			onchange:function(){
				
			}
		});
		$('#searchEndDate').bindDate({align:"right", valign:"bottom", separator:"-", selectType:"d",  defaultSelectType:"d", defaultDate : "rd1",
			onchange:function(){
				
			}
		});
		grid_ajax();
		myGrid.setConfig({
			targetID : "AXGridTarget",
			theme : "AXGrid",
			fixedColSeq : '',
		  
			height:"auto",
			
			colHead:{
				rows:[
					[
						{colSeq:0,rowspan:3},
						{colSeq:1,rowspan:3},
						{colSeq:2,rowspan:3},
						{colSeq:3,rowspan:3},
						{colSeq:4,rowspan:3},
						{colSeq:5,rowspan:3},
						{colSeq:6,rowspan:3},
						{colSeq:null,colspan:2,label:"종사자성별"},
						{colSeq:null,colspan:8,label:"조직형태"},
						{colSeq:null,colspan:6,label:"사업체구분"},
						{colSeq:null,colspan:18,label:"종사자규모"},
						{colSeq:null,colspan:5,label:"종사상지위"},
						{colSeq:null,colspan:4,label:"대표자성별"},
						{colSeq:null,colspan:12,label:"대표자연령대"},
						
					],
					[
						{colSeq:null,label:"남자"},
						{colSeq:null,label:"여자"},
						{colSeq:null,colspan:2,label:"개인사업체"},
						{colSeq:null,colspan:2,label:"회사법인"},
						{colSeq:null,colspan:2,label:"회사이외법인"},
						{colSeq:null,colspan:2,label:"비법인단체"},
						{colSeq:null,colspan:2,label:"단독사업체"},
						{colSeq:null,colspan:2,label:"공장,지사"},
						{colSeq:null,colspan:2,label:"본사,본점"},
						{colSeq:null,colspan:2,label:"1~4명"},
						{colSeq:null,colspan:2,label:"5~9명"},
						{colSeq:null,colspan:2,label:"10~19명"},
						{colSeq:null,colspan:2,label:"20~49명"},
						{colSeq:null,colspan:2,label:"50~99명"},
						{colSeq:null,colspan:2,label:"100~299명"},
						{colSeq:null,colspan:2,label:"300~499명"},
						{colSeq:null,colspan:2,label:"500~999명"},
						{colSeq:null,colspan:2,label:"1000명이상"},
						{colSeq:null,colspan:1,label:"자영업자"},
						{colSeq:null,colspan:1,label:"무급가족"},
						{colSeq:null,colspan:1,label:"상용"},
						{colSeq:null,colspan:1,label:"임시및일용"},
						{colSeq:null,colspan:1,label:"기타"},
						{colSeq:null,colspan:2,label:"대표자남자"},
						{colSeq:null,colspan:2,label:"대표자여자"},
						{colSeq:null,colspan:2,label:"20세미만"},
						{colSeq:null,colspan:2,label:"20~29세"},
						{colSeq:null,colspan:2,label:"30~39세"},
						{colSeq:null,colspan:2,label:"40~49세"},
						{colSeq:null,colspan:2,label:"50~59세"},
						{colSeq:null,colspan:2,label:"60세이상"},
					],
					[
						{colSeq:7},
						{colSeq:8},
						{colSeq:9},
						{colSeq:10},
						{colSeq:11},
						{colSeq:12},
						{colSeq:13},
						{colSeq:14},
						{colSeq:15},
						{colSeq:16},
						{colSeq:17},
						{colSeq:18},
						{colSeq:19},
						{colSeq:20},
						{colSeq:21},
						{colSeq:22},
						{colSeq:23},
						{colSeq:24},
						{colSeq:25},
						{colSeq:26},
						{colSeq:27},
						{colSeq:28},
						{colSeq:29},
						{colSeq:30},
						{colSeq:31},
						{colSeq:32},
						{colSeq:33},
						{colSeq:34},
						{colSeq:35},
						{colSeq:36},
						{colSeq:37},
						{colSeq:38},
						{colSeq:39},
						{colSeq:40},
						{colSeq:41},
						{colSeq:42},
						{colSeq:43},
						{colSeq:44},
						{colSeq:45},
						{colSeq:46},
						{colSeq:47},
						{colSeq:48},
						{colSeq:49},
						{colSeq:50},
						{colSeq:51},
						{colSeq:52},
						{colSeq:53},
						{colSeq:54},
						{colSeq:55},
						{colSeq:56},
						{colSeq:57},
						{colSeq:58},
						{colSeq:59},
						{colSeq:60},
						{colSeq:61},
					]
				]
			},
			
			colGroup : [
				{
					key:"rnum", label:"checkbox", width:"30", align:"center", formatter:"checkbox", 
					disabled:function(){
						return false;
						return (this.index % 2 != 0);
					},
					checked:function(){
						return false
						;
						return (this.index % 2 == 0);
					}
				},
				{key:"YEAR", label:"년도", width:"60", align:"center"},
				{key:"AD_CD_INDST_IDV_CD", label:"행정및산업코드", width:"100", align:"center"},
				{key:"CPNM1", label:"행정구역명", width:"100", align:"center"},
				{key:"INDST_NM", label:"산업분류명칭", width:"100", align:"center"},
				{key:"C1", label:"총사업체수", width:"80", align:"center" ,editor:{updateEdit:true,type:"number",updateWith:["_CUD"]},formatter:function(){return '<input type="number" class="'+this.key+'"  style="width:100%;"  value="'+this.item.C1+'">'}},
					/* ,formatter:function(){
					var html = '<select id="mejang'+this.item.rnum+'" name="mejang'+this.item.rnum+'" class="AXSelect" style="width:100%;">';
						html += '<option value="1"';
						if(this.item.mejang == 1){
							html += ' selected="selected"';	
						}
						html += '>절화</option>';
						html += '<option value="2"';
						if(this.item.mejang == 2){
							html += ' selected="selected"';	
						}
						html += '>관엽</option>';
						html += '<option value="3"';
						if(this.item.mejang == 3){
							html += ' selected="selected"';	
						}
						html += '>난</option>';
						html += '<option value="4"';
						if(this.item.mejang == 4){
							html += ' selected="selected"';	
						}
						html += '>춘란</option>';
						html += '<option value="5"';
						if(this.item.mejang == 5){
							html += ' selected="selected"';	
						}
						html += '>미분류</option>';
						html += '</select>';
						return html;
					}*/
				
				{key:"C2", label:"총종사자수", width:"80",align:"center",   editor:{updateEdit:true,type:"number",updateWith:["_CUD"]},             formatter:function(){return '<input type="number" class="'+this.key+'"  style="width:100%;"  value="'+this.item.C2+'">'}},
				{key:"C3", label:"종사자수", width:"80",align:"center",    editor:{updateEdit:true,type:"number",updateWith:["_CUD"]},            formatter:function(){return '<input type="number" class="'+this.key+'"  style="width:100%;" value="'+ this.item.C3 + '">'}},
				{key:"C4", label:"종사자수", width:"80",align:"center",    editor:{updateEdit:true,type:"number",updateWith:["_CUD"]},            formatter:function(){return '<input type="number" class="'+this.key+'"  style="width:100%;" value="'+ this.item.C4 + '">'}},
				{key:"C5", label:"사업체수", width:"80",align:"center",    editor:{updateEdit:true,type:"number",updateWith:["_CUD"]},            formatter:function(){return '<input type="number" class="'+this.key+'"  style="width:100%;" value="'+ this.item.C5 + '">'}},
				{key:"C6", label:"종사자수", width:"80",align:"center",    editor:{updateEdit:true,type:"number",updateWith:["_CUD"]},            formatter:function(){return '<input type="number" class="'+this.key+'"  style="width:100%;" value="'+ this.item.C6 + '">'}},
				{key:"C7", label:"사업제수", width:"80",align:"center",    editor:{updateEdit:true,type:"number",updateWith:["_CUD"]},            formatter:function(){return '<input type="number" class="'+this.key+'"  style="width:100%;" value="'+ this.item.C7 + '">'}},
				{key:"C8", label:"종사자수", width:"80",align:"center",    editor:{updateEdit:true,type:"number",updateWith:["_CUD"]},            formatter:function(){return '<input type="number" class="'+this.key+'"  style="width:100%;" value="'+ this.item.C8 + '">'}},
				{key:"C9", label:"사업체수", width:"80",align:"center",    editor:{updateEdit:true,type:"number",updateWith:["_CUD"]},            formatter:function(){return '<input type="number" class="'+this.key+'"  style="width:100%;" value="'+ this.item.C9 + '">'}},
				{key:"C10", label:"종사자수", width:"80",align:"center",      editor:{updateEdit:true,type:"number",updateWith:["_CUD"]},         formatter:function(){return '<input type="number" class="'+this.key+'"  style="width:100%;" value="'+ this.item.C10 + '">'}},
				{key:"C11", label:"사업체수", width:"80",align:"center",      editor:{updateEdit:true,type:"number",updateWith:["_CUD"]},         formatter:function(){return '<input type="number" class="'+this.key+'"  style="width:100%;" value="'+ this.item.C11 + '">'}},
				{key:"C12", label:"종사자수", width:"80",align:"center",      editor:{updateEdit:true,type:"number",updateWith:["_CUD"]},         formatter:function(){return '<input type="number" class="'+this.key+'"  style="width:100%;" value="'+ this.item.C12 + '">'}},
				{key:"C13", label:"사업체수", width:"80",align:"center",      editor:{updateEdit:true,type:"number",updateWith:["_CUD"]},         formatter:function(){return '<input type="number" class="'+this.key+'"  style="width:100%;" value="'+ this.item.C13 + '">'}},
				{key:"C14", label:"종사자수", width:"80",align:"center",      editor:{updateEdit:true,type:"number",updateWith:["_CUD"]},         formatter:function(){return '<input type="number" class="'+this.key+'"  style="width:100%;" value="'+ this.item.C14 + '">'}},
				{key:"C15", label:"사업체수", width:"80",align:"center",      editor:{updateEdit:true,type:"number",updateWith:["_CUD"]},         formatter:function(){return '<input type="number" class="'+this.key+'"  style="width:100%;" value="'+ this.item.C15 + '">'}},
				{key:"C16", label:"종사자수", width:"80",align:"center",      editor:{updateEdit:true,type:"number",updateWith:["_CUD"]},         formatter:function(){return '<input type="number" class="'+this.key+'"  style="width:100%;" value="'+ this.item.C16 + '">'}},
				{key:"C17", label:"사업체수", width:"80",align:"center",      editor:{updateEdit:true,type:"number",updateWith:["_CUD"]},         formatter:function(){return '<input type="number" class="'+this.key+'"  style="width:100%;" value="'+ this.item.C17 + '">'}},
				{key:"C18", label:"종사자수", width:"80",align:"center",      editor:{updateEdit:true,type:"number",updateWith:["_CUD"]},         formatter:function(){return '<input type="number" class="'+this.key+'"  style="width:100%;" value="'+ this.item.C18 + '">'}},
				{key:"C19", label:"사업체수", width:"80",align:"center",      editor:{updateEdit:true,type:"number",updateWith:["_CUD"]},         formatter:function(){return '<input type="number" class="'+this.key+'"  style="width:100%;" value="'+ this.item.C19 + '">'}},
				{key:"C20", label:"종사자수", width:"80",align:"center",      editor:{updateEdit:true,type:"number",updateWith:["_CUD"]},         formatter:function(){return '<input type="number" class="'+this.key+'"  style="width:100%;" value="'+ this.item.C20 + '">'}},
				{key:"C21", label:"사업체수", width:"80",align:"center",      editor:{updateEdit:true,type:"number",updateWith:["_CUD"]},         formatter:function(){return '<input type="number" class="'+this.key+'"  style="width:100%;" value="'+ this.item.C21 + '">'}},
				{key:"C22", label:"종사자수", width:"80",align:"center",      editor:{updateEdit:true,type:"number",updateWith:["_CUD"]},         formatter:function(){return '<input type="number" class="'+this.key+'"  style="width:100%;" value="'+ this.item.C22 + '">'}},
				{key:"C23", label:"사업체수", width:"80",align:"center",      editor:{updateEdit:true,type:"number",updateWith:["_CUD"]},         formatter:function(){return '<input type="number" class="'+this.key+'"  style="width:100%;" value="'+ this.item.C23 + '">'}},
				{key:"C24", label:"종사자수", width:"80",align:"center",      editor:{updateEdit:true,type:"number",updateWith:["_CUD"]},         formatter:function(){return '<input type="number" class="'+this.key+'"  style="width:100%;" value="'+ this.item.C24 + '">'}},
				{key:"C25", label:"사업체수", width:"80",align:"center",      editor:{updateEdit:true,type:"number",updateWith:["_CUD"]},         formatter:function(){return '<input type="number" class="'+this.key+'"  style="width:100%;" value="'+ this.item.C25 + '">'}},
				{key:"C26", label:"종사자수", width:"80",align:"center",      editor:{updateEdit:true,type:"number",updateWith:["_CUD"]},         formatter:function(){return '<input type="number" class="'+this.key+'"  style="width:100%;" value="'+ this.item.C26 + '">'}},
				{key:"C27", label:"사업체수", width:"80",align:"center",      editor:{updateEdit:true,type:"number",updateWith:["_CUD"]},         formatter:function(){return '<input type="number" class="'+this.key+'"  style="width:100%;" value="'+ this.item.C27 + '">'}},
				{key:"C28", label:"종사자수", width:"80",align:"center",      editor:{updateEdit:true,type:"number",updateWith:["_CUD"]},         formatter:function(){return '<input type="number" class="'+this.key+'"  style="width:100%;" value="'+ this.item.C28 + '">'}},
				{key:"C29", label:"사업체수", width:"80",align:"center",      editor:{updateEdit:true,type:"number",updateWith:["_CUD"]},         formatter:function(){return '<input type="number" class="'+this.key+'"  style="width:100%;" value="'+ this.item.C29 + '">'}},
				{key:"C30", label:"종사자수", width:"80",align:"center",      editor:{updateEdit:true,type:"number",updateWith:["_CUD"]},         formatter:function(){return '<input type="number" class="'+this.key+'"  style="width:100%;" value="'+ this.item.C30 + '">'}},
				{key:"C31", label:"사업체수", width:"80",align:"center",      editor:{updateEdit:true,type:"number",updateWith:["_CUD"]},         formatter:function(){return '<input type="number" class="'+this.key+'"  style="width:100%;" value="'+ this.item.C31 + '">'}},
				{key:"C32", label:"종사자수", width:"80",align:"center",      editor:{updateEdit:true,type:"number",updateWith:["_CUD"]},         formatter:function(){return '<input type="number" class="'+this.key+'"  style="width:100%;" value="'+ this.item.C32 + '">'}},
				{key:"C33", label:"사업체수", width:"80",align:"center",      editor:{updateEdit:true,type:"number",updateWith:["_CUD"]},         formatter:function(){return '<input type="number" class="'+this.key+'"  style="width:100%;" value="'+ this.item.C33 + '">'}},
				{key:"C34", label:"종사자수", width:"80",align:"center",      editor:{updateEdit:true,type:"number",updateWith:["_CUD"]},         formatter:function(){return '<input type="number" class="'+this.key+'"  style="width:100%;" value="'+ this.item.C34 + '">'}},
				{key:"C35", label:"사업체수", width:"80",align:"center",      editor:{updateEdit:true,type:"number",updateWith:["_CUD"]},         formatter:function(){return '<input type="number" class="'+this.key+'"  style="width:100%;" value="'+ this.item.C35 + '">'}},
				{key:"C36", label:"종사자수", width:"80",align:"center",      editor:{updateEdit:true,type:"number",updateWith:["_CUD"]},         formatter:function(){return '<input type="number" class="'+this.key+'"  style="width:100%;" value="'+ this.item.C36 + '">'}},
				{key:"C37", label:"종사자수", width:"80",align:"center",      editor:{updateEdit:true,type:"number",updateWith:["_CUD"]},         formatter:function(){return '<input type="number" class="'+this.key+'"  style="width:100%;" value="'+ this.item.C37 + '">'}},
				{key:"C38", label:"종사자수", width:"80",align:"center",      editor:{updateEdit:true,type:"number",updateWith:["_CUD"]},         formatter:function(){return '<input type="number" class="'+this.key+'"  style="width:100%;" value="'+ this.item.C38 + '">'}},
				{key:"C39", label:"종사자수", width:"80",align:"center",      editor:{updateEdit:true,type:"number",updateWith:["_CUD"]},         formatter:function(){return '<input type="number" class="'+this.key+'"  style="width:100%;" value="'+ this.item.C39 + '">'}},
				{key:"C40", label:"종사자수", width:"80",align:"center",      editor:{updateEdit:true,type:"number",updateWith:["_CUD"]},         formatter:function(){return '<input type="number" class="'+this.key+'"  style="width:100%;" value="'+ this.item.C40 + '">'}},
				{key:"C41", label:"종사자수", width:"80",align:"center",      editor:{updateEdit:true,type:"number",updateWith:["_CUD"]},         formatter:function(){return '<input type="number" class="'+this.key+'"  style="width:100%;" value="'+ this.item.C41 + '">'}},
				{key:"C42", label:"사업체수", width:"80",align:"center",      editor:{updateEdit:true,type:"number",updateWith:["_CUD"]},         formatter:function(){return '<input type="number" class="'+this.key+'"  style="width:100%;" value="'+ this.item.C42 + '">'}},
				{key:"C43", label:"종사자수", width:"80",align:"center",      editor:{updateEdit:true,type:"number",updateWith:["_CUD"]},         formatter:function(){return '<input type="number" class="'+this.key+'"  style="width:100%;" value="'+ this.item.C43 + '">'}},
				{key:"C44", label:"사업체수", width:"80",align:"center",      editor:{updateEdit:true,type:"number",updateWith:["_CUD"]},         formatter:function(){return '<input type="number" class="'+this.key+'"  style="width:100%;" value="'+ this.item.C44 + '">'}},
				{key:"C45", label:"종사자수", width:"80",align:"center",      editor:{updateEdit:true,type:"number",updateWith:["_CUD"]},         formatter:function(){return '<input type="number" class="'+this.key+'"  style="width:100%;" value="'+ this.item.C45 + '">'}},
				{key:"RPRG_GNR1_ESTM_CNT", label:"사업체수", width:"80",align:"center",     editor:{updateEdit:true,type:"number",updateWith:["_CUD"]},      formatter:function(){return '<input type="number" class="'+this.key+'"  style="width:100%;" value="'+ this.item.RPRG_GNR1_ESTM_CNT + '">'}},
				{key:"RPRG_GNR1_WOKE_SUM", label:"종사자수", width:"80",align:"center",     editor:{updateEdit:true,type:"number",updateWith:["_CUD"]},      formatter:function(){return '<input type="number" class="'+this.key+'"  style="width:100%;" value="'+ this.item.RPRG_GNR1_WOKE_SUM + '">'}},
				{key:"RPRG_GNR2_ESTM_CNT", label:"사업체수", width:"80",align:"center",     editor:{updateEdit:true,type:"number",updateWith:["_CUD"]},      formatter:function(){return '<input type="number" class="'+this.key+'"  style="width:100%;" value="'+ this.item.RPRG_GNR2_ESTM_CNT + '">'}},
				{key:"RPRG_GNR2_WOKE_SUM", label:"종사자수", width:"80",align:"center",     editor:{updateEdit:true,type:"number",updateWith:["_CUD"]},      formatter:function(){return '<input type="number" class="'+this.key+'"  style="width:100%;" value="'+ this.item.RPRG_GNR2_WOKE_SUM + '">'}},
				{key:"RPRG_GNR3_ESTM_CNT", label:"사업체수", width:"80",align:"center",     editor:{updateEdit:true,type:"number",updateWith:["_CUD"]},      formatter:function(){return '<input type="number" class="'+this.key+'"  style="width:100%;" value="'+ this.item.RPRG_GNR3_ESTM_CNT + '">'}},
				{key:"RPRG_GNR3_WOKE_SUM", label:"종사자수", width:"80",align:"center",     editor:{updateEdit:true,type:"number",updateWith:["_CUD"]},      formatter:function(){return '<input type="number" class="'+this.key+'"  style="width:100%;" value="'+ this.item.RPRG_GNR3_WOKE_SUM + '">'}},
				{key:"RPRG_GNR4_ESTM_CNT", label:"사업체수", width:"80",align:"center",     editor:{updateEdit:true,type:"number",updateWith:["_CUD"]},      formatter:function(){return '<input type="number" class="'+this.key+'"  style="width:100%;" value="'+ this.item.RPRG_GNR4_ESTM_CNT + '">'}},
				{key:"RPRG_GNR4_WOKE_SUM", label:"종사자수", width:"80",align:"center",     editor:{updateEdit:true,type:"number",updateWith:["_CUD"]},      formatter:function(){return '<input type="number" class="'+this.key+'"  style="width:100%;" value="'+ this.item.RPRG_GNR4_WOKE_SUM + '">'}},
				{key:"RPRG_GNR5_ESTM_CNT", label:"사업체수", width:"80",align:"center",     editor:{updateEdit:true,type:"number",updateWith:["_CUD"]},      formatter:function(){return '<input type="number" class="'+this.key+'"  style="width:100%;" value="'+ this.item.RPRG_GNR5_ESTM_CNT + '">'}},
				{key:"RPRG_GNR5_WOKE_SUM", label:"종사자수", width:"80",align:"center",     editor:{updateEdit:true,type:"number",updateWith:["_CUD"]},      formatter:function(){return '<input type="number" class="'+this.key+'"  style="width:100%;" value="'+ this.item.RPRG_GNR5_WOKE_SUM + '">'}},
				{key:"RPRG_GNR6_ESTM_CNT", label:"사업체수", width:"80",align:"center",     editor:{updateEdit:true,type:"number",updateWith:["_CUD"]},      formatter:function(){return '<input type="number" class="'+this.key+'"  style="width:100%;" value="'+ this.item.RPRG_GNR6_ESTM_CNT + '">'}},
				{key:"RPRG_GNR6_WOKE_SUM", label:"종사자수", width:"80",align:"center",     editor:{updateEdit:true,type:"number",updateWith:["_CUD"]},      formatter:function(){return '<input type="number" class="'+this.key+'"  style="width:100%;" value="'+ this.item.RPRG_GNR6_WOKE_SUM + '">'}},
				/* {key:"kindCd", label:"품종코드", width:"60", align:"center"},
				{key:"kindNm", label:"품종이름", width:"80", align:"center"},
				{key:"flowerGubn1", label:"추천구분값", width:"80", align:"center"},
				{key:"etc", label:" 품목/품종코드추가", width:"80",align:"center", formatter:function(){
					console.log(this.item.sale);
					var etc = '';
					if(this.item.kindCd == null && this.item.txtsale != null){
					etc = '<button id="etc-modal'+this.item.rnum+'" name="etc'+this.item.rnum+'" class="AXButton"  style="width:80%">추가</button>';
					}
					return etc;
				}}, */
			/* 	{key:"flowerGubn", label:"flowerGubn", width:"80", align:"center"},
				{key:"flowerCode", label:"flowerCode", width:"80", align:"center"},
				{key:"txtsale", label:"T_SALE여부", width:"80", align:"center"},
				{key:"txtreal", label:"T_REAL여부", width:"80",align:"center"} */
			],
			colHeadAlign:"center",
			body : {
				onclick: function(){
					if(this.c == "11"){
						 var gridData="RNUM="+this.item.rnum+"&ITEM_NM="
						+this.item.pumName+"&KIND_NM="+this.item.goodName+"&CMP_CD="
						+this.item.cmpCd+"&ITEM_CD="+this.item.itemCd+"&KIND_CD="+this.item.kindCd+"&FLOWER_GUBN="+this.item.flowerGubn
						+"&FLOWER_CODE="+this.item.flowerCode
						+"&CMP_GOOD="+this.item.cmpGood+"&mejang="+this.item.mejang+"&pum_name="+this.item.pumName2;
						console.log(gridData);
						console.log(this.item.mejang)
						fnObj.modalOpen(gridData); 
					}
					
					else{
						return false;
					}
				},
				ondblclick: function(){
				   
				},
				oncheck: function(){
					//fn_onChange(this.index)			
				},
				
				
			},
			page:{
				   paging:true,   
				   pageSize:10,
				   onchange: function(pageNo){
					   pageNo2=this.pageNo;
					   pageSize=this.pageSize;
					   startCount = ((pageNo2-1) *pageSize)+1;
					   endCount = pageNo2 * pageSize;
					   grid_ajax();
				   }
			}
		});
		myModal.setConfig({
			windowID:"myModalCT", 
			displayLoading: true,
			scrollLock: false,
			mediaQuery: {
				mx:{min:0, max:700}, dx:{min:700}
			},
			onclose: function(){
				console.log("myModal onClose 입니다")
				grid_ajax();
			}
		});
	},
	modalOpen: function(gridData){
		myModal.open({
			type : "GET",
			url : "/codeManage/sale/popupEtc.do",
			pars : (" " + gridData).queryToObject(),
			top : 50,
			closeByEscKey : true
		});
		myModal.setWidth("50%");
	
	}
}

$(document).ready(fnObj.pageStart);



function fn_change(){
	var checkedSize = $('input:checkbox:checked').length;
	var changeMejang =  $("#changeMejang").prop("value");
	
	if(checkedSize > 0){
		$('input:checkbox:checked').each(function(index){
			var chkVal = $(this).val();
			$("#mejang"+chkVal).prop("value",changeMejang);
		});	
	}else{
		alert("변경할 데이터를 체크해주세요");
	}
}

var checkedUpdateSize = 0;
var checkedUpdateList = null;

function fn_save(){
	checkedUpdateList = myGrid.getCheckedList(0)
	checkedUpdateSize = checkedUpdateList.length;
	
	console.log("checkedUpdateList = " + checkedUpdateList);
	console.log("checkedUpdateSize = " + checkedUpdateSize);
	if(checkedUpdateSize > 0){
		$(".loadingWrap").show();
		fn_update(checkedUpdateList);
	}else{
		alert("저장할 데이터를 체크해주세요");
	}
}


function fn_update(checkedList){
	
	//////var checkedList = checkedUpdateList[index];
	
	
	$.each(checkedList,function(i,v){
		console.log('체크한놈',v.C1)	
		
	})
	
	$.ajax({
			type : 'post',
			url : "/admin/kosis/updateCompanyData.json",
			data : JSON.stringify(checkedList)
			, 
			dataType: "json",
            contentType: "application/json", // Specifying this protocol is important   			   
			success : function(res){
				 if(res.msg.indexOf("오류") != -1){
					   toast.push({body:res.msg,type:"Caution"})
				   }
				   
				   toast.push(res.msg) 
				   myGrid.reloadList() 
			}
		});
	
	
	$(".loadingWrap").hide();
	return;
	console.log("VO",chckedUpdateVO);
	var rnum = chckedUpdateVO.rnum;
	var cmpCd = chckedUpdateVO.cmpCd;
	var cmpNm = chckedUpdateVO.cmpNm;
	var cmpGood = chckedUpdateVO.cmpGood;
	var goodName = chckedUpdateVO.goodName;
	var pumName2 = chckedUpdateVO.pumName2;
	var pumName = chckedUpdateVO.pumName;
	var etc = chckedUpdateVO.etc;
	var itemCd = chckedUpdateVO.itemCd;
	var kindCd = chckedUpdateVO.kindCd;
	var flowerGubn = chckedUpdateVO.flowerGubn;
	var flowerCode = chckedUpdateVO.flowerCode;
	var mejang=chckedUpdateVO.mejang;
	var originMejang = chckedUpdateVO.mejang;
	var changeMejang = $("#mejang"+rnum).prop("value");
	var txtsale=chckedUpdateVO.txtsale;
	var searchStartDate = $("#searchStartDate").prop("value");
	var searchEndDate = $("#searchEndDate").prop("value");

	var text = cmpNm+" / "+pumName+" / "+goodName+" : "+getFlowerGugnNm(originMejang)+" > "+getFlowerGugnNm(changeMejang)+ " 변경/마감 작업중...";
	$("#procText").html(text);
	if(originMejang != changeMejang){
		$.ajax({
			type : 'post',
			url : "/code/saleCodeUpdate.json",
			data : {
				cmpCd : cmpCd,
				cmpGood : cmpGood,
				originMejang : originMejang,
				changeMejang : changeMejang,
				pumName : pumName,
				pumName2 : pumName2,
				goodName : goodName,
				itemCd : itemCd,
				kindCd : kindCd,
				flowerGubn : flowerGubn,
				flowerCode : flowerCode,
				txtsale :txtsale,
				text : text,
				searchStartDate : searchStartDate,
				searchEndDate : searchEndDate
			}, 
			dataType : '',   			   
			success : function(res){
				if(index<checkedUpdateSize-1){
					fn_update(index+1);
				}else{
					checkedUpdateList = null;
					$(".loadingWrap").hide();
					fn_search();
					alert(checkedUpdateSize+" 건 변경처리 완료");
					$("#procText").html("로딩중입니다.");
				}
			}
		});
	}else{
		console.log("변경되지 않은 데이터.");
		if(index<checkedUpdateSize-1){
			fn_update(index+1);
		}else{
			checkedUpdateList = null;
			$(".loadingWrap").hide();
			fn_search();
			alert(checkedUpdateSize+" 건 변경처리 완료");
			$("#procText").html("로딩중입니다.");
		}
	}
}

function getFlowerGugnNm(mejang){
	
	if(mejang == '1'){
		return "절화";
	}else if(mejang == '2'){
		return "관엽";
	}else if(mejang == '3'){
		return "난";
	}else if(mejang == '4'){
		return "춘란";
	}else{
		return "미분류";
	}
}


function callbackForUpload(res){
	if(res.msg.indexOf("오류") != -1){
		toast.push({body:"서버오류발생",type:"Caution"})	
		return;
	}
	toast.push(res.msg);
	
}


//엑셀 업로드
function uploadExcel(){
 	
	if($.trim($('#searchStartDate').val()).length == 0 ){
		toast.push({body:"년도를 선택해주세요!",type:"Caution"})
		return ;
	}
		if($('#excelUploadFiles')[0].files.length == 0 ){
			toast.push({body:"엑셀파일을 선택해주세요!(하나만 가능)",type:"Caution"})
		return ;
		}
	
		let formData = new FormData();
		formData.set("year",$('#searchStartDate').val());
		formData.set("files",$('#excelUploadFiles')[0].files[0]);
			
			$.ajax({
			   url:"/excel/kosis/upload.json",
			   type:"post",
			   enctype: 'multipart/form-data',
			   data: formData,
			   dataType:'json',
			   processData: false,    
		       contentType: false,      
		       cache: false,   
			   success:callbackForUpload,
			   error:callbackForUpload,
				beforeSend: function(){
					$('#loading-indicator').show();
					$('#loading-indicator-back').show();
				},
				complete: function(){
					$('#loading-indicator').hide();
					$('#loading-indicator-back').hide();
				}
		   })	
		
		
 	
}


</script>
   
</head>
<body>
<%@ include file="/WEB-INF/inc/IncHeader.jsp" %>
<article>
<div class="wrap">

	<%@ include file="/WEB-INF/jsp/inc/IncMenu.jsp" %>

	<div class="hw_content"><!--컨텐츠 내용들어가는곳 시작-->
	
		<h3 class="hw_h3_ma"><span class="half_title">지역별화훼사업체관리</span></h3>
		<div class="hw_clear"></div>	
			
		<div class="hw_infouse_01">  <p> <span class="purple"> ◎ 이용안내 :</span> 각 지역별 화훼관련 종사자 및 사업체수를 집계한 데이터를 제공합니다.</p></div>
		
		<div style="margin-bottom:10px; margin-top:10px;">	
			<div class="selectWrap">
				년도
				 <!-- 
				<input type="text" id="searchStartDate" name="searchStartDate" value="${pRequestParamMap.searchStartDate}" class="AXInput"/>
				-
				<input type="text" id="searchEndDate" name="searchEndDate" value="${pRequestParamMap.searchEndDate}" class="AXInput"/>
				 -->
				 
				<input type="text" id="searchStartDate" name="searchStartDate" value="2021" class="AXInput"/>
				 
				<!-- <input type="text" id="searchEndDate" name="searchEndDate" value="2020-02-28" class="AXInput"/> -->
				 
			</div>
		</div>
		
		<div style="margin-bottom:10px; margin-top:10px;">	
			<div class="selectWrap">
				<!-- 화훼구분
				<select name="searchMejang" id="searchMejang" class="item_search_select">
					<option value="5">미분류</option>
					<option value="1">절화</option>
					<option value="2">관엽</option>
					<option value="3">난</option>
					<option value="4">춘란</option>
				</select> -->
				행정구역명
				<input type="text" id="searchCPNM1" name="searchCPNM1" class="AXInput" onkeypress='if(event.keyCode==13) {fn_search(); return false;}'/>
				산업분류명칭
				<select  style="display: none;"  name="NM" id="NM" class="item_search_select">
					<option value="" selected>전체</option>
					<option value="">채소, 화훼작물 및 종묘 재배업</option>
					<option value="">화훼작물 재배업</option>
					<option value="">채소, 화훼 및 과실작물 시설 재배업</option>
					<option value="">화훼류 및 식물 도매업</option>
				</select>
				<input style="" type="text" id="searchINDST_NM" name="searchINDST_NM" class="AXInput" onkeypress='if(event.keyCode==13) {fn_search(); return false;}'/>
				<input type="button" class="AXButton" id="btn1" value="검색" onclick="fn_search();"/>
				<div class="hw_clear"></div><div class="hw_clear"></div>		
				<div class="hw_infouse_01">
					<input type="file"  class="AXButton"   id="excelUploadFiles" accept=".xlsx"  style="display:inline; !important"   > 
					<input type="button" class="AXButton" id="btn2" value="업로드" onclick="javascript:uploadExcel();"/>
					<span class="purple">&nbsp;&nbsp;년도 선택(필수) - 선택된 년도로 업로드됩니다. </span>
				</div>
			</div>
		</div>
		
		<div class="hw_clear"></div>
						
		<div style="margin-top:20px; margin-bottom:10px;">
			<div class="hw_clear"></div>
			<div class="hw_ma_grid">
				<div id="AXGridTarget" style="height:150px;" ></div>
				
		 	</div>
		</div>
		
		<div style="margin-bottom:10px; margin-top:10px;">	
			<div class="selectWrap">
			<!-- 	<select name="changeMejang" id="changeMejang" class="item_search_select">
					<option value="1" selected="selected">절화</option>
					<option value="2">관엽</option>
					<option value="3">난</option>
					<option value="4">춘란</option> 
					<option value="5">미분류</option>
				</select>
			 -->	<!-- <input type="button" class="AXButton" id="btn2" value="일괄변경" onclick="fn_change();"/> -->
				<input style="float:right;width: 32.7%;height: 40px;font-size: 16px;line-height: 38px;color: white;background-color: #00582E;text-align: center;font-weight: 
				bold;margin-right: 1%;" type="button" value="저장하기" onclick="fn_save();">
			</div>
		</div>
	</div>
</div><!--wrap 끝-->
<div class="loadingWrap">
	<div class="loadArea">
		<div class="loading">
			<div class="lds-dual-ring"></div>
			<div class="text" id="procText" style="color: white;">
				로딩중입니다.
			</div>
		</div>
	</div>
</div>

</article>

<div class="hw_clear"></div>
<footer>
<%@ include file="/WEB-INF/inc/IncFooter.jsp" %>
</footer>

</body>

</html>

