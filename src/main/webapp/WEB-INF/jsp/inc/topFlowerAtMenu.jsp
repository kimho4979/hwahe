<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
var firstSearch1=true;

$(document).ready(function(){
	// 검색 selectbox
	$('#itemCd').select2();
	// 검색 selectbox
	//$('#itemCd2').select2();
	
	// WEB 부류선택 선택
	$(".flowerTab li a").click(function(){
		//flowerCd = $(this).parent().attr("value");
		flowerCd = $("#flowerTab .on > input").attr("value");
		
		$("#mobFlowerCdLab").text($("#flowerTab .on > a > img").attr('alt'));
		$("#mobFlowerCd").val(flowerCd);
		
		if(flowerCd == '1' || flowerCd == '3'){
			$("#searchProductGubun").val(flowerCd);
		}else{
			$("#searchProductGubun").val("1");
		}
		
		getSaledate(flowerCd);
		return false;
	});
	
	// MOB 부류선택 선택
	$("#mobFlowerCd").change(function(){
		flowerCd = $("#mobFlowerCd option:selected").val();
		
		if(flowerCd == '1' || flowerCd == '3'){
			$("#searchProductGubun").val(flowerCd);
		}else{
			$("#searchProductGubun").val("1");
		}
		
		var flowerIdx=$("#mobFlowerCd option").index($("#mobFlowerCd option:selected"));
		
		$("#flowerTab  .li0"+(flowerIdx+1)+" > a").click();
	});
	
	// 사용자 맞춤설정
	// 세션값 선택
	if('${sessionScope.searchList}'!=null&&'${sessionScope.searchList}'!=''){
		flowerCd = '${sessionScope.searchList.flowerCd}';
		
		if(flowerCd == '1' || flowerCd == '3'){
			$("#searchProductGubun").val(flowerCd);
			$("#mobFlowerCd").val(flowerCd);
		}else{
			$("#searchProductGubun").val("1");
			$("#mobFlowerCd").val("1");
		}
		
		var flowerIdx=$("#mobFlowerCd option").index($("#mobFlowerCd option:selected"));
		
		setMenuInit(flowerIdx);
		
	}else if($.cookie("cookie.cmpCd")!=undefined&&$.cookie("cookie.cmpCd")!=''){// 쿠키설정 로드
		flowerCd = $.cookie("cookie.flowerCd");
		
		if(flowerCd == '1' || flowerCd == '3'){
			$("#searchProductGubun").val(flowerCd);
			$("#mobFlowerCd").val(flowerCd);
		}else{
			$("#searchProductGubun").val("1");
			$("#mobFlowerCd").val("1");
		}
		
		var flowerIdx=$("#mobFlowerCd option").index($("#mobFlowerCd option:selected"));
		
		setMenuInit(flowerIdx);
	}
	
	flowerCd = $("#flowerTab .on > input").attr("value");
	
	getSaledate(flowerCd);
});

function setMenuInit(flowerIdx){
	$(".flowerTab li a").each(function(index){
		var str = $(this).parent().attr("class");
		str = str.substring(2,4);

		$(this).children().attr({"src":"../images/content/flowerTab"+str+"_off.png"});
		$(this).parent().removeClass("on");		
		
		if(flowerIdx==index){
			$(this).children().attr({"src": "../images/content/flowerTab"+str+"_on.png"});
			$(this).parent().addClass("on");	
		}
	});
}

//품목검색(유찰테이블)
function getYuchalPumList(flowerCd, searchStrDate, searchEndDate){ 
	var flowerGubn="N";
	
	if(flowerCd==1){
		flowerGubn="N";
	}else if(flowerCd==3){
		flowerGubn="Y";
	}else if(flowerCd==2){
		flowerGubn="C";
	}else{
		flowerGubn="G";
	}
	
	$.ajax({
		type : 'get',
		url : "/search/selectPumNameYuchal.json",
		data : '&searchProductGubun='+flowerGubn+'&searchStrDate='+searchStrDate+'&searchEndDate='+searchEndDate,
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
							//getSaleGoodList();
							search();
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
							//getSaleGoodList();
						}else{
							var goodCd = $.cookie("cookie.goodCd");
							
							if(goodCd==undefined||goodCd==''){
								// 초기 검색
								search();
								firstSearch1=false;	//1회만 검색
								//getSaleGoodList();
							}else{
								// 품종에서 검색
								//getSaleGoodList();
								search();
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

//품종검색(유찰테이블)
function getYuchalGoodList(){ 
	var itemCd = $('#itemCd option:selected').val();
	var searchStrDate = $("#searchStrDate").val().replace(/-/gi, "");
	var searchEndDate = $("#searchEndDate").val().replace(/-/gi, "");
    var flowerCd = $("#flowerTab .on > input").attr("value");
	var flowerGubn="N";
	
	if(flowerCd==1){
		flowerGubn="N";
	}else if(flowerCd==3){
		flowerGubn="Y";
	}else if(flowerCd==2){
		flowerGubn="C";
	}else{
		flowerGubn="G";
	}
	
	if(itemCd!=null && itemCd!=''){
		$.ajax({
			type : "post",
    		url : "/search/selectGoodNameYuchal.json",
    		data : {
    			searchProductGubun : flowerGubn,
    			searchStrDate : searchStrDate,
    			searchEndDate : searchEndDate,
    			searchItemCd : itemCd
    		},
			dataType : '',
			success : function(res) {
				if(res.list.length>0){
					$("#itemCd2").html("");
					$("#itemCd2").append("<option value='' selected>전체</option>");
					for(var i=0;i<res.list.length;i++){
						$("#itemCd2").append("<option value='"+res.list[i].GOOD_NAME+"'>"+res.list[i].GOOD_NAME+"</option>");
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
<div class="pcverWrap">
	<ul class="flowerTab btNo ptNo tabList2" id="flowerTab">
		<li class="li01 on"><input type="hidden" value="1"/><a href="#"><img src="../images/content/flowerTab01_on.png" alt="절화" /></a></li>
		<li class="li02"><input type="hidden" value="3"/><a href="#"><img src="../images/content/flowerTab02_off.png" alt="난" /></a></li>
		<!-- <li class="li03"><input type="hidden" value="2"/><a href="#"><img src="../images/content/flowerTab03_off.png" alt="관엽" /></a></li> -->
	</ul><!-- flowerTab end -->
</div><!-- pcverWrap end -->					
<section class="section content01">
	<div class="mbverWrap mb_ctHead">
		<ul class="selectWrap">
			<li class="mr5">부류선택</li>
			<li class="selectbox width160" style="">
				<label for="mobFlowerCd" id="mobFlowerCdLab">절화</label>
				<select id="mobFlowerCd" name="mobFlowerCd">
					<option value="1" selected="selected">절화</option>
					<option value="3">난</option>
					<!-- <option value="2">관엽</option> -->
				</select>
			</li>
		</ul>
		<ul class="btnWrap">
			<li class="li01">
				<label for="searchStrDate">시작일자</label>
				<input type="text" class="calender" name="searchStrDate" id="searchStrDate" />
			</li><!-- li01 end -->
			<li class="li02">
				<label for="searchEndDate">종료일자</label>
				<input type="text" class="calender" name="searchEndDate" id="searchEndDate" />
			</li>
			<li class="li04"  id="pumSelectbox">
				<label for="itemCd" id="itemCdLab">품목선택</label>
				<select id="itemCd" name="itemCd" style="width: 150px;">
				</select>
			</li>
			<li class="li05" >
				<button type="button" class="btn09" onclick="search()">검색</button>
			</li>
		</ul><!-- btnWrap end -->
	</div><!-- mbverWrap end -->
</section><!-- section content01 end -->