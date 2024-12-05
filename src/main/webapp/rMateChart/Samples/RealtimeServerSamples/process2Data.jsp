<%@ page language="java" contentType="text/xml; charset=utf-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
Random myRandom = new Random();
Date date = new Date();

int data = 100;
int tempData = myRandom.nextInt(50);

if(data * 0.5 < myRandom.nextInt(100))
	data = data - tempData;
else
	data = data + tempData;

// 데이트 포맷 형식은 반드시 "2010/02/15 20:30:00" 형태로 하여주십시오.
SimpleDateFormat dateFmt = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");

out.println("<items>");
out.println("<item>");
out.println("<Time>"+dateFmt.format(date)+"</Time>");
out.println("<Data>"+data+"</Data>");
out.println("</item>");
out.println("</items>");
%>
