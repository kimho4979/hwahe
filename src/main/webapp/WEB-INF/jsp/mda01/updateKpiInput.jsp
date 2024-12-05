<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<script type="text/javascript">
$(document).ready(function() {
	updateDefaltData();
}); 


// 초기갑 셋팅
function updateDefaltData(){
	var txtHtml = "";
	var arrValue = "";
	<c:if test="${detail.TYPE_SHIPMNT_EX eq 'Y'}">
		txtHtml += '<span>출하예정물량<a href="javascript:void(0);" onclick="delProduct(\'1\', $(this));">[x]</a>&nbsp;&nbsp;</span>';
		if(arrValue == ""){
			arrValue = "1";
		}else{
			arrValue += ",1";
		}
	</c:if>
	<c:if test="${detail.TYPE_SHIPMNT eq 'Y'}">
		txtHtml += '<span>출하물량<a href="javascript:void(0);" onclick="delProduct(\'2\', $(this));">[x]</a>&nbsp;&nbsp;</span>';
		if(arrValue == ""){
			arrValue = "2";
		}else{
			arrValue += ",2";
		}
	</c:if>
	<c:if test="${detail.TYPE_CROP eq 'Y'}">
		txtHtml += '<span>작황동향<a href="javascript:void(0);" onclick="delProduct(\'3\', $(this));">[x]</a>&nbsp;&nbsp;</span>';
		if(arrValue == ""){
			arrValue = "3";
		}else{
			arrValue += ",3";
		}
	</c:if>
	<c:if test="${detail.TYPE_CULT eq 'Y'}">
		txtHtml += '<span>재배동향<a href="javascript:void(0);" onclick="delProduct(\'4\', $(this));">[x]</a>&nbsp;&nbsp;</span>';
		if(arrValue == ""){
			arrValue = "4";
		}else{
			arrValue += ",4";
		}
	</c:if>
	<c:if test="${detail.TYPE_CONS_TREND eq 'Y'}">
		txtHtml += '<span>소비동향<a href="javascript:void(0);" onclick="delProduct(\'5\', $(this));">[x]</a>&nbsp;&nbsp;</span>';
		if(arrValue == ""){
			arrValue = "5";
		}else{
			arrValue += ",5";
		}
	</c:if>
	<c:if test="${detail.TYPE_CONS_PRICE eq 'Y'}">
		txtHtml += '<span>소매가격<a href="javascript:void(0);" onclick="delProduct(\'6\', $(this));">[x]</a>&nbsp;&nbsp;</span>';
		if(arrValue == ""){
			arrValue = "6";
		}else{
			arrValue += ",6";
		}
	</c:if>
	$("#productType").val(arrValue);
	$("#productArr").append(txtHtml);
	
	// and or 조건 selectbox 조정
	if($("#productType").val().split(",").length >= 2) $("#typeCondition").show();
	
}


//생산정보 등록
function updateKpiData($frm){
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
	
	if(!confirm("수정 하시겠습니까?")) return false;
	 
	$.ajax({
          type : 'post',
          url : "/mntr/mda01/kpiUpdateProc.json",
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

</script>

<div class="selectWrap mt10">
	<form id="kpiFrm" name="kpiFrm" method="post" onsubmit="return updateKpiData($(this));">
		<input type="hidden" name="kpiSeq" value="${detail.KPI_SEQ }" />
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
					<button type="button" onclick="addProduct();">[추가]</button>
					<input type="hidden" name="productType" id="productType" value="">
				</li>
				<li class="th">선택목록 : </li>
				<li class="td">
					<span id="productArr">&nbsp;</span>
					<label class="blind" for="typeCondition">조건선택</label>
					<select name="typeCondition" id="typeCondition" style="display: none;">
						<option value="A" <c:if test="${detail.TYPE_CONDITION eq 'A'}">selected="selected"</c:if>>AND</option>
						<option value="O" <c:if test="${detail.TYPE_CONDITION eq 'O'}">selected="selected"</c:if>>OR</option>
					</select>
				</li>
			</ul>
		</div>
		<div style="margin-bottom: 10px;">
			<ul class="titList3">
				<li class="th">등록기간 : </li>
				<li class="td">
					<label class="blind" for="startDt">등록기간</label>
					<select id="startDt" name="startDt" class="titSelect">
						<c:forEach begin="1" end="31" varStatus="num">
							<option value="${num.index }" <c:if test="${detail.START_DT eq num.index}">selected="selected"</c:if>>${num.index }</option>
						</c:forEach>
					</select>~
					<label class="blind" for="endDt">등록기간</label>
					<select id="endDt" name="endDt" class="titSelect">
						<c:forEach begin="2" end="31" varStatus="num">
							<option value="${num.index }" <c:if test="${detail.END_DT eq num.index}">selected="selected"</c:if>>${num.index }</option>
						</c:forEach>
					</select>
				</li>
				<li class="th">그룹선택 : </li>
				<li class="td">
					<label class="blind" for="kpiGroup">그룹선택</label>
					<select id="kpiGroup" name="kpiGroup" class="titSelect2">
						<option value="P" <c:if test="${detail.KPI_GROUP eq 'P'}">selected="selected"</c:if>>생산</option>
						<option value="C" <c:if test="${detail.KPI_GROUP eq 'C'}">selected="selected"</c:if>>소비</option>
						<option value="A" <c:if test="${detail.KPI_GROUP eq 'A'}">selected="selected"</c:if>>공통</option>
					</select>
				</li>
				<li class="th">지표선택 : </li>
				<li class="td">
					<label class="blind" for="indicatorType">지표선택</label>
					<select name="indicatorType" id="indicatorType" class="titSelect2">
						<option value="K" <c:if test="${detail.INDICATOR_TYPE eq 'K'}">selected="selected"</c:if>>계량</option>
						<option value="N" <c:if test="${detail.INDICATOR_TYPE eq 'N'}">selected="selected"</c:if>>비계량</option>
					</select>
				</li>
				<li class="th">금액 : </li>
				<li class="td">
					<label class="blind" for="price">금액</label>
					<input type="text" class="AXInput onlyNum" name="price" id="price" value="${detail.PRICE }" required="required">
				</li>
			</ul>
			<div class="btnWrap">
				<button type="submit" id="btnType" class="ma_add_2">수정하기</button>
				<button type="button" onclick="defaultFrm();" class="ma_re_2">초기화</button>
			</div>
		</div>
	</form>
</div>
