/* script.js */

//JQUERY 시작
$(function(){

	  //dim처리 layerpopup
	$('.btn-example').click(function(){
		var $href = $(this).attr('href');
		layer_popup($href);
	});
	function layer_popup(el){

		var $el = $(el);        //레이어의 id를 $el 변수에 저장
		var isDim = $el.prev().hasClass('dimBg');   //dimmed 레이어를 감지하기 위한 boolean 변수
    $('body').attr('style', 'overflow:hidden!important');
    
		isDim ? $('.dim-layer').fadeIn() : $el.fadeIn();

		var $elWidth = $( window ).width(),
			$elHeight = $( window ).height(),
			docWidth = $(window).width(),
			docHeight = $(window).height();

		var popboxW = $el.find(".popbox").width()/2; 
		var popboxH = $el.find(".popbox").height()/2; 
		$el.find(".popbox").css({
			marginTop: $elHeight /2 - popboxH,
			marginLeft: $elWidth/2 - popboxW
		})
		// 화면의 중앙에 레이어를 띄운다.
		/*if ($elHeight < docHeight || $elWidth < docWidth) {
			$el.css({
				marginTop: -$elHeight /2,
				marginLeft: -$elWidth/2
			})
		} else {
			$el.css({top: 0, left: 0});
		}*/

		$el.find('a.btn-layerClose').click(function(){
      isDim ? $('.dim-layer').fadeOut() : $el.fadeOut(); // 닫기 버튼을 클릭하면 레이어가 닫힌다.
      $('body').attr('style', 'overflow:auto!important');
			return false;
		});

		$('.layer .dimBg').click(function(){
			$('.dim-layer').fadeOut();
			return false;
		});

  }
  
  
  //lnb
      $('.btn_m_menu').click(function () {
        //$(this).toggleClass('on');
        $('.lnb').toggleClass('on');
        // $('.dimmed').css('display', 'block');
    });
    $('.close_menu').click(function () {
		
         $('.lnb').toggleClass('on');
        // $('.dimmed').css('display', 'none');
    });
	
    //depth
    var depth01 = $('.m_depth_01 > li > a');
    var depth02 = $('.m_depth_02 > li > a');

    depth01.click(function () {
        $(this).closest('ul').find('.m_depth_02').slideToggle('fast');
        $(this).find('p').toggleClass('plus');
        if ($(this).find('p').hasClass('plus') == true) {
            $(this).find('p').text ('─');
            depth01.siblings().find('p').removeClass('plus');
        } else {
            $(this).find('p').text('┼');
            depth01.siblings().find('p').addClass('plus');
        }
    });

    depth02.click(function () {
        $(this).closest('ul').find('.m_depth_03').slideToggle('fast');
        $(this).find('p').toggleClass('plus');
        if ($(this).find('p').hasClass('plus') == true) {
            $(this).find('p').text ('─');
            depth02.siblings().find('p').removeClass('plus');
        } else {
            $(this).find('p').text('┼');
            depth02.siblings().find('p').addClass('plus');
        }

    });

	//고정텝바
	
  
	//찾기있는 인풋
    

    //슬라이드 메뉴
    $('.menu_box,.slide_menu').hover(function() {
      $('.slide_menu').addClass('open');
       }, function(){
      $('.slide_menu').removeClass('open');
      $('.menu_box a').css('color','');
    });


    //gnb 마우스오버시 화살표 및 우측 이미지 변경
    $('.m_l_in').hover(function(){    
      var _index = $(this).index();
      /*
      if($(this).index() > 0){
          _index = $(this).index()-1;
      }
      */
      //console.log(_index); 
      $('.menu_explain div').css('display','none');
      $(".menu_explain div:eq("+_index+")").css('display','block');
      $(".menu_box a").siblings().css('color','');
      $(".menu_box a:eq("+_index+")").css('color','#53af31');
      //$(this).css({"background":"url(../images/2020/arrow_down.png) no-repeat center top"});          
      //$(this).siblings().css({"background":"none"});          
    });

    $('.menu_box a').hover(function(){    
      var index_02 = $(this).index();
      //console.log(index_02); 
      $('.menu_explain div').css('display','none');
      $(".menu_explain div:eq("+index_02+")").css('display','block');
      //$(".menu_list .m_l_in:eq("+index_02+")").css({"background":"url(../images/2020/arrow_down.png) no-repeat center top"}); 
      //$(".menu_list .m_l_in:eq("+index_02+")").siblings().css({"background":"none"});
    });
 


    //최하단 슬라이드 
    var mySlider=$("#slide_banner").bxSlider({
      mode:"horizontal",   // 가로 수평으로 슬라이드 됩니다.
    speed:1000,              // 이동 속도를 설정합니다.
    pager:false,            // 현재 위치 페이징 표시 여부 설정.
    moveSlides:3,         // 슬라이드 이동시 갯수 설정.
    slideWidth:'auto',        // 슬라이드 마다 너비 설정.
    minSlides:4,           // 최소 노출 개수를 설정합니다.
    maxSlides:20,          // 최대 노출 개수를 설정합니다.
    slideMargin:0,      // 슬라이드간의 간격을 설정합니다.
    auto:true,             // 자동으로 흐를지 설정합니다.
    autoHover:true,    // 마우스 오버시 정시킬지 설정합니다.
    controls:false       //  이전 다음 버튼 노출 여부 설정합니다.
    });
    //이전 버튼을 클릭하면 이전 슬라이드로 전환됩니다.
    $("#prevBtn").on("click",function(){
    mySlider.goToPrevSlide();  //이전 슬라이드 배너로 이동됩니다.
    return false; //<a>에 링크를 차단합니다.
    });
    //다음 버튼을 클릭하면 다음 슬라이드로 전환됩니다.
    $("#nextBtn").on("click",function(){
    mySlider.goToNextSlide();  //다음 슬라이드 배너로 이동됩니다.
    return false;
    });
    
 


// Hide Header on on scroll down
var didScroll;
var lastScrollTop = 0;
var delta = 5;
var navbarHeight = $('.header').outerHeight();

$(window).scroll(function(event){
    didScroll = true;
});

setInterval(function() {
    if (didScroll) {
        hasScrolled();
        didScroll = false;
    }
}, 250);

function hasScrolled() {
    var st = $(this).scrollTop();
    
    // Make sure they scroll more than delta
    if(Math.abs(lastScrollTop - st) <= delta)
        return;
    
    // If they scrolled down and are past the navbar, add class .nav-up.
    // This is necessary so you never see what is "behind" the navbar.
    if (st > lastScrollTop && st > navbarHeight){
        // Scroll Down
        $('.header').addClass('scroll');
    } else {
        // Scroll Up
        if(st + $(window).height() < $(document).height()) {
            $('.header').removeClass('scroll');
        }
    }
    
    lastScrollTop = st;
}

});

