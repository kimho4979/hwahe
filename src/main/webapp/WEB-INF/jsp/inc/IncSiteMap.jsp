<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

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
	<meta name="description" content="사이트맵">
	<meta name="content" content="화훼유통정보시스템 입니다.">
	<meta name="keywords" content="화훼경매시세, 화훼경매가격, Korea aT flower market auction price, 화훼공판장, 화훼거래정보, 꽃시장, 꽃값">
	<meta name="Author" content="화훼유통정보시스템 & www.woorim.co.kr">
	<title>사이트맵</title>
	<%@include file="../common/2020/commonJs.jsp" %>
	<%@include file="../common/2020/commonCss.jsp" %>
  
	<script type="text/javascript">
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
				<li class="m_right">사이트맵</li>
			</ul>
		</div>
		<!--공통 HEADER(E)-->
		
		<!--서브 타이틀(S)-->
		
		<div class="sub_title">
			<div class="title_box">
				<h2>화훼유통정보시스템 사이트맵</h2>
				<img src="../images/2020/sub/t_line.png" alt="방울점선">
			</div>
		</div>
		<!--서브 타이틀(E)-->
		<!--서브공통 (S)-->
		<div class="sub_contents">
			<div class="sitemap_box">
				<ul class="sitemap">
					<li class="site_block"><h4 class="s_tit_big">경매정보</h4></li>
					<li class="s_b_01">
						<p class="s_tit_mid">경매실적</p>
						<a href="/real/real2.do" class="s_menu">실시간 경매정보</a>
						<a href="/yuchal/yuchal.do" class="s_menu">일자별 유찰현황</a>
						<a href="/hab09/hab09.do" class="s_menu">일자별 경매결과</a>
					</li>
					<li class="s_b_01">
						<p class="s_tit_mid">경매통계</p>
						<a href="/hab10/hab10.do" class="s_menu">연도별실적</a>
						<a href="/hab06/hab06.do" class="s_menu">월별전년대비실적</a>
						<a href="/haa00_new/haa00_new.do" class="s_menu">기간별경매통계조회</a>
						<a href="/hab11/hab11.do" class="s_menu">경매통계비교</a>
						<a href="/hab07/hab07.do" class="s_menu">지역별 월별 출하실적</a>
					</li>
				</ul>
				<ul class="sitemap">
					<li class="site_block"><h4 class="s_tit_big">열린광장</h4></li>
					<li class="s_b_01">
						<p class="s_tit_mid">알림마당</p>
						<a href="/customInfo/customInfoForm.do" class="s_menu">가격문자알림서비스</a>
						<a href="/hfa01/hfa01.do" class="s_menu">공지사항</a>
						<a href="/hfc02/hfc02.do" class="s_menu">주요행사일정</a>
					</li>
				</ul>
				<ul class="sitemap">
					<li class="site_block"><h4 class="s_tit_big">공공데이터</h4></li>
					<li class="s_b_01">
						<p class="s_tit_mid">공공데이터</p>
						<a href="/api/apiOpenInfo.do" class="s_menu">데이터 개방 정보</a>
						<a href="/api/apiOpenApply.do" class="s_menu">데이터 개방 신청</a>
					</li>
					<li class="s_b_01">
						<p class="s_tit_mid">타 기관정보</p>
						<a href="/hga01/hga01.do" class="s_menu">월간 화훼 수출입 현황</a>
						<a href="/hga03/hga03.do" class="s_menu">식물검역정보</a>
					</li>
				</ul>
			</div>
		</div>
		
		<jsp:include page="../inc/2020/IncFooter.jsp"/>
		
	</div>
	<!--WRAP(E)-->
</body>
</html>