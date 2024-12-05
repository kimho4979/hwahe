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
<title>모니터요원 입력시스템-그룹관리</title>
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
  
  <script type="text/javascript">
var myProgress = new AXProgress();
var myGrid = new AXGrid();
var myGrid1 = new AXGrid();
var myModal = new AXModal();

function grid_ajax(){   
	$.ajax({
	    type : 'post',
	    url : "/menuMgt/groupManageMentList.json",
	    data : {},
	    dataType : '',   	           
	    success : function(res){
	    	var val = res.list;
	    	myGrid.setList(val);
	    },
	});      	    
};
   
var fnObj = {
    pageStart: function(){
    	//CHUL_NO="${SESSION_CMP_CODE}";
     
    	// $('input[type=radio]').bindChecked();
        myModal.setConfig({
				windowID:"myModalCT", width:1150,
				displayLoading:true,
	            scrollLock: false,
				onclose: function(){
				//toast.push("저장되었습니다.");	
				grid_ajax();
			}
		}); 
        myModal.setWidth("100%");
        
     	// 검색 조건 Default Date 설정 시작
    	var date = new Date();
    	var year = date.getFullYear();
    	
        var month = date.getMonth()+1;
        month = month > 9 ? month : '0'+month;
        
        var byear = date.getFullYear();
        var bmonth = date.getMonth();
        if(bmonth==0){
        	bmonth=12;
        	byear = byear-1;
        }
        bmonth = bmonth > 9 ? bmonth : '0'+bmonth;
        
        var day = date.getDate();
        day = day > 9 ? day : '0'+day;
        
        var dt = year + "-" + month + "-" + day;
        var bdt = byear + "-" + bmonth + "-" + day;
        
        //var rd1 = $('#REG_DATE1').val(bdt);
        //var rd2 = $('#REG_DATE2').val(dt);
    	grid_ajax();
    	
    	myGrid.setConfig({
			targetID : "AXGridTarget",
			theme : "AXGrid",
			fixedColSeq : '',
			fitToWidth:false,
			colGroup : [
				{key:"no", label:"checkbox", width:"30", align:"center", formatter:"checkbox", 
				    disabled:function(){
				        return false;
				        return (this.index % 2 != 0);
				    },
				    checked:function(){
				        return false;
				        return (this.index % 2 == 0);
				    }
				},
				{key:"groupCd", label:"그룹순번", width:"80", align:"center", pk:true},
				{key:"groupNm", label:"그룹명", width:"*", align:"center"}, 
				{key:"useYn", label:"사용여부", width:"80", align:"center"},
				{key:"regDt", label:"등록일자", width:"100", align:"center"},
				{key:"regId", label:"등록자", width:"100", align:"center"},
				{key:"uptDt", label:"수정일자", width:"100", align:"center"},
				{key:"uptId", label:"수정자", width:"100", align:"center"}
			],
			colHeadAlign:"center",
			body : {
				onclick: function(){
					var gridData = "groupCd="+this.item.groupCd;
					fnObj.modalOpen(gridData);
				},
				ondblclick: function(){},
				oncheck: function(){}
			},
			page:{
			    paging:false
			}
		}); 
    }, //pageStart
	modalOpen: function(gridData){
		myModal.open({
			type: "GET",
			url:"/menuMgt/groupManageMent_popup.do",				
			pars:("&"+gridData).queryToObject(),
			top: 50,
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
	getCheckedList: function(){
	    	
	    var checkedList = myGrid.getCheckedList(0);// colSeq
	    
	    if(checkedList.length == 0){
	        alert("선택된 목록이 없습니다. 삭제하시려는 목록을 체크하세요");    
	        return;
	    }
	   
	    if(!confirm("정말 삭제 하시겠습니까?")) return;        	
	   	 var obj2=checkedList;
	        var deleteValue = [];
	    $.each(obj2,function(key,value) {
	    	deleteValue += (value.groupCd+'!');
	    });
	    $.ajax({
	        type : 'post',
	        url : "/menuMgt/deleteGroupMenuInput.json",
	        data :deleteValue,
	        dataType : '',   	           
	        success : function(res){                   	 
				alert('삭제되었습니다');
				grid_ajax();
	        }
	    }); 
	    
	},
	removeList: function(){
	    var checkedList = myGrid.getCheckedList(0);// colSeq
	    alert(checkedList);
	    if(checkedList.length == 0){
	        alert("선택된 목록이 없습니다. 삭제하시려는 목록을 체크하세요");    
	        return;
	    }
	    if(!confirm("정말 삭제 하시겠습니까?")) return;
	    
	    /// something do for server
	    
	    var removeList = [];
	    $.each(checkedList, function(){
	        removeList.push({no:this.no});
	    });
	    myGrid.removeList(removeList); // 전달한 개체와 비교하여 일치하는 대상을 제거 합니다. 이때 고유한 값이 아닌 항목을 전달 할 때에는 에러가 발생 할 수 있습니다.
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
	
<h3 class="hw_h3_ma"><div class="half1_white"></div><span class="half_title">그룹관리</span></h3>
<div class="hw_clear"></div>	
	
<div class="hw_infouse_01">  <p> <span class="purple"> ◎ 이용안내 :</span> 글을 작성하시려면 등록하기를 누르셔서 작성하시면 됩니다.</p></div>
<div class="hw_clear"></div>	
<div class="ma_btn_allbox">
		<button class="ma_add" type="button" value="등록하기" onclick="fnObj.modalOpen();">등록하기</button>
		<button class="ma_del" type="button" value="삭제하기" onclick="fnObj.getCheckedList();">삭제하기</button>
		<button class="ma_re" type="button" value="새로고침" onclick="grid_ajax();">새로고침</button>
</div>

<div style="width:600px; margin-bottom:10px;">
</div>

<div class="hw_clear"></div>


<div class="hw_ma_grid">
 <div id="AXGridTarget" style="height:400px;"></div>
 <!-- <br/>
 <div id="AXGridTargetAll" style="height:400px;"></div> -->
</div><!--wrap 끝-->


</article>

<div class="hw_clear"></div>
<footer>
<%@ include file="/WEB-INF/inc/IncFooter.jsp" %>
</footer>
</body>
</html>