
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
	
	 $('.tab li').bind("click, mouseenter", function(){
		 
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


//서브 화훼 이미지선택 메뉴 스크립트
$(document).ready(function(){
	
	var tablndex = 0;
	
	 $('.tab_a li').bind("click, mouseenter", function(){
		 
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

