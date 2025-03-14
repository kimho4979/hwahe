<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />


	<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1, maximum-scale=1.0, minimum-scale=1" />
	<title>bindDate - AXISJ</title>

    <link rel="shortcut icon" href="../../ui/axisj.ico" type="image/x-icon" />
    <link rel="icon" href="../../ui/axisj.ico" type="image/x-icon" />
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="../../ui/AXJ.png" />
    <link rel="apple-touch-icon-precomposed" href="../../ui/AXJ.png" />
    <meta property="og:image" content="/samples/_img/axisj_sns.png" />
    <meta property="og:site_name" content="Axis of Javascript - axisj.com" />
    <meta property="og:description" id="meta_description" content="Javascript UI Library based on JQuery" />

    <link rel="stylesheet" type="text/css" href="../../ui/arongi/page.css">
    <link rel="stylesheet" type="text/css" href="../../ui/arongi/AXJ.min.css">

   <!--  <script type="text/javascript" src="../../jquery/jquery.min.js"></script> -->
   <!--  <script type="text/javascript" src="../../dist/AXJ.min.js"></script> -->
    <script type="text/javascript" src="<c:url value='/axisj/dist/AXJ.min.js' />"></script>
    <script type="text/javascript" src="<c:url value='/axisj/jquery/jquery.min.js' />"></script>
    <script type="text/javascript" src="<c:url value='/axisj/lib/AXCore.js' />"></script>
    <script type="text/javascript" src="<c:url value='/axisj/lib/AXInput.js' />"></script>
   <!--  <script type="text/javascript" src="../../lib/AXCore.js"></script>
    <script type="text/javascript" src="../../lib/AXInput.js"></script> -->
    
    <script type="text/javascript" src="../page.js"></script>
    <script type="text/javascript" src="pageTab.js"></script>
    <!-- js block -->
	<script>
	/**
	 * Require Files for AXISJ UI Component...
	 * Based		: jQuery
	 * Javascript 	: AXJ.js, AXInput.js
	 * CSS			: AXJ.css, AXInput.css
	 */	
	var pageID = "Date";
	var fnObj = {
		pageStart: function(){

			$("#AXInputDate").bindDate({align:"right", valign:"bottom", separator:"/", defaultSelectType:"m", onchange:function(){
                toast.push(Object.toJSON(this));
            }});
			$("#AXInputDateMiddle").bindDate({align:"left", valign:"middle", onChange:function(){
                toast.push(Object.toJSON(this));
            }});
			$("#AXInputDateMiddle2").bindDate({align:"center", valign:"middle", onChange:function(){
                toast.push(Object.toJSON(this));
            }});
			$("#AXInputDateRight").bindDate({
                align:"right",
                valign:"top",
                onChange:function(){
                    toast.push(Object.toJSON(this));
                },
                minDate:"2013-05-10",
                maxDate:"2013-05-20",
                defaultDate:"2013-05-15"
            });
			
			$("#AXInputDate2").bindDate({separator:"/", selectType:"m"});
			$("#AXInputDate3").bindDate({selectType:"y"});
			
			$("#AXInputDate4").bindDateTime({
				onChange:function(){
					//toast.push(Object.toJSON(this));
				}
			});

            $("#AXInputDateED").bindTwinDate({
                startTargetID: "AXInputDateST",
                handleLeft: 25,
                align: "right",
                valign: "bottom",
                separator: "/",
                buttonText: "선택",
                onChange: function () {
                    //toast.push(Object.toJSON(this));
                },
                onBeforeShowDay: function (date) {
                    if (date.getDay() == 3) {
                        return { isEnable: false, title: "수요일 선택불가", className: "", style: "" };
                    }
                }
            });
			
			$("#AXInputDateYED").bindTwinDate({align:"right", valign:"bottom", separator:"/", startTargetID:"AXInputDateYST", selectType:"y", onChange:function(){
                //toast.push(Object.toJSON(this));
            }});
			
			$("#AXInputDateMED").bindTwinDate({align:"right", valign:"bottom", separator:"/", startTargetID:"AXInputDateMST", selectType:"m", onChange:function(){
                //toast.push(Object.toJSON(this));
            }});
			
			$("#AXInputDateTimeED").bindTwinDateTime({align:"right", valign:"top", separator:"/", startTargetID:"AXInputDateTimeST", onChange:function(){
                //toast.push(Object.toJSON(this));
            }});

			$("#AXInputDate_earlier").bindDate({align:"right", valign:"bottom", onChange:{
					earlierThan:"AXInputDate_later", err:"종료일보다 빠른 날짜를 선택하세요", 
					onChange:function(){
				
					}
				}
			});
			$("#AXInputDate_later").bindDate({align:"right", valign:"bottom",
                onChange:{
                    laterThan:"AXInputDate_earlier", err:"시작일보다 느린 날짜를 선택하세요"
                }
            });
		},
        unbindInput: function () {
            $("#AXInputDate").unbindInput();
        },
        bindInput: function () {
            $("#AXInputDate").bindDate({align:"right", valign:"top", separator:"/", onChange:function(){toast.push(Object.toJSON(this));}});
        }
	};
	jQuery(document.body).ready(function(){fnObj.pageStart()});
	</script>

	<style type="text/css">
	
	</style>
</head>
	
<body>

<div id="AXPage">

	<div id="AXPageBody" class="SampleAXInput">
        <div id="demoPageTabTarget" class="AXdemoPageTabTarget"></div>
		<div class="ax-wrap AXdemoPageContent">
			<div class="title"><h1>AXInput</h1></div>
			<!-- s.axlayer 1 -->		
			<section class="ax-layer-1">
				<div class="ax-col-12">
					<div class="ax-unit">
						<h2>AXInput</h2>

						<input type="button" value="AXInputDate unbind" class="AXButton Red" onclick="fnObj.unbindInput();" />
						<input type="button" value="AXInputDate bind" class="AXButton Red" onclick="fnObj.bindInput();" />

						<h3>bind bind Date</h3>
						<input type="text" name="" id="AXInputDate" class="AXInput W100" readonly="readonly" />
						<input type="text" name="" id="AXInputDateMiddle" class="AXInput W100" disabled="disabled" />
						<input type="text" name="" id="AXInputDateMiddle2" class="AXInput W100" />
						<input type="text" name="" id="AXInputDateRight" class="AXInput W100" />
						
						<div class="H20"></div>
						
						<h3>bind Date (year, month)</h3>
						<input type="text" name="" id="AXInputDate2" class="AXInput W70" />
						<input type="text" name="" id="AXInputDate3" class="AXInput W50" />
						
						<div class="H20"></div>
						
						<h3>bind DateTime</h3>
						<input type="text" name="" id="AXInputDate4" class="AXInput W140" onchange="console.log('AXInputDate4 change');" />
		
						<div class="H20"></div>
						
						<h3>bind TwinDate</h3>
						<input type="text" name="" id="AXInputDateST" class="AXInput W80" /> ~ <input type="text" name="" id="AXInputDateED" class="AXInput W100" />
						
						<div class="H20"></div>
										
						<div class="inlineBlock"><input type="text" name="" id="AXInputDateYST" class="AXInput W50" /> ~ <input type="text" name="" id="AXInputDateYED" class="AXInput W50" />
				
						<div class="H20"></div>
						
						<input type="text" name="" id="AXInputDateMST" class="AXInput W70" /> ~ <input type="text" name="" id="AXInputDateMED" class="AXInput W70" />
				
						<div class="H20"></div>
				
						<h2>bind TwinDateTime</h2>
				
						<input type="text" name="" id="AXInputDateTimeST" class="AXInput W140" /> ~ <input type="text" name="" id="AXInputDateTimeED" class="AXInput W140" />
						
						<div class="H20"></div>
				
						<h2>Abind earlierThan / laterThan</h2>
				
						<input type="text" name="" id="AXInputDate_earlier" class="AXInput W100" /> ~ <input type="text" name="" id="AXInputDate_later" class="AXInput W100" />
						
						<div class="H30"></div>	
						
					</div>	
				</div>
				<div class="ax-clear"></div>
			</section>
			<!-- e.axlayer 1 -->
			<div class="ax-clear"></div>							
	
		</div>
		<div class="H20"></div>		
	</div>

</div>

</body>
</html>		