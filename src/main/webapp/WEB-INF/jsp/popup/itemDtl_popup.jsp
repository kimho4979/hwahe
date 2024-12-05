<div id="itemDtl_popup">
	<div class="w3-container">
		<h5>검색결과</h5>
		<table id="tb__itemDtlSrch" class="w3-table-all w3-hoverable display compact nowrap">
			<colgroup>
				<col width="20%" />
				<col width="60%" />
				<col width="20%" />
			</colgroup>
			<thead>
			  <tr class="w3-light-grey">
				<th>번호</th>
				<th>코드명</th>
				<th>선택</th>
			  </tr>
			</thead>
		</table>
	</div>
	<div class="w3-container">
		<h5>선택결과</h5>
		<table id="tb__itemDtlRslt" class="w3-table-all w3-hoverable display compact nowrap">
			<colgroup>
				<col width="20%" />
				<col width="60%" />
				<col width="20%" />
			</colgroup>
			<thead>
			  <tr class="w3-light-grey">
				<th>번호</th>
				<th>코드명</th>
				<th>취소</th>
			  </tr>
			</thead>
		</table>            
	</div>
	<div class="w3-container w3-padding-16 popup-confirm">
		<div class="w3-center">
			<button class="w3-button w3-white w3-mobile" name="btn__cancelItemDtl">취소</button>
			<button class="w3-button w3-blue w3-mobile" name="btn__confirmItemDtl">적용</button>
		</div>
	</div>
	<script>
		const data__itemDtlSrch = [];
		const data__itemDtlRslt = [];

		let confirm__itemDtl;

		const itemDtlPopup = {
			init : function (callbackFnc) {
				confirm__itemDtl = function(ds) {
					callbackFnc(ds);
				}
				// 조회 Table
				$('#tb__itemDtlSrch').DataTable({
					scrollY: '20vh',
					scrollCollapse: false,
					paging: true,
					searching : true,
					info : true,
					columns: [
						{data: 'cdSeq', className: 'dt-center'},
						{data: 'cdNm', className: 'dt-center'},
						{
							orderable: false,
							searchable: false,
							className : 'dt-center',
							render: function ( data, type, row ) {
								let html = '<button class="w3-button w3-green w3-mobile" name="btn__insertItemDtl" >선택</button>';
								return html;
							}
						}
					]
				});
				// 결과 Table
				$('#tb__itemDtlRslt').DataTable({
					scrollY: '20vh',
					scrollCollapse: false,
					paging: true ,
					searching : false,
					info : true,
					columns: [
						{data: 'cdSeq', className: 'dt-center'},
						{data: 'cdNm', className: 'dt-center'},
						{
							orderable: false,
							searchable: false,
							className : 'dt-center',
							render: function ( data, type, row ) {
								let html = '<button class="w3-button w3-red w3-mobile" name="btn__deleteItemDtl" >취소</button>';
								return html;
							}
						}
					]
				});
			},
			searchItem : function() {
				/*
				let param = {};
				let url = './data__itemSrch.json';
				$.ajax({
					type : "post",
					url : url,
					data : param,
					dataType : 'json',
					success : function(res){
						console.log(res);
						$('#tb__itemSrch').DataTable().clear().rows.add(res.data).draw();
					}
				});
				*/
				const res = {
					"data": [
						{
							"cdSeq": 1,
							"cdId": "A01",
							"cdNm": "코드1"
						},
						{
							"cdSeq": 2,
							"cdId": "A02",
							"cdNm": "코드2"
						},
						{
							"cdSeq": 3,
							"cdId": "A03",
							"cdNm": "코드3"
						},
						{
							"cdSeq": 4,
							"cdId": "A04",
							"cdNm": "코드4"
						},
						{
							"cdSeq": 5,
							"cdId": "A05",
							"cdNm": "코드5"
						},
						{
							"cdSeq": 6,
							"cdId": "A06",
							"cdNm": "코드6"
						},
						{
							"cdSeq": 7,
							"cdId": "A07",
							"cdNm": "코드7"
						},
						{
							"cdSeq": 8,
							"cdId": "A08",
							"cdNm": "코드8"
						},
						{
							"cdSeq": 9,
							"cdId": "A09",
							"cdNm": "코드9"
						},
						{
							"cdSeq": 10,
							"cdId": "A10",
							"cdNm": "10코드"
						},
						{
							"cdSeq": 11,
							"cdId": "A11",
							"cdNm": "코드11"
						},
						{
							"cdSeq": 12,
							"cdId": "A12",
							"cdNm": "코드12"
						}
					]
				}
				$('#tb__itemDtlSrch').DataTable().clear().rows.add(res.data).draw();
				
			},
			insertItem : function(row) {
				let data = row.data();                
				let needAdd = true;
				let ds = data__itemDtlRslt;
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
				}
			},
			deleteItem : function(row) {
				let data = row.data();
				let ds = data__itemDtlRslt;
				ds.forEach(function(item, index, array) {
					if (data.cdId === item.cdId) {
						array.splice(index, 1);
					}
				});
				row.remove().draw();
			},
			confirm: function() {
				confirm__item(data__itemDtlRslt);
			},
			close: function() {

			}
		}    	

		$(document).on('click', 'button[name="btn__insertItemDtl"]', function() {
			let row = $('#tb__itemDtlSrch').DataTable().row( $(this).parents('tr:first') );
			itemDtlPopup.insertItem(row);
			
		});
		$(document).on('click', 'button[name="btn__deleteItemDtl"]', function() {
			let row = $('#tb__itemDtlRslt').DataTable().row( $(this).parents('tr:first') );
			itemDtlPopup.deleteItem(row);
		});

		$(document).on('click', 'button[name="btn__confirmItemDtl"]', function() {
			itemDtlPopup.confirm();
		});

		$(document).on('click', 'button[name="btn__cancelItemDtl"]', function() {
			itemDtlPopup.confirm();
		});

		/**
		itemDtlPopup.init(function(ds) {
			console.log(ds);
		});

		itemDtlPopup.searchItem();
		**/
	</script>
</div>