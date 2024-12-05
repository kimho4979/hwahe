<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, user-scalable=no">
	<meta name="apple-mobile-web-app-title" content="화훼유통정보시스템">
	<meta name="robots" content="no-index,follow">
	<meta name="og:title" content="화훼유통정보시스템">
	<meta property="og:type" content="website">
	<meta name="og:description" content="화훼유통정보. 전국 화훼공판장 경매시세 조회 및 화훼 관련 정보 제공. 화훼 경락가격, 유찰정보, 수출입량 등 다양한 정보를 만나보세요.">
	<meta name="content" content="화훼유통정보시스템 입니다.">
	<meta name="keywords" content="화훼경매시세, 화훼경매가격, Korea aT flower market auction price, 화훼공판장, 화훼거래정보, 꽃시장, 꽃값">
	<meta name="description" content="화훼유통정보. 전국 화훼공판장 경매시세 조회 및 화훼 관련 정보 제공. 화훼 경락가격, 유찰정보, 수출입량 등 다양한 정보를 만나보세요.">
	<meta name="Author" content="화훼유통정보시스템 & www.woorim.co.kr : Kim Juyeon">
	<title>화훼유통정보시스템</title>
	<link type="text/css" rel="stylesheet" href="/css/common.css">
	<link type="text/css" rel="stylesheet" href="/css/main.css">
	<link type="text/css" rel="stylesheet" href="/css/media.css" media="(max-width:1023px)">
	
	<!--  파비콘 소스  -->
	<link rel="apple-touch-icon" href="/images/content/favicon.png" />
	<link rel="apple-touch-icon-precomposed" href="/images/content/favicon.png" />
	<link rel="shortcut icon" href="/images/content/favicon.png" />
	<link rel="shortcut icon" href="/images/content/favicon.png" type="image/x-icon" >
	
	<script type="text/javascript" src="/js/jquery-1.11.2.min.js"></script>
	<script type="text/javascript" src="/js/display.js"></script>
	<!-- Global site tag (gtag.js) - Google Analytics -->
	<!-- <script async src="https://www.googletagmanager.com/gtag/js?id=UA-124845654-1"></script> -->
	<!--Google tag (gtag.js) GA4 25 화훼공판장 2023.01 -->
	<script async src="https://www.googletagmanager.com/gtag/js?id=G-GH4XDEKH3E"></script>
	<script>
		window.dataLayer = window.dataLayer || [];
		function gtag(){dataLayer.push(arguments);}
		gtag('js',new Date());
		
		gtag('config','G-GH4XDEKH3E'),{'content_group':'FlowerInfo'};
		gtag('config','G-1C6GSRP5Z8'),{'content_group':'FlowerInfo'};
	</script>
	<script type="text/javascript">
	
 /* window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-124845654-1'); */
  
  history.replaceState({}, null, location.pathname);
		
	$(document).ready(function(){
		// 공지사항 목록 로딩
		//gongi(1,3);
		noLoginMainMenu();
		
		$("#messageButtom").hide();
	});
	
	/* function gongi(startPageNo, endPageNo){
		$.ajax({
			type : "post",
			url : "/main/flowerMain_gongi.json",
			data : {
				startPageNo : startPageNo,
				endPageNo : endPageNo
			},
			dataType : '',
			success : function(res){
				var val = res.result;
				var html='';
				for(var i=0; i<val.length; i++){					
					html+='<li>';
					html+="<a href='/hfa01/hfa01.do?seq="+val[i].seq1+"&seqNum="+val[i].seq1+"'>";
					html+='<strong class="tit">'+val[i].title1+'</strong>';
					html+='<span class="day">'+val[i].insDt+'</span>';
					html+='</a>';
					html+='</li>';					
				}
				$("#gongi").append(html);
			}
		});
	} */
	
	// 본인 설정메뉴, 관리자 설정 메뉴
	function noLoginMainMenu(){
		$.ajax({
			type : "post",
			url : "/main/selectNoLoginMenuList.json",
			data : {},
			dataType : '',
			success : function(res){
				if(res.userList!=null){
					var val = res.userList;
					if(val.length != 0){
						$("#visualList").empty();
						var html='';
						
						for(var i=0; i<val.length; i++){					
							html+='<li class=li0'+val[i].MENU_ORDER+'><a href='+val[i].MENU_URL+'>'+val[i].MENU_NM+'</a></li>';
						}
						$("#visualList").append(html);	
					}
				}else{
					var val = res.list;
					if(val.length != 0){
						$("#visualList").empty();
						var html='';
						
						for(var i=0; i<val.length; i++){					
							html+='<li class=li0'+(i+1)+'><a href='+val[i].menuUrl+'>'+val[i].menuNm+'</a></li>';
						}
						$("#visualList").append(html);	
					}
				}				
			}
		});
	}
	
	</script>
</head>
<body>
	<ul class="skip_nav">
		<li><a href="#header">상단바로가기</a></li>
		<li><a href="#content">본문바로가기</a></li>
	</ul><!-- skip end -->
	<div id="wrap" class="main">
		<jsp:include page="../inc/IncHeader.jsp"/>
		
		<article>
			<div class="visualWrap">
				<h3 class="blind">주메뉴 바로가기</h3>
				<ul class="visualList" id="visualList">
					<li class="li01">
						<a href="/hab01/hab01.do">일자별경매정보</a>
					</li>
					<li class="li02">
						<a href="/yuchal/yuchal.do">일자별유찰현황</a>
					</li>
					<li class="li03">
						<a href="/hca01/hca01.do">출하 및 작황정보</a>
					</li>
					<li class="li04">
						<a href="/haa04/haa04.do">주요거래지표</a>
					</li>
				</ul><!-- visualList end-->
			</div><!-- visualWrap end -->
			<!-- <div class="noticeWrap">
				<ul class="noticeList" id="gongi">
					<li>
						<a href="#">
							<strong class="tit">1공지사항 제목이 나옵니다.</strong>
							<span class="day">2018.07.09</span>
						</a>
					</li>
					<li>
						<a href="#">
							<strong class="tit">2공지사항 제목이 나옵니다.</strong>
							<span class="day">2018.07.09</span>
						</a>
					</li>
					<li>
						<a href="#">
							<strong class="tit">3공지사항 제목이 나옵니다.</strong>
							<span class="day">2018.07.09</span>
						</a>
					</li>
				</ul>noticeList end
				<div class="notice-controll">
					<div class="notice-up-contorl">
						<button type="button" class="left">이전</button>
						<button type="button" class="control play">재생/정지</button>
						<button type="button" class="right">다음</button>
					</div>
				</div>
			</div> --><!-- noticeWrap end -->
		</article>
		<jsp:include page="../inc/IncFooter.jsp"/>
	</div><!-- wrap end -->
</body>
</html>



