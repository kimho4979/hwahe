// sample기본 주소
var baseurl = "./Samples/",

	// 기본 타입
	default_types = [{
		// Line
			"n":"Line", "c":[
				// n - name
				// u - url
				{"n":"Line Segment", "u":"Line_2D_Segment"},
				{"n":"Line Curve", "u":"Line_2D_Curve"},
				{"n":"Line Step", "u":"Line_2D_Step"},
				{"n":"Line ItemRenderer", "u":"Line_2D_Item"},
				{"n":"Line BaseLine", "u":"Line_2D_BaseLine"},
				{"n":"Line for Null Data", "u":"Line_2D_Interpolate"},
				{"n":"Dashed Line Segment", "u":"Dash_Lines"},
				{"n":"Dashed Line Curve", "u":"Dash_Line_Curve"},
				{"n":"Dashed Line Step", "u":"Dash_Line_Step"},
				{"n":"Line + Dahsed Line", "u":"Dash_DashedLine_Line"},
				{"n":"Line + Dashed Line Multi", "u":"Dash_Line_DashedLine"}
			]
		},{
		// Column
			"n":"Column", "c":[
				{"n":"Column", "u":"Column_2D"},
				{"n":"Column 3D", "u":"Column_3D"},
				{"n":"Multi Series", "u":"Column_2D_MS"},
				{"n":"Multi Series 3D", "u":"Column_3D_MS"},
				{"n":"Stacked", "u":"Column_2D_Stacked"},
				{"n":"Stacked(연결선)", "u":"Column_2D_Stacked_Link"},
				{"n":"2D 100%", "u":"Column_2D_100Per"},
				{"n":"Stacked 3D", "u":"Column_3D_Stacked"},
				{"n":"Stacked 3D(연결선)", "u":"Column_3D_Stacked_Link"},
				{"n":"3D 100%", "u":"Column_3D_100Per"},
				{"n":"Multi Series Stacked", "u":"Column_2D_MS_Stacked"},
				{"n":"Column 폭 제어", "u":"Column_2D_Width_Control"},
				{"n":"Column Multi 폭 제어", "u":"Column_2D_MS_Width_Control"},
				{"n":"Cylinder 3D", "u":"Cylinder_3D"},
				{"n":"Cylinder Multi Series 3D", "u":"Cylinder_3D_MS"},
				{"n":"Cylinder Stacked 3D", "u":"Cylinder_3D_Stacked"}
			]
		},{
		// Bar
			"n":"Bar", "c":[
				{"n":"Bar", "u":"Bar_2D"},
				{"n":"Bar Negative", "u":"Bar_2D_Negative"},
				{"n":"Bar 3D", "u":"Bar_3D"},
				{"n":"Multi Series", "u":"Bar_2D_MS"},
				{"n":"Multi Series 3D", "u":"Bar_3D_MS"},
				{"n":"Stacked", "u":"Bar_2D_Stacked"},
				{"n":"Stacked(연결선)", "u":"Bar_2D_Stacked_Link"},
				{"n":"2D 100%", "u":"Bar_2D_100Per"},
				{"n":"Stacked 3D", "u":"Bar_3D_Stacked"},
				{"n":"3D 100%", "u":"Bar_3D_100Per"},
				{"n":"Multi Series Stacked", "u":"Bar_2D_MS_Stacked"},
				{"n":"Bar 폭 제어", "u":"Bar_2D_Width_Control"},
				{"n":"Bar Multi 폭 제어", "u":"Bar_2D_MS_Width_Control"},
				{"n":"Cylinder 3D", "u":"Cylinder_Bar_3D"},
				{"n":"Cylinder Stacked 3D", "u":"Cylinder_Bar_3D_Stacked"}
			]
		},{
		// Area
			"n":"Area", "c":[
				{"n":"Area", "u":"Area_2D"},
				{"n":"Stacked", "u":"Area_2D_Stacked"},
				{"n":"Multi Series", "u":"Area_2D_MS"},
				{"n":"Area Baseline", "u":"Area_2D_BaseLine"}
			]
		},{
		// Pie
			"n":"Pie", "c":[
				{"n":"Pie", "u":"Pie_2D"},
				{"n":"Pie 3D", "u":"Pie_3D"},
				{"n":"Stacked 3D", "u":"Pie_3D_Stacked"},
				{"n":"Pie with Wedge", "u":"Pie_2D_Wedge"},
				{"n":"Doughnut", "u":"Doughnut_2D"},
				{"n":"Doughnut 3D", "u":"Doughnut_3D"},
				{"n":"Half Pie", "u":"Half_Pie_2D"}
			]
		},{
		// Bubble
			"n":"Bubble", "c":[
				{"n":"Bubble", "u":"Bubble_3D"},
				{"n":"Multi Series", "u":"Bubble_3D_MS"},
				{"n":"Bubble Transparency", "u":"Bubble_3D_Transparency"}
			]
		},{
		// Plot
			"n":"Plot", "c":[
				{"n":"Plot", "u":"Plot_2D"},
				{"n":"Plot - 중심선", "u":"Plot_2D_Ex"}
			]
		},{
		// Combination
			"n":"Combination", "c":[
				{"n":"Area + Line", "u":"Combi_2D_Single"},
				{"n":"2D + Line", "u":"Combination_2D_Line"},
				{"n":"3D + Line", "u":"Combination_3D_Line"},
				{"n":"2D Multi Stacked + Line", "u":"Combination_2D_Complex_Line"},
				//{"n":"3D Multi Series", "u":"Combination_3D_MS_Line"},
				//{"n":"3D Stacked + Line", "u":"Combination_3D_Stacked_Line"},
				{"n":"2D Multi + Area + Line", "u":"Combi_2D_Multi"}
				//{"n":"3D + Area + Line", "u":"Combi_Single"},
				//{"n":"3D Multi + Area + Line", "u":"Combi_Multi"},
				//{"n":"3D Stacked + Area + Line", "u":"Combi_Stacked"}
			]
		},{
		// From-to
			"n":"From - To", "c":[
				{"n":"Steps", "u":"From_To_Bar_2D"},
				{"n":"From - To (Bar)", "u":"From_To_Bar_3D"},				
				{"n":"From - To (Column)", "u":"From_To_Column_3D"},
				{"n":"From - To (Area)", "u":"From_To_Area_2D"},
				{"n":"From - To (Area Multi)", "u":"From_To_Area_2D_MS"},
				{"n":"WaterFall", "u":"From_To_Column_2D"}
			]
		},{
		// Radar
			"n":"Radar", "c":[
				{"n":"Polygon - Fill", "u":"Radar_Polygon"},
				{"n":"Polygon - No Fill", "u":"Radar_Polygon_NoFill"},
				{"n":"Polygon - Fill", "u":"Radar_Polygon_NoFill2"},
				{"n":"Circle - Fill", "u":"Radar_Circle"},
				{"n":"Circle - No Fill", "u":"Radar_Circle_NoFill"}
			]
		},{
		// 목표대비실적
			"n":"Target vs Actual", "c":[
				{"n":"Cylinder 3D", "u":"Target_3D"},
				{"n":"Bar Cylinder 3D", "u":"Target_Bar_3D"},
				{"n":"Linear 2D", "u":"Target_2D"}
			]
		},{
		// History
			"n":"History", "c":[
				{"n":"Column", "u":"History_2D"},
				{"n":"Line", "u":"History_2D_Line"},
				{"n":"Column + Line", "u":"History_2D_WL"},
				{"n":"Combination", "u":"History_3D"}
			]
		},{
		// RealTime
			"n":"RealTime", "c":[
				{"n":"데이터 갯수 기준", "u":"RealTime_Size_TimeAxis"},
				{"n":"시간 기준", "u":"RealTime_Time_TimeAxis"}
				//{"n":"실시간 차트", "u":"Stock_Monitoring"}
			]
		},{
		// Scroll
			"n":"Scroll", "c":[
				{"n":"Column", "u":"Scroll_Column_2D"},
				{"n":"Column 3D", "u":"Scroll_Column_3D"},
				{"n":"Column Multi", "u":"Scroll_Column_2D_MS"},
				{"n":"Column Stacked", "u":"Scroll_Column_2D_Stacked"},
				{"n":"Bar Multi", "u":"Scroll_Bar_2D_MS"},
				{"n":"Bar Multi Inverted", "u":"Scroll_Bar_2D_Inverted_MS"},
				{"n":"Line Multi", "u":"Scroll_Line_2D_MS"},
				{"n":"Area", "u":"Scroll_Area_2D"},
				{"n":"Area Multi", "u":"Scroll_Area_2D_MS"},
				{"n":"Combination", "u":"Scroll_Combination_2D"},
				{"n":"Scroll Lazy Data", "u":"Scroll_Lazy_Data"}
			]
		}
	],

	// 프리미엄 타입
	premium_types = [{
		// BrokenAxis
			"n":"BrokenAxis", "c":[
				//{"n":"Column2DChart Broken Axis", "u":"BrokenAxis_Column_2D"},
				//{"n":"Bar2DChart Broken Axis", "u":"BrokenAxis_Bar_2D"},
				//{"n":"Column3DChart Broken Axis", "u":"BrokenAxis_Column_3D"},
				//{"n":"Bar3DChart Broken Axis", "u":"BrokenAxis_Bar_3D"},
				//{"n":"Line2DChart Broken Axis", "u":"BrokenAxis_Line_2D"}
				{"n":"2D Column Broken Axis", "u":"BrokenAxis_Column_2D"},
				{"n":"2D Bar Broken Axis", "u":"BrokenAxis_Bar_2D"},
				{"n":"3D Column Broken Axis", "u":"BrokenAxis_Column_3D"},
				{"n":"3D Bar Broken Axis", "u":"BrokenAxis_Bar_3D"},
				{"n":"2D Line Broken Axis", "u":"BrokenAxis_Line_2D"}
			]
		},{
		// Image
			"n":"Image", "c":[
				{"n":"정배율-단일이미지(1)", "u":"Image_Single_Ratio"},
				{"n":"정배율-단일이미지(2)", "u":"Image_Single_MS_Ratio"},
				{"n":"차등배율-단일이미지(1)", "u":"Image_Single_FRatio"},
				{"n":"차등배율-단일이미지(2)", "u":"Image_Single_FRatio2"},
				{"n":"정배율-반복이미지(1)", "u":"Image_SingleRepeat"},
				{"n":"정배율-반복이미지(2)", "u":"Image_SingleRepeat2"},
				{"n":"차등배율-복수이미지(1)", "u":"Image_Multiple"},
				{"n":"차등배율-복수이미지(2)", "u":"Image_Multiple2"}
			]
		},{
		// Wing
			"n":"Wing", "c":[
				{"n":"Bar 2D Wing", "u":"Bar_2D_Wing"},
				{"n":"Bar 2D Wing Multi", "u":"Bar_2D_Wing_Multi"},
				{"n":"Bar 2D Wing Stacked", "u":"Bar_2D_Wing_Stacked"},
				{"n":"Bar 2D Wing Stacked<br> ( 연결선 잇기 )", "u":"Bar_2D_Wing_Stacked_Link"},
				{"n":"Bar 2D Wing 100%", "u":"Bar_2D_Wing_100Per"},
				{"n":"Column 2D Wing", "u":"Column_2D_Wing"},
				{"n":"Column 2D Wing Multi", "u":"Column_2D_Wing_Multi"},
				{"n":"Column 2D Wing Stacked", "u":"Column_2D_Wing_Stacked"},
				{"n":"Column 2D Wing Stacked ( 연결선 잇기 )", "u":"Column_2D_Wing_Stacked_Link"},
				{"n":"Column 2D Wing 100%", "u":"Column_2D_Wing_100Per"}
			]
		},{
		// Candlestick
			"n":"Candlestick", "c":[
				{"n":"Candlestick Chart", "u":"Candlestick_Normal"},
				{"n":"Candlestick Chart Reverse", "u":"Candlestick_Reverse"},
				{"n":"Candlestick Symbol", "u":"Candlestick_Symbol"},
				{"n":"Candlestick Symbol Another", "u":"Candlestick_Symol_Another"},
				{"n":"CandleLine Symbol", "u":"CandleLine_Symbol"},
				{"n":"CandleLine Baseline", "u":"CandleLine_Baseline"},
				{"n":"CandleArea Symbol", "u":"CandleArea_Symbol"},
				{"n":"CandleArea Baseline", "u":"CandleArea_Baseline"},
				{"n":"Candle Lazy Data", "u":"Candle_Lazy_Data"}
			]
		},{
		// TreeMap
			"n":"TreeMap", "c":[
				{"n":"TreeMap", "u":"TreeMap"},
				{"n":"TreeMap Range", "u":"TreeMap_Range"},
				{"n":"TreeMap Depth", "u":"TreeMap_Depth"},
				{"n":"TreeMap Industry", "u":"TreeMap_Industry"},
				{"n":"TreeMap Dynamic", "u":"TreeMap_Dynamic"}
			]
		},{
		// WordCloud
			"n":"WordCloud", "c":[
				{"n":"Word Cloud Eng", "u":"WordCloud_Eng"},
				{"n":"Word Cloud Kor", "u":"WordCloud_Kor"},
				{"n":"Word Cloud Data Change", "u":"WordCloud_DataChange"},
				{"n":"Greetings around the World ", "u":"WordCloud_Greetings_World"}
			]
		},{
		// Matrix
			"n":"Matrix", "c":[
				{"n":"Matrix 기본형", "u":"Matrix2D_Renderer"},
				{"n":"Matrix Fill", "u":"Matrix2D_Fill"},
				{"n":"Matrix Fill 2", "u":"Matrix2D_Fill_2"},
				{"n":"Matrix Plot", "u":"Matrix2D_Plot"},
				{"n":"Matrix Image", "u":"Matrix2D_Image"},
				{"n":"Matrix 렌더러 종류", "u":"Matrix2D_Renderer_s"}
			]
		},{
		// Histogram
			"n":"Histogram", "c":[
				//{"n":"부품 무게 Histogram 2D", "u":"Histogram_2D_Weight"},
				{"n":"성적 Histogram 2D", "u":"Histogram_2D_Grade"},
				{"n":"도수분포다각형 출력", "u":"Histogram_2D_Grade_Polygon"},
				{"n":"상대도수 출력", "u":"Histogram_2D_Grade_Relative"},
				{"n":"개인 키 Histogram 3D", "u":"Histogram_3D_Height"}
			]
		},{
		// Vector
			"n":"Vector", "c":[
				{"n":"Vector Wind", "u":"Vector_2D_Wind"},
				{"n":"Vector Sea", "u":"Vector_2D_Sea"},
				{"n":"Vector Level", "u":"Vector_2D_Level"}
			]
		},{
		// ErrorBar
			"n":"ErrorBar", "c":[
				{"n":"Column ErrorBar", "u":"Error_Column"},
				{"n":"Line ErrorBar", "u":"Error_Line"},
				{"n":"Area ErrorBar", "u":"Error_Area"},
				{"n":"Bar ErrorBar", "u":"Error_Bar"},
				//{"n":"Bubble ErrorBar", "u":"Error_Bubble"},
				{"n":"Plot ErrorBar", "u":"Error_Plot"}
			]
		},{
		// BoxPlot
			"n":"BoxPlot", "c":[
				{"n":"BoxPlot", "u":"BoxPlot"},
				{"n":"BoxPlot Multi", "u":"BoxPlot_Multi"}
			]
		},{
		// Slide
			"n":"Slide", "c":[
				{"n":"기본 슬라이드", "u":"Slide_Sample"},
				{"n":"효과를 추가한 슬라이드", "u":"Slide_Sample2"}
			]
		},{
		// Motion
			"n":"Motion", "c":[
				{"n":"Bubble Motion", "u":"Motion_Bubble"},
				{"n":"Bubble Motion Trails", "u":"Motion_Bubble_Trails"},
				{"n":"Bubble Motion Multi", "u":"Motion_Bubble_Multi"},
				{"n":"Column Motion", "u":"Motion_Column"},
				{"n":"Column Motion Trails", "u":"Motion_Column_Trails"},
				{"n":"Column Motion Multi", "u":"Motion_Column_Multi"},
				{"n":"Line Motion", "u":"Motion_Line"}
			]
		},{
		// RealTime-Premium
			"n":"RealTime-Premium", "c":[
				{"n":"다른 주기의 <br>실시간 데이터 표현", "u":"RealTime_Premium_Line_Column"},
				{"n":"전일과 금일의 <br>실시간 비교", "u":"RealTime_Premium_10Int"},
				{"n":"서로 다른 주기의 <br>실시간 통합 비교", "u":"RealTime_Premium_25Base"}
			]
		},{
		// Gauge
			"n":"Gauge", "c":[
				{"n":"Circular Orange", "u":"Gauge_Circular_Orange"},
				{"n":"Circular Rainbow", "u":"Gauge_Circular_Rainbow"},
				{"n":"Circular Gradient", "u":"Gauge_Circular_Gradient"},
				{"n":"Circular Dual", "u":"Gauge_Circular_Dual"},
				{"n":"Half-Circular Rainbow1", "u":"Gauge_Half_Rainbow1"},
				{"n":"Half-Circular Rainbow2", "u":"Gauge_Half_Rainbow2"},
				{"n":"Half-Circular Notice", "u":"Gauge_Half_Notice"},
				{"n":"Half-Circular Gradient", "u":"Gauge_Half_Gradient"},
				{"n":"Horizontal Cylinder Gauge", "u":"Gauge_HorizontalCylinder"},
				{"n":"Vertical Cylinder Gauge", "u":"Gauge_VerticalCylinder"},
				{"n":"Horizontal Linear Gauge", "u":"Gauge_HorizontalLinear"},
				{"n":"Vertical Linear Gauge", "u":"Gauge_VerticalLinear"}
			]
		}
	],

	// properties
	props = [{
			"n":"데이터 생성 및<br>연동방식", "c":[
				{"n":"String 레이아웃 <br> 배열 데이터", "u":"Embeding_String_Array"},
				{"n":"URL 레이아웃 <br> 배열 데이터", "u":"Embeding_URL_Array"},
				{"n":"String 레이아웃 <br> XML URL 데이터", "u":"Embeding_String_URL"},
				{"n":"String 레이아웃 <br> JSon URL 데이터", "u":"Embeding_String_JSon_URL"},
				{"n":"URL 레이아웃 <br> XML URL 데이터", "u":"Embeding_URL_URL"},
				{"n":"chartVars 변수로 삽입", "u":"Embeding_chartVars"},
				{"n":"CSV URL 데이터로 생성", "u":"Embeding_CSV_URL"},
				{"n":"테이블 데이터로 생성 <br> Horizontal", "u":"GetData_From_Table_Horizontal"},
				{"n":"테이블 데이터로 생성 <br> Vertical", "u":"GetData_From_Table_Vertical"},
				{"n":"다른 차트로 데이터 표현", "u":"Dynamic_Change_Layout"},
				{"n":"데이터 동적으로 변경", "u":"Dynamic_Change_Data"},
				{"n":"데이터,레이아웃 변경", "u":"Dynamic_Change_Both"},
				{"n":"레이아웃 동적 생성", "u":"Var_Dynamic_Layout"}
			]
		},{
			"n":"축 설정", "c":[
				{"n":"축의 제목(대표문자)", "u":"XY_One_Label"},
				{"n":"축의 제목 스타일", "u":"XY_Label"},
				{"n":"축 꾸미기", "u":"XY_Tick"},
				{"n":"축의 위치바꾸기", "u":"XY_Revers"},
				{"n":"Y축 삭제", "u":"XY_Y_Remove"},
				{"n":"Invert Y축", "u":"XY_Invert_Y"},
				{"n":"X축 Category축<br> Y축 Linear축", "u":"XY_CatLin"},
				{"n":"X축 DateTime축<br> Y축 Log축", "u":"XY_DateLog"},
				{"n":"X축 Category축<br> Y축 Log축", "u":"XY_LogLog_Column"},
				{"n":"X축 Log축<br> Y축 Log축", "u":"XY_LogLog_Line"},
				//{"n":"얇은 3D 축", "u":"XY_Thin_3D"}, 개편되며 축이 얇아져 필요없어진 샘플
				{"n":"듀얼(Dual) 축", "u":"XY_Dual"},
				{"n":"듀얼축 - 트리플 시리즈", "u":"XY_Dual2"},
				{"n":"트리플(Triple) 축", "u":"XY_Triple"},
				{"n":"축 CSS 적용", "u":"CSS_Exam2"},
				{"n":"라인,영역 차트의 수치 잘림", "u":"Line_Area_Label"},
				{"n":"최소값, 최대값 적용하기", "u":"Minimum_Maximum"}
			]
		},{
			"n":"선/범위/배경", "c":[
				{"n":"축에 한계선 긋기", "u":"Column_3D_TargetLine"},
				{"n":"축에 상하한선 긋기", "u":"Line_2D_TargetLine"},
				{"n":"축에 다수의 선 긋기", "u":"Axis_Multi_Line"},
				{"n":"축에 범위 넣기", "u":"Axis_Area"},
				{"n":"축에 다수의 범위 넣기", "u":"Axis_Multi_Area"},
				{"n":"축에 범위 + 선 긋기", "u":"Axis_Area_Line"},
				{"n":"참조할 축 지정하여<br> 범위,선 긋기", "u":"Aim_Axis_Area_Line"},
				{"n":"마우스 이동에 따른 십자가", "u":"CrossHair_MouseMove"},
				{"n":"차트 배경<br>(가로 라인)", "u":"Bg_Hori"},
				{"n":"차트 배경<br>(세로 라인)", "u":"Bg_Vertical"},
				{"n":"차트 배경<br>(가로 + 세로)", "u":"Bg_Hori_Vertical"},
				{"n":"배경에 이미지 삽입", "u":"Bg_Image"},
				{"n":"배경에 이미지 로고 삽입", "u":"Bg_Image_Logo"},
				{"n":"배경에 이미지+라인 삽입", "u":"Bg_Image_Line"},
				{"n":"차트 외형 CSS Style 적용", "u":"CSS_rMateChart"},
				{"n":"html 바탕에 투명차트 삽입", "u":"Bg_Html_Alpha_Chart"}
			]
		},{
			"n":"축 라벨 설정", "c":[
				{"n":"폰트 사이즈 변경하기", "u":"Change_FontSize"},
				{"n":"천단위로 컴마 구분자 넣기", "u":"Formatter_Number"},
				{"n":"통화단위 원 넣기", "u":"Formatter_Currency2"},
				{"n":"통화단위 달러 넣기", "u":"Formatter_Currency"},
				{"n":"날짜표시<br>(YYYY년 MM월 DD일)", "u":"Formatter_Date"},
				{"n":"날짜표시<br>(M월 D일 YY년)", "u":"Formatter_Date2"},
				{"n":"X축 라벨 사용자 정의", "u":"Label_Func_X"},
				{"n":"X축 라벨 사용자 정의<br>(스크롤 차트)", "u":"Label_Func_X_Scroll"},
				{"n":"Y축 라벨 사용자 정의", "u":"Label_Func_Y"},
				{"n":"X축 라벨 회전하여 출력<br>(숫자)", "u":"EmbededFont_XLabel"},
				{"n":"한글 세로로 출력", "u":"Label_Vertical_Hangeul"},
				{"n":"한글 기울여 출력", "u":"LabelField_Hangeul_Rotation"},
				{"n":"영문 세로로 출력", "u":"Label_Vertical_Eng"},
				{"n":"영문 기울여 출력", "u":"LabelField_Eng_Rotation"},
				{"n":"라벨 회전하여 출력", "u":"LabelField_Eng_Rotation_Label"}
				//{"n":"CategoryAxis사용시 <br>많아진 라벨의 처리", "u":"CategoryAxis_CanDropLabels"}
			]
		},{
			"n":"시리즈 수치표시", "c":[
				{"n":"컬럼 차트 외부에 수치표시", "u":"LabelField_Column_Outside"},
				{"n":"컬럼 차트 안쪽에 수치표시", "u":"LabelField_Column_Inside"},
				{"n":"컬럼 차트 수치표시<br>(상단/중단/하단)", "u":"LabelField_Both_Column"},
				{"n":"바 차트 외부에 수치표시", "u":"LabelField_Bar_Outside"},
				{"n":"바 차트 안쪽에 수치표시", "u":"LabelField_Bar_Inside"},
				{"n":"바 차트 수치표시<br>(왼쪽/가운데/오른쪽)", "u":"LabelField_Both_Bar"},
				//{"n":"바 차트 outside 여백주기", "u":"LabelField_Bar_Outside_Margin"},
				{"n":"라인 차트 상단에 수치표시", "u":"LabelField_Line_2D_Up"},
				{"n":"라인 차트 하단에 수치표시", "u":"LabelField_Line_2D_Down"},
				{"n":"영역 차트 상단에 수치표시", "u":"LabelField_Area_2D_Up"},
				{"n":"영역 차트 하단에 수치표시", "u":"LabelField_Area_2D_Down"},
				{"n":"파이차트에 표시", "u":"LabelField_Pie"},
				{"n":"파이차트 밖에 표시", "u":"LabelField_Pie_Callout"},
				{"n":"파이차트 내부/외부에 표시", "u":"LabelField_Pie_insideWithCallout"},
				{"n":"레이더 차트 수치표시", "u":"Radar_Label"},
				{"n":"수치 + underline", "u":"LabelField_Underline_Column"},
				{"n":"수치 필드 세로로 출력", "u":"LabelField_Rotation"},
				{"n":"수치 필드 사용자 정의", "u":"LabelField_Func_Column"},
				{"n":"수치 필드 사용자 정의<br>(파이계열)", "u":"LabelField_Func_Pie"}
			]
		},{
			"n":"시리즈 디자인", "c":[
				{"n":"컬럼 차트 단일 색상", "u":"Column_3D_Color_Fill"},
				{"n":"컬럼 차트 복수 색상", "u":"Column_3D_Color_Fills"},
				{"n":"컬럼 멀티 시리즈 컬러", "u":"Column_3D_Multi_Color"},
				{"n":"바 차트 단일 색상", "u":"Bar_2D_Color_Fill"},
				{"n":"라인 차트 컬러", "u":"Line_2D_Color_Fill"},
				{"n":"영역 차트 컬러", "u":"Area_2D_Color_Fill"},
				{"n":"레이더 차트 컬러", "u":"Radar_Color_Polygon"},
				{"n":"조건별 차트 색상 결정하기(Column)", "u":"Column_3D_Custom_Fill"},
				{"n":"조건별 차트 색상 결정하기(Bar)", "u":"Bar_3D_Custom_Fill"},
				{"n":"조건별 차트 색상 결정하기(Line)", "u":"Line_2D_Custom_Fill"},
				{"n":"조건별 차트 색상 결정하기(Area)", "u":"Area_2D_Custom_Fill"},
				{"n":"조건별 차트 색상 결정하기(Bubble)", "u":"Bubble_3D_Custom_Fill"},
				{"n":"조건별 차트 색상 결정하기<br>(파이계열)", "u":"Pie_2D_Custom_Fill"}
			]
		},{
			"n":"추세선 표시", "c":[
				{"n":"플롯 차트 선형 추세선", "u":"Trendline_Plot"},
				{"n":"라인 차트 이동평균선<br>추세선", "u":"Trendline_Line"},
				{"n":"영역 차트 다항식 추세선", "u":"Trendline_Area"},
				{"n":"컬럼 차트 거듭제곱 추세선", "u":"Trendline_Column"},
				{"n":"컬럼 차트 지수 추세선", "u":"Trendline_Column_Exponential"},
				{"n":"바 차트 로그 추세선", "u":"Trendline_Bar"}
				//{"n":"버블 차트 추세선", "u":"Trendline_Bubble"},
			]
		},{
			"n":"데이터팁(툴팁)", "c":[
				{"n":"데이터 팁 색상 채우기", "u":"DataTip_BackgroundColor"},
				{"n":"데이터 팁 축 기준", "u":"DataTip_DisplayMode"},
				{"n":"데이터 팁 마우스 기준", "u":"DataTip_DisplayMode2"},
				{"n":"데이터 팁 사용자 정의", "u":"DataTip_Func"},
				{"n":"데이터 팁 사용자 정의<br>(파이계열)", "u":"DataTip_Func2"}
			]
		},{
			"n":"이펙트", "c":[
				{"n":"SeriesInterpolate", "u":"Effect_SeriesInterpolate"},
				{"n":"SeriesInterpolate Reverse", "u":"Effect_SeriesInterpolate_Reverse"},
				{"n":"SeriesInterpolate Bounce", "u":"Effect_SeriesInterpolate_Bounce"},
				{"n":"SeriesZoom - Chart", "u":"Effect_SeriesZoom_Chart"},
				{"n":"SeriesZoom - Series", "u":"Effect_SeriesZoom_Series"},
				{"n":"SeriesSlide", "u":"Effect_SeriesSlide"},
				{"n":"SeriesSlide Hide Effect", "u":"Effect_SeriesSlide_HideEffect"},
				{"n":"SeriesZoom Hide Effect", "u":"Effect_SeriesZoom_HideEffect"},
				{"n":"SeriesClip", "u":"Effect_SeriesClip"}
			]
		},{
			"n":"범례", "c":[
				{"n":"하단", "u":"Legend_Bottom"},
				{"n":"오른쪽", "u":"Legend_Right"},
				//{"n":"상단", "u":"Legend_Top"},				
				//{"n":"왼쪽", "u":"Legend_Left"},
				{"n":"마우스 오버 시 액션", "u":"Legend_Top_Right"},
				{"n":"범례 해제하여 출력", "u":"Legend_Check_False"},
				{"n":"범례에 스크롤 생성하기", "u":"Legend_Over"},
				{"n":"SubLegend 선택/해제", "u":"Legend_Sub_CheckBox"}
			]
		},{
			"n":"제목/메모 추가", "c":[
				{"n":"제목넣기(부제목)", "u":"Subject_Mod"},
				{"n":"제목 CSS Style 적용", "u":"CSS_Exam"},
				{"n":"기본 메모", "u":"Memo_Basic"},
				{"n":"메모에 테두리 넣기", "u":"Memo_BorderColor"},
				{"n":"메모 폰트/컬러/크기 변경", "u":"Memo_Font_Color_Size"}
			]
		},{
			"n":"확대/축소", "c":[
				{"n":"라인차트 확대/축소<br>(y축 고정)", "u":"Zoom_Line_Fix"},
				{"n":"라인차트 확대/축소<br>(y축 가변)", "u":"Zoom_Line_Flexible"},
				{"n":"컬럼차트 확대/축소", "u":"Zoom_Column"},
				{"n":"바 차트 확대/축소", "u":"Zoom_Bar"},
				{"n":"Area차트 확대/축소", "u":"Zoom_Area"},
				{"n":"버블차트 확대/축소", "u":"Zoom_Bubble"},
				{"n":"Plot차트 확대/축소", "u":"Zoom_Plot"},
				{"n":"Combination 확대/축소", "u":"Zoom_Combination"}
				//{"n":"Real-Time 확대/축소", "u":"Zoom_Real_Time"}
			]
		},{
			"n":"이벤트", "c":[
				{"n":"오버 시 툴팁", "u":"Mouse_Tooltip"},
				{"n":"클릭 시 파이 차트 액션", "u":"Click_Pie_2D"},
				//{"n":"클릭 시 도넛 차트 3D 액션", "u":"Click_Doughnut_3D"},
				{"n":"클릭한 아이템 정보 보기", "u":"Click_Bar_3D"},
				{"n":"클릭 시 URL 이동", "u":"Click_Column_3D"},
				{"n":"클릭 시 다른 차트 생성", "u":"Click_Pie3D_CreateChart"},
				{"n":"차트 출력 완료 시 함수호출", "u":"ChartLoadComp_CallJavascript"},
				//{"n":"브라우저 크기에 리사이즈", "u":"Resize_Browser"},
				{"n":"클릭 시 드릴다운(Column)", "u":"Drilldown_ChartData_Column"},
				{"n":"클릭 시 드릴다운(Pie)", "u":"Drilldown_ChartData_Pie"}
			]
		},{
			"n":"데이터 에디터", "c":[
				{"n":"기본형", "u":"DataEditor_Basic"},
				{"n":"데이터 에디터 색상 변경", "u":"DataEditor_Color"},
				{"n":"Huge 데이터 에디터", "u":"DataEditor_HugeData"}
			]
		},{
			"n":"차트 이미지 변환", "c":[
				{"n":"로컬로 이미지 저장", "u":"GetImageLocalDownload"},
				{"n":"서버로 이미지 전송", "u":"GetImageSnapshot"}
			]
		},{
			"n":"대용량 데이터", "c":[
				{"n":"라인 차트<br>(데이터 3,000개)", "u":"HugeData_Line"},
				{"n":"플롯 차트<br>(데이터 3,000개)", "u":"HugeData_Plot"},
				{"n":"스크롤 차트<br>(데이터 1,000개)", "u":"HugeData_Column"}
			]
		},{
			"n":"여러차트 사용", "c":[
				{"n":"각각 다른 차트와 데이터", "u":"Dual_Chart"},
				{"n":"같은 차트, 다른 데이터", "u":"Dual_Chart2"}
			]
		},{
			"n":"테마", "c":[
				{"n":"테마 적용하여 차트 생성", "u":"ApplyTheme_Chart"}
			]
		},{
			"n":"시각 장애인을 위한 패턴적용", "c":[
				{"n":"라인 차트 패턴", "u":"Pattern_Line_2D"},
				{"n":"컬럼 차트 패턴", "u":"Pattern_Column_2D"},
				{"n":"영역 차트 패턴", "u":"Pattern_Area_2D"},
				{"n":"파이 차트 패턴", "u":"Pattern_Pie_2D"},
				{"n":"게이지 차트 패턴", "u":"Pattern_Gauge"},
				{"n":"수치값에 따라 패턴 적용", "u":"Pattern_Custom"}
			]
		},{
			"n":"기타 기능", "c":[
				{"n":"버튼 클릭 으로 리사이즈", "u":"Resize_UserEvent"},
				{"n":"로딩바 보이기, 감추기", "u":"ShowAndHidePreloader"},
				{"n":"데이터가 없을경우", "u":"No_Data_Func"},
				{"n":"차트 데이터 CSV 저장", "u":"SaveData_CSV"}
			]
		}
	],

	// 홈 화면 이미지 경로
	images = [{
			"n":"Line Chart", "u":"line"
		},{
			"n":"Column Chart", "u":"column"
		},{
			"n":"Area Chart", "u":"area"
		},{
			"n":"Pie Chart", "u":"pie"
		},{
			"n":"Bubble Chart", "u":"bubble"
		},{
			"n":"Plot Chart", "u":"plot"
		},{
			"n":"Target vs Actual", "u":"target"
		},{
			"n":"History Chart", "u":"history"
		},{
			"n":"Broken-Axis Chart", "u":"broken"
		},{
			"n":"Image Chart", "u":"image"
		},{
			"n":"Candlestick Chart", "u":"candle"
		},{
			"n":"Gague Chart", "u":"gauge"
		},{
			"n":"TreeMap Chart", "u":"treemap"
		},{
			"n":"WordCloud Chart", "u":"wordcloud"
		},{
			"n":"Vector Chart", "u":"vector"
		},{
			"n":"Motion Chart", "u":"motion"
		}
],

tutorialContent = [{
		"index":0,"content":'<pre><font color="#0000ff">&#60;!doctype html&#62;<br>&#60;html&#62;<br>&#60;head&#62;</font><br>'
		+'<font color="#0000ff">&#60;meta <font color="#ff0000">http-equiv="Content-Type" content="text/html; charset=utf-8</font>/&#62;</font><br>'
		+'<font color="#0000ff">&#60;meta <font color="#ff0000">http-equiv="Content-Script-Type" content="text/javascript"</font>/&#62;</font><br>'
		+'<font color="#0000ff">&#60;meta <font color="#ff0000">http-equiv="Content-Style-Type" content="text/css"</font>/&#62;</font><br>'
		+'<font color="#0000ff">&#60;meta <font color="#ff0000">http-equiv="X-UA-Compatible" content="IE=edge"</font>/&#62;</font></pre>', "className":"active_tutorial_child"
	},{
		"index":1,"content":'<pre>'
		+'<font color="#4BBF5A">&#60;!-- IE7, 8 에서 차트 생성하고자 하는 경우 --&#62;<br>'
		+'&#60;!--[if IE]&#62;<br>'
		+'<font color="#0000ff">&#60;script <font color="#ff0000">language="javascript" type="text/javascript" src="../rMateChartH5/JS/excanvas.js"</font>&#62;&#60;/script></font><br>'
		+'&#60;![endif]--&#62;</font><br><br>'
		+'<font color="#4BBF5A">&#60;!-- rMateChartH5 라이센스 --&#62;</font><br>'		
		+'<font color="#0000ff">&#60;script <font color="#ff0000">language="javascript" type="text/javascript" src="../LicenseKey/rMateChartH5License.js"</font>&#62;&#60;/script&#62;</font><br><br>'
		+'<font color="#4BBF5A">&#60;!-- 실제적인 rMateChartH5 라이브러리 --&#62;</font><br>'
		+'<font color="#0000ff">&#60;script <font color="#ff0000">language="javascript" type="text/javascript" src="../rMateChartH5/JS/rMateChartH5.js"</font>&#62;&#60;/script&#62;</font><br><br>'
		+'<font color="#4BBF5A">&#60;!-- rMateChartH5 에서 사용하는 스타일 --&#62;</font><br>'
		+'<font color="#0000ff">&#60;link <font color="#ff0000">rel="stylesheet" type="text/css" href="../rMateChartH5/Assets/Css/rMateChartH5.css"</font>/&#62;<br>'
		+'</pre>'
		,"className":"none_tutorial_child","displayList":true,"displayIndex":0
		,"displayBtn":"차트 생성시 필요한 js파일을 불러옵니다.<br> IE7,8 에서 생성해야할 경우 excanvs도 함께 불러옵니다."
	},{
		"index":2,"content":'<pre><font color="#0000ff">&#60;script <font color="#ff0000">type="text/javascript"</font>></font><br>'
		+'<font color="#4BBF5A">// rMate 차트 생성 준비가 완료된 상태 시 호출할 함수를 지정합니다.</font><br>'
		+'<font color="#0000ff">var <font color="#792929">chartVars = "rMateOnLoadCallFunction=chartReadyHandler";</font><br><br>'
		+'<font color="#4BBF5A">// rMateChart 를 생성합니다.<br>'
		+'// 파라메터 (순서대로) <br>'
		+'//  1. 차트의 id ( 임의로 지정하십시오. ) <br>'
		+'//  2. 차트가 위치할 div 의 id (즉, 차트의 부모 div 의 id 입니다.)<br>'
		+'//  3. 차트 생성 시 필요한 환경 변수들의 묶음인 chartVars<br>'
		+'//  4. 차트의 가로 사이즈 (생략 가능, 생략 시 100%)<br>'
		+'//  5. 차트의 세로 사이즈 (생략 가능, 생략 시 100%)</font><br>'
		+'<font color="#792929">rMateChartH5.create("chart1", "chartHolder", chartVars, "100%", "100%"); </font><br><br>'
		+'<font color="#4BBF5A">// 차트의 속성인 rMateOnLoadCallFunction 으로 설정된 함수.<br>'
		+'// rMate 차트 준비가 완료된 경우 이 함수가 호출됩니다.<br>'
		+'// 이 함수를 통해 차트에 레이아웃과 데이터를 삽입합니다.<br>'
		+'// 파라메터 : id - rMateChartH5.create() 사용 시 사용자가 지정한 id 입니다.</font><br>'
		+'function <font color="#792929">chartReadyHandler(id) {<br>'
		+'	document.getElementById(id).setLayout(layoutStr);<br>'
		+'	document.getElementById(id).setData(chartData);<br>'
		+'}</font></font><br><br>'
		+'</pre>'
		,"className":"none_tutorial_child","displayList":true,"displayIndex":2
		,"displayBtn":"차트를 생성하는 스크립트를 작성 합니다.<br>"
						+"주석처리된 부분을 읽어 보시기 바랍니다."
	},{
		"index":3,"content":'<pre>'
		+'<font color="#4BBF5A">// 스트링 형식으로 레이아웃 정의.</font><br>'
		+'<font color="#0000ff">var</font> <font color="#792929">layoutStr = &#39;&#60;rMateChart backgroundColor="0xFFFFFF" cornerRadius="12" borderThickness="1" borderStyle="none">&#39;<br>'
		+'			+&#39;&#60;Options>+&#39;<br>'
		+'				+&#39;&#60;Caption text="RainFall"/>&#39;<br>'
		+'				+&#39;&#60;SubCaption text="( mm )" textAlign="right"/>&#39;<br>'
		+'			+&#39;&#60;/Options>&#39;<br>'
		+'			+&#39;&#60;NumberFormatter id="numFmt" precision="0"/>&#39;<br>'
		+'			+&#39;&#60;Line2DChart showDataTips="true" dataTipDisplayMode="axis">&#39;<br>'
		+'				+&#39;&#60;horizontalAxis>&#39;<br>'
		+'					+&#39;&#60;CategoryAxis categoryField="Month"/>&#39; <br>'
		+'				+&#39;&#60;/horizontalAxis>&#39;<br>'
		+'				+&#39;&#60;verticalAxis>&#39;<br>'
		+'					+&#39;&#60;LinearAxis minimum="70" maximum="100" interval="5"/>&#39;<br>'
		+'				+&#39;&#60;/verticalAxis>&#39;<br>'
		+'				+&#39;&#60;series>&#39;<br>'
		+'					+&#39;&#60;Line2DSeries yField="Vancouver" displayName="Vancouver">&#39;<br>'
		+'					+&#39;&#60;/Line2DSeries>&#39;<br>'
		+'				+&#39;&#60;/series>&#39;<br>'
		+'				+&#39;&#60;annotationElements>&#39;<br>'
		+'					+&#39;&#60;CrossRangeZoomer backgroundColor="0xeb494a" borderColor="0xeb494a" enableZooming="false" horizontalLabelFormatter="{numFmt}" horizontalStrokeEnable="false">&#39;<br>'
		+'						+&#39;&#60;verticalStroke>&#39;<br>'
		+'							+&#39;&#60;Stroke color="0xeb494a" />&#39;<br>'
		+'						+&#39;&#60;/verticalStroke>&#39;<br>'
		+'					+&#39;&#60;/CrossRangeZoomer>&#39;<br>'
		+'				+&#39;&#60;/annotationElements>&#39;<br>'
		+'			+&#39;&#60;/Line2DChart>&#39;<br>'
		+'		+&#39;&#60;/rMateChart>&#39;;</font><br><br>'
		+'</pre>'
		,"className":"none_tutorial_child","displayList":true,"displayIndex":3
		,"displayBtn":"차트의 외형인 레이아웃을 용도에 맞게 설정합니다."
	},{
		"index":4,"content":'<pre>'
		+'<font color="#4BBF5A">// 차트 데이터<br></font>'
		+'<font color="#0000ff">var</font> <font color="#792929">chartData = [{"Month":"Jan", "Vancouver":80},<br>'
		+'		{"Month":"Feb", "Vancouver":90},<br>'
		+'		{"Month":"Mar", "Vancouver":83},<br>'
		+'		{"Month":"Apr", "Vancouver":81},<br>'
		+'		{"Month":"May", "Vancouver":87},<br>'
		+'		{"Month":"Jun", "Vancouver":89},<br>'
		+'		{"Month":"Jul", "Vancouver":86},<br>'
		+'		{"Month":"Aug", "Vancouver":92},<br>'
		+'		{"Month":"Sep", "Vancouver":88},<br>'
		+'		{"Month":"Oct", "Vancouver":84},<br>'
		+'		{"Month":"Nov", "Vancouver":87},<br>'
		+'		{"Month":"Dec", "Vancouver":90}];</font><br><br>'
		+'</pre>'
		,"className":"none_tutorial_child","displayList":true,"displayIndex":4
		,"displayBtn":"차트에서 사용하게 될 데이터를 설정합니다."
	},{
		"index":5,"content":'<pre><font color="#0000ff">&#60/script></font><br><br></pre>',"className":"none_tutorial_child","displayList":true,"displayIndex":2
	},{
		"index":6,"content":"<pre><font color='#0000ff'>&#60;/head&#62;<br>&#60;body&#62;</font></pre>","className":"active_tutorial_child"
	},{
		"index":7,"content":'<pre>'
		+'	<font color="#0000ff">&#60;div <font color="#ff0000">id="content"</font>><br>'
		+'		<font color="#4BBF5A">&#60;!-- 차트가 삽입될 DIV --></font><br>'
		+'		&#60;div <font color="#ff0000">id="chartHolder" style="width:600px; height:400px;"</font>><br>'
		+'		&#60;/div><br>'
		+'	&#60;/div></font><br><br>'
		+'</pre>'
		,"className":"none_tutorial_child","displayList":true,"displayIndex":1
		,"displayBtn":"차트가 보여질 영역을 설정합니다.<br>id 와 크기를 지정합니다."
	},{
		"index":8,"content":'<pre>'
		+'<font color="#0000ff">&#60;/body><br>'
		+'&#60;/html></font>'
		+'</pre>'
		,"className":"active_tutorial_child"
	},{
		"index":9,"content":''
		,"className":"none_tutorial_child","displayList":true,"displayIndex":5
		,"displayBtn":""
	}
],

/*
	properties이외에 추가로 테마 적용하지 않을 목록들
	n : 이름	c : 자식(서브메뉴)	u : URL	
	t : 보여주지 않을 테마
		-1 : 모두
		0(오른쪽) ~ 6(왼쪽)
*/

none_theme = [{
	// Column
		"n":"Column", "c":[
			{"n":"Cylinder 3D", "u":"Cylinder_3D","t":[0]},
			{"n":"Cylinder Multi Series 3D", "u":"Cylinder_3D_MS","t":[0]},
			{"n":"Cylinder Stacked 3D", "u":"Cylinder_3D_Stacked","t":[0]}
		]
	},{
	// Bar
		"n":"Bar", "c":[
			{"n":"Cylinder Bar 3D", "u":"Cylinder_Bar_3D","t":[0]},
			{"n":"Cylinder Bar Stacked 3D", "u":"Cylinder_Bar_3D_Stacked","t":[0]}
		]
	},{
	// Bubble
		"n":"Bubble", "c":[
			{"n":"Bubble Transparency", "u":"Bubble_3D_Transparency","t":[-1]}
		]
	},{
	// From-to
		"n":"From - To", "c":[
			{"n":"WaterFall", "u":"From_To_Column_2D","t":[-1]}
		]
	},{
	// RealTime-Premium
		"n":"RealTime-Premium", "c":[
			{"n":"다른 주기의 <br>실시간 데이터 표현", "u":"RealTime_Premium_Line_Column","t":[-1]},
			{"n":"전일과 금일의 <br>실시간 비교", "u":"RealTime_Premium_10Int","t":[-1]},
			{"n":"서로 다른 주기의 <br>실시간 통합 비교", "u":"RealTime_Premium_25Base","t":[-1]}
		]
	},{
	// Slide
		"n":"Slide", "c":[
			{"n":"기본 슬라이드", "u":"Slide_Sample","t":[-1]},
			{"n":"효과를 추가한 슬라이드", "u":"Slide_Sample2","t":[-1]}
		]
	},{
	// Gauge
		"n":"Gauge", "c":[
			{"n":"Circular Orange", "u":"Gauge_Circular_Orange","t":[-1]},
			{"n":"Circular Rainbow", "u":"Gauge_Circular_Rainbow","t":[-1]},
			{"n":"Circular Gradient", "u":"Gauge_Circular_Gradient","t":[-1]},
			{"n":"Circular Dual", "u":"Gauge_Circular_Dual","t":[-1]},
			{"n":"Half-Circular Rainbow1", "u":"Gauge_Half_Rainbow1","t":[-1]},
			{"n":"Half-Circular Rainbow2", "u":"Gauge_Half_Rainbow2","t":[-1]},
			{"n":"Half-Circular Notice", "u":"Gauge_Half_Notice","t":[-1]},
			{"n":"Half-Circular Gradient", "u":"Gauge_Half_Gradient","t":[-1]},
			{"n":"Horizontal Cylinder Gauge", "u":"Gauge_HorizontalCylinder","t":[-1]},
			{"n":"Vertical Cylinder Gauge", "u":"Gauge_VerticalCylinder","t":[-1]},
			{"n":"Horizontal Linear Gauge", "u":"Gauge_HorizontalLinear","t":[-1]},
			{"n":"Vertical Linear Gauge", "u":"Gauge_VerticalLinear","t":[-1]}
		]
	},{
	// Candlestick
		"n":"Candlestick", "c":[
			{"n":"Candlestick Chart", "u":"Candlestick_Normal","t":[-1]},
			{"n":"Candlestick Chart Reverse", "u":"Candlestick_Reverse","t":[-1]},
			{"n":"Candlestick Symbol", "u":"Candlestick_Symbol","t":[-1]},
			{"n":"Candlestick Symbol Another", "u":"Candlestick_Symol_Another","t":[-1]}
		]
	},{
		// Image
		"n":"Image", "c":[
			{"n":"정배율-단일이미지(1)", "u":"Image_Single_Ratio","t":[-1]},
			{"n":"정배율-단일이미지(2)", "u":"Image_Single_MS_Ratio","t":[-1]},
			{"n":"차등배율-단일이미지(1)", "u":"Image_Single_FRatio","t":[-1]},
			{"n":"차등배율-단일이미지(2)", "u":"Image_Single_FRatio2","t":[-1]},
			{"n":"정배율-반복이미지(1)", "u":"Image_SingleRepeat","t":[-1]},
			{"n":"정배율-반복이미지(2)", "u":"Image_SingleRepeat2","t":[-1]},
			{"n":"차등배율-복수이미지(1)", "u":"Image_Multiple","t":[-1]},
			{"n":"차등배율-복수이미지(2)", "u":"Image_Multiple2","t":[-1]}
		]
	},{
		// TreeMap
		"n":"TreeMap", "c":[
			{"n":"TreeMap Range", "u":"TreeMap_Range", "t":[-1]}
		]
	},{
		// Histogram
		"n":"Histogram", "c":[
			{"n":"성적 Histogram 2D", "u":"Histogram_2D_Grade", "t":[-1]},
			{"n":"개인 키 Histogram 3D", "u":"Histogram_3D_Height", "t":[-1]}
		]
	},{
		// Vector
		"n":"Vector", "c":[
			{"n":"Vector Level", "u":"Vector_2D_Level", "t":[-1]}
		]
	},{
		// Error
		"n":"ErrorBar", "c":[
			{"n":"Column ErrorBar", "u":"Error_Column"},
			{"n":"Line ErrorBar", "u":"Error_Line"},
			{"n":"Area ErrorBar", "u":"Error_Area"},
			{"n":"Bar ErrorBar", "u":"Error_Bar"},
			//{"n":"Bubble ErrorBar", "u":"Error_Bubble"},
			{"n":"Plot ErrorBar", "u":"Error_Plot"}
		]
	},{
		// BoxPlot
		"n":"BoxPlot", "c":[
			{"n":"BoxPlot", "u":"BoxPlot"},
			{"n":"BoxPlot Multi", "u":"BoxPlot_Multi"}
		]
	},{
		// Motion
		"n":"Motion", "c":[
			{"n":"Bubble Motion", "u":"Motion_Bubble"},
			{"n":"Bubble Motion Trails", "u":"Motion_Bubble_Trails"},
			{"n":"Bubble Motion Multi", "u":"Motion_Bubble_Multi"},
			{"n":"Column Motion", "u":"Motion_Column"},
			{"n":"Column Motion Trails", "u":"Motion_Column_Trails"},
			{"n":"Column Motion Multi", "u":"Motion_Column_Multi"},
			{"n":"Line Motion", "u":"Motion_Line"}
		]
	}
];