var home_dirty = true, // 홈 화면인지
	ani_index = 0, // 실행되는 이펙트 count
	all_ani_dirty = false, // 해당 페이지내에 실행중인 effect의 여부
	textAreaMaxHeight = 600,//텍스트에어리어의 최대 높이
	tutorial_overview = true,//튜토리얼 클릭시 오버뷰 페이지 여부
	tutorial_index = 0,//튜토리얼 버튼의 count
	tutorial_array = [],
	mouseOverText = {
		"pastel":"Pastel",
		"lovely":"Lovely",
		"modern":"Modern",
		"cyber":"Cyber",
		"simple":"Simple"
	};

// 이벤트 설정
var demoEvent = function(role, target, type, handler){
	var event;

	if(role == "add"){
		event = "addEventListener";
		if(!window[event]){
			event = "attachEvent";
			type = "on" + type;
		}
	}else{
		event = "removeEventListener";
		if(!window[event]){
			event = "detachEvent";
			type = "on" + type;
		}
	}
	if(window[event])
		target[event](type, handler);
};

// chart type, prop div활성화 하기
function activeMenu(menu){
	if(menu === active_menu)
		return;
	
	// 활성화 된 메뉴가 있으면 비화성화 시킨다.
	if(active_menu)
		changeCss(active_menu, ".non_active_menu");
	
	// 메뉴 활성화
	changeCss(menu, ".active_menu");
	active_menu = menu;
	
	// 홈 화면일 경우
	if(home_dirty){
		// 클릭된 li상위 부모 div외에 다른 div의 자식들이 붙은 div의 height를 줄인다. ( 다른 메뉴의 li를 클릭하기 위해 스크롤 사용이 불편하여 추가 )
		if(menu.parentNode === _$("chart_type"))
			displayNoneElem = _$("prop_content");
		else
			displayNoneElem = _$("type_content");

		playEffect(displayNoneElem, {"height":displayNoneElem.scrollHeight}, {"height":0}, titleSlideEnd, 800);
		home_dirty = false;
	}
}

// chart type, prop 자식들 활성화 하기
function activeMainLi(item,f){
	var li = active_main_li,
		activeContentName = _$("active_content_name");
	if(item === li)
		return;
	
	// 활성화 되어있는 main li가 있으면 비 활성화
	if(li)
		changeCss(li, ".non_active_main_li");
	
	// item 활성화
	changeCss(item, ".active_main_li");
	active_main_li = item;


	// main menu에서 클릭한 item의 name을 activeContentName에 넣어준다
	activeContentName.innerHTML = item.name;

	// sub menu에 click된 li에 대한 자식들 생성
	createSubMenuItem(item.childs,f);
	
	// sub menu가 닫혀있다면
	if(!open_sub_menu){
		// rMate Chart for HTML5 v3.0 보이기
		set(_$("title_eng"), "display", "block");
		// main menu 오른쪽 선 설정
		changeCss(_$("main_menu"), ".active_main_menu_border");
		// menu div 넓히기 효과
		if(item.over){
			playEffect(_$("menu"), {"width":171}, {"width":321}, endSlide2, 800);
		}else{
			playEffect(_$("menu"), {"width":171}, {"width":321}, endSlide, 800);
		}		
	}
}

// sub menu의 click된 li를 활성화 하기
function activeSubLi(item){
	var li = active_sub_li,sampleStr="";
	if(item === li)
		return;
	// 활성화 되어있는 sub li가 있다면 비 활성화
	if(li)
		changeCss(li, ".non_active_sub_li");
	// item 활성화
	changeCss(item, ".active_sub_li");
	active_sub_li = item;

	sampleStr = item.innerHTML.replace('<br>',' ');
	
	if(/[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/.test(sampleStr)){
		changeCss(_$("sample_name"),".sample_name_han");
	}else{
		changeCss(_$("sample_name"),".sample_name_eng");
	}

	// main menu에서 클릭된 차트 종류 content영역에 출력
	_$("type_name").innerHTML = _$("active_content_name").innerHTML.replace('<br>',' ');
	// sub menu에서 클릭된 샘플 종류 content영역에 출력
	_$("sample_name").innerHTML = sampleStr;
}

// chart type, prop의 메뉴 아이템 생성
function createMenuItem(id, items,f){
	var ul,
		type,
		i, n, e,
		p = _$(id),
		html = "<ul>";

	for(i = 0, n = items.length ; i < n ; i += 1){
		html += "<li>" + items[i].n + "</li>";
	}

	html += "</ul>";
	p.innerHTML = html.replace('<br>',' ');

	ul = p.childNodes[0];
	type = id.indexOf("type") > -1 ? "type_title" : "prop_title";

	// click event 추가
	for(i = 0, n = ul.childNodes.length ; i < n ; i += 1){
		e = ul.childNodes[i];
		e.name = items[i].n; // li에 name 저장
		if(type == "type_title")
			e.name += " Chart";
		e.childs = items[i].c; // li에 childs 저장
		e.titleTarget = type; // li에 titleTarget 저장
		e.f = f;
		demoEvent("add", e, "click", menuItemClick);
	}
	
}

// chart type, prop에 대한 자식들 생성
function createSubMenuItem(items,f){
	var i, n, ul,
		html = "<ul>",
		p = _$("active_content_childs");

	if(p.childNodes && p.childNodes.length > 0){
		ul = p.childNodes[0];
		for(i = ul.childNodes.length - 1; i > -1 ; i -= 1){
			demoEvent("remove", ul.childNodes[i], "click", subMenuItemClick);
		}
	}
	
	for(i = 0, n = items.length ; i < n ; i += 1){
		html += "<li>" + items[i].n + "</li>";
	}

	html += "</ul>";
	_$("active_content_childs").innerHTML = html;
	
	ul = p.childNodes[0];
	// click event 추가
	for(i = 0, n = ul.childNodes.length ; i < n ; i += 1){
		e = ul.childNodes[i];
		e.url = items[i].u; // li에 url저장
		e.f = f;
		demoEvent("add", e, "click", subMenuItemClick);
	}
}

// sub menu li click handler
function subMenuItemClick(e){
	var i,j,nt,type,flag = false,
		theme = _$("theme_div"),
		tuto = _$("tutorial_div");
	if(all_ani_dirty) // 이펙트 중인 객체가 있으면 return
		return;

	if(get(tuto,"width") > 0){
		endTutorial();
	}

	var target = e.target || e.srcElement,
		overview = _$("overview");

	if(overview.style.display != "none"){
		set(overview, "display", "none");
		set(_$("chart_sample"), "display", "block");
	}
	
	for(i = 0 ; i < none_theme.length ; i++){
		type = none_theme[i];
		for(j = 0 ; j < type.c.length; j++){
			if(type.c[j].u == target.url){
				flag = true;
				nt = type.c[j].t;
				break;
			}
		}
	}
	set(theme,"display","block");
	if(target.f || flag){
		if(nt){
			for(i = 0 ; i < nt.length ; i++){
				if(nt[i] == -1){
					set(theme,"display","none");
					break;
				}else{
					set(theme.children[nt[i]],"display","none");
				}
			}
		}else{
			set(theme,"display","none");
		}
		
	}else{		
		for(i = 0 ; i < theme.children.length ; i++){
			set(theme.children[i],"display","block");
		}
	}
	activeSubLi(target); // target 활성화
	changeContent(target.url); // content iframe을 target의 url로 변경한다.
}

//테마 버튼 마우스 오버 이벤트
	function addImageEvent(){
		var pastel = _$("pastel"),
			lovely = _$("lovely"),
			modern = _$("modern"),
			cyber = _$("cyber"),
			simple = _$("simple");
		
		demoEvent("add", pastel, "mouseover", mouseHandler);
		//demoEvent("add", lovely, "mouseover", mouseHandler);
		//demoEvent("add", modern, "mouseover", mouseHandler);
		//demoEvent("add", cyber, "mouseover", mouseHandler);
		demoEvent("add", simple, "mouseover", mouseHandler);
	}

//테마 버튼 마우스 오버시 콜백 함수
function mouseHandler(e){
	var type = e.type,
		relatedTarget = e.relatedTarget,
		target = e.target || e.srcElement;

	switch(type){
		case "mouseover" : 
			var contentDiv = document.createElement("div");
			
			contentDiv.style.position = "absolute";
			contentDiv.style.height = "20px";
			contentDiv.style.cursor = "default";
			contentDiv.style.border = "1px solid #ebebeb";
			contentDiv.style.fontFamily = "arial";
			contentDiv.style.fontSize = "11px";
			contentDiv.style.color = "#666666";
			contentDiv.innerHTML = mouseOverText[target.id];
			contentDiv.style.backgroundColor = "#ffffff";
			contentDiv.style.padding = "2px 4px 2px 4px";
			document.body.appendChild(contentDiv);

			contentDiv.style.left = getElemX(target) + "px";
			contentDiv.style.top = getElemY(target) + target.offsetHeight * 0.5 + Number(contentDiv.style.height.replace(/px/,"")) + "px"; // 4는 padding 4는 여백

			target.popup = contentDiv;

			demoEvent("add", target, "mouseout", mouseHandler);
		break;

		case "mouseout" :
			document.body.removeChild(target.popup);
			target.popup = null;
			demoEvent("remove", target, "mouseout", mouseHandler);
		break;
		
		default:
	}
}

// x위치를 가져온다
function getElemX(elem){
	var pt = elem.offsetLeft;
	while(elem.parentNode){
		pt += elem.parentNode.offsetLeft || 0;
		elem = elem.parentNode;
	}
	return pt;
}

// y위치를 가져온다
function getElemY(elem){
	var pt = elem.offsetTop;
	while(elem.parentNode){
		pt += elem.parentNode.offsetTop || 0;
		elem = elem.parentNode;
	}
	return pt;
}

// li click handler
function menuItemClick(e){
	if(all_ani_dirty) // 이펙트 중인 객체가 있으면 return
		return;

	var target = e.target || e.srcElement;
	activeMenu(_$(target.titleTarget));
	activeMainLi(target,target.f);
}

// chart type 생성
function createChartType(){
	createMenuItem("default_type", default_types,false);
	createMenuItem("premium_type", premium_types,false);
}

// chart prop 생성
function createChartProp(){
	createMenuItem("prop_content", props,true);
}

// overview 이미지 생성
function createImage(){
	var i, n,
		count = 0,
		className,
		html = "";

	for(i = 0, n = images.length ; i < n ; i += 1){
		count++;

		className = "overview_image";
		if(count % 4 == 0)
			className += " overview_image_last";
		
		html += '<div class="' + className + '"id="img_'+images[i].u+'" style="background-image:url(./Samples/Web/Images/' + images[i].u + '.png)"><span id="image_name">' + images[i].n + '</span></div>';
	}
	_$("overview").innerHTML = html;
}

// content 영역 변경
function changeContent(url){
	var div = _$("content_chart"),
		contentIFrame = _$("content_iframe"),
		// iframe만들기
		frame = document.createElement("iframe");
	
	// content_iframe이 있을 경우 삭제
	if(contentIFrame){
		contentIFrame.parentNode.removeChild(contentIFrame);
		//removeIFrame(contentIFrame);
		contentIFrame = null;
	}

	// load이벤트 추가
	demoEvent("add", frame, "load", frameloadHandler);	

	frame.id = "content_iframe";
	frame.frameBorder = 0;
	frame.marginWidth = 0;
	frame.marginHeight = 0;
	frame.src = baseurl + url + ".html";

	// content_chart div에 appendChild
	div.appendChild(frame);
}

// 이전 iframe이 있으면 내용물 삭제
function removeIFrame(frame){
	var heads, childs,
		removeChild = function(cs){
			var i, n, child;
			for(i = cs.length - 1, n = -1 ; i > n ; i -= 1){
				child = cs[i];
				if(child.childNodes.length > 0)
					removeChild(child.childNodes);
				if(!/rMateChartH5/.test(child.className))
					child.parentNode.removeChild(child);
			}
		};
	
	try{
		heads = frame.contentWindow.document.head.childNodes;
		childs = frame.contentWindow.document.body.childNodes;

		removeChild(heads);
		removeChild(childs);
		
		for(var o in frame.contentWindow){
			if(o == "location"){
				continue;
			}else{
				frame.contentWindow[o] = null;
			}
			
		}
	}catch(e){}
	
	// 부모 노드에서 iframe삭제
	frame.parentNode.removeChild(frame);
	frame = null;
}

function sourceValue(e) {
	var iframe = e.target || e.srcElement;
    var a = iframe.contentWindow.document.getElementsByTagName("script");
    var b;
    for (var i = 0, n = a.length; i < n; i++) {
        b = a[i];
        if (b.nodeType === 1 && b.nodeName.toLowerCase() === "script" && b.text !== "") {
            var c = document.createElement("div");
            c.style.zIndex = 2;
            c.style.position = "absolute";
            c.style.background = "#FFF";
            c.style.border = "1px solid #aaaaaa";
            c.style.left = (document.body.offsetWidth - 600) * 0.5 + "px";
            c.style.top = "80px";
            c.style.width = "600px";
            c.style.height = "420px";
            c.style.font = "11px 'Arial'";
            var d = document.createElement("div");
            var e = document.createElement("button");
            e.style.position = "absolute";
            e.style.font = "11px 'Arial'";
            e.style.top = "0px";
            e.style.width = "60px";
            e.style.right = "0px";
            e.onclick = function() {
                document.body.removeChild(c);
                c.removeChild(e);
                c.removeChild(d);
                c = null;
                d = null;
                e = null;
            };
            e.innerHTML = "Close";
            d.style.position = "relative";
            d.style.overflow = "scroll";
            d.style.top = "24px";
            d.style.left = "0px";
            d.style.width = "600px";
            d.style.height = "396px";
            d.innerHTML = "<pre id='preview' style='max-width: 100%; *width:800px; height: 600px; border: 1px solid black; overflow: scroll; -ms-overflow-x: scroll; overflow-x: scroll; font-family: monospace; tab-size: 3; -moz-tab-size: 3; -o-tab-size: 3; -webkit-tab-size: 3;'>" + b.text.replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/\t/g, "&nbsp;&nbsp;&nbsp;&nbsp;").replace(/\n/g, "<br>") + "</pre>";
            var sValue = "<pre id='preview' style='max-width: 100%; *width:800px; height: 600px; border: 1px solid black; overflow: scroll; -ms-overflow-x: scroll; overflow-x: scroll; font-family: monospace; tab-size: 3; -moz-tab-size: 3; -o-tab-size: 3; -webkit-tab-size: 3;'>" + b.text.replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/\t/g, "&nbsp;&nbsp;&nbsp;&nbsp;").replace(/\n/g, "<br>") + "</pre>";
//            document.body.appendChild(c);
//            c.appendChild(e);
			var sv;
			// SyntaxHighLighter에서 
			if ( d.innerText ) {
				sv = b.text;//d.innerText;
			} else if ( d.innerText == undefined && d.textContent) {
				sv = b.text;// d.textContent;
			}
			var strArray = sv.split('//----------------------- 차트 설정 끝 -----------------------');
			return strArray[0];
        }
    }
};

// iframe의 load 핸들러
function frameloadHandler(e){
	var iframe = e.target || e.srcElement,
		url,str,i,n,layoutStr,chartData, source,
		contentChart = _$("content_chart");

	//iframe의 scr를 읽은 뒤, 해당 url을 분류하여 숫자를 반환		
	n = checkUrl(iframe);
	
	//null일때 접근할 경우 새로고침 시 주소 뒤에 null이 들어감
	if(!iframe.contentWindow){
		return;
	}
	//기본적으로 layoutStr & chartData라고 되어있는 값을 가져온다.
	if(iframe.contentWindow.layoutStr){
		layoutStr = inputTab(iframe.contentWindow.layoutStr);
	}	
	if(iframe.contentWindow.chartData){
		chartData = objectToString(iframe.contentWindow.chartData);
	}

	source = sourceValue(e);
	
	//n값에 따라 비활성화
	//1 = Layout
	//2 = chartData
	//3 = 둘다
	if(n == 1){
		layoutStr = "현재 샘플에서는 Layout을 수정 할 수 없습니다.";
	}else if(n == 2){
		chartData = "현재 샘플에서는 Data를 수정 할 수 없습니다.";
	}else if(n == 3){
		layoutStr = "현재 샘플에서는 Layout을 수정 할 수 없습니다.";
		chartData = "현재 샘플에서는 Data를 수정 할 수 없습니다.";
	}else{
		
	}
	
	contentChart.style.height = "0px";
	var frameHeight = contentChart.offsetHeight;
	
	for(i = 0 ; i < iframe.contentWindow.document.body.childNodes.length ; i++){
		if(iframe.contentWindow.document.body.childNodes[i].offsetHeight){
			frameHeight += iframe.contentWindow.document.body.childNodes[i].offsetHeight;
		}		
	}
	contentChart.style.height = frameHeight + 15 + "px";
	textAreaSetValue(layoutStr, chartData, n, source);
	
	demoEvent("remove", contentChart, "load", frameloadHandler);
}

//iframe의 src에서 필요한 url만 추출 한뒤 식별 번호 반환
function checkUrl(iframe){
	//src에서 url 식별
	var url,str;
	url = iframe.src;
	str = url.split("/");
	for(i = 0 ; i < str.length ; i++){
		if(str[i].indexOf(".html")>0){
			url = str[i];
		}
	}
	url = url.split(".")[0];	
	
	var n = 0;
	//Layout Disable
	if(url == "Line_2D_Segment" || 
		url == "Dual_Chart2" ||
		url =="Dual_Chart" ||
		url =="Zoom_Real_Time" ||
		url =="CategoryAxis_CanDropLabels" ||
		url =="Line_Area_Label" ||		
		url =="Dynamic_Change_Both" ||
		url =="Dynamic_Change_Data" ||
		url =="Dynamic_Change_Layout" ||
		url =="Embeding_chartVars" ||
		url =="Embeding_URL_Array"){

		n = 1;
	}//Data Disable
	else if(url.indexOf("Gauge") > -1 || 
		url.indexOf("Error") > -1 || 
		url.indexOf("BoxPlot") > -1 || 
		url.indexOf("Histogram") > -1 ||
		url.indexOf("TreeMap") > -1 ||
		url.indexOf("WordCloud_Eng") > -1 ||
		url == "Embeding_String_URL" ||
		url == "Embeding_String_JSon_URL" || 
		url == "Embeding_CSV_URL" || 
		url == "GetData_From_Table_Horizontal" || 
		url == "GetData_From_Table_Vertical"){

		n = 2;
	}//Layout & Data Disable
	else if(url == "Embeding_URL_URL"||
		url == "Slide_Sample"||
		url == "Slide_Sample2"||
		url == "Scroll_Lazy_Data"||
		url == "Candle_Lazy_Data"||
		url == "Stock_Monitoring"||
		url == "RealTime_Time_TimeAxis"||
		url =="Var_Dynamic_Layout" ||
		url == "RealTime_Size_TimeAxis"||
		url == "RealTime_Premium_25Base"||
		url == "RealTime_Premium_10Int"||
		url == "RealTime_Premium_Line_Column"){

		n = 3;
	}
	return n;
}

// layout, data textarea에 데이터를 설정합니다.
function textAreaSetValue(layout, data, n, source){
	var tlayout = _$("tarea_layout"),
		tdata = _$("tarea_data"),
		tsource = _$("tarea_source"),
		tadiv = _$("tarea_div"),
		updiv = _$("update_div"),		
		layoutHeight,
		dataHeight,
		sourceHeight,
		tabHeight;
	
	// 브라우저마다 scrollHeight를 다르게 가져온다.
	// 그리하여 iframe이 변경되어 textarea내용이 변경될 경우 textarea크기를 0으로 만든 후 value값을 넣어 올바른 scrollHeight를 가져오도록 함
	//display="none"으로 되어있으면 scrollHeight를 가져오지 못해서 block으로 변경 후 마지막에 다시 active되지 않은 부분은 none로 변경
	tlayout.style.display = "block";
	tdata.style.display = "block";
	tsource.style.display = "block";
	tlayout.style.height = "0px";
	tdata.style.height = "0px";
	tsource.style.height = "0px";
	
	// 레이아웃 인덴트 넣기
	tlayout.value = layout;
	//데이터 인덴트 넣기
	tdata.value = data;

	if ( tsource.nodeName == "DIV" ) {
		//var oldSource = document.getElementById("tarea_source");
		//var oldParent  = document.getElementById("tarea_div");
		tsource.parentNode.removeChild(tsource);
		//oldParent.removeChild(tsource);
		var newSource = document.createElement("pre");
		tadiv.appendChild(newSource);
		//newSource.style.height = "0px";
		newSource.style.display = "block";
		newSource.id = "tarea_source";
		newSource.name = "tarea_source";
		newSource.className = "brush:js toolbar:false";
		newSource.innerText = source;
		newSource.textContent = source;
		//값이 들어간 textarea의 높이 구하기 source는 highlighter가 들어가기 전의 크기와 달라 여기서 정한다
		sourceHeight = newSource.scrollHeight;
		newSource.style.display = "none";
	} else {
		tsource.innerText = source;
		tsource.textContent = source;
		//값이 들어간 textarea의 높이 구하기
		sourceHeight = tsource.scrollHeight;		
	}

	//값이 들어간 textarea의 높이 구하기
	layoutHeight = tlayout.scrollHeight;
	dataHeight = tdata.scrollHeight;

	//스크롤 생성
	//tlayout.style.overflow = "auto";
	//tdata.style.overflow = "auto";

	//최대 높이 설정
	if(layoutHeight > textAreaMaxHeight){
		layoutHeight = textAreaMaxHeight;		
	}

	if(dataHeight > textAreaMaxHeight){
		dataHeight = textAreaMaxHeight;
	}

	if(sourceHeight > textAreaMaxHeight){
		sourceHeight = textAreaMaxHeight;
	}
	
	//활성화되지 않은 탭은 감추기
	if(active_tab_li.id =="li_layout"){
		tdata.style.display = "none";
		tsource.style.display = "none";
		tabHeight = layoutHeight;		
	}else if (active_tab_li.id =="li_source") {
		tlayout.style.display = "none";
		tdata.style.display = "none";
		
		// source 탭이 활성화 되어있을 경우에만 HighLighter 실행
		SyntaxHighlighter.config.bloggerMode = true;
    	SyntaxHighlighter.highlight();
		SyntaxHighlighter.all();

		tabHeight = "600px"; //sourceHeight;	
	}else{
		tlayout.style.display = "none";
		tsource.style.display = "none";
		tabHeight = dataHeight;
	}
	
	//비활성화 되었을 경우 update버튼도 함께 비활성화
	activeUpdateBtn(n);

	// 레이아웃 textarea height 변경
	tlayout.style.height = layoutHeight + "px";
	// 데이터 textarea height 변경
	tdata.style.height = dataHeight + "px";
	// 소스 textarea height 변경
	tsource.style.height = sourceHeight + "px";	

	//tarea_div 의 top 17*2
	tadiv.style.height = tabHeight + 34 +"px";
	//tabdiv의 높이 37
	updiv.style.height = tabHeight + 71 + "px";	
}

// 일렬로 된 layout을 가지고 개행처리와 들여쓰기를 적용합니다.
function inputTab(layout){
	var i, n,
		str,
		retStr = "",
		tabCount = 0, // 들여쓰기 카운트
		strArr = layout.split("<");
	
	for(i = 0, n = strArr.length ; i < n ; i += 1){
		str = strArr[i];
		
		if(str == "")
			continue;
		
		// split으로 인하여 "<"가 제거가 됨 이를 다시 더해줌
		str = "<" + str;

		// str이 "</"으로 시작한다면 tabCount를 빼준다.
		if(str.indexOf("</") > -1)
			tabCount--;
		
		// tabCount를 가지고 들여쓰기를 설정합니다.
		retStr += (addTabTag(tabCount) + str + "\n");
		
		// "/>" 나 "</"가 아닐 경우 tabCount를 더해준다.
		if(str.indexOf("/>") < 0 && str.indexOf("</") < 0)
			tabCount++;
	}
	return retStr;
}

//update버튼이 필요 없을 경우 display="none"
function activeUpdateBtn(n){
	var updateBtn = _$("btn_update"),
		tdata = _$("tarea_data"),
		tsource = _$("tarea_source"),
		tlayout = _$("tarea_layout");

	tlayout.readOnly = false;
	tdata.readOnly = false;
	updateBtn.style.display = "block";
	if(active_tab_li.id =="li_layout" && (n == 1 || n == 3) ){
		updateBtn.style.display = "none";
		tlayout.readOnly = true;
	}

	if(active_tab_li.id =="li_data" && (n == 2 || n == 3) ){
		updateBtn.style.display = "none";
		tdata.readOnly = true;
	}

	if(active_tab_li.id =="li_source" ){
		updateBtn.style.display = "none";
		tsource.readOnly = true;
	}	
}

// count를 가지고 여백을 추가한다. 지금은 &nbsp; * 4
function addTabTag(count){
	var tabStr = "";
	for(var i = 0, n = count ; i < n ; i += 1)
		tabStr += "    ";
	return tabStr;
}

// 배열 데이터를 스트링 형태로 변환한다
function objectToString(obj){
	var data,
		retStr = "";
	for(var i = 0, n = obj.length ; i < n ; i += 1){
		data = obj[i];
		retStr += "{";
		for(var o in data){
			retStr += "\"" + o + "\":";
			if(typeof data[o] == "string")
				retStr += "\"" + data[o] + "\"";
			else
				retStr += data[o];
			retStr += ", ";
		}
		retStr = retStr.substring(0, retStr.length - 2) + "}"; // 2는 ", " 를 지우기위해
		if(i != obj.length - 1)
			retStr += ",\n";
	}
	return retStr;
}

// data tab에서 변경된 스트링 데이터들을 배열형태로 변경해준다
function stringToObject(str){
	var o,
		item,
		strArr,
		data = [];
		
	str = (str + ",").replace(/{|"|\r|\n| /g,"");
	strArr = str.split("},");
	for(var i = 0, n = strArr.length ; i < n ; i += 1){
		str = strArr[i];
		if(str == "")
			continue;
		str = str.split(",");
		o = {};
		for(var j = 0, m = str.length ; j < m ; j += 1){
			item = str[j].split(":");
			o[item[0]] = item[1];
		}
		data.push(o);
	}
	return data;
}

// type_title, prop_title에 마우스 오버시 target이 외의 div를 접는다.
function titleMouseHandler(e){
	if(!displayNoneElem || all_ani_dirty)
		return;

	var id,
		activeTarget,
		target = e.target || e.srcElement;
	
	id = target.id;
	if(id == "type_title")
		id = "type";
	else if(id == "prop_title")
		id = "prop";
	else
		return;
	
	// 
	if(displayNoneElem.id.indexOf(id) < 0)
		return;
	
	activeTarget = _$("prop_content");
	if(id == "prop")
		activeTarget = _$("type_content");

	// displayNoneElem의 크기를 원래크기로 돌리고 활성화 시킨다.
	playEffect(displayNoneElem, {"height":0}, {"height":displayNoneElem.scrollHeight}, titleSlideEnd, 800);
	activeMenu(_$(id + "_title"));

	// activeTarget의 크기를 줄인다
	playEffect(activeTarget, {"height":activeTarget.scrollHeight}, {"height":0}, titleSlideEnd, 800);
	displayNoneElem = activeTarget;
}

function titleSlideEnd(e){
	e._ani_dirty = false;
}

// layout, data tab, home button에 이벤트 추가
function addElementEvent(){
	var i,e,
		layout = _$("li_layout"),
		data = _$("li_data"),
		source = _$("li_source"),
		home = _$("home"),
		tsource = _$("tarea_source"),
		tdata = _$("tarea_data"),
		tlayout = _$("tarea_layout"), 
		update = _$("btn_update"),
		type_title = _$("type_title"),
		prop_title = _$("prop_title");

	//overview img click 핸들러
	for(i = 0 ; i < images.length; i++){
		e = _$("img_"+images[i].u);
		e.u = images[i].u;
		e.titleTarget = "type_title";
		demoEvent("add",e , "click", overviewImgClick);
	}
	
	// data text area 숨김
	set(_$("tarea_data"), "display", "none");
	// source text area 숨김
	set(_$("tarea_source"), "display", "none");

	// css class .active_li 적용
	changeCss(layout, ".active_li");
	// tab layout li 활성화
	active_tab_li = layout;

	demoEvent("add", type_title, "mouseover", titleMouseHandler);
	demoEvent("add", prop_title, "mouseover", titleMouseHandler);

	demoEvent("add", layout, "click", tabClickHandler);
	demoEvent("add", data, "click", tabClickHandler);
	demoEvent("add", source, "click", tabClickHandler);	
	demoEvent("add", update, "click",updateClickHandler);
	
	// layout textarea key 핸들러
	demoEvent("add", tlayout, "keydown", textAreaKeyHandler);
	demoEvent("add", tlayout, "keyup", textAreaKeyHandler);
	
	// layout data key 핸들러
	demoEvent("add", tdata, "keydown", textAreaKeyHandler);
	demoEvent("add", tdata, "keyup", textAreaKeyHandler);

	//tutorial 핸들러
	demoEvent("add", _$("tutorial"), "click", startTutorial);
	demoEvent("add",_$("tutorial_next"),"click",nextTutorial);

	demoEvent("add", home, "click", function(){
		if(!all_ani_dirty && open_sub_menu){
			// 이펙트 시 main menu안에 들어가는 것 처럼 보여지기 위해 z index -1
			set(_$("sub_menu"), "zIndex", -1);
			// 메뉴 비활성화
			changeCss(active_menu, ".non_active_menu");
			// 메뉴 li 비활성화
			changeCss(active_main_li, ".non_active_main_li");
			// chart sample 안보이기
			set(_$("chart_sample"), "display", "none");
			// overview 보이기
			set(_$("overview"), "display", "block");
			playEffect(_$("menu"), {"width":321}, {"width":171}, endSlide, 800);
			playEffect(displayNoneElem, {"height":0}, {"height":displayNoneElem.scrollHeight}, titleSlideEnd, 800);
			home_dirty = true;
			displayNoneElem = null;
		}
	});
}

// className으로 들어온 css를 검색하여 target에 적용합니다.
function changeCss(target, className){
	var i, n, 
		j, m,
		cssText,
		rules;

	// chrome 로컬을 위해...
	cssText = _forLocalChromeCss[className.substring(1, className.length)];
	
	if(cssText.indexOf("{") > -1)
		cssText = cssText.substring(cssText.indexOf("{") + 1, cssText.indexOf("}"));
	cssText = cssText.split(";");
	
	for(i = 0, n = cssText.length ; i < n ; i += 1){
		if(cssText[i] == "" || cssText[i] == " ")
			continue;
		rules = cssText[i].split(":");
		target.style[removeHyphen(rules[0])] = rules[1];//.substring(1, rules[1].length);
	}
}

// background-color -> backgroundColor 와 같이 변경해준다.
function removeHyphen(str){
	var i, n, retStr = "";
	str = str.toLowerCase();
	str = str.replace(/\"| /g,"");
	str = str.split("-");
	retStr = str[0];
	for(i = 1, n = str.length ; i < n ; i += 1){
		retStr += str[i].substring(0, 1).toUpperCase() + str[i].substring(1, str[i].length);
	}
	return retStr;
}

// layout, data tab click handler
function tabClickHandler(e){
	var datadisplay = "none",
		layoutdisplay = "none",
		sourcedisplay = "none",
		tsource = _$("tarea_source"),
		tdata = _$("tarea_data"),
		tlayout = _$("tarea_layout"), 
		tadiv = _$("tarea_div"),
		updiv = _$("update_div"),
		iframe = _$("content_iframe"),
		target = e.target || e.srcElement,
		tabHeight,n;
	
	n = checkUrl(iframe);
	if(active_tab_li === target)
		return;

	changeCss(target, ".active_li");
	changeCss(active_tab_li, ".non_active_li");
	
	//클릭된 탭을 활성화
	if(_$("li_layout") === target){
		layoutdisplay = "block";
		set(tsource, "display", "none");
		tabHeight = tlayout.style.height;

	}else if(_$("li_data") == target){
		datadisplay = "block";
		set(tsource, "display", "none");
		tabHeight = tdata.style.height;
	}else{
		sourcedisplay = "block";
		SyntaxHighlighter.config.bloggerMode = true;
    	SyntaxHighlighter.highlight();
		SyntaxHighlighter.all();
		//highlight();
		if ( tsource.nodeName == "DIV" || tsource.nodeName == "PRE" ) {
			set(tsource, "height", "600px");
		}
		tabHeight = tsource.style.height;
	}

	tabHeight = Number(tabHeight.replace(/px/, ''));
	//tarea_div 의 top 17*2
	tadiv.style.height = tabHeight + 34 +"px";
	//tabdiv의 높이 37
	updiv.style.height = tabHeight + 34 + 37 + "px";
	set(tlayout, "display", layoutdisplay);
	set(tdata, "display", datadisplay);
	set(tsource, "display", sourcedisplay);

	active_tab_li = target;
	//비활성화 되었을 경우 update버튼도 함께 비활성화
	activeUpdateBtn(n);

	SyntaxHighlighter.all();

	if ( tsource.nodeName == "DIV" || tsource.nodeName == "PRE" ) {
		set(tsource, "height", "600px");
	}
}

//updateButtonClick Handler
function updateClickHandler(e){
	window.scroll(0, 0);
	var iframe = _$("content_iframe"),
		tlayout = _$("tarea_layout"),
		tdata = _$("tarea_data"),
		chart = iframe.contentWindow.document.getElementById("chart1");
	if(tarea_layout_dirty && tarea_data_dirty){
		chart.setLayout(tlayout.value);
		chart.setData(stringToObject(tdata.value));
	}else if(active_tab_li.id =="li_layout"){
		chart.setLayout(tlayout.value);
	}else{
		chart.setData(stringToObject(tdata.value));
	}
	//초기화
	tarea_layout_dirty = tarea_data_dirty = false;

}

var tarea_layout_dirty = false, // layout textarea가 수정되었는지
	tarea_data_dirty = false; // data textarea가 수정되었는지
// 이 값을 보고 layout만 변경할지 data만 변경할지 모두 변경할지 결정합니다.

// textarea, textdata 키 핸들러
function textAreaKeyHandler(event){
	var tarea = event.target || event.srcElement,
		keyCode = event.keyCode,
		tareaHeight = 0,
		tadiv = _$("tarea_div"),
		updiv = _$("update_div"),
		resize = false, // 엔터, 백스페이스 등이 눌렸을 때 ( 개행처리 변경 )
		headText, // 키 커서를 기준으로 이전 텍스트들
		tailText, // 키 커서를 기준으로 다음 텍스트들
		space = "    ", // tab키를 눌렀을 경우 추가 텍스트
		sindex; // 키 커서 시작 인덱스

	switch(event.type){
		case "keydown":
				if(keyCode == 9){ // tab 키
					if(!tarea.selectionStart)
						alert("IE 7, 8에서는 Tab키를 지원하지 않습니다.");
					sindex = tarea.selectionStart;
					headText = tarea.value.substring(0, sindex);
					tailText = tarea.value.substring(sindex, tarea.value.length);
					tarea.value = headText + space + tailText;
					tarea.selectionStart = tarea.selectionEnd = sindex + space.length;
					if(event.preventDefault)
						event.preventDefault();
				}else if(keyCode == 13 || keyCode == 46 || keyCode == 8)
					resize = true;
			break;
		case "keyup":
				if(keyCode == 8)
					resize = true;
			break;
		default:
			break;
	}

	// 개행처리가 변경이 되었을 경우 
	if(resize){
		tarea.style.height = "1px";
		tareaHeight = tarea.scrollHeight;
		if(keyCode == 13)
			tareaHeight += 16;
		if(tareaHeight > textAreaMaxHeight){
			tareaHeight = textAreaMaxHeight;
		}
		tarea.style.height = tareaHeight + "px";		
		//tarea_div 의 top 17*2
		tadiv.style.height = tareaHeight + 34 +"px";
		//tabdiv의 높이 37
		updiv.style.height = tareaHeight + 34 + 37 + "px";
	}

	//if(keyCode == 13 || keyCode == 46 || keyCode == 8)
	//	window.scroll(0, tarea.scrollHeight);
	
	if(tarea === _$("tarea_layout"))
		tarea_layout_dirty = true;
	else if(tarea === _$("tarea_data"))
		tarea_data_dirty = true;

	if(keyCode == 9)
		return false;	
}

//튜토리얼 시작
function startTutorial(){
	var i,html,w,
		content = _$("tutorial_content"),
		btn = _$("tutorial_next"),
		tu = _$("tutorial_div"),
		exp = _$("tutorial_exp");
	w = get(tu,"width");
	if(w>0){
		return;
	}

	tu.style.display = "block";
	
	window.scrollTo(0,0);
	tutorial_index = 0;
	html = "";
	//html = "rMateChartH5 Tutorial <br> 하단의 버튼을 클릭하여 순차적으로 확인해 보세요.";
	exp.innerHTML = "상단의 버튼을 클릭하세요.";
	btn.innerHTML = "step.1";
	changeCss(tu,".active_tutorial_div");
	
	tutorial_array = [];
	for(i = 0 ; i < tutorialContent.length ; i++){
		html += '<div class="'+tutorialContent[i].className+'">'+tutorialContent[i].content+'</div>';
		if(tutorialContent[i].displayList){
			tutorial_array.push(tutorialContent[i]);
		}
	}

	content.innerHTML = html;
	
	playEffect(tu,{"width":0},{"width":900},tutorialSlideEnd,800);
	
}

//튜토리얼 종료
function endTutorial(){
	var tu = _$("tutorial_div");
	if(tutorial_overview){
		set(_$("overview"), "display", "block")
	}else{
		set(_$("chart_sample"), "display", "block")
	}
	
	playEffect(tu,{"width":900},{"width":0},tutorialEnd,800);
}

function tutorialEnd(e){
	var tu = _$("tutorial_div");
	tu.style.display = "none";
	e._ani_dirty = false;
}

function tutorialSlideEnd(e){
	var overview = _$("overview");
	if(overview.style.display != "none"){
		set(overview, "display", "none");
		tutorial_overview = true;
	}else{
		tutorial_overview = false;
		set(_$("chart_sample"), "display", "none");
	}	
	e._ani_dirty = false;	
}

//튜토리얼 버튼 클릭
function nextTutorial(){
	var i,h,n,btn = _$("tutorial_next"),
		con = _$("tutorial_content"),
		exp = _$("tutorial_exp"),
		maxCount = tutorial_array.length-1,
		chartVars;	
	if(btn.innerHTML == "step.6"){
		btn.innerHTML = "close";
		exp.innerHTML = "";
		//window.scrollBy(0,300);
		return;
	}else if(btn.innerHTML == "close"){
		endTutorial();		
		//window.scrollTo(0,0);
		return;
	}
	for(i = 0 ; i < tutorial_array.length; i++){		
		if(tutorial_array[i].displayIndex == tutorial_index){
			//changeCss(con.childNodes[tutorial_array[i].index],".active_tutorial_child");
			h = con.childNodes[tutorial_array[i].index].childNodes[0].offsetHeight + 10;
			playEffect(con.childNodes[tutorial_array[i].index],{"height":0},{"height":h},titleSlideEnd,800);
			if(tutorial_array[i].displayBtn){
				exp.innerHTML = tutorial_array[i].displayBtn;
			}
		}
	}	
	tutorial_index++;
	if(maxCount  <= tutorial_index){
		tutorial_index=maxCount;		
	}else if(tutorial_index == 3){
		//window.scrollBy(0,150);
	}else if(tutorial_index == 4){
		//window.scrollBy(0,250);
	}else if(tutorial_index == 5){
		//window.scrollBy(0,170);
	}
	n = tutorial_index+1;
	btn.innerHTML = "step."+ n;
}

// window scrollTo
function playWindowScroll(from, to){
	playEffect(window, {"scroll":from}, {"scroll":to}, function(e){
		e._ani_dirty = false;
	}, 800, true);
}

//테마 변경
function changeTheme(theme){
	var iframe = _$("content_iframe").contentWindow ;	
	iframe.rMateChartH5ChangeTheme(theme);
}

//overview image click handler
function overviewImgClick(e){
	if(all_ani_dirty) // 이펙트 중인 객체가 있으면 return
		return;
	var i,tname,turl,item,c,li,
		target = e.target || e.srcElement,
		type = _$("default_type").children[0].children,
		premium = _$("premium_type").children[0].children;
	activeMenu(_$(target.titleTarget));
	
	
	turl = target.u;
	//디폴트 타입에서 필요 li 검색
	for(i = 0 ; i < type.length ; i++){
		tname = type[i].innerHTML;
		if(turl=="target"){
			turl = "Target vs Actual";
		}else if(turl == "broken"){
			turl = "BrokenAxis";	
		}else if(turl == "candle"){
			turl = "candlestick";
		}
		if(tname.toUpperCase() == turl.toUpperCase()){
			item = type[i];
			break;
		}
	}
	
	//프리미엄 타입에서 필요 li 검색
	for(i = 0 ; i < premium.length ; i++){
		tname = premium[i].innerHTML;
		if(tname.toUpperCase() == turl.toUpperCase()){
			item = premium[i];
			break;
		}
	}
	item.over = true;
	activeMainLi(item,false);
	all_ani_dirty = false;
	
}

// effect
// e : 적용 엘리먼트
// fp : from prop value
// tp : to prop value
// d : duration
function playEffect(e, fp, tp, endFunc, d, scroll){
	var o,
		endTime,
		interval,
		offset = 1 / d,
		startTime = new Date().getTime(),
		play = function(){
			endTime = new Date().getTime();
			for(o in tp){
				if(endTime - startTime > d){
					if(scroll)
						e.scrollTo(0, tp[o]);
					else
						e.style[o] = tp[o] + "px";
					clearInterval(interval);
					endFunc(e);
					ani_index--;
					if(ani_index == 0)
						all_ani_dirty = false;
				}else{
					if(scroll)
						e.scrollTo(0, (easingFunc(endTime - startTime, 0, 1, d)  * (tp[o] - fp[o])));
					else
						e.style[o] = fp[o] + (easingFunc(endTime - startTime, 0, 1, d)  * (tp[o] - fp[o])) + "px";
				}
			}
		};
	// 이펙트 중이 아닐 경우만
	if(!e._ani_dirty){
		ani_index++; // 이펙트 count 증가
		all_ani_dirty = e._ani_dirty = true;
		interval = setInterval(play, 30);
	}
}

function endSlide(e){
	var display = "block",
		open = true;

	if(open_sub_menu){
		display = "none";
		open = false;
		
		// main menu 오른쪽 선 해제
		changeCss(_$("main_menu"), ".non_main_menu_border");
		// 활성화 된 메뉴와 메뉴 아이템 null처리
		active_menu = active_main_li = null;
		// rMate Chart for HTML5 v3.0 안 보이기
		set(_$("title_eng"), "display", display);
	}else{
		// sub item click으로 인하여 z-index 0으로 설정
		set(_$("sub_menu"), "zIndex", 0);
	}
	open_sub_menu = open;
	e._ani_dirty = false;
}

function endSlide2(e){
	var display = "block",
		open = true;

	if(open_sub_menu){
		display = "none";
		open = false;
		
		// main menu 오른쪽 선 해제
		changeCss(_$("main_menu"), ".non_main_menu_border");
		// 활성화 된 메뉴와 메뉴 아이템 null처리
		active_menu = active_main_li = null;
		// rMate Chart for HTML5 v3.0 안 보이기
		set(_$("title_eng"), "display", display);
	}else{
		// sub item click으로 인하여 z-index 0으로 설정
		set(_$("sub_menu"), "zIndex", 0);
	}
	open_sub_menu = open;
	e._ani_dirty = false;
	all_ani_dirty = false;
	var li  = _$("active_content_childs").children[0].children[0];
	li.click();
}

function easingFunc(t, b, c, d){
	t /= d;
	t--;
	return c*(t*t*t + 1) + b;
}

// 해당 id의 엘리먼트 가져오기
function _$(id){
	return document.getElementById(id);
}

function set(e, p, v, px){
	e.style[p] = v + (px ? "px" : "");
}

function get(e,p){
	var v = e.style[p];
	if(typeof v === "string" && v.indexOf("px") > 0 ) {
		v = Number(v.replace(/px/, ''));
	}
	return v;
}

// chrome에서는 로컬로 css에 접근이 되지 않아 사용자 조작으로 변경되는 css들을 아래에서 추출하여 적용하도록 한다.
var _forLocalChromeCss = {
	active_menu : "background-color:#f7721a;color:#ffffff",
	non_active_menu : "background-color:#f2f2f2;color:#454545",
	active_li : "border-bottom:none;background-color:#f7f7f7",
	non_active_li : "border-bottom:solid 1px #e2e2e2;background-color:#ffffff",
	active_main_li : "color:#454545;text-decoration:underline",
	non_active_main_li : "color:#888888;text-decoration:none",
	active_sub_li : "color:#ffffff;background-color:#888888",
	non_active_sub_li : "color:#888888;background-color:#ffffff",
	active_main_menu_border : "border-right-style:solid;border-right-width:1px;border-right-color:#ebebeb",
	non_main_menu_border : "border-right-style:none",
	sample_name_eng : "font-family:arial;font-size:28px",
	sample_name_han : "font-family:맑은 고딕;font-size:23px;letter-spacing:-1px",
	active_tutorial_child : "display:block;overflow:hidden;font-family: arial,맑은 고딕;font-size:12px",
	none_tutorial_child : "height:0px;overflow:hidden;font-family: arial,맑은 고딕;font-size:12px",
	active_tutorial_div : "border-right:solid 1px #ebebeb",
	non_tutorial_div : "border:none"
}

//크롬 & local여부 판별하여 안내 메세지
function checkChrome(){
	var u = navigator.userAgent,
		isSafari = Object.prototype.toString.call(window.HTMLElement).indexOf('Constructor') > 0;
	var rlocalProtocol = /^(?:about|app|app\-storage|.+\-extension|file|widget):$/;
	var rurl = /^([\w\+\.\-]+:)(?:\/\/([^\/?#:]*)(?::(\d+))?)?/;
	// Document location
	var ajaxLocation;

	// Document location segments
	var ajaxLocParts;

	// #8138, IE may throw an exception when accessing
	// a field from window.location if document.domain has been set
	try {
		ajaxLocation = location.href;
	} catch( e ) {
		// Use the href attribute of an A element
		// since IE will modify it given document.location
		ajaxLocation = document.createElement( "a" );
		ajaxLocation.href = "";
		ajaxLocation = ajaxLocation.href;
	}

	ajaxLocParts = rurl.exec( ajaxLocation.toLowerCase() ) || [];

	// 로컬인지 여부를 나타탬.
	var isLocal = rlocalProtocol.test( ajaxLocParts[ 1 ] );

	if(!isSafari && testCSS("WebkitTransform") && isLocal){
		//alert("Chrome Browser 는 보안문제로 인하여 샘플이 정상적으로 보이지 않습니다.\n자세한 사항은 제품에 첨부된 처음사용자.txt파일을 참고하시기 바랍니다.");

		var d = _$("deemd"),
			alert = _$("deemd_alert"),
			content = _$("deemd_content"),
			title = _$("deemd_title"),
			close = _$("deemd_close"),
			str="";

		str = "Chrome Browser 는 보안문제로 인하여 로컬에서 실행시<br> 샘플이 정상적으로 보이지 않습니다.<br> "
			+'자세한 사항은 제품에 첨부된 "처음사용자.txt" 파일의 1번 내용을<br>'
			+" 참고하여 주시기 바랍니다.";
		content.innerHTML = str;
		d.style.display = "block";
		alert.style.display = "block";
		demoEvent("add",close,"click",closeDeemd);
	}	
}

function closeDeemd(){
	var d = _$("deemd"),
		alert = _$("deemd_alert"),
		close = _$("deemd_close");
	
	demoEvent("remove",close,"click",closeDeemd);
	d.style.display = "none";
	alert.style.display = "none";
}

function testCSS(prop){
	return prop in document.documentElement.style;
}