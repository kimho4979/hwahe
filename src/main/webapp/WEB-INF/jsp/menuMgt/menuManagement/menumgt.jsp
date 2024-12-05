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
<title>모니터요원 입력시스템-메뉴관리</title>
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
<script type="text/javascript"  src="/dist/jquery-1.12.1.min.js"></script>
<script type="text/javascript"  src="/dist/jstree.min.js"></script>
<!-- jsTree End -->
  
<script type="text/javascript">

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


// 하위 메뉴 생성 폼 호출
function menuCreate(){
	var menuCd = $("#menuCd").val();
	if(menuCd == '' || menuCd == null){
		$("#childInsert").hide();
		alert("메뉴를 선택 후 하위메뉴를 추가하십시오.");
	}else{
		$("#childInsert").show();
	}
}

// 메뉴 입력
function menuInsert(){
	var cMenuUpCd = $("#cMenuUpCd").val();
	var cMenuNm = $("#cMenuNm").val();
	var cUseYn = $("#cUseYn").val();
	var id = $("#id").val();
	var cUrl = $("#cUrl").val();
	var cMenuGubn = $("#cMenuGubn").val();
	var menuDepth = $("#menuDepth").val();
	var authGubn = $("#authGubn").val();
	$.ajax({
		type : 'post',
	    url : "/menuMgt/insertMenuInput.json",
	    data : {
	    	cMenuUpCd : cMenuUpCd,
	    	cMenuNm : cMenuNm,
	    	cUseYn : cUseYn,
	    	id : id,
	    	cUrl : cUrl,
	    	cMenuGubn : cMenuGubn,
	    	menuDepth : menuDepth,
	    	authGubn  : authGubn
	    },
	    dataType : '',   	           
	    success : function(res){
	    	alert("메뉴가 입력되었습니다.");
	    	$("#childInsert").hide();
	    	location.reload();
	    }
	});
}

// 하위 메뉴 생성 폼 취소
function menuCancel(){
	$("#cMenuCd").val("");
	$("#cMenuUpCd").val("");
	$("#cMenuNm").val("");
	$("#cUseYn").val("Y");
	$("#cMenuGubn").val("1");
	$("#cUrl").val("");
	$("#authGubn").val('');
	$("#childInsert").hide();
}

// 메뉴 수정
function menuUpdate(){
	var menuCd = $("#menuCd").val();
	var menuNm = $("#menuNm").val();
	var useYn = $("#useYn").val();
	var id = $("#id").val();
	var url = $("#url").val();
	var menuGubn = $("#menuGubn").val();
	var menuOrder = $("#menuOrder").val();
	var authGubn = $("#authGubn").val();
	if(menuCd != '0'){
		$.ajax({
			type : 'post',
		    url : "/menuMgt/updateMenuInput.json",
		    data : {
		    	menuCd : menuCd,
		    	menuNm : menuNm,
		    	useYn : useYn,
		    	id : id,
		    	url : url,
		    	menuGubn : menuGubn,
		    	menuOrder : menuOrder,
		    	authGubn  : authGubn
		    },
		    dataType : '',   	           
		    success : function(res){
		    	alert("메뉴가 수정되었습니다.");
		    	location.reload();
		    }
		});
	}else{
		alert("이 메뉴는 최상위 메뉴로 수정 할 수 없습니다.");
	}
}

// 메뉴 삭제
function menuDelete(){
	var menuCd = $("#menuCd").val();
	
	if(menuCd != '0'){
		if(confirm("삭제하시겠습니까?")){
			$.ajax({
				type : 'post',
			    url : "/menuMgt/deleteMenuInput.json",
			    data : {
			    	menuCd : menuCd
			    },
			    dataType : '',   	           
			    success : function(res){
			    	alert("메뉴가 삭제되었습니다.");
			    	location.reload();
			    }
			});
		}
	}else{
		alert("이 메뉴는 최상위 메뉴로 삭제 할 수 없습니다.");
	}
}

// jstree 생성
function jstree(){
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
				var menuCd = data.node.id;
				$("#menuCd").val(menuCd);
				$("#cMenuUpCd").val(menuCd);
				
				var menuUpCd = data.node.parent;
				$("#menuUpCd").val(menuUpCd);
				
				var menuNm = data.node.text;
				$("#menuNm").attr("value",menuNm);
				
				$.ajax({
					type : 'post',
					url : "/menuMgt/selectMenuMgtUseYnList.json",
					data : {
						menuCd : menuCd
					},
					dataType : '',   	           
					success : function(res){
						var val = res.list;
						if(val[0].useYn == "Y"){
							$("#useYn").val("Y").prop("selected",true);
						}else{
							$("#useYn").val("N").prop("selected",true);
						}
						if(val[0].menuGubn == "1"){
							$("#menuGubn").val("1").prop("selected",true);
						}else{
							$("#menuGubn").val("2").prop("selected",true);
						}
						$("#url").attr("value",val[0].menuUrl);
						$("#uptDt").attr("value",val[0].uptDt);
						$("#uptId").attr("value",val[0].uptId);
						$("#menuOrder").attr("value",val[0].menuOrder);
						$("#menuDepth").attr("value",val[0].menuDepth);
					}
				});
			}).jstree();// create the instance
	    			
		} 
	});
}

// 스크립트 로드
$(function () {
	$("#childInsert").hide();
	jstree();
});
</script>
   
</head>
<body>
<%@ include file="/WEB-INF/inc/IncHeader.jsp" %>
<article>
<div class="wrap">
<%@ include file="/WEB-INF/jsp/inc/IncMenu.jsp" %>


<div class="hw_content"><!--컨텐츠 내용들어가는곳 시작-->
	
<h3 class="hw_h3_ma"><div class="half1_white"></div><span class="half_title">메뉴관리</span></h3>
<div class="hw_clear"></div>	
	
<div class="hw_infouse_01">  <p> <span class="purple"> ◎ 이용안내 :</span> 사용자 즐겨찾기 메뉴 추가 시 사용되는 메뉴입니다</p></div>
<div class="hw_clear"></div>	
<!-- <div class="ma_btn_allbox">
		<button class="ma_add" type="button" value="등록하기" onclick="fnObj.modalOpen();">등록하기</button>
		<button class="ma_del" type="button" value="삭제하기" onclick="fnObj.getCheckedList();">삭제하기</button>
		<button class="ma_re" type="button" value="새로고침" onclick="grid_ajax();">새로고침</button>
</div> -->
<div style="margin-top:20px;">
	<div class="treeBasic2">
		<div id="jstree_demo" class="demo"></div>
	</div>
	<div style="width:49%; margin-bottom:20px;float:right">
		<form name="send-form" onsubmit="return false;">
				<div class="hw_clear"></div>
				<input type=hidden id="menuCd" name="menuCd" value=""/>
				<input type=hidden id="menuUpCd" name="menuUpCd" value=""/>
				<input type=hidden id="menuDepth" name="menuDepth" value=""/>
				<input type=hidden id="id" name="id" value="${SESSION_USER_ID}"/>
				
				<div class="hw_clear"></div>
				<h4 class="ma_title">메뉴명</h4> <p class="hw_red">현재 선택된 메뉴명 입니다.</p>
				<div class="hw_clear"></div>
				<div class="hw_infouse_01">
					<label for="hide">메뉴명</label><input name="menuNm" id="menuNm" value="" class="AXInput" />
				</div>
				
				<div class="hw_clear"></div>
				<h4 class="ma_title">사용여부</h4> <p class="hw_red">사용여부를 선택하세요</p>
				<div class="hw_clear"></div>	
				<div class="hw_infouse_01">
					<label class="hw_item_search_title" for="useYn">사용여부</label>
					<select name="useYn" id="useYn" class="item_search_select">
						<option value="Y">활성화</option>
						<option value="N">비활성화</option>
					</select>
				</div>
				
				<div class="hw_clear"></div>
				<h4 class="ma_title">메뉴구분</h4> <p class="hw_red">메뉴구분를 선택하세요</p>
				<div class="hw_clear"></div>	
				<div class="hw_infouse_01">
					<label class="hw_item_search_title" for="menuGubn">메뉴구분</label>
					<select name="menuGubn" id="menuGubn" class="item_search_select">
						<option value="1">관리자</option>
						<option value="2">홈페이지</option>
					</select>
				</div>
				
				<div class="hw_clear"></div>
				<h4 class="ma_title">순번</h4> <!-- <p class="hw_red">현재 선택된 메뉴명 입니다.</p> -->
				<div class="hw_clear"></div>
				<div class="hw_infouse_01">
					<label for="hide">순번</label><input name="menuOrder" id="menuOrder" value="" class="AXInput"/>
				</div>
				
				<div class="hw_clear"></div>
				<h4 class="ma_title">URL</h4> <!-- <p class="hw_red">현재 선택된 메뉴명 입니다.</p> -->
				<div class="hw_clear"></div>
				<div class="hw_infouse_01">
					<label for="hide">URL</label><input name="url" id="url" value="" class="AXInput"/>
				</div>
				
				<div class="hw_clear"></div>
				<h4 class="ma_title">수정일자</h4> <!-- <p class="hw_red">현재 선택된 메뉴명 입니다.</p> -->
				<div class="hw_clear"></div>
				<div class="hw_infouse_01">
					<label for="hide">수정일자</label><input name="uptDt" id="uptDt" value="" class="AXInput" readOnly/>
				</div>
				
				<div class="hw_clear"></div>
				<h4 class="ma_title">수정자</h4> <!-- <p class="hw_red">현재 선택된 메뉴명 입니다.</p> -->
				<div class="hw_clear"></div>
				<div class="hw_infouse_01">
					<label for="hide">수정자</label><input name="uptId" id="uptId" value="" class="AXInput" readOnly/>
				</div>
				
				
				<div class="hw_clear"></div>
				<h4 class="ma_title">권한구분</h4> <p class="hw_red">권한구분를 선택하세요</p>
				<div class="hw_clear"></div>	
				<div class="hw_infouse_01">
					<label class="hw_item_search_title" for="authGubn">권한구분</label>
					<select name="authGubn" id="authGubn" class="item_search_select">
						
						<option value="1">관리자</option>
						<option value="kakao">카카오</option>
						<option value="email">이메일</option>
						
					</select>
				</div>
				
				
				<div class="hw_clear"></div>
				<div><input id="insert" name="insert" class="ma_add"  type="button" value="하위메뉴추가" onclick="menuCreate();" /></div>
				<div>
					<input id="update" name="update" class="ma_del"  type="button" value="수정" onclick="menuUpdate();" />
					<input id="delete" name="delete" class="ma_re"  type="button" value="삭제" onclick="menuDelete();" />
				</div>
				<!-- <button class="AXButton" type="button" onclick="fnObj.form.submit();">저장하기</button> -->
			</form>
			<div id="childInsert">
				<form id="send-form1" name="send-form1" onsubmit="return false;">
					<div class="hw_clear"></div>
					<input type=hidden id="cMenuCd" name="cMenuCd" value=""/>
					<input type=hidden id="cMenuUpCd" name="cMenuUpCd" value=""/>
					
					<div class="hw_clear"></div>
					<h4 class="ma_title">하위메뉴명</h4> <!-- <p class="hw_red">현재 선택된 하위메뉴명 입니다.</p> -->
					<div class="hw_clear"></div>
					<div class="hw_infouse_01">
						<label for="hide">하위메뉴명</label><input name="cMenuNm" id="cMenuNm" value="" class="AXInput" />
					</div>
					
					<div class="hw_clear"></div>
					<h4 class="ma_title">사용여부</h4> <p class="hw_red">사용여부를 선택하세요</p>
					<div class="hw_clear"></div>	
					<div class="hw_infouse_01">
						<label class="hw_item_search_title" for="cUseYn">사용여부</label>
						<select name="cUseYn" id="cUseYn" class="item_search_select">
							<option value="Y">활성화</option>
							<option value="N">비활성화</option>
						</select>
					</div>
					
					<div class="hw_clear"></div>
					<h4 class="ma_title">하위메뉴구분</h4> <p class="hw_red">하위메뉴구분를 선택하세요</p>
					<div class="hw_clear"></div>	
					<div class="hw_infouse_01">
						<label class="hw_item_search_title" for="cMenuGubn">하위메뉴구분</label>
						<select name="cMenuGubn" id="cMenuGubn" class="item_search_select">
							<option value="1">관리자</option>
							<option value="2">홈페이지</option>
						</select>
					</div>
					
					<div class="hw_clear"></div>
					<h4 class="ma_title">URL</h4> <!-- <p class="hw_red">현재 선택된 메뉴명 입니다.</p> -->
					<div class="hw_clear"></div>
					<div class="hw_infouse_01">
						<label for="hide">URL</label><input name="cUrl" id="cUrl" value="" class="AXInput"/>
					</div>

					<div class="hw_clear"></div>
					<div>
						<input id="cInsert" name="cInsert" class="ma_del"  type="button" value="등록" onclick="menuInsert();" />
						<input id="cCancel" name="cCancel" class="ma_re"  type="button" value="취소" onclick="menuCancel();" />
					</div>
					<!-- <button class="AXButton" type="button" onclick="fnObj.form.submit();">저장하기</button> -->
				</form>
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