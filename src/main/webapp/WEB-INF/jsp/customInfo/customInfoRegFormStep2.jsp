<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8"/>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, user-scalable=no"/>
	<meta name="apple-mobile-web-app-title" content="화훼유통정보시스템"/>
	<meta name="robots" content="no-index,follow"/>
	<meta name="og:title" content="화훼유통정보시스템"/>
	<meta name="og:description" content="화훼유통정보시스템"/>
	<meta name="description" content="정보수정">
	<meta name="content" content="화훼유통정보시스템 입니다."/>
	<meta name="keywords" content="화훼경매시세, 화훼경매가격, Korea aT flower market auction price, 화훼공판장, 화훼거래정보, 꽃시장, 꽃값">
	<meta name="Author" content="화훼유통정보시스템 & www.woorim.co.kr"/>
	<title>정보수정</title>
	<%@include file="../common/2020/commonJs.jsp" %>
	<%@include file="../common/2020/commonCss.jsp" %>
	
	<script type="text/javascript">
		var arrLoc= [];
		var arrFlowerCd=[];
		var arrItemCd=[];
		var arrItemCd1=[];
		var arrSeq = [];
		var index=0;
		
		$(document).ready(function(){
			// 검색 selectbox
			$('#ITEM_CD').select2();
			// 검색 selectbox
			$('#ITEM_CD2').select2();
			
			getCumtomInfoMs();
		});
		
		function getCumtomInfoMs(){
			var userId = '${sessionScope.userId}';
			$('#userId').val(userId);
			
			$.ajax({
				type : 'post',
				url : "/customInfo/getCustomInfoMs.json",
				data :  "userId="+userId,
				dataType : 'json',
				success : function(res){
					var val = res.list;

					var realTime = val[0].realTime;
					$("#realTime option[value="+realTime+"]").attr("selected", "selected");
					$("#realTimeLabel").text(realTime);
					$("#realCnt").val(val.length);
					
					for(var i=0; i<val.length; i++){
						var realYn = val[i].realYn;
						var sidoCode = val[i].sidoCode;
						var flowerCd = val[i].flowerCd;
						var itemCd = val[i].itemCd;
						var itemCd1 = val[i].itemCd1;
						var seq = val[i].seq;
												
						if(realYn != 'N'){
							$("#realYn").parent().addClass("checked");
							$("#realYn").attr("checked", "checked");
							
							$("#realTime").removeAttr('disabled');
							$("#sidoCd").removeAttr('disabled');
							$("#flowerCd").removeAttr('disabled');
							$("#ITEM_CD").removeAttr('disabled');
							$("#ITEM_CD2").removeAttr('disabled');
							$("#realYn").val("Y");
						}else{
							$("#realYn").parent().removeClass();
							$("#realTime").val("0").attr("selected","selected");
						}
						
						if(seq != "" && seq != null&&val[i].flowerCd!=null){
							var sidoCode = val[i].sidoCode;
							var flowerCd = val[i].flowerCd;
							var itemCd = val[i].itemCd;
							var itemCd1 = val[i].itemCd1;
							var seq = val[i].seq;
							
							var loc = sidoCode;
							var flowerTxt = $("#flowerCd > option[value="+flowerCd+"]").text();							
							
							var itemNm = itemCd;
							var itemNm1 = itemCd1;
							
							arrLoc.push(loc);
							arrFlowerCd.push(flowerCd);
							arrItemCd.push(itemNm);
							
							if(itemNm1=='' || itemNm1==null){
								itemNm1="전체";
							}
							arrItemCd1.push(itemNm1);
							arrSeq.push(seq);
							
							var locText='전체';
							if(loc=='0000000001'){
								locText='aT화훼공판장(양재동)';
							} else if(loc=='1508500020'){
								locText='부산화훼공판장(엄궁동)';
							} else if(loc=='6068207466'){
								locText='부산경남화훼농협(강동동)';
							} else if(loc=='4108212335'){
								locText='광주원예농협(풍암)';
							} else if(loc=='3848200087'){
								locText='한국화훼농협(음성)';
							} else if(loc=='1288202296'){
								locText='한국화훼농협(과천)';
							}
							
							var txt = locText+"/" + flowerTxt + "/" + itemNm+ "/" +itemNm1;
							//$(".saveList").append("<li id='"+seq+"'><span>"+txt+"</span><button class='btnClose' type='button' onclick='pumCancel(\""+seq+"\");'>취소</button></li>");
							$(".saveList").append("<tr id='"+seq+"'><td class='tc'><p>"+locText+"</p></td><td class='tc'><p>"+flowerTxt+"</p></td><td class='tc'><p>"+itemNm+"</p></td><td class='tc'><p>"+itemNm1+"</p></td><td class='tc'><button type='button' class='btn_type_03' onclick='pumCancel(\""+seq+"\");'>삭제</button></td>	</tr>");
						}
					}
				}
			});
			
			getPumName();
		}
		
		function realYnChk(chk){
			if(chk.checked){				
				$("#realTime").removeAttr('disabled');
				$("#sidoCd").removeAttr('disabled');
				$("#flowerCd").removeAttr('disabled');
				$("#ITEM_CD").removeAttr('disabled');
				$("#ITEM_CD2").removeAttr('disabled');
				$("#realYn").val('Y');
				getPumName();
			}else{
				if(!confirm('실시간 경매정보 데이터가 사라집니다.')){
					$("#realYn").val('Y');
					$("#realYn").parent().addClass("checked");
					$("#realYn").prop('checked',true);						
					return;
				}
				$("#realTime").prop('disabled','disabled');
				$("#realTime").val('0');
				$("#LabelRealTime").text('0');
				$("#sidoCd").prop('disabled','disabled');
				$("#sidoCd").val('0000000001');
				$("#labelSidoCd").text('aT화훼공판장(양재동)');
				$("#flowerCd").prop('disabled','disabled');
				$("#flowerCd").val('1');
				$("#labelFlowerCd").text('절화');
				$("#ITEM_CD").prop('disabled','disabled');
				$("#ITEM_CD2").prop('disabled','disabled');
				getPumName();
				
				$(".saveList").html('');
				arrLoc= [];
				arrFlowerCd=[];
				arrItemCd=[];
				arrItemCd1=[];
				
				$("#realYn").val('N');
			}
		}
		
		// 다중저장
		function setSelectBox(){
			var loc = $("#sidoCd option:selected").val()			// 공판장선택
			var locText = $("#sidoCd option:selected").text();		// 공판장명 
			var flowerCd = $("#flowerCd option:selected").val();	// 품종선택
			var flowerTxt = $("#flowerCd option:selected").text();	// 품종선택
			var itemNm = $("#ITEM_CD option:selected").val();		// 품목명
			var itemNm1 = $("#ITEM_CD option:selected").text();		// 품목명
			var itemNm2 = $("#ITEM_CD2 option:selected").val();		// 품목명
			var itemNm3 = $("#ITEM_CD2 option:selected").text();	// 품목명		
			
			
			if(itemNm==undefined || itemNm==''){
				alert('품목을 선택하세요.');
				return;
			}

			var cnt = $("#realCnt").val();
			cnt = parseInt(cnt)+1;
			
			if(cnt > 10){
				alert('설정정보는 10개까지 가능합니다.');
				return;
			}
			
			
			var checkCnt=0;
			
			for(var i=0; i<arrLoc.length; i++){
				if(arrLoc[i]==loc && arrFlowerCd[i]==flowerCd && arrItemCd[i]==itemNm && arrItemCd1[i]==itemNm2) {					
					checkCnt++;
				}
			}
			
			if(checkCnt>0){
				alert('이미 등록된 정보입니다.');
				return;
			}
			
			$("#realCnt").val(cnt);
			
			arrLoc.push(loc);
			arrFlowerCd.push(flowerCd);
			arrItemCd.push(itemNm);
			
			if(itemNm2=='' || itemNm2==null){
				itemNm2="전체";
			}
			arrItemCd1.push(itemNm2);
			arrSeq.push(seq);
			
			var txt = locText+"/" + flowerTxt + "/" + itemNm1+ "/" + itemNm3;
			//$(".saveList").append("<li id='"+cnt+"'><span>"+txt+"</span><button class='btnClose' type='button' onclick='pumCancel(\""+cnt+"\");'>취소</button></li>");
			$(".saveList").append("<tr id='"+cnt+"'><td class='tc'><p>"+locText+"</p></td><td class='tc'><p>"+flowerTxt+"</p></td><td class='tc'><p>"+itemNm1+"</p></td><td class='tc'><p>"+itemNm3+"</p></td><td class='tc'><button type='button' class='btn_type_03' onclick='pumCancel(\""+cnt+"\");'>삭제</button></td></tr>");
			
		}
		
		function pumCancel(txt){
			
			var index = arrSeq.indexOf(txt);
			arrLoc.splice(index,1);
			arrFlowerCd.splice(index,1);
			arrItemCd.splice(index,1);
			arrItemCd1.splice(index,1);
			arrSeq.splice(index,1);
			$("#"+txt).remove();
			var cnt = $("#realCnt").val();
			cnt = parseInt(cnt)-1;
			$("#realCnt").val(cnt);
		}
		
		
		/* 사용자 저장 */
		function saveCustomInfo(){
			
			$("#arrLoc").val(arrLoc);
			$("#arrFlowerCd").val(arrFlowerCd);
			$("#arrItemCd").val(arrItemCd);
			$("#arrItemCd1").val(arrItemCd1);
			$("#arrSeq").val(arrSeq);
			$("#useYn").val("Y");
			
			var checkbox = $("input[type='checkbox']");
			// updateCustomInfo
			
			checkbox.each(
				function(){
					if(this.checked){
						this.value="Y";
					}else{
						this.checked = true;
						this.value="N";
					}
				}		
			);
			
			$.ajax({
				type : 'get',
				url : "/customInfo/updateCustomInfo.json",
				data :  $("#actionForm").serialize(),
				dataType : 'json',   	           
				success : function(res){
					
					$(location).attr('href', "/customInfo/customInfoSuccess.do");
					
				},
			});     
		}
		
		function cancel(){
			var url = "/main/flowerMain.do";
			if(confirm("페이지의 정보가 사라집니다. 페이지를 이동하시겠습니까?") == true){
				$(location).attr('href',url);	
			}
		}
		
		function captureReturnKey(e) {
		    if(e.keyCode==13 && e.srcElement.type != 'textarea')
		    return false;
		}
		
		function getPumName(){
			$.ajax({
				type : 'post',
				url : "/customInfo/getPumName.json",
				data :  "flowerCd="+$("#flowerCd").val()+"&cmpCd="+$("#sidoCd").val(),
				dataType : 'json',   	           
				success : function(res){
					if(res.pumName.length > 0){
						$("#ITEM_CD").html('');
						$("#labelItemCd").text('선택');
						$("#ITEM_CD").append("<option value=''>선택</option>");	
						for(var i=0; i< res.pumName.length; i++){
							$("#ITEM_CD").append("<option value='"+res.pumName[i]+"'>"+res.pumName[i]+"</option>");	
						}
					}else{
						$("#ITEM_CD").html('');
						$("#labelItemCd").text('품목없음');
					}
				}
	       });	
		}
		
		function getGoodName(){
			$.ajax({
				type : 'post',
				url : "/customInfo/getGoodName.json",
				data :  "flowerCd="+$("#flowerCd").val()+"&cmpCd="+$("#sidoCd").val()+"&itemCd="+$("#ITEM_CD").val(),
				dataType : 'json',   	           
				success : function(res){
					if(res.goodName.length > 0){
						$("#ITEM_CD2").html('');
						$("#labelItemCd2").text('전체');
						$("#ITEM_CD2").append("<option value=''>전체</option>");	
						for(var i=0; i< res.goodName.length; i++){
							$("#ITEM_CD2").append("<option value='"+res.goodName[i]+"'>"+res.goodName[i]+"</option>");	
						}
					}else{
						$("#ITEM_CD2").html('');
						$("#labelItemCd2").text('품종없음');
					}
					}
	       });	
		}
		
		function goUrl1(){
			var url = "/customInfo/mainInfoModForm.do?type=1";    
			$(location).attr('href',url);
		}
		
		function goUrl2(){
			var url = "/customInfo/mainInfoModForm.do?type=2";    
			$(location).attr('href',url);
		}
		
	</script>
</head>
<body>
	<!--WRAP(S)-->
	<div class="wrap">
		 
		<jsp:include page="../inc/2020/IncHeader.jsp"/>	

		<!--콘텐츠_메인(S)-->
		<div class="conts_main">
			<div class="conts_main_in">

				<!-- 서브타이틀(S) -->
				<div class="log_title_box">
					<h2 class="log_tit">정보수정</h2>
					<p class="log_sant">화훼유통정보 홈페이지 회원가입을 환영합니다.</p>
				</div>
				<!-- 서브타이틀(E) -->

				<!-- 탭버튼(S) -->
				<div class="tab_btn devide_2">
					<ul>
						<li><a href="#" onclick="javascript:goUrl1()">자주 찾는 품목관리</a></li>
						<li class="on"><a href="#">가격문자 알림서비스</a></li>
					</ul>
				</div>
				<!-- 탭버튼(E) -->

				<!-- 타이틀(S) -->
				<div class="tit_box_02">
					<div class="fl">
						<h3 class="sub_title_01">가격문자 알림 서비스 설정 (실시간경매정보)</h3>
					</div>
				</div>
				<!-- 타이틀(E) -->

				<!-- 텍스트(S) -->
				<div class="tit_box_02">
					<div class="fl">
						<p class="notice_01">절화, 난, 관엽, 춘란 품목에 대한 min, max 경락가격을 확인하실 수 있습니다. </p>
						<p class="notice_01">가격문자 알림 서비스 설정은 최소 1개 (필수) 최대 10개까지 선택 가능 합니다.</p>
					</div>
				</div>
				<!-- 텍스트(E) -->
				
				<form id="actionForm" name="actionForm" method="post" action="/customInfo/customInfoSuccess.do">
				<input type="hidden" name="chkDupId" id="chkDupId" value="N">
				<input type="hidden" name="chkAuthCode" id="chkAuthCode" value="N">
				<input type="hidden" name="arrLoc" id="arrLoc">
				<input type="hidden" name="arrFlowerCd" id="arrFlowerCd">
				<input type="hidden" name="arrItemCd" id="arrItemCd">
				<input type="hidden" name="arrItemCd1" id="arrItemCd1">
				<input type="hidden" name="arrSeq" id="arrSeq">
				<input type="hidden" name="useYn" id="useYn">
				<input type="hidden" name="genNum" id="genNum">
				<input type="hidden" name="userId" id="userId">
				<input type="hidden" name="seq" id="seq">
				<input type="hidden" name="realCnt" id="realCnt" value="0">
				
				<!-- 테이블(S) -->
				<div class="column devide_2">
					<div>
						<table class="table_type_01">
							<caption>가격문자 알림 서비스 설정</caption>
							<colgroup>
								<col style="width:30%">
								<col style="width:70%">
							</colgroup>
							<tbody>
								<tr>
									<th>수신여부</th>
									<td>
										<input type="checkbox" name="realYn" id="realYn" value="N" onclick="realYnChk(this)" />
										<label for="realYn" class="title_box_chk space"><span></span><em class="txt">수신여부</em></label>										
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div>
						<table class="table_type_01">
							<caption>makingId</caption>
							<colgroup>
								<col style="width:30%">
								<col style="width:70%">
							</colgroup>
							<tbody>
								<tr>
									<th>전송시간설정</th>
									<td>
										<select class="select sign_02" id="realTime" name="realTime" disabled="disabled">
											<option value="01" selected="selected">1</option>
											<option value="02">2</option>
											<option value="03">3</option>
											<option value="04">4</option>
											<option value="05">5</option>
											<option value="06">6</option>
											<option value="07">7</option>
											<option value="08">8</option>
											<option value="09">9</option>
											<option value="10">10</option>
											<option value="11">11</option>
											<option value="12">12</option>
											<option value="13">13</option>
											<option value="14">14</option>
											<option value="15">15</option>
											<option value="16">16</option>
											<option value="17">17</option>
											<option value="18">18</option>
											<option value="19">19</option>
											<option value="20">20</option>
											<option value="21">21</option>
											<option value="22">22</option>
											<option value="23">23</option>
										</select>
										<label for="realTime"><em class="sel_txt">시</em></label>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<div class="column devide_2">
					<div>
						<table class="table_type_01">
							<caption>makingId</caption>
							<colgroup>
								<col style="width:30%">
								<col style="width:70%">
							</colgroup>
							<tbody>
								<tr>
									<th>공판장 선택</th>
									<td>
										<select class="select sign" name="sidoCd" id="sidoCd"  disabled="disabled" onchange="getPumName()">
											<option value="0000000001" >aT화훼공판장(양재동)</option>
											<option value="1508500020">부산화훼공판장(엄궁동)</option>
											<option value="4108212335">광주원예농협(풍암)</option>
											<option value="3848200087">한국화훼농협(음성)</option>
											<option value="1288202296">한국화훼농협(과천)</option>
										</select>
										<label for="sidoCd"></label>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div>
						<table class="table_type_01">
							<caption>makingId</caption>
							<colgroup>
								<col style="width:30%">
								<col style="width:70%">
							</colgroup>
							<tbody>
								<tr>
									<th>부류선택</th>
									<td>
										<select class="select sign" id="flowerCd" name="flowerCd" onchange="getPumName()" disabled="disabled">
											<option value="1" selected="selected">절화</option>
											<option value="3">난</option>
											<option value="2">관엽</option>
											<option value="4">춘란</option>
										</select>
										<label for="flowerCd"></label>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<div class="column devide_2">
					<div>
						<table class="table_type_01">
							<caption>makingId</caption>
							<colgroup>
								<col style="width:30%">
								<col style="width:70%">
							</colgroup>
							<tbody>
								<tr>
									<th>품목선택</th>
									<td>
										<select class="select sign" id="ITEM_CD" name="ITEM_CD" disabled="disabled" onchange="getGoodName()">
											<option value="" selected="selected">선택</option>
										</select>
										<label for="ITEM_CD"></label>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div>
						<table class="table_type_01">
							<caption>makingId</caption>
							<colgroup>
								<col style="width:30%">
								<col style="width:70%">
							</colgroup>
							<tbody>
								<tr>
									<th>품종선택</th>
									<td>
										<select class="select sign" id="ITEM_CD2" name="ITEM_CD2" disabled="disabled">
											<option value="" selected="selected">전체</option>
										</select>
										<label for="ITEM_CD2"></label>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<!-- 테이블(E) -->					
				
				
				<!-- 버튼박스(S) -->
				<div class="btn_box tc">
					<a href="javascript:void(0);" class="btn_type_02" onclick="setSelectBox();">추가</a>
				</div>
				<!-- 버튼박스(E) -->

				<!-- 타이틀(S) -->
				<div class="tit_box_02">
					
				</div>
				<!-- 타이틀(E) -->

				<!-- 테이블(S) -->
				<table class="table_type_01">
					<caption>noticeTable</caption>
					<colgroup>
						<col style="width:26%">
						<col style="width:15%">
						<col style="width:20%">
						<col style="width:15%">
						<col style="width:24%">
					</colgroup>
					<tbody>
						<thead>
							<tr>
								<th>공판장</th>
								<th>부류</th>
								<th>품목</th>
								<th>품종</th>
								<th>삭제여부</th>
							</tr>
						</thead>
						<tbody class="saveList">
						</tbody>
					</tbody>
				</table>
				<!-- 테이블(E) -->
				
				<!-- 버튼박스(S) -->
				<div class="btn_box tc">
					<a href="javascript:void(0);" class="btn_type_02" onclick="saveCustomInfo();">저장</a>
					<a href="javascript:void(0);" class="btn_type_02" onclick="cancel();">취소</a>
				</div>
				<!-- 버튼박스(E) -->
				</form>
				
			</div>
		</div>
		<!--콘텐츠_메인(E)-->

		<jsp:include page="../inc/2020/IncFooter.jsp"/>
		
	</div>
	<!--WRAP(E)-->
</body>
</html>