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

$(function(){
	$("#testBtn").click("on", function(){
		
		$.ajax({
			type : 'post',
			url : "/chart/insertChartData.json",
			data : {
				
			},
			dataType : '',
			success : function(res) {
				console.log("success")
			}
		});
		
	})
})

</script>

		<!--FOOTER 웹(S)-->
		
		<div class="footer">
			<div class="footer_in">
				<ul class="f_menu">
					<li class="f_menu_list">
						<a href="/main/accessTerms.do" target='_blank'>이용약관</a>
						<a href="https://www.at.or.kr/sitemap/apko918000/privacy_policy.action" class="bold" target='_blank'>개인정보처리방침</a>
						<a href="http://www.at.or.kr/privacy/apko372000/intro.action" target='_blank'>개인정보침해신고센터</a>
						<!-- <a href="/main/siteMap.do">사이트맵</a> -->
						<span class=""></span>
					</li>
					<li class="f_menu_address">
						<p>06774 서울특별시 서초구 강남대로 27 화훼공판장</p>
						<p>전화 02-579-8100</p>
						<p>팩스 02-578-8671</p>
						<em></em>
						<p>한국농수산식품유통공사 화훼사업센터</p>
						<p>사업자등록번호 229-82-00650</p>
						<p>대표자 홍문표</p>
					</li>
				</ul>
				<div class="f_logo_box">
					<a class="f_logo"></a>
					<p>COPYRIGHT @2016 by Korea Agro-Fisheries & Food Trade Corporation ALL RIGHTS RESERVED</p>
					<div style="">
						<button id="testBtn" name="testBtn" >차트</button>
					</div>
				</div>
			</div>
		</div>
		<!--FOOTER 웹(E)-->

            <!--FOOTER 모바일(S)-->
            <div class="m_footer">
                <div class="m_footer_in">
                    <ul class="m_f_menu">
                        <li class="m_f_menu_list">
                            <a href="/main/accessTerms.do" target='_blank'>이용약관</a>
                            <span class="m_f_bar"></span>
                            <a href="http://www.at.or.kr/html/member/at_acount_2.html" target='_blank'><b style="font-size: 15px;">개인정보처리방침</b></a>
                            <span class="m_f_bar"></span>
                            <a href="http://www.at.or.kr/privacy/apko372000/intro.action" target='_blank'>개인정보침해신고센터</a>
                            <span class="m_f_bar"></span>
                            <a href="/main/siteMap.do">사이트맵</a>
                        </li>
                        <li class="m_f_menu_address">
                            <p>[06774] 서울특별시 서초구 강남대로 27 화훼공판장 </p>
                            <p>전화 : 02-579-8100 ｜ 팩스 : 02-578-8671</p>
                            <p>한국농수산식품유통공사 화훼사업센터</p>
                            <p>사업자등록번호 :229-82-00650 ｜ 대표자 : 홍문표</p>
                            <p>COPYRIGHT @2016 by Korea Agro-Fisheries & Food Trade Corporation ALL RIGHTS RESERVED</p>
                        </li>
                    </ul>
                </div>
            </div>
            <!--FOOTER 모바일(E)-->
