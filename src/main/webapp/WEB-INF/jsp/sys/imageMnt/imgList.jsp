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
<title>모니터요원 입력시스템-이미지조회</title>
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
<script src="https://cdnjs.cloudflare.com/ajax/libs/color-thief/2.3.0/color-thief.umd.js"></script>

<!-- rMateChartH5 라이센스 시작 -->
<script type="text/javascript" src="<c:url value='/rMateChart/LicenseKey/rMateChartH5License.js' />"></script>
<!-- rMateChartH5 라이센스 끝-->  
<!-- 실제적인 rMateChartH5 라이브러리 시작-->
 <script type="text/javascript" src="<c:url value='/rMateChart/rMateChartH5/JS/rMateChartH5.js' />"></script>
<!-- 실제적인 rMateChartH5 라이브러리 끝-->  
<!-- rMateChartH5 테마 js -->
<script type="text/javascript" src="<c:url value='/rMateChart/rMateChartH5/Assets/Theme/theme.js' />"></script>
<!-- @@@@@@@@@@@@@@@@@@@@@@ css end   @@@@@@@@@@@@@@@@@@@@@@ --> 



<style>
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

</style>



<script type="text/javascript">
var myProgress = new AXProgress();
var myGrid = new AXGrid();
var myModal = new AXModal();
var rn = null;
var searchJongNm = null;
var searchMokNm = null;
var searchColorNm = null;
var pageNo2="";
var pageSize="";
var startCount="";
var endCount="";

//공공데이터 OpenAPI명 List :: 공통
function commonSelect(){
	$.ajax({
		type : 'post',
		url : "/apiMgt/selectApiSelectBoxList.json",
		data : {},
		dataType : '',   	           
		success : function(res){
			var val = res.list;
			
			$("#searchNm").empty();
			$("#searchNm").append("<option value=''>전체</option>");
			for(var i=0; i<val.length; i++){
				$("#searchNm").append("<option value="+val[i].reqDataCd+">"+val[i].reqDataNm+"</option>");
			}
		}
	});
};

function grid_ajax(){
	
	searchJongNm = $.trim($("#searchJongNm").val());
	searchMokNm = $.trim($("#searchMokNm").val());
	searchColorNm = $.trim($("#searchColorNm").val());
	$.ajax({
		type : 'post',
		url : "/admin/img/getImgList.json",
		data : {
			searchJongNm : searchJongNm,
			searchMokNm : searchMokNm,
			searchColorNm : searchColorNm,
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
			//var val = res.list;
			//myGrid.setList(val);
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
};

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


function printColor(ev) {
    const color = ev.target.value
    const r = parseInt(color.substr(1, 2), 16)
    const g = parseInt(color.substr(3, 2), 16)
    const b = parseInt(color.substr(5, 2), 16)
    console.log(`red: ${r}, green: ${g}, blue: ${b}`)
    console.log([r, g, b])
    alert(`R: ${r}, G: ${g}, B: ${b}`)
}

function fn_search(){
	pageNo2 = "1";
	startCount = "0";
	endCount = "10";
	
	grid_ajax();
	
}


var fnObj = {
    pageStart: function(){ 
    	//commonSelect();
    	
    	$('#searchJongNm').on("keyup", function(key) {
			if (key.keyCode == 13) {
				$('#searchMokNm').val('')
				$('#searchColorNm').val('')
				fn_search()
			}
		})
		$('#searchMokNm').on("keyup", function(key) {
			if (key.keyCode == 13) {
				$('#searchColorNm').val('')
				$('#searchJongNm').val('')
				fn_search()
			}
		})
		$('#searchColorNm').on("keyup", function(key) {
			if (key.keyCode == 13) {
				$('#searchMokNm').val('')
				$('#searchJongNm').val('')
				fn_search()
			}
		})
    	
    	grid_ajax();
		myGrid.setConfig({
			targetID : "AXGridTarget",
			theme : "AXGrid",
			fixedColSeq : '',
			fitToWidth:true,
			//showLineNumber: false,
            //showRowSelector: false,
            //multipleSelect: false,
			colGroup : [
				/*{
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
				},*/
				
				
				{key:"PUM_CODE", label:"품코드", width:"100", align:"center", pk:true},
				{key:"P_MOK_NAME", label:"품목", width:"100", align:"center"},
				{key:"P_JONG_NAME", label:"품종", width:"100", align:"center"},
				{key:"L_U_DT", label:"최신변경일", width:"100", align:"center"},
				{key:"COLOR_NAME", label:"색상", width:"100", align:"center"},
				{key:"RGB_CODE", label:"RGB", width:"100", align:"center",formatter:function(){
					let img = this.item.RGB_CODE != null ? this.item.RGB_CODE : "";
					console.log(this)
					//return '<input title="ColorPicker"  onchange="printColor(event)"  type="color" id="colorpick"   style="margin: 3px; background-color: '+img+';"   value="'+img+'" >'
					return '<span class="swatch theif" style="background-color: '+img+';">'+''+'</span>';
				}},
				{key:"FILE_ID", label:"파일", width:"100", align:"center"},
				
				{key:"FILE_ID", label:"이미지", width:"100", align:"center", formatter:function(){
					//console.log(this.item.FILE_ID.split(".")[0] + ".img")
					let img = this.item.FILE_ID != null ? this.item.FILE_ID.split(".")[0] + ".img" :"";
					console.log(this)
					if(img.length > 1){
						return '<div style="width:100%;height:50px;" ><img  id="p'+this.item.PUM_CODE+'"  style="width:100%;height:50px;"  onclick="fnObj.modalOpen(\''+encodeURIComponent(JSON.stringify(this.item))+'\')"  alt=""  src="/admin/img/loc/' + img + '"></div>';	
					}else{
						return '<div style="width:100%;height:50px;" ></div>';
					}
					//return '<input type="button" class="AXButton" id="uBtn'+this.item.rn+'" value="수정" onclick="updateList(\''+this.item.rn+'\')"/>';
				}},
				{key:"delete", label:"삭제버튼", width:"80", align:"center",display:false ,formatter: function(){
					//////////return '<input type="button" class="AXButton" id="dBtn'+this.item.rn+'" value="삭제" onclick="deleteList(\''+this.item.rn+'\')"/>';
				}},
			],
			colHeadAlign:"center",

			body : {
			    onclick: function(){},
			    ondblclick: function(){
			    	
			    	fnObj.modalOpen(encodeURIComponent(JSON.stringify(this.item)));
			    },
			    oncheck: function(){}
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
			},
			//displayLoading:false
		});
		
    },
    modalOpen: function(fileId){
    	let obj = (JSON.parse(decodeURIComponent(fileId)))
    	 if(obj.FILE_ID.length > 10) $('#imageModalArea').siblings().show() 
    	 $('#imageModalArea').siblings().css('padding-left','5%')
    	$('#disMok').val(obj.P_MOK_NAME)
    	$('#disJong').val(obj.P_JONG_NAME)
    	$('#txtColor').val(obj.COLOR_NAME)
    	$('#txtPumCd').val(obj.PUM_CODE)
    	 let img = new Image();
    	img.src = "/admin/img/loc/"+obj.FILE_ID;
    	let w = window.innerWidth;
    	img.onload = function(){
    		//alert(this.width + " X " + this.height);
    		myModal.openDiv({
    			modalID:"imageModal",				
    			targetID:"imageModalContent",
    			closeByEscKey:true,
    			closeButton:true,
    			width: (w/2 )
    			//height:this.height
    		});
    		
    		let h = window.innerHeight; 
    		$('#imageModalArea').attr("src",img.src)
    		//$('#imageModalArea').css("width",($('#imageModal').css('width') ))
    		$('#imageModalArea').css("width",'100%')
    		//$('#imageModalArea').css("display",'flex')
    		//$('#imageModalArea').css("height",(h/4 ))
    		$('#imageModalArea').click(function(){
    			$('#imageModal_close').trigger('click')
    		})
    		fnObj.extractImg();
    	}
    	return false;
		
	},
	extractImg : function(){
		var img = $('#imageModalArea')[0]//document.getElementById(imgId);
		const img2 = new ColorThief();
		//$('#imageModalArea').siblings().find('.swatch')[0].style.backgroundColor = '';
		   setTimeout(() => {
			   var colors = (img2.getPalette(img, 24));
			   for(var i=0;i<colors.length;i++){
					$('#imageModalArea').siblings().find('.swatch:eq('+i+')')[0].style.backgroundColor = 'rgb(' + colors[i] + ')';
			   } 
			   fnObj.eventOnImage();
		   }, 2000);
	},
	eventOnImage : function(){
		$('.swatch.colorLightVibrant').on('click',function(e){
			$(e.target).siblings().removeClass("active")
			$(e.target).addClass("active")
			$('#txtRgb').val($(e.target).css("background-color"))
			
		})
	},
	modify: function(){
		if(myGrid.selectedRow.length <= 0){
			//alert("선택된 항목이 없습니다.")
			//return;
		}
		if (!confirm("색상,RGB 정보를 수정하시겠습니까?")) {
        	return;
	    } else {
	    	/*let keys = [];
	    	for(let i=0;i<myGrid.selectedRow.length;i++){
	    		keys.push(myGrid.list[myGrid.selectedRow[i]].PUM_CODE);
	    	}*/
	    	let color = $('#txtColor').val()
	    	let rgb = $('#txtRgb').val()
	    	let pumCd = $('#txtPumCd').val()
	    	
	    	if(rgb == 'rgba(0, 0, 0, 0)')rgb = 'rgb(255,255,255)';
	    	
	    	$.ajax({
	    		type : 'post',
	    		url : "/admin/img/initUpdate.json",
	    		data : JSON.stringify({type:'upt',color:color,rgb:rgb,pumCd:pumCd}),
	    		dataType : 'json',   	           
	    		success : function(res){
	    			console.log(res)
	    			location.reload()
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
	},
	deleteImg: function(){
		if (!confirm("이미지를 초기화합니다. 계속하시겠습니까?")) {
        	return;
	    } else {
	    	/*let keys = [];
	    	for(let i=0;i<myGrid.selectedRow.length;i++){
	    		keys.push(myGrid.list[myGrid.selectedRow[i]].PUM_CODE);
	    	}*/
	    	
	    	let pumCd = $('#txtPumCd').val()
	    	$.ajax({
	    		type : 'post',
	    		url : "/admin/img/initUpdate.json",
	    		data : JSON.stringify({type:'del',pumCd:pumCd}),
	    		dataType : 'json',   	           
	    		success : function(res){
	    			console.log(res)
	    			location.reload()
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
	},
	moveToUpload: function(){
		location.href = "/admin/img/manage.do";
	}
}	 
  
$(document).ready(fnObj.pageStart);
</script>
   
</head>
<body>
<div id="loading-indicator"></div>
<div id="loading-indicator-back"></div>
<div id="imageModalContent"  >
	<img id="imageModalArea" />
	<div style="display:none;">
		<span class="swatch colorLightVibrant" style="margin:3px;"></span>
		<span class="swatch colorLightVibrant" style="margin:3px;"></span>
		<span class="swatch colorLightVibrant" style="margin:3px;"></span>
		<span class="swatch colorLightVibrant" style="margin:3px;"></span>
		<span class="swatch colorLightVibrant" style="margin:3px;"></span>
		<span class="swatch colorLightVibrant" style="margin:3px;"></span>
		<span class="swatch colorLightVibrant" style="margin:3px;"></span>
		<span class="swatch colorLightVibrant" style="margin:3px;"></span>
		<span class="swatch colorLightVibrant" style="margin:3px;"></span>
		<span class="swatch colorLightVibrant" style="margin:3px;"></span>
		<span class="swatch colorLightVibrant" style="margin:3px;"></span>
		<span class="swatch colorLightVibrant" style="margin:3px;"></span>
		<span class="swatch colorLightVibrant" style="margin:3px;"></span>
		<span class="swatch colorLightVibrant" style="margin:3px;"></span>
		<span class="swatch colorLightVibrant" style="margin:3px;"></span>
		<span class="swatch colorLightVibrant" style="margin:3px;"></span>
		<span class="swatch colorLightVibrant" style="margin:3px;"></span>
		<span class="swatch colorLightVibrant" style="margin:3px;"></span>
		<span class="swatch colorLightVibrant" style="margin:3px;"></span>
		<span class="swatch colorLightVibrant" style="margin:3px;"></span>
		<span class="swatch colorLightVibrant" style="margin:3px;"></span>
		<span class="swatch colorLightVibrant" style="margin:3px;"></span>
		<span class="swatch colorLightVibrant" style="margin:3px;"></span>
		<span class="swatch colorLightVibrant" style="margin:3px;"></span>
	</div>
	<div  style="display: none;"  class="hw_infouse_01">
		<label class="hw_item_search_title">품목</label>&nbsp;
		<input class="AXInput" id="disMok" disabled  value=""  style="color: black;"  aria-label="Color Input" aria-describedby="inputGroup-color-sm">
		<label class="hw_item_search_title">품종</label>&nbsp;
		<input class="AXInput" id="disJong"  disabled  value=""  style="color: black;"  aria-label="Color Input" aria-describedby="inputGroup-color-sm">
		<label class="hw_item_search_title">색상</label>&nbsp;
		<input class="AXInput" id="txtColor" style=""  aria-label="Color Input" aria-describedby="inputGroup-color-sm">
		<input type="hidden" id="txtRgb" value="">
		<input type="hidden" id="txtPumCd" value="">
		<input type="button" class="AXButton" id="updateBtn"  onclick="fnObj.modify();"  value="수정">
		<input type="button" class="AXButton" id="deleteBtn"  onclick="fnObj.deleteImg();"  value="삭제">
	</div>
</div>
<%@ include file="/WEB-INF/inc/IncHeader.jsp" %>
<article>
<div class="wrap">

	<%@ include file="/WEB-INF/jsp/inc/IncMenu.jsp" %>

	<div class="hw_content"><!--컨텐츠 내용들어가는곳 시작-->
	
		<h3 class="hw_h3_ma"><span class="half_title">이미지 조회</span></h3>
		<div class="hw_clear"></div>	
			
		<div class="hw_infouse_01">  <p> <span class="purple"> ◎ 이용안내 :</span> 이미지 업로드이후 결과 확인 및 관리용도</p></div>
		
		<div style="margin-bottom:10px; margin-top:10px;">	
			<div class="selectWrap">
				품목명
				<input type="text" id="searchMokNm" name="searchMokNm" class="AXInput"/>
				품종명
				<input type="text" id="searchJongNm" name="searchJongNm" class="AXInput"/>
				색상
				<input type="text" id="searchColorNm" name="searchColorNm" class="AXInput"/>
				<input type="button" class="AXButton" id="btn1" value="검색" onclick="fn_search();"/>
			</div>
		</div>
		
		<div class="hw_clear"></div>
						
		<div style="margin-top:20px; margin-bottom:10px;">
			<div class="hw_clear"></div>
			<div class="hw_ma_grid">
				<div id="AXGridTarget" style="height:400px;"></div>
		 	</div>
		</div>
		<input style="display:none;float:right;width: 32.7%;height: 40px;font-size: 16px;line-height: 38px;color: white;background-color: blue;text-align: center;font-weight: bold;margin-right: 0%;" type="button" value="업로드화면" onclick="fnObj.moveToUpload();">
		<input style="display:none;float:right;width: 32.7%;height: 40px;font-size: 16px;line-height: 38px;color: white;background-color: #00582E;text-align: center;font-weight: bold;margin-right: 1%;" type="button" value="이미지초기화" onclick="fnObj.modify();">
 	</div>
 	
</div><!--wrap 끝-->


</article>

<div class="hw_clear"></div>
<footer>
<%@ include file="/WEB-INF/inc/IncFooter.jsp" %>
</footer>
</body>
</html>