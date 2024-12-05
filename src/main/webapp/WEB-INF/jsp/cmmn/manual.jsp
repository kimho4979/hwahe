<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
    <%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
String pageNo=request.getParameter("pageNo"); 

%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, user-scalable=no">
<title>모니터요원 입력시스템-매뉴얼</title>
  <!-- @@@@@@@@@@@@@@@@@@@@@@ css begin @@@@@@@@@@@@@@@@@@@@@@ -->
  <link rel="stylesheet" type="text/css" href="<c:url value='/rMateChart/rMateChartH5/Assets/Css/rMateChartH5.css' />"/>   
 <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/axicon/axicon.min.css' />" />
 <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/arongi/AXJ.min.css' />" />
 <link rel="stylesheet" type="text/css" href="<c:url value='/css/hw/ma.css' />" />
 <link rel="stylesheet" type="text/css" href="<c:url value='/css/hw/common.css' />" />
  <!-- @@@@@@@@@@@@@@@@@@@@@@ css end   @@@@@@@@@@@@@@@@@@@@@@ --> 
  
  <script type="text/javascript" src="<c:url value='/axisj/jquery/jquery.min.js' />"></script>
  <script type="text/javascript" src="<c:url value='/axisj/dist/AXJ.min.js' />"></script>
  <script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/ax5-polyfill.js' />"></script>
  <script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/axjApp.js' />"></script>
  
  
  
  <!-- rMateChartH5 라이센스 시작 -->
  <script type="text/javascript" src="<c:url value='/rMateChart/LicenseKey/rMateChartH5License.js' />"></script>
  <!-- rMateChartH5 라이센스 끝-->  
  <!-- 실제적인 rMateChartH5 라이브러리 시작-->
   <script type="text/javascript" src="<c:url value='/rMateChart/rMateChartH5/JS/rMateChartH5.js' />"></script>
  <!-- 실제적인 rMateChartH5 라이브러리 끝-->
  <!-- rMateChartH5 테마 js -->
  <script type="text/javascript" src="<c:url value='/rMateChart/rMateChartH5/Assets/Theme/theme.js' />"></script>
    
  <script type="text/javascript">

</script>
   
</head>
<body>
<%@ include file="/WEB-INF/inc/IncHeader.jsp" %>

<article>
<div class="wrap">

<%@ include file="/WEB-INF/jsp/inc/IncMenu.jsp" %>

		<div class="hw_content"><!--컨텐츠 내용들어가는곳 시작-->
			<div class="ma_all">
				<div class="ma_half1"><!-- <div class="half1_white"></div> --><span class="half_title">매뉴얼</span></div>
			</div><!--  header title END --> 
			<div class="manualWrap">
				<div class="manual mn01">
					<div class="container">
						<h3 class="mn_tit mn01">1.출하예정물량 등록 방법</h3><!--  mn_tit mn01 end  -->
						<img src="/images/hw/pc_manual01.jpg" alt="pc매뉴얼"/>
						<ul class="mnList">
							<li><span class="ft_red ftB">① </span>출하예정물량 입력페이지 → <span class="ft_red ftB">② </span>등록하기버튼 클릭 <span class="ft_red">(버튼을 누르면 팝업창이 뜹니다.)</span></li>
							<li><span class="ft_red ftB">③ </span>원하는 내용을 체크 한 뒤 삭제하기 버튼을 누르면 <span class="ft_red ftB">삭제</span>가능</li>
							<li><span class="ft_red ftB">④ </span>등록한 내역이 안나올 때는 새로고침 버튼으로 리셋</li>
						</ul><!-- mnList end  -->
						<p class="mnP">- 팝업창 입력리스트</p>
						<img src="/images/hw/pc_manual01_2.jpg" alt="pc매뉴얼"/>
					</div><!--  container end  -->
				</div><!-- manual mn01 end  -->
				<div class="manual mn02">
					<div class="container">
						<h3 class="mn_tit mn02">2. 출하물량 등록 방법 </h3><!--  mn_tit mn01 end  -->
						<img src="/images/hw/pc_manual02.jpg" alt="pc매뉴얼"/>
						<ul class="mnList">
							<li><span class="ft_red ftB">① </span>출하물량 입력페이지 → <span class="ft_red ftB">② </span>등록하기버튼 클릭 <span class="ft_red">(버튼을 누르면 팝업창이 뜹니다.)</span></li>
							<li><span class="ft_red ftB">③ </span>원하는 내용을 체크 한 뒤 삭제하기 버튼을 누르면 <span class="ft_red ftB">삭제</span>가능</li>
							<li><span class="ft_red ftB">④ </span>등록한 내역이 안나올 때는 새로고침 버튼으로 리셋</li>
						</ul><!-- mnList end  -->
						<p class="mnP">- 팝업창 입력리스트</p>
						<img src="/images/hw/pc_manual02_2.jpg" alt="pc매뉴얼"/>
					</div><!--  container end  -->
				</div><!-- manual mn02 end  -->
				<div class="manual mn03">
					<div class="container">
						<h3 class="mn_tit mn03">3. 작황동향 등록 방법 </h3><!--  mn_tit mn01 end  -->
						<img src="/images/hw/pc_manual03.jpg" alt="pc매뉴얼"/>
						<ul class="mnList">
							<li><span class="ft_red ftB">① </span>작황동향 입력페이지 → <span class="ft_red ftB">② </span>등록하기버튼 클릭 <span class="ft_red">(버튼을 누르면 팝업창이 뜹니다.)</span></li>
							<li><span class="ft_red ftB">③ </span>원하는 내용을 체크 한 뒤 삭제하기 버튼을 누르면 <span class="ft_red ftB">삭제</span>가능</li>
							<li><span class="ft_red ftB">④ </span>등록한 내역이 안나올 때는 새로고침 버튼으로 리셋</li>
						</ul><!-- mnList end  -->
						<p class="mnP">- 팝업창 입력리스트</p>
						<img src="/images/hw/pc_manual03_2.jpg" alt="pc매뉴얼"/>
					</div><!--  container end  -->
				</div><!-- manual mn03 end  -->
				<div class="manual mn04">
					<div class="container">
						<h3 class="mn_tit mn04">4. 재배동향 등록 방법 </h3><!--  mn_tit mn01 end  -->
						<img src="/images/hw/pc_manual04.jpg" alt="pc매뉴얼"/>
						<ul class="mnList">
							<li><span class="ft_red ftB">① </span>재배동향 입력페이지 → <span class="ft_red ftB">② </span>등록하기버튼 클릭 <span class="ft_red">(버튼을 누르면 팝업창이 뜹니다.)</span></li>
							<li><span class="ft_red ftB">③ </span>원하는 내용을 체크 한 뒤 삭제하기 버튼을 누르면 <span class="ft_red ftB">삭제</span>가능</li>
							<li><span class="ft_red ftB">④ </span>등록한 내역이 안나올 때는 새로고침 버튼으로 리셋</li>
						</ul><!-- mnList end  -->
						<p class="mnP">- 팝업창 입력리스트</p>
						<img src="/images/hw/pc_manual04_2.jpg" alt="pc매뉴얼"/>
					</div><!--  container end  -->
				</div><!-- manual mn04 end  -->
				<div class="manual mn05">
					<div class="container">
						<h3 class="mn_tit mn05">5. 소비동향 등록 방법 </h3><!--  mn_tit mn01 end  -->
						<img src="/images/hw/pc_manual05.jpg" alt="pc매뉴얼"/>
						<ul class="mnList">
							<li><span class="ft_red ftB">① </span>소비동향 입력페이지 → <span class="ft_red ftB">② </span>등록하기버튼 클릭 <span class="ft_red">(버튼을 누르면 팝업창이 뜹니다.)</span></li>
							<li><span class="ft_red ftB">③ </span>원하는 내용을 체크 한 뒤 삭제하기 버튼을 누르면 <span class="ft_red ftB">삭제</span>가능</li>
							<li><span class="ft_red ftB">④ </span>등록한 내역이 안나올 때는 새로고침 버튼으로 리셋</li>
						</ul><!-- mnList end  -->
						<p class="mnP">- 팝업창 입력리스트</p>
						<img src="/images/hw/pc_manual05_2.jpg" alt="pc매뉴얼"/>
					</div><!--  container end  -->
				</div><!-- manual mn05 end  -->
				<div class="manual mn06">
					<div class="container">
						<h3 class="mn_tit mn06">6. 소매가격 등록 방법 </h3><!--  mn_tit mn01 end  -->
						<img src="/images/hw/pc_manual06.jpg" alt="pc매뉴얼"/>
						<ul class="mnList">
							<li><span class="ft_red ftB">① </span>소매가격 입력페이지 → <span class="ft_red ftB">② </span>등록하기버튼 클릭 <span class="ft_red">(버튼을 누르면 팝업창이 뜹니다.)</span></li>
							<li><span class="ft_red ftB">③ </span>원하는 내용을 체크 한 뒤 삭제하기 버튼을 누르면 <span class="ft_red ftB">삭제</span>가능</li>
							<li><span class="ft_red ftB">④ </span>등록한 내역이 안나올 때는 새로고침 버튼으로 리셋</li>
						</ul><!-- mnList end  -->
						<p class="mnP">- 팝업창 입력리스트</p>
						<img src="/images/hw/pc_manual06_2.jpg" alt="pc매뉴얼"/>
					</div><!--  container end  -->
				</div><!-- manual mn06 end  -->

			</div>
		</div><!--wrap 끝-->
	</div>	
</article>

<div class="hw_clear"></div>

<footer>
<%@ include file="/WEB-INF/inc/IncFooter.jsp" %>
</footer>
</body>
</html>