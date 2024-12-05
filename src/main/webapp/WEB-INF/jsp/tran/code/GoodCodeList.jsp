<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	  <title>화훼유통정보시스템 전송시스템::: </title>
	  <!-- @@@@@@@@@@@@@@@@@@@@@@ css begin @@@@@@@@@@@@@@@@@@@@@@ -->
	    <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/axicon/axicon.min.css' />" />    
	   <%--   <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/cocker/cmn/admin.css' />" /> --%>
	    <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/cocker/AXJ.css' />" id="axu-theme-axisj" />
	    <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/cocker/AXInput.css' />" />
	    <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/cocker/AXSelect.css' />" />
	    <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/cocker/AXSearch.css' />" />
	    <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/cocker/AXGrid.css' />" />
	    <link rel="stylesheet" type="text/css" href="<c:url value='/css_trans/css/sub.css' />" />	 
	   <!-- @@@@@@@@@@@@@@@@@@@@@@ css end @@@@@@@@@@@@@@@@@@@@@@ -->
	
	      
	<!-- @@@@@@@@@@@@@@@@@@@@@@ javascript START @@@@@@@@@@@@@@@@@@@@@@ --> 
	 <script type="text/javascript" src="<c:url value='/axisj/jquery/jquery.min.js' />"></script>
	  <script type="text/javascript" src="<c:url value='/axisj/dist/AXJ.min.js' />"></script>
	  <script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/ax5-polyfill.js' />"></script>	  
	  <script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/axjApp.js' />"></script>
	  <script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/base.js' />"></script>
	  	 <script type="text/javascript" src="<c:url value='/js/login.js'/>"></script>	

	  
	
	       
	 <!-- @@@@@@@@@@@@@@@@@@@@@@ javascript END @@@@@@@@@@@@@@@@@@@@@@ --> 
  
	</head>
<body>
<body>
<header><!--헤더 시작-->
</header>


<article> 
	<div class="wrap">
		<div class="logo"><a href="/tran/main.do"><img src="<c:url value='/images/logo.png'/>"/></a></div>
		<div style="float:right;margin-right:30px;"><a href="javascript:fnLogOut();"><i class="axi axi-power-off"></i> 로그아웃</a></div>		
		
		<div class="content">
			<div class="title"><i class="axi axi-list"></i>폼목(종)코드조회 </div>
			
			<!--  검색조건  -->
			
		  		<div id="AXSearchTarget" style="border-top:1px solid #ccc;"></div>
		  		<br/>
		  		<div class="a_table">
		  		    <div id="AXGridTarget" style="height:400px;"></div>
		  		</div>
	
	 	</div>
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

<script>

	/**
	 * Require Files for AXISJ UI Component...
	 * Based		: jQuery
	 * Javascript 	: AXJ.js, AXInput.js, AXSelect.js, AXSearch.js, AXGrid.js, AXTab.js, AXButton.js
	 * CSS			: AXJ.css, AXInput.css, AXSelect.css, AXSearch.css, AXGrid.css, AXTab.css, AXButton.css
	 */	
	var mySearch = new AXSearch();

	
	var fnObj = {
		pageStart: function(){
			//검색도구 설정 01 ---------------------------------------------------------
			mySearch.setConfig({
				targetID:"AXSearchTarget",
				theme : "AXSearch",
               /* mediaQuery: {
                    mx:{min:0, max:767}, dx:{min:767}
                }, */
				onsubmit: function(){
					//fnObj.search1(); // 버튼이 선언되지 않았거나 submit 개체가 있는 경우 발동 합니다.
				},
				rows:[
					{display:true, addClass:"", style:"", list:[
						{label:"검색", labelWidth:"", type:"inputText", width:"150", key:"searchParams", addClass:"", valueBoxStyle:"", value:"",
                                        onChange: function(changedValue){
                                            //아래 2개의 값을 사용 하실 수 있습니다.
                                            //toast.push(Object.toJSON(this));
                                            //dialog.push(changedValue);
                                        }
                         },
						 {label:"", labelWidth:"", type:"button", width:"80", key:"button", addClass:"Green", valueBoxStyle:"padding-left:10px;padding-right:10px;", value:"조회",
 							onclick: function(){            								
 								fnObj.search1();
 							}
 						} 

					]},
					
					
				]
			});
			//검색도구 설정 01 ---------------------------------------------------------
			  fnObj.grid.bind();
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
                             {key: "large", label: "대분류", width: "80" ,align: "center",},
                             {key: "largeName", label: "대분류명", width: "100" ,align: "center",},
                             {key: "midCode", label: "중분류", width: "80" ,align: "center",},
                             {key: "midName", label: "중분류명", width: "100" ,align: "center",},
                             {key: "stdCode", label: "소분류", width: "100" ,align: "center",},
                             {key: "goodName", label: "소분류명", width: "*" ,align: "center",},
                            
                         
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

                 fnObj.grid.setPage(fnObj.grid.pageNo);

             },
             setPage: function(pageNo, searchParams) {
                 var _this = this;
                 _this.pageNo = pageNo;
                 app.ajax({
                     type: "GET",
                     url: "/code/GoodCodeList.json",
                     data: "pageNumber=" + (pageNo-1) + "&pageSize=50&" + (searchParams||mySearch.getParam())
                 }, function(res){
                	 
                	        console.log(res);
                     if(res.error){
                         alert(res.error.message);
                     }
                     else
                     {
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
            
	};
	jQuery(document.body).ready(function(){fnObj.pageStart()});

</script>
</body>
</html>




