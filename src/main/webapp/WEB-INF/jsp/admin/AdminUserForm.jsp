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
	<link rel="stylesheet" type="text/css"	href="<c:url value='/css/hw/n_ma.css' />" />
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

<%@ include file="/WEB-INF/jsp/admin/adminheader.jsp" %>


<div class="hw_clear"></div>


<div class="content_wrap"><!--네비와 컨텐츠 감싸는 부분-->

<div class="navarea">
<h1 class="logo"><img src="<c:url value='/admin/images/logo.jpg'/>" alt="aT화훼유통정보시스템 관리자"/></h1>

<!-- menu -->  
	<%@ include file="/WEB-INF/jsp/admin/adminleft.jsp" %>

                      
</div>
<div class="sub_contents">  
<div class="sub_contents_title">회원관리</div>

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
<div class="footer_box"> <!--푸터시작-->
<div class="logo_g"><a href=""><img src="<c:url value='/admin/images/logo_g.jpg'/>" alt="aT화훼유통정보시스템 로고"/></a></div>
<div class="adress">
<p>[58217] 서울특별시 서초구 강남대로 27 화훼공판장    전화 : 02-579-8100    I   팩스 : 02-578-8671<p>
<p>&nbsp;COPYRIGHT @2016 by Korea Agro-Fisheries & Food Trade Corporation ALL RIGHTS RESERVED.</p>
</div> <!--어드레스 끝-->
</div> <!--푸터끝-->


</div><!--전체 끝--->
</body>
</html>

<script type="text/javascript">
var myProgress = new AXProgress();
var myGrid = new AXGrid();
var mySearch = new AXSearch();
var parent_window = parent||opener||window;
var myValidator = new AXValidator();
var pageNo2 = "";
var pageSize = "";
var startCount = "";
var endCount = "";
var loading_mask = new AXMask();
var pageNo3 = "";
var pageSize2 = "";
var startCount2 = "";
var endCount2 = "";
var myModal = new AXModal();


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
                      url:"/admin/adminUserInsertPopup.do",
                      pars:"",
                    	  top:50,
          				closeByEscKey:true
          				
                  });
              });
 
		},
	

		search1: function(){
			var pars = mySearch.getParam();
			//toast.push("콘솔창에 파라미터 정보를 출력하였습니다.");
			trace(pars);
			 fnObj.grid.setPage( 1, pars );
		},
		 grid: {
             target: new AXGrid(),
             pageNo: 1,
             bind: function () {
                 window.myGrid = fnObj.grid.target;

                 var getColGroup = function () {
                     return [
                             //{key:"index", label:"선택", width:"35", align:"center", formatter:"checkbox"}, 
                               /*  {key : "btns",label : "삭제",width : "10",align : "center",formatter : function() {
										return '<button type="button" name="delete" onclick="fnObj.getCheckedList('
												+ this.index
												+ ');"><i class="axi axi-trash-o"></i></button>';
									}
								}, */
                             {key: "userId", label: "회원아이디", width: "30" ,align: "center",},
                             {key: "san_BIGO", label: "주소", width: "15" ,align: "center",},
                             {key: "userType", label: "회원구분코드", width: "30" ,align: "center",display:false},
                             {key: "userTypeNm", label: "회원구분", width: "30" ,align: "center",},
                             {key: "compCode", label: "출하자코드", width: "30" ,align: "center",display:false},
                             {key: "compCodeNm", label: "출하자코드", width: "*" ,align: "center", formatter:function(){
                            	 
                                   if(this.item.userType=="M"){
                                	   return this.item.compCode;
                                   }else{
                                	   return this.value;
                                   }
                             
                              },
                             },
                             {key:"useYn", label:"사용여부", width:"15", align:"center", formatter:function(){
                                 return (this.value == "Y") ? "사용" :"미사용";
                             },},
                             {key: "remark", label: "산지코드", width: "30" ,align: "center",display:false},
                            {key: "insId", label: "작성자", width: "20" ,align: "center",},
                             {key: "regDt", label: "작성일", width: "15" ,align: "center",},
                             
                         
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
                    		 
								var grid_Data ="&userId=" + this.item.userId
									+"&userType=" + this.item.userType
									+"&compCode=" + this.item.compCode
									+"&useYn=" + this.item.useYn
									+"&remark=" + this.item.remark
									+"&regDt=" + this.item.regDt;
								
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
                     url: "/admin/searchAdminUserList.json",
                     data: '&pageNo2=' + pageNo2 + '&pageSize=' + pageSize
					+ '&startCount=' + startCount + '&endCount=' + endCount
					,
                 },function(res){
                	 
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
					url : "/admin/adminUserUpdatePopup.do",
					pars : ("&" + gridData).queryToObject(),
					top : axdom(window).scrollTop() + 30,
					closeByEscKey : true
				});
			},
	};
	jQuery(document.body).ready(function(){fnObj.pageStart()});



</script>