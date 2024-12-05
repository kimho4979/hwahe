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
  <script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/axjApp.js' />"></script>
   <script type="text/javascript" src="<c:url value='/axisj/lib/AXModal.js' />"></script>
  <script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/modal.js' />"></script>
  <script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/ax5-polyfill.js' />"></script>
  
  

  

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
            	<div class="ax-tree" id="page-tree-box" style="height:500px;"></div>			
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
		var myTree = new AXTree();
		var fnObj = {
				pageStart: function(){
					this.tree.bind();
					this.bindEvent();
				},
				pageResize: function(){
					parent.myModal.resize();
				},
				bindEvent: function(){

				},
				tree: {
					clickIndex: 0,
					target: new AXTree(),
					bind: function() {
						var _this = this;
						this.target.setConfig({
							targetID : "page-tree-box",
							theme: "AXTree_none",
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
										return (this.item.useYn == "N") ? '<s>' + this.item.mnuNm + '</s>': this.item.mnuNm;
									}
								}
							],
							body: {
								onclick: function(idx, item) {
									fnObj.tree.clickIndex = this.index;
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
									url: "/sys/menu/activeMenumList.json",
									data: { pageNumber:0, pageSize:10000 }
								},
								function(res) {
									//trace(res.list);

									var list_pointer = {};
									res.list.forEach(function(item){
										if(item.mnuLv == 1) {
											item.mnuUpCd = "__root__";
										}
										item.open = true;
										//item.open = true;
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

				control: {
					save: function(){
						
						var item = fnObj.tree.target.list[fnObj.tree.clickIndex];
						console.log(item);
						if(!item.progCd){
							alert("선택할 수 없는 메뉴 입니다. 하위 아이템을 선택해보세요.");
							return;
						}
						app.modal.save(window.callBackName, item, itemIndex);
					},
					cancel: function(){
						
						app.modal.cancel();
					}
				}
			};
			axdom(document.body).ready(function() {
				fnObj.pageStart();
			});
			//axdom(window).resize(fnObj.pageResize);

		</script>
	</body>
</html>