<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<script type="text/javascript">
$(document).ready(function() {
	$('#START_DT').bindDate({align:"right", valign:"bottom", separator:"-", selectType:"d",  defaultSelectType:"d"});
	$('#END_DT').bindDate({align:"right", valign:"bottom", separator:"-", selectType:"d",  defaultSelectType:"d"});
	
	// 컬러픽커
	$("#EVENT_COLOR").spectrum({
		preferredFormat: "hex",
	    showPaletteOnly: true,
	    togglePaletteOnly: true,
	    togglePaletteMoreText: 'more',
	    togglePaletteLessText: 'less',
	    color: '${detail.EVENT_COLOR}',
	    palette: [
	        ["#000","#444","#666","#999","#ccc","#eee","#f3f3f3","#fff"],
	        ["#f00","#f90","#ff0","#0f0","#0ff","#00f","#90f","#f0f"],
	        ["#f4cccc","#fce5cd","#fff2cc","#d9ead3","#d0e0e3","#cfe2f3","#d9d2e9","#ead1dc"],
	        ["#ea9999","#f9cb9c","#ffe599","#b6d7a8","#a2c4c9","#9fc5e8","#b4a7d6","#d5a6bd"],
	        ["#e06666","#f6b26b","#ffd966","#93c47d","#76a5af","#6fa8dc","#8e7cc3","#c27ba0"],
	        ["#c00","#e69138","#f1c232","#6aa84f","#45818e","#3d85c6","#674ea7","#a64d79"],
	        ["#900","#b45f06","#bf9000","#38761d","#134f5c","#0b5394","#351c75","#741b47"],
	        ["#600","#783f04","#7f6000","#274e13","#0c343d","#073763","#20124d","#4c1130"]
	    ]
	});
	
	
}); 

// 수정 처리
function updateEventProc($frm){
	// 달력확인
	var d1 = new Date($frm.find("#START_DT").val());
	var d2 = new Date($frm.find("#END_DT").val());
	if(d1 > d2){
		alert("종료일은 시작일 이전으로 입력하실수 없습니다.");
		$frm.find("#END_DT").focus();
		return false;
	}
	
	if(!confirm("수정 하시겠습니까?")) return false;
	 
	$.ajax({
          type : 'post',
          url : "/mntr/mce01/updateEventProc.json",
          data : $frm.serialize(),
          success : function(res){               
        	  console.log(res);
	    	   if(res.error){
                   alert(res.error.message);
               }else{
            	   alert(res.result.message);
            	   if(res.result.stat == "1"){
            		   defaultForm();
            	   }
            	   
               }
          },
	});
	
	return false;
}

// 화면초기화
function defaultPage(){
	defaultForm();
}

// 이벤트 삭제
function deleteEventProc(){
	
	if(!confirm("삭제 하시겠습니까?")) return false;
	 
	$.ajax({
		type : 'post',
		url : "/mntr/mce01/deleteEventProc.json",
		data : {
			EVENT_SEQ : $("#eventFrm #EVENT_SEQ").val()
		},
		success : function(res){               
			console.log(res);
			if(res.error){
				alert(res.error.message);
			}else{
				alert(res.result.message);
				if(res.result.stat == "1"){
					defaultForm();
				}
			}
		},
	});
	
}

</script>


<div class="selectWrap mt10">
	<form id="eventFrm" name="eventFrm" method="post" onsubmit="return updateEventProc($(this));">
		<input type="hidden" name="EVENT_SEQ" id="EVENT_SEQ" value="${detail.EVENT_SEQ }"/>
		<div style="margin-bottom: 10px;">
			<ul class="titList3" style="border-bottom: 0px;">
				<li class="th">일정 : </li>
				<li class="td">
					<label class="blind" for="START_DT">날짜 선택</label>
					<input type="text" name="START_DT" id="START_DT" class="AXInput W100" value="${detail.START_DT}" />
					 ~ 
					 <label class="blind" for="END_DT">날짜 선택</label>
					 <input type="text" name="END_DT" id="END_DT" class="AXInput W100" value="${detail.END_DT}" />
				</li>
				<li class="th">색상 :</li>
				<li class="td">
					<label class="blind" for="EVENT_COLOR">색상 선택</label>
					<input type="text" class="AXInput" name="EVENT_COLOR" id="EVENT_COLOR" value="${detail.EVENT_COLOR }" />
				</li>
			</ul>
			<ul class="titList" style="border-top: 0px;">
				<li class="th">행사구분 : </li>
				<li class="td">
					<label><input type="radio" name="EVENT_TYPE" value="1" <c:if test="${detail.EVENT_TYPE eq '1' }">checked="checked"</c:if>/> 교회력 </label>
					<label><input type="radio" name="EVENT_TYPE" value="2" <c:if test="${detail.EVENT_TYPE eq '2' }">checked="checked"</c:if>/> 불교 </label>
					<label><input type="radio" name="EVENT_TYPE" value="3" <c:if test="${detail.EVENT_TYPE eq '3' }">checked="checked"</c:if>/> 전례력(성당) </label>
					<label><input type="radio" name="EVENT_TYPE" value="4" <c:if test="${detail.EVENT_TYPE eq '4' }">checked="checked"</c:if>/> 주말길일(결혼) </label>
					<label><input type="radio" name="EVENT_TYPE" value="5" <c:if test="${detail.EVENT_TYPE eq '5' }">checked="checked"</c:if>/> 기타행사 </label>
				</li>
				<li class="th">행사명 :</li>
				<li class="td">
					<label class="blind" for="EVENT_NM">행사명</label>
					<input type="text" class="AXInput" name="EVENT_NM" id="EVENT_NM" value="${detail.EVENT_NM }" required="required" style="width: 85%;" maxlength="100" />
				</li>
				<li class="th">비고 :</li>
				<li class="td">
					<label class="blind" for="REMARKS">비고</label>
					<input type="text" class="AXInput" name="REMARKS" id="REMARKS" value="${detail.REMARKS }" style="width: 85%;" maxlength="150" />
				</li>
			</ul><!-- titList end  -->
			<div class="ma_btn_allbox">
				<button type="submit" id="btnType" class="ma_add">수정하기</button>
				<button type="button" onclick="deleteEventProc();" class="ma_del">삭제하기</button>
				<button type="button" onclick="defaultPage();" class="ma_re">초기화</button>
			</div>
		</div>
	</form>
</div>