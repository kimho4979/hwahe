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
	<link rel="stylesheet" type="text/css"	href="<c:url value='/css/layout.css' />" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/hw/n_ma.css' />" />
<link rel="stylesheet" type="text/css"	href="<c:url value='/css/hw/n_common.css' />" />
	
 
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

<%@ include file="/WEB-INF/jsp/admin/adminheader.jsp" %>


<div class="hw_clear"></div>


<div class="content_wrap"><!--네비와 컨텐츠 감싸는 부분-->

<div class="navarea">
<h1 class="logo"><img src="<c:url value='/admin/images/logo.jpg'/>" alt="aT화훼유통정보시스템 관리자"/></h1>

<!-- menu -->  
	<%@ include file="/WEB-INF/jsp/admin/adminleft.jsp" %>

                      
</div>
<div class="sub_contents">  
<div class="sub_contents_title">공지사항관리</div>

<div class="real_contents">
	
	</br>
	
	<div class="ax-search" id="AXSearchTarget"></div>
	</br>
	
 <div id="AXGridTarget" class="ax-grid" style="height:300px;"></div> 
	<div class="ax-button-group">
	    <div class="right">
	        <button type="button" class="AXButton" id="ax-grid-btn-add"><i class="axi axi-plus-circle"></i> 등록</button>
	    </div>
	    <div class="ax-clear"></div>
	</div>

</div>
</div>
</div> <!--네비와 컨텐츠 감싸는 부분 끝-->


<div class="hw_clear"></div>
	<%@ include file="/WEB-INF/jsp/admin/adminfooter.jsp" %>


</div><!--전체 끝--->
</body>
</html>

<script type="text/javascript">
var myProgress = new AXProgress();
var myGrid = new AXGrid();
var mySearch = new AXSearch();
var parent_window = parent||opener||window;
var myValidator = new AXValidator();
/* var loading_mask = new AXMask(); */
var myModal = new AXModal();
var pageNo2 = "";
var pageSize = "";
var startCount = "";
var endCount = "";
var loading_mask = new AXMask();
var pageNo3 = "";
var pageSize2 = "";
var startCount2 = "";
var endCount2 = "";

function grid_ajax() {
	   fnObj.grid.setPage(1);

}

var pageID = "AXGrid";
var fnObj = {
		pageStart: function(){
			this.bindEvent();

			//검색도구 설정 01 ---------------------------------------------------------
		
			
			myModal.setConfig({
				windowID:"myModalCT", width:1150,
           
				displayLoading:true,
           	 scrollLock: false,
				onclose: function(){					
					//toast.push("저장되었습니다.");	
					grid_ajax();
					
				}
			}); 
			//검색도구 설정 01 ---------------------------------------------------------
			  fnObj.grid.bind();
		},
		  bindEvent: function(){
			  var _this = this;

			  $("#ax-grid-btn-add").bind("click", function(){
				  myModal.open({
                      url:"/admin/noticeInsert_popup.do",
                      pars:"",
                    	  top:50,
          				closeByEscKey:true
          				
                  });
              });
 
		},
	

		
		 grid: {
             target: new AXGrid(),
         
             bind: function () {
                 window.myGrid = fnObj.grid.target;

                 var getColGroup = function () {
                     return [
                             //{key:"index", label:"선택", width:"35", align:"center", formatter:"checkbox"}, 
                                {key : "btns",label : "삭제",width : "10",align : "center",formatter : function() {
										return '<button type="button" name="delete" onclick="fnObj.getCheckedList('
												+ this.index
												+ ');"><i class="axi axi-trash-o"></i></button>';
									}
								},
                             {key: "seq", label: "번호", width: "10" ,align: "center",},
                             {key: "title", label: "제목", width: "*" ,align: "center",},
                             {key: "content", label: "내용", width: "*" ,align: "center", display:false},
                             {key: "insId", label: "작성자", width: "20" ,align: "center",},
                             {key: "regDt", label: "작성일", width: "20" ,align: "center",},  
                         
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
                    	 onclick : function() {
                    		 
								var grid_Data ="&SEQ_NO=" + this.item.seq
									+"&CONTENT=" + this.item.content
									+"&TITLE=" + this.item.title;
								
								fnObj.modalOpen(grid_Data);
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
             		page : {
    					paging : true,
    					pageSize : 15,
    					onchange : function(pageNo) {
    						 
    						pageNo2 = this.pageNo;
    						pageSize = this.pageSize;
    						
    						startCount = ((pageNo2 - 1) * pageSize) + 1;
    						endCount = pageNo2 * pageSize;
    						 grid_ajax(); 
    						//dialog.push(Object.toJSON(this));
    						//alert(this.pageNo);
    					}
    				}
                 });
                 fnObj.grid.setPage(fnObj.grid.pageNo);
             },
             
             setPage: function(pageNo, searchParams) {
            	 
                 var _this = this;
                 
                 _this.pageNo = pageNo;
                 app.ajax({
                     type: "GET",
                     url: "/admin/adminNoticeList.json",
                     data: '&pageNo2=' + pageNo2 + '&pageSize=' + pageSize
					+ '&startCount=' + startCount + '&endCount=' + endCount
					,
                 }, function(res){
                	 
                	        console.log(res);
                     if(res.error){
                         alert(res.error.message);
                     }
                     else
                     {
                    console.log(res.list);
     				console.log(res.list2.pageNo2);
     				
     				
    				var pageCount2 = res.list[0].total_COUNT/15;
    				var pageRest = res.list[0].total_COUNT % 15;
    				

    				if (pageRest == 0) {
    					pageRest = 0;
    				} else {
    					pageRest = 1;
    				}
    				pageCount2 = Math.floor(pageCount2);
    				var pageResult = pageCount2 + pageRest;
                         var gridData = {
                        		 list : res.list,
                             page:{
                            		pageNo : res.list2.pageNo2, // 현재페이지
            						pageCount : pageResult, // 전체 페이지수
            						listCount : res.list[0].total_COUNT
                             }
                         };
                         
                         fnObj.grid.target.setData(gridData);
                     }
                 });
             },
             
            
	        },
	        
	    	getCheckedList : function(index) {

				if (!confirm("정말 삭제 하시겠습니까?"))
					return;
				
					var deleteValue = [];

				$.Event(event).stopPropagation(); // 버튼클릭 이벤트가 row click 이벤트를 발생시키지 않도록 합니다.
				var item = myGrid.list[index];
				value = item;
				console.log(value);
				
				deleteValue = (value.seq + ',' + value.content + ','
					+ ',' + value.title + '!');
				  $("#COMP_CODE").val(value.CHUL_NO);
				  
				  $.ajax({
				    type : 'get',
				    url : "/admin/deleteAdminNotice.json",
				    data :deleteValue,
				    dataType : '',   	           
				    success : function(res){        
				     
				     var item={
	 			    		 COMP_CODE:$("#COMP_CODE").val()
				     }
				   	 grid_ajax();
				     
				   	 
				    },
				});  
				
			},
	        
	        modalOpen : function(gridData) {
				
				
				myModal.open({
					type : "GET",
					url : "/admin/noticeUpdate_popup.do",
					pars : ("&" + gridData).queryToObject(),
					top : axdom(window).scrollTop() + 30,
					closeByEscKey : true
				});
			},
	};
	jQuery(document.body).ready(function(){fnObj.pageStart()});



</script>