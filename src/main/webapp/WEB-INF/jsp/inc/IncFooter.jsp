<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
function showFavar(){
	if('${sessionScope.userId}'!=null&&'${sessionScope.userId}'!=''){
		footerSelectBookmark();	
	}else{
		alert('로그인 후 이용하실 수 있습니다');
		location.href='/customInfo/mainLoginForm.do';
	}
}

function footerSelectBookmark(){
	$.ajax({
		type : "post",
		url : "/customInfo/boomarkList.json",
		data : {},
		dataType : '',
		success : function(res){ 
			$("#bookmarkList1").html("");
			for(var i=0;i<res.favoriteList.length;i++){
				var data = res.favoriteList[i];
				$("#bookmarkList1").append('<p class="bookmarkP"><a href="'+data.menuUrl+'" class="txt">'+data.menuNm+'</a><button class="btn06" type="button" onClick="deleteBookmark1(\''+data.menuNm+'\')">삭제</button></p>');
			}
			
			fnShowLayer('#message_popup');
		}
     });
}

function deleteBookmark1(menuNm){
	$.ajax({
		type : "post",
		url : "/customInfo/deleteFavor.json",
		data : {menuNm:menuNm},
		dataType : '',
		success : function(res){ 
			if(res.success=='Y'){
				alert('삭제되었습니다');
				$("#bookmarkList1").html("");
    			for(var i=0;i<res.favoriteList.length;i++){
					var data = res.favoriteList[i];
					$("#bookmarkList1").append('<p class="bookmarkP"><a href="'+data.menuUrl+'" class="txt">'+data.menuNm+'</a><button class="btn06" type="button" onClick="deleteBookmark1(\''+data.menuNm+'\')">삭제</button></p>');
				}	
			}else{
				alert('삭제실패하였습니다. 관리자에게 문의하세요');
			}
			
		}
     });
}

function goodCont(){
	window.open('https://www.goodcontent.kr/upload_public/CERTIDW/2018-11-0071_f7mw2zb0wbyvsem20181119090611.png', '_blank'); 
}

</script>

<div id="footer">
	
	<ul class="ft_gnb">
		<li><a href="http://www.at.or.kr/html/member/at_acount_2.html"><b>개인정보처리방침</b></a></li>
		<li><a href="http://www.at.or.kr/privacy/apko372000/intro.action">개인정보침해신고센터</a></li>
		<li><a href="/main/accessTerms.do">이용약관</a></li>
		<li><a href="/main/siteMap.do">Sitemap</a></li>
		<li class="logo_goodContents"><img src="/images/common/goodContents.png" alt="굿 콘텐츠서비스 로고" onclick="goodCont()"/></li>
	</ul><!-- ft_gnb end -->
	<div class="address">
		<address>
			[06774] 서울특별시 서초구 강남대로 27 화훼공판장 전화 : 02-579-8100 ｜ 팩스 : 02-578-8671
			<span class="br">한국농수산식품유통공사 화훼사업센터 l 사업자등록번호 :229-82-00650 l 대표자 : 이병호 </span>
			<span class="copyright">COPYRIGHT @2016 by Korea Agro-Fisheries & Food Trade Corporation ALL RIGHTS RESERVED.
				
			</span>
			
		</address>
	</div>
</div><!-- footer end -->

<div class="messageWrap" id="messageButtom">
		<button class="messageBtn" onclick="showFavar()">즐겨찾기</button><!-- messageBtn end -->
		<!-- layer popup wrap begin -->
		<div class="lp_wrap">
			<!-- lp_container begin -->
			<div class="lp_container" id="message_popup"><!-- D: ID 필수 -->
				<div class="lp_area">
					<!--<div class="lp_header">
						<h2 class="lph_tit01">레이어 팝업 타이틀</h2>
					</div>-->
					<!-- <div class="messageCt"> -->
					<div class="lp_content">
						<div class="popupGreen" id="bookmarkList1">
						
						</div><!-- popupGreen end -->
					</div><!-- lp_content end -->
				</div><!-- lp_area end -->
				<button type="button" class="lp_close"><span>닫기</span></button>
			</div><!-- // lp_container end -->
			
		</div><!-- // layer popup wrap end -->
	</div><!-- massage end -->