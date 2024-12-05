<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, user-scalable=no">
	<title>모니터요원 입력시스템-그룹관리</title>
	<!-- @@@@@@@@@@@@@@@@@@@@@@ css begin @@@@@@@@@@@@@@@@@@@@@@ -->
	<link rel="stylesheet" type="text/css" href="<c:url value='/rMateChart/rMateChartH5/Assets/Css/rMateChartH5.css' />"/>   
	<link rel="stylesheet" type="text/css" href="<c:url value='/axisj/axicon/axicon.min.css' />" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/arongi/AXJ.min.css' />" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/hw/ma.css' />" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/hw/common.css' />" />
	<link href="/css/summernote/summernote.css" rel="stylesheet">
	<link href="/css/summernote/summernote-bs3.css" rel="stylesheet">
	<link href="/css/summernote/smsPhone.css" rel="stylesheet">
  	<!-- @@@@@@@@@@@@@@@@@@@@@@ css end   @@@@@@@@@@@@@@@@@@@@@@ --> 

	<script type="text/javascript" src="<c:url value='/axisj/jquery/jquery.min.js' />"></script>
	<script type="text/javascript" src="<c:url value='/axisj/dist/AXJ.min.js' />"></script>
	<script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/ax5-polyfill.js' />"></script>
	<script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/axjApp.js' />"></script>
  
	<!-- rMateChartH5 라이센스 시작 -->
	<script type="text/javascript" src="<c:url value='/rMateChart/LicenseKey/rMateChartH5License.js' />"></script>
	<!-- rMateChartH5 라이센스 끝-->  
	<!-- 실제적인 rMateChartH5 라이브러리 시작-->
	 <script type="text/javascript" src="<c:url value='/rMateChart/rMateChartH5/JS/rMateChartH5.js' />"></script>
	<!-- 실제적인 rMateChartH5 라이브러리 끝-->  
	<!-- rMateChartH5 테마 js -->
	<script type="text/javascript" src="<c:url value='/rMateChart/rMateChartH5/Assets/Theme/theme.js' />"></script>
	<!-- @@@@@@@@@@@@@@@@@@@@@@ css end   @@@@@@@@@@@@@@@@@@@@@@ --> 
  
<script type="text/javascript">
$(document).ready(function () {
	// 체크박스
    /* $('.i-checks').iCheck({
        checkboxClass: 'icheckbox_square-green',
        radioClass: 'iradio_square-green',
    }).on('ifChanged', function(e) {
        // Get the field name
        var isChecked = e.currentTarget.checked;

        if (isChecked == true) {
        	$(".resSelect").each(function(){ 
                $(this).prop('disabled', false);
            });
        }else{
        	$(".resSelect").each(function(){ 
                $(this).prop('disabled', true);
            });
        }
    }); */
	 
});

//받는 사람 목록 선택 효과 토글
function toggleClassOn(thisEl){
	thisEl.toggleClass("on");
}


var limitByte = 2000; //바이트의 최대크기, limitByte 를 초과할 수 없슴

// 메시지 글자수 체크
function fnChkByte(obj){
	var str = obj.value;
	var str_len = str.length;

	var rbyte = 0;
	var rlen = 0;
	var one_char = "";
	var str2 = "";

	for(var i=0; i<str_len; i++){
		one_char = str.charAt(i);
		if(escape(one_char).length > 4){
			rbyte += 2;                                         //한글2Byte
		}else{
			rbyte++;                                            //영문 등 나머지 1Byte
		}
		
		if(rbyte > 90){
			$("#sendSmsFrm #smsType").text("[장문]");
			$("#sendSmsFrm input[name=chkLong]").val("Y");
		}else{
			$("#sendSmsFrm #smsType").text("[단문]");
			$("#sendSmsFrm input[name=chkLong]").val("N");
		}
		
		if(rbyte <= limitByte){
			rlen = i+1;                                          //return할 문자열 갯수
		}
	}

	if(rbyte > limitByte){
		alert("한글 "+(limitByte/2)+"자 / 영문 "+limitByte+"자를 초과 입력할 수 없습니다.");
		str2 = str.substr(0,rlen);                                  //문자열 자르기
		obj.value = str2;
		fnChkByte(obj);
	}else{
		$("#sendSmsFrm #txtByte").text(rbyte);
	}
}

// 받는사람 추가
function addNumList(){
	var frm = $("#sendSmsFrm");
	
	var phone = frm.find("input[name=smsPhoneNum]").val();
	
	// 중복체크
	var chkNumer = 0;
	frm.find(".numList li").each(function(i){
		if($(this).find("a").text() == phone){
			alert("동일한 번호를 추가 할 수 없습니다.");
			frm.find("input[name=smsPhoneNum]").focus();
			chkNumer = 1;
			return false;
		}
	});
	if(chkNumer) return false;
	
	// 목록에 추가
	var listHtml ='<li><a href="javascript:void(0);" onclick="toggleClassOn($(this));">'+phone+'</a></li>';
	frm.find(".numList").append(listHtml);
	frm.find("input[name=smsPhoneNum]").val("");
	chkNumListCnt();
}

// 선택된 폰번호 제거 
function removePhoneNum(){
	var frm = $("#sendSmsFrm");
	if(frm.find(".numList li a.on").length == 0){
		alert("선택된 번호가 없습니다.");
		frm.find(".numList").focus();
		return false;
	}
	
	frm.find(".numList li a.on").each(function(i){
		$(this).parent().remove();
	});
	chkNumListCnt();
}

//현재 받는사람목록 최신화
function chkNumListCnt(){
	var frm = $("#sendSmsFrm");
	frm.find("#numListCnt").text(frm.find(".numList li").length);
}

// sms 발송
function sendSMS(){
	var frm = $("#sendSmsFrm");
	
	if (!confirm('문자를 발송하시겠습니까?')) return false;
	
	// 내용체크
	if(frm.find("textarea[name=message]").val() == ""){
		alert("메세지를 입력해주시기 바랍니다.");
		frm.find("textarea[name=message]").focus();
		return false;
	}
	
	if(frm.find(".numList li").length == 0 ){
		alert("받는사람을 등록해주시기 바랍니다.");
		frm.find("input[name=smsPhoneNum]").focus();
		return false;
	}
	
	// 예약 체크 되어있을경우 확인
	/* if($("input[name=reservation]").prop("checked")){
		frm.find("input[name=reservationChk]").val("Y");
		var now = new Date();
		var nowNumber =  leadingZeros(now.getFullYear(), 4) + 
						    leadingZeros(now.getMonth() + 1, 2) + 
						    leadingZeros(now.getDate(), 2) +
						    leadingZeros(now.getHours(), 2) + 
						    leadingZeros(now.getMinutes(), 2);
		var resTime = "" + frm.find("#preYear").val() + frm.find("#preMon").val() + frm.find("#preDay").val() + frm.find("#preHour").val() + frm.find("#preMin").val();
		if(nowNumber >= resTime ){
			alert("예약 전송은 현재시간 보다 이후에만 가능합니다.");
			return false;
		}	
	} */
	
	
	var phoneBook = [];
	frm.find(".numList li a").each(function(i){
		var data = {};
		data.mob = $(this).text();
		phoneBook.push(data);   
	});
	frm.find("input[name=phoneList]").val(JSON.stringify(phoneBook));
	
	/* $.ajax({
		type: "POST",
		url: "/sms/send/createProc.do",
		data: frm.serialize(),
		success: function(res) {
			alert(res.message);
			if(res.result == "1"){
				ajaxPageChange('/sms/send/list.do', '_self', 'SMS 발송', '${searchFrm.mn}', '${sessionScope.hpId}');
			}
		}
	}); */
	
	$.ajax({
		type: "post",
		url: "/send/sendSmsTranferInsert.json",
		data: frm.serialize(),
		success: function(res) {
			alert("완료");
		}
	});
	
	return false;
}

// 시간 숫자 두자리 변환 
function leadingZeros(n, digits) {
  var zero = '';
  n = n.toString();

  if (n.length < digits) {
    for (i = 0; i < digits - n.length; i++)
      zero += '0';
  }
  return zero + n;
}

//엑셀 upload modal 호출
function excelUploadModal(){
	$.ajax({
		type: "POST",
		url: "/sms/send/excelModal.do",
		success: function(res) {
			$("#mappModalfrm .modal-body").html(res);
			$("#mappModalfrm").modal("show");
		}
	});
}

</script>
   
</head>
<body>
	<%@ include file="/WEB-INF/inc/IncHeader.jsp" %>
	<article>
		<div class="wrap">
		<%@ include file="/WEB-INF/jsp/inc/IncMenu.jsp" %>

		<div class="hw_content"><!--컨텐츠 내용들어가는곳 시작-->
		<h3 class="hw_h3_ma"><div class="half1_white"></div><span class="half_title">SMS발송</span></h3>
		<div class="hw_clear"></div>	
	
		<div class="hw_infouse_01">  <p> <span class="purple"> ◎ 이용안내 :</span> 아래의 내용을 입력해 주시기 바랍니다.</p></div>
		<div class="hw_clear"></div>

		<div class="row">
			<div class="col-lg-12">
				<div class="ibox float-e-margins">
					<div class="ibox-content">
						<form id="sendSmsFrm" name="sendSmsFrm" method="post" class="form-horizontal" onsubmit="sendSMS();return false;" >
							<input type="hidden" name="chkLong" value="N" />
							<input type="hidden" name="phoneList" value="">
							<input type="hidden" name="reservationChk" value="N">
							
							<div class="form-group">
								<div class="col-sm-12">
									<!-- <div style="width: 710px;margin: 0 auto;">
										<div class="form-group">
											<div class="col-sm-6 ">
												<button class="btn btn-primary" type="button" onclick="excelUploadModal();">Excel Upload</button>
												&nbsp;&nbsp;SMS 받는사람 목록추가
											</div>
										</div>
									</div> -->
									
									<div class="phonWrap">
										<div class="phonArea pArea01">
											<div class="ct_phon">
												<h6 class="tit_phon">메세지 입력</h6>
												<textarea class="ct_sms" placeholder="메세지를 입력해주세요" id="message" name="message" onKeyUp="fnChkByte(this);"></textarea>
												<p class="sms_p100p">
													<span class="sms_gray" id="txtByte">0</span>
													&nbsp;/&nbsp;
													<span class="sms_red" id="txtFullByte">2000</span>
													&nbsp;byte&nbsp;
													<span id="smsType">[단문]</span>
												</p>
												<h6 class="tit_phon">보내는 사람</h6>
												<label class="hide" for="smsInput01">보내는사람번호입력</label>
												<input type="text" name="sendNumber" value="" placeholder="-없이 입력" class="smsInput onlyNum" id="smsInput01" required="required" maxlength="11">
											</div><!-- ct_phon end -->
										</div><!-- phonArea pArea01 end -->
										<div class="phonArea pArea02">
											<div class="ct_phon">
												<h6 class="tit_phon">받는 사람</h6>
												<label class="hide" for="smsInput02">받는사람번호입력</label>
												<input type="text" name="smsPhoneNum" value="" placeholder="-없이 입력" class="smsInput onlyNum" id="smsInput02" maxlength="11">
												<button class="btnAdd" type="button" onclick="addNumList();" >받는 사람 추가</button>
												<ul class="numList"></ul><!-- numList end -->
												<button class="btnAddDel" type="button" onclick="removePhoneNum();">선택삭제</button>
												<p class="sms_p50p"><span class="sms_gray">총인원</span>&nbsp;<span class="sms_red" id="numListCnt">0</span>&nbsp;명</p>
												<!-- <div class="i-checks">
													<label class="">
														<div class="icheckbox_square-green" style="position: relative;">
															<input type="checkbox" name="reservation" value="Y" style="position: absolute; opacity: 0;">
															<ins class="iCheck-helper" style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: rgb(255, 255, 255); border: 0px; opacity: 0;"></ins>
														</div> <i></i> 예약 전송으로 보내기 
													</label>
												</div> -->
												<%-- <div class="timeWrap">
													<div class="row">
														<div class="col-xs-4" style="padding-right: 0px;">
															<select name="preYear" id="preYear" class="form-control resSelect" disabled="disabled">
																<c:forEach begin="${preYear }" end="${preYear + 5}" varStatus="i">
																	<option value="${i.index }" <c:if test="${i.index eq preYear }">selected="selected"</c:if>>${i.index }</option>
				                                        		</c:forEach>
															</select>
														</div>
														<div class="col-xs-4" style="padding-right: 0px;">
															<select name="preMon" id="preMon" class="form-control resSelect" disabled="disabled">
																<c:forEach begin="1" end="12" varStatus="i">
																	<c:if test="${i.index < 10}">
																		<option value="0${i.index }" <c:if test="${i.index eq preMon }">selected="selected"</c:if>>${i.index } 월</option>
																	</c:if>
																	<c:if test="${i.index >= 10}">
																		<option value="${i.index }" <c:if test="${i.index eq preMon }">selected="selected"</c:if>>${i.index } 월</option>
																	</c:if>
				                                        		</c:forEach>
															</select>
														</div>
														<div class="col-xs-4" >
															<select name="preDay" id="preDay" class="form-control resSelect" disabled="disabled">
																<c:forEach begin="1" end="31" varStatus="i">
																	<c:if test="${i.index < 10}">
																		<option value="0${i.index }" <c:if test="${i.index eq preDay }">selected="selected"</c:if>>${i.index } 월</option>
																	</c:if>
																	<c:if test="${i.index >= 10}">
																		<option value="${i.index }" <c:if test="${i.index eq preDay }">selected="selected"</c:if>>${i.index } 월</option>
																	</c:if>
				                                        		</c:forEach>
															</select>
														</div>
													</div>
			                                    </div> --%><!-- timeWrap end -->
		                                    	<%-- <div class="timeWrap">
		                                    		<div class="row">
														<div class="col-xs-4" style="padding-right: 0px;">
															<select name="preHour" id="preHour" class="form-control resSelect" disabled="disabled">
																<c:forEach begin="0" end="23" varStatus="i">
																	<c:if test="${i.index < 10}">
																		<option value="0${i.index }" <c:if test="${i.index eq preHour }">selected="selected"</c:if>>${i.index } 시</option>
																	</c:if>
																	<c:if test="${i.index >= 10}">
																		<option value="${i.index }" <c:if test="${i.index eq preHour }">selected="selected"</c:if>>${i.index } 시</option>
																	</c:if>
				                                        		</c:forEach>
															</select>
														</div>
														<div class="col-xs-4" style="padding-right: 0px;">
															<select name="preMin" id="preMin" class="form-control resSelect" disabled="disabled">
																<c:forEach begin="0" end="59" varStatus="i">
																	<c:if test="${i.index < 10}">
																		<option value="0${i.index }" <c:if test="${i.index eq preMin }">selected="selected"</c:if>>${i.index } 분</option>
																	</c:if>
																	<c:if test="${i.index >= 10}">
																		<option value="${i.index }" <c:if test="${i.index eq preMin }">selected="selected"</c:if>>${i.index } 분</option>
																	</c:if>
				                                        		</c:forEach>
															</select>
														</div>
													</div>
			                                    </div> --%><!-- timeWrap end -->
		                                    	<button class="smsSend" type="submit">SMS 전송</button>
											</div><!-- ct_phon end -->
										</div><!-- phonArea pArea02 end -->
									</div><!-- phonWrap end -->
								
								</p></div>
							</div>
							<!--// 기타항목 종료 -->
							<div class="hr-line-dashed"></div>
							
							<!-- <div class="form-group">
								<div class="col-sm-6 ">
									<button class="btn btn-primary" type="button" onclick="sendEmail();" >문자 보내기</button>
								</div>
							</div> -->
						</form>
						
						<!-- 엑셀 업로드 모달 -->
						<div id="mappModalfrm" class="modal fade" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-body">
										&nbsp;
									</div>
								</div>
							</div>
						</div>
						<!--// 엑셀 업로드 모달 -->
						
					</div>
				</div>
			</div>
		</div>
		</div><!--wrap 끝-->
	</article>
	<footer>
		<%@ include file="/WEB-INF/inc/IncFooter.jsp" %>
	</footer>
</body>
</html>