<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>

<script type="text/javascript">
var sessionId = '${SESSION_USER_ID}';
var monitorType = '${SESSION_MONITOR_TYPE}';

$(document).ready(function(){	

	if(sessionId!= 'admin' && sessionId != 'at99999999'){
		if(monitorType=='A'){
			// 공통
			$(".tm_cpart5").children().click(function () {return false;});
			$(".tm_cpart5").attr('class','tm_cpart5 not');
			$(".tm_cpart6").children().click(function () {return false;});
			$(".tm_cpart6").attr('class','tm_cpart6 not');	
		}else if(monitorType=='P'){
			// 생산
			$(".tm_cpart3").children().click(function () {return false;});
			$(".tm_cpart3").attr('class','tm_cpart3 not');
			$(".tm_cpart4").children().click(function () {return false;});
			$(".tm_cpart4").attr('class','tm_cpart4 not');	
			$(".tm_cpart5").children().click(function () {return false;});
			$(".tm_cpart5").attr('class','tm_cpart5 not');
			$(".tm_cpart6").children().click(function () {return false;});
			$(".tm_cpart6").attr('class','tm_cpart6 not');	
		}else if(monitorType=='C'){
			// 소비
			$(".tm_cpart1").children().click(function () {return false;});
			$(".tm_cpart1").attr('class','tm_cpart1 not');
			$(".tm_cpart2").children().click(function () {return false;});
			$(".tm_cpart2").attr('class','tm_cpart2 not');
			$(".tm_cpart3").children().click(function () {return false;});
			$(".tm_cpart3").attr('class','tm_cpart3 not');
			$(".tm_cpart4").children().click(function () {return false;});
			$(".tm_cpart4").attr('class','tm_cpart4 not');
		}
		
		
	}
	
});

function goLogout(){
	var result = confirm('로그아웃하시겠습니까?'); 
	if(result) {
		location.href="/login/logoutProc.do";
	}
}

function goMain(){
	if(monitorType=='C'){
		// 소비
		location.href="/mba11/mba11.do";
	}else{
		location.href="/maa11/maa11.do";
	}
	
}

</script>
	<body>
		<ul class="skip_nav">
			<li><a href="#sub_top">상단바로가기</a></li>
			<li><a href="#content">본문바로가기</a></li>
		</ul><!-- skip end -->
	  <div id="sub_top">
	    <ul>
	      <li class="lay3">
	        <h1 class="h1_img">
	        <a href="javascript:goMain()"  title="화훼유통정보시스템모니터요원 입력화면 메인으로 이동합니다.">
	        <img src="../../../../images/common/at3.png" alt="aT화훼유통정보모니터요원로고" title="aT화훼유통정보모니터요원로고" />
	        </a>
	        </h1><!--화훼메인로고입니다-->
	      </li>
	      <li class="lay4">
	        <img src="../../../../images/common/logout.png" alt="로그아웃" title="로그아웃버튼" class="logout" onclick="javascript:goLogout()"  />
	      </li>
    </ul>
  </div>
  
     <ul id="sub_top_menu">
	     <li class="tm_cpart1"><a href="/maa11/maa11.do"><span class="">출하예정물량</span></a></li>
	     <li class="tm_cpart2"><a href="/maa22/maa22.do"><span class="">출하물량</span></a></li>
	     <li class="tm_cpart3"><a href="/mab11/mab11.do"><span class="">작황동향</span></a></li>
	     <li class="tm_cpart4"><a href="/mac11/mac11.do"><span class="">재배동향</span></a></li>
	     <li class="tm_cpart5"><a href="/mba11/mba11.do"><span class="">소비동향</span></a></li>
	     <li class="tm_cpart6"><a href="/mbb11/mbb11.do"><span class="">소매가격</span></a></li>
	     <li class="tm_cpart7"><a href="/cmmn/mobileManual.do"><span class="">매뉴얼</span></a></li>
  </ul> <!--화훼메뉴입니다-->
  <div class="hw_clear"></div>  
  



