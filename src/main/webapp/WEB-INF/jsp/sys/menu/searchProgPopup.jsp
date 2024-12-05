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
	request.setAttribute("callBack", request.getParameter("callBack"));
	request.setAttribute("itemIndex", request.getParameter("itemIndex"));
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1, maximum-scale=1.0, minimum-scale=1" />
<title>화훼유통정보시스템 모니터요원 입력시스템 </title>
  <!--  css begin  -->
 <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/axicon/axicon.min.css' />" />    
 <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/cocker/AXJ.css' />" id="axu-theme-axisj" />
	    <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/cocker/AXInput.css' />" />
	    <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/cocker/AXSelect.css' />" />
	    <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/cocker/AXSearch.css' />" />
	    <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/cocker/AXGrid.css' />" />
	    <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/cocker/AXTree.css' />" />
  <!--  css end    --> 

   <script type="text/javascript" src="<c:url value='/axisj/jquery/jquery.min.js' />"></script>
  <script type="text/javascript" src="<c:url value='/axisj/dist/AXJ.min.js' />"></script>
  <script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/ax5-polyfill.js' />"></script>
  <script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/modal.js' />"></script>

  
  

  

</head>
<body>
<div id="AXPage" class="bodyHeightDiv">
    <div class="ax-modal-header">
        <div class="ax-col-12">
            <div class="ax-unit">
<!-- @@@@@@@@@@@@@@@@@@@@@@ header begin @@@@@@@@@@@@@@@@@@@@@@ -->
                
<!-- @@@@@@@@@@@@@@@@@@@@@@ header end   @@@@@@@@@@@@@@@@@@@@@@ -->
            </div>
        </div>
        <div class="ax-clear"></div>
    </div>
    <div class="ax-modal-body">
        <div class="ax-wrap">
            <div class="ax-layer">
                <div class="ax-col-12">
<!-- @@@@@@@@@@@@@@@@@@@@@@ contents begin @@@@@@@@@@@@@@@@@@@@@@ -->
                    
		<div id="row-1231" class="ax-layer " style="">
	
			<div id="col-1231" class="ax-col-12">
	<div class="ax-unit">
		<div class="ax-box " style="">
            <div class="ax-box-wrap">
                

				<div class="ax-search" id="page-search-box"></div>
				<!--
				<div class="ax-button-group">
					<div class="left">

					</div>
					<div class="right">
						<button type="button" class="AXButton" id="ax-grid-btn-add"><i class="axi axi-search"></i> 이전</button>
						<button type="button" class="AXButton" id="ax-grid-btn-add"><i class="axi axi-search"></i> 다음</button>
					</div>
					<div class="ax-clear"></div>
				</div>
				-->
				<div class="ax-grid" id="page-grid-box" style="height:300px;"></div>

			
			</div>
		</div>
		<div class="ax-clear"></div>
		<div class="H10 DX-H10"></div>
	</div>
</div>
		
	<div class="ax-clear"></div>
</div>
	
<!-- @@@@@@@@@@@@@@@@@@@@@@ contents end   @@@@@@@@@@@@@@@@@@@@@@ -->
                </div>
                <div class="ax-clear"></div>
            </div>
        </div>
    </div>
    <div class="ax-modal-footer">
        <div class="ax-wrap">
            <div class="ax-col-12">
                <div class="ax-unit center">
<!-- @@@@@@@@@@@@@@@@@@@@@@ contents begin @@@@@@@@@@@@@@@@@@@@@@ -->
                    
		<button type="button" class="AXButton" onclick="fnObj.control.save();">확인</button>
		<button type="button" class="AXButton" onclick="fnObj.control.clear();">선택안함</button>
		<button type="button" class="AXButton" onclick="fnObj.control.cancel();">취소</button>
	
<!-- @@@@@@@@@@@@@@@@@@@@@@ contents end   @@@@@@@@@@@@@@@@@@@@@@ -->
                </div>
            </div>
            <div class="ax-clear"></div>
        </div>
    </div>
</div>

		<script type="text/javascript">
			var callBackName = "${callBack}";
			var itemIndex = "${itemIndex}";
			var fnObj = {
				pageStart: function(){
					this.search.bind();
					this.grid.bind();
					this.bindEvent();
				},
				pageResize: function(){
					parent.myModal.resize();
				},
				bindEvent: function(){

				},

				search: {
					target: new AXSearch(),
					get: function() { return this.target },
					bind: function() {
						var _this = this;
						var _target = this.target;
						this.target.setConfig({
							targetID: "page-search-box",
							theme : "AXSearch",
							/*
							 mediaQuery: {
							 mx:{min:0, max:767}, dx:{min:767}
							 },
							 */
							onsubmit: function(){
								// 버튼이 선언되지 않았거나 submit 개체가 있는 경우 발동 합니다.
								//_this.submit();
								setPage(1);
							},
							rows:[
								{display:true, addClass:"", style:"", list:[
									{label:"프로그램코드/명", labelWidth:100, type:"inputText", width:"150", key:"searchParams", value:""},
									{label:"", type:"submit", width:"50", key:"", valueBoxStyle:"padding-left:0px;", value:"찾기"}
								]}
							]
						});
						//axdom("#" + this.target.getItemId("inputText1")).attr("readonly", "readonly");
					},
					submit: function(){
						fnObj.grid.setPage(fnObj.grid.pageNo, this.target.getParam())
					}
				}, // search

				grid: {
					pageNo: 1,
					target: new AXGrid(),
					bind: function() {
						var _this = this;
						this.target.setConfig({
							targetID : "page-grid-box",
							theme : "AXGrid",
							colHeadAlign:"center",
							colGroup: [
								{key:"progCd", label:"코드", width:"150"},
								{key:"progNm", label:"프로그램명", width:"*"}
							],
							body: {
								onclick: function() {
									//toast.push(Object.toJSON({index:this.index, item:this.item}));
									//fnObj.modal.open("gridView", this.item);
								}
							},
							page: {
								display: true,
								paging: false,
								onchange: function(pageNo){  // 체크
									_this.setPage(pageNo);
								}
							}
						});
						this.setPage(fnObj.grid.pageNo); // 체크
					},
					setPage: function(pageNo, searchParams){ // 체크
						var _target = this.target;
						fnObj.grid.pageNo = pageNo;

						app.ajax({
							type: "GET",
							url: "/sys/prog/searchProgList.json",
							data: "pageNumber=" + (pageNo-1) + "&pageSize=50&" + (searchParams||"")
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
								_target.setData(gridData);
							}
						});
					}
				}, // grid

				control: {
					save: function(){

						var result = fnObj.grid.target.getSelectedItem();
						if(result.error) {
							alert("목록을 선택해주세요");
							return false;
						}
						var item = [].concat(result.item);
						app.modal.save(window.callBackName, {
							progCd: item[0].progCd,
							progNm: item[0].progNm
						}, itemIndex);
					},
					clear: function(){
						app.modal.save(window.callBackName, {
							progCd: '',
							progNm: ''
						}, itemIndex);
					},
					cancel: function(){
						app.modal.cancel();
					}
				}
			};
			axdom(document.body).ready(function() {
				fnObj.pageStart();
			});
			axdom(window).resize(fnObj.pageResize);
		</script>
	</body>
</html>