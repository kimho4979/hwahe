<div id="flowerCtgr_popup">
    <div class="w3-container">
        <h5>검색결과</h5>
        <table id="tb__flowerCtgrSrch" class="w3-table-all w3-hoverable display compact nowrap">
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
        <table id="tb__flowerCtgrRslt" class="w3-table-all w3-hoverable display compact nowrap">
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
    <div class="w3-container w3-padding-16">
        <div class="w3-center">
            <button class="w3-button w3-white w3-mobile" name="btn__cancelFlowerCtgr">취소</button>
            <button class="w3-button w3-blue w3-mobile" name="btn__confirmFlowerCtgr">적용</button>
        </div>
    </div>
    <script>
        const data__flowerCtgrSrch = [];
        const data__flowerCtgrRslt = [];

        let confirm__flowerCtgr;

        const flowerCtgrPopup = {
            param: {},
            rs : [],
            autoApply : false,
            init : function (callbackFnc) {
                if (typeof callbackFnc === 'function') {
                    this.confirm = function(ds) {
                        callbackFnc(ds);
                    }
                }

                // 조회 Table
                $('#tb__flowerCtgrSrch').DataTable({
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
                                let html = '<button class="w3-button w3-green w3-mobile" name="btn__insertFlowerCtgr" >선택</button>';
                                return html;
                            }
                        }
                    ]
                });
                // 결과 Table
                $('#tb__flowerCtgrRslt').DataTable({
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
                                let html = '<button class="w3-button w3-red w3-mobile" name="btn__deleteFlowerCtgr" >취소</button>';
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
                console.log(res);
                $('#tb__flowerCtgrSrch').DataTable().clear().rows.add(res.data).draw();
                
            },
            insertItem : function(row) {
                let data = row.data();                
                let needAdd = true;
                let ds = this.rs;
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
                    //$('#tb__itemRslt').DataTable().clear().rows.add(data__itemRslt).draw();
                    if (this.autoApply) {
                        this.confirm(ds);
                    }
                }
            },
            deleteItem : function(row) {
                let data = row.data();
                let ds = this.rs;
                ds.forEach(function(item, index, array) {
                    if (data.cdId === item.cdId) {
                        array.splice(index, 1);
                    }
                });
                row.remove().draw();

                if (this.autoApply) {
                    this.confirm(ds);
                }
            },
            confirm: function() {

            },
            close: function() {

            }
        }    	

        $(document).on('click', 'button[name="btn__insertFlowerCtgr"]', function() {
            let row = $('#tb__flowerCtgrSrch').DataTable().row( $(this).parents('tr:first') );
            flowerCtgrPopup.insertItem(row);
            
        });
        $(document).on('click', 'button[name="btn__deleteFlowerCtgr"]', function() {
            let row = $('#tb__flowerCtgrRslt').DataTable().row( $(this).parents('tr:first') );
            flowerCtgrPopup.deleteItem(row);
        });

        $(document).on('click', 'button[name="btn__confirmFlowerCtgr"]', function() {
            flowerCtgrPopup.confirm();
        });

        $(document).on('click', 'button[name="btn__cancelFlowerCtgr"]', function() {
            flowerCtgrPopup.confirm();
        });

        /**
         * 
        flowerCtgrPopup.init(alert);
        flowerCtgrPopup.searchItem();
        */

    </script>
</div>