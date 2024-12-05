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
						<li class="lnb_change"><a href="/customInfo/mainLoginForm.do">정보수정</a></li>
						<li class="lnb_change"><a href="/customInfo/logOut.do">로그아웃</a></li>
						</c:if>
					</ul>
				</div>
				<div class="lnb_header_t01">
					<div class="lnb_txt">
						<p>자주찾는 메뉴 > </p>
					</div>
					<div class="lnb_txt_box">
						<ul class="lnb_txt_btn">
							<li><a href="/hab01/hab01.do">일자별 경매정보</a></li>
							<li><a href="/yuchal/yuchal.do">일자별 유찰현황</a></li>
							<li><a href="/hga01/hga01.do">월간 화훼 수출입 현황</a></li>						
							<li><a href="/haa04/haa04.do">주요거래지표</a></li>
						</ul>
					</div>
				</div>
				<ul class="m_depth_01">
					<li>
						<a href="#!">경매정보<p>┼</p></a>
						<ul class="m_depth_02">
							<li>
								<a href="#!">경매실적<p>┼</p></a>
								<ul class="m_depth_03">
									<li><a href="/real/real2.do">실시간 경매정보</a></li>
									<li><a href="/hab01/hab01.do">일자별 경매정보</a></li>
									<li><a href="/yuchal/yuchal.do">일자별 유찰현황</a></li>
								</ul>
							</li>
						</ul>
						<ul class="m_depth_02">
							<li>
								<a href="#!">경매실적 세부정보<p>┼</p></a>
								<ul class="m_depth_03">
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
								</ul>
							</li>
						</ul>
						<ul class="m_depth_02">
							<li>
								<a href="#!">공판장 통합정보<p>┼</p></a>
								<ul class="m_depth_03">
									<li><a href="/item/itemdaily.do">일자별 품목 경매정보</a></li>
									<li><a href="/kind/kinddaily.do">일자별 품종 경매정보</a></li>
									<li><a href="/item/itemmonthly.do">월별 품목 경매정보</a></li>
									<li><a href="/kind/kindmonthly.do">월별 품종 경매정보</a></li>
									<li><a href="/item/itempopular.do">인기품목</a></li>
									<li><a href="/hab08/hab08.do">공판장별 거래현황</a></li>
								</ul>
							</li>
						</ul>
					</li>
				</ul>
				<ul class="m_depth_01">
					<li>
						<a href="#!">생산/소비정보<p>┼</p></a>
						<ul class="m_depth_02">
							<li>
								<a href="#!">출하 및 작황정보(장미)<p>┼</p></a>
								<ul class="m_depth_03">
									<li><a href="/hca01/hca01.do">출하 및 예정물량</a></li>
									<li><a href="/hca02/hca02.do">재배동향</a></li>
									<li><a href="/hca03/hca03.do">작황정보</a></li>
								</ul>
							</li>
						</ul>
						<ul class="m_depth_02">
							<li>
								<a href="#!">소비동향(장미)<p>┼</p></a>
								<ul class="m_depth_03">
									<li><a href="/auction/SalePrice.do">소비동향</a></li>
								</ul>
							</li>
						</ul>
						<ul class="m_depth_02">
							<li>
								<a href="#!">소매가격(장미)<p>┼</p></a>
								<ul class="m_depth_03">
									<li><a href="/hdb01/hdb01.do">소매가격동향</a></li>
								</ul>
							</li>
						</ul>
						<ul class="m_depth_02">
							<li>
								<a href="#!">장미가격 예측정보<p>┼</p></a>
								<ul class="m_depth_03">
									<li><a href="/preRose/preRose.do">장미가격 예측정보</a></li>
									<li><a href="/preRose/preRoseEstimation.do">장미가격 예측평가</a></li>
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
									<li><a href="/customInfo/customInfoForm.do">가격문자알림서비스</a></li>
									<li><a href="/hfa01/hfa01.do">공지사항</a></li>
									<li><a href="/hfc01/hfc01.do">기념일달력</a></li>
									<li><a href="/bbs/customerBbsList.do">고객상담실</a></li>
									<li><a href="#" onclick="window.open('/main/situationNew.do','_blank','');">화훼유통정보상황판 </a></li>
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
								<a href="#!">타 기관정보<p>┼</p></a>
								<ul class="m_depth_03">
									<li><a href="/hga02/hga02.do">기상동향 분석</a></li>
									<li><a href="/hga01/hga01.do">월간 화훼 수출입 현황</a></li>
									<li><a href="/hga03/hga03.do">식물검역정보</a></li>
								</ul>
							</li>
						</ul>
					</li>
				</ul>
			</div>
		</div>
		<!-- 모바일_LNB(E)-->
		
		<!--공통 HEADER(S)-->
		<div class="dim"></div>
		<div class="header">
			<div class="header_boxt">
				<div class="header_line">
					<ul class="header_t">
						<li>자주찾는 메뉴 ></li>
						<li><a href="/hab01/hab01.do">일자별 경매정보</a></li>
						<li><a href="/yuchal/yuchal.do">일자별 유찰현황</a></li>
						<li><a href="/hga01/hga01.do">월간 화훼 수출입 현황</a></li>						
						<li><a href="/haa04/haa04.do">주요거래지표</a></li>
					</ul>
				</div>
			</div>

			<div class="header_menu">
				<div class="header_in">
					<!-- 왼쪽상단 로고(S) -->
					<div class="logo_box">
						<a href="/main/flowerMain.do" class="btn_home"></a>
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
					<!-- 모바일 햄버거 메뉴 버튼(S) -->
					<a href="#!" class="btn_m_menu"></a>
					<!-- 모바일 햄버거 메뉴 버튼(E) -->
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
												<li class="f18">${depth3Menu.menuNm}</li>
												<c:if test="${!empty depth3MenuVO && !empty depth3MenuVO.children}">
													<c:forEach items="${depth3MenuVO.children}" var="depth4Menu" varStatus="depth4Idx">
														<wenbiz:menu attributeName="depth4MenuVO" menuId="${depth4Menu.menuId}"/>
															<li><a href="${depth4Menu.url}">${depth4Menu.menuNm}</a></li>
													</c:forEach>
												</c:if>
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
						<div class="img_02">
							<span class="img_place"></span>
							<h2 class="m_title">생산/소비정보</h2>
							<h3 class="m_sub_title">생산 및 소비정보를 분석</h3>
						</div>
						<div class="img_03">
							<span class="img_place"></span>
							<h2 class="m_title">열린 광장</h2>
							<h3 class="m_sub_title">고객과의 소통</h3>
						</div>
						<div class="img_04">
							<span class="img_place"></span>
							<h2 class="m_title">공공데이터</h2>
							<h3 class="m_sub_title">공공데이터 제공</h3>
						</div>
					</div>
				</div>
			</div>
			<!-- 슬라이드메뉴(E) -->
		</div>		
				
		<!-- <div class="lnb_box">
			<ul>
				<li><img src="../images/2020/m_lnb_img.png" alt="집"></li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li>경매정보</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li>경매실적</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li class="m_right">실시간 경매정보</li>
			</ul>
		</div> -->
		
		<!--공통 HEADER(E)-->