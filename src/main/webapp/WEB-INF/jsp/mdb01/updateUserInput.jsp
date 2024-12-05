<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
	//생산정보 수정
	function updateUserData($frm){
		if(!confirm("수정 하시겠습니까?")) return false;
		
		/* if(!handPhoneChk($frm.find("input[name=mob]").val())){
			alert("잘못된 형식의 휴대폰번호입니다.");
			$frm.find("input[name=mob]").focus();
			return false;
		} */
		
		$.ajax({
	          type : 'post',
	          url : "/mntr/mdb01/UserUpdateProc.json",
	          data : $frm.serialize(),
	          success : function(res){               
	        	  //console.log(res);
		    	   if(res.error){
	                   alert(res.error.message);
	               }else{
	            	   alert(res.result.message);
	            	   
	            	   if(res.result.stat == "2"){
	            		   $("#manageDiv").html(defaultHtml); 
		            	   grid_ajax(1);   
	            	   }
	            	   
	               }
	          },
		});
		
		return false;
	}
</script>


<div class="selectWrap mt10">
	<form id="userFrm" name="userFrm" method="post" onsubmit="return updateUserData($(this));">
		<div style="margin-bottom: 10px;">
			<ul class="titList">
				<li class="th">아이디 : </li>
				<li class="td">
					<label class="blind" for="userId">아이디 입력</label>
					<input type="text" class="AXInput" name="userId" id="userId"  value="${detail.USER_ID }" readonly="readonly">
				</li>
				<li class="th">이름 : </li>
				<li class="td">
					<label class="blind" for="userNm">이름 입력</label>
					<input type="text" class="AXInput" name="userNm" id="userNm" value="${detail.USER_NM }" required="required">
				</li>
				<li class="th">비밀번호 : </li>
				<li class="td">
					<label class="blind" for="userPasswd">비밀번호 입력</label>
					<input type="password" class="AXInput" name="userPasswd" id="userPasswd" value="${detail.USER_PASSWD }" autocomplete="off" required="required">
				</li>
				<li class="th">생산/소비 선택 : </li>
				<li class="td">
					<label class="blind" for="monitorType">생산/소비 선택</label>
					<select id="monitorType" name="monitorType" id="monitorType" class="titSelect2">
						<option value="P" <c:if test="${detail.MONITOR_TYPE eq 'P' }">selected="selected"</c:if>>생산</option>
						<option value="C" <c:if test="${detail.MONITOR_TYPE eq 'C' }">selected="selected"</c:if>>소비</option>
						<option value="A" <c:if test="${detail.MONITOR_TYPE eq 'A' }">selected="selected"</c:if>>공통</option>
					</select>
				</li>
				<li class="th">사용여부 선택 : </li>
				<li class="td">
					<label class="blind" for="useYn">생산/소비 선택</label>
					<select id="useYn" name="useYn" class="titSelect2">
						<option value="Y" <c:if test="${detail.USE_YN eq 'Y' }">selected="selected"</c:if>>사용</option>
						<option value="N" <c:if test="${detail.USE_YN eq 'N' }">selected="selected"</c:if>>미사용</option>
					</select>
				</li>
			</ul>
		</div>
		<div style="margin-bottom: 10px;">
			<ul class="titList2">
				<li class="th">법인코드 :</li>
				<li class="td">
					<label class="blind" for="compCode">법인코드 입력</label>
					<input type="text" class="AXInput noKorean" name="compCode" id="compCode" value="${detail.COMP_CODE }" required="required">
				</li>
				<li class="th">휴대폰번호 입력 : </li>
				<li class="td">
					<label class="blind" for="mob">휴대폰번호 입력</label>
					<input type="text" class="AXInput onlyNum" name="mob" id="mob" value="${detail.MOB }"  placeholder="'-' 을 제외한 번호">
				</li>
				<li class="th">은행 및 계좌번호 입력 : </li>
				<li class="td">
					<label class="blind" for="bankNum">은행 및 계좌번호 입력</label>
					<input type="text" class="AXInput" name="bankNum" id="bankNum" value="${detail.BANK_NUM }" >
				</li>
				<li class="th">은행 및 계좌번호 입력 : </li>
				<li class="td">
					<label class="blind" for="bankCode">은행 및 계좌번호 입력</label>
					<input type="text" class="AXInput" name="bankCode" id="bankCode" value="${detail.BANK_CODE }" >
				</li>
			</ul>
			<div class="btnWrap">
				<button type="submit" id="btnType" class="ma_add_2">수정하기</button>
				<button type="button" onclick="defaultFrm();" class="ma_re_2">초기화</button>
			</div>
		</div>
	</form>
</div>
