<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1, maximum-scale=1.0, minimum-scale=1" />
<title>화훼유통정보시스템 모니터요원 입력시스템 </title>
  <!-- @@@@@@@@@@@@@@@@@@@@@@ css begin @@@@@@@@@@@@@@@@@@@@@@ -->
  <link rel="stylesheet" type="text/css" href="<c:url value='/rMateChart/rMateChartH5/Assets/Css/rMateChartH5.css' />"/>   
 <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/axicon/axicon.min.css' />" />
 <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/arongi/AXJ.min.css' />" />
 <link rel="stylesheet" type="text/css" href="<c:url value='/css/hw/ma.css' />" />
 <link rel="stylesheet" type="text/css" href="<c:url value='/css/hw/common.css' />" />
  
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
  <!-- @@@@@@@@@@@@@@@@@@@@@@ css end   @@@@@@@@@@@@@@@@@@@@@@ --> 
  <!-- rMateChartH5 테마 js -->
  <script type="text/javascript" src="<c:url value='/rMateChart/rMateChartH5/Assets/Theme/theme.js' />"></script>
    
  <script type="text/javascript">
var myProgress = new AXProgress();
var myGrid = new AXGrid();
var myModal = new AXModal();
var REG_MONTH="";
var CHUL_NO="0001";
var MONTH_GUBN="";
var STATUS_CD="";
var BIGO="";

 function grid_ajax(){   		     		    	          	 
       $.ajax({
           type : 'get',
           url : "/mntr/maa01/gridList2.json",
           data :  '',
           dataType : '',   	           
           success : function(res){               
               console.log(res.list);
             	 myGrid.setList(res.list);
           },
       });      	    
   };
   function deleteGrid(){   		     		    	          	 
            	    
   } ;

var fnObj = {
    pageStart: function(){
    	
    	grid_ajax();
    	
    	$("#AXInputDate").bindDate({align:"right", valign:"bottom", separator:"/", defaultSelectType:"d", onchange:function(){
            //toast.push(Object.toJSON(this));
        }});
    	
     // $('input[type=radio]').bindChecked();
        myModal.setConfig({
				windowID:"myModalCT", width:1150,
            
				displayLoading:true,
             scrollLock: false,
				onclose: function(){
					//toast.push("저장되었습니다.");	
					grid_ajax();
				}
			}); 

    	 myGrid.setConfig({
    	             targetID : "AXGridTarget",
    	             theme : "AXGrid",
    	             fixedColSeq : '',
    	             fitToWidth:true,
    	             colGroup : [
    	                 {
    	                     key:"no", label:"checkbox", width:"30", align:"center", formatter:"checkbox", 
    	                     disabled:function(){
    	                         return false;
    	                         return (this.index % 2 != 0);
    	                     },
    	                     
    	                     checked:function(){
    	                         return false;
    	                       
    	                         return (this.index % 2 == 0);
    	                     }
    	                 },
    	                 {key:"REG_MONTH", label:"출하예정월", width:"110", align:"center", pk:true},                 
    	                 {key:"MONTH_GUBN", label:"순구분코드", width:"90", align:"center", display:false},
    	                 {key:"JGUBN", label:"순구분", width:"100", align:"center"},
    	                 {key:"CHUL_NO", label:"출하자등록번호", width:"150", align:"center", display:false},
    	 				 {key:"CHUL_NO2", label:"출하코드", width:"80",align:"center" ,formatter:function(){
    						var CHUL_NO = this.item.CHUL_NO;
    						var userId = "${sessionScope.SESSION_USER_ID}"; 
    						
    						if(userId == "admin" || userId == "at99999999"){
    							return CHUL_NO;
    						}else{
    							return "-";
    						}
    					 }},                     	                 
    	                 {key:"ITEM_NAME", label:"품종", width:"100", align:"center"},
    	                 {key:"MARKET_CD", label:"공판장코드", width:"80", display:false},     
    	                 {key:"MARKET_NAME", label:"출하예정지역", width:"150", },     
    	                 {key:"QTY", label:"예정출하량", width:"100", align:"right", formatter:"money"},
    	                 {key:"SIZE_CD", label:"단위코드", width:"100", align:"right", display:false},   
    	                 {key:"SIZE_NAME", label:"단위", width:"60", align:"center"},    	                 
    	                 {key:"BIGO", label:"출하내용", width:"600"},    	                 
    	                 {key:"REG_DATE", label:"등록일자", width:"100"},
    	                 {key:"GUBN", label:"구분자", width:"80"},
    	                 {key:"ITEM_CD", label:"품종", width:"100", align:"center"},
    	             ],
    	             colHeadAlign:"center",
    	            
    	             body : {
    	                 onclick: function(){  
    	                	
    	                	  app.modal.open({
    	                          url:"/maa01/shipmntPrearngeVolm_popup2.do",
    	                          pars:"REG_MONTH=" + this.item.REG_MONTH+"&CHUL_NO="+this.item.CHUL_NO+"&MONTH_GUBN="+this.item.MONTH_GUBN+"&QTY="+this.item.QTY
    	                          +"&MARKET_CD="+this.item.MARKET_CD+"&ITEM_CD="+this.item.ITEM_CD+"&SIZE_NAME="+this.item.SIZE_NAME+"&BIGO="+this.item.BIGO	                                   
    	                      }); 
    	                	    	                	
    	                 },
    	                 ondblclick: function(){
    	                    
    	                 },
    	                
    	                 oncheck: function(){
    	                     
    	                     
    	                 }
    	             },

    	             page:{
    	                 paging:false
    	             },
    	             editor: {
    	                 rows: [
    	                     [
    	                         {
    	                             colSeq:0, align:"center", valign:"middle", 
    	                             formatter: function(){
    	                                 return this.item.no;
    	                             }
    	                         },
    	                         {
    	                             colSeq:1, align:"center", valign:"middle", form:{type:"readonly", value:"itemValue"}
    	                         },
    	                         {colSeq:2, align:"left", valign:"top",
    	                             form:{
    	                                 type:"text", value:function(){
    	                                     return this.value.dec();
    	                                 }
    	                                 , validate:function(){
    	                                     return true;
    	                                    
    	                                 }
    	                             }
    	                             , AXBind:{type:"selector", config:{
    	                                 appendable:true,
    	                                 ajaxUrl:"selectorData.php",
    	                                 ajaxPars:"",
    	                                 onChange:function(){
    	                                   
    	                                     if(this.selectedOption){
    	                                         myGrid.setEditorForm({
    	                                             key:"title",
    	                                             position:[0,2], 
    	                                             value:this.selectedOption.optionText
    	                                         });
    	                                     }
    	                                 }
    	                                 }
    	                             }
    	                         },
    	                         {colSeq:3, align:"left", valign:"top",
    	                             form:{
    	                                 type:"radio",
    	                                 value:"itemValue",
    	                                 options:[
    	                                     {value:'장기영', text:'장기영'},
    	                                     {value:'장서우', text:'장서우'}
    	                                 ]
    	                             }
    	                         },
    	                         {colSeq:4, align:"left", valign:"top", form:{type:"text", value:"itemValue"}, AXBind:{type:"date"}},
    	                         {colSeq:5, align:"left", valign:"top", form:{type:"text", value:"itemValue"}, AXBind:{type:"money"}},
    	                         {colSeq:6, align:"left", valign:"top", form:{type:"text", value:"itemValue"}, AXBind:{type:"number", config:{min:0, max:100}}},
    	                         {colSeq:7, align:"right", valign:"top"},
    	                         {colSeq:8, align:"left", valign:"top",
    	                             form: {
    	                                 type: "select",
    	                                
    	                                 AXBind:{
    	                                     type:"select", config: {
    	                                         onChange: function () {
    	                                           
    	                                         }
    	                                     },
    	                                     onChange: function(){
    	                                         
    	                                         AXUtil.alert(this);
    	                                     }
    	                                 }
    	                             }
    	                         },
    	                         {
    	                             colSeq:9, align:"center", valign:"middle",
    	                             form:{
    	                                 type:"checkbox", value:"itemValue", options:[
    	                                     {value:true, text:''}
    	                                 ]
    	                             }
    	                         }
    	                     ]
    	                 ],
    	                
    	                 response: function(){ 
    	                     if(this.error){
    	                         trace(this);
    	                         return;
    	                     }

    	                     if(this.index == null){ 
    	                         var pushItem = this.res.item;
    	                      
    	                         if(this.res.item.title == ""){
    	                             alert("제목이 비어 추가 할 수 없습니다.");
    	                             return false;
    	                         }
    	                         trace(pushItem, this.insertIndex);
    	                         myGrid.pushList(pushItem, this.insertIndex);
    	                     }else{ 
    	                         AXUtil.overwriteObject(this.list[this.index], this.res.item, true);
    	                         myGrid.updateList(this.index, this.list[this.index]);
    	                     }
    	                     
    	                 },
    	                 onkeyup: function(event, element){
    	                     if(event.keyCode == 13 && element.name != "title") myGrid.saveEditor();
    	                     else if(event.keyCode == 13 && element.name == "title") myGrid.focusEditorForm("regDate");
    	                 }
    	             },
    	             contextMenu: {
    	                 theme:"AXContextMenu",
    	                 width:"150", 
    	                 menu:[
    	                     {
    	                         userType:1, label:"추가하기", className:"plus", onclick:function(){
    	                             myGrid.appendList(null);
    	                            
    	                         }
    	                     },
    	                     {
    	                         userType:1, label:"삭제하기", className:"minus", onclick:function(){
    	                             if(this.sendObj){
    	                                 if(!confirm("정말 삭제 하시겠습니까?")) return;
    	                                 var removeList = [];
    	                                     removeList.push({no:this.sendObj.item.no});
    	                                 myGrid.removeList(removeList); 
    	                             }
    	                         }
    	                     },
    	                     {
    	                         userType:1, label:"수정하기", className:"edit", onclick:function(){
    	                            
    	                             if(this.sendObj){
    	                                 myGrid.setEditor(this.sendObj.item, this.sendObj.index);
    	                             }
    	                         }
    	                     }
    	                 ],
    	                 filter:function(id){
    	                     return true;
    	                 }
    	             }
    	         }); 

     },//pageStart
     
   /*     grid_sumary: function(){
   	  app.ajax({
             type: "GET",
             url: "/mntr/mab01/gridList.json",
             data:"",
         }, function (res) {
             if (res.error) {
                 alert(res.error.message);
             }
             else {
            	 alert("그리드입니다.");
           	  console.log(res.list);
           	 myGrid.setList(res.list); 
               
                 }
         });
   },   */
     
     modalOpen: function(){    	  
		/*  if(REG_MONTH == null || REG_MONTH == ""){	 */				
    	  myModal.open({    		 
				type: "GET",
				url:"/maa01/shipmntPrearngeVolm_popup2.do",				
				pars:"",
				top: axdom(window).scrollTop() + 30,
				closeByEscKey:true
			});
		 /* }else {
			alert(REG_MONTH);			
			myModal.open({
				type: "GET",
				url:"/mab01/cropInfoInput_popup.do",				
				pars:"&REG_MONTH="+REG_MONTH+"&CHUL_NO2="+CHUL_NO2+"&MONTH_GUBN="+MONTH_GUBN+"&STATUS_CD="+STATUS_CD
                +"&BIGO="+BIGO,
				top:50,
				closeByEscKey:true
			});
		} */ 
	},
     
     appendGrid: function(index){
         var item = {amount:0};
         if(index == "last") {
             myGrid.appendList(item, myGrid.list.length);
         }else if(typeof index != "undefined"){
             myGrid.appendList(item, index);
         }else{
             myGrid.appendList(item);
         }
     },
     getCheckedList: function(){
	     	
         var checkedList = myGrid.getCheckedList(0);// colSeq
         
         if(checkedList.length == 0){
             alert("선택된 목록이 없습니다. 삭제하시려는 목록을 체크하세요");    
             return;
         }
        
         if(!confirm("정말 삭제 하시겠습니까?")) return;        	
        	 var obj2=checkedList;
             var deleteValue = [];
         $.each(obj2,function(key,value) {
         	//alert('key:'+key+', REG_MONTH:'+value.REG_MONTH+',CHUL_NO2:'+value.CHUL_NO2+',MONTH_GUBN'+value.MONTH_GUBN);
         	deleteValue += (value.REG_MONTH+','+value.CHUL_NO+','+value.MONTH_GUBN+','+value.GUBN+','+value.ITEM_CD+','+value.MARKET_CD+'!');
         });          
         $.ajax({
             type : 'get',
             url : "/mntr/maa01/deleteShipmntPrearngeVolm.json",
             data :deleteValue,
             dataType : '',   	           
             success : function(res){                   	 
            	 grid_ajax();
                 console.log(res.list);             	 
             },
         }); 
         
     },
     removeList: function(){
         var checkedList = myGrid.getCheckedList(0);// colSeq
         alert(checkedList);
         if(checkedList.length == 0){
             alert("선택된 목록이 없습니다. 삭제하시려는 목록을 체크하세요");    
             return;
         }
         if(!confirm("정말 삭제 하시겠습니까?")) return;
         
         /// something do for server
         
         var removeList = [];
         $.each(checkedList, function(){
             removeList.push({no:this.no});
         });
         myGrid.removeList(removeList); // 전달한 개체와 비교하여 일치하는 대상을 제거 합니다. 이때 고유한 값이 아닌 항목을 전달 할 때에는 에러가 발생 할 수 있습니다.
     }
        /* myProgress.setConfig({
            totalCount:50,
            width:300,
            top:100,
            title:"AXProgress BAR",
            duration:50 // Animation speed value of progress bar
        }); */
        //Not necessarily, but recommended to apply the code after preparing your page.
  
    };
  
    /*   progressStart: function(){
        mask.open();
        myProgress.start(function(){
            trace(this);
            if(this.isEnd){
                myProgress.close();
                mask.close();
                toast.push("progress end");
            }else{
                // Processes something.
                // Mostly, asynchronous AJAX communication.
                myProgress.update();
                // Starts the next count of Progress.
            }
        });
    } */

$(document).ready(fnObj.pageStart);
</script>
   
</head>
<body>
<%@ include file="/WEB-INF/inc/IncHeader.jsp" %>
<article>
<div class="wrap">
<div class="nav_sub_a"><!--서브 네비게이션시작-->
<img src="/images/hw/ma_img.jpg" alt="모니터요원입력화면" /><!--서브이미지-->
<nav>
<ul id="nav_sub_ma">
	<li><span class="sub_title_ma_on">생산정보입력</span></li>
	<li><a href="/maa01/maa01.do"><span class="sub_list_ma_on">출하물량 및 예정물량</span></a></li>
	<li><a href="/mab01/mab01.do">작황정보 입력</a></li>
	<li><a href="/mac01/mac01.do">재배동향 입력</a></li>
</ul>
<ul id="nav_sub_ma">
	<li><span class="sub_title_ma_off">소비정보입력</span></li>
	<li><a href="/mba01/mba01.do">소비동향 입력</a></li>
	<li><a href="/mbb01/mbb01.do">소매가격 입력</a></li>
</ul>

</nav>
</div><!--서브 네비게이션끝-->

<div class="hw_content"><!--컨텐츠 내용들어가는곳 시작-->
	
<div class="ma_all">
	<a href="/maa01/maa01.do"><div class="ma_half2"><div class="half2_purple"></div><span class="half_title">출하물량 입력</span></div></a>
	<div class="ma_half1"><div class="half1_white"></div><span class="half_title">출하예정물량 입력</span></div>
</div>
<div class="hw_clear"></div>	
<div class="hw_infouse_01">  <p> <span class="purple"> ◎ 이용안내 :</span> 글을 작성하시려면 등록하기를 누르셔서 작성하시면 됩니다.</p></div>
<div class="hw_clear"></div>	
<div>
<div><input  class="ma_add"  type="button" value="등록하기" onclick="fnObj.modalOpen();" /></div>
<div><input  class="ma_del"  type="button" value="삭제하기" onclick="fnObj.getCheckedList();" /></div>
<div><input  class="ma_re"  type="button" value="새로고침" onclick="grid_ajax();" /></div>
</div>
<div class="hw_clear"></div>


<div class="hw_ma_grid">
 <div id="AXGridTarget" style="height:400px;"></div>
</div><!--wrap 끝-->


</article>

<div class="hw_clear"></div>
<footer>
<div id="footer">

<div class="footer_box">
<p>&nbsp;화훼유통정보시스템 이용안내 /
&nbsp;개인정보처리방침 /
&nbsp;개인정보침해신고센터 /
&nbsp; 전자우편주소수집거부 /
&nbsp;뷰어다운로드 /
&nbsp;찾아오시는길 /
&nbsp;사이트맵</p>
<div class="logo_g"><a href=""><img src="/images/hw/logo_g.JPG" alt="aT화훼유통정보시스템 로고"/></a></div>
<div class="adress">
<p>[58217] 서울특별시 서초구 강남대로 27 화훼공판장    전화 : 02-579-8100    I   팩스 : 02-578-8671<p>
<p>&nbsp;COPYRIGHT @2016 by Korea Agro-Fisheries & Food Trade Corporation ALL RIGHTS RESERVED.</p>

</div>


</div>


</div>

</footer>
</body>
</html>