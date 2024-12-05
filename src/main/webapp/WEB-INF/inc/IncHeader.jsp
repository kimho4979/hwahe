<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 구글 애널리틱스 적용코드 
<script async type="text/javascript" src="/js/googleAnal.js"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-124845654-1');
</script> -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500;700&display=swap" rel="stylesheet">
<style>
	span, p{
	font-family: 'Noto Sans KR', sans-serif;
	}
</style>
<script type="text/javascript">
function goLogout(){
	var result = confirm('로그아웃하시겠습니까?'); 
	if(result) {
		location.href="/login/logoutProc.do";
	}
}

function goMain(){
	location.href="/maa01/maa01.do";
}
</script>
<div id="header">
	<div class="header"><!--헤더클래스 시작-->
		<div class="hw_logo_system">
			<h1><a href="javascript:goMain()"  title="화훼유통정보시스템모니터요원 입력화면 메인으로 이동합니다.">
				<img src="/images/hw/logo_system.JPG" alt="화훼유통정보시스템 로고"  /></a>
			</h1>
		</div>
	
		<div class="logout"><a><img src="/images/common/logout.png" alt="로그아웃" onclick="javascript:goLogout()" /></a></div>
	</div><!--헤더클래스 시작-->
</div>
