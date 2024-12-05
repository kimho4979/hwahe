<%@ page import="java.util.*"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1, maximum-scale=1.0, minimum-scale=1" />
<title>화훼유통정보시스템 모니터요원 입력시스템 </title>
  <!--  css begin  -->
 <link rel="stylesheet" type="text/css" href="<c:url value='/rMateChart/rMateChartH5/Assets/Css/rMateChartH5.css' />"/>   
 <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/axicon/axicon.min.css' />" />    
 <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/cocker/AXJ.css' />" id="axu-theme-axisj" />
	    <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/cocker/AXInput.css' />" />
	    <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/cocker/AXSelect.css' />" />
	    <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/cocker/AXSearch.css' />" />
	    <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/cocker/AXGrid.css' />" />
 <link rel="stylesheet" type="text/css" href="<c:url value='/css/hw/sub.css' />" />
 <link rel="stylesheet" type="text/css" href="<c:url value='/css/hw/common_admin.css' />" />
 <link rel="stylesheet" type="text/css" href="<c:url value='/css/hw/main.css' />" />
 <link rel="stylesheet" type="text/css" href="<c:url value='/css/hw/main_nav.css' />" />
  <!--  css end    --> 
  <!-- rMateChartH5 테마 js -->

  
  <!--  css end    --> 
   <script type="text/javascript" src="<c:url value='/axisj/jquery/jquery.min.js' />"></script>
  <script type="text/javascript" src="<c:url value='/axisj/dist/AXJ.min.js' />"></script>
  <script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/ax5-polyfill.js' />"></script>
  <script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/axjApp.js' />"></script>
  <script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/base.js' />"></script>
   <script type="text/javascript" src="<c:url value='/js/main_nav.js' />"></script>
  

  
  <!--  공판장별 경매기록부 첨부시작  -->
  
  <!-- rMateChartH5 라이센스 시작 -->
  <script type="text/javascript" src="<c:url value='/rMateChart/LicenseKey/rMateChartH5License.js' />"></script>
  <!-- rMateChartH5 라이센스 끝-->  
  <!-- 실제적인 rMateChartH5 라이브러리 시작-->
   <script type="text/javascript" src="<c:url value='/rMateChart/rMateChartH5/JS/rMateChartH5.js' />"></script>
  <!-- 실제적인 rMateChartH5 라이브러리 끝-->  

</head>
<body>

<header><!--헤더 시작-->
<%@ include file="/WEB-INF/jsp/inc/IncHeader.jsp" %>
</header><!--헤더 끝-->
<article>
<div class="wrap">
<%@ include file="/WEB-INF/jsp/inc/IncHfSuv.jsp" %>
		<div class="hw_b_content"><!--컨텐츠 내용들어가는곳 시작-->
				<div>
					<h3 class="hw_h3_f">프로그램관리</h3>
					<p class="hw_position_b">관리자 &gt; 프로그램관리 &gt; 프로그램관리</p>
				</div>
				<div class="hw_clear"></div>
				<!-- <div class="hw_infouse_02 infous_01_color infous_01_margin"> 
					<p> <span class="red"> ◎ 이용안내 :</span>  </p>
				</div> -->
				<div class="hw_clear"></div>
					<div id="page-search-box"></div>	
					 <div class="ax-button-group">
					    <div class="right">
					        <button type="button" class="AXButton" id="ax-grid-btn-add"><i class="axi axi-plus-circle"></i> 추가</button>
					        <button type="button" class="AXButton Red" id="ax-page-btn-save"><i class="axi axi-save"></i> 저장</button>
					    </div>
					    <div class="ax-clear"></div>
					</div>
				
				 <div class="ax-clear"></div> 
				 <div class="ax-clear"></div>
				<div class="ax-grid" id="page-grid-box" style="min-height:500px;"></div>
				<div class="hw_clear"></div>
					
		
		</div>	

</div>
<div class="hw_clear"></div>
<footer>
<div id="footer">
<!--<c:import url="/EgovPageLink.do?link=/inc/IncFooter" />-->
<jsp:include page="/WEB-INF/jsp/inc/IncFooter.jsp"/>

</div>

</footer>
</article>
<script type="text/javascript">
var parent_window = parent||opener||window;
var myValidator = new AXValidator();
var loading_mask = new AXMask();
//var myUpload = new AXUpload5();
//var mySearch = new AXSearch();
var AXGrid_instances = [];
var AXTree_instances = [];
var AXSearch_instances =[];


// 삭제금지 엘리먼트의 높이를 조절 해주는 오브젝트 - 2015-05-03
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
                var dto_list = [];
                axf.each(items, function(i, d){
                    if(d._CUD){
                        var item = {
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
                    url: "/sys/prog/saveProgProc.json",
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
	                    targetID:"page-search-box",
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
                                {label:"프로그램 코드/명", labelWidth:"", type:"inputText", width:"150", key:"searchParams", addClass:"", valueBoxStyle:"", value:"",
                                    onChange: function(changedValue){
                                        //아래 2개의 값을 사용 하실 수 있습니다.
                                        //toast.push(Object.toJSON(this));
                                        //dialog.push(changedValue);
                                    }
                                },
                                {label:"", labelWidth:"", type:"button", width:"80", key:"button", addClass:"Red", valueBoxStyle:"padding-left:0px;padding-right:5px;", value:"<span>조회</span>",
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

                    fnObj.grid.setPage(fnObj.grid.pageNo, pars);
	            }
	        },
	        grid: {
                pageNo: 1,
	            target: new AXGrid(),
	            bind: function(){
                    var target = this.target, _this = this;
	                target.setConfig({
	                    targetID : "page-grid-box",
	                    theme : "AXGrid",
                        colHeadAlign:"center",
                        /*
	                    mediaQuery: {
	                        mx:{min:"N", max:767}, dx:{min:767}
	                    },
	                    */
	                    colGroup : [
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
                            {key:"schAh", label:"조회", width:"50", align:"center",
                                editor:{
                                    type:"checkbox",
                                    beforeUpdate: function(val){
                                        return (val == true) ? "Y" : "N";
                                    }
                                }
                            },
                            {key:"savAh", label:"저장", width:"50", align:"center",
                                editor:{
                                    type:"checkbox",
                                    beforeUpdate: function(val){
                                        return (val == true) ? "Y" : "N";
                                    }
                                }
                            },
                            {key:"exlAh", label:"엑셀", width:"50", align:"center",

                                editor:{
                                    type:"checkbox",
                                    beforeUpdate: function(val){
                                        return (val == true) ? "Y" : "N";
                                    }
                                }
                            },
                            {key:"fn1Ah", label:"삭제", width:"50", align:"center",

                                editor:{
                                    type:"checkbox",
                                    beforeUpdate: function(val){
                                        return (val == true) ? "Y" : "N";
                                    }
                                }
                            },
                            {key:"fn2Ah", label:"등록", width:"50", align:"center",
                                editor:{
                                    type:"checkbox",
                                    beforeUpdate: function(val){
                                        return (val == true) ? "Y" : "N";
                                    }
                                }
                            },
                            {key:"fn3Ah", label:"수정", width:"50", align:"center",
                                editor:{
                                    type:"checkbox",
                                    beforeUpdate: function(val){
                                        return (val == true) ? "Y" : "N";
                                    }
                                }
                            },
                            {key:"fn4Ah", label:"FN4", width:"50", align:"center",
                                editor:{
                                    type:"checkbox",
                                    beforeUpdate: function(val){
                                        return (val == true) ? "Y" : "N";
                                    }
                                }
                            },
                            {key:"fn5Ah", label:"FN5", width:"50", align:"center",
                                editor:{
                                    type:"checkbox",
                                    beforeUpdate: function(val){
                                        return (val == true) ? "Y" : "N";
                                    }
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
                                    beforeUpdate: function(val){ // 수정이 처리된 후
                                        // 수정이 된 후 액션.
                                        //console.log(val);
                                        return val.optionValue; //(val.optionValue == "true");
                                    }
                                }
                            },
	                        {key:"remark", label:"ClassName(프로그램 인식코드)", width:"*",
                                editor:{
                                    type:"text"
                                }
                            }
	                    ],
                        colHead : {
                            rows: [
                                [
                                    { colSeq: 0, rowspan: 2, valign: "middle" },
                                    { colSeq: 1, rowspan: 2, valign: "middle" },
                                    { colSeq: 2, rowspan: 2, valign: "middle" },
                                    {colSeq:null, colspan:3, label:"공통버튼", align:"center"},
                                    { colSeq: 6, rowspan: 2, valign: "middle" },
                                    { colSeq: 7, rowspan: 2, valign: "middle" },
                                    { colSeq: 8, rowspan: 2, valign: "middle" },
                                    { colSeq: 9, rowspan: 2, valign: "middle" },
                                    { colSeq: 10, rowspan: 2, valign: "middle" },
                                    { colSeq: 11, rowspan: 2, valign: "middle" },
                                    { colSeq: 12, rowspan: 2, valign: "middle" }
                                ],
                                [
                                    {colSeq:3},
                                    {colSeq:4},
                                    {colSeq:5}
                                ]
                            ]
                        },
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
                    fnObj.grid.pageNo = pageNo;

                    app.ajax({
                        type: "GET",
                        url: "/sys/prog/searchProgList.json",
                        data: "pageNumber=" + (pageNo-1) + "&pageSize=10000&" + (searchParams||"")
                    }, function(res){
                        if(res.error){
                            alert(res.error.message);
                        }
                        else
                        {
                            // 샘플 입니다. 지워주세요
                            var gridData ={};
                            console.log(res.list.length);
                            
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
	    
	</body>
</html>
