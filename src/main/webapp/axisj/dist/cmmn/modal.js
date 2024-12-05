var parent_window = parent||opener||window;
var loading_mask = new AXMask();
	loading_mask.setConfig();
	loading_mask.setContent(
		{
			width:200, height:200,
			html: '<div class="loading" style="color:#ffffff;">' +
			'<i class="axi axi-flight animated bounceOutUp" style="font-size:100px;"></i>' +
			'<div style="font-family: consolas">Data is delivered by a plane</div>' +
			'</div>'
		}
	);