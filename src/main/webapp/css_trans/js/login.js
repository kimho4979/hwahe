var ROOT_TMP = "<c:url value='/' />" ;		// Client 에서 ContextRoot 활용 


function fnLogOut(){

	if(!confirm("로그아웃 하시겠습니까?")) return;
							
	$.ajax({
		  url:"/login/logout.json"
		, dataType: 'json'
		, success: function(res) {
//			alert("dataFromServer:" + dataFromServer);
			
			var result = res.result;
			var returnCode = result.code;

			if(returnCode == "SESSION_FINISH") {
				
				//alert(MsgTop.getMsgbyIndex(33)); // "Saved."
				alert("로그아웃 되었습니다.");
				window.location.href= '/login/loginForm.do';
			}
//			else {
//				alert("Fail to action.\n===========================\n" + result.return);
//			}

		},

		error : function() { 
//			alert(dataFromServer);
			alert("FAIL TO CALL SEND AJAX DATA");
		}
	});
		
}


function fnLogIn(){
	window.location.href= ROOT_TMP + 'login/loginForm.do?reqUri=/main.do';
}
