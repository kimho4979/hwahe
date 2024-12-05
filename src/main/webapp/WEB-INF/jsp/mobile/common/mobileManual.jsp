<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko" xmlns="http://www.w3.org/1999/xhtml">

 
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<title>출하 및 예정물량 ㅣ aT 화훼유통정보 모니터요원 입력시스템</title>
<script type="text/javascript"
	src="<c:url value='/axisj/jquery/jquery.min.js' />"></script>
<script type="text/javascript"
	src="<c:url value='/axisj/dist/AXJ.min.js' />"></script>
<script type="text/javascript"
	src="<c:url value='/axisj/lib/AXUpload5.js' />"></script>
<script type="text/javascript"
	src="<c:url value='/axisj/dist/cmmn/ax5-polyfill.js' />"></script>
<script type="text/javascript"
	src="<c:url value='/axisj/dist/cmmn/axjApp.js' />"></script>
<link rel="stylesheet" type="text/css"
	href="<c:url value='/axisj/axicon/axicon.min.css' />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value='/axisj/ui/arongi/mobileAXJ.min.css' />" />
<script type="text/javascript"
	src="<c:url value='/js/mobile/common/chulha.js' />"></script>
<link rel="stylesheet" type="text/css"
	href="/css/mobile/common/layout.css" />
</head>
<script>

var fnObj = {
	pageStart: function(){
		$('#sub_top_menu a span').removeClass('a_purple');
		$('#sub_top_menu a span').eq($('#sub_top_menu a span').index()+6).addClass('a_purple');	
	}
}

$(document).ready(fnObj.pageStart);
</script>


<!--  header -->
<jsp:include page="../common/common.jsp"></jsp:include>
<!--  header end -->

<div class="ma_half1_1" id="content"><span class="white">매뉴얼</span></div>
<div class="manualWrap">
				<div class="manual mn01">
					<div class="container">
						<h3 class="mn_tit mn01">1.출하예정물량 등록방법</h3><!--  mn_tit mn01 end  -->
						<img src="/images/hw/mb_manual01.jpg" alt="mb매뉴얼"/>
						<p class="mnList_tit">화면 기능 설명</p><!--  mnList_tit end  -->
						<ul class="mnList">
							<li><span class="ft_red">① </span>일자(초순/중순/하순)중 체크해주세요.</li>
							<li><span class="ft_red">② </span>출하할 품종을 선택하실 수 있습니다.</li>
							<li><span class="ft_red">③ </span>출하지역을 선택하실 수 있습니다.</li>
							<li><span class="ft_red">④ </span>예상출하량을 숫자로 입력하실 수 있습니다.</li>
							<li><span class="ft_red">⑤ </span>해당출하물량에 대한 간단한 요약정보를 입력하세요.</li>
							<li><span class="ft_red">⑥ </span>등록하기 버튼을 누르면 해당 리스트로 저장 됩니다.</li>
							<li><span class="ft_red">⑦ 삭제하기 버튼을 누르면 원하는 항목을 삭제 할 수 있습니다.</span></li>
							<li><span class="ft_red">⑧ 수정하기 버튼을 누르면 원하는 항목을 수정 할 수 있습니다.</span></li>
						</ul><!-- mnList end  -->
					</div><!--  container end  -->
				</div><!-- manual mn01 end  -->
				<div class="manual mn02">
					<div class="container">
						<h3 class="mn_tit mn02">2. 출하물량 등록 방법 </h3><!--  mn_tit mn01 end  -->
						<img src="/images/hw/mb_manual02.jpg" alt="mb매뉴얼"/>
						<p class="mnList_tit">화면 기능 설명</p><!--  mnList_tit end  -->
						<ul class="mnList">
							<li><span class="ft_red">① </span>일자(초순/중순/하순)중 체크해주세요.</li>
							<li><span class="ft_red">② </span>출하할 품종을 선택하실 수 있습니다.</li>
							<li><span class="ft_red">③ </span>출하지역을 선택하실 수 있습니다.</li>
							<li><span class="ft_red">④ </span>출하량을 숫자로 입력하실 수 있습니다.</li>
							<li><span class="ft_red">⑤ </span>해당출하물량에 대한 간단한 요약정보를 입력하세요.</li>
							<li><span class="ft_red">⑥ </span>등록하기 버튼을 누르면 해당 리스트로 저장 됩니다.</li>
							<li><span class="ft_red">⑦ 삭제하기 버튼을 누르면 원하는 항목을 삭제 할 수 있습니다.</span></li>
							<li><span class="ft_red">⑧ 수정하기 버튼을 누르면 원하는 항목을 수정 할 수 있습니다.</span></li>
						</ul><!-- mnList end  -->
					</div><!--  container end  -->
				</div><!-- manual mn02 end  -->
				<div class="manual mn03">
					<div class="container">
						<h3 class="mn_tit mn03">3. 작황동향 등록 방법 </h3><!--  mn_tit mn01 end  -->
						<img src="/images/hw/mb_manual03.jpg" alt="mb매뉴얼"/>
						<p class="mnList_tit">화면 기능 설명</p><!--  mnList_tit end  -->
						<ul class="mnList">
							<li><span class="ft_red">① </span>조사일자 달력을 선택하여 해당 날짜를 클릭하시면 됩니다.</li>
							<li><span class="ft_red">② </span>작황 품종을 선택 하세요</li>
							<li><span class="ft_red">③ </span>작황정보(전년대비)를 선택하세요</li>
							<li><span class="ft_red">④ </span>작황 상태에 대한 세부정보를 선택하세요</li>
							<li><span class="ft_red">⑤ </span>작황 상태에 대한 간단한 요약정보를 입력하실 수 있습니다.</li>
							<li><span class="ft_red">⑥ </span>파일 선택을 눌러 휴대폰에 저장된 사진을 업로드 하실 수 있습니다.</li>
							<li><span class="ft_red">⑦ </span>등록하기 버튼을 누르면 해당 리스트로 저장 됩니다.</li>
							<li><span class="ft_red">⑧ 삭제하기 버튼을 누르면 원하는 항목을 삭제 할 수 있습니다.</span></li>
							<li><span class="ft_red">⑨ 수정하기 버튼을 누르면 원하는 항목을 수정 할 수 있습니다.</span></li>
						</ul><!-- mnList end  -->
					</div><!--  container end  -->
				</div><!-- manual mn03 end  -->
				<div class="manual mn04">
					<div class="container">
						<h3 class="mn_tit mn04">4. 재배동향 등록 방법 </h3><!--  mn_tit mn01 end  -->
						<img src="/images/hw/mb_manual04.jpg" alt="mb매뉴얼"/>
						<p class="mnList_tit">화면 기능 설명</p><!--  mnList_tit end  -->
						<ul class="mnList">
							<li><span class="ft_red">① </span>조사일자 달력을 선택하여 해당 날짜를 클릭하시면 됩니다.</li>
							<li><span class="ft_red">② </span>원하시는 품종을 선택하실 수 있습니다.</li>
							<li><span class="ft_red">③ </span>전년대비면적(본인)을 선택 하실 수 있습니다.</li>
							<li><span class="ft_red">④ </span>재배면적을 숫자로 입력하실 수 있습니다.</li>
							<li><span class="ft_red">⑤ </span>재배면적 동향에 대한 간단한 요약정보를 입력 하실 수 있습니다.</li>
							<li><span class="ft_red">⑥ </span>등록하기 버튼을 누르면 해당 리스트로 저장 됩니다.</li>
							<li><span class="ft_red">⑦ 삭제하기 버튼을 누르면 원하는 항목을 삭제 할 수 있습니다.</span></li>
							<li><span class="ft_red">⑧ 수정하기 버튼을 누르면 원하는 항목을 수정 할 수 있습니다.</span></li>
						</ul><!-- mnList end  -->
					</div><!--  container end  -->
				</div><!-- manual mn04 end  -->
				<div class="manual mn05">
					<div class="container">
						<h3 class="mn_tit mn05">5. 소비동향 등록 방법 </h3><!--  mn_tit mn01 end  -->
						<img src="/images/hw/mb_manual05.jpg" alt="mb매뉴얼"/>
						<p class="mnList_tit">화면 기능 설명</p><!--  mnList_tit end  -->
						<ul class="mnList">
							<li><span class="ft_red">① </span>조사일자 달력을 선택하여 해당 날짜를 클릭하시면 됩니다.</li>
							<li><span class="ft_red">② </span>원하시는 품종을 선택하실 수 있습니다.</li>
							<li><span class="ft_red">③ </span>소매거래량을 숫자로 입력하실 수 있습니다.</li>
							<li><span class="ft_red">④ </span>소비동향에 대한 간단한 요약정보를 입력 하실 수 있습니다.</li>
							<li><span class="ft_red">⑤ </span>등록하기 버튼을 누르면 해당 리스트로 저장 됩니다.</li>
							<li><span class="ft_red">⑥ 삭제하기 버튼을 누르면 원하는 항목을 삭제 할 수 있습니다.</span></li>
							<li><span class="ft_red">⑦ 수정하기 버튼을 누르면 원하는 항목을 수정 할 수 있습니다.</span></li>
						</ul><!-- mnList end  -->
					</div><!--  container end  -->
				</div><!-- manual mn04 end  -->
				<div class="manual mn06">
					<div class="container">
						<h3 class="mn_tit mn06">6. 소매가격 등록 방법 </h3><!--  mn_tit mn01 end  -->
						<img src="/images/hw/mb_manual06.jpg" alt="mb매뉴얼"/>
						<p class="mnList_tit">화면 기능 설명</p><!--  mnList_tit end  -->
						<ul class="mnList">
							<li><span class="ft_red">① </span>날짜선택 달력을 선택하여 해당 날짜를 클릭하시면 됩니다.</li>
							<li><span class="ft_red">② </span>원하시는 품종을 선택하실 수 있습니다.</li>
							<li><span class="ft_red">③ </span>소매가격을 숫자로 입력하실 수 있습니다.</li>
							<li><span class="ft_red">④ </span>등록하기 버튼을 누르면 해당 리스트로 저장 됩니다.</li>
							<li><span class="ft_red">⑤ 삭제하기 버튼을 누르면 원하는 항목을 삭제 할 수 있습니다.</span></li>
							<li><span class="ft_red">⑥ 수정하기 버튼을 누르면 원하는 항목을 수정 할 수 있습니다.</span></li>
						</ul><!-- mnList end  -->
					</div><!--  container end  -->
				</div><!-- manual mn04 end  -->

			</div>
<div id="bottom">
      <li class="lay1">
          <a href="/cmmn/manual.do"><button type=button class="pcver_btn">pc버전</button></a> 
          <a href="javascript:window.scrollTo(0,0)"><button type=button class="up_btn">맨위로</button></a>          
      </li>
      <li class="lay2">
      	  <address class="copyright_address">Copyright By <span class="ft_green">화훼유통정보시스템 모바일.</span> All rights reserved.</address>
      </li>
  </div>
</div>
</body>
</html>


