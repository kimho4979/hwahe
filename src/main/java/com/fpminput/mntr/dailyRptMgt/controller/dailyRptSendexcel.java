package com.fpminput.mntr.dailyRptMgt.controller;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;
import javax.mail.util.ByteArrayDataSource;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.ss.util.RegionUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.fpdisys.admin.data.service.ConfigService;
import com.fpdisys.dist.report.mapper.ReportMapper;
import com.fpdisys.dist.report.service.CommonExcel;
import com.fpdisys.dist.report.service.ReportService;
import com.fpminput.mntr.dailyRptMgt.service.DailyRptMgtService;
import com.fpminput.mntr.dailyRptSend.service.DailyRptSendService;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service
public class dailyRptSendexcel {
	
	@Autowired
	private ConfigService configService;
	
	@Autowired
	ReportService reportService;
	@Autowired
	ReportMapper reportMapper;
	@Autowired
	CommonExcel commonExcel;
	
	@Autowired
	DailyRptSendService dailyRptSendService;
	
	@Autowired
	DailyRptMgtService dailyRptMgtService;
	
	public String mailSend(String receiver, Workbook dayPumAuc_excel,Workbook mainFlowerAuc_excel,Workbook dayAuc_excel) {
		Properties props = new Properties();
		props.put("mail.transport.protocol", "smtp");
		props.put("mail.smtp.host", "211.251.247.124");
		props.put("mail.smtp.port", "25");
		props.put("mail.smtp.auth", "true");
		props.setProperty("mail.smtp.quitwait", "false");
		
//		props.put("mail.smtp.host", "smtp.gmail.com"); 
//		props.put("mail.smtp.port", 465); 
//		props.put("mail.smtp.auth", "true"); 
//		props.put("mail.smtp.ssl.enable", "true"); 
//		props.put("mail.smtp.ssl.trust", "smtp.gmail.com");

		Session session = Session.getInstance(props, new Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
//				return new PasswordAuthentication("goeyu0213@gmail.com", "xsflmlvhuuxcnspk");
				return new PasswordAuthentication("atflower@at.or.kr", "atmail23$%");
			}
		});

		//session 생성 및  MimeMessage생성
		MimeMessage msg = new MimeMessage(session);
		
		MimeMessage mimeMessage = new MimeMessage(session);

		try {
			
			mimeMessage.setSentDate(new Date());// 보내는 날짜 지정
			mimeMessage.setFrom(new InternetAddress("atflower@at.or.kr", "관리자", "utf-8"));
            // 수신자의 메일을 생성한다.
			

			InternetAddress receiverAddress = new InternetAddress();
			receiverAddress =  new InternetAddress(receiver);


			mimeMessage.setRecipient(Message.RecipientType.TO, receiverAddress); //수신정보 설정

			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy.MM.dd");
			Date now = new Date();
			String nowStr = dateFormat.format(now);
			
			String title = "[한국농수산식품유통공사]주요 절화류 도매가격 동향(" + nowStr + ")";
			mimeMessage.setSubject(title, "UTF-8");             // 메일의 제목 지정		
			Multipart mp = new MimeMultipart(); //멀티파트 객체 생성
			
			
			
			
			String content = "안녕하세요.<br/>" + 
							 "ㅤ<br/>"+
							 nowStr+" 주요 절화류 도매가격 동향을 송부드립니다.<br/>"+
							 "ㅤ<br/>"+
							 "감사합니다. 즐거운 하루 되세요. <br/>"+
							 "ㅤ<br/>"+
							 "  <br/>";
			System.out.println(" ===== file info body info setting . . .  ===== ");
			MimeBodyPart mbp1 = new MimeBodyPart();
			mbp1.setContent(content, "text/html; charset=utf-8"); //메일 내용 셋팅
			mp.addBodyPart(mbp1); // 파일송신시 보이는 텍스트 파일 멀티파트 담는다.
			
			dateFormat = new SimpleDateFormat("yyyyMMdd");
			now = new Date();
			nowStr = dateFormat.format(now);
			
			Workbook[] wb_array = {dayPumAuc_excel, mainFlowerAuc_excel, dayAuc_excel};
			String[] excel_name = {nowStr+"_daily.xls", nowStr+"_주요_절화류_도매가격_동향.xls", nowStr+"_daily_2.xls"};
			
			for(int i=0; i<wb_array.length; i++) {
				ByteArrayOutputStream bos = new ByteArrayOutputStream();
				wb_array[i].write(bos);
				
				DataSource fds = new ByteArrayDataSource(bos.toByteArray(), "application/vnd.ms-excel");
				MimeBodyPart attachment = new MimeBodyPart();
				attachment.setFileName(MimeUtility.encodeText(excel_name[i], "UTF-8","B"));  // 파일이름설정
				attachment.setDataHandler(new DataHandler(fds)); // 전달파일 핸들러			
				
				//멀티파트 형식으로 파일정보 추가
				mp.addBodyPart(attachment);
				//메일 전달내용에 해당 멀티파트(엑셀파일) 정보 추가
				mimeMessage.setContent(mp);
			}
			
			mimeMessage.setContent(mp);
			System.out.println(" ===== file info setting end  ===== ");
			//메일 발송
			Transport.send(mimeMessage);
		} catch (AddressException ae) {
			System.out.println("AddressException : " + ae);
			return "fail";
		} catch (MessagingException me) {
			System.out.println("MessagingException : " + me);
			return "fail";
		} catch (UnsupportedEncodingException e) {
			System.out.println("UnsupportedEncodingException : " + e);
			return "fail";
		} catch(IOException e){
			System.out.println("IOException : " + e);
			return "fail";
		}
		return "success";
	}
	
	
	
	public String excelTest(){
		System.out.println("엑셀테스트시작");
		try{
			//get_dayAuc_excel("20221008");
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}
	
	//date:yyyy-MM-dd
	public HSSFWorkbook get_dayAuc_excel(String date) {
		System.out.println("get_dayAuc_excel start");
		Map<String, Object> pRequestParamMap = new HashMap<String, Object>();
		pRequestParamMap.put("searchYear", date.substring(0, 4));
		
		String filename =  "일별 경매실적";
		
		HSSFWorkbook workbook = commonExcel.createWorkbook();
		HSSFSheet sheet = commonExcel.createSheet(workbook, "절화류");
		pRequestParamMap.put("searchYear", pRequestParamMap.get("searchYear"));
		pRequestParamMap.put("pumName", "절화류");
		setSheetDayAuc(reportMapper.selectDayAucList(pRequestParamMap), workbook, sheet, pRequestParamMap);
		
		commonExcel.autoSizeSheet(sheet);
		
		try{
			System.out.println("get_dayAuc_excel success");
		} catch(Exception e){
			e.printStackTrace();
		}
		
		
		return workbook;
	}

	public void setSheetDayAuc(List<EgovMap> list, HSSFWorkbook workbook, HSSFSheet sheet, Map<String, Object> requestParam) {
		if(list != null) {
			if(list.size() > 0) {
				
				HSSFRow title = sheet.createRow(0);
			
				title.createCell(0).setCellValue("경매일자");
				title.createCell(1).setCellValue("금년출하물량");
				title.createCell(2).setCellValue("금년거래물량");
				title.createCell(3).setCellValue("금년유찰물량");
				title.createCell(4).setCellValue("금년단가");
				title.createCell(5).setCellValue("전년출하물량");
				title.createCell(6).setCellValue("전년거래물량");
				title.createCell(7).setCellValue("전년유찰물량");
				title.createCell(8).setCellValue("전년단가");
				title.createCell(9).setCellValue("출하량증감");
				title.createCell(10).setCellValue("거래량증감");
				title.createCell(11).setCellValue("유찰증감");
				title.createCell(12).setCellValue("단가증감");
				title.createCell(13).setCellValue("평년출하물량");
				title.createCell(14).setCellValue("평년거래물량");
				title.createCell(15).setCellValue("평년유찰물량");
				title.createCell(16).setCellValue("평년단가");
				title.createCell(17).setCellValue("출하량증감");
				title.createCell(18).setCellValue("거래량증감");
				title.createCell(19).setCellValue("유찰증감");
				title.createCell(20).setCellValue("단가증감");
				
				HSSFCellStyle style = workbook.createCellStyle();
			    style.setFillForegroundColor(IndexedColors.YELLOW.getIndex());  // 배경색
			    style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
				style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				style.setBorderTop(HSSFCellStyle.BORDER_THIN);
				style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				style.setBorderRight(HSSFCellStyle.BORDER_THIN);
				for(int i=5;i<13;i++){
					title.getCell(i).setCellStyle(style);
				}
				
				HSSFCellStyle style2 = workbook.createCellStyle();
				style2.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());  // 배경색
			    style2.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
				style2.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				style2.setBorderTop(HSSFCellStyle.BORDER_THIN);
				style2.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				style2.setBorderRight(HSSFCellStyle.BORDER_THIN);
				for(int i=13;i<21;i++){
					title.getCell(i).setCellStyle(style2);
				}
				
			
				
				for (int i=0; i<list.size(); i++) {
					
					HSSFRow row = sheet.createRow(i+1);
					
					row.createCell(0).setCellValue(String.valueOf(list.get(i).get("mmdd")));
					row.createCell(1).setCellValue(String.valueOf(list.get(i).get("totCnt")));
					row.createCell(2).setCellValue(String.valueOf(list.get(i).get("panCnt")));
					row.createCell(3).setCellValue(String.valueOf(list.get(i).get("yuchalCnt")));
					row.createCell(4).setCellValue(String.valueOf(list.get(i).get("avgAmt")));
					row.createCell(5).setCellValue(String.valueOf(list.get(i).get("preTotCnt")));
					row.createCell(6).setCellValue(String.valueOf(list.get(i).get("prePanCnt")));
					row.createCell(7).setCellValue(String.valueOf(list.get(i).get("preYuchalCnt")));
					row.createCell(8).setCellValue(String.valueOf(list.get(i).get("preAvgAmt")));
					row.createCell(9).setCellValue(String.valueOf(list.get(i).get("preTotCntPer")));
					row.createCell(10).setCellValue(String.valueOf(list.get(i).get("prePanCntPer")));
					row.createCell(11).setCellValue(String.valueOf(list.get(i).get("preYuchalCntPer")));
					row.createCell(12).setCellValue(String.valueOf(list.get(i).get("preAvgAmtPer")));
					row.createCell(13).setCellValue(String.valueOf(Math.round(Float.parseFloat(String.valueOf(list.get(i).get("avgTotCnt"))))));
					row.createCell(14).setCellValue(String.valueOf(Math.round(Float.parseFloat(String.valueOf(list.get(i).get("avgPanCnt"))))));
					row.createCell(15).setCellValue(String.valueOf(Math.round(Float.parseFloat(String.valueOf(list.get(i).get("avgYuchalCnt"))))));
					row.createCell(16).setCellValue(String.valueOf(list.get(i).get("avgAvgAmt")));
					row.createCell(17).setCellValue(String.valueOf(list.get(i).get("avgTotCntPer")));
					row.createCell(18).setCellValue(String.valueOf(list.get(i).get("avgPanCntPer")));
					row.createCell(19).setCellValue(String.valueOf(list.get(i).get("avgYuchalCntPer")));
					row.createCell(20).setCellValue(String.valueOf(list.get(i).get("avgAvgAmtPer")));
					
					for(int z=5;z<13;z++){
						
						row.getCell(z).setCellStyle(style);
					}
					
					
					
					
					for(int z=13;z<21;z++){
						
						row.getCell(z).setCellStyle(style2);
					}
				}
			
			}
		}
	}
	
	//date:yyyy-MM-dd
	public Workbook get_mainFlowerAuc_excel(String date) {
		System.out.println("get_mainFlowerAuc_excel start");
		
		HashMap<String, Object> pRequestParamMap = new HashMap<String, Object>();
		pRequestParamMap.put("cmpCd", "0000000001");
		pRequestParamMap.put("searchTime", "7");
		pRequestParamMap.put("searchStrDate", date);
		
		Workbook wb = new HSSFWorkbook();
		try{
			String excelNm = "주요절화류도매가격동향";
			
			// 워크북 생성
			Sheet sheet = wb.createSheet(excelNm);
			Row row = null;
			Cell cell = null;
			int rowNo = 0;
			
			// 1.셀 스타일 및 폰트 설정
			CellStyle style = wb.createCellStyle();
			style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
	
			CellStyle LineBreakStyle = wb.createCellStyle();
			LineBreakStyle.setWrapText(true);
	
			CellStyle blueStyle = wb.createCellStyle();
			blueStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
	
			CellStyle redStyle = wb.createCellStyle();
			redStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
	
			// 폰트 색상 설정
			HSSFFont blueFont = (HSSFFont) wb.createFont();
			blueFont.setColor(HSSFColor.BLUE.index);
			blueStyle.setFont(blueFont);
	
			HSSFFont RedFont = (HSSFFont) wb.createFont();
			RedFont.setColor(HSSFColor.RED.index);
			redStyle.setFont(RedFont);
	
			
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String searchDate = pRequestParamMap.get("searchStrDate").toString();
			Date to = sdf.parse(searchDate);
			int iday = Integer.parseInt(pRequestParamMap.get("searchStrDate").toString().substring(8,10));
			
			String check = "";
			String sun = "";
	        if(iday < 11){
	            check = "1";
	            sun = "상순";
	        }else if(10 < iday && iday < 21){
	            check = "2";
	            sun = "중순";
	        }else{
	            check = "3";
	            sun = "하순";
	        }
	        pRequestParamMap.put("sCheck", check);
			List<EgovMap> list = selectDynamicMainFlowerAuc(pRequestParamMap);
			String beforeHoliday = reportMapper.selectTsaleHolidayBefore(pRequestParamMap);
			
			Calendar preYear = Calendar.getInstance();
			Calendar preMonth = Calendar.getInstance();
			
			preYear.setTime(to);
			preMonth.setTime(to);
			
			preYear.add(Calendar.YEAR, -1);
			preMonth.add(Calendar.MONTH, -1);
			
			String preYearStr = sdf.format(preYear.getTime());
			String preMonthStr = sdf.format(preMonth.getTime());
					
//			String preYear = sdf.format(strDate.getTime()).substring(0,4);
//			String preMonth = sdf.format(strDate.getTime()).substring(5,7);
			
			//헤더 생성
			row = sheet.createRow(rowNo++);
			cell = row.createCell(0);
			cell.setCellValue("품목");
			cell = row.createCell(1);
			cell.setCellValue("단위");
			cell = row.createCell(2);
			cell.setCellValue("평년 "+searchDate.substring(5,7)+sun+"(A)");
			cell = row.createCell(3);
			cell.setCellValue(preYearStr.substring(2,4)+"년"+preYearStr.substring(5,7)+"월"+sun+"(B)");
			cell = row.createCell(4);
			cell.setCellValue(preMonthStr.substring(2,4)+"년"+preMonthStr.substring(5,7)+"월"+sun+"(C)");
			cell = row.createCell(5);
			if(check.equals("1")){
				cell.setCellValue(preMonthStr.substring(2,4)+"년"+preMonthStr.substring(5,7)+"월"+"하순 (D)");
			}else if(check.equals("2")){
				cell.setCellValue(searchDate.substring(2,4)+"년"+searchDate.substring(5,7)+"월"+"상순(D)");
			}else{
				cell.setCellValue(searchDate.substring(2,4)+"년"+searchDate.substring(5,7)+"월"+"중순(D)");
			}

		    String beforeDate = beforeHoliday.substring(5,beforeHoliday.length());
		    
			cell = row.createCell(6);
			cell.setCellValue(beforeDate+"(전일)");
			cell = row.createCell(7);
			cell.setCellValue(searchDate+"(E)");
			cell = row.createCell(8);
			cell.setCellValue("평년(E/A)");
			cell = row.createCell(9);
			cell.setCellValue("전년(E/B)");
			cell = row.createCell(10);
			cell.setCellValue("전월(E/C)");
			cell = row.createCell(11);
			cell.setCellValue("전순(E/D)");
			
			//데이터
			for(EgovMap vo : list) {
				row = sheet.createRow(rowNo++);
				cell = row.createCell(0);
				cell.setCellValue(vo.get("pumName").toString());
				cell = row.createCell(1);
				cell.setCellValue(vo.get("dan").toString());
				cell = row.createCell(2);
				cell.setCellValue(vo.get("cyAvg").toString());
				cell = row.createCell(3);
				cell.setCellValue(vo.get("preyAvg").toString());
				cell = row.createCell(4);
				cell.setCellValue(vo.get("premAvg").toString());
				cell = row.createCell(5);
				cell.setCellValue(vo.get("sdayAvg").toString());
				cell = row.createCell(6);
				cell.setCellValue(vo.get("ydayAvg").toString());
				cell = row.createCell(7);
				cell.setCellValue(vo.get("todayAvg").toString());
				cell = row.createCell(8);
				cell.setCellValue(vo.get("cyPer").toString());
				cell = row.createCell(9);
				cell.setCellValue(vo.get("preyPer").toString());
				cell = row.createCell(10);
				cell.setCellValue(vo.get("premPer").toString());
				cell = row.createCell(11);
				cell.setCellValue(vo.get("sdayPer").toString());
			}
			
			   
			// ?.1 데이터가 존재하는 셀의 영역 구하기
			ArrayList<ArrayList<String>> frame = new ArrayList<ArrayList<String>>();
			int rows = sheet.getPhysicalNumberOfRows();
			for(int i=0; i<rows; i++) {
				Row row1 = sheet.getRow(i);
				if(row1 != null) {
					frame.add(new ArrayList<String>());
					int cells = row1.getPhysicalNumberOfCells();
					for(int j=0; j<cells; j++) {
						frame.get(i).add(row1.getCell(j).getStringCellValue());
						row1.getCell(j).setCellValue("");
					}
				}
			}
			
			
			// 제목 작성
			CellStyle title_style = wb.createCellStyle();
			title_style.setAlignment(CellStyle.ALIGN_CENTER); //가운데 정렬
			title_style.setVerticalAlignment(CellStyle.ALIGN_CENTER); //높이 가운데 정렬
			title_style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
			title_style.setFillPattern(CellStyle.SOLID_FOREGROUND);
			Font font = wb.createFont();
			font.setFontName("나눔고딕"); //글씨체
			font.setFontHeight((short)(16*20)); //사이즈
			font.setBold(true); //볼드 (굵게)
			
			title_style.setFont(font);
			// 데이터가 존재하는 영역에 굵은 테두리 그리기
			
			sheet.addMergedRegion(new CellRangeAddress(2,2,2,13));
			Row title_row = sheet.getRow(2);
			Cell title_cell = title_row.getCell(2);
			title_cell.setCellValue("주요 절화류 도매가격 동향");
			title_cell.setCellStyle(style);
			
			for(int i=2;i<=13;i++) {
				title_style.setBorderRight(CellStyle.BORDER_THIN);
				title_style.setBorderLeft(CellStyle.BORDER_THIN);
				title_style.setBorderTop(CellStyle.BORDER_THICK);
				title_style.setBorderBottom(CellStyle.BORDER_THICK);
				if(title_row.getCell(i) == null)
					title_row.createCell(i);
				title_row.getCell(i).setCellStyle(title_style);
			}
			
			// frame start 지점
			int w_s = 2;
			int h_s = 6;
			
			for(int i=0; i<frame.size(); i++) {
				if(sheet.getRow(i+h_s) == null)
					sheet.createRow(i+h_s);
				Row frame_row = sheet.getRow(i+h_s);
				for(int j=0; j<frame.get(i).size(); j++) {
					if(frame_row.getCell(j+w_s) == null)
						frame_row.createCell(j+w_s);
					Cell frame_cell = frame_row.getCell(j+w_s);
					frame_cell.setCellValue(frame.get(i).get(j));
					
				}
			}
			
			//23.07.05 위대한 주임님 요청 '출처' 표기
			sheet.createRow(frame.size() + h_s);
			Row refer_row = sheet.getRow(frame.size() + h_s);
			refer_row.createCell(w_s);
			refer_row.getCell(w_s).setCellValue("출처 : aT화훼공판장");
			
			CellStyle refer_style = wb.createCellStyle();
			Font refer_font = wb.createFont();
			refer_font.setFontName("나눔고딕");
			refer_font.setBold(true);
			refer_style.setFont(refer_font);
			sheet.getRow(frame.size() + h_s).getCell(w_s).setCellStyle(refer_style);
			
			
			CellStyle subtitle_style = wb.createCellStyle();
			subtitle_style.setAlignment(CellStyle.ALIGN_CENTER); //가운데 정렬
			subtitle_style.setVerticalAlignment(CellStyle.ALIGN_CENTER); //높이 가운데 정렬
			subtitle_style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
			subtitle_style.setFillPattern(CellStyle.SOLID_FOREGROUND);
			Font subtitle_font = wb.createFont();
			subtitle_font.setFontName("나눔고딕");
			subtitle_font.setBold(true);
			subtitle_style.setFont(subtitle_font);
			
			
			for(int i=5; i<=6; i++) {
				if(sheet.getRow(i) == null)
					sheet.createRow(i);
				for(int j=2; j<14; j++) {
					if(sheet.getRow(i).getCell(j) == null)
						sheet.getRow(i).createCell(j);
					
					sheet.getRow(i).getCell(j).setCellStyle(subtitle_style);
				}
			}
			for(int i=2; i<=9; i++)
				sheet.setColumnWidth(i, 16*256);
			
			for(int i=10; i<=13; i++){
				sheet.autoSizeColumn(i);
			}
			
			
			
			// 가격, 등락률 상단에 작성
			if(sheet.getRow(5) == null)
				sheet.createRow(5);
			if(sheet.getRow(5).getCell(5) == null)
				sheet.getRow(5).createCell(5);
			sheet.getRow(5).getCell(4).setCellValue("가격");
			sheet.addMergedRegion(new CellRangeAddress(5,5,4,9));
			
			if(sheet.getRow(5) == null)
				sheet.createRow(5);
			if(sheet.getRow(5).getCell(10) == null)
				sheet.getRow(5).createCell(10);
			
			sheet.getRow(5).getCell(10).setCellValue("등락률");
			sheet.addMergedRegion(new CellRangeAddress(5,5,10,13));
			
			sheet.addMergedRegion(new CellRangeAddress(5,6,2,2)); // 품목 셀 병합
			sheet.getRow(5).getCell(2).setCellValue("품목");
			sheet.addMergedRegion(new CellRangeAddress(5,6,3,3)); // 단위 셀 병합
			sheet.getRow(5).getCell(3).setCellValue("단위");
			
			CellRangeAddress date_range = new CellRangeAddress(5,5+frame.size(),2,13);
			RegionUtil.setBorderTop(CellStyle.BORDER_THICK, date_range, sheet, wb);
			RegionUtil.setBorderBottom(CellStyle.BORDER_THICK, date_range, sheet, wb);
			RegionUtil.setBorderLeft(CellStyle.BORDER_THICK, date_range, sheet, wb);
			RegionUtil.setBorderRight(CellStyle.BORDER_THICK, date_range, sheet, wb);
			
			date_range = new CellRangeAddress(6,6,2,13);
			RegionUtil.setBorderBottom(CellStyle.BORDER_DOUBLE, date_range, sheet, wb);
			
			
		} catch(ParseException e){
			System.out.println("get_mainFlowerAuc_excel fail");
			e.printStackTrace();
		}
		System.out.println("get_mainFlowerAuc_excel success");
		return wb;
	}
	//date:yyyy-MM-dd, searchEndDate
	public Workbook get_dayPumAuc_excel(String date) {
		Map<String, Object> pRequestParamMap = new HashMap<String, Object>();
		pRequestParamMap.put("excelNm", "일별 품목별 경매실적 및 동향");
		pRequestParamMap.put("searchTime", "7");
		
		pRequestParamMap.put("searchEndDate", date.replaceAll("-", ""));
		String excelNm = (String) pRequestParamMap.get("excelNm");
		// 워크북 생성
		Workbook wb = new HSSFWorkbook();
		Sheet sheet = wb.createSheet(date.substring(0,4).concat("년"));
		Sheet sheet2 = wb.createSheet(date.substring(0,4).concat("년-화환"));
		
		Row row = null;
		Cell cell = null;
		int rowNo = 0;
		
		Row row2 = null;
		Cell cell2 = null;
		int rowNo2 = 0;
		
		// 1.셀 스타일 및 폰트 설정
		CellStyle style = wb.createCellStyle();
		style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);

		CellStyle LineBreakStyle = wb.createCellStyle();
		LineBreakStyle.setWrapText(true);

		CellStyle blueStyle = wb.createCellStyle();
		blueStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);

		CellStyle redStyle = wb.createCellStyle();
		redStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);

		// 폰트 색상 설정
		HSSFFont blueFont = (HSSFFont) wb.createFont();
		blueFont.setColor(HSSFColor.BLUE.index);
		blueStyle.setFont(blueFont);

		HSSFFont RedFont = (HSSFFont) wb.createFont();
		RedFont.setColor(HSSFColor.RED.index);
		redStyle.setFont(RedFont);
		
		try{
			System.out.println("get_dayPumAuc_excel start");

			String searchStrDate = date.substring(0,4)+"0101";
			pRequestParamMap.put("searchStrDate", searchStrDate);
			pRequestParamMap.put("itemCd", null);
			pRequestParamMap.put("hwahwanYn", "N");
			
			List<EgovMap> list = reportService.selectDayPumAucExcel(pRequestParamMap);
			List<EgovMap> list2 = selectDynamicDayPumAucExcel2023(pRequestParamMap);
	
			// 헤더 생성 첫번째 시트  
			row = sheet.createRow(rowNo++); 
			cell = row.createCell(0);
			cell.setCellValue("연");
			cell = row.createCell(1);
			cell.setCellValue("월");
			cell = row.createCell(2);
			cell.setCellValue("일");
			cell = row.createCell(3);
			cell.setCellValue("품목");
			cell = row.createCell(4);
			cell.setCellValue("출하물량");
			cell = row.createCell(5);
			cell.setCellValue("판매물량");
			cell = row.createCell(6);
			cell.setCellValue("유찰물량");
			cell = row.createCell(7);
			cell.setCellValue("판매금액");
			cell = row.createCell(8);
			cell.setCellValue("평균단가");
			
			// 두번째 시트 
			row2 = sheet2.createRow(rowNo2++); 
			cell2 = row2.createCell(0);
			cell2.setCellValue("연");
			cell2 = row2.createCell(1);
			cell2.setCellValue("월");
			cell2 = row2.createCell(2);
			cell2.setCellValue("일");
			cell2 = row2.createCell(3);
			cell2.setCellValue("품목");
			cell2 = row2.createCell(4);
			cell2.setCellValue("출하물량");
			cell2 = row2.createCell(5);
			cell2.setCellValue("판매물량");
			cell2 = row2.createCell(6);
			cell2.setCellValue("유찰물량");
			cell2 = row2.createCell(7);
			cell2.setCellValue("판매금액");
			cell2 = row2.createCell(8);
			cell2.setCellValue("평균단가");
	
			// 데이터 첫번째 시트 
			for (EgovMap vo : list) {
				row = sheet.createRow(rowNo++);
				cell = row.createCell(0);
				cell.setCellValue(vo.get("year").toString());
				cell = row.createCell(1);
				cell.setCellValue(vo.get("month").toString());
				cell = row.createCell(2);
				cell.setCellValue(vo.get("day").toString());
				cell = row.createCell(3);
				cell.setCellValue(vo.get("pumName").toString());
				cell = row.createCell(4);
				cell.setCellValue(vo.get("totCnt").toString());
				cell = row.createCell(5);
				cell.setCellValue(vo.get("panCnt").toString());
				cell = row.createCell(6);
				cell.setCellValue(vo.get("yuchalCnt").toString());
				cell = row.createCell(7);
				cell.setCellValue(vo.get("totAmt").toString());
				cell = row.createCell(8);
				cell.setCellValue(vo.get("avgAmt").toString());
			}
			// 두번째 시트 
			for (EgovMap vo : list2) {
				row2 = sheet2.createRow(rowNo2++);
				cell2 = row2.createCell(0);
				cell2.setCellValue(vo.get("year").toString());
				cell2 = row2.createCell(1);
				cell2.setCellValue(vo.get("month").toString());
				cell2 = row2.createCell(2);
				cell2.setCellValue(vo.get("day").toString());
				cell2 = row2.createCell(3);
				cell2.setCellValue(vo.get("pumName").toString());
				cell2 = row2.createCell(4);
				cell2.setCellValue(vo.get("totCnt").toString());
				cell2 = row2.createCell(5);
				cell2.setCellValue(vo.get("panCnt").toString());
				cell2 = row2.createCell(6);
				cell2.setCellValue(vo.get("yuchalCnt").toString());
				cell2 = row2.createCell(7);
				cell2.setCellValue(vo.get("totAmt").toString());
				cell2 = row2.createCell(8);
				cell2.setCellValue(vo.get("avgAmt").toString());
			}
			System.out.println("get_dayPumAuc_excel success");
		}catch(Exception e){
			e.printStackTrace();
		}
		return wb;
	}
	public List<EgovMap> selectDynamicMainFlowerAuc(Map<String, Object> pRequestParamMap){
		//개발
//		String url = "jdbc:oracle:thin:@175.106.91.132:1521:flower";
//		String id = "flower";
//		String pw = "flower";
		
		//운영
		String url = "jdbc:oracle:thin:@192.168.100.113:11521:FLOWERDB";
		String id = "flower";
		String pw = "ghkgnp#1";

		List<EgovMap> result = new ArrayList<>();
		
		try{
			pRequestParamMap.put("CONFIG", "1");
			
			List<Map<String, Object>> list2 = configService.selectDailyConfig(pRequestParamMap);

			String query ="	SELECT \n"
					+"	    A1.DY_NAME AS PUM_NAME\n"
					+"	    , DAN\n"
					+"	    , NVL(ROUND(A2.AVG_AMT),0) AS CY_AVG -- 평년\n"
					+"	    , NVL(ROUND(A3.AVG_AMT),0) AS PREY_AVG -- 작년\n"
					+"	    , NVL(ROUND(A4.AVG_AMT),0) AS PREM_AVG -- 전월\n"
					+"	    , NVL(ROUND(A5.AVG_AMT),0) AS SDAY_AVG -- 전순\n"
					+"	    , NVL(ROUND(A6.AVG_AMT),0) AS YDAY_AVG -- 전일\n"
					+"	    , NVL(ROUND(A7.AVG_AMT),0) AS TODAY_AVG -- 당일\n"
					+"	    , CASE WHEN A7.AVG_AMT IS NULL THEN 0 ELSE \n"
					+"	        CASE WHEN A2.AVG_AMT IS NULL THEN 0 ELSE ROUND(((A7.AVG_AMT/A2.AVG_AMT)-1)*100,1)END END AS CY_PER\n"
					+"	    , CASE WHEN A7.AVG_AMT IS NULL THEN 0 ELSE \n"
					+"	        CASE WHEN A3.AVG_AMT IS NULL THEN 0 ELSE ROUND(((A7.AVG_AMT/A3.AVG_AMT)-1)*100,1) END END AS PREY_PER\n"
					+"	    , CASE WHEN A7.AVG_AMT IS NULL THEN 0 ELSE \n"
					+"	        CASE WHEN A4.AVG_AMT IS NULL THEN 0 ELSE ROUND(((A7.AVG_AMT/NVL(ROUND(A4.AVG_AMT),0))-1)*100,1) END END AS PREM_PER\n"
					+"	    , CASE WHEN A7.AVG_AMT IS NULL THEN 0 ELSE\n"
					+"	        CASE WHEN A5.AVG_AMT IS NULL THEN 0 ELSE ROUND(((A7.AVG_AMT/NVL(ROUND(A5.AVG_AMT),0))-1)*100,1) END END AS SDAY_PER\n"
					+"		FROM\n"
					+"		    (SELECT '절화류(전체)' AS DY_NAME ,'-' AS DAN , '0000' AS RK\n"
					+"		          FROM DUAL\n"
					+":pumInfoArr"
					+"		    ) A1\n"
					+"		LEFT JOIN\n"
					+"		    (\n"
					+"                SELECT AVG_AMT, PUM_NAME\n"
					+"                FROM(\n"
					+"					SELECT CASE WHEN COUNT(PUM_NAME) > 3 THEN (SUM(AVG_AMT) - (MIN(AVG_AMT) + MAX(AVG_AMT)))/3 ELSE AVG(AVG_AMT) END AS AVG_AMT, PUM_NAME\n"
					+"					FROM(\n"
					+"					    SELECT  AVG(AVG_AMT) AS AVG_AMT, PUM_NAME\n"
					+"					    FROM(\n"
					+"					        SELECT \n"
					+"					            SUBSTR(SALE_DATE,1,4) as YYYY   \n"
					+"					            ,SUBSTR(SALE_DATE,6,2) as MM\n"
					+"					            ,SUBSTR(SALE_DATE,9,2) as DD\n"
					+"					            ,'절화류(전체)' AS PUM_NAME\n"
					+"					            ,SUM(TOT_AMT)/DECODE(SUM(TOT_QTY),0,NULL,SUM(TOT_QTY)) AS AVG_AMT\n"
					+"					        FROM T_SALE\n"
					+"					        WHERE \n"
					+"			                	SALE_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE(:searchStrDate,'YYYY-MM-DD'), -60),'YYYY-MM') || '-01' AND TO_CHAR(ADD_MONTHS(TO_DATE(:searchStrDate,'YYYY-MM-DD'), -12),'YYYY-MM') || '-31'\n"
					+"					            AND MEJANG = '1'\n"
					+"					            AND CMP_CD = :cmdCd\n"
					+"					            AND TO_CHAR(TO_DATE(SALE_DATE,'yyyy-mm-dd'),'d') in ('2','4','6')\n"
					+"					            AND SUBSTR(SALE_DATE,6,2) = SUBSTR(:searchStrDate ,6,2)\n"
					+"                                AND SUBSTR(SALE_DATE,9,2) BETWEEN case when :sCheck = '1' then '01' when :sCheck = '2' then '11' else '21' end AND case when :sCheck = '1' then '10' when :sCheck = '2' then '20' else '31' end\n"
					+"					        GROUP BY SUBSTR(SALE_DATE,1,4) ,SUBSTR(SALE_DATE,6,2) ,SUBSTR(SALE_DATE,9,2)\n"
					+"					    )\n"
					+"					    GROUP BY YYYY, PUM_NAME\n"
					+"					)\n"
					+"					GROUP BY PUM_NAME\n"
					+"                )\n"
					+"                UNION ALL\n"
					+"                    \n"
					+"                SELECT AVG_AMT, PUM_NAME\n"
					+"                FROM(\n"
					+"                    SELECT CASE WHEN COUNT(PUM_NAME) > 3 THEN (SUM(AVG_AMT) - (MIN(AVG_AMT) + MAX(AVG_AMT)))/3 ELSE AVG(AVG_AMT) END AS AVG_AMT, PUM_NAME\n"
					+"                    FROM(\n"
					+"                        SELECT YUCHAL.YYYY, YUCHAL.MM, YUCHAL.QUATER, NVL(AVGYEAR.AVG_AMT, 0)/YUCHAL.MOK_CNT AS AVG_AMT, YUCHAL.PUM_NAME, YUCHAL.MOK_CNT         \n"
					+"                             FROM(\n"
					+"                                    SELECT YYYY, MM\n"
					+"                                        , CASE WHEN DD BETWEEN '01' AND '10' THEN '1'\n"
					+"                                        WHEN DD BETWEEN '11' AND '20' THEN '2'\n"
					+"                                        WHEN DD BETWEEN '21' AND '31' THEN '3' END AS  QUATER  \n"
					+"                                        , PUM_NAME\n"
					+"                                        , SUM(AVG_AMT) AS AVG_AMT\n"
					+"                                    FROM(\n"
					+"                                    SELECT\n"
					+"                                            SUBSTR(SALE_DATE,1,4) as YYYY   \n"
					+"                                            ,SUBSTR(SALE_DATE,6,2) as MM\n"
					+"                                            ,SUBSTR(SALE_DATE,9,2) as DD\n"
					+"                                            ,PUM_NAME\n"
					+"                                            ,SUM(TOT_AMT)/DECODE(SUM(TOT_QTY),0,NULL,SUM(TOT_QTY)) AS AVG_AMT\n"
					+"                                        FROM T_SALE\n"
					+"                                        WHERE\n"
					+"                                            SALE_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE(:searchStrDate,'YYYY-MM-DD'), -60),'YYYY-MM') || '-01' AND TO_CHAR(ADD_MONTHS(TO_DATE(:searchStrDate,'YYYY-MM-DD'), -12),'YYYY-MM') || '-31'\n"
					+"                                            AND MEJANG = '1'\n"
					+"                                            AND CMP_CD = :cmdCd\n"
					+"                                            AND (PUM_NAME IN (:pumArr):pumjongMap1)\n"
					+"                                            AND TO_CHAR(TO_DATE(SALE_DATE,'yyyy-mm-dd'),'d') in ('2','4','6')\n"
					+"                                        GROUP BY SUBSTR(SALE_DATE,1,4), SUBSTR(SALE_DATE,6,2), SUBSTR(SALE_DATE,9,2), PUM_NAME\n"
					+"                                    )\n"
					+"                                    GROUP BY YYYY, MM, \n"
					+"                                        CASE WHEN DD BETWEEN '01' AND '10' THEN '1'\n"
					+"                                        WHEN DD BETWEEN '11' AND '20' THEN '2'\n"
					+"                                        WHEN DD BETWEEN '21' AND '31' THEN '3' END, PUM_NAME\n"
					+"                                ) AVGYEAR\n"
					+"                                RIGHT JOIN(\n"
					+"                                    SELECT YYYY, MM, MOK_NAME AS PUM_NAME\n"
					+"                                        , CASE WHEN DD BETWEEN '01' AND '10' THEN '1'\n"
					+"                                        WHEN DD BETWEEN '11' AND '20' THEN '2'\n"
					+"                                        WHEN DD BETWEEN '21' AND '31' THEN '3' END AS  QUATER  \n"
					+"                                        ,COUNT(DISTINCT DD) AS MOK_CNT\n"
					+"                                    FROM\n"
					+"                                    (SELECT SUBSTR(SALE_DATE,1,4) AS YYYY\n"
					+"                                        , SUBSTR(SALE_DATE,5,2) AS MM\n"
					+"                                        , SUBSTR(SALE_DATE,7,2) AS DD\n"
					+"                                        , MOK_NAME\n"
					+"                                    FROM FLOWER.TB_YUCHAL\n"
					+"                                    WHERE\n"
					+"                                    SALE_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE(:searchStrDate,'YYYY-MM-DD'), -60),'YYYYMM') || '01' AND TO_CHAR(ADD_MONTHS(TO_DATE(:searchStrDate,'YYYY-MM-DD'), -12),'YYYYMM') || '31'\n"
					+"                                    AND TO_CHAR(TO_DATE(SALE_DATE,'yyyymmdd'),'d') in ('2','4','6')\n"
					+"                                    AND BUN_CHK = 'N'\n"
					+"                                    AND (MOK_NAME IN (:pumArr):pumjongMap2)\n"
					+"                                    )\n"
					+"                                    GROUP BY YYYY, MM\n"
					+"                                        ,CASE WHEN DD BETWEEN '01' AND '10' THEN '1'\n"
					+"                                        WHEN DD BETWEEN '11' AND '20' THEN '2'\n"
					+"                                        WHEN DD BETWEEN '21' AND '31' THEN '3' END\n"
					+"                                        , MOK_NAME\n"
					+"                                        \n"
					+"                              ) YUCHAL\n"
					+"                              ON AVGYEAR.YYYY = YUCHAL.YYYY\n"
					+"                              AND AVGYEAR.MM = YUCHAL.MM\n"
					+"                              AND AVGYEAR.PUM_NAME = YUCHAL.PUM_NAME\n"
					+"                              AND AVGYEAR.QUATER = YUCHAL.QUATER\n"
					+"                              ORDER BY AVGYEAR.YYYY, AVGYEAR.MM, AVGYEAR.QUATER\n"
					+"                    )\n"
					+"                    WHERE MM = SUBSTR(:searchStrDate ,6,2)\n"
					+"                    AND QUATER = :sCheck\n"
					+"                    GROUP BY PUM_NAME\n"
					+"                )\n"
					+"		    )A2\n"
					+"		ON A1.DY_NAME = A2.PUM_NAME\n"
					+"		LEFT JOIN\n"
					+"		    (\n"
					+"                SELECT AVG_AMT, PUM_NAME\n"
					+"                FROM(\n"
					+"                    SELECT AVG(AVG_AMT) AS AVG_AMT, PUM_NAME\n"
					+"                    FROM(\n"
					+"                        SELECT \n"
					+"                            SUBSTR(SALE_DATE,1,4) as YYYY   \n"
					+"                            ,SUBSTR(SALE_DATE,6,2) as MM\n"
					+"                            ,SUBSTR(SALE_DATE,9,2) as DD\n"
					+"                            ,'절화류(전체)' AS PUM_NAME\n"
					+"                            ,SUM(TOT_AMT)/DECODE(SUM(TOT_QTY),0,NULL,SUM(TOT_QTY)) AS AVG_AMT\n"
					+"                        FROM T_SALE\n"
					+"                        WHERE \n"
					+"                            SALE_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE(:searchStrDate,'YYYY-MM-DD'), -12),'YYYY-MM') || case when :sCheck = '1' then '-01' when :sCheck = '2' then '-11' else '-21' end AND TO_CHAR(ADD_MONTHS(TO_DATE(:searchStrDate,'YYYY-MM-DD'), -12),'YYYY-MM') || case when :sCheck = '1' then '-10' when :sCheck = '2' then '-20' else '-31' end\n"
					+"                            AND MEJANG = '1'\n"
					+"                            AND CMP_CD = :cmdCd\n"
					+"                            AND TO_CHAR(TO_DATE(SALE_DATE,'yyyy-mm-dd'),'d') in ('2','4','6')\n"
					+"                        GROUP BY SUBSTR(SALE_DATE,1,4) ,SUBSTR(SALE_DATE,6,2) ,SUBSTR(SALE_DATE,9,2)\n"
					+"					)\n"
					+"                    GROUP BY PUM_NAME\n"
					+"				)\n"
					+"				UNION ALL\n"
					+"                    \n"
					+"				SELECT AVG_AMT, PUM_NAME\n"
					+"				FROM(\n"
					+"					SELECT YUCHAL.YYYY, YUCHAL.MM, YUCHAL.QUATER, NVL(AVGYEAR.AVG_AMT, 0)/YUCHAL.MOK_CNT AS AVG_AMT, YUCHAL.PUM_NAME, YUCHAL.MOK_CNT         \n"
					+"                         FROM(\n"
					+"                                SELECT YYYY, MM\n"
					+"                                    , CASE WHEN DD BETWEEN '01' AND '10' THEN '1'\n"
					+"                                    WHEN DD BETWEEN '11' AND '20' THEN '2'\n"
					+"                                    WHEN DD BETWEEN '21' AND '31' THEN '3' END AS  QUATER  \n"
					+"                                    , PUM_NAME\n"
					+"                                    , SUM(AVG_AMT) AS AVG_AMT\n"
					+"                                FROM(\n"
					+"                                SELECT\n"
					+"                                        SUBSTR(SALE_DATE,1,4) as YYYY   \n"
					+"                                        ,SUBSTR(SALE_DATE,6,2) as MM\n"
					+"                                        ,SUBSTR(SALE_DATE,9,2) as DD\n"
					+"                                        ,PUM_NAME\n"
					+"                                        ,SUM(TOT_AMT)/DECODE(SUM(TOT_QTY),0,NULL,SUM(TOT_QTY)) AS AVG_AMT\n"
					+"                                    FROM T_SALE\n"
					+"                                    WHERE\n"
					+"                                            SALE_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE(:searchStrDate,'YYYY-MM-DD'), -12),'YYYY-MM') || case when :sCheck = '1' then '-01' when :sCheck = '2' then '-11' else '-21' end AND TO_CHAR(ADD_MONTHS(TO_DATE(:searchStrDate,'YYYY-MM-DD'), -12),'YYYY-MM') || case when :sCheck = '1' then '-10' when :sCheck = '2' then '-20' else '-31' end\n"
					+"                                        AND MEJANG = '1'\n"
					+"                                        AND CMP_CD = :cmdCd\n"
					+"                                        AND (PUM_NAME IN (:pumArr):pumjongMap1)\n"
					+"                                        AND TO_CHAR(TO_DATE(SALE_DATE,'yyyy-mm-dd'),'d') in ('2','4','6')\n"
					+"                                    GROUP BY SUBSTR(SALE_DATE,1,4), SUBSTR(SALE_DATE,6,2), SUBSTR(SALE_DATE,9,2), PUM_NAME\n"
					+"                                )\n"
					+"                                GROUP BY YYYY, MM, \n"
					+"                                    CASE WHEN DD BETWEEN '01' AND '10' THEN '1'\n"
					+"                                    WHEN DD BETWEEN '11' AND '20' THEN '2'\n"
					+"                                    WHEN DD BETWEEN '21' AND '31' THEN '3' END, PUM_NAME\n"
					+"                            ) AVGYEAR\n"
					+"                            RIGHT JOIN(\n"
					+"                                SELECT YYYY, MM, MOK_NAME AS PUM_NAME\n"
					+"                                    , CASE WHEN DD BETWEEN '01' AND '10' THEN '1'\n"
					+"                                    WHEN DD BETWEEN '11' AND '20' THEN '2'\n"
					+"                                    WHEN DD BETWEEN '21' AND '31' THEN '3' END AS  QUATER  \n"
					+"                                    ,COUNT(DISTINCT DD) AS MOK_CNT\n"
					+"                                FROM\n"
					+"                                (SELECT SUBSTR(SALE_DATE,1,4) AS YYYY\n"
					+"                                    , SUBSTR(SALE_DATE,5,2) AS MM\n"
					+"                                    , SUBSTR(SALE_DATE,7,2) AS DD\n"
					+"                                    , MOK_NAME\n"
					+"                                FROM FLOWER.TB_YUCHAL\n"
					+"                                WHERE\n"
					+"                                    SALE_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE(:searchStrDate,'YYYY-MM-DD'), -12),'YYYYMM') || case when :sCheck = '1' then '01' when :sCheck = '2' then '11' else '21' end AND TO_CHAR(ADD_MONTHS(TO_DATE(:searchStrDate,'YYYY-MM-DD'), -12),'YYYYMM') || case when :sCheck = '1' then '10' when :sCheck = '2' then '20' else '31' end\n"
					+"                                    AND TO_CHAR(TO_DATE(SALE_DATE,'yyyymmdd'),'d') in ('2','4','6')\n"
					+"                                    AND BUN_CHK = 'N'\n"
					+"                                    AND (MOK_NAME IN (:pumArr):pumjongMap2)\n"
					+"                                )\n"
					+"                                GROUP BY YYYY, MM\n"
					+"                                    ,CASE WHEN DD BETWEEN '01' AND '10' THEN '1'\n"
					+"                                    WHEN DD BETWEEN '11' AND '20' THEN '2'\n"
					+"                                    WHEN DD BETWEEN '21' AND '31' THEN '3' END\n"
					+"                                    , MOK_NAME\n"
					+"                                    \n"
					+"                          ) YUCHAL\n"
					+"                          ON AVGYEAR.YYYY = YUCHAL.YYYY\n"
					+"                          AND AVGYEAR.MM = YUCHAL.MM\n"
					+"                          AND AVGYEAR.PUM_NAME = YUCHAL.PUM_NAME\n"
					+"                          AND AVGYEAR.QUATER = YUCHAL.QUATER\n"
					+"                          ORDER BY AVGYEAR.YYYY, AVGYEAR.MM, AVGYEAR.QUATER\n"
					+"                )\n"
					+"		    )A3\n"
					+"		ON A1.DY_NAME = A3.PUM_NAME\n"
					+"		LEFT JOIN\n"
					+"		    (\n"
					+"                SELECT AVG_AMT, PUM_NAME\n"
					+"                FROM(\n"
					+"                    SELECT AVG(AVG_AMT) AS AVG_AMT, PUM_NAME\n"
					+"                    FROM(\n"
					+"                        SELECT \n"
					+"                            SUBSTR(SALE_DATE,1,4) as YYYY   \n"
					+"                            ,SUBSTR(SALE_DATE,6,2) as MM\n"
					+"                            ,SUBSTR(SALE_DATE,9,2) as DD\n"
					+"                            ,'절화류(전체)' AS PUM_NAME\n"
					+"                            ,SUM(TOT_AMT)/DECODE(SUM(TOT_QTY),0,NULL,SUM(TOT_QTY)) AS AVG_AMT\n"
					+"                        FROM T_SALE\n"
					+"                        WHERE \n"
					+"                            SALE_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE(:searchStrDate,'YYYY-MM-DD'), -1),'YYYY-MM') || case when :sCheck = '1' then '-01' when :sCheck = '2' then '-11' else '-21' end AND TO_CHAR(ADD_MONTHS(TO_DATE(:searchStrDate,'YYYY-MM-DD'), -1),'YYYY-MM') || case when :sCheck = '1' then '-10' when :sCheck = '2' then '-20' else '-31' end\n"
					+"                            AND MEJANG = '1'\n"
					+"                            AND CMP_CD = :cmdCd\n"
					+"                            AND TO_CHAR(TO_DATE(SALE_DATE,'yyyy-mm-dd'),'d') in ('2','4','6')\n"
					+"                        GROUP BY SUBSTR(SALE_DATE,1,4) ,SUBSTR(SALE_DATE,6,2) ,SUBSTR(SALE_DATE,9,2)\n"
					+"					)\n"
					+"                    GROUP BY PUM_NAME\n"
					+"				)\n"
					+"				UNION ALL\n"
					+"				\n"
					+"                SELECT AVG_AMT, PUM_NAME\n"
					+"                FROM(\n"
					+"                    SELECT YUCHAL.YYYY, YUCHAL.MM, YUCHAL.QUATER, NVL(AVGYEAR.AVG_AMT, 0)/YUCHAL.MOK_CNT AS AVG_AMT, YUCHAL.PUM_NAME, YUCHAL.MOK_CNT         \n"
					+"                         FROM(\n"
					+"                                SELECT YYYY, MM\n"
					+"                                    , CASE WHEN DD BETWEEN '01' AND '10' THEN '1'\n"
					+"                                    WHEN DD BETWEEN '11' AND '20' THEN '2'\n"
					+"                                    WHEN DD BETWEEN '21' AND '31' THEN '3' END AS  QUATER  \n"
					+"                                    , PUM_NAME\n"
					+"                                    , SUM(AVG_AMT) AS AVG_AMT\n"
					+"                                FROM(\n"
					+"                                SELECT\n"
					+"                                        SUBSTR(SALE_DATE,1,4) as YYYY   \n"
					+"                                        ,SUBSTR(SALE_DATE,6,2) as MM\n"
					+"                                        ,SUBSTR(SALE_DATE,9,2) as DD\n"
					+"                                        ,PUM_NAME\n"
					+"                                        ,SUM(TOT_AMT)/DECODE(SUM(TOT_QTY),0,NULL,SUM(TOT_QTY)) AS AVG_AMT\n"
					+"                                    FROM T_SALE\n"
					+"                                    WHERE\n"
					+"                                        SALE_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE(:searchStrDate,'YYYY-MM-DD'), -1),'YYYY-MM') || case when :sCheck = '1' then '-01' when :sCheck = '2' then '-11' else '-21' end AND TO_CHAR(ADD_MONTHS(TO_DATE(:searchStrDate,'YYYY-MM-DD'), -1),'YYYY-MM') || case when :sCheck = '1' then '-10' when :sCheck = '2' then '-20' else '-31' end\n"
					+"                                        AND MEJANG = '1'\n"
					+"                                        AND CMP_CD = :cmdCd\n"
					+"                                        AND (PUM_NAME IN (:pumArr):pumjongMap1)\n"
					+"                                        AND TO_CHAR(TO_DATE(SALE_DATE,'yyyy-mm-dd'),'d') in ('2','4','6')\n"
					+"                                    GROUP BY SUBSTR(SALE_DATE,1,4), SUBSTR(SALE_DATE,6,2), SUBSTR(SALE_DATE,9,2), PUM_NAME\n"
					+"                                )\n"
					+"                                GROUP BY YYYY, MM, \n"
					+"                                    CASE WHEN DD BETWEEN '01' AND '10' THEN '1'\n"
					+"                                    WHEN DD BETWEEN '11' AND '20' THEN '2'\n"
					+"                                    WHEN DD BETWEEN '21' AND '31' THEN '3' END, PUM_NAME\n"
					+"                            ) AVGYEAR\n"
					+"                            RIGHT JOIN(\n"
					+"                                SELECT YYYY, MM, MOK_NAME AS PUM_NAME\n"
					+"                                    , CASE WHEN DD BETWEEN '01' AND '10' THEN '1'\n"
					+"                                    WHEN DD BETWEEN '11' AND '20' THEN '2'\n"
					+"                                    WHEN DD BETWEEN '21' AND '31' THEN '3' END AS  QUATER  \n"
					+"                                    ,COUNT(DISTINCT DD) AS MOK_CNT\n"
					+"                                FROM\n"
					+"                                (SELECT SUBSTR(SALE_DATE,1,4) AS YYYY\n"
					+"                                    , SUBSTR(SALE_DATE,5,2) AS MM\n"
					+"                                    , SUBSTR(SALE_DATE,7,2) AS DD\n"
					+"                                    , MOK_NAME\n"
					+"                                FROM FLOWER.TB_YUCHAL\n"
					+"                                WHERE\n"
					+"                                SALE_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE(:searchStrDate,'YYYY-MM-DD'), -1),'YYYYMM') || case when :sCheck = '1' then '01' when :sCheck = '2' then '11' else '21' end AND TO_CHAR(ADD_MONTHS(TO_DATE(:searchStrDate,'YYYY-MM-DD'), -1),'YYYYMM') || case when :sCheck = '1' then '10' when :sCheck = '2' then '20' else '31' end\n"
					+"                                AND TO_CHAR(TO_DATE(SALE_DATE,'yyyymmdd'),'d') in ('2','4','6')\n"
					+"                                AND BUN_CHK = 'N'\n"
					+"                                AND (MOK_NAME IN (:pumArr):pumjongMap2)\n"
					+"                                )\n"
					+"                                GROUP BY YYYY, MM\n"
					+"                                    ,CASE WHEN DD BETWEEN '01' AND '10' THEN '1'\n"
					+"                                    WHEN DD BETWEEN '11' AND '20' THEN '2'\n"
					+"                                    WHEN DD BETWEEN '21' AND '31' THEN '3' END\n"
					+"                                    , MOK_NAME\n"
					+"                                    \n"
					+"                          ) YUCHAL\n"
					+"                          ON AVGYEAR.YYYY = YUCHAL.YYYY\n"
					+"                          AND AVGYEAR.MM = YUCHAL.MM\n"
					+"                          AND AVGYEAR.PUM_NAME = YUCHAL.PUM_NAME\n"
					+"                          AND AVGYEAR.QUATER = YUCHAL.QUATER\n"
					+"                          ORDER BY AVGYEAR.YYYY, AVGYEAR.MM, AVGYEAR.QUATER\n"
					+"                )\n"
					+"		    ) A4\n"
					+"		ON A1.DY_NAME = A4.PUM_NAME\n"
					+"		LEFT JOIN\n"
					+"		    (\n"
					+"                SELECT AVG_AMT, PUM_NAME\n"
					+"				FROM(\n"
					+"                    SELECT AVG(AVG_AMT) AS AVG_AMT, PUM_NAME\n"
					+"                    FROM(\n"
					+"                        SELECT \n"
					+"                            SUBSTR(SALE_DATE,1,4) as YYYY   \n"
					+"                            ,SUBSTR(SALE_DATE,6,2) as MM\n"
					+"                            ,SUBSTR(SALE_DATE,9,2) as DD\n"
					+"                            ,'절화류(전체)' AS PUM_NAME\n"
					+"                            ,SUM(TOT_AMT)/DECODE(SUM(TOT_QTY),0,NULL,SUM(TOT_QTY)) AS AVG_AMT\n"
					+"                        FROM T_SALE\n"
					+"                        WHERE\n"
					+"								:QueryBySCheck1"
					+"                            AND MEJANG = '1'\n"
					+"                            AND CMP_CD = :cmdCd\n"
					+"                            AND TO_CHAR(TO_DATE(SALE_DATE,'yyyy-mm-dd'),'d') in ('2','4','6')\n"
					+"                        GROUP BY SUBSTR(SALE_DATE,1,4) ,SUBSTR(SALE_DATE,6,2) ,SUBSTR(SALE_DATE,9,2)\n"
					+"                    )\n"
					+"                    GROUP BY PUM_NAME\n"
					+"				)\n"
					+"				UNION ALL\n"
					+"                    \n"
					+"                SELECT AVG_AMT, PUM_NAME\n"
					+"                FROM(\n"
					+"                    SELECT YUCHAL.YYYY, YUCHAL.MM, YUCHAL.QUATER, NVL(AVGYEAR.AVG_AMT, 0)/YUCHAL.MOK_CNT AS AVG_AMT, YUCHAL.PUM_NAME, YUCHAL.MOK_CNT         \n"
					+"                         FROM(\n"
					+"                                SELECT YYYY, MM\n"
					+"                                    , CASE WHEN DD BETWEEN '01' AND '10' THEN '1'\n"
					+"                                    WHEN DD BETWEEN '11' AND '20' THEN '2'\n"
					+"                                    WHEN DD BETWEEN '21' AND '31' THEN '3' END AS  QUATER  \n"
					+"                                    , PUM_NAME\n"
					+"                                    , SUM(AVG_AMT) AS AVG_AMT\n"
					+"                                FROM(\n"
					+"                                SELECT\n"
					+"                                        SUBSTR(SALE_DATE,1,4) as YYYY   \n"
					+"                                        ,SUBSTR(SALE_DATE,6,2) as MM\n"
					+"                                        ,SUBSTR(SALE_DATE,9,2) as DD\n"
					+"                                        ,PUM_NAME\n"
					+"                                        ,SUM(TOT_AMT)/DECODE(SUM(TOT_QTY),0,NULL,SUM(TOT_QTY)) AS AVG_AMT\n"
					+"                                    FROM T_SALE\n"
					+"                                    WHERE\n"
					+"                                        :QueryBySCheck2"
					+"                                        AND MEJANG = '1'\n"
					+"                                        AND CMP_CD = :cmdCd\n"
					+"                                        AND (PUM_NAME IN (:pumArr):pumjongMap1)\n"
					+"                                        AND TO_CHAR(TO_DATE(SALE_DATE,'yyyy-mm-dd'),'d') in ('2','4','6')\n"
					+"                                    GROUP BY SUBSTR(SALE_DATE,1,4), SUBSTR(SALE_DATE,6,2), SUBSTR(SALE_DATE,9,2), PUM_NAME\n"
					+"                                )\n"
					+"                                GROUP BY YYYY, MM, \n"
					+"                                    CASE WHEN DD BETWEEN '01' AND '10' THEN '1'\n"
					+"                                    WHEN DD BETWEEN '11' AND '20' THEN '2'\n"
					+"                                    WHEN DD BETWEEN '21' AND '31' THEN '3' END, PUM_NAME\n"
					+"                            ) AVGYEAR\n"
					+"                            RIGHT JOIN(\n"
					+"                                SELECT YYYY, MM, MOK_NAME AS PUM_NAME\n"
					+"                                    , CASE WHEN DD BETWEEN '01' AND '10' THEN '1'\n"
					+"                                    WHEN DD BETWEEN '11' AND '20' THEN '2'\n"
					+"                                    WHEN DD BETWEEN '21' AND '31' THEN '3' END AS  QUATER  \n"
					+"                                    ,COUNT(DISTINCT DD) AS MOK_CNT\n"
					+"                                FROM\n"
					+"                                (SELECT SUBSTR(SALE_DATE,1,4) AS YYYY\n"
					+"                                    , SUBSTR(SALE_DATE,5,2) AS MM\n"
					+"                                    , SUBSTR(SALE_DATE,7,2) AS DD\n"
					+"                                    , MOK_NAME\n"
					+"                                FROM FLOWER.TB_YUCHAL\n"
					+"                                WHERE\n"
					+"                                        :QueryBySCheck3"
					+"                                    AND TO_CHAR(TO_DATE(SALE_DATE,'yyyymmdd'),'d') in ('2','4','6')\n"
					+"                                    AND BUN_CHK = 'N'\n"
					+"                                    AND (MOK_NAME IN (:pumArr):pumjongMap2)\n"
					+"                                )\n"
					+"                                GROUP BY YYYY, MM\n"
					+"                                    ,CASE WHEN DD BETWEEN '01' AND '10' THEN '1'\n"
					+"                                    WHEN DD BETWEEN '11' AND '20' THEN '2'\n"
					+"                                    WHEN DD BETWEEN '21' AND '31' THEN '3' END\n"
					+"                                    , MOK_NAME\n"
					+"                                    \n"
					+"                          ) YUCHAL\n"
					+"                          ON AVGYEAR.YYYY = YUCHAL.YYYY\n"
					+"                          AND AVGYEAR.MM = YUCHAL.MM\n"
					+"                          AND AVGYEAR.PUM_NAME = YUCHAL.PUM_NAME\n"
					+"                          AND AVGYEAR.QUATER = YUCHAL.QUATER\n"
					+"                          ORDER BY AVGYEAR.YYYY, AVGYEAR.MM, AVGYEAR.QUATER\n"
					+"                )\n"
					+"		    ) A5\n"
					+"		ON A1.DY_NAME = A5.PUM_NAME\n"
					+"		LEFT JOIN\n"
					+"		    (\n"
					+"		        SELECT AVG(AVG_AMT) AS AVG_AMT, PUM_NAME FROM(\n"
					+"		                SELECT \n"
					+"		                    SUM(TOT_AMT)/DECODE(SUM(TOT_QTY),0,NULL,SUM(TOT_QTY)) AS AVG_AMT\n"
					+"		                    ,'절화류(전체)' AS PUM_NAME\n"
					+"		                FROM T_SALE\n"
					+"		                WHERE SALE_DATE = (SELECT MAX(SALE_DATE)\n"
					+"		                                    FROM T_SALE\n"
					+"		                                    WHERE SALE_DATE < :searchStrDate\n"
					+"		                                    AND CMP_CD = :cmdCd\n"
					+"		                                    AND TO_CHAR(TO_DATE(SALE_DATE,'yyyy-mm-dd'),'d') in ('2','4','6')\n"
					+"		                                    AND MEJANG = '1')\n"
					+"		                    AND CMP_CD = :cmdCd\n"
					+"		                    AND MEJANG = '1'\n"
					+"		                GROUP BY SALE_DATE\n"
					+"		                UNION ALL\n"
					+"		                SELECT \n"
					+"		                    SUM(TOT_AMT)/DECODE(SUM(TOT_QTY),0,NULL,SUM(TOT_QTY)) AS AVG_AMT\n"
					+"		                    ,PUM_NAME\n"
					+"		                FROM T_SALE\n"
					+"		                WHERE SALE_DATE = (SELECT MAX(SALE_DATE)\n"
					+"		                                    FROM T_SALE\n"
					+"		                                    WHERE SALE_DATE < :searchStrDate\n"
					+"		                                    AND CMP_CD = :cmdCd\n"
					+"		                                    AND TO_CHAR(TO_DATE(SALE_DATE,'yyyy-mm-dd'),'d') in ('2','4','6')\n"
					+"		                                    AND MEJANG = '1')\n"
					+"		                    AND CMP_CD = :cmdCd\n"
					+"		                    AND MEJANG = '1'\n"
					+"		                    AND (PUM_NAME IN (:pumArr):pumjongMap1)\n"
					+"		                GROUP BY SALE_DATE , PUM_NAME)\n"
					+"		            GROUP BY PUM_NAME\n"
					+"		    ) A6\n"
					+"		ON A1.DY_NAME = A6.PUM_NAME\n"
					+"		LEFT JOIN \n"
					+"		(\n"
					+"		    SELECT SUM(TOT_AMT)/DECODE(SUM(TOT_QTY),0,NULL,SUM(TOT_QTY)) AS AVG_AMT, PUM_NAME FROM(\n"
					+"		        SELECT \n"
					+"		                    SUM(TOT_AMT) AS TOT_AMT\n"
					+"		                    ,SUM(QTY) AS TOT_QTY\n"
					+"		                    ,'절화류(전체)' AS PUM_NAME\n"
					+"		                FROM T_SALE\n"
					+"		                WHERE REPLACE(SALE_DATE, '-', '')  = REPLACE(:searchStrDate,'-','')\n"
					+"		                    AND CMP_CD = :cmdCd\n"
					+"		                    AND MEJANG = '1'\n"
					+"		                GROUP BY SALE_DATE\n"
					+"		                UNION ALL\n"
					+"		                SELECT \n"
					+"		                    SUM(TOT_AMT) AS TOT_AMT\n"
					+"		                    ,SUM(QTY) AS TOT_QTY\n"
					+"		                    ,PUM_NAME\n"
					+"		                FROM T_SALE\n"
					+"		                WHERE REPLACE(SALE_DATE, '-', '')  = REPLACE(:searchStrDate,'-','')\n"
					+"		                    AND CMP_CD = :cmdCd\n"
					+"		                    AND MEJANG = '1'\n"
					+"		                    AND (PUM_NAME IN (:pumArr):pumjongMap1)\n"
					+"		                GROUP BY SALE_DATE, PUM_NAME)\n"
					+"		            GROUP BY PUM_NAME\n"
					+"		    ) A7\n"
					+"		ON A1.DY_NAME = A7.PUM_NAME\n"
					+"		ORDER BY RK\n"
					+"        \n";
			
			Map<String, String> param = new HashMap<>();


			param.put(":cmdCd", "0000000001");
			param.put(":searchStrDate", pRequestParamMap.get("searchStrDate").toString());
			param.put(":sCheck", pRequestParamMap.get("sCheck").toString());
			
			// 쿼리 커스텀
			// 1. sCheck 값에 따라 달라지는 쿼리 구문 적용
			
			if (param.get(":sCheck").equals("1")){
				query = query.replaceAll(":QueryBySCheck1", "SALE_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE(:searchStrDate,'YYYY-MM-DD'), -1), 'YYYY-MM') || '-21' AND TO_CHAR(ADD_MONTHS(TO_DATE(:searchStrDate,'YYYY-MM-DD'), -1), 'YYYY-MM') || '-31'\n");
				query = query.replaceAll(":QueryBySCheck2", "SALE_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE(:searchStrDate,'YYYY-MM-DD'), -1), 'YYYY-MM') || '-21' AND TO_CHAR(ADD_MONTHS(TO_DATE(:searchStrDate,'YYYY-MM-DD'), -1), 'YYYY-MM') || '-31'\n");
				query = query.replaceAll(":QueryBySCheck3", "SALE_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE(:searchStrDate,'YYYY-MM-DD'), -1), 'YYYYMM') || '21' AND TO_CHAR(ADD_MONTHS(TO_DATE(:searchStrDate,'YYYY-MM-DD'), -1), 'YYYYMM') || '31'\n");
			}
			if (param.get(":sCheck").equals("2")){
				query = query.replaceAll(":QueryBySCheck1", "SALE_DATE BETWEEN TO_CHAR(TO_DATE(:searchStrDate,'YYYY-MM-DD'), 'YYYY-MM') || '-01' AND TO_CHAR(TO_DATE(:searchStrDate,'YYYY-MM-DD'), 'YYYY-MM') || '-10'\n");
				query = query.replaceAll(":QueryBySCheck2", "SALE_DATE BETWEEN TO_CHAR(TO_DATE(:searchStrDate,'YYYY-MM-DD'), 'YYYY-MM') || '-01' AND TO_CHAR(TO_DATE(:searchStrDate,'YYYY-MM-DD'), 'YYYY-MM') || '-10'\n");
				query = query.replaceAll(":QueryBySCheck3", "SALE_DATE BETWEEN TO_CHAR(TO_DATE(:searchStrDate,'YYYY-MM-DD'), 'YYYYMM') || '01' AND TO_CHAR(TO_DATE(:searchStrDate,'YYYY-MM-DD'), 'YYYYMM') || '10'\n");
			}
			if (param.get(":sCheck").equals("3")){
				query = query.replaceAll(":QueryBySCheck1", "SALE_DATE BETWEEN TO_CHAR(TO_DATE(:searchStrDate,'YYYY-MM-DD'), 'YYYY-MM') || '-11' AND TO_CHAR(TO_DATE(:searchStrDate,'YYYY-MM-DD'), 'YYYY-MM') || '-20'\n");
				query = query.replaceAll(":QueryBySCheck2", "SALE_DATE BETWEEN TO_CHAR(TO_DATE(:searchStrDate,'YYYY-MM-DD'), 'YYYY-MM') || '-11' AND TO_CHAR(TO_DATE(:searchStrDate,'YYYY-MM-DD'), 'YYYY-MM') || '-20'\n");
				query = query.replaceAll(":QueryBySCheck3", "SALE_DATE BETWEEN TO_CHAR(TO_DATE(:searchStrDate,'YYYY-MM-DD'), 'YYYYMM') || '11' AND TO_CHAR(TO_DATE(:searchStrDate,'YYYY-MM-DD'), 'YYYYMM') || '20'\n");
			}
			
			// 2. 변수 바인딩
			for (Map.Entry<String, String> entry : param.entrySet()){
				query = query.replaceAll(entry.getKey(), "'"+entry.getValue()+"'");
			}
			
			// 3. 선택된 품목, 품종만 조회하는 구문 적용
			// 3.1. 모든 품종을 조회하는 품목 구문 적용
			List<String> pumArr = new ArrayList<>();
			for(Map<String, Object> e : list2){
				if(e.get("CMP_GOOD") == null || e.get("CMP_GOOD").toString().equals("null") || e.get("CMP_GOOD").toString().equals("")){
					pumArr.add(e.get("PUM_NAME").toString());
				}
			}
			
			String pumArrStr = "\'";
			for(String e : pumArr){
				pumArrStr += "\', \'" + e;
			}
			pumArrStr += "\'";
//			query = query.replaceAll(":pumArr", "\'"+ String.join("', '", pumArr) +"\'");
			query = query.replaceAll(":pumArr", pumArrStr);

			// 3.2. 특정 품종을 조회하는 품목과 품종번호 구문 적용
			Map<String, String> pumjongMap = new HashMap<>();
			for(Map<String, Object> e : list2){
				if(e.get("CMP_GOOD") != null && e.get("CMP_GOOD").toString().equals("null") == false && e.get("CMP_GOOD").toString().equals("") == false){
					pumjongMap.put(e.get("PUM_NAME").toString(), "\'"+e.get("CMP_GOOD").toString().replaceAll(",", "\',\'")+"\'");
				}
			}
//			pumjongMap.put("거베라", "'10510000'");
//			pumjongMap.put("국화", "'10011640','10010327','10010616'");
			if (pumjongMap.keySet().size() == 0){
				query = query.replaceAll(":pumjongMap1", "");
				query = query.replaceAll(":pumjongMap2", "");
			}
			else{
				String pumjongMap1 = "";
				String pumjongMap2 = "";
				for (Map.Entry<String, String> entry : pumjongMap.entrySet()){
					pumjongMap1 += String.format(" OR (PUM_NAME = \'%S\' AND CMP_GOOD IN (%S))", entry.getKey(), entry.getValue());
					pumjongMap2 += String.format(" OR (MOK_NAME = \'%S\' AND PUM_CODE IN (%S))", entry.getKey(), entry.getValue());
				}
				query = query.replaceAll(":pumjongMap1", pumjongMap1);
				query = query.replaceAll(":pumjongMap2", pumjongMap2);
			}

			// 4. 표시할 품목 이름(PUM_NAME), 단(DAN), 정렬 순서(RK) 구문 적용
			List<List<String>> pumInfoArr = new ArrayList<>();
			for(Map<String, Object> e : list2){
				pumInfoArr.add(Arrays.asList(e.get("PUM_NAME").toString(), e.get("DAN").toString(),e.get("RK").toString()));
			}
//			pumInfoArr.add(Arrays.asList("국화", "단(20송이)", "0101"));
//			pumInfoArr.add(Arrays.asList("거베라", "단(10송이)", "0102"));

			String pumInfoArr2SQL = "";
			for(List<String> pumInfo : pumInfoArr){
				pumInfoArr2SQL += String.format("		          UNION ALL\n		          SELECT \'%s\' AS DY_NAME , \'%s\' AS DAN , \'%s\' AS RK\n		          FROM DUAL \n", pumInfo.get(0), pumInfo.get(1), pumInfo.get(2));
			}
			query = query.replaceAll(":pumInfoArr", pumInfoArr2SQL);
			
			
			System.out.println(query);
			
			System.out.println("step4");
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection(url, id, pw);
			Statement stmt = con.createStatement();
			stmt.setQueryTimeout(1000);
			
			ResultSet rs = stmt.executeQuery(query);
			List<String> columNm = Arrays.asList("PUM_NAME", "DAN", "CY_AVG", "PREY_AVG", "PREM_AVG", "SDAY_AVG", "YDAY_AVG", "TODAY_AVG", "CY_PER", "PREY_PER", "PREM_PER", "SDAY_PER");
			List<String> resultColumNm = Arrays.asList("pumName", "dan", "cyAvg", "preyAvg", "premAvg", "sdayAvg", "ydayAvg", "todayAvg", "cyPer", "preyPer", "premPer", "sdayPer");

			System.out.println("step5");
			while(rs.next()){
				EgovMap e = new EgovMap();
				for(int i=0; i<columNm.size(); i++){
					String colum = columNm.get(i);
					e.put(resultColumNm.get(i), rs.getString(colum));
					System.out.print(rs.getString(colum));
					System.out.print("	");
				}
				result.add(e);
				System.out.println();
			}
			System.out.println("step6");
			rs.close();
			stmt.close();
			con.close();
			
		}catch (Exception e){
			e.printStackTrace();
		}
		
		return result;
	}
	
	public List<EgovMap> selectDynamicDayPumAucExcel2023(Map<String, Object> pRequestParamMap){
		//개발
//		String url = "jdbc:oracle:thin:@175.106.91.132:1521:flower";
//		String id = "flower";
//		String pw = "flower";
		
		//운영
		String url = "jdbc:oracle:thin:@192.168.100.113:11521:FLOWERDB";
		String id = "flower";
		String pw = "ghkgnp#1";
		List<EgovMap> result = new ArrayList<>();
		
		try{

			pRequestParamMap.put("CONFIG", "2");
			List<Map<String, Object>> list2 = configService.selectDailyConfig(pRequestParamMap);
			
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection(url, id, pw);
			Statement stmt = con.createStatement();
			String query ="SELECT \n"
					+"               SUBSTR(REPLACE(A.SALE_DATE, '-', ''), 0, 4) AS YEAR,\n"
					+"	       	   SUBSTR(REPLACE(A.SALE_DATE, '-', ''), 5, 2) AS MONTH,\n"
					+"	       	   SUBSTR(REPLACE(A.SALE_DATE, '-', ''), 7, 2) AS DAY,\n"
					+"	       	   decode(A.PUM_NAME,'거베라','거베라(거베라)','국화','국화(대국)',A.PUM_NAME) as PUM_NAME,\n"
					+"	       	   B.TOT_CNT AS TOT_CNT,\n"
					+"	       	   B.PAN_CNT AS PAN_CNT,\n"
					+"	       	   B.YUCHAL_CNT AS YUCHAL_CNT,\n"
					+"	       	   A.TOT_AMT AS TOT_AMT,\n"
					+"	       	   C.AVG_AMT AS AVG_AMT\n"
					+"		 FROM\n"
					+"			(\n"
					+"			SELECT REPLACE(SALE_DATE, '-', '') AS SALE_DATE,\n"
					+"			       DECODE(PUM_NAME, '팔레높시스', '호접란', PUM_NAME) AS PUM_NAME,\n"
					+"			       SUM(TOT_AMT) AS TOT_AMT\n"
					+"			FROM T_SALE\n"
					+"			WHERE CMP_CD = '0000000001'\n"
					+"		      and REPLACE(SALE_DATE, '-', '') BETWEEN :searchStrDate AND :searchEndDate\n"
					+"		      and (:default :PUM_NAME :CMP_GOOD)\n"
					+"		      and to_char(to_date(REPLACE(SALE_DATE,'-',''), 'yyyymmdd'), 'd') in ('2','4','6')\n"
					+"			GROUP BY SALE_DATE, DECODE(PUM_NAME,'팔레높시스','호접란',PUM_NAME)\n"
					+"			) A,\n"
					+"			(\n"
					+"			SELECT REPLACE(SALE_DATE, '-', '') AS SALE_DATE,\n"
					+"			       DECODE(MOK_NAME, '팔레높시스', '호접란', MOK_NAME) AS PUM_NAME,\n"
					+"			       SUM(TOT_CNT) AS TOT_CNT,\n"
					+"			       SUM(TOT_CNT - YUCHAL_CNT) AS PAN_CNT,\n"
					+"			       SUM(YUCHAL_CNT) AS YUCHAL_CNT\n"
					+"			FROM TB_YUCHAL\n"
					+"			WHERE REPLACE(SALE_DATE, '-', '') BETWEEN :searchStrDate AND :searchEndDate\n"
					+"			  AND BUN_CHK = 'N'\n"
					+"            AND (:default :MOK_NAME :PUM_CODE) \n"
					+"			  and to_char(to_date(REPLACE(SALE_DATE,'-',''), 'yyyymmdd'), 'd') in ('2','4','6')\n"
					+"			  OR (TOT_CNT = YUCHAL_CNT)\n"
					+"			GROUP BY SALE_DATE, DECODE(MOK_NAME, '팔레높시스', '호접란', MOK_NAME)\n"
					+"			) B,\n"
					+"            (\n"
					+"            SELECT ROUND(SUM(TOT_AMT)/SUM(TOT_QTY), 0) AS AVG_AMT,\n"
					+"                   REPLACE(SALE_DATE, '-', '') AS SALE_DATE,\n"
					+"			       DECODE(PUM_NAME, '팔레높시스', '호접란', PUM_NAME) AS PUM_NAME\n"
					+"            FROM T_SALE_DATE\n"
					+"            WHERE FLOWER_GUBN = '1'\n"
					+"            and CMP_CD = '0000000001'\n"
					+"            and REPLACE(SALE_DATE, '-', '') BETWEEN :searchStrDate AND :searchEndDate\n"
					+"            and to_char(to_date(REPLACE(SALE_DATE,'-',''), 'yyyymmdd'), 'd') in ('2','4','6')\n"
					+"            and (:default :PUM_NAME :GOOD_NAME)\n"
					+"			GROUP BY SALE_DATE, DECODE(PUM_NAME,'팔레높시스','호접란',PUM_NAME)\n"
					+"            ) C\n"
					+"		WHERE A.SALE_DATE = B.SALE_DATE\n"
					+"		  AND A.PUM_NAME = B.PUM_NAME\n"
					+"          AND A.SALE_DATE = C.SALE_DATE\n"
					+"          AND A.PUM_NAME = C.PUM_NAME\n"
					+"		ORDER BY PUM_NAME, YEAR, MONTH, DAY\n";
			
			Map<String, String> param = new HashMap<>();

			// 쿼리 커스텀
			// 1. 날짜 바인딩
			query = query.replaceAll(":searchStrDate", pRequestParamMap.get("searchStrDate").toString());
			query = query.replaceAll(":searchEndDate", pRequestParamMap.get("searchEndDate").toString());

			
			// 2. 변수 바인딩
			for (Map.Entry<String, String> entry : param.entrySet()){
				query = query.replaceAll(entry.getKey(), "'"+entry.getValue()+"'");
			}
			
			// 3. 선택된 품목, 품종만 조회하는 구문 적용
			// 3.1. 모든 품종을 조회하는 품목 구문 적용
			List<String> pumArr = new ArrayList<>();
			for(Map<String, Object> e : list2){
				if(e.get("CMP_GOOD") == null || e.get("CMP_GOOD").toString().equals("null") || e.get("CMP_GOOD").toString().equals("")){
					pumArr.add(e.get("PUM_NAME").toString());
				}
			}
			if (pumArr.size() != 0){
				query = query.replaceAll(":PUM_NAME", String.format(" OR (PUM_NAME IN (%S))", "'"+  StringUtils.join("', '", pumArr) +"'"));
				query = query.replaceAll(":MOK_NAME", String.format(" OR (MOK_NAME IN (%S))", "'"+ StringUtils.join("', '", pumArr) +"'"));
				query = query.replaceAll(":default", "1!=1");
			}
			else{
				query = query.replaceAll(":PUM_NAME", "");
				query = query.replaceAll(":MOK_NAME", "");
			}
			
			// 3.2. 특정 품종을 조회하는 품목과 품종번호 구문 적용
			Map<String, String> pumjongMap = new HashMap<>();
			for(Map<String, Object> e : list2){
				if(e.get("CMP_GOOD") != null && e.get("CMP_GOOD").toString().equals("null") == false && e.get("CMP_GOOD").toString().equals("") == false){
					pumjongMap.put(e.get("PUM_NAME").toString(), "'"+e.get("CMP_GOOD").toString().replaceAll(",", "','")+"'");
				}
			}
//			pumjongMap.put("거베라", "'10510000'");
//			pumjongMap.put("국화", "'10011640','10010327','10010616'");
			if (pumjongMap.keySet().size() == 0){
				query = query.replaceAll(":GOOD_NAME", "");
			}
			else{
				String pumjongMap1 = "";
				String pumjongMap2 = "";
				for (Map.Entry<String, String> entry : pumjongMap.entrySet()){
					pumjongMap1 += String.format(" OR (PUM_NAME = '%S' AND CMP_GOOD IN (%S))", entry.getKey(), entry.getValue());
					pumjongMap2 += String.format(" OR (MOK_NAME = '%S' AND PUM_CODE IN (%S))", entry.getKey(), entry.getValue());
				}
				query = query.replaceAll(":CMP_GOOD", pumjongMap1);
				query = query.replaceAll(":PUM_CODE", pumjongMap2);
				query = query.replaceAll(":default", "1!=1");
			}
			query = query.replaceAll(":default", "1=1");
			
			
			// 3.3. 특정 품종을 조회하는 품목과 품종명 구문 적용
			pumjongMap = new HashMap<>();
			for(Map<String, Object> e : list2){
				if(e.get("GOOD_NAME") != null && e.get("GOOD_NAME").toString().equals("null") == false && e.get("GOOD_NAME").toString().equals("") == false){
					pumjongMap.put(e.get("PUM_NAME").toString(), "'"+e.get("GOOD_NAME").toString().replaceAll(",", "','")+"'");
				}
			}
			if (pumjongMap.keySet().size() == 0){
				query = query.replaceAll(":GOOD_NAME", "");
			}
			else{
				String pumjongMap1 = "";
				for (Map.Entry<String, String> entry : pumjongMap.entrySet()){
					pumjongMap1 += String.format(" OR (PUM_NAME = '%S' AND GOOD_NAME IN (%S))", entry.getKey(), entry.getValue());
				}
				query = query.replaceAll(":GOOD_NAME", pumjongMap1);
			}
			
			System.out.println(query);
			ResultSet rs = stmt.executeQuery(query);
			List<String> columNm = Arrays.asList("YEAR", "MONTH", "DAY", "PUM_NAME", "TOT_CNT", "PAN_CNT", "YUCHAL_CNT", "TOT_AMT", "AVG_AMT");
			List<String> resultColumNm = Arrays.asList("year", "month", "day", "pumName", "totCnt", "panCnt", "yuchalCnt", "totAmt", "avgAmt");
			
			while(rs.next()){
				EgovMap e = new EgovMap();
				for(int i=0; i<columNm.size(); i++){
					String colum = columNm.get(i);
					e.put(resultColumNm.get(i), rs.getString(colum));
					System.out.print(rs.getString(colum));
					System.out.print("	");
				}
				result.add(e);
				System.out.println();
			}
			rs.close();
			stmt.close();
			con.close();
			
		}catch (Exception e){
			e.printStackTrace();
		}
		
		return result;
	}
}
