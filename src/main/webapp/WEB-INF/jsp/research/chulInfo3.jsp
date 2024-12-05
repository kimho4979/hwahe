
<div style="width:100%;">
	<div> 
		년도
		<select name="stdYear" id="stdYear" onchange="fn_stdYearChange();">
		<c:forEach begin="2019" end="2030" var="year">
		<option value="${year}" <c:if test="${paramMap.stdYear eq year}">selected="selected"</c:if>>${year}</option>
		</c:forEach>
		</select>
		
		시도
		<select name="sidoCode" id="sidoCode" onchange="fn_sidoChange();">
		<option value="" id="sido0">전체</option>
		<c:forEach items="${sidoList}" var="sido">
		<option value="${sido.areaCode}" id="sido${sido.areaCode}" data-code="${sido.sidoCode}">${sido.searchKorName}</option>
		</c:forEach>
		</select>
		
		시군구
		<select name="sigunCode" id="sigunCode" onchange="fn_sigunChange();">
		<option value="" id="sigun0">전체</option>
		</select>
		
		재배면적
		<select name="prdArea" id="prdArea" onchange="fn_prdAreaChange();">
		<option value="">전체</option>
		<option value="1" <c:if test="${paramMap.prdArea eq '1'}">selected="selected"</c:if>>0.3ha 미만</option>
		<option value="2" <c:if test="${paramMap.prdArea eq '2'}">selected="selected"</c:if>>0.3ha ~ 0.5ha 미만</option>
		<option value="3" <c:if test="${paramMap.prdArea eq '3'}">selected="selected"</c:if>>0.3ha ~ 1ha 미만</option>
		<option value="4" <c:if test="${paramMap.prdArea eq '4'}">selected="selected"</c:if>>1ha 이상</option>
		</select>
		
		<input type="button" class="AXButton" onclick="fn_printDiv('printArea');" value="이미지 내려받기"/>
		
	</div>
	<div style="width:100%;" id="printArea">
		<div style="width:100%;">
			<div id="content" style="width:50%;height:500px;float:left;" >
				<!-- 차트가 삽입될 DIV -->
				<div id="mapHolder" style="width:100%;height:100%;"></div>
			</div>
			<div style="width:50%;float:left;">
				<div id="mainDiv" style="width:100%;height:150px;">
				   <p id="mainArea">인천</p>
				   <p id="mainChulCnt">재배농가수 542호</p>
				   <p id="mainPrdArea">재배면적 220ha</p>
				   <p id="mainYearChulQty">연간출하량 1300만단</p>
				   <p id="mainYearChulAmt">연간출하액 448억원</p>
				</div>
				<div id="subDiv" style="width:100%;height:300px;">
					
				</div>
			</div>
		</div>
		<div style="width:100%;">
		<h2>재배시설 항목별 면적비중</h2>
		</div>
		<div style="width:100%;">
			<div id="chartContent" style="width:300px;height:300px;float:left;" >
				<div id="chartHolder1" style="width:100%;height:100%;"></div>
			</div>
			<div style="width:300px;height:300px;float:left;" >
				<div id="chartHolder2" style="width:100%;height:100%;"></div>
			</div>
			<div style="width:500px;height:300px;float:left;" >
				<div id="chartHolder3" style="width:100%;height:100%;"></div>
			</div>
			<div style="width:300px;height:300px;float:left;" >
				<div id="chartHolder4" style="width:100%;height:100%;"></div>
			</div>
		</div>
		<div style="width:100%;">
			<div style="width:465px;height:300px;float:left;" >
				<div id="chartHolder5" style="width:100%;height:100%;"></div>
			</div>
			<div style="width:465px;height:300px;float:left;" >
				<div id="chartHolder6" style="width:100%;height:100%;"></div>
			</div>
			<div style="width:465px;height:300px;float:left;" >
				<div id="chartHolder7" style="width:100%;height:100%;"></div>
			</div>
		</div>
		<div style="width:100%;">
		<h2>재배인력</h2>
		</div>
		<div style="width:100%;">
			<div style="width:460px;height:300px;float:left;" id="person">
				
			</div>
			<div style="width:460px;height:300px;float:left;" >
				<div id="chartHolder8" style="width:100%;height:100%;"></div>
			</div>
			<div style="width:460px;height:300px;float:left;" >
				<div id="chartHolder9" style="width:100%;height:100%;"></div>
			</div>
		</div>
		<div style="width:100%;">
			<div style="width:450px;height:300px;float:left;" >
				<div id="chartHolder10" style="width:100%;height:100%;"></div>
			</div>
			<div style="width:450px;height:300px;float:left;" >
				<div id="chartHolder11" style="width:100%;height:100%;"></div>
			</div>
			<div style="width:450px;height:300px;float:left;" >
				<div id="chartHolder12" style="width:100%;height:100%;"></div>
			</div>
		</div>
	</div>
	
	
	  
	
	<div class="loadingWrap">
	    <div class="loadArea">
	        <div class="loading">
	        	<div class="lds-dual-ring"></div>
	        	<div class="text" id="procText" style="color: white;">
		        	처리중입니다.
		        </div>
	        </div>
	    </div>
	</div>
</div>