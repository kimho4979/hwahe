<%@ page import="java.util.*"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j"%>
<%

%>
<ax:layout name="empty.jsp">
    <ax:set name="title" value="회원등록" />
    <ax:set name="page_desc" value="" />
	<ax:div name="contents">
		<ax:row>
			<ax:col size="12">
           

                <ax:custom customid="table">
                    <ax:custom customid="tr">
                      <ax:custom customid="td">
                            <div class="ax-button-group">
                                <div class="left">
                                    <h2><i class="axi axi-table"></i> 사용자등록</h2>
                                </div>
                                <div class="right">
                                  <!--   <button type="button" class="AXButton" id="ax-form-btn-add"><i class="axi axi-plus-circle"></i> 신규</button> -->
                                </div>
                                <div class="ax-clear"></div>
                            </div>

                            <ax:form name="table-form" id="table-form" method="post">
                                <input type="hidden" name="userType" id="userType" value="U" />
                                <input type="hidden" name="useYn" id="useYn" value="Y"/>
                                
                                 <%-- <ax:fields>
                                    <ax:field label="구분" width="220px">
                                        <select name="userType" id="userType" class="AXSelect W150">
                                            <option value="S">슈퍼관리자</option>
                                            <option value="A">관리자</option>
                                            <option value="U">일반 사용자</option>
                                        </select>
                                    </ax:field>
                                </ax:fields> --%>
                                <ax:fields>
                                    <ax:field label="이름" width="220px">
                                        <input type="text" name="userNm" id="userNm" maxlength="15" title="이름" class="av-required AXInput W120" value="" />
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="아이디" width="220px">
                                        <input type="text" name="userCd" id="userCd" maxlength="10" title="아이디" class="av-required AXInput W150" value="" />
                                         <input type="hidden" name="dupCheck" id="dupCheck" value="N">
                                         <button type="button" class="AXButton Red" id="dupBtn">아이디중목체크</button>
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="비밀번호" width="220px">
                                        <input type="password" name="userPs" id="userPs" maxlength="128" class="AXInput W120" value="" autocomplete="off" />
                                    </ax:field>
                                    <ax:field label="비밀번호 확인" width="220px">
                                        <input type="password" name="userPs_chk" id="userPs_chk" maxlength="128" class="AXInput W120" value="" autocomplete="off" />
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="이메일" width="220px">
                                        <input type="text" name="email" id="email" maxlength="50" title="이메일" placeholder="abc@abc.com" class="av-email AXInput W180" value="" />
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="핸드폰번호" width="220px">
                                        <input type="text" name="hpNo" id="hpNo" maxlength="15" placeholder="" class="av-phone AXInput W120" value="" />
                                       		 예)01012345679
                                    </ax:field>
                                </ax:fields>

                               <%--  <ax:fields>
                                    <ax:field label="사용여부" width="220px">
                                        <select name="useYn" id="useYn" class="AXSelect W100">
                                            <option value="Y">사용</option>
                                            <option value="N">사용안함</option>
                                        </select>
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="비고" width="220px">
                                        <input type="text" name="remark" id="remark" maxlength="100" class="AXInput W300" value="" />
                                    </ax:field>
                                </ax:fields>      	 --%>
                             
                            </ax:form>

                        </ax:custom>
                    </ax:custom>
                </ax:custom>
                   <div class="ax-button-group">
            		<div class="right">
            	       	 <button type="button" class="AXButtonLarge Red" id="regBtn"><i class="axi axi-check-circle"></i>등록</button>
			             <button class="AXButtonLarge GREEN" id="canBtn"><i class="axi axi-times-circle"></i>취소</button>
   					</div>
				</div>			                

			</ax:col>
		</ax:row>
	</ax:div>
		<ax:div name="scripts">
		 <script type="text/javascript" src="<c:url value='/plugins/axisj/lib/AXValidator.js'/>"></script>
	    <script type="text/javascript">
	    var fnObj = {
	    		 
	    		 pageStart: function(){
	    			 var _this = this;
	    			 $("#regBtn").bind("click", function(){
	                     setTimeout(function() {
	                         _this.form.save();
	                     }, 500);
	                 });
                     
                     $("#canBtn").bind("click", function(){
	                     location.href="/";
	                 });
                     
                     $("#dupBtn").bind("click", function(){
                    	_this.form.duplicateUserCd();
	                 });
                     
	             },
	            
	             form: {
	            	 target: $(document["table-form"]),
                     validate_target: new AXValidator(),
                     bind: function(){
                         this.validate_target.setConfig({
                             targetFormName : "table-form"
                         });
                         $("#useYn").bindSelect();
                         $("#hpNo").bindPattern({
                             pattern: "phone"
                         });  
                        
                         
                     },
                     duplicateUserCd: function(){
                      var item = app.form.serializeObjectWithIds(this.target);
       	 	           var item2 =app.form.serializeObjectWithIds(this.target, '');
       	 	           
       	 	       if(!item.userCd){
	 	            	  alert("아이디를 입력해 주십시오");
	 	            	 $("#userCd").focus();
	 	            	  return false;
	 	            	  
	 	              }
	 	             var pattern = /^[A-Za-z]{1}[A-Za-z0-9]{3,19}$/;
	 	             if(!pattern.test( $("#userCd").val())){
	 	            	 alert("아이디는 4~20자 영문자 또는 숫자입니다. 첫글자는 영문입니다.");
	 	            	 $("#userCd").focus();
	 	            	 return false;
	 	             }
                    	 
                         app.ajax({
     	 	                type: "GET",
     	 	                url: "/cmn/user/duplicateProc.json",
     	 	                data: item2
     	 	            }, function(res){
     	 	            	
     	 	            	//console.log(res);
     	 	            	
     	 	                if(res.error){
     	 	                    alert(res.error.message);
     	 	                }
     	 	                else
     	 	                {
     	 	                	var dupCheck = res.dupCheck;
     	 	                		
     	 	                	if(dupCheck=='N'){
     	 	                		alert(res.message);
     	 	                		$("#userCd").focus();
     	 	                		
     	 	                	}else{
     	 	                		$("#dupCheck").val("Y");
     	 	                		alert(res.message);
     	 	                		// $("#dupCheck").bindPatternSetText(dupCheck);  
     	 	                		
     	 	                		 
     	 	                	}	
     	 	                		
     	 	                	
     	 	                	
     	 	                	
     	 	                    // 그리드 새로고침
     	 	                  
 						   
     	 	                    //location.href="/"
     	 	                }
     	 	            });
                     },                    
                     save: function(){
    	            	 var validateResult = this.validate_target.validate();
    	 	            if (!validateResult) {
    	 	                var msg = this.validate_target.getErrorMessage();
    	 	                AXUtil.alert(msg);
    	 	                this.validate_target.getErrorElement().focus();
    	 	                return false;
    	 	            }

    	 	            var item = app.form.serializeObjectWithIds(this.target);
    	 	           var item2 =app.form.serializeObjectWithIds(this.target, '');
    	 	            console.log(item);
    	 	               if(!item.userNm){
    	 	            	   alert("이름을 입력해 주십시오");
    	 	            	  $("#userNm").focus();
    	 	            	   return false;
    	 	               }
    	 	              if(!item.userCd){
    	 	            	  alert("아이디를 입력해 주십시오");
    	 	            	 $("#userCd").focus();
    	 	            	  return false;
    	 	            	  
    	 	              }
    	 	             var pattern = /^[A-Za-z]{1}[A-Za-z0-9]{3,19}$/;
    	 	             if(!pattern.test( $("#userCd").val())){
    	 	            	 alert("아이디는 4~20자 영문자 또는 숫자입니다. 첫글자는 영문입니다.");
    	 	            	 $("#userCd").focus();
    	 	            	 return false;
    	 	             }
    	 	             
    	 	             if($("#dupCheck").val()!="Y"){
    	 	            	 alert("아이디 중복체크를 해 주십시오")
    	 	            	 return false;
    	 	             }

    	 	            var pwPattern = /^[a-z0-9_]{4,20}$/; 
    	 	                // 비밀번호가 필요 합니다.
    	 	                if(!item.userPs){
    	 	                    alert("비밀번호를 입력해 주십시오");
    	 	                   $("#userPs").focus();
    	 	                    return false;
    	 	                }
    	 	               if(!pwPattern.test( $("#userPs").val())){
      	 	            	 alert("패스워드는 4~20자 영문자 또는 숫자입니다.");
      	 	            	 $("#userPs").focus();
      	 	            	 return false;
      	 	             	}
    	 	                
    	 	            if(item.userPs) {
    	 	                if(item.userPs != item.userPs_chk) {
    	 	                    alert("비밀번호를 다시 입력해주십시오. 확인 값과 일치하지 않습니다.");
    	 	                   $("#userPs_chk").focus();
    	 	                    return false;
    	 	                }
    	 	            }
    	 	           var emailExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i; 
    	 	           
    	 	           
    	 	          if(!item.email){
    	 	        	 alert("이메일을 입력해 주세요");
	 	                   $("#email").focus();
	 	                    return false;
    	 	          
    	 	          }
    	 	           if(!emailExp.test( $("#email").val())){
   	 	            	 alert("이메일 형식이 올바르지 않습니다. 다시 입력해 주십시오");
   	 	            	 $("#email").focus();
   	 	            	 return false;
   	 	             	}
    	 	         
    	 	          
    	 	         var hpExp = /^\d{2,3}\d{3,4}\d{4}$/;
    	 	         
    	 	        if(!item.hpNo){
    	 	        	  alert("전화번호를 입력해 주십시오");
	 	                   $("#hpNo").focus();
	 	                    return false;
    	 	        }	
     	 	           if(!hpExp.test( $("#hpNo").val())){
    	 	            	 alert("잘못된 전화번호입니다. 숫자만 입력해 주십시오");
    	 	            	 $("#hpNo").focus();
    	 	            	 return false;
    	 	             	}
     	 	         
    	 	          
     	 	           		//console.log($("#userType").val())	
							item2.userType =$("#userType").val();
     	 	           		item2.useYn = $("#useYn").val();

    	 	            app.ajax({
    	 	                type: "GET",
    	 	                url: "/cmn/user/createProc.json",
    	 	                data: item2
    	 	            }, function(res){
    	 	            	
    	 	            	console.log(res);
    	 	            	
    	 	                if(res.error){
    	 	                    alert(res.error.message);
    	 	                }
    	 	                else
    	 	                {
    	 	                	
    	 	                	alert("등록되었습니다.");
    	 	                    // 그리드 새로고침
    	 	                  var result = confirm('메인페이지로 이동하시겠습니까?');
						       if(result){
    	 	                    	location.replace("/");
						       }else{
						    	   
						       }
    	 	                }
    	 	            });
    		            
    	            	 
    	             }
	            
	             },
	           
	             
              
            };
	    
	    
	    
	    </script>
		</ax:div>
	
	</ax:layout>