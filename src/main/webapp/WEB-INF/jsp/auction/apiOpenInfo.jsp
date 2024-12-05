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
	<meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, user-scalable=no">
	<meta name="apple-mobile-web-app-title" content="화훼유통정보시스템">
	<meta name="robots" content="no-index,follow">
	<meta name="og:title" content="화훼유통정보시스템">
	<meta name="og:description" content="화훼유통정보시스템">
	<meta name="description" content="데이터 개방 정보">
	<meta name="content" content="화훼유통정보시스템 입니다.">
	<meta name="keywords" content="화훼경매시세, 화훼경매가격, Korea aT flower market auction price, 화훼공판장, 화훼거래정보, 꽃시장, 꽃값">
	<meta name="Author" content="화훼유통정보시스템 & www.woorim.co.kr">
	<title>데이터 개방 정보</title>
	<%@include file="../common/2020/commonJs.jsp" %>
	<%@include file="../common/2020/commonCss.jsp" %>
	
	<script type="text/javascript">
	
		var showData='f001';
		
		$(function(){
			$("#f21").hide();
			$("#f22").hide();
			init();
		});
		
		function init(){
			$.ajax({
				type : "post",
				url : "/api/selectDataOpenPageSetting.json",
				dataType : '',
				success : function(res){
					var val = res.list;
					
					var openGubn = null;
					if(val[0].openGubn == 'Y'){
						openGubn = "자동승인";
					}else if(val[0].openGubn == 'N'){
						openGubn = "수동승인";
					}
					
					$("#init").empty();
					
					var html='';
					html+='<p>· 활용승인 절차  계정 : '+openGubn+'</p> <p>· 신청가능 트래픽 : '+val[0].maxCallCnt+' 건 / 관리자 문의 후 트래픽 증가 가능</p> ';
					html+='<p id="addressLi">· 요청주소 :  https://flower.at.or.kr/api/api/returnData.api?kind=f001 </p>';
										
					$("#init").append(html);
					
					$("#sampleUrl").text('https://flower.at.or.kr/api/returnData.api?kind=f001&serviceKey=sample&baseDate=2018-08-16&flowerGubn=1&dataType=json&countPerPage=999');
					showData='f001';
				}
			});
		}
		
		// 활용신청 팝업
		function popupOpen(){
			var userId="${sessionScope.userId}";
			
			if(userId!=null&&userId!='null'&&userId!=''){
				$.ajax({
					type : "post",
					url : "/api/selectMemberList.json",
					dataType : '',
					success : function(res){
						var val = res.list;
						if(val != null && val.length > 0){
							
							$.ajax({
								type : "post",
								url : "/api/selectExsistList.json",
								dataType : '',
								success : function(res){
									var val = res.list;
									var result = confirm('이미 신청한 공공데이터가 있습니다. 재신청 하시겠습니까?'); 
									
									if(result) {
										location.href = "/api/apiOpenApply.do";
									}
								}
							});
						}else{
							$("#pCompNm").val("");
							$("#pCompMgr").val("");
							$("#pNum01 option:selected").val("010");
							$("#pNum02").val("");
							$("#pNum03").val("");
							$("#pIp").val("");
							
							//fnShowLayer('#sub0501popup');
							fnLayerPopup('#sub0501popup');
						}
					}
				});
			}else{
				alert('로그인 후 이용하실 수 있습니다');
				location.href = "/customInfo/mainLoginForm.do";
			}	
		}
		
		function exsisPage(){
			location.href = "/api/apiOpenApplyExsist.do";
		}
		
		function closeLayer(){
			hideLayer('#sub0501popup');
		}
		
		function corpInsert(){
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
			
			if(num01==''||num02==''){
				alert('담당자연락처를 입력하세요');
				$("#pNum02").focus();
				return;
			}
			
			if(num03==''){
				alert('담당자연락처를 입력하세요');
				$("#pNum03").focus();
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
		
		function reApply(){
			var compNm = $("#pCompNm").val();
			var compMgr = $("#pCompMgr").val();
			var num01 = $("#pNum01 option:selected").val();
			var num02 = $("#pNum02").val();
			var num03 = $("#pNum03").val();
			var num = num01+num02+num03;
			var ip = $("#pIp").val();
			
			$.ajax({
				type : "post",
				url : "/api/updateApiData.json",
				data : {
					compNm : compNm,
					compMgr : compMgr,
					compTel : num,
					serviceKey : "serviceKey",
					ip : ip
				},
				dataType : '',
				success : function(res){
					//location.href = "/api/apiOpenApply.do";
				}
			});
		}
		
		function fBtn1(){
			$("#f21").hide();
			$("#f22").hide();
			$("#f11").show();
			$("#f12").show();
			$("#addressLi").html('· 요청주소 :  https://flower.at.or.kr/api/api/returnData.api?kind=f001');
			$("#sampleUrl").text('https://flower.at.or.kr/api/returnData.api?kind=f001&serviceKey=sample&baseDate=2018-08-16&flowerGubn=1&dataType=json&countPerPage=999');
			showData='f001';
		}
		
		/* function fBtn2(){
			$("#f11").hide();
			$("#f12").hide();
			$("#f21").show();
			$("#f22").show();
			$("#addressLi").html('· 요청주소 :  https://flower.at.or.kr/api/api/returnData.api?kind=f002');
			$("#sampleUrl").text('https://flower.at.or.kr/api/returnData.api?kind=f002&serviceKey=sample&baseDate=2018-08-13&flowerGubn=1&dataType=json&countPerPage=999');
			showData='f002';
		} */
		
		function getOpenApi(dataType){
			
			window.open('/api/returnData.api?kind='+showData+'&serviceKey=sample&baseDate=2018-08-13&flowerGubn=1&countPerPage=999&dataType='+dataType, '_blank');
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
				<li class="m_right">데이터 개방 정보</li>
			</ul>
		</div>
		<!--공통 HEADER(E)-->
		
		<!--서브 타이틀(S)-->
		<div class="sub_sns">
		</div>
		
		<div class="sub_title">
			<div class="title_box">
				<h2>공공데이터 개방 정보</h2>
				<img src="../images/2020/sub/t_line.png" alt="방울점선">
			</div>
		</div>
		<!--서브 타이틀(E)-->
		<!--서브공통 (S)-->
		<div class="sub_contents">
		
		</div>
		<!--컨텐츠 내용(S)-->
		<div class="sub_guide">
			<!--경락가격 정보 서비스-->
			<div class="opendata01_b">
				<h2 class="title_02">경락가격 정보 서비스</h2>
				<div class="sevi_box01_b">
					<p>· 일자별 경매정보</p>
				</div>
				<div class="sevi_box02_b" id="init">
					<p>· 활용승인 절차 계정 : 자동승인</p>
					<p>· 신청가능 트래픽 : 1000 건 / 관리자 문의 후 트래픽 증가 가능</p>
					<p>· 요청주소 : https://flower.at.or.kr/api/api/returnData.api?kind=f001</p>
				</div>
			
				<div class="sevi_box03_b">
					<button id="opend" name="opend" onclick="popupOpen();">활용신청</button>
					<button id="exsist" name="exsist" onclick="exsisPage();">신청현황보기</button>
				</div>
			</div>
			<!--요청변수-->
			<div class="opendata03_b" id="f11">
				<h2 class="title_02">요청변수(Request Parameter)</h2>
				<table>
					<caption>요청변수</caption>
					<colgroup>
						<col style="width:15%">
						<col style="width:15%">
						<col style="width:10%">
						<col style="width:10%">
						<col style="width:25%">
						<col style="width:20%">
					</colgroup>
					<thead>
						<tr>
							<th>항목명(국문)</th>
							<th>항목명(영문)</th>
							<th>항목크기</th>
							<th>항목구분</th>
							<th>샘플데이터</th>
							<th>항목설명</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>서비스 구분 코드</td>
							<td>kind</td>
							<td>4</td>
							<td>필수</td>
							<td>f001</td>
							<td>서비스 구분 코드</td>
						</tr>
						<tr>
							<td>서비스 키</td>
							<td>serviceKey</td>
							<td>32</td>
							<td>필수</td>
							<td>C2CE14F208A44622A87CB506D9256B79</td>
							<td>서비스 키</td>
						</tr>
						<tr>
							<td>기준일</td>
							<td>baseDate</td>
							<td>10</td>
							<td>필수</td>
							<td>2018-08-16</td>
							<td>조회일자</td>
						</tr>
						<tr>
							<td>화훼구분코드</td>
							<td>flowerGubn</td>
							<td>1</td>
							<td>필수</td>
							<td>1</td>
							<td>부류코드(1:절화, 2:관엽, 3:난, 4:춘란)</td>
						</tr>
						<tr>
							<td>데이터 타입</td>
							<td>dataType</td>
							<td>2</td>
							<td>필수</td>
							<td>json</td>
							<td>데이터 타입 (json/xml)</td>
						</tr>
						<tr>
							<td>페이지당 출력 개수</td>
							<td>countPerPage</td>
							<td>2</td>
							<td>옵션</td>
							<td>10</td>
							<td>페이지당 출력 개수</td>
						</tr>
						<tr>
							<td>출력될 페이지 번호</td>
							<td>currentPage</td>
							<td>2</td>
							<td>옵션</td>
							<td>1</td>
							<td>출력될 페이지 번호</td>
						</tr>
						<tr>
							<td>품목명</td>
							<td>pumName</td>
							<td>100</td>
							<td>옵션</td>
							<td>장미</td>
							<td>품목명</td>
						</tr>
						<tr>
							<td>품종명</td>
							<td>goodName</td>
							<td>100</td>
							<td>옵션</td>
							<td>블론디</td>
							<td>품종명</td>
						</tr>
					</tbody>
				</table>
			</div>
			<!--출력결과-->
			<div class="opendata03_b" id="f12">
				<h2 class="title_02"> 출력결과(Response Element)</h2>
				<table>
					<caption>요청변수</caption>
					<colgroup>
						<col style="width:%">
						<col style="width:%">
						<col style="width:%">
						<col style="width:%">
						<col style="width:%">
						<col style="width:%">
					</colgroup>
					<thead>
						<tr>
							<th>항목명(국문)</th>
							<th>항목명(영문)</th>
							<th>항목크기</th>
							<th>항목구분</th>
							<th>샘플데이터</th>
							<th>항목설명</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>결과코드</td>
							<td>resultCd</td>
							<td>1</td>
							<td>필수</td>
							<td>0</td>
							<td>결과코드</td>
						</tr>
						<tr>
							<td>결과메세지</td>
							<td>resultMsg</td>
							<td>50</td>
							<td>필수</td>
							<td>OK</td>
							<td>결과메세지</td>
						</tr>
						<tr>
							<td>한 페이지 결과 수</td>
							<td>numOfRows</td>
							<td>2</td>
							<td>필수</td>
							<td>10</td>
							<td>한 페이지 결과 수</td>
						</tr>
						<tr>
							<td>경매일자</td>
							<td>saleDate</td>
							<td>10</td>
							<td>필수</td>
							<td>2018-08-16</td>
							<td>경매일자</td>
						</tr>
						<tr>
							<td>화훼부류명</td>
							<td>flowerGubn</td>
							<td>2</td>
							<td>필수</td>
							<td>절화</td>
							<td>화훼부류명</td>
						</tr>
						<tr>
							<td>품목명</td>
							<td>pumName</td>
							<td>100</td>
							<td>필수</td>
							<td>장미</td>
							<td>품목명</td>
						</tr>
						<tr>
							<td>품종명</td>
							<td>goodName</td>
							<td>100</td>
							<td>필수</td>
							<td>블론디</td>
							<td>품종명</td>
						</tr>
						<tr>
							<td>등급명</td>
							<td>lv</td>
							<td>100</td>
							<td>필수</td>
							<td>특1</td>
							<td>등급명</td>
						</tr>
						<tr>
							<td>최고가</td>
							<td>maxAmt</td>
							<td>100</td>
							<td>필수</td>
							<td>9000</td>
							<td>최고가</td>
						</tr>
						<tr>
							<td>최저가</td>
							<td>minAmt</td>
							<td>100</td>
							<td>필수</td>
							<td>6000</td>
							<td>최저가</td>
						</tr>
						<tr>
							<td>평균가</td>
							<td>avgAmt</td>
							<td>100</td>
							<td>필수</td>
							<td>15000</td>
							<td>평균가</td>
						</tr>
						<tr>
							<td>총금액</td>
							<td>totAmt</td>
							<td>100</td>
							<td>필수</td>
							<td>27900</td>
							<td>총금액 (단위 : 원)</td>
						</tr>
						<tr>
							<td>총물량</td>
							<td>totQty</td>
							<td>100</td>
							<td>필수</td>
							<td>31</td>
							<td>총물량 (단위 : 속)</td>
						</tr>
					</tbody>
				</table>
			</div>
			<!--샘플URL-->
			<div class="opendata04_b">
				<h2 class="title_02"> 샘플URL</h2>
				<div class="url_b">
					<p id="sampleUrl"></p>
				</div>				
			</div>			
			
			<div class="opendata01_b">			
				<div class="sevi_box03_b">
					<button type="button" onclick="getOpenApi('json')" >JSON</button>
					<button type="button" onclick="getOpenApi('xml')">XML</button>
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
							<a href="#!" class="btn-layerClose close_B">Ⅹ</a>
						</div>
						<!-- 팝업타이틀(E) -->

						<!-- 팝업 콘텐츠(S) -->
						<div class="pop_conts01">
							<div class="info_pop">
								<span class="info_title">기업명</span>
								<input type="text" class="opendata_pop" id="pCompNm" name="pCompNm" maxlength="20" />
								<span class="info_title">담당자명</span>
								<input type="text" class="opendata_pop" id="pCompMgr" name="pCompMgr" maxlength="10" />
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
								<button class="btn-layerClose">취소</button>
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