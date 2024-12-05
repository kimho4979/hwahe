<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
$(document).ready(function(){

	// 검색 selectbox
	$('#pumCd').select2().on('select2:open', function(){
		setTimeout(function() {
			$('.select2-search__field').blur();
		  }, 0);		
	});
	// 검색 selectbox
	$('#lvCd').select2().on('select2:open', function(){
		setTimeout(function() {
			$('.select2-search__field').blur();
		  }, 0);		
	});
	
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

		<!--서브공통 (S)-->
		<div class="sub_contents">
			<!--서브 리스트 (S)-->
			<div class="sub_content">
				<ul class="sub_tab_04 ct_gnb" id="cmpCdTab">
					<li class="on s_on"><input type="hidden" value="0000000001"/><a href="#">aT화훼공판장 <br/> <span>(양재동)</span></a></li>
					<li><input type="hidden" value="1508500020"/><a href="#">부산화훼공판장 <br/> <span>(엄궁동)</span></a></li>
					<li><input type="hidden" value="6068207466"/><a href="#">부산경남화훼농협 <br/> <span>(강동동)</span></a></li>
					<li><input type="hidden" value="4108212335"/><a href="#">광주원예농협 <br/> <span>(풍암)</span></a></li>
				</ul>
			</div>
			<!--서브 리스트 (E)-->
			<!--서브 TAB공통 (S)-->
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
							</select>
						</li>
						<li class="calendar" id="baseDateLi">
							<p class="search_01_txt">예측실시일</p>
							<input type="text" class="datepicker" name="baseDate" id="baseDate"  readonly/>
						</li>
						<li>
							<p class="search_01_txt">품종</p>
							<select id="pumCd" name="pumCd" class="form-control">
							</select>
						</li>
						<li>
							<p class="search_01_txt">등급</p>
							<select id="lvCd" name="lvCd" class="form-control">
							</select>
						</li>
						<li class="search_btn">
							<a href="javascript:search()"><img src="../images/2020/sub/search_img.png" alt="돋보기">검색</a>
						</li>
					</ul>
				</div>
			</div>
			
			<!--서브 TAB공통 (E)-->
		</div>