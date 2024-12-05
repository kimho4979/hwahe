<%@ page language="java" contentType="application/octet-stream; charset=utf-8" %>
<%@ page import="sun.misc.BASE64Decoder" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%
	Date date = new Date();

	String data = request.getParameter("data");
	String fileName = request.getParameter("fileName"); // 사용자가 저장 할 때의 파일 이름
	String extension = request.getParameter("extension");
	String updir = request.getServerName() + "경로";
	String userIp = request.getRemoteAddr();
	String filename = userIp + "_" + date.getTime()  + "." + extension;
	String filePath = "경로" + filename;
	String path = "";

	File f = new File(filePath);

	if(!f.exists())
	{
		response.setContentType("application/" + extension);
		response.setHeader("Content-Disposition", "attachment;filename=" + fileName +"." + extension + ";");

		f.createNewFile();

		byte[] byteFile;
		if(extension.equals("csv")){
			byteFile = data.getBytes();
		}else{
			BASE64Decoder decoder = new BASE64Decoder();
			byteFile = decoder.decodeBuffer(data);
		}

		FileOutputStream fileoutputstream = new FileOutputStream(f);

		for(int i=0,len=byteFile.length; i<len; ++i){
			fileoutputstream.write(byteFile[i]);
		}

		fileoutputstream.close();

		File file = new File(filePath);

		if(file.exists()){
			byte b[] = new byte[(int)file.length()];

			BufferedInputStream bis = new BufferedInputStream(new FileInputStream(file));
			BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());

			int read = 0;
			while((read = bis.read(b)) != -1){
				bos.write(b, 0, read);
			}

			bos.close();
			bis.close();
			
			try{
			//	f.delete();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
	}
%>

