/*
 *   2017-06-28
 *   김민주 Form Validation Chkeck 용 JS
 */




$( document ).ready(function() {
	
	/* $("body").on('change focusin focusout hover keydown keypress keyup', ".injectAble", function(){
		var exp = /delete|update|insert|select|<script>|<script|<|>|javascript|vbscript|expression|--/gi;
		removeUnableTxt($(this),exp);
	});*/
	
	// 비밀번호 체크
	$("body").on('blur',".pwAble",function(){
		var exp = /[^a-zA-Z0-9!#\$\(\)\*,.\/:@\[\]\^_`\{\|\}~]/gi;
		removeUnableAllTxt($(this),exp);
	});
    
	$("body").on('blur',".noKorean",function(){
		var exp = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/gi;
		removeUnableAllTxt($(this),exp);
	});
	
	$("body").on('blur',".emailChk",function(){
		unableEmail($(this));
	});
	
	$("body").on('blur',".phoneChk",function(){
		var exp = /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/;
		removeUnableAllTxt($(this),exp);
	});
	
	
    // 숫자만
    $("body").on("keydown",".onlyNum",function(){
    	 onlyNumber(event);
	});
    $("body").on("focusout keyup",".onlyNum",function(){
    	removeChar(event);
	});
   
    
});

// 텍스트 해당부분 제거(실시간)
function removeUnableTxt(p_obj, p_regexp){
	var expAbleText = p_regexp;
	var oriTxt = p_obj.val();
	var returnTxt;
	returnTxt = oriTxt.replace(expAbleText,"");
	if (returnTxt != oriTxt){
		p_obj.val(returnTxt);
	}
}

// 이메일 체크 및 경고
function unableEmail(p_obj){
	var $tempEl = p_obj.parents(".form-group");
	var oriTxt = p_obj.val();
	if(!emailChk(oriTxt)){
		if(oriTxt == ""){
			// 값 없을때
		}else{
			alert("잘못된 형식의 이메일주소 입니다.");
		}	
	}else{
		// 정상 값
	}
}


// 테스트 전체 삭제 및 경고(form-group 클래스가 부모에 있을떄)
function removeUnableAllTxt(p_obj, p_regexp){
	var expAbleText = p_regexp;
	var oriTxt = p_obj.val();
	var returnTxt;
	returnTxt = oriTxt.replace(expAbleText,"");
	
	if (returnTxt != oriTxt){
		alert("사용 불가는한 문자가 있습니다.");
		p_obj.val("");
	}else{
		if(oriTxt == ""){
			// 값 없을때
		}else{
			// 정상 값
		}
	}
}


// inpu null 체크
function nullCheack($obj, msg){
	if ($obj === undefined || $obj == null) return false; 
	if($obj.val() == "" ){
		alert(msg);
		$obj.focus();
	}
}



/*/****************************************************************************************
 * 숫자만 입력 tap 키 허용
 * 필요한 input 에 클래스 .onlyNum 만  추가하면됨
 *****************************************************************************************/

function onlyNumber(event){
    event = event || window.event;
    var keyID = (event.which) ? event.which : event.keyCode;
    if ( (keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 || keyID == 9  )
        return;
    else
        return false;
}
function removeChar(event) {
    event = event || window.event;
    var keyID = (event.which) ? event.which : event.keyCode;
    if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 || keyID == 9  )
        return;
    else
        event.target.value = event.target.value.replace(/[^0-9]/g, "");
}

/*/****************************************************************************************
 * 숫자만 입력 tap 키 허용 종료
 *****************************************************************************************/



/***************************************************
 * 이메일체크
 * 
 ****************************************************/
function emailChk(email){
	var regEmailExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i; 
	if(!regEmailExp.test(email)){
		return false;
	}
	
	return true;
}

/***************************************************
 * 휴대전화번호체크
 * 
 ****************************************************/
/**
 * 전화번호형식으로 처리 
 * - num : '-' 문자가 들어있지않은 숫자로된 전화번호
 * - type : 0을 보내면 가운데자리를 숨겨준다 (가끔보면 필요한 사람 있더라)
 */
function phoneFomatter(num,type){
    
    var formatNum = '';
    
    if(num.length==11){
        if(type==0){
            formatNum = num.replace(/(\d{3})(\d{4})(\d{4})/, '$1-****-$3');
        }else{
            formatNum = num.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
        }
    }else if(num.length==8){
        formatNum = num.replace(/(\d{4})(\d{4})/, '$1-$2');
    }else{
        if(num.indexOf('02')==0){
            if(type==0){
                formatNum = num.replace(/(\d{2})(\d{4})(\d{4})/, '$1-****-$3');
            }else{
                formatNum = num.replace(/(\d{2})(\d{4})(\d{4})/, '$1-$2-$3');
            }
        }else{
            if(type==0){
                formatNum = num.replace(/(\d{3})(\d{3})(\d{4})/, '$1-***-$3');
            }else{
                formatNum = num.replace(/(\d{3})(\d{3})(\d{4})/, '$1-$2-$3');
            }
        }
    }
    return formatNum;
    
}

// 하이픈 없는거
function handPhoneChk(phone){
	var regHPhoneExp = /[01](0|1|6|7|8|9)(\d{4}|\d{3})\d{4}$/g;
	if(!regHPhoneExp.test(phone)){
		return false;
	}
	return true;
}
// 하이픈 있는거
function handPhoneChk2(phone){
	var regHPhoneExp = /[01](0|1|6|7|8|9)[-](\d{4}|\d{3})[-]\d{4}$/g;
	if(!regHPhoneExp.test(phone)){
		return false;
	}
	return true;
}


