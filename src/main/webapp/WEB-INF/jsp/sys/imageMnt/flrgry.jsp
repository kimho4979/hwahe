<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

	<!DOCTYPE html>
	<html lang="ko">

	<head>
		<meta charset="utf-8" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<meta name="viewport"
			content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, user-scalable=no" />
		<meta name="apple-mobile-web-app-title" content="화훼유통정보시스템" />
		<meta name="robots" content="no-index,follow" />
		<meta name="og:title" content="화훼유통정보시스템" />
		<meta name="og:description" content="화훼유통정보시스템" />
		<meta name="description" content="가격문자알림서비스">
		<meta name="content" content="화훼유통정보시스템 입니다." />
		<meta name="keywords" content="화훼경매시세, 화훼경매가격, Korea aT flower market auction price, 화훼공판장, 화훼거래정보, 꽃시장, 꽃값">
		<meta name="Author" content="화훼유통정보시스템 & www.woorim.co.kr" />
		<title>Flower Gallery</title>
		<%@include file="../../common/2020/commonJs.jsp" %>
			<%@include file="../../common/2020/commonCss.jsp" %>

				<%-- <link rel="stylesheet" href="<%=request.getContextPath()%>/admin/css/bootstrap.css"> --%>
					<%-- <link rel="stylesheet" href="<%=request.getContextPath()%>/admin/css/bootstrap-theme.css"> --%>
						<%-- <script type="text/javascript"
							src="<%=request.getContextPath()%>/admin/js/bootstrap.min.js"></script> --%>
							<%-- <script type="text/javascript"
								src="<%=request.getContextPath()%>/admin/js/watermark.js"></script> --%>

								<style>
									#loading-indicator-back {
										background: rgba(0, 0, 0, .5);
										display: none;
										position: fixed;
										z-index: 999;
										height: 100%;
										width: 100%;
										left: 0;
										top: 0;
									}

									#searchBtn {
										margin-right: 30px;
										width: 64px;
										text-align: center;
										height: 45px;
										background: #4d6bed;
										border-radius: 4px;
									}

									#loading-indicator {
										background: url('/images/loadingBar.gif') no-repeat;
										display: none;
										position: fixed;
										z-index: 999;
										height: 100%;
										width: 100%;
										left: 50%;
										top: 50%;
									}

									.row {
										display: flex;
										flex-wrap: wrap;
										width: 1300px;
										margin: 0 auto;
									}

									/* Create four equal columns that sits next to each other */
									.column {
										flex: 13%;
										padding: 0.1%;
										width: 100%;
										height: 180px;
									}

									.column img {
										margin-top: 0;
										height: 180px;
										vertical-align: middle;
										width: 100%;
									}

									.f-select {
										/* border-radius:0px !important;
		position: absolute;
  		left: 420px;
  		top: 506px;
  		height: 40px !important; */
										width: 100%;
									}

									.f-text {
										/* position: absolute;
	  	top: 506px;
	  	right: 393px;
	  	width: 40%; */
										border-radius: 4px !important;
										width: 100%;
										height: 45px !important;
									}

									.contextMenuBody {
										color: #A9A9A9 !important;
									}

									.overlay {
										position: relative;
										bottom: 33px;
										background: rgb(0, 0, 0);
										background: rgba(0, 0, 0, 0.5);
										/* Black see-through */
										color: #f1f1f1;
										width: 100%;
										transition: .5s ease;
										opacity: 0;
										color: white;
										font-size: 13px;
										padding-bottom: 10px;
										padding-top: 10px;
										text-align: center;
									}

									.overlay i {
										color: #e4e7ec;
										padding-right: 10px;
										cursor: pointer;
										float: right;
									}

									.overlay2 {
										position: absolute;
										top: 15px;
										background: rgb(0, 0, 0);
										background: rgba(0, 0, 0, 0.5);
										/* Black see-through */
										color: #f1f1f1;
										width: 100%;
										transition: .5s ease;
										opacity: 0;
										color: white;
										font-size: 14px;
										padding-bottom: 10px;
										padding-top: 10px;
										text-align: right;
										padding-right: 4px;
									}

									.column:hover .overlay {
										opacity: 1;
									}

									.column:hover .overlay2 {
										opacity: 1;
									}

									/* 팝업css추가2023-11-15 */
									.dim-layer .pop-layer {
										width: 50%;
									}

									.table_type_02 tbody tr td {
										height: 70px;
									}

									#mainImageContainer {
										position: relative;
										background: url(/images/main/main_bg.jpg);
										background-size: cover;
										height: 300px;
										display: grid;
										justify-items: center;
									}

									#mainImageContainer table {
										width: 36%;
									}

									/* Responsive layout - makes a two column-layout instead of four columns */
									@media screen and (max-width: 800px) {
										.dim-layer .pop-layer {
											width: 100%;
										}

										.table_type_02.pop tbody tr td {
											height: 22px;
										}

										#mainImageContainer table {
											width: 80%;
										}

										.column {
											flex: 50%;
											max-width: 50%;
										}

										.column {
											flex: 13%;
											padding: 0.1%;
											width: 100%;
											height: auto;
										}

										.row {
											width: 100%;
										}

										.column img {
											margin-top: 0;
											height: auto;
											vertical-align: middle;
											width: 100%;
										}

										.overlay {
											bottom: 39px;
											width: 100%;
											font-size: 20px;
										}
									}

									/* Responsive layout - makes the two columns stack on top of each other instead of next to each other */
									@media screen and (max-width: 600px) {
										.column {
											flex: 100%;
											max-width: 100%;
										}
									}
								</style>


								<script type="text/javascript">
									var showImageCnt = 21;
									function searchBtnFn() {
										let ov = $('.f-select option:selected').val();
										let tv = $.trim($("#searchJongNm").val());
										obj = {};
										obj.type = ov;
										obj.value = tv;
										reqSearch(obj)
									}

									var moks = [];
									var jongs = [];
									var colors = [];
									function reqSearch(obj) {
										moks = [];
										jongs = [];
										colors = [];
										$
											.ajax({
												type: 'post',
												url: "/hfd01/getImages.json",
												data: JSON.stringify(obj),
												dataType: 'json',
												success: function (res) {
													$('#imageGridArea').empty();

													let output = '';
													let imagePath = '';

													output += '<div class="row">';
													let arr = [];
													$
														.each(
															res.data,
															function (i, v) {
																jongs.push(v.P_JONG_NAME);
																moks.push(v.P_MOK_NAME);
																colors.push(v.COLOR_NAME);
																imagePath = "/admin/img/loc/"
																	+ v.FILE_ID;

																output += '<div class="column" style="position: relative;">';
																output += '<img src="' + imagePath + '"   id="tooltip' + i + '"  origin="' + v.ORIGIN_NAME + '"  >';
																output += '<div class="overlay"  data-color-name="' + v.COLOR_NAME + '" data-rgb="' + v.RGB_CODE + '"  >'
																	+ v.P_MOK_NAME
																	+ ' / '
																	+ v.P_JONG_NAME
																	+ '<i class="fa-light fa-circle-down" style="color: #e4e7ec;"></i></div>'
																output += '</div>';

															})

													
													for(let i=0;i<7;i++){
														output += '<div class="column"></div>';	
													}

													output += '</div>';
													output += '<div id="searchBtn"  style="cursor:pointer;position: fixed;right: 5%;top: 80%;background:none !important; "  onclick="moreBtn();"  > <img  style="width:70px;height:60px"  src="../images/content/icon_more.png">  </div>';
													$('#imageGridArea').html(output);
													
													$.each($('.column'),function(i,v){
														if((i+1) > showImageCnt){
															
															$(this).hide()
														} else {
															$(this).show()
														}
													})

													$('#searchJongNm').autocomplete(
														{
															source: Array.from(new Set(moks.concat(
																jongs).concat(colors))),
															select: function (event, ui) {
																$(this).val(ui.item.label);
																$(this).attr('val', ui.item.value);
																return false;
															},
															focus: function (event, ui) {
																return false;
															}
														});

													/////$(".tooltipbind").bindTooltip(); 
													$('div.column > img').on(
														'click',
														function (e) {
															console.log($(e.target).siblings().text())
															$('#popMok').text(
																$(e.target).siblings().text()
																	.split('/')[0])
															$('#popJong').text(
																$(e.target).siblings().text()
																	.split('/')[1])
															$('#popColor').text(
																$(e.target).siblings().attr(
																	'data-color-name'))
															$('#popRgb').parent().css(
																'background-color',
																$(e.target).siblings().attr(
																	'data-rgb'))
															$('#popImage').parent().css(
																{
																	"background": "url("
																		+ $(e.target).attr(
																			'src')
																		+ ") round"
																});

															fnLayerPopup('#utda_input');
														})
													$('.fa-circle-down')
														.on(
															'click',
															function (e) {
																if (confirm("해당 이미지를 다운로드 하시겠습니까?")) {
																	//$('.fa-circle-down:eq(1)').parent().siblings(':eq(0)')
																	let img = $(e.target).parent()
																		.siblings(':eq(0)')[0].src;
																	let origin = img.split('/')[6]
																		.split('.')[0]
																		+ '.'
																		+ $(e.target)
																			.parent()
																			.siblings(
																				':eq(0)')[0]
																			.getAttribute(
																				'origin')
																			.split('.')[1];
																	$
																		.ajax({
																			contentType: "application/x-www-form-urlencoded;charset=UTF-8",
																			xhr: function () {
																				let xhr = new XMLHttpRequest();
																				xhr.onreadystatechange = function () {
																					//response 데이터를 바이너리로 처리한다. 세팅하지 않으면 default가 text 
																					xhr.responseType = "blob";
																				};
																				return xhr;
																			},
																			url: "download.do",
																			data: {
																				path: img,
																				origin: origin
																			},
																			type: 'post',
																			success: function (
																				data,
																				message,
																				xhr) {

																				if (xhr.readyState == 4
																					&& xhr.status == 200) {
																					// 성공했을때만 파일 다운로드 처리하고
																					let disposition = xhr
																						.getResponseHeader('Content-Disposition');
																					let filename;
																					if (disposition
																						&& disposition
																							.indexOf('attachment') !== -1) {
																						let filenameRegex = /filename[^;=\n]*=((['"]).*?\2|[^;\n]*)/;
																						let matches = filenameRegex
																							.exec(disposition);
																						if (matches != null
																							&& matches[1])
																							filename = matches[1]
																								.replace(
																									/['"]/g,
																									'');
																					}
																					let blob = new Blob(
																						[data]);
																					let link = document
																						.createElement('a');
																					link.href = window.URL
																						.createObjectURL(blob);
																					link.download = filename;
																					link
																						.click();
																				} else {
																					//실패했을때는 alert 메시지 출력
																					alertPopup("다운로드에 실패하였습니다.");
																				}
																			}
																		})
																}

															})

												},
												beforeSend: function () {
													$('#loading-indicator').show();
													$('#loading-indicator-back').show();
												},
												complete: function () {
													$('#loading-indicator').hide();
													$('#loading-indicator-back').hide();
												}
											});
									}
									let cnt = 1;
									function moreBtn() {
										cnt = cnt + 1;
										let limit = (cnt * showImageCnt);
										let before = $('.column').length - 7
										
										console.log(cnt, limit, before)
										
										$.each($('.column'),function(i,v){
											if((i+1) > limit){
												$(this).hide()
											} else {
												$(this).show()
											}
										})
									}

									$(document).ready(function () {

										let obj = {};
										reqSearch(obj)
										$('.f-select').on('change', function (e) {
											console.log($(e.target).val());
											console.log(moks);
											console.log(jongs);
											var searchParam = [];
											if ($(e.target).val() == 'mok') {
												searchParam = moks
											} else if ($(e.target).val() == 'jong') {
												searchParam = jongs
											} else if ($(e.target).val() == 'color') {
												searchParam = colors;
											} else {
												searchParam = moks.concat(jongs).concat(colors);
											}
											let noDup = new Set(searchParam);
											$('#searchJongNm').autocomplete({
												source: Array.from(noDup),
												select: function (event, ui) {
													$(this).val(ui.item.label);
													$(this).attr('val', ui.item.value);
													return false;
												},
												focus: function (event, ui) {
													return false;
												}
											});

										})
										$(".f-text").on("keyup", function (key) {
											if (key.keyCode == 13) {
												let ov = $('.f-select option:selected').val();
												let tv = $.trim($(this).val());
												obj.type = ov;
												obj.value = tv;
												console.log(obj)
												reqSearch(obj)
											}
										});
									})
								</script>



	</head>

	<body>
		<!--WRAP(S)-->
		<div class="wrap">

			<jsp:include page="../../inc/2020/IncHeader.jsp" />

			<!--콘텐츠_메인(S)-->
			<div class="conts_main">
				<div class="conts_main_in" style="max-width: 3000px !important;">

					<!-- 로그인 타이틀(S) -->
					<div class="log_title_box">
						<h2 class="log_tit">Flower Gallery</h2>
						<!-- 	<p class="log_sant">aT 화훼유통정보시스템에 방문하신 것을 환영합니다. 아이디 및 비밀번호를 입력해 주세요.</p> -->
					</div>
					<!-- 로그인 타이틀(E) -->

					<!-- 로그인 박스(S) -->

					<div id="mainImageContainer">

						<table>
							<colgroup>
								<col width="30%">
								<col width="70%">

							</colgroup>
							<thead>
								<tr>

									<td><select id="" class="f-select">
											<option selected value="all">전체</option>
											<option value="mok">품목</option>
											<option value="jong">품종</option>
											<option value="color">색상</option>
										</select></td>
									<td><input type="text" class="f-text" id="searchJongNm" placeholder="입력하십시오...">
									</td>
									<td>
										<!--  <button class="search_btn" style="width:66px;height:43px;" onclick="searchBtnFn();">-->
										<div id="searchBtn">
											<a href="javascript:searchBtnFn()"
												style="display: block; color: #fff; font-size: 18px; line-height: 45px;">
												<img src="../images/2020/sub/search_img.png" alt="돋보기"
													style="vertical-align: sub;">

											</a>
										</div> <!--</button>-->
									</td>

								</tr>
							</thead>
						</table>

					</div>

					<!-- <div id="mainImageContainer" style="position: relative;">
					<img src="/images/main/main_bg.jpg" alt="이미지 없음"
						style="width: 100%; height: 100%;">

					<table style="position: absolute; bottom: 28%; width: 100%;">
						<colgroup>

							<col width="25%">
							<col width="10%">
							<col width="40%">
							<col width="25%">
						</colgroup>
						<thead>
							<tr>
								<td></td>
								<td><select id="" class="f-select">
										<option selected value="mok">품목</option>
										<option value="jong">품종</option>
								</select></td>
								<td><input type="text" class="f-text" id="searchJongNm"
									placeholder="입력하십시오..."></td>
								<td></td>
							</tr>
						</thead>
					</table>

				</div> -->










					<div id="imageGridArea" style="margin-top: 10px;"></div>

					<!-- 로그인 박스(E) -->
				</div>
			</div>
			<!--콘텐츠_메인(E)-->

			<jsp:include page="../../inc/2020/IncFooter.jsp" />

			<!-- 팝업 -->
			<div class="dim-layer" id="utda_input">
				<div class="dimBg"></div>
				<div class="pop-layer popbox" style="position: fixed !important;">
					<div class="pop-container">
						<div class="pop-conts_00">
							<!-- 팝업타이틀(S) -->
							<div class="pop_title_box">
								<h2 class="pop_title">상세정보</h2>
								<a href="#!" class="btn-layerClose close_B">Ⅹ</a>
							</div>
							<!-- 팝업타이틀(E) -->

							<!-- 팝업 콘텐츠(S) -->
							<div class="pop_conts">
								<!-- 테이블02(S) -->
								<table class="table_type_02 pop">
									<caption>noticePopTable</caption>
									<colgroup>
										<col style="width: 50%">
										<col style="width: 20%">
										<col style="width: 30%">

									</colgroup>

									<tbody>
									<tbody>
										<tr>
											<td rowspan="8" colspan="1">
												<div id="popImage"></div>
											</td>
											<th rowspan="">품목</th>
											<td rowspan="">
												<p id="popMok"></p>
											</td>

											<!-- <th>작성자</th>
												<td><p id="insId"></p></td> -->
										</tr>
										<tr>
											<th rowspan="">품종</th>
											<td rowspan="">
												<p id="popJong"></p>
											</td>
										</tr>
										<tr>
											<th rowspan="">계열</th>
											<td rowspan="">
												<p id="popColor"></p>
											</td>
										</tr>
										<tr>
											<th rowspan="">색상</th>
											<td rowspan="">
												<p id="popRgb"></p>
											</td>
										</tr>
										<tr style="border-bottom-style: hidden;">
											<td></td>
										</tr>
										<tr style="border-bottom-style: hidden;">
											<td></td>
										</tr>
										<tr style="border-bottom-style: hidden;">
											<td></td>
										</tr>
										<tr style="border-bottom-style: hidden;">
											<td></td>
										</tr>

										<%-- <tr>
											<th>파일다운로드</th>
											<td colspan="3">
												<div class="file_box" id="fileName">
													<a href="/hfa01/hfa01FileDown.json?seq=${notice.ENCRPT_SEQ}"
														class="file_down" download></a>
													<span class="file_name"></span>
												</div>
											</td>
											</tr> --%>
									</tbody>
									</tbody>
								</table>
								<!-- 테이블02(E) -->
							</div>
							<!-- 팝업 콘텐츠(E) -->
						</div>
					</div>
				</div>
			</div>


		</div>
		<!--WRAP(E)-->
	</body>

	</html>