<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!doctype html>
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
	<meta name="description" content="가격문자알림서비스">
	<meta name="content" content="화훼유통정보시스템 입니다."/>
	<meta name="keywords" content="화훼경매시세, 화훼경매가격, Korea aT flower market auction price, 화훼공판장, 화훼거래정보, 꽃시장, 꽃값">
	<meta name="Author" content="화훼유통정보시스템 & www.woorim.co.kr"/>
	<title>가격문자알림서비스</title>
	<%@include file="../common/2020/commonJs.jsp" %>
	<%@include file="../common/2020/commonCss.jsp" %>
	
	<script type="text/javascript">
		$(document).ready(function(){
			$("#btn1").click(function(){
				var url = "/main/flowerMain.do";
				$(location).attr('href',url);
			});
			
			$("#btn2").click(function(){
				var url = "/customInfo/loginCustomInfo.do";
				$(location).attr('href',url);
			});
		});
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
					<h2 class="log_tit">가격문자 알림 서비스 설정</h2>
					<p class="log_sant"></p>
				</div>
				<!-- 서브타이틀(E) -->				
				
				<!-- 회원가입순서(S) -->
				<div class="sign_step">
				</div>
				<!-- 회원가입순서(E) -->
				
				<!-- 회원가입 내용(S) -->
				<!-- <div class="tit_box_01">
					<div class="fl">
						<h3 class="sub_title_01">가격문자 알림 서비스 설정</h3>
					</div>
				</div> -->
				
				<div class="notice_box_01 tc">
					<p class="notice_02">가격문자 알림 서비스 설정이 모두 <span class="color_g">완료</span>되었습니다.</p>
				</div>
				
			
				<!-- 회원가입 내용(E) -->

				<div class="btn_box tc">
					<a href="javascript:void(0);" class="btn_type_02" id="btn1">메인으로 가기</a>
					<a href="javascript:void(0);" class="btn_type_02" id="btn2">설정으로 가기</a>
				</div>
			</div>
		</div>
		<!--콘텐츠_메인(E)-->

		<jsp:include page="../inc/2020/IncFooter.jsp"/>
		
	</div>
	<!--WRAP(E)-->
</body>
</html>