$(document).ready(function(){
	/* 네비게이션 */
	/*$(".gnb > li > a, .sub_gnb").mouseover(function(){
		$(".sub_gnb").stop().slideDown();
	}).mouseout(function(){
		$(".sub_gnb").stop().slideUp();
	});*/
	
	$(".gnb").on({
		'mouseenter' : function(){
			if($(".sub_gnb").css("display") == "none"){
				$(".sub_gnb").slideDown();
			}
		}, 
		'mouseleave' : function(){
			$(".sub_gnb").slideUp();
		}
	});
	
	/* 모바일 네비게이션 */
	$(".mb_naviBar button").click(function(){
		$(".mb_nav").fadeIn();
		return false;
	});
	$(".btn_close").click(function(){
		$(".mb_nav").fadeOut();
		return false;
	});
	
	
	/*$(".mb_gnb li a").click(function(){
		$(".mb_gnb li").removeClass("on");
		$(".mb_sub_gnb").removeClass("on");
		$(this).parent().addClass("on");
		$(this).next().addClass("on");
	});*/
	
	$(".mb_gnb > li > a").click(function(){
		if( $(this).next().css("display") == "none" ){
			$(".mb_gnb > li").removeClass("on");
			$(".mb_sub_gnb").slideUp();
			$(this).parent().addClass("on");
			$(this).next().slideDown();
		}else{
			$(this).parent().removeClass("on");
			$(this).next().slideUp();
		}
	});
	/*$(".mb_sub_gnb .tab a").on({
		'mouseenter' : function(){
			if($(".mb_sub_gnb_sub").css("display") == "none"){
				$(".mb_sub_gnb_sub").slideDown();
			}
		}, 
		'mouseleave' : function(){
			$(".mb_sub_gnb_sub").slideUp();
		}
	});*/
	$(".mb_sub_gnb .tab a").click(function(){
		if( $(this).next().css("display") == "none" ){
			$(".mb_sub_gnb_sub").slideUp();
			$(this).next().slideDown();
		}else{
			$(this).next().slideUp();
		}
	});


	/* visual  */
	$(".ms_over").mouseover(function(){
		var width = $(window).width();
		if ( width > 1156 ){
			$(this).stop().animate({"top":"0"}, 600);
			$(this).children().children().children().stop().animate({"marginTop":"75px"}, 600);
		}
	}).mouseout(function(){
		var width = $(window).width();
		if ( width > 1156 ){
			$(this).stop().animate({"top":"308px"}, 600);
			$(this).children().children().children().stop().animate({"marginTop":"0"}, 600);
		}
	});
	/* 경매날짜선택 경매기록부탭변경  */
	$(".dt li a, .tab_dt a, .ct_gnb > li > a").click(function(){
		$(this).parent().siblings().removeClass("on");
		$(this).parent().addClass("on");
		return false;
	});
	/*경매날짜선택 탭변경*/
	/*$(".dt > li > a").click(function(){
		//console.log($(this).parent().attr('class'));
		var str = $(this).parent().attr('class');
		str = str.substring(2,4);
		$(".dd > li").addClass("hide");
		$(".dd"+str).removeClass("hide");
		return false;
	});*/

	/* 서브탭 변경  -경매기록부 */
	$(".tab_dt > a").click(function(){
		//console.log($(this).parent().attr('class'));
		var str = $(this).parent().attr('class');
		str = str.substring(2,4);
		$(this).parent().siblings(".tab_dd").addClass("hide");
		$(this).parent().siblings(".dd"+str).removeClass("hide");
		return false;
	});
	/*$(".ct_gnb > li > a, .flowerTab > li > a").click(function(){
		var str = $(this).parent().attr("class");
		str = str.substring(2,4);
		$(this).parent().parent().siblings(".section").addClass("hide");
		$(this).parent().parent().siblings(".content"+str).removeClass("hide");
	});*/

	$(".flowerTab li a, .tab_btn01 a").click(function(){
		$(this).parent().siblings().removeClass("on");
		$(this).parent().addClass("on");
		return false;
	});

	$(".btn01").click(function(){
		$(this).siblings().removeClass("on");
		$(this).addClass("on");
		return false;
	});

	$(".flowerTab li a").click(function(){
		var str = $(this).parent().attr("class");
		str = str.substring(2,4);

		$(this).parent().siblings().each(function(){
			var imgSrc = $(this).children().children().attr("src");
			if(imgSrc.lastIndexOf("_on") !=-1){
				$(this).children().children().attr({"src":imgSrc.substring(0,imgSrc.lastIndexOf("_on"))+"_off.png"});
			}	
		});

		if ( $(this).parent().attr("class").indexOf("on") != -1 )
		{ $(this).children().attr({"src": "../images/content/flowerTab"+str+"_on.png"});
		}else{
			$(this).children().attr({"src":"../images/content/flowerTab"+str+"_off.png"});
		}
	});
	$(".flowerTab li a").mouseover(function(){
		var str = $(this).parent().attr("class");
		str = str.substring(2,4);
			$(this).children().attr({"src": "../images/content/flowerTab"+str+"_on.png"});
	}).mouseout(function(){
		var str = $(this).parent().attr("class");
		str = str.substring(2,4);
		if ( $(this).parent().attr("class").indexOf("on") !=-1 )
		{ 
			$(this).children().attr({"src":"../images/content/flowerTab"+str+"_on.png"});
		}else{
			$(this).children().attr({"src": "../images/content/flowerTab"+str+"_off.png"});
		}
	});
/*
	 체크박스  
	$(".checkWrap .check").click(function(){
		alert( $(this).attr("checked"));
		if( $(this).prop("checked") == "true" ){
			$(this).parent().addClass("checked");
		}else{
			$(this).parent().removeClass("checked");
		}
		if( $(this).is(":checked") ){
			$(this).parent().addClass("checked");
		}else{
			$(this).parent().removeClass("checked");
		}
	});
	$("#allSelect").change(function(){
		$("input[name='subSelect']").prop("checked",$(this).prop("checked"));
		if($(this).prop("checked")==true){
			$("input[name='subSelect']").parent().addClass("checked");
		}else{
			$("input[name='subSelect']").parent().removeClass("checked");
		}
	});
	$("input[name='subSelect']").change(function(){
		if($("input[name='subSelect']:checked").length < $("input[name='subSelect']").length){
			$("#allSelect").prop("checked", false);
			$("#allSelect").parent().removeClass("checked");
		}else{
			$("#allSelect").prop("checked", true);
			$("#allSelect").parent().addClass("checked");
		}
	});*/
	/* 체크박스  */
	$(".checkWrap .check, .checkWrap02 .check").click(function(){
		/*alert( $(this).attr("checked"));*/
		/*if( $(this).prop("checked") == "true" ){
			$(this).parent().addClass("checked");
		}else{
			$(this).parent().removeClass("checked");
		}*/
		if( $(this).is(":checked") ){
			$(this).parent().addClass("checked");
		}else{
			$(this).parent().removeClass("checked");
		}
		
	});
	/* 라디오 */
	$(".radio").click(function(){
		$(".radio").parent().removeClass("checked");
		$(this).parent().addClass("checked");
	});
	$("#allSelect").change(function(){
		$("input[name='subSelect']").prop("checked",$(this).prop("checked"));
		if($(this).prop("checked")==true){
			$("input[name='subSelect']").parent().addClass("checked");
		}else{
			$("input[name='subSelect']").parent().removeClass("checked");
		}
	});
	/* 상황실 */
	$(".tabNav li a").click(function(){
		$(".tabNav li").removeClass("on");
		$(this).parent().addClass("on");
	});

	$(".tabNav .li01 a").click(function(){
		$("#st_content02").removeClass("on");
		$("#st_content01").addClass("on");
	});
	$(".tabNav .li02 a").click(function(){
		$("#st_content01").removeClass("on");
		$("#st_content02").addClass("on");
	});
	
	/*상황판 */
	$(".tabNav2 li a").click(function(){
		$(".tabNav2 li").removeClass("on");
		$(this).parent().addClass("on");
	});

	$(".tabNav2 .li01 a").click(function(){
		$(".situation2").removeClass("on");
		$("#st_content01").addClass("on");
	});
	$(".tabNav2 .li02 a").click(function(){
		$(".situation2").removeClass("on");
		$("#st_content02").addClass("on");
	});
	$(".tabNav2 .li03 a").click(function(){
		$(".situation2").removeClass("on");
		$("#st_content03").addClass("on");
	});
	$(".tabNav2 .li04 a").click(function(){
		$(".situation2").removeClass("on");
		$("#st_content04").addClass("on");
	});
	$(".tabNav2 .li05 a").click(function(){
		$(".situation2").removeClass("on");
		$("#st_content05").addClass("on");
	});
	
		
	var setstHeightSize = function () {
		var stwrap2Height = $("#wrap3").height();
		var wrap2hdHt = $("#wrap3 #header").innerHeight();
		
		var situation2Height = $(".situation2").height();
		var situation2titHeight = $(".situation2 .tit").innerHeight();
				
		$("#wrap3 article").height(stwrap2Height - wrap2hdHt);
		$(".graphWrap100").height(situation2Height - situation2titHeight);
	}
	
	setstHeightSize();
	
	$(window).resize(function () {
		setstHeightSize();
	});
	
});

/* Layer popup */
function fnShowLayer(objName, wid) {

	var str = '<div id="lp_dim"></div>';
	var layerTop = $(document).scrollTop();
	var layerObj = $(".lp_wrap "+objName);
	layerObj.attr('tabindex', 0).focus();
	
	$("#wrap").append(str);
	$("#lp_dim").stop().fadeIn("fast");
	$("html, body").addClass("nyScroll");
	
	layerObj.show().parent().stop().fadeIn("fast");
	layerObj.focus();
	
	var rh = realHeight($(".lp_wrap "+objName));
	
	//console.log("realHeight",rh);
	
	var rePosition = function(){
		if(parseInt(rh)<$(window).height()) {
			layerObj.css({
				top: (($(window).height()/2) - (rh/2) ) +"px"
			});
		}
		//console.log($(window).height());
	}
	rePosition();
	
	$(layerObj).find(".lp_close").off("click").on("click",function(e){
		e.preventDefault();
		hideLayer(layerTop,$(this));
	});
	
	$(window).resize(function(){
		rePosition();
	});
	//e.preventDefault();
}
function hideLayer(pos, closeObj){
	var layerObj = $(closeObj).closest('.lp_container');
	
	$("#lp_dim").stop().fadeOut("fast", 0, function() {$(this).remove();});
	$(".lp_wrap").scrollTop(0);
	$("html, body").removeClass("nyScroll");
	$(".lp_wrap").hide();
	
	$(layerObj).hide();
}

function realHeight(obj){
	var clone = obj.clone();
	$('body').append(clone);
	var height = clone.outerHeight();
	clone.remove();
	return height;
}

/* select */ 
var fnSelect = function(){
	var selectTarget = $('.selectbox select');

	selectTarget.each(function(){
		$(this).change(function(){
			var select_name = $(this).children('option:selected').text();
			$(this).siblings('label').text(select_name);
		});
		
		if($(this).is(":disabled")) {
			$(this).closest(".selectbox").addClass("disabled");
		};
	})

	selectTarget.each(function(){
		var $table = $(this).parent();
		$table.css({ position: "absolute", visibility: "hidden", display: "block" });
		var select_name = $(this).children('option:selected').text();

		$table.css({ position: "", visibility: "", display: "" });
		$(this).find("option").each(function (n) {
			$(this).closest(".selectbox").find("label").text(select_name);
			if($(this).is(':selected') && n){
				$(this).closest(".selectbox").find("label").text($(this).text()).css({"color":"#212121"});
			}
		});
	});
}

// 20171106 김민주 Chart 호출 오류 처리
function rMateChartLoding(id, handlerName){
	if (document.getElementById(id) 
			&& document.getElementById(id).hasOwnProperty("setLayout") ) { 
		eval(handlerName+"('"+id+"')");
	}else{
		var inter = setInterval(function(){   
			if (document.getElementById(id) 
					&& document.getElementById(id).hasOwnProperty("setLayout") ) { 
				// 차트 생성 확인되면 차트 데이트 입력 및 인터발 종료
				eval(handlerName+"('"+id+"')");
				clearInterval(inter);
			}
		}, 500);
	}
}


$(window).load(function(){
	fnSelect();/* 셀렉트 */
});
/* //select */