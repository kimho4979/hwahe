<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdn.datatables.net/1.13.1/css/jquery.dataTables.min.css">

<script type="text/javascript" src="https://cdn.datatables.net/1.13.1/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/fixedcolumns/4.2.1/js/dataTables.fixedColumns.min.js"></script>
<style>

/* 탭 전체 스타일 */
.modal-body .tabs {
  margin-top: 50px;
  padding-bottom: 40px;
  background-color: #ffffff;
  box-shadow: none;
  width: 100%;
  margin: 0 auto;}

/* 탭 전체 스타일 */
.tabs {
  margin-top: 50px;
  padding-bottom: 40px;
  background-color: #ffffff;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
  width: 100%;
  margin: 0 auto;}

/* 탭 스타일 */
.tab_item {
  width: calc(100%/3);
}
.tab_item:hover {
  opacity: 0.75;
}

/* 라디오 버튼 UI삭제*/
input[name="tab_item"] {
  display: none;
}

/* 탭 컨텐츠 스타일 */
.tab_content {
  display: none;
  padding: 40px 40px 0;
  clear: both;
  overflow: hidden;
}

/* 선택된 탭 스타일 */
.tabs input:checked + .tab_item {
  background-color: #333333;
  color: #fff;
}

/* 선택 된 탭 콘텐츠를 표시 */
#tp__flowerCtgr:checked ~ #flowerCtgr__content,
#tp__market:checked ~ #market__content,
#tp__item:checked ~ #item__content,
#tp__itemDtl:checked ~ #itemDtl__content {
  display: block;
}

.tab_content table { width:100%; }

/* 선택된 탭 스타일 */
.tabs input:checked + .tab_item {
  background-color: #333333;
  color: #fff;
}

.select__list ul {
    list-style: none;
    margin-top: 5px;
    margin-bottom: 10px;
}

.select__list li {
    float: left;
    margin-left: 10px;
    margin-bottom: 5px;
    padding: 5px 5px;
    border: 2px solid green;
    border-radius: 5px;
}

</style>

<div class="tabs">
	<input id="tp__market" type="radio" name="tab_item" style="display: none" >
    <label class="tab_item" for="tp__market" style="display: none" >경매장</label>
    <input id="tp__flowerCtgr" type="radio" name="tab_item">
    <label class="tab_item" for="tp__flowerCtgr">부류</label>    
    <input id="tp__item" type="radio" name="tab_item">
    <label class="tab_item" for="tp__item">품목</label>
    <input id="tp__itemDtl" type="radio" name="tab_item">
    <label class="tab_item" for="tp__itemDtl">품종</label>

    

    <!-- 경매장 tab page -->
    <div class="tab_content" id="market__content">
		<div id="market_popup">
		    <div class="w3-container">
		        <h5>검색결과</h5>
		        <table id="tb__marketSrch" class="w3-table-all w3-hoverable display compact nowrap">
		            <colgroup>
		                <col width="70%" />
		                <col width="30%" />
		            </colgroup>
		            <thead>
		                <tr class="w3-light-grey">
					        <th>코드명</th>
					        <th>선택</th>
		                </tr>
		            </thead>
		        </table>
		    </div>
		    <div class="w3-container">
		        <h5>선택결과</h5>
		        <table id="tb__marketRslt" class="w3-table-all w3-hoverable display compact nowrap">
		            <colgroup>
		                <col width="70%" />
		                <col width="30%" />
		            </colgroup>
		            <thead>
		                <tr class="w3-light-grey">
					        <th>코드명</th>
					        <th>취소</th>
		                </tr>
		            </thead>
		        </table>
		    </div>

		</div>
    </div>
    
    <!-- 부류 tab page -->
    <div class="tab_content" id="flowerCtgr__content">
		<div id="flowerCtgr_popup">
		    <div class="w3-container">
		        <h5>검색결과</h5>
		        <table id="tb__flowerCtgrSrch" class="w3-table-all w3-hoverable display compact nowrap">
		            <colgroup>
		                <col width="70%" />
		                <col width="30%" />
		            </colgroup>
		            <thead>
		                <tr class="w3-light-grey">
					        <th>코드명</th>
					        <th>선택</th>
		                </tr>
		            </thead>
		        </table>
		    </div>
		    <div class="w3-container">
			    <div style="width: 10%;  float: left;">
			        <h5>선택결과</h5>
				</div>
				<div style="width: 90%;  float: left;">
					<h5 id="error_msg1" style="color:red"></h5>
				</div>
		        <table id="tb__flowerCtgrRslt" class="w3-table-all w3-hoverable display compact nowrap">
		            <colgroup>
		                <col width="70%" />
		                <col width="30%" />
		            </colgroup>
		            <thead>
		                <tr class="w3-light-grey">
					        <th>코드명</th>
					        <th>취소</th>
		                </tr>
		            </thead>
		        </table>
		    </div>
		</div>
    </div>

    <!-- 품목 tab page -->
    <div class="tab_content" id="item__content">
		<div id="item_popup">
			<div class="w3-container">
				<h5>검색결과</h5>
				<table id="tb__itemSrch" class="w3-table-all w3-hoverable display compact nowrap">
					<colgroup>
						<col width="70%" />
						<col width="30%" />
					</colgroup>
					<thead>
					  <tr class="w3-light-grey">
				        <th>코드명</th>
				        <th>선택</th>
					  </tr>
					</thead>
				</table>
			</div>
			<div class="w3-container">
			    <div style="width: 10%;  float: left;">
			        <h5>선택결과</h5>
				</div>
				<div style="width: 90%;  float: left;">
					<h5 id="error_msg2" style="color:red"></h5>
				</div>
				<table id="tb__itemRslt" class="w3-table-all w3-hoverable display compact nowrap">
					<colgroup>
						<col width="70%" />
						<col width="30%" />
					</colgroup>
					<thead>
					  <tr class="w3-light-grey">
				        <th>코드명</th>
				        <th>취소</th>
					  </tr>
					</thead>
				</table>
			</div>
		</div>
    </div>

    <!-- 품종 tab page -->
    <div class="tab_content" id="itemDtl__content">
		<div id="itemDtl_popup">
			<div class="w3-container">
				<h5>검색결과</h5>
				<table id="tb__itemDtlSrch" class="w3-table-all w3-hoverable display compact nowrap">
					<colgroup>
						<col width="70%" />
						<col width="30%" />
					</colgroup>
					<thead>
					  <tr class="w3-light-grey">
				        <th>코드명</th>
				        <th>선택</th>
					  </tr>
					</thead>
				</table>
			</div>
			<div class="w3-container">
			    <div style="width: 10%;  float: left;">
			        <h5>선택결과</h5>
				</div>
				<div style="width: 90%;  float: left;">
					<h5 id="error_msg3" style="color:red"></h5>
				</div>
				<table id="tb__itemDtlRslt" class="w3-table-all w3-hoverable display compact nowrap">
					<colgroup>
						<col width="70%" />
						<col width="30%" />
					</colgroup>
					<thead>
					  <tr class="w3-light-grey">
				        <th>코드명</th>
				        <th>취소</th>
					  </tr>
					</thead>
				</table>
			</div>
		</div>
    </div>
	<div class="w3-container w3-margin w3-padding-16 w3-border-green select__info">
		<ul class="">
			<li><strong>1.부류 선택내역 : </strong><span class="pop__flower__text"></span></li>
			<li style="display: none" ><strong>2.경매장 선택내역 : </strong><span class="pop__market__text" ></span></li>
			<li><strong>2.품목 선택내역 : </strong><span class="pop__item__text"></span></li>
			<li><strong>3.품종 선택내역 : </strong><span class="pop__itemDtl__text"></span></li>
		</ul>
	</div>
    <div class="w3-container w3-center">
	    <button class="w3-white w3-border button-pop-cancel" name="btn__closeMultiPopup">취소</button>
	    <button class="w3-border button-pop-ok" name="btn__confirmMultiPopup">적용</button>
    </div>
</div>



<script>
    const isEmpty = function(value) {
        if (value === null) return true
        if (typeof value === 'undefined') return true
        if (typeof value === 'string' && value === '') return true
        if (Array.isArray(value) && value.length < 1) return true
        if (typeof value === 'object' && value.constructor.name === 'Object' && Object.keys(value).length < 1 && Object.getOwnPropertyNames(value) < 1) return true
        if (typeof value === 'object' && value.constructor.name === 'String' && Object.keys(value).length < 1) return true // new String()

        return false;
    };


    const multiPopup = {
    	endDate: '',
    	rsFlowerCtgr: [],
    	rsMarket: [],
    	rsItem: [],
    	rsItemDtl: [],
		openPopup: function(rs) {

			multiPopup.rsFlowerCtgr.length = 0;
			multiPopup.rsMarket.length = 0;
			multiPopup.rsItem.length = 0;
			multiPopup.rsItemDtl.length = 0;

			multiPopup.strDate = rs.strDate;
			multiPopup.endDate = rs.endDate;
			rs.rsFlowerCtgr.forEach(function(item){
				multiPopup.rsFlowerCtgr.push(item);
			});
			rs.rsMarket.forEach(function(item){
				multiPopup.rsMarket.push(item);
			});
			rs.rsItem.forEach(function(item){
				multiPopup.rsItem.push(item);
			});
			rs.rsItemDtl.forEach(function(item){
				multiPopup.rsItemDtl.push(item);
			});

	    	let modal = document.getElementById("multiPopup");
			modal.style.display = "block";
			multiPopup.selectTab();
		},
        init: function(callbackFnc) {
        	if (typeof callbackFnc === 'function') {
                this.confirm = function(ds) {
                    callbackFnc(ds);
                }
            }


            let tabs = document.getElementsByName("tab_item");
            for(i=0 ; i < tabs.length ; i++){
                tabs[i].addEventListener('click', function () {
                	multiPopup.selectTab(this.id);
                });
            }

            flowerCtgrPopup.init();
            marketPopup.init();
            itemPopup.init();
            itemDtlPopup.init();

        },
        selectTab: function(tabId) {

//             tabId = tabId || 'tp__market';
            tabId = tabId || 'tp__flowerCtgr';

            const radioBtn = document.getElementById(tabId);
            radioBtn.checked = true;
            let tabs = document.getElementsByName("tab_item");

            let popObj;
            switch (tabId) {
                case "tp__flowerCtgr":
                    popObj = flowerCtgrPopup;
                    $('#error_msg1').text("");
                    var error_txt = "";
                    console.log(multiPopup.rsMarket.length);
                    if(multiPopup.rsMarket.length == 0)
                    	error_txt += "경매장, ";
                    if(error_txt != ""){
                    	error_txt = error_txt.substring(0, error_txt.length-2);
                    	error_txt += "을(를) 선택해주세요."
                   		$('#error_msg1').text(error_txt);
                    }
                    break;
                case "tp__market":
                    popObj = marketPopup;
                    break;
                case "tp__item":
                    popObj = itemPopup;
                    $('#error_msg2').text("");
                    var error_txt = "";
                    if(multiPopup.rsMarket.length == 0)
                    	error_txt += "경매장, ";
                    if(multiPopup.rsFlowerCtgr.length == 0)
                    	error_txt += "부류, ";
                    if(error_txt != ""){
                    	error_txt = error_txt.substring(0, error_txt.length-2);
                    	error_txt += "을(를) 선택해주세요."
                   		$('#error_msg2').text(error_txt);
                    }
                    break;
                case "tp__itemDtl":
                    popObj = itemDtlPopup;
                    $('#error_msg3').text("");
                    var error_txt = "";
                    if(multiPopup.rsMarket.length == 0)
                    	error_txt += "경매장, ";
                    if(multiPopup.rsFlowerCtgr.length == 0)
                    	error_txt += "부류, ";
                    if(multiPopup.rsItem.length == 0)
                    	error_txt += "품목, ";
                    if(error_txt != ""){
                    	error_txt = error_txt.substring(0, error_txt.length-2);
                    	error_txt += "을(를) 선택해주세요."
                   		$('#error_msg3').text(error_txt);
                    }
                    break;
            }

            popObj.searchItem();

            multiPopup.setInfoText();
        },

        resetParam : function() {

        	multiPopup.rsFlowerCtgr.length = 0;
        	multiPopup.rsMarket.length = 0;
        	multiPopup.rsItem.length = 0;
        	multiPopup.rsItemDtl.length = 0;

        	multiPopup.setInfoText();
        },

        setInfoText : function () {
        	let select__info = document.querySelector(".select__info");
            let span = select__info.querySelector(".pop__flower__text");
            let spanText = '';
            multiPopup.rsFlowerCtgr.forEach(function(item) {
            	if (!isEmpty(spanText)) {
            		spanText += ', ';
            	}
            	spanText += item.cdNm;
            });
			span.textContent = spanText;

            // market
            span = select__info.querySelector(".pop__market__text");
            spanText = '';
            multiPopup.rsMarket.forEach(function(item) {
            	if (!isEmpty(spanText)) {
            		spanText += ', ';
            	}
            	spanText += item.cdNm;
            });
			span.textContent = spanText;

            // item
            span = select__info.querySelector(".pop__item__text");
            spanText = '';
            multiPopup.rsItem.forEach(function(item) {
            	if (!isEmpty(spanText)) {
            		spanText += ', ';
            	}
            	spanText += item.cdNm;
            });
			span.textContent = spanText;

            // item detail
            span = select__info.querySelector(".pop__itemDtl__text");
            spanText = '';
            multiPopup.rsItemDtl.forEach(function(item) {
            	if (!isEmpty(spanText)) {
            		spanText += ', ';
            	}
            	spanText += item.cdNm;
            });
			span.textContent = spanText;
        },
        confirm : function() {

        },
        close : function() {}
    };


    const flowerCtgrPopup = {
	        init : function () {
	            $('#tb__flowerCtgrSrch').DataTable({
	                scrollCollapse: false,
	                paging: false ,
					ordering: false,
	                searching : false,
					language: {
						"zeroRecords": " "
					},
	                info : false,
	                columns: [
	                    {data: 'cdNm', className: 'dt-center'},
	                    {
	                        orderable: false,
	                        searchable: false,
	                        className : 'dt-center',
	                        render: function ( data, type, row ) {
	                            let html = '<button class="w3-button btn-pop-green" name="btn__insertFlowerCtgr" >선택</button>';
	                            return html;
	                        }
	                    }
	                ]
	            });

	            $('#tb__flowerCtgrRslt').DataTable({
	                scrollCollapse: false,
	                searching : false,
					language: {
						"zeroRecords": " "
					},
	                paging: false ,
					ordering: false,
	                info : false,
	                columns: [
	                    {data: 'cdNm', className: 'dt-center'},
	                    {
	                        orderable: false,
	                        searchable: false,
	                        className : 'dt-center',
	                        render: function ( data, type, row ) {
	                            let html = '<button class="w3-button btn-pop-red" name="btn__deleteFlowerCtgr" >취소</button>';
	                            return html;
	                        }
	                    }
	                ]
	            });

	        },
	        searchItem : function() {
	        	$('#tb__flowerCtgrRslt').DataTable().clear().rows.add(multiPopup.rsFlowerCtgr).draw();
	        	let param = {};
	            let url = "/comm/selectFlowerGubnList.json";
	            $.ajax({
	                type : "post",
	                url : url,
	                data : param,
	                dataType : 'json',
	                success : function(res){
	                	res.data = res.data.filter(function(e){
	                		return Number(e.cdId) < 4;
	                	});
	                    $('#tb__flowerCtgrSrch').DataTable().clear().rows.add(res.data).draw();
	                }
	            });

	        },
	        insertItem : function(row) {
	            let data = row.data();
	            let needAdd = true;
	            let ds = multiPopup.rsFlowerCtgr;
				if(ds.length > 0){
					alert("부류는 최대 1개까지 선택 가능합니다.");
					return false;
				}
				
	            ds.forEach(function(item) {
	                if (data.cdId === item.cdId) {
	                    needAdd = false;
	                    return false;
	                }
	            });
	            if (needAdd) {
	                ds.push(data);
	                let table = $('#tb__flowerCtgrRslt').DataTable();
	                table.row.add(data).draw();
	                
	                multiPopup.setInfoText();
	            }
	        },
	        deleteItem : function(row) {
	            let data = row.data();
	            let ds = multiPopup.rsFlowerCtgr;
	            ds.forEach(function(item, index, array) {
	                if (data.cdId === item.cdId) {
	                    array.splice(index, 1);
	                }
	            });
	            row.remove().draw();
	            multiPopup.setInfoText();
	        }
	    };

    const marketPopup = {
            init : function (callbackFnc) {
                $('#tb__marketSrch').DataTable({
                    scrollCollapse: false,
                    paging: false ,
					ordering: false,
                    searching : false,
					language: {
						"zeroRecords": " "
					},
                    info : false,
                    columns: [
                        {data: 'cdNm', className: 'dt-center'},
                        {
                            orderable: false,
                            searchable: false,
                            className : 'dt-center',
                            render: function ( data, type, row ) {
                                let html = '<button class="w3-button btn-pop-green" name="btn__insertMarket">선택</button>';
                                return html;
                            }
                        }
                    ]
                });

                $('#tb__marketRslt').DataTable({
                    scrollCollapse: false,
                    paging: false,
                    searching : false,
					language: {
						"zeroRecords": " "
					},
                    info : false,
                    columns: [
                        {data: 'cdNm', className: 'dt-center'},
                        {
                            orderable: false,
                            searchable: false,
                            className : 'dt-center',
                            render: function ( data, type, row ) {
                                let html = '<button class="w3-button btn-pop-red" name="btn__deleteMarket">취소</button>';
                                return html;
                            }
                        }
                    ]
                });
            },
            searchItem : function() {
                let param = {};
                let url = '/comm/selectMarketList.json';
                $.ajax({
                    type : "post",
                    url : url,
                    data : param,
                    dataType : 'json',
                    success : function(res){
                    	console.log("searchItem", res);
                        $('#tb__marketSrch').DataTable().clear().rows.add(res.data).draw();
                    }
                });
                $('#tb__marketRslt').DataTable().clear().rows.add(multiPopup.rsMarket).draw();
            },
            insertItem : function(row) {
                let data = row.data();
                let needAdd = true;
                let ds = multiPopup.rsMarket;
                ds.forEach(function(item) {
                    if (data.cdId === item.cdId) {
                        needAdd = false;
                        return false;
                    }
                });

                if (needAdd) {
                    ds.push(data);
                    let table = $('#tb__marketRslt').DataTable();
                    table.row.add(data).draw();
                    multiPopup.setInfoText();
                }
            },
            deleteItem : function(row) {
                let data = row.data();
                let ds = multiPopup.rsMarket;
                ds.forEach(function(item, index, array) {
                    if (data.cdId === item.cdId) {
                        array.splice(index, 1);
                    }
                });
                row.remove().draw();
                multiPopup.setInfoText();
            }
        };
	const itemPopup = {
            init : function () {
				$('#tb__itemSrch').DataTable({
					scrollY: '30vh',
					scrollCollapse: false,
					paging: false ,
					ordering: false,
					searching : true,
					language: {
						"zeroRecords": " ",
						'search': '검색 : '
					},
					info : false,
					columns: [
						{data: 'cdNm', className: 'dt-center'},
						{
							orderable: false,
							searchable: false,
							className : 'dt-center',
							render: function ( data, type, row ) {
								let html = '<button class="w3-button btn-pop-green" name="btn__insertItem" >선택</button>';
								return html;
							}
						}
					]
				});

				$('#tb__itemRslt').DataTable({
					scrollY: '20vh',
					scrollCollapse: false,
					paging: false ,
					searching : false,
					language: {
						"zeroRecords": " "
					},
					ordering: false,
					info : false,
					columns: [
						{data: 'cdNm', className: 'dt-center'},
						{
							orderable: false,
							searchable: false,
							className : 'dt-center',
							render: function ( data, type, row ) {
								let html = '<button class="w3-button btn-pop-red" name="btn__deleteItem" >취소</button>';
								return html;
							}
						}
					]
				});
			},
			searchItem : function() {

				let flower = [];
				multiPopup.rsFlowerCtgr.forEach(function(item){
					flower.push(item.cdId);
				});

				let market = [];
				multiPopup.rsMarket.forEach(function(item){
					market.push(item.cdId);
				});

				let param = {
					saleDateFrom: multiPopup.strDate,
					saleDateTo: multiPopup.endDate,
					flower: flower,
					market: market, 
					type: $(":input:radio[name=rr99]:checked").val()
				};

				let url = '/comm/selectItemList.json';
				$.ajax({
					type : "post",
					url : url,
					data : param,
					dataType : 'json',
					success : function(res){
						$('#tb__itemSrch').DataTable().clear().rows.add(res.data).draw();
					}
				});
				$('#tb__itemRslt').DataTable().clear().rows.add(multiPopup.rsItem).draw();
			},
			insertItem : function(row) {
				let data = row.data();
				let needAdd = true;
				let ds = multiPopup.rsItem;
				if(ds.length > 0){
					alert("품목은 최대 1개까지 선택 가능합니다.");
					return false;
				}
				ds.forEach(function(item) {
					if (data.cdId === item.cdId) {
						needAdd = false;
						return false;
					}
				});

				if (needAdd) {
					ds.push(data);
					let table = $('#tb__itemRslt').DataTable();
					table.row.add(data).draw();
					table.columns().search('');
					multiPopup.setInfoText();
				}
			},
			deleteItem : function(row) {
				let data = row.data();
				
				let ds = multiPopup.rsItem;
				ds.forEach(function(item, index, array) {
					if (data.cdId === item.cdId) {
						array.splice(index, 1);
					}
				});
				row.remove().draw();
				multiPopup.setInfoText();
			}
		};

	const itemDtlPopup = {
			init : function () {
				$('#tb__itemDtlSrch').DataTable({
					scrollY: '20vh',
					scrollCollapse: false,
					paging: false ,
					ordering: false,
					searching : true,
					language: {
						"zeroRecords": " ",
						'search': '검색 : '
					},
					info : false,
					columns: [
						{data: 'cdNm', className: 'dt-center'},
						{
							orderable: false,
							searchable: false,
							className : 'dt-center',
							render: function ( data, type, row ) {
								let html = '<button class="w3-button btn-pop-green" name="btn__insertItemDtl">선택</button>';
								return html;
							}
						}
					]
				});

				$('#tb__itemDtlRslt').DataTable({
					language: {
						"zeroRecords": " "
					},
					
					scrollY: '20vh',
					scrollCollapse: false,
					paging: false ,
					ordering: false,
					searching : false,
					info : false,
					columns: [
						{data: 'cdNm', className: 'dt-center'},
						{
							orderable: false,
							searchable: false,
							className : 'dt-center',
							render: function ( data, type, row ) {
								let html = '<button class="w3-button btn-pop-red" name="btn__deleteItemDtl">취소</button>';
								return html;
							}
						}
					]
				});
			},
			searchItem : function() {
				let flower = [];
				multiPopup.rsFlowerCtgr.forEach(function(item){
					flower.push(item.cdId);
				});

				let market = [];
				multiPopup.rsMarket.forEach(function(item){
					market.push(item.cdId);
				});

				let items = [];
				multiPopup.rsItem.forEach(function(item){
					items.push(item.cdId);
				});

				let param = {
					saleDateFrom: multiPopup.strDate,
					saleDateTo: multiPopup.endDate,
					flower: flower,
					market: market,
					item: items, 
					type: $(":input:radio[name=rr99]:checked").val()
				};

				let url = '/comm/selectItemDtlList.json';
				$.ajax({
					type : "post",
					url : url,
					data : param,
					dataType : 'json',
					success : function(res){
						$('#tb__itemDtlSrch').DataTable().clear().rows.add(res.data).draw();
					}
				});
				$('#tb__itemDtlRslt').DataTable().clear().rows.add(multiPopup.rsItemDtl).draw();
			},
			insertItem : function(row) {
				let data = row.data();
				let needAdd = true;
				let ds = multiPopup.rsItemDtl;
				if(ds.length > 0){
					alert("품종은 최대 1개까지 선택 가능합니다.");
					return false;
				}
				ds.forEach(function(item) {
					if (data.cdId === item.cdId) {
						needAdd = false;
						return false;
					}
				});

				if (needAdd) {
					ds.push(data);
					let table = $('#tb__itemDtlRslt').DataTable();
					table.row.add(data).draw();

					multiPopup.setInfoText();
				}
			},
			deleteItem : function(row) {
				let data = row.data();
				let ds = multiPopup.rsItemDtl;
				ds.forEach(function(item, index, array) {
					if (data.cdId === item.cdId) {
						array.splice(index, 1);
					}
				});
				row.remove().draw();
				multiPopup.setInfoText();
			}
		};

    $(document).on('click', 'button[name="btn__insertFlowerCtgr"]', function() {
        let row = $('#tb__flowerCtgrSrch').DataTable().row( $(this).parents('tr:first') );
        flowerCtgrPopup.insertItem(row);
    });
    $(document).on('click', 'button[name="btn__deleteFlowerCtgr"]', function() {
        let row = $('#tb__flowerCtgrRslt').DataTable().row( $(this).parents('tr:first') );
        flowerCtgrPopup.deleteItem(row);
    });
    $(document).on('click', 'button[name="btn__insertMarket"]', function(e) {
        let row = $('#tb__marketSrch').DataTable().row( $(this).parents('tr:first') );
		if($(e.target).parent().prev().text().indexOf('과천') != -1){ gwacheonAlert(); }
		marketPopup.insertItem(row);

    });
    $(document).on('click', 'button[name="btn__deleteMarket"]', function() {
        let row = $('#tb__marketRslt').DataTable().row( $(this).parents('tr:first') );
        marketPopup.deleteItem(row);
    });
	$(document).on('click', 'button[name="btn__insertItem"]', function() {
		let row = $('#tb__itemSrch').DataTable().row( $(this).parents('tr:first') );
		itemPopup.insertItem(row);

	});
	$(document).on('click', 'button[name="btn__deleteItem"]', function() {
		let row = $('#tb__itemRslt').DataTable().row( $(this).parents('tr:first') );
		itemPopup.deleteItem(row);
	});

	$(document).on('click', 'button[name="btn__insertItemDtl"]', function() {
		let row = $('#tb__itemDtlSrch').DataTable().row( $(this).parents('tr:first') );
		itemDtlPopup.insertItem(row);

	});
	$(document).on('click', 'button[name="btn__deleteItemDtl"]', function() {
		let row = $('#tb__itemDtlRslt').DataTable().row( $(this).parents('tr:first') );
		itemDtlPopup.deleteItem(row);
	});


	// 적용
	$(document).on('click', 'button[name="btn__confirmMultiPopup"]', function() {
		let modal = document.getElementById("multiPopup");
		if (multiPopup.rsItem.length == 0){
			alert("품목을 선택해주세요.");
			return;
		}
		modal.style.display = "none";
		
		multiPopup.confirm({
			rsFlowerCtgr: multiPopup.rsFlowerCtgr,
			rsMarket: multiPopup.rsMarket,
			rsItem: multiPopup.rsItem,
			rsItemDtl: multiPopup.rsItemDtl
		});

	});
	// 취소
	$(document).on('click', 'button[name="btn__closeMultiPopup"]', function() {
		let modal = document.getElementById("multiPopup");
		modal.style.display = "none";
	});


</script>