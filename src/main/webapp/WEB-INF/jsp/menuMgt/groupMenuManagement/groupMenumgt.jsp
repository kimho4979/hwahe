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
<title>모니터요원 입력시스템-그룹메뉴관리</title>
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

<!-- jsTree Start -->
<link rel="stylesheet" href="/css/jstree/default/style.min.css" />
<script src="/dist/jquery-1.12.1.min.js"></script>
<script src="/dist/jstree.min.js"></script>
<!-- jsTree End -->
  
<script type="text/javascript">
//var myProgress = new AXProgress();
//var myGrid = new AXGrid();
//var myGrid1 = new AXGrid();
//var myModal = new AXModal();

function demo_create() {
	var ref = $('#jstree_demo').jstree(true),
		sel = ref.get_selected();
	if(!sel.length) { return false; }
	sel = sel[0];
	sel = ref.create_node(sel, {"type":"file"});
	if(sel) {
		ref.edit(sel);
	}
};
function demo_rename() {
	var ref = $('#jstree_demo').jstree(true),
		sel = ref.get_selected();
	if(!sel.length) { return false; }
	sel = sel[0];
	ref.edit(sel);
};
function demo_delete() {
	var ref = $('#jstree_demo').jstree(true),
		sel = ref.get_selected();
	if(!sel.length) { return false; }
	ref.delete_node(sel);
};

// jstree 생성
function jstreeMenu(){
	$.ajax({
		type : 'post',
	    url : "/menuMgt/selectMenuMgtList_root.json",
	    data : {},
	    dataType : '',   	           
	    success : function(res){
	    	$('#jstree_demo').jstree({
				"core" : {
					"animation" : 0,
					"check_callback" : true,
					"themes" : { "stripes" : true },
					'data' :res.list
					,"types" : {
						"#" : {
							"max_children" : 1,
							"max_depth" : 4,
							"valid_children" : ["root"]
						},
						"root" : {
							"icon" : "/images/jstree/tree_icon.jpg",
							"valid_children" : ["default"]
						},
						"default" : {
							"valid_children" : ["default","file"]
						},
						"file" : {
							"icon" : "glyphicon glyphicon-file",
							"valid_children" : []
						}
					  },
					  "plugins" : [ "contextmenu", "dnd", "search", "state", "types", "wholerow" ]
				}
		   	}).on('ready.jstree', function(){ $(this).jstree('open_all')});
	    	
	    	// click 이벤트
	    	$('#jstree_demo').on('changed.jstree', function (e, data) {
				//console.log(data.node);
				var chkCd = $("#groupCdChk").val();
				var id = "${SESSION_USER_ID}";
				
				if(chkCd == null || chkCd == ''){
					alert("그룹을 선택 후 메뉴를 추가하십시오.");
				}else if(data.node.original.type != 'file'){
					alert("최하위 메뉴만 추가 하실 수 있습니다.");
				}else{
					var groupCdChk = $("#groupCdChk").val();
					var size = $("#groupMenuList option").length;
			    	for(var i=0; i<size; i++){
			    		var value = $("#groupMenuList option:eq("+[i]+")").val();
			    		if(value == data.node.id){
			    			alert("중복 값이 있습니다.");
			    			return false;
			    		}
			    	}
			    	$("#groupMenuList").append("<option value="+data.node.id+">"+data.node.text+"</option>");
				}
			}).jstree();// create the instance
		}
	});
}

// 그룹 List
function groupList(){
	$.ajax({
		type : 'post',
	    url : "/menuMgt/selectGroupList.json",
	    data : {},
	    dataType : '',   	           
	    success : function(res){
	    	var val = res.list;
	    	
	    	for(var i=0; i<val.length; i++){
	    		var option = $("<option value="+val[i].groupCd+">"+val[i].groupNm+"</option>");
                $('#groupList').append(option);
	    	}
	    }
	});
}

// 그룹메뉴 List
function groupMenuJoinList(value){
	$.ajax({
		type : 'post',
	    url : "/menuMgt/selectGroupMenuJoinList.json",
	    data : {
	    	groupCd : value
	    },
	    dataType : '',   	           
	    success : function(res){
	    	var val = res.list;
	    	$("#groupCdChk").attr("value",value);
	    	$('#groupMenuList').empty();
	    	for(var i=0; i<val.length; i++){
	    		var option = $("<option value="+val[i].menuCd+">"+val[i].menuNm+" ("+val[i].menuSeq+")</option>");
                $('#groupMenuList').append(option);
	    	}
	    }
	});
}

// 그룹메뉴 Delete
function optionClick(value){
	var menuCd = value;
	var groupCd = $("#groupCdChk").val();
	$("#groupMenuList option:selected").on("click", function(){
		$("#groupMenuList option:selected").remove();
	});
}

// 초기화
function refresh(){
	var groupCdChk = $("#groupCdChk").val();
	$.ajax({
		type : 'post',
	    url : "/menuMgt/selectGroupMenuJoinList.json",
	    data : {
	    	groupCd : groupCdChk
	    },
	    dataType : '',
	    success : function(res){
	    	var val = res.list;
	    	
	    	if(groupCdChk == null || groupCdChk == ''){
	    		alert("선택된 그룹이 없습니다.");
	    		return false;
	    	}else{
	    		$('#groupMenuList').empty();
		    	for(var i=0; i<val.length; i++){
		    		var option = $("<option value="+val[i].menuCd+">"+val[i].menuNm+" ("+val[i].menuSeq+")</option>");
	                $('#groupMenuList').append(option);
		    	}
	    	}
	    }
	});
}

// 저장 버튼
function save(){
	var groupCdChk = $("#groupCdChk").val();
	var id = "${SESSION_USER_ID}";
	var size = $("#groupMenuList option").length;
	
	$.ajax({
		type : 'post',
	    url : "/menuMgt/deleteGroupMenuJoinInput.json",
	    data : {
	    	groupCd : groupCdChk
	    },
	    dataType : '',   	           
	    success : function(res){
	    	for(var i=0; i<size; i++){
		    	$.ajax({
					type : 'post',
				    url : "/menuMgt/insertGroupMenuJoinInput.json",
				    data : {
				    	groupCd : groupCdChk,
				    	menuCd : $("#groupMenuList option:eq("+[i]+")").val(),
				    	id : id,
				    	menuSeq : i+1
				    },
				    dataType : '',   	           
				    success : function(res){
				    	var val = res.list;
				    }
				});
	    	}
	    	alert("저장하였습니다.");
	    	groupMenuJoinList(groupCdChk);	
		}
	});
}

// 스크립트 로드
$(function () {
	jstreeMenu();
	groupList();
});
</script>
   
</head>
<body>
<%@ include file="/WEB-INF/inc/IncHeader.jsp" %>
<article>
<div class="wrap">
<%@ include file="/WEB-INF/jsp/inc/IncMenu.jsp" %>


<div class="hw_content"><!--컨텐츠 내용들어가는곳 시작-->
	
<h3 class="hw_h3_ma"><div class="half1_white"></div><span class="half_title">그룹메뉴관리</span></h3>
<div class="hw_clear"></div>	
	
<div class="hw_infouse_01">  
<p> <span class="purple"> ◎ 이용안내 :</span> 글을 작성하시려면 등록하기를 누르셔서 작성하시면 됩니다.</p></div>
<p> - 그룹을 클릭하고 그룹메뉴 우측 리스트에서 매핑할 그룹을 선택한 후 저장하세요.</p>
<p> - 그룹메뉴명을 클릭하시면 삭제됩니다.</p>
<div class="hw_clear"></div>	
<!-- <div class="ma_btn_allbox">
		<button class="ma_add" type="button" value="등록하기" onclick="fnObj.modalOpen();">등록하기</button>
		<button class="ma_del" type="button" value="삭제하기" onclick="fnObj.getCheckedList();">삭제하기</button>
		<button class="ma_re" type="button" value="새로고침" onclick="grid_ajax();">새로고침</button>
</div> -->
<div style="margin-top:20px;">
	<div style="width:30%;height:500px; margin-bottom:20px;float:left;">
		<p> <span class="purple">그룹명</span></p>
		<label class="hw_item_search_title" for="groupList"></label>
		<select name="groupList" id="groupList" class="item_search_select" style="width:250px;height:100%;" onchange="groupMenuJoinList(this.value);" multiple="multiple"></select>
		<br/>
		<button type="button" name="refresh" id="refresh" onclick="javascript:refresh();" value="초기화">초기화</button>
		<button type="button" name="save" id="save" onclick="javascript:save();" value="저장">저장</button>
	</div>
	
	<form name="gmList" id="gmList" method="post">
		<p> <span class="purple">그룹메뉴명</p>
		<input type="hidden" name="groupCdChk" id="groupCdChk" value=""/>
		<div style="width:30%;height:500px; margin-bottom:20px;float:left;">
			<label class="hw_item_search_title" for="groupMenuList"></label>
			<select name="groupMenuList" id="groupMenuList" class="item_search_select" style="width:250px;height:100%;" onchange="optionClick(this.value);" multiple="multiple"></select>
		</div>
		<div class="treeBasic">
			<div id="jstree_demo" class="demo"></div>
		</div>
	</form>
	
</div>

</article>

<div class="hw_clear"></div>
<footer>
<%@ include file="/WEB-INF/inc/IncFooter.jsp" %>
</footer>
</body>
</html>