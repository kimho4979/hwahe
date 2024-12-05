<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
    <%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%   
   if (request.getParameter("REG_DATE")==null){
    request.setAttribute("pageTitle", "회원 등록"); 
    
  }
  else{
    request.setAttribute("pageTitle", "회원 수정");
   
    
  }   
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1, maximum-scale=1.0, minimum-scale=1" />
<title>재배동향 입력창 </title>
  <!-- @@@@@@@@@@@@@@@@@@@@@@ css begin @@@@@@@@@@@@@@@@@@@@@@ -->
 <link rel="stylesheet" type="text/css" href="<c:url value='/rMateChart/rMateChartH5/Assets/Css/rMateChartH5.css' />"/>   
 <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/axicon/axicon.min.css' />" />
 <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/arongi/AXJ.min.css' />" />
 <link rel="stylesheet" type="text/css" href="<c:url value='/css/hw/n_ma.css' />" />
 <link rel="stylesheet" type="text/css" href="<c:url value='/css/hw/n_common.css' />" />
  <!-- @@@@@@@@@@@@@@@@@@@@@@ css end   @@@@@@@@@@@@@@@@@@@@@@ --> 

  <!-- @@@@@@@@@@@@@@@@@@@@@@ css end   @@@@@@@@@@@@@@@@@@@@@@ --> 
  
  <script type="text/javascript" src="<c:url value='/axisj/jquery/jquery.min.js' />"></script>
  <script type="text/javascript" src="<c:url value='/axisj/dist/AXJ.min.js' />"></script>
  <script type="text/javascript" src="<c:url value='/axisj/lib/AXUpload5.js' />"></script>
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
  
   <style type="text/css">
        .modalProgramTitle{
            height:49px;line-height:49px;
            color:#282828;font-size:14px;font-weight:bold;
            padding-left:15px;
            border-bottom:1px solid #ccc;
        }
        .modalButtonBox{
            padding:10px;border-top:1px solid #ccc;
        }
    </style>  
     <script type="text/javascript">
     var myProgress = new AXProgress();      
    var myModal = new AXModal();
	var myUpload = new AXUpload5();

    var fnObj = {
        pageStart: function(){
        	// this.bindEvent();
        	//fnObj.upload.init();
        	
        	$("input[name=userType]").change(function() {
    			var radioValue = $(this).val();
    			if (radioValue == "M") {
    				$("#compDiv1").show();
    				$("#compDiv2").hide();
    				$("#remarkDiv1").show();
    				$("#remarkDiv2").hide();
    				
    			} else if (radioValue == "A") {
    				$("#compDiv2").show();
    				$("#compDiv1").hide();
    				$("#remarkDiv2").show();
    				$("#remarkDiv1").hide();
    				
    			} else if (radioValue == "F") {
    				$("#compDiv2").show();
    				$("#compDiv1").hide();
    				$("#remarkDiv2").show();
    				$("#remarkDiv1").hide();
    			}
    		});
        	
        	 myModal.setConfig({
                 windowID: "myModalCT", width: 600,
                 mediaQuery: {
                     mx: {min: 0, max: 600}, dx: {min: 600}
                 },
                 displayLoading: true,
                 scrollLock: true,
                 onclose: function () {
                     //toast.push("모달 close");
                 }
             });
	
      		
			
        },

        form: {			
			submit: function(){
				var usrId = $("#userId").val();
				if(usrId==null || usrId==""){
					alert("아이디는 필수입력입니다.");
					 $("#userId").focus();
					 return;
				}
				var dupCheck = $("#dupCheck").val();
				if(dupCheck!="OK"){
					alert("아이디중복체크를 해주십시오");
					$("#ax_btn_001").focus();
					return;
				}
				
				var usrType = $(':radio[name="userType"]:checked').val();
				
				if(usrType==null || usrType==""){
					alert("유저구분을 선택하세요");
					return;
				}
				
				if(usrType=="M"){
					var compCode = $("#compCode").val();
					if(compCode==null || compCode==""){
						alert("출하코드는 필수입력입니다.");
						$("#compCode").focus();
						return;
					}
					
					var sanCode = $("#remark2").val();
					if(sanCode==null || sanCode==""){
						alert("산지코드는 필수입력입니다.");
						$("#ax_btn_002").focus();
						return;
					}
					
				}else{
					var compCode =$("select[name=compCode1]").val();
					if(compCode==null || compCode==""){
						alert("도매시장코드는 필수입력입니다.")
						$("select[name=compCode1]").focus();
						return;
					}
				}
				
				
				
				
				var frm = document["send-form"];
				if(confirm("저장하시겠습니까?")==true){				
				$.ajax({
			           type : "POST",
			           url : "/admin/saveInsertUserProc.json",
			           data : $(frm).serialize(),
			           dataType : '',   	           
			           success : function(res){	
			        	   parent.myModal.close();
			           },
			       });   
				}else{
					return;
				}
				//dialog.push( $(frm).serialize() );
				return false;
			},
		},
		checkedUserId:function(){
			 var usrId =$("#userId").val();
			 if(usrId==null || usrId==""){
				 alert("아이디를 입력하세요");
				 $("#userId").focus();
				 return;
			 }
			 console.log(usrId);
			 $.ajax({
		           type : "GET",
		           url : "/admin/checkedUserId.json",
		           data : "userId="+usrId,
		           dataType : '',   	           
		           success : function(res){	
		        	  console.log(res);
		        	  if(res.dupCheck=="OK"){
		        		  alert(res.msg); 
		        		  $("#dupCheck").val(res.dupCheck);
		        	  }else{
		        		  alert(res.msg); 
		        		  $("#userId").focus();
		        		  $("#dupCheck").val(res.dupCheck);
		        	  }
		           },
		       });   
			
			
			
			
        },
        
        sanCdopen: function(){
            var pars = {};
            myModal.open({
                url:"/admin/adminSearchSanCdPopup.do",
                pars:'',
                top:0, width:400,
                closeByEscKey:true
            });
        },
        close: function(){
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
    
    jQuery(document).ready(fnObj.pageStart);  
    </script>
    
</head>

<body>
  	
 

<article>
<div class="wrap">


<div class="ma_content"><!--컨텐츠 내용들어가는곳 시작-->
	
<div>
<h4 class="hw_h3_ma_01" >${pageTitle}</h4> 

</div>

<form name="send-form" onsubmit="return false;">
<input type="hidden" id="dupCheck" name="dupCheck" value=""/>
<div class="hw_clear"></div>




<p class="hw_green"></p>
	

</div>

<div class="hw_clear"></div>
<h4 class="ma_title">회원아이디</h4> <p class="hw_green"></p>
<div class="hw_clear"></div>
<input type="text" id="userId" name="userId"  class="AXInput W100"/><button class="AXButton" type="button" id="ax_btn_001" onclick="fnObj.checkedUserId();">중복체크</button>
<div class="hw_clear"></div>	
<h4 class="ma_title">회원구분</h4> <p class="hw_green"></p>
<div class="hw_clear"></div>	
<input type="radio" name="userType" id="userType" value="A" />관리자
<input type="radio" name="userType" id="userType" value="M"  checked="checked"/>모니터요원
<input type="radio" name="userType" id="userType" value="F" />자료전송관리자
<div class="hw_clear"></div>
<div id="compDiv1">	
<h4 class="ma_title">출하자코드</h4> <p class="hw_green"></p>
<div class="hw_clear"></div>
<input type="text" id="compCode" name="compCode"  class="AXInput W100"/>	
</div>
<div id="compDiv2" style="display:none;">
<h4 class="ma_title">도매시장코드</h4> <p class="hw_green"></p>
<div class="hw_clear"></div>
<select name="compCode1" class="AXSelect" id="compCode1">
<option value="">선택하세요</option>
<option value="000000001">aT화훼공판장(양재동)</option>
<option value="108212335">광주원예농협(풍암)</option>
<option value="068207466">부산경남화훼농협(강동동)</option>
<option value="508500020">부산화훼공판장(엄궁동)</option>
<option value="848200087">한국화훼농협(음성)</option>
<option value="288202296">한국화훼농협(과천)</option>
<option value="999999999">기타</option>
<option value="000000100">경부선</option>
<option value="000000200">호남선</option>
<option value="000000300">남대문</option>
</select>
</div>
<div class="hw_clear"></div>	
<h4 class="ma_title">사용여부</h4> <p class="hw_green"></p>
<div class="hw_clear"></div>
<select name="useYn" class="AXSelect" id="useYn">
		<option value="">-- 선택하세요 --</option>
		<option value="N">미사용</option>
		<option value="Y" selected="selected">사용</option>
	</select>
<div class="hw_clear"></div>

<div id="remarkDiv1">
<h4 class="ma_title">산지코드</h4> <p class="hw_green"></p>
<div class="hw_clear"></div>
 <input type="text" id="remark2" name="remark2"  class="AXInput W100" readonly="true"/><button class="AXButton" type="button" id="ax_btn_002" onclick="fnObj.sanCdopen();">찾기</button>
</div>
<div class="hw_clear"></div>
<div id="remarkDiv2" style="display:none;">
<h4 class="ma_title">비고</h4> <p class="hw_green"></p>
<div class="hw_clear"></div>
<textarea name="remark" id="remark" class="AXTextarea" style="box-shadow:inset 0px 0px 3px #ccc;width:100%;height:60px; margin-top:10px; ime-mode:active;box-sizing: border-box;" title="내용">${CONTENT}</textarea>
</div>


<div class="hw_clear"></div>	     
<div><input style="${pageopen}"id="add" name="add" class="ma_add_01"  type="button" value="등록하기" onclick="fnObj.form.submit();" /></div>

  
<!-- <button class="AXButton" type="button" onclick="fnObj.form.submit();">저장하기</button> -->

</form>
</div>
</div><!--wrap 끝-->
</article>
</body>
</html>

