<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
	//공유
	$(document).ready(function(){
		
		$("li[class^=share] > .saveDdBtn").click(function (e) {
			//공유타입
			var linkType = e.currentTarget.innerText.toLowerCase();
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
			    snsArray['facebook'] = "http://www.facebook.com/share.php?u=" + encodeURIComponent(url);
			    window.open(snsArray['facebook']);
			}else if(linkType=='트위터'){			
				snsArray['twitter'] = "http://twitter.com/home?status=" + encodeURIComponent(strTitle) + ' ' + encodeURIComponent(url);
			    window.open(snsArray['twitter']);
			}else if(linkType=='네이버밴드'){
				snsArray['band'] = "http://band.us/plugin/share?body=" + encodeURIComponent(strTitle) + "  " + encodeURIComponent(url) + "&route=" + encodeURIComponent(url);
				window.open(snsArray['band']);
			}
		});
		
		/* 즐겨찾기 */
		$("li[class^=bookMark] > .saveDdBtn02").click(function (e) {
			//공유타입		
			if(e.currentTarget.innerText=='등록'){
				var strTitle = $("title").text();
				var url = window.location.pathname;
				insertFavor(strTitle, url);
			}else{
				this.css('display','none');
			}
		});
	});
	
	function insertFavor(title, url){	
		$.ajax({
			type : 'get',
			url : "/customInfo/insertFavor.json",
			data :"menuNm="+title+"&menuUrl="+url,
			dataType : '',   	           
			success : function(res){ 
				if(res.loginFail=='Y'){
					alert('로그인 후 이용해주세요.');
				}else if(res.loginFail=='D'){
					alert('이미 즐겨찾기에 등록되었습니다.');
				}else{
					alert('등록되었습니다.');
				}
			}
		}); 
	}

</script>

	<div class="saveArea">
		<div class="saveArea_cell">
			<ul class="saveDt">
				<li id="excelBtn1"><button class="excelSaveBtn" name="exportTable1">엑셀저장</button></li><!-- ecxelSaveBtn end -->
				<li><button class="share">공유</button></li><!-- btn02 end -->
				<li><button class="bookMark">즐겨찾기</button></li><!-- btn02 end -->
			</ul><!-- saveDt end -->
			<ul class="saveDd">
				<li class="share">
					<button class="saveDdBtn">링크복사</button>
					<button class="saveDdBtn">페이스북</button>
					<button class="saveDdBtn">트위터</button>					
					<button class="saveDdBtn last">네이버밴드</button>
				</li><!-- imgSave end -->
				<li class="bookMark">
					<p class="txt"><span class="blue">즐겨찾기 </span>메뉴에 등록하시겠습니까?</p>
					<button class="saveDdBtn02">등록</button>
					<button class="saveDdBtn02">취소</button>
				</li><!-- imgSave end -->
			</ul>
		</div><!-- ctH_cell end -->
	</div><!-- saveArea end -->