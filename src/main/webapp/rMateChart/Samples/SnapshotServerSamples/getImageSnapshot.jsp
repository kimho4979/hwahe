<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import="sun.misc.BASE64Decoder" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%
	String data = request.getParameter("data");
	String extension = request.getParameter("extension");
	String updir = request.getServerName() + "/chartTest/savedImage/";
	Date date = new Date();
	
	String userIp = request.getRemoteAddr();

	String filename = userIp + "_" + date.getTime()  + "." + extension;
	
	String filePath = "/var/www/html/chartTest/savedImage/" + filename;

	File f = new File(filePath);
	String path = "";
	if(!f.exists())
	{
		f.createNewFile();

		BASE64Decoder decoder = new BASE64Decoder();
		byte[] byteFile = decoder.decodeBuffer(data);
		
		FileOutputStream fileoutputstream = new FileOutputStream(f);

		for (int i=0,len=byteFile.length; i<len; ++i) 
		{
			fileoutputstream.write(byteFile[i]);
		}
		fileoutputstream.close();
		
		path=updir+filename;

//		response.getWriter().write(path);
//		out.print(path);
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta http-equiv="Content-Script-Type" content="text/javascript"/>
<meta http-equiv="Content-Style-Type" content="text/css"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>

<!-- rMateChartH5 에서 사용하는 스타일 -->
<link rel="stylesheet" type="text/css" href="http://demo.riamore.net/HTML5demo/chart/rMateChartH5/Assets/Css/rMateChartH5.css"/>
<link rel="stylesheet" type="text/css" href="http://demo.riamore.net/HTML5demo/chart/Samples/Web/sample.css"/>

<title>rMate Chart for HTML5</title>

</head>
<body>
	<div class="wrapper">
		<div class="header">
			<div class="headerTitle">서버로 이미지 전송 완료</div>
		</div>
		<div id="content">
			<img src="http://<%=path%>"/>
		</div>
		<div class="description">
			경로 : <%=path%><br><br>
			<span class="warning"><b>IE7,8 에서는 이미지 변환 및 전송기능이 지원되지 않습니다.<br>자세한 사항은 html 소스를 참고하시기 바랍니다.</b></span>
		</div>
	</div>
</body>
</html>