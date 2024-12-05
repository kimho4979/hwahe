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
<title>모니터요원 입력시스템-작황동향 입력</title>
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
  <!-- rMateChartH5 테마 js -->
  <script type="text/javascript" src="<c:url value='/rMateChart/rMateChartH5/Assets/Theme/theme.js' />"></script>
  <!-- @@@@@@@@@@@@@@@@@@@@@@ css end   @@@@@@@@@@@@@@@@@@@@@@ --> 
  
  <script type="text/javascript">
var chulno = "0001"
var myProgress = new AXProgress();
var myGrid = new AXGrid();
var myGrid1 = new AXGrid();
var myModal = new AXModal();
var REG_DATE="";
var CHUL_NO="";
var STATUS="";
var BIGO="";
var gridData=[];
 function grid_ajax(){
	 	var REG_DATE1 = $('#REG_DATE1').val();
	 	var REG_DATE2 = $('#REG_DATE2').val();
	 	var PUM_NAME = $('#PUM_NAME').val();
	 	var GOOD_NAME = $('#GOOD_NAME').val();
	 	var STATUS = $('#STATUS').val();
	 
       $.ajax({
           type : 'post',
           url : "/mntr/mab01/gridList.json",
           //data :  '&CHUL_NO='+CHUL_NO,
           data : {
        	   CHUL_NO : CHUL_NO,
        	   REG_DATE1 : REG_DATE1,
        	   REG_DATE2 : REG_DATE2,
        	   PUM_NAME : PUM_NAME,
        	   GOOD_NAME : GOOD_NAME,
        	   STATUS : STATUS
           },
           dataType : '',   	           
           success : function(res){               
				console.log(res.list);
				myGrid.setList(res.list);
           },
       });      	    
   };
   
   function grid_ajax1(){
      $.ajax({
          type : 'post',
          url : "/mntr/mab01/gridListAll.json",
          data :{},
          dataType : '',   	           
          success : function(res){               
			console.log(res.list);
			myGrid1.setList(res.list);
          }
      });      	    
  	};
   
   function deleteGrid(){   		     		    	          	 
		
   } ;

var fnObj = {
    pageStart: function(){
    	CHUL_NO="${SESSION_CMP_CODE}";
    	//grid_ajaxAll();
    	    	
    	$('input[type=radio]').bindChecked();
        myModal.setConfig({
				windowID:"myModalCT", width:1150,
				displayLoading:true,
            	scrollLock: false,
				onclose: function(){					
				//toast.push("저장되었습니다.");	
				grid_ajax();
				grid_ajax1();
			}
		});
        myModal.setWidth("100%");
        
     	// 검색 조건 Default Date 설정 시작
    	var date = new Date();
    	var year = date.getFullYear();
    	
        var month = date.getMonth()+1;
        month = month > 9 ? month : '0'+month;
        
        var byear = date.getFullYear();
        var bmonth = date.getMonth();
        if(bmonth==0){
        	bmonth=12;
        	byear = byear-1;
        }
        bmonth = bmonth > 9 ? bmonth : '0'+bmonth;
        
        var day = date.getDate();
        day = day > 9 ? day : '0'+day;
        
        var dt = year + "-" + month + "-" + day;
        var bdt = byear + "-" + bmonth + "-" + day;
        
        var rd1 = $('#REG_DATE1').val(bdt);
        var rd2 = $('#REG_DATE2').val(dt);
        
        $('#REG_DATE1').bindDate({align:"right", valign:"bottom", separator:"-", selectType:"d",  defaultSelectType:"d", defaultDate : "rd1",
			onchange:function(){
				//toast.push(Object.toJSON(this));
				grid_ajax();
			}
    	});
    	$('#REG_DATE2').bindDate({align:"right", valign:"bottom", separator:"-", selectType:"d",  defaultSelectType:"d", defaultDate : "rd2",
			onchange:function(){
				//toast.push(Object.toJSON(this));
				grid_ajax();
            }
        });
    	grid_ajax();
    	grid_ajax1();
    	
    	$('#GOOD_NAME').hide();
    	$('#PUM_NAME').change(function(){
    		var pum = $('#PUM_NAME').val();
    		if(pum == "장미"){
    			$('#GOOD_NAME').show();
    		}else{
    			$('#GOOD_NAME').hide();
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
    	                     // checkbox 개체를 checked 된 상태로 만들기
    	                     checked:function(){
    	                         return false;
    	                         //사용 가능한 변수
    	                         //this.index
    	                         //this.item
    	                         //this.list
    	                         return (this.index % 2 == 0);
    	                     }
    	                 },
    	                 {key:"REG_DATE", label:"등록일자", width:"100", align:"center", pk:true},                     	                 
    	                 {key:"SEQ_NO", label:"일련번호", width:"120", display: false},
    	                 {key:"CHUL_NO", label:"출하코드",align:"center", width:"80", display:false},
    	 				 {key:"CHUL_NO2", label:"출하코드", width:"80",align:"center" ,formatter:function(){
    						var CHUL_NO = this.item.CHUL_NO;
    						var userId = "${sessionScope.SESSION_USER_ID}"; 
    						
    						if(userId == "admin" || userId == "at99999999"){
    							return CHUL_NO;
    						}else{
    							return "-";
    						}
    					 }},
    	                 {key:"PUM_NAME", label:"품목명",align:"center", width:"80"},
    	                 {key:"GOOD_NAME", label:"품종명",align:"center", width:"80"},
    	                 {key:"STATUS_NAME", label:"작황상태", width:"120",align:"center"},
    	                 {key:"STATUS", label:"작황상태코드", width:"120", display: false},
    	                 {key:"BIGO", label:"작황내용", width:"400"},
    	                 {key:"FILE_NAME", label:"파일이름", width:"120"},
    	                 {key:"REG_DT", label:"등록일", width:"120"},
    	                 {key:"UPT_DT", label:"수정일", width:"120"}
    	             ],
    	             colHeadAlign:"center",
    	             /* colHead : {
    	                 rows: [
    	                     [
    	                         {colSeq:0, rowspan:2},
    	                         {colSeq:1, rowspan:2},
    	                         {colSeq:null, colspan:3, label:"표현식", align:"center"}, // 2,3,4
    	                         {colSeq:5, rowspan:2},
    	                         {colSeq:6, rowspan:2},
    	                         {colSeq:7, rowspan:2},
    	                         {colSeq:8, rowspan:2},
    	                         {colSeq:9, rowspan:2}
    	                     ],
    	                     [
    	                         {colSeq:2},
    	                         {colSeq:3},
    	                         {colSeq:4}
    	                     ]
    	                 ]
    	             }, */
    	             body : {
    	                 onclick: function(){  
    	                	// toast.push(Object.toJSON(this.item));
    	                	gridData="REG_DATE=" + this.item.REG_DATE+"&PUM_NAME="+this.item.PUM_NAME+"&GOOD_NAME="+this.item.GOOD_NAME+"&CHUL_NO="+this.item.CHUL_NO+"&STATUS="+this.item.STATUS+"&SEQ_NO="+this.item.SEQ_NO +"&BIGO="+this.item.BIGO;
    	                	fnObj.modalOpen(gridData);
    	                	/*   app.modal.open({
    	                          url:"/mab01/cropInfoInput_popup.do",
    	                          pars:"REG_DATE=" + this.item.REG_DATE+"&CHUL_NO="+this.item.CHUL_NO+"&STATUS="+this.item.STATUS+"&SEQ_NO="+this.item.SEQ_NO
    	                          +"&BIGO="+this.item.BIGO    	                                   
    	                      });  */
    	                	/*   REG_MONTH=this.item.REG_MONTH;
    	                	  CHUL_NO2=this.item.CHUL_NO2;
    	                	  MONTH_GUBN=this.item.MONTH_GUBN;
    	                	  STATUS_CD=this.item.STATUS_CD;
    	                	  BIGO=this.item.BIGO; 
    	                     
    	                      fnObj.modalOpen(); */
    	                	
    	                 },
    	                 ondblclick: function(){
    	                     //toast.push(Object.toJSON({index:this.index, r:this.r, c:this.c, item:this.item}));
    	                 },
    	                 // checkbox 개체를 click 할때 이벤트 체크
    	                 oncheck: function(){
    	                     //사용 가능한 변수
    	                     //this.itemIndex
    	                     //this.target
    	                     //this.checked
    	                     //this.r
    	                     //this.c
    	                     //this.list
    	                     //this.item
    	                     //toast.push(this.checked);
    	                     
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
    	                                     /*
    	                                     if(this.value == ""){
    	                                         alert("제목은 필수 입력 항목 입니다.");
    	                                         return false;
    	                                     }else{
    	                                         return true;
    	                                     }
    	                                     */
    	                                 }
    	                             }
    	                             , AXBind:{type:"selector", config:{
    	                                 appendable:true,
    	                                 ajaxUrl:"selectorData.php",
    	                                 ajaxPars:"",
    	                                 onChange:function(){
    	                                     //trace(this.selectedOption);
    	                                     if(this.selectedOption){
    	                                         myGrid.setEditorForm({
    	                                             key:"title",
    	                                             position:[0,2], // editor rows 적용할 대상의 배열 포지션 (다르면 적용되지 않습니다.)
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
    	                                 /*
    	                                 options:[
    	                                     {value:1, optionText:"AXJ_String%2C%EC%97%91%EC%8B%9C%EC%8A%A4%EC%A0%9C%EC%9D%B4"},
    	                                     {value:2, text:"AXJ_String%2C%EC%97%91%EC%8B%9C%EC%8A%A4%EC%A0%9C%EC%9D%B4"}
    	                                 ],
    	                                 */
    	                                 AXBind:{
    	                                     type:"select", config: {
    	                                         onChange: function () {
    	                                             //trace(this);
    	                                         }
    	                                     },
    	                                     onChange: function(){
    	                                         // abcd
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
    	                 //request:{ajaxUrl:"saveGrid.php", ajaxPars:"param1=1&param2=2"},
    	                 response: function(){ // ajax 응답에 대해 예외 처리 필요시 response 구현
    	                     // response에서 처리 할 수 있는 객체 들
    	                     //trace({res:this.res, index:this.index, insertIndex:this.insertIndex, list:this.list, page:this.page});
    	                     if(this.error){
    	                         trace(this);
    	                         return;
    	                     }

    	                     if(this.index == null){ // 추가
    	                         var pushItem = this.res.item;
    	                         //pushItem 에 추가 값 지정 가능
    	                         if(this.res.item.title == ""){
    	                             alert("제목이 비어 추가 할 수 없습니다.");
    	                             return false;
    	                         }
    	                         trace(pushItem, this.insertIndex);
    	                         myGrid.pushList(pushItem, this.insertIndex);
    	                     }else{ // 수정
    	                         //trace(this.res.item);
    	                         AXUtil.overwriteObject(this.list[this.index], this.res.item, true); // this.list[this.index] object 에 this.res.item 값 덮어쓰기
    	                         myGrid.updateList(this.index, this.list[this.index]);
    	                     }
    	                     
    	                 },
    	                 onkeyup: function(event, element){
    	                     if(event.keyCode == 13 && element.name != "title") myGrid.saveEditor();
    	                     else if(event.keyCode == 13 && element.name == "title") myGrid.focusEditorForm("regDate");
    	                 }
    	             },
    	             contextMenu: {
    	                 theme:"AXContextMenu", // 선택항목
    	                 width:"150", // 선택항목
    	                 menu:[
    	                     {
    	                         userType:1, label:"추가하기", className:"plus", onclick:function(){
    	                             myGrid.appendList(null);
    	                             //myGrid.appendList(item, index);
    	                             /*
    	                             var removeList = [];
    	                                 removeList.push({no:this.sendObj.item.no});
    	                             myGrid.removeList(removeList); // 전달한 개체와 비교하여 일치하는 대상을 제거 합니다. 이때 고유한 값이 아닌 항목을 전달 할 때에는 에러가 발생 할 수 있습니다.
    	                             */
    	                         }
    	                     },
    	                     {
    	                         userType:1, label:"삭제하기", className:"minus", onclick:function(){
    	                             if(this.sendObj){
    	                                 if(!confirm("정말 삭제 하시겠습니까?")) return;
    	                                 var removeList = [];
    	                                     removeList.push({no:this.sendObj.item.no});
    	                                 myGrid.removeList(removeList); // 전달한 개체와 비교하여 일치하는 대상을 제거 합니다. 이때 고유한 값이 아닌 항목을 전달 할 때에는 에러가 발생 할 수 있습니다.
    	                             }
    	                         }
    	                     },
    	                     {
    	                         userType:1, label:"수정하기", className:"edit", onclick:function(){
    	                             //trace(this);
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
    	
    	myGrid1.setConfig({
            targetID : "AXGridTargetAll",
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
                    // checkbox 개체를 checked 된 상태로 만들기
                    checked:function(){
                        return false;
                        //사용 가능한 변수
                        //this.index
                        //this.item
                        //this.list
                        return (this.index % 2 == 0);
                    }
                },
                {key:"REG_DATE", label:"등록일자", width:"100", align:"center", pk:true},                     	                 
                {key:"SEQ_NO", label:"일련번호", width:"120", display: false},
                {key:"CHUL_NO", label:"출하코드",align:"center", width:"80"},
                {key:"PUM_NAME", label:"품목명",align:"center", width:"80"},
                {key:"GOOD_NAME", label:"품종명",align:"center", width:"80"},
                {key:"STATUS_NAME", label:"작황상태", width:"120",align:"center"},
                {key:"STATUS", label:"작황상태코드", width:"120", display: false},
                {key:"BIGO", label:"작황내용", width:"400"},
                {key:"FILE_NAME", label:"파일이름", width:"120"},
                {key:"REG_DT", label:"등록일", width:"120"}
            ],
            colHeadAlign:"center",
            body : {
                onclick: function(){  

                },
                ondblclick: function(){
                    
                },
                // checkbox 개체를 click 할때 이벤트 체크
                oncheck: function(){
                }
            },
            page:{
                paging:true
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
     
     modalOpen: function(gridData){

		/*  if(REG_MONTH == null || REG_MONTH == ""){	 */				
    	  myModal.open({    		 
				type: "GET",
				url:"/mab01/cropInfoInput_popup.do",				
				pars:("&"+gridData).queryToObject(),
				top:50,
				closeByEscKey:true
			});
    	  myModal.setWidth("100%");
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
             myGrid1.appendList(item, myGrid1.list.length);
         }else if(typeof index != "undefined"){
             myGrid.appendList(item, index);
             myGrid1.appendList(item, index);
         }else{
             myGrid.appendList(item);
             myGrid1.appendList(item);
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
         	deleteValue += (value.REG_DATE+','+value.CHUL_NO+','+value.PUM_NAME+','+value.GOOD_NAME+','+value.SEQ_NO+'!');
         });
         $.ajax({
             type : 'post',
             url : "/mntr/mab01/deleteCropInfoInput.json",
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
<%@ include file="/WEB-INF/jsp/inc/IncMenu.jsp" %>


<div class="hw_content"><!--컨텐츠 내용들어가는곳 시작-->
	
<h3 class="hw_h3_ma"><!-- <div class="half1_white"></div> --><span class="half_title">작황동향 입력</span></h3>
<div class="hw_clear"></div>	
	
<div class="hw_infouse_01">  <p> <span class="purple"> ◎ 이용안내 :</span> 글을 작성하시려면 추가하기를 누르셔서 작성날짜선택, 작황정보선택, 작황정보 요약, 사진업로드를 해주시면 됩니다.</p></div>



<div class="ma_btn_allbox">
		<input  class="ma_add"  type="button" value="등록하기" onclick="fnObj.modalOpen();" />
		<input  class="ma_del"  type="button" value="삭제하기" onclick="fnObj.getCheckedList();" />
		<input  class="ma_re"  type="button" value="새로고침" onclick="grid_ajax();" />

</div>

<div style="width:600px; margin-bottom:10px;">
	<div class="selectWrap">
		<input type="text" name="REG_DATE1" id="REG_DATE1" class="AXInput W100" value="" />
		-
		<input type="text" name="REG_DATE2" id="REG_DATE2" class="AXInput W100" value="" />
	</div>
	<div class="selectWrap mt10">
		<select id="PUM_NAME" name="PUM_NAME" onchange="grid_ajax();">
			<option value="">품목 선택</option>
			<option value="장미">장미</option>
		</select>
		
		<select name="GOOD_NAME" id="GOOD_NAME" onchange="grid_ajax();">
			<option value="">품종 선택</option>
			<option value="그레이스">그레이스</option>
			<option value="그린나오미">그린나오미</option>
			<option value="나오미골드">나오미골드</option>   
			<option value="나이팅게일">나이팅게일</option>   
			<option value="달리">달리</option>   
			<option value="도미니카">도미니카</option>   
			<option value="돌세토">돌세토</option>   
			<option value="라펄">라펄</option>   
			<option value="레가토">레가토</option>   
			<option value="레드나오미">레드나오미</option>   
			<option value="레드이글">레드이글</option>  
			<option value="리바이벌">리바이벌</option> 
			<option value="마르시아">마르시아</option>
			<option value="마이걸">마이걸</option>
			<option value="미스홀렌드">미스홀렌드</option>
			<option value="밀바">밀바</option>
			<option value="버블검">버블검</option>
			<option value="보르도">보르도</option>
			<option value="부루트">부루트</option>
			<option value="블론디">블론디</option>
			<option value="비탈">비탈</option>
			<option value="빅토리아">빅토리아</option>
			<option value="사비나">사비나</option>
			<option value="샤만트">샤만트</option>
			<option value="샹그리라">샹그리라</option>
			<option value="스위트돌로미트">스위트돌로미트</option>
			<option value="슈퍼센세이션">슈퍼센세이션</option>
			<option value="선스타">선스타</option>
			<option value="아쿠아">아쿠아</option>
			<option value="어피니티">어피니티</option>
			<option value="F1">F1</option>
			<option value="엑설런트">엑설런트</option>
			<option value="오션송">오션송</option>
			<option value="오로라">오로라</option>
			<option value="올포러브">올포러브</option>
			<option value="이구아나">이구아나</option>
			<option value="일레오스">일레오스</option>
			<option value="와우">와우</option>
			<option value="자나">자나</option>
			<option value="지니">지니</option>
			<option value="카렌자">카렌자</option>
			<option value="클럽니카">클럽니카</option>
			<option value="푸에고">푸에고</option>
			<option value="피치걸">피치걸</option>
			<option value="피치벨리">피치벨리</option>
			<option value="핑크파티">핑크파티</option>
			<option value="핑크하트">핑크하트</option>
			<option value="헤라">헤라</option>
			<option value="기타">기타</option>
		</select>
		
		<select name="STATUS" id="STATUS" onchange="grid_ajax();">
			<option value="">상태 선택</option>
			<option value="1">좋음</option>
			<option value="2">보통</option>
			<option value="3">나쁨</option>
		</select>
	</div>
</div>

<div class="hw_clear"></div>

<div class="hw_ma_grid">
 <div id="AXGridTarget" style="height:400px;"></div>
 <br/>
 <div id="AXGridTargetAll" style="height:400px;"></div>
</div><!--wrap 끝-->

</article>

<div class="hw_clear"></div>
<footer>
<%@ include file="/WEB-INF/inc/IncFooter.jsp" %>
</footer>
</body>
</html>