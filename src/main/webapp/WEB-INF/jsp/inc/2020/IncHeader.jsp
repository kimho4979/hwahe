<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"
%><%@ taglib prefix="spring" uri="http://www.springframework.org/tags"
%><%@ taglib prefix="wenbiz" uri="http://www.wenbiz.com/tld/wenbiz"
%><%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"
%><c:set var="upperMenuId" value="${ currentMenuInfo.upperId }" scope="request" />
<c:set var="pathNms" value="${fn:split(currentMenuInfo.pathNm, '>')}" scope="request" />
<c:set var="pathIds" value="${fn:split(currentMenuInfo.pathId, '>')}" scope="request" />
<c:set var="currentMenuNm" value="${ currentMenuInfo.menuNm }" scope="request" />
<c:set var="currentMenuId" value="${ currentMenuInfo.menuId }" scope="request" />
<c:set var="currentMenuDepth" value="${ currentMenuInfo.depth }" scope="request" />
<!-- 모바일_LNB(S) -->
		<div class="m_lnb_box">
			<div class="lnb">
				<div class="lnb_header_t">
					<ul class="lnb_top">
						<li class="close_menu"><a href="#!"><img src="../images/2020/lnb_close_img.png" alt="닫기이미지"></a></li>
						<c:if test="${empty sessionScope.userId}">
						<li class="lnb_change"><a href="/customInfo/mainLoginForm.do">로그인</a></li>
						</c:if>
						<c:if test="${not empty sessionScope.userId}">
						<li class="lnb_change"><a href="/customInfo/logOut.do">로그아웃</a></li>
						<li class="lnb_change"><a href="/customInfo/mainLoginForm.do">정보수정</a></li>
						</c:if>
					</ul>
				</div>
				<ul class="m_depth_01">
					<li>
						<a href="#!">경매정보<p>┼</p></a>
						<ul class="m_depth_02">
							<li>
								<a href="#!">경매실적<p>┼</p></a>
								<ul class="m_depth_03">
									<li><a href="/real/real2.do">실시간 경매실적</a></li>
									<li><a href="/yuchal/yuchal.do">일자별 유찰정보</a></li>
									<li><a href="/hab09/hab09.do">일자별 경매결과</a></li>
									<!-- <li><a href="/hab01/hab01.do">일자별 경매정보</a></li> -->
								</ul>
							</li>
						</ul>
						<ul class="m_depth_02">
							<li>
								<a href="#!">경매통계<p>┼</p></a>
								<ul class="m_depth_03">
									<li><a href="/haa00/haa00.do">기간별 경매통계 조회</a></li>
									<li><a href="/hab11/hab11.do">경매통계비교</a></li>
									<li><a href="/hab10/hab10.do">연도별실적</a></li>
									<li><a href="/hab06/hab06.do">월별 전년대비 실적</a></li>
									<!-- <li><a href="/hab02/hab02.do">월별경매정보</a></li> -->
									<li><a href="/hab07/hab07.do">지역별 월별 출하실적</a></li>
									<li><a href="/haa05/haa05.do">품목·품종별 출하시기</a></li>
									<li><a href="/haa06/haa06.do">주간거래동향</a></li>
								</ul>
							</li>
						</ul>
					</li>
				</ul>
				<ul class="m_depth_01">
					<li>
						<a href="#!">열린광장<p>┼</p></a>
						<ul class="m_depth_02">
							<li>
								<a href="#!">알림마당<p>┼</p></a>
								<ul class="m_depth_03">
									<li><a href="/hfa01/hfa01.do">공지사항</a></li>
									<li><a href="/customInfo/customInfoForm.do">가격문자알림서비스</a></li>
									<li><a href="/hfc02/hfc02.do">주요행사일정</a></li>
									<li><a href="/hfd01/hfd01.do">Flower Gallery</a></li>
								</ul>
							</li>
						</ul>
					</li>
				</ul>
				<ul class="m_depth_01">
					<li>
						<a href="#!">공공데이터<p>┼</p></a>
						<ul class="m_depth_02">
							<li>
								<a href="#!">공공데이터<p>┼</p></a>
								<ul class="m_depth_03">
									<li><a href="/api/apiOpenInfo.do">데이터 개방 정보</a></li>
									<li><a href="/api/apiOpenApply.do">데이터 개방 신청</a></li>
								</ul>
							</li>
						</ul>

						<ul class="m_depth_02">
							<li>
								<a href="#!">타기관정보<p>┼</p></a>
								<ul class="m_depth_03">
									<li><a href="/hga01/hga01.do">월간 화훼 수출입 현황</a></li>
									<li><a href="/hga03/hga03.do">식물 검역정보</a></li>
									<li><a href="/hga08/hga08.do">화훼 재배현황</a></li>
									<li><a href="/hga07/hga07.do">지역별 화훼관련 사업체 정보</a></li>
								</ul>
							</li>
						</ul>
						<c:if test="${sessionScope.acsYn eq 'Y'}">
						<ul class="m_depth_02">
							<li>
								<a href="#!">농식품부 보고자료<p>┼</p></a>
								<ul class="m_depth_03">
									<li><a href="/report/mainFlowerAuc.do">주요 절화류 도매가격 동향</a></li>
									<li><a href="/report/dayPumAuc.do">일별 품목별 경매실적 및 동향</a></li>
									<li><a href="/report/dayAuc.do">일별경매실적</a></li>
								</ul>
							</li>
						</ul>


						</c:if>
					</li>
				</ul>

			</div>
		</div>
		<!-- 모바일_LNB(E)-->

		<!--공통 HEADER(S)-->
		<div class="dim"></div>
		<div class="header">
			<div class="header_menu">
				<div class="header_in">
					<!-- 모바일 햄버거 메뉴 버튼(S) -->
					<a href="#!"  aria-label="flowerMain"  class="btn_m_menu"></a>
					<!-- 모바일 햄버거 메뉴 버튼(E) -->
					<!-- 왼쪽상단 로고(S) -->
					<div class="logo_box">
						<a href="/main/flowerMain.do"  aria-label="flowerMain"   class="btn_home"></a>
					</div>
					<!-- 왼쪽상단 로고(E) -->
					<!-- 헤더메뉴(S) -->
					<div class="menu_box">
						<wenbiz:menu attributeName="depth1MenuVO" menuId="${pathIds[0]}" />
							<c:forEach items="${depth1MenuVO.children}" var="depth2Menu" varStatus="depth2Idx">
								<wenbiz:menu attributeName="depth2MenuVO" menuId="${depth2Menu.menuId}" />
									<a href="${depth2Menu.url}">${depth2Menu.menuNm}</a>
							</c:forEach>
					</div>
					<!-- 헤더메뉴(E) -->
					<!-- 로그인(S) -->
					<c:if test="${empty sessionScope.userId}">
					<div class="login_box">
						<div class="login_h">
							<a href="/customInfo/mainLoginForm.do">로그인</a>
						</div>
						<!-- sns연동(S) -->
						<!-- <ul class="sns_box">
							<li><a href="javascript:;"><img src="../../images/main/sns_01.png" alt="페이스북"></a></li>
							<li><a href="javascript:;"><img src="../images/main/sns_02.png" alt="트위터"></a></li>
							<li><a href="javascript:;"><img src="../images/main/sns_03.png" alt="네이버밴드"></a></li>
							<li><a href="javascript:;"><img src="../images/main/sns_04.png" alt="링크복사"></a></li>
						</ul> -->
						<!-- sns연동(E) -->

					</div>

					</c:if>
					<c:if test="${not empty sessionScope.userId}">
					<div class="login_box">
						<div class="login_f">
							<a href="/customInfo/mainLoginForm.do">정보수정</a>
						</div>
						<div class="login_h">
							<a href="/customInfo/logOut.do">로그아웃</a>
						</div>
					</div>
					</c:if>

					<!-- <span class="line_01"></span> -->

					<!-- 로그인(E) -->

				</div>
			</div>
			<!--HEADER(E)-->
			<!-- 슬라이드메뉴(S) -->
			<div class="slide_menu">
				<div class="s_m_in">
					<div class="menu_list open">
						<c:if test="${!empty depth1MenuVO && !empty depth1MenuVO.children}">
							<c:forEach items="${depth1MenuVO.children}" var="depth2Menu" varStatus="depth2Idx">
								<wenbiz:menu attributeName="depth2MenuVO" menuId="${depth2Menu.menuId}" />
									<c:if test="${!empty depth2MenuVO && !empty depth2MenuVO.children}">
										<c:forEach items="${depth2MenuVO.children}" var="depth3Menu" varStatus="depth3Idx">
											<wenbiz:menu attributeName="depth3MenuVO" menuId="${depth3Menu.menuId}"/>
												<c:if test="${depth3Idx.first eq true || depth3Menu.menuId eq 49}">
													<ul class="m_l_in">
												</c:if>
												<c:choose>
												    <c:when test="${depth3Menu.menuId eq 59}">
												        <c:if test="${sessionScope.acsYn eq 'Y'}">
												            <li class="f18">${depth3Menu.menuNm}</li>
												            <c:if test="${!empty depth3MenuVO && !empty depth3MenuVO.children}">
												                <c:forEach items="${depth3MenuVO.children}" var="depth4Menu" varStatus="depth4Idx">
												                    <wenbiz:menu attributeName="depth4MenuVO" menuId="${depth4Menu.menuId}"/>
												                    <li><a href="${depth4Menu.url}">${depth4Menu.menuNm}</a></li>
												                </c:forEach>
												            </c:if>
												        </c:if>
												    </c:when>
												    <c:otherwise>
												        <li class="f18">${depth3Menu.menuNm}</li>
												        <c:if test="${!empty depth3MenuVO && !empty depth3MenuVO.children}">
												            <c:forEach items="${depth3MenuVO.children}" var="depth4Menu" varStatus="depth4Idx">
												                <wenbiz:menu attributeName="depth4MenuVO" menuId="${depth4Menu.menuId}"/>
												                <li><a href="${depth4Menu.url}">${depth4Menu.menuNm}</a></li>
												            </c:forEach>
												        </c:if>
												    </c:otherwise>
												</c:choose>
												<c:if test="${depth3Idx.first eq false && depth3Idx.last eq true || depth3Idx.first eq true && depth3Idx.last eq true || depth3Menu.menuId eq 6}">
													</ul>
												</c:if>
										</c:forEach>
									</c:if>
							</c:forEach>
						</c:if>
					</div>
					<div class="menu_explain">
						<div class="img_01">
							<span class="img_place"></span>
							<h2 class="m_title">경매정보</h2>
							<h3 class="m_sub_title">경매정보를 통한 신속한 분석</h3>
						</div>
						<div class="img_03">
							<span class="img_place"></span>
							<h2 class="m_title">열린광장</h2>
							<h3 class="m_sub_title">고객과의 소통</h3>
						</div>
						<div class="img_04">
							<span class="img_place"></span>
							<h2 class="m_title">공공데이터</h2>
							<h3 class="m_sub_title">공공데이터 제공</h3>
						</div>
						<div class="img_02">
							<span class="img_place"></span>
							<h2 class="m_title">통계기타</h2>
							<h3 class="m_sub_title">기타 통계정보 제공</h3>
						</div>
					</div>
				</div>
			</div>
			<!-- 슬라이드메뉴(E) -->
		</div>
		<!--공통 HEADER(E)-->
