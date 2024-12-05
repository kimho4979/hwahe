<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
.fl {float:left;}
.fr {float:right;}

/* 탭 전체 스타일 */
.modal-body .tabs {
  margin-top: 50px;
  padding-bottom: 40px;
  background-color: #ffffff;
  box-shadow: none;
  width: 100%;
  margin: 0 auto;}

/* 탭 스타일 */
.tab_item {
  width: calc(100%/5);
  height: 40px;
  border-bottom: 1px solid #b8b8b8;
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
  padding: 40px 10px 0;
  clear: both;
  overflow: hidden;
}


/* 선택 된 탭 콘텐츠를 표시 */
#tp__period:checked ~ #period__content,
#tp__flowerCtgr:checked ~ #flowerCtgr__content,
#tp__market:checked ~ #market__content,
#tp__item:checked ~ #item__content,
#tp__itemDtl:checked ~ #itemDtl__content {
  display: block;
}

.tab_content table { width:100%; }
.tab_content table thead tr th {word-break: keep-all;}

/* 선택된 탭 스타일 */
.tabs input:checked + .tab_item {
  color: #4d6bed;
    border-bottom: 3px solid #4d6bed;
    font-size: 18px;
    font-weight: 700;
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
  <input id="tp__period" type="radio" name="tab_item" checked>
  <label class="tab_item" for="tp__period">기간</label>
  <input id="tp__flowerCtgr" type="radio" name="tab_item">
  <label class="tab_item" for="tp__flowerCtgr">부류</label>
  <input id="tp__market" type="radio" name="tab_item">
  <label class="tab_item" for="tp__market">경매장</label>
  <input id="tp__item" type="radio" name="tab_item">
  <label class="tab_item" for="tp__item">품목</label>
  <input id="tp__itemDtl" type="radio" name="tab_item">
  <label class="tab_item" for="tp__itemDtl">품종</label>

  <div class="tab_content" id="period__content">
	<div class="w3-container">
		<div class="w3-row">
			<div class="in_dsp">
				<input type="checkbox" id="chk__isPeriodCmpr" name="chk__isPeriodCmpr" checked style="display:none">
	    		<label for="chk__isPeriodCmpr" style="display:none"><span></span> 기간별 비교 </label>
	    	</div>
	    </div>
	    <div>
	    	<table class="table_type_03">
				<colgroup>
					<col width="15%">
					<col width="auto">
				</colgroup>
				<thead>
					<!-- <tr>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
					</tr> -->
				</thead>
				<tbody>
					<tr>
						<td class="sbn_tit_001">기간1</td>
						<td class="text-lt">
							<div class="date-from-to">
								<div class="cal_check_box">
									<input type="checkbox" id="chk__isDayCond1" name="chk__isDayCond1" style="display:none">
									<label for="chk__isDayCond1" style="display:none"><span></span> <em class="txt">일단위</em> </label>
								</div>
								<div class="calendar_new">
									<label for="dt__cond1DateFrom" class="ft0">시작 </label>
									<input type="date" id="dt__cond1DateFrom" name="dt__cond1DateFrom" class="hasDatepicker"  max="9999-12-31">
								</div>
								<span class="hyphen">~</span>
								<div class="calendar_new">
									<label for="dt__cond1DateTo" class="ft0">종료 </label>
									<input type="date" id="dt__cond1DateTo" name="dt__cond1DateTo" max="9999-12-31">
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td class="sbn_tit_001">기간2</td>
						<td class="text-lt">
							<div class="cal_check_box">
								<input type="checkbox" id="chk__isDayCond2" name="chk__isDayCond2" style="display:none">
								<label for="chk__isDayCond2" style="display:none"><span></span><em class="txt"> 일단위</em></label>
							</div>
							<div class="calendar_new">
								<label for="dt__cond2DateFrom" class="ft0">시작 </label>
								<input type="date" id="dt__cond2DateFrom" name="dt__cond2DateFrom" max="9999-12-31">
							</div>
							<span class="hyphen">~</span>
							<div class="calendar_new">
								<label for="dt__cond2DateTo" class="ft0">종료 </label>
								<input type="date" id="dt__cond2DateTo" name="dt__cond2DateTo" max="9999-12-31">
							</div>							
						</td>
					</tr>
				</tbody>
			</table>
	    </div>


	</div>
  </div>

  <!-- 부류 tab page -->
  <div class="tab_content" id="flowerCtgr__content">
    <!-- grid -->
    <div class="w3-container">
    	<h5>검색결과</h5>
		<table id="tb__flowerCtgrSrch" class="w3-table-all w3-hoverable display compact nowrap">
			<colgroup>
				<col width="35%" />
				<col width="15%" />
				<col width="35%" />
				<col width="15%" />
			</colgroup>
			<thead>
		      <tr class="w3-light-grey">
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
		<table id="tb__flowerCtgrRslt" class="w3-table-all w3-hoverable display compact nowrap">
			<colgroup>
				<col width="35%" />
				<col width="15%" />
				<col width="35%" />
				<col width="15%" />
			</colgroup>
			<thead>
		      <tr class="w3-light-grey">
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
  	<div class="tab_content" id="market__content">
	    <div class="w3-container">
	    	<h5>검색결과</h5>
			<table id="tb__marketSrch" class="w3-table-all w3-hoverable display compact nowrap">
				<colgroup>
					<col width="35%" />
					<col width="15%" />
					<col width="35%" />
					<col width="15%" />
				</colgroup>
				<thead>
			      <tr class="w3-light-grey">
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
			<table id="tb__marketRslt" class="w3-table-all w3-hoverable display compact nowrap">
				<colgroup>
					<col width="35%" />
					<col width="15%" />
					<col width="35%" />
					<col width="15%" />
				</colgroup>
				<thead>
			      <tr class="w3-light-grey">
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
  	<div class="tab_content" id="item__content">
	    <div class="w3-container">
	    	<h5>검색결과</h5>
			<table id="tb__itemSrch" class="w3-table-all w3-hoverable display compact nowrap">
				<colgroup>
					<col width="35%" />
					<col width="15%" />
					<col width="35%" />
					<col width="15%" />
				</colgroup>
				<thead>
			      <tr class="w3-light-grey">
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
			<table id="tb__itemRslt" class="w3-table-all w3-hoverable display compact nowrap">
				<colgroup>
					<col width="35%" />
					<col width="15%" />
					<col width="35%" />
					<col width="15%" />
				</colgroup>
				<thead>
			      <tr class="w3-light-grey">
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
  	<div class="tab_content" id="itemDtl__content">
    	<div class="w3-container">
	    	<h5>검색결과</h5>
			<table id="tb__itemDtlSrch" class="w3-table-all w3-hoverable display compact nowrap">
				<colgroup>
					<col width="35%" />
					<col width="15%" />
					<col width="35%" />
					<col width="15%" />
				</colgroup>
				<thead>
			      <tr class="w3-light-grey">
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
			<table id="tb__itemDtlRslt" class="w3-table-all w3-hoverable display compact nowrap">
				<colgroup>
					<col width="35%" />
					<col width="15%" />
					<col width="35%" />
					<col width="15%" />
				</colgroup>
				<thead>
			      <tr class="w3-light-grey">
			        <th>조건1</th>
			        <th>취소</th>
			        <th>조건2</th>
			        <th>취소</th>
			      </tr>
			    </thead>
		    </table>
	    </div>
  	</div>
    <div class="w3-container w3-center">
		<div class="w3-bar w3-padding-16">
			<button class="w3-button w3-grey w3-border" name="btn__resetCmprPopup">초기화</button>
			<button class="w3-button w3-blue w3-border" name="btn__confirmCmprPopup">적용</button>
			<button class="w3-button w3-white w3-border" name="btn__closeCmprPopup">취소</button>
		</div>
    </div>
</div>

<script>
	let selectTabId = '';
	
	const cmprPopup = {
		rsPeriod: {
			isPeriodCmpr: false,
			isDayCond1: false,
			cond1DateFrom: '',
			cond1DateTo: '',
			isDayCond2: false,
			cond2DateFrom: '',
			cond2DateTo: ''
		},
		rsFlowerCtgr: [],
		rsMarket: [],
		rsItem: [],
		rsItemDtl: [],
		openPopup: function(tabId, rs) {
			
			cmprPopup.resetParam();
			
			cmprPopup.rsPeriod = rs.period;

			rs.flowerCtgr.forEach(function(item){
				cmprPopup.rsFlowerCtgr.push(item);
			});
			rs.market.forEach(function(item){
				cmprPopup.rsMarket.push(item);
			});
			rs.item.forEach(function(item){
				cmprPopup.rsItem.push(item);
			});
			rs.itemDtl.forEach(function(item){
				cmprPopup.rsItemDtl.push(item);
			});

			cmprPopup.redrawResult();

			let modal = document.getElementById("cmprPopup");
			modal.style.display = "block";
			cmprPopup.selectTab(tabId);
		},
		resetParam: function() {
			
			if(selectTabId && ['tp__period','tp__flowerCtgr','tp__market','tp__item','tp__itemDtl'].indexOf(selectTabId) > -1){
				
				switch (selectTabId) {
					case "tp__period":
						let tempDate = new Date();
						let defaultDate = tempDate.toISOString().substr(0, 10);
						cmprPopup.rsPeriod = {
							isPeriodCmpr: false,
							isDayCond1: false,
							cond1DateFrom: defaultDate.substr(0, 8) + '01',
							cond1DateTo: defaultDate,
							isDayCond2: false,
							cond2DateFrom: defaultDate.substr(0, 8) + '01',
							cond2DateTo: defaultDate
						};

						let chk__isPeriodCmpr = document.querySelector("#chk__isPeriodCmpr");
						let chk__isDayCond1 = document.querySelector("#chk__isDayCond1");
						let dt__cond1DateFrom = document.querySelector("#dt__cond1DateFrom");
						let dt__cond1DateTo = document.querySelector("#dt__cond1DateTo");
						let chk__isDayCond2 = document.querySelector("#chk__isDayCond2");
						let dt__cond2DateFrom = document.querySelector("#dt__cond2DateFrom");
						let dt__cond2DateTo = document.querySelector("#dt__cond2DateTo");

						chk__isPeriodCmpr.checked = cmprPopup.rsPeriod.isPeriodCmpr;
						chk__isDayCond1.checked = cmprPopup.rsPeriod.isDayCond1;
						dt__cond1DateFrom.value = cmprPopup.rsPeriod.cond1DateFrom;
						dt__cond1DateTo.value = cmprPopup.rsPeriod.cond1DateTo;
						chk__isDayCond2.checked = cmprPopup.rsPeriod.isDayCond2;
						dt__cond2DateFrom.value = cmprPopup.rsPeriod.cond2DateFrom;
						dt__cond2DateTo.value = cmprPopup.rsPeriod.cond2DateTo;
						break;
					case "tp__flowerCtgr" :
						cmprPopup.rsFlowerCtgr.length = 0;
						break;
					case "tp__market" :
						cmprPopup.rsMarket.length = 0;
						break;
					case "tp__item" :
						cmprPopup.rsItem.length = 0;
						break;
					case "tp__itemDtl" :
						cmprPopup.rsItemDtl.length = 0;
						break;
					default:
						break;
				}
			}else{
				let tempDate = new Date();
				let defaultDate = tempDate.toISOString().substr(0, 10);
				cmprPopup.rsPeriod = {
					isPeriodCmpr: false,
					isDayCond1: false,
					cond1DateFrom: defaultDate.substr(0, 8) + '01',
					cond1DateTo: defaultDate,
					isDayCond2: false,
					cond2DateFrom: defaultDate.substr(0, 8) + '01',
					cond2DateTo: defaultDate
				};

				let chk__isPeriodCmpr = document.querySelector("#chk__isPeriodCmpr");
				let chk__isDayCond1 = document.querySelector("#chk__isDayCond1");
				let dt__cond1DateFrom = document.querySelector("#dt__cond1DateFrom");
				let dt__cond1DateTo = document.querySelector("#dt__cond1DateTo");
				let chk__isDayCond2 = document.querySelector("#chk__isDayCond2");
				let dt__cond2DateFrom = document.querySelector("#dt__cond2DateFrom");
				let dt__cond2DateTo = document.querySelector("#dt__cond2DateTo");

				chk__isPeriodCmpr.checked = cmprPopup.rsPeriod.isPeriodCmpr;
				chk__isDayCond1.checked = cmprPopup.rsPeriod.isDayCond1;
				dt__cond1DateFrom.value = cmprPopup.rsPeriod.cond1DateFrom;
				dt__cond1DateTo.value = cmprPopup.rsPeriod.cond1DateTo;
				chk__isDayCond2.checked = cmprPopup.rsPeriod.isDayCond2;
				dt__cond2DateFrom.value = cmprPopup.rsPeriod.cond2DateFrom;
				dt__cond2DateTo.value = cmprPopup.rsPeriod.cond2DateTo;

				cmprPopup.rsFlowerCtgr.length = 0;
				cmprPopup.rsMarket.length = 0;
				cmprPopup.rsItem.length = 0;
				cmprPopup.rsItemDtl.length = 0;
			}

			cmprPopup.redrawResult();
		},
		redrawResult: function() {
			
			if(selectTabId && ['tp__period','tp__flowerCtgr','tp__market','tp__item','tp__itemDtl'].indexOf(selectTabId) > -1){
				switch (selectTabId) {
					case "tp__period":
						const tabPage = document.querySelector("#period__content");
						let chk__isPeriodCmpr = tabPage.querySelector("#chk__isPeriodCmpr");
						let chk__isDayCond1 = tabPage.querySelector("#chk__isDayCond1");
						let dt__cond1DateFrom = tabPage.querySelector("#dt__cond1DateFrom");
						let dt__cond1DateTo = tabPage.querySelector("#dt__cond1DateTo");
						let chk__isDayCond2 = tabPage.querySelector("#chk__isDayCond2");
						let dt__cond2DateFrom = tabPage.querySelector("#dt__cond2DateFrom");
						let dt__cond2DateTo = tabPage.querySelector("#dt__cond2DateTo");
	
						chk__isPeriodCmpr.checked = cmprPopup.rsPeriod.isPeriodCmpr;
						chk__isDayCond1.checked = cmprPopup.rsPeriod.isDayCond1;
						dt__cond1DateFrom.value = cmprPopup.rsPeriod.cond1DateFrom;
						dt__cond1DateTo.value = cmprPopup.rsPeriod.cond1DateTo;
						chk__isDayCond2.checked = cmprPopup.rsPeriod.isDayCond2;
						dt__cond2DateFrom.value = cmprPopup.rsPeriod.cond2DateFrom;
						dt__cond2DateTo.value = cmprPopup.rsPeriod.cond2DateTo;
						break;
					case "tp__flowerCtgr" :
						$('#tb__flowerCtgrRslt').DataTable().clear().rows.add(cmprPopup.rsFlowerCtgr).draw();
						break;
					case "tp__market" :
						$('#tb__marketRslt').DataTable().clear().rows.add(cmprPopup.rsMarket).draw();
						break;
					case "tp__item" :
						$('#tb__itemRslt').DataTable().clear().rows.add(cmprPopup.rsItem).draw();
						break;
					case "tp__itemDtl" :
						$('#tb__itemDtlRslt').DataTable().clear().rows.add(cmprPopup.rsItemDtl).draw();
						break;
					default:
						break;
				}
			}else{
				$('#tb__flowerCtgrRslt').DataTable().clear().rows.add(cmprPopup.rsFlowerCtgr).draw();
				$('#tb__marketRslt').DataTable().clear().rows.add(cmprPopup.rsMarket).draw();
				$('#tb__itemRslt').DataTable().clear().rows.add(cmprPopup.rsItem).draw();
				$('#tb__itemDtlRslt').DataTable().clear().rows.add(cmprPopup.rsItemDtl).draw();

				const tabPage = document.querySelector("#period__content");
				let chk__isPeriodCmpr = tabPage.querySelector("#chk__isPeriodCmpr");
				let chk__isDayCond1 = tabPage.querySelector("#chk__isDayCond1");
				let dt__cond1DateFrom = tabPage.querySelector("#dt__cond1DateFrom");
				let dt__cond1DateTo = tabPage.querySelector("#dt__cond1DateTo");
				let chk__isDayCond2 = tabPage.querySelector("#chk__isDayCond2");
				let dt__cond2DateFrom = tabPage.querySelector("#dt__cond2DateFrom");
				let dt__cond2DateTo = tabPage.querySelector("#dt__cond2DateTo");

				chk__isPeriodCmpr.checked = cmprPopup.rsPeriod.isPeriodCmpr;
				chk__isDayCond1.checked = cmprPopup.rsPeriod.isDayCond1;
				dt__cond1DateFrom.value = cmprPopup.rsPeriod.cond1DateFrom;
				dt__cond1DateTo.value = cmprPopup.rsPeriod.cond1DateTo;
				chk__isDayCond2.checked = cmprPopup.rsPeriod.isDayCond2;
				dt__cond2DateFrom.value = cmprPopup.rsPeriod.cond2DateFrom;
				dt__cond2DateTo.value = cmprPopup.rsPeriod.cond2DateTo;
			}
			
		},
		confirmParam: function() {
			let chk__isPeriodCmpr = document.querySelector("#chk__isPeriodCmpr");
			let chk__isDayCond1 = document.querySelector("#chk__isDayCond1");
			let dt__cond1DateFrom = document.querySelector("#dt__cond1DateFrom");
			let dt__cond1DateTo = document.querySelector("#dt__cond1DateTo");
			let chk__isDayCond2 = document.querySelector("#chk__isDayCond2");
			let dt__cond2DateFrom = document.querySelector("#dt__cond2DateFrom");
			let dt__cond2DateTo = document.querySelector("#dt__cond2DateTo");

			cmprPopup.rsPeriod.isPeriodCmpr = chk__isPeriodCmpr.checked;
			cmprPopup.rsPeriod.isDayCond1 = chk__isDayCond1.checked;
			cmprPopup.rsPeriod.cond1DateFrom = dt__cond1DateFrom.value;
			cmprPopup.rsPeriod.cond1DateTo = dt__cond1DateTo.value;
			cmprPopup.rsPeriod.isDayCond2 = chk__isDayCond2.checked;
			cmprPopup.rsPeriod.cond2DateFrom = dt__cond2DateFrom.value;
			cmprPopup.rsPeriod.cond2DateTo = dt__cond2DateTo.value;

			const period = cmprPopup.rsPeriod;
			const flowers = [];
			const markets = [];
			const items = [];
			const itemDtls = [];

			cmprPopup.rsFlowerCtgr.forEach(function(item) {
				flowers.push(item);
			});
			cmprPopup.rsMarket.forEach(function(item) {
				markets.push(item);
			});
			cmprPopup.rsItem.forEach(function(item) {
				items.push(item);
			});
			cmprPopup.rsItemDtl.forEach(function(item) {
				itemDtls.push(item);
			});

			const param = {
				period: period,
				flowerCtgr: flowers,
				market: markets,
				item: items,
				itemDtl: itemDtls
			};

			cmprPopup.confirm(param);
		},
		selectPeriod: function() {			
			
		},
		selectFlowerCtgr: function() {
			let url = "/comm/selectFlowerGubnList.json";
			let param = {};
			$.ajax({
				type : "post",
				url : url,
				data : param,
				dataType : 'json',
				success : function(res){
					$('#tb__flowerCtgrSrch').DataTable().clear().rows.add(res.data).draw();
				}
			});
			$('#tb__flowerCtgrRslt').DataTable().clear().rows.add(cmprPopup.rsFlowerCtgr).draw();
		},
		selectMarket: function() {
			let url = "/comm/selectMarketList.json";
			let param = {};
			$.ajax({
				type : "post",
				url : url,
				data : param,
				dataType : 'json',
				success : function(res){
					$('#tb__marketSrch').DataTable().clear().rows.add(res.data).draw();
				}
			});
			$('#tb__marketRslt').DataTable().clear().rows.add(cmprPopup.rsMarket).draw();
		},
		selectItem: function() {
			let url = "/comm/selectItemList.json";

			const flowers = [];
			const markets = [];

			let isPeriodCmpr = cmprPopup.rsPeriod.isPeriodCmpr;
			cmprPopup.rsFlowerCtgr.forEach(function(item){
				flowers.push(item.cdId1);
				if (!isPeriodCmpr) {
					flowers.push(item.cdId2);
				}
			});
			cmprPopup.rsMarket.forEach(function(item){
				markets.push(item.cdId1);
				if (!isPeriodCmpr) {
					markets.push(item.cdId2);
				}
			});
			
			
			let cond1DateFrom = document.querySelector("#dt__cond1DateFrom").value;
			let cond1DateTo = document.querySelector("#dt__cond1DateTo").value;
			let cond2DateFrom = document.querySelector("#dt__cond2DateFrom").value;
			let cond2DateTo = document.querySelector("#dt__cond2DateTo").value;

			let saleDateFrom = cond1DateFrom < cond2DateFrom
								? cond1DateFrom : cond2DateFrom;
			let saleDateTo = cond1DateTo > cond2DateTo
								? cond1DateTo : cond2DateTo;
			
			
			let param = {
					saleDateFrom: saleDateFrom,
					saleDateTo: saleDateTo,
					flower: flowers,
					market: markets, 
					type: ""
			};

			$.ajax({
				type : "post",
				url : url,
				data : param,
				dataType : 'json',
				success : function(res){
					$('#tb__itemSrch').DataTable().clear().rows.add(res.data).draw();
				}
			});
			$('#tb__itemRslt').DataTable().clear().rows.add(cmprPopup.rsItem).draw();
		},
		selectItemDtl: function() {
			let url = "/comm/selectItemDtlList.json";

			const flowers = [];
			const markets = [];
			const items = [];

			let isPeriodCmpr = cmprPopup.rsPeriod.isPeriodCmpr;
			cmprPopup.rsFlowerCtgr.forEach(function(item){
				flowers.push(item.cdId1);
				if (!isPeriodCmpr) {
					flowers.push(item.cdId2);
				}
			});
			cmprPopup.rsMarket.forEach(function(item){
				markets.push(item.cdId1);
				if (!isPeriodCmpr) {
					markets.push(item.cdId2);
				}
			});
			cmprPopup.rsItem.forEach(function(item){
				items.push(item.cdId1);
				if (!isPeriodCmpr) {
					items.push(item.cdId2);
				}
			});

			let cond1DateFrom = document.querySelector("#dt__cond1DateFrom").value;
			let cond1DateTo = document.querySelector("#dt__cond1DateTo").value;
			let cond2DateFrom = document.querySelector("#dt__cond2DateFrom").value;
			let cond2DateTo = document.querySelector("#dt__cond2DateTo").value;

			let saleDateFrom = cond1DateFrom < cond2DateFrom
								? cond1DateFrom : cond2DateFrom;
			let saleDateTo = cond1DateTo > cond2DateTo
								? cond1DateTo : cond2DateTo;
			let param = {
					saleDateFrom: saleDateFrom,
					saleDateTo: saleDateTo,
					flower: flowers,
					market: markets,
					item: items, 
					type: ""
			};

			$.ajax({
				type : "post",
				url : url,
				data : param,
				dataType : 'json',
				success : function(res){
					$('#tb__itemDtlSrch').DataTable().clear().rows.add(res.data).draw();
				}
			});
			$('#tb__itemDtlRslt').DataTable().clear().rows.add(cmprPopup.rsItemDtl).draw();
		},
		selectTab : function(tabId) {

			let searchFnc;
			selectTabId = tabId;
			switch (tabId) {
				case "tp__period":
					searchFnc = cmprPopup.selectPeriod;
					break;
				case "tp__flowerCtgr" :
					searchFnc = cmprPopup.selectFlowerCtgr;
					break;
				case "tp__market" :
					searchFnc = cmprPopup.selectMarket;
					break;
				case "tp__item" :
					searchFnc = cmprPopup.selectItem;
					break;
				case "tp__itemDtl" :
					searchFnc = cmprPopup.selectItemDtl;
					break;
				default:
					break;
			}
			
			var radioBtn = document.getElementById(tabId);
			radioBtn.checked = true;

			if (typeof searchFnc === 'function') {
				searchFnc();
			}
		},
		init : function(callbackFnc) {
			if (typeof callbackFnc === 'function') {
                cmprPopup.confirm = function(ds) {
                    callbackFnc(ds);
                }
            }

			// 부류 검색 Table
			$('#tb__flowerCtgrSrch').DataTable({
				scrollCollapse: true,
				paging: false ,
				ordering: false,
				searching : false,
				info : false,
				language: {
					'search': '검색 : ', 
					"emptyTable": " "
				},
				columns: [
					{data: 'cdNm', className: 'dt-center'},
					{
						orderable: false,
						searchable: false,
						className : 'dt-center',
						render: function ( data, type, row ) {
							let html = '<button class="w3-button btn-pop-green" name="btn__insertFlowerCtgr1" >선택</button>';
							return html;
						}
					},
					{data: 'cdNm', className: 'dt-center'},
					{
						orderable: false,
						searchable: false,
						className : 'dt-center',
						render: function ( data, type, row ) {
							let html = '<button class="w3-button btn-pop-green" name="btn__insertFlowerCtgr2" >선택</button>';
							return html;
						}
					}
				]
			});
			// 부류 결과 Table
			$('#tb__flowerCtgrRslt').DataTable({
				scrollCollapse: false,
				paging: false ,
				ordering: false,
				searching : false,				
				info : false,
				language: {
					"emptyTable": " "
				},
				columns: [
					{data: 'cdNm1', className: 'dt-center'},
					{
						orderable: false,
						searchable: false,
						className : 'dt-center',
						render: function ( data, type, row ) {
							if (isEmpty(row.cdId1)) {
								return '';
							}
							let html = '<button class="w3-button btn-pop-red" name="btn__deleteFlowerCtgr1" >취소</button>';
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
							let html = '<button class="w3-button btn-pop-red" name="btn__deleteFlowerCtgr2" >취소</button>';
							return html;
						}
					}
				]
			});
			// 경매장 검색 Table
			$('#tb__marketSrch').DataTable({
				scrollCollapse: true,
				paging: false ,
				ordering: false,
				searching : false,
				info : false,
				language: {
					'search': '검색 : ', 
					"emptyTable": " "
				},
				columns: [
					{data: 'cdNm', className: 'dt-center'},
					{
						orderable: false,
						searchable: false,
						className : 'dt-center',
						render: function ( data, type, row ) {
							let html = '<button class="w3-button btn-pop-green" name="btn__insertMarket1" >선택</button>';
							return html;
						}
					},
					{data: 'cdNm', className: 'dt-center'},	//cdNm cdSeq
					{
						orderable: false,
						searchable: false,
						className : 'dt-center',
						render: function ( data, type, row ) {
							let html = '<button class="w3-button btn-pop-green" name="btn__insertMarket2" >선택</button>';
							return html;
						}
					}
				]
			});
			// 경매장 결과 Table
			$('#tb__marketRslt').DataTable({
				scrollCollapse: false,
				paging: false ,
				ordering: false,
				searching : false,
				info : false,
				language: { 
					"emptyTable": " "
				},
				columns: [
					{data: 'cdNm1', className: 'dt-center'},
					{
						orderable: false,
						searchable: false,
						className : 'dt-center',
						render: function ( data, type, row ) {
							if (isEmpty(row.cdId1)) {
								return '';
							}
							let html = '<button class="w3-button btn-pop-red" name="btn__deleteMarket1" >취소</button>';
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
							let html = '<button class="w3-button btn-pop-red" name="btn__deleteMarket2" >취소</button>';
							return html;
						}
					}
				]
			});
			// 품목 검색 Table
			$('#tb__itemSrch').DataTable({
				scrollY: '20vh',
				scrollCollapse: true,
				paging: false ,
				ordering: false,
				searching : true,
				info : false,
				language: {
					'search': '검색 : ', 
					"emptyTable": " "
				},
				columns: [
					{data: 'cdNm', className: 'dt-center'},
					{
						orderable: false,
						searchable: false,
						className : 'dt-center',
						render: function ( data, type, row ) {
							let html = '<button class="w3-button btn-pop-green" name="btn__insertItem1" >선택</button>';
							return html;
						}
					},
					{data: 'cdNm', className: 'dt-center'},
					{
						orderable: false,
						searchable: false,
						className : 'dt-center',
						render: function ( data, type, row ) {
							let html = '<button class="w3-button btn-pop-green" name="btn__insertItem2" >선택</button>';
							return html;
						}
					}
				]
			});
			// 품목 결과 Table
			$('#tb__itemRslt').DataTable({
				scrollY: '20vh',
				scrollCollapse: false,
				paging: false ,
				ordering: false,
				searching : false,
				info : false,
				language: {
					"emptyTable": " "
				},
				columns: [
					{data: 'cdNm1', className: 'dt-center'},
					{
						orderable: false,
						searchable: false,
						className : 'dt-center',
						render: function ( data, type, row ) {
							if (isEmpty(row.cdId1)) {
								return '';
							}
							let html = '<button class="w3-button btn-pop-red" name="btn__deleteItem1" >취소</button>';
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
							let html = '<button class="w3-button btn-pop-red" name="btn__deleteItem2" >취소</button>';
							return html;
						}
					}
				]
			});
			// 품종 검색 Table
			$('#tb__itemDtlSrch').DataTable({
				scrollY: '20vh',
				scrollCollapse: true,
				paging: false ,
				ordering: false,
				searching : true,
				info : false,
				language: {
					'search': '검색 : ', 
					"emptyTable": " "
				},
				columns: [
					{data: 'cdNm', className: 'dt-center'},
					{
						orderable: false,
						searchable: false,
						className : 'dt-center',
						render: function ( data, type, row ) {
							let html = '<button class="w3-button btn-pop-green" name="btn__insertItemDtl1" >선택</button>';
							return html;
						}
					},
					{data: 'cdNm', className: 'dt-center'},	//cdNm cdSeq
					{
						orderable: false,
						searchable: false,
						className : 'dt-center',
						render: function ( data, type, row ) {
							let html = '<button class="w3-button btn-pop-green" name="btn__insertItemDtl2" >선택</button>';
							return html;
						}
					}
				]
			});
			// 품종 결과 Table
			$('#tb__itemDtlRslt').DataTable({
				scrollY: '20vh',
				scrollCollapse: false,
				paging: false ,
				ordering: false,
				searching : false,
				info : false,
				language: {
					"emptyTable": " "
				},
				columns: [
					{data: 'cdNm1', className: 'dt-center'},
					{
						orderable: false,
						searchable: false,
						className : 'dt-center',
						render: function ( data, type, row ) {
							if (isEmpty(row.cdId1)) {
								return '';
							}
							let html = '<button class="w3-button btn-pop-red" name="btn__deleteItemDtl1" >취소</button>';
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
							let html = '<button class="w3-button btn-pop-red" name="btn__deleteItemDtl2" >취소</button>';
							return html;
						}
					}
				]
			});

			cmprPopup.resetParam();

			let tabs = document.getElementsByName("tab_item");
			for(i=0 ; i < tabs.length ; i++){
				tabs[i].addEventListener('click', function () {
					cmprPopup.selectTab(this.id);
				});
			}

			// 부류 선택, 취소 grid event
			$(document).on('click', 'button[name="btn__insertFlowerCtgr1"]', function() {
				let dt = $('#tb__flowerCtgrRslt').DataTable();
				let data = $('#tb__flowerCtgrSrch').DataTable().row( $(this).parents('tr:first') ).data();
				let ds = cmprPopup.rsFlowerCtgr;
				cmprPopup.addCmprCond1(data, ds, dt);
			});
			$(document).on('click', 'button[name="btn__insertFlowerCtgr2"]', function() {
				let dt = $('#tb__flowerCtgrRslt').DataTable();
				let data = $('#tb__flowerCtgrSrch').DataTable().row( $(this).parents('tr:first') ).data();
				let ds = cmprPopup.rsFlowerCtgr;
				cmprPopup.addCmprCond2(data, ds, dt);
			});
			$(document).on('click', 'button[name="btn__deleteFlowerCtgr1"]', function() {
				let dt = $('#tb__flowerCtgrRslt').DataTable();
				let data = dt.row( $(this).parents('tr:first') ).data();
				let ds = cmprPopup.rsFlowerCtgr;
				cmprPopup.delCmprCond1(data, ds, dt);
			});
			$(document).on('click', 'button[name="btn__deleteFlowerCtgr2"]', function() {
				let dt = $('#tb__flowerCtgrRslt').DataTable();
				let data = dt.row( $(this).parents('tr:first') ).data();
				let ds = cmprPopup.rsFlowerCtgr;
				cmprPopup.delCmprCond2(data, ds, dt);
			});

			// 경매장 선택, 취소 grid event
			$(document).on('click', 'button[name="btn__insertMarket1"]', function(e) {
				if($(e.target).parent().prev().text().indexOf('과천') != -1){ gwacheonAlert(); }
				let dt = $('#tb__marketRslt').DataTable();
				let data = $('#tb__marketSrch').DataTable().row( $(this).parents('tr:first') ).data();
				let ds = cmprPopup.rsMarket;
				cmprPopup.addCmprCond1(data, ds, dt);
			});
			$(document).on('click', 'button[name="btn__insertMarket2"]', function(e) {
				if($(e.target).parent().prev().text().indexOf('과천') != -1){ gwacheonAlert(); }
				let dt = $('#tb__marketRslt').DataTable();
				let data = $('#tb__marketSrch').DataTable().row( $(this).parents('tr:first') ).data();
				let ds = cmprPopup.rsMarket;
				cmprPopup.addCmprCond2(data, ds, dt);
			});
			$(document).on('click', 'button[name="btn__deleteMarket1"]', function() {
				let dt = $('#tb__marketRslt').DataTable();
				let data = dt.row( $(this).parents('tr:first') ).data();
				let ds = cmprPopup.rsMarket;
				cmprPopup.delCmprCond1(data, ds, dt);
			});
			$(document).on('click', 'button[name="btn__deleteMarket2"]', function() {
				let dt = $('#tb__marketRslt').DataTable();
				let data = dt.row( $(this).parents('tr:first') ).data();
				let ds = cmprPopup.rsMarket;
				cmprPopup.delCmprCond2(data, ds, dt);
			});

			// 품목 선택, 취소 grid event
			$(document).on('click', 'button[name="btn__insertItem1"]', function() {
				let dt = $('#tb__itemRslt').DataTable();
				let data = $('#tb__itemSrch').DataTable().row( $(this).parents('tr:first') ).data();
				let ds = cmprPopup.rsItem;
				cmprPopup.addCmprCond1(data, ds, dt);
			});
			$(document).on('click', 'button[name="btn__insertItem2"]', function() {
				let dt = $('#tb__itemRslt').DataTable();
				let data = $('#tb__itemSrch').DataTable().row( $(this).parents('tr:first') ).data();
				let ds = cmprPopup.rsItem;
				cmprPopup.addCmprCond2(data, ds, dt);
			});
			$(document).on('click', 'button[name="btn__deleteItem1"]', function() {
				let dt = $('#tb__itemRslt').DataTable();
				let data = dt.row( $(this).parents('tr:first') ).data();
				let ds = cmprPopup.rsItem;
				cmprPopup.delCmprCond1(data, ds, dt);
			});
			$(document).on('click', 'button[name="btn__deleteItem2"]', function() {
				let dt = $('#tb__itemRslt').DataTable();
				let data = dt.row( $(this).parents('tr:first') ).data();
				let ds = cmprPopup.rsItem;
				cmprPopup.delCmprCond2(data, ds, dt);
			});

			// 품종 선택, 취소 grid event
			$(document).on('click', 'button[name="btn__insertItemDtl1"]', function() {
				let dt = $('#tb__itemDtlRslt').DataTable();
				let data = $('#tb__itemDtlSrch').DataTable().row( $(this).parents('tr:first') ).data();
				let ds = cmprPopup.rsItemDtl;
				cmprPopup.addCmprCond1(data, ds, dt);
			});
			$(document).on('click', 'button[name="btn__insertItemDtl2"]', function() {
				let dt = $('#tb__itemDtlRslt').DataTable();
				let data = $('#tb__itemDtlSrch').DataTable().row( $(this).parents('tr:first') ).data();
				let ds = cmprPopup.rsItemDtl;
				cmprPopup.addCmprCond2(data, ds, dt);
			});
			$(document).on('click', 'button[name="btn__deleteItemDtl1"]', function() {
				let dt = $('#tb__itemDtlRslt').DataTable();
				let data = dt.row( $(this).parents('tr:first') ).data();
				let ds = cmprPopup.rsItemDtl;
				cmprPopup.delCmprCond1(data, ds, dt);
			});
			$(document).on('click', 'button[name="btn__deleteItemDtl2"]', function() {
				let dt = $('#tb__itemDtlRslt').DataTable();
				let data = dt.row( $(this).parents('tr:first') ).data();
				let ds = cmprPopup.rsItemDtl;
				cmprPopup.delCmprCond2(data, ds, dt);
			});

			// 하단 버튼
			// 초기화
			$(document).on('click', 'button[name="btn__resetCmprPopup"]', function() {
				cmprPopup.resetParam();
				
				/* 
				let today = new Date();
				let fromDate = today.toISOString().substr(0, 10);
				let toDate = fromDate;
				cmprPopup.rsPeriod = {
					isPeriodCmpr: false,
					isDayCond1: false,
					cond1DateFrom: fromDate,
					cond1DateTo: toDate,
					isDayCond2: false,
					cond2DateFrom: fromDate,
					cond2DateTo: toDate
				};
				cmprPopup.rsFlowerCtgr = [];
				cmprPopup.rsMarket = [];
				cmprPopup.rsItem = [];
				cmprPopup.rsItemDtl = [];
				 */
			});

			// 적용
			$(document).on('click', 'button[name="btn__confirmCmprPopup"]', function() {
				let modal = document.getElementById("cmprPopup");
				modal.style.display = "none";
				cmprPopup.confirmParam();
				selectTabId = '';
			});

			// 취소
			$(document).on('click', 'button[name="btn__closeCmprPopup"]', function() {
				let modal = document.getElementById("cmprPopup");
				modal.style.display = "none";
				selectTabId = '';
			});

		},
		addCmprCond1 : function (data, ds, dt, callback) {
			let isAdded = false;
			ds.forEach(function(el, index) {
				if (el.cdId1 == data.cdId) {
					isAdded = true;
					return false;
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
			dt.clear().rows.add(ds).draw();
		},
		addCmprCond2 : function (data, ds, dt, callback) {
			let isAdded = false;
			ds.forEach(function(el, index) {
				if (el.cdId2 == data.cdId) {
					isAdded = true;
					return false;
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
			dt.clear().rows.add(ds).draw();
		},
		delCmprCond1 : function (data, ds, dt, callback) {
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
			dt.clear().rows.add(ds).draw();
		},
		delCmprCond2 : function (data, ds, dt, callback) {
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
			dt.clear().rows.add(ds).draw();
		},
		confirm : function() {
		},
		close : function() {}
	}


	// cmprPopup.init();

</script>