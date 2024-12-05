<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

	<div id="header">
		<h1 class="blind">화훼유통정보시스템</h1>
		<ul class="header01">
			<li class="logo"><a href="/main/flowerMain.do">로고</a></li>
			<c:if test="${empty sessionScope.userId}">
				<li class="login_btn"><a href="/customInfo/mainLoginForm.do">로그인</a></li>
			</c:if>
			<c:if test="${not empty sessionScope.userId}">
				<li class="custom_btn">
					<a href="/customInfo/mainLoginForm.do">정보수정</a>
				</li>
				<li class="logout_btn">
					<a href="/customInfo/logOut.do">로그아웃</a>
				</li>
			</c:if>
			
		</ul><!-- header01 end -->
		
		<nav class="nav">
			<ul class="gnb">
				<li class="li01"><a href="#">경매정보</a>
					<ul class="sub_gnb">
						<li>경매실적</li>
						<li><a href="/real/real2.do">실시간 경매정보</a></li>
						<li><a href="/hab01/hab01.do">일자별 경매정보</a></li>
						<li><a href="/yuchal/yuchal.do">일자별 유찰현황</a></li>
						<li>경매실적 세부정보</li>
						<li><a href="/hab02/hab02.do">월별 경매정보</a></li>
						<li><a href="/hab03/hab03.do">경락단가내역</a></li>
						<li><a href="/hab04/hab04.do">품목별 총 거래정보</a></li>
						<li><a href="/hab05/hab05.do">품종별 총 거래정보</a></li>
						<li><a href="/hab06/hab06.do">월별전년대비실적</a></li>
						<li><a href="/hab07/hab07.do">지역별 월별 출하실적</a></li>
						<li><a href="/haa01/haa01.do">경매기록부</a></li>
						<li><a href="/haa02/haa02.do">품목경락가격</a></li>
						<li><a href="/haa03/haa03.do">품종경락가격</a></li>
						<li><a href="/haa04/haa04.do">주요거래지표</a></li>
					</ul><!-- sub_gnb end -->
				</li>
				<li class="li02"><a href="#">생산/소비정보</a>
					<ul class="sub_gnb">
						<li>출하 및 작황정보</li>
						<li><a href="/hca01/hca01.do">출하 및 예정물량</a></li>
						<li><a href="/hca02/hca02.do">재배동향</a></li>
						<li><a href="/hca03/hca03.do">작황정보</a></li>
						<li>소비동향(장미)</li>
						<li><a href="/auction/SalePrice.do">소비동향</a></li>
						<li>소매가격(장미)</li>
						<li><a href="/hdb01/hdb01.do">소매가격동향</a></li>
					</ul><!-- sub_gnb end -->
				</li>
				<li class="li04"><a href="#">장미가격 예측정보</a>
					<ul class="sub_gnb">
						<li>장미가격 예측정보</li>
						<li><a href="/preRose/preRose.do">장미가격 예측정보</a></li>
						<li><a href="/preRose/preRoseEstimation.do">장미가격 예측평가</a></li>
					</ul><!-- sub_gnb end -->
				</li>
				<li class="li05"><a href="#">열린광장</a>
					<ul class="sub_gnb">
						<li>알림마당</li>
						<li><a href="/customInfo/customInfoForm.do">가격문자알림서비스</a></li>
						<li><a href="/hfa01/hfa01.do">공지사항</a></li>
						<li><a href="/hfc01/hfc01.do">기념일달력</a></li>
						<li><a href="/bbs/customerBbsList.do">고객상담실</a></li>
						<li><a href="#" onclick="window.open('/main/situationNew.do','_blank','');">화훼유통정보상황판</a></li>
					</ul><!-- sub_gnb end -->
				</li>
				<li class="li06"><a href="#">공공데이터</a>
					<ul class="sub_gnb">
						<li>공공데이터</li>
						<li><a href="/api/apiOpenInfo.do">데이터 개방 정보</a></li>
						<li><a href="/api/apiOpenApply.do">데이터 개방 신청</a></li>
						<li>타 기관 정보</li>
						<li><a href="/hga02/hga02.do">기상동향 분석</a></li>
						<li><a href="/hga01/hga01.do">월간 화훼 수출입 현황</a></li>
						<li><a href="/hga03/hga03.do">식물검역정보</a></li>
						<!-- <li>예측 알고리즘</li>
						<li><a href="#">장미가격 예측서비스</a></li>
						<li><a href="#">장미가격 통계정보</a></li>
						<li><a href="#">알고리즘 검증</a></li> -->
					</ul><!-- sub_gnb end -->
				</li>
			</ul><!-- gnb end -->
			<div class="bg_subgnb">&nbsp;</div>
		</nav><!-- nav end -->
		<p class="mb_naviBar"><a href="#">전체메뉴</a></p>
		<nav class="mb_nav">
			<p class="btn_close"><img src="../images/btn/closeBtn.png" alt="닫기"/></p>
			<c:if test="${empty sessionScope.userId}">
				<p class="mb_logout_btn"><a href="/customInfo/mainLoginForm.do">로그인</a></p>
			</c:if>
			<c:if test="${not empty sessionScope.userId}">
				<p class="mb_logout_btn"><a href="/customInfo/logOut.do">로그아웃</a></p>
			</c:if>
			
			
			<ul class="mb_gnb">
				<li class="on"><a href="#">경매정보</a>
					<ul class="mb_sub_gnb on">
						<li class="tit">경매실적</li>
						<li><a href="/real/real2.do"> - 실시간 경매정보</a></li>
						<li><a href="/hab01/hab01.do"> - 일자별 경매정보</a></li>
						<li><a href="/yuchal/yuchal.do"> - 일자별 유찰현황</a></li>
						<li class="tit">경매실적 세부정보</li>
						<li><a href="/hab02/hab02.do"> - 월별 경매정보</a></li>
						<li><a href="/hab03/hab03.do"> - 경락단가내역</a></li>
						<li><a href="/hab04/hab04.do"> - 품목별 총 거래정보</a></li>
						<li><a href="/hab05/hab05.do"> - 품종별 총 거래정보</a></li>
						<li><a href="/hab06/hab06.do"> - 월별전년대비실적</a></li>
						<li><a href="/hab07/hab07.do"> - 지역별 월별 출하실적</a></li>
						<li><a href="/haa01/haa01.do"> - 경매기록부</a></li>
						<li><a href="/haa02/haa02.do"> - 품목경락가격</a></li>
						<li><a href="/haa03/haa03.do"> - 품종경락가격</a></li>
						<li><a href="/haa04/haa04.do"> - 주요거래지표</a></li>
					</ul><!-- mb_sub_gnb end -->
				</li>
				<li><a href="#">생산/소비정보</a>
					<ul class="mb_sub_gnb">
						<li class="tit">출하 및 작황정보</li>
						<li><a href="/hca01/hca01.do"> - 출하 및 예정물량</a></li>
						<li><a href="/hca02/hca02.do"> - 재배동향</a></li>
						<li><a href="/hca03/hca03.do"> - 작황정보</a></li>
						<li class="tit">소비동향(장미)</li>
						<li><a href="/auction/SalePrice.do"> - 소비동향</a></li>
						<li class="tit">소매가격(장미)</li>
						<li><a href="/hdb01/hdb01.do"> - 소매가격동향</a></li>
					</ul><!-- mb_sub_gnb end -->
				</li>					
				<li><a href="#">장미가격 예측정보</a>
					<ul class="mb_sub_gnb">
						<li class="tit">장미가격 예측정보</li>
						<li><a href="/preRose/preRose.do">- 장미가격 예측정보</a></li>
						<li><a href="/preRose/preRoseEstimation.do">- 장미가격 예측평가</a></li>
					</ul><!-- mb_sub_gnb end -->
				</li>
				<li><a href="#">열린광장</a>
					<ul class="mb_sub_gnb">
						<li class="tit">알림마당</li>
						<li><a href="/customInfo/customInfoForm.do">- 가격문자알림서비스</a></li>
						<li><a href="/hfa01/hfa01.do"> - 공지사항</a></li>
						<li><a href="/hfc01/hfc01.do"> - 기념일달력</a></li>
						<li><a href="/bbs/customerBbsList.do"> - 고객상담실</a></li>
						<!-- <li><a href="#" onclick="window.open('/main/situationNew.do','_blank','');"> - 화훼유통정보상황판</a></li> -->
					</ul><!-- mb_sub_gnb end -->
				</li>
				<li><a href="#">공공데이터</a>
					<ul class="mb_sub_gnb">
						<li class="tit">공공데이터</li>
						<li><a href="/api/apiOpenInfo.do"> - 데이터 개방 정보</a></li>
						<li><a href="/api/apiOpenApply.do"> - 데이터 개방 신청</a></li>
						<li class="tit">타 기관 정보</li>
						<li><a href="/hga02/hga02.do">- 기상동향 분석</a></li>
						<li><a href="/hga01/hga01.do">- 월간 화훼 수출입 현황</a></li>
						<li><a href="/hga03/hga03.do">- 식물검역정보</a></li>
					</ul><!-- mb_sub_gnb end -->
				</li>
			</ul><!-- mb_gnb end -->
			
		</nav><!-- mb_nav end -->
		
	</div><!-- header end -->
	
	