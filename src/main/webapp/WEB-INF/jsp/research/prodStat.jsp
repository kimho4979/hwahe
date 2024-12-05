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
	<title>절화류 생산현황조사</title>
	
	<%@include file="../common/2020/commonJs.jsp" %>
	<%@include file="../common/2020/commonCss.jsp" %>
	<link rel="stylesheet" type="text/css" href="/css/sub_02.css">
	<script type="text/javascript" src="/research/js/jquery-3.6.0.min.js"></script>
	
	<script type="text/javascript">
		function comma(num){
		    var len, point, str; 
		       
		    num = num + ""; 
		    point = num.length % 3 ;
		    len = num.length; 
		   
		    str = num.substring(0, point); 
		    while (point < len) { 
		        if (str != "") str += ","; 
		        str += num.substring(point, point + 3); 
		        point += 3; 
		    } 
		     
		    return str;
		}
	
		$(document).ready(function(){	
			fh_chulInfoAll();
		});
	
		function fn_stdYearChange(){
			fh_chulInfoAll();
		}
	
		function fh_chulInfoAll(){
			var stdYear = $("#stdYear").prop("value");
			
			$.ajax({
			    type : 'get',
			    url : "/reseach/chulInfo.json",
			    data : {
			    	stdYear : stdYear
			    },
			    dataType : 'json',   	           
			    success : function(res){        
			    	
			    	var resultList = res.chulInfoList;
			    	var chulCnt = 0;
			    	var prdArea = 0;
			    	var yearQty = 0;
			    	var yearAmt = 0;
			    	
			    	if(resultList.length > 0){
			    		for(var i=0; i<resultList.length; i++){
			    			
			    			$("#chulCnt"+resultList[i].sidoOrder).html(comma(resultList[i].chulCnt) + "호");
					    	$("#prdArea"+resultList[i].sidoOrder).html(comma(resultList[i].prdArea) + "ha");
					    	$("#yearChulQty"+resultList[i].sidoOrder).html(comma(resultList[i].yearQty) + "만단");
					    	$("#yearChulAmt"+resultList[i].sidoOrder).html(comma(resultList[i].yearAmt) + "억원");
			    			
			    			chulCnt = chulCnt+resultList[i].chulCnt;
			    			prdArea = prdArea+resultList[i].prdArea;
			    			yearQty = yearQty+resultList[i].yearQty;
			    			yearAmt = yearAmt+resultList[i].yearAmt;
			    		}
			    	}else{
			    		for(var i=1; i<8; i++){
				    		$("#chulCnt"+i).html("0호");
					    	$("#prdArea"+i).html("0ha");
					    	$("#yearChulQty"+i).html("0만단");
					    	$("#yearChulAmt"+i).html("0억원");
			    		}
			    	}
			    	
			    	$("#mainChulCnt").html(comma(chulCnt) + "호");
			    	$("#mainPrdArea").html(comma(prdArea) + "ha");
			    	$("#mainYearChulQty").html(comma(yearQty) + "만단");
			    	$("#mainYearChulAmt").html(comma(yearAmt) + "억원");
			    	
			    	
			    },
			});
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
				<li>생산/소비정보</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li>생산정보</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li class="m_right">절화류 생산현황조사</li>
			</ul>
		</div>
		<!--공통 HEADER(E)-->
		
		<!--서브 타이틀(S)-->
		<jsp:include page="../inc/2020/IncShare.jsp"/>
		
		<div class="sub_title">
			<div class="title_box">
				<h2>절화류 생산현황조사</h2>
				<img src="../images/2020/sub/t_line.png" alt="방울점선">
			</div>
		</div>
		<!--서브 타이틀(E)-->
		
		<!--컨텐츠 내용(S)-->
		<div class="sub_guide scroll_x">
		
		<div class="content_02">

		<!-- title(S) -->
		<div class="title_box">
			<div class="fr">
				<p class="tit_tag">기준년도</p>
				<div class="select_type_01">
					<select name="stdYear" id="stdYear" onchange="fn_stdYearChange();">
						<c:forEach begin="2019" end="2030" var="year">
							<option value="${year}" <c:if test="${paramMap.stdYear eq year}">selected="selected"</c:if>>${year}</option>
						</c:forEach>
					</select>
					<label for="stdYear"></label>
				</div>
			</div>
		</div>
		<!-- title(E) -->

		<!-- total date(S) -->
		<div class="total_data col4">
			<ul>
				<li>
				 	<h4 class="td_tit">재배 농가수</h4>
					<p class="data_num" id="mainChulCnt">0호</p>
				</li>
				<li>
					<h4 class="td_tit">재배 면적</h4>
					<p class="data_num" id="mainPrdArea">0 ha</p>
				</li>
				<li>
					<h4 class="td_tit">연간 출하량</h4>
					<p class="data_num" id="mainYearChulQty">0 만단</p>
				</li>
				<li>
					<h4 class="td_tit">연간 출하액</h4>
					<p class="data_num" id="mainYearChulAmt">0억원</p>
				</li>
			</ul>
		</div>
		<!-- total date(E) -->

		<!-- map data(S) -->
		<div class="map_data">

			<!-- map(S) -->
			<!-- <div class="map_chart">
				<img src="../img/map.png" alt="지도">
			</div> -->
			<!-- map(E) -->

			<!-- area01(S) -->
			<div class="area a1">
				<!-- 서울·인천·경기(S) -->
				<div class="city_data capital">

					<h4 class="c_name">
						서울·인천·경기
					</h4>

					<div class="cd_detail">
						<dl>
							<dt><h4 class="cd_tit">재배농가 수</h4></dt>
							<dd><p class="txt_data" id="chulCnt1">0호</p></dd>
						</dl>
						<dl>
							<dt><h4 class="cd_tit">재배면적</h4></dt>
							<dd><p class="txt_data" id="prdArea1">0ha</p></dd>
						</dl>
						<dl>
							<dt><h4 class="cd_tit">연간출하량</h4></dt>
							<dd><p class="txt_data" id="yearChulQty1">0만단</p></dd>
						</dl>
						<dl>
							<dt><h4 class="cd_tit">연간출하액</h4></dt>
							<dd><p class="txt_data" id="yearChulAmt1">0억원</p></dd>
						</dl>
					</div>
				</div>
				<!-- 서울·인천·경기(E) -->

				<!-- 강원(S) -->
				<div class="city_data gw">

					<h4 class="c_name">
						강원
					</h4>

					<div class="cd_detail">
						<dl>
							<dt><h4 class="cd_tit">재배농가 수</h4></dt>
							<dd><p class="txt_data" id="chulCnt5">0호</p></dd>
						</dl>
						<dl>
							<dt><h4 class="cd_tit">재배면적</h4></dt>
							<dd><p class="txt_data" id="prdArea5">0ha</p></dd>
						</dl>
						<dl>
							<dt><h4 class="cd_tit">연간출하량</h4></dt>
							<dd><p class="txt_data" id="yearChulQty5">0만단</p></dd>
						</dl>
						<dl>
							<dt><h4 class="cd_tit">연간출하액</h4></dt>
							<dd><p class="txt_data" id="yearChulAmt5">0억원</p></dd>
						</dl>
					</div>
				</div>
				<!-- 강원(E) -->
			</div>
			<!-- area01(E) -->

			<!-- area02(S) -->
			<div class="area a2">
				<!-- 대전·충청(S) -->
				<div class="city_data ct">

					<h4 class="c_name">
						대전·충청
					</h4>

					<div class="cd_detail">
						<dl>
							<dt><h4 class="cd_tit">재배농가 수</h4></dt>
							<dd><p class="txt_data" id="chulCnt2">0호</p></dd>
						</dl>
						<dl>
							<dt><h4 class="cd_tit">재배면적</h4></dt>
							<dd><p class="txt_data" id="prdArea2">0ha</p></dd>
						</dl>
						<dl>
							<dt><h4 class="cd_tit">연간출하량</h4></dt>
							<dd><p class="txt_data" id="yearChulQty2">0만단</p></dd>
						</dl>
						<dl>
							<dt><h4 class="cd_tit">연간출하액</h4></dt>
							<dd><p class="txt_data" id="yearChulAmt2">0억원</p></dd>
						</dl>
					</div>
				</div>
				<!-- 대전·충청(E) -->

				<!-- 대구·경북(S) -->
				<div class="city_data tk">

					<h4 class="c_name">
						대구·경북
					</h4>

					<div class="cd_detail">
						<dl>
							<dt><h4 class="cd_tit">재배농가 수</h4></dt>
							<dd><p class="txt_data" id="chulCnt6">0호</p></dd>
						</dl>
						<dl>
							<dt><h4 class="cd_tit">재배면적</h4></dt>
							<dd><p class="txt_data" id="prdArea6">0ha</p></dd>
						</dl>
						<dl>
							<dt><h4 class="cd_tit">연간출하량</h4></dt>
							<dd><p class="txt_data" id="yearChulQty6">0만단</p></dd>
						</dl>
						<dl>
							<dt><h4 class="cd_tit">연간출하액</h4></dt>
							<dd><p class="txt_data" id="yearChulAmt6">0억원</p></dd>
						</dl>
					</div>
				</div>
				<!-- 대구·경북(E) -->
			</div>
			<!-- area02(E) -->

			<!-- area03(S) -->
			<div class="area a3">
				<!-- 광주·전라(S) -->
				<div class="city_data kj">

					<h4 class="c_name">
						광주·전라
					</h4>

					<div class="cd_detail">
						<dl>
							<dt><h4 class="cd_tit">재배농가 수</h4></dt>
							<dd><p class="txt_data" id="chulCnt3">0호</p></dd>
						</dl>
						<dl>
							<dt><h4 class="cd_tit">재배면적</h4></dt>
							<dd><p class="txt_data" id="prdArea3">0ha</p></dd>
						</dl>
						<dl>
							<dt><h4 class="cd_tit">연간출하량</h4></dt>
							<dd><p class="txt_data" id="yearChulQty3">0만단</p></dd>
						</dl>
						<dl>
							<dt><h4 class="cd_tit">연간출하액</h4></dt>
							<dd><p class="txt_data" id="yearChulAmt3">0억원</p></dd>
						</dl>
					</div>
				</div>
				<!-- 광주·전라(E) -->

				<!-- 부산·울산·경남(S) -->
				<div class="city_data pk">

					<h4 class="c_name">
						부산·울산·경남
					</h4>

					<div class="cd_detail">
						<dl>
							<dt><h4 class="cd_tit">재배농가 수</h4></dt>
							<dd><p class="txt_data" id="chulCnt7">0호</p></dd>
						</dl>
						<dl>
							<dt><h4 class="cd_tit">재배면적</h4></dt>
							<dd><p class="txt_data" id="prdArea7">0ha</p></dd>
						</dl>
						<dl>
							<dt><h4 class="cd_tit">연간출하량</h4></dt>
							<dd><p class="txt_data" id="yearChulQty7">0만단</p></dd>
						</dl>
						<dl>
							<dt><h4 class="cd_tit">연간출하액</h4></dt>
							<dd><p class="txt_data" id="yearChulAmt7">0억원</p></dd>
						</dl>
					</div>
				</div>
				<!-- 부산·울산·경남(E) -->

				<!-- 제주(S) -->
				<div class="city_data jeju">

					<h4 class="c_name">
						제주
					</h4>

					<div class="cd_detail">
						<dl>
							<dt><h4 class="cd_tit">재배농가 수</h4></dt>
							<dd><p class="txt_data" id="chulCnt4">0호</p></dd>
						</dl>
						<dl>
							<dt><h4 class="cd_tit">재배면적</h4></dt>
							<dd><p class="txt_data" id="prdArea4">0ha</p></dd>
						</dl>
						<dl>
							<dt><h4 class="cd_tit">연간출하량</h4></dt>
							<dd><p class="txt_data" id="yearChulQty4">0만단</p></dd>
						</dl>
						<dl>
							<dt><h4 class="cd_tit">연간출하액</h4></dt>
							<dd><p class="txt_data" id="yearChulAmt4">0억원</p></dd>
						</dl>
					</div>
				</div>
				<!-- 제주(E) -->
			</div>
			<!-- area03(E) -->
		</div>
		<!-- map data(E) -->
	</div>
		<!--컨텐츠 내용(E)-->
		</div>
		
		<jsp:include page="../inc/2020/IncFooter.jsp"/>
		
	</div>
	<!--WRAP(E)-->
</body>
</html>


