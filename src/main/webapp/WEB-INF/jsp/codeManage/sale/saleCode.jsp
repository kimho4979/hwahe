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
<title>모니터요원 입력시스템-전송 데이터 코드관리</title>
<!-- @@@@@@@@@@@@@@@@@@@@@@ css begin @@@@@@@@@@@@@@@@@@@@@@ -->
<link rel="stylesheet" type="text/css" href="<c:url value='/rMateChart/rMateChartH5/Assets/Css/rMateChartH5.css' />"/>   
<link rel="stylesheet" type="text/css" href="<c:url value='/axisj/axicon/axicon.min.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/arongi/AXJ.min.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/hw/ma.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/hw/common.css' />" />
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
	endCount = "20";
	grid_ajax();
}
function grid_ajax(){
	$(".loadingWrap").show();
	var searchStartDate = $("#searchStartDate").val();
	var searchEndDate = $("#searchEndDate").val();
	var searchPumNm = $("#searchPumNm").val();
	var searchGoodNm = $("#searchGoodNm").val();
	var searchMejang = $("#searchMejang").val();
	
	$.ajax({
		type : 'post',
		url : "/code/saleCodeList.json",
		data : {
			pageNo2 : pageNo2,
			pageSize : pageSize,
			startCount : startCount,
			endCount : endCount,
			searchStartDate : searchStartDate,
			searchEndDate : searchEndDate,
			searchPumNm : searchPumNm,
			searchGoodNm : searchGoodNm,
			searchMejang : searchMejang
		},
		dataType : '',
		success : function(res){
			console.log(res);
			
			if(res.list.length > 0 ){
				var pageCount2 =  res.list[0].totCount/20;
				var pageRest = res.list[0].totCount%20;
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
						pageNo: res.list2.pageNo2, // 현재페이지
						pageCount: pageResult, // 전체 페이지수
						listCount: res.list[0].totCount // 우측하단 카운트 표시 갯수
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
		$('#searchStartDate').bindDate({align:"right", valign:"bottom", separator:"-", selectType:"d",  defaultSelectType:"d", defaultDate : "rd1",
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
			columns: [
			
			],
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
				{key:"pumName", label:"품목명", width:"100", align:"center"},
				{key:"goodName", label:"품종명", width:"100", align:"center"},
				{key:"cmpCd", label:"법인코드", width:"100", align:"center"},
				{key:"cmpNm", label:"법인명", width:"100", align:"center"},
				{key:"mejang", label:"화훼구분", width:"80", align:"center", formatter:function(){
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
					}
				},
				{key:"itemCd", label:"품목코드", width:"40",align:"center"},
				{key:"itemNm", label:"품목이름", width:"80", align:"center"},
				{key:"kindCd", label:"품종코드", width:"60", align:"center"},
				{key:"kindNm", label:"품종이름", width:"80", align:"center"},
				{key:"flowerGubn1", label:"추천구분값", width:"80", align:"center"},
				{key:"etc", label:" 품목/품종코드추가", width:"80",align:"center", formatter:function(){
					console.log(this.item.sale);
					var etc = '';
					if(this.item.kindCd == null && this.item.txtsale != null){
					etc = '<button id="etc-modal'+this.item.rnum+'" name="etc'+this.item.rnum+'" class="AXButton"  style="width:80%">추가</button>';
					}
					return etc;
				}},
				{key:"flowerGubn", label:"flowerGubn", width:"80", align:"center"},
				{key:"flowerCode", label:"flowerCode", width:"80", align:"center"},
				{key:"txtsale", label:"T_SALE여부", width:"80", align:"center"},
				{key:"txtreal", label:"T_REAL여부", width:"80",align:"center"}
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
							
				}
				
			},
			page:{
				   paging:true,   
				   pageSize:20,
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
		fn_update(0);
	}else{
		alert("저장할 데이터를 체크해주세요");
	}
}


function fn_update(index){
	var chckedUpdateVO = checkedUpdateList[index];
	
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
</script>
   
</head>
<body>
<%@ include file="/WEB-INF/inc/IncHeader.jsp" %>
<article>
<div class="wrap">

	<%@ include file="/WEB-INF/jsp/inc/IncMenu.jsp" %>

	<div class="hw_content"><!--컨텐츠 내용들어가는곳 시작-->
	
		<h3 class="hw_h3_ma"><span class="half_title">전송 데이터 코드 관리</span></h3>
		<div class="hw_clear"></div>	
			
		<div class="hw_infouse_01">  <p> <span class="purple"> ◎ 이용안내 :</span> aT공판장과 타공판장의 품종명을 표준화합니다.</p></div>
		
		<div style="margin-bottom:10px; margin-top:10px;">	
			<div class="selectWrap">
				정산날짜
				 <!-- 
				<input type="text" id="searchStartDate" name="searchStartDate" value="${pRequestParamMap.searchStartDate}" class="AXInput"/>
				-
				<input type="text" id="searchEndDate" name="searchEndDate" value="${pRequestParamMap.searchEndDate}" class="AXInput"/>
				 -->
				 
				<input type="text" id="searchStartDate" name="searchStartDate" value="2020-01-01" class="AXInput"/>
				 -
				<input type="text" id="searchEndDate" name="searchEndDate" value="2020-02-28" class="AXInput"/>
				 
			</div>
		</div>
		
		<div style="margin-bottom:10px; margin-top:10px;">	
			<div class="selectWrap">
				화훼구분
				<select name="searchMejang" id="searchMejang" class="item_search_select">
					<option value="5">미분류</option>
					<option value="1">절화</option>
					<option value="2">관엽</option>
					<option value="3">난</option>
					<option value="4">춘란</option>
				</select>
				품목명
				<input type="text" id="searchPumNm" name="searchPumNm" class="AXInput" onkeypress='if(event.keyCode==13) {fn_search(); return false;}'/>
				품종명
				<input type="text" id="searchGoodNm" name="searchGoodNm" class="AXInput" onkeypress='if(event.keyCode==13) {fn_search(); return false;}'/>
				<input type="button" class="AXButton" id="btn1" value="검색" onclick="fn_search();"/>
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
				<select name="changeMejang" id="changeMejang" class="item_search_select">
					<option value="1" selected="selected">절화</option>
					<option value="2">관엽</option>
					<option value="3">난</option>
					<option value="4">춘란</option> 
					<option value="5">미분류</option>
				</select>
				<input type="button" class="AXButton" id="btn2" value="일괄변경" onclick="fn_change();"/>
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

