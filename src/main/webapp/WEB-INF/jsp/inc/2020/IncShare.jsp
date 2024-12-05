<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">
	//공유
	$(document).ready(function(){

		$(".sns_box > li > a").click(function() {

			//공유타입
			var linkType = $(this).children().attr("alt");
			var url=window.location.protocol+ '//'+window.location.host+window.location.pathname;
			var strTitle = $(".sub_tit").text();

			if(strTitle=='일자별 경매정보'){
				var itemCd = $('#itemCd option:selected').val();
				var itemCd2 = $('#itemCd2 option:selected').val();
				var searchStrDate = $("#searchStrDate").val();
				var searchEndDate = $("#searchEndDate").val();
			    var flowerCd = $("#flowerTab .on > input").attr("value");
				var cmpCd = $("#cmpCdTab .on > input").attr("value");
				url+='?itemCd='+itemCd+'&itemCd2='+itemCd2+'&searchStrDate='+searchStrDate+'&searchEndDate='+searchEndDate+'&flowerCd='+flowerCd+'&cmpCd='+cmpCd
			}

		    var snsArray = new Array();

			if(linkType=='링크복사'){
				var IE = (document.all) ? true : false;
			    if (IE) {
			        window.clipboardData.setData("Text", url);
			        alert("url이 클립보드에 복사되었습니다.");
			    } else {
			        temp = prompt("이 글의 단축url입니다. Ctrl+C를 눌러 클립보드로 복사하세요", url);
			    }
			}else if(linkType=='페이스북'){
			    // snsArray['facebook'] = "http://www.facebook.com/share.php?u=" + encodeURIComponent(url);
			    snsArray['facebook'] = "http://www.facebook.com/atatstory";
			    window.open(snsArray['facebook']);
			}else if(linkType=='트위터'){
				snsArray['twitter'] = "http://twitter.com/home?status=" + encodeURIComponent(strTitle) + ' ' + encodeURIComponent(url);
			    window.open(snsArray['twitter']);
			}else if(linkType=='네이버밴드'){
				snsArray['band'] = "http://band.us/plugin/share?body=" + encodeURIComponent(strTitle) + "  " + encodeURIComponent(url) + "&route=" + encodeURIComponent(url);
				window.open(snsArray['band']);
			}else if(linkType=='유튜브'){
				snsArray['youtube'] = "https://www.youtube.com/atwebtv";
				window.open(snsArray['youtube']);
			}else if(linkType=='네이버블로그'){
				snsArray['blog'] = "https://blog.naver.com/gr22nade";
				window.open(snsArray['blog']);
			}else if(linkType=='인스타그램'){
				snsArray['insta'] = "https://www.instagram.com/atstory.official/";
				window.open(snsArray['insta']);
			}

		});

	});


</script>

		<div class="sub_sns">
			<ul class="sns_box">
				<li><a href="javascript:;"><img src="../images/sns_01.png" alt="네이버블로그"></a></li>
				<li><a href="javascript:;"><img src="../images/sns_03.png" alt="인스타그램"></a></li>	
				<li><a href="javascript:;"><img src="../images/2020/sub/sns_02.png" alt="페이스북"></a></li>
				<li><a href="javascript:;"><img src="../images/sns_02.png" alt="유튜브"></a></li>
				<li><a href="javascript:;"><img src="../images/2020/sub/sns_04.png" alt="링크복사"></a></li>
			</ul>
		</div>
