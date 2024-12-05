<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>

<ax:layout name="base.jsp">
   <ax:set name="title" value="${jspPageInfo.getMenuName()}" />
	<ax:set name="page_desc" value="${pageRemark}" />
	<ax:div name="contents">
		<ax:row>
			<ax:col size="12">
               <ax:custom customid="page-button" pageId="${jspPageInfo.getPageId()}" searchAuth="${jspPageInfo.getSearchAuth()}" saveAuth="${jspPageInfo.getSaveAuth()}" excelAuth="${jspPageInfo.getExcelAuth()}" function1Auth="${jspPageInfo.getFunction1Auth()}" function2Auth="${jspPageInfo.getFunction2Auth()}" function3Auth="${jspPageInfo.getFunction3Auth()}" function4Auth="${jspPageInfo.getFunction4Auth()}" function5Auth="${jspPageInfo.getFunction5Auth()}"></ax:custom> 

                <div class="ax-search" id="page-search-box"></div>
				<div class="ax-button-group">
				    <div class="right">
				        <button type="button" class="AXButton" id="ax-grid-btn-add"><i class="axi axi-plus-circle"></i> 추가</button>
				    </div>
				    <div class="ax-clear"></div>
				</div>
				<div class="ax-grid" id="page-grid-box"></div>
			</ax:col>
		</ax:row>
	</ax:div>
	<ax:div name="scripts">
	    <script type="text/javascript">
        var resize_elements = [
            {id:"page-grid-box", adjust:-97}
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
                        _this.search.save();
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
	        search: {
	            target: new AXSearch(),
	            get: function(){ return this.target },
	            bind: function(){
                    var _this = this;
                    this.target.setConfig({
	                    targetID:"page-search-box",
	                    theme : "AXSearch",
                        /*
	                    mediaQuery: {
	                        mx:{min:"N", max:767}, dx:{min:767}
	                    },
	                    */
	                    onsubmit: function(){
	                        // 버튼이 선언되지 않았거나 submit 개체가 있는 경우 발동 합니다.
                            fnObj.search.submit();
	                    },
	                    rows:[
                            {display:true, addClass:"", style:"", list:[
                                {label:"검색", labelWidth:"", type:"inputText", width:"150", key:"searchParams", addClass:"", valueBoxStyle:"", value:"",
                                    onChange: function(changedValue){
                                        //아래 2개의 값을 사용 하실 수 있습니다.
                                        //toast.push(Object.toJSON(this));
                                        //dialog.push(changedValue);
                                    }
                                }
                            ]}
	                    ]
	                });
	            },
                makeParam:function(){
                    var grid_list = myGrid.list;
                    var dto_list = [];
                    axf.each(grid_list, function(i, d){
                        if(d._CUD){
                            var item = {
                                basicCd : (d.basicCd || ""),
                                basicNm : (d.basicNm || ""),
                                code    : (d.code    || ""),
                                name    : (d.name    || ""),
                                sort    : (d.sort    || ""),
                                data1   : (d.data1   || ""),
                                data2   : (d.data2   || ""),
                                data3   : (d.data3   || ""),
                                data4   : (d.data4   || ""),
                                data5   : (d.data5   || ""),
                                posUseYn: (d.posUseYn || "N"),
                                useYn   : (d.useYn || "N"),
                                remark  : (d.remark  || "")
                            };
                            dto_list.push(item);
                        }
                    });
                    return dto_list;
                },
                save: function(){
                    var items = myGrid.list;
                    if (items.length == 0) {
                        alert("저장할 내용이 없습니다.");
                        return;
                    }
                    var dto_list = this.makeParam();
                    trace(dto_list);
                    var sDtoList = JSON.stringify(dto_list);
                    trace(sDtoList);
                    //return;
                    app.ajax({
                    	type : "PUT",        	
                        url: "/sys/base/baseCodeSaveProc.json",
                        data:sDtoList
                    }, function(res){
                        if(res.error){
                            console.log(res.error.message);
                            alert(res.error.message);
                        }
                        else
                        {
                            alert("저장되었습니다.");

                        }
                    });

                },
                excel: function(){

                },
	            submit: function(){
	                var pars = this.target.getParam();
	                //toast.push("콘솔창에 파라미터 정보를 출력하였습니다.");
	                //trace(pars);

                    fnObj.grid.setPage(fnObj.grid.pageNo, pars);
	            }
	        },
	        grid: {
                pageNo: 1,
	            target: new AXGrid(),
	            bind: function(){

                    var target = this.target, _this = this;
                    window.myGrid = target;
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
	                        {key:"basicCd", label:"분류코드", width:"100", align:"left",
                                editor:{
                                    type:"text",
                                    disabled: function(){
                                        return this.item._CUD != "C";
                                    }
                                }
                            },
	                        {key:"basicNm", label:"분류명", width:"150",
                                editor:{
                                    type:"text"
                                }
                            },
	                        {key:"code", label:"코드", width:"60",
                                editor:{
                                    type:"text",
                                    disabled: function(){
                                        return this.item._CUD != "C";
                                    }
                                }
                            },
                            {key:"name", label:"코드값", width:"150",
                                editor:{
                                    type:"text"
                                }
                            },
                            {key:"sort", label:"정렬", width:"60", align:"center",
                                editor:{
                                    type:"number"
                                }
                            },
                            {key:"data1", label:"데이터1", width:"70", align:"center",
                                editor:{
                                    type:"text"
                                }
                            },
                            {key:"data2", label:"데이터2", width:"70", align:"center",
                                editor:{
                                    type:"text"
                                }
                            },
                            {key:"data3", label:"데이터3", width:"70", align:"center",
                                editor:{
                                    type:"text"
                                }
                            },
                            {key:"data4", label:"데이터4", width:"70", align:"center",
                                editor:{
                                    type:"text"
                                }
                            },
                            {key:"data5", label:"데이터5", width:"70", align:"center",
                                editor:{
                                    type:"text"
                                }
                            },
                            {key:"posUseYn", label:"모바일사용여부", width:"100", align:"center",formatter:function(){
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
                            {key:"useYn", label:"사용여부", width:"90", align:"center", formatter:function(){
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
                    myGrid.pushList(
                        {
                            "basicCd" : "",
                            "basicNm" : "",
                            "code"    : "",
                            "name"    : "",
                            "sort"    : 0,
                            "data1"   : "",
                            "data2"   : "",
                            "data3"   : "",
                            "data4"   : "",
                            "data5"   : "",
                            "posUseYn": "Y",
                            "useYn"   : "Y",
                            "remark"  : ""
                        }
                    );
                    myGrid.setFocus(myGrid.list.length-1);
                },
                del:function(){
                    var checkedList = myGrid.getCheckedListWithIndex(0);// colSeq
                    if(checkedList.length == 0){
                        alert("선택된 목록이 없습니다. 삭제하시려는 목록을 체크하세요");
                        return;
                    }
                    myGrid.removeListIndex(checkedList);
                },
                setPage: function(pageNo, searchParams){
                    var _target = this.target;
                    fnObj.grid.pageNo = pageNo;

                    app.ajax({
                        type: "GET",
                        url: "/sys/base/baseCodeList.json",
                        data: "dummy="+ axf.timekey() +"&pageNumber=" + (pageNo-1) + "&pageSize=50&" + (searchParams||"")
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
                            //console.log(gridData);

                            _target.setData(gridData);
                        }
                    });

                }
	        }
	    };
	    </script>
	</ax:div>
</ax:layout>