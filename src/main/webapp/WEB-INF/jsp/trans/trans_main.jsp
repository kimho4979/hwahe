<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
    <%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>화훼유통정보시스템 ::: </title>
  <!-- @@@@@@@@@@@@@@@@@@@@@@ css begin @@@@@@@@@@@@@@@@@@@@@@ -->
  <link rel="stylesheet" type="text/css" href="<c:url value='/rMateChart/rMateChartH5/Assets/Css/rMateChartH5.css' />"/>   
 <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/axicon/axicon.min.css' />" />
 <link rel="stylesheet" type="text/css" href="<c:url value='/axisj/ui/arongi/AXJ.min.css' />" />
  <!-- @@@@@@@@@@@@@@@@@@@@@@ css end   @@@@@@@@@@@@@@@@@@@@@@ --> 
  
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
  
   
</head>
<body>
<h3><i class="axi axi-assignment-ind"></i><i class="axi axi-aspect-ratio"></i>자료전송 시스템</h3>
<button class="AXButton Green"><i class="axi axi-axicon"></i> AXIcon</button><br />
<div class="ax-search" id="page-search-box"></div>

<div id="content">
		<!-- 차트가 삽입될 DIV -->
		<div id="chartHolder" style="width:600px; height:400px;">
		</div>
	</div>
<div id="page-grid-box" style="height:120px;"></div>
</body>
</html>
 <script type="text/javascript">

// -----------------------차트 설정 시작-----------------------

// rMate 차트 생성 준비가 완료된 상태 시 호출할 함수를 지정합니다.
var chartVars = "rMateOnLoadCallFunction=chartReadyHandler";

// rMateChart 를 생성합니다.
// 파라메터 (순서대로) 
//  1. 차트의 id ( 임의로 지정하십시오. ) 
//  2. 차트가 위치할 div 의 id (즉, 차트의 부모 div 의 id 입니다.)
//  3. 차트 생성 시 필요한 환경 변수들의 묶음인 chartVars
//  4. 차트의 가로 사이즈 (생략 가능, 생략 시 100%)
//  5. 차트의 세로 사이즈 (생략 가능, 생략 시 100%)
rMateChartH5.create("chart1", "chartHolder", chartVars, "100%", "100%"); 

// 차트의 속성인 rMateOnLoadCallFunction 으로 설정된 함수.
// rMate 차트 준비가 완료된 경우 이 함수가 호출됩니다.
// 이 함수를 통해 차트에 레이아웃과 데이터를 삽입합니다.
// 파라메터 : id - rMateChartH5.create() 사용 시 사용자가 지정한 id 입니다.
function chartReadyHandler(id) {
	// 레이아웃 생성
	var layoutStr = createLayout();

	document.getElementById(id).setLayout(layoutStr);
	document.getElementById(id).setData(chartData);
}

function createLayout(){
	// IE 7,8은 SeriesClip을 지원하지 않음
	var effect = compIE() ? "SeriesClip" : "SeriesInterpolate";

	// 스트링 형식으로 레이아웃 정의.
	return '<rMateChart backgroundColor="#FFFFFF"  borderThickness="1" borderStyle="none">'
			+'<Options>'
				+'<Caption text="Rainfall" />'
				+'<SubCaption text="( mm )" textAlign="right" />'
				+'<Legend />'
			+'</Options>'
			+'<NumberFormatter id="numFmt" precision="0"/>'
			+'<Line2DChart showDataTips="true" dataTipDisplayMode="axis" paddingTop="0">'
				+'<horizontalAxis>'
					+'<CategoryAxis categoryField="Month"/>'
				+'</horizontalAxis>'
				+'<verticalAxis>'
					+'<LinearAxis minimum="70" maximum="100" interval="5" />'
				+'</verticalAxis>'
				+'<series>'
					+'<Line2DSeries yField="Vancouver" displayName="Vancouver">'
						+'<showDataEffect>'
							+ '<' + effect + ' duration="1000"/>'
						+'</showDataEffect>'
					+'</Line2DSeries>'
				+'</series>'
			+'</Line2DChart>'
		+'</rMateChart>';
}

// 차트 데이터
var chartData = [{"Month":"Jan", "Vancouver":80},
				{"Month":"Feb", "Vancouver":90},
				{"Month":"Mar", "Vancouver":83},
				{"Month":"Apr", "Vancouver":81},
				{"Month":"May", "Vancouver":87},
				{"Month":"Jun", "Vancouver":89},
				{"Month":"Jul", "Vancouver":86},
				{"Month":"Aug", "Vancouver":92},
				{"Month":"Sep", "Vancouver":88},
				{"Month":"Oct", "Vancouver":84},
				{"Month":"Nov", "Vancouver":87},
				{"Month":"Dec", "Vancouver":90}];

// IE 판별
function compIE(){
	var agent = navigator.userAgent;
	if(agent.indexOf("MSIE 7.0") > -1 || agent.indexOf("MSIE 8.0") > - 1 || agent.indexOf("Trident 4.0") > -1)
		return false;

	if(document.documentMode && document.documentMode <= 5)
		return false;

	return true;
}

/**
 * rMateChartH5 3.0에서 제공하고 있는 테마기능을 사용하시려면 아래 내용을 설정하여 주십시오.
 * 테마 기능을 사용하지 않으시려면 아래 내용은 삭제 혹은 주석처리 하셔도 됩니다.
 *
 * -- rMateChartH5.themes에 등록되어있는 테마 목록 --
 * - simple
 * - cyber
 * - modern
 * - lovely
 * - pastel
 * - old
 * -------------------------------------------------
 *
 * rMateChartH5.themes 변수는 theme.js에서 정의하고 있습니다.
 */
//rMateChartH5.registerTheme(rMateChartH5.themes);

/**
 * 샘플 내의 테마 버튼 클릭 시 호출되는 함수입니다.
 * 접근하는 차트 객체의 테마를 변경합니다.
 * 파라메터로 넘어오는 값
 * - simple
 * - cyber
 * - modern
 * - lovely
 * - pastel
 * - old
 * - default
 *
 * default : 테마를 적용하기 전 기본 형태를 출력합니다.
 * old : rMateChartH5 2.5 이하 버전의 형태를 출력합니다.
 */
function rMateChartH5ChangeTheme(theme){
	document.getElementById("chart1").setTheme(theme);
}

// -----------------------차트 설정 끝 -----------------------
 var resize_elements = [
            {id:"page-grid-box", adjust:-97}
          ];
          
 var fnObj = {
		 
		 pageStart: function(){
			 this.search.bind();
			 this.grid.bind();
		 },
		 bindEvent: function(){
			 
		 },
		 search: {
			 target: new AXSearch(),
             get: function(){ return this.target},
             bind: function(){
                 var _this = this;
                 this.target.setConfig({
                     targetID:"page-search-box",
                     theme : "AXSearch",
                     mediaQuery: {
                         mx:{min:0, max:767}, dx:{min:767}
                     },
                     onsubmit: function(){
                         // 버튼이 선언되지 않았거나 submit 개체가 있는 경우 발동 합니다.
                     },
                     rows:[
							{display:true, addClass:"", style:"", list:[
                        		{label:"Selector", labelWidth:"", type:"inputText", width:"150", key:"inputTextSelector", addClass:"", valueBoxStyle:"", value:"123",
	                        		AXBind:{
	                        			type:"selector", config:{
	                        				appendable:true,
	                        				ajaxUrl:"selectorData.txt",
	                        				ajaxPars:"",
	                        				onChange:function(){
	                        					toast.push(Object.toJSON(this));
	                        				}
	                        			}
	                        	}
	                         },
	                        {label:"Date", labelWidth:"", type:"inputText", width:"110", key:"inputTextDate", addClass:"secondItem", valueBoxStyle:"", value:"",
	                        	AXBind:{
	                        		type:"date", config:{
	                        		align:"right", valign:"top", defaultDate:"2013-05-01", 
	                        		onChange:function(){
	                        			toast.push(Object.toJSON(this));
	                        		}
	                        	}
	                       	  },
	                       	  onkeydown: function(e){
	                       			trace("keydown" + e.keyCode);
	                       	 },
	                      	 onkeyup: function(e){
	                      	 	trace("keyup" + e.keyCode);
	                      	}
	                      }
                      ]},
                      {display:false, addClass:"", style:"", list:[
                      		{label:"", labelWidth:"100", type:"selectBox", width:"", key:"selectbox", addClass:"", valueBoxStyle:"", value:"",
                        		options:[{optionValue:"all", optionText:"전체보기"}, {optionValue:"open", optionText:"공개"}, {optionValue:"close", optionText:"비공개"}],
                        			AXBind:{
                        				type:"select", config:{
                        					onChange:function(){
                        						toast.push(Object.toJSON(this));
                        					}
                        				}
                        			}
                        	},
                        	{label:"", labelWidth:"", type:"inputText", width:"150", key:"inputText", addClass:"secondItem", valueBoxStyle:"padding-left:0px;", value:"",
                        			onChange: function(){}
                        	},
                        	{label:"기간", labelWidth:"", type:"inputText", width:"70", key:"inputText1", addClass:"secondItem", valueBoxStyle:"", value:"",
                        			onChange: function(){}
                        	},
                        	{label:"", labelWidth:"", type:"inputText", width:"90", key:"inputText2", addClass:"secondItem", valueBoxStyle:"padding-left:0px;", value:"",
                        		AXBind:{
                        			type:"twinDate", config:{
                        				align:"right", valign:"top", startTargetID:"inputText1", 
                        				onChange:function(){
       									}
                					}
                        		}
                        	},
                        	{label:"", labelWidth:"", type:"button", width:"80", key:"button", addClass:"Red", valueBoxStyle:"padding-left:0px;padding-right:5px;", value:"검색하기",
                        			onclick: function(){
                        					var pars = this.target.getParam();
                        					toast.push("콘솔창에 파라미터 정보를 출력하였습니다.");
                        					trace(pars);
                        			}
                        	}
                      ]}
                    ]
                 });
             },
		 },
		   grid: {
	            target: new AXGrid(),
               pageNo: 1,
	            bind: function(){
	                this.target.setConfig({
	                    targetID : "page-grid-box",
	                    theme : "AXGrid",
                       colHeadAlign:"center",
                       /*
	                    mediaQuery: {
	                        mx:{min:0, max:767}, dx:{min:767}
	                    },
	                    */
	                    colGroup : [
                          
	                        {key:"title", label:"제목", width:"*", align:"left"},
	                        {key:"insDt", label:"등록일", width:"80", align:"center", formatter:function(){
                               if (this.value!=""){
                                   return this.value.date().print();
                               }
                               else
                                   return "";
                           }},
                               /*
                           {key:"attach1", label:"첨부1", width:"150", align:"center", formatter:function(){
                               //trace(this.item.files[0].value);
                               return "";
                           }},
                           {key:"attach2", label:"첨부2", width:"150", align:"center", formatter:function(){
                               //trace(this.value);
                               return "";
                           }},
                           */
                           {key:"dispYn", label:"표시여부", width:"70", align:"center", formatter:function(){
                               if (this.value=="Y")
                                   return "사용";
                               else
                                   return "사용안함";
                           }},
	                        {key:"popupYn", label:"팝업여부", width:"70", align:"center", formatter:function(){
                               if (this.value=="Y")
                                   return "사용";
                               else
                                   return "사용안함";
                           }},
	                        {key:"stDt", label:"게시시간", width:"160", align:"center", formatter:function(){
                               if (this.value==undefined || this.value=="")
                                   return "";
                               else
                                   return this.value.date().print() + " ~ " + this.item.endDt.date().print();
                           }}
	                    ],
	                    body : {
	                       
	                    },
                       page: {
                           display:true,
                           paging:false,
                           onchange: function(pageNo){
                               _this.setPage(pageNo);
                           }
                       }
	                });

                   fnObj.grid.setPage(fnObj.grid.pageNo);
	            },
               setPage: function(pageNo, searchParams) {
                   var _this = this;
                   _this.pageNo = pageNo;
                   /* app.ajax({
                       type: "GET",
                       url: "/cmn/notice/noticeList.json",
                       data: "pageNumber=" + (pageNo-1) + "&pageSize=50&" + (searchParams||fnObj.search.target.getParam())
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
                           _this.target.setData(gridData);
                       }
                   }); */
               }
	        }
		 
 
 
 
 
 
 };
 
 jQuery(document.body).ready(function(){fnObj.pageStart()});


</script>
