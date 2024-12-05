//메인 탑 메뉴 스크립트
$(document).ready(function() {

$("#gnb > li").bind("mouseenter focusin", function() {
    $("#gnb > li").addClass("on").siblings();
});
$("#gnb > li").bind("mouseleave focusout", function() {
    $("#gnb > li").removeClass("on");
});
});

//메인 화훼 이미지선택 메뉴 스크립트
$(document).ready(function(){
	
	var tablndex = 0;
	
	   $('.tab_a li').click(function(){
		   
		 tabindex = $(this).index();
		 
		 $('.tab_a li').each(function(idx){
		 $(this).find('img').attr('src',$(this).find('img').attr('src').replace('_off','_on'));
		 if(tabindex !=idx) {
		 $(this).find('img').attr('src',$(this).find('img').attr('src').replace('_on','_off'));
		 }
		 });
		 $('.tab_a > div').eq(tabindex).show().siblings('div').hide();
	 });
	 
});


//haa02 최근1개월 최근6개월 최근1년 탭부분
$(document).ready(function(){
	
	var tablndex = 0;
	
	 $('.hw_a_select_06').click(function(){
		 
		 tabindex = $(this).index();
		 
		 $('.hw_a_select_06').each(function(idx){
		 $(this).find('img').attr('src',$(this).find('img').attr('src').replace('_off','_on'));
		 if(tabindex !=idx) {
		 $(this).find('img').attr('src',$(this).find('img').attr('src').replace('_on','_off'));
		 }
		 });
		 $('.hw_a_select_06 > div').eq(tabindex).show().siblings('div').hide();
	 });
	 
});

$(document).ready(function(){
	
	var tablndex = 0;
	
	 $('.hw_market_sub li').click(function(){
		 
		 tabindex = $(this).index();
		 
		 $('.hw_market_sub li').each(function(idx){
		 $(this).find('img').attr('src',$(this).find('img').attr('src').replace('_off','_on'));
		 if(tabindex !=idx) {
		 $(this).find('img').attr('src',$(this).find('img').attr('src').replace('_on','_off'));
		 }
		 });
		 $('.hw_market_sub > div').eq(tabindex).show().siblings('div').hide();
	 });
	 
});

$(document).ready(function(){
	
	var tablndex = 0;
	
	 $('.hw_market li').click(function(){
		 
		 tabindex = $(this).index();
		 
		 $('.hw_market li').each(function(idx){
		 $(this).find('img').attr('src',$(this).find('img').attr('src').replace('_off','_on'));
		 if(tabindex !=idx) {
		 $(this).find('img').attr('src',$(this).find('img').attr('src').replace('_on','_off'));
		 }
		 });
		 $('.hw_market > div').eq(tabindex).show().siblings('div').hide();
	 });
	 
});

$(document).ready(function(){
	 
	 var tablndex = 0;
	 
	  $('.tab li').click(function(){
	   
	   tabindex = $(this).index();
	   
	   $('.tab li').each(function(idx){
	   $(this).find('img').attr('src',$(this).find('img').attr('src').replace('_off','_on'));
	   if(tabindex !=idx) {
	   $(this).find('img').attr('src',$(this).find('img').attr('src').replace('_on','_off'));
	   }
	   });
	   $('.tab > div').eq(tabindex).show().siblings('div').hide();
	  });
	  
	});
