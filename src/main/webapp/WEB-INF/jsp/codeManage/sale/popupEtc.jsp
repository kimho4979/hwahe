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
<title>품목/품종 코드 등록 창 </title>

<style type="text/css">
	.modalProgramTitle{
		height:relative;line-height:49px;
		color:#282828;font-size:14px;font-weight:bold;
		padding-left:15px;
		border-bottom:1px solid #ccc;
	}
	.modalButtonBox{
		padding:10px;border-top:1px solid #ccc;
	}
</style>  
<!-- @@@@@@@@@@@@@@@@@@@@@@ css begin @@@@@@@@@@@@@@@@@@@@@@ -->
<link rel="stylesheet" type="text/css" href="<c:url value='/rMateChart/rMateChartH5/Assets/Css/rMateChartH5.css' />"/>   
<link rel="stylesheet" type="text/css" href="<c:url value='/axisj/axicon/axicon.min.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/arongi/AXJ.min.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/hw/ma.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/2020/reset.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/2020/common_sub.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/2020/common.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/2020/sub.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/2020/main.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/2020/jquery-ui.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/2020/select2.min.css' />" />

<script type="text/javascript" src="<c:url value='/axisj/jquery/jquery.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/axisj/dist/AXJ.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/axisj/lib/AXUpload5.js' />"></script>
<script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/ax5-polyfill.js' />"></script>
<script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/axjApp.js' />"></script>
<script type="text/javascript" src="<c:url value='/plugin/select2/select2.min.js'/>"></script>

<!-- rMateChartH5 라이센스 시작 --><script type="text/javascript" src="<c:url value='/rMateChart/LicenseKey/rMateChartH5License.js' />"></script><!-- rMateChartH5 라이센스 끝-->  
<!-- 실제적인 rMateChartH5 라이브러리 시작--><script type="text/javascript" src="<c:url value='/rMateChart/rMateChartH5/JS/rMateChartH5.js' />"></script><!-- 실제적인 rMateChartH5 라이브러리 끝-->
<!-- @@@@@@@@@@@@@@@@@@@@@@ css end   @@@@@@@@@@@@@@@@@@@@@@ --> 

<script type="text/javascript">
	var myProgress = new AXProgress();
	var myModal = new AXModal();
	var myUpload = new AXUpload5();
	
	$(document).ready(function(){

		$("#kindCd").select2(); 
		$("#itemCd").select2();
		
		$(".KindAddTextArea").hide();
		$(".ItemAddTextArea").hide();
		$('#addKind').hide();
		
		
		var itemCdV = $('#itemCdV').val();
		console.log("itemCdV = " + itemCdV);
		
		if(itemCdV != null){
			getIntItemList();
			console.log("품목코드불러오기완료");
			getKindList();
		}
		var flowerGubn1=$('#flowerGubn').val();
		console.log("flowerGubn1="+flowerGubn1);
		$("#selectBox").val(flowerGubn1).prop("selected", true);
		
		if($("#itemCdV").val()!='null'){
			$(".ItemKindAddButton").hide();
		}
		if($("#KindAddButton").val()!='')
		$("#itemCd").change(function(){
			console.log("품목을 선택");
			var mob=$("#itemCd option:selected").attr('value2');
			console.log("mob" + mob);
			$("#selectBox").val(mob).prop("selected",true);
			getKindList();
			return false;
		});
		$("#kindCd").change(function(){
			var mob = $("#kindCd option:selected").attr('value2');
			console.log(mob);
			$("#selectBox").val(mob).prop("selected", true);
			return false;
			
			
			
		});

		$(".ItemKindAddButton").click(function(){
			$("#itemCd").html('');
			$('.search_item').hide();
			$('.ItemAddTextArea').show();
			$('.search_kind').hide();
			$('.KindAddTextArea').show();
			$('#addKind').show();
			$('#add2').hide();
		});
		$(".KindAddButton").click(function(){
			$('.search_kind').hide();
			$('.KindAddTextArea').show();
			$('#addKind').show();
			$('#add2').hide();
		});
	});
	
	var fnObj = {
		pageStart: function(){

		},
		form : {
			submit: function(){
				var cmpCd=$('#cmpCd').val();
				var cmpGood=$('#cmpGood').val();
				var flowerCd=$("#selectBox option:selected").attr("value");
				if(flowerCd=='5'){
					alert('분류 정보에서 절화/난/관엽/춘란을 분류해주세요!!');
					return;
				}
				if($('#itemCd option:selected').attr("value") != null){
					var itemCd=$('#itemCd option:selected').attr("value");
					var itemNm=document.getElementById("itemCd").options[document.getElementById("itemCd").selectedIndex].text;
					var kindCd=$('#kindCd option:selected').attr("value");
					var kindNm=document.querySelector('select#kindCd option:checked').text;
					var pumNm=$('#itemNm').val();
					var goodNm=$('#kindNm').val();
				} else {
					var itemCd=$('#itemCd option:selected').attr("value");
					var itemNm=$('#itemNmAdd').val();
					var kindCd=$('#kindCd option:selected').attr("value");
					var kindNm=$('#kindNmAdd').val();
					var pumNm=$('#itemNm').val();
					var goodNm=$('#kindNm').val();
				}
				
				console.log("cmpCd : " + cmpCd);
				console.log("cmpGood : " + cmpGood);
				console.log("flowerCd : " +  flowerCd  );
				console.log("itemCd : " + itemCd);
				console.log("itemNm : " + itemNm);
				console.log("kindCd : " + kindCd);
				console.log("kindNm : " + kindNm);
				console.log("pumNm : " + pumNm);
				console.log("goodNm : " + goodNm);
				
				var frm = document["send-form"];
				if(confirm("등록하시겠습니까?")==true){
					console.log("frm = " + frm);
					$.ajax({
						type:"POST",
						url:"/codeManage/sale/insertInto.json",
						data:{
							cmpCd : cmpCd,
							cmpGood : cmpGood,
							flowerCd : flowerCd,
							itemCd : itemCd,
							itemNm : itemNm,
							kindCd : kindCd,
							kindNm : kindNm,
							pumNm : pumNm,
							goodNm : goodNm
						},
						dataType:'json',
						success:function(res){
							alert('등록되었습니다');
							parent.myModal.close();
						}
					});
				} else {
					return;
				} return false;
			},kindSubmit: function(){
				var flowerGubn = $("#selectBox option:selected").prop("value");
				var flowerCd=$("#flowerCode").val();
				if(flowerGubn==null){
					alert('분류 정보에서 절화/난/관엽/춘란을 분류해주세요!!');
					return false;
				}
				var cmpCd=$('#cmpCd').val();
				var cmpGood=$('#cmpGood').val();
				
				if($('#itemCd option:selected').prop("value")!=null){
					var itemCd=$('#itemCd option:selected').prop("value");
					var itemNm = $('itemCd option:selected').val();
					console.log("item2 : " + itemCd+  itemNm);
				} else {
					
					var itemCd = $('#itemNmAdd').val();
					var itemNm = null;
					console.log("item1 : " + itemCd+  itemNm);
				}
				
				if($('#kindCd option:selected').prop("value")!='' ){
					var kindCd=$('#kindCd option:selected').prop("value");
					var kindNm=$('#kindCd option:selected').val();
					console.log("kind2: " + kindCd+ kindNm);

				} else {
					var kindCd=null;
					var kindNm=$('#kindNmAdd').val();
					console.log("kind1 : " + kindCd+ kindNm);
				}
				
				console.log("cmpCd : " + cmpCd);
				console.log("cmpGood : " + cmpGood);
				console.log("flowerGubn : " + flowerGubn);
				console.log("flowerCd : " +  flowerCd);
				console.log("itemCd : " + itemCd);
				console.log("itemNm : " + itemNm);
				console.log("kindCd : " + kindCd);
				console.log("kindNm : " + kindNm);

				var frm = document["send-form"];
				console.log(kindCd, flowerCd, itemCd);
				$.ajax({
					type:"POST",
					url:"/codeManage/sale/insertIntoKind.json",
					data:{
						cmpCd: cmpCd,
						cmpGood: cmpGood,
						flowerGubn: flowerGubn,
						flowerCd: flowerCd,
						itemCd: itemCd,
						itemNm: itemNm,
						kindCd: kindCd,
						kindNm: kindNm
					},
					dataType:'json',
					success:function(res){
						alert('품종코드가 등록되었습니다. ');
						parent.myModal.close();
					}
				});
			},close:function(){
				if(opener){
					window.close();
				} else if (parent) {
					if(parent.myModal) parent.myModal.close();
				} else {
					window.close();
				}
			}
		},
	}

function getIntItemList() {
	var itemCd = $("#itemCdV").val();
	var flowerGubn = $("#flowerGubn").val();
	var flowerCode = $("#flowerCode").val();
	console.log(itemCd, flowerGubn, flowerCode);
	$("#itemCd").html("");
	$("#itemCd").append("<option value='' selected> 전체 </option>");
	
	$.ajax({
			type:'post'
		,	url : "/codeManage/sale/selectItem.json"
		,	data : {
				itemCd: itemCd,
				flowerGubn : flowerGubn,
				flowerCode : flowerCode
			}
		,	dataType : 'json'
		,	success : function(res){
				if(res.list.length>0){
					for(var i=0;i<res.list.length;i++){
						var chkSelect = '';
						if(itemCd == res.list[i].ITEMCD){chkSelect = 'selected';};
						$("#itemCd").append("<option value='"+ res.list[i].ITEMCD +"'value2='"+res.list[i].FLOWERGUBN+"'"+ chkSelect +">"+res.list[i].ITEMNM+"</option>");
					}
				} 
			
			}
	});
}
function getKindList(){
	if($('#itemCdV').val()=='null'){
		var itemCd=$("#itemCd option:selected").prop("value");
	} else {
		var itemCd=$('#itemCdV').val();
	}
	var flowerGubn = $('#flowerGubn').val();
	var flowerCode=$('#flowerCode').val();

	$("#kindCd").html("");
	$("#kindCd").append("<option value='' selected>전체</option>");
	
	if(itemCd == null){return;}
	
	$.ajax({
		type:'post',
		url:"/codeManage/sale/selectKind.json",
		data:{
			itemCd:itemCd,
			flowerCode:flowerCode,
			flowerGubn:flowerGubn
		},
		dataType:'json',
		success:function(res){
			if(res.klist.length>0){
				for(var i=0;i<res.klist.length;i++){
					var chkSelect='';
					if(kindCd==res.klist[i].KIND_CD){chkSelect='selected';};
					$("#kindCd").append("<option value='"+res.klist[i].KIND_CD+"'value2='"+res.klist[i].FLOWER_GUBN+"'"+chkSelect+">"+res.klist[i].KIND_NM+"</option>");
				}
			} 
		}
	});
}

</script>
<title>item코드 kind코드</title>
</head>
<body>
<article>
	<div>
	<form id="send-form" name="send-form" onsubmit="return false;">
		<div class="hw_clear"/>
		<input type=hidden name="cmpGood" id="cmpGood" value="${CMP_GOOD}"/>
		<input type=hidden name="cmpCd" id="cmpCd" value="${CMP_CD}"/>
		<input type=hidden name="mejang" id="mejang" value="${mejang}"/>
		<input type=hidden name="itemCdV" id="itemCdV" value="${ITEM_CD}"/>
		<input type=hidden name="kindCdV" id="kindCdV" value="${KIND_CD}"/>
		<input type=hidden name="flowerGubn" id="flowerGubn" value="${FLOWER_GUBN}"/>
		<input type=hidden name="flowerCode" id="flowerCode" value="${FLOWER_CODE}"/>
		
		<div class="ma_content">
			<h4 class="hw_h3_ma_01"> 품목/품종 이름</h4>
		</div>
		<div class="hw_clear"/>
		
		<div class="ItemKindAddButton">
			<button id="ItemKindAddButton" name="ItemKindAddButton" class="ma_re">품목/ 품종 새로 추가</button>
		</div>
		<div class="KindAddButton">
			<button id="KindAddButton" name="KindAddButton" class="ma_add_01">품종만 새로 추가</button>
		</div>
		
		<div class="hw_clear"/>
		<h4 class="ma_title">품목이름(ITEM_NM)</h4>
		<div class="hw_clear"/>
		
		<div class="search_item">
			<p class="hw_red">T_INT_ITEM에 들어가있는 품목이름입니다. 매칭할 것이 있다면 선택해서 매칭해주세요</p>
			<select id="itemCd"  name="itemCd" class="form-control except"></select>
		</div>
		
		<div class="hw_clear"/>
		<div class="ItemAddTextArea">
			<input type="text" name="itemNmAdd" id="itemNmAdd" value="505" readonly/>
			<p>품목코드는 505 , 이름은 분류값에 따라서 들어갑니다. </p>
		</div>
 
		<h4 class="ma_title">품종이름(KIND_NM)</h4>
		<div class="hw_clear"/>
		<div class="search_kind">
		<p class="hw_red">T_INT_KIND에 들어가있는 품종이름입니다. 매칭할 것이 있다면 선택해서 매칭해주세요</p>
			<select id = "kindCd" name="kindCd" class="form-control except">
				<option value='' seletcted> 전체 </option>
			</select>
		</div>
		<div class="hw_clear"/>
		<div class="KindAddTextArea">
			<input type="text" name="kindNmAdd" id="kindNmAdd" value="${KIND_NM}"/>
		</div>	
		
		<h4 class="ma_title ">분류 정보</h4>
		<div class="hw_clear"/>
		<div class="hw_infouse_01">
			<select name="selectBox" id="selectBox" width="300px;">
				<option value="5">미분류</option>
				<option value="1">절화</option>
				<option value="2">관엽</option>
				<option value="3">난</option>
				<option value="4">춘란</option>
			</select>
		</div>
		<div id="addKind" >	
			<input type="button" id="addKind" name="addKind" class="ma_add" value="새로추가하는경우" onclick="fnObj.form.kindSubmit();"/> 
		</div>

		<div id="add2">	
			<input type="button" id="add2" name="add2" class="ma_add" type="button" value="기존과 매핑하여 등록" onclick="fnObj.form.submit();"/> 
		</div>
		<div class="hw_clear"/>
		<p class="hw_red">매칭할 것이 없다면, 새로추가 버튼을 눌러주세요. 그런다음 선택한 품목 이름을 넣어주세요</p>

		<div class="hw_clear"/>
		<h4 class="ma_title">선택한 품목이름</h4>
		<div class="hw_clear"/>
		<div class="hw_infouse_01" >
			<input type="itemInsert" name="itemNm" id="itemNm" value='${ITEM_NM}' class="AXInput" readonly />
		</div>
		
		<div class="hw_clear"/>
		<h4 class="ma_title">선택한 품종이름</h4>
		<div class="hw_clear"/>
		<div class="hw_infouse_01" >
			<input type="kindInsert" name="kindNm" id="kindNm" value='${KIND_NM}' class="AXInput" readonly/>
		</div>
	
	</form>	
	</div>
	
		
	</div>
</article>

 </body>
</html>