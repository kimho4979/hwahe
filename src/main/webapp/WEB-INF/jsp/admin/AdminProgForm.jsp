<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
<title>화훼유통정보시스템 관리자</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=9">
	<meta http-equiv="X-UA-Compatible" content="IE=8">
<link rel="stylesheet" type="text/css" href="../../../css/layout.css" />
 <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/axicon/axicon.min.css' />" />    
 <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/cocker/AXJ.css' />" id="axu-theme-axisj" />
 <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/cocker/AXInput.css' />" />
 <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/cocker/AXSelect.css' />" />
 <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/cocker/AXSearch.css' />" />
 <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/cocker/AXGrid.css' />" />
  <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/cocker/AXButton.css' />" />
  	<link rel="stylesheet" type="text/css"	href="<c:url value='/css/hw/n_ma.css' />" />
<link rel="stylesheet" type="text/css"	href="<c:url value='/css/hw/n_common.css' />" />
  <script type="text/javascript" src="<c:url value='/axisj/jquery/jquery.min.js' />"></script>
  <script type="text/javascript" src="<c:url value='/axisj/dist/AXJ.min.js' />"></script>
  <script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/ax5-polyfill.js' />"></script>
  <script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/axjApp.js' />"></script>
<script>

$(function(){
	 $("#accordian li").eq(1).addClass('active'); 
	$("#accordian h3").click(function(){
		
		$("#accordian ul ul").slideUp();
		if(!$(this).next().is(":visible"))
		{
			$(this).next().slideDown();
		}
	})
});
</script>

</head>
<body>

<div id="wrap"><!--전체--->

		<%@ include file="/WEB-INF/jsp/admin/adminheader.jsp"%>


<div class="hw_clear"></div>


<div class="content_wrap"><!--네비와 컨텐츠 감싸는 부분-->

<div class="navarea">
<h1 class="logo"><img src="<c:url value='/admin/images/logo.jpg'/>" alt="aT화훼유통정보시스템 관리자"/></h1>

<!-- menu -->  
	<%@ include file="/WEB-INF/jsp/admin/adminleft.jsp" %>

                      
</div>
<div class="sub_contents">  
<div class="sub_contents_title">프로그램관리</div>

<div class="real_contents">
	
	</br>
	
	<div class="ax-search" id="AXSearchTarget"></div>
	</br>
	
 <div id="AXGridTarget" class="ax-grid" style="height:300px;"></div> 
	<div class="ax-button-group">
	    <div class="right">
	        <button type="button" class="AXButton" id="ax-grid-btn-add"><i class="axi axi-plus-circle"></i> 추가</button>
	        <button type="button" class="AXButton Red" id="ax-page-btn-save"><i class="axi axi-save"></i> 저장</button>
	    </div>
	    <div class="ax-clear"></div>
	</div>

</div>
</div>
</div> <!--네비와 컨텐츠 감싸는 부분 끝-->


<div class="hw_clear"></div>
			<%@ include file="/WEB-INF/jsp/admin/adminfooter.jsp"%>

</div><!--전체 끝--->
</body>
</html>

<script type="text/javascript">
var myProgress = new AXProgress();
var myGrid = new AXGrid();
var mySearch = new AXSearch();
var parent_window = parent||opener||window;
var myValidator = new AXValidator();
var loading_mask = new AXMask();
var myModal = new AXModal();

var resize_elements = [
                       {id:"page-grid-box", adjust:-98}
                   ];
           	    var fnObj = {
           	        pageStart: function(){
           	            this.search.bind();
           	            this.grid.bind();
           	            this.bindEvent();
           	        },
           	        bindEvent: function(){
           	            var _this = this;
                           $("#ax-page-btn-search").bind("click", function(){
                               _this.search.submit();
                           });
                           $("#ax-page-btn-save").bind("click", function(){
                               setTimeout(function() {
                                   _this.save();
                               }, 500);
                           });
                           $("#ax-page-btn-excel").bind("click", function(){
                               app.modal.excel({
                                   pars:"target=${className}"
                               });
                           });
                           $("#ax-grid-btn-add").bind("click", function(){
                               _this.grid.add();
                           });
           	        },
                       save: function(){
                           var items = fnObj.grid.target.list;
                           if (items.length == 0) {
                               alert("저장할 내용이 없습니다.");
                               return;
                           }
                           
							for(var i=0; i<items.length; i++){
								
								if(items[i].sysCd===undefined){
									alert("시스템을 선택해주세요.")
									return false;
								}
							} 
                           
                           var dto_list = [];
                           axf.each(items, function(i, d){
                        	   
                               if(d._CUD){
                                   var item = {
                                	   sysCd:  (d.sysCd || ""), 	   
                                       progCd: (d.progCd || ""),
                                       progNm: (d.progNm || ""),
                                       fileNm: (d.fileNm || ""),
                                       progPh: (d.progPh || ""),
                                       target: (d.target || ""),
                                       schAh: (d.schAh || "N"),
                                       savAh: (d.savAh || "N"),
                                       exlAh: (d.exlAh || "N"),
                                       fn1Ah: (d.fn1Ah || "N"),
                                       fn2Ah: (d.fn2Ah || "N"),
                                       fn3Ah: (d.fn3Ah || "N"),
                                       fn4Ah: (d.fn4Ah || "N"),
                                       fn5Ah: (d.fn5Ah || "N"),
                                       remark: (d.remark || ""),
                                       useYn: (d.useYn || "N")
                                   };
                                   dto_list.push(item);
                               }
                           });

                           //trace(dto_list);
                           //return;

                           app.ajax({
                               type: "PUT",
                               url: "/admin/saveProgProc.json",
                               data: Object.toJSON(dto_list)
                           }, function(res){
                               if(res.error){
                                   alert(res.error.message);
                               }
                               else
                               {
                                   toast.push("저장되었습니다.");
                               }
                           });
                       },
                       excel: function(){

                       },
                       search: {
           	            target: new AXSearch(),
           	            get: function(){ return this.target },
           	            bind: function(){
                               var _this = this;
                               this.target.setConfig({
           	                    targetID:"AXSearchTarget",
           	                    theme : "AXSearch",
           	                    mediaQuery: {
           	                        mx:{min:"N", max:767}, dx:{min:767}
           	                    },
           	                    onsubmit: function(){
           	                        // 버튼이 선언되지 않았거나 submit 개체가 있는 경우 발동 합니다.
                                       fnObj.search.submit();
           	                    },
           	                    rows:[
                                       {display:true, addClass:"", style:"", list:[
											{label:"시스템설정", labelWidth:"100", type:"selectBox", width:"", key:"searchSysCd", addClass:"", valueBoxStyle:"", value:"",
												options:[
													{optionValue:"", optionText:"전체보기"},
													{optionValue:"s", optionText:"화훼유통정보시스템"},
													{optionValue:"m", optionText:"모니터요원입력시스템"},
													{optionValue:"t", optionText:"자료전송시스템"}
													
												],
												onChange: function(selectedObject, value){
													//아래 3개의 값을 사용 하실 수 있습니다.
													//toast.push(Object.toJSON(this));
													//toast.push(Object.toJSON(selectedObject));
													//toast.push(value);
												}
											},                                        
                                           {label:"프로그램 코드/명", labelWidth:"", type:"inputText", width:"150", key:"searchParams", addClass:"", valueBoxStyle:"", value:"",
                                               onChange: function(changedValue){
                                                   //아래 2개의 값을 사용 하실 수 있습니다.
                                                   //toast.push(Object.toJSON(this));
                                                   //dialog.push(changedValue);
                                               }
                                           },
                                           {label:"", labelWidth:"", type:"button", width:"80", key:"button", addClass:"BLUE", valueBoxStyle:"padding-left:0px;padding-right:5px;", value:"<span>조회</span>",
                   							onclick: function(){
                   								 fnObj.search.submit();


                   								
                   							}
                   						},
                                       ]}
           	                    ]
           	                });
           	            },
           	            submit: function(){
           	                var pars = this.target.getParam();

                               fnObj.grid.setPage(1, pars);
           	            }
           	        },
           	        grid: {
                           pageNo: 1,
           	            target: new AXGrid(),
           	            bind: function(){
                               var target = this.target, _this = this;
           	                target.setConfig({
           	                    targetID : "AXGridTarget",
           	                    theme : "AXGrid",
                                   colHeadAlign:"center",
                                   
                                   /*
           	                    mediaQuery: {
           	                        mx:{min:"N", max:767}, dx:{min:767}
           	                    },
           	                    */
           	                    colGroup : [
           	                             {key:"sysCd", label:"시스템", width:"120", align:"center", formatter:function(){
                                            
                                            if(this.value == "m")
                                            {
                                            	return "모니터요원입력시스템";
                                            }else if(this.value == "t"){
                                            	return "자료전송시스템";
                                            }else if(this.value == "s"){
                                            	return "화훼유통정보시스템";
                                            }else{
                                            	 return "선탁하세요";
                                            }
                                            
                                                              	                            	 
           	                            	
                                         },
                                         editor:{
                                             type:"select", value:"itemValue",alwaysOnChange: true,
                                             options:[
												 {optionValue:"", optionText:"선택하세요."},
                                                 {optionValue:"s", optionText:"화훼유통정보시스템"},
                                                 {optionValue:"m", optionText:"모니터요원입력시스템"},
                                                 {optionValue:"t", optionText:"자료전송시스템"}
                                             ],
                                             beforeUpdate: function (val) { // 수정이 되기전 value를 처리 할 수 있음.
                                                 // 선택된 값은
                                                 
                                                 return val;
                                             },
                                             afterUpdate: function (val) { // 수정이 처리된 후
                                                 // 수정이 된 후 액션.
                                                 //console.log(this);
                                             }
                                         }
                                     },
           	                        {key:"progCd", label:"프로그램코드", width:"150", align:"left",
                                           editor:{
                                               type:"text",
           				    maxLength: 50,
                                               disabled: function(){
                                                   return this.item._CUD != "C";
                                               }
                                           }
                                       },
           	                        {key:"progNm", label:"프로그램명", width:"160",
                                           editor:{
                                               type:"text",
           				    maxLength: 25
                                           }
                                       },
           	                        {key:"progPh", label:"경로", width:"250",
                                           editor:{
                                               type:"text",
           				    maxLEngth: 100
                                           }
                                       },
                                      
                                       {key:"useYn", label:"사용여부", width:"80", align:"center", formatter:function(){
                                               return (this.value == "Y") ? "사용" :"미사용";
                                           },
                                           editor:{
                                               type:"select", value:"itemValue",
                                               options:[
                                                   {optionValue:"Y", optionText:"사용"},
                                                   {optionValue:"N", optionText:"미사용"}
                                               ],
                                               beforeUpdate: function (val) { // 수정이 되기전 value를 처리 할 수 있음.
                                                   // 선택된 값은
                                                   
                                                   return val;
                                               },
                                               afterUpdate: function (val) { // 수정이 처리된 후
                                                   // 수정이 된 후 액션.
                                                   //console.log(this);
                                               }
                                           }
                                       },
           	                        {key:"remark", label:"비고", width:"*",
                                           editor:{
                                               type:"text"
                                           }
                                       }
           	                    ],
                                   
           	                    body : {
           	                        onclick: function(){
           	                            //toast.push(Object.toJSON({index:this.index, item:this.item}));
           	                            //alert(this.list);
           	                            //alert(this.page);
           	                        }
           	                    },
           	                    page:{
                                       display:true,
                                       paging:false,
                                       onchange: function(pageNo){
                                           _this.setPage(pageNo);
                                       }
           	                    }
           	                });
                               this.setPage(fnObj.grid.pageNo);
           	            },
                           add:function(){
                               this.target.pushList(
                                   {
                                       "progCd": "",
                                       "progNm": "",
                                       "fileNm": "",
                                       "progPh": "",
                                       "target": "",
                                       "schAh": "",
                                       "savAh": "",
                                       "exlAh": "",
                                       "fn1Ah": "",
                                       "fn2Ah": "",
                                       "fn3Ah": "",
                                       "fn4Ah": "",
                                       "fn5Ah": "",
                                       "remark": "",
                                       "useYn": "Y"
                                   }
                               );
                               this.target.setFocus(this.target.list.length-1);
                           },
                           del:function(){
                               var checkedList = this.target.getCheckedListWithIndex(0);// colSeq
                               if(checkedList.length == 0){
                                   alert("선택된 목록이 없습니다. 삭제하시려는 목록을 체크하세요");
                                   return;
                               }
                               this.target.removeListIndex(checkedList);
                           },
                           setPage: function(pageNo, searchParams){
                               var _target = this.target;
                              // fnObj.grid.pageNo = pageNo;

                               app.ajax({
                                   type: "GET",
                                   url: "/admin/searchAdminProgList.json",
                                   data: "pageNumber=" + (pageNo-1) + "&pageSize=10000&" + (searchParams||mySearch.getParam())

                               }, function(res){
                                   if(res.error){
                                       alert(res.error.message);
                                   }
                                   else
                                   {
                                       // 샘플 입니다. 지워주세요
                                       var gridData ={};
                                       
                                       if(res.list.length>0){
                                       
           	                            gridData = {
           	                                list: res.list,
           	                                page:{
           	                                    pageNo: res.page.currentPage.number()+1,
           	                                    pageSize: res.page.pageSize,
           	                                    pageCount: res.page.totalPages,
           	                                    listCount: res.page.totalElements
           	                                }
           	                              };
                                        }else{
                                       	 gridData = {
                	                                list: res.list,
                	                                page:{
                	                                    pageNo: 0,
                	                                    pageSize: 0,
                	                                    pageCount: 0,
                	                                    listCount: 0
                	                                }
                	                              }; 
                                       	 
                                        }
                                       _target.setData(gridData);
                                   }
                               });

                           }
           	        }
           	    };

           jQuery(document.body).ready(function(){fnObj.pageStart()});



</script>