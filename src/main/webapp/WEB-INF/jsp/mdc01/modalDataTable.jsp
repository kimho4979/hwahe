<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<c:if test="${monitorType eq 'A' || monitorType eq 'P' }">
	<div id="shipmntEx">
		<h4 class="ma_title">출하예정물량</h4>
		<table class="modalList">
			<caption>정산내역(출하예정물량) 상세 내용입니다.</caption>
			<thead>
				<tr>
					<th>날짜구분</th><th>출하코드</th><th>출하예정지역</th><th>품종</th>
					<th>예정출하량</th><th>출하구분</th><th>출하내용</th><th>출하등록일</th><th>출하수정일</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="data1" items="${shipmntEx }">
					<tr>
						<td>
							<c:if test="${data1.DAYS_GUBN eq '1' }">초순</c:if>
							<c:if test="${data1.DAYS_GUBN eq '2' }">중순</c:if>
							<c:if test="${data1.DAYS_GUBN eq '3' }">하순</c:if>
						</td>
						<td>${data1.CHUL_NO }</td><td>${data1.MARKET_NAME }</td><td>${data1.GOOD_NAME }</td>
						<td>${data1.QTY }</td><td>${data1.GUBN_NAME }</td><td>${data1.BIGO }</td><td>${data1.REG_DT }</td><td>${data1.UPT_DT }</td>
					</tr>
				</c:forEach>
				<c:if test="${empty shipmntEx }">
					<tr><td colspan="9">등록된 내용이 없습니다.</td></tr>
				</c:if>
			</tbody>
		</table>
	</div>
	<div id="shipmnt">
		<h4 class="ma_title">출하물량</h4>
		<table class="modalList">
			<caption>정산내역(출하물량) 상세 내용입니다.</caption>
			<thead>
				<tr>
					<th>날짜구분</th><th>출하코드</th><th>출하지역</th><th>품종</th>
					<th>출하량</th><th>출하구분</th><th>출하내용</th><th>등록일</th><th>수정일</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="data2" items="${shipmnt }">
					<tr>
						<td>
							<c:if test="${data2.DAYS_GUBN eq '1' }">초순</c:if>
							<c:if test="${data2.DAYS_GUBN eq '2' }">중순</c:if>
							<c:if test="${data2.DAYS_GUBN eq '3' }">하순</c:if>
						</td>
						<td>${data2.CHUL_NO }</td><td>${data2.MARKET_NAME }</td><td>${data2.GOOD_NAME }</td>
						<td>${data2.QTY }</td><td>${data2.GUBN_NAME }</td><td>${data2.BIGO }</td><td>${data2.REG_DT }</td><td>${data2.UPT_DT }</td>
					</tr>
				</c:forEach>
				<c:if test="${empty shipmnt }">
					<tr><td colspan="9">등록된 내용이 없습니다.</td></tr>
				</c:if>
			</tbody>
		</table>
	</div>
</c:if>
<c:if test="${monitorType eq 'A' }">
	<div id="cropReport">
		<h4 class="ma_title">작황동향</h4>
		<table class="modalList">
			<caption>작황동향 상세내역입니다.</caption>
			<thead>
				<tr>
					<th>조사일자</th>
					<th>품목명</th>
					<th>품종명</th>
					<th>작황정보(전년대비)</th>
					<th>일조량</th>
					<th>기후</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="data3" items="${crop }">
					<tr>
						<td>${data3.REG_DATE }</td>
						<td>${data3.PUM_NAME }</td>
						<td>${data3.GOOD_NAME }</td>
						<td>
							<c:if test="${data3.STATUS eq '0' }">매우나쁨</c:if>
							<c:if test="${data3.STATUS eq '1' }">나쁨</c:if>
							<c:if test="${data3.STATUS eq '2' }">좋음</c:if>
							<c:if test="${data3.STATUS eq '3' }">매우좋음</c:if>
						</td>
						<td>
							<c:if test="${data3.STAT_SUN eq '0' }">매우나쁨</c:if>
							<c:if test="${data3.STAT_SUN eq '1' }">나쁨</c:if>
							<c:if test="${data3.STAT_SUN eq '2' }">좋음</c:if>
							<c:if test="${data3.STAT_SUN eq '3' }">매우좋음</c:if>
						</td>
						<td>
							<c:if test="${data3.STAT_CLIMATE eq '0' }">매우나쁨</c:if>
							<c:if test="${data3.STAT_CLIMATE eq '1' }">나쁨</c:if>
							<c:if test="${data3.STAT_CLIMATE eq '2' }">좋음</c:if>
							<c:if test="${data3.STAT_CLIMATE eq '3' }">매우좋음</c:if>
						</td>
					</tr>
				</c:forEach>
				<c:if test="${empty crop }">
					<tr><td colspan="6">등록된 내용이 없습니다.</td></tr>
				</c:if>
			</tbody>
		</table>
	</div>
	<div id="typeCult">
		<h4 class="ma_title">재배동향</h4>
		<table class="modalList">
			<caption>정산내역(재배동향) 상세 내용입니다.</caption>
			<thead>
				<tr>
					<th>조사일자</th><th>출하코드</th><th>품목명</th><th>품종명</th>
					<th>전년대비면적</th><th>재배면적</th><th>동향</th><th>등록일</th><th>수정일</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="data4" items="${cult }">
					<tr>
						<td>${data4.REG_DATE }</td><td>${data4.CHUL_NO }</td><td>${data4.PUM_NAME }</td><td>${data4.GOOD_NAME }</td>
						<td>${data4.STATUS_NAME }</td><td>${data4.AREA }</td><td>${data4.BIGO }</td><td>${data4.REG_DT }</td><td>${data4.UPT_DT }</td>
					</tr>	
				</c:forEach>
				<c:if test="${empty cult }">
					<tr><td colspan="9">등록된 내용이 없습니다.</td></tr>
				</c:if>
			</tbody>
		</table>
	</div>
</c:if>
<c:if test="${monitorType eq 'C' }">
	<div id="typeConsTrend">
		<h4 class="ma_title">소비동향</h4>
		<table class="modalList">
			<caption>정산내역(소비동향) 상세 내용입니다.</caption>
			<thead>
				<tr>
					<th>조사일자</th><th>출하코드</th><th>품목명</th><th>품종명</th>
					<th>거래량</th><th>내용</th><th>등록일</th><th>수정일</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="data5" items="${consTrend }">
					<tr>
						<td>${data5.REG_DATE }</td><td>${data5.CHUL_NO }</td><td>${data5.PUM_NAME }</td><td>${data5.GOOD_NAME }</td>
						<td>${data5.QTY }</td><td>${data5.BIGO }</td><td>${data5.REG_DT }</td><td>${data5.UPT_DT }</td>
					</tr>	
				</c:forEach>
				<c:if test="${empty consTrend }">
					<tr><td colspan="8">&nbsp;</td></tr>
				</c:if>
			</tbody>
		</table>
	</div>
	<div id="typeConsPrice">
		<h4 class="ma_title">소매가격</h4>
		<table class="modalList">
			<caption>정산내역(소매가격) 상세 내용입니다.</caption>
			<thead>
				<tr>
					<th>조사일자</th><th>출하코드</th><th>품목명</th><th>품종명</th>
					<th>소매가격</th><th>지역명</th><th>등록일</th><th>수정일</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="data6" items="${consTrend }">
					<tr>
						<td>${data6.REG_DATE }</td><td>${data6.CHUL_NO }</td><td>${data6.PUM_NAME }</td><td>${data6.GOOD_NAME }</td>
						<td>${data6.SALE_PRICE }</td><td>${data6.SAN_NAME }</td><td>${data6.REG_DT }</td><td>${data6.UPT_DT }</td>
					</tr>	
				</c:forEach>
				<c:if test="${empty consTrend }">
					<tr><td colspan="8">&nbsp;</td></tr>
				</c:if>
			</tbody>
		</table>
	</div>
</c:if>