<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, user-scalable=no">
<title>모니터요원 입력시스템-이미지관리</title>
<!-- @@@@@@@@@@@@@@@@@@@@@@ css begin @@@@@@@@@@@@@@@@@@@@@@ -->
<link rel="stylesheet" type="text/css"
	href="<c:url value='/rMateChart/rMateChartH5/Assets/Css/rMateChartH5.css' />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value='/axisj/axicon/axicon.min.css' />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value='/axisj/ui/arongi/AXJ.min.css' />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value='/css/hw/ma.css' />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value='/css/hw/common.css' />" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/admin/css/bootstrap.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/admin/css/bootstrap-theme.css">
<!-- @@@@@@@@@@@@@@@@@@@@@@ css end   @@@@@@@@@@@@@@@@@@@@@@ -->

<script type="text/javascript"
	src="<c:url value='/axisj/jquery/jquery.min.js' />"></script>
<script type="text/javascript"
	src="<c:url value='/axisj/dist/AXJ.min.js' />"></script>
<script type="text/javascript"
	src="<c:url value='/axisj/dist/cmmn/ax5-polyfill.js' />"></script>
<script type="text/javascript"
	src="<c:url value='/axisj/dist/cmmn/axjApp.js' />"></script>

<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.3.0/codemirror.min.js"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.3.0/mode/xml/xml.min.js"></script>
<script type="text/javascript"
	src="/plugin/froala/js/froala_editor.min.js"></script>
<script type="text/javascript"
	src="/plugin/froala/js/plugins/align.min.js"></script>
<script type="text/javascript"
	src="/plugin/froala/js/plugins/code_beautifier.min.js"></script>
<script type="text/javascript"
	src="/plugin/froala/js/plugins/code_view.min.js"></script>
<script type="text/javascript"
	src="/plugin/froala/js/plugins/draggable.min.js"></script>
<!-- <script type="text/javascript" src="/plugin/froala/js/plugins/image.min.js"></script>
	<script type="text/javascript" src="/plugin/froala/js/plugins/image_manager.min.js"></script> -->
<script type="text/javascript"
	src="/plugin/froala/js/plugins/link.min.js"></script>
<script type="text/javascript"
	src="/plugin/froala/js/plugins/lists.min.js"></script>
<script type="text/javascript"
	src="/plugin/froala/js/plugins/paragraph_format.min.js"></script>
<script type="text/javascript"
	src="/plugin/froala/js/plugins/paragraph_style.min.js"></script>
<script type="text/javascript"
	src="/plugin/froala/js/plugins/table.min.js"></script>
<!-- <script type="text/javascript" src="/plugin/froala/js/plugins/video.min.js"></script> -->
<script type="text/javascript"
	src="/plugin/froala/js/plugins/url.min.js"></script>
<script type="text/javascript"
	src="/plugin/froala/js/plugins/entities.min.js"></script>
<script type="text/javascript" src="/admin/js/vibrant.js"></script>
<script type="text/javascript" src="/admin/js/script.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/admin/js/bootstrap.min.js"></script>


<script type="text/javascript" src="<%=request.getContextPath()%>/admin/js/jquery-ui.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/color-thief/2.3.0/color-thief.umd.js"></script>

<%-- <link rel="stylesheet" href="<%=request.getContextPath()%>/admin/css/bootstrap.min.css"> --%>
<%-- <link rel="stylesheet" href="<%=request.getContextPath()%>/admin/css/bootstrap-theme.min.css"> --%>

<link rel="stylesheet" href="/admin/css/jquery-ui.min.css">
<link rel="stylesheet" href="/admin/css/jquery-ui.theme.min.css">
<link rel="stylesheet" href="/admin/css/jquery-ui.structure.min.css">
<link rel="stylesheet" href="/admin/css/demo.css">
<link rel="stylesheet" href="/admin/css/style.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.4.0/css/font-awesome.min.css">
<link rel="stylesheet" href="/plugin/froala/css/froala_editor.css">
<link rel="stylesheet" href="/plugin/froala/css/froala_style.css">
<link rel="stylesheet" href="/plugin/froala/css/plugins/code_view.css">
<!-- <link rel="stylesheet" href="/plugin/froala/css/plugins/image_manager.css">
	<link rel="stylesheet" href="/plugin/froala/css/plugins/image.css"> -->
<link rel="stylesheet" href="/plugin/froala/css/plugins/table.css">
<!-- <link rel="stylesheet" href="/plugin/froala/css/plugins/video.css"> -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.3.0/codemirror.min.css">
	

<style>
.preview-area {
	display: flex;
	flex-wrap: wrap;
}

.preview-area img {
	width: 50%;
	margin: 0 0 10px;
	object-fit: contain;
}

.preview-area
 
img
:not
 
(
:nth-child(4n)
 
){
margin-right
:
 
1
.333
%;


}
.swatch {
	display: inline-block;
	height: 40px;
	width: 40px;
	border-radius: 50px;
	-webkit-transition: 0.3s;
	-moz-transition: 0.3s;
}

.swatch.active {
	display: inline-block;
	height: 45px;
	width: 45px;
	/*border: 2mm dashed rgba(0,0,0);*/
	border-style: dashed;
	/*box-shadow : 5px 5px 5px black;*/
	border-radius: 50px;
	-webkit-transition: 0.3s;
	-moz-transition: 0.3s;
	transition-duration: 0.3s;
}

#loading-indicator-back {
	background: rgba(0,0,0,.5) ;
	display: none;
    position: fixed;
    z-index: 999;
    height: 100%;
    width: 100%;
    left: 0;
    top: 0;
}

#loading-indicator {

	background:  url( '/images/loadingBar.gif' ) no-repeat;
	display: none;
    position: fixed;
    z-index: 999;
    height: 100%;
    width: 100%;
    left: 50%;
    top: 50%;
}

</style>

<script type="text/javascript">
	var fullUrl = location.protocol+'//'+location.hostname+(location.port ? ':'+location.port: '');
	//console.log(full);
	
	$(document).ready(function() {
		
		/* $('#edit').on('froalaEditor.initialized', function (e, editor) {
          $('#edit').parents('form').on('submit', function () {
            //console.log($('#edit').val());
            return false;
          })
        }).froalaEditor({enter: $.FroalaEditor.ENTER_P, placeholderText: null}); */
		
		// ajax 때문에 초기화 한번 해줘야함(값이 남아 있기 때문)
		//resetFileEl();
		//initFileEl("fileData", 1, 80, "zip,png,gif,bmp,jpg,jpeg,7z,hwp,ppt,xls,doc,txt,text,pdf,xlsx,pptx,docx", 0);
		if(new URL(location.href).searchParams.get('update') == 1){
			let blobUrl='';let i=1;
		     var outer = '<div class="profile">';
            outer += '<div class="profile__image">';
            outer += "<img id=\"previewImg"+i+"\" src=\""+blobUrl+"\"/></div>";
            outer += '<div class="profile__info">';
            outer += '<div class="hw_infouse_01 rgbHolder" >RGB 영역</div>';             
            outer += '<span class="swatch colorVibrant" style="margin:3px;"></span>';
            outer += '<span class="swatch colorMuted" style="margin:3px;"></span>';
            outer += '<span class="swatch colorDarkVibrant" style="margin:3px;"></span>';
            outer += '<span class="swatch colorDarkMuted" style="margin:3px;"></span>';
            outer += '<span class="swatch colorLightVibrant" style="margin:3px;"></span>';
            outer += '<span class="swatch colorLightVibrant" style="margin:3px;"></span>';
            outer += '<span class="swatch colorLightVibrant" style="margin:3px;"></span>';
            outer += '<span class="swatch colorLightVibrant" style="margin:3px;"></span>';
            outer += '<span class="swatch colorLightVibrant" style="margin:3px;"></span>';
            outer += '<span class="swatch colorLightVibrant" style="margin:3px;"></span>';
            outer += '<span class="swatch colorLightVibrant" style="margin:3px;"></span>';
            outer += '<span class="swatch colorLightVibrant" style="margin:3px;"></span>';
            outer += '<span class="swatch colorLightVibrant" style="margin:3px;"></span>';
            outer += '<span class="swatch colorLightVibrant" style="margin:3px;"></span>';
            outer += '<span class="swatch colorLightVibrant" style="margin:3px;"></span>';
            outer += '<span class="swatch colorLightVibrant" style="margin:3px;"></span>';
            outer += '<span class="swatch colorLightVibrant" style="margin:3px;"></span>';
            outer += '<span class="swatch colorLightVibrant" style="margin:3px;"></span>';
            outer += '<span class="swatch colorLightVibrant" style="margin:3px;"></span>';
            outer += '<span class="swatch colorLightVibrant" style="margin:3px;"></span>';
            outer += '<span class="swatch colorLightVibrant" style="margin:3px;"></span>';
            outer += '<span class="swatch colorLightVibrant" style="margin:3px;"></span>';
            outer += '<span class="swatch colorLightVibrant" style="margin:3px;"></span>';
            outer += '<span class="swatch colorLightVibrant" style="margin:3px;"></span>';
            outer += '<div class="hw_infouse_01"><label class="hw_item_search_title">부류 </label>&nbsp;<select  class="item_search_select"  id="flwrgbn'+i+'"></select></div>';
            outer += '<div class="hw_infouse_01"><label class="hw_item_search_title">품목</label>&nbsp;<input class="AXInput" id="txtMok'+i+'" style="height:30px;width:160px;"  aria-label="Color Input" aria-describedby="inputGroup-color-sm"></div>';
            outer += '<div class="hw_infouse_01"><label class="hw_item_search_title">품종</label>&nbsp;<input class="AXInput" id="txtJong'+i+'" style="height:30px;width:160px;"  aria-label="Color Input" aria-describedby="inputGroup-color-sm"><span id="pumCode'+i+'"></span></div>';
            outer += '<div class="hw_infouse_01">';
          	 outer += '<label class="" id="inputGroup-sizing-sm">색상</label>&nbsp;';
          	 outer += '<input class="AXInput"  id="colorTxt'+i+'"  style="height:30px;width:160px;"  aria-label="Color Input" aria-describedby="inputGroup-color-sm">';
            outer += '</div></div></div>';
			 console.log(outer)
            $('.results-section.results--grid')[0].innerHTML += outer;
		}
			
		
		
		
	});
	
	function getCommonCode(){
		$.ajax({
			url:'/admin',
			type : 'post',
			url : "/admin/img/manage.json",
			data : '' ,
			dataType : 'json',
			beforeSend: function(){
				$('#loading-indicator').show();
				$('#loading-indicator-back').show();
			},
			complete: function(){
				$('#loading-indicator').hide();
				$('#loading-indicator-back').hide();
			},
			success : function(res) {
			
				if(res.flower.length > 0){
					for(var z=1;z<=$('.profile__image').size();z++){
						var moks = [];
						var jongs = [];
						$('#flwrgbn'+z).empty()
						for(var i=0;i<res.flower.length;i++){	
							console.log(res.flower[i])
							if(res.flower[i].CMNGBN == "F"){
								$('#flwrgbn'+z).append('<option cdId="'+res.flower[i].CD_ID+'">'+res.flower[i].CD_NM+'</option>')	
							}
						}
						
						for(var i=0;i<res.mok.length;i++){
							let obj = {};
							obj.label = res.mok[i].P_MOK_NAME;
							obj.value = res.mok[i].P_MOK_CODE;
							moks.push(obj);
						}
						
						
						/*for(var i=0;i<res.jong.length;i++){
							let obj = {};
							obj.label = res.jong[i].P_JONG_NAME;
							obj.value = res.jong[i].PUM_CODE;
							jongs.push(obj);
						}*/
						
						$('#txtMok'+z).autocomplete({
							source: moks,
							select: function(event,ui){
								$(this).val(ui.item.label +' - '+ ui.item.value);
								$(this).attr('val',ui.item.value);
								console.log("서버로")
								$.ajax({
									url:"/admin/img/getJongCodeP.json",
									type:"post",
									data:{data : ui.item.value},
									dataType:"json",
									success:function(res){
										jongs=[];
										$.each(res.jong,function(i,v){
											let obj = {};
											obj.label = v.P_JONG_NAME;
											obj.value = v.PUM_CODE;
											jongs.push(obj);
										})
										console.log(jongs)
										for(var z=1;z<=$('.profile__image').size();z++){
											$('#txtJong'+(z)).autocomplete({
												source: jongs,
												select: function(event,ui){
													$(this).val(ui.item.label +' - '+ ui.item.value);
													$(this).attr('val',ui.item.value);
													
													return false;
												},
												focus: function(event,ui){
													return false;
												}
											})
										}
									}
								})
								return false;
							},
							focus: function(event,ui){
								return false;
							}
						})
						
						
						/**/
					}
				}
				
			}
		
		})	
	}
	
	function eventOnImage(){
		$('.swatch').on('click',function(e){
			$(e.target).siblings().removeClass("active")
			$(e.target).addClass("active")
			$('label[for=rgb]').text($(e.target).css("background-color"))
			console.log($('label[for=rgb]').text())
			$(e.target).parent().children(':first').text($(e.target).css("background-color"))
			console.log($(e.target).parent().children(':first').text())
			//e.target.style.border = "0.5em solid";
		})	
	}
	
	
	// SELECT * FROM FLOWER.TB_CM_CODE where gp_id = 'FLOWER_GUBN';
   function preview(elem, output = '') {
	   $('.results-section.results--grid').empty();
	    var i = 1;
        Array.from(elem.files).map((file) => {
        	
        	//const blobUrl = window.URL.createObjectURL(file)
            
        	var reader = new FileReader();
        	reader.readAsDataURL(file); 
        	reader.onloadend = function() {
        	  var blobUrl = reader.result;                
      
        	
        	
        	
             var outer = '<div class="profile">';
             outer += '<div class="profile__image">';
             outer += "<img id=\"previewImg"+i+"\" src=\""+blobUrl+"\"/></div>";
             outer += '<div class="profile__info">';
             outer += '<div class="hw_infouse_01 rgbHolder" >RGB 영역</div>';             
             outer += '<span class="swatch colorVibrant" style="margin:3px;"></span>';
             outer += '<span class="swatch colorMuted" style="margin:3px;"></span>';
             outer += '<span class="swatch colorDarkVibrant" style="margin:3px;"></span>';
             outer += '<span class="swatch colorDarkMuted" style="margin:3px;"></span>';
             outer += '<span class="swatch colorLightVibrant" style="margin:3px;"></span>';
             outer += '<span class="swatch colorLightVibrant" style="margin:3px;"></span>';
             outer += '<span class="swatch colorLightVibrant" style="margin:3px;"></span>';
             outer += '<span class="swatch colorLightVibrant" style="margin:3px;"></span>';
             outer += '<span class="swatch colorLightVibrant" style="margin:3px;"></span>';
             outer += '<span class="swatch colorLightVibrant" style="margin:3px;"></span>';
             outer += '<span class="swatch colorLightVibrant" style="margin:3px;"></span>';
             outer += '<span class="swatch colorLightVibrant" style="margin:3px;"></span>';
             outer += '<span class="swatch colorLightVibrant" style="margin:3px;"></span>';
             outer += '<span class="swatch colorLightVibrant" style="margin:3px;"></span>';
             outer += '<span class="swatch colorLightVibrant" style="margin:3px;"></span>';
             outer += '<span class="swatch colorLightVibrant" style="margin:3px;"></span>';
             outer += '<span class="swatch colorLightVibrant" style="margin:3px;"></span>';
             outer += '<span class="swatch colorLightVibrant" style="margin:3px;"></span>';
             outer += '<span class="swatch colorLightVibrant" style="margin:3px;"></span>';
             outer += '<span class="swatch colorLightVibrant" style="margin:3px;"></span>';
             outer += '<span class="swatch colorLightVibrant" style="margin:3px;"></span>';
             outer += '<span class="swatch colorLightVibrant" style="margin:3px;"></span>';
             outer += '<span class="swatch colorLightVibrant" style="margin:3px;"></span>';
             outer += '<span class="swatch colorLightVibrant" style="margin:3px;"></span>';
             outer += '<div class="hw_infouse_01"><label class="hw_item_search_title">부류 </label>&nbsp;<select  class="item_search_select"  id="flwrgbn'+i+'"></select></div>';
             outer += '<div class="hw_infouse_01"><label class="hw_item_search_title">품목</label>&nbsp;<input class="AXInput" id="txtMok'+i+'" style="height:30px;width:160px;"  aria-label="Color Input" aria-describedby="inputGroup-color-sm"></div>';
             outer += '<div class="hw_infouse_01"><label class="hw_item_search_title">품종</label>&nbsp;<input class="AXInput" id="txtJong'+i+'" style="height:30px;width:160px;"  aria-label="Color Input" aria-describedby="inputGroup-color-sm"><span id="pumCode'+i+'"></span></div>';
             outer += '<div class="hw_infouse_01">';
           	 outer += '<label class="" id="inputGroup-sizing-sm">색상</label>&nbsp;';
           	 outer += '<input class="AXInput"  id="colorTxt'+i+'"  style="height:30px;width:160px;"  aria-label="Color Input" aria-describedby="inputGroup-color-sm">';
             outer += '</div></div></div>';
			 console.log(outer)
             $('.results-section.results--grid')[0].innerHTML += outer;
            loadColorInfo('previewImg'+i);
            i++;
        	}})
        
        getCommonCode();
    }
   
   
   function loadColorInfo(imgId){
	   var img = document.getElementById(imgId);
	   const img2 = new ColorThief();
	   setTimeout(() => {
		   var colors = (img2.getPalette(img, 24));
		   for(var i=0;i<colors.length;i++){
			   console.log(colors[i])
		    	$('#'+imgId).parent().siblings().find('.swatch:eq('+i+')')[0].style.backgroundColor = 'rgb(' + colors[i] + ')';
		   } 
		   eventOnImage();
	   }, 2000);

	   

	   
	   
	   
	   
	   return false;
	   
	   
	   //////var img = document.getElementById(imgId);
	   
	   img.addEventListener('load', function() {
		    var vibrant = new Vibrant(img);
		    var swatches = vibrant.swatches()
		    var hexas = [];
		    for (var swatch in swatches){
		    	if (swatches.hasOwnProperty(swatch) && swatches[swatch]){
	            	console.log(swatch, swatches[swatch].getHex())
	            	console.log(swatch, swatches[swatch].getTitleTextColor())
	            	console.log(swatch, swatches[swatch].getBodyTextColor())
	            	console.log(swatch, swatches[swatch].getRgb())
		            hexas.push(swatches[swatch].getHex());
		        }
		    }
		    
		    for(var i=0;i<hexas.length;i++){
		    	$('#'+imgId).parent().siblings().find('.swatch:eq('+i+')')[0].style.backgroundColor = hexas[i];
		    }
	        $.each($('.swatch'),function(i,v){
            	//v.style.backgroundColor = swatches[swatch].getHex()
            });
		});
   }
	
   function validate(){
	   let psize = $('.results-section.results--grid').find('.profile').size();
	   
	   if($('.profile__info .swatch.active').size() != psize){
		   alert("컬러 팔레트를 선택하지 않은 항목이 있습니다.");
		   return;
	   }
	   
	   for(var i=1;i<=psize;i++){
		   let colorTxt = $.trim($('#colorTxt'+i).val());
		   let txtJong = $.trim($('#txtJong'+i).val());
		   if(colorTxt == ""){
			   alert("색상을 입력하십시오");
			   $('#colorTxt'+i).focus();
			   return;
		   
		   }
		   if(txtJong == ""){
			   alert("품종을 입력하십시오");
			   $('#txtJong'+i).focus();
			   return;
		   }
	   }
	   
	   for(var i=0;i<psize;i++){
		   let formData= new FormData();
		   let request = new XMLHttpRequest();
		   let fileInfo = $('#inputGroupFile01')[0].files[i];
		   let rgbColor = $('.profile__info:eq('+i+') .swatch.active').css('background-color');
		   let colorTxt = $.trim($('#colorTxt'+(i+1)).val());
		   let txtJong = $.trim($('#txtJong'+(i+1)).val());
		   let cdId = $('#flwrgbn'+(i+1)+' option:selected').attr('cdid');
		   
		   if(rgbColor == 'rgba(0, 0, 0, 0)')rgbColor = 'rgb(255,255,255)';
			   
		   formData.set('cdId',cdId);
		   formData.set('colorTxt',colorTxt);
		   formData.set('rgbColor',rgbColor);
		   formData.set('txtJong',txtJong);
		   formData.set('file',fileInfo);
		   
		   request.onreadystatechange = () => {
			   
			   if (request.readyState === 4) {
				
			       callbackForUpload(request.responseText,(i));
			   }
		   };
		   
		   request.addEventListener("progress", function(e){ 
			   $('#loading-indicator').show();
		       $('#loading-indicator-back').show();
		   },false);
		   
		   request.addEventListener("load", function(e){ 
			   $('#loading-indicator').hide();
		       $('#loading-indicator-back').hide();
		   });
		   
		   //request.open('POST','upload.json');
		   //request.send(formData);
		   
		   $.ajax({
			   url:"/admin/img/upload.json",
			   type:"post",
			   enctype: 'multipart/form-data',
			   data: formData,
			   dataType:'json',
			   processData: false,    
		       contentType: false,      
		       cache: false,   
			   success:callbackForUpload,
			   error:callbackForUpload,
				beforeSend: function(){
					$('#loading-indicator').show();
					$('#loading-indicator-back').show();
				},
				complete: function(){
					$('#loading-indicator').hide();
					$('#loading-indicator-back').hide();
				}
		   })
		   
	   }
   }
   
   function callbackForUpload(res){
	   console.log(res)
	   if(res.msg.indexOf("오류") != -1){
		   toast.push({body:res.msg,type:"Caution"})
		   return false;
	   }

	   toast.push(res.msg); 
	   location.reload();
	   //location.href = "/admin/img/getImgList.do";
	   
   }
   
	// 이메일 등록 처리
	function sendEmail1111111(){
		/* if($("input[name=sender]").val() ==""){
			alert("보내는 사람을 입력해주시기 바랍니다.");
			$("input[name=sender]").focus();
			return false;
		} */
		if($("input[name=address]").val() ==""){
			alert("받는 사람을 입력해주시기 바랍니다.");
			$("input[name=address]").focus();
			return false;
		}
		if($("input[name=title]").val() ==""){
			alert("제목을 입력해주시기 바랍니다.");
			$("input[name=title]").focus();
			return false;
		}
		var cont = $('#edit').val();
		if(cont =="<p>&nbsp;</p>" || cont =="<p></p>" || cont == "" || cont == "<p><br></p>"){
			alert("내용을 입력해주시기 바랍니다.");
			$('#edit').focus();
			return false;
		}
		
		/* if (!confirm('이메일을 발송하시겠습니까?\n다중전송의 경우 메일의 양에 따라 일정 시간이 걸릴 수 있습니다.')) return false;
		
		$("#emailCreateFrm input[name=multiMail]").val($('.mailListInput').val());
		$("#emailCreateFrm").ajaxFormUnbind();
		// 에디터일때
		$("#emailCreateFrm input[name=conHtml]").val(cont);  
		
		ajaxFileFrm("emailCreateFrm", "emailCreateProc" );
		$("#emailCreateFrm").attr("action", "/sendEmail/createProc.do");
		$("#emailCreateFrm").submit(); */
		var address = $("#address").val();
		var title = $("#title").val();
		$.ajax({
			type: "POST",
			url: "/send/sendEmailTranferInsert.json",
			data: {
				address:address,
				title : title,
				cont : cont
			},
			success: function(res) {
				alert("발송을 완료하였습니다.");
				$("#address").val("");
				$("#title").val("");
				$("#edit").val("");
			}
		});
		
		return false;
	}
	function moveToImgList(){
		location.href = "/admin/img/getImgList.do";
	}
</script>



</head>
<body>
<div id="loading-indicator"></div>
<div id="loading-indicator-back"></div>
	<%@ include file="/WEB-INF/inc/IncHeader.jsp"%>
	<article>
		<div class="wrap">
			<%@ include file="/WEB-INF/jsp/inc/IncMenu.jsp"%>

			<div class="hw_content">
				<!--컨텐츠 내용들어가는곳 시작-->
				<h3 class="hw_h3_ma">
					<div class="half1_white"></div>
					<span class="half_title">이미지 업로드</span>
				</h3>
				<div class="hw_clear"></div>

				<div class="hw_infouse_01">
					<p>
						<span class="purple"> ◎ 이용안내 :</span>&nbsp;꽃이미지를 여러장 색상을 선택하여 올리거나
						엑셀로 일괄 업로드가 가능합니다.
					</p>
				</div>
				<div class="hw_clear"></div>

				<div class="ibox-content11111">
					<form id="emailCreateFrm" name="emailCreateFrm" method="post"
						class="form-horizontal1111111" enctype="multipart/form-data">
						<div class="emailBox111111">
						
		
		
							<input  style="float:left;width: 32.7%;height: 40px;font-size: 16px;line-height: 38px;color: white;background-color: blue;text-align: center;font-weight: bold;margin-left: 0%;margin-top: 2%;"   type="file" class="" id="inputGroupFile01"   onchange="preview(this)" multiple>
									
		

							<br />
							<hr>
							<br />

							<section class="results-section results--grid"></section>


						</div>
						<!-- emailBox end -->

						<!-- <textarea id="edit" name="edit" style="margin-top:0px;width:100%;height:300px;" placeholder="내용을 입력하여 주십시오."></textarea> -->
						<!-- <button type="button" class="btn btn-primary" onclick="validate()">업로드</button> -->
						<input style="float:right;width: 32.7%;height: 40px;font-size: 16px;line-height: 38px;color: white;background-color: blue;text-align: center;font-weight: bold;margin-right: 0%;margin-top: 2%;"   type="button" value="업로드" onclick="validate()">
						<input style="float:right;width: 32.7%;height: 40px;font-size: 16px;line-height: 38px;color: white;background-color: green;text-align: center;font-weight: bold;margin-right: 1%;margin-top: 2%;"  type="button" value="이미지조회화면" onclick="moveToImgList()">
						
					</form>
				</div>
			</div>
			<!--wrap 끝-->
	</article>
	<footer>
		<%@ include file="/WEB-INF/inc/IncFooter.jsp"%>
	</footer>
</body>
</html>