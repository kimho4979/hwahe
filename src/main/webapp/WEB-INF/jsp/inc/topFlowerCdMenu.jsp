<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
$(document).ready(function(){
	
	// WEB 부류선택 선택
	$(".flowerTab li a").click(function(){
		//flowerCd = $(this).parent().attr("value");
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
		if(cmpCd == '0000000001' || cmpCd == '1508500020' || cmpCd == '6068207466' || cmpCd == '4108212335' || cmpCd == '3848200087' || cmpCd == '1288202296'){
			$("#searchCmpCd").val(cmpCd);
		}else {
			$("#searchCmpCd").val("");
		}
		cmpCd = $("#mobCmpCd option:selected").val();
		flowerCd = $("#mobFlowerCd option:selected").val();
		getSaledate(cmpCd, flowerCd);
		return false;
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
		
		if(cmpCd == '0000000001' || cmpCd == '1508500020' || cmpCd == '6068207466' || cmpCd == '4108212335' || cmpCd == '3848200087' || cmpCd == '1288202296'){
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
		flowerCd = '${sessionScope.searchList.flowerCd}';
		
		if(flowerCd == '1' || flowerCd == '2' || flowerCd == '3' || flowerCd == '4' ){
			$("#searchProductGubun").val(flowerCd);
			$("#mobFlowerCd").val(flowerCd);
		}else{
			$("#searchProductGubun").val("1");
			$("#mobFlowerCd").val("1");
		}
		
		var flowerIdx=$("#mobFlowerCd option").index($("#mobFlowerCd option:selected"));
		
		setMenuInit(flowerIdx);
	}else if($.cookie("cookie.flowerCd")!=undefined&&$.cookie("cookie.flowerCd")!=''){// 쿠키설정 로드
		flowerCd = $.cookie("cookie.flowerCd");
		
		if(flowerCd == '1' || flowerCd == '2' || flowerCd == '3' || flowerCd == '4' ){
			$("#searchProductGubun").val(flowerCd);
			$("#mobFlowerCd").val(flowerCd);
		}else{
			$("#searchProductGubun").val("1");
			$("#mobFlowerCd").val("1");
		}
		
		var flowerIdx=$("#mobFlowerCd option").index($("#mobFlowerCd option:selected"));
		
		setMenuInit(flowerIdx);
	}
	
	getSaledate();
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

function addThousandSeparatorCommas(num) {
    return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
}
</script>
<div class="pcverWrap">
	<ul class="flowerTab btNo ptNo" id="flowerTab">
		<li class="li01 on"><input type="hidden" value="1"/><a href="#"><img src="../images/content/flowerTab01_on.png" alt="절화" /></a></li>
		<li class="li02"><input type="hidden" value="3"/><a href="#"><img src="../images/content/flowerTab02_off.png" alt="난" /></a></li>
		<li class="li03"><input type="hidden" value="2"/><a href="#"><img src="../images/content/flowerTab03_off.png" alt="관엽" /></a></li>
		<li class="li04 mrNo"><input type="hidden" value="4"/><a href="#"><img src="../images/content/flowerTab04_off.png" alt="춘란" /></a></li>
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
					<option value="2">관엽</option>
					<option value="4">춘란</option>
				</select>
			</li>
		</ul>
	</div><!-- mbverWrap end -->
</section><!-- section content01 end -->