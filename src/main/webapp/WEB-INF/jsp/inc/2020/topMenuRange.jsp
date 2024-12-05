<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
var firstSearch1=true;

$(document).ready(function(){
	// 검색 selectbox
	//$('#itemCd').select2();
	// 검색 selectbox
	//$('#itemCd2').select2();
	// 검색 selectbox
	$('#itemCd').select2().on('select2:open', function(){
		setTimeout(function() {
			$('.select2-search__field').blur();
		  }, 0);
	});
	// 검색 selectbox
	$('#itemCd2').select2().on('select2:open', function(){
		setTimeout(function() {
			$('.select2-search__field').blur();
		  }, 0);
	});

	// 공유설정

	if('${param.flowerCd}'!=''){
		$.cookie("cookie.cmpCd", '${param.cmpCd}', {expires: 7, path: '/' });
		$.cookie("cookie.flowerCd", '${param.flowerCd}', { expires: 7, path: '/' });
		$.cookie("cookie.pumCd", '${param.itemCd}',{ expires: 7, path: '/' });
		$.cookie("cookie.goodCd", '${param.itemCd2}', { expires: 7, path: '/' });
	}


	// WEB 공판장 선택
	$(".dt li a, .tab_dt a, .ct_gnb > li > a").click(function(){

		cmpCd = $("#cmpCdTab .on > input").attr("value");
		flowerCd = $("#flowerTab .on > input").attr("value");

		// mob selectbox 선택 추가
		$("#mobCmpCdLab").text($("#cmpCdTab .on > a").text());
		$("#mobCmpCd").val(cmpCd);
		$("#mobFlowerCdLab").text($("#flowerTab .on > a > img").attr('alt'));
		$("#mobFlowerCd").val(flowerCd);

		if(flowerCd == '1' || flowerCd == '2' || flowerCd == '3' || flowerCd == '4' ){
			$("#searchProductGubun").val(flowerCd);
		}else{
			$("#searchProductGubun").val("");
		}
		if(cmpCd == '0000000001' || cmpCd == '1508500020' || cmpCd == '6068207466' || cmpCd == '4108212335' || cmpCd == '3848200087' || cmpCd == '1288202296' || cmpCd == '6158209828'){
			$("#searchCmpCd").val(cmpCd);
		}else {
			$("#searchCmpCd").val("");
		}

		getSaledate(cmpCd, flowerCd);

		return false;
	});

	// WEB 부류선택 선택
	$(".flowerTab li a").click(function(){

		cmpCd = $("#cmpCdTab .on > input").attr("value");
		flowerCd = $("#flowerTab .on > input").attr("value");

		$("#mobCmpCdLab").text($("#cmpCdTab .on > a").text());
		$("#mobCmpCd").val(cmpCd);
		$("#mobFlowerCdLab").text($("#flowerTab .on > a > img").attr('alt'));
		$("#mobFlowerCd").val(flowerCd);

		if(flowerCd == '1' || flowerCd == '2' || flowerCd == '3' || flowerCd == '4' ){
			$("#searchProductGubun").val(flowerCd);
		}else{
			$("#searchProductGubun").val("");
		}
		if(cmpCd == '0000000001' || cmpCd == '1508500020' || cmpCd == '6068207466' || cmpCd == '4108212335' || cmpCd == '3848200087' || cmpCd == '1288202296' || cmpCd == '6158209828'){
			$("#searchCmpCd").val(cmpCd);
		}else {
			$("#searchCmpCd").val("");
		}
		getSaledate(cmpCd, flowerCd);
		return false;
	});

	// MOB 공판장 선택
	$("#mobCmpCd").change(function(){
		cmpCd = $("#mobCmpCd option:selected").val();
		flowerCd = $("#mobFlowerCd option:selected").val();

		if(flowerCd == '1' || flowerCd == '2' || flowerCd == '3' || flowerCd == '4' ){
			$("#searchProductGubun").val(flowerCd);
		}else{
			$("#searchProductGubun").val("");
		}

		if(cmpCd == '0000000001' || cmpCd == '1508500020' || cmpCd == '6068207466' || cmpCd == '4108212335' || cmpCd == '3848200087' || cmpCd == '1288202296' || cmpCd == '6158209828'){
			$("#searchCmpCd").val(cmpCd);
		}else {
			$("#searchCmpCd").val("");
		}

		var cmpIdx=$("#mobCmpCd option").index($("#mobCmpCd option:selected"));
		var flowerIdx=$("#mobFlowerCd option").index($("#mobFlowerCd option:selected"));

		$("#cmpCdTab  .li0"+(cmpIdx+1)+" > a").click();
	});

	// MOB 부류선택 선택
	$("#mobFlowerCd").change(function(){
		cmpCd = $("#mobCmpCd option:selected").val();
		flowerCd = $("#mobFlowerCd option:selected").val();

		if(flowerCd == '1' || flowerCd == '2' || flowerCd == '3' || flowerCd == '4' ){
			$("#searchProductGubun").val(flowerCd);
		}else{
			$("#searchProductGubun").val("");
		}

		if(cmpCd == '0000000001' || cmpCd == '1508500020' || cmpCd == '6068207466' || cmpCd == '4108212335' || cmpCd == '3848200087' || cmpCd == '1288202296' || cmpCd == '6158209828'){
			$("#searchCmpCd").val(cmpCd);
		}else {
			$("#searchCmpCd").val("");
		}

		var cmpIdx=$("#mobCmpCd option").index($("#mobCmpCd option:selected"));
		var flowerIdx=$("#mobFlowerCd option").index($("#mobFlowerCd option:selected"));

		$("#flowerTab  .li0"+(flowerIdx+1)+" > a").click();
	});

	// 사용자 맞춤설정(세션값 선택)
	if('${sessionScope.searchList}'!=null&&'${sessionScope.searchList}'!=''){
		cmpCd = '${sessionScope.searchList.cmpCd}';
		flowerCd = '${sessionScope.searchList.flowerCd}';

		if(flowerCd == '1' || flowerCd == '2' || flowerCd == '3' || flowerCd == '4' ){
			$("#searchProductGubun").val(flowerCd);
			$("#mobFlowerCd").val(flowerCd);
		}else{
			$("#searchProductGubun").val("1");
			$("#mobFlowerCd").val("1");
		}

		if(cmpCd == '0000000001' || cmpCd == '1508500020' || cmpCd == '6068207466' || cmpCd == '4108212335' || cmpCd == '3848200087' || cmpCd == '1288202296' || cmpCd == '6158209828'){
			$("#searchCmpCd").val(cmpCd);
			$("#mobCmpCd").val(cmpCd);
		}else {
			$("#searchCmpCd").val("0000000001");
			$("#mobCmpCd").val("0000000001");
		}

		var cmpIdx=$("#mobCmpCd option").index($("#mobCmpCd option:selected"));
		var flowerIdx=$("#mobFlowerCd option").index($("#mobFlowerCd option:selected"));

		setMenuInit(cmpIdx,flowerIdx);

	}else if($.cookie("cookie.cmpCd")!=undefined&&$.cookie("cookie.cmpCd")!=''){// 쿠키설정 로드
		cmpCd = $.cookie("cookie.cmpCd");
		flowerCd = $.cookie("cookie.flowerCd");

		if(flowerCd == '1' || flowerCd == '2' || flowerCd == '3' || flowerCd == '4' ){
			$("#searchProductGubun").val(flowerCd);
			$("#mobFlowerCd").val(flowerCd);
		}else{
			$("#searchProductGubun").val("1");
			$("#mobFlowerCd").val("1");
		}

		if(cmpCd == '0000000001' || cmpCd == '1508500020' || cmpCd == '6068207466' || cmpCd == '4108212335' || cmpCd == '3848200087' || cmpCd == '1288202296' || cmpCd == '6158209828'){
			$("#searchCmpCd").val(cmpCd);
			$("#mobCmpCd").val(cmpCd);
		}else {
			$("#searchCmpCd").val("0000000001");
			$("#mobCmpCd").val("0000000001");
		}

		var cmpIdx=$("#mobCmpCd option").index($("#mobCmpCd option:selected"));
		var flowerIdx=$("#mobFlowerCd option").index($("#mobFlowerCd option:selected"));

		setMenuInit(cmpIdx,flowerIdx);
	}

	cmpCd = $("#mobCmpCd option:selected").val();
	flowerCd = $("#mobFlowerCd option:selected").val();
	getSaledate(cmpCd, flowerCd);

});

function setMenuInit(cmpIdx,flowerIdx){
	$(".ct_gnb > li > a").each(function(index){
		$(this).parent().removeClass("on");
		$(this).parent().removeClass("s_on");
		if(index==cmpIdx){
			$(this).parent().addClass("on");
			$(this).parent().addClass("s_on");
		}
	});

	$(".flowerTab li a").each(function(index){
		var str = $(this).parent().attr("class");
		str = str.substring(5,7);

		$(this).children().attr({"src":"../images/2020/sub/step_"+str+"_off.png"});
		$(this).parent().removeClass("on");

		if(flowerIdx==index){
			$(this).children().attr({"src": "../images/2020/sub/step_"+str+"_on.png"});
			$(this).parent().addClass("on");
		}

	});

}
//품목검색(정산테이블-일자별)
function getSalePumList(cmpCd, flowerCd, searchStrDate, searchEndDate){
	$.ajax({
		type : 'get',
		url : "/search/selectPumNameDate.json",
		data : '&searchProductGubun='+flowerCd+'&searchStrDate='+searchStrDate+'&searchEndDate='+searchEndDate+'&searchCmpCd='+cmpCd,
		dataType : '',
		success : function(res) {
			if(res.list.length>0){
				$("#itemCd").html("");
				$("#itemCd").append("<option value='' selected>전체</option>");
				var pumCd='';

				if(firstSearch1==true){
					// 쿠키설정 로드
					if($.cookie("cookie.pumCd")!=undefined&&$.cookie("cookie.pumCd")!=''){
						pumCd =$.cookie("cookie.pumCd");
						for(var i=0;i<res.list.length;i++){
							if(pumCd==res.list[i].PUM_NAME){
								$("#itemCd").append("<option value='"+res.list[i].PUM_NAME+"' selected>"+res.list[i].PUM_NAME+"</option>");
							}else{
								$("#itemCd").append("<option value='"+res.list[i].PUM_NAME+"'>"+res.list[i].PUM_NAME+"</option>");
							}
						}
						// 품목이 없을경우
						if($('#itemCd option:selected').val()==''){
							search();
							firstSearch1=false;	//1회만 검색
							getSaleGoodList();
						}else{
							var goodCd = $.cookie("cookie.goodCd");

							if(goodCd==undefined||goodCd==''){
								// 초기 검색
								search();
								firstSearch1=false;	//1회만 검색
								getSaleGoodList();
							}else{
								// 품종에서 검색
								getSaleGoodList();
							}
						}

					}else if(firstSearch1&& '${sessionScope.searchList}'!=null&&'${sessionScope.searchList}'!=''&&'${sessionScope.searchList.pumCd}'!=''){
						// 사용자 맞춤설정(세션값 선택)
						pumCd = '${sessionScope.searchList.pumCd}';
						for(var i=0;i<res.list.length;i++){
							if(pumCd==res.list[i].PUM_NAME){
								$("#itemCd").append("<option value='"+res.list[i].PUM_NAME+"' selected>"+res.list[i].PUM_NAME+"</option>");
							}else{
								$("#itemCd").append("<option value='"+res.list[i].PUM_NAME+"'>"+res.list[i].PUM_NAME+"</option>");
							}
						}

						var goodCd = '${sessionScope.searchList.goodCd}';

						if(firstSearch1==true&&'${sessionScope.searchList}'!=null&&'${sessionScope.searchList}'!=''&&'${sessionScope.searchList.goodCd}'==''){
							// 초기 검색
							search();
							firstSearch1=false;	//1회만 검색
						}else{
							// 품종에서 검색
							getSaleGoodList();
						}

					}else{
						for(var i=0;i<res.list.length;i++){
							$("#itemCd").append("<option value='"+res.list[i].PUM_NAME+"'>"+res.list[i].PUM_NAME+"</option>");
						}
						search();
					}

				}else{
					for(var i=0;i<res.list.length;i++){
						$("#itemCd").append("<option value='"+res.list[i].PUM_NAME+"'>"+res.list[i].PUM_NAME+"</option>");
					}
					search();
				}
			}else{
				alert('해당일자에 데이터가 없습니다.');
				// 검색하여 값 초기화
				//search();
			}
		},
	});
}

//품종검색(정산테이블-일자별)
function getSaleGoodList(){
	var itemCd = $('#itemCd option:selected').val();
	var searchStrDate = $("#searchStrDate").val();
	var searchEndDate = $("#searchEndDate").val();
    var flowerCd = $("#flowerTab .on > input").attr("value");
	var cmpCd = $("#cmpCdTab .on > input").attr("value");

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
				$("#itemCd2").html("");
				$("#itemCd2").append("<option value='' selected>전체</option>");
				var goodCd='';

				if(firstSearch1==true){
					// 쿠키설정 로드
					if('${sessionScope.searchList}'!=null&&'${sessionScope.searchList}'!=''&&'${sessionScope.searchList.goodCd}'!=''){
						// 사용자 맞춤설정(세션값 선택)
						goodCd = '${sessionScope.searchList.goodCd}';
						for(var i=0;i<res.list.length;i++){
							if(goodCd==res.list[i].GOOD_NAME){
								$("#itemCd2").append("<option value='"+res.list[i].GOOD_NAME+"' selected>"+res.list[i].GOOD_NAME+"</option>");
							}else{
								$("#itemCd2").append("<option value='"+res.list[i].GOOD_NAME+"'>"+res.list[i].GOOD_NAME+"</option>");
							}
						}
						search();
						firstSearch1=false;
					} else if(firstSearch1==true&&$.cookie("cookie.goodCd")!=undefined&&$.cookie("cookie.goodCd")!=''){
						goodCd =$.cookie("cookie.goodCd");
						for(var i=0;i<res.list.length;i++){
							if(goodCd==res.list[i].GOOD_NAME){
								$("#itemCd2").append("<option value='"+res.list[i].GOOD_NAME+"' selected>"+res.list[i].GOOD_NAME+"</option>");
							}else{
								$("#itemCd2").append("<option value='"+res.list[i].GOOD_NAME+"'>"+res.list[i].GOOD_NAME+"</option>");
							}
						}

						search();
						firstSearch1=false;	//1회만 검색
					}else{
						for(var i=0;i<res.list.length;i++){
							$("#itemCd2").append("<option value='"+res.list[i].GOOD_NAME+"'>"+res.list[i].GOOD_NAME+"</option>");
						}
					}

				}else{
					for(var i=0;i<res.list.length;i++){
						$("#itemCd2").append("<option value='"+res.list[i].GOOD_NAME+"'>"+res.list[i].GOOD_NAME+"</option>");
					}
				}
			},
		});
	}else{
		$("#itemCd2").html("");
		$("#itemCd2").append("<option value='' selected>품목미선택</option>");
	}
}

//품목검색(정산테이블-월별)
// selectCnt 선택할 itemCnt 값
function getSaleMonthPumList(cmpCd, flowerCd, searchStrDate, searchEndDate, selectCnt){
	$.ajax({
		type : 'get',
		url : "/search/selectPumNameMonth.json",
		data : '&searchProductGubun='+flowerCd+'&searchStrDate='+searchStrDate+'&searchEndDate='+searchEndDate+'&searchCmpCd='+cmpCd,
		dataType : '',
		success : function(res) {
			if(res.list.length>0){
				$("#itemCd").html("");
				$("#itemCd").append("<option value='' selected>전체</option>");
				var pumCd='';

				if(firstSearch1==true){
					// 쿠키설정 로드
					if( '${sessionScope.searchList}'!=null&&'${sessionScope.searchList}'!=''&&'${sessionScope.searchList.pumCd}'!=''){
						// 사용자 맞춤설정(세션값 선택)
						pumCd = '${sessionScope.searchList.pumCd}';
						for(var i=0;i<res.list.length;i++){
							if(pumCd==res.list[i].PUM_NAME){
								$("#itemCd").append("<option value='"+res.list[i].PUM_NAME+"' selected>"+res.list[i].PUM_NAME+"</option>");
							}else{
								$("#itemCd").append("<option value='"+res.list[i].PUM_NAME+"'>"+res.list[i].PUM_NAME+"</option>");
							}
						}

						var goodCd = '${sessionScope.searchList.goodCd}';

						if(firstSearch1==true&&'${sessionScope.searchList}'!=null&&'${sessionScope.searchList}'!=''&&'${sessionScope.searchList.goodCd}'==''){
							// 초기 검색
							search();
							firstSearch1=false;	//1회만 검색
						}else{
							// 품종에서 검색
							getSaleMonthGoodList();
						}
					}else if(firstSearch1&&$.cookie("cookie.pumCd")!=undefined&&$.cookie("cookie.pumCd")!=''){

						pumCd =$.cookie("cookie.pumCd");
						for(var i=0;i<res.list.length;i++){
							if(pumCd==res.list[i].PUM_NAME){
								$("#itemCd").append("<option value='"+res.list[i].PUM_NAME+"' selected>"+res.list[i].PUM_NAME+"</option>");
							}else{
								$("#itemCd").append("<option value='"+res.list[i].PUM_NAME+"'>"+res.list[i].PUM_NAME+"</option>");
							}
						}

						// 품목이 없을경우
						if($('#itemCd option:selected').val()==''){
							search();
							firstSearch1=false;	//1회만 검색
							getSaleMonthGoodList();
						}else{
							var goodCd = $.cookie("cookie.goodCd");

							if(goodCd==undefined||goodCd==''){
								// 초기 검색
								search();
								firstSearch1=false;	//1회만 검색
								getSaleMonthGoodList();
							}else{
								// 품종에서 검색
								getSaleMonthGoodList();
							}
						}
					}else{
						for(var i=0;i<res.list.length;i++){
							$("#itemCd").append("<option value='"+res.list[i].PUM_NAME+"'>"+res.list[i].PUM_NAME+"</option>");
						}
						search();
					}

				}else{
					for(var i=0;i<res.list.length;i++){
						$("#itemCd").append("<option value='"+res.list[i].PUM_NAME+"'>"+res.list[i].PUM_NAME+"</option>");
					}
					search();
				}
			}else{
				alert('해당일자에 데이터가 없습니다.');
				// 검색하여 값 초기화
				//search();
			}
		}
	});
}

//품종검색(정산테이블-월별)
//selectCnt 선택할 itemCnt 값
function getSaleMonthGoodList(){
	var itemCd = $('#itemCd option:selected').val();
	var searchStrDate = $("#searchStrDate").val();
   	var searchEndDate = $("#searchEndDate").val();
    var flowerCd = $("#flowerTab .on > input").attr("value");
	var cmpCd = $("#cmpCdTab .on > input").attr("value");

	if(itemCd!=null && itemCd!=''){
		$.ajax({
			type : "post",
    		url : "/search/selectGoodNameMonth.json",
    		data : {
    			searchProductGubun : flowerCd,
    			searchCmpCd : cmpCd,
    			searchItemCd : itemCd,
    			searchStrDate : searchStrDate,
    			searchEndDate : searchEndDate
    		},
			dataType : '',
			success : function(res) {
				$("#itemCd2").html("");
				$("#itemCd2").append("<option value='' selected>전체</option>");
				var goodCd='';

				if(firstSearch1==true){
					// 쿠키설정 로드
					if('${sessionScope.searchList}'!=null&&'${sessionScope.searchList}'!=''&&'${sessionScope.searchList.goodCd}'!=''){
						// 사용자 맞춤설정(세션값 선택)
						goodCd = '${sessionScope.searchList.goodCd}';
						for(var i=0;i<res.list.length;i++){
							if(goodCd==res.list[i].GOOD_NAME){
								$("#itemCd2").append("<option value='"+res.list[i].GOOD_NAME+"' selected>"+res.list[i].GOOD_NAME+"</option>");
							}else{
								$("#itemCd2").append("<option value='"+res.list[i].GOOD_NAME+"'>"+res.list[i].GOOD_NAME+"</option>");
							}
						}
						search();
						firstSearch1=false;
					} else if(firstSearch1==true&&$.cookie("cookie.goodCd")!=undefined&&$.cookie("cookie.goodCd")!=''){
						goodCd =$.cookie("cookie.goodCd");
						for(var i=0;i<res.list.length;i++){
							if(goodCd==res.list[i].GOOD_NAME){
								$("#itemCd2").append("<option value='"+res.list[i].GOOD_NAME+"' selected>"+res.list[i].GOOD_NAME+"</option>");
							}else{
								$("#itemCd2").append("<option value='"+res.list[i].GOOD_NAME+"'>"+res.list[i].GOOD_NAME+"</option>");
							}
						}

						search();
						firstSearch1=false;	//1회만 검색
					}else{
						for(var i=0;i<res.list.length;i++){
							$("#itemCd2").append("<option value='"+res.list[i].GOOD_NAME+"'>"+res.list[i].GOOD_NAME+"</option>");
						}
					}

				}else{
					for(var i=0;i<res.list.length;i++){
						$("#itemCd2").append("<option value='"+res.list[i].GOOD_NAME+"'>"+res.list[i].GOOD_NAME+"</option>");
					}
				}
			},
		});
	}else{
		$("#itemCd2").html("");
		$("#itemCd2").append("<option value='' selected>품목미선택</option>");
	}
}

function getItemInit(){
	$("#itemCd").html("");
	$("#itemCd").append("<option value='' selected>전체</option>");

	$("#itemCd2").html("");
	$("#itemCd2").append("<option value='' selected>품목미선택</option>");
}


function addThousandSeparatorCommas(num) {
    return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
}
</script>

		<!--서브공통 (S)-->
		<div class="sub_contents">
			<!--서브 리스트 (S)-->
			<div class="sub_content">
				<ul class="sub_tab ct_gnb" id="cmpCdTab">
					<li class="on s_on"><input type="hidden" value="0000000001"/><a href="#">aT화훼공판장 <br/> <span>(양재동)</span></a></li>
					<li><input type="hidden" value="1508500020"/><a href="#">부산화훼공판장 <br/> <span>(엄궁동)</span></a></li>
					<li><input type="hidden" value="6068207466"/><a href="#">부산경남화훼농협 <br/> <span>(강동동)</span></a></li>
					<li><input type="hidden" value="4108212335"/><a href="#">광주원예농협 <br/> <span>(풍암)</span></a></li>
					<li><input type="hidden" value="3848200087"/><a href="#">한국화훼농협 <br/> <span>(음성)</span></a></li>
					<li><input type="hidden" value="1288202296"/><a href="#" onclick="gwacheonAlert();">한국화훼농협 <br/> <span>(과천)</span></a></li>
					<li><input type="hidden" value="7368200686"/><a href="#">한국화훼농협 <br/> <span>(고양)</span></a></li>
					<li><input type="hidden" value="6158209828"/><a href="#">영남화훼농협 <br/> <span>(김해)</span></a></li>

				</ul>
			</div>
			<!--서브 리스트 (E)-->
			<!--서브 TAB공통 (S)-->
			<div class="sub_tab_yangjae">
				<div class="yangjae_list">
					<ul class="sub_fw_btn flowerTab btNo ptNo" id="flowerTab">
						<li class="step_01 on">
							<input type="hidden" value="1"/>
							<a href="#!" >
								절화
							</a>
						</li>
						<li class="step_02">
							<input type="hidden" value="3"/>
							<a href="#!" >
								난
							</a>
						</li>
						<li class="step_03">
							<input type="hidden" value="2"/>
							<a href="#!" >
								관엽
							</a>
						</li>
						<li class="step_04">
							<input type="hidden" value="4"/>
							<a href="#!">
								춘란
							</a>
						</li>
					</ul>
				</div>
				<div class="search_box">
					<div class="search_01">
						<ul class="search_box01">
							<li style="display:none;">
								<p class="search_01_txt">공판장선택</p>
								<select id="mobCmpCd" name="mobCmpCd">
									<option value="0000000001" selected="selected">aT화훼공판장(양재동)</option>
									<option value="1508500020">부산화훼공판장(엄궁동)</option>
									<option value="6068207466">부산경남화훼농협(강동동)</option>
									<option value="4108212335">광주원예농협(풍암)</option>
									<option value="3848200087">한국화훼농협(음성)</option>
									<option value="1288202296">한국화훼농협(과천)</option>
									<option value="6158209828">영남화훼농협(김해)</option>
								</select>
							</li>
							<li style="display:none;">
								<p class="search_01_txt">부류선택</p>
								<select id="mobFlowerCd" name="mobFlowerCd">
									<option value="1" selected="selected">절화</option>
									<option value="3">난</option>
									<option value="2">관엽</option>
									<option value="4">춘란</option>
								</select>
							</li>
							<li class="calendar" id="liStrDate">
								<p class="search_01_txt">시작일자</p>
								<input type="text" class="datepicker" name="searchStrDate" id="searchStrDate" value="${param.searchStrDate}" />
							</li>
							<li class="calendar" id="liEndDate">
								<p class="search_01_txt">종료일자</p>
								<input type="text" class="datepicker" name="searchEndDate" id="searchEndDate" value="${param.searchEndDate}" />
							</li>
							<li id="pumSelectbox">
								<p class="search_01_txt">품목</p>
								<select id="itemCd" name="itemCd" class="form-control">
								</select>
							</li>
							<li id="goodSelectbox" style="display: none;">
								<p class="search_01_txt">품종</p>
								<select id="itemCd2" name="itemCd2" class="form-control">
								</select>
							</li>
							<li class="search_btn">
								<a href="javascript:search()"><img src="../images/2020/sub/search_img.png" alt="돋보기">검색</a>
							</li>
						</ul>
					</div>
				</div>
			</div>
			<!--서브 TAB공통 (E)-->
		</div>