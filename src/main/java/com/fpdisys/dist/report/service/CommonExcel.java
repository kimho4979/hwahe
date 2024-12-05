package com.fpdisys.dist.report.service;

import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.stereotype.Service;

@Service
public class CommonExcel {

	private void encodeUtf8(HttpServletResponse response, String fileName) throws IOException {
		response.setHeader("Content-Disposition", "attachment;filename="+URLEncoder.encode(fileName + ".xls", "UTF-8").replaceAll("\\+", "%20"));
	}
	
	public void download(HttpServletResponse response, HSSFWorkbook workbook, String fileName) {
		
		try {
			
			encodeUtf8(response, fileName);
			
			ServletOutputStream outStream = response.getOutputStream();
			workbook.write(outStream);
	        outStream.flush();
	        
		} catch (IOException e) {
			throw new RuntimeException(e.getMessage());
		}
	}
	
	public HSSFWorkbook createWorkbook() {
		
		return new HSSFWorkbook();
	}
	
	public HSSFWorkbook getWorkbook(String fileFullPath) {
	
		try {
			return new HSSFWorkbook(new FileInputStream(fileFullPath));
		} catch (Exception e) {
			throw new RuntimeException(e.getMessage());
		}
	}
	
	public HSSFSheet createSheet(HSSFWorkbook workbook, String title) {
		return workbook.createSheet(title);
	}
	
	public void autoSizeSheet(HSSFSheet sheet) {
		
		int maxColumnIndex = 0;

		for (int r = 0; r <= sheet.getLastRowNum(); r++) {
			
			HSSFRow row = sheet.getRow(r);
			
			if(row != null) {
				
				// 현 시트에 가장 큰 Cell Number 까지 오토사이징.
				if(row.getLastCellNum() > maxColumnIndex) {
					
					for (int m = maxColumnIndex; m < row.getLastCellNum(); m++) {
						sheet.autoSizeColumn((short)m);
						sheet.setColumnWidth(m, (sheet.getColumnWidth(m)) + 1000);
					}
					
					maxColumnIndex = row.getLastCellNum();
				}
			}
		}
	}
	
}
