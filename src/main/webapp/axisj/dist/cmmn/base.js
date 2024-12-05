var parent_window = parent||opener||window;
var myValidator = new AXValidator();
var loading_mask = new AXMask();
var myUpload = new AXUpload5();
var AXGrid_instances = [];
var AXTree_instances = [];
var fcObj = {	
		
		pageStart: function(){
			
			/*	loading_mask.setContent(
					{
						width:200, height:200,
						html: '<div class="loading" style="color:#ffffff;">' +
			   			'<i class="axi axi-spinner axi-spin" style="font-size:100px;"></i>' +
			   			'<div>Loading..</div>' +
			   			'</div>'
						html: '<div class="loading" style="color:#ffffff;">' +
						'<i class="axi axi-data-usage animated bounceOutUp" style="font-size:100px;display:block;"></i>' +
						'<div style="font-family: consolas">Data is delivered</div>' +
						'</div>'
					}
				);*/
				
				
		 },
		 pageResize: function(){
			
			if(window.fnObj && fnObj.pageResize) fnObj.pageResize();
	},
	resize_elements: function(){
		if(window.resize_elements && window.resize_elements.length > 0){
			for(var i= 0,l=resize_elements.length,adjust;i<l;i++){
				if(resize_elements[i].id){
					if(!resize_elements[i].dom) resize_elements[i].dom = $("#" + resize_elements[i].id);
					if(typeof resize_elements[i].adjust == "function"){
						adjust = (resize_elements[i].adjust()||0).number();
					}else{
						adjust = (resize_elements[i].adjust||0).number();
					}
					resize_elements[i].dom.css({height: axf.clientHeight() + adjust - 200});
					// AXPage 안에 AXBox의 높이가 적절히 표시되기 위한 조건
				}
			}

			if(AXGrid_instances.length > 0){
				for(var i= 0,l=AXGrid_instances.length;i<l;i++) {
					AXGrid_instances[i].resetHeight();
				}
			}
			if(AXTree_instances.length > 0){
				for(var i= 0,l=AXTree_instances.length;i<l;i++) {
					AXTree_instances[i].resetHeight();
				}
			}
			//AXGrid_instances
			//AXTree_instances
		}
	},	
		theme: {
			sel: null,
			init: function(){
				return;
				var themes = [
					["taeyoung","cocker"],
					["cocker","cocker"],
					["cocker-dark","bulldog"],
					["cocker-dark-red","cocker"],
					["cacao","kakao"],
					["cacao-dark","kakao"]
				];
				var po = [];
				$.each(themes, function(){
					po.push('<option value="', this[0],'/', this[1],'">', this[0],'</option>');
				});
				fcObj.theme.sel = jQuery("#theme-select");
				fcObj.theme.sel.html( po.join('') );
				
				var _theme;
				if((_theme = axf.getCookie("axutheme"))){
					fcObj.theme.sel.val(_theme);
					fcObj.theme.change(_theme);
				}
				fcObj.theme.sel.bind("change", function(e) {
					fcObj.theme.change(e.target.value);
				});
			},
			change: function(theme){
				var t = theme.split("/");
				jQuery("#axu-theme-admin").attr("href", "ui/"+t[0]+"/admin.css");
				jQuery("#axu-theme-axisj").attr("href", "/plugins/axisj/ui/"+ t[1] +"/AXJ.min.css?v="+axf.timekey());
				axf.setCookie("axutheme", theme);
			}
		},
			
		
		
};

jQuery(document.body).ready(function() {
	fcObj.pageStart()
});
jQuery(window).resize(function() {
	fcObj.pageResize();
});



// 2014-12-26 AXU, admin.js add script
jQuery(document.body).ready(function() {
	jQuery(document.body).append('<div class="ax-scroll-top"><a href="javascript:window.scroll(0, 0);"><i class="axi axi-ion-arrow-up-c"></i> TOP</a></div>');
	window.scroll_top_handle = jQuery(".ax-scroll-top");
});

jQuery(window).bind("scroll", function() {
	if (window.scroll_top_handle === undefined){
		window.scroll_top_handle = jQuery(".ax-scroll-top");
	}else{
		if (jQuery(document.body).scrollTop() > 60) {
	        window.scroll_top_handle.addClass("on");
	    } else {
	        window.scroll_top_handle.removeClass("on");
	    }
	}
});
