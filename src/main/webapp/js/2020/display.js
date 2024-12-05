$(document).ready(function(){
	
	/* 네비게이션 */
	$(".gnb > li, .sub_gnb, .bg_subgnb ").mouseenter(function(){
		$(".sub_gnb, .bg_subgnb ").stop(true,false).slideDown();
	}).mouseleave(function(){
		$(".sub_gnb, .bg_subgnb ").stop(true,false).slideUp();
	});
	
	var bg_gnb = $(".gnb .li01 .sub_gnb").innerHeight();
	var sub_gnbH = $(".gnb .li01 .sub_gnb").height();
	$(".bg_subgnb").height(bg_gnb);
	$(".sub_gnb").height(sub_gnbH);

	/* 모바일 네비게이션 */
	var mb_navH = $("#wrap").height();
	//$(".mb_nav").height(mb_navH);

	$(".mb_naviBar a ").click(function(){
		$(".mb_nav").fadeIn();
		return false;
	});
	$(".btn_close").click(function(){
		$(".mb_nav").fadeOut();
		return false;
	});
	$(".mb_gnb li a").click(function(){
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

	/* 메인배너 */
		var noticeSlider = function () {
			var notice = $('.noticeWrap');
			var upControl = notice.find('.notice-up-contorl');
			var ul = notice.children('ul');
			var li = ul.children('li');
			
			upControl.show();
			ul.show();
			notice.attr('data-status', 'play');
			$('.notice-location').find('li:first').addClass('view');

			setInterval(function () {
				var status = notice.attr('data-status');
				if (status == 'play') {
					var c = ul.find('li:visible');
					var n = c.next();
					
					if (n.length == 0) {
						n = ul.find('li:first');
					}
					
					c.hide();
					n.show();
					$('.notice-location').find('li').removeClass('view');
					$('.notice-location').find('li:eq('+n.index()+')').addClass('view');
				}
			},4000);
			
			li.find('.detail-btn').each(function () {
				$(this).click(function () {
					location.href=$(this).attr('data-url');	
				});
			});
			
			upControl.find('.left').click(function () {
				upControl.find('.control').removeClass('play');
				notice.attr('data-status', 'pause');
				
				var c = ul.find('li:visible');
				var n = c.prev();
				
				if (n.length == 0) {
					n = ul.find('li:last');
				}
				
				c.hide();
				n.show();
				$('.notice-location').find('li').removeClass('view');
				$('.notice-location').find('li:eq('+n.index()+')').addClass('view');
			});
			
			upControl.find('.right').click(function () {
				upControl.find('.control').removeClass('play');
				notice.attr('data-status', 'pause');
				
				var c = ul.find('li:visible');
				var n = c.next();
				
				if (n.length == 0) {
					n = ul.find('li:first');
				}
				
				c.hide();
				n.show();
				$('.notice-location').find('li').removeClass('view');
				$('.notice-location').find('li:eq('+n.index()+')').addClass('view');
			});
			
			upControl.find('.control').click(function () {
				var _this = $(this);
				if (_this.hasClass('play')) {
					_this.removeClass('play');
					notice.attr('data-status', 'pause');
				} else {
					_this.removeClass('play').addClass('play');
					notice.attr('data-status', 'play');
				}
			});
		}
		
		noticeSlider();

		/* 서브 상단 탭 변경 */
		$(".tit_tabList li a").click(function(){
			$(this).parents(".tit_tabList").children("li").removeClass("on");
			$(this).parent().addClass("on");
		});
		/* 탭변경 */
		$(".js_tabBtn01 a").click(function(){
			$(".js_tabCt").addClass("hide");
			$(".js_tabCt.js_ct01").removeClass("hide");
			return false;
		});
		$(".js_tabBtn02 a").click(function(){
			$(".js_tabCt").addClass("hide");
			$(".js_tabCt.js_ct02").removeClass("hide");
			return false;
		});
		
		/* 추가 [200205] */
		
		/* 경매날짜선택 경매기록부탭변경  */
		$(".dt li a, .tab_dt a, .ct_gnb > li > a").click(function(){
			$(this).parent().siblings().removeClass("on s_on");
			$(this).parent().addClass("on s_on");
			return false;
		});

		/* 서브탭 변경  -경매기록부 */
		$(".tab_dt > a").click(function(){
			//console.log($(this).parent().attr('class'));
			var str = $(this).parent().attr('class');
			str = str.substring(2,4);
			
			$(this).parent().parent().parent().find('.graph_boxsing_b').addClass("hide");
			$(this).parent().parent().parent().find(".dd"+str).removeClass("hide");
			
			//$(this).parent().siblings(".tab_dd").addClass("hide");
			//$(this).parent().siblings(".dd"+str).removeClass("hide");
			return false;
		});

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
		
		/* 품목결락가격 버튼 스위칭 20.02.24 */
		$(".list_bt").click(function(){
			$(this).siblings().removeClass("time_on");
			$(this).addClass("time_on");
			return false;
		});

		$(".flowerTab li a").click(function(){
			/*var str = $(this).parent().attr("class");
			str = str.substring(5,7);

			$(this).parent().siblings().each(function(){
				var imgSrc = $(this).children().children().attr("src");
				if(imgSrc.lastIndexOf("_on") !=-1){
					$(this).children().children().attr({"src":imgSrc.substring(0,imgSrc.lastIndexOf("_on"))+"_off.png"});
				}	
			});

			if ( $(this).parent().attr("class").indexOf("on") != -1 ){ 
				$(this).children().attr({"src": "../images/2020/sub/step_"+str+"_on.png"});
			}else{
				$(this).children().attr({"src":"../images/2020/sub/step_"+str+"_off.png"});
			}*/
		});
		$(".flowerTab li a").mouseover(function(){
			var str = $(this).parent().attr("class");
			str = str.substring(5,7);
				$(this).children().attr({"src": "../images/2020/sub/step_"+str+"_on.png"});
		}).mouseout(function(){
			var str = $(this).parent().attr("class");
			str = str.substring(5,7);
			if ( $(this).parent().attr("class").indexOf("on") !=-1 ){ 
				$(this).children().attr({"src":"../images/2020/sub/step_"+str+"_on.png"});
			}else{
				$(this).children().attr({"src": "../images/2020/sub/step_"+str+"_off.png"});
			}
		});

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
		
		/* 저장 공유 등  */	
		$(".saveDt li button").unbind("click").click(function(){
			if($(".saveDd ."+$(this).attr("class")).css("display") == "none"){
				$(".saveDd li").hide();
				$(this).parents(".saveDt").next().children(".saveDd ."+$(this).attr("class")).slideDown();
			}else{
				$(".saveDd li").slideUp();
			}
			
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


$(window).on(function(){
	fnSelect();/* 셀렉트 */
});
/* //select */


/* Layer popup 추가 -> script.js 재 선언 */
function fnLayerPopup(el){

	var $el = $(el);        //레이어의 id를 $el 변수에 저장
	var isDim = $el.prev().hasClass('dimBg');   //dimmed 레이어를 감지하기 위한 boolean 변수

	isDim ? $('.dim-layer').fadeIn() : $el.fadeIn();

	var $elWidth = $( window ).width(),
		$elHeight = $( window ).height(),
		docWidth = $(window).width(),
		docHeight = $(window).height();

	var popboxW = $el.find(".popbox").width()/2; 
	var popboxH = $el.find(".popbox").height()/2; 
	
	//높이가 음수일때 양수로 변경 추가
	var marginTop = $elHeight /2 - popboxH;
	if(marginTop < 0){
		marginTop = 10;
	}
	
	$el.find(".popbox").css({
		marginTop: marginTop,
		marginLeft: $elWidth/2 - popboxW
	})

	$el.find('a.btn-layerClose').click(function(){
		isDim ? $('.dim-layer').fadeOut() : $el.fadeOut(); // 닫기 버튼을 클릭하면 레이어가 닫힌다.
		return false;
	});
	
	$el.find('button.btn-layerClose').click(function(){
		isDim ? $('.dim-layer').fadeOut() : $el.fadeOut(); // 닫기 버튼을 클릭하면 레이어가 닫힌다.
		return false;
	});

	$('.layer .dimBg').click(function(){
		$('.dim-layer').fadeOut();
		return false;
	});

}

function fnHidePopup(el){

	var $el = $(el);        //레이어의 id를 $el 변수에 저장
	var isDim = $el.prev().hasClass('dimBg');   //dimmed 레이어를 감지하기 위한 boolean 변수

	isDim ? $('.dim-layer').fadeOut() : $el.fadeOut(); // 닫기 버튼을 클릭하면 레이어가 닫힌다.
	
}
