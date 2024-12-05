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
	<title>데이터 개방 정보</title>
	<%@include file="../common/2020/commonJs.jsp" %>
	<%@include file="../common/2020/commonCss.jsp" %>
	
	<script type="text/javascript">	
		function samplePage(reqDataCd){
			userId = "${sessionScope.userId}";
			$.ajax({
				type : "post",
				url : "/api/selectCheckList.json",
				data : {
					userId : userId,
					reqDataCd : reqDataCd
				},
				dataType : '',
				success : function(res){
					var val = res.list;
					var serviceKey = val[0].serviceKey;
					var baseDate = "2018-08-16";
					var numOfRow = "10";
					if(reqDataCd == 'f001'){
						var flowerGubn = "1";
						var param = "?kind="+reqDataCd+"&serviceKey="+serviceKey+"&baseDate="+baseDate+"&countPerPage=10&flowerGubn="+flowerGubn+"&dataType=json";
					}else if(reqDataCd == 'f002'){
						var flowerGubn = '1';
						var baseDate = "2018-08-13";
						var param = "?kind="+reqDataCd+"&serviceKey="+serviceKey+"&baseDate="+baseDate+"&flowerGubn="+flowerGubn+"&countPerPage=10&dataType=json";
					}
					alert("샘플 URL 페이지로 이동합니다.");
					location.href = "/api/apiOpenInfoExsist.do"+param;
				}
			});
		}
		
		function goBackPage(){
			location.href = "/api/apiOpenInfo.do";
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
				<h2>공공데이터 개방 신청 현황</h2>
				<img src="../images/2020/sub/t_line.png" alt="방울점선">
			</div>
		</div>
		<!--서브 타이틀(E)-->
		<!--서브공통 (S)-->
		<div class="sub_contents">
		
		</div>
		<!--컨텐츠 내용(S)-->
		<div class="sub_guide">
			<input type="hidden" id="openTerm" name="openTerm" value=""/>
			<!--상세기능 정보-->
			<div class="datalog04_b">
				<h2 class="title_02">상세기능 정보</h2>
				<table>
					<caption>상세기능 정보</caption>
					<colgroup>
						<col style="width:10%">
						<col style="width:30%">
						<col style="width:45%">
						<col style="width:15%">
						<col style="width:10%">
					</colgroup>
					<thead>
						<tr>							
							<th>상세기능</th>
							<th>설명</th>
							<th>서비스키</th>
							<th>일일트래픽</th>
							<th>샘플보기</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${dataList[0].reqDataCd != '0'}">
								<c:forEach var="item" items="${dataList}" varStatus="status">
									<tr>
										<td>${item.reqDataNm}</td>
										<td>${item.menual}</td>
										<td>${item.serviceKey }</td>
										<td>${item.maxCallCnt}</td>
										<td><button type="button" class="btn10" onclick="samplePage('${item.reqDataCd}');">샘플보기</button></td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="4">신청한 공공데이터가 없습니다.</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>
			<div class="opendata01_b">			
				<div class="sevi_box03_b">
					<button type="button" onclick="goBackPage()">뒤로가기</button>
				</div>
			</div>
			
		</div>
		
		<!--컨텐츠 내용(E)-->
		
		<jsp:include page="../inc/2020/IncFooter.jsp"/>
			
	</div>
	<!--WRAP(E)-->
</body>
</html>