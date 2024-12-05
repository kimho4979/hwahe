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

   <!--  css end    --> 
  <!-- rMateChartH5 테마 js -->

  
  <!--  css end    --> 
   <script type="text/javascript" src="<c:url value='/axisj/jquery/jquery.min.js' />"></script>
  <script type="text/javascript" src="<c:url value='/axisj/dist/AXJ.min.js' />"></script>
   <script type="text/javascript" src="<c:url value='/axisj/dist/AXJ.min.js' />"></script>
    <script type="text/javascript" src="<c:url value='/axisj/lib/AXModal.js' />"></script>
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
					<h3 class="hw_h3_f">권한관리</h3>
					<p class="hw_position_b">관리자 &gt; 권한관리 &gt; 그룹권한관리</p>
				</div>
				<div class="hw_clear"></div>
				<!-- <div class="hw_infouse_02 infous_01_color infous_01_margin"> 
					<p> <span class="red"> ◎ 이용안내 :</span>  </p>
				</div> -->
				<div class="hw_clear"></div>
					<div id="page-search-box"></div>					 				
				 <div class="ax-clear"></div> 
				 <div class="ax-clear"></div>
				 <table style="width:100%;" class="tbl-layout">
				  <tr>
				  	<td style="width:40%;">
				  	    <h2><i class="axi axi-list-alt"></i> 권한그룹</h2>
						<div class="ax-grid" id="page-grid-box" style="min-height:300px;"></div>
						
				  	</td>
				  	<td >
 <div class="ax-button-group">
                                <div class="left">
                                    <h2><i class="axi axi-table"></i> 권한그룹 정보</h2>
                                </div>
                                <div class="right">
                                    <button type="button" class="AXButton" id="ax-grid-btn-add"><i class="axi axi-plus-circle"></i> 신규</button>
                                </div>
                                <div class="ax-clear"></div>
                            </div>

                            <form id="table-form" name="table-form" method="get" class="ax-rwd-form " style="" onsubmit="">
							<div class="ax-rwd-table">
		
		                                <input type="hidden" name="act_tp" id="act_tp" value="C" />
		                                <div id="fields-1923" class="item-group " style="">
			
		                                    <div id="field-1922" class=".ax-rwd-table.item-group.item">
		        <div class=".ax-rwd-table.item-group.item.item-lable">
		            <span class="th">권한코드</span>
		            <span class="td inputText " style="min-width:100px;" title="">		                
		                                        <input type="text" name="grpAuthCd" id="grpAuthCd" maxlength="10" class="AXInput W100" value="" />		                                   
		            </span>
		        </div>
		    </div>
		    <div class="item-clear"></div>
		      <div id="field-1923" class="item">
		        <div class="item-lable">
		            <span class="th">권한명</span>
		            <span class="td inputText " style="min-width:200px;" title="">
		                
		                                        <input type="text" name="grpAuthNm" id="grpAuthNm" maxlength="25" class="AXInput W200" value="" />
		                                    
		            </span>
		        </div>
		    </div>
		    <div class="item-clear"></div>
		                                
			<div class="group-clear"></div>
		</div>
		                                <div id="fields-1925" class="item-group " style="">
			
		                                    <div id="field-1925" class="item">
		        <div class="item-lable">
		            <span class="th">비고</span>
		            <span class="td inputText " style="" title="">
		                
		                                        <input type="text" name="remark" id="remark" maxlength="100" class="AXInput W200" value="" />
		                                    
		            </span>
		        </div>
		    </div>
		    <div class="item-clear"></div>
		                                
			<div class="group-clear"></div>
		</div>
		                            
			</div>
		</form>

				  	   
				  	   
				  	   
				  	    <div class="ax-button-group">
                                <div class="left">
                                    <h2><i class="axi axi-list-alt"></i> 권한허용 메뉴목록</h2>
                                </div>
                                <div class="right">
                                    <button type="button" class="AXButton" id="ax-grid2-btn-add"><i class="axi axi-plus-circle"></i> 추가</button>
                                    <button type="button" class="AXButton" id="ax-grid2-btn-del"><i class="axi axi-minus-circle"></i> 삭제</button>
                                </div>
                                <div class="ax-clear"></div>
                            </div>
                          <div class="ax-grid" id="page-grid2-box" style="min-height:150px;"></div>
				  	  
				  	</td>
				  	</tr>
				 </table>
				
					
		
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
                {id:"page-grid-box", adjust:-97},
                {id:"page-grid2-box", adjust:function() {
                    return -$("#table-form").outerHeight() - 97 - 52;
                }}
            ];
            var fnObj = {
                pageStart: function(){
                    this.search.bind();
                    this.grid.bind();
                    this.grid2.bind();
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
                        _this.form.add();
                    });
                    $("#ax-grid-btn-del").bind("click", function(){
                        _this.form.del();
                    });

                    $("#ax-grid2-btn-add").bind("click", function(){
                        _this.grid2.add();
                    });
                    $("#ax-grid2-btn-del").bind("click", function(){
                        _this.grid2.del();
                    });

                    $("#ax-frm-2").bindSelect();
                },

                save: function(){
                    fnObj.form.save();
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
                                mx:{min:0, max:767}, dx:{min:767}
                            },
                            onsubmit: function(){
                                // 버튼이 선언되지 않았거나 submit 개체가 있는 경우 발동 합니다.
                            },
                            rows:[
                                {display:true, addClass:"", style:"", list:[
                                    {label:"검색어", labelWidth:"", type:"inputText", width:"150", key:"searchParams", addClass:"", valueBoxStyle:"", value:"",
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
                        //toast.push("콘솔창에 파라미터 정보를 출력하였습니다.");
                        //trace(pars);
                        fnObj.grid.setPage(0, pars);
                        fnObj.form.add();
                    }
                },
                grid: {
                    pageNo: 0,
                    target: new AXGrid(),
                    bind: function(){
                        var _this = this;
                        _this.target.setConfig({
                            targetID : "page-grid-box",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            /*
                            mediaQuery: {
                                mx:{min:0, max:767}, dx:{min:767}
                            },
                            */
                            colGroup : [
                                {key:"grpAuthCd", label:"그룹코드", width:"70", align:"center"},
                                {key:"grpAuthNm", label:"그룹명", width:"140"},
                                {key:"remark", label:"비고", width:"*"}
                            ],
                            body : {
                                onclick: function(){
                                    //toast.push(Object.toJSON({index:this.index, item:this.item}));
                                    fnObj.form.edit(this.item);
                                }
                            },
                            page:{
                                display:true,
                                paging:false,
                                onchange: function(pageNo){
                                    _this.setPage(pageNo-1);
                                }
                            }
                        });
                        this.setPage(this.pageNo);
                    },
                    setPage: function(pageNo, searchParams) {
                        var _this = this;
                        _this.pageNo = pageNo;
                        app.ajax({
                            type: "GET",
                            url: "/sys/group/groupList.json",
                            data: "pageNumber=" + (pageNo) + "&pageSize=50&" + (searchParams||fnObj.search.target.getParam())
                        }, function(res){
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
                    }
                },
                grid2: {
                    removedList: [],
                    target: new AXGrid(),
                    bind: function(){
                        this.target.setConfig({
                            targetID : "page-grid2-box",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            /*
                            mediaQuery: {
                                mx:{min:0, max:767}, dx:{min:767}
                            },
                            */
                            colGroup : [
                                {key:"index", label:"구분", width:"40", align:"center", formatter:"checkbox"},
                                {key:"mnuCd", label:"메뉴코드", width:"180", align:"left",
                                    formatter: function(){
                                        return ((this.value||"") == "") ? "<span style='color:#ff3300;'>메뉴를 선택하세요.</span>" : this.value;
                                    },
                                    editor:{
                                        type:"finder",
                                        finder:{
                                            onclick: function(){
                                            	
                                              app.modal.open({
                                                    url:"/sys/menu/searchMenuPopup.do",
                                                    pars:"callBack=fnObj.grid2.setMnuCd&itemIndex=" + this.index, // callBack 말고
                                                    width:500 // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
                                                    //top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
                                                });
                                            }
                                        }
                                    }
                                },
                                {key:"mnuNm", label:"메뉴", width:"200",
                                    formatter: function(){
                                        return ((this.value||"") == "") ? "<span style='color:#ff3300;'>메뉴를 선택하세요.</span>" : this.value;
                                    },
                                    editor:{
                                        type:"finder",
                                        finder:{
                                            onclick: function(){
                                                app.modal.open({
                                                    url:"/sys/menu/searchMenuPopup.do",
                                                    pars:"callBack=fnObj.grid2.setMnuCd&itemIndex=" + this.index, // callBack 말고
                                                    width:500 // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
                                                    //top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
                                                });
                                            }
                                        }
                                    }
                                },
                                {key:"schAh", label:"조회", width:"50", align:"center",
                                    editor:{
                                        type:"checkbox",
                                        beforeUpdate: function(val){
                                            return (val == true) ? "Y" : "N";
                                        },
                                        disabled: function(){
                                            return this.item.progSchAh == "N";
                                        }
                                    }
                                },
                                {key:"savAh", label:"저장", width:"50", align:"center",
                                    editor:{
                                        type:"checkbox",
                                        beforeUpdate: function(val){
                                            return (val == true) ? "Y" : "N";
                                        },
                                        disabled: function(){
                                            return this.item.progSavAh == "N";
                                        }
                                    }
                                },
                                {key:"exlAh", label:"엑셀", width:"50", align:"center",
                                    editor:{
                                        type:"checkbox",
                                        beforeUpdate: function(val){
                                            return (val == true) ? "Y" : "N";
                                        },
                                        disabled: function(){
                                            return this.item.progExlAh == "N";
                                        }
                                    }
                                },
                                {key:"fn1Ah", label:"삭제", width:"50", align:"center",
                                    editor:{
                                        type:"checkbox",
                                        beforeUpdate: function(val){
                                            return (val == true) ? "Y" : "N";
                                        },
                                        disabled: function(){
                                            return this.item.progFn1Ah == "N";
                                        }
                                    }
                                },
                                {key:"fn2Ah", label:"FN2", width:"50", align:"center",
                                    editor:{
                                        type:"checkbox",
                                        beforeUpdate: function(val){
                                            return (val == true) ? "Y" : "N";
                                        },
                                        disabled: function(){
                                            return this.item.progFn2Ah == "N";
                                        }
                                    }
                                },
                                {key:"fn3Ah", label:"FN3", width:"50", align:"center",
                                    editor:{
                                        type:"checkbox",
                                        beforeUpdate: function(val){
                                            return (val == true) ? "Y" : "N";
                                        },
                                        disabled: function(){
                                            return this.item.progFn3Ah == "N";
                                        }
                                    }
                                },
                                {key:"fn4Ah", label:"FN4", width:"50", align:"center",
                                    editor:{
                                        type:"checkbox",
                                        beforeUpdate: function(val){
                                            return (val == true) ? "Y" : "N";
                                        },
                                        disabled: function(){
                                            return this.item.progFn4Ah == "N";
                                        }
                                    }
                                },
                                {key:"fn5Ah", label:"FN5", width:"50", align:"center",
                                    editor:{
                                        type:"checkbox",
                                        beforeUpdate: function(val){
                                            return (val == true) ? "Y" : "N";
                                        },
                                        disabled: function(){
                                            return this.item.progFn5Ah == "N";
                                        }
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
                                        { colSeq: 10, rowspan: 2, valign: "middle" }
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
                                paging:false
                            }
                        });
                    },
                    setList: function(list){
                        this.target.setList(list);
                    },
                    add: function(){
                        fnObj.grid2.target.pushList(
                            {
                                "grpAuthCd": $("#grpAuthCd").val(),
                                "mnuCd":"",
                                "mnuNm":"",
                                "progCd":"",
                                "progNm":"",
                                "schAh":"N",
                                "savAh":"N",
                                "exlAh":"N",
                                "fn1Ah":"N",
                                "fn2Ah":"N",
                                "fn3Ah":"N",
                                "fn4Ah":"N",
                                "fn5Ah":"N",
                                "progSchAh":"N",
                                "progSavAh":"N",
                                "progExlAh":"N",
                                "progFn1Ah":"N",
                                "progFn2Ah":"N",
                                "progFn3Ah":"N",
                                "progFn4Ah":"N",
                                "progFn5Ah":"N"
                            }
                        );
                        fnObj.grid2.target.setFocus(fnObj.grid2.target.list.length-1);
                    },
                    del: function(){
                        var checkedList = fnObj.grid2.target.getCheckedListWithIndex(0);// colSeq
                        if(checkedList.length == 0){
                            alert("선택된 목록이 없습니다. 삭제하시려는 목록을 체크하세요");
                            return;
                        }

                        for(var i= 0, l=checkedList.length;i<l;i++){
                            if(checkedList[i].item._CUD != "C" && checkedList[i].item.mnuCd != "") fnObj.grid2.removedList.push(checkedList[i].item.mnuCd);
                        }
                        //todo 삭제목록 담기
                        fnObj.grid2.target.removeListIndex(checkedList);
                    },
                    setMnuCd: function(item, itemIndex){
                        //trace(item);
                        var update_item = {
                            "grpAuthCd": $("#grpAuthCd").val(),
                            "mnuCd": item.mnuCd,
                            "mnuNm": item.mnuNm,
                            "progCd": item.progCd,
                            "progNm": item.progNm,
                            "schAh":"N",
                            "savAh":"N",
                            "exlAh":"N",
                            "fn1Ah":"N",
                            "fn2Ah":"N",
                            "fn3Ah":"N",
                            "fn4Ah":"N",
                            "fn5Ah":"N",
                            "progSchAh": item.program.schAh,
                            "progSavAh": item.program.savAh,
                            "progExlAh": item.program.exlAh,
                            "progFn1Ah": item.program.fn1Ah,
                            "progFn2Ah": item.program.fn2Ah,
                            "progFn3Ah": item.program.fn3Ah,
                            "progFn4Ah": item.program.fn4Ah,
                            "progFn5Ah": item.program.fn5Ah
                        };
                        fnObj.grid2.target.updateList(itemIndex, update_item);
                        app.modal.close();
                    }
                },
                form: {
                    target: document["table-form"],
                    init:function(){
                        fnObj.grid2.removedList = []; // 삭제된 목록 초기화
                        var collect = [];
                        axf.each(fnObj.grid2.target.list, function(i, item){
                            collect.push({ index: i, item: item });
                        });
                        if(collect.length > 0 ) fnObj.grid2.target.removeListIndex(collect);
                    },
                    add: function(){
                        this.init();
                        var frm = this.target;
                        frm.reset();
                        $("#act_tp").val("C");
                        $("#grpAuthCd").removeAttr("readonly");
                        fnObj.grid2.target.setList([]);
                    },
                    del:function(){
                        if(axdom("#act_tp").val() == "C"){
                            toast.push("선택된 권한 그룹이 없습니다.");
                            return false;
                        }
                        if(!confirm("정말 삭제하시겠습니까?")) return;

                        app.ajax({
                            type: "DELETE",
                            url: "/sys/group/deleteAuthGroupProc.json?grpAuthCd="+$("#grpAuthCd").val(),
                            data: ""
                        }, function(res){
                            if(res.error){
                                alert(res.error.message);
                            }
                            else
                            {
                                toast.push("삭제 되었습니다.");
                                // 그리드 새로고침
                                fnObj.search.submit();
                            }
                        });

                    },
                    edit: function(item){
                        this.init();

                        $("#act_tp").val("U");

                        $("#grpAuthCd").attr("readonly", "readonly");
                        $("#grpAuthCd").val(item.grpAuthCd);
                        $("#grpAuthNm").val(item.grpAuthNm);
                        $("#remark").val(item.remark);

                        loading_mask.open();

                        app.ajax({
                            type: "GET",
                            url: "/sys/group/authGroupMenuList.json",
                            data: "grpAuthCd=" + item.grpAuthCd
                        }, function(res){
                        	console.log(res);
                        	
                            if(res.error){
                                alert(res.error.message);
                            }
                            else
                            {
                                // 그리드 새로고침
                                var list = [];
                                if(res.list!=null){
	                                for(var i= 0,l=res.list.length;i<l;i++){
	                                    if(res.list[i].progCd) list.push(res.list[i]);
	                                    
	                                }
	                                if(res.list.length>0){
	                                	fnObj.grid2.setList(list);
	                                }
                                }	
                                
                            }
                        });

                    },
                    save: function(){
                        //alert("저장");
                        var item = app.form.serializeObjectWithIds($("#table-form"));
                        //trace(item);

                        if(item.grpAuthCd == ""){
                            alert("권한코드를 입력하세요");
                            $("#grpAuthCd").focus();
                            return;
                        }
                        if(item.grpAuthNm == ""){
                            alert("권한명를 입력하세요");
                            $("#grpAuthNm").focus();
                            return;
                        }

                        //trace(fnObj.grid2.target.list);
                        var update_list = [];
                        for(var i= 0, l=fnObj.grid2.target.list.length;i<l;i++){
                            if(fnObj.grid2.target.list[i].mnuCd != "") {
                                //fnObj.grid2.target.list[i]
                                if(fnObj.grid2.target.list[i]["progSchAh"] == "N") fnObj.grid2.target.list[i]["schAh"] = "N";
                                if(fnObj.grid2.target.list[i]["progSavAh"] == "N") fnObj.grid2.target.list[i]["savAh"] = "N";
                                if(fnObj.grid2.target.list[i]["progExlAh"] == "N") fnObj.grid2.target.list[i]["exlAh"] = "N";
                                if(fnObj.grid2.target.list[i]["progFn1Ah"] == "N") fnObj.grid2.target.list[i]["fn1Ah"] = "N";
                                if(fnObj.grid2.target.list[i]["progFn2Ah"] == "N") fnObj.grid2.target.list[i]["fn2Ah"] = "N";
                                if(fnObj.grid2.target.list[i]["progFn3Ah"] == "N") fnObj.grid2.target.list[i]["fn3Ah"] = "N";
                                if(fnObj.grid2.target.list[i]["progFn4Ah"] == "N") fnObj.grid2.target.list[i]["fn4Ah"] = "N";
                                if(fnObj.grid2.target.list[i]["progFn5Ah"] == "N") fnObj.grid2.target.list[i]["fn5Ah"] = "N";
                                update_list.push(fnObj.grid2.target.list[i]);
                            }
                        }


                        var delete_pars = [];
                        for(var i= 0, l=fnObj.grid2.removedList.length;i<l;i++) {
                            delete_pars.push("mnuCd=" + fnObj.grid2.removedList[i]);
                        }


                        // step 권한그룹명 저장
                        app.ajax(
                            {
                            type:"PUT",
                            url:"/sys/group/saveAuthGroup.json",
                            data: Object.toJSON([item])
                            },
                            function(res){
                                if(res.error){
                                    alert(res.error.message);
                                }
                                else
                                {

                                    var put_fn = function(){
                                        // step 권한그룹메뉴 등록
                                        //trace(update_list);
                                        app.ajax({
                                            type:"PUT",
                                            url:"/sys/group/saveAuthGroupMenu.json",
                                            data: Object.toJSON(update_list)
                                        }, function(res) {
                                            // step 권한그룹메뉴 등록
                                            if(res.error){
                                                alert(res.error.message);
                                            }
                                            else {
                                                toast.push("저장 되었습니다.");
                                                fnObj.grid.setPage(fnObj.grid.pageNo);
                                                fnObj.form.add();
                                            }
                                        });
                                    };

                                    // step 권한그룹메뉴 삭제
                                    if(delete_pars.length > 0){
                                        //trace("grpAuthCd="+ $("#grpAuthCd").val() +"&" + delete_pars.join("&"));
                                        app.ajax({
                                            type:"DELETE",
                                            url:"/sys/group/deleteAuthGroupMenuProc.json?" + "grpAuthCd="+ $("#grpAuthCd").val() +"&" + delete_pars.join("&"),
                                            data: ""
                                        }, function(res) {

                                            if(res.error){
                                                alert(res.error.message);
                                            }
                                            else {
                                                put_fn();
                                            }
                                        });
                                    }else{
                                        put_fn();
                                    }

                                }
                            }
                        );


                    }
                }
            };

jQuery(document.body).ready(function(){fnObj.pageStart()});

 </script>
	    
	</body>
</html>
