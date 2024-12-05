<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
	var firstSearch1=true;
	
	$(document).ready(function(){
		
		// 검색 selectbox
		$('#itemCd').select2();
		// 검색 selectbox
		$('#itemCd2').select2();

		// WEB 부류선택 선택
		$(".flowerTab li a").click(function(){

			getIntItemList();
			
			if (chkKind) {
				getIntKindList();
			}

			return false;
		});
		
		// 공판장 선택
		$("#mobCmpCd").change(function(){
			
			getIntItemList();
			
			if (chkKind) {
				getIntKindList();
			}
			
			return false;
		});
		
		// 품목 선택
		$("#itemCd").change(function(){
			
			search();
			
			if (chkKind) {
				getIntKindList();
			}
			
			return false;
		});
		
		// 품종 선택
		$("#itemCd2").change(function(){

			search();
			return false;
		});
	});
	
	//품목 검색 (일자별)
	function getIntItemList() {
		var searchStrDate = $("#searchStrDate").val();
		var searchEndDate = $("#searchEndDate").val();
		var itemCd = $("#itemCd option:selected").val();
		var cmpCd = $("#mobCmpCd option:selected").attr("value");
		var flowerCd = $("#flowerTab .on > input").attr("value");
		
 		if (chkMonth){
			searchStrDate += '-01';
			searchEndDate += '-31';
		}
 
		$("#itemCd").html("");
		$("#itemCd").append("<option value='' selected> 전체 </option>");
		
		$.ajax({
				type:'post'
			,	url : "/intCode/selectIntItemList.json"
			,	data : {
					cmpCd : cmpCd
				,	flowerCd : flowerCd
				,	searchStrDate : searchStrDate
				,	searchEndDate : searchEndDate
				}
			,	dataType : ''
			,	success : function(res){
					if(res.list.length>0){
						for(var i=0;i<res.list.length;i++){
							var chkSelect = '';
							if(itemCd == res.list[i].flowerCode + res.list[i].itemCd){chkSelect = 'selected';};
							$("#itemCd").append("<option value='"+ res.list[i].flowerCode + res.list[i].itemCd +"'"+ chkSelect +">"+res.list[i].itemNm+"</option>");
						}
					}
					search();
				}
		});
	}
	
	//품종 검색 (일자별)
	function getIntKindList() {
		var searchStrDate = $("#searchStrDate").val();
		var searchEndDate = $("#searchEndDate").val();
		var itemCd = $("#itemCd option:selected").val();
		var itemCd2 = $("#itemCd2 option:selected").val();
		var cmpCd = $("#mobCmpCd option:selected").attr("value");
		var flowerCd = $("#flowerTab .on > input").attr("value");

		$("#itemCd2").html("");
		$("#itemCd2").append("<option value='' selected> 전체 </option>");

		
		if (itemCd == null){return;}

		if (chkMonth){
			searchStrDate += '-01';
			searchEndDate += '-31';
		}
		
		$.ajax({
				type:'post'
			,	url : "/intCode/selectIntKindList.json"
			,	data : {
					cmpCd : cmpCd
				,	flowerCd : flowerCd
				,	searchStrDate : searchStrDate
				,	searchEndDate : searchEndDate
				,	itemCd : itemCd
				}
			,	dataType : ''
			,	success : function(res){
					if(res.list.length>0){
						for(var i=0;i<res.list.length;i++){
							var chkSelect = '';
							if(itemCd2 == res.list[i].flowerCd + res.list[i].flowerCode + res.list[i].itemCd + res.list[i].kindCd){chkSelect = 'selected';};
							$("#itemCd2").append("<option value='"+ res.list[i].flowerCd + res.list[i].flowerCode + res.list[i].itemCd + res.list[i].kindCd +"'"+ chkSelect +">"+res.list[i].kindNm+"</option>");
						}
					}
					search();
				}
		});
	}
	
	function init(){
		var searchStrDate = $("#searchStrDate").val();
		var searchEndDate = $("#searchEndDate").val();
		var itemCd = $("#itemCd option:selected").val();
		var itemCd2 = $("#itemCd2 option:selected").val();
		var cmpCd = $("#mobCmpCd option:selected").attr("value");
		var flowerCd = $("#flowerTab .on > input").attr("value");

		console.log("init.searchStrDate ==" + searchStrDate);
		console.log("init.searchEndDate ==" + searchEndDate);
		console.log("init.itemCd ==" + itemCd);
		console.log("init.itemCd2 ==" + itemCd2);
		console.log("init.cmpCd ==" + cmpCd);
		console.log("init.flowerCd ==" + flowerCd);

		
		getIntItemList();
		
		$('#pumNameTxt').text('품종별 종합 경매정보');
		$('#lvNameTxt').text('등급정보');
		
		// grid 초기화
		$("#jqGrid").jqGrid("clearGridData", true);
	}

</script>

		<!--서브공통 (S)-->
		<div class="sub_contents">
			<!--서브 TAB공통 (S)-->
			<div class="sub_tab_yangjae">
				<div class="yangjae_list">
					<ul class="sub_fw_btn btn_03 flowerTab btNo ptNo" id="flowerTab">
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
									<option value="2">관엽</option>
								</select>
							</li>
							<li class="calendar" id="liStrDate">
								<p class="search_01_txt">시작일자</p>
								<input type="text" class="datepicker except" name="searchStrDate" id="searchStrDate" value="${param.searchStrDate}" />
							</li>
							<li class="calendar">
								<p class="search_01_txt">종료일자</p>
								<input type="text" class="datepicker except" name="searchEndDate" id="searchEndDate" value="${param.searchEndDate}" />
							</li>
							<li id="pumSelectbox">
								<p class="search_01_txt">품목</p>
								<select id="itemCd" name="itemCd" class="form-control except">
								</select>
							</li>
							<li id="goodSelectbox" style="display: none;">
								<p class="search_01_txt">품종</p>
								<select id="itemCd2" name="itemCd2" class="form-control except">
									<option value='' selected> 전체 </option>
								</select>
							</li>
							<li style="display: ;">
								<p class="search_01_txt">공판장선택</p>
								<select id="mobCmpCd" name="mobCmpCd" class="form-control except">
									<option value="" selected="selected">전체</option>
									<option value="0000000001">aT화훼공판장(양재동)</option>
									<option value="1508500020">부산화훼공판장(엄궁동)</option>
									<option value="6068207466">부산경남화훼농협(강동동)</option>
									<option value="4108212335">광주원예농협(풍암)</option>
									<option value="3848200087">한국화훼농협(음성)</option>
									<option value="1288202296">한국화훼농협(과천)</option>
									<option value="6158209828">영남화훼농협(김해)</option>
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