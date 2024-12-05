<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>


<!DOCTYPE html>
<html lang="ko">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	  <title>화훼유통정보시스템 전송시스템::: </title>
	  <!-- @@@@@@@@@@@@@@@@@@@@@@ css begin @@@@@@@@@@@@@@@@@@@@@@ -->
	    <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/axicon/axicon.min.css' />" />
	     <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/cocker/cmn/admin.css' />" />
	    <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/cocker/AXJ.min.css' />" id="axu-theme-axisj" />
	    <link rel="stylesheet" type="text/css" href="<c:url value='/css_trans/css/sub.css' />" />
	   <link rel="stylesheet" type="text/css" href="<c:url value='/css_trans/common.css' />" />
	   <link rel="stylesheet" type="text/css" href="<c:url value='/css_trans/jquery-ui-1.9.2.css' />" />
	<!-- @@@@@@@@@@@@@@@@@@@@@@ css end @@@@@@@@@@@@@@@@@@@@@@ -->
	      
	<!-- @@@@@@@@@@@@@@@@@@@@@@ javascript START @@@@@@@@@@@@@@@@@@@@@@ --> 
	 <script type="text/javascript" src="<c:url value='/axisj/jquery/jquery.min.js' />"></script>
	 <script type="text/javascript" src="<c:url value='/js/jquery-ui.min.js' />" ></script>
	  <script type="text/javascript" src="<c:url value='/js/mobile/common/jquery.form.js' />"></script>
	  <script type="text/javascript" src="<c:url value='/axisj/dist/AXJ.min.js' />"></script>
	  <script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/ax5-polyfill.js' />"></script>
	  <script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/axjApp.js' />"></script>
	  <script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/base.js' />"></script>
	  <script type="text/javascript" src="<c:url value='/js/login.js'/>"></script>	
	  
	       
	       
	 <!-- @@@@@@@@@@@@@@@@@@@@@@ javascript END @@@@@@@@@@@@@@@@@@@@@@ --> 
	  
	</head>
	<body>
<header><!--헤더 시작-->
</header>


<article> 

	<div class="wrap">
	
		<div class="logo"><a href="/tran/main.do"><img src="<c:url value='/images/logo.png'/>"/></a></div>
		<div style="float:right;margin-right:30px;"><a href="javascript:fnLogOut();"><i class="axi axi-power-off"></i> 로그아웃</a></div>		
		
		<div class="content">
		<div class="title"><i class="axi axi-upload"></i>&nbsp;&nbsp;정산자료 전송관리 </div>
		<br/>
		<br/>
		
		<div>
			<div class="a_jungsan">
				
				<form id="form-file" name="form-file" method="post" enctype="multipart/form-data">    	
					정산자료 :&nbsp;&nbsp;<input type="file" name="file1" id="file1" maxlength="200" class="AXInput" value="" style="height:19px;" /> <button type="button" class="AXButton" onclick="fnObj.dataForm.save();">저장</button>
				</form>
			</div>
			<div class="a_jungsan_02" id="tWord1"> - 판매일자 : </div>
			<div class="a_jungsan_03" id="tWord2"> - Insert 시간 :</div>
			<div class="a_jungsan_04" id="tWord3"> - 전송건수 :</div>
		</div>
		<div class="hw_clear"></div>
		<br/>
		<br/>

		
		<div>
			<div class="b_jungsan_02" id="tWord4"> - 성공건수 : </div>
			<div class="b_jungsan_03" id="tWord5"> - 물량 :</div>
			<div class="b_jungsan_04" id="tWord6"> - 금액 :</div>
			<div class="c_jungsan_02" id="tWord7"> - 실패건수 : </div>
			<div class="c_jungsan_03" id="tWord8"> - 물량 :</div>
			<div class="c_jungsan_04" id="tWord9"> - 금액 :</div>
		</div>
		<div class="hw_clear"></div>
		<br/>
		<br/>
		<br/>
		<br/>
		<h3>정산자료 에러리스트   </h3>
		<div class="a_table">
			<div id="AXGridTarget" style="height:400px;"></div>
		</div>		
		
		
		 </div>
		
		
	</div>
		
	<div id="dialog-message" title="전송처리" >
		 <p>전송처리 진행 중입니다. 잠시만 기다려주세요.</p> 
	</div>	
</article>


<footer>
<div id="footer">
<div class="footer_box">
<div class="logo_g"><a href=""><img src="<c:url value='/images/logo_g.jpg' />" alt="aT화훼유통정보시스템 로고"/></a></div>
<div class="adress">
<p>[58217] 서울특별시 서초구 강남대로 27 화훼공판장    전화 : 02-579-8100    I   팩스 : 02-578-8671<p>
<p>&nbsp;COPYRIGHT @2016 by Korea Agro-Fisheries & Food Trade Corporation ALL RIGHTS RESERVED.</p>
</div>
</div>

</footer>
</body>
</html>
<script type="text/javascript">
var fnObj = {
	 pageStart: function(){
		 
		 fnObj.grid.bind();	
	 },
	 
	 dataForm: {
	      target: $(document["myform"]),
	       validate_target: new AXValidator(),
	        bind: function(){
	            this.validate_target.setConfig({
	              targetFormName : "myform"
	            });
	          },
	          fileSaveEnd: function(){
	              parent.toast.push("저장되었습니다.");
	          },
	          init: function(){
	        	  
	          },
	          save: function(){
	              var validateResult = this.validate_target.validate();
	              if (!validateResult) {
	                var msg = this.validate_target.getErrorMessage();
	                AXUtil.alert(msg);
	                this.validate_target.getErrorElement().focus();
	                $("#dialog-message").dialog("close");
	                return false;
	              }
	              
	              var searchParam ="&searchSuccessYn=N";
	              
	             
	               var frm = document["form-file"];
	               var target_name = "submitwin";
	               
	               frm.target = target_name;
	               frm.action = "/calculate/saveFileProc.json";
	               if(!frm.file1.value){
	            	   
	            	  alert("파일을 선택하세요");
	            	  return false;
	               }
	               
	               console.log(navigator.userAgent);
	               
	               if(frm.file1.value ){
	            	   
	            	   if (/MSIE/.test(navigator.userAgent) || navigator.userAgent.indexOf("rv:11.0") >= 0) 
	      	         	{
	            		   goSubmit();
	            		}else{
							
		                   // iframe 생성
		                   var iframe = $('<iframe src="javascript:false;" name="' + target_name + '" style="display:none;"></iframe>');
		                   $(document.body).append(iframe);
						   
		                   $("#dialog-message").dialog("open");
		                   // onload 이벤트 핸들러
		                   // action에서 파일을 받아 처리한 결과값을 텍스트로 출력한다고 가정하고 iframe의 내부 데이터를 결과값으로 callback 호출
		                   iframe.load(function(){
		                     var doc = this.contentWindow ? this.contentWindow.document : (this.contentDocument ? this.contentDocument : this.document);
		                     var root = doc.documentElement ? doc.documentElement : doc.body;
		                     var result = root.textContent ? root.textContent : root.innerText;
		                     var res = result.object();
	
		                     if(res.error){
		                       axf.alert(res.error);
		                       $("#dialog-message").dialog("close");
		                       loading_mask.close();
		                     }else{
		                    	 
		                       console.log(res);
			                   	if(res!=null){
		                       		if(res.saleDate){
		                       			
		                       			document.getElementById("tWord1").innerHTML= "판매일자 :"+res.saleDate ;
		                       			 
		                       			searchParam = searchParam+"&searchSaleDate ="+res.saleDate;
		                       		}
									if(res.cmpCd){
		                       			
										searchParam = searchParam+"&searchCmpCd="+res.cmpCd;
		                       		}
									if(res.orginFileName){
										searchParam = searchParam+"&orginFileName="+res.orginFileName;	
									}
		                       		
		                       		
		                       		if(res.resultTime){
		                       			document.getElementById("tWord2").innerHTML= "Insert 시간 :"+res.resultTime.money() ;
		                       		}
		                       		if(res.totCnt){
		                       			document.getElementById("tWord3").innerHTML= " 전송건수 :"+res.totCnt.money()+"건" ;
		                       		}
		                       		if(res.yCNT){
		                       			document.getElementById("tWord4").innerHTML= " 성공건수 :"+res.yCNT.money()+"건";
		                       		}
		                       		if(res.yQTY){
		                       			document.getElementById("tWord5").innerHTML= " 물량 :"+res.yQTY.money() ;
		                       		}
		                       		if(res.yAMT){
		                       			document.getElementById("tWord6").innerHTML= " 금액 :"+res.yAMT.money() +"원";
		                       		}
		                       		if(res.nCNT){
		                       			document.getElementById("tWord7").innerHTML= " 실패건수 :"+res.nCNT.money()+"건"; 
		                       			}
		                       		if(res.nQTY){
		                       			document.getElementById("tWord8").innerHTML= " 물량 :"+res.nQTY.money() ;
		                       		}
		                       		if(res.yAMT){
		                       			document.getElementById("tWord9").innerHTML= " 금액 :"+res.nAMT.money()+"원";
		                       		}
		                       	
		                       		if (confirm("정산자료 현황 페이지로 이동하시겠습니까?")){
						                  $("#dialog-message").html("<p> 전송 처리가 완료되었습니다. 페이지 로딩 중입니다. </p> <br> <p> 잠시만기다려 주세요. </p>");
						                  document.location.href = "/calculate/calculateListForm.do";
		                       		}else{
		                       			$("#dialog-message").dialog("close");
		                       		}

		                       		
		                       	}
		                     
		                       
		                        
		                       fnObj.dataForm.fileSaveEnd();
		                       //parent.myModal.close();
		                     }
		                     iframe.remove();
		                   });
	
		                   loading_mask.open();
		                   frm.submit();
	               			}
			             }else{
			               fnObj.dataForm.fileSaveEnd();
			             }
		               
		                  
		                  fnObj.grid.setPage(1,searchParam);
		                  frm.file1.value="";
		                  loading_mask.close(300);	
						
		                 
	                  
	              
	          } 
	          
	 },
	 grid: {
         target: new AXGrid(),
         pageNo: 1,
         bind: function () {
             window.myGrid = fnObj.grid.target;

             var getColGroup = function () {
                 return [
                         //{key:"index", label:"선택", width:"35", align:"center", formatter:"checkbox"}, 
                         {key: "saleDate", label: "일자", width: "100",align: "center",},
                         {key: "cmpCd", label: "법인", width: "100",align: "center",},
                         {key: "seq", label: "원표번호", width: "80" ,align: "center",},
                         {key: "no1", label: "일련번호", width: "100",align: "center",},
                         {key: "no2", label: "경매구분", width: "60",align: "center",},
                         {key: "totQty", label: "실패물량", width: "80", align: "right", formatter: "money"},
                         {key: "totAmt", label: "실패금액", width: "100", align: "right", formatter: "money"},
                         {key: "failMessage", label: "실패원인", width: "100",align: "center",},
                         {
                             key: "btns", label: "내용보기", width: "100", align: "center", formatter: function () {
                             return '<button type="button" name="delete" onclick=" fnObj.grid.goTost('+ this.index + ');"><i class="axi axi-folder-open2"></i>내용보기</button>';
                         	}
                         }
                        
                        
                     
                 ];
             };

             myGrid.setConfig({
                 targetID: "AXGridTarget",
                 sort: true, //정렬을 원하지 않을 경우 (tip
                 colHeadTool: true, // column tool use
                 fitToWidth: true, // 너비에 자동 맞춤
                 colGroup: getColGroup(),
                 colHeadAlign: "center", // 헤드의 기본 정렬 값. colHeadAlign 을 지정하면 colGroup 에서 정의한 정렬이 무시되고 colHeadAlign : false 이거나 없으면 colGroup 에서 정의한 속성이 적용됩니다.
                 body: {
                     onclick: function () {
                        // toast.push(Object.toJSON({"event": "click", "index": this.index, "r": this.r, "c": this.c, "item": this.item}));
                         // this.list, this.page
                     },
                     /* ondblclick 선언하면 onclick 이벤트가 0.25 초 지연 발생 됩니다. 주의 하시기 바람니다. */
                     ondblclick: function () {
                         //toast.push(Object.toJSON({"event": "dblclick", "index": this.index, "r": this.r, "c": this.c, "item": this.item}));
                         // this.list, this.page
                     },
                     addClass: function () {
                         return (this.index % 2 == 0 ? "gray" : "white"); // red, green, blue, yellow, white, gray
                     }
                 },
                 page: {
                     display: false,
                     paging: false
                 }
             });

            
            // fnObj.grid.setPage(fnObj.grid.pageNo);

         },
         setPage: function(pageNo, searchParams) {
             var _this = this;
             _this.pageNo = pageNo;
             app.ajax({
                 type: "GET",
                 url: "/trans/calcLogDetailList.json",
                 data: "pageNumber=" + (pageNo-1) + "&pageSize=50&" + (searchParams)
             }, function(res){
            	 
            	        console.log(res);
                 if(res.error){
                     alert(res.error.message);
                 }
                 else
                 {
                	 if(res.list){
                     var gridData = {
                         list: res.list,
                         page:{
                             pageNo: res.page.currentPage.number()+1,
                             pageSize: res.page.pageSize,
                             pageCount: res.page.totalPages,
                             listCount: res.page.totalElements
                         }
                     };
                    
                     _this.target.setData(gridData);
                	 }
                 }
             });
         },
         deleteItem: function (index) {
             $.Event(event).stopPropagation(); // 버튼클릭 이벤트가 row click 이벤트를 발생시키지 않도록 합니다.
             var item = myGrid.list[index];
             toast.push('deleteItem: ' + $.param(item).dec());
         },
         goTost: function (index) {
             $.Event(event).stopPropagation(); // 버튼클릭 이벤트가 row click 이벤트를 발생시키지 않도록 합니다.
             var item = myGrid.list[index];
              var reText = item.recordText;
              //console.log(reText);
             toast.push(reText);
         },
         
         getExcel: function (type) {
             var obj = myGrid.getExcelFormat(type);
             trace(obj);
             $("#printout").html(Object.toJSON(obj));
         },
         getSelectedItem: function () {
             trace(this.target.getSelectedItem());
             toast.push('콘솔창에 데이터를 출력하였습니다.');
         }
     
         
        
        },
	 
	 __end: {}		
};

axdom(document.body).ready(function() {
  fnObj.pageStart();  
  
});

function goSubmit(){
	
	$("#dialog-message").dialog("open");
	
	 var frm = $('#form-file');
	 var searchParam ="&searchSuccessYn=N";
      var stringData = frm.serialize();
      frm.ajaxSubmit({
          type: 'post',
          url: '/calculate/saveFileProc.json',
          data: stringData,
          success:function(res){
          	console.log(res);
          	if(res.error){
                axf.alert(res.error);
                loading_mask.close();
              }else{
             	 
                console.log(res);
                	if(res!=null){
                		if(res.saleDate){
                			
                			document.getElementById("tWord1").innerHTML= "판매일자 :"+res.saleDate ;
                			 
                			searchParam = searchParam+"&searchSaleDate ="+res.saleDate;
                		}
						if(res.cmpCd){
                			
							searchParam = searchParam+"&searchCmpCd="+res.cmpCd;
                		}
						if(res.orginFileName){
							searchParam = searchParam+"&orginFileName="+res.orginFileName;	
						}
                		
                		
                		if(res.resultTime){
                			document.getElementById("tWord2").innerHTML= "Insert 시간 :"+res.resultTime.money() ;
                		}
                		if(res.totCnt){
                			document.getElementById("tWord3").innerHTML= " 전송건수 :"+res.totCnt.money()+"건" ;
                		}
                		if(res.yCNT){
                			document.getElementById("tWord4").innerHTML= " 성공건수 :"+res.yCNT.money()+"건";
                		}
                		if(res.yQTY){
                			document.getElementById("tWord5").innerHTML= " 물량 :"+res.yQTY.money() ;
                		}
                		if(res.yAMT){
                			document.getElementById("tWord6").innerHTML= " 금액 :"+res.yAMT.money() +"원";
                		}
                		if(res.nCNT){
                			document.getElementById("tWord7").innerHTML= " 실패건수 :"+res.nCNT.money()+"건"; 
                			}
                		if(res.nQTY){
                			document.getElementById("tWord8").innerHTML= " 물량 :"+res.nQTY.money() ;
                		}
                		if(res.yAMT){
                			document.getElementById("tWord9").innerHTML= " 금액 :"+res.nAMT.money()+"원";
                		}
                		
                	}
                
                fnObj.dataForm.fileSaveEnd();
                
                if (confirm("정산자료 현황 페이지로 이동하시겠습니까?")){
	                  $("#dialog-message").html("<p> 전송 처리가 완료되었습니다. 페이지 로딩 중입니다. </p> <br> <p> 잠시만기다려 주세요. </p>");
	                  document.location.href = "/calculate/calculateListForm.do";
         		}else{
         			$("#dialog-message").dialog("close");
         		}

              }
          	
          	
          	
          },
          error : function( error ) {
        	  alert('오류가 발생하였습니다.');
        	  $("#dialog-message").dialog("close");
        	}
      }); // end ajaxSubmit
}

$(document).ready(function(){
		 
	 $( function() {
	        $( "#dialog-message" ).dialog({
	          autoOpen: false,
	          modal: true,
	          closeOnEscape: false,
	          open: function(event, ui) { 
	              $(".ui-dialog-titlebar-close", $(this).parent()).hide(); 
	           }
	        });
	      } );
	
});


</script>
