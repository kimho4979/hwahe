<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
var firstSearch1=true;

$(document).ready(function(){
	// 검색 selectbox
	//$('#itemCd').select2();
	$('#itemCd').select2().on('select2:open', function(){
		setTimeout(function() {
			$('.select2-search__field').blur();
		  }, 0);		
	});
	
	// 검색 selectbox
	//$('#itemCd2').select2();	
	
	
	// WEB 부류선택 선택
	$(".flowerTab li a").click(function(){
		
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
		str = str.substring(5,7);

		$(this).children().attr({"src":"../images/2020/sub/step_"+str+"_off.png"});
		$(this).parent().removeClass("on");		
		
		if(flowerIdx==index){
			$(this).children().attr({"src": "../images/2020/sub/step_"+str+"_on.png"});
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

		<!--서브공통 (S)-->
		<div class="sub_contents">
			<!--서브 TAB공통 (S)-->
			<div class="sub_tab_yangjae">
				<div class="yangjae_list">
					<ul class="sub_fw_btn_02 flowerTab btNo ptNo" id="flowerTab">
						<li class="step_21 on">
							<input type="hidden" value="1"/>
							<a href="#!" >								
								절화<!--절화-->
							</a>
						</li>
						<li class="step_22">
							<input type="hidden" value="3"/>
							<a href="#!" >
								난<!--난-->
							</a>
						</li>
						<!-- <li class="step_03">
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
						</li> -->
					</ul>
				</div>
				<div class="search_box">
					<div class="search_01">
						<ul class="search_box01">
							<li style="display:none;">
								<p class="search_01_txt">부류선택</p>
								<select id="mobFlowerCd" name="mobFlowerCd">
									<option value="1" selected="selected">절화</option>
									<option value="3">난</option>
									<!-- <option value="2">관엽</option>
									<option value="4">춘란</option> -->
								</select>
							</li>
							<li class="calendar">
								<p class="search_01_txt">시작일자</p>
								<input type="text" class="datepicker" name="searchStrDate" id="searchStrDate" readonly/>
							</li>
							<li class="calendar">
								<p class="search_01_txt">종료일자</p>
								<input type="text" class="datepicker" name="searchEndDate" id="searchEndDate" readonly/>
							</li>
							<li>
								<p class="search_01_txt">품목</p>
								<select id="itemCd" name="itemCd" class="form-control">
								</select>
							</li>
							<li class="search_btn">
								<a href="javascript:search()"><img src="../images/2020/sub/search_img.png" alt="돋보기"></a>
							</li>
						</ul>
					</div>
				</div>
			</div>
			<!--서브 TAB공통 (E)-->
		</div>