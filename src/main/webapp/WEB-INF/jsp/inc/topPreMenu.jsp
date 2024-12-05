<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
$(document).ready(function(){

	// 검색 selectbox
	$('#pumCd').select2();
	// 검색 selectbox
	$('#lvCd').select2();
	
	// WEB 공판장 선택
	$("#cmpCdTab > li > a").click(function(){
	
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
		if(cmpCd == '0000000001' || cmpCd == '1508500020' || cmpCd == '6068207466' || cmpCd == '4108212335' || cmpCd == '3848200087' || cmpCd == '1288202296'){
			$("#searchCmpCd").val(cmpCd);
		}else {
			$("#searchCmpCd").val("");
		}
		getSaledate(cmpCd);
		
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
		
		if(cmpCd == '0000000001' || cmpCd == '1508500020' || cmpCd == '6068207466' || cmpCd == '4108212335' || cmpCd == '3848200087' || cmpCd == '1288202296'){
			$("#searchCmpCd").val(cmpCd);
		}else {
			$("#searchCmpCd").val("");
		}		
		
		var cmpIdx=$("#mobCmpCd option").index($("#mobCmpCd option:selected"));
		var flowerIdx=$("#mobFlowerCd option").index($("#mobFlowerCd option:selected"));
		
		$("#cmpCdTab  .li0"+(cmpIdx+1)+" > a").click();
	});
	
	cmpCd = $("#mobCmpCd option:selected").val();
	getSaledate(cmpCd);
	
});

//품목검색(정산테이블-일자별)
function getSalePumList(cmpCd, flowerCd, saleDate){ 
	$.ajax({
		type : 'get',
		url : "/search/selectPumNameDate.json",
		data : '&searchProductGubun='+flowerCd+'&searchSaleDate='+saleDate+'&searchCmpCd='+cmpCd,
		dataType : '',
		success : function(res) {			
			if(res.list.length>0){
				$("#itemCd").html("");
				$("#itemCd").append("<option value='' selected>전체</option>");
				for(var i=0;i<res.list.length;i++){
					$("#itemCd").append("<option value='"+res.list[i].PUM_NAME+"'>"+res.list[i].PUM_NAME+"</option>");
				}
			}else{
				alert('해당일자에 데이터가 없습니다.')
			}
			search();
		},
	});
}

//품목검색(정산테이블-월별)
// selectCnt 선택할 itemCnt 값
function getSaleMonthPumList(cmpCd, flowerCd, saleDate, selectCnt){ 
	$.ajax({
		type : 'get',
		url : "/search/selectPumNameMonth.json",
		data : '&searchProductGubun='+flowerCd+'&searchSaleDate='+saleDate+'&searchCmpCd='+cmpCd,
		dataType : '',
		success : function(res) {
			if(res.list.length>0){
				$("#itemCd").html("");
				$("#itemCd").append("<option value=''>전체</option>");
				for(var i=0;i<res.list.length;i++){
					$("#itemCd").append("<option value='"+res.list[i].PUM_NAME+"'>"+res.list[i].PUM_NAME+"</option>");
				}
				$("#itemCd option:eq("+selectCnt+")").attr("selected", "selected");
			}else{
				alert('해당일자에 데이터가 없습니다.')
			}
			search();
		},
	});
}

//품목검색(실시간테이블)
function getRealPumList(cmpCd, flowerCd, saleDate){ 
	$.ajax({
		type : 'get',
		url : "/search/selectPumNameReal.json",
		data : '&searchProductGubun='+flowerCd+'&searchSaleDate='+saleDate+'&searchCmpCd='+cmpCd,
		dataType : '',
		success : function(res) {
			if(res.list.length>0){
				$("#itemCd").html("");
				$("#itemCd").append("<option value='' selected>전체</option>");
				for(var i=0;i<res.list.length;i++){
					$("#itemCd").append("<option value='"+res.list[i].PUM_NAME+"'>"+res.list[i].PUM_NAME+"</option>");
				}
			}else{
				alert('해당일자에 데이터가 없습니다.')
			}
			search();
		},
	});
}

function getItemInit(){ 
	$("#itemCd").html("");
	$("#itemCd").append("<option value='' selected>전체</option>");
}


function addThousandSeparatorCommas(num) {
    return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
}
</script>
<div class="pcverWrap">
	<ul class="ct_gnb tab4" id="cmpCdTab">
		<li class="li01 on"><input type="hidden" value="0000000001"/><a href="#">aT화훼공판장(양재동)</a></li>
		<li class="li02"><input type="hidden" value="1508500020"/><a href="#">부산화훼공판장(엄궁동)</a></li>
		<li class="li03"><input type="hidden" value="6068207466"/><a href="#">부산경남화훼농협(강동동)</a></li>
		<li class="li04"><input type="hidden" value="4108212335"/><a href="#">광주원예농협(풍암)</a></li>
	</ul><!-- ct_gnb end -->
</div><!-- pcverWrap end -->					
<section class="section content01">
	<div class="mbverWrap mb_ctHead">
		<ul class="selectWrap">
			<li class="mr5">공판장선택</li>
			<li class="selectbox width180" style="">
				<label for="mobCmpCd" id="mobCmpCdLab">aT화훼공판장(양재동)</label>
				<select id="mobCmpCd" name="mobCmpCd">
					<option value="0000000001" selected="selected">aT화훼공판장(양재동)</option>
					<option value="1508500020">부산화훼공판장(엄궁동)</option>
					<option value="6068207466">부산경남화훼농협(강동동)</option>
					<option value="4108212335">광주원예농협(풍암)</option>
				</select>
			</li>
		</ul>
		<ul class="btnWrap" id="subSearchMenu">
			<li class="li01" id="baseDateLi">
				<label for="baseDate">예측실시일</label>
				<input type="text" class="calender" name="baseDate" id="baseDate" />
			</li><!-- li01 end -->
			<li class="li02">
				<label for="pumCd">품종선택</label>
				<select id="pumCd" name="pumCd" style="width: 150px;"></select>
			</li><!-- li01 end -->
			<li class="li03 mbNo">
				<label for="lvCd">등급선택</label>
				<select id="lvCd" name="lvCd" style="width: 150px;">
				</select>
			</li>
			<li class="li04" >
				<button type="button" class="btn09" onclick="search()">검색</button>
			</li>
		</ul><!-- btnWrap end -->
	</div><!-- mbverWrap end -->
</section><!-- section content01 end -->