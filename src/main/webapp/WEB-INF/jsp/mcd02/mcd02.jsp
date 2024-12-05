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
	<title>모니터요원 입력시스템-행사일정 관리</title>
	<!-- @@@@@@@@@@@@@@@@@@@@@@ css begin @@@@@@@@@@@@@@@@@@@@@@ -->
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

<script type="text/javascript">
var chulno = "0001"
var myProgress = new AXProgress();
var myGrid = new AXGrid();
var myModal = new AXModal();
var SEQ="";
var TITLE="";
var INS_ID="";
var DISP_YN="";
var INS_DT="";
var gridData=[];
var sessionId = null;

var eventGp = null;
var eventYmd = null;
var eventTim = null;
var eventNm = null;
var siNm = null;
var addr = null;
var eventPls = null;

function grid_ajax(){
	var searchDate = $("#searchDate1").val();
	
	$.ajax({
		type : 'post',
		url : "/mntr/mcd02/gridList.json",
		data :  {
			searchDate : searchDate
		},
		dataType : '',   	           
		success : function(res){
			myGrid.setList(res.list);
		},
	});      	    
};

function deleteGrid(){
	
};

var fnObj = {
    pageStart: function(){
    	CHUL_NO="${SESSION_CMP_CODE}";
    	sessionId = '${SESSION_USER_ID}';
    	
    	// 검색 조건 Default Date 설정 시작
    	var date = new Date();
    	var year = date.getFullYear();
    	
        var month = date.getMonth()+1;
        month = month > 9 ? month : '0'+month;
                
        var day = date.getDate();
        day = day > 9 ? day : '0'+day;
        
        var dt = year + "-" + month + "-" + day;
                
        var rd1 = $('#searchDate1').val(dt);
        		
		$('#searchDate1').bindDate({align:"right", valign:"bottom", separator:"-", selectType:"d",  defaultSelectType:"d", defaultDate : "rd1",
			onchange:function(){
				grid_ajax();
			}
    	});
		
    	grid_ajax();
    	    	
    	$('input[type=radio]').bindChecked();
        myModal.setConfig({
			windowID:"myModalCT", width:1150,
			displayLoading:true,
			scrollLock: false,
			onclose: function(){					
				grid_ajax();
			}
		}); 
        myModal.setWidth("100%");

		myGrid.setConfig({
			targetID : "AXGridTarget",
			theme : "AXGrid",
			fixedColSeq : '',
			fitToWidth:true,
			colGroup : [
				{
					key:"no", label:"checkbox", width:"30", align:"center", formatter:"checkbox", disabled:function(){
						return false;
						return (this.index % 2 != 0);
					},
					checked:function(){
						return false;
						return (this.index % 2 == 0);
					}
				},
				{key:"eventGp", label:"구분코드", width:"120", display: false},
				{key:"eventGpNm", label:"구분", width:"80", align:"center", pk:true},                     	                 
				{key:"eventNm", label:"행사명", width:"130"},
				{key:"eventYmd", label:"행사일자",align:"center", width:"80"},                     	                                              
				{key:"eventTim", label:"행사시간", width:"80",align:"center"},
				{key:"siNm", label:"시", width:"90"},
				{key:"addr", label:"상세주소", width:"120"},
				{key:"eventPls", label:"행사장명", width:"120"}
			],
			colHeadAlign:"center",
			body : {
				onclick: function(){
					sessionId = '${SESSION_USER_ID}';
					gridData = 'eventGp='+this.item.eventGp
					         + '&eventNm='+this.item.eventNm
					         + '&eventYmd='+this.item.eventYmd
					         + '&eventTim='+this.item.eventTim
					         + '&siNm='+this.item.siNm
					         + '&addr='+this.item.addr
					         + '&eventPls='+this.item.eventPls;

					fnObj.modalOpen(gridData);
				},
				// checkbox 개체를 click 할때 이벤트 체크
				oncheck: function(){
					
				}
			},
			page:{
				paging:false
			},
			contextMenu: {
				theme:"AXContextMenu", 
				width:"150", 
				menu:[
					{
						userType:1, label:"추가하기", className:"plus", onclick:function(){
							myGrid.appendList(null);
						}
					},
					{
						userType:1, label:"삭제하기", className:"minus", onclick:function(){
							if(this.sendObj){
								if(!confirm("정말 삭제 하시겠습니까?")) return;
									var removeList = [];
									removeList.push({no:this.sendObj.item.no});
									myGrid.removeList(removeList); // 전달한 개체와 비교하여 일치하는 대상을 제거 합니다. 이때 고유한 값이 아닌 항목을 전달 할 때에는 에러가 발생 할 수 있습니다.
							}
						}
					},
					{
						userType:1, label:"수정하기", className:"edit", onclick:function(){
							//trace(this);
							if(this.sendObj){
								myGrid.setEditor(this.sendObj.item, this.sendObj.index);
							}
						}
					}
				],
				filter:function(id){
					return true;
				}
			}
		});
		
		
	},
	modalOpen: function(gridData){
		// 등록하기 팝업
		gridData += "&sessionId="+sessionId;
		myModal.open({    		 
			type: "post",
			url:"/mcd02/mcd02_popup.do",				
			pars:("&"+gridData).queryToObject(),
			top:50,
			closeByEscKey:true
		});
		myModal.setWidth("100%");
	},
	appendGrid: function(index){
		var item = {amount:0};
		if(index == "last") {
			myGrid.appendList(item, myGrid.list.length);
		}else if(typeof index != "undefined"){
			myGrid.appendList(item, index);
		}else{
			myGrid.appendList(item);
		}
	},
	removeList: function(){
		var checkedList = myGrid.getCheckedList(0);// colSeq

		if(checkedList.length == 0){
			alert("선택된 목록이 없습니다. 삭제하시려는 목록을 체크하세요");    
			return;
		}
		if(!confirm("정말 삭제 하시겠습니까?")) return;        	
			
		var obj2=checkedList;
		var deleteValue = [];
		$.each(obj2,function(key,value) {
			deleteValue += (value.eventGp+','+
					        value.eventNm+','+
					        value.eventYmd+','+
					        value.eventTim+','+
					        value.siNm+','+
					        value.addr+','+
					        value.eventPls+','+'!');
		});          
		$.ajax({
			type : 'post',
			url : "/mntr/mcd02/deleteEventSch.json",
			data : deleteValue,
			dataType : '',   	           
			success : function(res){                   	 
				grid_ajax();
			},
		}); 
	}
};

$(document).ready(fnObj.pageStart);

</script>
   
</head>
<body>
<%@ include file="/WEB-INF/inc/IncHeader.jsp" %>
<article>
	<div class="wrap">
		<%@ include file="/WEB-INF/jsp/inc/IncMenu.jsp" %>
	
		<div class="hw_content"><!--컨텐츠 내용들어가는곳 시작-->
			<h3 class="hw_h3_ma"><span class="half_title">행사일정관리</span></h3>
			<div class="hw_clear"></div>	
			<div class="hw_infouse_01"><p><span class="purple"> ◎ 이용안내 :</span> 행사일정을 작성하시려면 등록하기를 누르시면 됩니다.</p></div>
			
			<div style="margin-bottom:10px; margin-top:10px;">	
				<div class="selectWrap">
					기간
					<label class="blind" for="searchDate1">날짜선택하기</label>
					<input type="text" name="searchDate1" id="searchDate1" class="AXInput W100" value="" />					
				</div>
			</div>
	
			<div>
				<div><input class="ma_add"  type="button" value="등록하기" onclick="fnObj.modalOpen();" /></div>
				<div><input class="ma_del"  type="button" value="삭제하기" onclick="fnObj.removeList();" /></div>
				<div><input class="ma_re"  type="button" value="새로고침" onclick="grid_ajax();" /></div>
			</div>
	
			<div class="hw_clear"></div>
	
			<div class="hw_ma_grid">
				<div id="AXGridTarget" style="height:400px;"></div>
			</div> 
		</div>
	</div><!--wrap 끝-->
</article>

<div class="hw_clear"></div>
<footer>
<%@ include file="/WEB-INF/inc/IncFooter.jsp" %>
</footer>
</body>
</html>