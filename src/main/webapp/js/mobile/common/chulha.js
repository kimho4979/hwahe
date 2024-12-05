    var myProgress = new AXProgress();      
    var myModal = new AXModal();
	var myUpload = new AXUpload5();

$(document).ready(function(){
		$('.register_title').click(function(){
			
			var GUBN=nvl($(":radio[name=radio]:checked").val());
		
		 		
		 		url="/mntr/maa11/mobileInsertShipmntPrearngeVolm.json"
		 
			
			Insert(url,GUBN);
		});
		
		
});







