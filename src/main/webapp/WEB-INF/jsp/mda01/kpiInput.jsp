<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, user-scalable=no">
	<title>모니터요원 입력시스템-계량/비계량 설정</title>
	<!-- @@@@@@@@@@@@@@@@@@@@@@ css begin @@@@@@@@@@@@@@@@@@@@@@ -->
	 <link rel="stylesheet" type="text/css" href="<c:url value='/rMateChart/rMateChartH5/Assets/Css/rMateChartH5.css' />"/>   
	<link rel="stylesheet" type="text/css" href="<c:url value='/axisj/axicon/axicon.min.css' />" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/arongi/AXJ.min.css' />" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/hw/ma.css' />" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/hw/common.css' />" />
	 <!-- @@@@@@@@@@@@@@@@@@@@@@ css end   @@@@@@@@@@@@@@@@@@@@@@ --> 
  
	<script type="text/javascript" src="<c:url value='/axisj/jquery/jquery.min.js' />"></script>
	<script type="text/javascript" src="<c:url value='/axisj/dist/AXJ.min.js' />"></script>
	<script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/ax5-polyfill.js' />"></script>
	<script type="text/javascript" src="<c:url value='/axisj/dist/cmmn/axjApp.js' />"></script>
	
	
	<!-- rMateChartH5 라이센스 시작 -->
	<script type="text/javascript" src="<c:url value='/rMateChart/LicenseKey/rMateChartH5License.js' />"></script>
	<!-- rMateChartH5 라이센스 끝-->  
	<!-- 실제적인 rMateChartH5 라이브러리 시작-->
	 <script type="text/javascript" src="<c:url value='/rMateChart/rMateChartH5/JS/rMateChartH5.js' />"></script>
	<!-- 실제적인 rMateChartH5 라이브러리 끝-->  
	<!-- rMateChartH5 테마 js -->
	<script type="text/javascript" src="<c:url value='/rMateChart/rMateChartH5/Assets/Theme/theme.js' />"></script>
	<!-- @@@@@@@@@@@@@@@@@@@@@@ css end   @@@@@@@@@@@@@@@@@@@@@@ -->
	
	<script type="text/javascript" src="<c:url value='/js/validation.js' />"></script>
	
	
<script type="text/javascript">
	var myProgress = new AXProgress();
	var myGrid = new AXGrid();
	var myModal = new AXModal();
	var defaultHtml = "";

	// 데이터 입력
	function grid_ajax(pageNo){   
		if(pageNo == null || pageNo == "") pageNo = 1;
		$.ajax({
	       type : 'post',
	       url : "/mntr/mda01/gridList.json",
	       data : "pageNumber=" + (pageNo) + "&pageSize=10",
	       success : function(res){ 
	    	   //console.log(res.list);
	    	   if(res.error){
                   alert(res.error.message);
               }else{
                   var gridData = {
                       list: res.list,
                       page:{
                           pageNo: res.page.currentPage,
                           pageSize: res.page.pageSize,
                           pageCount: res.page.totalPages,
                           listCount: res.page.totalElements
                       }
                   };
                   myGrid.setData(gridData);
               }
	         	
	       },
	   });      	    
	};
		
	// 그리드 설정시작
	var fnObj = {
		    pageStart: function(){
		    	CHUL_NO="${SESSION_CMP_CODE}";
		    	grid_ajax();
		    	defaultHtml = $("#manageDiv").html();

		    	myModal.setConfig({
                    windowID: "myModalCT",
                    width: 1020,
                    displayLoading: true,
                    onclose: function () {
                        //toast.push("모달 close");
                    }
                });
		    	myModal.setWidth("100%");
		    	myGrid.setConfig({
    	             targetID : "AXGridTarget",
    	             theme : "AXGrid",
    	             fixedColSeq : '',
    	             fitToWidth:false,
    	             colGroup : [
    	                 {
    	                     key:"KPI_SEQ", label:"checkbox", width:"30", align:"center", formatter:"checkbox", pk:true,
    	                     disabled:function(){
    	                         return false;
    	                         return (this.index % 2 != 0);
    	                     },
    	                     checked:function(){
    	                         return false;
    	                         return (this.index % 2 == 0);
    	                     }
    	                 },
    	                 {key:"KPI_DATE", label:"등록기간", width:"100", align:"center", pk:true}, 
    	                 {key:"KPI_GROUP", label:"생산/소비/공통", width:"100", align:"center"},
    	                 {key:"TYPE", label:"생산정보", width:"260", align:"center"},
    	                 {key:"TYPE_CONDITION", label:"조건", width:"50", align:"center"},
    	                 {key:"INDICATOR_TYPE", label:"지표", width:"70", align:"center"},
    	                 {key:"PRICE", label:"금액", width:"150", align:"center"},
    	                 {key:"INS_DT", label:"기준등록일", width:"90", align:"center"},
    	                 {key:"INS_ID", label:"등록자ID", width:"100", align:"center"}
    	             ],
    	             colHeadAlign:"center",
    	             body : {
    	                 onclick: function(){  
    	                	 //console.log("thisItem", this.item);
    	                	 $.ajax({
    	    		             type : 'post',
    	    		             url : "/mntr/mda01/updateKpiInput.do",
    	    		             data :{
    	    		            	 KPI_SEQ : this.item.KPI_SEQ
    	    		             },
    	    		             success : function(res){                   	 
    	    		            	 $("#manageDiv").html(res);
    	    		             },
    	    		         }); 
    	                	 
    	                 },
    	             },
    	             page: {
                         display: true,
                         paging: true,
                         pageNo:1,
                         pageSize:10,
                         onchange: function (pageNo) {
                            grid_ajax(pageNo);
                         }
                     }
    	         }); 
		    },//pageStart
			modalOpen: function(){
				myModal.open({    		 
					type: "GET",
					url:"/mntr/mda01/kpiLogView.do",				
					top:50,
					pars:"",
					closeByEscKey:true
				});	
				myModal.setWidth("100%");
			},
		    getCheckedList: function(){
			    
		         var checkedList = myGrid.getCheckedList(0);// colSeq
		         
		         if(checkedList.length == 0){
		             alert("선택된 목록이 없습니다. 삭제하시려는 목록을 체크하세요");    
		             return;
		         }
		        
		         if(!confirm("정말 삭제 하시겠습니까?")) return;        	
		        	 var obj2=checkedList;
		             var deleteValue = "";
		         $.each(obj2,function(num,value) {
		         	//alert('key:'+key+', REG_DATE:'+value.REG_DATE+',CHUL_NO2:'+value.CHUL_NO2+',MONTH_GUBN'+value.MONTH_GUBN);
		         	if(num == (obj2.length-1)){
		         		deleteValue += value.KPI_SEQ;
		         	}else{
		         		deleteValue += value.KPI_SEQ+',';
		         	}
		         	
		         });          
		         $.ajax({
		             type : 'post',
		             url : "/mntr/mda01/deleteKpiInput.json",
		             data :{
		            	 deleteValue : deleteValue
		             },
		             dataType : '',   	           
		             success : function(res){                   	 
						//console.log(res);
						if(res.error){
							alert(res.error.message);
						}else{
							alert(res.result.message);
							grid_ajax(1);
							defaultFrm();
						}          	 
		             },
		         }); 
		         
		     },
		};

	$(document).ready(fnObj.pageStart);

	
	// 생산정보선택 추가
	function addProduct(){
		var type = $("#productSelect option:selected").val();
		var txt = $("#productSelect option:selected").text();
		
		// 기존에 추가된 항목이면 무동작
		if($("#productArr").text().indexOf(txt) >= 0) return false;
		
		if($("#productType").val() == ""){
			$("#productType").val(type);
		}else{
			$("#productType").val($("#productType").val()+","+type);
		}
		
		// and or 조건 selectbox 조정
		if($("#productType").val().split(",").length >= 2) $("#typeCondition").show();
		
		var arrHtml = '<span>'+txt+'<a href="javascript:void(0);" onclick="delProduct(\''+type+'\', $(this));">[x]</a>&nbsp;&nbsp;</span>';
		$("#productArr").append(arrHtml);
	}
	// 생산정보선택 제거
	function delProduct(type, $this){
		$this.parent("span").remove();
		var productVal = $("#productType").val();
		if(productVal.indexOf(type) == 0){
			if($("#productType").val().length == 1) productVal = "";
			if($("#productType").val().length != 1) productVal = $("#productType").val().split(type+",").join("");
		}else{
			productVal = $("#productType").val().split(","+type).join("");
		}
		$("#productType").val(productVal);
		
		// and or 조건 selectbox 조정
		if($("#productType").val().split(",").length < 2) $("#typeCondition").hide();
		
	}
	
	// 생산정보 등록
	function inputKpiData($frm){
		var stDt = $frm.find("select[name=startDt] option:selected").val();
		var edDt = $frm.find("select[name=endDt] option:selected").val();
		
		if(stDt > edDt){
			alert("등록 종료일은 시작일 이전으로 등록 하실수 없습니다.");
			$frm.find("select[name=endDt]").focus();
			return false;
		}
		if($frm.find("input[name=productType]").val() == ""){
			alert("생산정보를 선택해주시기 바랍니다.");
			$frm.find("select[name=productSelect]").focus();
			return false;
		}
		
		if(!confirm("등록 하시겠습니까?")) return false;
		 
		$.ajax({
	          type : 'post',
	          url : "/mntr/mda01/kpiInputProc.json",
	          //data :'&CHUL_NO='+CHUL_NO,
	          data : $frm.serialize(),
	          success : function(res){               
	        	  //console.log(res);
		    	   if(res.error){
	                   alert(res.error.message);
	               }else{
	            	   alert(res.result.message);
	            	   if(res.result.stat == "2"){
	            		   $("#manageDiv").html(defaultHtml); 
		            	   grid_ajax(1);   
	            	   }
	            	   
	               }
	          },
		});
		
		return false;
	}
	
	// 설정 데이터 삭제
	function deleteKpiData(){
		fnObj.getCheckedList();
	}
	
	// 수정창에서 기존 등록창 호출
	function defaultFrm(){
		$("#manageDiv").html(defaultHtml); 
	}
	
	// 변경이력 모달 호출
	function KpiLogView(){
		fnObj.modalOpen();
		$(window).scrollTop(0);
	}
	
	
</script>
</head>
<body>

<%@ include file="/WEB-INF/inc/IncHeader.jsp" %>

<article>
	<div class="wrap">
		<%@ include file="/WEB-INF/jsp/inc/IncMenu.jsp" %>
	
	
		<div class="hw_content"><!--컨텐츠 내용들어가는곳 시작-->
			<h3 class="hw_h3_ma"><!-- <div class="half1_white"></div> --><span class="half_title">계량/비계량 설정</span></h3>
			<div class="hw_clear"></div>
		
			<div class="hw_infouse_01">
				<p><span class="purple"> ◎ 정산정보 관리 :</span> 정산정보에 대한 지표 별 관리</p>
			</div>

			<div id="manageDiv" style="width:100%; margin: 10px 0px;">
				<div class="selectWrap mt10">
					<form id="kpiFrm" name="kpiFrm" method="post" onsubmit="return inputKpiData($(this));">
						<div style="margin-bottom: 10px;">
							<ul class="titList3">
								<li class="th">생산정보 선택 : </li>
								<li class="td">
									<label class="blind" for="productSelect">생산정보 선택</label>
									<select name="productSelect" id="productSelect">
										<option value="1">출하예정물량</option>
										<option value="2">출하물량</option>
										<option value="3">작황정보</option>
										<option value="4">재배동향</option>
										<option value="5">소비동향</option>
										<option value="6">소매가격</option>
									</select>
									<button type="button" onclick="addProduct();" class="addBtn">추가</button>
									<input type="hidden" name="productType" id="productType" value="">
								</li>
								<li class="th">선택목록 : </li>
								<li class="td">
									<span id="productArr">&nbsp;</span>
									<label class="blind" for="typeCondition">조건선택</label>
									<select name="typeCondition" id="typeCondition" style="display: none;">
										<option value="A">AND</option>
										<option value="O">OR</option>
									</select>
								</li>
							</ul><!-- titList end  -->
						</div>
						<div style="margin-bottom: 10px;">
							<ul class="titList3">
								<li class="th">등록기간 :</li>
								<li class="td">
									<label class="blind" for="startDt">등록기간 선택</label>
									<select id="startDt" name="startDt" class="titSelect">
										<c:forEach begin="1" end="31" varStatus="num">
											<option value="${num.index }">${num.index }</option>
										</c:forEach>
									</select>~
									<label class="blind" for="endDt">등록기간 선택</label>
									<select id="endDt" name="endDt" class="titSelect">
										<c:forEach begin="2" end="31" varStatus="num">
											<option value="${num.index }">${num.index }</option>
										</c:forEach>
									</select>
								</li>
								<li class="th">그룹선택 :</li>
								<li class="td">
									<label class="blind" for="kpiGroup">그룹선택</label>
									<select id="kpiGroup" name="kpiGroup" class="titSelect2">
										<option value="P">생산</option>
										<option value="C">소비</option>
										<option value="A">공통</option>
									</select>
								</li>
								<li class="th">지표선택 :</li>
								<li class="td">
									<label class="blind" for="indicatorType">지표선택</label>
									<select name="indicatorType" id="indicatorType" class="titSelect2">
										<option value="K">계량</option>
										<option value="N">비계량</option>
									</select>
								</li>
								<li class="th">금액 :</li>
								<li class="td">
									<label class="blind" for="price">금액입력</label>
									<input type="text" class="AXInput onlyNum" name="price" id="price" value="" required="required">
								</li>
							</ul><!--   -->
							<div class="btnWrap"><button type="submit" id="btnType" class="ma_add_2">등록하기</button></div>
						</div>
					</form>
				</div>
			</div>
			<div class="hw_clear"></div>
			
			<div class="hw_ma_grid">
				<div id="AXGridTarget" style="height: 400px;"></div>
			</div>
			<div style="width:100%; margin: 10px 0px;">
				<button type="button" onclick="deleteKpiData();" class="delBtn">삭제</button>
				<button type="button" onclick="KpiLogView();" class="addBtn" style="width: 100px;float: right;">변경이력</button>
			</div>
			
		</div>
		<!--// hw_content -->
	</div>
	<!--// wrap-->
</article>

	<div class="hw_clear"></div>
	<footer>
		<%@ include file="/WEB-INF/inc/IncFooter.jsp" %>
	</footer>
</body>
</html>

