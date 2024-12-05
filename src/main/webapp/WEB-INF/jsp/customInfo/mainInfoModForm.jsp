<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
	<meta charset="utf-8"/>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, user-scalable=no"/>
	<meta name="apple-mobile-web-app-title" content="화훼유통정보시스템"/>
	<meta name="robots" content="no-index,follow"/>
	<meta name="og:title" content="화훼유통정보시스템"/>
	<meta name="og:description" content="화훼유통정보시스템"/>
	<meta name="description" content="정보수정">
	<meta name="content" content="화훼유통정보시스템 입니다."/>
	<meta name="keywords" content="화훼경매시세, 화훼경매가격, Korea aT flower market auction price, 화훼공판장, 화훼거래정보, 꽃시장, 꽃값">
	<meta name="Author" content="화훼유통정보시스템 & www.woorim.co.kr"/>
	<title>정보수정</title>	
	<%@include file="../common/2020/commonJs.jsp" %>
	<%@include file="../common/2020/commonCss.jsp" %>
	
	<script type="text/javascript">
	
	var initPumCd='';
	var initGoodCd='';
	$(document).ready(function(){
		/* 맞춤검색 수정 */
		// 검색 selectbox
		$('#itemCd').select2();
		// 검색 selectbox
		$('#itemCd2').select2();
		
		// 검색 selectbox
		$('#orderNum01').select2();
		$('#orderNum02').select2();
		$('#orderNum03').select2();
		$('#orderNum04').select2();
		
		$("#itemCd").change(function() {
			getSaleGoodList();
		});
		
		// WEB 공판장 선택
		$("#cmpCd, #flowerCd").change(function(){
			var cmpCd=$('#cmpCd').val();
			var flowerCd =$('#flowerCd').val();
			if(cmpCd!='' && flowerCd!=''){
				getSalePumList(cmpCd, flowerCd);
			}else{
				$("#itemCd").html("");
				$("#itemCd").append("<option value='' selected>공판장&부류 미선택</option>");
				$("#itemCd2").html("");
				$("#itemCd2").append("<option value='' selected>품목미선택</option>");
			}
		});
		
		selectSearch();
		
		/* 메인화면 퀵메뉴 관리 순서관리 */
		selectMenu();
		
		/* 즐겨찾기 관리 */
		selectBookmark();
		
		if('${param.type}'=='2'){
			$('.js_tabBtn02>a').trigger('click');
		}
	});
	
	//품목검색(정산테이블-일자별)
	function getSalePumList(cmpCd, flowerCd){ 
		var dt = new Date();

		// Display the month, day, and year. getMonth() returns a 0-based number.
		var year = dt.getFullYear();
		var month = dt.getMonth()-2;
		var day = dt.getDate();
		if(month<10){
			month='0'+month;
		}
		var searchStrDate=year+'-'+month+'-'+day;
		
		month = dt.getMonth()+1;
		if(month<10){
			month='0'+month;
		}
		var searchEndDate=year+'-'+month+'-'+day;
		
		$.ajax({
			type : 'get',
			url : "/search/selectPumNameDate.json",
			data : '&searchProductGubun='+flowerCd+'&searchStrDate='+searchStrDate+'&searchEndDate='+searchEndDate+'&searchCmpCd='+cmpCd,
			dataType : '',
			success : function(res) {			
				if(res.list.length>0){
					$("#itemCd").html("");
					$("#itemCd").append("<option value='' selected>선택</option>");
					for(var i=0;i<res.list.length;i++){
						$("#itemCd").append("<option value='"+res.list[i].PUM_NAME+"'>"+res.list[i].PUM_NAME+"</option>");
					}
					if(initPumCd!=''){
						$("#itemCd").val(initPumCd);
						if($("#itemCd").val()==null){
							$("#itemCd").val('');
						}
						getSaleGoodList();
					}
				}else{
					alert('해당일자에 데이터가 없습니다.')
				}
			},
		});
	}
	
	//품종검색(정산테이블-일자별)
	function getSaleGoodList(){ 
		var dt = new Date();

		// Display the month, day, and year. getMonth() returns a 0-based number.
		var year = dt.getFullYear();
		var month = dt.getMonth()-2;
		var day = dt.getDate();
		if(month<10){
			month='0'+month;
		}
		var searchStrDate=year+'-'+month+'-'+day;
		
		month = dt.getMonth()+1;
		if(month<10){
			month='0'+month;
		}
		var searchEndDate=year+'-'+month+'-'+day;
		
		var itemCd = $('#itemCd').val();
	    var flowerCd = $("#flowerCd").val();
		var cmpCd = $("#cmpCd").val();
		
		if(itemCd!=null && itemCd!=''){
			$.ajax({
				type : "post",
	    		url : "/search/selectGoodNameDate.json",
	    		data : {
	    			searchProductGubun : flowerCd,
	    			searchStrDate : searchStrDate,
	    			searchEndDate : searchEndDate,
	    			searchCmpCd : cmpCd,
	    			searchItemCd : itemCd
	    		},
				dataType : '',
				success : function(res) {
					if(res.list.length>0){
						$("#itemCd2").html("");
						$("#itemCd2").append("<option value='' selected>선택</option>");
						for(var i=0;i<res.list.length;i++){
							$("#itemCd2").append("<option value='"+res.list[i].GOOD_NAME+"'>"+res.list[i].GOOD_NAME+"</option>");
						}
						if(initGoodCd!=''){
							$("#itemCd2").val(initGoodCd);
							if($("#itemCd2").val()==null){
								$("#itemCd2").val('');
							}
						}
					}else{
						alert('해당일자에 데이터가 없습니다.')
					}
				},
			});
		}else{
			$("#itemCd2").html("");
			$("#itemCd2").append("<option value='' selected>품목미선택</option>");
		}
	}
	
	// 맞춤검색 설정 조회
	function selectSearch(){
		$.ajax({
    		type : "post",
    		url : "/customInfo/getUserSearch.json",
    		data : {},
    		dataType : '',
    		success : function(res){    
    			if(res.searchList!=undefined&&res.searchList!=null){
    				var dataList = res.searchList;
    				if(dataList!=null){
	    				if(dataList.cmpCd!=null){
	    					$('#cmpCd').val(dataList.cmpCd);	
	    				}
	    				if(dataList.flowerCd!=null){
	    					$('#flowerCd').val(dataList.flowerCd);	
	    				}
	    				if(dataList.pumCd!=null){
	    					$('#itemCd').val(dataList.pumCd);	
	    					initPumCd=dataList.pumCd;
	    				}
	    				if(dataList.goodCd!=null){
	    					$('#itemCd2').val(dataList.goodCd);	
	    					initGoodCd=dataList.goodCd;
	    				}
	    				
	    				// 데이터 로드
	    				if(dataList.cmpCd!=null && dataList.flowerCd!=null){
	    					getSalePumList(dataList.cmpCd, dataList.flowerCd);
	    				}
    				}
    			}
    		}
         });
	}
	
	// 맞춤검색 설정 변경
	function changeSearch(){
		var cmpCd=$('#cmpCd').val();
		var flowerCd=$('#flowerCd').val();
		var itemCd=$('#itemCd').val();
		var itemCd2=$('#itemCd2').val();
		
		if(cmpCd==''&&flowerCd==''&&itemCd==''&&itemCd2==''){
			alert('자주 찾는 품목 관리 설정값을 선택하세요');
			return;
		}
		
		var result = confirm('수정하시겠습니까?');
		if(result) {
			$.ajax({
	    		type : "post",
	    		url : "/customInfo/insertUserSearch.json",
	    		data : {
	    			cmpCd : cmpCd,
	    			flowerCd : flowerCd,
	    			itemCd : itemCd,
	    			itemCd2 : itemCd2
	    		},
	    		dataType : '',
	    		success : function(res){ 
	    			if(res.cnt!=null&&res.cnt=='1'){
	    				alert('수정되었습니다');
	    			}else{
	    				alert('수정에 실패하였습니다. 관리자에게 문의하세요');
	    			}
	    		}
	         });
		}
	}
	
	function selectMenu(){
		$.ajax({
    		type : "post",
    		url : "/customInfo/selectMenuList.json",
    		data : {},
    		dataType : '',
    		success : function(res){ 
    			if(res.list!=null&& res.list.length>0){
					$("#orderNum01").html("");
					$("#orderNum01").append("<option value='' selected>1순위</option>");
					$("#orderNum02").html("");
					$("#orderNum02").append("<option value='' selected>2순위</option>");
					$("#orderNum03").html("");
					$("#orderNum03").append("<option value='' selected>3순위</option>");
					$("#orderNum04").html("");
					$("#orderNum04").append("<option value='' selected>4순위</option>");
					
					for(var i=0;i<res.list.length;i++){
						var data = res.list[i];
						$("#orderNum01").append("<option value='"+data.menuCd+"'>"+data.menuDetail+"</option>");
						$("#orderNum02").append("<option value='"+data.menuCd+"'>"+data.menuDetail+"</option>");
						$("#orderNum03").append("<option value='"+data.menuCd+"'>"+data.menuDetail+"</option>");
						$("#orderNum04").append("<option value='"+data.menuCd+"'>"+data.menuDetail+"</option>");
					}
					selectMainSet();
				}else{
					alert('메인화면 퀵메뉴 관리에 오류가 발생하였습니다. 관리자에게 문의하세요.')
				}    			
    		}
         });
	}
	
	function selectDupChk(num){
		var orderTxt01=$('#orderNum01 option:selected').text();
		var orderTxt02=$('#orderNum02 option:selected').text();
		var orderTxt03=$('#orderNum03 option:selected').text();
		var orderTxt04=$('#orderNum04 option:selected').text();
		
		if(num==1){
			if(orderTxt01==orderTxt02){
				alert('이미 설정한 값이 있습니다');
				$('#orderNum01').val('');
				$('#select2-orderNum01-container').text('1순위');
				return;				
			}
			
			if(orderTxt01==orderTxt03){
				alert('이미 설정한 값이 있습니다');
				$('#orderNum01').val('');
				$('#select2-orderNum01-container').text('1순위');
				return;				
			}
			
			if(orderTxt01==orderTxt04){
				alert('이미 설정한 값이 있습니다');
				$('#orderNum01').val('');
				$('#select2-orderNum01-container').text('1순위');
				return;				
			}			
		}
		
		if(num==2){
			if(orderTxt02==orderTxt01){
				alert('이미 설정한 값이 있습니다');
				$('#orderNum02').val('');
				$('#select2-orderNum02-container').text('2순위');
				return;				
			}
			
			if(orderTxt02==orderTxt03){
				alert('이미 설정한 값이 있습니다');
				$('#orderNum02').val('');
				$('#select2-orderNum02-container').text('2순위');
				return;				
			}
			
			if(orderTxt02==orderTxt04){
				alert('이미 설정한 값이 있습니다');
				$('#orderNum02').val('');
				$('#select2-orderNum02-container').text('2순위');
				return;				
			}			
		}
		
		if(num==3){
			if(orderTxt03==orderTxt01){
				alert('이미 설정한 값이 있습니다');
				$('#orderNum03').val('');
				$('#select2-orderNum03-container').text('3순위');
				return;				
			}
			
			if(orderTxt03==orderTxt02){
				alert('이미 설정한 값이 있습니다');
				$('#orderNum03').val('');
				$('#select2-orderNum03-container').text('3순위');
				return;				
			}
			
			if(orderTxt03==orderTxt04){
				alert('이미 설정한 값이 있습니다');
				$('#orderNum03').val('');
				$('#select2-orderNum03-container').text('3순위');
				return;				
			}			
		}
		
		if(num==4){
			if(orderTxt04==orderTxt01){
				alert('이미 설정한 값이 있습니다');
				$('#orderNum04').val('');
				$('#select2-orderNum04-container').text('4순위');
				return;				
			}
			
			if(orderTxt04==orderTxt02){
				alert('이미 설정한 값이 있습니다');
				$('#orderNum04').val('');
				$('#select2-orderNum04-container').text('4순위');
				return;				
			}
			
			if(orderTxt04==orderTxt03){
				alert('이미 설정한 값이 있습니다');
				$('#orderNum04').val('');
				$('#select2-orderNum04-container').text('4순위');
				return;				
			}			
		}
	}
	
	
	// 사용자 메뉴설정 조회
	function selectMainSet(){
		$.ajax({
    		type : "post",
    		url : "/customInfo/selectMainSet.json",
    		data : {},
    		dataType : '',
    		success : function(res){    
    			if(res.selectMainSet!=undefined&&res.selectMainSet!=null){
    				var dataList = res.selectMainSet;
    				for(var i=0; i<dataList.length; i++){
    					var data=dataList[i];
    					if(data.MENU_ORDER=='1'){
    						$('#orderNum01').val(data.MENU_CD);
    						$('#select2-orderNum01-container').text(data.MENU_NM);
    					}
    					if(data.MENU_ORDER=='2'){
    						$('#orderNum02').val(data.MENU_CD);
    						$('#select2-orderNum02-container').text(data.MENU_NM);
    					}
    					if(data.MENU_ORDER=='3'){
    						$('#orderNum03').val(data.MENU_CD);
    						$('#select2-orderNum03-container').text(data.MENU_NM);
    					}
    					if(data.MENU_ORDER=='4'){
    						$('#orderNum04').val(data.MENU_CD);
    						$('#select2-orderNum04-container').text(data.MENU_NM);
    					}
    				}
    				
    				// 데이터 로드
    			}
    		}
         });
	}
		
	// 사용자 메뉴설정 변경
	function changeMainSet(){
		var orderNum01=$('#orderNum01').val();
		var orderNum02=$('#orderNum02').val();
		var orderNum03=$('#orderNum03').val();
		var orderNum04=$('#orderNum04').val();
		var orderTxt01=$('#orderNum01 option:selected').text();
		var orderTxt02=$('#orderNum02 option:selected').text();
		var orderTxt03=$('#orderNum03 option:selected').text();
		var orderTxt04=$('#orderNum04 option:selected').text();
		
		if(orderNum01==''||orderNum02==''||orderNum03==''||orderNum04==''){
			alert('모든 순위를 입력하세요');
			return;
		}
		
		var result = confirm('수정하시겠습니까?');
		if(result) {
			$.ajax({
	    		type : "post",
	    		url : "/customInfo/insertMainSet.json",
	    		data : {
	    			orderNum01 : orderNum01,
	    			orderNum02 : orderNum02,
	    			orderNum03 : orderNum03,
	    			orderNum04 : orderNum04,
	    			orderTxt01 : orderTxt01,
	    			orderTxt02 : orderTxt02,
	    			orderTxt03 : orderTxt03,
	    			orderTxt04 : orderTxt04
	    		},
	    		dataType : '',
	    		success : function(res){ 
	    			if(res.cnt!=null&&res.cnt=='1'){
	    				alert('수정되었습니다');
	    			}else{
	    				alert('수정에 실패하였습니다. 관리자에게 문의하세요');
	    			}
	    		}
	         });
		}
	}
	
	function selectBookmark(){
		$.ajax({
    		type : "post",
    		url : "/customInfo/boomarkList.json",
    		data : {},
    		dataType : '',
    		success : function(res){ 
    			$("#bookmarkList").html("");
    			for(var i=0;i<res.favoriteList.length;i++){
					var data = res.favoriteList[i];
					$("#bookmarkList").append('<p class="bookmarkP"><a href="'+data.menuUrl+'" class="txt">'+data.menuNm+'</a><button class="btn06" type="button" onClick="deleteBookmark(\''+data.menuNm+'\')">삭제</button></p>');
				}
    		}
         });
	}
	
	function deleteBookmark(menuNm){
		$.ajax({
    		type : "post",
    		url : "/customInfo/deleteFavor.json",
    		data : {menuNm:menuNm},
    		dataType : '',
    		success : function(res){ 
    			if(res.success=='Y'){
    				alert('삭제되었습니다');
    				$("#bookmarkList").html("");
        			for(var i=0;i<res.favoriteList.length;i++){
    					var data = res.favoriteList[i];
    					$("#bookmarkList").append('<p class="bookmarkP"><a href="'+data.menuUrl+'" class="txt">'+data.menuNm+'</a><button class="btn06" type="button" onClick="deleteBookmark(\''+data.menuNm+'\')">삭제</button></p>');
    				}	
    			}else{
    				alert('삭제실패하였습니다. 관리자에게 문의하세요');
    			}
    			
    		}
         });
	}
	
	function goPage(){
		location.href="/customInfo/customInfoForm.do";
	}
	
	function deleteUser(){
		var result = confirm('탈퇴하시면 기존 등록정보를 이용하실 수 없습니다. 그래도 탈퇴하시겠습니까?');
		if(result) {
			$.ajax({
	    		type : "post",
	    		url : "/customInfo/deleteUser.json",
	    		data : {},
	    		dataType : '',
	    		success : function(res){ 
	    			if(res.success=='Y'){
	    				alert('탈퇴되었습니다');
	        			location.href="/customInfo/logOut.do";
	    			}else{
	    				alert('탈퇴실패하였습니다. 관리자에게 문의하세요');
	    			}
	    			
	    		}
	         });
		}
	}
	</script>
</head>
<body>
	<!--WRAP(S)-->
	<div class="wrap">
		 
		<jsp:include page="../inc/2020/IncHeader.jsp"/>	

		<!--콘텐츠_메인(S)-->
		<div class="conts_main">
			<div class="conts_main_in">

				<!-- 서브타이틀(S) -->
				<div class="log_title_box">
					<h2 class="log_tit">정보수정</h2>
					<p class="log_sant">화훼유통정보 홈페이지 회원가입을 환영합니다.</p>
				</div>
				<!-- 서브타이틀(E) -->

				<!-- 탭버튼(S) -->
				<div class="tab_btn devide_2">
					<ul>
						<li class="on"><a href="#!">자주 찾는 품목관리</a></li>
						<li><a href="/customInfo/loginCustomInfo.do">가격문자 알림서비스</a></li>
					</ul>
				</div>
				<!-- 탭버튼(E) -->

				<!-- 타이틀(S) -->
				<div class="tit_box_02">
					<div class="fl">
						<h3 class="sub_title_01">자주 찾는 품목 관리</h3>
					</div>
				</div>
				<!-- 타이틀(E) -->
				
				<!-- 테이블(S) -->
				<table class="table_type_01">
					<caption>자주 찾는 품목 관리</caption>
					<colgroup>
						<col style="width:25%">
						<col style="width:75%">
					</colgroup>
					<tbody>
						<tr>
							<th>공판장 선택</th>
							<td>
								<label for="cmpCd" ></label>
								<select class="select size_01" id="cmpCd" >
									<option value=''  selected="selected">공판장선택</option>
									<option value="0000000001">aT화훼공판장(양재동)</option>
									<option value="1508500020">부산화훼공판장(엄궁동)</option>
									<option value="6068207466">부산경남화훼농협(강동동)</option>
									<option value="4108212335">광주원예농협(풍암)</option>
									<option value="3848200087">한국화훼농협(음성)</option>
									<option value="1288202296">한국화훼농협(과천)</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>부류선택</th>
							<td>
								<label for="flowerCd" ></label>
								<select class="select size_01" id="flowerCd" >
									<option value=''  selected="selected">부류선택</option>
									<option value="1">절화</option>
									<option value="3">난</option>
									<option value="2">관엽</option>
									<option value="4">춘란</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>품목선택</th>
							<td>
								<label for="itemCd" ></label>
								<select class="select size_01" id="itemCd" >
									<option value=''  selected="selected">공판장&부류 미선택</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>품종선택</th>
							<td>
								<label for="itemCd2" ></label>
								<select class="select size_01" id="itemCd2" >
									<option value='' selected="selected">품목 미선택</option>
								</select>
							</td>
						</tr>
					</tbody>
				</table>
				<!-- 테이블(E) -->			
				
				<!-- 버튼박스(S) -->
				<div class="btn_box tc">
					<a href="javascript:void(0);" class="btn_type_02" onclick="changeSearch()">수정</a>
				</div>
				<!-- 버튼박스(E) -->

				<!-- 타이틀(S) -->
				<div class="tit_box_02">
					<div class="fl">
						<h3 class="sub_title_01">회원 탈퇴</h3>
					</div>
				</div>
				<!-- 타이틀(E) -->

				<!-- 텍스트박스(S) -->
				<div class="notice_box_01 tc">
					<p class="notice_common">탈퇴하시면 기존 등록정보를 이용하실 수 없습니다. 그래도 탈퇴하시겠습니까?</p>
				</div>
				<!-- 텍스트박스(E) -->

				<!-- 버튼박스(S) -->
				<div class="btn_box tc">
					<a href="javascript:void(0);" class="btn_type_02 on" onclick="deleteUser()">회원탈퇴</a>
				</div>
				<!-- 버튼박스(E) -->
			</div>
		</div>
		<!--콘텐츠_메인(E)-->

		<jsp:include page="../inc/2020/IncFooter.jsp"/>
		
	</div>
	<!--WRAP(E)-->
</body>
</html>