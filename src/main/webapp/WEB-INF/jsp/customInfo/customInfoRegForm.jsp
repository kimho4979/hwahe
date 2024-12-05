<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8"/>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, user-scalable=no"/>
	<meta name="apple-mobile-web-app-title" content="화훼유통정보시스템"/>
	<meta name="robots" content="no-index,follow"/>
	<meta name="og:title" content="화훼유통정보시스템"/>
	<meta name="og:description" content="화훼유통정보시스템"/>
	<meta name="description" content="회원가입-약관동의">
	<meta name="content" content="화훼유통정보시스템 입니다."/>
	<meta name="keywords" content="화훼경매시세, 화훼경매가격, Korea aT flower market auction price, 화훼공판장, 화훼거래정보, 꽃시장, 꽃값">
	<meta name="Author" content="화훼유통정보시스템 & www.woorim.co.kr"/>
	<title>회원가입-약관동의</title>
	<%@include file="../common/2020/commonCss.jsp" %>
	<%@include file="../common/2020/commonJs.jsp" %>
	
	<script type="text/javascript">
		var checkBox = null;
	
		$(document).ready(function(){
			
		});
		
		/* $.ajax({
		type : 'get',
		url : "/customInfo/saveUser.json",
		data :  $("#actionForm").serialize(),
		dataType : 'json',   	           
		success : function(res){    
			if(res.result){
				alert('저장되었습니다');
				var url = "/customInfo/customInfoForm.do";
				$(location).attr('href',url);	
			}else{
				alert(res.resultMsg);
				return;
			}
		},
		error : function(res){
			alert('저장실패');
			return;
		}
	}); */ 

		function checkedBtn(){
			checkBox = $("input:checkbox[id=checkBox]").is(":checked");
			if(checkBox == false){
				alert("개인정보 수집 및 이용에 동의하여 주십시오.")
				$("#checkBox").siblings("label").focus();
			}
			if(checkBox == true){
				
			    $.ajax({ //비동기 방식 (페이지가 넘어가지 않고 그 페이지에서 바로 자료가 변경됨)
			        type : 'get',
			        url : "/customInfo/nextStep.json",
			        data : '&vaildation=2',
					dataType : 'json',   
			        success : function(result){}
			        });
				var url = "/customInfo/customInfoRegForm2.do";    
				$(location).attr('href',url);
			}
		}
		
		function cancel(){
			var url = "/main/flowerMain.do";
			$(location).attr('href',url);
		}
	</script>
</head>
<body>
	<!--WRAP(S)-->
	<div class="wrap">
	
		<jsp:include page="../inc/2020/IncHeader.jsp"/>	

		<!--콘텐츠_메인(S)-->
		<div class="conts_main">
			<div class="conts_main_in">

				<!-- 서브타이틀(S) -->
				<div class="log_title_box">
					<h2 class="log_tit">회원가입</h2>
					<p class="log_sant">화훼유통정보 홈페이지 회원가입을 환영합니다.</p>
				</div>
				<!-- 서브타이틀(E) -->

				<!-- 회원가입순서(S) -->
				<div class="sign_step">
					<ul>
						<li class="on">
							<p>1 STEP</p>
							<span>약관동의</span>
						</li>
						<li>
							<p>2 STEP</p>
							<span>본인인증</span>
						</li>
						<li>
							<p>3 STEP</p>
							<span>아이디생성</span>
						</li>
						<li>
							<p>4 STEP</p>
							<span>정보입력</span>
						</li>						
						<li>
							<p>5 STEP</p>
							<span>가입완료</span>
						</li>
					</ul>
				</div>
				<!-- 회원가입순서(E) -->

				<!-- 회원가입 내용(S) -->
				<div class="tit_box_01">
					<div class="fl">
						<h3 class="sub_title_01">개인정보 수집·이용에 대한 안내</h3>
					</div>
				</div>

			

				<div class="notice_box_01">
					<p class="notice_common">aT화훼유통정보 서비스 이용을 위한 개인정보보호법에 따라 아래와 같이 귀하의 개인정보를 수집·이용·제공하고자 합니다. </p>
					<p class="notice_common">본 수집·이용·제공 동의와 함께 제출된 개인정보는 보유·이용기간 만료 시 안전한 방법으로 파기합니다.</p>
					
					<br/>
					
					<table class="table_type_01">
						<caption>infoNotice</caption>
						<colgroup>
							<col style="width:33.3%">
							<col style="width:33.3%">
							<col style="width:33.3%">
						</colgroup>
						<thead>
							<tr>
								<th>수집·이용하려는 개인정보 항목</th>
								<th>개인정보의 수집·이용 목적</th>
								<th>개인정보 보유·이용기간</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="tc"><p><em class="point_01">필수</em> <br/> 이메일, 비밀번호</p></td>
								<td class="tc"><p>가격문자알림서비스</p></td>
								<td class="tc"><p>보유·이용기간 만료 시</p></td>
							</tr>
						</tbody>
					</table>
					
					<p class="notice_common">동의를 거부할 권리 및 동의를 거부할 경우의 불이익</p>
					<p class="notice_common">귀하는 개인정보 수집·동의를 거부할 권리가 있으며, 동의 거부시 가격문자 알림 서비스 이용이 불가하오니 양지하시기 바랍니다.</p>
				</div>

				<div class="tit_box_02">
					<div class="fl">
						<h3 class="sub_title_01">이용약관</h3>
					</div>
				</div>

				<!-- 이용약관내용(S) -->
				<div class="notice_box_02">
					<p class="notice_common fwb">제1장 총칙</p>

					<p class="notice_common">제1조 (목적)</p>
					

					<p class="notice_common">본 약관은 한국농수산식품유통공사 화훼사업센터에서 농림축산식품부로부터 위탁받아 운영하는 화훼유통정보시스템(이하 시스템이라고 한다.)에서 제공하는 모든 서비스(이하 “서비스”)의 이용조건 및 절차와 기타 필요한 사항을 규정함을 목적으로 합니다.</p>
					
					<br/>
					<p class="notice_common">제2조 (정의)</p>

					<p class="notice_common">이 약관에서 사용하는 용어의 정의는 다음과 같습니다.</p>
					<p class="notice_common">① 회원 : 시스템에 접속하거나 회원 가입을 한 후에 서비스를 이용하고 있는 자</p>
					<p class="notice_common">② 비밀번호 : 이용자와 회원ID가 일치하는지를 확인하고 통신상의 자신의 비밀보호를 위하여 이용자 자신이 선정한 문자와 숫자의 조합</p>
					<p class="notice_common">④ 탈퇴 : 회원이 시스템 이용계약을 종료시키는 행위</p>
					<p class="notice_common">⑤ 본 약관에서 정의하지 않은 용어는 개별서비스에 대한 별도 약관 및 기능별 안내에서 정의합니다.</p>
					<br/>

					<p class="notice_common">제3조 (약관의 효력과 변경)</p>
					<p class="notice_common">① 회원이 본 약관 내용에 동의하는 경우 시스템 서비스 제공 행위와 회원의 서비스 사용 행위에 대해 본 약관이 우선적으로 적용됩니다.</p>
					<p class="notice_common">② 본 약관의 변경은 시스템 인터넷 홈페이지에 공지함으로써 효력이 발생합니다. 단, 회원의 권리와 의무가 제한되는 내용의 변경이 있는 경우 회원의 동의 후에 효력이 발생됩니다.</p>
					<br/>

					<p class="notice_common">제4조 (약관 외 준칙)</p>
									
					<p class="notice_common">본 약관에 명시되지 않은 사항은 전기통신기본법, 전기통신사업법, 정보통신윤리위원회심의규정, 정보통신 윤리강령, 프로그램보호법 및 기타 관련 법령의 규정에 의합니다.</p>
					
					<br/>
					<p class="notice_common fwb">제2장 회원가입 및 탈퇴 처리</p>
									
					<p class="notice_common">제5조 (회원가입 및 이용계약의 성립)</p>
									
					<p class="notice_common">① 본 약관에 동의하고 회원가입을 하는 경우 이용계약이 성립되며 관련법령에 따라 회원의 개인정보 정보 수집, 이용에 동의하는 것으로 간주됩니다.</p>
					<p class="notice_common">② 회원은 본인의 정보를 시스템에 등록하여야만 전체 서비스를 이용할 수 있으며, 타인의 정보를 도용하거나 허위 정보를 등록하는 등의 행위를 하는 경우 관계 법령에 따라 처벌받을 수도 있습니다.</p>
					<p class="notice_common">③ 회원은 등록사항에 변경이 있는 경우, 그 변경 사항을 수정하여야 합니다. 변경 사항을 수정하지 아니함으로 인하여 발생한 손해는 회원에게 그 책임이 있습니다.</p>
					<p class="notice_common">④ 다음 각 호에 해당하는 경우에는 시스템 ID로 사용할 수 없습니다.</p>
					<p class="notice_common">1. ID가 시스템의 정상 작동을 저해할 수 있는 경우</p>
					<p class="notice_common">2. ID가 타인에게 혐오감을 줄 수 우려가 있는 경우</p>
					<p class="notice_common">⑤ 회원은 부득이한 사유로 ID를 변경하고자 하는 경우에는 해당 ID를 해지하고 재가입하여야 합니다. 회원이 해지한 ID는 사용할 수 없습니다.</p>
					<br/>

					<p class="notice_common">제6조 (회원 탈퇴)</p>
									
					<p class="notice_common">① 회원은 이용계약 해지를 통해 시스템 회원에서 탈퇴할 수 있습니다.</p>
					<p class="notice_common">② 회원 탈퇴에 따른 말소 등의 처리는 시스템 개인정보보호 정책에 따릅니다.</p>
					<p class="notice_common">제3장 회원의 의무 및 서비스 이용</p>
					<br/>
									
					<p class="notice_common">제7조 (회원 의무)</p>
									
					<p class="notice_common">① ID와 비밀번호에 관한 모든 권한과 책임은 회원에게 있으며 시스템은 회원의 과실로 ID와 비밀번호가 유출되어 발생한 피해에 대해서는 책임지지 않습니다.</p>
					<p class="notice_common">② 시스템 정보입력 및 수정 등은 회원 본인이 하여야 하며, 정보 수정 등이 불가능한 경우 시스템 담당부서가 회원의 요청에 의해 가능한 범위 내에서 처리를 지원할 수 있습니다.</p>
					<p class="notice_common">③ 회원의 ID나 비밀번호가 부정하게 사용되었다는 사실을 발견한 경우 회원은 즉시 시스템에 신고하여야 하고, 시스템의 안내가 있는 경우 그에 따라야 합니다. 회원이 신고하지 않거나 시스템의 안내에 따르지 아니하여 발생하는 손해는 회원에게 그 책임이 있습니다.</p>
					<br/>
					
					<p class="notice_common">제8조 (서비스 이용시간)</p>
									
					<p class="notice_common">① 서비스 이용 시간은 업무상 또는 기술상 특별한 지장이 없는 한 24시간 운영을 원칙으로 합니다.</p>
					<br/>

					<p class="notice_common">제9조 (업무 지원)</p>									
					<p class="notice_common">① 이용자 문의 응대는 평일에만 지원합니다.</p>
					<p class="notice_common">② 이용자 문의 응대를 위하여 회원의 정보를 요구하거나 열람할 수 있으며 회원이 정보 제공을 거부하는 경우 업무 지원이 제한될 수 있습니다.</p>
					<p class="notice_common">③ 회원의 지나친 요구나 반말, 욕설, 비하발언, 성추행 등 부적절한 언어의 사용하는 경우 업무지원은 즉시 중단될 수 있습니다.</p>
					<p class="notice_common">⑤ 회원에게 상담 등으로 응대한 내용은 응대자 개인의 의견일 수 있으므로 이에 대하여 시스템이 법적 책임을 부담하지 아니하고, 위 응대 내용은 소송 등 법적 절차에서 증거로 사용될 수 없습니다.</p>
					<br/>
					
					<p class="notice_common">제10조 (서비스 중지)</p>
									
					<p class="notice_common">① 국가비상사태, 정전, 긴급한 시스템 점검, 증설 및 교체, 설비의 장애 등 부득이한 사유가 발생한 경우 사전 예고없이 일시적으로 시스템의 서비스의 전부 또는 일부가 중단될 수 있습니다.</p>
					<p class="notice_common">② 시스템 점검, 기능개선 등 시스템의 원활한 운영과 사용자 서비스 향상을 위해 필요한 경우 시스템은 서비스의 전부 또는 일부를 중단할 수 있습니다.</p>
					<br/>
					
					<p class="notice_common">제11조 (게시물 관리)</p>
									
					<p class="notice_common">① 회원이 등록한 게시물에 대한 권리는 회원에게 있으며, 그 게시물이 타인의 지식재산권을 침해하는 경우 민, 형사상의 모든 책임은 회원에게 있습니다.</p>
					<p class="notice_common">② 시스템은 다음 각 호에 해당하는 게시물 등의 경우 회원의 사전 동의 및 통지 없이 삭제할 수 있습니다.</p>
					<p class="notice_common">1. 본 서비스 약관에 위배되거나 상용 또는 불법, 음란, 저속하다고 판단되는 내용을 게시한 경우</p>
					<p class="notice_common">2. 다른 회원 또는 제3자를 비방하거나 명예를 손상시키는 내용인 경우</p>
					<p class="notice_common">3. 공공질서 및 미풍양속에 위반되는 내용인 경우</p>
					<p class="notice_common">4. 범죄적 행위에 결부된다고 인정되는 내용일 경우</p>
					<p class="notice_common">5. 제3자의 저작권 등 기타 권리를 침해하는 내용인 경우</p>
					<p class="notice_common">6. 기타 관계법령에 위배된다고 판단되는 경우</p>
					<br/>
					
					<p class="notice_common">제12조 (통지)</p>
									
					<p class="notice_common">① 시스템은 회원이 시스템에 등록한 전화, e-mail, 주소 등을 활용하여 시스템 운영과 관련된 안내사항 등을 통지할 수 있습니다.</p>
					<p class="notice_common">② 불특정다수 회원에게 통지를 해야 할 경우 시스템 팝업창 또는 공지 게시판을 통해 일정기간 게시함으로써 개별통지를 갈음할 수 있습니다.</p>
					<br/>
					
					<p class="notice_common fwb">제4장 기타</p>
									
					<p class="notice_common">제13조 (손해배상 및 면책조항)</p>
									
					<p class="notice_common">① 국가 비상사태, 정전, 시스템 장애, 기타 불가항력적으로 시스템이 중단되는 경우 시스템은 회원에게 발생한 손해에 대해 책임을 부담하지 않습니다.</p>
					<p class="notice_common">② 시스템 기능 개선 및 시스템 점검을 위해 시스템 중단이 필요한 경우 서비스를 중지할 수 있으며 이로 인해 발생한 손해에 대해서는 시스템은 책임을 부담하지 않습니다.</p>
					<p class="notice_common">③ 시스템은 회원이 서비스 사용으로 인하여 입은 손해에 대하여 시스템이 고의로 행한 범죄 행위를 제외하고는 책임지지 아니합니다.</p>
					<br/>
					
					<p class="notice_common">제14조 (지식재산권)</p>
									
					<p class="notice_common">① 시스템을 통해 제공하는 서비스, 그에 필요한 소프트웨어, 이미지, 마크, 로고, 디자인, 서비스명칭, 정보 및 상표 등과 관련된 지식재산권 및 기타 권리는 한국농수산식품유통공사 화훼사업센터에 소유권이 있습니다.</p>
					<p class="notice_common">② 회원은 매뉴얼 등 시스템에서 제공하는 자료에 대해 자유롭게 이용할 수 있으며 제공된 자료를 이용할 경우 시스템에서 제공한 자료임을 명기하여야 합니다.</p>
					<p class="notice_common">제15조 (재판권 및 준거법)</p>
									
					<p class="notice_common">① 이 약관에 명시되지 않은 사항은 「정보통신망 이용촉진 및 정보보호 등에 관한 법률」등 대한민국의 관계법령과 관습에 따릅니다.</p>
					<p class="notice_common">② 서비스 이용으로 발생한 분쟁에 대하여는 대한민국 법을 적용하며, 본 분쟁으로 인한 소는 대한민국 법원에 제기합니다.</p>
					<br/>
					
					<p class="notice_common fwb">부칙</p>
									
					<p class="notice_common">제1조 본 약관은 2018년 10월 16일부터 시행됩니다.</p>
				</div>
				<!-- 이용약관내용(E) -->

				<!-- 하단(S) -->
				<div class="bottom_tit_box">
					<div class="fr">
						<input type="checkbox" id="checkBox" value="" />
						<label for="checkBox" class="title_box_chk"><em class="txt">개인정보 수집 및 이용에 동의합니다</em><span></span></label>
					</div>
				</div>
				<!-- 하단(E) -->				

				<!-- 회원가입 내용(E) -->

				<div class="btn_box tc">
					<a href="javascript:void(0);" class="btn_type_02" onclick="checkedBtn();">동의합니다.</a>
					<a href="javascript:void(0);" class="btn_type_02" onclick="cancel();">동의하지 않습니다.</a>
				</div>
			</div>
		</div>
		<!--콘텐츠_메인(E)-->

		<jsp:include page="../inc/2020/IncFooter.jsp"/>
		
	</div>
	<!--WRAP(E)-->
</body>
</html>