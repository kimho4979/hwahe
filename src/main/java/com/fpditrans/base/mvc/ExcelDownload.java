package com.fpditrans.base.mvc;

import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.*;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @Class Name : ExcelDownload.java
 * @Description : ExcelDownload Class
 * @Modification Information
 * @
 * @  수정일	  수정자			  수정내용
 * @ ---------	---------	-------------------------------
 * @ 2016.08.16			최초생성
 *
 * @author 우림인포텍
 * @since 2016. 03.16
 * @version 1.0
 * @see
 *
 *  Copyright (C) by WOORIM All right reserved.
 */

@Service
public class ExcelDownload {
	public void excelDownload(String[][] list, String[] columnTitle, String fileName, HttpServletResponse response) throws IOException {


		try {
			String filenameStr = null;
			HSSFRow row = null;
			HSSFCell cell = null;
			HSSFWorkbook wb = new HSSFWorkbook();
			HSSFSheet sheet = wb.createSheet();
			// 첫번째 sheet 에 키워드 정보라고 노출 
			wb.setSheetName(0, "sheet");
/*
			// column 너비지정(너비지정 필요시 주석제거 할 것 )
			//String[] columnWidth = {"700", "700", "700", "700"};  주석필요시 service단에 추가하고 excelDownload 메소드 호출시 columnWidth 파라미터 추가

			for(int i=0; i<columnWidth.length; i++){
				sheet.setColumnWidth(i, sheet.getDefaultColumnWidth() * Integer.parseInt(columnWidth[i]));
			}
*/
			// 가운데정렬
			HSSFCellStyle contentCellStyle = wb.createCellStyle();
			contentCellStyle.setAlignment((short) 2);



			//타이들 input
			row = sheet.createRow(0);
			for (int j=0; j<columnTitle.length; j++) {
				cell = row.createCell(j);
				cell.setCellValue(columnTitle[j]);
				cell.setCellStyle(contentCellStyle);
			}

			//리스트 input
			for (int k=1; k<list.length+1; k++) {
				row = sheet.createRow(k);
				for (int l=0; l<columnTitle.length; l++) {
					cell = row.createCell(l);
					cell.setCellValue(list[k-1][l]);
					cell.setCellStyle(contentCellStyle);
				}

			}

			try {
				response.setContentType("application/vnd.ms-excel;charset=utf-8");
				filenameStr = fileName + ".xls";
				//euc 였는데 UTF로 변경했음.
				response.setHeader("Content-Disposition", "attachment;filename=" + new String(filenameStr.getBytes("UTF-8"), "8859_1"));
				wb.write(response.getOutputStream());
			} catch (Exception ex) {
				String name = ex.getClass().getName();

				if (!name.equals("org.apache.catalina.connector.ClientAbortException")) {
					throw ex;
				}
			}

		} catch (Exception ex) {
			throw new RuntimeException(ex.getMessage());
		}
	}

	public String[][] excelRead(HttpServletRequest request, String filePath, String fileName, int cellNum, int startRow, int endRow) throws IOException {

		FileInputStream fileInputStream = new FileInputStream(filePath + "/" + fileName);


		String[] split = fileName.split("\\.");

		String extention = split[split.length - 1];

		if (extention.equals("xls")) {

			HSSFWorkbook workbook = new HSSFWorkbook(fileInputStream);

			int rowIndex = 0;
			int columnIndex = 0;

			//무조건 시트는 0 더필요할시 for문을 돌린다.
			HSSFSheet sheet = workbook.getSheetAt(0);

			int rows = sheet.getPhysicalNumberOfRows();
			String[][] retValue = new String[endRow-startRow][cellNum];

			int arrayIndex = 0; // retValue[?] 에 넣기 위해 0부터 시작을 위해

			for (rowIndex = startRow; rowIndex < endRow; rowIndex++) {
				HSSFRow row = sheet.getRow(rowIndex);


				if (row != null) {

					int cells = row.getPhysicalNumberOfCells();

					for (columnIndex = 0; columnIndex < cells; columnIndex++) {
						HSSFCell cell = row.getCell(columnIndex);
						String value = "";

						if (cell == null) {
							value = "";
						} else {
							switch (cell.getCellType()) {
								case 2:  //HSSFCell.CELL_TYPE_FORMULA
									value = cell.getCellFormula();
									break;
								case 0: //HSSFCell.CELL_TYPE_NUMERIC
									value = (Long.toString((long) cell.getNumericCellValue()));
									break;
								case 1: //HSSFCell.CELL_TYPE_STRING
									value = cell.getStringCellValue() + "";
									break;
								case 3: //HSSFCell.CELL_TYPE_BLANK
									value = cell.getBooleanCellValue() + "";
									break;
								case 5: //HSSFCell.CELL_TYPE_ERROR
									value = cell.getErrorCellValue() + "";
									break;
							}
						}

						retValue[arrayIndex][columnIndex] = value;
					}

					arrayIndex++;

				}
			}

			return retValue;

		} else if (extention.equals("xlsx")) {
			XSSFWorkbook workbook = new XSSFWorkbook(fileInputStream);

			int rowIndex = 0;
			int columnIndex = 0;

			XSSFSheet sheet = workbook.getSheetAt(0);
			int rows = sheet.getPhysicalNumberOfRows();

			String[][] retValue = new String[endRow-startRow][cellNum];

			int arrayIndex = 0; // retValue[?] 에 넣기 위해 0부터 시작을 위해

			for (rowIndex = startRow; rowIndex < endRow; rowIndex++) {
				XSSFRow row = sheet.getRow(rowIndex);

				if (row != null) {
					int cells = row.getPhysicalNumberOfCells();

					for (columnIndex = 0; columnIndex < cells; columnIndex++) {
						XSSFCell cell = row.getCell(columnIndex);
						String value = "";

						if (cell == null) {
							value = "";
						} else {
							switch (cell.getCellType()) {
								case 2:  //HSSFCell.CELL_TYPE_FORMULA
									value = cell.getCellFormula();
									break;
								case 0: //HSSFCell.CELL_TYPE_NUMERIC
									value = (Long.toString((long) cell.getNumericCellValue()));
									break;
								case 1: //HSSFCell.CELL_TYPE_STRING
									value = cell.getStringCellValue() + "";
									break;
								case 3: //HSSFCell.CELL_TYPE_BLANK
									value = cell.getBooleanCellValue() + "";
									break;
								case 5: //HSSFCell.CELL_TYPE_ERROR
									value = cell.getErrorCellValue() + "";
									break;
							}
						}

						retValue[arrayIndex][columnIndex] = value;
					}

					arrayIndex++;
				}
			}

			return retValue;

		}

		return null;

	}

	public String getCurrentTimes() {
		String currentTime = "";

		Date currentDate = new Date(System.currentTimeMillis());
		SimpleDateFormat sdfFileName = new SimpleDateFormat("yyyyMMddHHmmss", Locale.getDefault());
		currentTime = "_" + sdfFileName.format(currentDate);

		return currentTime;
	}
}

