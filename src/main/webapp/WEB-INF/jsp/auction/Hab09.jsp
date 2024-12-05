<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head> 
	<meta charset="utf-8">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, user-scalable=no">
	<meta name="apple-mobile-web-app-title" content="화훼유통정보시스템">
	<meta name="robots" content="no-index,follow">
	<meta name="og:title" content="화훼유통정보시스템">
	<meta name="og:description" content="화훼유통정보시스템">
	<meta name="description" content="일자별 경매동향">
	<meta name="content" content="화훼유통정보시스템 입니다.">
	<meta name="keywords" content="화훼경매시세, 화훼경매가격, Korea aT flower market auction price, 화훼공판장, 화훼거래정보, 꽃시장, 꽃값">
	<meta name="Author" content="화훼유통정보시스템 & www.woorim.co.kr">
	<title>일자별 경매결과</title>
	<%@include file="../common/2020/commonJs.jsp" %>
	<%@include file="../common/2020/commonCss.jsp" %>
  
	<script type="text/javascript">
		$(document).ready(function(){
			$("#searchStrDate").datepicker({
				showOn: "button",
				buttonImage: "../images/2020/ico_date_02.png",
				buttonImageOnly: true,
				todayHighlight: true,
				autoclose: true,
				showMonthAfterYear: true,
				dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
				monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
				language: 'kr',
				dateFormat: 'yy-mm-dd',
				beforeShowDay:datechktoday,
				yearSuffix: '년',
				changeMonth: true,
				changeYear: true,
				onSelect: function(){
					dateChkstr();
				}
			});
	
			$("#searchEndDate").datepicker({
				showOn: "button",
				buttonImage: "../images/2020/ico_date_02.png",
				buttonImageOnly: true,
				todayHighlight: true,
				autoclose: true,
				showMonthAfterYear: true,
				dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
				monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
				language: 'kr',
				dateFormat: 'yy-mm-dd',
				beforeShowDay:datechktoday,
				yearSuffix: '년',
				changeMonth: true,
				changeYear: true,
				onSelect: function(){
					var begins=$("#searchEndDate").val();
					var begindate=month_sample(begins,12);
					$("#searchStrDate").datepicker("change",{minDate: begindate });
	
					dateChkend();
				}
			});
		});

		function dateChkstr(){
			if($("#searchStrDate").val() > $("#searchEndDate").val()){
				$("#searchEndDate").val($("#searchStrDate").val()) ;
			}
		}

		function dateChkend(){
			if($("#searchStrDate").val() > $("#searchEndDate").val()){
				$("#searchStrDate").val($("#searchEndDate").val()) ;
			}
		}

		function datechktoday(date){
			if(date > new Date()) return [false]; return [true];
		}

		function month_sample(value,num){
			var yyyy,m,d;
			var arr=value.split('-');
			var dt= new Date(arr[0],arr[1],arr[2]);
			var dt_v= new Date(arr[0],arr[1],arr[2]);
			dt_v.setMonth(dt.getMonth()-num);
			yyyy= dt_v.getFullYear();
			m=dt_v.getMonth();
			d=dt_v.getDate();

			if(m =="0") {m="12"; yyyy=yyyy-1;}
			if(m<10) {m='0'+m;}
			if(d<10) {d='0'+d;}

			begindate=yyyy+'-'+m+'-'+d;
			return begindate;
		}
		
	
		var myModal = new AXModal();
	
		/**
		 * Require Files for AXISJ UI Component...
		 * Based        : jQuery
		 * Javascript    : AXJ.js, AXModal.js
		 * CSS            : AXJ.css
		 */
		var fnObj =  {
		    modalOpen: function (seq) {
		    	addClickCnt(seq);
		    	$.ajax({
		            url : "/hab09/getHab09Seq.json",
		            data : {
		           	 seq : seq,
		           	 searchStrDate : $("#searchStrDate").val(),
		           	 searchEndDate : $("#searchEndDate").val(),
		           	 mobCmpCd : $("#mobCmpCd option:selected").val()
		    		},
		    		dataType : '',
		            success : function(res){
		               	$("#rNum").text(res.detail.RNUM);
		               	$("#insId").text(res.detail.CMP_NAME);
		               	$("#title").text(res.detail.TITLE);
		               	
		               	$("#exportBtn1").attr("onclick", "excelExport(\""+ res.detail.SALE_DT + "\", \""+ res.detail.CMP_CD +"\");");

		               	fnLayerPopup('#utda_input');
		            }
		        }); 
		    },

		    close:function(){
		        if(opener){
		            window.close();
		        }
		        else
		        if(parent){
		            if(parent.myModal) parent.myModal.close();
		        }
		        else
		        {
		            window.close();
		        }
		    }
		};
		
		function gfn_isNull(str) {
			if (str == null) return true;
			if (str == "NaN") return true;
			if (new String(str).valueOf() == "undefined") return true;    
			var chkStr = new String(str);
			if( chkStr.valueOf() == "undefined" ) return true;
			if (chkStr == null) return true;    
			if (chkStr.toString().length == 0 ) return true;   
			return false; 
		}
		
		function ComSubmit(opt_formId) {
			this.formId = gfn_isNull(opt_formId) == true ? "commonForm" : opt_formId;
			this.url = "";
			
			if(this.formId == "commonForm"){
				$("#commonForm")[0].reset();
			}
			
			this.setUrl = function setUrl(url){
				this.url = url;
			};
			
			this.addParam = function addParam(key, value){
				$("#"+this.formId).append($("<input type='hidden' name='"+key+"' id='"+key+"' value='"+value+"' >"));
			};
			 
			
			 this.submit = function submit(){
				var frm = $("#"+this.formId)[0];
				frm.action = this.url;
				frm.method = "post";
				frm.submit();	
			};
		}
		
		function fn_searchPage(pageNo){
		   var comSubmit = new ComSubmit();
		   comSubmit.setUrl("<c:url value='/hab09/hab09.do'/>");
		   comSubmit.addParam("currentPageNo", pageNo);
		   
		   comSubmit.addParam("searchStrDate", $("#searchStrDate").val());
		   comSubmit.addParam("searchEndDate", $("#searchEndDate").val());
		   comSubmit.addParam("mobCmpCd", $("#mobCmpCd option:selected").val());
		   
		   comSubmit.submit();
		};
		
		
		function fn_search(pageNo) {		
			$("#currentPageNo").val(pageNo);
			$("#searchForm").attr("action", "<c:url value='/hab09/hab09.do'/>").submit();
		}
		
		function addClickCnt(SEQ){
			$.ajax({
				type : "post",
				url : "/hab09/updateClickCnt.json",
				data : {
					SEQ : SEQ
				},
				dataType : '',
				success : function(res){
					var clickCnt = $(".td_"+SEQ).html();
					$(".td_"+SEQ).html((Number(clickCnt)+1));
				}
			});
		}
		
		// 엑셀 다운로드
		function excelExport(saleDt, cmpCd){
			var excelNm = "일자별 경매동향";
			var param = "?excelNm=" + excelNm + "&saleDate=" + saleDt + "&cmpCd=" + cmpCd;
			location.href = "/excel/excelDownLoad.do" + param;
		}
	</script>
</head>


<body>
	<!--WRAP(S)-->
	<div class="wrap">

		<jsp:include page="../inc/2020/IncHeader.jsp"/>
		
		<!--서브 헤더 (S)-->
		<div class="lnb_box">
			<ul>
				<li><img src="../images/2020/m_lnb_img.png" alt="집"></li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li>경매정보</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li>경매실적</li>
				<li><img src="../images/2020/m_right_img.png" alt="화살표"></li>
				<li class="m_right">일자별 경매결과</li>
			</ul>
		</div>
		<!--sub 헤더 (E)-->
		
		<!--서브 타이틀(S)-->
		<div class="sub_title">		
			<div class="title_box">
				<h2>일자별 경매결과</h2>
				<img src="../images/2020/sub/t_line.png" alt="방울점선">
			</div>
		</div>
		<!--서브 타이틀(E)-->
		
		<!--콘텐츠_메인(S)-->
		<div class="sub_contents">
				
			<form name="searchForm" id="searchForm" method="post">
				<input type="hidden" name="currentPageNo" value=""/>
				<!-- 검색창(S) -->
				<div class="search_box_s">
					<div class="search_01">
						<ul class="search_box01">
							<li class="calendar" id="liStrDate">
								<p class="search_01_txt">시작일자</p>
								<input type="text" class="datepicker except" name="searchStrDate" id="searchStrDate" value="${searchStrDate}"/>
							</li>
							<li class="calendar">
								<p class="search_01_txt">종료일자</p>
								<input type="text" class="datepicker except" name="searchEndDate" id="searchEndDate" value="${searchEndDate}"/>
							</li>
							<li>
								<p class="search_01_txt">공판장선택</p>
								<select id="mobCmpCd" name="mobCmpCd" class="form-control except">
									<option value="" >전체</option>
									<option value="0000000001" <c:if test="${mobCmpCd == '0000000001'}">selected="selected"</c:if>>aT화훼공판장(양재동)</option>
									<option value="1508500020" <c:if test="${mobCmpCd == '1508500020'}">selected="selected"</c:if>>부산화훼공판장(엄궁동)</option>
									<option value="6068207466" <c:if test="${mobCmpCd == '6068207466'}">selected="selected"</c:if>>부산경남화훼농협(강동동)</option>
									<option value="4108212335" <c:if test="${mobCmpCd == '4108212335'}">selected="selected"</c:if>>광주원예농협(풍암)</option>
									<option value="3848200087" <c:if test="${mobCmpCd == '3848200087'}">selected="selected"</c:if>>한국화훼농협(음성)</option>
									<option value="1288202296" <c:if test="${mobCmpCd == '1288202296'}">selected="selected" onclick="gwacheonAlert();" </c:if>>한국화훼농협(과천)</option>
									<option value="7368200686" <c:if test="${mobCmpCd == '7368200686'}">selected="selected"</c:if>>한국화훼농협(고양)</option>
									<option value="6158209828" <c:if test="${mobCmpCd == '1288202296'}">selected="selected"</c:if>>영남화훼농협(김해)</option>


								</select>
							</li>
							<li class="search_btn">
								<!-- <button type="button" class="btn_search" onclick="fn_search(1)">검색</button> -->
								<a href="javascript:fn_search(1)"><img src="../images/2020/sub/search_img.png" alt="돋보기"></a>
							</li>
						</ul>
					</div>
				</div>
				<!-- 검색창(E) -->
			</form>
				
			<!-- 테이블(S) -->
			<table class="table_type_02">
				<caption>일자별 경매결과</caption>
				<colgroup>
					<col style="width:10%">
					<col style="width:23%">
					<col style="width:25%">
					<col style="width:13%">
					<col style="width:16%">
					<col style="width:13%">
				</colgroup>
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>공판장</th>
						<th>엑셀다운로드</th>
						<th>작성일</th>
						<th>조회수</th>
					</tr>
				</thead>
				<tbody>
					<c:set var="list" value="${list}"/>
					<c:if test="${!empty list}">
						<c:forEach var="bbs" items="${list}"  varStatus="status">
							<tr>
								<td class="tc">
									${bbs.rnum}
								</td>
								<td class="tc">
									<a href="#" class="ellipsis" onclick="fnObj.modalOpen('${bbs.seq}');" >${bbs.title}</a>
								</td>
								<td class="tc">
									${bbs.cmpName}
								</td>
								<td class="tc">
									<a href="javascript:void(0);" class="file_down" onclick="excelExport('${bbs.saleDt}', '${bbs.cmpCd}');"></a>
								</td>
								<td class="tc">
									${bbs.insDt}
								</td>
								<td class="tc td_${bbs.seq}">
									${bbs.clickCnt}
								</td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${empty list}">
						<tr><td class="tc" colspan="6">데이터가 없습니다.</td></tr>
					</c:if>						
				</tbody>
			</table>
			<!-- 테이블(E) -->	
				
			<!-- 페이지버튼(S) -->
			<div class="paging_box">
				<c:if test="${not empty paginationInfo}">
					<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_searchPage"/>
				</c:if>
				<input type="hidden" id="currentPageNo" name="currentPageNo"/>
			</div>
			<!-- 페이지버튼(E) -->
				
		</div>
		<!--콘텐츠_메인(E)-->
	
		<jsp:include page="../inc/2020/IncFooter.jsp"/>	
	
	
		<!-- 팝업(S) -->
		<form name="send-form" id="send-form" enctype="multipart/form-data">
			<input type="hidden" id="contentHidden" name="contentHidden" value=""/>
			
			<div class="dim-layer" id="utda_input">
				<div class="dimBg"></div>
				<div class="pop-layer popbox">
					<div class="pop-container">
						<div class="pop-conts_00">
							<!-- 팝업타이틀(S) -->
							<div class="pop_title_box">
								<h2 class="pop_title">일자별 경매결과</h2>
								<a href="#!" class="btn-layerClose close_B">Ⅹ</a>
							</div>
							<!-- 팝업타이틀(E) -->
		
							<!-- 팝업 콘텐츠(S) -->
							<div class="pop_conts">
								<!-- 테이블02(S) -->
								<table class="table_type_02 pop">
									<caption>popTable</caption>
									<colgroup>
										<col style="width:10%">
										<col style="width:35%">
										<col style="width:25%">
										<col style="width:30%">
									</colgroup>
									<tbody>
										<tr>
											<th>번호</th>
											<th>제목</th>
											<th>공판장</th>
											<th>파일다운로드</th>
										</tr>
										<tr>
											<td class="tc"><p id="rNum"></p></td>
											<td class="tc"><p id="title"></p></td>
											<td class="tc"><p id="insId"></p></td>
											<td class="tc">
												<div class="dwn_bt_c" id="excelBtn1">
													<a href="javascript:void(0);" id="exportBtn1" name="exportTable1">
													<img src="../images/2020/exel.png" alt="엑셀이미지">엑셀저장</a>
												</div>
											</td>
										</tr>									
									</tbody>
								</table>
								<!-- 테이블02(E) -->				
							</div>
							<!-- 팝업 콘텐츠(E) -->
						</div>
					</div>
				</div>
			</div>
		</form>
		<form id="commonForm" name="commonForm"></form>
		<!-- 팝업(E) -->	
	
	</div>		
	<!--WRAP(E)-->		

</body>
</html>