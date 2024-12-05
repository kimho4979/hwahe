package com.fpdisys.dist.excel.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import com.fpdisys.dist.excel.domain.ExcelRealVO;

public class ExcelView extends AbstractExcelView{
	protected void buildExcelDocument(Map<String,Object> model , Workbook workbook , HttpServletRequest request , HttpServletResponse response) throws Exception{
		 
		String type = model.get("excelType").toString();
		 
			if(type.equals("board")){
			 
			List<ExcelRealVO> excelList = (List<ExcelRealVO>)model.get("excelList");
			Sheet sheet = workbook.createSheet(type);
			Row row = null;
			int rowCount = 0;
			int cellCount = 0;
			 
			row = sheet.createRow(rowCount++);
 
			row.createCell(cellCount++).setCellValue("품목");
			row.createCell(cellCount++).setCellValue("품종");
			row.createCell(cellCount++).setCellValue("등급");
			row.createCell(cellCount++).setCellValue("속수량");
			row.createCell(cellCount++).setCellValue("낙찰금액");
			row.createCell(cellCount++).setCellValue("낙찰시간");
			row.createCell(cellCount++).setCellValue("지역");
			
			for(ExcelRealVO vo : excelList){
				row = sheet.createRow(rowCount++);
				cellCount = 0;
				row.createCell(cellCount++).setCellValue("1");
				row.createCell(cellCount++).setCellValue("1");
				row.createCell(cellCount++).setCellValue("1");
				row.createCell(cellCount++).setCellValue("1");
				row.createCell(cellCount++).setCellValue("1");
				row.createCell(cellCount++).setCellValue("1");
				row.createCell(cellCount++).setCellValue("1");
			}
		}
	}
	protected Workbook createWorkbook(){
		return new HSSFWorkbook();
	}
	@Override
	protected void buildExcelDocument(Map<String, Object> model, HSSFWorkbook workbook
			, HttpServletRequest request, HttpServletResponse response) throws Exception {
	}
}
