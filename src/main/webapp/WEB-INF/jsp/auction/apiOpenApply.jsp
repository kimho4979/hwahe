<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, user-scalable=no">
	<meta name="apple-mobile-web-app-title" content="화훼유통정보시스템">
	<meta name="robots" content="no-index,follow">
	<meta name="og:title" content="화훼유통정보시스템">
	<meta name="og:description" content="화훼유통정보시스템">
	<meta name="description" content="데이터 개방 신청">
	<meta name="content" content="화훼유통정보시스템 입니다.">
	<meta name="keywords" content="화훼경매시세, 화훼경매가격, Korea aT flower market auction price, 화훼공판장, 화훼거래정보, 꽃시장, 꽃값">
	<meta name="Author" content="화훼유통정보시스템 & www.woorim.co.kr">
	<title>데이터 개방 신청</title>
	<%@include file="../common/2020/commonJs.jsp" %>
	<%@include file="../common/2020/commonCss.jsp" %>
	
	<script type="text/javascript">
		var openGubn = null;
		var userId = null;
		var serviceKey = null;
		
		$(function(){
			// api 초기 설정값 로딩
			settingList();
			
			$("input[name=radio01]").click(function(){
				$("input[name=radio02]:checked").parent().addClass("checked");
			});
			
			$("input[name=radio02]").click(function(){
				$("input[name=radio01]:checked").parent().addClass("checked");
			});
			// 사용자정보로딩
			selectMember();
		});
		
		function settingList(){
			$.ajax({
				type : "post",
				url : "/api/selectSettingList.json",
				dataType : '',
				success : function(res){
					var val = res.list;
					
					$("#apply").empty();
					if(val[0].openGubn == 'Y'){
						$("#apply").append("자동승인");	
					}else{
						$("#apply").append("수동승인");
					}
					
					$("#month").empty();
					$("#month").append("승인일로부터 "+val[0].openTerm+"개월 간 활용가능");
					$("#openTerm").val(val[0].openTerm);
				}
			});
		}
		
		function selectMember(){
			var userId="${sessionScope.userId}";
			
			if(userId!=null&&userId!='null'&&userId!=''){
				$.ajax({
					type : "post",
					url : "/api/selectMemberList.json",
					dataType : '',
					success : function(res){
						var val = res.list;
						var serviceKey='';
						
						if(val.length > 0){
							$("#pCompNm").val(val[0].compNm);
							$("#pCompMgr").val(val[0].compMgr);
							$("#pNum01 option:selected").val(val[0].pnum01);
							$("#pNum02").val(val[0].pnum02);
							$("#pNum03").val(val[0].pnum03);
							$("#pIp").val(val[0].ip);
							$("#serviceKey").val(val[0].serviceKey);
							
							serviceKey=val[0].serviceKey;
						}else{
							$("#serviceKey").val('0');
							serviceKey='0';
						}
						
						if(serviceKey != '0'){
							exsistCheck();
						}else if(serviceKey == '0'){
							// 법인등록팝업 open
							popupOpen();
						}
					}
				});
			}else{
				alert('로그인 후 이용하실 수 있습니다');
				location.href = "/customInfo/mainLoginForm.do";
			}
		}
		
		function popupOpen(){
			$("#pCompNm").val("");
			$("#pCompMgr").val("");
			$("#pNum01 option:selected").val("010");
			$("#pNum02").val("");
			$("#pNum03").val("");
			$("#pIp").val("");
			
			//fnShowLayer('#sub0501popup');
			fnLayerPopup('#sub0501popup');
		}
		
		function exsistCheck(){
			$.ajax({
				type : "post",
				url : "/api/selectExsistApplyList.json",
				dataType : '',
				success : function(res){
					var val = res.list;
					var reqDataCd = val[0].reqDataCd;
					
					if(reqDataCd != 0){
						$("#radioGubun1").attr("disabled","disabled");
						$("#radioGubun2").attr("disabled","disabled");
						if(val[0].sysFmt == 'normal'){
							$("#radioGubun1").parent().addClass("checked");
							$("#radioGubun1").attr("checked","checked");
						}else if(val[0].sysFmt == 'server'){
							$("#radioGubun2").parent().addClass("checked");
							$("#radioGubun2").attr("checked","checked");
						}
						
						$("#radioGubun3").attr("disabled","disabled");
						$("#radioGubun4").attr("disabled","disabled");
						$("#radioGubun5").attr("disabled","disabled");
						$("#radioGubun6").attr("disabled","disabled");
						$("#radioGubun7").attr("disabled","disabled");
						if(val[0].useInfo == 'web'){
							$("#radioGubun3").parent().addClass("checked");
							$("#radioGubun3").attr("checked","checked");
						}else if(val[0].useInfo == 'app'){
							$("#radioGubun4").parent().addClass("checked");
							$("#radioGubun4").attr("checked","checked");
						}else if(val[0].useInfo == 'soon'){
							$("#radioGubun5").parent().addClass("checked");
							$("#radioGubun5").attr("checked","checked");
						}else if(val[0].useInfo == 'ref'){
							$("#radioGubun6").parent().addClass("checked");
							$("#radioGubun6").attr("checked","checked");
						}else if(val[0].useInfo == 'res'){
							$("#radioGubun7").parent().addClass("checked");
							$("#radioGubun7").attr("checked","checked");
						}
						
						for(var i=0; i<val.length; i++){
							if(val[i].reqDataCd == 'f001' && val[i].delYn == 'N'){
								$("#allSelect1").parent().addClass("checked");
								$("#allSelect1").attr("checked","checked");
								$("#f001").val(val[i].delYn);
							}else if(val[i].reqDataCd == 'f002' && val[i].delYn == 'N'){
								$("#allSelect2").parent().addClass("checked");
								$("#allSelect2").attr("checked","checked");
								$("#f002").val(val[i].delYn);
							}else if(val[i].delYn == 'Y'){
								$("#f00"+(i+1)).val(val[i].delYn);
							}
						}
					}else{
					}
				}
			});
		}
		
		function applyBtn(){
			var agree = $("#allSelect4:checked").val();
			var rBtn1 = $("input[name=radio01]:checked").val();
			var rBtn2 = $("input[name=radio02]:checked").val();
			var cBtn1 = $("#allSelect1:checked").val();
			var cBtn2 = $("#allSelect2:checked").val();
			var openTerm = $("#openTerm").val();
			
			if(agree == undefined){
				alert("라이센스 동의를 체크하여 주십시오.");
			}else if(rBtn1 == undefined){
				alert("시스템 유형을 선택하여 주십시오.");
			}else if(rBtn2 == undefined){
				alert("활용정보를 선택하여 주십시오.");
			}else if(cBtn1 != 'f001' && cBtn2 != 'f002'){
				alert("최소 하나 이상의 상세기능 정보를 선택하셔야 합니다.");
			}else{
				
				$.ajax({
					type : "post",
					url : "/api/selectExsistList.json",
					data : {
						userId : userId
					},
					dataType : '',
					success : function(res){
						var val = res.list;
		
						var openTerm = $("#openTerm").val();
						var serviceKey = $("#serviceKey").val();
		
						/* 코드 첫번째 */			
						
						var checked1 = $("#allSelect1").is(":checked");
						cBtn1 = $("#allSelect1").val();
						var f001 = $("#f001").val();
						
						insertData(checked1, openTerm, cBtn1, f001, serviceKey, rBtn1, rBtn2);
		
						/* 코드 두 번째 */
						
						checked1 = $("#allSelect2").is(":checked");
						cBtn1 = $("#allSelect2").val();
						f001 = $("#f002").val();
						
						insertData(checked1, openTerm, cBtn1, f001, serviceKey, rBtn1, rBtn2);
						
						alert('신청되었습니다.');
						location.href = "/api/apiOpenApplyExsist.do";
					}
				});
			}
		}
		
		// 데이터 입력
		function insertData(checked2, openTerm, cBtn2, f002, serviceKey, rBtn1, rBtn2){
			if(f002 == ''){
				if(checked2 == true){
					$.ajax({
						type : "post",
						url : "/api/insertApiData.json",
						data : {
							allSelect : cBtn2,
							openTerm : openTerm,
							rBtn1 : rBtn1,
							rBtn2 : rBtn2
						},
						dataType : '',
						success : function(res){}
					});
				}
			}else if(f002 == 'N' || f002 == 'Y'){
				
				var userNo='Y';
				if(checked2 == true){
					userNo='N';
				}
				
				$.ajax({
					type : "post",
					url : "/api/updateApiDataInUser.json",
					data : {
						userNo : userNo,
						allSelect : cBtn2,
						openTerm : openTerm,
						serviceKey : serviceKey
					},
					dataType : '',
					success : function(res){}
				});
				
			}
		}
		
		function corpInsert(){
			var compNm = $("#pCompNm").val();
			var compMgr = $("#pCompMgr").val();
			var num01 = $("#pNum01 option:selected").val();
			var num02 = $("#pNum02").val();
			var num03 = $("#pNum03").val();
			var num = num01+num02+num03;
			var ip = $("#pIp").val();
			
			var compNm = $("#pCompNm").val();
			var compMgr = $("#pCompMgr").val();
			var num01 = $("#pNum01 option:selected").val();
			var num02 = $("#pNum02").val();
			var num03 = $("#pNum03").val();
			var num = num01+num02+num03;
			var ip = $("#pIp").val();
			
			if(compNm==''){
				alert('기업명을 입력하세요');
				$("#pCompNm").focus();
				return;
			}
			
			if(compMgr==''){
				alert('담당자명을 입력하세요');
				$("#pCompMgr").focus();
				return;
			}
			
			if(num01==''||num02==''||num03==''){
				alert('담당자연락처를 입력하세요');
				$("#pNum02").focus();
				return;
			}
			
			if(ip==''){
				alert('ip를 입력하세요');
				$("#pIp").focus();
				return;
			}
			
			$.ajax({
				type : "post",
				url : "/api/insertApiUser.json",
				data : {
					compNm : compNm,
					compMgr : compMgr,
					compTel : num,
					ip : ip
				},
				dataType : '',
				success : function(res){
					alert("공공데이터 개방 신청 페이지로 이동합니다.");
					location.href = "/api/apiOpenApply.do";
				}
			});
		}
		
		function pageOpenInfo(){
			var result = confirm('개방정보 화면으로 돌아가시겠습니까?'); 
			if(result) {
				location.href = "/api/apiOpenInfo.do";
			}
		}
		
		function pageGoBack(){
			var result = confirm('기본정보 미입력 시 공공데이터를 사용하실 수 없습니다. 개방정보 화면으로 돌아가시겠습니까?'); 
			if(result) {
				location.href = "/api/apiOpenInfo.do";
			}
		}
	</script>
</head>
<body>
	<!--WRAP(S)-->
	<div class="wrap">
			
		<jsp:include page="../inc/2020/IncHeader.jsp"/>
		
		<div class="lnb_box">
			<ul>
				<li><img src="../images/2020/m_lnb_img.png" alt="집"></li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li>공공데이터</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li>공공데이터</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li class="m_right">데이터개방 신청</li>
			</ul>
		</div>
		<!--공통 HEADER(E)-->
		
		<!--서브 타이틀(S)-->
		<div class="sub_sns">
		</div>
		
		<div class="sub_title">
			<div class="title_box">
				<h2>데이터개방 신청</h2>
				<p>전국 화훼공판장의 졍매정보를 확인 할 수 있습니다.</p>
			</div>
		</div>
		<!--서브 타이틀(E)-->
		<!--서브공통 (S)-->
		<div class="sub_contents">
		
		</div>
		<!--컨텐츠 내용(S)-->
		<div class="sub_guide">
			<!--기본정보-->
			<input type="hidden" id="openTerm" name="openTerm" value=""/>
			<input type="hidden" id="serviceKey" name="serviceKey" value=""/>
			<input type="hidden" id="f001" name="f001" value=""/>
			<input type="hidden" id="f002" name="f002" value=""/>
			
			<div class="datalog01_b">
				<h2 class="title_02">기본정보</h2>
				<table>
					<caption>기본정보</caption>
					<colgroup>
						<col style="width:15%">
						<col style="width:35%">
						<col style="width:15%">
						<col style="width:35%">
					</colgroup>
					<tbody>
						<tr>
							<th>서버명</th>
							<td>화훼가격정보</td>
							<th>서비스유형</th>
							<td>REST</td>
						</tr>
						<tr>
							<th>심의여부</th>
							<td id="apply">자동승인</td>
							<th>신청유형</th>
							<td>개발계정</td>
						</tr>
						<tr>
							<th>처리상태</th>
							<td>신청</td>
							<th>활용기간</th>
							<td id="month">승인일로부터 24개월 간 활용가능</td>
						</tr>
					</tbody>
				</table>
			</div>
			<!--시스템 유형선택-->
			<div class="datalog02_b">
				<h2 class="title_02">시스템 유형선택</h2>
				<table>
					<caption>시스템 유형선택</caption>
					<colgroup>
						<col style="width:15%">
						<col style="width:35%">
					</colgroup>
					<tbody>
						<tr>
							<th></th>
							<td>
								<input type="radio" id="radioGubun1" name="radio01" value="normal">
								<label for="radioGubun1" class="title_box_chk"><em class="txt">일반</em><span></span></label>
								<input type="radio"  id="radioGubun2" name="radio01" value="server">
								<label for="radioGubun2" class="title_box_chk"><em class="txt">서버구축</em><span></span></label>								
								
							</td>
							
						</tr>
						<tr>
							<th rowspan="1">시스템유형</th>
							<td>- 일반 : OpenAPI 서비스를 호출하여 응답받은 결과값을 서버에 저장하지 않고 사용할 경우 (서버 미구축)</td>
							
						</tr>
						<tr>
							<th></th>
							<td>- 서버 구축 : OpenAPI 서비스를 호출하여 응답받은 결과값을 서버에 저장하거나 DB화 하여 사용할 경우</td>
						</tr>
					</tbody>
				</table>
			</div>
			<!--활용정보-->
			<div class="datalog03_b">
				<h2 class="title_02">활용정보</h2>
				<table>
					<caption>활용정보</caption>
					<colgroup>
						<col style="width:20%">
						<col style="width:80%">
						
					</colgroup>
					<tbody>
						<tr>
							<th>활용정보</th>
							<td>
								<input type="radio" id="radioGubun3" name="radio02" value="web">
								<label for="radioGubun3" class="title_box_chk"><em class="txt">웹사이트 개발</em><span></span></label>
								<input type="radio" id="radioGubun4" name="radio02" value="app">
								<label for="radioGubun4" class="title_box_chk"><em class="txt">앱개발(모바일, 솔루션 등)</em><span></span></label>
								<input type="radio" id="radioGubun5" name="radio02" value="soon">
								<label for="radioGubun5" class="title_box_chk"><em class="txt">기타</em><span></span></label>
								<input type="radio" id="radioGubun6" name="radio02" value="ref">
								<label for="radioGubun6" class="title_box_chk"><em class="txt">참고자료</em><span></span></label>
								<input type="radio" id="radioGubun7" name="radio02" value="res">
								<label for="radioGubun7" class="title_box_chk"><em class="txt">연구(논문 등)</em><span></span></label>								
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<!--상세기능 정보-->
			<div class="datalog04_b">
				<h2 class="title_02">상세기능 정보</h2>
				<!-- <p class="wt_red">*  자동승인 상세기능은 신청과 동시에 활용 가능합니다.</p> -->
				<table>
					<caption>상세기능 정보</caption>
					<colgroup>
						<col style="width:10%">
						<col style="width:15%">
						<col style="width:60%">
						<col style="width:15%">
					</colgroup>
					<thead>
						<tr>
							<th></th>
							<th>상세기능</th>
							<th>설명</th>
							<th>일일트래픽</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="item" items="${dataList}" varStatus="status">
							<tr>
								<td>
									<input type="checkbox" value="${item.reqDataCd}" id="allSelect${status.count}">
									<label for="allSelect${status.count}" class="title_box_chk"><em class="txt"></em><span></span></label>
								</td>
								<td>${item.reqDataNm}</td>
								<td class="no_tet">${item.menual}</td>
								<td>${item.maxCallCnt}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<!--라이센스 표시-->
			<div class="datalog05_b">
				<h2 class="title_02">라이센스 표시</h2>
				<table>
					<caption>라이센스 표시</caption>
					<colgroup>
						<col style="width:20%">
						<col style="width:20%">
						<col style="width:60%">
					</colgroup>
					<tbody>
						<tr>
							<th>
								이용허락범위
							</th>
							<td>
								제작자 표시
							</td>
							<td>
								<input type="checkbox" id="allSelect4" value="agree">
								<label for="allSelect4" class="title_box_chk"><em class="txt">동의합니다</em><span></span></label>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			
			<div class="opendata01_b">			
				<div class="sevi_box03_b">
					<button type="button" id="apply" onclick="applyBtn();" >신청</button>
					<button type="button" id="cancel" onclick="pageOpenInfo();">취소</button>
				</div>
			</div>
			
		</div>
		
		<!--컨텐츠 내용(E)-->
		
		<jsp:include page="../inc/2020/IncFooter.jsp"/>
		
		<!-- 팝업(S) -->
		<div class="dim-layer" id="sub0501popup">
			<div class="dimBg"></div>
			<div class="pop-layer popbox pop_info">
				<div class="pop-container">
					<div class="pop-conts_00">
						<!-- 팝업타이틀(S) -->
						<div class="pop_title_box">
							<h2 class="title_02"> 기본정보</h2>
						</div>
						<!-- 팝업타이틀(E) -->

						<!-- 팝업 콘텐츠(S) -->
						<div class="pop_conts01">
							<div class="info_pop">
								<span class="info_title">기업명</span>
								<input type="text" class="opendata_pop" id="pCompNm" name="pCompNm" maxlength="20"/>
								<span class="info_title">담당자명</span>
								<input type="text" class="opendata_pop" id="pCompMgr" name="pCompMgr" maxlength="10"/>
								<span class="info_title">담당자연락처</span>
								<div class="info_tel">
									<label></label>
									<select class="numSelect" id="pNum01" name="pNum01" >
										<option value="010">010</option>
										<option value="011">011</option>
										<option value="016">016</option>
										<option value="019">019</option>
									</select>
									<span >-</span>
									<label for="pNum02"></label>
									<input type="text" class="opendata_pop" id="pNum02" name="pNum02" maxlength="4" />
									<span >-</span>
									<label for="pNum03" ></label>
									<input type="text" class="opendata_pop" id="pNum03" name="pNum03" maxlength="4" />
								</div>
								<span class="info_title">접속아이피</span>
								<input type="text" class="opendata_pop" id="pIp" name="pIp" maxlength="15" />
							</div>
							
							<div class="pop_btn_b">
								<p>개인정보 보호 및 부정 사용으로 인한 피해를 방지하기 위해 회원정보를 확인해 주시기 바랍니다.</p>
								<button class="btn-example" id="finalApply" onclick="corpInsert();">확인</button>
								<button id="pageBack" onclick="pageGoBack();">취소</button>
							</div>
						</div>
						<!-- 팝업 콘텐츠(E) -->
					</div>
				</div>
			</div>
		</div>
		<!-- 팝업(E) -->
	</div>
	<!--WRAP(E)-->
</body>
</html>