<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
request.setAttribute("searchParams", request.getParameter("remark")); 

%>
<html>
<head>
<title>화훼유통정보시스템 관리자</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=9">
	<meta http-equiv="X-UA-Compatible" content="IE=8">
<link rel="stylesheet" type="text/css" href="<c:url value='/admin/css/layout.css' />"/> 
 <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/axicon/axicon.min.css' />" />    
 <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/cocker/AXJ.css' />" id="axu-theme-axisj" />
 <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/cocker/AXInput.css' />" />
 <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/cocker/AXSelect.css' />" />
 <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/cocker/AXSearch.css' />" />
 <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/cocker/AXGrid.css' />" />
  <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/cocker/AXButton.css' />" />
  <script type="text/javascript" src="<c:url value='/axisj/jquery/jquery.min.js' />"></script>
  <script type="text/javascript" src="<c:url value='/axisj/dist/AXJ.min.js' />"></script>
  <script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/ax5-polyfill.js' />"></script>
  <script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/axjApp.js' />"></script>
  
  
<script>

$(function(){
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

<div class="hw_clear"></div>
<div class="content_wrap"><!--네비와 컨텐츠 감싸는 부분-->
<div class="sub_contents">  
<div class="sub_contents_title">산지코드검색</div>
<input type="hidden" />
<div class="real_contents">
	
	</br>
	
	<div class="ax-search" id="AXSearchTarget"></div>
	</br>
	
 <div id="AXGridTarget" class="ax-grid" style="height:500px;width:400px;"></div> 

 <button class="AXButton W60" onclick="fnObj.close();">취소</button>
</div>
</div>
</div> <!--네비와 컨텐츠 감싸는 부분 끝-->


<div class="hw_clear"></div>



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
var temp='';


var resize_elements = [
                       {id:"AXGridTarget", adjust:-98}
                   ];
           	    var fnObj = {
           	        pageStart: function(){
           	            this.search.bind();
           	            this.grid.bind();
           	            this.bindEvent();
           	            
           	         myModal.setConfig({
                         windowID:"myModalCT",
                         mediaQuery: {
                             mx:{min:0, max:320}, dx:{min:320}
                         },
                         displayLoading:true
                     });
           	      fnObj.search.submit();
           	        },
           	        bindEvent: function(){
           	            var _this = this;
                           $("#ax-page-btn-search").bind("click", function(){
                               _this.search.submit();
                           });
                          
                           
           	        },
                       save: function(){
                           var items = fnObj.grid.target.list;
                           if (items.length == 0) {
                               alert("저장할 내용이 없습니다.");
                               return;
                           }
                           
							for(var i=0; i<items.length; i++){
								
								if(items[i].grpAuthCd===undefined){
									alert("그룹코드를 입력하세요.")
									return false;
								}
							} 
                           
                           var dto_list = [];
                           axf.each(items, function(i, d){
                        	   
                               if(d._CUD){
                                   var item = {
                                	   grpAuthCd:  (d.grpAuthCd || ""), 	   
                                	   grpAuthNm: (d.grpAuthNm || ""),
                                       remark: (d.remark || ""),
                                       useYn: (d.useYn || "Y")
                                   };
                                   dto_list.push(item);
                               }
                           });

                           //trace(dto_list);
                           //return;

                           app.ajax({
                               type: "PUT",
                               url: "/admin/adminAuthGrpProc.json",
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
                       search: {
           	            target: new AXSearch(),
           	            get: function(){ return this.target },
           	            bind: function(){
                               var _this = this;
                               this.target.setConfig({
           	                    targetID:"AXSearchTarget",
           	                    theme : "AXSearch",
           	                    mediaQuery: {
           	                        mx:{min:"N", max:300}, dx:{min:300}
           	                    },
           	                    onsubmit: function(){
           	                        // 버튼이 선언되지 않았거나 submit 개체가 있는 경우 발동 합니다.
                                       fnObj.search.submit();
           	                    },
           	                    rows:[
                                       {display:true, addClass:"", style:"", list:[
											                             
                                           {label:"코드/코드명", labelWidth:"", type:"inputText", width:"150", key:"searchParams", addClass:"", valueBoxStyle:"", value:"${searchParams}",
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
           	                
           	                console.log(pars);

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
           	                             
           	                        {key:"SAN_CD", label:"산지코드", width:"150", align:"left",
                                         
                                       },
           	                        {key:"SAN_NAME", label:"산지명", width:"160",
                                         
                                       },
           	                                    
                                       {key:"GUBN", label:"사용여부", width:"80", align:"center", formatter:function(){
                                               return (this.value == "Y") ? "사용" :"미사용";
                                           },
                                           
                                       },
           	                       
           	                    ],
                                   
           	                    body : {
           	                        onclick: function(){
           	                           //toast.push(Object.toJSON({index:this.index, item:this.item}));
           	                            //alert(this.list);
           	                            //alert(this.page);
           	                          // console.log( $("#remark2",parent_window.document).val());
           	                         parent_window.document.getElementById("remark2").value = this.item.SAN_CD;
           	                         //console.log($(opener.document).find("#id").val());
           	                            //$("#remark2",opener.document).val(this.item.SAN_CD); 
           	                        fnObj.close();
           	                        }
           	                    },
           	                    page:{
                                       display:true,
                                       paging:true,
                                       onchange: function(pageNo){
											                                    	
                                           _this.setPage(pageNo);
                                       }
           	                    }
           	                });
                               //this.setPage(fnObj.grid.pageNo);
           	            },
                           add:function(){
                               this.target.pushList(
                                   {
                                       "grpAuthCd": "",
                                       "grpAuthNm": "",
                                       "remark":"",
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
                        	   var page1=pageNo;
                        	   
                        	   if(temp==pageNo && temp>1){
                        		   pageNo=pageNo-2;
                        			   
                        	   }
                        	   temp=pageNo;
                        	   
                               var _target = this.target;
                               fnObj.grid.pageNo = pageNo;
								
                               app.ajax({
                                   type: "GET",
                                   url: "/admin/searchAdminSanCdList.json",
                                   data: "pageNumber=" + (pageNo) + "&pageSize=10&" + (searchParams||fnObj.search.target.getParam())

                               }, function(res){
                            	   console.log(res);
                            	   
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

           jQuery(document.body).ready(function(){fnObj.pageStart()});



</script>