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
      $('.menu_explain div').css('display','none');
      $(".menu_explain div:eq("+_index+")").css('display','block');
      
      //console.log(_index);       
      $(".menu_box a").siblings().css('color','');
      $(".menu_box a:eq("+_index+")").css('color','#009e5d');
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
 

   

  
    
  
	

	

		// KR language callendar
	//$.datepicker.regional['kr'] = {
		//closeText: '닫기', // 닫기 버튼 텍스트 변경
		//currentText: '오늘', // 오늘 텍스트 변경
		//monthNames: ['1 월','2 월','3 월','4 월','5 월','6 월','7 월','8 월','9 월','10 월','11 월','12 월'], // 개월 텍스트 설정
		//monthNamesShort: ['1 월','2 월','3 월','4 월','5 월','6 월','7 월','8 월','9 월','10 월','11 월','12 월'], // 개월 텍스트 설정
		//dayNamesMin: ['일','월','화','수','목','금','토'], // 요일 텍스트 설정
		//dayNamesShort: ['월','화','수','목','금','토','일'], // 요일 텍스트 축약 설정&nbsp;   dayNamesMin: ['월','화','수','목','금','토','일'], // 요일 최소 축약 텍스트 설정
		//dateFormat: 'dd/mm/yy' // 날짜 포맷 설정
	//};
		// Seeting up default language, Korean
	$.datepicker.setDefaults($.datepicker.regional['kr']);

  //서브 탭 메뉴 도매시장운영실적평가안내 >> 평가지표
  $('.btn_tab_box_column_04 ul li').click(function() {
    var activeTab = $(this).attr('data-tab');
    $('.btn_tab_box_column_04 ul li').removeClass('on');
    $('.tab_box_column_04 ul li').removeClass('on');
    $(this).addClass('on');
    $('#' + activeTab).addClass('on');
  });

  //서브 탭 메뉴 도매시장운영실적평가안내 >> 평가방법
  $('.btn_tab_box_column_02 ul li').click(function() {
    var activeTab = $(this).attr('data-tab');
    $('.btn_tab_box_column_02 ul li').removeClass('on');
    $('.tab_box_column_02 ul li').removeClass('on');
    $(this).addClass('on');
    $('#' + activeTab).addClass('on');
  });

  //서브 탭 메뉴 도매시장운영실적평가안내 >> 평가결과 조회
  $('.btn_tab_box_column_02_type_02 ul li').click(function() {
    var activeTab = $(this).attr('data-tab');
    $('.btn_tab_box_column_02_type_02 ul li').removeClass('on');
    $('.tab_box_column_02_type_02 ul li').removeClass('on');
    $(this).addClass('on');
    $('#' + activeTab).addClass('on');
  });

  // 작황정보 높이 동일 맞추기
    var heightArray = $(".crop_list_box .crop_list ul.crop_list_b li table tr").map(function(){
      return $(this).height();
      }).get(); 
      
      var maxHeight = Math.max.apply( Math, heightArray);
      $(".crop_list_box .crop_list ul.crop_list_b li  table tr").height(maxHeight); 
      

  // 2021.09.28 추가 (S)    
  //최하단 슬라이드 
  var mySlider=$("#slide_banner").bxSlider({
    mode:"horizontal",   // 가로 수평으로 슬라이드 됩니다.
  speed:500,              // 이동 속도를 설정합니다.
  pager:false,            // 현재 위치 페이징 표시 여부 설정.
  moveSlides:3,         // 슬라이드 이동시 갯수 설정.
  slideWidth:'auto',        // 슬라이드 마다 너비 설정.
  minSlides:4,           // 최소 노출 개수를 설정합니다.
  maxSlides:4,          // 최대 노출 개수를 설정합니다.
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
  //2021.09.28 추가 (E)   
});


//서브 lnb
(function($)
{ var lnbUI = {
   click : function (target, speed) 
  { var _self = this, 
    $target = $(target); 
    _self.speed = speed || 300; 
    
    $target.each(function(){ 
      if(findChildren($(this))) {
         return; }
          $(this).addClass('noDepth');
         }); 

         function findChildren(obj) {
            return obj.find('> ul').length > 0; 
          } 
          
          $target.on('click','a', function(e){ 
            e.stopPropagation(); 
            var $this = $(this), 
              $depthTarget = $this.next(), 
              $siblings = $this.parent().siblings(); 
              
              $this.parent('li').find('ul li').removeClass('on');
              $siblings.removeClass('on'); 
              $siblings.find('ul').slideUp(250); 
              
              if($depthTarget.css('display') == 'none') {
                _self.activeOn($this);
                $depthTarget.slideDown(_self.speed);
              } else { 
                $depthTarget.slideUp(_self.speed);
                _self.activeOff($this);
               }
               })
               },
				
               activeOff : function($target){ 
                 $target.parent().removeClass('on');
               },
               activeOn : function($target) { 
                 $target.parent().addClass('on');
               }
              }; 

    // Call lnbUI 

    $(function(){ 
      lnbUI.click('#lnb li', 300) 
    }); 
  }(jQuery));









$(function(){
  /*터치 슬라이드 비주얼 영역*/
   window.mySwipe =$('#mySwipe').Swipe({
   auto: 3000,  //배너가 3초 간격으로 이동합니다.
   speed: 1500,
   continuous: true, // 반복해서 롤링됩니다.
   callback: function(index, element) {
   //이벤트가 완료되면 실행합니다.
  
/*클래스 "active"를 포함하는 불릿 버튼을 비활성화 버튼으로 만들고, "active" 클래스를 삭제합니다.
    $(".touch_bullet .active")
    .attr("src",$(".touch_bullet .active")
    .attr("src").replace("on.png","off.png"))
    .removeClass("active"); */
/*인덱스(index)에 해당하는 불릿 버튼을 활성화된 버튼으로 만들고, 
    "active" 클래스를 생성합니다.
    $(".touch_bullet img").eq(index)
    .attr("src",$(".touch_bullet img").eq(index)
    .attr("src").replace("off.png","on.png"))
    .addClass("active");*/
   }
  }).data('Swipe');
  
  
  /*비주얼 이전, 다음 버튼*/
  $(".touch_left_btn a").on("click",function(){
  //이전 버튼을 누를 때마다...
   mySwipe.prev(); //이전 배너로 이동합니다.
   return false; //링크를 차단합니다.
  });
  $(".touch_right_btn a").on("click",function(){
  //다음 버튼을 누를 때마다...
   mySwipe.next(); //다음 배너로 이동합니다.
   return false; //링크를 차단합니다.
  });
  
});

/*
메인 슬라이드(모바일)
*/


/*
메인 탭메뉴
*/

$(function () {	
	tab('#tab',0);	
});

function tab(e, num){
    var num = num || 0;
    var menu = $(e).children();
    var con = $(e+'_con').children();
    var select = $(menu).eq(num);
    var i = num;

    select.addClass('on');
    con.eq(num).show();

    menu.click(function(){
        if(select!==null){
            select.removeClass("on");
            con.eq(i).hide();
        }

        select = $(this);	
        i = $(this).index();

        select.addClass('on');
        con.eq(i).show();
    });
}




/*
작황정보 높이 동일
*/




