<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
.fl {float:left;}
.fr {float:right;}

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
  width: calc(100%/5);
  height: 40px;
  border-bottom: 3px solid #333333;
  background-color: #f8f8f8;
  line-height: 40px;
  font-size: 14px;
  text-align: center;
  color: #333333;
  display: block;
  float: left;
  text-align: center;
  font-weight: bold;
  transition: all 0.2s ease;
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


/* 선택 된 탭 콘텐츠를 표시 */
#period:checked ~ #period_content,
#flowerClass:checked ~ #flowerClass_content,
#market:checked ~ #market_content,
#itemCd:checked ~ #item_content,
#itemDtl:checked ~ #itemDtl_content {
  display: block;
}

.tab_content table { width:100%; }


/* 선택된 탭 스타일 */
.tabs input:checked + .tab_item {
  background-color: #333333;
  color: #fff;
}


.btn_text{
  width : 180px;
  height: 23px;
}

section {
  display : flex;
}

.btn_search{
  font-weight : 900;
  font-family: "Font Awesome 5 Free";
  background-color : transparent;
  border : none;
  cursor : pointer;
  position : absolute;
  right : 5px;
  top : 50%;
  transform : translatey(-50%);
}
.btn_search::before{
  content : "\f002";
}
form{
  position : relative;
}

</style>

<script>


</script>

<div class="tabs">
  <input id="period" type="radio" name="tab_item" checked>
  <label class="tab_item" for="period">기간</label>
  <input id="flowerClass" type="radio" name="tab_item">
  <label class="tab_item" for="flowerClass">부류</label>
  <input id="market" type="radio" name="tab_item">
  <label class="tab_item" for="market">경매장</label>
  <input id="itemCd" type="radio" name="tab_item">
  <label class="tab_item" for="itemCd">품목</label>
  <input id="itemDtl" type="radio" name="tab_item">
  <label class="tab_item" for="itemDtl">품종</label>

  <div class="tab_content" id="period_content">

	<div class="w3-container">
		<div class="w3-row">
			<div class="w3-twothird">
				<input type="checkbox" id="chk_cmpr_period" name="chk_cmpr_period" checked >
	    		<label for="chk_cmpr_period"><span></span> 기간별 비교 </label>
	    	</div>
			<div class="w3-rest">
				<button class="fr btn btn_gray">초기화</button>
				<button class="fr btn btn_gray" name="btnApplDate">적용</button>
			</div>
	    </div>
		<div class="w3-row s-line">
			<div class="w3-col m1 s2 w3-center w3-grey">
				<h4>비교기간1</h4>
			</div>
			<div class="w3-col m1 s2 w3-center">
				<input type="checkbox" id="chkDateYnPeriod1" name="chkDateYnPeriod1">
	    		<label for="chkDateYnPeriod1"><span></span> 일단위 </label>
			</div>

			<div class="w3-col m5 s4 w3-container">
				<label for="cmprPeriod1From">시작 </label>
				<input type="date" id="cmprPeriod1From" name="cmprPeriod1From">
			</div>
			<div class="w3-col m5 s4 w3-container">
				<label for="cmprPeriod1To">종료 </label>
				<input type="date" id="cmprPeriod1To" name="cmprPeriod1To">
			</div>
		</div>
		<div class="w3-row s-line">
			<div class="w3-col m1 s2 w3-center w3-grey">
				<h4>비교기간2</h4>
			</div>
			<div class="w3-col m1 s2 w3-center">
				<input type="checkbox" id="chkDateYnPeriod2" name="chkDateYnPeriod2">
	    		<label for="chkDateYnPeriod2"><span></span> 일단위</label>
			</div>

			<div class="w3-col m5 s4 w3-container">
				<label for="cmprPeriod2From">시작 </label>
				<input type="date" id="cmprPeriod2From" name="cmprPeriod2From">
			</div>
			<div class="w3-col m5 s4 w3-container">
				<label for="cmprPeriod2To">종료 </label>
				<input type="date" id="cmprPeriod2To" name="cmprPeriod2To">
			</div>
		</div>
	</div>
  </div>

  <!-- 부류 tab page -->
  <div class="tab_content" id="flowerClass_content">
    <!-- grid -->
    <div class="w3-container">
    	<h5>검색결과</h5>
		<table id="tb_flowerClass" class="w3-table-all w3-hoverable display compact nowrap">
			<colgroup>
				<col width="10%" />
				<col width="30%" />
				<col width="15%" />
				<col width="30%" />
				<col width="15%" />
			</colgroup>
			<thead>
		      <tr class="w3-light-grey">
		        <th>번호</th>
		        <th>조건1</th>
		        <th>선택</th>
		        <th>조건2</th>
		        <th>선택</th>
		      </tr>
		    </thead>
	    </table>
    </div>

    <div class="w3-container">
        <h5>선택결과</h5>
		<table id="tb_flowerClassRslt" class="w3-table-all w3-hoverable display compact nowrap">
			<colgroup>
				<col width="10%" />
				<col width="30%" />
				<col width="15%" />
				<col width="30%" />
				<col width="15%" />
			</colgroup>
			<thead>
		      <tr class="w3-light-grey">
		        <th>번호</th>
		        <th>조건1</th>
		        <th>취소</th>
		        <th>조건2</th>
		        <th>취소</th>
		      </tr>
		    </thead>
	    </table>
    </div>
  </div>

	<!-- 경매장 tab page -->
  	<div class="tab_content" id="market_content">
	    <div class="w3-container">
	    	<h5>검색결과</h5>
			<table id="tb_market" class="w3-table-all w3-hoverable display compact nowrap">
				<colgroup>
					<col width="10%" />
					<col width="30%" />
					<col width="15%" />
					<col width="30%" />
					<col width="15%" />
				</colgroup>
				<thead>
			      <tr class="w3-light-grey">
			        <th>번호</th>
			        <th>조건1</th>
			        <th>선택</th>
			        <th>조건2</th>
			        <th>선택</th>
			      </tr>
			    </thead>
		    </table>
	    </div>
	    <div class="w3-container">
	    	<h5>선택결과</h5>
			<table id="tb_marketRslt" class="w3-table-all w3-hoverable display compact nowrap">
				<colgroup>
					<col width="10%" />
					<col width="30%" />
					<col width="15%" />
					<col width="30%" />
					<col width="15%" />
				</colgroup>
				<thead>
			      <tr class="w3-light-grey">
			        <th>번호</th>
			        <th>조건1</th>
			        <th>취소</th>
			        <th>조건2</th>
			        <th>취소</th>
			      </tr>
			    </thead>
		    </table>
	    </div>
  	</div>

	<!-- 품목 tab page -->
  	<div class="tab_content" id="item_content">
	    <div class="w3-container">
	    	<h5>검색결과</h5>
			<table id="tb_item" class="w3-table-all w3-hoverable display compact nowrap">
				<colgroup>
					<col width="10%" />
					<col width="30%" />
					<col width="15%" />
					<col width="30%" />
					<col width="15%" />
				</colgroup>
				<thead>
			      <tr class="w3-light-grey">
			        <th>번호</th>
			        <th>조건1</th>
			        <th>선택</th>
			        <th>조건2</th>
			        <th>선택</th>
			      </tr>
			    </thead>
		    </table>
	    </div>
	    <div class="w3-container">
	    	<h5>선택결과</h5>
			<table id="tb_itemRslt" class="w3-table-all w3-hoverable display compact nowrap">
				<colgroup>
					<col width="10%" />
					<col width="30%" />
					<col width="15%" />
					<col width="30%" />
					<col width="15%" />
				</colgroup>
				<thead>
			      <tr class="w3-light-grey">
			        <th>번호</th>
			        <th>조건1</th>
			        <th>취소</th>
			        <th>조건2</th>
			        <th>취소</th>
			      </tr>
			    </thead>
		    </table>
	    </div>
  	</div>

	<!-- 품종 tab page -->
  	<div class="tab_content" id="itemDtl_content">
    	<div class="w3-container">
	    	<h5>검색결과</h5>
			<table id="tb_itemDtl" class="w3-table-all w3-hoverable display compact nowrap">
				<colgroup>
					<col width="10%" />
					<col width="30%" />
					<col width="15%" />
					<col width="30%" />
					<col width="15%" />
				</colgroup>
				<thead>
			      <tr class="w3-light-grey">
			        <th>번호</th>
			        <th>조건1</th>
			        <th>선택</th>
			        <th>조건2</th>
			        <th>선택</th>
			      </tr>
			    </thead>
		    </table>
	    </div>
	    <div class="w3-container">
	    	<h5>선택결과</h5>
			<table id="tb_itemDtlRslt" class="w3-table-all w3-hoverable display compact nowrap">
				<colgroup>
					<col width="10%" />
					<col width="30%" />
					<col width="15%" />
					<col width="30%" />
					<col width="15%" />
				</colgroup>
				<thead>
			      <tr class="w3-light-grey">
			        <th>번호</th>
			        <th>조건1</th>
			        <th>취소</th>
			        <th>조건2</th>
			        <th>취소</th>
			      </tr>
			    </thead>
		    </table>
	    </div>
  	</div>

</div>

<script>
	const flowerClassRslt 	= [];
	const marketRslt		= [];
	const itemRslt			= [];
	const itemDtlRslt		= [];

	const selectTab = function(type) {
		var radioBtn = document.getElementById(type);
		radioBtn.checked = true;

		switch (type) {
			case "flowerClass" :
            	search_flowerClass();
            	set_flowerClassRslt();
				break;
			case "market" :
            	search_market();
            	set_marketRslt();
				break;
			case "itemCd" :
            	search_item();
            	set_itemRslt();
				break;
			case "itemDtl" :
            	search_itemDtl();
            	set_itemDtlRslt();
				break;
			default:
				break;
		}
	};

	let tabs = document.getElementsByName("tab_item");
	for(i=0 ; i < tabs.length ; i++){
		tabs[i].addEventListener('click', function () {
	        switch(this.id){
	            case "flowerClass":
	            	search_flowerClass();
	            	set_flowerClassRslt();
	                break;
	            case "market":
	            	search_market();
	            	set_marketRslt();
            		break;
				case "itemCd" :
	            	search_item();
	            	set_itemRslt();
					break;
				case "itemDtl" :
	            	search_itemDtl();
	            	set_itemDtlRslt();
					break;
				default:
					break;
	        }
	    });
	}

	const initCmprDate = function () {
		let cmprPeriod1From = document.querySelector("#cmprPeriod1From");
		let cmprPeriod1To = document.querySelector("#cmprPeriod1To");
		let cmprPeriod2From = document.querySelector("#cmprPeriod2From");
		let cmprPeriod2To = document.querySelector("#cmprPeriod2To");

		let today = new Date();
		let fromDate = today.toISOString().substr(0, 10);
		let toDate = fromDate;

		cmprPeriod1From.value = fromDate;
		cmprPeriod1To.value = toDate;
		cmprPeriod2From.value = fromDate;
		cmprPeriod2To.value = toDate;

		};

	const cmprPopupInit = function() {

		// 일자 설정
		//let chkDateYn = document.getElementById("chkDateYn");
			//chkDateYn.

		let chkDateYn = document.getElementById("chkDateYn");
		initCmprDate();

		// 부류 검색 Table
		$('#tb_flowerClass').DataTable({
			scrollY: '40vh',
	        scrollCollapse: true,
			paging: false ,
	        searching : true,
	        info : false,
	        language: {
	            'search': '검색 : '
	        },
	        ajax: '/comm/selectFlowerGubnList.json',
	        dataSrc: 'list',

	        columns: [
	            {data: 'cdSeq', className: 'dt-right'},
	            {data: 'cdNm', className: 'dt-center'},
	            {
	            	data: 'cdId',
					orderable: false,
					searchable: false,
					className : 'dt-center',
					render: function ( data, type, row ) {
						var cnt = 0;
						flowerClassRslt.forEach(function(each) {
							if (each.cdId1 == data) {
								cnt++;
								return false;
							}
						} );

						if (cnt > 0) return '';
						var html = '<button type="button" class="btn_s2 btn_gray" name="selFlowerGubn1">선택</button>';

	                    return html;
	                  }

				},
				{data: 'cdNm', className: 'dt-center'},	//cdNm cdSeq
				{
					data: 'cdId',
					orderable: false,
					searchable: false,
					className : 'dt-center',
					render: function ( data, type, row ) {
						var cnt = 0;
						flowerClassRslt.forEach(function(each) {
							if (each.cdId2 == data) {
								cnt++;
								return false;
							}
						} );

						if (cnt > 0) return '';
	                    var html = '<button type="button" class="btn_s2 btn_gray" name="selFlowerGubn2">선택</button>';
	                    return html;
	                  }
				}
			]
		});
		// 부류 결과 Table
		$('#tb_flowerClassRslt').DataTable({
			scrollY: '20vh',
	        scrollCollapse: false,
			paging: false ,
			searching : false,
			info : false,
	        data: flowerClassRslt,
	        columns: [
	            {data: 'cdSeq', className: 'dt-right'},
	            {data: 'cdNm1', className: 'dt-center'},
	            {
	            	data: 'cdId1',
					orderable: false,
					searchable: false,
					className : 'dt-center',
					render: function ( data, type, row ) {
						if (isEmpty(data)) {
							return '';
						}
                       	let html = '<button type="button" class="btn_s2 btn_gray" name="delFlowerGubn1">취소</button>';
                       	return html;
                     }
				},
				{data: 'cdNm2', className: 'dt-center'},
				{
					data: 'cdId2',
					orderable: false,
					searchable: false,
					className : 'dt-center',
					render: function ( data, type, row ) {
						if (isEmpty(data)) {
							return '';
						}
						var html = '<button type="button" class="btn_s2 btn_gray" name="delFlowerGubn2">취소</button>';
	                       return html;
	                     }
				}
			]
		});
		//$('#tb_flowerClassRslt').css('max-height', '40vh');

		// 경매장 검색 Table
		$('#tb_market').DataTable({
			scrollY: '40vh',
	        scrollCollapse: true,
			paging: false ,
	        searching : true,
	        info : false,
	        language: {
	            'search': '검색 : '
	        },
	        ajax: '/comm/selectMarketList.json',
	        dataSrc: 'list',
	        columns: [
	            {data: 'cdSeq', className: 'dt-right'},
	            {data: 'cdNm', className: 'dt-center'},
	            {
	            	data: 'cdId',
					orderable: false,
					searchable: false,
					className : 'dt-center',
					render: function ( data, type, row ) {
						var cnt = 0;
						marketRslt.forEach(function(each) {
							if (each.cdId1 == data) {
								cnt++;
								return false;
							}
						} );

						if (cnt > 0) return '';
	                    var html = '<button type="button" class="btn_s2 btn_gray" name="selMarket1">선택</button>';
	                    return html;
	                  }

				},
				{data: 'cdNm', className: 'dt-center'},	//cdNm cdSeq
				{
					data: 'cdId',
					orderable: false,
					searchable: false,
					className : 'dt-center',
					render: function ( data, type, row ) {
						var cnt = 0;
						marketRslt.forEach(function(each) {
							if (each.cdId2 == data) {
								cnt++;
								return false;
							}
						} );

						if (cnt > 0) return '';
	                    var html = '<button type="button" class="btn_s2 btn_gray" name="selMarket2">선택</button>';
	                    return html;
	                  }
				}
			]
		});
		// 경매장 결과 Table
		$('#tb_marketRslt').DataTable({
			scrollY: '20vh',
	        scrollCollapse: false,
			paging: false ,
			searching : false,
			info : false,
	        data: marketRslt,
	        columns: [
	            {data: 'cdSeq', className: 'dt-right'},
	            {data: 'cdNm1', className: 'dt-center'},
	            {
					orderable: false,
					searchable: false,
					className : 'dt-center',
					render: function ( data, type, row ) {
						if (isEmpty(row.cdId1)) {
							return '';
						}
	                       let html = '<button type="button" class="btn_s2 btn_gray" name="delMarket1">취소</button>';
	                       return html;
	                     }
				},
				{data: 'cdNm2', className: 'dt-center'},
				{
					orderable: false,
					searchable: false,
					className : 'dt-center',
					render: function ( data, type, row ) {
						if (isEmpty(row.cdId2)) {
							return '';
						}
						var html = '<button type="button" class="btn_s2 btn_gray" name="delMarket2">취소</button>';
	                       return html;
	                     }
				}
			]
		});


		// 품목 검색 Table
		$('#tb_item').DataTable({
			scrollY: '40vh',
	        scrollCollapse: true,
			paging: false ,
	        searching : true,
	        info : false,
	        language: {
	            'search': '검색 : '
	        },
	        columns: [
	            {data: 'cdSeq', className: 'dt-right', width: '10%'},
	            {data: 'cdNm', className: 'dt-center', width: '30%'},
	            {
	            	data: 'cdId',
					orderable: false,
					searchable: false,
					className : 'dt-center',
					width: '15%',
					render: function ( data, type, row ) {
						var cnt = 0;
						itemRslt.forEach(function(each) {
							if (each.cdId1 == data) {
								cnt++;
								return false;
							}
						} );

						if (cnt > 0) return '';
	                    var html = '<button type="button" class="btn_s2 btn_gray" name="selItem1">선택</button>';
	                    return html;
	                  }

				},
				{data: 'cdNm', className: 'dt-center', width:'30%'},	//cdNm cdSeq
				{
					data: 'cdId',
					orderable: false,
					searchable: false,
					className : 'dt-center',
					width: '15%',
					render: function ( data, type, row ) {
						var cnt = 0;
						itemRslt.forEach(function(each) {
							if (each.cdId2 == data) {
								cnt++;
								return false;
							}
						} );

						if (cnt > 0) return '';
	                    var html = '<button type="button" class="btn_s2 btn_gray" name="selItem2">선택</button>';
	                    return html;
	                  }
				}
			]
		});
		// 품목 결과 Table
		$('#tb_itemRslt').DataTable({
			scrollY: '20vh',
	        scrollCollapse: false,
			paging: false ,
			searching : false,
			info : false,
	        data: itemRslt,
	        columns: [
	            {data: 'cdSeq', className: 'dt-right'},
	            {data: 'cdNm1', className: 'dt-center'},
	            {
					orderable: false,
					searchable: false,
					className : 'dt-center',
					render: function ( data, type, row ) {
						if (isEmpty(row.cdId1)) {
							return '';
						}
	                       let html = '<button type="button" class="btn_s2 btn_gray" name="delItem1">취소</button>';
	                       return html;
	                     }
				},
				{data: 'cdNm2', className: 'dt-center'},
				{
					orderable: false,
					searchable: false,
					className : 'dt-center',
					render: function ( data, type, row ) {
						if (isEmpty(row.cdId2)) {
							return '';
						}
						var html = '<button type="button" class="btn_s2 btn_gray" name="delItem2">취소</button>';
	                       return html;
	                     }
				}
			]
		});

		// 품종 검색 Table
		$('#tb_itemDtl').DataTable({
			scrollY: '40vh',
	        scrollCollapse: true,
			paging: false ,
	        searching : true,
	        info : false,
	        language: {
	            'search': '검색 : '
	        },
	        columns: [
	            {data: 'cdSeq', className: 'dt-right', width: '10%'},
	            {data: 'cdNm', className: 'dt-center', width: '30%'},
	            {
	            	data: 'cdId',
					orderable: false,
					searchable: false,
					className : 'dt-center',
					width: '15%',
					render: function ( data, type, row ) {
						var cnt = 0;
						itemDtlRslt.forEach(function(each) {
							if (each.cdId1 == data) {
								cnt++;
								return false;
							}
						} );

						if (cnt > 0) return '';
	                    var html = '<button type="button" class="btn_s2 btn_gray" name="selItemDtl1">선택</button>';
	                    return html;
	                  }

				},
				{data: 'cdNm', className: 'dt-center', width: '30%'},	//cdNm cdSeq
				{
					data: 'cdId',
					orderable: false,
					searchable: false,
					className : 'dt-center',
					width: '15%',
					render: function ( data, type, row ) {
						var cnt = 0;
						itemDtlRslt.forEach(function(each) {
							if (each.cdId2 == data) {
								cnt++;
								return false;
							}
						} );

						if (cnt > 0) return '';
	                    var html = '<button type="button" class="btn_s2 btn_gray" name="selItemDtl2">선택</button>';
	                    return html;
	                  }
				}
			]
		});

		// 품종 결과 Table
		$('#tb_itemDtlRslt').DataTable({
			scrollY: '20vh',
	        scrollCollapse: false,
			paging: false ,
			searching : false,
			info : false,
	        data: itemDtlRslt,
	        columns: [
	            {data: 'cdSeq', className: 'dt-right'},
	            {data: 'cdNm1', className: 'dt-center'},
	            {
					orderable: false,
					searchable: false,
					className : 'dt-center',
					render: function ( data, type, row ) {
						if (isEmpty(row.cdId1)) {
							return '';
						}
	                       let html = '<button type="button" class="btn_s2 btn_gray" name="delItemDtl1">취소</button>';
	                       return html;
	                     }
				},
				{data: 'cdNm2', className: 'dt-center'},
				{
					orderable: false,
					searchable: false,
					className : 'dt-center',
					render: function ( data, type, row ) {
						if (isEmpty(row.cdId2)) {
							return '';
						}
						var html = '<button type="button" class="btn_s2 btn_gray" name="delItemDtl2">취소</button>';
	                       return html;
	                     }
				}
			]
		});
	};

	const search_flowerClass = function() {
		//$('#tb_flowerClass').DataTable().draw();
		$('#tb_flowerClass').DataTable().ajax.reload();
	};
	const set_flowerClassRslt = function() {
		$('#tb_flowerClassRslt').DataTable().draw();
	};
	const search_market = function() {
		//$('#tb_market').DataTable().draw();
		$('#tb_market').DataTable().ajax.reload();
	};
	const set_marketRslt = function() {
		$('#tb_marketRslt').DataTable().draw();
	};


	const search_item = function() {

		console.log("##### search_item #####");
		$('#tb_item').DataTable().clear().draw();

		let flowers = "";
		flowerClassRslt.forEach(function(flower) {
				//flowers.push(flower.cdId);
				flowers += flower.cdId;
				flowers += ",";
			});
		console.log(flowers);
		let markets = "";
		marketRslt.forEach(function(market) {
				markets += market.cdId;
				markets += ",";
			} );

		let url = "/comm/selectItemList.json";
		let param = {
				saleDateFrom : document.querySelector("#cmprPeriod1From").value,
				saleDateTo : document.querySelector("#cmprPeriod1To").value,
				//flowers : flowers,
				//markets : markets,
				itemCd : null
			};
		console.log(param);

		$.ajax({
			type : "post",
			url : url,
			data : param,
			dataType : 'json',
			success : function(res){
				$('#tb_item').DataTable().clear().rows.add(res.data).draw();
			}
		});
	};
	const set_itemRslt = function() {
		$('#tb_itemRslt').DataTable().draw();
	};
	const search_itemDtl = function() {

		console.log("##### search_itemDtl #####");
		$('#tb_itemDtl').DataTable().clear().draw();

		let url = "/comm/selectItemDtlList.json";

		let flowers = [];
		flowerClassRslt.forEach(function(flower) {
				flowers.push(flower.cdId);
			});
		console.log(flowers);
		let markets = [];
		marketRslt.forEach(function(market) {
				markets.push(market.cdId)
			} );

		let param = {
				saleDateFrom : document.querySelector("#cmprPeriod1From").value,
				saleDateTo : document.querySelector("#cmprPeriod1To").value,
				flowerClassList : flowers,
				marketList : markets,
				itemCd : null
			};
		console.log(param);


		$.ajax({
			type : "post",
			url : url,
			data : param,
			dataType : 'json',
			success : function(res){
				$('#tb_itemDtl').DataTable().clear().rows.add(res.data).draw();
			}
		});
	};
	const set_itemDtlRslt = function() {
		$('#tb_itemDtlRslt').DataTable().draw();
	};

	const addCmprCond1 = function (data, ds, dTableRslt, callback) {
		let isAdded = false;
		ds.forEach(function(el, index) {
			if (isAdded) return;

			if (el.cdId1 == data.cdId) {
				isAdded = true;
			}
		});

		if (isAdded) return;

		let needAdd = true;
		ds.forEach(function(el, index) {
			if (!needAdd) return;

			if (isEmpty(el.cdId1)) {
				el.cdId1 = data.cdId;
				el.cdNm1 = data.cdNm;
				needAdd = false;
			}
		});

		if (needAdd) {
			ds.push(
				{
					cdId1: data.cdId,
					cdNm1: data.cdNm,
					cdId2: null,
					cdNm2: null,
					cdSeq: ds.length + 1
				}
			);
		}

		dTableRslt.clear().rows.add(ds).draw();
		console.log(typeof callback);
		if (typeof callback === "function") {
			callback();
		}
	};

	const addCmprCond2 = function (data, ds, dTableRslt, callback) {
		let isAdded = false;
		ds.forEach(function(el, index) {
			if (isAdded) return;

			if (el.cdId2 == data.cdId) {
				isAdded = true;
			}
		});

		if (isAdded) return;

		let needAdd = true;
		ds.forEach(function(el, index) {
			if (!needAdd) return;

			if (isEmpty(el.cdId2)) {
				el.cdId2 = data.cdId;
				el.cdNm2 = data.cdNm;
				needAdd = false;
			}
		});

		if (needAdd) {
			ds.push(
				{
					cdId1: null,
					cdNm1: null,
					cdId2: data.cdId,
					cdNm2: data.cdNm,
					cdSeq: ds.length + 1
				}
			);
		}

		dTableRslt.clear().rows.add(ds).draw();
		if (typeof callback === "function") {
			callback();
		}
	};

	const delCmprCond1 = function (data, ds, dTableRslt, callback) {
		ds.forEach(function(el, index, array) {
			if (data.cdId1 == el.cdId1) {
				if (isEmpty(el.cdId2)) {
					array.splice(index, 1);
				} else {
					el.cdId1 = null;
					el.cdNm1 = null;
				}
			}
		});

		ds.forEach(function(el, index, array) {
			el.cdSeq = index + 1;
		});

		dTableRslt.clear().rows.add(ds).draw();
		if (typeof callback === "function") {
			callback();
		}
	};

	const delCmprCond2 = function (data, ds, dTableRslt, callback) {
		ds.forEach(function(el, index, array) {
			if (data.cdId2 == el.cdId2) {
				if (isEmpty(el.cdId1)) {
					array.splice(index, 1);
				} else {
					el.cdId2 = null;
					el.cdNm2 = null;
				}
			}
		});

		ds.forEach(function(el, index, array) {
			el.cdSeq = index + 1;
		});

		dTableRslt.clear().rows.add(ds).draw();
		if (typeof callback === "function") {
			callback();
		}
	};

	$(document).on('click', 'button[name="btnApplDate"]', function() {
		let cmprPeriod1From = document.querySelector("#cmprPeriod1From");
		let cmprPeriod1To = document.querySelector("#cmprPeriod1To");
		let cmprPeriod2From = document.querySelector("#cmprPeriod2From");
		let cmprPeriod2To = document.querySelector("#cmprPeriod2To");
		setCmprDate(cmprPeriod1From, cmprPeriod1To, cmprPeriod2From, cmprPeriod2To);

	});

	$(document).on('click', 'button[name="selFlowerGubn1"]', function() {
		let ds = flowerClassRslt;
		let dt = $('#tb_flowerClassRslt').DataTable();
		let dtx = $('#tb_flowerClass').DataTable();
		let data = $('#tb_flowerClass').DataTable().row( $(this).parents('tr:first') ).data();
		addCmprCond1(data, ds, dt, search_flowerClass);

	});

	$(document).on('click', 'button[name="selFlowerGubn2"]', function() {
		let ds = flowerClassRslt;
		let dt = $('#tb_flowerClassRslt').DataTable();
		let dtx = $('#tb_flowerClass').DataTable();
		let data = $('#tb_flowerClass').DataTable().row( $(this).parents('tr:first') ).data();
		addCmprCond2(data, ds, dt, search_flowerClass);
	});

	$(document).on('click', 'button[name="delFlowerGubn1"]', function() {
		let ds = flowerClassRslt;
		let dt = $('#tb_flowerClassRslt').DataTable();
		let dtx = $('#tb_flowerClass').DataTable();
		let data = dt.row( $(this).parents('tr:first') ).data();
		delCmprCond1(data, ds, dt, search_flowerClass);
	});

	$(document).on('click', 'button[name="delFlowerGubn2"]', function() {
		let ds = flowerClassRslt;
		let dt = $('#tb_flowerClassRslt').DataTable();
		let dtx = $('#tb_flowerClass').DataTable();
		let data = dt.row( $(this).parents('tr:first') ).data();
		delCmprCond2(data, ds, dt, search_flowerClass);
	});

	$(document).on('click', 'button[name="selMarket1"]', function() {
		let ds = marketRslt;
		let dt = $('#tb_marketRslt').DataTable();
		let data = $('#tb_market').DataTable().row( $(this).parents('tr:first') ).data();
		addCmprCond1(data, ds, dt, search_market);
	});
	$(document).on('click', 'button[name="selMarket2"]', function() {
		let ds = marketRslt;
		let dt = $('#tb_marketRslt').DataTable();
		let data = $('#tb_market').DataTable().row( $(this).parents('tr:first') ).data();
		addCmprCond2(data, ds, dt, search_market);
	});
	$(document).on('click', 'button[name="delMarket1"]', function() {
		let ds = marketRslt;
		let dt = $('#tb_marketRslt').DataTable();
		let data = dt.row( $(this).parents('tr:first') ).data();
		delCmprCond1(data, ds, dt, search_market);
	});
	$(document).on('click', 'button[name="delMarket2"]', function() {
		let ds = marketRslt;
		let dt = $('#tb_marketRslt').DataTable();
		let data = dt.row( $(this).parents('tr:first') ).data();
		delCmprCond2(data, ds, dt, search_market);
	});
	$(document).on('click', 'button[name="selItem1"]', function() {
		let ds = itemRslt;
		let dt = $('#tb_itemRslt').DataTable();
		let data = $('#tb_item').DataTable().row( $(this).parents('tr:first') ).data();
		addCmprCond1(data, ds, dt, search_item);
	});
	$(document).on('click', 'button[name="selItem2"]', function() {
		let ds = itemRslt;
		let dt = $('#tb_itemRslt').DataTable();
		let data = $('#tb_item').DataTable().row( $(this).parents('tr:first') ).data();
		addCmprCond2(data, ds, dt, search_item);
	});
	$(document).on('click', 'button[name="delItem1"]', function() {
		let ds = itemRslt;
		let dt = $('#tb_itemRslt').DataTable();
		let data = dt.row( $(this).parents('tr:first') ).data();
		delCmprCond1(data, ds, dt, search_item);
	});
	$(document).on('click', 'button[name="delItem2"]', function() {
		let ds = itemRslt;
		let dt = $('#tb_itemRslt').DataTable();
		let data = dt.row( $(this).parents('tr:first') ).data();
		delCmprCond2(data, ds, dt, search_item);
	});
	$(document).on('click', 'button[name="selItemDtl1"]', function() {
		let ds = itemDtlRslt;
		let dt = $('#tb_itemDtlRslt').DataTable();
		let data = $('#tb_itemDtl').DataTable().row( $(this).parents('tr:first') ).data();
		addCmprCond1(data, ds, dt, search_itemDtl);
	});
	$(document).on('click', 'button[name="selItemDtl2"]', function() {
		let ds = itemDtlRslt;
		let dt = $('#tb_itemDtlRslt').DataTable();
		let data = $('#tb_itemDtl').DataTable().row( $(this).parents('tr:first') ).data();
		addCmprCond2(data, ds, dt, search_itemDtl);
	});
	$(document).on('click', 'button[name="delItemDtl1"]', function() {
		let ds = itemDtlRslt;
		let dt = $('#tb_itemDtlRslt').DataTable();
		let data = dt.row( $(this).parents('tr:first') ).data();
		delCmprCond1(data, ds, dt, search_itemDtl);
	});
	$(document).on('click', 'button[name="delItem2"]', function() {
		let ds = itemDtlRslt;
		let dt = $('#tb_itemDtlRslt').DataTable();
		let data = dt.row( $(this).parents('tr:first') ).data();
		delCmprCond2(data, ds, dt, search_itemDtl);
	});

	cmprPopupInit();

</script>