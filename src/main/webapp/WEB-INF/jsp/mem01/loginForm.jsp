<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j"%>
<ax:layout name="empty.jsp">
    <ax:div name="header">
    </ax:div>
    <ax:div name="contents">
        <ax:row>
            <ax:col size="12" wrap="false">
				  <div class="login-visual"></div>
                <div class="login-vline"></div>
                <div class="login-form">
                    <h1>
                        <small>로그인 해주세요.</small>
                    </h1>
                    <div class="H10"></div>
                    <form name="login-form" method="post" action="/cmn/login/loginProc.do" onsubmit="return fnObj.smsChk();">
                        <div class="ax-input">
                            <input type="text" name="userCd" id="userCd" value="${loginUserCd}" class="AXInput ime-false"
                                   placeholder="id">
                        </div>
                        <div class="ax-input">
                            <input type="password" name="userPs" id="userPs" value="${loginUserPs}" class="AXInput"
                                   placeholder="password" autocomplete="off">
                        </div>

                        <div class="ax-clear"></div>
                        <div class="H10"></div>
                        <input type="hidden"
                               name="${_csrf.parameterName}" value="${_csrf.token}"/>

                        <div class="ax-funcs">
                            <!--
                            <label>
                                <span>&nbsp;아이디 기억하기</span>
                                <input type="text" name="" value="NO" id="AXInputSwitch"
                                       style="width:50px;height:23px;border:0px none;"/>

                            </label>
                            -->
                           <!--  <button type="submit" class="AXButtonLarge Red">&nbsp;&nbsp;로그인&nbsp;&nbsp;</button>&nbsp;
                            <button type="button" class="AXButtonLarge Green">&nbsp;&nbsp;회원가입&nbsp;&nbsp;</button>&nbsp; -->
                        </div>
                        <div class="ax-button-group">
            		<div class="right">
            	       	   <button type="submit" class="AXButtonLarge Red">&nbsp;&nbsp;로그인&nbsp;&nbsp;</button>&nbsp;
                            <button type="button" class="AXButtonLarge Green" id="canBtn">&nbsp;&nbsp;회원가입&nbsp;&nbsp;</button>&nbsp;
   					</div>
				</div>		
                        
                    </form>
                     	 
                </div>
                <div class="ax-clear"></div>
                <div class="icn-stipe">

                </div>
      
            </ax:col>
        </ax:row>
    </ax:div>
    <ax:div name="scripts">
        <script type="text/javascript">
            var fnObj = {
                pageStart: function(){
                	 $("#canBtn").bind("click", function(){
	                     location.href="/mntr/login/loginForm.do";
	                 });
                    
                },
                smsChk: function () {
                    if($("#userCd").val() == ''){
                        alert("아이디를 입력해 주세요.");
                        $("#userCd").focus();
                        return false;
                    }
                    
                    if( $("#userPs").val() == ''){
                    	 alert("비밀번호를 입력해 주세요.");
                         $("#userPs").focus();
                    	return false;
                    }
                    
                   /*  console.log($("#userPs").val());
                    if($("#userCd").val()!='admin' ){
                    	alert("아이디를 바르게 입력해주세요.");
                    	$("#userCd").val('')
                    	$("#userCd").focus();
                    	return false;
                    }
                    
                    if($("#userPs").val()!='1234'){
                    	alert("패스워드를 바르게 입력해주세요.");
                    	$("#userPs").val('');
                    	$("#userPs").focus();
                    	return false;
                    }
                     */
                   
                    

                     
                    return true;
                },
                login: function () {
                	
                }
            };
        </script>
    </ax:div>
</ax:layout>