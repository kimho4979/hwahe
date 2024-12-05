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
	    <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/cocker/AXTree.css' />" />
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
					<h3 class="hw_h3_f">메뉴관리</h3>
					<p class="hw_position_b">관리자 &gt; 메뉴관리 &gt; 메뉴관리</p>
				</div>
				<div class="hw_clear"></div>
				<!-- <div class="hw_infouse_02 infous_01_color infous_01_margin"> 
					<p> <span class="red"> ◎ 이용안내 :</span>  </p>
				</div> -->
				<div class="hw_clear"></div>
				<table>
					<tr>
						<td style="width:40%;">
							<div class="ax-button-group">
								<div class="left">
									<h2><i class="axi axi-list-alt"></i> 카테고리 선택</h2>
								</div>
								<div class="right">
									<!--button type="button" class="AXButton" id="ax-grid-btn-add"><i class="axi axi-plus-circle"></i> 신규</button-->
								</div>
								<div class="ax-clear"></div>
							</div>

							<div class="ax-tree" id="page-tree-box" style="height: 400px;"></div>
						</td>
						<td style="width:60%;">
							<div class="ax-button-group">
                                <div class="left">
                                    <h2>
                                        <i class='axi axi-folder-open-o'></i>
                                      	  상위메뉴
                                        <input type="text" name="parent_cd" id="parent_cd" class="AXInput W80" readonly="readonly" />
                                        <input type="text" name="parent_nm" id="parent_nm" class="AXInput W150" readonly="readonly" />
                                    </h2>
                                </div>
                                <div class="right">
                                    <button type="button" class="AXButton" id="ax-grid-btn-add"><i class="axi axi-plus-circle"></i> 추가</button>
                                    <button type="button" class="AXButton" id="ax-grid-btn-del"><i class="axi axi-minus-circle"></i> 삭제</button>
                                </div>
                                <div class="ax-clear"></div>
                            </div>

							<div class="ax-grid" id="page-grid-box"></div>
					    </td>
				    </tr>
				</table>
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

	var resize_elements = [
       				{id:"page-grid-box", adjust:function(){
       					return -$("#page-grid-box-sbar").height() - 14;
       				}},
       				{id:"page-tree-box", adjust:-56}
       			];
       			var fnObj = {
       				pageStart: function(){
       					this.tree.bind();
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
       					$("#ax-grid-btn-del").bind("click", function(){
       						_this.grid.del();
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
                                       mnuCd: (d.mnuCd || ""),
                                       mnuUpCd: (d.mnuUpCd || ""),
                                       mnuNm: (d.mnuNm || ""),
                                       mnuIx: (d.mnuIx || ""),
                                       useYn: (d.useYn || "N"),
                                       mnuLv: (d.mnuLv || ""),
                                       progCd: (d.progCd || "")
                                   };
                                   dto_list.push(item);
                               }
                           });

                           app.ajax({
                               type: "PUT",
                               url: "/sys/menu/menuProc.json",
                               data: Object.toJSON(dto_list)
                           }, function(res){
                               if(res.error){
                                   alert(res.error.message);
                               }
                               else
                               {
                                   toast.push("저장되었습니다.");
                                   fnObj.tree.load();
                               }
                           });

                           //console.log(fnObj.grid.list);
                       },
                       excel: function(){

                       },

         			  tree: {
       					clickIndex: 0,
       					target: new AXTree(),
       					get: function() { return this.target; },
       					bind: function() {
       						var _this = this;
       						this.target.setConfig({
       							targetID : "page-tree-box",
       							theme: "AXTree_none",
       							xscroll:true,
       							relation:{
       								parentKey:"mnuUpCd",
       								childKey:"mnuCd"
       							},
       							reserveKeys: {
       								parentHashKey:"pHash", // 부모 트리 포지션
       								hashKey:"hash", // 트리 포지션
       								openKey:"open", // 확장여부
       								subTree:"cn", // 자식개체키
       								displayKey:"display" // 표시여부
       							},
       							colGroup: [
       								{key:"mnuNm", label:"제목", width:"*", align:"left", indent:true,
       									getIconClass: function(){
       										if(this.item.__subTreeLength > 0){
       											return {
       												addClass:"userHtml",
       												html:"<i class='axi axi-folder-open-o'></i>"
       											};
       										}else{
       											return {
       												addClass:"userHtml",
       												html:"<i class='axi axi-file-o'></i>"
       											};
       										}
       									},
       									formatter:function(){
       										//return "<b>"+this.item.no.setDigit(2) + "</b> : " + this.item.nodeName + " (" + this.item.writer + ")";
       										return this.item.mnuNm;
       									}
       								}
       							],
       							body: {
       								onclick: function(idx, item) {
       									fnObj.tree.clickIndex = this.index;
       									fnObj.tree.mnuLv = (this.item.mnuLv || 0);

       									$("#parent_cd").val(this.item.mnuCd);
       									$("#parent_nm").val(this.item.mnuNm);

       									fnObj.grid.setList(this.subTree.cn);
       								}
       							}
       						});

       						this.load();
       					},
       					load: function(){
       						var _this = this;
       						app.ajax(
       							{
       								type: "GET",
       								url: "/sys/menu/menuProgmList.json",
       								data: { pageNumber:0, pageSize:10000 }
       								
       							},
       							function(res) {
                                       console.log(res);
                                       
       								res.list.forEach(function(item){
       									if(item.mnuLv == 1) item.mnuUpCd = "__root__"
       								});

       								res.list.splice(0, 0, {
       									mnuCd: "__root__",
       									mnuNm: "메뉴",
       									open: true
       								});

       								fnObj.tree.target.setList(res.list);
       								fnObj.tree.target.click(_this.clickIndex, "open");
       							}
       						);
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
       								{key:"mnuCd", label:"구분", width:"40", align:"center", formatter:"checkbox", disabled: function(){
       									return (this.item._CUD != "C");
       								}},
       								{key:"mnuCd", label:"메뉴코드", width:"140",
       									editor:{
       										type:"text",
       										maxLength: 50,
       										disabled: function(){
       											return this.item._CUD != "C";
       										}
       									}
       								},
       								{key:"mnuNm", label:"메뉴명", width:"200",
       									editor:{
       										type:"text",
       										maxLength: 50
       									}
       								},
       								{key:"mnuIx", label:"정렬", width:"60", align:"center",
       									editor:{
       										type:"number"
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
       								{key:"mnuLv", label:"LEVEL", width:"70", align:"center",
       									editor:{
       										type:"number"
       									}
       								},
       								{key:"progCd", label:"프로그램코드", width:"140",
       									formatter: function(){
       										return ((this.value||"") == "") ? "<span style='color:#ff3300;'>프로그램을 선택하세요.</span>" : this.value;
       									},
       									editor: {
       										type: "finder",
       										finder: {
       											onclick: function(){
       												app.modal.open({
       													url:"/sys/menu/searchProgPopup.do",
       													pars:"callBack=fnObj.grid.setProgCd&itemIndex=" + this.index, // callBack 말고
       													width:500 // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
       													//top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
       												});
       											}
       										}
       									}
       								},
       								{key:"progNm", label:"프로그램명", width:"200",
       									formatter: function(){
       										return ((this.value||"") == "") ? "<span style='color:#ff3300;'>프로그램을 선택하세요.</span>" : this.value;
       									},
       									editor: {
       										type: "finder",
       										finder: {
       											onclick: function(){
       												app.modal.open({
       													url:"/sys/menu/searchProgPopup.do",
       													pars:"callBack=fnObj.grid.setProgCd&itemIndex=" + this.index, // callBack 말고
       													width:500 // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
       													//top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
       												})
       											}
       										}
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
       						//this.setPage(fnObj.grid.pageNo);
       					},
       					add:function(){
       						// $("#parent_cd").val()
       						this.target.pushList(
       							{
       								mnuCd: "",
       								mnuUpCd: $("#parent_cd").val(),
       								mnuNm: "",
       								mnuIx: "",
       								useYn: "Y",
       								mnuLv: Number(fnObj.tree.mnuLv) + 1,
       								progCd: ""
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
       					setList: function(list){
       						this.target.setList(list);
       					},
       					setProgCd: function(item, itemIndex){
       						fnObj.grid.target.updateItem(0, 6, itemIndex, item.progCd);
       						fnObj.grid.target.updateItem(0, 7, itemIndex, item.progNm);
       						app.modal.close();
       					}
       				}
       			};


jQuery(document.body).ready(function(){fnObj.pageStart()});

 </script>
	    
	</body>
</html>
