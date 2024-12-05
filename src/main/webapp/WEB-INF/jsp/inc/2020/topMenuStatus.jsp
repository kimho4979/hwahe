<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
var firstSearch1=true;

$(document).ready(function(){
	$('#itemCd').select2().on('select2:open', function(){
		setTimeout(function() {
			$('.select2-search__field').blur();
		  }, 0);		
	});
	
	// 공유설정	
	if('${param.flowerCd}'!=''){
		$.cookie("cookie.flowerCd", '${param.flowerCd}', { expires: 7, path: '/' });
		$.cookie("cookie.pumCd", '${param.itemCd}',{ expires: 7, path: '/' });
	}
	
	
	// WEB 부류선택 선택
	$(".flowerTab li a").click(function(){
		
		flowerCd = $("#flowerTab .on > input").attr("value");
		
		$("#mobFlowerCdLab").text($("#flowerTab .on > a > img").attr('alt'));
		$("#mobFlowerCd").val(flowerCd);
		
		if(flowerCd == '1' || flowerCd == '2' || flowerCd == '3' || flowerCd == '4' ){
			$("#searchProductGubun").val(flowerCd);
		}else{
			$("#searchProductGubun").val("");
		}
		
		datepickerCreate(flowerCd);
		getSaledate(flowerCd);
		return false;
	});
	
	
	// MOB 부류선택 선택
	$("#mobFlowerCd").change(function(){
		flowerCd = $("#mobFlowerCd option:selected").val();
		
		if(flowerCd == '1' || flowerCd == '2' || flowerCd == '3' || flowerCd == '4' ){
			$("#searchProductGubun").val(flowerCd);
		}else{
			$("#searchProductGubun").val("");
		}
				
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
		
	}else if($.cookie("cookie.cmpCd")!=undefined&&$.cookie("cookie.cmpCd")!=''){// 쿠키설정 로드
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
	
	flowerCd = $("#mobFlowerCd option:selected").val();
	getSaledate(flowerCd);
	
});

function setMenuInit(flowerIdx){
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
function getSalePumList(flowerCd, searchDate){ 
	//조회조건 품목-품종 명칭 변경
	if(flowerCd == "1"){
		$("#pum_nm").text("품목");
	}else{
		$("#pum_nm").text("품종");
	}		
		
	$.ajax({
		type : 'get',
		url : "/hab08/hab08Button.json",
		data : '&searchProductGubun='+flowerCd+'&searchDate='+searchDate,
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
							if(pumCd==res.list[i].pumName){
								$("#itemCd").append("<option value='"+res.list[i].pumCode+"' selected>"+res.list[i].pumName+"</option>");	
							}else{
								$("#itemCd").append("<option value='"+res.list[i].pumCode+"'>"+res.list[i].pumName+"</option>");
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
							}
						}
						
					}else if(firstSearch1&& '${sessionScope.searchList}'!=null&&'${sessionScope.searchList}'!=''&&'${sessionScope.searchList.pumCd}'!=''){
						// 사용자 맞춤설정(세션값 선택)
						pumCd = '${sessionScope.searchList.pumCd}';
						for(var i=0;i<res.list.length;i++){
							if(pumCd==res.list[i].pumName){
								$("#itemCd").append("<option value='"+res.list[i].pumCode+"' selected>"+res.list[i].pumName+"</option>");	
							}else{
								$("#itemCd").append("<option value='"+res.list[i].pumCode+"'>"+res.list[i].pumName+"</option>");
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
						}					
						
					}else{
						for(var i=0;i<res.list.length;i++){
							$("#itemCd").append("<option value='"+res.list[i].pumCode+"'>"+res.list[i].pumName+"</option>");
						}
						search();
					}
					
				}else{
					for(var i=0;i<res.list.length;i++){
						$("#itemCd").append("<option value='"+res.list[i].pumCode+"'>"+res.list[i].pumName+"</option>");
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

function addThousandSeparatorCommas(num) {
    return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
}
</script>

		<!--서브공통 (S)-->
		<div class="sub_contents">
			<!--서브 TAB공통 (S)-->
			<div class="sub_tab_yangjae">
				<div class="yangjae_list">
					<ul class="sub_fw_btn_03 flowerTab btNo ptNo" id="flowerTab">
						<li class="step_11 on">
							<input type="hidden" value="1"/>
							<a href="#!" >								
								<img src="../images/2020/sub/step_11_on.png" alt="절화"><!--절화-->
							</a>
						</li>
						<li class="step_12">
							<input type="hidden" value="3"/>
							<a href="#!" >
								<img src="../images/2020/sub/step_12_off.png" alt="난"><!--난-->
							</a>
						</li>
						<li class="step_13">
							<input type="hidden" value="2"/>
							<a href="#!" >
								<img src="../images/2020/sub/step_13_off.png" alt="관엽"><!--관엽-->
							</a>
						</li>
					</ul>
				</div>
				<div class="search_box" id="searchbox">
					<div class="search_01">
						<ul class="search_box01">
							<li style="display:none;">
								<p class="search_01_txt">부류선택</p>
								<select id="mobFlowerCd" name="mobFlowerCd">
									<option value="1" selected="selected">절화</option>
									<option value="3">난</option>
									<option value="2">관엽</option>
								</select>
							</li>
							
							<li class="calendar" id="liStrDate">
								<p class="search_01_txt">일자선택</p>
								<input type="text" class="datepicker" name="searchSaleDate" id="searchSaleDate" value="${searchSaleDate}" readonly/>
							</li>
							<li id="pumSelectbox">
								<p class="search_01_txt" id="pum_nm">품목</p>
								<select id="itemCd" name="itemCd" class="form-control">
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