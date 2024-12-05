<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
	<meta name="description" content="경락단가내역">
	<meta name="content" content="화훼유통정보시스템 입니다.">
	<meta name="keywords" content="화훼경매시세, 화훼경매가격, Korea aT flower market auction price, 화훼공판장, 화훼거래정보, 꽃시장, 꽃값">
	<meta name="Author" content="화훼유통정보시스템 & www.woorim.co.kr : Kim Juyeon">
	<title>경락단가내역</title>
	
	<%@include file="../common/2020/commonJs.jsp" %>
	<%@include file="../common/2020/commonCss.jsp" %>
	
	<script type="text/javascript">
		var flowerCd = null;
		var cmpCd = null;
		var searchSaleDate = null;
		var searchPumGubn = null;
	
		$(document).ready(function(){
			$("#pumSelectbox").css('display','none');
			$("#liStrDate").css("display","none");
			
			var d = new Date();
			$("#searchEndDate").val(d.getFullYear());
			$("#searchEndDate").bindDate({align:"right", valign:"bottom", separator:"-", selectType:"y",  defaultSelectType:"y", value:d.getFullYear(),
				onchange:function(){
					dateChke();
				}
											
			});
			
			$(".tab_btn01 a").click(function(){
				var choose = $(this).parent().attr("value");
				cmpCd = $("#cmpCdTab .on > input").attr("value");
				flowerCd = $("#flowerTab .on > input").attr("value");
				
				if(choose == '1' || choose == '2'){
					$("#searchPumGubn").val(choose);
					
					if(choose == '1'){
						$("#gubunTxt").html("품목");
						getData1(cmpCd, flowerCd, searchSaleDate);
					}else{
						$("#gubunTxt").html("품목<br>(품종)");
						getData2(cmpCd, flowerCd, searchSaleDate);
					}
				}else{
					$("#searchPumGubn").val("");
				}
			});
			
			$("#excelBtn1").empty();
			$("#excelBtn1").append('<a href="javascript:void(0);" id="exportBtn1" name="exportTable1" onclick="excelExport();"><img src="../images/2020/exel.png" alt="엑셀이미지">엑셀저장</a>');
		});
	
		function dateChke(){
			var searchGoFlag=false;
			var selectDate = $("#searchEndDate").val().replace(/-/gi, "");
			var today = new Date();
			var yy= today.getFullYear();
			today = yy;
			if(selectDate<=today){
				searchGoFlag=true;
			}else{
				alert("당일년도까지만 선택이 가능합니다")
				return searchGoFlag;
			}
		}
		
		// 엑셀 다운로드
		function excelExport(){
			var choose = $(".sub_tab_btn").children().children(".on").attr("value");			
			
			var excelNm = "경락단가내역";
			searchEndDate = $("#searchEndDate").val();
			cmpCd = $("#searchCmpCd").val();
			flowerCd = $("#mobFlowerCd").val();
			var itemCd = $("#itemCd option:selected").val();
			var itemCd2 = $("#itemCd2 option:selected").val();
			var param = "?excelNm="+excelNm+"&searchYear="+searchEndDate+"&searchCmpCd="+cmpCd+"&searchProductGubun="+flowerCd+"&itemCd="+itemCd+"&itemCd2="+itemCd2+"&choose="+choose;
			location.href = "/excel/excelDownLoad.do"+param;			
		}
		
		function init(){
			$("#get1").empty();
			$("#get1").append("<tr><td colspan='14'>데이터가 없습니다.</td></tr>");
		}
		
		function search(){
			cmpCd = $("#cmpCdTab .on > input").attr("value");
			flowerCd = $("#flowerTab .on > input").attr("value");
			searchSaleDate = $("#searchEndDate").val(); 
			searchPumGubn = $("#searchPumGubn").val(); 
			
			// 검색 시 쿠키저장
			$.cookie("cookie.cmpCd", cmpCd, {expires: 7, path: '/' });
			$.cookie("cookie.flowerCd", flowerCd, { expires: 7, path: '/' });
			//$.cookie("cookie.pumCd", itemCd,{ expires: 7, path: '/' });
			//$.cookie("cookie.goodCd", itemCd2, { expires: 7, path: '/' });
			
			if(searchPumGubn == '1'){
				getData1(cmpCd, flowerCd, searchSaleDate);	
			}else{
				getData2(cmpCd, flowerCd, searchSaleDate);	
			}
		}
		
		function SeparatCom(num) {
		    return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		}
		
		function getSaledate(cmpCd, flowerCd){ 
			// 일자 호출 , 품목호출
			// 1번
			//init();
			
			$.ajax({
				type : "post",
				url : "/search/selectSaleMonth.json",
				data : {
					searchProductGubun : flowerCd,
					searchCmpCd : cmpCd
				},
				dataType : '',
				success : function(res){
					var val = res.list;
					if(res.list!=null && res.list.length > 0){
						var saleMonth=val[0].SALE_MONTH;
						searchSaleDate = saleMonth.substring(0,4);
						$("#searchEndDate").val(searchSaleDate);
						search();
					}
					if(val[0] == null){
						searchSaleDate = '';
						$('#searchEndDate').val(searchSaleDate);
						init();
					}
				}
			});
		}
		
		function getData1(cmpCd, flowerCd, searchSaleDate){
			$("#get1").empty();
			
			$.ajax({
				type : "GET",
				url : "/hab03/hab03.json",
				data : "searchCmpCd="+cmpCd+"&searchProductGubun="+flowerCd+"&searchYear="+searchSaleDate,
				dataType : '',
				success : function(res){
					var val = res.list;
					
					if(val != ""){
						for(var i=0; i<val.length; i++){
							/* $("#get1").append("<tr><td rowspan='3' class='first'>"+val[i].pumName+"</td><td>최고</td><td>"+SeparatCom(val[i].maxamt1)+"</td><td>"+SeparatCom(val[i].maxamt2)+"</td><td>"+SeparatCom(val[i].maxamt3)+"</td><td>"+SeparatCom(val[i].maxamt4)+"</td><td>"+SeparatCom(val[i].maxamt5)+"</td><td>"+SeparatCom(val[i].maxamt6)+"</td><td>"+SeparatCom(val[i].maxamt7)+"</td><td>"+SeparatCom(val[i].maxamt8)+"</td><td>"+SeparatCom(val[i].maxamt9)+"</td><td>"+SeparatCom(val[i].maxamt10)+"</td><td>"+SeparatCom(val[i].maxamt11)+"</td><td>"+SeparatCom(val[i].maxamt12)+"</td></tr>"+
									"<tr><td>최저</td><td>"+SeparatCom(val[i].minamt1)+"</td><td>"+SeparatCom(val[i].minamt2)+"</td><td>"+SeparatCom(val[i].minamt3)+"</td><td>"+SeparatCom(val[i].minamt4)+"</td><td>"+SeparatCom(val[i].minamt5)+"</td><td>"+SeparatCom(val[i].minamt6)+"</td><td>"+SeparatCom(val[i].minamt7)+"</td><td>"+SeparatCom(val[i].minamt8)+"</td><td>"+SeparatCom(val[i].minamt9)+"</td><td>"+SeparatCom(val[i].minamt10)+"</td><td>"+SeparatCom(val[i].minamt11)+"</td><td>"+SeparatCom(val[i].minamt12)+"</td></tr>"+
									"<tr><td>평균</td><td>"+SeparatCom(val[i].avgamt1)+"</td><td>"+SeparatCom(val[i].avgamt2)+"</td><td>"+SeparatCom(val[i].avgamt3)+"</td><td>"+SeparatCom(val[i].avgamt4)+"</td><td>"+SeparatCom(val[i].avgamt5)+"</td><td>"+SeparatCom(val[i].avgamt6)+"</td><td>"+SeparatCom(val[i].avgamt7)+"</td><td>"+SeparatCom(val[i].avgamt8)+"</td><td>"+SeparatCom(val[i].avgamt9)+"</td><td>"+SeparatCom(val[i].avgamt10)+"</td><td>"+SeparatCom(val[i].avgamt11)+"</td><td>"+SeparatCom(val[i].avgamt12)+"</td></tr>");
							 */
							$("#get1").append("<tr><td class='tc' rowspan='3'><p>"+val[i].pumName+"</p></td><td class='tc'><p>최고</p></td><td class='tc'><p>"+SeparatCom(val[i].maxamt1)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].maxamt2)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].maxamt3)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].maxamt4)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].maxamt5)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].maxamt6)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].maxamt7)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].maxamt8)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].maxamt9)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].maxamt10)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].maxamt11)+"</td><td class='tc'><p>"+SeparatCom(val[i].maxamt12)+"</p></td></tr>"+
									"<tr><td class='tc'><p>최저</p></td><td class='tc'><p>"+SeparatCom(val[i].minamt1)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].minamt2)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].minamt3)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].minamt4)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].minamt5)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].minamt6)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].minamt7)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].minamt8)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].minamt9)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].minamt10)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].minamt11)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].minamt12)+"</p></td></tr>"+
									"<tr><td class='tc'><p>평균</p></td><td class='tc'><p>"+SeparatCom(val[i].avgamt1)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].avgamt2)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].avgamt3)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].avgamt4)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].avgamt5)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].avgamt6)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].avgamt7)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].avgamt8)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].avgamt9)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].avgamt10)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].avgamt11)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].avgamt12)+"</p></td></tr>");
													
						}	
					}else{
						$("#get1").append("<tr><td colspan='14'>데이터가 없습니다.</td></tr>");
					}
					
				}
			});
		}
		
		function getData2(cmpCd, flowerCd, searchSaleDate){
			$("#get1").empty();
			
			$.ajax({
				type : "GET",
				url : "/hab03/hab03selectPumJong.json",
				data : "searchCmpCd="+cmpCd+"&searchProductGubun="+flowerCd+"&searchYear="+searchSaleDate,
				dataType : '',
				success : function(res){
					var val = res.list;

					if(val != ""){
						for(var i=0; i<val.length; i++){
							/* $("#get1").append("<tr><td rowspan='3' class='first'>"+val[i].pumName+"<br>("+val[i].goodName+")"+"</td><td>최고</td><td>"+SeparatCom(val[i].maxamt1)+"</td><td>"+SeparatCom(val[i].maxamt2)+"</td><td>"+SeparatCom(val[i].maxamt3)+"</td><td>"+SeparatCom(val[i].maxamt4)+"</td><td>"+SeparatCom(val[i].maxamt5)+"</td><td>"+SeparatCom(val[i].maxamt6)+"</td><td>"+SeparatCom(val[i].maxamt7)+"</td><td>"+SeparatCom(val[i].maxamt8)+"</td><td>"+SeparatCom(val[i].maxamt9)+"</td><td>"+SeparatCom(val[i].maxamt10)+"</td><td>"+SeparatCom(val[i].maxamt11)+"</td><td>"+SeparatCom(val[i].maxamt12)+"</td></tr>"+
									"<tr><td>최저</td><td>"+SeparatCom(val[i].minamt1)+"</td><td>"+SeparatCom(val[i].minamt2)+"</td><td>"+SeparatCom(val[i].minamt3)+"</td><td>"+SeparatCom(val[i].minamt4)+"</td><td>"+SeparatCom(val[i].minamt5)+"</td><td>"+SeparatCom(val[i].minamt6)+"</td><td>"+SeparatCom(val[i].minamt7)+"</td><td>"+SeparatCom(val[i].minamt8)+"</td><td>"+SeparatCom(val[i].minamt9)+"</td><td>"+SeparatCom(val[i].minamt10)+"</td><td>"+SeparatCom(val[i].minamt11)+"</td><td>"+SeparatCom(val[i].minamt12)+"</td></tr>"+
									"<tr><td>평균</td><td>"+SeparatCom(val[i].avgamt1)+"</td><td>"+SeparatCom(val[i].avgamt2)+"</td><td>"+SeparatCom(val[i].avgamt3)+"</td><td>"+SeparatCom(val[i].avgamt4)+"</td><td>"+SeparatCom(val[i].avgamt5)+"</td><td>"+SeparatCom(val[i].avgamt6)+"</td><td>"+SeparatCom(val[i].avgamt7)+"</td><td>"+SeparatCom(val[i].avgamt8)+"</td><td>"+SeparatCom(val[i].avgamt9)+"</td><td>"+SeparatCom(val[i].avgamt10)+"</td><td>"+SeparatCom(val[i].avgamt11)+"</td><td>"+SeparatCom(val[i].avgamt12)+"</td></tr>");
							 */
							$("#get1").append("<tr><td class='tc' rowspan='3'><p>"+val[i].pumName+"<br>("+val[i].goodName+")"+"</p></td><td class='tc'><p>최고</p></td><td class='tc'><p>"+SeparatCom(val[i].maxamt1)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].maxamt2)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].maxamt3)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].maxamt4)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].maxamt5)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].maxamt6)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].maxamt7)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].maxamt8)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].maxamt9)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].maxamt10)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].maxamt11)+"</td><td class='tc'><p>"+SeparatCom(val[i].maxamt12)+"</p></td></tr>"+
									"<tr><td class='tc'><p>최저</p></td><td class='tc'><p>"+SeparatCom(val[i].minamt1)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].minamt2)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].minamt3)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].minamt4)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].minamt5)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].minamt6)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].minamt7)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].minamt8)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].minamt9)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].minamt10)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].minamt11)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].minamt12)+"</p></td></tr>"+
									"<tr><td class='tc'><p>평균</p></td><td class='tc'><p>"+SeparatCom(val[i].avgamt1)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].avgamt2)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].avgamt3)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].avgamt4)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].avgamt5)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].avgamt6)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].avgamt7)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].avgamt8)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].avgamt9)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].avgamt10)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].avgamt11)+"</p></td><td class='tc'><p>"+SeparatCom(val[i].avgamt12)+"</p></td></tr>");
							
						}	
					}else{
						$("#get1").append("<tr><td colspan='14'>데이터가 없습니다.</td></tr>");
					}
				}
			});
		}
	</script>
</head>
<body>
	<input type="hidden" id="searchProductGubun" name="searchProductGubun" value="1"/>
	<input type="hidden" id="searchCmpCd" name="searchCmpCd" value="0000000001"/>
	<input type="hidden" id="searchPumGubn" name="searchPumGubn" value="1"/>
	
	<!--WRAP(S)-->
	<div class="wrap">
			
		<jsp:include page="../inc/2020/IncHeader.jsp"/>
		
		<div class="lnb_box">
			<ul>
				<li><img src="../images/2020/m_lnb_img.png" alt="집"></li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li>경매정보</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li>경매실적 세부정보</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li class="m_right">경락단가내역</li>
			</ul>
		</div>
		<!--공통 HEADER(E)-->
		
		<!--서브 타이틀(S)-->
		<jsp:include page="../inc/2020/IncShare.jsp"/>
		
		<div class="sub_title">
			<div class="title_box">
				<h2>경락단가내역</h2>
				<img src="../images/2020/sub/t_line.png" alt="방울점선">
			</div>
		</div>
		<!--서브 타이틀(E)-->
		<jsp:include page="../inc/2020/topMenuRange.jsp"/>
		
		<!--컨텐츠 내용(S)-->
		<div class="sub_guide">
			
			<!-- 탭버튼(S) -->
			<div class="sub_tab_btn devide_2">
				<ul>
					<li class="tab_btn01 on" value="1"><a href="#">품목별</a></li>
					<li class="tab_btn01" value="2"><a href="#">주요 품종별</a></li>
				</ul>
			</div>
			<!-- 탭버튼(E) -->

			<!-- 탭콘텐츠(S) -->
			<ul class="tab_contents">
				<li>				
					<!-- 테이블(S) -->
					<div class="overflow-x">
					<table class="table_type_01 btg tiny">
						<caption>경락단가내역</caption>
						<colgroup>
							<col style="width:90px">
							<col style="width:70px">
							<col style="width:70px">
							<col style="width:70px">
							<col style="width:70px">
							<col style="width:70px">
							<col style="width:70px">
							<col style="width:70px">
							<col style="width:70px">
							<col style="width:70px">
							<col style="width:70px">
							<col style="width:70px">
							<col style="width:70px">
							<col style="width:70px">
						</colgroup>
						<tbody>
							<thead>
								<tr>
									<th class="tc" id="gubunTxt">품목</th>
									<th class="tc">구분</th>
									<th class="tc">1월</th>
									<th class="tc">2월</th>
									<th class="tc">3월</th>
									<th class="tc">4월</th>
									<th class="tc">5월</th>
									<th class="tc">6월</th>
									<th class="tc">7월</th>
									<th class="tc">8월</th>
									<th class="tc">9월</th>
									<th class="tc">10월</th>
									<th class="tc">11월</th>
									<th class="tc">12월</th>
								</tr>
							</thead>
							<tbody id="get1"></tbody>						
						</tbody>
					</table>
					</div>
					<!-- 테이블(E) -->
				</li>
			</ul>
			<!-- 탭콘텐츠(E) --> 
			<!-- 버튼박스(S) -->
			<div class="dwn_bt_b" id="excelBtn1">
				<a href="#!">엑셀저장</a>
			</div>
			<!-- 버튼박스(E) -->
		</div>
		<div class="guide">
			<h2 class="title_02">이용안내</h2>
			<ul class="guide_box">
				<li class="">· 품목 및 주요품종별 경락단가내역을 월별로 비교 분석할수 있는 화면</li>
				<li class="">· 품목별 탭 및 주요품종별 탭을 선택하여 원하는 정보를 확인 할 수 있습니다.</li>
				<li class="">· 거래금액이 크고 거래물량이 많은 상위 품목/품종 20개</li>
				<li class="">· 단위 : 단가(원) / 자료출처 : 각 공판장별 경매 자료 현황</li>
				<li class="">· 공판장별 단순집계 자료이므로 참고자료로만 활용하시기 바랍니다.</li>
			</ul>
		</div>
		<!--컨텐츠 내용(E)-->
		
		<jsp:include page="../inc/2020/IncFooter.jsp"/>
		
	</div>
	<!--WRAP(E)-->
</body>
</html>